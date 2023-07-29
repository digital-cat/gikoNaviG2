unit RoundData;

interface

uses
	Windows, Messages, SysUtils, Classes,
	GikoSystem, BoardGroup;

type
	TGikoRoundType = (grtBoard, grtItem);
	TRoundItem = class;

	TRoundList = class(TObject)
	private
        FOldFileRead: Boolean;
		FBoardList: TList;
		FItemList: TList;
		function GetCount(RoundType: TGikoRoundType): Integer;
		function GetRoundItem(Index: Integer; RoundType: TGikoRoundType): TRoundItem;
		function ParseRoundBoardLine(Line: string):		Boolean;
		function ParseRoundThreadLine(Line: string):	Boolean;
		function ParseOldRoundBoardLine(Line: string):	Boolean;
		function ParseOldRoundThreadLine(Line: string): Boolean;
	public
		RoundNameList: TStringList;

		constructor Create;
		destructor Destroy; override;
		function Add(Board: TBoard): Integer; overload;
		function Add(ThreadItem: TThreadItem): Integer; overload;
		procedure Delete(Board: TBoard); overload;
		procedure Delete(ThreadItem: TThreadItem); overload;
        procedure Delete(URL: string; RoundType: TGikoRoundType); overload;
		procedure Clear;
		function Find(Board: TBoard): Integer; overload;
		function Find(ThreadItem: TThreadItem): Integer; overload;
        function Find(URL: string; RoundType: TGikoRoundType): Integer; overload;
		property Count[RoundType: TGikoRoundType]: Integer read GetCount;
        property OldFileRead: Boolean read FOldFileRead;
		property Items[Index: integer; RoundType: TGikoRoundType]: TRoundItem read GetRoundItem;
		procedure LoadRoundBoardFile;
        procedure LoadRoundThreadFile;
		procedure SaveRoundFile;

        procedure URLReplace(oldURLs: TStringList; newURLs :TStringList);
	end;

	TRoundItem = class(TObject)
	private
		FItem		: TObject;
		FRoundType: TGikoRoundType;
		FTmpURL	: string;
		FBoolData: Boolean;		//いろいろ使うょぅ
		function GetBoardTitle : string;
		function GetThreadTitle : string;
		function GetURL	: string;
		function GetFileName : string;
        //! 巡回名取得
        function GetRoundName : string;
	public
		constructor Create;
		property Item : TObject read FItem;
		property RoundName: string read GetRoundName;
		property RoundType: TGikoRoundType read FRoundType write FRoundType;
		property URL : string read GetURL;
		property TmpURL : string read FTmpURL write FTmpURL;
		property BoardTitle: string read GetBoardTitle;
		property ThreadTitle: string read GetThreadTitle;
		property FileName: string read GEtFileName;
		property BoolData: Boolean read FBoolData write FBoolData;
	end;

var
	RoundList: TRoundList;

implementation
const
	ROUND_BOARD_FILENAME: string = 'RoundBoard.2ch';	//あとでBoardGroupへ移動
	ROUND_ITEM_FILENAME: string  = 'RoundItem.2ch';		//同上
	ROUND_INDEX_VERSION: string = '2.00';
    ERROR_BOARD_FILENAME: string = 'ErrorBoard.2ch'; //Error行を保管する
    ERROR_ITEM_FILENAME: string = 'ErrorItem.2ch'; //Error行を保管する
//! 巡回アイテムコンストラクタ
constructor TRoundItem.Create;
begin
	inherited Create;
end;
//! 板名取得
function TRoundItem.GetBoardTitle : string;
begin
	Result := '';
	if( Self.FItem <> nil) then begin
		if( Self.FItem is TBoard) then begin
			Result := TBoard(Self.FItem).Title;
		end else if( Self.FItem is TThreadItem) then begin
			Result := TThreadItem(Self.FItem).ParentBoard.Title;
		end;
	end;
end;
//! スレッド名取得
function TRoundItem.GetThreadTitle : string;
begin
	Result := '';
	if( Self.FItem <> nil) then begin
		if( Self.FItem is TThreadItem) then begin
			Result := TThreadItem(Self.FItem).Title;
		end;
	end;
end;
//! URL取得
function TRoundItem.GetURL	: string;
begin
	Result := '';
	if( Self.FItem <> nil) then begin
		if( Self.FItem is TBoard) then begin
			Result := TBoard(Self.FItem).URL;
		end else if( Self.FItem is TThreadItem) then begin
			Result := TThreadItem(Self.FItem).URL;
		end;
	end;
end;
//! スレッドのファイ名取得
function TRoundItem.GetFileName : string;
begin
	Result := '';
	if( Self.FItem <> nil) then begin
		if( Self.FItem is TThreadItem) then begin
			Result := TThreadItem(Self.FItem).FileName;
		end;
	end;
end;
//! 巡回名取得
function TRoundItem.GetRoundName : string;
begin
	Result := '';
	if( Self.FItem <> nil) then begin
		if( Self.FItem is TBoard) then begin
			Result := TBoard(Self.FItem).RoundName;
		end else if( Self.FItem is TThreadItem) then begin
			Result := TThreadItem(Self.FItem).RoundName;
		end;
	end;
end;
//! 巡回リストコンストラクタ
constructor TRoundList.Create;
begin
	inherited;
	FBoardList := TList.Create;
	FItemList := TList.Create;
	RoundNameList := TStringList.Create;
	RoundNameList.Sorted := True;
	RoundNameList.Duplicates := dupIgnore;
    FOldFileRead := false;
end;
//! 巡回リストデストラクタ
destructor TRoundList.Destroy;
begin
	RoundNameList.Free;
	Clear;
	FBoardList.Free;
	FItemList.Free;
	//inherited;
end;
//! 巡回予約追加（板）
function TRoundList.Add(Board: TBoard): Integer;
var
	idx: Integer;
	Item: TRoundItem;
begin
    Result := -1;
	idx := Find(Board);
	if idx = -1 then begin
		Item := TRoundItem.Create;
		Item.FItem := Board;
//		Item.BBSType := gbt2ch;	//とりあえず
		Item.RoundType := grtBoard;
		Result := FBoardList.Add(Item);
	end;
end;
//! 巡回予約追加（スレッド）
function TRoundList.Add(ThreadItem: TThreadItem): Integer;
var
	idx: Integer;
	Item: TRoundItem;
begin
    Result := -1;
	idx := Find(ThreadItem);
	if idx = -1 then begin
		Item := TRoundItem.Create;
		Item.FItem := ThreadItem;
//		Item.BBSType := gbt2ch;	//とりあえず
		Item.RoundType := grtItem;
		Result := FItemList.Add(Item);
	end;
end;
//! 巡回予約削除（板）
procedure TRoundList.Delete(Board: TBoard);
var
	idx: Integer;
begin
	idx := Find(Board);
	if idx <> -1 then begin
		TBoard(TRoundItem(FBoardList[idx]).FItem).RoundName := '';
		TRoundItem(FBoardList[idx]).Free;
		FBoardList.Delete(idx);
	end;
end;
//! 巡回予約削除（スレッド）
procedure TRoundList.Delete(ThreadItem: TThreadItem);
var
	idx: Integer;
begin
	idx := Find(ThreadItem);
	if idx <> -1 then begin
        TThreadItem(TRoundItem(FItemList[idx]).FItem).RoundName := '';
		TRoundItem(FItemList[idx]).Free;
		FItemList.Delete(idx);
	end;
end;
//! 巡回予約消去
procedure TRoundList.Clear;
var
	i: Integer;
begin
	for i := FBoardList.Count - 1 downto 0 do begin
        if FBoardList[i] <> nil then
			TRoundItem(FBoardList[i]).Free;
		FBoardList.Delete(i);
	end;
    FBoardList.Capacity := FBoardList.Count;
	for i := FItemList.Count - 1 downto 0 do begin
        if FItemList[i] <> nil then
			TRoundItem(FItemList[i]).Free;
		FItemList.Delete(i);
	end;
    FItemList.Capacity := FItemList.Count;
end;
//! 巡回予約検索（板）
function TRoundList.Find(Board: TBoard): Integer;
var
	i: Integer;
	Item: TRoundItem;
begin
	Result := -1;
	for i := 0 to FBoardList.Count - 1 do begin
		Item := TRoundItem(FBoardList[i]);
		if Item.FRoundType <> grtBoard then Continue;
		if Item.FItem = Board then begin
			Result := i;
			Exit;
		end;
	end;
end;
//! 巡回予約検索（スレッド）
function TRoundList.Find(ThreadItem: TThreadItem): Integer;
var
	i: Integer;
	Item: TRoundItem;
begin
	Result := -1;
	for i := 0 to FItemList.Count - 1 do begin
		Item := TRoundItem(FItemList[i]);
		if Item.FRoundType <> grtItem then Continue;
		if Item.FItem = ThreadItem then begin
			Result := i;
			Exit;
		end;
	end;
end;
//! 巡回予約検索（URL＋アイテムタイプ）
function TRoundList.Find(URL: string; RoundType: TGikoRoundType): Integer;
var
	i: Integer;
	Item: TRoundItem;
begin
	Result := -1;
    if RoundType = grtItem then begin
		for i := 0 to FItemList.Count - 1 do begin
			Item := TRoundItem(FItemList[i]);
			if Item.FRoundType <> RoundType then Continue;
			if Item.URL = URL then begin
				Result := i;
				Exit;
			end;
		end;
	end else begin
		for i := 0 to FBoardList.Count - 1 do begin
			Item := TRoundItem(FBoardList[i]);
			if Item.FRoundType <> RoundType then Continue;
			if Item.URL = URL then begin
				Result := i;
				Exit;
			end;
		end;
    end;
end;
//! 巡回予約削除（URL＋アイテムタイプ）
procedure TRoundList.Delete(URL: string; RoundType: TGikoRoundType);
var
	idx: Integer;
	Item: TRoundItem;
    board: TBoard;
    threadItem: TThreadItem;
begin
	idx := Find(URL, RoundType);
	if idx <> -1 then begin

        if RoundType = grtBoard then begin
			Item := TRoundItem(FBoardList[idx]);
			board := TBoard(Item);
			Item.Free;
			FBoardList.Delete(idx);
			if board <> nil then begin
				board.Round := False;
				board.RoundName := '';
			end;
		end else begin
			Item := TRoundItem(FItemList[idx]);
			threadItem := TThreadItem(Item.FItem);
			Item.Free;
			FItemList.Delete(idx);

            if threadItem <> nil then begin
	            threadItem.Round := false;
    	        threadItem.RoundName := '';
            end;
        end;
	end;
end;
//! 巡回予約数取得
function TRoundList.GetCount(RoundType: TGikoRoundType): Integer;
begin
	Result := 0;
	if RoundType = grtBoard then
		Result := FBoardList.Count
	else if RoundType = grtItem then
		Result := FItemList.Count;
end;
//! 巡回予約取得
function TRoundList.GetRoundItem(Index: Integer; RoundType: TGikoRoundType): TRoundItem;
begin
	Result := nil;
	if RoundType = grtBoard then begin
		if (Index >= 0) and (Index < FBoardList.Count) then
			Result := TRoundItem(FBoardList[Index]);
	end else if RoundType = grtItem then begin
		if (Index >= 0) and (Index < FItemList.Count) then
			Result := TRoundItem(FItemList[Index]);
	end;
end;
//! ボード巡回予約ファイル読み込み
procedure TRoundList.LoadRoundBoardFile;
var
	i: Integer;
	sl: TStringList;
	FileName, bFileName: string;
	errorSl: TStringList;
	errorFileName: string;
	delCount: Integer;
begin
	sl := TStringList.Create;
	errorSl := TStringList.Create;
	errorSl.Duplicates := dupIgnore;
	try
		//ボード巡回ファイル読み込み
		FileName := GikoSys.GetConfigDir + ROUND_BOARD_FILENAME;
		bFileName := GikoSys.GetConfigDir + '~' + ROUND_BOARD_FILENAME;
		//エラー行保存ファイル読み込み
		errorFileName := GikoSys.GetConfigDir + ERROR_BOARD_FILENAME;

		if FileExists(FileName) then begin
			sl.LoadFromFile(FileName);
			if FileExists(bFileName) then
				DeleteFile(bFileName);
			//バックアップ用のファイルを作成する
			sl.SaveToFile(bFileName);
			if FileExists(errorFileName) then begin
				try
                	errorSl.LoadFromFile(errorFileName);
                except
                end;
            end;
            //Item := TRoundItem.Create;

            if sl.Count = 0 then begin
                //エラー落ちするなどしてファイルの内容が空だとエラーになる対策
                sl.Add(ROUND_INDEX_VERSION);
            end;

            delCount := 0;
            //１行目はバージョン
			if sl[0] = ROUND_INDEX_VERSION then begin
				for i := 1 to sl.Count - 1 do begin
					if not ParseRoundBoardLine(sl[i - delCount]) then begin
						errorSl.Add( sl[i - delCount] );
                        sl.Delete(i- delCount);
                        Inc(delCount);
                    end;
				end;
            end else begin
                if FOldFileRead then begin  //ギコナビ本体がボードファイルをよみとった後じゃないとクラッシュするので
					for i := 1 to sl.Count - 1 do begin
						if not ParseOldRoundBoardLine(sl[i - delCount]) then begin
							errorSl.Add( sl[i- delCount] );
                        	sl.Delete(i- delCount);
                            Inc(delCount);
                        end;
					end;
                end else
                	FOldFileRead := true;
            end;
		end;
        if errorSl.Count > 0 then
        	errorSl.SaveToFile(errorFileName);
	finally
    	errorSl.Free;
		sl.Free;
	end;
end;
//! スレッド巡回予約ファイル読み込み
procedure TRoundList.LoadRoundThreadFile;
var
	i: Integer;
	sl: TStringList;
	FileName, bFileName: string;
    errorSl: TStringList;
    errorFileName: string;
    delCount: Integer;
begin
    errorSl := TStringList.Create;
	errorSl.Duplicates := dupIgnore;
	sl := TStringList.Create;
	try
		//スレ巡回ファイル読み込み
		FileName := GikoSys.GetConfigDir + ROUND_ITEM_FILENAME;
		bFileName := GikoSys.GetConfigDir + '~' + ROUND_ITEM_FILENAME;
		//エラー行保存ファイル読み込み
        errorFileName := GikoSys.GetConfigDir + ERROR_ITEM_FILENAME;
		if FileExists(FileName) then begin
			sl.LoadFromFile(FileName);
			if FileExists(bFileName) then
				DeleteFile(bFileName);
			sl.SaveToFile(bFileName);
			if FileExists(errorFileName) then begin
            	try
                	errorSl.LoadFromFile(errorFileName);
                except
                end;
            end;
            //Item := TRoundItem.Create;
            if sl.Count = 0 then begin
                //エラー落ちするなどしてファイルの内容が空だとエラーになる対策
                sl.Add(ROUND_INDEX_VERSION);
            end;

            delCount := 0;
			//１行目はバージョン
            if sl[0] = ROUND_INDEX_VERSION then begin
				for i := 1 to sl.Count - 1 do begin
					if not ParseRoundThreadLine(sl[i - delCount]) then begin
						errorSl.Add(sl[i - delCount]);
                        sl.Delete(i - delCount);
                        Inc(delCount);
                    end;
                end;
			end else begin
				LoadRoundBoardFile;
				for i := 1 to sl.Count - 1 do begin
					if not ParseOldRoundThreadLine(sl[i - delCount]) then begin
						errorSl.Add(sl[i - delCount]);
                        sl.Delete(i - delCount);
                        Inc(delCount);
                    end;
				end;
            end;
            if errorSl.Count > 0 then
            	errorSl.SaveToFile(errorFileName);
		end;
	finally
		errorSl.Free;
		sl.Free;
	end;
end;
//! 巡回予約ファイル保存
procedure TRoundList.SaveRoundFile;
var
	i: integer;
	FileName: string;
	sl: TStringList;
	s: string;
	Item: TRoundItem;
begin
	GikoSys.ForceDirectoriesEx(GikoSys.GetConfigDir);

	sl := TStringList.Create;
	try
		FileName := GikoSys.GetConfigDir + ROUND_BOARD_FILENAME;
		sl.Add(ROUND_INDEX_VERSION);
		for i := 0 to FBoardList.Count - 1 do begin
			Item := TRoundItem(FBoardList[i]);
			try
				if Item.TmpURL <> '' then begin
					s := Item.TmpURL + #1
						 + Item.BoardTitle + #1
						 + Item.RoundName;
				end else begin
					s := Item.URL + #1
						 + Item.BoardTitle + #1
						 + Item.RoundName;
				end;
				sl.Add(s);
			except
			end;
		end;
		sl.SaveToFile(FileName);
		sl.Clear;
		FileName := GikoSys.GetConfigDir + ROUND_ITEM_FILENAME;
		sl.Add(ROUND_INDEX_VERSION);
		for i := 0 to FItemList.Count - 1 do begin
			Item := TRoundItem(FItemList[i]);
			try
				if Item.TmpURL <> '' then begin
					s := Item.TmpURL + #1
					 + Item.BoardTitle + #1
					 + Item.FileName + #1
					 + Item.ThreadTitle + #1
					 + Item.RoundName;
				end else begin
					s := Item.URL + #1
					 + Item.BoardTitle + #1
					 + Item.FileName + #1
					 + Item.ThreadTitle + #1
					 + Item.RoundName;
				end;
				sl.Add(s);
			except
			end;
		end;
		sl.SaveToFile(FileName);
	finally
		sl.Free;
	end;
end;
function TRoundList.ParseRoundBoardLine(Line: string): Boolean;
var
	s: string;
	roundname: string;
	board: TBoard;
	i: Integer;
begin
	//Result := TRoundItem.Create;
	//Result.ThreadTitle := '';
	//Result.FileName := '';
	//Result.RoundType := grtBoard;
	board := nil;
	for i := 0 to 2 do begin
		s := GikoSys.GetTokenIndex(Line, #1, i);
		try
			case i of
				0:
				begin
					board := BBSsFindBoardFromURL(s);
					//Result.URL := s;
				end;
				//1: Result.BoardTitle := s;
				2: roundname := s;
			end;
		except
			Result := false;
			Exit;
		end;
	end;
	if( board <> nil ) then begin
		if not board.Round then begin
			board.RoundName := roundname;
			RoundNameList.Add(roundname);
			//RoundNameList.Find(roundname, i);
			//board.RoundName := PChar(RoundNameList[i]);
			board.Round := true;
		end;
		Result := true;
	end else begin
		Result := false;
	end;
end;

function TRoundList.ParseRoundThreadLine(Line: string): Boolean;
var
	s: string;
	roundname: string;
	threadItem: TThreadItem;
	i: Integer;
//    threadItem: TThreadItem;
begin
	//Result := TRoundItem.Create;
	//Result.RoundType := grtItem;
	threadItem := nil;
	for i := 0 to 4 do begin
		s := GikoSys.GetTokenIndex(Line, #1, i);
		try
			case i of
				0:
				begin
					//Result.URL := s;
					threadItem := BBSsFindThreadFromURL( s );
					//if threadItem <> nil then begin
					//    BoardList.Add( threadItem.ParentBoard.URL );
					//end;
				end;
				//1: Result.BoardTitle := s;
				//2: Result.FileName := s;
				//3: Result.ThreadTitle := s;
				4: roundname := s;
			end;
		except
			Result := false;
			Exit;
		end;
	end;
	if( threadItem <> nil ) then begin
		if not threadItem.Round then begin
			threadItem.RoundName := roundname;
			RoundNameList.Add(roundname);
			//RoundNameList.Find(roundname, i);
			//threadItem.RoundName := PChar(RoundNameList[i]);
			threadItem.Round := True;
		end;
		Result := true;
	end else begin
		Result := false;
	end;
end;

function TRoundList.ParseOldRoundBoardLine(Line: string): Boolean;
	var
	i: Integer;
	s: string;
	roundname: string;
	board: TBoard;
begin
	//Result := TRoundItem.Create;
	//Result.ThreadTitle := '';
	//Result.FileName := '';
	//Result.RoundType := grtBoard;
	board := nil;
	for i := 0 to 2 do begin
		s := GikoSys.GetTokenIndex(Line, #1, i);
		try
			case i of
				0:
				begin
					board := BBSs[ 0 ].FindBBSID( s );
					if board = nil then begin
						raise Exception.Create('この巡回は読み込めないよ（多分外部板）');
					end;
				end;
				//1: Result.FBoardTitle := s;
				2: roundname := s;
			end;
		except
			Result := false;
			Exit;
		end;
	end;
	if( board <> nil ) then begin
		if not board.Round then begin
			board.RoundName := roundname;
			RoundNameList.Add(roundname);
			//RoundNameList.Find(roundname, i);
			//board.RoundName := PChar(RoundNameList[i]);
			board.Round := true;
		end;
		Result := true;
	end else begin
		Result := false;
	end;
end;

function TRoundList.ParseOldRoundThreadLine(Line: string): Boolean;
	var
	i: Integer;
	s: string;
	roundname : string;
	buf: string;
	board: TBoard;
	threadItem: TThreadItem;
	bbsID: string;
begin
//	Result := TRoundItem.Create;
//	Result.RoundType := grtItem;
	threadItem := nil;
	for i := 0 to 4 do begin
		s := GikoSys.GetTokenIndex(Line, #1, i);
		try
			case i of
				0: bbsID := s;
				//1: Result.BoardTitle := s;
				2:
				begin
					//Result.FileName := s;
					board := BBSs[ 0 ].FindBBSID(bbsID);
					if board <> nil then begin
						buf := Copy(board.GetSendURL,1,LastDelimiter('/', board.GetSendURL)-1);
						buf := buf + '/read.cgi/'+ board.BBSID+ '/' +ChangeFileExt(s,'') + '/l50';
						threadItem := BBSsFindThreadFromURL(buf);
					end else begin
						raise Exception.Create('この巡回は読み込めないよ');
					end;
				end;
				//3: Result.ThreadTitle := s;
				4: roundname := s;
			end;
		except
			Result := false;
			Exit;
		end;
	end;
	if( threadItem <> nil ) then begin
		if not threadItem.Round then begin
			threadItem.RoundName := roundname;
			RoundNameList.Add(roundname);
			//RoundNameList.Find(roundname, i);
			//threadItem.RoundName := PChar(RoundNameList[i]);
			threadItem.Round := true;
		end;
		Result := true;
	end else begin
		Result := false;
	end;

end;
procedure  TRoundList.URLReplace(oldURLs: TStringList; newURLs :TStringList);
var
	i: Integer;
	j: Integer;
	tempString: string;
	tmpURL: string;
	oldHost: string;
	oldBoardName: string;
	newHost: string;
	newBoardName: string;
begin
	if oldURLs.Count <> newURLs.Count then
		Exit;
	//ここから、BoardのURLの変更
	for j :=0 to oldURLs.Count - 1 do begin
		for i :=0 to FBoardList.Count - 1 do begin
			if TRoundItem(FBoardList[i]).URL = oldURLs[j] then
				TRoundItem(FBoardList[i]).TmpURL := newURLs[j];
		end;
	end;
	//ここまで、BoardのURLの変更

	//ここから、ThreadのURLの変更
	//面倒だけどthreadはそれぞれURLをチャックしながらやってかなきゃいけない。
	for i := 0 to oldURLs.Count - 1 do begin
		tmpURL 			:= Copy(oldURLs[i], 1, Length(oldURLs[i]) -1);
		oldHost			:= Copy(tmpURL, 1, LastDelimiter('/', tmpURL) );
		oldBoardName    := Copy(tmpURL, LastDelimiter('/', tmpURL), Length(tmpURL) ) + '/';
		tmpURL 			:= Copy(newURLs[i], 1, Length(newURLs[i]) -1);
		newHost			:= Copy(tmpURL, 1, LastDelimiter('/', tmpURL) );
		newBoardName    := Copy(tmpURL, LastDelimiter('/', tmpURL), Length(tmpURL) ) + '/';

		for j := 0 to FItemList.Count - 1 do begin
			tempString := TRoundItem(FItemList[j]).URL;
			if ( AnsiPos(oldBoardName, tempString) <> 0 ) and ( AnsiPos(oldHost, tempString ) <> 0 ) then begin
				tempString := StringReplace(tempString, oldHost, newHost,[]);
				TRoundItem(FItemList[j]).TmpURL := tempString;
			end;
		end;
	end;
	//ここまで、ThreadのURLの変更

end;

end.
