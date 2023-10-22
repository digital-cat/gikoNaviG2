unit IndyModule;

interface

uses
  SysUtils, Classes, Windows, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze, IdHTTP;

type
  TIndyMdl = class(TDataModule)
    { TIdAntiFreeze�̓v���Z�X���ɃC���X�^���X1�̂� }
    IdAntiFreeze: TIdAntiFreeze;
  private
    { Private �錾 }
    function GetFileVersion(path: String): String;
  public
    { Public �錾 }
    function StartAntiFreeze(IdleTimeOut : Integer): Boolean;
    function EndAntiFreeze: Boolean;
    function MakeRangeHeader(RangeStart : Integer; RangeEnd : Integer): String;
    function GetIndyVersion: String;
    function GetOpenSSLVersion: String;
    //function GetOpenSSLInfo: String;

    class procedure InitHTTP(IdHTTP: TIdHTTP; WriteMethod: Boolean = False); static;
    class procedure ClearHTTP(idHTTP: TIdHTTP); static;
  end;

var
  IndyMdl: TIndyMdl;

implementation

uses
  GikoSystem;

{$R *.dfm}

function TIndyMdl.StartAntiFreeze(IdleTimeOut : Integer): Boolean;
begin
  try
    IdAntiFreeze.Active := False;
    IdAntiFreeze.IdleTimeOut := IdleTimeOut;
    IdAntiFreeze.Active := True;
    Result := True;
  except
    Result := False;
  end;
end;

function TIndyMdl.EndAntiFreeze: Boolean;
begin
  try
    IdAntiFreeze.Active := False;
    Result := True;
  except
    Result := False;
  end;
end;

{ HTTP���N�G�X�g�w�b�_ 'Range' �̐ݒ�l�쐬 }
function TIndyMdl.MakeRangeHeader(RangeStart : Integer; RangeEnd : Integer): String;
begin
  if RangeEnd <> 0 then begin
    Result := 'bytes=' + IntToStr(RangeStart) + '-' + IntToStr(RangeEnd);
  end else begin
    Result := 'bytes=' + IntToStr(RangeStart) + '-';
  end;
end;

{ Indy�o�[�W�����擾 }
function TIndyMdl.GetIndyVersion: String;
begin
  Result := IdAntiFreeze.Version;
end;

{ ���W���[���̃t�@�C���o�[�W�����擾 }
function TIndyMdl.GetFileVersion(path: String): String;
type
  LANGANDCODEPAGE = record
    wLanguage : WORD;
    wCodePage : WORD;
  end;
  PLANGANDCODEPAGE = ^LANGANDCODEPAGE;
var
  dwHandle: DWORD;
  dwSize: DWORD;
  lpData: Pointer;
  uLen: UINT;
  lpTranslate: PLANGANDCODEPAGE;
  subBlock: AnsiString;
  lpFileVersion: Pointer;
begin
  Result := '�G���[';

  try
    dwSize := GetFileVersionInfoSize(PAnsiChar(path), dwHandle);
    if dwSize = 0 then
      Exit;

    GetMem(lpData, dwSize);
    try
      if GetFileVersionInfo(PAnsiChar(path), dwHandle, dwSize, lpData) = False then
        Exit;
      if VerQueryValue(lpData, PAnsiChar('\VarFileInfo\Translation'), Pointer(lpTranslate), uLen) = False then
        Exit;

      subBlock := Format('\StringFileInfo\%s%s\FileVersion',
                          [IntToHex(lpTranslate.wLanguage, 4), IntToHex(lpTranslate.wCodePage, 4)]);

      if VerQueryValue(lpData, PAnsiChar(subBlock), lpFileVersion, uLen) = False then
        Exit;

      Result := PAnsiChar(lpFileVersion);

    finally
      FreeMem(lpData, dwSize);
    end;

  except
    on ex: Exception do begin
      Result := ex.Message;
    end;
  end;
end;

{ OpenSSL�o�[�W�����擾 }
function TIndyMdl.GetOpenSSLVersion: String;
begin
  Result := GetFileVersion('ssleay32.dll');
end;

{ TIdHTTP�R���|�[�l���g�N���A }
class procedure TIndyMdl.ClearHTTP(IdHTTP: TIdHTTP);
begin
  IdHTTP.Request.CustomHeaders.Clear;
  IdHTTP.Request.RawHeaders.Clear;
  IdHTTP.Request.Clear;
  IdHTTP.Response.CustomHeaders.Clear;
  IdHTTP.Response.RawHeaders.Clear;
  IdHTTP.Response.Clear;
  IdHTTP.ProxyParams.Clear;
  IdHTTP.ProxyParams.BasicAuthentication := False;
end;

{ TIdHTTP�R���|�[�l���g������ }
class procedure TIndyMdl.InitHTTP(IdHTTP: TIdHTTP; WriteMethod: Boolean = False);
begin
  IdHTTP.Disconnect;
  ClearHTTP(IdHTTP);

	IdHTTP.Request.UserAgent := GikoSys.GetUserAgent;
  IdHTTP.ReadTimeout       := GikoSys.Setting.ReadTimeOut;
  IdHTTP.ConnectTimeout    := GikoSys.Setting.ReadTimeOut;

	{$IFDEF DEBUG}
	Writeln('------------------------------------------------------------');
	{$ENDIF}

  if WriteMethod and GikoSys.Setting.WriteProxy then begin
    if GikoSys.Setting.ProxyProtocol then
      IdHTTP.ProtocolVersion := pv1_1
    else
      IdHTTP.ProtocolVersion := pv1_0;
    IdHTTP.ProxyParams.ProxyServer   := GikoSys.Setting.WriteProxyAddress;
    IdHTTP.ProxyParams.ProxyPort     := GikoSys.Setting.WriteProxyPort;
    IdHTTP.ProxyParams.ProxyUsername := GikoSys.Setting.WriteProxyUserID;
    IdHTTP.ProxyParams.ProxyPassword := GikoSys.Setting.WriteProxyPassword;
    if GikoSys.Setting.ReadProxyUserID <> '' then
      IdHTTP.ProxyParams.BasicAuthentication := True;

		{$IFDEF DEBUG}
		Writeln('�������ݗp�v���L�V�ݒ肠��');
		Writeln('�z�X�g: ' + GikoSys.Setting.WriteProxyAddress);
		Writeln('�|�[�g: ' + IntToStr(GikoSys.Setting.WriteProxyPort));
		{$ENDIF}

  end else if not WriteMethod and GikoSys.Setting.ReadProxy then begin
    if GikoSys.Setting.ProxyProtocol then
      IdHTTP.ProtocolVersion := pv1_1
    else
      IdHTTP.ProtocolVersion := pv1_0;
    IdHTTP.ProxyParams.ProxyServer   := GikoSys.Setting.ReadProxyAddress;
    IdHTTP.ProxyParams.ProxyPort     := GikoSys.Setting.ReadProxyPort;
    IdHTTP.ProxyParams.ProxyUsername := GikoSys.Setting.ReadProxyUserID;
    IdHTTP.ProxyParams.ProxyPassword := GikoSys.Setting.ReadProxyPassword;
    if GikoSys.Setting.ReadProxyUserID <> '' then
      IdHTTP.ProxyParams.BasicAuthentication := True;

		{$IFDEF DEBUG}
		Writeln('�_�E�����[�h�p�v���L�V�ݒ肠��');
		Writeln('�z�X�g: ' + GikoSys.Setting.ReadProxyAddress);
		Writeln('�|�[�g: ' + IntToStr(GikoSys.Setting.ReadProxyPort));
		{$ENDIF}

  end else begin
    if GikoSys.Setting.Protocol then
      IdHTTP.ProtocolVersion := pv1_1
    else
      IdHTTP.ProtocolVersion := pv1_0;
    IdHTTP.ProxyParams.ProxyServer   := '';
    IdHTTP.ProxyParams.ProxyPort     := 80;
    IdHTTP.ProxyParams.ProxyUsername := '';
    IdHTTP.ProxyParams.ProxyPassword := '';

		{$IFDEF DEBUG}
		Writeln('�v���L�V�ݒ�Ȃ�');
		{$ENDIF}
  end;
end;

end.
