unit FavoriteAdd;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, StdCtrls, Favorite, ImgList, BoardGroup, NewFavoriteFolder;

type
	TFavoriteAddDialog = class(TForm)
    TitleLabel: TLabel;
    NameLabel: TLabel;
		Label3: TLabel;
    NameEdit: TEdit;
		CaptionEdit: TEdit;
		OKButton: TButton;
		CancelButton: TButton;
		NewFolderButton: TButton;
		FolderTreeView: TTreeView;
		Label4: TLabel;
		procedure FormCreate(Sender: TObject);
		procedure OKButtonClick(Sender: TObject);
		procedure CancelButtonClick(Sender: TObject);
		procedure NewFolderButtonClick(Sender: TObject);
	private
		{ Private 宣言 }
		FBoard: TBoard;
		FThreadItem: TThreadItem;
		procedure CopyTree( dst, src : TTreeNode );
//		procedure PrepareFavoriteTree(Favo: TFavoriteItem; Node: TTreeNode);
		function GetGikoFavoriteNode(FavFolder: TFavoriteFolder): TTreeNode;
	public
		{ Public 宣言 }
		procedure SetBoard(Board: TBoard);
		procedure SetThreadItem(ThreadItem: TThreadItem);
	end;

var
	FavoriteAddDialog: TFavoriteAddDialog;

implementation

uses Giko;

{$R *.dfm}

procedure TFavoriteAddDialog.CopyTree( dst, src : TTreeNode );
var
	newNode	: TTreeNode;
begin
	while src <> nil do begin
		if TObject( src.Data ) is TFavoriteFolder then begin
			newNode := FolderTreeView.Items.AddChildObject( dst, src.Text, src.Data );
			newNode.ImageIndex		:= src.ImageIndex;
			newNode.SelectedIndex	:= src.SelectedIndex;
			CopyTree( newNode, src.getFirstChild );
		end;
		src := src.getNextSibling;
	end;
end;

procedure TFavoriteAddDialog.FormCreate(Sender: TObject);
var
	src		: TTreeNode;
	node	: TTreeNode;
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

	FolderTreeView.Items.BeginUpdate;

	// FavoriteDM のフォルダ階層をコピー
	FolderTreeView.Items.Clear;
	src		:= FavoriteDM.TreeView.Items.GetFirstNode;
	node	:= TTreeNode.Create( FolderTreeView.Items );
	node := FolderTreeView.Items.AddFirst( node, src.Text );
	node.Data						:= src.Data;
	node.ImageIndex			:= src.ImageIndex;
	node.SelectedIndex	:= src.SelectedIndex;
	CopyTree( node, src.getFirstChild );

	if FolderTreeView.Items.GetFirstNode <> nil then begin
		FolderTreeView.Items.GetFirstNode.Expanded := True;
		FolderTreeView.Items.GetFirstNode.Selected := True;
	end;
	FolderTreeView.Items.EndUpdate;

{	Node := FolderTreeView.Items.AddChild(nil, GikoForm.Favorite.Root.Title);
	Node.ImageIndex := 0;
	Node.Data := GikoForm.Favorite.Root;
	PrepareFavoriteTree(GikoForm.Favorite.Root, Node);
	Node.Expanded := True;
	Node.Selected := True;}
end;


{procedure TFavoriteAddDialog.PrepareFavoriteTree(Favo: TFavoriteItem; Node: TTreeNode);
var
	i: Integer;
	ChildFavo: TFavoriteItem;
	ChildNode: TTreeNode;
begin
	for i := 0 to TFavoriteFolder(Favo).Count - 1 do begin

		ChildFavo := TFavoriteFolder(Favo).Items[i];
		if ChildFavo is TFavoriteFolder then begin
			ChildNode := FolderTreeView.Items.AddChild(Node, ChildFavo.Title);
			ChildNode.ImageIndex := 0;
			ChildNode.Data := ChildFavo;
			PrepareFavoriteTree(ChildFavo, ChildNode);
		end else if ChildFavo is TFavoriteBoardItem then begin
		end else if ChildFavo is TFavoriteThreadItem then begin
		end;
	end;
end;}

procedure TFavoriteAddDialog.OKButtonClick(Sender: TObject);
var
	Node						: TTreeNode;
	NewNode					: TTreeNode;
	FavoBoardItem		: TFavoriteBoardItem;
	FavoThreadItem	: TFavoriteThreadItem;
	FavNode					: TTreeNode;
begin
	if FolderTreeView.Selected = nil then
		Exit;

	Node		:= FolderTreeView.Items.GetFirstNode;
	while Node <> nil do begin
		FavNode := GetGikoFavoriteNode(Node.Data);
		if FavNode = nil then begin
			if Node.Parent <> nil then
				FavNode := GetGikoFavoriteNode(Node.Parent.Data);
			if FavNode <> nil then begin
				NewNode := FavoriteDM.TreeView.Items.AddChildObject(FavNode, Node.Text, Node.Data);
				NewNode.ImageIndex := 14;
				NewNode.SelectedIndex := 14;
			end;
		end;
		Node := Node.GetNext;
	end;

	FavNode := GetGikoFavoriteNode(FolderTreeView.Selected.Data);
	if FavNode <> nil then begin
		if FBoard <> nil then begin
			FavoBoardItem := TFavoriteBoardItem.Create( FBoard.URL, FBoard.Title, FBoard );
			NewNode := FavoriteDM.TreeView.Items.AddChildObject(FavNode, CaptionEdit.Text, FavoBoardItem);
			NewNode.ImageIndex := 15;
			NewNode.SelectedIndex := 15;
		end else if FThreadItem <> nil then begin
			FavoThreadItem := TFavoriteThreadItem.Create( FThreadItem.URL, FThreadItem.Title, FThreadItem );
			NewNode := FavoriteDM.TreeView.Items.AddChildObject(FavNode, CaptionEdit.Text, FavoThreadItem);
			NewNode.ImageIndex := 16;
			NewNode.SelectedIndex := 16;
		end;
	end;

	FavoriteDM.WriteFavorite;
	Close;
end;

procedure TFavoriteAddDialog.CancelButtonClick(Sender: TObject);
begin
	Close;
end;

procedure TFavoriteAddDialog.NewFolderButtonClick(Sender: TObject);
var
	Dlg: TNewFavoriteFolderDialog;
	Node: TTreeNode;
	FavFolder: TFavoriteFolder;
begin
	if FolderTreeView.Selected = nil then
		Exit;

	Dlg := TNewFavoriteFolderDialog.Create(Self);
	try
		Dlg.ShowModal;
		if Dlg.ModalResult = mrOK then begin
			if Length(Dlg.FolderEdit.Text) = 0 then
				Exit;
			FavFolder := TFavoriteFolder.Create;
			Node := FolderTreeView.Items.AddChildObject(FolderTreeView.Selected, Dlg.FolderEdit.Text, FavFolder);
			Node.ImageIndex := 14;
			Node.SelectedIndex := 14;
			FolderTreeView.Selected := Node;
		end;
	finally
		Dlg.Free;
	end;
end;

procedure TFavoriteAddDialog.SetBoard(Board: TBoard);
begin
	FBoard := Board;
	if Board = nil then Exit;

	NameEdit.Text := Board.Title;
	CaptionEdit.Text := Board.Title;
	TitleLabel.Caption := 'この板がお気に入りに追加されます';
	NameLabel.Caption := '板名:';
end;

procedure TFavoriteAddDialog.SetThreadItem(ThreadItem: TThreadItem);
begin
	FThreadItem := ThreadItem;
	if ThreadItem = nil then Exit;

	NameEdit.Text := ThreadItem.Title;
	CaptionEdit.Text := ThreadItem.Title;
	TitleLabel.Caption := 'このスレッドがお気に入りに追加されます';
	NameLabel.Caption := 'スレッド名:';
end;

function TFavoriteAddDialog.GetGikoFavoriteNode(FavFolder: TFavoriteFolder): TTreeNode;
var
	Node	: TTreeNode;
begin
	Result	:= nil;
	Node		:= FavoriteDM.TreeView.Items.GetFirstNode;
	while Node <> nil do begin
		if Node.Data = FavFolder then begin
			Result := Node;
			Exit;
		end;
		Node := Node.GetNext;
	end;
end;

end.
