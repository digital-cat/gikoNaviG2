unit HistoryList;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls,
    BoardGroup, Favorite, ComCtrls, GikoXMLDoc;

type
	TGikoTreeType = (gttNone, gtt2ch, gttHistory, gttFavorite);

	THistoryList = class(TList)
    public
        function AddHistory( favItem : TFavoriteThreadItem; TreeView : TTreeView;
            TreeType: TGikoTreeType): Boolean;
        procedure DeleteHistory( threadItem: TThreadItem; TreeView : TTreeView;
            TreeType: TGikoTreeType );
        procedure Clear; override;
        procedure SaveToFile(const FileName: String);
        procedure LoadFromFile(const FileName: String;
            TreeView : TTreeView; TreeType: TGikoTreeType);
        procedure SetTreeNode( TreeView : TTreeView );

    end;


implementation

uses
    Giko, GikoSystem, Setting, YofUtils, MojuUtils;

const
	ITEM_ICON_THREADLOG1		= 6;		//スレアイコン（ログあり）
	ITEM_ICON_THREADLOG2		= 7;		//スレアイコン（ログあり）


function THistoryList.AddHistory(
    favItem : TFavoriteThreadItem; TreeView : TTreeView;
    TreeType: TGikoTreeType ): Boolean;
var
	i: Integer;
	Item: TFavoriteThreadItem;
	Node: TTreeNode;
begin
	Result := True;
	if TreeType = gttHistory then
  	TreeView.Selected := nil;

	for i := 0 to Self.Count - 1 do begin
		if TObject(Self[i]) is TFavoriteThreadItem then begin
			Item := TFavoriteThreadItem(Self[i]);
			if Item.URL = favItem.URL then begin
				Self.Move(i, 0);
				if TreeType = gttHistory then
					if TreeView.Items.GetFirstNode <> TreeView.Items[ i ] then
						TreeView.Items[ i ].MoveTo( TreeView.Items.GetFirstNode, naInsert );
								Result := false;
				Exit;
			end;
		end;
	end;

	if Self.Count > 0 then
		Self.Insert( 0, favItem )
	else
		Self.Add( favItem );

	while GikoSys.Setting.MaxRecordCount < Self.Count do begin
		i := Self.Count - 1;
		TObject( Self.Items[ i ] ).Free;
		Self.Delete( i );
	end;

	if TreeType = gttHistory then begin
		Node := TreeView.Items.Add( nil, favItem.Title );
		Node.MoveTo( TreeView.Items.GetFirstNode, naInsert );
		{
		if favItem.NewArrival then begin
			Node.ImageIndex := ITEM_ICON_THREADNEW1;
			Node.SelectedIndex := ITEM_ICON_THREADNEW2;
		end else begin
			Node.ImageIndex := ITEM_ICON_THREADLOG1;
			Node.SelectedIndex := ITEM_ICON_THREADLOG2;
		end;
		}
		// 負荷をかけたくないので NewArrival のチェックを行わない
		// ※favItem.Item プロパティは dat の読み込みを必要とする
		Node.ImageIndex := ITEM_ICON_THREADLOG1;
		Node.SelectedIndex := ITEM_ICON_THREADLOG2;
		Node.Data := favItem;
		//while GikoSys.Setting.AddressHistoryCount < TreeView.Items.Count do begin
		while GikoSys.Setting.MaxRecordCount < TreeView.Items.Count do begin
			i := TreeView.Items.Count - 1;
			TreeView.Items.Item[ i ].Delete;
		end;
	end;
end;

procedure THistoryList.DeleteHistory( threadItem: TThreadItem;
    TreeView : TTreeView; TreeType: TGikoTreeType );
var
	i: Integer;
	node: TTreeNode;
begin
	// キャビネットに履歴が表示されていたら、
	// キャビネット内のアイテムも削除する。
	if (TreeType = gttHistory) then begin
		node := TreeView.Items.GetFirstNode;
		while (node <> nil) do begin
			if ( TFavoriteThreadItem(node.Data).Item  = threadItem ) then begin
				TreeView.Items.Delete(node);
				TreeView.Refresh;
				node := nil;
			end else begin
				node := node.GetNext;
			end;
		end;
	end;
	for i := 0 to Self.Count - 1 do begin
		if threadItem = TFavoriteThreadItem( Self.Items[i] ).Item then begin
			TFavoriteThreadItem( Self.Items[ i ] ).Free;
			Self.Delete(i);
			Self.Capacity := Self.Count;
			Break;
		end;
	end;
end;

procedure THistoryList.Clear;
var
	i : Integer;
begin
	try
		for i := Self.Count - 1 downto 0 do begin
			if TObject(Self[ i ]) is TFavoriteThreadItem then
            	TFavoriteThreadItem(Self[ i ]).Free
            else if TObject(Self[ i ]) is TFavoriteBoardItem then
                TFavoriteBoardItem(Self[ i ]).Free;
        end;
	except
	end;

	inherited Clear;
    Self.Capacity := Self.Count;

end;

procedure THistoryList.SaveToFile(const FileName: String);
var
	i, bound	: Integer;
	saveList	: TstringList;
begin

	saveList := TStringList.Create;
	try
		Self.Pack;
        Self.Capacity := Self.Count;
		saveList.Add('<?xml version="1.0" encoding="Shift_JIS" standalone="yes"?>');
		saveList.Add('<address>');
		bound := Self.Count - 1;
		for i := bound downto 0 do begin
			// title は今のところ使っていない
			saveList.Add(
				'<history url="' + HtmlEncode( TFavoriteThreadItem( Self[ i ] ).URL ) + '"' +
				' title="' + HtmlEncode( MojuUtils.Sanitize(TFavoriteThreadItem( Self[ i ] ).Title )) + '"/>');
		end;
		saveList.Add('</address>');
		saveList.SaveToFile( FileName );
	finally
		saveList.Free;
	end;

end;

procedure THistoryList.LoadFromFile(const FileName: String;
    TreeView : TTreeView; TreeType: TGikoTreeType);
var
	i, bound		: Integer;
	XMLDoc			: IXMLDocument;
	XMLNode			: IXMLNode;
	HistoryNode	: IXMLNode;
	s						: string;
	favItem			: TFavoriteThreadItem;
{$IFDEF DEBUG}
	st, rt : Cardinal;
{$ENDIF}
begin
{$IFDEF DEBUG}
	st := GetTickCount;
{$ENDIF}
	if FileExists( FileName ) then begin
		try
			XMLDoc := IXMLDocument.Create;
			//XMLDoc := LoadXMLDocument(FileName);
			LoadXMLDocument(FileName, XMLDoc);
			try
				XMLNode := XMLDoc.DocumentElement;

				if XMLNode.NodeName = 'address' then begin
					bound := XMLNode.ChildNodes.Count - 1;
					for i := 0 to bound do begin
						HistoryNode := XMLNode.ChildNodes[i];
						if HistoryNode.NodeName = 'history' then begin
							//if FReadCount >= sl.Count then begin
								s := Trim(HistoryNode.Attributes['url']);
								if s <> '' then begin
									favItem := TFavoriteThreadItem.Create(
										s, MojuUtils.UnSanitize(HistoryNode.Attributes[ 'title' ]) );
									if not AddHistory( favItem, TreeView, TreeType ) then
										favItem.Free;
								end;
							//end;
						end;
					end;
				end;
			finally
				XMLDoc.Free;
			end;
		except
		end;
	end;
{$IFDEF DEBUG}
	rt := GetTickCount - st;
	Writeln('Runtime(Load Histroy) : ' + IntToStr(rt) + ' ms');
{$ENDIF}

end;
procedure THistoryList.SetTreeNode(
    TreeView : TTreeView );
var
	i: Integer;
	Node: TTreeNode;
	Item: TFavoriteThreadItem;
begin
	TreeView.Items.BeginUpdate;
	try
		TreeView.Items.Clear;
		for i := 0 to Self.Count - 1 do begin
			Item := TFavoriteThreadItem(Self[i]);
			Node := TreeView.Items.Add(nil, Item.Title);
			{
			if Item.Item.NewArrival then begin
				Node.ImageIndex := ITEM_ICON_THREADNEW1;
				Node.SelectedIndex := ITEM_ICON_THREADNEW2;
			end else begin
				Node.ImageIndex := ITEM_ICON_THREADLOG1;
				Node.SelectedIndex := ITEM_ICON_THREADLOG2;
			end;
			}
			// 負荷をかけたくないので NewArrival のチェックを行わない
			// ※Item.Item プロパティは dat の読み込みを必要とする
			Node.ImageIndex := ITEM_ICON_THREADLOG1;
			Node.SelectedIndex := ITEM_ICON_THREADLOG2;
			Node.Data := Item;
		end;
	finally
		TreeView.Items.EndUpdate;
	end;
end;

end.
