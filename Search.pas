unit Search;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, ExtCtrls, ComCtrls,
	BoardGroup, GikoSystem, bmRegExp, YofUtils;

type
	TSearchDialog = class(TForm)
		BoardListView: TListView;
		BoardLabel: TLabel;
		OkBotton: TButton;
		CancelBotton: TButton;
		Label1: TLabel;
		SearchComboBox: TComboBox;
		CategoryListView: TListView;
		AllReleaseButton: TButton;
		AllSelectButton: TButton;
		GroupBox1: TGroupBox;
		NameCheckBox: TCheckBox;
		MailCheckBox: TCheckBox;
		IDCheckBox: TCheckBox;
		SentenceCheckBox: TCheckBox;
		RegExpCheckBox: TCheckBox;
		GoogleCheckBox: TCheckBox;
    FuzzyCharDicCheckBox: TCheckBox;
    BoardsProgressBar: TProgressBar;
		procedure FormCreate(Sender: TObject);
		procedure CategoryListViewSelectItem(Sender: TObject; Item: TListItem;
			Selected: Boolean);
		procedure BoardListViewChange(Sender: TObject; Item: TListItem;
			Change: TItemChange);
		procedure AllSelectButtonClick(Sender: TObject);
		procedure AllReleaseButtonClick(Sender: TObject);
		procedure OkBottonClick(Sender: TObject);
		procedure BoardListViewDblClick(Sender: TObject);
		procedure CancelBottonClick(Sender: TObject);
		procedure BoardListViewResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
	private
		{ Private 宣言 }
		FChkItem: TObject;
		FRegItem: TThreadItem;
				FCancel: Boolean;
		procedure SetCategoryList;
		procedure SetBoardList(Item: TListItem);
		procedure CheckItem(Item: TObject);
		procedure OnMatch(Sender: TObject; LineInfo: RE_LineInfo_t);
		procedure SearchLogs( Reg: TGrep );
		procedure SearchLog(Reg: TGrep; Item: TThreadItem);
		function  CountBoards : Integer;
	public
		{ Public 宣言 }
//		constructor Create(AOwner: TComponent); overload; override;
		constructor Create(AOwner: TComponent; ChkItem: TObject); virtual; //overload;
	end;

var
	SearchDialog: TSearchDialog;

implementation

uses Giko;

{$R *.dfm}

{constructor TSearchDialog.Create(AOwner: TComponent);
begin
	Create(AOwner, nil);
end;}

constructor TSearchDialog.Create(AOwner: TComponent; ChkItem: TObject);
begin
	inherited Create(AOwner);
	FChkItem := ChkItem;
		FCancel := false;
end;

procedure TSearchDialog.FormCreate(Sender: TObject);
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

	SetCategoryList;
	CheckItem(FChkItem);
end;

procedure TSearchDialog.CategoryListViewSelectItem(Sender: TObject;
	Item: TListItem; Selected: Boolean);
begin
	if not Selected then Exit;
	SetBoardList(Item);
end;

procedure TSearchDialog.SetCategoryList;
var
	i, j, k: integer;
	Item: TListItem;
	bbs : TBBS;
begin
	Item := CategoryListView.Items.Add;
	Item.Caption := '（すべて）';
	Item.Data := nil;
	for k := 0 to Length( BBSs ) - 1 do begin
		bbs := BBSs[ k ];
		for i := 0 to bbs.Count - 1 do begin
			Item := CategoryListView.Items.Add;
			Item.Caption := bbs.Items[i].Title;
			Item.Data := bbs.Items[i];
			for j := 0 to bbs.Items[i].Count - 1 do
				bbs.Items[i].Items[j].BoolData := False;
		end;
	end;
end;

procedure TSearchDialog.SetBoardList(Item: TListItem);
var
	i, j, k: Integer;
	NewItem: TListItem;
	Category: TCategory;
	bbs : TBBS;
begin
	BoardListView.Clear;
	if Item.Data = nil then begin
		for k := 0 to Length( BBSs ) - 1 do begin
			bbs := BBSs[ k ];
			for i := 0 to bbs.Count - 1 do begin
				Category := bbs.Items[i];
				for j := 0 to Category.Count - 1 do begin
					NewItem := BoardListView.Items.Add;
					NewItem.Caption := Category.Items[j].Title;
					NewItem.Checked := Category.Items[j].BoolData;
					NewItem.Data := Category.Items[j];
				end;
			end;
		end;
	end else if TObject(Item.Data) is TCategory then begin
		Category := TCategory(Item.Data);
		for i := 0 to Category.Count - 1 do begin
			NewItem := BoardListView.Items.Add;
			NewItem.Caption := Category.Items[i].Title;
			NewItem.Checked := Category.Items[i].BoolData;
			NewItem.Data := Category.Items[i];
		end;
	end;
end;

procedure TSearchDialog.CheckItem(Item: TObject);
var
	i: Integer;
	Category: TCategory;
	Board: TBoard;
begin
	if Item is TCategory then begin
		Category := TCategory(Item);
		for i := 0 to CategoryListView.Items.Count - 1 do begin
			if TObject(CategoryListView.Items[i].Data) is TCategory then
				if TCategory(CategoryListView.Items[i].Data) = Category then begin
					CategoryListView.Items[i].Selected := True;
					CategoryListView.Items[i].MakeVisible(False);
				end;
		end;
		AllSelectButtonClick( nil );
	end else if Item is TBoard then begin
		Board := TBoard(Item);
		Category := Board.ParentCategory;
		Board.BoolData := True;
		for i := 0 to CategoryListView.Items.Count - 1 do begin
			if TObject(CategoryListView.Items[i].Data) is TCategory then begin
				if TCategory(CategoryListView.Items[i].Data) = Category then begin
					CategoryListView.Items[i].Selected := True;
					CategoryListView.Items[i].MakeVisible(False);
				end;
			end;
		end;
	end else begin
		// 「(すべて)」にチェック
		CategoryListView.Items[0].Selected := True;
		CategoryListView.Items[0].MakeVisible(False);
		AllSelectButtonClick( nil );
	end;
end;

procedure TSearchDialog.BoardListViewChange(Sender: TObject;
	Item: TListItem; Change: TItemChange);
var
	Board: TBoard;
begin
	if TObject(Item.Data) is TBoard then begin
		Board := TBoard(Item.Data);
		Board.BoolData := Item.Checked;
	end;
end;

procedure TSearchDialog.AllSelectButtonClick(Sender: TObject);
var
	i: Integer;
	//Board: TBoard;
begin
	for i := 0 to BoardListView.Items.Count - 1 do begin
		if TObject(BoardListView.Items[i].Data) is TBoard then begin
			//Board := TBoard(BoardListView.Items[i].Data);
			BoardListView.Items[i].Checked := True;
		end;
	end;
end;

procedure TSearchDialog.AllReleaseButtonClick(Sender: TObject);
var
	i: Integer;
	//Board: TBoard;
begin
	for i := 0 to BoardListView.Items.Count - 1 do begin
		if TObject(BoardListView.Items[i].Data) is TBoard then begin
			//Board := TBoard(BoardListView.Items[i].Data);
			BoardListView.Items[i].Checked := False;
		end;
	end;
end;

procedure TSearchDialog.OnMatch(Sender: TObject; LineInfo: RE_LineInfo_t);
begin

	// 探しているファイルから見つかったのでリストに追加する
	BoardListView.AddItem( FRegItem.Title, FRegItem );
	// このファイルはもう見つけたのでこれ以上続けない
	TGrep( Sender ).Cancel := True;

end;

procedure TSearchDialog.OkBottonClick(Sender: TObject);
var
	i : Integer;
//	i, j, k, l: Integer;
//	Category: TCategory;
//	Board: TBoard;
//	ThreadItem: TThreadItem;
	List: TList;
	//sl: TStringList;
	SearchWord: string;
	Reg: TGrep;
	Filter: string;
	oldText: string;
//	bbs : TBBS;
begin
	// grep 内でイベントが拾えてしまうので、操作できないようにする
	AllSelectButton.Enabled := False;
	AllReleaseButton.Enabled := False;
	OkBotton.Enabled := False;
		CancelBotton.Enabled := true;
	FCancel := false;
	CategoryListView.Enabled := False;

	Screen.Cursor := crHourglass;
	//sl := TStringList.Create;
	List := TList.Create;

	Reg := TGrep.Create( nil );
	try
		// プログレスバーを設定して見えるようにする
		BoardsProgressBar.Max := CountBoards;
		BoardsProgressBar.Position := 0;
		BoardsProgressBar.Visible := True;

		if Length( SearchComboBox.Text ) > 0 then
		begin
			// ComboBox の内容を更新
			oldText := SearchComboBox.Text;
			i := GikoSys.Setting.SelectTextList.IndexOf( oldText );
			if i <> -1 then
				GikoSys.Setting.SelectTextList.Delete( i );
			i := SearchComboBox.Items.IndexOf( oldText );
			if i <> -1 then
				SearchComboBox.Items.Delete( i );
			GikoSys.Setting.SelectTextList.Insert( 0, oldText );
			SearchComboBox.Items.Insert( 0, oldText );
			SearchComboBox.Text := oldText;

			BoardListView.Clear;
			Application.ProcessMessages;
			// grep 用の検索ワードを生成
			Reg.OnMatch := OnMatch;
			Reg.UseFuzzyCharDic := FuzzyCharDicCheckBox.Checked;

			If RegExpCheckBox.Checked Then
				SearchWord := SearchComboBox.Text
			Else
				SearchWord := RegExpEncode( SearchComboBox.Text );

			If NameCheckBox.Checked And
				MailCheckBox.Checked And
				IDCheckBox.Checked And
				SentenceCheckBox.Checked Then
			Begin
				// 全てセットされている場合は正規表現を極力使わない
				// (正規表現を使うとかなり遅いので)
				Reg.RegExp := SearchWord;
			End Else Begin
				If NameCheckBox.Checked Then
					Filter := '.*' + SearchWord + '.*<>'
				Else
					Filter := '.*<>';
				If MailCheckBox.Checked Then
					Filter := Filter + '.*' + SearchWord + '.*<>'
				Else
					Filter := Filter + '.*<>';
				If IDCheckBox.Checked Then
					Filter := Filter + '.*' + SearchWord + '.*<>'
				Else
					Filter := Filter + '.*<>';
				If SentenceCheckBox.Checked Then
					Filter := Filter + '.*' + SearchWord + '.*<>\n'
				Else
					Filter := Filter + '.*<>\n';

				Reg.RegExp := Filter;
			End;

			// サイトの中の (続く)
			SearchLogs(Reg);
		end;
	finally
		//プログレスバーを隠す
		BoardsProgressBar.Visible := False;
		//sl.Free;
		List.Free;
		Screen.Cursor := crDefault;
		Reg.Free;

		// 操作できるように開放
		AllSelectButton.Enabled := True;
		AllReleaseButton.Enabled := True;
		OkBotton.Enabled := True;
		CategoryListView.Enabled := True;
		CancelBotton.Enabled := false;
	end;
end;
//! 選択された板のスレッドの中身を検索する
procedure TSearchDialog.SearchLogs( Reg: TGrep );
var
	i, j, k, l : Integer;
	bbs : TBBS;
	Category: TCategory;
	Board: TBoard;
begin
	// サイトの中の (続く)
	try
		// 掲示板の中の (続く)
		for l := 0 to Length( BBSs ) - 1 do begin
			bbs := BBSs[ l ];
			for i := 0 to bbs.Count - 1 do begin
				// カテゴリの中の (続く)
				Category := bbs.Items[i];
				for j := 0 to Category.Count - 1 do begin
					// 板の中の (続く)
					Board := Category.Items[j];
					if Board.BoolData then begin
						if not Board.IsThreadDatRead then
							GikoSys.ReadSubjectFile(Board);
						for k := 0 to Board.Count - 1 do begin
							// 個々のスレッドの (続く)
							SearchLog(Reg, Board.Items[k]);
						end;
						BoardsProgressBar.StepIt;
					end;

				end;
			end;
		end;
	except
		on E:Exception do ShowMessage(E.Message)
	end;
end;
//! 選択されている板の数をカウントする
function  TSearchDialog.CountBoards : Integer;
var
	i, j, l : Integer;
	bbs : TBBS;
	Category: TCategory;
	Board: TBoard;
begin
	Result := 0;
	// 掲示板の中の (続く)
	for l := 0 to Length( BBSs ) - 1 do begin
		bbs := BBSs[ l ];
		for i := 0 to bbs.Count - 1 do begin
			// カテゴリの中の (続く)
			Category := bbs.Items[i];
			for j := 0 to Category.Count - 1 do begin
				// 板の中の (続く)
				Board := Category.Items[j];
				if Board.BoolData then begin
					Inc(Result);
				end;
			end;
		end;
	end;
end;
//! 正規表現の検索にスレッドのログファイルを送る
procedure TSearchDialog.SearchLog(Reg: TGrep; Item: TThreadItem);
begin
	// ログが存在するか確認
	if (Item.IsLogFile) and (FileExists( Item.GetThreadFileName )) then begin
		try
			// 検索
			// ※見つかったら OnMatch に飛ぶ
			FRegItem := Item;
			// GrepByRegの中でApplication.ProcessMessageが大量に呼ばれている
			Reg.GrepByRegExp( Item.GetThreadFileName )
		except
		end;
		if FCancel then raise	Exception.Create('ログ検索を中止します');
	end;
end;
procedure TSearchDialog.BoardListViewDblClick(Sender: TObject);
begin
try
	If (BoardListView.Selected <> nil) and
     (TObject( BoardListView.Selected.Data ) is TThreadItem) Then
		GikoForm.InsertBrowserTab( TThreadItem(BoardListView.Selected.Data) );

	BringToFront;
except
  on e: Exception do begin
		ShowMessage(e.Message);
  end;
end;
end;

procedure TSearchDialog.CancelBottonClick(Sender: TObject);
begin
	TGrep(Sender).Cancel := true;
	FCancel := true;
end;

procedure TSearchDialog.BoardListViewResize(Sender: TObject);
begin

	BoardListView.Column[ 0 ].Width := BoardListView.ClientWidth;

end;

procedure TSearchDialog.FormDestroy(Sender: TObject);
begin
	if (BoardListView <> nil) then begin
		BoardListView.Clear;
	end;
	if (CategoryListView <> nil) then begin
		CategoryListView.Clear;
	end;
end;

procedure TSearchDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
	if (BoardsProgressBar.Visible) then begin
		TGrep(Sender).Cancel := true;
		FCancel := true;
		Application.ProcessMessages;
	end;
end;

end.
