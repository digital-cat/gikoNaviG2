unit FavoriteArrange;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, StdCtrls, ExtCtrls, Favorite, ImgList, NewFavoriteFolder,
	GikoSystem, GikoUtil, Menus, TntComCtrls, WideCtrls;

type
  TFavoriteArrangeDialog = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    DeleteButton: TButton;
    RenameButton: TButton;
    NewFolderButton: TButton;
    FolderTreeView: TTreeView;
    Panel4: TPanel;
    CloseButton: TButton;
    SortPopupMenu: TPopupMenu;
    SortAscName: TMenuItem;
    SortDscName: TMenuItem;
    N1: TMenuItem;
    SortURL: TMenuItem;
    SortAscURL: TMenuItem;
    SortDscURL: TMenuItem;
    SortTitle: TMenuItem;
    SortAscTitle: TMenuItem;
    SortDscTitle: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewFolderButtonClick(Sender: TObject);
    procedure RenameButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FolderTreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure FolderTreeViewDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
		procedure FolderTreeViewDragDrop(Sender, Source: TObject; X,
			Y: Integer);
		procedure FormDestroy(Sender: TObject);
    procedure SortDscNameClick(Sender: TObject);
    procedure SortAscNameClick(Sender: TObject);
    procedure SortDscURLClick(Sender: TObject);
    procedure SortAscURLClick(Sender: TObject);
    procedure SortDscTitleClick(Sender: TObject);
    procedure SortAscTitleClick(Sender: TObject);
	private
		{ Private 宣言 }
		FDeleteList: TList;
    FolderTreeViewUC: TTntTreeView;
		procedure SetDeleteItemList(Node: TTntTreeNode);
    procedure FolderTreeViewUCEdited(Sender: TObject; Node: TTntTreeNode;
      var S: WideString);
	public
		{ Public 宣言 }
	end;

var
	FavoriteArrangeDialog: TFavoriteArrangeDialog;

function SortProc(Node1, Node2: TTntTreeNode; Data: Longint): Integer; stdcall;

implementation

uses Giko;

const
    SORT_ASC    = 0;
    SORT_DSC    = 1;
    SORT_NAME   = 8;
    SORT_URL    = 16;
    SORT_TITLE  = 32;

{$R *.dfm}

procedure TFavoriteArrangeDialog.CloseButtonClick(Sender: TObject);
begin
	Close;
end;

procedure TFavoriteArrangeDialog.FormCreate(Sender: TObject);
var
	CenterForm: TCustomForm;
begin
  CenterForm := TCustomForm(Owner);
  if Assigned(CenterForm) then begin
    Left := ((CenterForm.Width - Width) div 2) + CenterForm.Left;
    Top := ((CenterForm.Height - Height) div 2) + CenterForm.Top;
  end else begin
    Left := (Screen.Width - Width) div 2;
    Top := (Screen.Height - Height) div 2;
  end;

	// Unicode版に差し替え
	FolderTreeViewUC := TTntTreeView.Create(Self);
  FolderTreeViewUC.Parent        := FolderTreeView.Parent;
  FolderTreeViewUC.Align         := FolderTreeView.Align;
  FolderTreeViewUC.Left          := FolderTreeView.Left;
  FolderTreeViewUC.Top           := FolderTreeView.Top;
  FolderTreeViewUC.Width         := FolderTreeView.Width;
  FolderTreeViewUC.Height        := FolderTreeView.Height;
  FolderTreeViewUC.DragCursor    := FolderTreeView.DragCursor;
  FolderTreeViewUC.DragMode      := FolderTreeView.DragMode;
  FolderTreeViewUC.HideSelection := FolderTreeView.HideSelection;
  FolderTreeViewUC.Images        := FolderTreeView.Images;
  FolderTreeViewUC.Indent        := FolderTreeView.Indent;
  FolderTreeViewUC.PopupMenu     := FolderTreeView.PopupMenu;
  FolderTreeViewUC.ReadOnly      := FolderTreeView.ReadOnly;
  FolderTreeViewUC.ShowRoot      := FolderTreeView.ShowRoot;
  FolderTreeViewUC.TabOrder      := FolderTreeView.TabOrder;
  FolderTreeViewUC.OnDragDrop    := FolderTreeView.OnDragDrop;
  FolderTreeViewUC.OnDragOver    := FolderTreeView.OnDragOver;
  FolderTreeViewUC.OnEdited      := FolderTreeViewUCEdited;
  FolderTreeView.Visible         := False;
	//--------

	FDeleteList := TList.Create;
	FolderTreeViewUC.Items := FavoriteDM.TreeView.Items;

	if FolderTreeViewUC.Items.GetFirstNode <> nil then begin
		FolderTreeViewUC.Items.GetFirstNode.Expanded := True;
		FolderTreeViewUC.Items.GetFirstNode.Selected := True;
	end;
end;

procedure TFavoriteArrangeDialog.NewFolderButtonClick(Sender: TObject);
var
	Dlg: TNewFavoriteFolderDialog;
	NewFavFolder: TFavoriteFolder;
	Node: TTntTreeNode;
begin
	if FolderTreeViewUC.Selected = nil then
		Exit;
	Dlg := TNewFavoriteFolderDialog.Create(Self);
	try
		Dlg.ShowModal;
		if Dlg.ModalResult = mrOK then begin
			if Length(Dlg.FolderEdit.Text) = 0 then
				Exit;
			if not (TObject(FolderTreeViewUC.Selected.Data) is TFavoriteFolder) then
				FolderTreeViewUC.Selected := FolderTreeViewUC.Selected.Parent;

			NewFavFolder := TFavoriteFolder.Create;
			Node := FolderTreeViewUC.Items.AddChildObject(FolderTreeViewUC.Selected, Dlg.FolderEdit.Text, NewFavFolder);
			Node.ImageIndex := 14;
			Node.SelectedIndex := 14;
//			FolderTreeView.Selected.Expanded := True;
			FolderTreeViewUC.Selected := Node;
		end;
	finally
		Dlg.Release;
	end;
end;

procedure TFavoriteArrangeDialog.RenameButtonClick(Sender: TObject);
begin
	if FolderTreeViewUC.Selected = nil then
		Exit;
	if FolderTreeViewUC.Selected.IsFirstNode then
		Exit;
	if FolderTreeViewUC.Selected.Text = Favorite.FAVORITE_LINK_NAME then
		Exit;
	FolderTreeViewUC.ReadOnly := False;
	FolderTreeViewUC.Selected.EditText;
end;

procedure TFavoriteArrangeDialog.DeleteButtonClick(Sender: TObject);
const
	DEL_LINK_MSG = '“リンク”はリンクバー用フォルダです。削除してよろしいですか？';
	DEL_MSG = '“^0”を削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
var
  Text: WideString;
  Idx: Integer;
begin
	if FolderTreeViewUC.Selected = nil then
		Exit;
	if FolderTreeViewUC.Selected.IsFirstNode then
		Exit;
	if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then begin
		if FolderTreeViewUC.Selected.Text = Favorite.FAVORITE_LINK_NAME then begin
			if MsgBox(Handle, DEL_LINK_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
				Exit;
		end else begin
    	Text := DEL_MSG;
      Idx := Pos('^0', Text);
      Delete(Text, Idx, 2);
      Insert(FolderTreeViewUC.Selected.Text, Text, Idx);
			if MsgBox(Handle, Text, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
				Exit;
		end;
	end;

	FDeleteList.Add(FolderTreeViewUC.Selected.Data);
	SetDeleteItemList(FolderTreeViewUC.Selected);

	FolderTreeViewUC.Selected.Delete;
end;

procedure TFavoriteArrangeDialog.FolderTreeViewEdited(Sender: TObject;
	Node: TTreeNode; var S: String);
begin
	FolderTreeView.ReadOnly := True;
end;

procedure TFavoriteArrangeDialog.FolderTreeViewUCEdited(Sender: TObject;
	Node: TTntTreeNode; var S: WideString);
begin
	FolderTreeViewUC.ReadOnly := True;
end;

procedure TFavoriteArrangeDialog.FolderTreeViewDragOver(Sender,
	Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
	if Source = FolderTreeViewUC then begin
		if FolderTreeViewUC.Selected = FolderTreeViewUC.Items.GetFirstNode then begin
			Accept := False;
			Exit;
		end;
		Accept := True;
	end else
		Accept := False;
end;

procedure TFavoriteArrangeDialog.FolderTreeViewDragDrop(Sender,
	Source: TObject; X, Y: Integer);
begin
	if FolderTreeViewUC.GetNodeAt(X, Y) = nil then
		Exit;
	if Source <> FolderTreeViewUC then
		Exit;
	if FolderTreeViewUC.Selected = FolderTreeViewUC.GetNodeAt(X, Y) then
		Exit;

	if TObject(FolderTreeViewUC.GetNodeAt(X, Y).Data) is TFavoriteFolder then
		FolderTreeViewUC.Selected.MoveTo(FolderTreeViewUC.GetNodeAt(X, Y), naAddChild)
	else if TObject(FolderTreeViewUC.GetNodeAt(X, Y).Data) is TFavoriteBoardItem then
		FolderTreeViewUC.Selected.MoveTo(FolderTreeViewUC.GetNodeAt(X, Y), naInsert)
	else if TObject(FolderTreeViewUC.GetNodeAt(X, Y).Data) is TFavoriteThreadItem then
		FolderTreeViewUC.Selected.MoveTo(FolderTreeViewUC.GetNodeAt(X, Y), naInsert);
end;

procedure TFavoriteArrangeDialog.FormDestroy(Sender: TObject);
var
	i: Integer;
begin
	FavoriteDM.TreeView.Items := FolderTreeViewUC.Items;

	for i := FDeleteList.Count - 1 downto 0 do
		TObject(FDeleteList[i]).Free;
    FDeleteList.Free;
	FavoriteDM.WriteFavorite;
end;

procedure TFavoriteArrangeDialog.SetDeleteItemList(Node: TTntTreeNode);
var
	i: Integer;
begin
	for i := 0 to Node.Count - 1 do begin
		FDeleteList.Add(Node.Item[i].Data);
		if Node.Item[i].Count > 0 then
			SetDeleteItemList(Node.item[i]);
	end;
end;
{
\brief  ツリーのソート処理
\pram   Node1   ノード
\param  Node2   ノード
\param  Data    ソートオプション
\return Node1(>0) Node1=Node2(=0)  Node2(<0)
}
function SortProc(Node1, Node2: TTntTreeNode; Data: Longint): Integer;
stdcall;
var
    folder1, folder2 : TFavoriteFolder;
    item1, item2 : TFavoriteItem;
begin
    if (TObject(Node1.Data) is TFavoriteItem) then begin
        item1 := TFavoriteItem(Node1.Data);
        folder1 := nil;
    end else begin
        item1 := nil;
        folder1 := TFavoriteFolder(Node1.Data);
    end;
    if (TObject(Node2.Data) is TFavoriteItem) then begin
        item2 := TFavoriteItem(Node2.Data);
        folder2 := nil;
    end else begin
        item2 := nil;
        folder2 := TFavoriteFolder(Node2.Data);
    end;

    if (folder1 <> nil) and (folder2 = nil) then begin
        Result := 1;
    end else
    if (folder1 = nil) and (folder2 <> nil) then begin
        Result := -1;
    end else begin
        Result := 0;
        if (folder1 <> nil) and (folder2 <> nil) then begin
            Result := WideCompareStr(Node1.Text, Node2.Text);
        end else
        if (folder1 = nil) and (folder2 = nil) then begin
            if ((Data and SORT_NAME) > 0) then begin
                Result := WideCompareStr(Node1.Text, Node2.Text);
            end else
            if ((Data and SORT_URL) > 0) then begin
                Result := CompareStr(item1.URL, item2.URL);
            end else
            if ((Data and SORT_TITLE) > 0) then begin
                Result := CompareStr(item1.Title, item2.Title);
            end;
        end;
        if ((Data and SORT_DSC) > 0) then begin
            Result := -1 * Result;
        end;
    end;
end;

{
\brief  名前の降順ソート
}
procedure TFavoriteArrangeDialog.SortDscNameClick(Sender: TObject);
begin
	if (FolderTreeViewUC.Selected <> nil) and
        (TObject(FolderTreeViewUC.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeViewUC.Selected
            .CustomSort(@SortProc, SORT_NAME or SORT_DSC, False);
    end;
end;

{
\brief  名前の昇順ソート
}
procedure TFavoriteArrangeDialog.SortAscNameClick(Sender: TObject);
begin
	if (FolderTreeViewUC.Selected <> nil) and
        (TObject(FolderTreeViewUC.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeViewUC.Selected
            .CustomSort(@SortProc, SORT_NAME or SORT_ASC, False);
    end;
end;
{
\brief  URLの降順ソート
}
procedure TFavoriteArrangeDialog.SortDscURLClick(Sender: TObject);
begin
	if (FolderTreeViewUC.Selected <> nil) and
        (TObject(FolderTreeViewUC.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeViewUC.Selected
            .CustomSort(@SortProc, SORT_URL or SORT_DSC, False);
    end;
end;
{
\brief  URLの昇順ソート
}
procedure TFavoriteArrangeDialog.SortAscURLClick(Sender: TObject);
begin
	if (FolderTreeViewUC.Selected <> nil) and
        (TObject(FolderTreeViewUC.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeViewUC.Selected
            .CustomSort(@SortProc, SORT_URL or SORT_ASC, False);
    end;
end;
{
\brief  タイトルの降順ソート
}
procedure TFavoriteArrangeDialog.SortDscTitleClick(Sender: TObject);
begin
	if (FolderTreeViewUC.Selected <> nil) and
        (TObject(FolderTreeViewUC.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeViewUC.Selected
            .CustomSort(@SortProc, SORT_TITLE or SORT_DSC, False);
    end;
end;
{
\brief  タイトルの昇順ソート
}
procedure TFavoriteArrangeDialog.SortAscTitleClick(Sender: TObject);
begin
	if (FolderTreeViewUC.Selected <> nil) and
        (TObject(FolderTreeViewUC.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeViewUC.Selected
            .CustomSort(@SortProc, SORT_TITLE or SORT_ASC, False);
    end;
end;

end.

