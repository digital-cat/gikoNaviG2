unit IndyModule;

interface

uses
  SysUtils, Classes, Windows, Forms, StrUtils, IdBaseComponent, IdAntiFreezeBase,
  IdAntiFreeze, IdHTTP, IdGlobal, IdCookie, IdURI;

type
  TIndyMdl = class(TDataModule)
    { TIdAntiFreeze�̓v���Z�X���ɃC���X�^���X1�̂� }
    IdAntiFreeze: TIdAntiFreeze;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private �錾 }
    FCookieCollection: TIdCookies;

    function GetFileVersion(path: String): String;
    function GetCookieFilePath: String;
    function GetCookieValue(text, name: String): String;
    procedure AddServerCookie(const ACookie: String; AURL: TIdURI);
    procedure DelCookies(delFlgs: array of Boolean);
    function GetCookieCount: Integer;
  public
    { Public �錾 }
    function StartAntiFreeze(IdleTimeOut : Integer): Boolean;
    function EndAntiFreeze: Boolean;
    function MakeRangeHeader(RangeStart : Integer; RangeEnd : Integer): String;
    function GetIndyVersion: String;
    function GetOpenSSLVersion: String;
    //function GetOpenSSLInfo: String;
    procedure SaveCookies(idHTTP: TIdHTTP; is2ch: Boolean = False; handle: HWND = 0);
    function GetCookieString(uri: TIdURI): String;
    procedure GetCookieList(uri: TIdURI; names, values: TStringList);
    procedure DelCookie(name: String; url: String);
    procedure SetCookieValue(name, url, value: String);
    procedure Serialize;
    procedure Deserialize;
    function GetCookie(index: integer): TIdCookie;

    function IsDonguriCookie(cookie: TIdCookie): Boolean;
    function IsUpliftCookie(cookie: TIdCookie): Boolean;
    function IsBeCookie(cookie: TIdCookie): Boolean;
    function IsTakoCookie(cookie: TIdCookie): Boolean;
    function HasTakoCookie: Boolean;

		function GetDonguriCookieValue: String;
    procedure DelDonguriCookie;
    procedure DelUpliftCookie;
    procedure DelBeCookie;

    property CookieCount: Integer read GetCookieCount;

    class procedure InitHTTP(IdHTTP: TIdHTTP; WriteMethod: Boolean = False); static;
    class procedure ClearHTTP(idHTTP: TIdHTTP); static;
  end;

var
  IndyMdl: TIndyMdl;

implementation

uses
  GikoSystem, DmSession5ch, GikoUtil, GikoDataModule;

const
	URL_5CH_ROOT   = 'https://5ch.net/';
	DOMAIN_5CH     = '5ch.net';
  COOKIE_DONGURI = 'acorn';
	COOKIE_UPLIFT  = 'sid';
	COOKIE_BE1     = 'DMDM';
	COOKIE_BE2     = 'MDMD';
	COOKIE_TAKO    = 'TAKO';

{$R *.dfm}

procedure TIndyMdl.DataModuleCreate(Sender: TObject);
begin
	FCookieCollection := TIdCookies.Create(Self);
	Deserialize;	// Cookie�ǂݍ���
end;


procedure TIndyMdl.DataModuleDestroy(Sender: TObject);
begin
	Serialize;	// Cookie�ۑ�
	FCookieCollection.Free;
end;

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

  if GikoSys.Setting.ProxyProtocol then
    IdHTTP.ProtocolVersion := pv1_1
  else
    IdHTTP.ProtocolVersion := pv1_0;

  if WriteMethod and GikoSys.Setting.WriteProxy then begin
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
    IdHTTP.ProxyParams.ProxyServer   := '';
    IdHTTP.ProxyParams.ProxyPort     := 80;
    IdHTTP.ProxyParams.ProxyUsername := '';
    IdHTTP.ProxyParams.ProxyPassword := '';

		{$IFDEF DEBUG}
		Writeln('�v���L�V�ݒ�Ȃ�');
		{$ENDIF}
  end;
end;

{ Cookie�����擾 }
function TIndyMdl.GetCookieCount: Integer;
begin
	Result := FCookieCollection.Count;
end;

{ Cookie�擾 }
function TIndyMdl.GetCookie(index: integer): TIdCookie;
begin
	Result := TIdCookie(FCookieCollection.Items[index]);
end;

{ ���X�g�ɃT�[�o�����Cookie��o�^ }
procedure TIndyMdl.AddServerCookie(const ACookie: String; AURL: TIdURI);
var
  LCookie: TIdCookie;
begin
  LCookie := FCookieCollection.Add;
  try
    if LCookie.ParseServerCookie(ACookie, AURL) and
       FCookieCollection.AddCookie(LCookie, AURL) then
      LCookie := nil;
  finally
    if LCookie <> nil then begin
      LCookie.Collection := nil;
      LCookie.Free;
    end;
  end;
end;

{ ���X�|���XCookie�����X�g�ɕۑ� }
procedure TIndyMdl.SaveCookies(idHTTP: TIdHTTP; is2ch: Boolean = False; handle: HWND = 0);
var
  //dst: TextFile;	// debug
  //path: String;		// debug
  i: Integer;
	cookie: TIdCookie;
begin
	//path := ChangeFileExt(Application.ExeName, '.cookies');	// debug

  try
    // debug
    //AssignFile(dst, path);
    //if FileExists(path) then
    //  Append(dst)
    //else
    //  Rewrite(dst);
    ///
		//Writeln(dst, '========================================================');
		//Writeln(dst, idHTTP.URL.URI);
		//Writeln(dst, idHTTP.Request.Method);
		//Writeln(dst, '----');
    // debug

    for i := 0 to idHTTP.CookieManager.CookieCollection.Count - 1 do begin
			cookie := TIdCookie(idHTTP.CookieManager.CookieCollection.Items[i]);

    	if is2ch and (handle <> 0) and
         IsTakoCookie(cookie) and							// TAKO���󂯎����
         (HasTakoCookie = False) then begin		// ���܂�TAKO�������Ă��Ȃ�����
         if GikoUtil.MsgBox(handle,
         				Format('%s=%s ���󂯎��܂����B', [cookie.CookieName, cookie.Value]) + #10 +
         				'�j�����܂����H', 'Cookie�Ǘ�', MB_YESNO or MB_ICONWARNING) = IDYES then
         	Continue;		// �ۑ����Ȃ�
      end;

    	AddServerCookie(cookie.CookieText, idHTTP.URL);

	    // debug
			//Writeln(dst, cookie.CookieText);
			//Writeln(dst, '----');
	    // debug
    end;

  finally
		//CloseFile(dst);	// debug
  end;
end;

{ ���N�G�X�g�pCookie������擾 }
function TIndyMdl.GetCookieString(uri: TIdURI): String;
var
	i: Integer;
	cookie: TIdCookie;
  del: array of Boolean;
begin
	try
    SetLength(del, FCookieCollection.Count);

    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
			del[i] := cookie.IsExpired;
      if (not del[i]) and IsDomainMatch(uri.Host, cookie.Domain) then
				Result := Result + cookie.CookieName + '=' + cookie.Value + '; ';
    end;

    DelCookies(del);
  except
  end;
end;

{ ���N�G�X�g�pCookie��StringList�Ŏ擾 }
procedure TIndyMdl.GetCookieList(uri: TIdURI; names, values: TStringList);
var
	i: Integer;
	cookie: TIdCookie;
  del: array of Boolean;
begin
	try
    SetLength(del, FCookieCollection.Count);

    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
			del[i] := cookie.IsExpired;
      if (not del[i]) and IsDomainMatch(uri.Host, cookie.Domain) then begin
      	names.Add(cookie.CookieName);
        values.Add(cookie.Value);
      end;
    end;

    DelCookies(del);
  except
  end;
end;

{ Cookie�폜 }
procedure TIndyMdl.DelCookie(name: String; url: String);
var
	i: Integer;
	cookie: TIdCookie;
  del: array of Boolean;
  uri: TIdURI;
begin
  uri := TIdURI.Create(url);
	try
    SetLength(del, FCookieCollection.Count);

    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
			del[i] := cookie.IsExpired;
      if (not del[i]) and
      	 IsDomainMatch(uri.Host, cookie.Domain) and
         (cookie.CookieName = name) then
      	del[i] := True;
    end;

    DelCookies(del);
  finally
    uri.Free;
  end;
end;

{ �폜�Ώ�Cookie�S�폜 }
procedure TIndyMdl.DelCookies(delFlgs: array of Boolean);
var
	i: Integer;
	cookie: TIdCookie;
  uplift: Boolean;
begin
	try
  	// UPLIFT���O�C���ς݂̏ꍇ�̓Z�b�V����ID�����؂�m�F���s��
  	uplift := Session5ch.Connected;

    for i := FCookieCollection.Count - 1 downto 0 do begin
      if delFlgs[i] then begin
        if uplift then begin
          cookie := TIdCookie(FCookieCollection.Items[i]);
          if (cookie.Domain = DOMAIN_5CH) and (cookie.CookieName = COOKIE_UPLIFT) then begin
          	GikoDM.LoginAction.Execute;		// UPLIFT�����O�A�E�g������
            uplift := False;	// ����ȍ~��UPLIFT�`�F�b�N�s�v
          end;
        end;
	    	FCookieCollection.Delete(i);
      end;
    end;
  except
  end;
end;

{ Cookie�̒l���Z�b�g }
procedure TIndyMdl.SetCookieValue(name, url, value: String);
var
	i: Integer;
	cookie: TIdCookie;
  del: array of Boolean;
  uri: TIdURI;
begin
  uri := TIdURI.Create(url);
	try
    SetLength(del, FCookieCollection.Count);

    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
			del[i] := cookie.IsExpired;
      if (not del[i]) and
      	 IsDomainMatch(uri.Host, cookie.Domain) and
         (cookie.CookieName = name) then
      	cookie.Value := value;
    end;

    DelCookies(del);
  finally
    uri.Free;
  end;
end;

{ �ǂ񂮂�Cookie�l�擾 }
function TIndyMdl.GetDonguriCookieValue: String;
var
	i: Integer;
	cookie: TIdCookie;
  del: array of Boolean;
  uri: TIdURI;
begin
	Result := '';
  uri := TIdURI.Create(URL_5CH_ROOT);
	try
    SetLength(del, FCookieCollection.Count);

    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
			del[i] := cookie.IsExpired;
      if (not del[i]) and
      	 IsDomainMatch(uri.Host, cookie.Domain) and
         (cookie.CookieName = COOKIE_DONGURI) then
      	Result := cookie.Value;
    end;

    DelCookies(del);
  finally
    uri.Free;
  end;
end;

{ �ǂ񂮂�Cookie�폜 }
procedure TIndyMdl.DelDonguriCookie;
begin
	DelCookie(COOKIE_DONGURI, URL_5CH_ROOT);
end;

{ UPLIFT Cookie�폜 }
procedure TIndyMdl.DelUpliftCookie;
begin
	DelCookie(COOKIE_UPLIFT, URL_5CH_ROOT);
end;

{ Be Cookie�폜 }
procedure TIndyMdl.DelBeCookie;
begin
	DelCookie(COOKIE_BE1, URL_5CH_ROOT);
	DelCookie(COOKIE_BE2, URL_5CH_ROOT);
end;


function TIndyMdl.IsDonguriCookie(cookie: TIdCookie): Boolean;
begin
	Result := (cookie.Domain = DOMAIN_5CH) and (cookie.Path = '/') and (cookie.CookieName = COOKIE_DONGURI);
end;

function TIndyMdl.IsUpliftCookie(cookie: TIdCookie): Boolean;
begin
	Result := (cookie.Domain = DOMAIN_5CH) and (cookie.Path = '/') and (cookie.CookieName = COOKIE_UPLIFT);
end;

function TIndyMdl.IsBeCookie(cookie: TIdCookie): Boolean;
begin
	Result := (cookie.Domain = DOMAIN_5CH) and (cookie.Path = '/') and ((cookie.CookieName = COOKIE_BE1) or (cookie.CookieName = COOKIE_BE2));
end;

function TIndyMdl.IsTakoCookie(cookie: TIdCookie): Boolean;
begin
	Result := (cookie.Domain = DOMAIN_5CH) and (cookie.Path = '/') and (cookie.CookieName = COOKIE_TAKO);
end;

{ TAKO�������Ă��邩�ǂ����i�����؂�`�F�b�N�Ȃ��j }
function TIndyMdl.HasTakoCookie: Boolean;
var
	i: Integer;
	cookie: TIdCookie;
  uri: TIdURI;
begin
	Result := False;
  uri := TIdURI.Create(URL_5CH_ROOT);
	try
    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
      if IsDomainMatch(uri.Host, cookie.Domain) and
         (cookie.CookieName = COOKIE_TAKO) then begin
      	Result := True;
        Break;
			end;
    end;
  finally
    uri.Free;
  end;
end;

{ Cookie�t�@�C���p�X�擾 }
function TIndyMdl.GetCookieFilePath: String;
begin
	Result := GikoSys.GetConfigDir + 'GikoNavi.cookies';
end;

{ Cookie�t�@�C���ۑ� }
procedure TIndyMdl.Serialize;
var
	i: Integer;
	cookie: TIdCookie;
  del: array of Boolean;
  dst: TStringList;
  path: String;
begin
  dst := TStringList.Create;

  try
    SetLength(del, FCookieCollection.Count);

  	path := GetCookieFilePath;

    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
			del[i] := cookie.IsExpired;
      if (not del[i]) and ((cookie.Domain <> DOMAIN_5CH) or (cookie.CookieName <> COOKIE_UPLIFT)) then	// UPLIFT�̃Z�b�V����ID�͕ۑ����Ȃ�
				dst.Add(cookie.CookieText);
    end;

    dst.SaveToFile(path);

    DelCookies(del);
  finally
    dst.Free;
  end;
end;

{ �t�@�C������Cookie�ǂݍ��� }
procedure TIndyMdl.Deserialize;
var
	i: Integer;
  src: TStringList;
  path: String;
  text: String;
	uriDomain: String;
  uriPath: String;
  uri: TIdURI;
begin
  src := TStringList.Create;

  try
  	FCookieCollection.Clear;

  	path := GetCookieFilePath;
    if not FileExists(path) then
    	Exit;
    src.LoadFromFile(path);

    for i := 0 to src.Count - 1 do begin
      text := src.Strings[i];
      uriDomain := GetCookieValue(text, 'Domain');
      uriPath := GetCookieValue(text, 'Path');
      if uriDomain = '' then
        Continue;
      uri := TIdURI.Create('https://' + uriDomain + uriPath);
      try
        AddServerCookie(text, uri);
      finally
        uri.Free;
      end;
    end;
  finally
    src.Free;
  end;
end;

{ CookieText����w�荀�ڂ̒l���擾 }
function TIndyMdl.GetCookieValue(text, name: String): String;
var
  idx1: Integer;
  idx2: Integer;
  key: String;
begin
	Result := '';
	key := name + '=';
  idx1 := Pos(key, text);
  if idx1 > 0 then begin
    idx1 := idx1 + Length(key);
    idx2 := PosEx(';', text, idx1);
    if idx2 > 0 then
      Result := Copy(text, idx1, idx2 - idx1);
  end;
end;

end.
