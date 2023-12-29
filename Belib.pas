{ DolibをコピーしてBEログインセッション管理を作成 }
unit Belib;

{$IOCHECKS ON}

interface

uses
	Windows, SysUtils, WinInet, YofUtils, Y_TextConverter;

type
	TBelibSession = class(TObject)
	private
		FMDMD: string;
		FDMDM: string;
		FErrorCode: Integer;
		FErrorString: string;
	public
		property MDMD: string read FMDMD write FMDMD;
        property DMDM: string read FDMDM write FDMDM;
		property ErrorCode: Integer read FErrorCode write FErrorCode;
		property ErrorString: string read FErrorString write FErrorString;
	end;

	TBelib  = class(TObject)
	private
		FSession : TBelibSession;
		FConnected: boolean;
		FProxyPort: integer;
		FUserName: string;
		FPassword: string;
		FProxyAddress: string;
		FClientUA: string;
		function GetMDMD : string;
		function GetDMDM : string;
		function GetErrorCode: integer;
		function GetErrorMsg: string;
		procedure MakeError(Session: TBelibSession; Error: DWORD);
		procedure BELIB_LOGIN(Proxy: string; Port: Integer; ID: string; Pass: string);
	public
		constructor Create;
		destructor  Destroy; override;
		function  Connect: boolean;
		function  Disconnect: boolean;
		property  ProxyAddress: string  read  FProxyAddress write FProxyAddress;
		property  ProxyPort: integer  read  FProxyPort  write FProxyPort;
		property  UserName: string  read  FUserName write FUserName;
		property  Password: string  read  FPassword write FPassword;
		property  ClientUA: string  read  FClientUA write FClientUA;
		property  Connected: boolean  read  FConnected;
		property  MDMD: string read  GetMDMD;
		property  DMDM: string read  GetDMDM;
		property  ErrorCode: integer read  GetErrorCode;
		property  ErrorMsg: string  read  GetErrorMsg;
	end;

implementation
const
	BELIB_LOGIN_UA      = 'BELIB/1.00';
	BELIB_LOGIN_HOST    = 'be.5ch.net';
	BELIB_LOGIN_URL     = '/log';
	BELIB_2CH_UA        = 'X-2ch-UA:';
	BELIB_ENOMEM_STRING = 'メモリが足りません。';
	BELIB_LOGIN_ERROR   = 'ERROR:';
// http:///　

{ TBelib }

constructor TBelib.Create;
begin
	FSession   := nil;
	FConnected := False;
end;

destructor TBelib.Destroy;
begin
	if Connected then
		Disconnect;
	inherited;
end;

function TBelib.Connect: boolean;
begin
	Result := False;
	if not Connected then begin
		BELIB_LOGIN(FProxyAddress, FProxyPort, FUserName, FPassword);
		FConnected  :=  True;
		if (Length(MDMD)=0) and (Length(DMDM)=0) then  begin
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

function TBelib.Disconnect: boolean;
begin
	Result := True;
  if FSession <> nil then
    FreeAndNil(FSession);
  FConnected := False;
end;

function TBelib.GetMDMD : string;
begin
	if Connected then
		Result := FSession.FMDMD
	else
		Result := '';
end;

function TBelib.GetDMDM : string;
begin
	if Connected then
		Result := FSession.FDMDM
	else
		Result := '';
end;


function TBelib.GetErrorMsg: string;
begin
	if Connected then
		Result := FSession.FErrorString
	else
    Result  :=  'Error: メールアドレスかパスワードが正しくありません。'; 
end;

function TBelib.GetErrorCode: integer;
begin
	if Connected then
		Result := FSession.ErrorCode
	else
		Result := 0;
end;

procedure TBelib.MakeError(Session: TBelibSession; Error: DWORD);
var
	Buf: array[0..4096] of Char;
begin
	Session.ErrorCode := Error;
	if Error = ERROR_NOT_ENOUGH_MEMORY then
		Session.ErrorString := BELIB_ENOMEM_STRING
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

{DOLIBを参考にしてます
}
procedure TBelib.BELIB_LOGIN(Proxy: string; Port: Integer; ID: string; Pass: string);
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
	Index: DWORD;
//	Delim: Integer;
    body: string;
begin
	FSession := TBelibSession.Create;

	if Proxy <> '' then begin
		ProxyHostPort := Format('%s:%d', [Proxy, Port]);
		hSession := InternetOpen(BELIB_LOGIN_UA, INTERNET_OPEN_TYPE_PROXY, PChar(ProxyHostPort), '', 0);
	end else begin
		hSession := InternetOpen(BELIB_LOGIN_UA, INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
	end;

	if not Assigned(hSession) then
		MakeError(FSession, GetLastError())
	else begin
		hConnect := InternetConnect(hSession, BELIB_LOGIN_HOST,
			INTERNET_DEFAULT_HTTPS_PORT, nil, nil,
			INTERNET_SERVICE_HTTP, INTERNET_FLAG_SECURE, 0);
		if not Assigned(hConnect) then
			MakeError(FSession, GetLastError())
		else begin
			hRequest := HttpOpenRequest(hConnect, 'POST', BELIB_LOGIN_URL,
				nil, nil, nil,
				INTERNET_FLAG_NO_CACHE_WRITE or INTERNET_FLAG_NO_COOKIES or
				INTERNET_FLAG_NO_UI or INTERNET_FLAG_SECURE, 0);
			if not Assigned(hRequest) then
				MakeError(FSession, GetLastError())
			else begin
				UserInfo := Format('mail=%s&pass=%s', [HttpEncode(ID), HttpEncode(Pass)]);
                Header := 'Content-Type: application/x-www-form-urlencoded'#13#10;
				UserAgent := Format('%s %s', [BELIB_2CH_UA, ClientUA]) + #13#10;
                Header := Header + UserAgent;
				if not HttpSendRequest(hRequest, PChar(Header), DWORD(-1), PChar(UserInfo), Length(UserInfo)) then
					MakeError(FSession, GetLastError())
				else begin
                    cb := Sizeof(Buf);
                    Index := 0;
                    ZeroMemory(@Buf, cb);
                    if not HttpQueryInfo(hRequest, HTTP_QUERY_RAW_HEADERS_CRLF, @Buf, cb, Index) then
    					MakeError(FSession, GetLastError())
					else if (Pos('Set-Cookie:', Buf) = 0) or (Pos('DMDM=', Buf) = 0)
                     or (Pos('MDMD=', Buf) = 0) then begin
						MakeError(FSession, ERROR_INVALID_DATA);
                    end
					else begin
                        body := Buf;
                        FSession.FDMDM := Copy(body, Pos('DMDM=', body) + 5, Length(body));
                        FSession.FDMDM := Copy(FSession.FDMDM, 1, Pos(';', FSession.FDMDM) - 1);
                        FSession.FMDMD := Copy(body, Pos('MDMD=', body) + 5, Length(body));
                        FSession.FMDMD := Copy(FSession.FMDMD, 1, Pos(';', FSession.FMDMD) - 1);
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

