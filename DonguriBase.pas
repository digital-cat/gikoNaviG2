unit DonguriBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, StrUtils;

type
  TDonguriForm = class(TForm)
    TimerInit: TTimer;
    InfoGrid: TStringGrid;
    AuthButton: TButton;
    LogoutButton: TButton;
    UplLoginButton: TButton;
    UplLogoutButton: TButton;
    LoginButton: TButton;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
    procedure TimerInitTimer(Sender: TObject);
    procedure AuthButtonClick(Sender: TObject);
    procedure LogoutButtonClick(Sender: TObject);
    procedure UplLoginButtonClick(Sender: TObject);
    procedure UplLogoutButtonClick(Sender: TObject);
    procedure LoginButtonClick(Sender: TObject);
  private
    { Private declarations }
    FHunter: Boolean;
    FUplift: Boolean;

    procedure ClearInfoValue;
    procedure ShowRoot;
    function Parsing(html: String): Boolean;
    function Extract(html, kws, kwe: String; var dest: String): Boolean;
    procedure EnableUpliftButton;
    procedure ShowHttpError;
  public
    { Public declarations }
  end;

var
  DonguriForm: TDonguriForm;

implementation

uses
	GikoSystem, IndyModule, DmSession5ch, GikoDataModule;

type
  ColIndex = (
    idxUserType  = 0,
    idxHunterID  = 1,
    idxDonguri   = 2,
    idxNumWood   = 3,
    idxNumIron   = 4,
    idxIronKey   = 5,
    idxLevel     = 6,
    idxNumKills  = 7,
    idxNumDamage = 8,
    idxPeriod    = 9,
    idxExplrtn   = 10,
    idxMining    = 11,
    idxFelling   = 12,
    idxArmsWork  = 13,
    idxProtector = 14,
    idxMessage   = 15,
    idxRowCount  = 16);

const
  COL_NAME: array [0..15] of string  = (
  	'�@���',
    '�@�n���^�[ID',
    '�@�h���O���c��',
  	'�@�؍ނ̐�',
    '�@�S�̐�',
    '�@�S�̃L�[',
    '�@���x��',
    '�@K',
    '�@D',
    '�@��',
    '�@�T��',
    '�@�̌@',
    '�@�؂���',
    '�@���퐻��',
    '�@�h���',
    '�@���b�Z�[�W');

{$R *.dfm}

procedure TDonguriForm.FormShow(Sender: TObject);
var
	i: Integer;
begin
	FHunter := False;
  FUplift := (GikoSys.Setting.UserID <> '') and (GikoSys.Setting.Password <> '');

  InfoGrid.RowCount := Integer(idxRowCount);
  InfoGrid.ColWidths[1] := 400;
	for i := 0 to Integer(idxRowCount) - 1 do
	  InfoGrid.Cells[0, i] := COL_NAME[i];

	EnableUpliftButton;

	TimerInit.Enabled := True;
end;

procedure TDonguriForm.EnableUpliftButton;
begin
	try
    UplLoginButton.Enabled  := FUplift and (Session5ch.Connected = False);
    UplLogoutButton.Enabled := FUplift and  Session5ch.Connected;
  except
  end;
end;

procedure TDonguriForm.TimerInitTimer(Sender: TObject);
begin
	TimerInit.Enabled := False;
  ShowRoot;
end;

procedure TDonguriForm.ClearInfoValue;
var
	i: Integer;
begin
	for i := 0 to Integer(idxRowCount) - 1 do
	  InfoGrid.Cells[1, i] := '';
end;

procedure TDonguriForm.ShowRoot;
var
  res: String;
begin
  if GikoSys.DonguriSys.Root(res) then begin
  	if Parsing(res) = False then
      MessageBox(Handle, '�h���O���V�X�e���̃y�[�W��͂Ɏ��s���܂���',
								'�h���O���V�X�e��', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

function TDonguriForm.Parsing(html: String): Boolean;
const
  TAG_USR_S = '<p>���Ȃ���';
  TAG_USR_E = '�ł��B</p>';
	TAG_HID_S = '<span>�n���^�[ID:';
  TAG_HID_E = '<br>';
	TAG_DNG_S = '<span>�h���O���c��:';
	TAG_DN2_S = '<span>��q�c��:';
  TAG_DNG_E = '</span>';
  TAG_NWD_S = '<span>�؍ނ̐�:';
  TAG_NWD_E = '<br>';
  TAG_NIR_S = '�S�̐�:';
  TAG_NIR_E = '<br>';
  TAG_IRK_S = '<br>�S�̃L�[:';
  TAG_IRK_E = '</span>';
  TAG_LVL_S = '<h4>���x��:';
  TAG_LVL_E = '<br>';
  TAG_NKL_S = '<br>K:';
  TAG_NKL_E = '|';
  TAG_NDM_S = '| D:';
  TAG_NDM_E = '</h4>';
  TAG_PRD_S = '<span>��';
  TAG_PRD_E = '��</span>';
  TAG_EXP_S = '<a href="/focus/exploration">�T��:';
  TAG_EXP_E = '</a>';
  TAG_MNG_S = '<a href="/focus/mining">�̌@:';
  TAG_MNG_E = '</a>';
  TAG_FLL_S = '<a href="/focus/woodcutting">�؂���:';
  TAG_FLL_E = '</a>';
  TAG_ARM_S = '<a href="/focus/weaponcraft">���퐻��:';
  TAG_ARM_E = '</a>';
  TAG_PRT_S = '<a href="/focus/armorcraft">�h���:';
  TAG_PRT_E = '</a>';

  TAG_ERROR = '<p>�G���[�I</p>';
	TAG_ECD_S = '<p>NG&lt;&gt;';
	TAG_ECD_E = '</p>';
	TAG_E_COOKIE_MSG = '<p>���O�A�E�g���āA������x���O�C�����Ă��������B</p>';
var
  tmp: String;
  tm2: String;
  ecd: String;
  idx: Integer;
begin
	Result := False;

	try
  	ClearInfoValue;
    FHunter := False;

    // HTML�ł͂Ȃ��G���[���b�Z�[�W�̃e�L�X�g�̂�
    if Pos('NG<>', html) = 1 then begin
      tmp := Copy(html, 5, Length(html) - 4);
			InfoGrid.Cells[1, Integer(idxMessage)] := tmp;
      Result := True;
      Exit;
    end;

    if Extract(html, TAG_USR_S, TAG_USR_E, tmp) then begin
    	tmp := Trim(tmp);
      InfoGrid.Cells[1, Integer(idxUserType)] := tmp;
			FHunter := (tmp = '�n���^�[');
    end;

    if FHunter and Extract(html, TAG_HID_S, TAG_HID_E, tmp) then
      InfoGrid.Cells[1, Integer(idxHunterID)] := Trim(tmp);

    if Extract(html, TAG_DNG_S, TAG_DNG_E, tmp) then begin					// ���Ԃ�n���^�[
      InfoGrid.Cells[0, Integer(idxDonguri)] := '�@�h���O���c��';
      InfoGrid.Cells[1, Integer(idxDonguri)] := Trim(tmp);
    end else if Extract(html, TAG_DN2_S, TAG_DNG_E, tmp) then begin	// ���Ԃ�x����
      InfoGrid.Cells[0, Integer(idxDonguri)] := '�@��q�c��';
      InfoGrid.Cells[1, Integer(idxDonguri)] := Trim(tmp);
    end;

    if Extract(html, TAG_NWD_S, TAG_NWD_E, tmp) then
      InfoGrid.Cells[1, Integer(idxNumWood)] := Trim(tmp);

    if Extract(html, TAG_NIR_S, TAG_NIR_E, tmp) then
      InfoGrid.Cells[1, Integer(idxNumIron)] := Trim(tmp);

    if Extract(html, TAG_IRK_S, TAG_IRK_E, tmp) then
      InfoGrid.Cells[1, Integer(idxIronKey)] := Trim(tmp);

    if Extract(html, TAG_LVL_S, TAG_LVL_E, tmp) then begin
      tmp := Trim(tmp);
      idx := Pos('|', tmp);
      if idx < 1 then
	      InfoGrid.Cells[1, Integer(idxLevel)] := tmp
      else begin
        tm2 := Trim(Copy(tmp, 1, idx - 1));
      	Delete(tmp, 1, idx);
	      tmp := tm2 + ' (' + Trim(tmp) + ')';
	      InfoGrid.Cells[1, Integer(idxLevel)] := tmp;
      end;
    end;

    if Extract(html, TAG_NKL_S, TAG_NKL_E, tmp) then
      InfoGrid.Cells[1, Integer(idxNumKills)] := Trim(tmp);

    if Extract(html, TAG_NDM_S, TAG_NDM_E, tmp) then
      InfoGrid.Cells[1, Integer(idxNumDamage)] := Trim(tmp);

    if Extract(html, TAG_PRD_S, TAG_PRD_E, tmp) then
      InfoGrid.Cells[1, Integer(idxPeriod)] := '��' + tmp + '��';

    if Extract(html, TAG_EXP_S, TAG_EXP_E, tmp) then
      InfoGrid.Cells[1, Integer(idxExplrtn)] := Trim(tmp);

    if Extract(html, TAG_MNG_S, TAG_MNG_E, tmp) then
      InfoGrid.Cells[1, Integer(idxMining)] := Trim(tmp);

    if Extract(html, TAG_FLL_S, TAG_FLL_E, tmp) then
      InfoGrid.Cells[1, Integer(idxFelling)] := Trim(tmp);

    if Extract(html, TAG_ARM_S, TAG_ARM_E, tmp) then
      InfoGrid.Cells[1, Integer(idxArmsWork)] := Trim(tmp);

    if Extract(html, TAG_PRT_S, TAG_PRT_E, tmp) then
      InfoGrid.Cells[1, Integer(idxProtector)] := Trim(tmp);

  	if Pos(TAG_ERROR, html) > 0 then begin
	    if Extract(html, TAG_ECD_S, TAG_ECD_E, tmp) then begin
        ecd := 'NG<>' + tmp;
        if Pos(TAG_E_COOKIE_MSG, html) > 0 then
		      InfoGrid.Cells[1, Integer(idxMessage)] := ecd + ' ���O�A�E�g���āA������x���O�C�����Ă��������B'
        else
		      InfoGrid.Cells[1, Integer(idxMessage)] := '�G���[�I ' + ecd;
      end else
        InfoGrid.Cells[1, Integer(idxMessage)] := '�G���[�I';
    end;

    Result := True;
  except
  end;
end;

function TDonguriForm.Extract(html, kws, kwe: String; var dest: String): Boolean;
var
	idx1: Integer;
	idx2: Integer;
  start: Integer;
begin
	Result := False;
  dest := '';

	idx1 := Pos(kws, html);
  if idx1 < 1 then
  	Exit;

	start := idx1 + Length(kws);
	idx2 := PosEx(kwe, html, start);
  if idx2 < 1 then
  	Exit;

	dest := Copy(html, start, idx2 - start);

  Result := True;
end;


procedure TDonguriForm.ShowHttpError;
var
  msg: String;
begin
  msg := '�G���[���������܂����B' + #10 +
         'HTTP ' + IntToStr(GikoSys.DonguriSys.ResponseCode) + #10 +
         GikoSys.DonguriSys.ResponseText;
  MessageBox(Handle, PChar(msg), '�h���O���V�X�e��', MB_OK or MB_ICONERROR);
end;

procedure TDonguriForm.AuthButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Auth(res) then begin
  	if Parsing(res) = False then
      MessageBox(Handle, '�h���O���V�X�e���̃y�[�W��͂Ɏ��s���܂���',
								'�h���O���V�X�e��', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.LoginButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Login(res) then begin
  	if Parsing(res) = False then
      MessageBox(Handle, '�h���O���V�X�e���̃y�[�W��͂Ɏ��s���܂���',
								'�h���O���V�X�e��', MB_OK or MB_ICONERROR)
    else if Pos('NG<>�܂���UPLIFT�Ń��O�C��', res) = 1 then
      MessageBox(Handle, PChar('UPLIFT�ł̃��O�C����v������܂����B' + #10 +
      						'UPLIFT�Ń��O�C�����Ȃ��ꍇ�͏������݂łǂ񂮂�𖄂߂Ă��������B'),
								'�h���O���V�X�e��', MB_OK or MB_ICONWARNING);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.LogoutButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Logout(res) then begin
	  MessageBox(Handle, '���O�A�E�g���܂����B',
    						'�h���O���V�X�e��', MB_OK or MB_ICONINFORMATION);
  	if Parsing(res) = False then
      MessageBox(Handle, '�h���O���V�X�e���̃y�[�W��͂Ɏ��s���܂���',
								'�h���O���V�X�e��', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;


procedure TDonguriForm.UplLoginButtonClick(Sender: TObject);
begin
	try
    if FUplift and (Session5ch.Connected = False) then
	  	GikoDM.LoginActionExecute(nil);
  except
	  on e: Exception do begin
      MessageBox(Handle, PChar(e.Message), 'UPLIFT���O�C��', MB_OK or MB_ICONERROR);
    end;
  end;
	EnableUpliftButton;
end;

procedure TDonguriForm.UplLogoutButtonClick(Sender: TObject);
begin
	try
    if FUplift and Session5ch.Connected then
	  	GikoDM.LoginActionExecute(nil);
  except
	  on e: Exception do begin
      MessageBox(Handle, PChar(e.Message), 'UPLIFT���O�A�E�g', MB_OK or MB_ICONERROR);
    end;
  end;
	EnableUpliftButton;

end;

end.
