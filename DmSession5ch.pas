unit DmSession5ch;

interface

uses
  SysUtils, Classes, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdCookieManager, IdCookie, IdURI, IdCTypes, IdSSLOpenSSLHeaders, IdGlobal;

type
  TSession5ch = class(TDataModule)
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdCookieManager: TIdCookieManager;
  private
		FConnected:  Boolean;
		FErrorCode:   Integer;
		FErrorString: string;

		function GetSessionID: string;
    function Login: Boolean;
    procedure Clear;
    function IsConnected: Boolean;  // できるだけ呼ばない
  public
		constructor Create(AOwner: TComponent); reintroduce; virtual;
		destructor  Destroy; override;

		function  Connect:    Boolean;
		function  Disconnect: Boolean;

		property  Connected: Boolean read  FConnected;
		property  SessionID: string  read  GetSessionID;
		property  ErrorCode: Integer read  FErrorCode;
		property  ErrorMsg:  string  read  FErrorString;
  end;

var
  Session5ch: TSession5ch;

  function Session5ch_Connected:  Boolean;
  function Session5ch_Connect:    Boolean;
  function Session5ch_Disconnect: Boolean;
  function Session5ch_SessionID:  String;
  function Session5ch_ErrorMsg:   String;
  function Session5ch_ErrorCode:  Integer;

implementation

{$R *.dfm}

uses
  GikoSystem, YofUtils, IndyModule;

const
//  LOGIN_5CH_URL     = 'https://uplift.5ch.net/log';
//  LOGIN_5CH_URLV6   = 'https://[uplift.5ch.net]/log';
//  LOGIN_5CH_REFERER = 'https://uplift.5ch.net/login';
  LOGIN_5CH_URL     = 'https://uplift.5ch.io/log';
  LOGIN_5CH_URLV6   = 'https://[uplift.5ch.io]/log';
  LOGIN_5CH_REFERER = 'https://uplift.5ch.io/login';
  LOGIN_5GH_ACCEPT  = 'text/html,image/gif,image/jpeg,image/png,*/*';
  LOGIN_5CH_CNTTYPE = 'application/x-www-form-urlencoded';
  LOGIN_5CH_FORMFMT = 'usr=%s&pwd=%s&log=';
  LOGIN_5CH_SID     = 'sid';
  LOGIN_5CH_ERRMSG  = 'Error: UPLIFTにログインできませんでした。';
//  ROOT_5CH_URL			= 'https://5ch.net/';
  ROOT_5CH_URL			= 'https://5ch.io/';




procedure DebugLog(text: String);
{var
  dst: TextFile;
  path: String;}
begin
{
  path := 'd:\log\uplift.log';

  try
    AssignFile(dst, path);
    if FileExists(path) then
      Append(dst)
    else
      Rewrite(dst);

    Writeln(dst, FormatDateTime('YYYY/MM/DD HH:NN:SS', Now) + ' ' + text);

  finally
    CloseFile(dst);
  end;
}
end;

function Session5ch_Connected: Boolean;
begin
  if Session5ch = nil then
    Session5ch := TSession5ch.Create(nil);
  Result := Session5ch.Connected;
end;

function Session5ch_Connect: Boolean;
var
  i: Integer;
begin

  Result := Session5ch_Connected;

  if Result then
    Exit;   // ログイン済み

  for i := 0 to 2 do begin

    if i > 0 then begin
      DebugLog(Format('Session5ch_Connect() リトライ[%d]', [i]));
      Sleep(1000);
    end;

    if Session5ch <> nil then
      FreeAndNil(Session5ch);

    Session5ch := TSession5ch.Create(nil);

    Result := Session5ch.Connect;
    if Result then
      Exit;		// 成功

    DebugLog(Format('Session5ch_Connect() UPLIFTログイン失敗[%d][%s]', [Session5ch.ErrorCode, Session5ch.ErrorMsg]));

    if Session5ch.ErrorCode <> 405 then
      Exit;		// 405以外はリトライしない
  end;
end;

function Session5ch_Disconnect: Boolean;
begin
  if Session5ch = nil then
    Session5ch := TSession5ch.Create(nil);
  Result := Session5ch.Disconnect;
end;

function Session5ch_SessionID: String;
begin
  if Session5ch = nil then
    Session5ch := TSession5ch.Create(nil);
  Result := Session5ch.SessionID;
end;

function Session5ch_ErrorMsg: String;
begin
  if Session5ch <> nil then begin
    if (Session5ch.ErrorMsg = '') and (not Session5ch.Connected) then
      Result := LOGIN_5CH_ERRMSG
    else
      Result := Session5ch.ErrorMsg;
  end else
    Result := '';
end;

function Session5ch_ErrorCode: Integer;
begin
  if (Session5ch <> nil) and (not Session5ch.Connected) then
    Result := Session5ch.ErrorCode
  else
    Result := 0;
end;


{ コンストラクタ }
constructor TSession5ch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Clear;
  IsConnected;
end;

{ デストラクタ }
destructor TSession5ch.Destroy;
begin
//	if Connected then
//		Disconnect;
  inherited Destroy;
end;

{ セッション情報クリア }
procedure TSession5ch.Clear;
begin
  FErrorCode   := 0;
  FErrorString := '';
end;

{ ログイン中か }
function TSession5ch.IsConnected: Boolean;
begin
  FConnected := (IndyMdl.UpliftCookieValue <> '');
  Result := FConnected;
end;

{ ログイン }
function TSession5ch.Connect: Boolean;
begin
	Result := IsConnected;
	if not Result then begin
    Clear;
		Result := Login;
	end;
end;

{ ログアウト }
function TSession5ch.Disconnect: Boolean;
begin
  IndyMdl.DelUpliftCookie;
  FConnected := False;
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
  url: String;
//	uri: TIdURI;
//  sendCookies: String;
begin

  Result := IsConnected;

  if Result then
    Exit;

  IndyMdl.DelUpliftCookie;  // 念のため

  try
    if GikoSys.Setting.IPv6 then
      url := LOGIN_5CH_URLV6
    else
      url := LOGIN_5CH_URL;

    FormData := Format(LOGIN_5CH_FORMFMT, [HttpEncode(GikoSys.Setting.UserID),
                                           HttpEncode(GikoSys.Setting.Password)]);
    idx := Pos('@', FormData);
    if idx > 0 then begin
      Delete(FormData, idx, 1);
      Insert('%40', FormData, idx);
    end;
    SrcContent := TStringStream.Create(FormData);
    ResContent := TMemoryStream.Create;

//		uri := TIdURI.Create(LOGIN_5CH_URL);
//  	try
//	    sendCookies := IndyMdl.GetCookieString(uri);
//    finally
//		  uri.Free;
//    end;

    TIndyMdl.InitHTTP(IdHTTP);

    IdHTTP.AllowCookies           := True;
    IdHTTP.Request.AcceptEncoding := '';
    IdHTTP.Request.AcceptLanguage := 'ja';
    IdHTTP.Request.Accept         := LOGIN_5GH_ACCEPT;
    IdHTTP.Request.ContentType    := LOGIN_5CH_CNTTYPE;
    IdHTTP.Request.Referer        := LOGIN_5CH_REFERER;
//  	if sendCookies <> '' then
//	    IdHTTP.Request.CustomHeaders.Add('Cookie: ' + sendCookies);

    OK := False;

    IndyMdl.StartAntiFreeze(100);
    try
      IdHTTP.Post(url, SrcContent, ResContent);
      OK := True;
    except
      FErrorString := LOGIN_5CH_ERRMSG + IdHTTP.ResponseText;
      FErrorCode   := IdHTTP.ResponseCode;
    end;
    IndyMdl.EndAntiFreeze;
		IndyMdl.SaveCookies(IdHTTP);

    if SrcContent <> nil then
      SrcContent.Free;
    if ResContent <> nil then
      ResContent.Free;

    if not OK then
      Exit;

    if IdHTTP.ResponseCode <> 200 then begin
      FErrorString := LOGIN_5CH_ERRMSG + IdHTTP.ResponseText;
      FErrorCode   := IdHTTP.ResponseCode;
      Exit;
    end;

    if not IsConnected then begin
      FErrorString := LOGIN_5CH_ERRMSG;
      FErrorCode   := -1;
      Exit;
    end;

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
  Result := IndyMdl.UpliftCookieValue;
end;

end.
