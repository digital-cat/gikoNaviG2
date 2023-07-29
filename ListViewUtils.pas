unit ListViewUtils;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls,
	BoardGroup, StdCtrls, ComCtrls;

type
	TListViewUtils = class(TObject)
	private
		{Private 宣言}

		class procedure DrawCategoryItem(BBS: TBBS; Item: TListItem; ListView: TListView);
		class procedure DrawBoardItem(Category: TCategory; Item: TListItem; ListView: TListView);
		class procedure DrawThreadItem(Board: TBoard; Item: TListItem; ListView: TListView);
		class procedure DrawItemLogThread(Thread: TThreadItem; Item: TListItem; ColumnCount: Integer);
		class procedure DrawItemNoLogThread(Thread: TThreadItem; Item: TListItem; ColumnCount: Integer);
	public
		{Public 宣言}
		class procedure SetBoardTreeNode(inBBS : TBBS; treeView: TTreeView);
		class function SetCategoryListItem(ABBS2ch: TBBS; ListView: TListView;
			NumberVisible: Boolean): Integer;
		class procedure ListViewSort(Sender: TObject; ListView: TListView; Column: TListColumn;
			NumberVisible: Boolean; vSortOrder: Boolean);
		class function	ActiveListTrueColumn( column : TListColumn ) : TListColumn;
		class function SetBoardListItem(Category: TCategory; ListView: TListView;
			NumberVisible: Boolean): Integer;
		class function SetThreadListItem(Board: TBoard; ListView: TListView;
			NumberVisible: Boolean): Integer;
		class procedure ListViewData(Sender: TObject; Item: TListItem);
	end;

implementation

uses
	GikoSystem, Sort, Setting, Giko, MojuUtils, GikoDataModule, DateUtils, Math;

const
	//ツリー・リストアイコン
	ITEM_ICON_2CH1					= 0;		//2chアイコン
	ITEM_ICON_2CH2					= 1;		//2chアイコン
	ITEM_ICON_CATEGORY1			= 2;		//カテゴリアイコン
	ITEM_ICON_CATEGORY2			= 3;		//カテゴリアイコン
	ITEM_ICON_BOARD_NOSUBJECT	= 3;	//読み込まれていない板アイコン
	ITEM_ICON_BOARD1				= 4;		//板アイコン
	ITEM_ICON_BOARD2				= 5;		//板アイコン
	ITEM_ICON_THREADLOG1		= 6;		//スレアイコン（ログあり）
	ITEM_ICON_THREADLOG2		= 7;		//スレアイコン（ログあり）
	ITEM_ICON_THREAD1				= 8;		//スレアイコン（ログなし）
	ITEM_ICON_THREAD2				= 9;		//スレアイコン（ログなし）
	ITEM_ICON_THREADNEW1		= 10;		//スレアイコン（新着）
	ITEM_ICON_THREADNEW2		= 11;		//スレアイコン（新着）
	ITEM_ICON_SORT1					= 12;		//ソートアイコン
	ITEM_ICON_SORT2					= 13;		//ソートアイコン
	ITEM_ICON_BOARD_LOG			= 17;		//スレログあり板アイコン
	ITEM_ICON_BOARD_NEW			= 18;		//スレ新着板アイコン


//ボードツリー設定
class procedure TListViewUtils.SetBoardTreeNode(
	inBBS : TBBS;
	treeView : TTreeView
);
var
	i, j, k: integer;
	Root: TTreeNode;
	CategoryNode: TTreeNode;
	BoardNode: TTreeNode;
	Category: TCategory;
	Board: TBoard;
begin
	// 板リストの設定

	TreeView.Items.BeginUpdate;
	TreeView.Items.Clear;
	try
		if not inBBS.IsBoardFileRead then
			GikoSys.ReadBoardFile( inBBS );

		// キャビネット表示前に再ソート
		if ( GikoSys.Setting.BBSSortIndex <> 0 ) or ( GikoSys.Setting.BBSSortOrder <> true ) then begin
			Sort.SetSortOrder(true);
			Sort.SetSortIndex(0);
			Sort.SetSortNoFlag(true);
			inBBS.Sort(CategorySortProc);
		end;

		Root								:= TreeView.Items.Add( nil, inBBS.Title );
		Root.ImageIndex			:= ITEM_ICON_2CH1;
		Root.SelectedIndex	:= ITEM_ICON_2CH2;
		Root.Data						:= inBBS;
		for i := inBBS.Count - 1 downto 0 do begin
			Category := TCategory(inBBS.Items[i]);
			CategoryNode := TreeView.Items.AddChildFirst(Root, Category.Title);
			CategoryNode.Data := Category;
			CategoryNode.ImageIndex := ITEM_ICON_CATEGORY1;
			CategoryNode.SelectedIndex := ITEM_ICON_CATEGORY2;

			// キャビネット表示前に再ソート
			if ( GikoSys.Setting.CategorySortIndex <> 0 ) or ( GikoSys.Setting.CategorySortOrder <> true ) then begin
				Sort.SetSortOrder(true);
				Sort.SetSortIndex(0);
				Sort.SetSortNoFlag(true);
				Category.CustomSort(BoardSortProc);
			end;

			for j := Category.Count - 1 downto 0 do begin
				Board := TBoard(Category.Items[j]);
				Board.BeginUpdate;
				BoardNode := TreeView.Items.AddChildFirst(CategoryNode, Board.Title);
				BoardNode.Data := Board;
				//if (Board.LastGetTime = 0) or (Board.LastGetTime = ZERO_DATE) then begin
				if not Board.IsLogFile then begin
					BoardNode.ImageIndex := ITEM_ICON_BOARD_NOSUBJECT;
					BoardNode.SelectedIndex := ITEM_ICON_BOARD_NOSUBJECT;
				end else begin
					BoardNode.ImageIndex := ITEM_ICON_BOARD1;
					BoardNode.SelectedIndex := ITEM_ICON_BOARD2;
					for k := 0 to Board.Count - 1 do begin
						if Board.Items[ k ].IsLogFile then begin
							BoardNode.ImageIndex := ITEM_ICON_BOARD_LOG;
							BoardNode.SelectedIndex := ITEM_ICON_BOARD_LOG;

							Break;
						end;
					end;
				end;
				Board.EndUpdate;
			end;

			CategoryNode.Expanded := Category.NodeExpand;

		end;
	finally
		TreeView.Items.EndUpdate;
	end;
end;

//ListViewにカテゴリを設定する
class function TListViewUtils.SetCategoryListItem(
	ABBS2ch: TBBS;
	ListView: TListView;
	NumberVisible: Boolean
): Integer;
var
	TitleColumn	: TListColumn;
	ListColumn	: TListColumn;
	i, id, idx	: Integer;
begin
	ListView.Items.BeginUpdate;
	try
		ListView.Columns.Clear;
		TitleColumn := ListView.Columns.Add;
		TitleColumn.Caption := GikoBBSColumnCaption[ Ord( gbbscTitle ) ];
		TitleColumn.Width := GikoSys.Setting.BBSColumnWidth[ Ord( gbbscTitle ) ];
		idx := 0;
		for i := 0 to GikoSys.Setting.BBSColumnOrder.Count - 1 do begin
			if GikoSys.Setting.BBSColumnOrder[ i ] = gbbscTitle then begin
				TitleColumn.Tag := i;
				idx := i;
			end else begin
				id := Ord( GikoSys.Setting.BBSColumnOrder[ i ] );
				if (Integer( Low( TGikoBBSColumnID ) ) <= id) and
					(id <= Integer( High( TGikoBBSColumnID ) )) then begin
					ListColumn := ListView.Columns.Add;
	//					ListColumn.Tag := id;
						ListColumn.Tag := i;
					ListColumn.Caption := GikoBBSColumnCaption[ id ];
					ListColumn.Width := GikoSys.Setting.BBSColumnWidth[ id ];
				end;
			end;
		end;
		TitleColumn.Index := idx;

		ListView.Items.Count := 0;
		ListView.Items.Clear;
		ListView.Items.Count := ABBS2ch.Count;

		GikoForm.ListNameLabel.Caption := ABBS2ch.Title;
		GikoForm.FolderImage.Picture := nil;
		GikoForm.ItemIcon16.GetBitmap(1, GikoForm.FolderImage.Picture.Bitmap);

		for i := ListView.Columns.Count - 1 downto 0 do begin
			if (GikoSys.Setting.BBSSortIndex
					= Integer(GikoSys.Setting.BBSColumnOrder[ ListView.Column[ i ].Tag ])) then begin
				ListViewSort( nil, ListView, ListView.Column[ i ],
					 NumberVisible, GikoSys.Setting.BBSSortOrder);
				Break;
			end;
		end;

		Result := ABBS2ch.Count;
	finally
		ListView.Items.EndUpdate;
	end;
end;

class procedure TListViewUtils.ListViewSort(
	Sender: TObject;
	ListView: TListView;
	Column: TListColumn;
	NumberVisible: Boolean;
	vSortOrder: Boolean
);
var
	i, idx	: Integer;
	orderList		: TList;
	wkBBS: TBBS;
	wkCategory: TCategory;
	wkBoard: TBoard;
begin
	idx := ActiveListTrueColumn( Column ).Tag;

	for i := 0 to ListView.Columns.Count - 1 do begin
		ListView.Column[i].ImageIndex := -1;
	end;
	if vSortOrder then
		ListView.Column[ idx ].ImageIndex := ITEM_ICON_SORT1
	else
		ListView.Column[ idx ].ImageIndex := ITEM_ICON_SORT2;


	Sort.SetSortNoFlag(NumberVisible);

	if TObject( GikoForm.ActiveList ) is TBBS then begin
		wkBBS := TBBS( GikoForm.ActiveList );
		orderList := GikoSys.Setting.BBSColumnOrder;
		Sort.SetSortOrder(vSortOrder);
		Sort.SetSortIndex(Integer( orderList[ idx ] ));
		GikoSys.Setting.BBSSortIndex := Sort.GetSortIndex;
		GikoSys.Setting.BBSSortOrder := Sort.GetSortOrder;
		wkBBS.Sort(Sort.CategorySortProc);
	end else if TObject( GikoForm.ActiveList ) is TCategory then begin
		wkCategory := TCategory( GikoForm.ActiveList );
		orderList := GikoSys.Setting.CategoryColumnOrder;
		Sort.SetSortOrder(vSortOrder);
		Sort.SetSortIndex(Integer( orderList[ idx ] ));
		GikoSys.Setting.CategorySortIndex := Sort.GetSortIndex;
		GikoSys.Setting.CategorySortOrder := Sort.GetSortOrder;
		wkCategory.CustomSort(BoardSortProc);
	end else if TObject( GikoForm.ActiveList ) is TBoard then begin
		wkBoard := TBoard( GikoForm.ActiveList );
		orderList := GikoSys.Setting.BoardColumnOrder;
		Sort.SetSortOrder(vSortOrder);
		Sort.SetSortIndex(Integer( orderList[ idx ] ));
		GikoSys.Setting.BoardSortIndex := Sort.GetSortIndex;
		GikoSys.Setting.BoardSortOrder := Sort.GetSortOrder;
		wkBoard.CustomSort(ThreadItemSortProc);
	end;

	ListView.Refresh;
end;

{!
\brief		ListView の Column を真のカラムに変換

Delphi 6 Personal での ListView では ListViewColumnClick イベントで
正しいカラムが渡されないため、正しいカラムに変換します。
}
class function	TListViewUtils.ActiveListTrueColumn( column : TListColumn ) : TListColumn;
begin
	// 正しく変換する方法が分からないので保留
	Result := column;
	Exit;
end;
//ListViewにBoardItemを設定する
class function TListViewUtils.SetBoardListItem(
	Category: TCategory;
	ListView: TListView;
	NumberVisible: Boolean
): Integer;
var
	TitleColumn	: TListColumn;
	ListColumn	: TListColumn;
	i, id, idx	: Integer;
begin
	ListView.Items.BeginUpdate;
	try
		ListView.Columns.Clear;
		TitleColumn := ListView.Columns.Add;
		TitleColumn.Caption := GikoCategoryColumnCaption[ Ord( gccTitle ) ];
		TitleColumn.Width := GikoSys.Setting.CategoryColumnWidth[ Ord( gccTitle ) ];
		idx := 0;
		for i := 0 to GikoSys.Setting.CategoryColumnOrder.Count - 1 do begin
			if GikoSys.Setting.CategoryColumnOrder[ i ] = gccTitle then begin
				TitleColumn.Tag := i;
				idx := i;
			end else begin
				id := Ord( GikoSys.Setting.CategoryColumnOrder[ i ] );
				if (Integer( Low( TGikoCategoryColumnID ) ) <= id) and
					(id <= Integer( High( TGikoCategoryColumnID ) )) then begin
					ListColumn := ListView.Columns.Add;
//						ListColumn.Tag := id;
					ListColumn.Tag := i;
					ListColumn.Caption := GikoCategoryColumnCaption[ id ];
					ListColumn.Width := GikoSys.Setting.CategoryColumnWidth[ id ];
				end;
			end;
		end;
		TitleColumn.Index := idx;

		ListView.Items.Count := 0;
		ListView.Items.Clear;
		ListView.Items.Count := Category.Count;

		for i := Category.Count - 1 downto 0 do begin
			if( Category.Items[i].ParentCategory <> Category ) then begin
				Category.Items[i].ParentCategory	:= Category;
				Category.Items[i].No 				:= i + 1;
			end;
		end;
//		UpFolderAction.Enabled := True;
//		AllItemAction.Enabled := False;
//		LogItemAction.Enabled := False;
//		NewItemAction.Enabled := False;
//		SelectItemAction.Enabled := False;
//		ListDownloadToolButton.Enabled := False;
//		BoardReservToolButton.Enabled := False;
//		ListThreadDownloadToolButton.Enabled := False;

		GikoForm.ListNameLabel.Caption := Category.Title;
		GikoForm.FolderImage.Picture := nil;
		GikoForm.ItemIcon16.GetBitmap(3, GikoForm.FolderImage.Picture.Bitmap);

		for i := ListView.Columns.Count - 1 downto 0 do begin
			if (GikoSys.Setting.CategorySortIndex =
				Integer( GikoSys.Setting.CategoryColumnOrder[ ListView.Columns[i].Tag ] )) then begin
				ListViewSort( nil, ListView, ListView.Column[ i ],
					 NumberVisible, GikoSys.Setting.CategorySortOrder);
				Break;
			end;
		end;

		Result := Category.Count;
	finally
		ListView.Items.EndUpdate;
	end;
end;
//ListViewにThreadItemを設定する
class function TListViewUtils.SetThreadListItem(
	Board: TBoard;
	ListView: TListView;
	NumberVisible: Boolean
): Integer;
var
	TitleColumn	: TListColumn;
	ListColumn	: TListColumn;
	i, id, idx	: Integer;
begin
	ListView.Items.BeginUpdate;
	try
		//Screen.Cursor := crHourGlass;

{*
		// チラつき防止のため、変更されている場合のみ
		// ※名称は違うがカラム数が同じ、といった場合に対処できないので注意
		if ListView.Columns.Count <> GikoSys.Setting.BoardColumnOrder.Count then
*}
		begin
			ListView.Columns.Clear;
			TitleColumn := ListView.Columns.Add;
			TitleColumn.Caption := GikoBoardColumnCaption[ Ord( gbcTitle ) ];
			TitleColumn.Width := GikoSys.Setting.BoardColumnWidth[ Ord( gbcTitle ) ];
			idx := 0;
			for i := 0 to GikoSys.Setting.BoardColumnOrder.Count - 1 do begin
				if GikoSys.Setting.BoardColumnOrder[ i ] = gbcTitle then begin
					TitleColumn.Tag := i;
					idx := i;
				end else begin
					id := Ord( GikoSys.Setting.BoardColumnOrder[ i ] );
					if (Integer( Low( TGikoBoardColumnID ) ) <= id) and
						(id <= Integer( High( TGikoBoardColumnID ) )) then begin
						ListColumn := ListView.Columns.Add;
						ListColumn.Caption := GikoBoardColumnCaption[ id ];
	//					ListColumn.Tag := id;
						ListColumn.Tag := i;
						ListColumn.Width := GikoSys.Setting.BoardColumnWidth[ id ];
						ListColumn.Alignment := GikoBoardColumnAlignment[ id ];
					end;
				end;
			end;
			TitleColumn.Index := idx;
		end;

		ListView.Items.Count := 0;
		ListView.Items.Clear;

		{case GikoForm.ViewType of
			gvtAll: ListView.Items.Count := Board.Count;
			gvtLog: ListView.Items.Count := Board.GetLogThreadCount;
			gvtNew: ListView.Items.Count := Board.GetNewThreadCount;
			gvtUser: ListView.Items.Count := Board.GetUserThreadCount;
		end;
		}
		case GikoForm.ViewType of
			gvtAll: ListView.Items.Count := Board.Count;
			gvtLog:
			begin
				Board.LogThreadCount := Board.GetLogThreadCount;
				ListView.Items.Count := Board.LogThreadCount;
			end;
			gvtNew:
			begin
				Board.NewThreadCount := Board.GetNewThreadCount;
				ListView.Items.Count := Board.NewThreadCount;
			end;
			gvtArch:
			begin
				Board.ArchiveThreadCount := Board.GetArchiveThreadCount;
				ListView.Items.Count := Board.ArchiveThreadCount;
			end;
			gvtLive:
			begin
				Board.LiveThreadCount := Board.GetLiveThreadCount;
				ListView.Items.Count := Board.LiveThreadCount;
			end;
			gvtUser:
			begin
				Board.UserThreadCount:= Board.GetUserThreadCount;
				ListView.Items.Count := Board.UserThreadCount;
			end;
		end;

		GikoForm.ListNameLabel.Caption := Board.Title;
		GikoForm.FolderImage.Picture := nil;
		GikoForm.ItemIcon16.GetBitmap(5, GikoForm.FolderImage.Picture.Bitmap);

		for i := ListView.Columns.Count - 1 downto 0 do begin
			if (GikoSys.Setting.BoardSortIndex
				= Integer( GikoSys.Setting.BoardColumnOrder[ ListView.Columns[ i ].Tag ] )) then begin
				ListViewSort( nil, ListView, ListView.Column[ i ],
					 NumberVisible, GikoSys.Setting.BoardSortOrder);
				Break;
			end;
		end;

		Result := Board.Count;
	finally
		ListView.Items.EndUpdate;
	end;
end;

class procedure TListViewUtils.ListViewData(Sender: TObject; Item: TListItem);
var
	ActivListObj : TObject;
	ListView : TListView;
begin
	if (Sender <> nil) and (Sender is TListView) then begin
		ListView := TListView(Sender);
		ActivListObj := GikoForm.ActiveList;
		if ActivListObj is TBBS then begin
			DrawCategoryItem(TBBS(ActivListObj), Item, ListView);
		end else if ActivListObj is TCategory then begin
			DrawBoardItem(TCategory(ActivListObj), Item, ListView);
		end else if ActivListObj is TBoard then begin
			DrawThreadItem(TBoard(ActivListObj), Item, ListView);
		end;
	end;
end;
//! リストビューのアイテムを描画する（カテゴリー用）
class procedure TListViewUtils.DrawCategoryItem(
	BBS: TBBS; Item: TListItem; ListView: TListView
);
var
	Category : TCategory;
begin

	//===== カテゴリリスト =====
	ListView.StateImages := nil;

	if (BBS = nil) or (BBS.Count <= 0) or (Item = nil)
		or (Item.Index >= BBS.Count) or (ListView.Items.Count = 0)
		or (not (BBS.Items[Item.index] is TCategory)) then Exit;

	Category := TCategory(BBS.Items[Item.index]);

	if (Category = nil) then Exit;

    if GikoDM.ListNumberVisibleAction.Checked then
		Item.Caption := IntToStr(Category.No) + ': ' + Category.Title
	else
		Item.Caption := Category.Title;

	Item.ImageIndex := ITEM_ICON_CATEGORY1;
	Item.Data := Category;
end;
//! リストビューのアイテムを描画する（板用）
class procedure TListViewUtils.DrawBoardItem(
	Category: TCategory; Item: TListItem; ListView: TListView
);
var
	Board: TBoard;
	i, idx : Integer;
begin
	//===== 板リスト =====
	ListView.StateImages := nil;

	if (Category = nil) or (Category.Count <= 0) or (Item = nil)
		or (Item.Index >= Category.Count) or (ListView.Items.Count = 0)
		or (not (Category.Items[Item.Index] is TBoard))  then Exit;

	Board := TBoard(Category.Items[Item.Index]);

	if (Board = nil)  then Exit;

	if GikoDM.ListNumberVisibleAction.Checked then
		Item.Caption := IntToStr(Board.No) + ': ' + Board.Title
	else
		Item.Caption := Board.Title;

	if Item.SubItems.Count <> ListView.Columns.Count then begin
		Item.SubItems.Clear;
		Item.SubItems.Capacity := GikoSys.Setting.CategoryColumnOrder.Count;
		for i := GikoSys.Setting.CategoryColumnOrder.Count - 1 downto 1 do
			Item.SubItems.Add('');
	end;

	Item.ImageIndex := ITEM_ICON_BOARD1;
	idx := 0;
	for i := 0 to ListView.Columns.Count - 1 do begin
		if GikoSys.Setting.CategoryColumnOrder.Count <= i then
			Break;
		case GikoSys.Setting.CategoryColumnOrder[ i ] of
		gccTitle:
			// Item.Caption は SubItems に含まれ無いので
			Dec( idx );

		gccRoundName:
			if Board.Round then
				Item.SubItems[ idx ] := Board.RoundName	// '予約'
			else
				Item.SubItems[ idx ] := '';

		gccLastModified:
			if Board.RoundDate = ZERO_DATE then begin
				Item.SubItems[ idx ] := '';
			end else
				Item.SubItems[ idx ] := FormatDateTime('yyyy/mm/dd hh:mm:ss', Board.RoundDate);
		end;
		Inc( idx );
	end;

	Item.Data := Board;

end;
//! リストビューのアイテムを描画する（スレッド用）
class procedure TListViewUtils.DrawThreadItem(
	Board: TBoard; Item: TListItem;ListView : TListView
);
var
	ThreadItem: TThreadItem;
	BoardCnt: Integer;
	RepStr: String;
	i: Integer;
begin
	//===== スレリスト =====
	if GikoSys.Setting.ListIconVisible then
		ListView.StateImages := GikoForm.StateIconImageList
	else
		ListView.StateImages := nil;


	case GikoForm.ViewType of
		gvtAll: BoardCnt := Board.Count;
		gvtLog: BoardCnt := Board.LogThreadCount;
		gvtNew: BoardCnt := Board.NewThreadCount;
		gvtArch: BoardCnt := Board.ArchiveThreadCount;
		gvtLive: BoardCnt := Board.LiveThreadCount;
		gvtUser: BoardCnt := Board.UserThreadCount;
		else
			BoardCnt := 0;
	end;

	if (BoardCnt <= 0) or (Item = nil) or (Item.Index >= BoardCnt)
		or (ListView.Items.Count = 0) or (not (Board.Items[Item.Index] is TThreadItem)) then Exit;

	//改善すべきブロック/////////////////////////////////////////////////////
	ThreadItem := nil;
	case GikoForm.ViewType of
		gvtAll: if Item.Index >= Board.Count then Exit else
							ThreadItem := TThreadItem(Board.Items[Item.Index]);
		gvtLog: 	ThreadItem := Board.GetLogThread(Item.Index);
		gvtNew:		ThreadItem := Board.GetNewThread(Item.Index);
		gvtArch:    ThreadItem := Board.GetArchiveThread(Item.Index);
		gvtLive:    ThreadItem := Board.GetLiveThread(Item.Index);
		gvtUser:	ThreadItem := Board.GetUserThread(Item.Index);
	end;
	//////////////////////////////////////////////////////////////////////////

	if (ThreadItem = nil)  then Exit;

	RepStr := CustomStringReplace(ThreadItem.Title, '&lt;', '<' );
	RepStr := CustomStringReplace(RepStr, '&gt;', '>' );
	RepStr := CustomStringReplace(RepStr, '&quot;', '"' );
	RepStr := CustomStringReplace(RepStr, '&amp;', '&' );
	//RepStr := StringReplace(RepStr, '＠｀', ',', [rfReplaceAll]);

    if (ThreadNgList.IsNG(RepStr) = True) then
        RepStr := '＜あぼ～ん＞'
    else if (GikoSys.Setting.ThreadTitleTrim = True) then
        RepStr := GikoSys.TrimThreadTitle(RepStr);

	if Item.SubItems.Count <> ListView.Columns.Count then begin
		Item.SubItems.Clear;
		Item.SubItems.Capacity := GikoSys.Setting.BoardColumnOrder.Count;
		for i := GikoSys.Setting.BoardColumnOrder.Count - 1 downto 1 do
			Item.SubItems.Add('');
	end;

	if GikoDM.ListNumberVisibleAction.Checked then
		Item.Caption := IntToStr(ThreadItem.No) + ': ' + RepStr
	else
		Item.Caption := RepStr;

	case ThreadItem.AgeSage of
		gasNone: Item.StateIndex := -1;
		gasNew:	Item.StateIndex := 0;
		gasAge:	Item.StateIndex := 1;
		gasSage: Item.StateIndex := 2;
		gasArch: Item.StateIndex := 3;
	end;

	if ThreadItem.IsLogFile then begin
		DrawItemLogThread(ThreadItem, Item, ListView.Columns.Count);
	end else begin
		DrawItemNoLogThread(ThreadItem, Item, GikoSys.Setting.BoardColumnOrder.Count);
	end;

	Item.Data := ThreadItem;
end;
//! ログ有りスレッドを描画する
class procedure TListViewUtils.DrawItemLogThread(Thread: TThreadItem; Item: TListItem; ColumnCount: Integer);
var
	i, idx : Integer;
	spanday: Double;
begin
	idx := 0;
	for i := 0 to ColumnCount - 1 do begin
		if GikoSys.Setting.BoardColumnOrder.Count <= i then
			Break;

		case GikoSys.Setting.BoardColumnOrder[ i ] of
		gbcTitle:
			// Item.Caption は SubItems に含まれ無いので
			Dec( idx );
		gbcAllCount:
			Item.SubItems[ idx ] := IntToStr(Thread.AllResCount);
		gbcLocalCount:
			Item.SubItems[ idx ] := IntToStr(Thread.Count);
		gbcNonAcqCount:
			Item.SubItems[ idx ] := IntToStr(Thread.AllResCount - Thread.Count);
		gbcNewCount:
			if Thread.NewResCount = 0 then
				Item.SubItems[ idx ] := ''
			else
				Item.SubItems[ idx ] := IntToStr(Thread.NewResCount);
		gbcUnReadCount:
			Item.SubItems[ idx ] := '';
		gbcRoundName:
			if Thread.Round then
				Item.SubItems[ idx ] := Thread.RoundName
			else
				Item.SubItems[ idx ] := '';
		gbcRoundDate://gbcLastModified:
			if (Thread.RoundDate = ZERO_DATE)  then begin
				Item.SubItems[ idx ] := '';
			end else
				Item.SubItems[ idx ] := FormatDateTime('yyyy/mm/dd hh:mm:ss', Thread.RoundDate);
		gbcCreated:
			if Thread.CreateDate = ZERO_DATE then begin
				Item.SubItems[ idx ] := '';
			end else
				Item.SubItems[ idx ] := FormatDateTime('yyyy/mm/dd hh:mm:ss', Thread.CreateDate);
		gbcLastModified:
			if (Thread.LastModified = ZERO_DATE)  then begin
				Item.SubItems[ idx ] := '';
			end else
				Item.SubItems[ idx ] := FormatDateTime('yyyy/mm/dd hh:mm:ss', Thread.LastModified);
		gbcVigor:
			begin
				if (Thread.CreateDate <> ZERO_DATE)  then begin
					if (Thread.AgeSage <> gasArch) then begin
						spanday := DaySpan(Sort.GetSortDate, Thread.CreateDate);
					end else begin
						spanday := DaySpan(Thread.LastModified, Thread.CreateDate);
					end;
					if (spanday > 0) then begin
						Item.SubItems[ idx ] := Format('%f', [Thread.AllResCount / spanday]);
					end else begin
						Item.SubItems[ idx ] := '';
					end;
				end else begin
					Item.SubItems[ idx ] := '';
				end;
			end;
		end;
		Inc( idx );
	end;

	if Thread.NewArrival then
		Item.ImageIndex := ITEM_ICON_THREADNEW1
	else
		Item.ImageIndex := ITEM_ICON_THREADLOG1;
end;
//! ログなしスレッドを描画する
class procedure TListViewUtils.DrawItemNoLogThread(Thread: TThreadItem; Item: TListItem; ColumnCount: Integer);
var
	i, idx: Integer;
	spanday: Double;
begin
	idx := 0;
	for i := 0 to ColumnCount - 1do begin
		case GikoSys.Setting.BoardColumnOrder[ i ] of
		gbcTitle:
			// Item.Caption は SubItems に含まれ無いので
			Dec( idx );
		gbcAllCount:
			Item.SubItems[ idx ] := IntToStr(Thread.AllResCount);
		gbcRoundDate://gbcLastModified:
			Item.SubItems[ idx ] := '';
		gbcCreated:
			if Thread.CreateDate = ZERO_DATE then begin
				Item.SubItems[ idx ] := '';
			end else
				Item.SubItems[ idx ] := FormatDateTime('yyyy/mm/dd hh:mm:ss', Thread.CreateDate);
		gbcLastModified:
			Item.SubItems[ idx ] := '';
		gbcVigor:
			begin
				if (Thread.CreateDate <> ZERO_DATE)  then begin
					if (Thread.AgeSage <> gasArch) then begin
						spanday := DaySpan(Sort.GetSortDate, Thread.CreateDate);
					end else begin
						spanday := DaySpan(Thread.LastModified, Thread.CreateDate);
					end;

					if (spanday > 0) then begin
						Item.SubItems[ idx ] := Format('%f', [Thread.AllResCount / spanday]);
					end else begin
						Item.SubItems[ idx ] := '';
					end;
				end else begin
					Item.SubItems[ idx ] := '';
				end;
			end;
		else
			Item.SubItems[ idx ] := '';
		end;

		Inc( idx );
	end;
	if Thread.NewArrival then
		Item.ImageIndex := ITEM_ICON_THREADNEW1
	else
		Item.ImageIndex := ITEM_ICON_THREAD1;
end;

end.
