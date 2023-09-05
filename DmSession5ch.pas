unit DmSession5ch;

interface

uses
  SysUtils, Classes, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdCookieManager, IdCookie;

type
  TSession5ch = class(TDataModule)
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdCookieManager: TIdCookieManager;
  private
		FConnected:   Boolean;
		FSessionID:   string;
		FErrorCode:   Integer;
		FErrorString: string;
		FUserAgent:   string;

		function GetSessionID: string;
		function GetUserAgent: string;
		function GetErrorCode: Integer;
		function GetErrorMsg:  string;
    function Login: Boolean;
    procedure InitHTTP;
    procedure Clear;
  public
		constructor Create(AOwner: TComponent); reintroduce; virtual;
		destructor  Destroy; override;

		function  Connect:    Boolean;
		function  Disconnect: Boolean;

		property  Connected: Boolean read  FConnected;
		property  SessionID: string  read  GetSessionID;
		property  UserAgent: string  read  GetUserAgent;
		property  ErrorCode: Integer read  GetErrorCode;
		property  ErrorMsg:  string  read  GetErrorMsg;
  end;

var
  Session5ch: TSession5ch;

implementation

{$R *.dfm}

uses
  GikoSystem, YofUtils, IndyModule;

const
  LOGIN_5CH_URL     = 'https://uplift.5ch.net/log';
  LOGIN_5CH_REFERER = 'https://uplift.5ch.net/login';
  LOGIN_5GH_ACCEPT  = 'text/html,image/gif,image/x-xbitmap,image/jpeg,image/pjpeg,*/*';
  LOGIN_5CH_CNTTYPE = 'application/x-www-form-urlencoded';
  LOGIN_5CH_FORMFMT = 'usr=%s&pwd=%s&log=';
  LOGIN_5CH_SID     = 'sid';
  LOGIN_5CH_ERRMSG  = 'Error: ログインできませんでした。';


{ コンストラクタ }
constructor TSession5ch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Clear;
end;

{ デストラクタ }
destructor TSession5ch.Destroy;
begin
	if Connected then
		Disconnect;
  inherited Destroy;
end;

{ セッション情報クリア }
procedure TSession5ch.Clear;
begin
  FConnected   := False;
  FSessionID   := '';
  FErrorCode   := 0;
  FErrorString := '';
  FUserAgent   := '';
end;

{ ログイン }
function TSession5ch.Connect: Boolean;
begin
	Result := False;
	if not FConnected then begin
    Clear;
		if Login then
			Result := True
		else
			Disconnect;
	end;
end;

{ ログアウト }
function TSession5ch.Disconnect: Boolean;
begin
  Clear;
	Result := True;
end;

{ ログイン処理 }
function TSession5ch.Login: Boolean;
var
  SrcContent: TStringStream;
  ResContent: TMemoryStream;
  FormData: String;
  OK: Boolean;
  Idx: Integer;
  Sep: Integer;
  Cookie: TIdCookie;
begin
  Result := False;

  try
    FormData := Format(LOGIN_5CH_FORMFMT, [HttpEncode(GikoSys.Setting.UserID),
                                           HttpEncode(GikoSys.Setting.Password)]);
    SrcContent := TStringStream.Create(FormData);
    ResContent := TMemoryStream.Create;

    InitHTTP;

    IdHTTP.Request.AcceptLanguage := 'ja';
    IdHTTP.Request.Accept         := LOGIN_5GH_ACCEPT;
    IdHTTP.Request.ContentType    := LOGIN_5CH_CNTTYPE;
    IdHTTP.Request.Referer        := LOGIN_5CH_REFERER;

    OK := False;

    IndyMdl.StartAntiFreeze(100);
    try
      IdHTTP.Post(LOGIN_5CH_URL, SrcContent, ResContent);
      OK := True;
    except
      FErrorString := IdHTTP.ResponseText;
      FErrorCode   := IdHTTP.ResponseCode;
    end;
    IndyMdl.EndAntiFreeze;

    if SrcContent <> nil then
      SrcContent.Free;
    if ResContent <> nil then
      ResContent.Free;

    if not OK then begin
      Exit;
    end;

    if IdHTTP.ResponseCode <> 200 then begin
      FErrorString := IdHTTP.ResponseText;
      FErrorCode   := IdHTTP.ResponseCode;
      Exit;
    end;

    Idx := IdCookieManager.CookieCollection.GetCookieIndex(LOGIN_5CH_SID);
    if Idx < 0 then begin
      FErrorString := LOGIN_5CH_ERRMSG;
      FErrorCode   := -1;
      Exit;
    end;

    Cookie := IdCookieManager.CookieCollection.Items[Idx] as TIdCookie;
    FSessionID := Cookie.Value;
    if FSessionID = '' then begin
      FErrorString := LOGIN_5CH_ERRMSG;
      FErrorCode   := -2;
      Exit;
    end;

    Sep := Pos(':', FSessionID);
    if Sep > 1 then
      FUserAgent := Copy(FSessionID, 1, Sep - 1);
    FConnected := True;

    Result := True;

  except
    on ex: Exception do begin
      FErrorString := ex.Message;
      FErrorCode   := -10;
    end;
  end;

end;

{ HTTPコンポーネント初期化 }
procedure TSession5ch.InitHTTP;
begin
  IdHTTP.CookieManager.CookieCollection.Clear;
	IdHTTP.Request.Clear;
	IdHTTP.ProxyParams.BasicAuthentication := False;
	if GikoSys.Setting.WriteProxy then begin
		IdHTTP.ProxyParams.ProxyServer   := GikoSys.Setting.WriteProxyAddress;
		IdHTTP.ProxyParams.ProxyPort     := GikoSys.Setting.WriteProxyPort;
		IdHTTP.ProxyParams.ProxyUsername := GikoSys.Setting.WriteProxyUserID;
		IdHTTP.ProxyParams.ProxyPassword := GikoSys.Setting.WriteProxyPassword;
		if GikoSys.Setting.ReadProxyUserID <> '' then
			IdHTTP.ProxyParams.BasicAuthentication := True;
	end else begin
		IdHTTP.ProxyParams.ProxyServer   := '';
		IdHTTP.ProxyParams.ProxyPort     := 80;
		IdHTTP.ProxyParams.ProxyUsername := '';
		IdHTTP.ProxyParams.ProxyPassword := '';
	end;
	IdHTTP.Request.UserAgent      := GikoSys.GetUserAgent;
	IdHTTP.Request.AcceptEncoding := '';
  IdHTTP.AllowCookies   := True;
  IdHTTP.ReadTimeout    := GikoSys.Setting.ReadTimeOut;
  IdHTTP.ConnectTimeout := GikoSys.Setting.ReadTimeOut;
end;

{ セッションID取得 }
function TSession5ch.GetSessionID: string;
begin
  if FConnected then
    Result := FSessionID
  else
    Result := '';
end;

{ セッションIDのUSER-AGENT取得 }
function TSession5ch.GetUserAgent: string;
begin
  if FConnected then
    Result := FUserAgent
  else
    Result := '';
end;

{ エラーコード取得 }
function TSession5ch.GetErrorCode: Integer;
begin
	if FConnected then
		Result := ErrorCode
	else
		Result := 0;
end;

{ エラーメッセージ取得 }
function TSession5ch.GetErrorMsg:  string;
begin
	if FConnected then
		Result := FErrorString
	else
    //Result := 'Error: IDかパスワードが正しくありません。';
    Result := LOGIN_5CH_ERRMSG;
end;
























end.
