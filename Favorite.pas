unit Favorite;

interface

uses
	Messages, SysUtils, Classes, Contnrs, ComCtrls, {HttpApp,} YofUtils,
	GikoSystem{, XMLIntf, XMLDoc}, GikoXMLDoc, BoardGroup, windows,
  TntComCtrls, WideCtrls;
	{SAX, SAXHelpers, SAXComps, SAXKW;}

type
	TFavoriteFolder = class
	end;

	TFavoriteItem = class(TObject)
	private
		FURL				: string;
		FTitle			: string;
	public
		function GetItemTitle : string; virtual;abstract;
		property URL				: string	read FURL write FURL;	// Item が取得できなくても URL は常に保持される
		property Title			: string	read FTitle write FTitle;
	end;
	TFavoriteBoardItem = class(TFavoriteItem)
	private
		FItem				: TBoard;
		function	GetItem : TBoard;
	public
		constructor Create( inURL : string; inTitle : string = ''; inItem : TBoard = nil );
		constructor CreateWithItem( inItem : TBoard );
		destructor Destory;
		function GetItemTitle : string; override;
		property Item				: TBoard	read GetItem write FItem;
	end;

	TFavoriteThreadItem = class(TFavoriteItem)
	private
		FItem				: TThreadItem;
		function	GetItem : TThreadItem;
	public
		constructor Create( inURL : string; inTitle : string = ''; inItem : TThreadItem = nil );
		constructor CreateWithItem( inItem : TThreadItem );
		destructor Destory;
		function GetItemTitle : string; override;
		property Item				: TThreadItem	read GetItem write FItem;
	end;

	TFavoriteDM = class(TDataModule)
	private
		{ Private 宣言 }
		FAbEnd: Boolean;
		FTreeView: TTntTreeView;
		FModified: boolean;
		procedure ReadNode(Node: IXMLNode; Stack: TStack; TreeView: TTntTreeView);
		procedure AddSaveString(Node: TTntTreeNode; SaveList: TStringList);
	public
		{ Public 宣言 }
		procedure Clear;
		function GetFavoriteFilePath() : String;
		function SaveFavoriteFile(FileName: String) : Boolean;
		procedure SetFavTreeView(TreeView: TTntTreeView);
		procedure ReadFavorite;
		procedure WriteFavorite;
		procedure URLReplace(oldURLs: TStringList; newURLs: TStringList);
		property TreeView: TTntTreeView read FTreeView;
		property Modified: boolean read FModified write FModified;
		property AbEnd: Boolean read FAbEnd write FAbEnd;
	end;

var
	FavoriteDM: TFavoriteDM;
const
	FAVORITE_LINK_NAME = 'リンク';
	FAVORITE_FILE_NAME = 'Favorite.xml';

implementation

uses	ExternalBoardManager, ExternalBoardPlugInMain,  MojuUtils;

const
	FAVORITE_ROOT_NAME = 'お気に入り';


{$R *.dfm}

constructor TFavoriteBoardItem.Create(
	inURL		: string;
	inTitle	: string = '';
	inItem	: TBoard = nil
);
begin

	inherited Create;

	URL		:= inURL;
	Title	:= inTitle;
	Item	:= inItem;

end;

constructor TFavoriteBoardItem.CreateWithItem(
	inItem	: TBoard
);
begin

	Create( inItem.URL, inItem.Title, inItem );

end;
destructor TFavoriteBoardItem.Destory;
begin
	if FItem <> nil then
		FItem.Free;
	inherited;
end;
//! 保持している板のタイトルを返す
function TFavoriteBoardItem.GetItemTitle : string;
begin
	Result := '';
	//一度も板を開いていないとき（起動時にキャビネットをお気に入りとか）
	//のときにFItemがnilなのでそのときはべっと検索
	if FItem = nil then begin
		FItem := BBSsFindBoardFromURL(URL);
	end;
	if FItem <> nil then begin
		try
			if not FItem.IsThreadDatRead then begin
				GikoSys.ReadSubjectFile(FItem);
			end;
		except
		end;
		Result := FItem.Title;
	end;
end;
function	TFavoriteBoardItem.GetItem : TBoard;
var
	protocol, host, path, document, port, bookmark : string;
	BBSID	: string;
	tmpURL	: string;
begin

	if FItem = nil then begin
		FItem := BBSsFindBoardFromURL( URL );
		if FItem = nil then begin
			tmpURL := URL;
			GikoSys.ParseURI( tmpURL, protocol, host, path, document, port, bookmark );
			if GikoSys.Is2chHost( host ) then begin
				BBSID := GikoSys.URLToID( tmpURL );
				FItem := BBSs[ 0 ].FindBBSID( BBSID );
				if FItem <> nil then
					URL := FItem.URL;
			end;
			{
			// ※作っても、追加するカテゴリが無いので激しく保留
			FItem				:= GikoSys.GetUnknownBoard( nil, URL );
			FItem.Title	:= Title;
			}
		end;
	end;

	Result := FItem;

end;

constructor TFavoriteThreadItem.Create(
	inURL		: string;
	inTitle	: string = '';
	inItem	: TThreadItem = nil
);
begin

	inherited Create;
	URL		:= inURL;

	Title	:= inTitle;
	Item	:= inItem;

end;

constructor TFavoriteThreadItem.CreateWithItem(
	inItem	: TThreadItem
);
begin

	Create( inItem.URL, inItem.Title, inItem );

end;
destructor TFavoriteThreadItem.Destory;
begin
	if FItem <> nil then
    	FItem.Free;
    inherited;
end;
//! 保持しているスレのタイトルを返す
function TFavoriteThreadItem.GetItemTitle : string;
begin
	Result := '';
	if FItem = nil then begin
		FItem := BBSsFindThreadFromURL(URL);
	end;
	if FItem <> nil then begin
		Result := FItem.Title;
	end;
end;

function	TFavoriteThreadItem.GetItem : TThreadItem;
var
	board					: TBoard;
	boardURL			: string;
	browsableURL	: string;
	protocol, host, path, document, port, bookmark : string;
	BBSID, BBSKey	: string;
	tmpURL				: string;
begin

	Result := nil;
	if FItem = nil then begin
		browsableURL	:= GikoSys.GetBrowsableThreadURL( URL );
		boardURL			:= GikoSys.GetThreadURL2BoardURL( browsableURL );
		board					:= BBSsFindBoardFromURL( boardURL );

		if board = nil then begin
			tmpURL := URL;
			GikoSys.ParseURI( tmpURL, protocol, host, path, document, port, bookmark );
			if GikoSys.Is2chHost( host ) then begin
				GikoSys.Parse2chURL( tmpURL, path, document, BBSID, BBSKey );
				board := BBSs[ 0 ].FindBBSID( BBSID );
			end;

			if board = nil then begin
				Exit;
				// ※作っても、追加するカテゴリが無いので激しく保留
				//board := GikoSys.GetUnknownBoard( nil, boardURL )
			end;
		end;

		FItem := board.FindThreadFromURL( browsableURL );

		if FItem = nil then begin
			tmpURL := URL;
			GikoSys.ParseURI( tmpURL, protocol, host, path, document, port, bookmark );
			if GikoSys.Is2chHost( host ) then begin
				GikoSys.Parse2chURL( tmpURL, path, document, BBSID, BBSKey );
				FItem := BBSs[ 0 ].FindThreadItem( BBSID, BBSKey + '.dat' );
				if FItem <> nil then
					URL := FItem.URL;
			end;
		end;

		if FItem = nil then begin
			FItem := TThreadItem.Create( board.BoardPlugIn, board, browsableURL );

			FItem.Title := Title;
			board.Add( FItem );
		end;
	end;

 	Result := FItem;

end;

procedure TFavoriteDM.Clear;
var
	Node	: TTntTreeNode;
begin
	TreeView.Items.BeginUpdate;
	Node	:= TreeView.Items.GetFirstNode;
	while Node <> nil do begin
		if TObject(Node.Data) <> nil then
				TObject(Node.Data).Free;
		Node := Node.GetNext;
	end;
		TreeView.Items.Clear;
		TreeView.Items.EndUpdate;

    FavoriteDM.Modified := true;
end;

procedure TFavoriteDM.SetFavTreeView(TreeView: TTntTreeView);
begin
	FTreeView := TreeView;
end;

procedure TFavoriteDM.ReadFavorite;
var
	FileName: string;
	XMLDoc: IXMLDocument;
	XMLNode: IXMLNode;
	Node: TTntTreeNode;
	i: Integer;
	FavFolder: TFavoriteFolder;
	LinkExists: Boolean;
	Stack: TStack;
begin
	FABend := False;

	FavoriteDM.Modified := true;
	FileName := GikoSys.GetConfigDir + FAVORITE_FILE_NAME;

	FavFolder := TFavoriteFolder.Create;
	Node := FTreeView.Items.AddChildObjectFirst(nil, FAVORITE_ROOT_NAME, FavFolder);
	Node.ImageIndex := 14;
	Node.SelectedIndex := 14;

	if FileExists(FileName) then begin
		try
			XMLDoc := IXMLDocument.Create;
			//XMLDoc := LoadXMLDocument(FileName);
			LoadXMLDocument(FileName, XMLDoc);
			XMLNode := XMLDoc.DocumentElement;

			Stack := TStack.Create;
			try
				Stack.Push(Node);
				LinkExists := False;
				if XMLNode.NodeName = 'favorite' then begin
					for i := XMLNode.ChildNodes.Count - 1 downto 0 do begin
						ReadNode(XMLNode.ChildNodes[i], Stack, FTreeView);
						if (XMLNode.ChildNodes[i].NodeName = 'folder') and
							 (XMLNode.ChildNodes[i].Attributes['title'] = FAVORITE_LINK_NAME) then begin
							LinkExists := True;
						end;
					end;
				end;
				if not LinkExists then begin
					FavFolder := TFavoriteFolder.Create;
					Node := FTreeView.Items.AddChildObjectFirst(Node, FAVORITE_LINK_NAME, FavFolder);
					Node.ImageIndex := 14;
					Node.SelectedIndex := 14;
				end;

			finally
				Stack.Free;
				XMLDoc.Free;
			end;
		except
			on e : Exception do begin
				FABend := True;
			end;
		end;
	end;

end;

procedure TFavoriteDM.ReadNode(Node: IXMLNode; Stack: TStack; TreeView: TTntTreeView);
var
	i: Integer;

	ParentNode: TTntTreeNode;
	CurrentNode: TTntTreeNode;
	FavFolder: TFavoriteFolder;
	FavBoard: TFavoriteBoardItem;
	FavThread: TFavoriteThreadItem;
	board				: TBoard;
	threadItem	: TThreadItem;
  title: String;
begin
	if Node.NodeName = 'folder' then begin
		CurrentNode := nil;
		ParentNode := Stack.Peek;
		if TObject(ParentNode.Data) is TFavoriteFolder then begin
			FavFolder := TFavoriteFolder.Create;
			CurrentNode := TreeView.Items.AddChildObjectFirst(ParentNode, Node.Attributes['title'], FavFolder);
			CurrentNode.ImageIndex := 14;
			CurrentNode.SelectedIndex := 14;
			Stack.Push(CurrentNode);
		end;
		for i := Node.ChildNodes.Count - 1 downto 0 do begin
			ReadNode(Node.ChildNodes[i], Stack, TreeView);
		end;
		if CurrentNode <> nil then
			CurrentNode.Expanded := Node.Attributes[ 'expanded' ] = 'true';
		if Stack.Count <> 0 then
			Stack.Pop;
	end else if Node.NodeName = 'favitem' then begin
		try
			ParentNode := Stack.Peek;
			if TObject(ParentNode.Data) is TFavoriteFolder then begin
				if Node.Attributes['favtype'] = 'board' then begin
					FavBoard := nil;
					// 旧式のお気に入りとの互換性のため
					if Length( Node.Attributes[ 'bbs' ] ) > 0 then begin
						board := BBSsFindBoardFromBBSID( Node.Attributes[ 'bbs' ] );
						if board <> nil then
							FavBoard := TFavoriteBoardItem.Create(
								board.URL, MojuUtils.UnSanitize(Node.Attributes[ 'title' ]), board );
					end else begin
						FavBoard := TFavoriteBoardItem.Create(
							Node.Attributes[ 'url' ], MojuUtils.UnSanitize(Node.Attributes[ 'title' ]), nil );
					end;
					CurrentNode := TreeView.Items.AddChildObjectFirst(ParentNode, UnSanitize(Node.Attributes['title']), FavBoard);
					CurrentNode.ImageIndex := 15;
					CurrentNode.SelectedIndex := 15;
				end else if Node.Attributes['favtype'] = 'thread' then begin
					// 旧式のお気に入りとの互換性のため
					if Length( Node.Attributes[ 'bbs' ] ) > 0 then begin
						board := BBSsFindBoardFromBBSID( Node.Attributes[ 'bbs' ] );
						if board = nil then
							Exit;

						if not board.IsThreadDatRead then
							GikoSys.ReadSubjectFile( board );
						threadItem := board.FindThreadFromFileName( Node.Attributes[ 'thread' ] );
						if threadItem = nil then begin
							threadItem := TThreadItem.Create(
								board.BoardPlugIn,
                                board,
								GikoSys.Get2chBoard2ThreadURL( board, ChangeFileExt( Node.Attributes[ 'thread' ], '' ) ) );
							threadItem.Title := UnSanitize(Node.Attributes[ 'title' ]);
							board.Add( threadItem );
						end;
						FavThread := TFavoriteThreadItem.Create(
							threadItem.URL, UnSanitize(Node.Attributes[ 'title' ]), threadItem );
                        threadItem.Free;
					end else begin
						FavThread := TFavoriteThreadItem.Create(
							Node.Attributes[ 'url' ], UnSanitize(Node.Attributes[ 'title' ]), nil );
					end;
          title := UnSanitize(Node.Attributes['title']);
					CurrentNode := TreeView.Items.AddChildObjectFirst(ParentNode, EncAnsiToWideString(title), FavThread);
					CurrentNode.ImageIndex := 16;
					CurrentNode.SelectedIndex := 16;
				end;
			end;
		except
			// このアイテムで問題が起きても他のアイテムに影響を与えたくないので
		end;
	end;
end;

procedure TFavoriteDM.WriteFavorite;
var
  FileName, tmpFileName, bakFileName: string;
  SaveList: TStringList;
  Buffer: array[0..MAX_PATH] of Char;   // バッファ
  FileRep : Boolean;
begin
	FavoriteDM.Modified := true;
	FileName := GikoSys.GetConfigDir + FAVORITE_FILE_NAME;
	SaveList := TStringList.Create;
	tmpFileName := '';
  // 書き込み用一時ファイル取得
  if GetTempFileName(PChar(GikoSys.GetConfigDir), PChar('fav'), 0, Buffer) <> 0 then begin
    tmpFileName := Buffer;
    try
      try
        SaveList.Add('<?xml version="1.0" encoding="Shift_JIS" standalone="yes"?>');
        SaveList.Add('<favorite>');
        AddSaveString(TreeView.Items.GetFirstNode.getFirstChild, SaveList);
        SaveList.Add('</favorite>');
        // 一時ファイルとして保存
        SaveList.SaveToFile(tmpFileName);
        FileRep := True;
        // 前のファイルを移動する
        if FileExists(FileName) then begin
          bakFileName := GikoSys.GetConfigDir + '~' + FAVORITE_FILE_NAME;
          if FileExists(bakFileName) then begin
	          FileRep := SysUtils.DeleteFile(bakFileName); //SysUtils.をつけないとWinAPIと区別できないので
          end;
          if FileRep then begin
	          FileRep := RenameFile(FileName, bakFileName);
          end;
				end;
        // 正規のファイル名にリネームする
        if FileRep then begin
	      	FileRep := RenameFile(tmpFileName, FileName);
				end;
      except
      end;
    finally
			SaveList.Free;
    end;
  end;
end;

procedure TFavoriteDM.AddSaveString(Node: TTntTreeNode; SaveList: TStringList);
var
	s: string;
	FavBoard: TFavoriteBoardItem;
	FavThread: TFavoriteThreadItem;
	data : Pointer;
  title: String;
begin
	while Node <> nil do begin
		data := Node.Data;
		if TObject(data) is TFavoriteFolder then begin
			if Node.Expanded then
				s := Format('<folder title="%s" expanded="true">', [HtmlEncode(Node.Text)])
			else
				s := Format('<folder title="%s" expanded="false">', [HtmlEncode(Node.Text)]);
			SaveList.Add(s);
			AddSaveString(Node.getFirstChild, SaveList);
			SaveList.Add('</folder>');
		end else if TObject(data) is TFavoriteBoardItem then begin
			FavBoard := TFavoriteBoardItem(data);
			s := Format('<favitem type="2ch" favtype="board" url="%s" title="%s"/>',
									[HtmlEncode( FavBoard.URL ), HtmlEncode(MojuUtils.Sanitize(Node.Text))]);
			SaveList.Add(s);
		end else if TObject(data) is TFavoriteThreadItem then begin
    	title := WideToEncAnsiString(Node.Text);
			FavThread := TFavoriteThreadItem(data);
			s := Format('<favitem type="2ch" favtype="thread" url="%s" title="%s"/>',
									[HtmlEncode( FavThread.URL ), HtmlEncode(MojuUtils.Sanitize(title))]);
			SaveList.Add(s);
		end;
		Node := Node.getNextSibling;
	end;
end;

function TFavoriteDM.SaveFavoriteFile(FileName: String) : Boolean;
var
	FavoriteFilePath: string;
	tempStringList: TStringList;
begin
	WriteFavorite;
	FavoriteFilePath := GikoSys.GetConfigDir + FAVORITE_FILE_NAME;

	if FileExists( FavoriteFilePath ) then begin
		tempStringList := TStringList.Create;
		try
			tempStringList.LoadFromFile( FavoriteFilePath );
			tempStringList.SaveToFile( FileName );
		finally
			tempStringList.Free;
		end;
		Result := true;
	end else begin
		Result := false;
	end;
end;

procedure TFavoriteDM.URLReplace(oldURLs: TStringList; newURLs: TStringList);
var
	i					: Integer;
  tmpURL: string;
  oldHost: string;
  oldBoardName: string;
  newHost: string;
  newBoardName: string;
  tempString: string;
	favBoard	: TFavoriteBoardItem;
	favThread	: TFavoriteThreadItem;
	favorites	: TTntTreeNodes;
	Node			: TTntTreeNode;
begin

	// 面倒だけどthreadはそれぞれURLをチェックしながらやってかなきゃいけない。
	favorites := FavoriteDM.FTreeView.Items;
	for i := 0 to oldURLs.Count - 1 do begin
		try
			tmpURL 			:= Copy(oldURLs[i], 1, Length(oldURLs[i]) -1);
			oldHost			:= Copy(tmpURL, 1, LastDelimiter('/', tmpURL) );
			oldBoardName    := Copy(tmpURL, LastDelimiter('/', tmpURL), Length(tmpURL) ) + '/';
			tmpURL 			:= Copy(newURLs[i], 1, Length(newURLs[i]) -1);
			newHost			:= Copy(tmpURL, 1, LastDelimiter('/', tmpURL) );
			newBoardName    := Copy(tmpURL, LastDelimiter('/', tmpURL), Length(tmpURL) ) + '/';

			Node := favorites.GetFirstNode.getFirstChild;
			while Node <> nil do begin
				try
					if TObject( Node.Data ) is TFavoriteBoardItem then begin
						favBoard := TFavoriteBoardItem( Node.Data );
						if favBoard = nil then continue;
						tempString := favBoard.URL;
						if ( AnsiPos(oldBoardName, tempString) <> 0 ) and ( AnsiPos(oldHost, tempString ) <> 0 ) then begin
							tempString		:= StringReplace(tempString, oldHost, newHost,[]);
							favBoard.URL	:= tempString;
						end;
					end else if TObject( Node.Data ) is TFavoriteThreadItem then begin
						favThread := TFavoriteThreadItem( Node.Data );
						if favThread = nil then continue;
						tempString := favThread.URL;
						if ( AnsiPos(oldBoardName, tempString) <> 0 ) and ( AnsiPos(oldHost, tempString ) <> 0 ) then begin
							tempString		:= StringReplace(tempString, oldHost, newHost,[]);
							favThread.URL	:= tempString;
						end;
					end;
				except
				end;
				Node := Node.GetNext;
			end;
		except
		end;
	end;

end;

function TFavoriteDM.GetFavoriteFilePath() : String;
begin
	Result := GikoSys.GetConfigDir + FAVORITE_FILE_NAME;
end;

end.
