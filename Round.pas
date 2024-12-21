unit Round;

{$DEFINE LOOSENUP}

interface

uses
	Windows, Classes, Controls, Forms, StdCtrls, ComCtrls, Menus,
	SysUtils, ImgList, ExtCtrls, GikoSystem, GikoUtil;

type
	TRoundDialog = class(TForm)
	RoundPopupMenu: TPopupMenu;
	C1: TMenuItem;
	P1: TMenuItem;
		N1: TMenuItem;
	D1: TMenuItem;
		ItemIcon16: TImageList;
	Panel1: TPanel;
	Label1: TLabel;
	Label2: TLabel;
	RoundNameComboBox: TComboBox;
	Panel2: TPanel;
	Panel3: TPanel;
	AllSelectButton: TButton;
	AllCancelButton: TButton;
	RoundDeleteButton: TButton;
	Panel4: TPanel;
    ButtonCancel: TButton;
	RoundButton: TButton;
	StatusBar1: TStatusBar;
	RoundListView: TListView;
		procedure RoundButtonClick(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure RoundListViewChange(Sender: TObject; Item: TListItem;
			Change: TItemChange);
		procedure AllSelectButtonClick(Sender: TObject);
		procedure AllCancelButtonClick(Sender: TObject);
		procedure RoundNameComboBoxChange(Sender: TObject);
		procedure RoundDeleteButtonClick(Sender: TObject);
    procedure RoundListViewColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure RoundListViewCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure RoundListViewColumnRightClick(Sender: TObject;
      Column: TListColumn; Point: TPoint);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonCancelClick(Sender: TObject);
	private
		{ Private �錾 }
		FColumnToSort: Integer;
		FSortOrder:	Boolean;
    FProcessing: Boolean;

		function GetRoundCount: Integer;
		procedure SetRoundItem(RoundName: string);
		function CompareTime(Time1: TDateTime; Time2: TDateTime; MarginMin: Integer): Boolean;
    procedure EnableControls;
	public
		{ Public �錾 }
	end;


implementation

uses
	Giko, BoardGroup, RoundData, Math, GikoDataModule;

{$R *.DFM}

procedure TRoundDialog.RoundButtonClick(Sender: TObject);
const
{$IFDEF LOOSENUP}
	ROUND_INTERVAL: Integer = 10;	// �������ア�ꍇ�F�����O�C���ł̏���Ԋu����
{$ELSE}
  TARGET_MAX: Integer = 100;		// �����������ꍇ�F�����O�C���ł̏��񌏐����
{$ENDIF}
  LOGIN_NAME: String = 'UPLIFT';
var
	i: Integer;
	cnt: Integer;
	msg: string;
	Board: TBoard;
	ThreadItem: TThreadItem;
	RoundItem: TRoundItem;
begin
{$IF Defined(FRCRND) }
	GikoDM.LoginAction.Checked := true; // ���쎎���p�r
{$IFEND}

{$IFNDEF LOOSENUP}	//���񐧌����ɂ߂邱�Ƃɂ��Ă���{$ELSE}�̕����g��
	if not GikoDM.LoginAction.Checked then begin
		if GikoSys.Setting.UserID <> '' then begin
			msg := LOGIN_NAME + '�Ƀ��O�C�����Ȃ��Ə���͏o���܂���' + #13#10
				+ '�����O�C�����܂���';
			if MsgBox(Handle, msg, '�m�F', MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) <> IDYES then begin
				Exit;
			end;
			GikoDM.LoginAction.Execute;
		end;
		if not GikoDM.LoginAction.Checked then begin
			msg := LOGIN_NAME + '�Ƀ��O�C�����Ȃ��Ə���͏o���܂���';
			MsgBox(Handle, msg, '�G���[', MB_OK or MB_ICONSTOP);
			Exit;
		end;
	end;
{$ELSE}
	//�K�����ɂ߂��ق��́A�X���ꗗ�̂ݏ���\
{	if not GikoDM.LoginAction.Checked then begin
		if GikoSys.Setting.UserID <> '' then begin
			msg := LOGIN_NAME + '�Ƀ��O�C�����Ȃ��ƃX���b�h�̏���͏o���܂���' + #13#10
				+ '�����O�C�����܂���';
			if MsgBox(Handle, msg, '�m�F', MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) <> IDYES then begin
				Exit;
			end;
			GikoDM.LoginAction.Execute;
		end;
	end; }
	//���Ȃ�����͈�蕪���ȏ�̊Ԋu��K�v�Ƃ���
	if not GikoDM.LoginAction.Checked then begin
		if CompareTime(GikoForm.LastRoundTime, Now, ROUND_INTERVAL) then begin
			msg := Format('%s�����O�C���̏ꍇ�A�O��̏��񂩂�%d���ԑ҂K�v������܂�',
      							[LOGIN_NAME, ROUND_INTERVAL]);
			MsgBox(Handle, msg, '�G���[', MB_OK or MB_ICONSTOP);
			Exit;
		end;
	end;
{$ENDIF}

	//�������ɐݒ肵�Ă��Ȃ�������G���[�ɂ���
	cnt := GetRoundCount;
	if cnt = 0 then begin
		msg := '���񂵂������ڂɂP�ȏ�`�F�b�N�����Ă�������';
		MsgBox(Handle, msg, '�G���[', MB_OK or MB_ICONSTOP);
		Exit;
	end;

{$IFNDEF LOOSENUP}
	//���Ȃ�����͂P�x��100�܂łɂ���
	if not GikoDM.LoginAction.Checked then begin
		if cnt > TARGET_MAX then begin
			msg := Format('%s�����O�C���̏ꍇ�A%d���܂ł�������ł��܂���',
      							[LOGIN_NAME, TARGET_MAX]);
			MsgBox(Handle, msg, '�G���[', MB_OK or MB_ICONSTOP);
			Exit;
		end;
	end;
{$ENDIF}

	FProcessing := True;
  EnableControls;
  try
    //����ɓo�^����Ă���̐������܂킷
    for i := 0 to RoundList.Count[grtBoard] - 1 do begin
      RoundItem := RoundList.Items[i, grtBoard];
      //����̃`�F�b�N�����Ă��Ȃ���΃X���[
      if not RoundItem.BoolData then Continue;
      //�m���ɔ̂͂������ǃ`�F�b�N
      if RoundItem.RoundType = grtBoard then begin
        Board := TBoard( RoundItem.Item );
        //Board�̃I�u�W�F�N�g�����݂���΁ADL����
        if Board <> nil then begin
          if not Board.IsThreadDatRead then
            GikoSys.ReadSubjectFile(Board);
          GikoForm.DownloadList(Board);
        end;
      end;
    end;
    for i := 0 to RoundList.Count[grtItem] - 1 do begin
      RoundItem := RoundList.Items[i, grtItem];
      //����̃`�F�b�N�����Ă��Ȃ���΃X���[
      if not RoundItem.BoolData then Continue;
{$IFDEF LOOSENUP}
      //���Ȃ�����̓X���b�h�͂ł��Ȃ����Ƃɂ���
{      if not GikoDM.LoginAction.Checked then begin
        msg := LOGIN_NAME + '�Ƀ��O�C�����Ȃ��ƃX���b�h�̏���͂ł��܂���B';
        MsgBox(Handle, msg, '�G���[', MB_OK or MB_ICONSTOP);
        break;
      end; }
{$ENDIF}
      if RoundItem.RoundType = grtItem then begin
        ThreadItem := TThreadItem( RoundItem.Item );
        if ThreadItem <> nil then begin
          GikoForm.DownloadContent(ThreadItem);
        end;
      end;
    end;
  finally
		FProcessing := False;
	  EnableControls;
  end;

	GikoForm.LastRoundTime := Now;
	Close;
end;

function TRoundDialog.GetRoundCount: Integer;
var
	i: Integer;
	RoundItem: TRoundItem;
begin
	Result := 0;
	for i := 0 to RoundList.Count[grtBoard] - 1 do begin
		RoundItem := RoundList.Items[i, grtBoard];
		if RoundItem.BoolData then
			Result := Result + 1;
	end;
	for i := 0 to RoundList.Count[grtItem] - 1 do begin
		RoundItem := RoundList.Items[i, grtItem];
		if RoundItem.BoolData then
			Result := Result + 1;
	end;
end;

function TRoundDialog.CompareTime(Time1: TDateTime; Time2: TDateTime; MarginMin: Integer): Boolean;
const
	AMin: Double = (1 / 24 / 60);
var
	d: TDateTime;
begin
	d := Time1 + (AMin * MarginMin);
	Result := Time2 < d;
end;

procedure TRoundDialog.EnableControls;
begin
	RoundNameComboBox.Enabled := not FProcessing;
  RoundListView.Enabled     := not FProcessing;
  AllSelectButton.Enabled   := not FProcessing;
  AllCancelButton.Enabled   := not FProcessing;
  RoundDeleteButton.Enabled := not FProcessing;
	RoundButton.Enabled       := not FProcessing;
  ButtonCancel.Enabled      := not FProcessing;
end;

procedure TRoundDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FProcessing then
		CanClose := False;
end;

procedure TRoundDialog.ButtonCancelClick(Sender: TObject);
begin
  if not FProcessing then
	  ModalResult := mrCancel;
end;

procedure TRoundDialog.FormCreate(Sender: TObject);
var
	i: Integer;
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

  FProcessing := False;

	//���݂̏���f�[�^���t�@�C���A�E�g����
	RoundList.SaveRoundFile;
	RoundNameComboBox.Items.Add('�i���ׂāj');
	for i := 0 to RoundList.RoundNameList.Count - 1 do
		RoundNameComboBox.Items.Add(RoundList.RoundNameList[i]);
	for i := 0 to RoundList.Count[grtBoard] - 1 do
		RoundList.Items[i, grtBoard].BoolData := False;
	for i := 0 to RoundList.Count[grtItem] - 1 do
		RoundList.Items[i, grtItem].BoolData := False;
	RoundNameComboBox.ItemIndex := 0;
	SetRoundItem('');
end;

procedure TRoundDialog.RoundListViewChange(Sender: TObject;
	Item: TListItem; Change: TItemChange);
var
	RoundItem: TRoundItem;
begin
	if TObject(Item.Data) is TRoundItem then begin
		RoundItem := TRoundItem(Item.Data);
		RoundItem.BoolData := Item.Checked;
	end;
end;

procedure TRoundDialog.AllSelectButtonClick(Sender: TObject);
var
	i: Integer;
	RoundItem: TRoundItem;
	ListChangeEvent: TLVChangeEvent;
begin
	ListChangeEvent := RoundListView.OnChange;
	RoundListView.OnChange := nil;
	try
		for i := 0 to RoundListView.Items.Count - 1 do begin
			if TObject(RoundListView.Items[i].Data) is TRoundItem then begin
				RoundItem := TRoundItem(RoundListView.Items[i].Data);
				RoundItem.BoolData := True;
				RoundListView.Items[i].Checked := True;
			end;
		end;
	finally
		RoundListView.OnChange := ListChangeEvent;
	end;
end;

procedure TRoundDialog.AllCancelButtonClick(Sender: TObject);
var
	i: Integer;
	RoundItem: TRoundItem;
	ListChangeEvent: TLVChangeEvent;
begin
	ListChangeEvent := RoundListView.OnChange;
	RoundListView.OnChange := nil;
	try
		for i := 0 to RoundListView.Items.Count - 1 do begin
			if TObject(RoundListView.Items[i].Data) is TRoundItem then begin
				RoundItem := TRoundItem(RoundListView.Items[i].Data);
				RoundItem.BoolData := False;
				RoundListView.Items[i].Checked := False;
			end;
		end;
	finally
		RoundListView.OnChange := ListChangeEvent;
	end;
end;

procedure TRoundDialog.RoundNameComboBoxChange(Sender: TObject);
begin
	//�J�����̃\�[�g�L���C���[�W����������
	if FColumnToSort > -1 then
		RoundListView.Column[FColumnToSort].ImageIndex := -1;
	FColumnToSort := -1;
	if RoundNameComboBox.ItemIndex = 0 then
		SetRoundItem('')
	else
		SetRoundItem(RoundNameComboBox.Items[RoundNameComboBox.itemIndex]);

end;

procedure TRoundDialog.SetRoundItem(RoundName: string);
var
	ListItem: TListItem;
	i: Integer;
	ListChangeEvent: TLVChangeEvent;
begin
	ListChangeEvent := RoundListView.OnChange;
	RoundListView.OnChange := nil;
	try
		RoundListView.Clear;
		for i := 0 to RoundList.Count[grtBoard] - 1 do begin
			if (RoundList.Items[i, grtBoard].RoundName = RoundName) or (RoundName = '') then begin
				ListItem := RoundListView.Items.Add;
				ListItem.Data := RoundList.Items[i, grtBoard];
				ListItem.Caption := RoundList.Items[i, grtBoard].RoundName;
				ListItem.SubItems.Add(RoundList.Items[i, grtBoard].BoardTitle);
				ListItem.SubItems.Add('-');
				ListItem.Checked := RoundList.Items[i, grtBoard].BoolData;
				ListItem.ImageIndex := 0;
			end;
		end;
		for i := 0 to RoundList.Count[grtItem] - 1 do begin
			if (RoundList.Items[i, grtItem].RoundName = RoundName) or (RoundName = '') then begin
				ListItem := RoundListView.Items.Add;
				ListItem.Data := RoundList.Items[i, grtItem];
				ListItem.Caption := RoundList.Items[i, grtItem].RoundName;
				ListItem.SubItems.Add(RoundList.Items[i, grtItem].BoardTitle);
				ListItem.SubItems.Add(RoundList.Items[i, grtItem].ThreadTitle);
				ListItem.Checked := RoundList.Items[i, grtItem].BoolData;
				ListItem.ImageIndex := 1;
			end;
		end;
	finally
		RoundListView.OnChange := ListChangeEvent;
	end;
end;

procedure TRoundDialog.RoundDeleteButtonClick(Sender: TObject);
var
//	Board: TBoard;
//	ThreadItem: TThreadItem;
	RoundItem: TRoundItem;
	ListChangeEvent: TLVChangeEvent;
begin
	ListChangeEvent := RoundListView.OnChange;
	RoundListView.OnChange := nil;
	try
		if RoundListView.Selected = nil then
			Exit;
		if TObject(RoundListView.Selected.Data) is TRoundItem then begin
			RoundItem := TRoundItem(RoundListView.Selected.Data);
			if( RoundItem.Item is TBoard ) then begin
				TBoard(RoundItem.Item).Round := false;
			end else if( RoundItem.Item is TThreadItem ) then begin
				TThreadItem(RoundItem.Item).Round := false;
			end;
			//RoundList.Delete(RoundItem.URL,RoundItem.RoundType);
			{
			if RoundItem.RoundType = grtBoard then begin
				//Board := TBoard( RoundItem.Item );
				RoundList.Delete(RoundItem.URL,RoundItem.RoundType);
				Board.Round := False;
				Board.RoundName := '';
			end else begin
				//ThreadItem := TThreadItem( RoundItem.Item );
				RoundList.Delete(ThreadItem);
				ThreadItem.Round := False;
				ThreadItem.RoundName := '';
			end;
			}
			GikoForm.ListView.Refresh;
		end;
		RoundListView.Selected.Delete;
	finally
		RoundListView.OnChange := ListChangeEvent;
	end;
end;

procedure TRoundDialog.RoundListViewColumnClick(Sender: TObject;
  Column: TListColumn);
begin
	if (Sender is TCustomListView) then begin

		if FColumnToSort > -1 then
			(Sender as TCustomListView).Column[FColumnToSort].ImageIndex := -1;

		if FColumnToSort = Column.Index then
			FSortOrder := not FSortOrder
		else
			FSortOrder := false;

		if FSortOrder then
			Column.ImageIndex := 3
		else
			Column.ImageIndex := 2;

		FColumnToSort := Column.Index;
		(Sender as TCustomListView).AlphaSort;
	end;
end;

procedure TRoundDialog.RoundListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
	if FColumnToSort = 0 then begin
		if not FSortOrder then begin
			Compare := CompareText(Item1.Caption,Item2.Caption);
			if Compare = 0 then
				Compare := CompareValue(Item1.ImageIndex, item2.ImageIndex);
		end else begin
			Compare := -CompareText(Item1.Caption,Item2.Caption);
			if Compare = 0 then
				Compare := -CompareValue(Item1.ImageIndex,item2.ImageIndex);
		end;
	end else begin
		ix := FColumnToSort - 1;
		if not FSortOrder then begin
			Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
			if Compare = 0 then
				Compare := CompareValue(Item1.ImageIndex, item2.ImageIndex);
		end else begin
			Compare := -CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
			if Compare = 0 then
				Compare := -CompareValue(Item1.ImageIndex, item2.ImageIndex);
		end;
	end;
end;
(*
* �J������ŉE�N���b�N������\�[�g���������ď�����Ԃɖ߂�
*)
procedure TRoundDialog.RoundListViewColumnRightClick(Sender: TObject;
  Column: TListColumn; Point: TPoint);
begin
	RoundNameComboBox.OnChange(Sender);
end;

end.
