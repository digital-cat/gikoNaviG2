unit DonguriSystem;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, Forms, StrUtils,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdGlobal, IdURI, IdTCPClient,
  IdHTTP;

type
  TDonguriSys = class(TObject)

  private
    FHTTP: TIdHTTP;
    FSSL: TIdSSLIOHandlerSocketOpenSSL;
    FResponseText: String;
    FResponseCode: Integer;
    FErroeMessage: String;

    procedure ClearResponse;
		function HttpGet(url, referer: String; gzip: Boolean; var response: String; var redirect: Boolean): Boolean;
		function HttpGetCall(urlStart: String; var response: String): Boolean;

		function CheckFormAction(html, url: String): Boolean;
		function CheckCannon(html: String; var resMsg: String): Boolean;
    function CheckConfirm(html: String; var resMsg: String): Boolean;
    procedure ShowCannonError(msg: String);

  public

		constructor Create;
		destructor Destroy; override;

		function Root(var response: String): Boolean;
		function Auth(var response: String): Boolean;
		function Login(var response: String): Boolean;
		function Logout(var response: String): Boolean;

		function Cannon(urlRes, date: String): Boolean;

    // HTTPレスポンステキスト
    property ResponseText: String  read FResponseText;
    // HTTPレスポンスコード
    property ResponseCode: Integer read FResponseCode;
    // 例外メッセージ
    property ErroeMessage: String  read FErroeMessage;
  end;

var
	DonguriSys: TDonguriSys;

const
	URL_DNG_BASE    = 'https://donguri.5ch.net';
	URL_DNG_ROOT    = 'https://donguri.5ch.net/';
  URL_DNG_AUTH    = 'https://donguri.5ch.net/auth';
  URL_DNG_LOGIN   = 'https://donguri.5ch.net/login';
  URL_DNG_LOGOUT  = 'https://donguri.5ch.net/logout';
  URL_DNG_CANNON  = 'https://donguri.5ch.net/cannon';
  URL_DNG_CANNON2 = 'https://donguri.5ch.net/confirm';
  URL_DNG_CANNON3 = 'https://donguri.5ch.net/fire';


implementation

uses
  GikoSystem, IndyModule, YofUtils, Giko;


constructor TDonguriSys.Create;
begin
	Inherited;

  FResponseCode := 0;
  
  try
    FHTTP := TIdHttp.Create(nil);
    FSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    FSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
    FSSL.SSLOptions.Method := sslvTLSv1_2;
    FHTTP.IOHandler := FSSL;
  except
    on e: Exception do begin
      MessageBox(0, PChar(e.Message), 'TDonguriSys.Create', MB_OK);
    end;
  end;

end;

destructor TDonguriSys.Destroy;
begin
  try
    TIndyMdl.ClearHTTP(FHTTP);
    FHTTP.Free;
    FSSL.Free;
  except
  end;

	Inherited;
end;


procedure TDonguriSys.ClearResponse;
begin
	FErroeMessage := '';
	FResponseText := '';
	FResponseCode := 0;
end;

// HTTP-GET処理
function TDonguriSys.HttpGet(url, referer: String; gzip: Boolean; var response: String; var redirect: Boolean): Boolean;
var
  ok: Boolean;
	uri: TIdURI;
  url2: String;
  sendCookies: String;
  res: TMemoryStream;
  enc: String;
  u8: UTF8String;
begin
	Result := False;
  redirect := False;
  response := '';
  ClearResponse;

  res := TMemoryStream.Create;

	try
		uri := TIdURI.Create(url);
  	try
	    sendCookies := IndyMdl.GetCookieString(uri);
    finally
		  uri.Free;
    end;

    url2 := GikoSys.GetActualURL(url);

    TIndyMdl.InitHTTP(FHTTP);

    FHTTP.AllowCookies    := True;
    FHTTP.Request.Referer := referer;
    FHTTP.Request.Accept  := 'text/html';
    FHTTP.Request.AcceptLanguage := 'ja';
    if gzip then
	    FHTTP.Request.AcceptEncoding := 'gzip'
    else
  	  FHTTP.Request.AcceptEncoding := '';
  	if sendCookies <> '' then
	    FHTTP.Request.CustomHeaders.Add('Cookie: ' + sendCookies);

    ok := False;

    IndyMdl.StartAntiFreeze(100);
    Screen.Cursor := crHourGlass;
    try
      FHTTP.Get(url2, res);
      ok := True;
    except
      on e: Exception do begin
      	if FHTTP.ResponseCode = 302 then
		      ok := True
        else
	        FErroeMessage := e.Message;
      end;
    end;
    FResponseText := FHTTP.ResponseText;
		FResponseCode := FHTTP.ResponseCode;

    Screen.Cursor := crDefault;
    IndyMdl.EndAntiFreeze;
		IndyMdl.SaveCookies(FHTTP);

    if ok then begin
      if FResponseCode = 302 then begin
        response := FHTTP.Response.Location;
        redirect := True;
      end else if res.Size > 0 then begin
        if gzip then
          enc := FHTTP.Response.ContentEncoding;
        u8 := GikoSys.GzipDecompress(res, enc);
        response := GikoSys.UTF8toSJIS(PChar(u8))
      end;
    end;

    Result := ok;

  finally
  	res.Free;
  end;
end;

// リダイレクト有りのHTTP-GET
function TDonguriSys.HttpGetCall(urlStart: String; var response: String): Boolean;
var
  url: String;
  ref: String;
  res: String;
  red: Boolean;
  gzip: Boolean;
  ok: Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

    ok := False;
  	url := urlStart;
    ref := '';

  	while True do begin
    	res := '';
      red := False;
      gzip := (url = URL_DNG_ROOT);

			ok := HttpGet(url, ref, gzip, res, red);

      if ok and (url = URL_DNG_LOGOUT) then begin
        GikoSys.Setting.DonguriCookie := '';
        GikoSys.Setting.DonguriExpires := '';
        IndyMdl.DelCookie('acorn', 'https://5ch.net/');		// Cookie保存時に消してくれているとは思うけど
        IndyMdl.DelCookie('fp',    'https://5ch.net/');		// 受け取ってないけどクリア要求？？？
      end;

      if red = False then begin
			  response := res;
      	Break;
      end;

      if res[1] = '/' then
        res := URL_DNG_BASE + res;

      ref := url;
			url := res;
    end;

    Result := ok;

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ルート（メインページ）
function TDonguriSys.Root(var response: String): Boolean;
var
	redirect: Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGet(URL_DNG_ROOT, '', True, response, redirect);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 再認証
function TDonguriSys.Auth(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_AUTH, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ログイン
function TDonguriSys.Login(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_LOGIN, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ログアウト
function TDonguriSys.Logout(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_LOGOUT, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;


function TDonguriSys.Cannon(urlRes, date: String): Boolean;
var
	ok: Boolean;
  res: String;
  url2: String;
  url3: String;
  param: String;
  resMsg: String;
	redirect: Boolean;
begin
	Result := False;

	try
	  ClearResponse;

  	ok := HttpGet(URL_DNG_CANNON, '', True, res, redirect);
    if ok then
	  	ok := CheckCannon(res, resMsg);

    if ok = False then begin
    	if resMsg = '' then
				ShowCannonError('どんぐり大砲を使用できません。')
      else
		    ShowCannonError(resMsg);
    	Exit;
    end;

    param := Format('?url=%s&date=%s', [
											HttpEncode(UTF8Encode(urlRes)),
											HttpEncode(UTF8Encode(date))
										]);
  	url2 := URL_DNG_CANNON2 + param;
  	ok := HttpGet(url2, URL_DNG_CANNON, True, res, redirect);
    if ok then
	  	ok := CheckConfirm(res, resMsg);

    if ok = False then begin
    	if resMsg = '' then
		    ShowCannonError('どんぐり大砲を使用できません。')
      else
		    ShowCannonError(resMsg);
    	Exit;
    end;

    if MessageBox(GikoForm.Handle, PChar(resMsg + #10 + 'どんぐり大砲を撃ちますか？'),
    								'どんぐり大砲', MB_YESNO or MB_ICONQUESTION) <> IDYES then begin
			Result := True;
    	Exit;
    end;

  	url3 := URL_DNG_CANNON3 + param;
  	ok := HttpGet(url3, url2, True, res, redirect);

    if ok then begin
      if (res <> '') and (Pos('<html', res) < 1) then
				 MessageBox(GikoForm.Handle, PChar(res), 'どんぐり大砲', MB_OK or MB_ICONINFORMATION)
      else
				 MessageBox(GikoForm.Handle, PChar('どんぐり大砲を発射しましたが結果不明です。' + #10#10 + res),
         						'どんぐり大砲', MB_OK or MB_ICONWARNING);
    end else
	    ShowCannonError('どんぐり大砲の発射に失敗しました。');

    Result := ok;

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
	    ShowCannonError('どんぐり大砲の発射でエラーが発生しました。');
    end;
  end;

end;

function TDonguriSys.CheckFormAction(html, url: String): Boolean;
var
	idx1: Integer;
	idx2: Integer;
  tmp1: String;
  tmp2: String;
begin
	Result := False;

	idx1 := Pos('<form ', html);
  if idx1 < 1 then
  	Exit;
	idx2 := PosEx('>', html, idx1);
  if idx2 < 1 then
  	Exit;

  tmp1 := Copy(html, idx1, idx2 - idx1);
  tmp2 := Format('action="%s"', [url]);

	Result := (Pos(tmp2, tmp1) > 0);
end;

// cannon
function TDonguriSys.CheckCannon(html: String; var resMsg: String): Boolean;
begin
	Result := False;

  if Pos('<h1>どんぐり大砲</h1>', html) < 1 then
  	Exit;

	Result := CheckFormAction(html, URL_DNG_CANNON2);
end;

// cannon -> confirm
function TDonguriSys.CheckConfirm(html: String; var resMsg: String): Boolean;
var
	idx1: Integer;
	idx2: Integer;
	idx3: Integer;
begin
	Result := False;
  resMsg := '';

  if Pos('<html', html) < 1 then begin
	  resMsg := html;
    Exit;
  end;

	idx1 := Pos('<body>', html);
  if idx1 < 1 then
  	Exit;

	idx2 := PosEx('<p>', html, idx1);
  if idx2 < 1 then
  	Exit;
	idx2 := idx2 + 3;
	idx3 := PosEx('</p>', html, idx2);
  if idx3 < 1 then
  	Exit;
  resMsg := Copy(html, idx2, idx3 - idx2);

	Result := CheckFormAction(html, URL_DNG_CANNON3);
end;

procedure TDonguriSys.ShowCannonError(msg: String);
begin
	MessageBox(GikoForm.Handle, PChar(msg), 'どんぐり大砲', MB_OK or MB_ICONERROR);
end;


end.
