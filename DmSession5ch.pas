unit DmSession5ch;

interface

uses
  SysUtils, Classes, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdCookieManager, IdCookie, IdURI;

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
    FIsExpired:		Boolean;

		function GetSessionID: string;
		function GetUserAgent: string;
		function GetErrorCode: Integer;
		function GetErrorMsg:  string;
    function Login: Boolean;
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
    property	IsExpired: Boolean read  FIsExpired write FIsExpired;
  end;

var
  Session5ch: TSession5ch;

implementation

{$R *.dfm}

uses
  GikoSystem, YofUtils, IndyModule;

const
  LOGIN_5CH_URL     = 'https://uplift.5ch.net/log';
  LOGIN_5CH_URLV6   = 'https://[uplift.5ch.net]/log';
  LOGIN_5CH_REFERER = 'https://uplift.5ch.net/login';
  LOGIN_5GH_ACCEPT  = 'text/html,image/gif,image/x-xbitmap,image/jpeg,image/pjpeg,*/*';
  LOGIN_5CH_CNTTYPE = 'application/x-www-form-urlencoded';
  LOGIN_5CH_FORMFMT = 'usr=%s&pwd=%s&log=';
  LOGIN_5CH_SID     = 'sid';
  LOGIN_5CH_ERRMSG  = 'Error: ログインできませんでした。';
  ROOT_5CH_URL			= 'https://5ch.net/';


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
  FIsExpired	 := False;
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
  IndyMdl.DelUpliftCookie;
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
  url: String;
	uri: TIdURI;
  sendCookies: String;
begin
  Result := False;

  try
    if GikoSys.Setting.IPv6 then
      url := LOGIN_5CH_URLV6
    else
      url := LOGIN_5CH_URL;

    FormData := Format(LOGIN_5CH_FORMFMT, [HttpEncode(GikoSys.Setting.UserID),
                                           HttpEncode(GikoSys.Setting.Password)]);
    SrcContent := TStringStream.Create(FormData);
    ResContent := TMemoryStream.Create;

		uri := TIdURI.Create(LOGIN_5CH_URL);
  	try
	    sendCookies := IndyMdl.GetCookieString(uri);
    finally
		  uri.Free;
    end;

    TIndyMdl.InitHTTP(IdHTTP);

    IdHTTP.AllowCookies           := True;
    IdHTTP.Request.AcceptEncoding := '';
    IdHTTP.Request.AcceptLanguage := 'ja';
    IdHTTP.Request.Accept         := LOGIN_5GH_ACCEPT;
    IdHTTP.Request.ContentType    := LOGIN_5CH_CNTTYPE;
    IdHTTP.Request.Referer        := LOGIN_5CH_REFERER;
  	if sendCookies <> '' then
	    IdHTTP.Request.CustomHeaders.Add('Cookie: ' + sendCookies);

    OK := False;

    IndyMdl.StartAntiFreeze(100);
    try
      IdHTTP.Post(url, SrcContent, ResContent);
      OK := True;
    except
      FErrorString := IdHTTP.ResponseText;
      FErrorCode   := IdHTTP.ResponseCode;
    end;
    IndyMdl.EndAntiFreeze;
		IndyMdl.SaveCookies(IdHTTP);

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
