unit UpdateCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IndyModule,   // for Indy10
  IdTCPConnection, IdTCPClient, IdHTTP, StdCtrls, ExtCtrls, Buttons,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
	/// �o�[�W�������N���X
  VersionNumber = class
  private
    FValue1:  Integer;	// �o�[�W�����ԍ�1�v�f��
    FValue2:  Integer;	// �o�[�W�����ԍ�2�v�f��
    FValue3:  Integer;	// �o�[�W�����ԍ�3�v�f��
    FValue4:  Integer;	// �o�[�W�����ԍ�4�v�f��
    FVersion: String;		// �o�[�W�����ԍ�������in.n.n.n�j
    FURL:     String;		// �C���X�g�[���[URL
  public
  	constructor Create; overload;
  	constructor Create(ASrc: String; AURL: String); overload;

    procedure Clear;
    function SetValue(AVer: String; AURL: String): Boolean;

    function IsGood: Boolean;
    function IsFormal: Boolean;
    function IsSelfNew(const AOther: VersionNumber; ANightly: Boolean): Boolean;

    property Version: String  read FVersion;
    property Value1:  Integer read FValue1;
    property Value2:  Integer read FValue2;
    property Value3:  Integer read FValue3;
    property Value4:  Integer read FValue4;
    property URL:     String  read FURL;
  end;



  TUpdateCheckForm = class(TForm)
    IdHTTP: TIdHTTP;
    CancelBitBtn: TBitBtn;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    CurNameLabel: TLabel;
    CurVerLabel: TLabel;
    CurTypLabel: TLabel;
    CheckButton: TButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    NewVerLabel: TLabel;
    NewMsgLabel: TLabel;
    UpdateNewButton: TButton;
    NlyNameLabel: TLabel;
    Label9: TLabel;
    NlyVerLabel: TLabel;
    NlyMsgLabel: TLabel;
    UpdateNlyButton: TButton;
    GroupBox2: TGroupBox;
    CloseButton: TButton;
    NewNameLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    NewDateLabel: TLabel;
    Label3: TLabel;
    NlyDateLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure CheckButtonClick(Sender: TObject);
    procedure UpdateNewButtonClick(Sender: TObject);
    procedure UpdateNlyButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private �錾 }
    FExecPath : string;
    FExecArgs : string;
    FAllowshutdown : Boolean;
    FCanceled : Boolean;
    FCurVer: VersionNumber;		// ���݂̃o�[�W����
    FFmlVer: VersionNumber;		// �ŐV�����Ńo�[�W����
    FNlyVer: VersionNumber;		// �ŐV�l���Ńo�[�W����
    function GetDesktopDir:string;
    function GetDownloadFilePath(FileName: String): String;
    function CreateShortCut(FileName, Argment, SavePath :string):boolean;
    function DonwloadUpdate(url: String): Boolean;
    procedure UpdateProc(newVer: VersionNumber);
    function QueryYesNo(msg: PChar; title: PChar): Integer;
  public
    { Public �錾 }
    property ExecPath :String read FExecPath;
    property ExecArgs :String read FExecArgs;
    property Allowshutdown :Boolean read FAllowshutdown;
  end;

var
  UpdateCheckForm: TUpdateCheckForm;

implementation
uses
    GikoSystem, NewBoard, Giko, IniFiles, MojuUtils, GikoDataModule,
    ActiveX, ComObj, ShlObj, GikoUtil;

{$R *.dfm}

//! Form�R���X�g���N�^
procedure TUpdateCheckForm.FormCreate(Sender: TObject);
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

  FExecPath := '';
  FExecArgs := '';
  FAllowshutdown := False;

  FCurVer := VersionNumber.Create(GikoSys.Version, '');
  FFmlVer := VersionNumber.Create;
  FNlyVer := VersionNumber.Create;

  CurNameLabel.Caption := BETA_VERSION_NAME_J + IntToStr(BETA_VERSION);
  CurVerLabel.Caption  := FCurVer.Version;
  if not FCurVer.IsGood then begin
    CurTypLabel.Caption := '�G���[����';
    CheckButton.Enabled := False;
  end else if FCurVer.IsFormal then
    CurTypLabel.Caption := ''
  else
    CurTypLabel.Caption := '�l���łł��B';
	NewNameLabel.Caption := '������';
  NewDateLabel.Caption := '_';
  NewVerLabel.Caption  := '_';
  NewMsgLabel.Caption  := '���m�F�ł��B';
  NlyNameLabel.Caption := '�l����';
  NlyDateLabel.Caption := '_';
  NlyVerLabel.Caption  := '_';
  NlyMsgLabel.Caption  := '���m�F�ł��B';
  UpdateNewButton.Enabled := False;
  UpdateNlyButton.Enabled := False;
end;

//! �ŐV�ł̊m�F�{�^���N���b�N
procedure TUpdateCheckForm.CheckButtonClick(Sender: TObject);
const
{$IFDEF DEBUG}
	CHECK_URL = 'https://digital-cat.github.io/gikog2/updater/debug.txt';
{$ELSE}
	CHECK_URL = 'https://digital-cat.github.io/gikog2/updater/latest.txt';
{$ENDIF}
var
  value: string;
  ResStream: TMemoryStream;
  downResult: TStringList;
begin
  FExecPath := '';
  FExecArgs := '';
  FAllowshutdown := False;
  Screen.Cursor := crHourGlass;

  CheckButton.Enabled := False;
  CloseButton.Enabled := False;

  FFmlVer.Clear;
  FNlyVer.Clear;
	NewVerLabel.Caption := '_';
	NlyVerLabel.Caption := '_';
  NewMsgLabel.Caption := ' ';
  NlyMsgLabel.Caption := ' ';
  UpdateNewButton.Enabled := False;
  UpdateNlyButton.Enabled := False;

  try
    ResStream := TMemoryStream.Create;
    try
      TIndyMdl.InitHTTP(IdHTTP);
      IdHTTP.Request.Referer := '';
      IdHTTP.Request.AcceptEncoding := 'gzip';

      IdHTTP.Request.CacheControl := 'no-cache';
      IdHTTP.Request.CustomHeaders.Add('Pragma: no-cache');
      IdHTTP.ReadTimeout := 0;
      IdHTTP.HandleRedirects := true;
      downResult := TStringList.Create;
      IndyMdl.StartAntiFreeze(250);
      try
        try
          ResStream.Clear;
          FCanceled := False;
          CancelBitBtn.Enabled := True;
          IdHTTP.Get(CHECK_URL, ResStream);
          CancelBitBtn.Enabled := False;
          if (FCanceled) then begin
            raise Exception.Create('�_�E�����[�h���L�����Z������܂����B');
          end;
          value := GikoSys.GzipDecompress(ResStream, IdHTTP.Response.ContentEncoding);
          downResult.Text := value;

          // �o�[�W�����ԍ����
          FFmlVer.SetValue(downResult.Values[ 'version' ],   downResult.Values[ 'url' ]);
          FNlyVer.SetValue(downResult.Values[ 'n_version' ], downResult.Values[ 'n_url' ]);

          NewVerLabel.Caption  := FFmlVer.Version;
          NlyVerLabel.Caption  := FNlyVer.Version;
          NewNameLabel.Caption := downResult.Values[ 'name' ];
          NlyNameLabel.Caption := downResult.Values[ 'n_name' ];
          NewDateLabel.Caption := downResult.Values[ 'date' ];
          NlyDateLabel.Caption := downResult.Values[ 'n_date' ];

          // �����Ńo�[�W�����m�F
          if (not FFmlVer.IsGood) or (FFmlVer.URL = '') then
            NewMsgLabel.Caption := '�G���[����'
          else if not FFmlVer.IsSelfNew(FCurVer, False) then
            NewMsgLabel.Caption := '�X�V�s�v�ł��B'
          else begin
            NewMsgLabel.Caption := '�X�V�\�ł��B';
            UpdateNewButton.Enabled := True;
          end;

          // �l���Ńo�[�W�����m�F
          if (not FNlyVer.IsGood) or (FNlyVer.URL = '') then
            NlyMsgLabel.Caption := '�G���[����'
          else if not FNlyVer.IsSelfNew(FCurVer, True) then
            NlyMsgLabel.Caption := '�X�V�s�v�ł��B'
          else begin
            NlyMsgLabel.Caption := '�X�V�\�ł��B';
            UpdateNlyButton.Enabled := True;
          end;

        except
          on E: Exception do begin
            GikoUtil.MsgBox(Handle, PChar(E.Message), '�ŐV�ł̊m�F', MB_OK or MB_ICONERROR);
            {$IFDEF DEBUG}
            Writeln(IdHTTP.ResponseText);
            {$ENDIF}
          end;
        end;
      finally
        downResult.Free;
        IndyMdl.EndAntiFreeze;
      end;
    finally
      ResStream.Clear;
      ResStream.Free;
    end;
  finally
	  CheckButton.Enabled := True;
	  CloseButton.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;


//! �ŐV�łɍX�V�{�^���N���b�N
procedure TUpdateCheckForm.UpdateNewButtonClick(Sender: TObject);
begin
  UpdateProc(FFmlVer);
end;

//! �l���łɍX�V�{�^���N���b�N
procedure TUpdateCheckForm.UpdateNlyButtonClick(Sender: TObject);
begin
	if QueryYesNo('���������[�X�łł͂���܂��񂪂�낵���ł����H', '�X�V�m�F') = ID_YES then
		UpdateProc(FNlyVer);
end;

//! YES/NO�₢���킹���b�Z�[�W�{�b�N�X�\��
function TUpdateCheckForm.QueryYesNo(msg: PChar; title: PChar): Integer;
begin
	Result := GikoUtil.MsgBox(Handle, msg, title, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2);
end;

//! �X�V���s����
procedure TUpdateCheckForm.UpdateProc(newVer: VersionNumber);
begin
  if (not newVer.IsGood) or (newVer.URL = '') then begin
  	GikoUtil.MsgBox(Handle, '�X�V��񂪊m�F�ł��܂���ł����B', '�X�V�m�F', MB_OK or MB_ICONERROR);
    Exit;
  end;

	if QueryYesNo('�V�����M�R�i�r���_�E�����[�h���܂����H', '�X�V�m�F') <> ID_YES then
  	Exit;

	if not DonwloadUpdate(newVer.URL) then
  	Exit;

  if QueryYesNo('�X�V�̂��߃M�R�i�r���ċN�����܂��B��낵���ł����H', '�I���m�F') = ID_YES then begin
    FAllowshutdown := True;
    Close;
  end;
end;

//! �A�b�v�f�[�g�_�E�����[�h
function TUpdateCheckForm.DonwloadUpdate(url: String): Boolean;
var
  filename : String;
  fileStrem: TFileStream;
  msg: String;
  ok: Boolean;
begin
  CheckButton.Enabled := False;
	CloseButton.Enabled := False;
  FCanceled := False;

  filename := GetDownloadFilePath(Copy(url, LastDelimiter('/', url) + 1,  Length(url)));
  fileStrem := TFileStream.Create(filename, fmCreate);
  try
  	ok := False;
    CancelBitBtn.Enabled := True;
		IndyMdl.StartAntiFreeze(250);
    try
	    IdHTTP.Get(url, fileStrem);
      ok := True;
    except
			on e: Exception do begin
      	msg := '�_�E�����[�h�Ɏ��s���܂����B' + #13#10 + e.Message;
    		GikoUtil.MsgBox(Handle, PChar(msg), '�X�V�G���[', MB_OK or MB_ICONERROR);
	    end;
    end;
		IndyMdl.EndAntiFreeze;
    CancelBitBtn.Enabled := False;
    if (not ok) or FCanceled then begin
	    if FCanceled then
				GikoUtil.MsgBox(Handle, '�_�E�����[�h���L�����Z������܂����B', '�M�R�i�r�X�V', MB_OK or MB_ICONWARNING);
    	Result := False;
      Exit;
    end;
    //ResultMemo.Lines.Add(
		//			IdHttp.ResponseText + '(' + IntToStr(IdHttp.ResponseCode) + ')');

    try
      FExecPath := filename;
      FExecArgs := '/SP- /silent /noicons "/dir=' + GikoSys.GetAppDir + '"';
      if CreateShortCut(execPath, execArgs, GetDesktopDir) then begin
        //ResultMemo.Lines.Add('�f�X�N�g�b�v��"�M�R�i�r�X�V"�V���[�g�J�b�g���쐬���܂����B');
        // ResultMemo.Lines.Add('�M�R�i�r���I�����āA"�M�R�i�r�X�V"�V���[�g�J�b�g���_�u���N���b�N���Ă��������B');
      end else begin
        //ResultMemo.Lines.Add('�f�X�N�g�b�v�ɃV���[�g�J�b�g���쐬�ł��܂���ł����B');
      end;
      Result := True;
    except
			on e: Exception do begin
      	msg := '�M�R�i�r�X�V�V���[�g�J�b�g�̍쐬�Ɏ��s���܂����B' + #13#10 + e.Message;
    		GikoUtil.MsgBox(Handle, PChar(msg), '�X�V�G���[', MB_OK or MB_ICONERROR);
	    	Result := False;
	    end;
    end;

  finally
		fileStrem.Free;
    CheckButton.Enabled := True;
    CloseButton.Enabled := True;
  end;
end;

//! �_�E�����[�h�����t�@�C���̕ۑ��p�X
function  TUpdateCheckForm.GetDownloadFilePath(FileName: String): String;
var
    TempPath: array[0..MAX_PATH] of Char;
begin
    GetTempPath(MAX_PATH, TempPath);
    Result := IncludeTrailingPathDelimiter(TempPath) + FileName;
end;


//! �f�X�N�g�b�v�̃p�X���擾����֐�
function  TUpdateCheckForm.GetDesktopDir:string;
var
    DeskTopPath: array[0..MAX_PATH] of Char;
    pidl: PItemIDList;
begin
    SHGetSpecialFolderLocation(Application.Handle, CSIDL_DESKTOP, pidl);
    SHGetPathFromIDList(pidl, DesktopPath);
    Result := DesktopPath;
end;

//! �V���[�g�J�b�g���쐬����֐�
function  TUpdateCheckForm.CreateShortCut(FileName, Argment, SavePath :string):boolean;
//FileName�c�V���[�g�J�b�g���쐬����t�@�C����
//SavePath�c.lnk�t�@�C�����쐬����f�B���N�g��
var
    SL :IShelllink;
    PF :IPersistFile;
    wFileName :WideString;
begin
    Result :=false;
    //IUnKnown�I�u�W�F�N�g���쐬���āAIShellLink�ɃL���X�g
    SL :=CreateComObject(CLSID_ShellLink) as IShellLink;
    //IPersistFile �ɃL���X�g
    PF :=SL as IPersistFile;

    if (SL.SetPath(PChar(FileName)) <> NOERROR) then begin
        Exit;
    end;
    if (SL.SetWorkingDirectory(PChar(ExtractFilePath(FileName)))
                                   <> NOERROR ) then begin
        Exit;
    end;
    if (SL.SetArguments(PChar(Argment)) <> NOERROR) then begin
        Exit;
    end;
    if (SL.SetDescription(PChar('�M�R�i�r�X�V')) <> NOERROR) then begin
        Exit;
    end;

    //IPersistFile��Save���\�b�h�ɂ�PWChar�^�̃p�����[�^���K�v
    wFileName :=SavePath +'\�M�R�i�r�X�V.lnk';
    //�V���[�g�J�b�g���쐬
    if (PF.Save(PWChar(wFileName),True) <> NOERROR) then begin
        Exit;
    end;
    Result :=true;
end;

//! �L�����Z���{�^������
procedure TUpdateCheckForm.CancelBitBtnClick(Sender: TObject);
begin
  CancelBitBtn.Enabled := False;
  FCanceled := True;
  if IdHTTP.Connected then begin
		IdHTTP.Disconnect;
  end;
end;

//! ����{�^���N���b�N
procedure TUpdateCheckForm.CloseButtonClick(Sender: TObject);
begin
	Close;
end;

//! �t�H�[���N���[�Y�m�F
procedure TUpdateCheckForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
	CanClose := CloseButton.Enabled or FAllowshutdown;
end;




////////////////////////////////////////////////////////////////////////////////

//! �o�[�W�������N���X�R���X�g���N�^
constructor VersionNumber.Create;
begin
  Clear;
end;

//! �o�[�W�������N���X�R���X�g���N�^
constructor VersionNumber.Create(ASrc: String; AURL: String);
begin
	SetValue(ASrc, AURL);
end;

//! �N���A
procedure VersionNumber.Clear;
begin
  FValue1  := 0;
  FValue2  := 0;
  FValue3  := 0;
  FValue4  := 0;
  FVersion := '';
  FURL     := '';
end;

//! �o�[�W�������Z�b�g
function VersionNumber.SetValue(AVer: String; AURL: String): Boolean;
var
	split: TStringList;
begin
  FValue1  := 0;
  FValue2  := 0;
  FValue3  := 0;
  FValue4  := 0;
  FVersion := Trim(AVer);
  FURL     := Trim(AURL);

  split := TStringList.Create;
  try
		split.Text := MojuUtils.CustomStringReplace(AVer, '.', #10, false);
    if split.Count > 0 then
		  FValue1 := StrToIntDef(split[0], 0);
    if split.Count > 1 then
		  FValue2 := StrToIntDef(split[1], 0);
    if split.Count > 2 then
		  FValue3 := StrToIntDef(split[2], 0);
    if split.Count > 3 then
		  FValue4 := StrToIntDef(split[3], 0);
  finally
  	split.Free;
  end;

	Result := IsGood;
end;

//! ����l�m�F
function VersionNumber.IsGood: Boolean;
begin
  Result := (FValue1 > 0) and (FValue2 > 0) and (FValue3 >= 0) and (FValue4 > 0);
end;

//! �����ł��ǂ���
function VersionNumber.IsFormal: Boolean;
begin
  Result := (FValue1 > 0) and (FValue2 > 0) and (FValue3 = 1) and (FValue4 > 0);
end;

//! ���g�̕����V�����o�[�W�������m�F
function VersionNumber.IsSelfNew(const AOther: VersionNumber; ANightly: Boolean): Boolean;
begin
  if ANightly then
  	Result := FValue4 > AOther.FValue4
  else
    Result := (FValue1 > AOther.FValue1) or
            	((FValue1 = AOther.FValue1) and (FValue2 > AOther.FValue2)) or
            	((FValue1 = AOther.FValue1) and (FValue2 = AOther.FValue2)) and (FValue3 > AOther.FValue3);
end;

end.
