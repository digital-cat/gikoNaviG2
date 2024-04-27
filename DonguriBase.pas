unit DonguriBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, StrUtils, ComCtrls, Buttons;

type
  TDonguriForm = class(TForm)
    TimerInit: TTimer;
    InfoGrid: TStringGrid;
    PanelBottom: TPanel;
    RenameButton: TButton;
    TransferButton: TButton;
    CraftButton: TButton;
    PanelTop: TPanel;
    PageControl: TPageControl;
    TabSheetHome: TTabSheet;
    TabSheetHunter: TTabSheet;
    SpeedButtonTopMost: TSpeedButton;
    PanelHome: TPanel;
    MsgLabel: TLabel;
    PanelHunterTop: TPanel;
    PageControlHunter: TPageControl;
    TabSheetRename: TTabSheet;
    TabSheetCraft: TTabSheet;
    AuthSpButton: TSpeedButton;
    LoginSpButton: TSpeedButton;
    LogoutSpButton: TSpeedButton;
    ExplorSpButton: TSpeedButton;
    MiningSpButton: TSpeedButton;
    WoodctSpButton: TSpeedButton;
    WeaponSpButton: TSpeedButton;
    ArmorcSpButton: TSpeedButton;
    ResurrectSpButton: TSpeedButton;
    ChestSpButton: TSpeedButton;
    BagSpButton: TSpeedButton;
    TabSheetSetting: TTabSheet;
    TabSheetChest: TTabSheet;
    PanelHomeTop: TPanel;
    Label1: TLabel;
    LabelUserType: TLabel;
    Label2: TLabel;
    EditName: TEdit;
    LabelID: TLabel;
    EditID: TEdit;
    Label3: TLabel;
    LabelPeriod: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabelD: TLabel;
    LabelK: TLabel;
    LabelLevel: TLabel;
    RootSpButton: TSpeedButton;
    procedure TimerInitTimer(Sender: TObject);
    procedure RenameButtonClick(Sender: TObject);
    procedure TransferButtonClick(Sender: TObject);
    procedure CraftButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonTopMostClick(Sender: TObject);
    procedure AuthSpButtonClick(Sender: TObject);
    procedure LoginSpButtonClick(Sender: TObject);
    procedure LogoutSpButtonClick(Sender: TObject);
    procedure ExplorSpButtonClick(Sender: TObject);
    procedure MiningSpButtonClick(Sender: TObject);
    procedure WoodctSpButtonClick(Sender: TObject);
    procedure WeaponSpButtonClick(Sender: TObject);
    procedure ArmorcSpButtonClick(Sender: TObject);
    procedure ResurrectSpButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure RootSpButtonClick(Sender: TObject);
  private
    { Private declarations }
    FHunter: Boolean;

    procedure SetMode;
    procedure ClearInfoValue;
    procedure ShowRoot;
    function Parsing(html: String): Boolean;
    function Extract(html, kws, kwe: String; var dest: String): Boolean;
    procedure ShowHttpError;
    function MsgBox(const hWnd: HWND; const Text, Caption: string; Flags: Longint = MB_OK): Integer;
  public
    { Public declarations }
  end;

var
  DonguriForm: TDonguriForm;

implementation

uses
	GikoSystem, IndyModule, DmSession5ch, GikoDataModule, GikoUtil;

type
  ColIndex = (
    idxDonguri   = 0,
    idxNumWood   = 1,
    idxNumIron   = 2,
    idxIronKey   = 3,
    idxWdCnBall  = 4,
    idxIrCnBall  = 5,
    idxMarimo    = 6,
    idxExplrtn   = 7,
    idxMining    = 8,
    idxFelling   = 9,
    idxArmsWork  = 10,
    idxProtector = 11,
    idxRowCount  = 12);

const
  COL_NAME: array [0..11] of string  = (
    '　種子残高',
  	'　木材の数',
    '　鉄の数',
    '　鉄のキー',
    '　木製の大砲の玉',
    '　鉄の大砲の玉',
    '　マリモ',
    '　探検',
    '　採掘',
    '　木こり',
    '　武器製作',
    '　防具製作'
    );
	NAME_DNG: array [0..1] of string = (
    '　種子残高',
    '　どんぐり残高'
	  );
  NAME_ID: array [0..1] of string = (
    '警備員ID：',
    'ハンターID：'
	  );

{$R *.dfm}

procedure TDonguriForm.FormCreate(Sender: TObject);
var
	i: Integer;
begin
	FHunter := False;

	PageControl.ActivePageIndex := 0;
  PageControlHunter.ActivePageIndex := 0;

  InfoGrid.RowCount := Integer(idxRowCount);
  InfoGrid.ColWidths[1] := 150;
	for i := 0 to Integer(idxRowCount) - 1 do
	  InfoGrid.Cells[0, i] := COL_NAME[i];

	SetMode;

	Left   := GikoSys.Setting.DonguriLeft;
	Top    := GikoSys.Setting.DonguriTop;
  Width  := GikoSys.Setting.DonguriWidth;
	Height := GikoSys.Setting.DonguriHeight;

	TimerInit.Enabled := True;
end;

procedure TDonguriForm.TimerInitTimer(Sender: TObject);
begin
	TimerInit.Enabled := False;
	if GikoSys.Setting.DonguriStay then begin
  	SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
    SpeedButtonTopMost.Down := True;
  end;
  ShowRoot;
end;

procedure TDonguriForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
  DonguriForm := nil;
end;

procedure TDonguriForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
	try
  	if WindowState = wsMinimized then
    	WindowState := wsNormal;
    
    GikoSys.Setting.DonguriLeft   := Left;
    GikoSys.Setting.DonguriTop    := Top;
    GikoSys.Setting.DonguriWidth  := Width;
    GikoSys.Setting.DonguriHeight := Height;
  Except
  end;
end;

procedure TDonguriForm.FormResize(Sender: TObject);
begin
	try
    if WindowState = wsNormal then begin
      GikoSys.Setting.DonguriLeft   := Left;
      GikoSys.Setting.DonguriTop    := Top;
      GikoSys.Setting.DonguriWidth  := Width;
      GikoSys.Setting.DonguriHeight := Height;
    end;
  except
  end;
end;

procedure TDonguriForm.SetMode;
var
	idx: Integer;
begin
	if FHunter then
		idx := 1
  else
		idx := 0;

	LabelID.Caption := NAME_ID[idx];
  InfoGrid.Cells[0, Integer(idxDonguri)] := NAME_DNG[idx];

	PanelHunterTop.Enabled := FHunter;
  PageControlHunter.Enabled := FHunter;
end;

procedure TDonguriForm.SpeedButtonTopMostClick(Sender: TObject);
begin
	if GikoSys.Setting.DonguriStay then begin
  	SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
    SpeedButtonTopMost.Down := False;
    GikoSys.Setting.DonguriStay := False;
  end else begin
  	SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
    SpeedButtonTopMost.Down := True;
    GikoSys.Setting.DonguriStay := True;
  end;
end;

procedure TDonguriForm.ClearInfoValue;
var
	i: Integer;
begin
	LabelPeriod.Caption := '';
	LabelUserType.Caption := ' ';
	EditName.Text := '';
	EditID.Text := '';
	LabelLevel.Caption := '';
	LabelK.Caption := '';
	LabelD.Caption := '';

	for i := 0 to Integer(idxRowCount) - 1 do
	  InfoGrid.Cells[1, i] := '';
end;

procedure TDonguriForm.ShowRoot;
var
  res: String;
begin
  if GikoSys.DonguriSys.Root(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

function TDonguriForm.Parsing(html: String): Boolean;
const
  TAG_USR_S = '<p>あなたは';
  TAG_USR_E = 'です。</p>';
  TAG_ANM_S = '<span>呼び名:';
  TAG_ANM_E = '<br>';
	TAG_HID_S = '<span>ハンターID:';
  TAG_HID_E = '<br>';
	TAG_GID_S = '<span>警備員ID:';
  TAG_GID_E = '<br>';
	TAG_DNG_S = '<span>どんぐり残高:';
	TAG_DN2_S = '<span>種子残高:';
  TAG_DNG_E = '</span>';
  TAG_NWD_S = '<span>木材の数:';
  TAG_NWD_E = '<br>';
  TAG_NIR_S = '鉄の数:';
  TAG_NIR_E = '<br>';
  TAG_IRK_S = '<br>鉄のキー:';
  TAG_IRK_E = '<br>';
  TAG_WCB_S = '<br>木製の大砲の玉:';
  TAG_WCB_E = '<br>';
  TAG_ICB_S = '<br>鉄の大砲の玉:';
  TAG_ICB_E = '<br>';
  TAG_MRM_S = '<br>マリモ:';
  TAG_MRM_E = '</span>';
  TAG_LVL_S = '<h4>レベル:';
  TAG_LVL_E = '<br>';
  TAG_NKL_S = '<br>K:';
  TAG_NKL_E = '|';
  TAG_NDM_S = '| D:';
  TAG_NDM_E = '</h4>';
  TAG_PRD_S = '<span>第';
  TAG_PRD_E = '期</span>';
  TAG_EXP_S = '<a href="/focus/exploration">探検:';
  TAG_EXP_E = '</a>';
  TAG_MNG_S = '<a href="/focus/mining">採掘:';
  TAG_MNG_E = '</a>';
  TAG_FLL_S = '<a href="/focus/woodcutting">木こり:';
  TAG_FLL_E = '</a>';
  TAG_ARM_S = '<a href="/focus/weaponcraft">武器製作:';
  TAG_ARM_E = '</a>';
  TAG_PRT_S = '<a href="/focus/armorcraft">防具製作:';
  TAG_PRT_E = '</a>';

  TAG_ERROR = '<p>エラー！</p>';
	TAG_ECD_S = '<p>NG&lt;&gt;';
	TAG_ECD_E = '</p>';
	TAG_E_COOKIE_MSG = '<p>ログアウトして、もう一度ログインしてください。</p>';
var
  tmp: String;
  tm2: String;
  ecd: String;
  idx: Integer;
begin
	Result := False;

	try
  	ClearInfoValue;
    FHunter := False;

//    MsgBox(Handle, html, 'debug');

    // HTMLではなくエラーメッセージのテキストのみ
    if Pos('NG<>', html) = 1 then begin
      MsgLabel.Caption := Copy(html, 5, Length(html) - 4);
      Result := True;
      Exit;
    end;

    if Extract(html, TAG_USR_S, TAG_USR_E, tmp) then begin
    	tmp := Trim(tmp);
      LabelUserType.Caption := tmp;
			FHunter := (tmp = 'ハンター');
    end;

  	SetMode;

    if Extract(html, TAG_ANM_S, TAG_ANM_E, tmp) then
      EditName.Text := Trim(tmp);

    if FHunter then begin		// ハンター
    	if Extract(html, TAG_HID_S, TAG_HID_E, tmp) then
  	    EditID.Text := Trim(tmp);
	    if Extract(html, TAG_DNG_S, TAG_DNG_E, tmp) then
	      InfoGrid.Cells[1, Integer(idxDonguri)] := Trim(tmp);
    end else begin					// 警備員
	    if Extract(html, TAG_GID_S, TAG_GID_E, tmp) then
  	    EditID.Text := Trim(tmp);
			if Extract(html, TAG_DN2_S, TAG_DNG_E, tmp) then
      	InfoGrid.Cells[1, Integer(idxDonguri)] := Trim(tmp);
    end;

    if Extract(html, TAG_NWD_S, TAG_NWD_E, tmp) then
      InfoGrid.Cells[1, Integer(idxNumWood)] := Trim(tmp);

    if Extract(html, TAG_NIR_S, TAG_NIR_E, tmp) then
      InfoGrid.Cells[1, Integer(idxNumIron)] := Trim(tmp);

    if Extract(html, TAG_IRK_S, TAG_IRK_E, tmp) then
      InfoGrid.Cells[1, Integer(idxIronKey)] := Trim(tmp);

    if Extract(html, TAG_WCB_S, TAG_WCB_E, tmp) then
      InfoGrid.Cells[1, Integer(idxWdCnBall)] := Trim(tmp);

    if Extract(html, TAG_ICB_S, TAG_ICB_E, tmp) then
      InfoGrid.Cells[1, Integer(idxIrCnBall)] := Trim(tmp);

    if Extract(html, TAG_MRM_S, TAG_MRM_E, tmp) then
      InfoGrid.Cells[1, Integer(idxMarimo)] := Trim(tmp);

    if Extract(html, TAG_LVL_S, TAG_LVL_E, tmp) then begin
      tmp := Trim(tmp);
      idx := Pos('|', tmp);
      if idx < 1 then
	      LabelLevel.Caption := tmp
      else begin
        tm2 := Trim(Copy(tmp, 1, idx - 1));
      	Delete(tmp, 1, idx);
	      tmp := tm2 + ' (' + Trim(tmp) + ')';
	      LabelLevel.Caption := tmp;
      end;
    end;

    if Extract(html, TAG_NKL_S, TAG_NKL_E, tmp) then
      LabelK.Caption := Trim(tmp);

    if Extract(html, TAG_NDM_S, TAG_NDM_E, tmp) then
      LabelD.Caption := Trim(tmp);

    if Extract(html, TAG_PRD_S, TAG_PRD_E, tmp) then
      LabelPeriod.Caption := '第' + tmp + '期';

    if Extract(html, TAG_EXP_S, TAG_EXP_E, tmp) then
      InfoGrid.Cells[1, Integer(idxExplrtn)] := Trim(tmp);

    if Extract(html, TAG_MNG_S, TAG_MNG_E, tmp) then
      InfoGrid.Cells[1, Integer(idxMining)] := Trim(tmp);

    if Extract(html, TAG_FLL_S, TAG_FLL_E, tmp) then
      InfoGrid.Cells[1, Integer(idxFelling)] := Trim(tmp);

    if Extract(html, TAG_ARM_S, TAG_ARM_E, tmp) then
      InfoGrid.Cells[1, Integer(idxArmsWork)] := Trim(tmp);

    if Extract(html, TAG_PRT_S, TAG_PRT_E, tmp) then
      InfoGrid.Cells[1, Integer(idxProtector)] := Trim(tmp);

  	if Pos(TAG_ERROR, html) > 0 then begin
	    if Extract(html, TAG_ECD_S, TAG_ECD_E, tmp) then begin
        ecd := 'NG<>' + tmp;
        if Pos(TAG_E_COOKIE_MSG, html) > 0 then
		      MsgLabel.Caption := ecd + ' ログアウトして、もう一度ログインしてください。'
        else
		      MsgLabel.Caption := 'エラー！ ' + ecd;
      end else
        MsgLabel.Caption := 'エラー！';
    end;

    Result := True;
  except
  end;
end;

function TDonguriForm.Extract(html, kws, kwe: String; var dest: String): Boolean;
var
	idx1: Integer;
	idx2: Integer;
  start: Integer;
begin
	Result := False;
  dest := '';

	idx1 := Pos(kws, html);
  if idx1 < 1 then
  	Exit;

	start := idx1 + Length(kws);
	idx2 := PosEx(kwe, html, start);
  if idx2 < 1 then
  	Exit;

	dest := Copy(html, start, idx2 - start);

  Result := True;
end;


procedure TDonguriForm.ShowHttpError;
var
  msg: String;
begin
  msg := 'エラーが発生しました。' + #10 +
         GikoSys.DonguriSys.ErroeMessage + #10 +
         'HTTP ' + IntToStr(GikoSys.DonguriSys.ResponseCode) + #10 +
         GikoSys.DonguriSys.ResponseText;
  MsgBox(Handle, PChar(msg), 'どんぐりシステム', MB_OK or MB_ICONERROR);
end;


procedure TDonguriForm.RootSpButtonClick(Sender: TObject);
begin
	ShowRoot;
end;

procedure TDonguriForm.AuthSpButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Auth(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.LoginSpButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Login(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR)
    else if Pos('NG<>まずはUPLIFTでログイン', res) = 1 then
      MsgBox(Handle, PChar('UPLIFTでのログインを要求されました。' + #10 +
      						'UPLIFTでログインしない場合は書き込みでどんぐりを埋めてください。'),
								'どんぐりシステム', MB_OK or MB_ICONWARNING);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.LogoutSpButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Logout(res) then begin
	  MsgBox(Handle, 'ログアウトしました。',
    						'どんぐりシステム', MB_OK or MB_ICONINFORMATION);
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.ExplorSpButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Exploration(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.MiningSpButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Mining(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.WoodctSpButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.WoodCutting(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.WeaponSpButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.WeaponCraft(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.ArmorcSpButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.ArmorCraft(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

//=================

procedure TDonguriForm.RenameButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Rename(res) then begin
//  	if Parsing(res) = False then
//      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
//								'どんぐりシステム', MB_OK or MB_ICONERROR);
  	MsgBox(Handle, 'OK', 'debug', MB_OK);
  end else
  	ShowHttpError;
end;

// 復活
procedure TDonguriForm.ResurrectSpButtonClick(Sender: TObject);
var
  res: String;
  cancel: Boolean;
begin
  if GikoSys.DonguriSys.Resurrect(res, cancel, Handle) then begin
		MsgBox(Handle, res, 'どんぐりシステム', MB_OK or MB_ICONINFORMATION);
    ShowRoot;
  end else if cancel = False then begin
  	if res <> '' then
    	MsgBox(Handle, res, 'どんぐりシステム', MB_OK or MB_ICONERROR)
		else
  		ShowHttpError;
  end;
end;

procedure TDonguriForm.TransferButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Transfer(res) then begin
//  	if Parsing(res) = False then
//      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
//								'どんぐりシステム', MB_OK or MB_ICONERROR);
  	MsgBox(Handle, 'OK', 'debug', MB_OK);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.CraftButtonClick(Sender: TObject);
var
  res: String;
begin
  if GikoSys.DonguriSys.Craft(res) then begin
//  	if Parsing(res) = False then
//      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
//								'どんぐりシステム', MB_OK or MB_ICONERROR);
  	MsgBox(Handle, 'OK', 'debug', MB_OK);
  end else
  	ShowHttpError;
end;

function TDonguriForm.MsgBox(const hWnd: HWND; const Text, Caption: string; Flags: Longint = MB_OK): Integer;
begin
  //Result := Windows.MessageBox(hwnd, PChar(Text), PChar(Caption), Flags);
  Result := GikoUtil.MsgBox(hwnd, Text, Caption, Flags);
end;

end.
