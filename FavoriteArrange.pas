unit FavoriteArrange;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, StdCtrls, ExtCtrls, Favorite, ImgList, NewFavoriteFolder,
	GikoSystem, GikoUtil, Menus;

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
		procedure SetDeleteItemList(Node: TTreeNode);
	public
		{ Public 宣言 }
	end;

var
	FavoriteArrangeDialog: TFavoriteArrangeDialog;

function SortProc(Node1, Node2: TTreeNode; Data: Longint): Integer; stdcall;

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

	FDeleteList := TList.Create;
	FolderTreeView.Items := FavoriteDM.TreeView.Items;

	if FolderTreeView.Items.GetFirstNode <> nil then begin
		FolderTreeView.Items.GetFirstNode.Expanded := True;
		FolderTreeView.Items.GetFirstNode.Selected := True;
	end;
end;

procedure TFavoriteArrangeDialog.NewFolderButtonClick(Sender: TObject);
var
	Dlg: TNewFavoriteFolderDialog;
	NewFavFolder: TFavoriteFolder;
	Node: TTreeNode;
begin
	if FolderTreeView.Selected = nil then
		Exit;
	Dlg := TNewFavoriteFolderDialog.Create(Self);
	try
		Dlg.ShowModal;
		if Dlg.ModalResult = mrOK then begin
			if Length(Dlg.FolderEdit.Text) = 0 then
				Exit;
			if not (TObject(FolderTreeView.Selected.Data) is TFavoriteFolder) then
				FolderTreeView.Selected := FolderTreeView.Selected.Parent;

			NewFavFolder := TFavoriteFolder.Create;
			Node := FolderTreeView.Items.AddChildObject(FolderTreeView.Selected, Dlg.FolderEdit.Text, NewFavFolder);
			Node.ImageIndex := 14;
			Node.SelectedIndex := 14;
//			FolderTreeView.Selected.Expanded := True;
			FolderTreeView.Selected := Node;
		end;
	finally
		Dlg.Release;
	end;
end;

procedure TFavoriteArrangeDialog.RenameButtonClick(Sender: TObject);
begin
	if FolderTreeView.Selected = nil then
		Exit;
	if FolderTreeView.Selected.IsFirstNode then
		Exit;
	if FolderTreeView.Selected.Text = Favorite.FAVORITE_LINK_NAME then
		Exit;
	FolderTreeView.ReadOnly := False;
	FolderTreeView.Selected.EditText;
end;

procedure TFavoriteArrangeDialog.DeleteButtonClick(Sender: TObject);
const
	DEL_LINK_MSG = '“リンク”はリンクバー用フォルダです。削除してよろしいですか？';
	DEL_MSG = '“^0”を削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
begin
	if FolderTreeView.Selected = nil then
		Exit;
	if FolderTreeView.Selected.IsFirstNode then
		Exit;
	if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then begin
		if FolderTreeView.Selected.Text = Favorite.FAVORITE_LINK_NAME then begin
			if MsgBox(Handle, DEL_LINK_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
				Exit;
		end else begin
			if MsgBox(Handle, StringReplace( DEL_MSG, '^0', FolderTreeView.Selected.Text, [rfReplaceAll] ) , DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
				Exit;
		end;
	end;

	FDeleteList.Add(FolderTreeView.Selected.Data);
	SetDeleteItemList(FolderTreeView.Selected);

	FolderTreeView.Selected.Delete;
end;

procedure TFavoriteArrangeDialog.FolderTreeViewEdited(Sender: TObject;
	Node: TTreeNode; var S: String);
begin
	FolderTreeView.ReadOnly := True;
end;

procedure TFavoriteArrangeDialog.FolderTreeViewDragOver(Sender,
	Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
	if Source = FolderTreeView then begin
		if FolderTreeView.Selected = FolderTreeView.Items.GetFirstNode then begin
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
	if FolderTreeView.GetNodeAt(X, Y) = nil then
		Exit;
	if Source <> FolderTreeView then
		Exit;
	if FolderTreeView.Selected = FolderTreeView.GetNodeAt(X, Y) then
		Exit;

	if TObject(FolderTreeView.GetNodeAt(X, Y).Data) is TFavoriteFolder then
		FolderTreeView.Selected.MoveTo(FolderTreeView.GetNodeAt(X, Y), naAddChild)
	else if TObject(FolderTreeView.GetNodeAt(X, Y).Data) is TFavoriteBoardItem then
		FolderTreeView.Selected.MoveTo(FolderTreeView.GetNodeAt(X, Y), naInsert)
	else if TObject(FolderTreeView.GetNodeAt(X, Y).Data) is TFavoriteThreadItem then
		FolderTreeView.Selected.MoveTo(FolderTreeView.GetNodeAt(X, Y), naInsert);
end;

procedure TFavoriteArrangeDialog.FormDestroy(Sender: TObject);
var
	i: Integer;
begin
	FavoriteDM.TreeView.Items := FolderTreeView.Items;

	for i := FDeleteList.Count - 1 downto 0 do
		TObject(FDeleteList[i]).Free;
    FDeleteList.Free;
	FavoriteDM.WriteFavorite;
end;

procedure TFavoriteArrangeDialog.SetDeleteItemList(Node: TTreeNode);
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
function SortProc(Node1, Node2: TTreeNode; Data: Longint): Integer;
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
            Result := CompareStr(Node1.Text, Node2.Text);
        end else
        if (folder1 = nil) and (folder2 = nil) then begin
            if ((Data and SORT_NAME) > 0) then begin
                Result := CompareStr(Node1.Text, Node2.Text);
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
	if (FolderTreeView.Selected <> nil) and
        (TObject(FolderTreeView.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeView.Selected
            .CustomSort(@SortProc, SORT_NAME or SORT_DSC, False);
    end;
end;

{
\brief  名前の昇順ソート
}
procedure TFavoriteArrangeDialog.SortAscNameClick(Sender: TObject);
begin
	if (FolderTreeView.Selected <> nil) and
        (TObject(FolderTreeView.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeView.Selected
            .CustomSort(@SortProc, SORT_NAME or SORT_ASC, False);
    end;
end;
{
\brief  URLの降順ソート
}
procedure TFavoriteArrangeDialog.SortDscURLClick(Sender: TObject);
begin
	if (FolderTreeView.Selected <> nil) and
        (TObject(FolderTreeView.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeView.Selected
            .CustomSort(@SortProc, SORT_URL or SORT_DSC, False);
    end;
end;
{
\brief  URLの昇順ソート
}
procedure TFavoriteArrangeDialog.SortAscURLClick(Sender: TObject);
begin
	if (FolderTreeView.Selected <> nil) and
        (TObject(FolderTreeView.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeView.Selected
            .CustomSort(@SortProc, SORT_URL or SORT_ASC, False);
    end;
end;
{
\brief  タイトルの降順ソート
}
procedure TFavoriteArrangeDialog.SortDscTitleClick(Sender: TObject);
begin
	if (FolderTreeView.Selected <> nil) and
        (TObject(FolderTreeView.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeView.Selected
            .CustomSort(@SortProc, SORT_TITLE or SORT_DSC, False);
    end;
end;
{
\brief  タイトルの昇順ソート
}
procedure TFavoriteArrangeDialog.SortAscTitleClick(Sender: TObject);
begin
	if (FolderTreeView.Selected <> nil) and
        (TObject(FolderTreeView.Selected.Data) is TFavoriteFolder) then begin
        FolderTreeView.Selected
            .CustomSort(@SortProc, SORT_TITLE or SORT_ASC, False);
    end;
end;

end.

