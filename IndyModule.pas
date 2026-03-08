unit IndyModule;

interface

uses
  SysUtils, Classes, Windows, Forms, StrUtils, IdBaseComponent, IdAntiFreezeBase,
  IdAntiFreeze, IdHTTP, IdGlobal, IdCookie, IdURI, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;
  
type
  TIndyMdl = class(TDataModule)
    { TIdAntiFreezeはプロセス内にインスタンス1つのみ }
    IdAntiFreeze: TIdAntiFreeze;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private 宣言 }
    FCookieCollection: TIdCookies;

    function GetFileVersion(path: String): String;
    function GetCookieFilePath: String;
    function GetCookieValueFromText(text, name: String): String;
    function DelCookieValueFromText(text, name: String): String;
    procedure RepDomainInCookieText(var text: String);
    procedure AddServerCookie(const ACookie: String; AURL: TIdURI);
    procedure DelCookies(delFlgs: array of Boolean; chkUplift: Boolean = True);
    function GetCookieCount: Integer;
    function ChkExpired(cookie: TIdCookie): Boolean;
  public
    { Public 宣言 }
    function StartAntiFreeze(IdleTimeOut : Integer): Boolean;
    function EndAntiFreeze: Boolean;
    function MakeRangeHeader(RangeStart : Integer; RangeEnd : Integer): String;
    function GetIndyVersion: String;
    function GetOpenSSLVersion: String;
    //function GetOpenSSLInfo: String;
    procedure SaveCookies(idHTTP: TIdHTTP; is2ch: Boolean = False; handle: HWND = 0);
    function GetCookieString(uri: TIdURI): String;
    procedure GetCookieList(uri: TIdURI; names, values: TStringList);
    procedure DelCookie(name: String; url: String; chkUplift: Boolean = True);
    procedure SetCookieValue(name, url, value: String);
    function  GetCookieValue(name, url: String): String;
    procedure Serialize;
    procedure Deserialize;
    function GetCookie(index: integer): TIdCookie;

    function IsDonguriCookie(cookie: TIdCookie): Boolean;
    function IsUpliftCookie(cookie: TIdCookie): Boolean;
    function IsBeCookie(cookie: TIdCookie): Boolean;
    function IsTakoCookie(cookie: TIdCookie): Boolean;
    function HasTakoCookie: Boolean;

		function GetDonguriCookieValue: String;
		function GetUpliftCookieValue: String;
    procedure DelDonguriCookie;
    procedure DelUpliftCookie;
    procedure DelBeCookie;
    procedure DelMonaTicketCookie;
    procedure DelExpiredCookie;

    property CookieCount: Integer read GetCookieCount;
    property UpliftCookieValue: String read GetUpliftCookieValue;

    class procedure InitHTTP(IdHTTP: TIdHTTP; WriteMethod: Boolean = False); static;
    class procedure ClearHTTP(idHTTP: TIdHTTP); static;
  end;

var
  IndyMdl: TIndyMdl;

implementation

uses
  GikoSystem, DmSession5ch, GikoUtil, GikoDataModule;

const
//	URL_5CH_ROOT   = 'https://5ch.net/';
//	URL_UPL_ROOT   = 'https://uplift.5ch.net/';
//	DOMAIN_5CH     = '5ch.net';
//	DOMAIN_UPLIFT  = 'uplift.5ch.net';
	URL_5CH_ROOT   = 'https://5ch.io/';
	URL_UPL_ROOT   = 'https://uplift.5ch.io/';
	DOMAIN_5CH     = '5ch.io';
	DOMAIN_UPLIFT  = 'uplift.5ch.io';
  COOKIE_DONGURI = 'acorn';
	COOKIE_UPLIFT1 = 'sid';
	COOKIE_UPLIFT2 = 'eid';
	COOKIE_BE1     = 'DMDM';
	COOKIE_BE2     = 'MDMD';
	COOKIE_TAKO    = 'TAKO';
  COOKIE_MTICKET = 'MonaTicket';

{$R *.dfm}

procedure TIndyMdl.DataModuleCreate(Sender: TObject);
begin
	FCookieCollection := TIdCookies.Create(Self);
	Deserialize;	// Cookie読み込み
end;


procedure TIndyMdl.DataModuleDestroy(Sender: TObject);
begin
	Serialize;	// Cookie保存
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

{ HTTPリクエストヘッダ 'Range' の設定値作成 }
function TIndyMdl.MakeRangeHeader(RangeStart : Integer; RangeEnd : Integer): String;
begin
  if RangeEnd <> 0 then begin
    Result := 'bytes=' + IntToStr(RangeStart) + '-' + IntToStr(RangeEnd);
  end else begin
    Result := 'bytes=' + IntToStr(RangeStart) + '-';
  end;
end;

{ Indyバージョン取得 }
function TIndyMdl.GetIndyVersion: String;
begin
  Result := IdAntiFreeze.Version;
end;

{ モジュールのファイルバージョン取得 }
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
  Result := 'エラー';

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

{ OpenSSLバージョン取得 }
function TIndyMdl.GetOpenSSLVersion: String;
const
{$IFDEF OPENSSL3}
  OPENSSL_DLL_NAME : String = 'libssl-3.dll';
{$ELSE}
  OPENSSL_DLL_NAME : String = 'ssleay32.dll';
{$ENDIF}
begin
  Result := GetFileVersion(OPENSSL_DLL_NAME);
end;

{ TIdHTTPコンポーネントクリア }
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

{ TIdHTTPコンポーネント初期化 }
class procedure TIndyMdl.InitHTTP(IdHTTP: TIdHTTP; WriteMethod: Boolean = False);
var
  protocol: Boolean;
{$IFDEF OPENSSL3}
  ssl: TIdSSLIOHandlerSocketOpenSSL;
{$ENDIF}
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
    protocol := GikoSys.Setting.ProxyProtocol;
    IdHTTP.ProxyParams.ProxyServer   := GikoSys.Setting.WriteProxyAddress;
    IdHTTP.ProxyParams.ProxyPort     := GikoSys.Setting.WriteProxyPort;
    IdHTTP.ProxyParams.ProxyUsername := GikoSys.Setting.WriteProxyUserID;
    IdHTTP.ProxyParams.ProxyPassword := GikoSys.Setting.WriteProxyPassword;
    if GikoSys.Setting.ReadProxyUserID <> '' then
      IdHTTP.ProxyParams.BasicAuthentication := True;

		{$IFDEF DEBUG}
		Writeln('書き込み用プロキシ設定あり');
		Writeln('ホスト: ' + GikoSys.Setting.WriteProxyAddress);
		Writeln('ポート: ' + IntToStr(GikoSys.Setting.WriteProxyPort));
		{$ENDIF}

  end else if not WriteMethod and GikoSys.Setting.ReadProxy then begin
    protocol := GikoSys.Setting.ProxyProtocol;
    IdHTTP.ProxyParams.ProxyServer   := GikoSys.Setting.ReadProxyAddress;
    IdHTTP.ProxyParams.ProxyPort     := GikoSys.Setting.ReadProxyPort;
    IdHTTP.ProxyParams.ProxyUsername := GikoSys.Setting.ReadProxyUserID;
    IdHTTP.ProxyParams.ProxyPassword := GikoSys.Setting.ReadProxyPassword;
    if GikoSys.Setting.ReadProxyUserID <> '' then
      IdHTTP.ProxyParams.BasicAuthentication := True;

		{$IFDEF DEBUG}
		Writeln('ダウンロード用プロキシ設定あり');
		Writeln('ホスト: ' + GikoSys.Setting.ReadProxyAddress);
		Writeln('ポート: ' + IntToStr(GikoSys.Setting.ReadProxyPort));
		{$ENDIF}

  end else begin
    protocol := GikoSys.Setting.Protocol;
    IdHTTP.ProxyParams.ProxyServer   := '';
    IdHTTP.ProxyParams.ProxyPort     := 80;
    IdHTTP.ProxyParams.ProxyUsername := '';
    IdHTTP.ProxyParams.ProxyPassword := '';

		{$IFDEF DEBUG}
		Writeln('プロキシ設定なし');
		{$ENDIF}
  end;

  if protocol then
    IdHTTP.ProtocolVersion := pv1_1
  else
    IdHTTP.ProtocolVersion := pv1_0;

  {$IFDEF OPENSSL3}
  if IdHTTP.IOHandler <> nil then begin
    ssl := TIdSSLIOHandlerSocketOpenSSL(IdHTTP.IOHandler);
    ssl.SSLOptions.SSLVersions := [sslvTLSv1_3];
    ssl.SSLOptions.Method := sslvTLSv1_3;
  end;
  {$ENDIF}
end;

{ Cookie件数取得 }
function TIndyMdl.GetCookieCount: Integer;
begin
	Result := FCookieCollection.Count;
end;

{ Cookie取得 }
function TIndyMdl.GetCookie(index: integer): TIdCookie;
begin
	Result := TIdCookie(FCookieCollection.Items[index]);
end;

{ リストにサーバからのCookieを登録 }
procedure TIndyMdl.AddServerCookie(const ACookie: String; AURL: TIdURI);
var
  LCookie: TIdCookie;
begin
  LCookie := FCookieCollection.Add;
  try
    if LCookie.ParseServerCookie(ACookie, AURL) and
       (not ChkExpired(LCookie)) and
       FCookieCollection.AddCookie(LCookie, AURL) then
      LCookie := nil;
  finally
    if LCookie <> nil then begin
      LCookie.Collection := nil;
      LCookie.Free;
    end;
  end;
end;

{ レスポンスCookieをリストに保存 }
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
         IsTakoCookie(cookie) and							// TAKOを受け取った
         (HasTakoCookie = False) then begin		// 今までTAKOを持っていなかった
         if GikoUtil.MsgBox(handle,
         				Format('%s=%s を受け取りました。', [cookie.CookieName, cookie.Value]) + #10 +
         				'破棄しますか？', 'Cookie管理', MB_YESNO or MB_ICONWARNING) = IDYES then
         	Continue;		// 保存しない
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

{ Cookie期限切れ確認 }
function TIndyMdl.ChkExpired(cookie: TIdCookie): Boolean;
var
  expr: TDateTime;
begin
  Result := cookie.IsExpired;

  if (not Result) and
     (GikoSys.Setting.DelMonaTicket >  0) and
     (GikoSys.Setting.DelMonaTicket <= 9) and
     (cookie.Expires   <> 0.0)            and
     (cookie.CookieName = COOKIE_MTICKET) and
     (cookie.Domain     = DOMAIN_5CH) then begin

    expr := cookie.Expires - GikoSys.Setting.DelMonaTicket;
    Result := (expr <= Now);
  end;
end;

{ リクエスト用Cookie文字列取得 }
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
			//del[i] := cookie.IsExpired;
			del[i] := ChkExpired(cookie);
      if (not del[i]) and IsDomainMatch(uri.Host, cookie.Domain) then
				Result := Result + cookie.CookieName + '=' + cookie.Value + '; ';
    end;

    DelCookies(del);
  except
  end;
end;

{ リクエスト用CookieをStringListで取得 }
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
			//del[i] := cookie.IsExpired;
			del[i] := ChkExpired(cookie);
      if (not del[i]) and IsDomainMatch(uri.Host, cookie.Domain) then begin
      	names.Add(cookie.CookieName);
        values.Add(cookie.Value);
      end;
    end;

    DelCookies(del);
  except
  end;
end;

{ Cookie削除 }
procedure TIndyMdl.DelCookie(name: String; url: String; chkUplift: Boolean = True);
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
			//del[i] := cookie.IsExpired;
			del[i] := ChkExpired(cookie);
      if (not del[i]) and
      	 IsDomainMatch(uri.Host, cookie.Domain) and
         (cookie.CookieName = name) then
      	del[i] := True;
    end;

    DelCookies(del, chkUplift);
  finally
    uri.Free;
  end;
end;

{ 期限切れCookie削除 }
procedure TIndyMdl.DelExpiredCookie;
var
	i: Integer;
	cookie: TIdCookie;
  del: array of Boolean;
begin
	try
    SetLength(del, FCookieCollection.Count);

    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
			del[i] := ChkExpired(cookie);
    end;

    DelCookies(del);
  except
  end;
end;

{ 削除対象Cookie全削除 }
procedure TIndyMdl.DelCookies(delFlgs: array of Boolean; chkUplift: Boolean = True);
var
	i: Integer;
	cookie: TIdCookie;
  upliftLogout: Boolean;
begin
	try
  	// UPLIFTログアウトさせるか
    upliftLogout := False;

    for i := FCookieCollection.Count - 1 downto 0 do begin
      if delFlgs[i] then begin
        if chkUplift and (not upliftLogout) then begin
          cookie := TIdCookie(FCookieCollection.Items[i]);
          if (cookie.Domain = DOMAIN_5CH) and (cookie.CookieName = COOKIE_UPLIFT1) then begin
            upliftLogout := True;
          end;
        end;
	    	FCookieCollection.Delete(i);
      end;
    end;

    if upliftLogout then begin
      Session5ch_Disconnect;
      GikoDM.UpliftLoginActionUpdate; // 画面側更新
    end;

  except
  end;
end;

{ Cookieの値をセット }
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
			//del[i] := cookie.IsExpired;
			del[i] := ChkExpired(cookie);
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

{ Cookie値取得 }
function TIndyMdl.GetCookieValue(name, url: String): String;
var
	i: Integer;
	cookie: TIdCookie;
  del: array of Boolean;
  uri: TIdURI;
begin
	Result := '';
  uri := TIdURI.Create(url);
	try
    SetLength(del, FCookieCollection.Count);

    for i := 0 to FCookieCollection.Count - 1 do begin
			cookie := TIdCookie(FCookieCollection.Items[i]);
			del[i] := ChkExpired(cookie);
      if (not del[i]) and
      	 IsDomainMatch(uri.Host, cookie.Domain) and
         (cookie.CookieName = name) then
      	Result := cookie.Value;
    end;

    DelCookies(del);
  finally
    uri.Free;
  end;
end;

{ どんぐりCookie値取得 }
function TIndyMdl.GetDonguriCookieValue: String;
begin
	Result := GetCookieValue(COOKIE_DONGURI, URL_5CH_ROOT);
end;

{ どんぐりCookie削除 }
procedure TIndyMdl.DelDonguriCookie;
begin
	DelCookie(COOKIE_DONGURI, URL_5CH_ROOT);
end;

{ UPLIFT Cookie値取得 }
function TIndyMdl.GetUpliftCookieValue: String;
begin
	Result := GetCookieValue(COOKIE_UPLIFT1, URL_5CH_ROOT);
end;

{ UPLIFT Cookie削除 }
procedure TIndyMdl.DelUpliftCookie;
begin
	DelCookie(COOKIE_UPLIFT1, URL_5CH_ROOT, False);
	DelCookie(COOKIE_UPLIFT2, URL_UPL_ROOT, False);
end;

{ Be Cookie削除 }
procedure TIndyMdl.DelBeCookie;
begin
	DelCookie(COOKIE_BE1, URL_5CH_ROOT);
	DelCookie(COOKIE_BE2, URL_5CH_ROOT);
end;

{ MonaTicket Cookie削除 }
procedure TIndyMdl.DelMonaTicketCookie;
begin
	DelCookie(COOKIE_MTICKET, URL_5CH_ROOT);
end;


function TIndyMdl.IsDonguriCookie(cookie: TIdCookie): Boolean;
begin
	Result := (cookie.Domain = DOMAIN_5CH) and (cookie.Path = '/') and (cookie.CookieName = COOKIE_DONGURI);
end;

function TIndyMdl.IsUpliftCookie(cookie: TIdCookie): Boolean;
begin
	Result := ((cookie.Domain = DOMAIN_5CH)    and (cookie.Path = '/') and (cookie.CookieName = COOKIE_UPLIFT1)) or
            ((cookie.Domain = DOMAIN_UPLIFT) and (cookie.Path = '/') and (cookie.CookieName = COOKIE_UPLIFT2));
end;

function TIndyMdl.IsBeCookie(cookie: TIdCookie): Boolean;
begin
	Result := (cookie.Domain = DOMAIN_5CH) and (cookie.Path = '/') and ((cookie.CookieName = COOKIE_BE1) or (cookie.CookieName = COOKIE_BE2));
end;

function TIndyMdl.IsTakoCookie(cookie: TIdCookie): Boolean;
begin
	Result := (cookie.Domain = DOMAIN_5CH) and (cookie.Path = '/') and (cookie.CookieName = COOKIE_TAKO);
end;

{ TAKOを持っているかどうか（期限切れチェックなし） }
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

{ Cookieファイルパス取得 }
function TIndyMdl.GetCookieFilePath: String;
begin
	Result := GikoSys.GetConfigDir + 'GikoNavi.cookies';
end;

{ Cookieファイル保存 }
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
			//del[i] := cookie.IsExpired;
			del[i] := ChkExpired(cookie);
      if not del[i] then
				dst.Add(cookie.CookieText);
    end;

    dst.SaveToFile(path);

    DelCookies(del);
  finally
    dst.Free;
  end;
end;

{ ファイルからCookie読み込み }
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
      text := DelCookieValueFromText(src.Strings[i], 'Max-Age');
      RepDomainInCookieText(text);
      uriDomain := GetCookieValueFromText(text, 'Domain');
      if uriDomain = '' then
        Continue;
      uriPath := GetCookieValueFromText(text, 'Path');
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

{ CookieTextから指定項目の値を取得 }
function TIndyMdl.GetCookieValueFromText(text, name: String): String;
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

{ CookieTextから指定項目を削除 }
function TIndyMdl.DelCookieValueFromText(text, name: String): String;
var
  items: TStringList;
  item : String;
  key  : String;
  i    : Integer;
begin
	Result := '';
	key := name + '=';
  items := TStringList.Create;
  try
    items.LineBreak := ';';
    items.Text := text;
    for i := 0 to items.Count - 1 do begin
      item := Trim(items.Strings[i]);
      if Pos(key, item) <> 1 then begin
        if Result <> '' then
          Result := Result + '; ';
        Result := Result + item;
      end;
    end;
  finally
    items.Free;
  end;
end;

{ CookieTextのドメインを置換 }
procedure TIndyMdl.RepDomainInCookieText(var text: String);
const
  DOMAIN_OLD: String = 'Domain=5ch.net;';
  DOMAIN_NEW: String = 'Domain=5ch.io;';
var
  idx : Integer;
begin
  idx := Pos(DOMAIN_OLD, text);
  if idx > 0 then begin
    Delete(text, idx, Length(DOMAIN_OLD));
    Insert(DOMAIN_NEW, text, idx);
  end;
end;

end.
