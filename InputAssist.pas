unit InputAssist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, GikoListView, Menus, ExtCtrls, ImgList,
  InputAssistDataModule, StdActns, ActnList, GikoSystem, IniFiles;

type
  TInputAssistForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GikoListView1: TGikoListView;
    Panel3: TPanel;
	Panel4: TPanel;
	TextMemo: TMemo;
    ColumnImageList: TImageList;
    InputAssistFormActionList: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    GroupBox1: TGroupBox;
    Panel5: TPanel;
    CloseButton: TButton;
    ApplyButton: TButton;
    DeleteButton: TButton;
    AddButton: TButton;
    Panel6: TPanel;
    Panel7: TPanel;
    CategoryComboBox: TComboBox;
    CategoryComboLabel: TLabel;
    InsertButton: TButton;
    InsertButtonAction: TAction;
    CloseAction: TAction;
    KeyPanel: TPanel;
    KeyNameEdit: TLabeledEdit;
    Splitter: TSplitter;
    CategoryPanel: TPanel;
    CategoryNameComboBox: TComboBox;
    CategoryNameLabel: TLabel;
    DiffButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure GikoListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GikoListView1Compare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure GikoListView1ColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure CloseButtonClick(Sender: TObject);
    procedure CategoryComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure CategoryComboBoxChange(Sender: TObject);
    procedure InsertButtonActionUpdate(Sender: TObject);
    procedure InsertButtonActionExecute(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure DiffButtonClick(Sender: TObject);
  private
	{ Private �錾 }
	FSortColumn : Integer;
	FInsertText : String;
	procedure AddListViewItem(ResWord : TResistWord);
    procedure SetCategory(combo: TComboBox; selected: String);
    function ValidateKey(key, category: String): boolean;
  public
	{ Public �錾 }
	procedure SetUpFromEditor();
	procedure SetUpFromMain();
	function GetInsertText(): String;
  end;

var
  InputAssistForm: TInputAssistForm;

implementation

uses Setting, MojuUtils;


{$R *.dfm}
//! �t�H�[�������̃C�x���g
procedure TInputAssistForm.FormCreate(Sender: TObject);
var
	wp: TWindowPlacement;
	i : Integer;
	column: TListColumn;
begin
	//�E�B���h�E�̈ʒu�ݒ�
	wp.length := sizeof(wp);
	wp.rcNormalPosition.Top := GikoSys.Setting.InputAssistFormTop;
	wp.rcNormalPosition.Left := GikoSys.Setting.InputAssistFormLeft;

	wp.rcNormalPosition.Bottom := GikoSys.Setting.InputAssistFormTop
									+ GikoSys.Setting.InputAssistFormHeight;
	wp.rcNormalPosition.Right := GikoSys.Setting.InputAssistFormLeft
									+ GikoSys.Setting.InputAssistFormWidth;
	wp.showCmd := SW_HIDE;
	SetWindowPlacement(Handle, @wp);

	FSortColumn := 0;
	GikoListView1.Columns.Clear;
	column := GikoListView1.Columns.Add;
	column.ImageIndex := 0;
	column.Caption := '�L�[';
	column.Width := 150;
	column := GikoListView1.Columns.Add;
	column.Caption := '�J�e�S��';
	column.Width := 80;
	for i := 0 to InputAssistDM.ResistWordCount - 1 do begin
		AddListViewItem(InputAssistDM.GetResistWord(i));
	end;
	//�\�[�g��Ԃ����� (�������Ȃ��ƃA�C�e���̃L�[����ύX�ł��Ȃ�)
	InputAssistDM.Sorted := False;
end;
//! �ꗗ�ɃA�C�e����ǉ����鏈��
procedure TInputAssistForm.AddListViewItem(ResWord : TResistWord);
var
	item: TListItem;
begin
	item := GikoListView1.Items.Add;
	item.ImageIndex := -1;
	item.Caption := resWord.GetKey;
	item.SubItems.Add(resWord.GetCategory);
	item.Data := resWord;
end;
//! �o�^�P��ꗗ����A�C�e����I�������Ƃ��̃C�x���g
procedure TInputAssistForm.GikoListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
	if (Item <> nil) and (Item.Data <> nil) then begin
		KeyNameEdit.Text := TResistWord(Item.Data).GetKey;
        CategoryNameComboBox.Text := TResistWord(Item.Data).GetCategory;
		TextMemo.Lines.Text := TResistWord(Item.Data).GetText;
	end else begin
		TextMemo.Lines.Text := '';
	end;
end;
//! �ǉ��{�^���������̃C�x���g
procedure TInputAssistForm.AddButtonClick(Sender: TObject);
var
	resWord : TResistWord;
begin
	if (ValidateKey(KeyNameEdit.Text, CategoryNameComboBox.Text)) then begin
		if (not InputAssistDM.IsDupulicate(
			KeyNameEdit.Text, CategoryNameComboBox.Text) ) then begin
			resWord := InputAssistDM.Add(KeyNameEdit.Text);
			resWord.SetCategory(CategoryNameComboBox.Text);
			resWord.SetText(TextMemo.Text);
			AddListViewItem(resWord);
            SetCategory(CategoryNameComboBox, resWord.GetCategory);
			GikoListView1.AlphaSort;
		end else begin
			ShowMessage('����̃L�[���E�J�e�S�����Ŋ��ɓo�^�ς݂ł��B');
		end;
	end;
end;
//! �L�[���E�J�e�S���L���`�F�b�N
function TInputAssistForm.ValidateKey(key, category: String): boolean;
begin
    Result := True;
    if (Length(key) = 0) then begin
        ShowMessage('�L�[����ݒ肵�Ă��������B');
        Result := False;
    end else begin
        if (Length(category) = 0) then begin
            ShowMessage('�J�e�S����ݒ肵�Ă��������B');
            Result := False;
        end;
    end;
end;

//! �폜�{�^���������̃C�x���g
procedure TInputAssistForm.DeleteButtonClick(Sender: TObject);
begin
	if GikoListView1.Selected <> nil then begin
		InputAssistDM.DeleteResistWord(GikoListView1.Selected.Data);
		GikoListView1.Selected.Data := nil;
		GikoListView1.DeleteSelected;
	end;
end;
//! �K�p�{�^���������̃C�x���g
procedure TInputAssistForm.ApplyButtonClick(Sender: TObject);
var
	resWord : TResistWord;
begin
	if GikoListView1.Selected <> nil then begin
    	if (ValidateKey(KeyNameEdit.Text, CategoryNameComboBox.Text)) then begin
            resWord := TResistWord(GikoListView1.Selected.Data);
            // �ύX�O�̃L�[�^�J�e�S���Ɠ���������́A���Əd������
            if ((resWord.GetKey = KeyNameEdit.Text)
                and (resWord.GetCategory = CategoryNameComboBox.Text)) or
                (not InputAssistDM.IsDupulicate(
    			KeyNameEdit.Text, CategoryNameComboBox.Text) ) then begin
                resWord.SetCategory(CategoryNameComboBox.Text);
                resWord.SetText(TextMemo.Text);
                // �L�[���ς��Ƃ��́AChangeKey���Ă�
                if (resWord.GetKey <> KeyNameEdit.Text) then begin
       		    	resWord.SetKey(KeyNameEdit.Text);
                    InputAssistDM.ChangeKey(resWord);
                end;
		    	// �ꗗ�̍X�V
			    GikoListView1.Selected.Caption := resWord.GetKey;
    			GikoListView1.Selected.SubItems[0] := resWord.GetCategory;
                SetCategory(CategoryNameComboBox, resWord.GetCategory);
		    	GikoListView1.AlphaSort;
    		end else begin
	    		ShowMessage('����̃L�[���E�J�e�S�����Ŋ��ɓo�^�ς݂ł��B');
		    end;
		end;
	end;
end;
//! �t�H�[�������Ƃ��̃C�x���g
procedure TInputAssistForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	GikoSys.Setting.InputAssistFormTop := Self.Top;
	GikoSys.Setting.InputAssistFormLeft := Self.Left;
	GikoSys.Setting.InputAssistFormHeight := Self.Height;
	GikoSys.Setting.InputAssistFormWidth := Self.Width;
	//�\�[�g��Ԃ̐ݒ�
	InputAssistDM.Sorted := True;
end;
//! �o�^�P��ꗗ�̃\�[�g�p�̔�r����
procedure TInputAssistForm.GikoListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
	if ((FSortColumn and 2) > 0) then begin
		// �J�e�S���Ń\�[�g
		Compare := CompareStr(
			ZenToHan(Item1.SubItems[0]), ZenToHan(Item2.SubItems[0]));
		if (Compare = 0) then begin
			Compare := CompareStr(
				ZenToHan(Item1.Caption), ZenToHan(Item2.Caption));
		end;
	end else begin
		// �L�[�Ń\�[�g
		Compare := CompareStr(
			ZenToHan(Item1.Caption), ZenToHan(Item2.Caption));
		if (Compare = 0) then begin
			Compare := CompareStr(
				ZenToHan(Item1.SubItems[0]), ZenToHan(Item2.SubItems[0]));
		end;
	end;
	// �����~���̔��]
	if ((FSortColumn and 1) > 0) then begin
		Compare := Compare * -1;
	end;
	;
end;
//! �o�^�P��ꗗ�̃��X�g�̃J�����N���b�N�C�x���g
procedure TInputAssistForm.GikoListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
var
	i : Integer;
begin
	if Column <> nil then begin
		// �C���[�W�̍폜
		for i := 0 to GikoListView1.Columns.Count - 1 do begin
			GikoListView1.Column[i].ImageIndex := -1;
		end;

		// FSortColumn ����:���� ��F�~��
		if Column.Caption = '�L�[' then begin
			if FSortColumn = 0 then begin
				FSortColumn := 1;
			end else begin
				FSortColumn := 0;
			end;
		end else begin
			if FSortColumn = 2 then begin
				FSortColumn := 3;
			end else begin
				FSortColumn := 2;
			end;
		end;
		Column.ImageIndex := (FSortColumn and 1);
		GikoListView1.AlphaSort;
	end;

end;
//! �I���{�^�����������̃C�x���g
procedure TInputAssistForm.CloseButtonClick(Sender: TObject);
begin
	Close();
end;
//! �J�e�S���i���݃R���{�{�b�N�X��ǎ��p�ɂ��邽�߂̃C�x���g����
procedure TInputAssistForm.CategoryComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
	Key := #0;
end;
//! �J�e�S���i���݃R���{�{�b�N�X�ł̃J�e�S���ύX����
procedure TInputAssistForm.CategoryComboBoxChange(Sender: TObject);
var
	i : Integer;
	key : String;
begin
	LockWindowUpdate(GikoListView1.Handle);
	GikoListView1.Clear;
	if (CategoryComboBox.ItemIndex <= 0) then begin
		for i := 0 to InputAssistDM.ResistWordCount - 1 do begin
			AddListViewItem(InputAssistDM.GetResistWord(i));
		end;
	end else begin
		key := CategoryComboBox.Items[CategoryComboBox.ItemIndex];
		for i := 0 to InputAssistDM.ResistWordCount - 1 do begin
			if (key = InputAssistDM.GetResistWord(i).GetCategory) then begin
				AddListViewItem(InputAssistDM.GetResistWord(i));
			end;
		end;
	end;
	LockWindowUpdate(0);
end;
//! �J�e�S���R���{�{�b�N�X�ݒ�
procedure TInputAssistForm.SetCategory(combo: TComboBox; selected: String);
var
	cat : TStringList;
    i : Integer;
begin
	// �����p
	cat := TStringList.Create;
	try
		InputAssistDM.GetCategoryList(cat);
        combo.Items.BeginUpdate;
        combo.Items.Clear;
		combo.Items.Add('');
		combo.Items.AddStrings(cat);
		combo.ItemIndex := 0;
        combo.Items.EndUpdate;
        // �I���ς݂̃J�e�S���ɃC���f�b�N�X��ύX
        i := combo.Items.IndexOf(selected);
        if (i <> -1) then begin
            combo.ItemIndex := i;
        end;
	finally
		cat.Free;
	end;
end;

procedure TInputAssistForm.SetUpFromMain();
begin
	Self.Caption := '���̓A�V�X�g�ݒ�';
	Panel3.Visible := True;
	Panel5.Visible := True;
	Panel7.Visible := False;
	TextMemo.ReadOnly := False;
	FInsertText := '';
	CloseAction.ShortCut := TShortCut(0);
	// �ǉ��p�L�[����OK
    SetCategory(CategoryNameComboBox, '');
end;
procedure TInputAssistForm.SetUpFromEditor();
begin
	Self.Caption := '���̓A�V�X�g';
	Panel3.Visible := False;
	Panel5.Visible := False;
	Panel7.Visible := True;
	TextMemo.ReadOnly := True;
	FInsertText := '';
	CloseAction.ShortCut := ShortCut(VK_ESCAPE, []);
	// �����p
    SetCategory(CategoryComboBox, '');
end;
function TInputAssistForm.GetInsertText(): String;
begin
	Result := FInsertText;
end;

procedure TInputAssistForm.InsertButtonActionUpdate(Sender: TObject);
begin
	InsertButtonAction.Enabled := (GikoListView1.Selected <> nil);
end;

procedure TInputAssistForm.InsertButtonActionExecute(Sender: TObject);
begin
	if (GikoListView1.Selected = nil) then begin
		FInsertText := '';
		Self.ModalResult := mrNone;
	end else begin
		FInsertText :=  TResistWord(GikoListView1.Selected.Data).GetText;
		Self.ModalResult := mrOk;
	end;
end;

procedure TInputAssistForm.CloseActionExecute(Sender: TObject);
begin
	Self.ModalResult := mrCancel;
end;

procedure TInputAssistForm.DiffButtonClick(Sender: TObject);
var
	ini: TIniFile;
    DefPath: String;
    SecList: TStringList;
    KeyList: TStringList;
    Cnt: Integer;
    Cnt2: Integer;
    MaxCnt: Integer;
    MaxCnt2: Integer;
    RegCnt: Integer;
    DatString: String;
	resWord : TResistWord;
    ResMsg: String;
begin
	ini := TIniFile.Create(GikoSys.Setting.GetDefaultFilesFileName);
    DefPath := ini.ReadString('InputAssist', 'FROM', '');
    ini.Free;
    if (DefPath = '') then begin
        Application.MessageBox('default�t�@�C������`����Ă��܂���B', '�����o�^', MB_OK or MB_ICONERROR);
        Exit;
    end;

    DefPath := GikoSys.GetAppDir + DefPath;
    if (FileExists(DefPath) = False) then begin
        Application.MessageBox('default�t�@�C����������܂���B', '�����o�^', MB_OK or MB_ICONERROR);
        Exit;
    end;

    RegCnt := 0;
    SecList := TStringList.Create;
	ini := TIniFile.Create(DefPath);

    ini.ReadSections(SecList);
    if (SecList.Count > 0) then begin
        KeyList := TStringList.Create;
        MaxCnt := SecList.Count - 1;
        for Cnt := 0 to MaxCnt do begin;
            KeyList.Clear;
            ini.ReadSection(SecList.Strings[Cnt], KeyList);
            if (KeyList.Count > 0) then begin;
                MaxCnt2 := KeyList.Count - 1;
                for Cnt2 := 0 to MaxCnt2 do begin
                    DatString := ini.ReadString(SecList.Strings[Cnt], KeyList.Strings[Cnt2], '');
                    if (DatString = '') then
                        Continue;

                    if (not InputAssistDM.IsDupulicate(
                            KeyList.Strings[Cnt2], SecList.Strings[Cnt]) ) then begin
                        resWord := InputAssistDM.Add(KeyList.Strings[Cnt2]);
                        resWord.SetCategory(SecList.Strings[Cnt]);
                        resWord.SetText(DatString);
                        AddListViewItem(resWord);
                        RegCnt := RegCnt + 1;
                    end;
                end;
            end;
        end;
        KeyList.Free;
    end;

    ini.Free;
    SecList.Free;

    if (RegCnt > 0) then begin
        SetCategory(CategoryNameComboBox, '');
        GikoListView1.AlphaSort;
    end;

    ResMsg := IntToStr(RegCnt) + '���o�^���܂����B';
    Application.MessageBox(PChar(ResMsg), '�����o�^', MB_OK or MB_ICONINFORMATION);
end;

end.
