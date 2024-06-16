unit DonguriSystem;

//{$DEFINE _DEBUG_MODE}

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, Forms, StrUtils,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdGlobal, IdURI, IdTCPClient,
  IdHTTP, ComCtrls;

type
  TDonguriAutoLogin = (atlOn, atlOff, atlUnknown);
  TModifyWeapon = (mdwDmgMin, mdwDmgMax, mdwSpeed,  mdwCrit);
  TModifyArmor  = (mdaDefMin, mdaDefMax, mdaWeight, mdaCrit);

	TDonguriHome = class(TObject)
  protected
    function GetProgressPosition(var html: String; const kws: String; const kwe: String): Integer;
		procedure SetSkillInfo(var html: String; const kws: String; const kw2: String; const kwe: String;
												const pbs: String; const pbe: String; var Sel: Boolean; var Value: Integer; var Rate: Integer);
  public
  	Hunter:     Boolean;
    UserMode:   String;
    UserID:     String;
    UserName:   String;
    Level:      String;
    RateExpr:		Integer;
    Period:     String;
    RatePrgr:   Integer;
    Explor:     Integer;
    RateExplr:  Integer;
    SelExplr:   Boolean;
    Mining:     Integer;
    RateMnng:   Integer;
    SelMnng:    Boolean;
    Woodct:     Integer;
    RateWdct:   Integer;
    SelWdct:    Boolean;
    Weapon:     Integer;
    RateWpn:    Integer;
    SelWpn:     Boolean;
    Armorc:     Integer;
    RateArmr:   Integer;
    SelArmr:    Boolean;
    // ���v
    SttCannon:  String;
    SttFight:   String;
    // �ۊǌ�
    Acorn:      String;
    AcornTitle: String;
    Wood:       Integer;
    Iron:       Integer;
    IronKey:    Integer;
    Marimo:     Integer;
    WoodCB:     Integer;
    IronCB:     Integer;
    HP:         Integer;
  	// �ݒ�
    AutoLogin:  TDonguriAutoLogin;
    ////
    Error:      String;

		constructor Create;
    procedure Clear;
    function Parsing(html: String): Boolean;
  end;


	TDonguriItem = class(TObject)
  protected
    procedure SetMarimo(html: String);
    procedure SetState(html: String);
    function GetRangeValue(html: String): String;
    function TrimBracket(src: String): String;
  public
    Rarity: String;		// ���A���e�B
    Name:   String;		// ����
    CRIT:   String;
    ELEM:   String;
    Modify: String;		// MOD
    Marimo: String;		// �}����
    ItemNo: String;		// �A�C�e��No.
    Lock:   Boolean;
    Used:		Boolean;

    procedure Clear; virtual;
    procedure SetListItem(no: Integer; var item: TListItem); virtual;
    function IsEmpty: Boolean;
    function GetImageIndex: Integer;
  end;
  TDonguriItemImageIndex = (
    // �A�����b�N
    IDX_IMG_N_UNLOCK   = 0,
    IDX_IMG_R_UNLOCK   = 1,
    IDX_IMG_SR_UNLOCK  = 2,
    IDX_IMG_SSR_UNLOCK = 3,
    IDX_IMG_UR_UNLOCK  = 4,
    // ���b�N
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
    FHome:				 TDonguriHome;

    procedure ClearResponse;
		function HttpGet(url, referer: String; gzip: Boolean; var response: String; var redirect: Boolean): Boolean;
		function HttpGetCall(urlStart: String; var response: String): Boolean;
		function HttpPost(url, referer: String; postParam: TStringList; gzip: Boolean; var response: String; var redirect: Boolean): Boolean;
    function HttpPostCall(urlStart, referer: String; postParam: TStringList; var response: String): Boolean;

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

		function Download(url, referer: String; var response: TMemoryStream): Boolean;

		function Root(var response: String): Boolean;
		function Auth(var response: String): Boolean;
		function Login(var response: String): Boolean;
		function MailLogin(mail, pwd: String; var response: String): Boolean;
		function Logout(var response: String): Boolean;
    function RegisterPage(var response: String): Boolean;
    function RegisterSubmit(mail, pwd: String; var response: String): Boolean;
    function RegisterVerify(link: String; var response: String): Boolean;
    function ToggleAutoLogin(var response: String): Boolean;

    function Exploration(var response: String): Boolean;
    function Mining(var response: String): Boolean;
    function WoodCutting(var response: String): Boolean;
    function WeaponCraft(var response: String): Boolean;
    function ArmorCraft(var response: String): Boolean;

    function RenamePage(var response: String): Boolean;
    function Rename(newName: String; var response: String): Boolean;
    function Resurrect(var response: String; var cancel: Boolean; handle: HWND): Boolean;
    function TransferPage(var response: String): Boolean;
    function Transfer(recipientID, amount: String; var response: String): Boolean;
    function Craft(var response: String): Boolean;
    function CraftCB(amount: Integer; var response: String): Boolean;
    function CraftKY(amount: Integer; var response: String): Boolean;
    function Bag(var itemBag: TDonguriBag; var response: String; var denied: Boolean): Boolean;
    function AddSlots(var response: String): Boolean;
    function Unequip(var itemBag: TDonguriBag; weapon: Boolean): Boolean;
    function ChestOpen(amount: Integer; var itemBag: TDonguriBag; var response: String): Boolean;
    function RecycleAll(var itemBag: TDonguriBag): Boolean;
    function Lock(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;
    function Unlock(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;
    function Equip(itemNo: String; var itemBag: TDonguriBag): Boolean;
    function Recycle(itemNoList: TStringList; var itemBag: TDonguriBag): Boolean;
    function ModArmorView(itemNo: String; var response: String): Boolean;
    function ModArmor(modType: TModifyArmor; itemNo: String; var response: String): Boolean;
    function ModWeaponView(itemNo: String; var response: String): Boolean;
    function ModWeapon(modType: TModifyWeapon; itemNo: String; var response: String): Boolean;


		function Cannon(urlRes, date: String; no: Integer): Boolean;

    // HTTP���X�|���X�e�L�X�g
    property ResponseText: String  read FResponseText;
    // HTTP���X�|���X�R�[�h
    property ResponseCode: Integer read FResponseCode;
    // ��O���b�Z�[�W
    property ErroeMessage: String  read FErroeMessage;
  	// �ʐM�����ǂ���
    property Processing:   Boolean read FProcessing;

    // ���[�U���
    property Home:				 TDonguriHome read FHome;

  	// �r���h���[�h
		function GetBuildMode: String;
    property BuildMode: String read GetBuildMode;
  end;


function IsRootPage(html: String): Boolean;
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
  URL_DNG_REGIST  = 'https://donguri.5ch.net/register';
  URL_DNG_SET_ALN = 'https://donguri.5ch.net/setting/autologin';

  URL_DNG_EXPLOR  = 'https://donguri.5ch.net/focus/exploration';    // �T��
  URL_DNG_MINING  = 'https://donguri.5ch.net/focus/mining';         // �̌@
  URL_DNG_WOODCT  = 'https://donguri.5ch.net/focus/woodcutting';    // �؂���
  URL_DNG_WEAPON  = 'https://donguri.5ch.net/focus/weaponcraft';    // ���퐻��
  URL_DNG_ARMORC  = 'https://donguri.5ch.net/focus/armorcraft';     // �h���
  URL_DNG_RENAME  = 'https://donguri.5ch.net/rename';								// �n���^�[�Ăі��ύX�T�[�r�X
  URL_DNG_RESRRCT = 'https://donguri.5ch.net/resurrect';						// �����T�[�r�X
  URL_DNG_TRNSFR  = 'https://donguri.5ch.net/transfer';							// �h���O���]���T�[�r�X
  URL_DNG_CRAFT   = 'https://donguri.5ch.net/craft';								// �H��Z���^�[
  URL_DNG_CRAFTCB = 'https://donguri.5ch.net/craft/cannonball';			// �H��Z���^�[�S�̑�C�̋ʍ쐬
	URL_DNG_CRAFTKY = 'https://donguri.5ch.net/craft/key';						// �H��Z���^�[�S�̃L�[�쐬
  URL_DNG_BAG     = 'https://donguri.5ch.net/bag';									// �A�C�e���o�b�O
  URL_DNG_ADDSLOT = 'https://donguri.5ch.net/addslots';							// �X���b�g�ǉ�
  URL_DNG_UNEQW   = 'https://donguri.5ch.net/unequip/weapon';				// �������̕�����O��
  URL_DNG_UNEQA   = 'https://donguri.5ch.net/unequip/armor';				// �������̖h����O��
  URL_DNG_CHEST   = 'https://donguri.5ch.net/chest';								// ��
  URL_DNG_CHESTOP = 'https://donguri.5ch.net/open';									// �󔠂��J����
  URL_DNG_RECYALL = 'https://donguri.5ch.net/recycleunlocked';			// ���b�N����Ă��Ȃ�����h���S�ĕ�������
  URL_DNG_LOCK    = 'https://donguri.5ch.net/lock/';								// ���b�N
  URL_DNG_UNLOCK  = 'https://donguri.5ch.net/unlock/';							// �A�����b�N
  URL_DNG_EQUIP   = 'https://donguri.5ch.net/equip/';								// ����
  URL_DNG_RECYCLE = 'https://donguri.5ch.net/recycle/';							// ����

  URL_DNG_MDYW_VW = 'https://donguri.5ch.net/modify/weapon/view/';			// ������� �ڍו\��
  URL_DNG_MDYW_DL = 'https://donguri.5ch.net/modify/weapon/dmglow/';		// ������� �_���[�W�ŏ��l
  URL_DNG_MDYW_DH = 'https://donguri.5ch.net/modify/weapon/dmghigh/';		// ������� �_���[�W�ő�l
  URL_DNG_MDYW_SP = 'https://donguri.5ch.net/modify/weapon/speed/';			// ������� �X�s�[�h
  URL_DNG_MDYW_CR = 'https://donguri.5ch.net/modify/weapon/critical/';	// ������� �N���e�B�J��

  URL_DNG_MDYA_VW = 'https://donguri.5ch.net/modify/armor/view/';				// �h����� �ڍו\��
  URL_DNG_MDYA_DL = 'https://donguri.5ch.net/modify/armor/deflow/';			// �h����� �h��ŏ��l
  URL_DNG_MDYA_DH = 'https://donguri.5ch.net/modify/armor/defhigh/';		// �h����� �h��ő�l
  URL_DNG_MDYA_WT = 'https://donguri.5ch.net/modify/armor/weight/';			// �h����� �d��
  URL_DNG_MDYA_CR = 'https://donguri.5ch.net/modify/armor/critical/';		// �h����� �N���e�B�J��

  URL_DNG_CANNON  = 'https://donguri.5ch.net/cannon';								// �ǂ񂮂��C
  URL_DNG_CANNON2 = 'https://donguri.5ch.net/confirm';							// �ǂ񂮂��C�m�F
  URL_DNG_CANNON3 = 'https://donguri.5ch.net/fire';									// �ǂ񂮂��C����
	URL_5CH_ROOT    = 'https://5ch.net/';

  // �C���[�W�C���f�b�N�X

implementation

uses
  GikoSystem, IndyModule, YofUtils, Giko, GikoUtil, MojuUtils;


// �R���X�g���N�^
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

		FHome := TDonguriHome.Create;
  except
    //on e: Exception do begin
    //  MessageBox(0, PChar(e.Message), 'TDonguriSys.Create', MB_OK);
    //end;
  end;
end;

// �f�X�g���N�^
destructor TDonguriSys.Destroy;
begin
  try
    TIndyMdl.ClearHTTP(FHTTP);
    FHTTP.Free;
    FSSL.Free;

    FHome.Free;
  except
  end;

	Inherited;
end;

// �r���h���[�h
function TDonguriSys.GetBuildMode: String;
var
	mode: String;
begin
{$IFDEF DEBUG}
	mode := 'Debug Build ';
{$ENDIF}
{$IFDEF _DEBUG_MODE}
  mode := mode + '�������[�h';
{$ENDIF}
	Result := mode;
end;

// HTTP���X�|���X���N���A
procedure TDonguriSys.ClearResponse;
begin
	FErroeMessage := '';
	FResponseText := '';
	FResponseCode := 0;
end;

// HTTP-GET����
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

// HTTP-POST����
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

// ���_�C���N�g�L���HTTP-GET
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
        IndyMdl.DelCookie('acorn', URL_5CH_ROOT);	// Cookie�ۑ����ɏ����Ă���Ă���Ƃ͎v������
        IndyMdl.DelCookie('fp',    URL_5CH_ROOT);	// �󂯎���ĂȂ����ǃN���A�v���H�H�H
      end;

      if red = False then begin
			  response := res;
      	Break;
      end;

      if res[1] = '/' then
        res := URL_DNG_BASE + res;

      if res = url then begin
        FErroeMessage := '�ُ�ȃ��_�C���N�g�����o���܂����B' + #10 + '�ǂ񂮂�V�X�e����ʂ���x����Ɖ������邩������܂���B';
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

// ���_�C���N�g�L���HTTP-POST�i���_�C���N�g��GET�j
function TDonguriSys.HttpPostCall(urlStart, referer: String; postParam: TStringList; var response: String): Boolean;
var
  url: String;
  ref: String;
  res: String;
  red: Boolean;
  gzip: Boolean;
  ok: Boolean;
  first: Boolean;
begin
	Result := False;
  response := '';

  if FProcessing then
    Exit;

	try
	  ClearResponse;

    ok := False;
  	url := urlStart;
    ref := referer;
    first := True;

  	while True do begin
    	res := '';
      red := False;
      gzip := (url = URL_DNG_ROOT);

    	if first then begin
	      ok := HttpPost(url, ref, postParam, gzip, res, red);
        first := False;
      end else
				ok := HttpGet(url, ref, gzip, res, red);

      if ok and (url = URL_DNG_LOGOUT) then begin
        IndyMdl.DelCookie('acorn', URL_5CH_ROOT);	// Cookie�ۑ����ɏ����Ă���Ă���Ƃ͎v������
        //IndyMdl.DelCookie('fp',    URL_5CH_ROOT);	// �󂯎���ĂȂ����ǃN���A�v���H�H�H
      end;

      if red = False then begin
			  response := res;
      	Break;
      end;

      if res[1] = '/' then
        res := URL_DNG_BASE + res;

      if res = url then begin
        FErroeMessage := '�ُ�ȃ��_�C���N�g�����o���܂����B' + #10 + '�ǂ񂮂�V�X�e����ʂ���x����Ɖ������邩������܂���B';
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


function TDonguriSys.Download(url, referer: String; var response: TMemoryStream): Boolean;
var
  ok: Boolean;
	uri: TIdURI;
  url2: String;
  sendCookies: String;
{$IFDEF _DEBUG_MODE}
  dbgpath: String;
  dbgcnt: Integer;
{$ENDIF}
begin
	Result := False;

  if FProcessing then
    Exit;

  FProcessing := True;

  ClearResponse;

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
		FHTTP.Request.AcceptEncoding := '';
  	if sendCookies <> '' then
	    FHTTP.Request.CustomHeaders.Add('Cookie: ' + sendCookies);

    ok := False;

    IndyMdl.StartAntiFreeze(100);
    Screen.Cursor := crHourGlass;
    try
      FHTTP.Get(url2, response);
      ok := True;
    except
      on e: Exception do begin
				FErroeMessage := e.Message;
      end;
    end;
    FResponseText := FHTTP.ResponseText;
		FResponseCode := FHTTP.ResponseCode;

    Screen.Cursor := crDefault;
    IndyMdl.EndAntiFreeze;
		IndyMdl.SaveCookies(FHTTP);

    if ok then begin
{$IFDEF _DEBUG_MODE}
      if response.Size > 0 then begin
        for dbgcnt := 0 to 99 do begin
					dbgpath := 'D:\Log\Donguri\' + FormatDateTime('yyyymmdd_hhnnss_zzz', Now) + Format('_%.2d.dat', [dbgcnt]);
          if not FileExists(dbgpath) then
          	Break;
        end;
        try
          response.SaveToFile(dbgpath);
        except
        end;
      end;
      response.Position := 0;
{$ENDIF}
    end;

    Result := ok;

  finally
	  FProcessing := False;
  end;
end;


function IsRootPage(html: String): Boolean;
begin

  if Pos('<h1>�ǂ񂮂�V�X�e��</h1><p>���Ȃ��͌x�����ł��B</p>', html) > 0 then	// �����O�C��
    Result := True
	else if (Pos('<div>�n���^�[[ID:',   html) > 0) or
					(Pos('<div>�n���^�[��[ID:', html) > 0) or
					(Pos('<div>�n���^�[��[ID:', html) > 0) or
					(Pos('<div>�x����[ID:',     html) > 0) or
					(Pos('<div>�x������[ID:',   html) > 0) or
					(Pos('<div>�x������[ID:',   html) > 0) then
    Result := True
  else
    Result := False;
end;

// ���[�g�i���C���y�[�W�j
function TDonguriSys.Root(var response: String): Boolean;
var
	redirect: Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGet(URL_DNG_ROOT, '', True, response, redirect);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �ĔF��
function TDonguriSys.Auth(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_AUTH, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ���O�C��
function TDonguriSys.Login(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_LOGIN, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ���[�����O�C��
function TDonguriSys.MailLogin(mail, pwd: String; var response: String): Boolean;
var
  param: TStringList;
begin
	Result := False;
	param := TStringList.Create;

  try
	  ClearResponse;

    param.Add('email=' + mail);
    param.Add('pass=' + pwd);

    Result := HttpPostCall(URL_DNG_LOGIN, URL_DNG_ROOT, param, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
	param.Free;
end;

// ���O�A�E�g
function TDonguriSys.Logout(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_LOGOUT, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �A�J�E���g�o�^�g�b�v�y�[�W
function TDonguriSys.RegisterPage(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_REGIST, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �A�J�E���g�o�^���{
function TDonguriSys.RegisterSubmit(mail, pwd: String; var response: String): Boolean;
var
  param: TStringList;
begin
	Result := False;
	param := TStringList.Create;

  try
	  ClearResponse;

    param.Add('email=' + mail);
    param.Add('password=' + pwd);

    Result := HttpPostCall(URL_DNG_REGIST, URL_DNG_REGIST, param, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
	param.Free;
end;

function TDonguriSys.RegisterVerify(link: String; var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(link, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �������O�C���؂�ւ�
function TDonguriSys.ToggleAutoLogin(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_SET_ALN, response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �T��
function TDonguriSys.Exploration(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_EXPLOR, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �̌@
function TDonguriSys.Mining(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_MINING, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �؂���
function TDonguriSys.WoodCutting(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_WOODCT, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ���퐻��
function TDonguriSys.WeaponCraft(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_WEAPON, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �h���
function TDonguriSys.ArmorCraft(var response: String): Boolean;
begin
	Result := False;
  response := '';

	try
	  ClearResponse;

  	Result := HttpGetCall(URL_DNG_ARMORC, response);

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �n���^�[�Ăі��ύX�T�[�r�X�y�[�W�擾
function TDonguriSys.RenamePage(var response: String): Boolean;
var
  redirect: Boolean;
begin
	Result := False;
  response := '';

  try
		Result := HttpGet(URL_DNG_RENAME, URL_DNG_ROOT, True, response, redirect);
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �n���^�[�Ăі��ύX�T�[�r�X
function TDonguriSys.Rename(newName: String; var response: String): Boolean;
var
  name: String;
  len: Integer;
	postParam: TStringList;
	redirect: Boolean;
begin
	Result := False;
  response := '';

  try
	  ClearResponse;

  	name := newName;
    if name[1] = '[' then
    	Delete(name, 1, 1);
  	len := Length(name);
    if name[len] = ']' then
    	Delete(name, len, 1);

		postParam := TStringList.Create;
    try
  		postParam.Add('name=' + name);
  		Result := HttpPost(URL_DNG_RENAME, URL_DNG_RENAME, postParam, False, response, redirect);
    finally
	  	postParam.Free;
    end;

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �����T�[�r�X
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

    if MsgBox(handle, resMsg + #10#10 + '���x�����������s���܂����H',
    					'���x������', MB_YESNO or mbFlag) <> IDYES then begin
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

  	if Extract('>���m�点�F', '</p>', form, resMsg) then
    	resMsg := '���m�点�F' + resMsg;

    Result := True;

  except
  end;
end;

// �h���O���]���T�[�r�X�y�[�W�擾
function TDonguriSys.TransferPage(var response: String): Boolean;
var
  redirect: Boolean;
begin
	Result := False;
  response := '';

  try
		Result := HttpGet(URL_DNG_TRNSFR, URL_DNG_ROOT, True, response, redirect);
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �h���O���]���T�[�r�X
function TDonguriSys.Transfer(recipientID, amount: String; var response: String): Boolean;
var
  rid: String;
  len: Integer;
	postParam: TStringList;
	redirect: Boolean;
begin
	Result := False;
  response := '';

  try
	  ClearResponse;

  	rid := recipientID;
    if rid[1] = '[' then
    	Delete(rid, 1, 1);
  	len := Length(rid);
    if rid[len] = ']' then
    	Delete(rid, len, 1);

		postParam := TStringList.Create;
    try
  		postParam.Add('recipientid=' + rid);
  		postParam.Add('transferamt=' + amount);
  		Result := HttpPost(URL_DNG_TRNSFR, URL_DNG_TRNSFR, postParam, False, response, redirect);
    finally
	  	postParam.Free;
    end;

    if Result then
      FHome.Parsing(response);

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �H��Z���^�[�y�[�W�擾
function TDonguriSys.Craft(var response: String): Boolean;
var
  redirect: Boolean;
begin
	Result := False;
  response := '';

  try
		Result := HttpGet(URL_DNG_CRAFT, URL_DNG_ROOT, True, response, redirect);
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �S�̑�C�̋ʍ쐬
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

// �S�̃L�[�쐬
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

// �A�C�e���o�b�O
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
      end else if Pos('<h1>�A�C�e���o�b�O</h1>', response) > 0 then begin
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
	KW_SLOT_S = '<h5>�A�C�e���o�b�O�ɂ�';
  KW_SLOT_E = '�X���b�g������܂��B';
  KW_USEW_S = '<h3>�������Ă��镐��: </h3>';
  KW_USEW_E = '</p>';
  KW_USEA_S = '<h3>�������Ă���h��: </h3>';
  KW_USEA_E = '</p>';
  KW_IBAG_S = '<h3>�A�C�e���o�b�O:</h3>';
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

    // �X���b�g��
		if Extract2(KW_SLOT_S, KW_SLOT_E, html, tmp) then
    	itemBag.Slot := StrToIntDef(tmp, 0);

    // �g�p���̕���
		if Extract2(KW_USEW_S, KW_USEW_E, html, tmp) then begin
    	idx := Pos(KW_TBDY_S, tmp);
      if idx > 0 then
      	Delete(tmp, 1, idx + 6);
      itemBag.UseWeapon.SetItems(tmp);
    end;

    // �g�p���̖h��
		if Extract2(KW_USEA_S, KW_USEA_E, html, tmp) then begin
    	idx := Pos(KW_TBDY_S, tmp);
      if idx > 0 then
      	Delete(tmp, 1, idx + 6);
      itemBag.UseArmor.SetItems(tmp);
    end;

    idx := Pos(KW_IBAG_S, html);
    if idx > 0 then
    	Delete(html, 1, idx + Length(KW_IBAG_S) - 1);

		// ����ꗗ
		if Extract2(KW_TBDY_S, KW_TBDY_E, html, tmp) then begin
    	while True do begin
				if Extract2(KW_TROW_S, KW_TROW_E, tmp, tmp2) = False then
        	Break;
				wp := TDonguriWeapon.Create;
        wp.SetItems(tmp2);
        itemBag.WeaponList.Add(wp);
      end;
  	end;

    // �h��ꗗ
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

// �X���b�g�ǉ�
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

// �������O��
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
			ret := HttpGetCall(URL_DNG_UNEQW, res)		// ����
    else
			ret := HttpGetCall(URL_DNG_UNEQA, res);		// �h��

    if ret and (Pos('<h1>�A�C�e���o�b�O</h1>', res) > 0) then
			Result := ParceBag(res, itemBag);
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// �󔠂��J����
function TDonguriSys.ChestOpen(amount: Integer; var itemBag: TDonguriBag; var response: String): Boolean;
var
  ret: Boolean;
  param: TStringList;
begin
	Result := False;
	itemBag.Clear;
	param := TStringList.Create;

  try
	  ClearResponse;

    case amount of
    10:  param.Add('chestsize=A65');
    100: param.Add('chestsize=B70');
    else FErroeMessage := Format('�󔠂��J�����Ƃ��ł��܂���ł����B%s�p�����[�^�s���F%d', [#10, amount]);
    end;

  	if param.Count > 0 then begin
      ret := HttpPostCall(URL_DNG_CHESTOP, URL_DNG_CHEST, param, response);

      if ret and (Pos('<h1>�A�C�e���o�b�O</h1>', response) > 0) then
        Result := ParceBag(response, itemBag)
    end;
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
	param.Free;
  
end;

// ���b�N����Ă��Ȃ�����h���S�ĕ�������
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

    if ret and (Pos('<h1>�A�C�e���o�b�O</h1>', res) > 0) then
			Result := ParceBag(res, itemBag)
    else
    	FErroeMessage := res;
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ���b�N
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

      if ret and (Pos('<h1>�A�C�e���o�b�O</h1>', res) > 0) then begin
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

// �A�����b�N
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

      if ret and (Pos('<h1>�A�C�e���o�b�O</h1>', res) > 0) then begin
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

// ����
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

    if ret and (Pos('<h1>�A�C�e���o�b�O</h1>', res) > 0) then
			Result := ParceBag(res, itemBag)
    else
    	FErroeMessage := res;
  except
    on e: Exception do begin
      FErroeMessage := e.Message;
    end;
  end;
end;

// ����
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

      if ret and (Pos('<h1>�A�C�e���o�b�O</h1>', res) > 0) then begin
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


// ���틭���r���[
function TDonguriSys.ModWeaponView(itemNo: String; var response: String): Boolean;
begin
  try
    ClearResponse;

    Result := HttpGetCall(URL_DNG_MDYW_VW+ itemNo, response);

  except
    on e: Exception do begin
			Result := False;
      FErroeMessage := e.Message;
    end;
  end;
end;

function TDonguriSys.ModWeapon(modType: TModifyWeapon; itemNo: String; var response: String): Boolean;
var
	url: String;
  param: TStringList;
begin
  param := TStringList.Create;
  try
    try
      ClearResponse;

      case modType of
        mdwDmgMin: url := URL_DNG_MDYW_DL + itemNo;
        mdwDmgMax: url := URL_DNG_MDYW_DH + itemNo;
        mdwSpeed:  url := URL_DNG_MDYW_SP + itemNo;
        mdwCrit:   url := URL_DNG_MDYW_CR + itemNo;
        else begin
          Result := False;
          FErroeMessage := '�V�X�e���G���[�F���틭�����';
          Exit;
        end;
      end;

      Result := HttpPostCall(url, URL_DNG_MDYW_VW + itemNo, param, response);

    except
      on e: Exception do begin
        Result := False;
        FErroeMessage := e.Message;
      end;
    end;
  finally
  	param.Free;
  end;
end;



// �h����r���[
function TDonguriSys.ModArmorView(itemNo: String; var response: String): Boolean;
begin
  try
    ClearResponse;

    Result := HttpGetCall(URL_DNG_MDYA_VW + itemNo, response);

  except
    on e: Exception do begin
			Result := False;
      FErroeMessage := e.Message;
    end;
  end;
end;

function TDonguriSys.ModArmor(modType: TModifyArmor; itemNo: String; var response: String): Boolean;
var
	url: String;
  param: TStringList;
begin
  param := TStringList.Create;
  try
    try
      ClearResponse;

      case modType of
        mdaDefMin: url := URL_DNG_MDYA_DL + itemNo;
        mdaDefMax: url := URL_DNG_MDYA_DH + itemNo;
        mdaWeight: url := URL_DNG_MDYA_WT + itemNo;
        mdaCrit:   url := URL_DNG_MDYA_CR + itemNo;
        else begin
          Result := False;
          FErroeMessage := '�V�X�e���G���[�F�h������';
          Exit;
        end;
      end;

      Result := HttpPostCall(url, URL_DNG_MDYA_VW + itemNo, param, response);

    except
      on e: Exception do begin
        Result := False;
        FErroeMessage := e.Message;
      end;
    end;
  finally
  	param.Free;
  end;
end;


//------------------------------------------------------------------------------
// �ǂ񂮂��C
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
				ShowCannonError('�ǂ񂮂��C���g�p�ł��܂���B', True)
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
		    ShowCannonError('�ǂ񂮂��C���g�p�ł��܂���B', True)
      else
		    ShowCannonError(resNo + resMsg);
    	Exit;
    end;

    //debug := #39 + urlRes + DBG_SEP + date + DBG_SEP + resMsg + DBG_SEP;

    if Pos('������m����99%�ł�', resMsg) > 0 then
	  	mbType := MB_YESNO or MB_ICONQUESTION
    else
	  	mbType := MB_YESNO or MB_ICONWARNING;

    if ShowCannonMessage(resNo + resMsg + #10 + '�ǂ񂮂��C�������܂����H',
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
        if Pos('�ǂ񂮂��C���������܂���', res) > 0 then
          mbType := MB_OK or MB_ICONINFORMATION
        else if Pos('�ǂ񂮂��C����˂��܂���', res) > 0 then
          mbType := MB_OK or MB_ICONERROR
        else
          mbType := MB_OK or MB_ICONWARNING;
				ShowCannonMessage(resNo + res, mbType);
      end else
				ShowCannonMessage(resNo + '�ǂ񂮂��C�𔭎˂��܂��������ʕs���ł��B' + #10#10 + res,
         												MB_OK or MB_ICONWARNING);
    end else
	    ShowCannonError(resNo + '�ǂ񂮂��C�̔��˂Ɏ��s���܂����B', True);

    Result := ok;

  except
    on e: Exception do begin
      FErroeMessage := e.Message;
	    ShowCannonError('�ǂ񂮂��C�̔��˂ŃG���[���������܂����B', True);
    end;
  end;

end;

// form�^�O��action�����������URL�ł��邩���m�F
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

// /cannon�̃��X�|���X�`�F�b�N
function TDonguriSys.CheckCannon(html: String; var resMsg: String): Boolean;
begin
	//Result := False;

  //if Pos('<h1>�ǂ񂮂��C</h1>', html) < 1 then
  //	Exit;

	Result := CheckFormAction(html, URL_DNG_CANNON2);		// ����URL�m�F
end;

// /confirm�̃��X�|���X�`�F�b�N
function TDonguriSys.CheckConfirm(html: String; var resMsg: String): Boolean;
var
	idx1: Integer;
	idx2: Integer;
	idx3: Integer;
begin
	Result := False;
  resMsg := '';

  if Pos('<html', html) < 1 then begin
	  resMsg := TrimTag(html);		// �v���[���e�L�X�g
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
  resMsg := TrimTag(Copy(html, idx2, idx3 - idx2));	// ���b�Z�[�W���炵�����̂����o��

	Result := CheckFormAction(html, URL_DNG_CANNON3);		// ����URL�m�F
end;

// �ǂ񂮂��C�p�G���[���b�Z�[�W�\��
procedure TDonguriSys.ShowCannonError(msg: String; httperr: Boolean = False);
begin
	if httperr then
  	msg := msg + #10 +
					 FErroeMessage + #10 +
        	 'HTTP ' + IntToStr(FResponseCode) + #10 +
           FResponseText;

  ShowCannonMessage(msg, MB_OK or MB_ICONERROR);
end;

// �ǂ񂮂��C�p���b�Z�[�W�\��
// ���ǂ񂮂��C�̓��C����ʂ���̑����O��Ƃ��A���b�Z�[�W�{�b�N�X�����C����ʂ�e�Ƃ���
function TDonguriSys.ShowCannonMessage(msg: String; mbType: Cardinal): Integer;
begin
	Result := MsgBox(GikoForm.Handle, PChar(msg), '�ǂ񂮂��C', mbType);
end;



//------------------------------------------------------------------------------
// �ǂ񂮂�z�[��
//------------------------------------------------------------------------------

constructor TDonguriHome.Create;
begin
	Inherited;

	Clear;
end;

procedure TDonguriHome.Clear;
begin
	Hunter     := False;
  UserMode   := '';
  UserID     := '';
  UserName   := '';
  Level      := '';
  RateExpr   := 0;
  Period     := '';
  RatePrgr   := 0;
  Explor     := 0;
  RateExplr  := 0;
  SelExplr   := False;
  Mining     := 0;
  RateMnng   := 0;
  SelMnng    := False;
  Woodct     := 0;
  RateWdct   := 0;
  SelWdct    := False;
  Weapon     := 0;
  RateWpn    := 0;
  SelWpn     := False;
  Armorc     := 0;
  RateArmr   := 0;
  SelArmr    := False;
  SttCannon  := '';
  SttFight   := '';
  Acorn      := '';
  AcornTitle := '';
  Wood       := 0;
  Iron       := 0;
  IronKey    := 0;
  Marimo     := 0;
  WoodCB     := 0;
  IronCB     := 0;
  HP         := 0;
  AutoLogin  := atlUnknown;
  Error      := '';
end;

function TDonguriHome.Parsing(html: String): Boolean;
const
  TAG_ANM_S = '�ǂ񂮂��n</h1>';
  TAG_ANM_E = '</div>';
	TAG_HID_S = '<div>�n���^�[[ID:';
	TAG_HID1S = '<div>�n���^�[��[ID:';
	TAG_HID2S = '<div>�n���^�[��[ID:';
  TAG_HID_E = ']</div>';
	TAG_GID_S = '<div>�x����[ID:';
	TAG_GID1S = '<div>�x������[ID:';
	TAG_GID2S = '<div>�x������[ID:';
  TAG_GID_E = ']</div>';
	TAG_DNG_S = '<div>�ǂ񂮂�c��:';
	TAG_DN2_S = '<div>��q�c��:';
  TAG_DNG_E = '</div>';
  TAG_NWD_S = '<div>�؍ނ̐�:';
  TAG_NWD_E = '</div>';
  TAG_NIR_S = '<div>�S�̐�:';
  TAG_NIR_E = '</div>';
  TAG_IRK_S = '<div>�S�̃L�[:';
  TAG_IRK_E = '</div>';
  TAG_MRM_S = '<div>�}����:';
  TAG_MRM_E = '</div>';
  TAG_WCB_S = '<div>�ؐ��̑�C�̋�:';
  TAG_WCB_E = '</div>';
  TAG_ICB_S = '<div>�S�̑�C�̋�:';
  TAG_ICB_E = '</div>';
  TAG_HP__S = '<div>HP:';
  TAG_HP__E = '</div>';
  TAG_CNN_S = '<label>��C�̓��v</label><div>';
  TAG_CNN_E = '</div>';
  TAG_DMG_S = '| D:';
  TAG_FGT_S = '<label>�嗐���̓��v</label><div>';
  TAG_FGT_E = '</div>';
  TAG_PEX_S = '<div>�o���l:';
  TAG_PEX_E = '</div>';
  TAG_LVL_S = '���x��:';
  TAG_LVL_E = '<div';
  TAG_PTM_S = '<div>�o�ߎ���:';
  TAG_PTM_E = '</div>';
  TAG_PRD_S = '��';
  TAG_PRD_E = '��';
  TAG_EXP_S = '<div>��<a style="text-decoration:underline;" href="/focus/exploration">�T��:';
  TAG_EX2_S = '<div>��<a style="text-decoration:underline;" href="/focus/exploration">�T��:';
  TAG_EXP_E = '</a>';
  TAG_MNG_S = '<div>��<a style="text-decoration:underline;" href="/focus/mining">�̌@:';
  TAG_MN2_S = '<div>��<a style="text-decoration:underline;" href="/focus/mining">�̌@:';
  TAG_MNG_E = '</a>';
  TAG_FLL_S = '<div>��<a style="text-decoration:underline;" href="/focus/woodcutting">�؂���:';
  TAG_FL2_S = '<div>��<a style="text-decoration:underline;" href="/focus/woodcutting">�؂���:';
  TAG_FLL_E = '</a>';
  TAG_ARM_S = '<div>��<a style="text-decoration:underline;" href="/focus/weaponcraft">���퐻��:';
  TAG_AR2_S = '<div>��<a style="text-decoration:underline;" href="/focus/weaponcraft">���퐻��:';
  TAG_ARM_E = '</a>';
  TAG_PRT_S = '<div>��<a style="text-decoration:underline;" href="/focus/armorcraft">�h���:';
  TAG_PR2_S = '<div>��<a style="text-decoration:underline;" href="/focus/armorcraft">�h���:';
  TAG_PRT_E = '</a>';
  TAG_PRG_S = '<div class="progress-bar">';
  TAG_PRG_E = '</div>';
  TAG_ALN_H = '<div>�������O�C���FON<br>';
  TAG_ALN_S = '<a href="https://donguri.5ch.net/setting/autologin">�������O�C���F';
  TAG_ALN_E = '</a>';

  MODE_NAME: array[0..6] of String = (
    '�s��',
    '�n���^�[',
    '�n���^�[��',
    '�n���^�[��',
    '�x����',
    '�x������',
    '�x������'
  );
  COL_NAME_ACRN : String = '�@�ǂ񂮂�c��';
  COL_NAME_SEED : String = '�@��q�c��';

var
  tmp: String;
  tm2: String;
  mode: Integer;
  err: Boolean;
  auto: Boolean;
begin
	Result := False;

	try
		if not IsRootPage(html) then
      Exit;

  	Clear;
    Hunter := False;

		if DonguriSystem.Extract(TAG_ANM_S, TAG_ANM_E, html, tmp) then
      UserName := Trim(TrimTag(tmp));

  	tmp := '';
    mode := 0;
    if      DonguriSystem.Extract(TAG_HID_S, TAG_HID_E, html, tmp) then mode := 1
    else if DonguriSystem.Extract(TAG_HID1S, TAG_HID_E, html, tmp) then mode := 2
    else if DonguriSystem.Extract(TAG_HID2S, TAG_HID_E, html, tmp) then mode := 3
    else if DonguriSystem.Extract(TAG_GID_S, TAG_GID_E, html, tmp) then mode := 4
    else if DonguriSystem.Extract(TAG_GID1S, TAG_GID_E, html, tmp) then mode := 5
    else if DonguriSystem.Extract(TAG_GID2S, TAG_GID_E, html, tmp) then mode := 6;

		Hunter := (mode >= 1) and (mode <= 3);
		UserID := Trim(tmp);
		UserMode := MODE_NAME[mode];

    if Extract(TAG_DNG_S, TAG_DNG_E, html, tmp) then begin
      Acorntitle := COL_NAME_ACRN;
      Acorn := Trim(tmp);
    end else if Extract(TAG_DN2_S, TAG_DNG_E, html, tmp) then begin
      Acorntitle := COL_NAME_SEED;
      Acorn := Trim(tmp);
    end;

    if Extract(TAG_NWD_S, TAG_NWD_E, html, tmp) then
      Wood := StrToIntDef(Trim(tmp), 0);

    if Extract(TAG_NIR_S, TAG_NIR_E, html, tmp) then
      Iron := StrToIntDef(Trim(tmp), 0);

    if Extract(TAG_IRK_S, TAG_IRK_E, html, tmp) then
      IronKey := StrToIntDef(Trim(tmp), 0);

    if Extract(TAG_MRM_S, TAG_MRM_E, html, tmp) then
      Marimo := StrToIntDef(Trim(tmp), 0);

    if Extract(TAG_WCB_S, TAG_WCB_E, html, tmp) then
      WoodCB := StrToIntDef(Trim(tmp), 0);

    if Extract(TAG_ICB_S, TAG_ICB_E, html, tmp) then
      IronCB := StrToIntDef(Trim(tmp), 0);

    if Extract(TAG_HP__S, TAG_HP__E, html, tmp) then
      HP := StrToIntDef(Trim(tmp), 0);

    if Extract(TAG_CNN_S, TAG_CNN_E, html, tmp) then
		  SttCannon := Trim(ReplaceString(tmp, '|', '�@'));

    if Extract(TAG_FGT_S, TAG_FGT_E, html, tmp) then
		  SttFight := Trim(ReplaceString(tmp, '|', '�@'));

    // �o���l
    if Extract2(TAG_PEX_S, TAG_PEX_E, html, tmp) then begin
    	tmp := tmp + TAG_PEX_E;
      if Extract(TAG_LVL_S, TAG_LVL_E, tmp, tm2) then
        Level := Trim(tm2);
      RateExpr := GetProgressPosition(tmp, TAG_PRG_S, TAG_PRG_E);
    end;
  	// �o�ߎ���
    if Extract2(TAG_PTM_S, TAG_PTM_E, html, tmp) then begin
    	tmp := tmp + TAG_PTM_E;
      if Extract(TAG_PRD_S, TAG_PRD_E, tmp, tm2) then
	      Period := '��' + tm2 + '��';
      RatePrgr := GetProgressPosition(tmp, TAG_PRG_S, TAG_PRG_E);
    end;

    // �T��
		SetSkillInfo(html, TAG_EXP_S, TAG_EX2_S, TAG_EXP_E, TAG_PRG_S, TAG_PRG_E, SelExplr, Explor, RateExplr);
  	// �̌@
		SetSkillInfo(html, TAG_MNG_S, TAG_MN2_S, TAG_MNG_E, TAG_PRG_S, TAG_PRG_E, SelMnng,  Mining, RateMnng);
  	// �؂���
		SetSkillInfo(html, TAG_FLL_S, TAG_FL2_S, TAG_FLL_E, TAG_PRG_S, TAG_PRG_E, SelWdct,  Woodct, RateWdct);
  	// ���퐻��
		SetSkillInfo(html, TAG_ARM_S, TAG_AR2_S, TAG_ARM_E, TAG_PRG_S, TAG_PRG_E, SelWpn,   Weapon, RateWpn);
  	// �h���
		SetSkillInfo(html, TAG_PRT_S, TAG_PR2_S, TAG_PRT_E, TAG_PRG_S, TAG_PRG_E, SelArmr,  Armorc, RateArmr);

    // �������O�C��
    auto := False;
    err := False;
  	if Hunter then
      auto := (Pos(TAG_ALN_H, html) > 0)
    else if DonguriSystem.Extract(TAG_ALN_S, TAG_ALN_E, html, tmp) then begin
      if (tmp = 'ON') then
	      auto := True
      else if (tmp <> 'OFF') then
        err := True;
    end else
      err := True;

  	if err then
    	AutoLogin := atlUnknown
    else if auto then
    	AutoLogin := atlOn
    else
    	AutoLogin := atlOff;

    //Error := (mode = 0) or (UserID = '') or (UserName = '') or (Level = '');

    Result := True;
  except
    on e: Exception do
	    Error := e.Message;
  end;
end;


function TDonguriHome.GetProgressPosition(var html: String; const kws: String; const kwe: String): Integer;
var
	tmp: String;
  idx: Integer;
begin
	Result := 0;
  if Extract2(kws, kwe, html, tmp) then begin 	// �폜����I
  	tmp := TrimTag(tmp);
    idx := Pos('%', tmp);
    if idx > 0 then
      SetLength(tmp, idx - 1);
	  Result := StrToInt(tmp);
  end;
end;

procedure TDonguriHome.SetSkillInfo(var html: String;
												const kws: String; const kw2: String; const kwe: String;
												const pbs: String; const pbe: String;
                        var Sel: Boolean; var Value: Integer; var Rate: Integer);
var
	tmp: String;
begin
	Value := 0;
  Rate  := 0;
  Sel   := False;
	if Extract2(kws, kwe, html, tmp) = False then
		Sel := Extract2(kw2, kwe, html, tmp);

  if tmp <> '' then begin
    Value := StrToIntDef(Trim(tmp), 0);
    Rate := GetProgressPosition(html, pbs, pbe);
  end;
end;


//------------------------------------------------------------------------------
// �A�C�e���o�b�O
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
	idx := Pos('�}', tmp);
  if idx > 0 then
  	SetLength(tmp, idx - 1);
  Marimo := Trim(tmp);
end;

procedure TDonguriItem.SetState(html: String);
var
	tmp: String;
begin
  Used := (Pos('[�O��]', html) > 0);	// �o�b�O���A�C�e�����X�g�̏ꍇ�͎g�p�����ǂ����̏�񂪂Ȃ�
  if Used = False then
    Lock := (Pos('[����]', html) > 0);	// �g�p�����X�g�ɂ̓��b�N�����ǂ����̏�񂪂Ȃ�
  if Extract2('<a href="https://donguri.5ch.net/equip/', '">', html, tmp) then
		ItemNo := tmp;	// �g�p�����X�g�ɂ͂��ꂪ�Ȃ�
end;

function TDonguriItem.GetRangeValue(html: String): String;
var
	tmp: String;
  idx: Integer;
begin
	tmp := Trim(TrimTag(html));
  idx := Pos('~', tmp);
  if idx > 0 then
  	Result := Copy(tmp, 1, idx - 1) + '�`' + Copy(tmp, idx + 1, Length(tmp) - idx)
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

function TDonguriItem.TrimBracket(src: String): String;
var
	dst: String;
  len: Integer;
begin
	dst := Trim(src);
  len := Length(dst);
  if (len > 0) and (dst[1] = '[') then begin
    Delete(dst, 1, 1);
    Dec(len);
  end;
  if (len > 0) and (dst[len] = ']') then
    SetLength(dst, len - 1);
	Result := dst;
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
      5: Modify := TrimBracket(TrimTag(tmp1));
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
      5: Modify := TrimBracket(TrimTag(tmp1));
      6: SetMarimo(tmp1);
      7: SetState(tmp1);
    end;
  end;
end;


// �R���X�g���N�^
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

// �f�X�g���N�^
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
// ���ʊ֐�
//------------------------------------------------------------------------------

// �폜�Ȃ��L�[���[�h���o
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

// �폜����L�[���[�h���o
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

	Delete(text, 1, idx2 + Length(kw2) - 1);		// ���o�L�[���[�h�܂ō폜

	Result := True;
end;

// �^�O�폜
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
