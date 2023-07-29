{*******************************************************}
{                                                       }
{       DOLIB API Interface Unit                        }
{                                                       }
{       2002 Monazilla Project                          }
{            Dax   mailto:daxmonazilla@yahoo.co.jp      }
{            （ヒ）mailto:gikonavi@ice.dti2.ne.jp       }
{********************************************************

Updates:

2002/03/02 ログインエラーを検出するように修正したかも。
2002/03/02 DOLIB.dllを使わないようにした。
2002/02/27 バグ修正 (GetVersionはコネクトしてなくても取得可能にした)
2002/01/22 DOLIB 1.00C対応。
					 以下のプロパティを追加。
					 - Session ......... セッションのポインタを返します、多分使わない。
					 - SessionID ....... セッションIDを返します。
					 - Version ......... DOLIBのバージョンを返します。
					 - UserAgent ....... UA用の文字列 Monazilla/x.xx を返します。
					 - ErrorCode ....... エラーコードを返します。
					 - ErrorMsg ........ エラーメッセージを返します。
2002/01/20 Disconnect後に Connectedプロパティを戻してなかった。
2002/01/19 DOLIB 1.00B対応。データ取得に成功！
2002/01/18 DOLIB 1.00対応。しかしエラーしか返って来ない、、
2002/01/18 ghanyan氏の助言により動作する。感謝！
2002/01/09 DOLIB 0.01用に作成開始。でも動かないのでほっとく。
}
unit Dolib;

{$IOCHECKS ON}

interface

uses
	Windows, SysUtils, WinInet, YofUtils;

type
	TDolibSession = class(TObject)
	private
		FSessionID: string;
		FErrorCode: Integer;
		FErrorString: string;
		FUserAgent: string;
	public
		property SessionID: string read FSessionID write FSessionID;
		property ErrorCode: Integer read FErrorCode write FErrorCode;
		property ErrorString: string read FErrorString write FErrorString;
		property UserAgent: string read FUserAgent write FUserAgent;
	end;

	TDolib  = class(TObject)
	private
		FSession : TDolibSession;
		FConnected: boolean;
		FProxyPort: integer;
		FUserName: string;
		FPassword: string;
		FProxyAddress: string;
		FClientUA: string;
		function GetSessionID: string;
		function GetVersion: string;
		function GetUserAgent: string;
		function GetErrorCode: integer;
		function GetErrorMsg: string;
		procedure MakeError(Session: TDolibSession; Error: DWORD);
		procedure DOLIB_LOGIN(Proxy: string; Port: Integer; ID: string; Pass: string);
		procedure ForcedDOLIB_LOGIN(Proxy: string; Port: Integer; ID: string; Pass: string);
	public
		constructor Create;
		destructor  Destroy; override;
		function  Connect: boolean;
		function  ForcedConnect: boolean;   //SSL障害用強制ログイン
		function  Disconnect: boolean;
		property  ProxyAddress: string  read  FProxyAddress write FProxyAddress;
		property  ProxyPort: integer  read  FProxyPort  write FProxyPort;
		property  UserName: string  read  FUserName write FUserName;
		property  Password: string  read  FPassword write FPassword;
		property  ClientUA: string  read  FClientUA write FClientUA;
		property  Connected: boolean  read  FConnected;
		property  SessionID: string read  GetSessionID;
		property  Version: string read  GetVersion;
		property  UserAgent: string read  GetUserAgent;
		property  ErrorCode: integer read  GetErrorCode;
		property  ErrorMsg: string  read  GetErrorMsg;
	end;

implementation
const
	DOLIB_VERSION       = $10000;
	DOLIB_LOGIN_UA      = 'DOLIB/1.00';
	DOLIB_LOGIN_HOST    = '2chv.tora3.net';
	DOLIB_LOGIN_URL     = '/futen.cgi';
	DOLIB_2CH_UA        = 'X-2ch-UA:';
//	DOLIB_2CH_UA        = 'X-2ch-UA: gikoNavi/1.00'#13#10;
	DOLIB_ENOMEM_STRING = 'メモリが足りません。';
	DOLIB_LOGIN_ERROR   = 'ERROR:';
// https://2chv.tora3.net/futen.cgi

{ TDolib }

constructor TDolib.Create;
begin
	FSession   := nil;
	FConnected := False;
end;

destructor TDolib.Destroy;
begin
	if Connected then
		Disconnect;
	inherited;
end;

function TDolib.Connect: boolean;
begin
	Result := False;
	if not Connected then begin
		DOLIB_LOGIN(FProxyAddress, FProxyPort, FUserName, FPassword);
		FConnected  :=  True;
		if  (AnsiPos(DOLIB_LOGIN_ERROR, SessionID) = 1) then  begin
			Disconnect;
			Result      :=  False;
		end else if ErrorCode <> 0 then begin
			Disconnect;
			Result := False;
		end else begin
			Result := True;
//			Result      :=  (ErrorCode = 0);
		end;
	end;
end;
function  TDolib.ForcedConnect: boolean;   //2003/12/20までのSSL障害用強制ログイン（12/21以降なら通常ログイン）
begin
	Result := False;
	if not Connected then begin
		ForcedDOLIB_LOGIN(FProxyAddress, FProxyPort, FUserName, FPassword);
        Result := True;
	end;
end;

function TDolib.Disconnect: boolean;
begin
	Result := True;
  if FSession <> nil then
    FreeAndNil(FSession);
  FConnected := False;
end;

function TDolib.GetVersion: string;
var
	v : DWORD;
	mj, mn : integer;
begin
	v  := DOLIB_VERSION;
	mj := v shr 16;
	mn := v and $ffff;
	Result := Format('%d.%.2d', [mj, mn]);
end;

function TDolib.GetSessionID: string;
begin
	if Connected then
		Result := FSession.FSessionID
	else
		Result := '';
end;

function TDolib.GetUserAgent: string;
begin
	if Connected then
		Result := FSession.FUserAgent
	else
		Result := '';
end;

function TDolib.GetErrorMsg: string;
begin
	if Connected then
		Result := FSession.FErrorString
	else
    Result  :=  'Error: IDかパスワードが正しくありません。'; 
end;

function TDolib.GetErrorCode: integer;
begin
	if Connected then
		Result := FSession.ErrorCode
	else
		Result := 0;
end;

procedure TDolib.MakeError(Session: TDolibSession; Error: DWORD);
var
	Buf: array[0..4096] of Char;
begin
	Session.ErrorCode := Error;
	if Error = ERROR_NOT_ENOUGH_MEMORY then
		Session.ErrorString := DOLIB_ENOMEM_STRING
	else begin
		FillChar(Buf, SizeOf(Buf), #0);
		FormatMessage({FORMAT_MESSAGE_ALLOCATE_BUFFER or}
			FORMAT_MESSAGE_IGNORE_INSERTS or
			FORMAT_MESSAGE_FROM_SYSTEM or
			FORMAT_MESSAGE_FROM_HMODULE,
			Pointer(GetModuleHandle('wininet')), Error,
			(((Word(SUBLANG_DEFAULT)) shl 10) or Word(LANG_NEUTRAL)),	//DelphiにMAKELANGIDマクロが無かったの。(´･ω･`)ｼｮﾎﾞｰﾝ
//			MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
			Buf, SizeOf(Buf), nil);
		Session.ErrorString := Buf;
	end;
end;

{参考URL
kage作者さんのDOLIBクローンソース（大変おいしゅうございました）
http://members.jcom.home.ne.jp/monazilla/document/wininetdel.html
http://support.microsoft.com/default.aspx?scid=kb;EN-US;q168151
http://msdn.microsoft.com/library/default.asp?url=/workshop/networking/wininet/wininet.asp
http://homepage1.nifty.com/~suzuki/delphi/wininet.html
}
procedure TDolib.DOLIB_LOGIN(Proxy: string; Port: Integer; ID: string; Pass: string);
var
	hSession: HINTERNET;
	hConnect: HINTERNET;
	hRequest: HINTERNET;
	ProxyHostPort: string;
	Buf: array[0..4096] of Char;
	UserInfo: string;
	UserAgent: string;
    Header: string;
	cb: DWORD;
	Delim: Integer;
begin
	FSession := TDolibSession.Create;

	if Proxy <> '' then begin
		ProxyHostPort := Format('%s:%d', [Proxy, Port]);
		hSession := InternetOpen(DOLIB_LOGIN_UA, INTERNET_OPEN_TYPE_PROXY, PChar(ProxyHostPort), '', 0);
	end else begin
		hSession := InternetOpen(DOLIB_LOGIN_UA, INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
	end;

	if not Assigned(hSession) then
		MakeError(FSession, GetLastError())
	else begin
		hConnect := InternetConnect(hSession, DOLIB_LOGIN_HOST,
			INTERNET_DEFAULT_HTTPS_PORT, nil, nil,
			INTERNET_SERVICE_HTTP, INTERNET_FLAG_SECURE, 0);
		if not Assigned(hConnect) then
			MakeError(FSession, GetLastError())
		else begin
			hRequest := HttpOpenRequest(hConnect, 'POST', DOLIB_LOGIN_URL,
				nil, nil, nil,
				INTERNET_FLAG_NO_CACHE_WRITE or INTERNET_FLAG_NO_COOKIES or
				INTERNET_FLAG_NO_UI or INTERNET_FLAG_SECURE, 0);
			if not Assigned(hRequest) then
				MakeError(FSession, GetLastError())
			else begin
				UserInfo := Format('ID=%s&PW=%s', [HttpEncode(ID), HttpEncode(Pass)]);
                Header := 'Content-Type: application/x-www-form-urlencoded'#13#10;
				UserAgent := Format('%s %s', [DOLIB_2CH_UA, ClientUA]) + #13#10;
                Header := Header + UserAgent;
				if not HttpSendRequest(hRequest, PChar(Header), DWORD(-1), PChar(UserInfo), Length(UserInfo)) then
					MakeError(FSession, GetLastError())
				else begin
					if not InternetReadFile(hRequest, @Buf, SizeOf(Buf), cb) then
						MakeError(FSession, GetLastError())
					else if (cb < 11) or (Pos('SESSION-ID=', Buf) <> 1) then
						MakeError(FSession, ERROR_INVALID_DATA)
					else begin
						if Buf[cb - 1] = #10 then
							Buf[cb - 1] := #0;
						FSession.SessionID := Copy(Buf, 12, cb);
						if FSession.SessionID = '' then
							MakeError(FSession, ERROR_NOT_ENOUGH_MEMORY);
						Delim := Pos(':', Buf);
						if Delim = 0 then
							MakeError(FSession, ERROR_INVALID_DATA)
						else begin
							FSession.UserAgent := Copy(Buf, 12, Delim - 12);
							if FSession.UserAgent = '' then
								MakeError(FSession, ERROR_NOT_ENOUGH_MEMORY);
						end;
					end;
				end;
				InternetCloseHandle(hRequest);
			end;
			InternetCloseHandle(hConnect);
		end;
		InternetCloseHandle(hSession);
	end;
end;
//SSL障害用強制ログイン
procedure TDolib.ForcedDOLIB_LOGIN(Proxy: string; Port: Integer; ID: string; Pass: string);
var
	hSession: HINTERNET;
	hConnect: HINTERNET;
	hRequest: HINTERNET;
	ProxyHostPort: string;
	Buf: array[0..4096] of Char;
	UserInfo: string;
	UserAgent: string;
	cb: DWORD;
	Delim: Integer;
begin
	FSession := TDolibSession.Create;

	if Proxy <> '' then begin
		ProxyHostPort := Format('%s:%d', [Proxy, Port]);
		hSession := InternetOpen(DOLIB_LOGIN_UA, INTERNET_OPEN_TYPE_PROXY, PChar(ProxyHostPort), '', 0);
	end else begin
		hSession := InternetOpen(DOLIB_LOGIN_UA, INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
	end;

	if not Assigned(hSession) then
		MakeError(FSession, GetLastError())
	else begin
		hConnect := InternetConnect(hSession, DOLIB_LOGIN_HOST,
			INTERNET_DEFAULT_HTTPS_PORT, nil, nil,
			INTERNET_SERVICE_HTTP, INTERNET_FLAG_SECURE, 0);
		if not Assigned(hConnect) then
			MakeError(FSession, GetLastError())
		else begin
			hRequest := HttpOpenRequest(hConnect, 'POST', DOLIB_LOGIN_URL,
				nil, nil, nil,
				INTERNET_FLAG_NO_CACHE_WRITE or INTERNET_FLAG_NO_COOKIES or
				INTERNET_FLAG_NO_UI or INTERNET_FLAG_SECURE, 0);
			if not Assigned(hRequest) then
				MakeError(FSession, GetLastError())
			else begin
				UserInfo := Format('ID=%s&PW=%s', [ID, Pass]);
				UserAgent := Format('%s %s', [DOLIB_2CH_UA, ClientUA]) + #13#10;
				HttpSendRequest(hRequest, PChar(UserAgent), DWORD(-1), PChar(UserInfo), Length(UserInfo));
                if not InternetReadFile(hRequest, @Buf, SizeOf(Buf), cb) then
                    MakeError(FSession, GetLastError())
                else if (cb < 11) or (Pos('SESSION-ID=', Buf) <> 1) then
                    MakeError(FSession, ERROR_INVALID_DATA)
                else begin
                    if Buf[cb - 1] = #10 then
                        Buf[cb - 1] := #0;
                    FSession.SessionID := Copy(Buf, 12, cb);
                    if FSession.SessionID = '' then
                        MakeError(FSession, ERROR_NOT_ENOUGH_MEMORY);
                    Delim := Pos(':', Buf);
                    if Delim = 0 then
                        MakeError(FSession, ERROR_INVALID_DATA)
                    else begin
                        FSession.UserAgent := Copy(Buf, 12, Delim - 12);
                        if FSession.UserAgent = '' then
                            MakeError(FSession, ERROR_NOT_ENOUGH_MEMORY);
                    end;
				end;
				InternetCloseHandle(hRequest);
			end;
			InternetCloseHandle(hConnect);
		end;
		InternetCloseHandle(hSession);
	end;
end;
end.

