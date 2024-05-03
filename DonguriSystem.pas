unit DonguriSystem;

//{$DEFINE _DEBUG_MODE}

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
		function HttpPost(url, referer: String; postParam: TStringList; gzip: Boolean; var response: String; var redirect: Boolean): Boolean;

		function CheckFormAction(html, url: String): Boolean;
  	function CheckResurrect(html: String; var resMsg: String; var nextUrl: String; var post: Boolean): Boolean;
		function CheckCannon(html: String; var resMsg: String): Boolean;
    function CheckConfirm(html: String; var resMsg: String): Boolean;
    procedure ShowCannonError(msg: String; httperr: Boolean = False);
    function  ShowCannonMessage(msg: String; mbType: Cardinal): Integer;

    function Extract(kw1, kw2, text: String; var val: String): Boolean;

    //procedure DebugLog(text: String);
  public

		constructor Create;
		destructor Destroy; override;

		function Root(var response: String): Boolean;
		function Auth(var response: String): Boolean;
		function Login(var response: String): Boolean;
		function Logout(var response: String): Boolean;

    function Exploration(var response: String): Boolean;
    function Mining(var response: String): Boolean;
    function WoodCutting(var response: String): Boolean;
    function WeaponCraft(var response: String): Boolean;
    function ArmorCraft(var response: String): Boolean;

    function Rename(var response: String): Boolean;
    function Resurrect(var response: String; var cancel: Boolean; handle: HWND): Boolean;
    function Transfer(var response: String): Boolean;
    function Craft(var response: String): Boolean;
    function CraftCB(amount: Integer; var response: String): Boolean;

		function Cannon(urlRes, date: String; no: Integer): Boolean;

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
  URL_DNG_EXPLOR  = 'https://donguri.5ch.net/focus/exploration';    // 探検
  URL_DNG_MINING  = 'https://donguri.5ch.net/focus/mining';         // 採掘
  URL_DNG_WOODCT  = 'https://donguri.5ch.net/focus/woodcutting';    // 木こり
  URL_DNG_WEAPON  = 'https://donguri.5ch.net/focus/weaponcraft';    // 武器製作
  URL_DNG_ARMORC  = 'https://donguri.5ch.net/focus/armorcraft';     // 防具製作
  URL_DNG_RENAME  = 'https://donguri.5ch.net/rename';								// ハンター呼び名変更サービス
  URL_DNG_RESRRCT = 'https://donguri.5ch.net/resurrect';						// 復活サービス
  URL_DNG_TRNSFR  = 'https://donguri.5ch.net/transfer';							// ドングリ転送サービス
  URL_DNG_CRAFT   = 'https://donguri.5ch.net/craft';								// 工作センター
  URL_DNG_CRAFTCB = 'https://donguri.5ch.net/craft/cannonball';			// 工作センター鉄の大砲の玉作成
  URL_DNG_CANNON  = 'https://donguri.5ch.net/cannon';
  URL_DNG_CANNON2 = 'https://donguri.5ch.net/confirm';
  URL_DNG_CANNON3 = 'https://donguri.5ch.net/fire';
	URL_5CH_ROOT    = 'https://5ch.net/';


implementation

uses
  GikoSystem, IndyModule, YofUtils, Giko, GikoUtil, MojuUtils;


// コンストラクタ
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
    //on e: Exception do begin
    //  MessageBox(0, PChar(e.Message), 'TDonguriSys.Create', MB_OK);
    //end;
  end;
end;

// デストラクタ
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

// HTTPレスポンス情報クリア
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
{$IFDEF _DEBUG_MODE}
  dbg: TMemoryStream;
  dbgpath: String;
  dbgcnt: Integer;
{$ENDIF}
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
        response := GikoSys.UTF8toSJIS(PChar(u8));
{$IFDEF _DEBUG_MODE}
        for dbgcnt := 0 to 99 do begin
					dbgpath := 'D:\Log\Donguri\' + FormatDateTime('yyyymmdd_hhnnss_zzz', Now) + Format('_%.2d.html', [dbgcnt]);
          if not FileExists(dbgpath) then
          	Break;
        end;
			  dbg := TMemoryStream.Create;
        try
        	dbg.Write(PChar(u8)^,Length(u8));
          dbg.SaveToFile(dbgpath);
        finally
          dbg.Free;
        end;
{$ENDIF}
      end;
    end;

    Result := ok;

  finally
  	res.Free;
  end;
end;

// HTTP-POST処理
function TDonguriSys.HttpPost(url, referer: String; postParam: TStringList; gzip: Boolean; var response: String; var redirect: Boolean): Boolean;
var
  ok: Boolean;
	uri: TIdURI;
  url2: String;
  sendCookies: String;
  res: TMemoryStream;
  enc: String;
  u8: UTF8String;
{$IFDEF _DEBUG_MODE}
  dbg: TMemoryStream;
  dbgpath: String;
  dbgcnt: Integer;
{$ENDIF}
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
      FHTTP.Post(url2, postParam, res);
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
        response := GikoSys.UTF8toSJIS(PChar(u8));
{$IFDEF _DEBUG_MODE}
        for dbgcnt := 0 to 99 do begin
					dbgpath := 'D:\Log\Donguri\' + FormatDateTime('yyyymmdd_hhnnss_zzz', Now) + Format('_%.2d.html', [dbgcnt]);
          if not FileExists(dbgpath) then
          	Break;
        end;
			  dbg := TMemoryStream.Create;
        try
        	dbg.Write(PChar(u8)^,Length(u8));
          dbg.SaveToFile(dbgpath);
        finally
          dbg.Free;
        end;
{$ENDIF}
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
        IndyMdl.DelCookie('acorn', URL_5CH_ROOT);	// Cookie保存時に消してくれているとは思うけど
        IndyMdl.DelCookie('fp',    URL_5CH_ROOT);	// 受け取ってないけどクリア要求？？？
      end;

      if red = False then begin
			  response := res;
      	Break;
      end;

      if res[1] = '/' then
        res := URL_DNG_BASE + res;

      if res = url then begin
        FErroeMessage := '異常なリダイレクトを検出しました。' + #10 + 'どんぐりシステム画面を一度閉じると解消するかもしれません。';
        ok := False;
        Break;
      end;

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

function TDonguriSys.Extract(kw1, kw2, text: String; var val: String): Boolean;
var
	idx1: Integer;
	idx2: Integer;
begin
	Result := False;
  val := '';

  idx1 := Pos(kw1, text);
  if idx1 < 1 then
  	Exit;
	idx1 := idx1 + Length(kw1);
  idx2 := PosEx(kw2, text, idx1);
  if idx2 < 1 then
  	Exit;

	val := Copy(text, idx1, idx2 - idx1);

	Result := True;
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

// 探検
function TDonguriSys.Exploration(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_EXPLOR, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 採掘
function TDonguriSys.Mining(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_MINING, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 木こり
function TDonguriSys.WoodCutting(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_WOODCT, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 武器製作
function TDonguriSys.WeaponCraft(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_WEAPON, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 防具製作
function TDonguriSys.ArmorCraft(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_ARMORC, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ハンター呼び名変更サービス
function TDonguriSys.Rename(var response: String): Boolean;
{begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_RENAME, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
}
var
	redirect: Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGet(URL_DNG_RENAME, '', True, response, redirect);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 復活サービス
function TDonguriSys.Resurrect(var response: String; var cancel: Boolean; handle: HWND): Boolean;
var
	redirect: Boolean;
  post: Boolean;
  ok: Boolean;
  res: String;
  nextUrl: String;
  resMsg: String;
  param: TStringList;
  mbFlag: Integer;
begin
	Result := False;
  cancel := False;
  response := '';

	try
	  ClearResponse;

  	if HttpGet(URL_DNG_RESRRCT, '', True, res, redirect) = False then
      Exit;

  	ok := CheckResurrect(res, resMsg, nextUrl, post);
		if resMsg <> '' then
	    resMsg := UnSanitize(resMsg);

		if ok = False then begin
      response := resMsg;
      Exit;
    end;

    if (resMsg <> '') and (Pos('Error', resMsg) < 1) then
	  	mbFlag := MB_ICONQUESTION
    else
    	mbFlag := MB_ICONWARNING;

    if MsgBox(handle, resMsg + #10#10 + 'レベル復活を実行しますか？',
    					'レベル復活', MB_YESNO or mbFlag) <> IDYES then begin
    	cancel := True;
      Exit;
    end;

    if post then begin
		  param := TStringList.Create;
      try
      	Result := HttpPost(nextUrl, URL_DNG_RESRRCT, param, False, response, redirect);
      finally
      	param.Free;
      end;
    end else begin
    	Result := HttpGet(nextUrl, URL_DNG_RESRRCT, False, response, redirect);
    end;

    if Result then
	    response := UnSanitize(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

function TDonguriSys.CheckResurrect(html: String; var resMsg: String; var nextUrl: String; var post: Boolean): Boolean;
var
	form: String;
  temp: String;
begin
	Result  := False;
  resMsg  := '';
  nextUrl := '';
  post    := True;

  try
    if Pos('<html', html) < 1 then begin
		  resMsg  := html;
    	Exit;
    end;

  	if Extract('<form ', '</form>', html, form) = False then
    	Exit;

  	if Extract('action="', '"', form, nextUrl) = False then
    	Exit;

    if nextUrl = '' then
    	Exit;

  	Extract('method="', '"', form, temp);
    post := (temp = 'post');

  	if Extract('>お知らせ：', '</p>', form, resMsg) then
    	resMsg := 'お知らせ：' + resMsg;

    Result := True;

  except
  end;
end;


// ドングリ転送サービス
function TDonguriSys.Transfer(var response: String): Boolean;
{begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_TRNSFR, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
}
var
	redirect: Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGet(URL_DNG_TRNSFR, '', True, response, redirect);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 工作センター
function TDonguriSys.Craft(var response: String): Boolean;
{begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_CRAFT, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
}
var
	redirect: Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGet(URL_DNG_CRAFT, '', True, response, redirect);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 鉄の大砲の玉作成
function TDonguriSys.CraftCB(amount: Integer; var response: String): Boolean;
var
	postParam: TStringList;
  redirect: Boolean;
begin

	postParam := TStringList.Create;
  try
  	postParam.Add('cannonballamt=' + IntToStr(amount));
  	Result := HttpPost(URL_DNG_CRAFTCB, URL_DNG_CRAFT, postParam, True, response, redirect);
  finally
  	postParam.Free;
  end;

end;



//----------
//----------

// どんぐり大砲
function TDonguriSys.Cannon(urlRes, date: String; no: Integer): Boolean;
//const
//  DBG_SEP = #39 + ',' + #39;
var
	ok: Boolean;
  res: String;
  url2: String;
  url3: String;
  param: String;
  resMsg: String;
	redirect: Boolean;
  resNo: String;
  mbType: Cardinal;
  //debug: String;
begin
	Result := False;

	try
	  ClearResponse;

  	ok := HttpGet(URL_DNG_CANNON, '', True, res, redirect);
    if ok then
	  	ok := CheckCannon(res, resMsg);

    if ok = False then begin
    	if resMsg = '' then
				ShowCannonError('どんぐり大砲を使用できません。', True)
      else
		    ShowCannonError(resMsg);
    	Exit;
    end;

  	resNo := Format('%d: ', [no]);

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
		    ShowCannonError('どんぐり大砲を使用できません。', True)
      else
		    ShowCannonError(resNo + resMsg);
    	Exit;
    end;

    //debug := #39 + urlRes + DBG_SEP + date + DBG_SEP + resMsg + DBG_SEP;

    if Pos('当たる確率が99%です', resMsg) > 0 then
	  	mbType := MB_YESNO or MB_ICONQUESTION
    else
	  	mbType := MB_YESNO or MB_ICONWARNING;

    if ShowCannonMessage(resNo + resMsg + #10 + 'どんぐり大砲を撃ちますか？',
    											mbType) <> IDYES then begin
			Result := True;
      //DebugLog(debug + 'Cancel' + #39);
    	Exit;
    end;

    res := '';
  	url3 := URL_DNG_CANNON3 + param;
  	ok := HttpGet(url3, url2, True, res, redirect);

		//DebugLog(debug + res + #39);

    if ok then begin
      if (res <> '') and (Pos('<html', res) < 1) then begin
        if Pos('どんぐり大砲が直撃しました', res) > 0 then
          mbType := MB_OK or MB_ICONINFORMATION
        else if Pos('どんぐり大砲が誤射しました', res) > 0 then
          mbType := MB_OK or MB_ICONERROR
        else
          mbType := MB_OK or MB_ICONWARNING;
				ShowCannonMessage(resNo + res, mbType);
      end else
				ShowCannonMessage(resNo + 'どんぐり大砲を発射しましたが結果不明です。' + #10#10 + res,
         												MB_OK or MB_ICONWARNING);
    end else
	    ShowCannonError(resNo + 'どんぐり大砲の発射に失敗しました。', True);

    Result := ok;

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
	    ShowCannonError('どんぐり大砲の発射でエラーが発生しました。', True);
    end;
  end;

end;

// formタグのaction属性が特定のURLであるかを確認
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

// /cannonのレスポンスチェック
function TDonguriSys.CheckCannon(html: String; var resMsg: String): Boolean;
begin
	//Result := False;

  //if Pos('<h1>どんぐり大砲</h1>', html) < 1 then
  //	Exit;

	Result := CheckFormAction(html, URL_DNG_CANNON2);		// 次のURL確認
end;

// /confirmのレスポンスチェック
function TDonguriSys.CheckConfirm(html: String; var resMsg: String): Boolean;
var
	idx1: Integer;
	idx2: Integer;
	idx3: Integer;
begin
	Result := False;
  resMsg := '';

  if Pos('<html', html) < 1 then begin
	  resMsg := html;		// プレーンテキスト
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
  resMsg := Copy(html, idx2, idx3 - idx2);	// メッセージ文らしきものを取り出し

	Result := CheckFormAction(html, URL_DNG_CANNON3);		// 次のURL確認
end;

// どんぐり大砲用エラーメッセージ表示
procedure TDonguriSys.ShowCannonError(msg: String; httperr: Boolean = False);
begin
	if httperr then
  	msg := msg + #10 +
					 FErroeMessage + #10 +
        	 'HTTP ' + IntToStr(FResponseCode) + #10 +
           FResponseText;

  ShowCannonMessage(msg, MB_OK or MB_ICONERROR);
end;

// どんぐり大砲用メッセージ表示
// ※どんぐり大砲はメイン画面からの操作を前提とし、メッセージボックスもメイン画面を親とする
function TDonguriSys.ShowCannonMessage(msg: String; mbType: Cardinal): Integer;
begin
	Result := MsgBox(GikoForm.Handle, PChar(msg), 'どんぐり大砲', mbType);
end;



{
procedure TDonguriSys.DebugLog(text: String);
var
  dst: TextFile;
  path: String;
begin
	path := ChangeFileExt(Application.ExeName, '.cannon.log');

  try
    AssignFile(dst, path);
    if FileExists(path) then
      Append(dst)
    else
      Rewrite(dst);

		Writeln(dst, text);

  finally
		CloseFile(dst);
  end;
end;
}

end.
