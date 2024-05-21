unit DonguriSystem;

//{$DEFINE _DEBUG_MODE}

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, Forms, StrUtils,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdGlobal, IdURI, IdTCPClient,
  IdHTTP, ComCtrls;

type
	TDonguriItem = class(TObject)
  protected
    procedure SetMarimo(html: String);
    procedure SetState(html: String);
    function GetRangeValue(html: String): String;
  public
    Rarity: String;		// レアリティ
    Name:   String;		// 名称
    CRIT:   String;
    ELEM:   String;
    Modify: String;		// MOD
    Marimo: String;		// マリモ
    ItemNo: String;		// アイテムNo.
    Lock:   Boolean;
    Used:		Boolean;

    procedure Clear; virtual;
    procedure SetListItem(no: Integer; var item: TListItem); virtual;
    function IsEmpty: Boolean;
    function GetImageIndex: Integer;
  end;
  TDonguriItemImageIndex = (
    // アンロック
    IDX_IMG_N_UNLOCK   = 0,
    IDX_IMG_R_UNLOCK   = 1,
    IDX_IMG_SR_UNLOCK  = 2,
    IDX_IMG_SSR_UNLOCK = 3,
    IDX_IMG_UR_UNLOCK  = 4,
    // ロック
    IDX_IMG_N_LOCK     = 5,
    IDX_IMG_R_LOCK     = 6,
    IDX_IMG_SR_LOCK    = 7,
    IDX_IMG_SSR_LOCK   = 8,
    IDX_IMG_UR_LOCK    = 9
  );

  TDonguriWeapon = class(TDonguriItem)
    ATK:    String;
    SPD:    String;

    procedure Clear; override;
    procedure SetListItem(no: Integer; var item: TListItem); override;
    procedure SetItems(html: String);
  end;

  TDonguriArmor = class(TDonguriItem)
    DEF:    String;
    WT:     String;

    procedure Clear; override;
    procedure SetListItem(no: Integer; var item: TListItem); override;
    procedure SetItems(html: String);
  end;

  TDonguriBag = class(TObject)
  public
    Slot:       Integer;
    UseWeapon:  TDonguriWeapon;
    UseArmor:   TDonguriArmor;
    WeaponList: TList;
    ArmorList:  TList;

		constructor Create;
		destructor Destroy; override;
    procedure Clear;
  end;

//--------------------------------------------------
type
  TDonguriSys = class(TObject)

  private
    FHTTP: TIdHTTP;
    FSSL: TIdSSLIOHandlerSocketOpenSSL;
    FResponseText: String;
    FResponseCode: Integer;
    FErroeMessage: String;
    FProcessing:   Boolean;

    procedure ClearResponse;
		function HttpGet(url, referer: String; gzip: Boolean; var response: String; var redirect: Boolean): Boolean;
		function HttpGetCall(urlStart: String; var response: String): Boolean;
		function HttpPost(url, referer: String; postParam: TStringList; gzip: Boolean; var response: String; var redirect: Boolean): Boolean;
    function HttpPostCall(urlStart: String; var response: String): Boolean;

		function CheckFormAction(html, url: String): Boolean;
  	function CheckResurrect(html: String; var resMsg: String; var nextUrl: String; var post: Boolean): Boolean;
		function CheckCannon(html: String; var resMsg: String): Boolean;
    function CheckConfirm(html: String; var resMsg: String): Boolean;
    procedure ShowCannonError(msg: String; httperr: Boolean = False);
    function  ShowCannonMessage(msg: String; mbType: Cardinal): Integer;
    function ParceBag(html: String; var itemBag: TDonguriBag): Boolean;

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
    function CraftKY(amount: Integer; var response: String): Boolean;
    function Bag(var itemBag: TDonguriBag; var response: String; var denied: Boolean): Boolean;
    function AddSlots(var response: String): Boolean;
    function Unequip(var itemBag: TDonguriBag; weapon: Boolean): Boolean;
    function ChestOpen(var itemBag: TDonguriBag; var response: String): Boolean;
    function RecycleAll(var itemBag: TDonguriBag): Boolean;
    function Lock(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;
    function Unlock(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;
    function Equip(itemNo: String; var itemBag: TDonguriBag): Boolean;
    function Recycle(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;

		function Cannon(urlRes, date: String; no: Integer): Boolean;

    // HTTPレスポンステキスト
    property ResponseText: String  read FResponseText;
    // HTTPレスポンスコード
    property ResponseCode: Integer read FResponseCode;
    // 例外メッセージ
    property ErroeMessage: String  read FErroeMessage;
  	// 通信中かどうか
    property Processing:   Boolean read FProcessing;
  end;


function Extract(kw1, kw2, text: String; var val: String): Boolean;
function Extract2(kw1, kw2: String; var text: String; var val: String): Boolean;
function TrimTag(html: String): String;

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
	URL_DNG_CRAFTKY = 'https://donguri.5ch.net/craft/key';						// 工作センター鉄のキー作成
  URL_DNG_BAG     = 'https://donguri.5ch.net/bag';									// アイテムバッグ
  URL_DNG_ADDSLOT = 'https://donguri.5ch.net/addslots';							// スロット追加
  URL_DNG_UNEQW   = 'https://donguri.5ch.net/unequip/weapon';				// 装備中の武器を外す
  URL_DNG_UNEQA   = 'https://donguri.5ch.net/unequip/armor';				// 装備中の防具を外す
  URL_DNG_CHESTOP = 'https://donguri.5ch.net/open';									// 宝箱を開ける
  URL_DNG_RECYALL = 'https://donguri.5ch.net/recycleunlocked';			// ロックされていない武器防具を全て分解する
  URL_DNG_LOCK    = 'https://donguri.5ch.net/lock/';								// ロック
  URL_DNG_UNLOCK  = 'https://donguri.5ch.net/unlock/';							// アンロック
  URL_DNG_EQUIP   = 'https://donguri.5ch.net/equip/';								// 装備
  URL_DNG_RECYCLE = 'https://donguri.5ch.net/recycle/';							// 分解

  URL_DNG_CANNON  = 'https://donguri.5ch.net/cannon';								// どんぐり大砲
  URL_DNG_CANNON2 = 'https://donguri.5ch.net/confirm';							// どんぐり大砲確認
  URL_DNG_CANNON3 = 'https://donguri.5ch.net/fire';									// どんぐり大砲発射
	URL_5CH_ROOT    = 'https://5ch.net/';

  // イメージインデックス

implementation

uses
  GikoSystem, IndyModule, YofUtils, Giko, GikoUtil, MojuUtils;


// コンストラクタ
constructor TDonguriSys.Create;
begin
	Inherited;

  FResponseCode := 0;
  FProcessing := False;

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

  if FProcessing then
    Exit;

  FProcessing := True;

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
//        for dbgcnt := 0 to 99 do begin
//					dbgpath := 'D:\Log\Donguri\' + FormatDateTime('yyyymmdd_hhnnss_zzz', Now) + Format('_%.2d.sjis.html', [dbgcnt]);
//          if not FileExists(dbgpath) then
//          	Break;
//        end;
//			  dbg := TMemoryStream.Create;
//        try
//        	dbg.Write(PChar(response)^,Length(response));
//          dbg.SaveToFile(dbgpath);
//        finally
//          dbg.Free;
//        end;
{$ENDIF}
      end;
    end;

    Result := ok;

  finally
  	res.Free;
	  FProcessing := False;
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

  if FProcessing then
    Exit;

  FProcessing := True;

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
	  FProcessing := False;
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

  if FProcessing then
    Exit;

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

// リダイレクト有りのHTTP-POST（リダイレクトはGET）
function TDonguriSys.HttpPostCall(urlStart: String; var response: String): Boolean;
var
  url: String;
  ref: String;
  res: String;
  red: Boolean;
  gzip: Boolean;
  ok: Boolean;
  param: TStringList;
  first: Boolean;
begin
	Result := False;
  response := '';

  if FProcessing then
    Exit;

  param := TStringList.Create;

	try
	  ClearResponse;

    ok := False;
  	url := urlStart;
    ref := '';
    first := True;

  	while True do begin
    	res := '';
      red := False;
      gzip := (url = URL_DNG_ROOT);

    	if first then begin
	      ok := HttpPost(url, ref, param, gzip, res, red);
        first := False;
      end else
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
  param.Free;
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
	Result := False;
  response := '';

	postParam := TStringList.Create;
  try
  	postParam.Add('cannonballamt=' + IntToStr(amount));
  	Result := HttpPost(URL_DNG_CRAFTCB, URL_DNG_CRAFT, postParam, True, response, redirect);
  finally
  	postParam.Free;
  end;
end;

// 鉄のキー作成
function TDonguriSys.CraftKY(amount: Integer; var response: String): Boolean;
var
	postParam: TStringList;
  redirect: Boolean;
begin
	Result := False;
  response := '';

	postParam := TStringList.Create;
  try
  	postParam.Add('ironkeyamt=' + IntToStr(amount));
  	Result := HttpPost(URL_DNG_CRAFTKY, URL_DNG_CRAFT, postParam, True, response, redirect);
  finally
  	postParam.Free;
  end;
end;

// アイテムバッグ
function TDonguriSys.Bag(var itemBag: TDonguriBag; var response: String; var denied: Boolean): Boolean;
var
  ret: Boolean;
  redirect: Boolean;
begin
	Result := False;
  denied := False;
  response := '';
  itemBag.Clear;

	try
	  ClearResponse;
  	ret := HttpGet(URL_DNG_BAG, URL_DNG_ROOT, True, response, redirect);

    if ret then begin
    	if redirect then begin
      	denied := True;
      end else if Pos('<h1>アイテムバッグ</h1>', response) > 0 then begin
				Result := ParceBag(response, itemBag);
      end;
    end;
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

function TDonguriSys.ParceBag(html: String; var itemBag: TDonguriBag): Boolean;
const
	KW_SLOT_S = '<h5>アイテムバッグには';
  KW_SLOT_E = 'スロットがあります。';
  KW_USEW_S = '<h3>装備している武器: </h3>';
  KW_USEW_E = '</p>';
  KW_USEA_S = '<h3>装備している防具: </h3>';
  KW_USEA_E = '</p>';
  KW_IBAG_S = '<h3>アイテムバッグ:</h3>';
  KW_TBDY_S  = '<tbody>';
  KW_TBDY_E  = '</tbody>';
  KW_TROW_S = '<tr';
  KW_TROW_E = '</tr>';

var
	tmp: String;
	tmp2: String;
  idx: Integer;
  wp: TDonguriWeapon;
  am: TDonguriArmor;
begin
	Result := False;

	try
		itemBag.Clear;

    // スロット数
		if Extract2(KW_SLOT_S, KW_SLOT_E, html, tmp) then
    	itemBag.Slot := StrToIntDef(tmp, 0);

    // 使用中の武器
		if Extract2(KW_USEW_S, KW_USEW_E, html, tmp) then begin
    	idx := Pos(KW_TBDY_S, tmp);
      if idx > 0 then
      	Delete(tmp, 1, idx + 6);
      itemBag.UseWeapon.SetItems(tmp);
    end;

    // 使用中の防具
		if Extract2(KW_USEA_S, KW_USEA_E, html, tmp) then begin
    	idx := Pos(KW_TBDY_S, tmp);
      if idx > 0 then
      	Delete(tmp, 1, idx + 6);
      itemBag.UseArmor.SetItems(tmp);
    end;

    idx := Pos(KW_IBAG_S, html);
    if idx > 0 then
    	Delete(html, 1, idx + Length(KW_IBAG_S) - 1);

		// 武器一覧
		if Extract2(KW_TBDY_S, KW_TBDY_E, html, tmp) then begin
    	while True do begin
				if Extract2(KW_TROW_S, KW_TROW_E, tmp, tmp2) = False then
        	Break;
				wp := TDonguriWeapon.Create;
        wp.SetItems(tmp2);
        itemBag.WeaponList.Add(wp);
      end;
  	end;

    // 防具一覧
		if Extract2(KW_TBDY_S, KW_TBDY_E, html, tmp) then begin
    	while True do begin
				if Extract2(KW_TROW_S, KW_TROW_E, tmp, tmp2) = False then
        	Break;
			  am := TDonguriArmor.Create;
        am.SetItems(tmp2);
        itemBag.ArmorList.Add(am);
      end;
  	end;

		Result := True;
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// スロット追加
function TDonguriSys.AddSlots(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

		Result := HttpGetCall(URL_DNG_ADDSLOT, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 装備を外す
function TDonguriSys.Unequip(var itemBag: TDonguriBag; weapon: Boolean): Boolean;
var
	res: String;
  ret: Boolean;
begin
	Result := False;
	itemBag.Clear;

	try
	  ClearResponse;

    if weapon then
			ret := HttpGetCall(URL_DNG_UNEQW, res)		// 武器
    else
			ret := HttpGetCall(URL_DNG_UNEQA, res);		// 防具

    if ret and (Pos('<h1>アイテムバッグ</h1>', res) > 0) then
			Result := ParceBag(res, itemBag);
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 宝箱を開ける
function TDonguriSys.ChestOpen(var itemBag: TDonguriBag; var response: String): Boolean;
var
  ret: Boolean;
begin
	Result := False;
	itemBag.Clear;

  try
	  ClearResponse;

		ret := HttpPostCall(URL_DNG_CHESTOP, response);

    if ret and (Pos('<h1>アイテムバッグ</h1>', response) > 0) then
			Result := ParceBag(response, itemBag)
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ロックされていない武器防具を全て分解する
function TDonguriSys.RecycleAll(var itemBag: TDonguriBag): Boolean;
var
	res: String;
  ret: Boolean;
begin
	Result := False;
	itemBag.Clear;

  try
	  ClearResponse;

		ret := HttpGetCall(URL_DNG_RECYALL, res);

    if ret and (Pos('<h1>アイテムバッグ</h1>', res) > 0) then
			Result := ParceBag(res, itemBag)
    else
    	FErroeMessage := res;
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ロック
function TDonguriSys.Lock(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;
var
	i: Integer;
	res: String;
  ret: Boolean;
begin
  ret := False;
	itemBag.Clear;

  try
    for i := 0 to itemNoList.Count - 1 do begin
      ClearResponse;

      ret := HttpGetCall(URL_DNG_LOCK + itemNoList.Strings[i], res);

      if ret and (Pos('<h1>アイテムバッグ</h1>', res) > 0) then begin
				itemBag.Clear;
        ret := ParceBag(res, itemBag)
      end else begin
      	ret := False;
        FErroeMessage := res;
      end;

      if ret = False then
      	Break;
    end;
  except
    on e: Exception do begin
			ret := False;
      FErroeMessage := e.Message;
    end;
  end;

  Result := ret;
end;

// アンロック
function TDonguriSys.Unlock(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;
var
	i: Integer;
	res: String;
  ret: Boolean;
begin
  ret := False;
	itemBag.Clear;

  try
    for i := 0 to itemNoList.Count - 1 do begin
      ClearResponse;

      ret := HttpGetCall(URL_DNG_UNLOCK + itemNoList.Strings[i], res);

      if ret and (Pos('<h1>アイテムバッグ</h1>', res) > 0) then begin
				itemBag.Clear;
        ret := ParceBag(res, itemBag)
      end else begin
      	ret := False;
        FErroeMessage := res;
      end;

      if ret = False then
      	Break;
    end;
  except
    on e: Exception do begin
			ret := False;
      FErroeMessage := e.Message;
    end;
  end;

  Result := ret;
end;

// 装備
function TDonguriSys.Equip(itemNo: String; var itemBag: TDonguriBag): Boolean;
var
	res: String;
  ret: Boolean;
begin
	Result := False;
	itemBag.Clear;

  try
	  ClearResponse;

		ret := HttpGetCall(URL_DNG_EQUIP + itemNo, res);

    if ret and (Pos('<h1>アイテムバッグ</h1>', res) > 0) then
			Result := ParceBag(res, itemBag)
    else
    	FErroeMessage := res;
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// 分解
function TDonguriSys.Recycle(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;
var
	i: Integer;
	res: String;
  ret: Boolean;
begin
  ret := False;
	itemBag.Clear;

  try
    for i := 0 to itemNoList.Count - 1 do begin
      ClearResponse;

      ret := HttpGetCall(URL_DNG_RECYCLE + itemNoList.Strings[i], res);

      if ret and (Pos('<h1>アイテムバッグ</h1>', res) > 0) then begin
				itemBag.Clear;
        ret := ParceBag(res, itemBag)
      end else begin
      	ret := False;
        FErroeMessage := res;
      end;

      if ret = False then
      	Break;
    end;
  except
    on e: Exception do begin
			ret := False;
      FErroeMessage := e.Message;
    end;
  end;

  Result := ret;
end;


//------------------------------------------------------------------------------
// どんぐり大砲
//------------------------------------------------------------------------------

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
	  resMsg := TrimTag(html);		// プレーンテキスト
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
  resMsg := TrimTag(Copy(html, idx2, idx3 - idx2));	// メッセージ文らしきものを取り出し

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



//------------------------------------------------------------------------------
// アイテムバッグ
//------------------------------------------------------------------------------

procedure TDonguriItem.Clear;
begin
  Rarity := '';
  Name   := '';
  CRIT   := '';
  ELEM   := '';
  Modify := '';
  Marimo := '';
  ItemNo := '';
  Lock   := False;
  Used   := False;
end;

procedure TDonguriItem.SetMarimo(html: String);
var
	tmp: String;
  idx: Integer;
begin
	tmp := TrimTag(html);
	idx := Pos('マ', tmp);
  if idx > 0 then
  	SetLength(tmp, idx - 1);
  Marimo := Trim(tmp);
end;

procedure TDonguriItem.SetState(html: String);
var
	tmp: String;
begin
  Used := (Pos('[外す]', html) > 0);	// バッグ内アイテムリストの場合は使用中かどうかの情報がない
  if Used = False then
    Lock := (Pos('[解錠]', html) > 0);	// 使用中リストにはロック中かどうかの情報がない
  if Extract2('<a href="https://donguri.5ch.net/equip/', '">', html, tmp) then
		ItemNo := tmp;	// 使用中リストにはこれがない
end;

function TDonguriItem.GetRangeValue(html: String): String;
var
	tmp: String;
  idx: Integer;
begin
	tmp := Trim(TrimTag(html));
  idx := Pos('~', tmp);
  if idx > 0 then
  	Result := Copy(tmp, 1, idx - 1) + '～' + Copy(tmp, idx + 1, Length(tmp) - idx)
  else
  	Result := tmp;
end;

function TDonguriItem.GetImageIndex: Integer;
begin
  if Rarity = 'N' then
		if Lock then Result := Ord(IDX_IMG_N_LOCK)
    else         Result := Ord(IDX_IMG_N_UNLOCK)
  else if Rarity = 'R' then
		if Lock then Result := Ord(IDX_IMG_R_LOCK)
    else         Result := Ord(IDX_IMG_R_UNLOCK)
  else if Rarity = 'SR' then
		if Lock then Result := Ord(IDX_IMG_SR_LOCK)
    else         Result := Ord(IDX_IMG_SR_UNLOCK)
  else if Rarity = 'SSR' then
		if Lock then Result := Ord(IDX_IMG_SSR_LOCK)
    else         Result := Ord(IDX_IMG_SSR_UNLOCK)
  else if Rarity = 'UR' then
		if Lock then Result := Ord(IDX_IMG_UR_LOCK)
    else         Result := Ord(IDX_IMG_UR_UNLOCK)
  else           Result := -1;
end;

procedure TDonguriItem.SetListItem(no: Integer; var item: TListItem);
begin
	if no > 0 then
	  item.Caption := Format('%3d', [no])
  else
	  item.Caption := ' ';
  item.SubItems.Add(Rarity);
  item.SubItems.Add(Name);
  item.SubItems.Add('');
  item.SubItems.Add('');
  item.SubItems.Add(CRIT);
  item.SubItems.Add(ELEM);
  item.SubItems.Add(Modify);
  item.SubItems.Add(Marimo);
  item.Data := Self;
	item.ImageIndex := GetImageIndex;
end;

function TDonguriItem.IsEmpty: Boolean;
begin
	Result := (Name = '');
end;

procedure TDonguriWeapon.Clear;
begin
	Inherited;
	ATK := '';
	SPD := '';
end;

procedure TDonguriWeapon.SetListItem(no: Integer; var item: TListItem);
begin
	Inherited;
  item.SubItems.Strings[2] := ATK;
  item.SubItems.Strings[3] := SPD;
end;

procedure TDonguriWeapon.SetItems(html: String);
var
	i: Integer;
  idx: Integer;
  tmp1: String;
  tmp2: String;
begin
  for i := 0 to 7 do begin
    if Extract2('<td ', '</td>', html, tmp1) = False then
	    Break;
    idx := Pos('>', tmp1);
    if idx > 0 then
      Delete(tmp1, 1, idx);

    case i of
      0: begin
        tmp2 := '';
        idx := Pos('<br>', tmp1);
        if idx > 0 then begin
          tmp2 := Copy(tmp1, idx + 4, Length(tmp1) - idx + 3);
          SetLength(tmp1, idx - 1);
        end;
        Name := Trim(TrimTag(tmp1));
        tmp2 := Trim(TrimTag(tmp2));
        tmp1 := '';
        if Extract2('[', ']', tmp2, tmp1) then
          Rarity := tmp1;
      end;
    	1: ATK := GetRangeValue(tmp1);
      2: SPD := Trim(TrimTag(tmp1));
      3: CRIT := Trim(TrimTag(tmp1));
      4: ELEM := Trim(TrimTag(tmp1));
      5: Modify := Trim(TrimTag(tmp1));
      6: SetMarimo(tmp1);
      7: SetState(tmp1);
    end;
  end;
end;

procedure TDonguriArmor.Clear;
begin
	Inherited;
	DEF := '';
	WT  := '';
end;

procedure TDonguriArmor.SetListItem(no: Integer; var item: TListItem);
begin
	Inherited;
  item.SubItems.Strings[2] := DEF;
  item.SubItems.Strings[3] := WT;
end;

procedure TDonguriArmor.SetItems(html: String);
var
	i: Integer;
  idx: Integer;
  tmp1: String;
  tmp2: String;
begin
  for i := 0 to 7 do begin
    if Extract2('<td ', '</td>', html, tmp1) = False then
	    Break;
    idx := Pos('>', tmp1);
    if idx > 0 then
      Delete(tmp1, 1, idx);

    case i of
      0: begin
        tmp2 := '';
        idx := Pos('<br>', tmp1);
        if idx > 0 then begin
          tmp2 := Copy(tmp1, idx + 4, Length(tmp1) - idx + 3);
          SetLength(tmp1, idx - 1);
        end;
        Name := Trim(TrimTag(tmp1));
        tmp2 := Trim(TrimTag(tmp2));
        tmp1 := '';
        if Extract2('[', ']', tmp2, tmp1) then
          Rarity := tmp1;
      end;
    	1: DEF := GetRangeValue(tmp1);
      2: WT  := Trim(TrimTag(tmp1));
      3: CRIT := Trim(TrimTag(tmp1));
      4: ELEM := Trim(TrimTag(tmp1));
      5: Modify := Trim(TrimTag(tmp1));
      6: SetMarimo(tmp1);
      7: SetState(tmp1);
    end;
  end;
end;


// コンストラクタ
constructor TDonguriBag.Create;
begin
	Inherited;

  try
    UseWeapon  := TDonguriWeapon.Create;
    UseArmor   := TDonguriArmor.Create;
    WeaponList := TList.Create;
    ArmorList  := TList.Create;
    Clear;
  except
  end;
end;

// デストラクタ
destructor TDonguriBag.Destroy;
begin
	try
    Clear;
    FreeAndNil(UseWeapon);
    FreeAndNil(UseArmor);
    FreeAndNil(WeaponList);
    FreeAndNil(ArmorList);
  except
  end;

	Inherited;
end;

procedure TDonguriBag.Clear;
var
	i: Integer;
begin
  try
    Slot := 0;
    UseWeapon.Clear;
    UseArmor.Clear;

    for i := 0 to WeaponList.Count - 1 do
      TDonguriWeapon(WeaponList.Items[i]).Free;
    WeaponList.Clear;

    for i := 0 to ArmorList.Count - 1 do
      TDonguriArmor(ArmorList.Items[i]).Free;
    ArmorList.Clear;
  except
  end;
end;






//------------------------------------------------------------------------------
// 共通関数
//------------------------------------------------------------------------------

// 削除なしキーワード抽出
function Extract(kw1, kw2, text: String; var val: String): Boolean;
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

// 削除ありキーワード抽出
function Extract2(kw1, kw2: String; var text: String; var val: String): Boolean;
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

	Delete(text, 1, idx2 + Length(kw2) - 1);		// 抽出キーワードまで削除

	Result := True;
end;

// タグ削除
function TrimTag(html: String): String;
var
	idx1: Integer;
	idx2: Integer;
  tmp: String;
begin
  tmp := html;

  while True do begin
    idx1 := Pos('<', tmp);
    if idx1 < 1 then
      Break;
    idx2 := PosEx('>', tmp, idx1 + 1);
    if idx2 < 1 then
      Break;

    Delete(tmp, idx1, idx2 - idx1 + 1);
  end;

  Result := tmp;
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
