unit FavoriteAdd;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, StdCtrls, Favorite, ImgList, BoardGroup, NewFavoriteFolder,
  TntComCtrls, WideCtrls;

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
    procedure FormDestroy(Sender: TObject);
	private
		{ Private 宣言 }
		FBoard: TBoard;
		FThreadItem: TThreadItem;
		FolderTreeViewUC: TTntTreeView;
    NameEditUC: TWideEdit;
		CaptionEditUC: TWideEdit;
		procedure CopyTree( dst, src : TTntTreeNode );
//		procedure PrepareFavoriteTree(Favo: TFavoriteItem; Node: TTreeNode);
		function GetGikoFavoriteNode(FavFolder: TFavoriteFolder): TTntTreeNode;
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

procedure TFavoriteAddDialog.CopyTree( dst, src : TTntTreeNode );
var
	newNode	: TTntTreeNode;
begin
	while src <> nil do begin
		if TObject( src.Data ) is TFavoriteFolder then begin
			newNode := FolderTreeViewUC.Items.AddChildObject( dst, src.Text, src.Data );
			newNode.ImageIndex		:= src.ImageIndex;
			newNode.SelectedIndex	:= src.SelectedIndex;
			CopyTree( newNode, src.getFirstChild );
		end;
		src := src.getNextSibling;
	end;
end;

procedure TFavoriteAddDialog.FormCreate(Sender: TObject);
var
	src		: TTntTreeNode;
	node	: TTntTreeNode;
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

  // TreeViewをUnicode版に差し替え
	FolderTreeViewUC := TTntTreeView.Create(Self);
  FolderTreeViewUC.Parent        := FolderTreeView.Parent;
  FolderTreeViewUC.Left          := FolderTreeView.Left;
  FolderTreeViewUC.Top           := FolderTreeView.Top;
  FolderTreeViewUC.Width         := FolderTreeView.Width;
  FolderTreeViewUC.Height        := FolderTreeView.Height;
  FolderTreeViewUC.HideSelection := FolderTreeView.HideSelection;
  FolderTreeViewUC.Images        := FolderTreeView.Images;
  FolderTreeViewUC.Indent        := FolderTreeView.Indent;
  FolderTreeViewUC.ReadOnly      := FolderTreeView.ReadOnly;
  FolderTreeViewUC.ShowRoot      := FolderTreeView.ShowRoot;
  FolderTreeViewUC.TabOrder      := FolderTreeView.TabOrder;
	FolderTreeView.Visible         := False;
	// スレッド名エディットボックスをUnicode版に差し替え
	NameEditUC := TWideEdit.Create(Self);
  NameEditUC.Parent      := NameEdit.Parent;
  NameEditUC.Left        := NameEdit.Left;
  NameEditUC.Top         := NameEdit.Top;
  NameEditUC.Width       := NameEdit.Width;
  NameEditUC.Height      := NameEdit.Height;
  NameEditUC.TabOrder    := NameEdit.TabOrder;
  NameEditUC.TabStop     := NameEdit.TabStop;
  NameEditUC.ReadOnly    := NameEdit.ReadOnly;
  NameEditUC.Color       := NameEdit.Color;
  NameEdit.Visible       := False;
	// 表示名エディットボックスをUnicode版に差し替え
	CaptionEditUC := TWideEdit.Create(Self);
  CaptionEditUC.Parent   := CaptionEdit.Parent;
  CaptionEditUC.Left     := CaptionEdit.Left;
  CaptionEditUC.Top      := CaptionEdit.Top;
  CaptionEditUC.Width    := CaptionEdit.Width;
  CaptionEditUC.Height   := CaptionEdit.Height;
  CaptionEditUC.TabOrder := CaptionEdit.TabOrder;
  CaptionEdit.Visible    := False;
	//------------

	FolderTreeViewUC.Items.BeginUpdate;

	// FavoriteDM のフォルダ階層をコピー
	FolderTreeViewUC.Items.Clear;
	src		:= FavoriteDM.TreeView.Items.GetFirstNode;
	node	:= TTntTreeNode.Create( FolderTreeViewUC.Items );
	node := FolderTreeViewUC.Items.AddFirst( node, src.Text );
	node.Data						:= src.Data;
	node.ImageIndex			:= src.ImageIndex;
	node.SelectedIndex	:= src.SelectedIndex;
	CopyTree( node, src.getFirstChild );

	if FolderTreeViewUC.Items.GetFirstNode <> nil then begin
		FolderTreeViewUC.Items.GetFirstNode.Expanded := True;
		FolderTreeViewUC.Items.GetFirstNode.Selected := True;
	end;
	FolderTreeViewUC.Items.EndUpdate;

{	Node := FolderTreeView.Items.AddChild(nil, GikoForm.Favorite.Root.Title);
	Node.ImageIndex := 0;
	Node.Data := GikoForm.Favorite.Root;
	PrepareFavoriteTree(GikoForm.Favorite.Root, Node);
	Node.Expanded := True;
	Node.Selected := True;}
end;


procedure TFavoriteAddDialog.FormDestroy(Sender: TObject);
begin
	try
    FolderTreeViewUC.Free;
    NameEditUC.Free;
		CaptionEditUC.Free;
  except
  end;
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
	Node						: TTntTreeNode;
	NewNode					: TTntTreeNode;
	FavoBoardItem		: TFavoriteBoardItem;
	FavoThreadItem	: TFavoriteThreadItem;
	FavNode					: TTntTreeNode;
begin
	if FolderTreeViewUC.Selected = nil then
		Exit;

	Node		:= FolderTreeViewUC.Items.GetFirstNode;
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

	FavNode := GetGikoFavoriteNode(FolderTreeViewUC.Selected.Data);
	if FavNode <> nil then begin
		if FBoard <> nil then begin
			FavoBoardItem := TFavoriteBoardItem.Create( FBoard.URL, FBoard.Title, FBoard );
			NewNode := FavoriteDM.TreeView.Items.AddChildObject(FavNode, CaptionEditUC.Text, FavoBoardItem);
			NewNode.ImageIndex := 15;
			NewNode.SelectedIndex := 15;
		end else if FThreadItem <> nil then begin
			FavoThreadItem := TFavoriteThreadItem.Create( FThreadItem.URL, FThreadItem.Title, FThreadItem );
			NewNode := FavoriteDM.TreeView.Items.AddChildObject(FavNode, CaptionEditUC.Text, FavoThreadItem);
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
	Node: TTntTreeNode;
	FavFolder: TFavoriteFolder;
begin
	if FolderTreeViewUC.Selected = nil then
		Exit;

	Dlg := TNewFavoriteFolderDialog.Create(Self);
	try
		Dlg.ShowModal;
		if Dlg.ModalResult = mrOK then begin
			if Length(Dlg.FolderEdit.Text) = 0 then
				Exit;
			FavFolder := TFavoriteFolder.Create;
			Node := FolderTreeViewUC.Items.AddChildObject(FolderTreeViewUC.Selected, Dlg.FolderEdit.Text, FavFolder);
			Node.ImageIndex := 14;
			Node.SelectedIndex := 14;
			FolderTreeViewUC.Selected := Node;
		end;
	finally
		Dlg.Free;
	end;
end;

procedure TFavoriteAddDialog.SetBoard(Board: TBoard);
begin
	FBoard := Board;
	if Board = nil then Exit;

	NameEditUC.Text := Board.Title;
	CaptionEditUC.Text := Board.Title;
	TitleLabel.Caption := 'この板がお気に入りに追加されます';
	NameLabel.Caption := '板名:';
end;

procedure TFavoriteAddDialog.SetThreadItem(ThreadItem: TThreadItem);
begin
	FThreadItem := ThreadItem;
	if ThreadItem = nil then Exit;

	NameEditUC.EncodeText := ThreadItem.Title;
	CaptionEditUC.EncodeText := ThreadItem.Title;
	TitleLabel.Caption := 'このスレッドがお気に入りに追加されます';
	NameLabel.Caption := 'スレッド名:';
end;

function TFavoriteAddDialog.GetGikoFavoriteNode(FavFolder: TFavoriteFolder): TTntTreeNode;
var
	Node	: TTntTreeNode;
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
