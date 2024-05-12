unit DonguriBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, StrUtils, ComCtrls, Buttons, DonguriSystem,
  ImgList;

type
  TDonguriForm = class(TForm)
    TimerInit: TTimer;
    InfoGrid: TStringGrid;
    PanelBottom: TPanel;
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
    ColorRadioGroup: TRadioGroup;
    EditLevel: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    CBAmountComboBox: TComboBox;
    Label7: TLabel;
    CBIronLabel: TLabel;
    ExplorPnlButton: TPanel;
    MiningPnlButton: TPanel;
    WoodctPnlButton: TPanel;
    WeaponPnlButton: TPanel;
    ArmorcPnlButton: TPanel;
    RootPnlButton: TPanel;
    AuthPnlButton: TPanel;
    LoginPnlButton: TPanel;
    LogoutPnlButton: TPanel;
    ResurrectPnlButton: TPanel;
    CraftCBPnlButton: TPanel;
    RenamePnlButton: TPanel;
    TransferPnlButton: TPanel;
    BagPnlButton: TPanel;
    ChestPnlButton: TPanel;
    CannonGroupBox: TGroupBox;
    CannonMenuCheckBox: TCheckBox;
    SystemGroupBox: TGroupBox;
    TaskBarCheckBox: TCheckBox;
    Label8: TLabel;
    Label9: TLabel;
    SlotLabel: TLabel;
    SlotPnlButton: TPanel;
    ListViewWeaponUsing: TListView;
    PageControlItemBag: TPageControl;
    TabSheetUsing: TTabSheet;
    TabSheetWeapon: TTabSheet;
    TabSheetArmor: TTabSheet;
    BagTopPanel: TPanel;
    Label10: TLabel;
    RemWeaponPnlButton: TPanel;
    Label11: TLabel;
    RemArmorPnlButton: TPanel;
    ListViewArmorUsing: TListView;
    WeaponTopPanel: TPanel;
    ListViewWeapon: TListView;
    ArmorTopPanel: TPanel;
    ListViewArmor: TListView;
    WeaponAllCheckBox: TCheckBox;
    ArmorAllCheckBox: TCheckBox;
    BagImageList: TImageList;
    LockAPnlButton: TPanel;
    UnlockAPnlButton: TPanel;
    RecycleAPnlButton: TPanel;
    RecycleWPnlButton: TPanel;
    UnlockWPnlButton: TPanel;
    LockWPnlButton: TPanel;
    RecycleAllPnlButton: TPanel;
    UseAPnlButton: TPanel;
    UseWPnlButton: TPanel;
    procedure TimerInitTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonTopMostClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure ColorRadioGroupClick(Sender: TObject);
    procedure PageControlDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure PageControlHunterDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure CBAmountComboBoxChange(Sender: TObject);
    procedure ExplorPnlButtonClick(Sender: TObject);
    procedure PanelButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MiningPnlButtonClick(Sender: TObject);
    procedure WoodctPnlButtonClick(Sender: TObject);
    procedure WeaponPnlButtonClick(Sender: TObject);
    procedure ArmorcPnlButtonClick(Sender: TObject);
    procedure RootPnlButtonClick(Sender: TObject);
    procedure AuthPnlButtonClick(Sender: TObject);
    procedure LoginPnlButtonClick(Sender: TObject);
    procedure LogoutPnlButtonClick(Sender: TObject);
    procedure ResurrectPnlButtonClick(Sender: TObject);
    procedure CraftCBPnlButtonClick(Sender: TObject);
    procedure RenamePnlButtonClick(Sender: TObject);
    procedure TransferPnlButtonClick(Sender: TObject);
    procedure CannonMenuCheckBoxClick(Sender: TObject);
    procedure TaskBarCheckBoxClick(Sender: TObject);
    procedure TabSheetUsingResize(Sender: TObject);
    procedure PageControlItemBagDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure BagPnlButtonClick(Sender: TObject);
    procedure RemWeaponPnlButtonClick(Sender: TObject);
    procedure RemArmorPnlButtonClick(Sender: TObject);
    procedure WeaponAllCheckBoxClick(Sender: TObject);
    procedure ArmorAllCheckBoxClick(Sender: TObject);
    procedure ChestPnlButtonClick(Sender: TObject);
    procedure RecycleAllPnlButtonClick(Sender: TObject);
    procedure ListViewWeaponChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ListViewArmorChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure LockWPnlButtonClick(Sender: TObject);
    procedure LockAPnlButtonClick(Sender: TObject);
    procedure UnlockWPnlButtonClick(Sender: TObject);
    procedure UnlockAPnlButtonClick(Sender: TObject);
    procedure RecycleWPnlButtonClick(Sender: TObject);
    procedure RecycleAPnlButtonClick(Sender: TObject);
    procedure UseWPnlButtonClick(Sender: TObject);
    procedure UseAPnlButtonClick(Sender: TObject);
    procedure SlotPnlButtonClick(Sender: TObject);
  private
    { Private declarations }
    FHunter: Boolean;
    FBag: TDonguriBag;

    procedure SetMode;
    procedure SetColor;
    procedure SetButtonColor;
    procedure SetColors(control: TControl; bkg, txt: TColor);
    procedure SetButtonColors(button: TPanel; bkg, txt, dtx: TColor);
    procedure ClearInfoValue;
    procedure ShowRoot;
    function Parsing(html: String): Boolean;
    procedure ShowHttpError;
    function MsgBox(const hWnd: HWND; const Text, Caption: string; Flags: Longint = MB_OK): Integer;
    procedure DrawTab(TabCanvas: TCanvas; TabIndex: Integer; TabCaption: String; const Rect: TRect; Active: Boolean);
    function GetCBAmount: Integer;
    procedure RedrawControl(h: HWND);
    procedure ShowBag;
    procedure CheckCount(list: TListView; var lock, unlock: Integer);
    procedure LockItem(list: TListView);
    procedure UnlockItem(list: TListView);
    procedure RecycleItem(list: TListView);
    procedure UseItem(list: TListView);
	protected
		procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  DonguriForm: TDonguriForm;

implementation

uses
	GikoSystem, IndyModule, DmSession5ch, GikoDataModule, GikoUtil, Giko;

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

	COL_DARK_BKG1 : TColor = $00202020;
	COL_DARK_BKG2 : TColor = $00404040;
	COL_DARK_BKG3 : TColor = $00303030;
  COL_DARK_TEXT : TColor = $00FFFFFF;
  COL_DARK_DTXT : TColor = $00808080;//00A0A0A0;
  COL_LGHT_DTXT : TColor = $00808080;
  COL_BDWN_TEXT : TColor = clRed;

{$R *.dfm}

procedure TDonguriForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if GikoSys.Setting.DonguriTaskBar and
		(FormStyle in [fsNormal, fsStayOnTop]) and
    (BorderStyle in [bsSingle, bsSizeable]) then begin
    Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
    Params.WndParent := 0;
  end;
end;

procedure TDonguriForm.FormCreate(Sender: TObject);
var
	i: Integer;
begin
	FHunter := False;
	FBag := TDonguriBag.Create;

	PageControl.ActivePageIndex := 0;
  PageControlHunter.ActivePageIndex := 0;
  PageControlItemBag.ActivePageIndex := 0;

  InfoGrid.RowCount := Integer(idxRowCount);
  InfoGrid.ColWidths[1] := 150;
	for i := 0 to Integer(idxRowCount) - 1 do
	  InfoGrid.Cells[0, i] := COL_NAME[i];

	SetMode;

	Left   := GikoSys.Setting.DonguriLeft;
	Top    := GikoSys.Setting.DonguriTop;
  Width  := GikoSys.Setting.DonguriWidth;
	Height := GikoSys.Setting.DonguriHeight;

  TaskBarCheckBox.Checked   := GikoSys.Setting.DonguriTaskBar;
	ColorRadioGroup.ItemIndex := GikoSys.Setting.DonguriTheme;
	SetColor;
  CannonMenuCheckBox.Checked := GikoSys.Setting.DonguriMenuTop;

  LabelPeriod.Caption := ' ';
  LabelD.Caption := ' ';
  LabelK.Caption := ' ';

	TimerInit.Enabled := True;
end;

procedure TDonguriForm.TabSheetUsingResize(Sender: TObject);
var
  w: Integer;
begin
	w := TabSheetUsing.ClientWidth;
  ListViewWeaponUsing.Width := w;
  ListViewArmorUsing.Width := w;
end;

procedure TDonguriForm.TaskBarCheckBoxClick(Sender: TObject);
begin
	GikoSys.Setting.DonguriTaskBar := TaskBarCheckBox.Checked;
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

    FreeAndNil(FBag);
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

  ResurrectPnlButton.Enabled := FHunter;
  PageControlHunter.Enabled := FHunter;

  SetButtonColor;
end;

procedure TDonguriForm.RedrawControl(h: HWND);
begin
  if h <> 0 then begin
    Windows.InvalidateRect(h, nil, True);
		Windows.UpdateWindow(h);
  end;
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
	EditLevel.Text := '';
	LabelK.Caption := '';
	LabelD.Caption := '';

	for i := 0 to Integer(idxRowCount) - 1 do
	  InfoGrid.Cells[1, i] := '';
end;

procedure TDonguriForm.ShowRoot;
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

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

    if DonguriSystem.Extract(TAG_USR_S, TAG_USR_E, html, tmp) then begin
    	tmp := Trim(tmp);
      LabelUserType.Caption := tmp;
			FHunter := (tmp = 'ハンター');
    end;

  	SetMode;

    if DonguriSystem.Extract(TAG_ANM_S, TAG_ANM_E, html, tmp) then
      EditName.Text := Trim(tmp);

    if FHunter then begin		// ハンター
    	if DonguriSystem.Extract(TAG_HID_S, TAG_HID_E, html, tmp) then
  	    EditID.Text := Trim(tmp);
	    if DonguriSystem.Extract(TAG_DNG_S, TAG_DNG_E, html, tmp) then
	      InfoGrid.Cells[1, Integer(idxDonguri)] := Trim(tmp);
    end else begin					// 警備員
	    if DonguriSystem.Extract(TAG_GID_S, TAG_GID_E, html, tmp) then
  	    EditID.Text := Trim(tmp);
			if DonguriSystem.Extract(TAG_DN2_S, TAG_DNG_E, html, tmp) then
      	InfoGrid.Cells[1, Integer(idxDonguri)] := Trim(tmp);
    end;

    if DonguriSystem.Extract(TAG_NWD_S, TAG_NWD_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxNumWood)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_NIR_S, TAG_NIR_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxNumIron)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_IRK_S, TAG_IRK_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxIronKey)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_WCB_S, TAG_WCB_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxWdCnBall)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_ICB_S, TAG_ICB_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxIrCnBall)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_MRM_S, TAG_MRM_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxMarimo)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_LVL_S, TAG_LVL_E, html, tmp) then begin
      tmp := Trim(tmp);
      idx := Pos('|', tmp);
      if idx < 1 then
	      EditLevel.Text := tmp
      else begin
        tm2 := Trim(Copy(tmp, 1, idx - 1));
      	Delete(tmp, 1, idx);
	      tmp := tm2 + ' (' + Trim(tmp) + ')';
	      EditLevel.Text := tmp;
      end;
    end;

    if DonguriSystem.Extract(TAG_NKL_S, TAG_NKL_E, html, tmp) then
      LabelK.Caption := Trim(tmp);

    if DonguriSystem.Extract(TAG_NDM_S, TAG_NDM_E, html, tmp) then
      LabelD.Caption := Trim(tmp);

    if DonguriSystem.Extract(TAG_PRD_S, TAG_PRD_E, html, tmp) then
      LabelPeriod.Caption := '第' + tmp + '期';

    if DonguriSystem.Extract(TAG_EXP_S, TAG_EXP_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxExplrtn)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_MNG_S, TAG_MNG_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxMining)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_FLL_S, TAG_FLL_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxFelling)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_ARM_S, TAG_ARM_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxArmsWork)] := Trim(tmp);

    if DonguriSystem.Extract(TAG_PRT_S, TAG_PRT_E, html, tmp) then
      InfoGrid.Cells[1, Integer(idxProtector)] := Trim(tmp);

  	if Pos(TAG_ERROR, html) > 0 then begin
	    if DonguriSystem.Extract(TAG_ECD_S, TAG_ECD_E, html, tmp) then begin
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


procedure TDonguriForm.AuthPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Auth(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.ListViewArmorChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  lock, unlock: Integer;
begin
	CheckCount(ListViewArmor, lock, unlock);
	LockAPnlButton.Enabled := (unlock > 0);
  UnlockAPnlButton.Enabled := (lock > 0);
  RecycleAPnlButton.Enabled := (unlock > 0);
  UseAPnlButton.Enabled := ((lock + unlock) = 1);
  SetButtonColor;
end;

procedure TDonguriForm.ListViewWeaponChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  lock, unlock: Integer;
begin
	CheckCount(ListViewWeapon, lock, unlock);
	LockWPnlButton.Enabled := (unlock > 0);
  UnlockWPnlButton.Enabled := (lock > 0);
  RecycleWPnlButton.Enabled := (unlock > 0);
  UseWPnlButton.Enabled := ((lock + unlock) = 1);
  SetButtonColor;
end;

procedure TDonguriForm.LoginPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

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

procedure TDonguriForm.LogoutPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Logout(res) then begin
	  MsgBox(Handle, 'ログアウトしました。',
    						'どんぐりシステム', MB_OK or MB_ICONINFORMATION);
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.ExplorPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Exploration(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.PanelButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TPanel then
		TPanel(Sender).Font.Color := COL_BDWN_TEXT;
end;

procedure TDonguriForm.PanelButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TPanel then begin
    if ColorRadioGroup.ItemIndex = 0 then
      TPanel(Sender).Font.Color := clWindowText
    else
      TPanel(Sender).Font.Color := COL_DARK_TEXT;
  end;
end;

procedure TDonguriForm.MiningPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Mining(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.WoodctPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.WoodCutting(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.WeaponPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.WeaponCraft(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.ArmorcPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.ArmorCraft(res) then begin
  	if Parsing(res) = False then
      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
  end else
  	ShowHttpError;
end;

//=================

procedure TDonguriForm.RenamePnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Rename(res) then begin
//  	if Parsing(res) = False then
//      MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
//								'どんぐりシステム', MB_OK or MB_ICONERROR);
  	MsgBox(Handle, 'OK', 'debug', MB_OK);
  end else
  	ShowHttpError;
end;

// 復活
procedure TDonguriForm.ResurrectPnlButtonClick(Sender: TObject);
var
  res: String;
  cancel: Boolean;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

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

procedure TDonguriForm.RootPnlButtonClick(Sender: TObject);
begin
	ShowRoot;
end;

procedure TDonguriForm.TransferPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Transfer(res) then begin
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

procedure TDonguriForm.ColorRadioGroupClick(Sender: TObject);
begin
	GikoSys.Setting.DonguriTheme := ColorRadioGroup.ItemIndex;
	SetColor;
end;


procedure TDonguriForm.SetColor;
begin
	try
    case ColorRadioGroup.ItemIndex of
    	0: begin
        PageControl.OwnerDraw := False;
        PageControlHunter.OwnerDraw := False;
        PageControlItemBag.OwnerDraw := False;

        Color := clBtnFace;
        PanelTop.Color := clBtnFace;
			  SetColors(PanelBottom,     clBtnFace, clWindowText);

			  SetColors(PanelHomeTop,    clBtnFace, clWindowText);
			  SetColors(EditName,        clWindow,  clWindowText);
			  SetColors(EditID,          clWindow,  clWindowText);
			  SetColors(EditLevel,       clWindow,  clWindowText);
			  SetColors(InfoGrid,        clWindow,  clWindowText);
			  SetColors(PanelHome,       clBtnFace, clWindowText);

        TabSheetHunter.Font.Color := clWindowText;
        SetColors(ListViewWeaponUsing, clWindow,  clWindowText);
        SetColors(ListViewArmorUsing,  clWindow,  clWindowText);
        SetColors(ListViewWeapon,      clWindow,  clWindowText);
        SetColors(ListViewArmor,       clWindow,  clWindowText);
			  SetColors(PanelHunterTop,      clBtnFace, clWindowText);
        SetColors(WeaponTopPanel,      clBtnFace, clWindowText);
        SetColors(ArmorTopPanel,       clBtnFace, clWindowText);
			  SetColors(CBAmountComboBox,    clWindow,  clWindowText);
        SetColors(BagTopPanel,         clBtnFace, clWindowText);

      	TabSheetSetting.Font.Color := clWindowText;

      end;
      1: begin
        PageControl.OwnerDraw := True;
        PageControlHunter.OwnerDraw := True;
        PageControlItemBag.OwnerDraw := True;

        Color := COL_DARK_BKG1;
        PanelTop.Color := COL_DARK_BKG1;
			  SetColors(PanelBottom,     COL_DARK_BKG1, COL_DARK_TEXT);

			  SetColors(PanelHomeTop,    COL_DARK_BKG1, COL_DARK_TEXT);
			  SetColors(EditName,        COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(EditID,          COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(EditLevel,       COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(InfoGrid,        COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(PanelHome,       COL_DARK_BKG1, COL_DARK_TEXT);

        TabSheetHunter.Font.Color := COL_DARK_TEXT;
        SetColors(ListViewWeaponUsing, COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ListViewArmorUsing,  COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ListViewWeapon,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ListViewArmor,       COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(PanelHunterTop,      COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(WeaponTopPanel,      COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(ArmorTopPanel,       COL_DARK_BKG1, COL_DARK_TEXT);
			  SetColors(CBAmountComboBox,    COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(BagTopPanel,         COL_DARK_BKG1, COL_DARK_TEXT);

      	TabSheetSetting.Font.Color := COL_DARK_TEXT;

      end;
    end;

    SetButtonColor;

	  RedrawControl(PageControl.Handle);
  except
  	on e: Exception do
    	MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
  end;
end;

procedure TDonguriForm.SetColors(control: TControl; bkg, txt: TColor);
begin
  if control is TPanel then begin
    TPanel(control).Color := bkg;
    TPanel(control).Font.Color := txt;
  end else if control is TEdit then begin
    TEdit(control).Color := bkg;
    TEdit(control).Font.Color := txt;
  end else if control is TComboBox then begin
    TComboBox(control).Color := bkg;
    TComboBox(control).Font.Color := txt;
  end else if control is TStringGrid then begin
    TStringGrid(control).Color := bkg;
    TStringGrid(control).Font.Color := txt;
  end else if control is TListView then begin
    TListView(control).Color := bkg;
    TListView(control).Font.Color := txt;
  end;
end;

procedure TDonguriForm.SetButtonColor;
var
  bkg: TColor;
  txt: TColor;
  dtx: TColor;
begin
  if ColorRadioGroup.ItemIndex = 0 then begin
    bkg := clBtnFace;
    txt := clWindowText;
    dtx := COL_LGHT_DTXT;
  end else {if ColorRadioGroup.ItemIndex = 1 then} begin
    bkg := COL_DARK_BKG3;
    txt := COL_DARK_TEXT;
    dtx := COL_DARK_DTXT;
  end;

  SetButtonColors(RootPnlButton,   bkg, txt, dtx);
  SetButtonColors(AuthPnlButton,   bkg, txt, dtx);
  SetButtonColors(LoginPnlButton,  bkg, txt, dtx);
  SetButtonColors(LogoutPnlButton, bkg, txt, dtx);

  SetButtonColors(ExplorPnlButton, bkg, txt, dtx);
  SetButtonColors(MiningPnlButton, bkg, txt, dtx);
  SetButtonColors(WoodctPnlButton, bkg, txt, dtx);
  SetButtonColors(WeaponPnlButton, bkg, txt, dtx);
  SetButtonColors(ArmorcPnlButton, bkg, txt, dtx);
  SetButtonColors(SlotPnlButton,   bkg, txt, dtx);
  SetButtonColors(RemWeaponPnlButton, bkg, txt, dtx);
  SetButtonColors(RemArmorPnlButton,  bkg, txt, dtx);
  SetButtonColors(LockWPnlButton,     bkg, txt, dtx);
  SetButtonColors(UnlockWPnlButton,   bkg, txt, dtx);
  SetButtonColors(RecycleWPnlButton,  bkg, txt, dtx);
  SetButtonColors(UseWPnlButton,      bkg, txt, dtx);
  SetButtonColors(LockAPnlButton,     bkg, txt, dtx);
  SetButtonColors(UnlockAPnlButton,   bkg, txt, dtx);
  SetButtonColors(RecycleAPnlButton,  bkg, txt, dtx);
  SetButtonColors(UseAPnlButton,      bkg, txt, dtx);
  SetButtonColors(RecycleAllPnlButton,bkg, txt, dtx);

  SetButtonColors(ResurrectPnlButton, bkg, txt, dtx);
  SetButtonColors(RenamePnlButton,    bkg, txt, dtx);
	SetButtonColors(TransferPnlButton,  bkg, txt, dtx);
  SetButtonColors(CraftCBPnlButton,   bkg, txt, dtx);
  SetButtonColors(BagPnlButton,       bkg, txt, dtx);
  SetButtonColors(ChestPnlButton,     bkg, txt, dtx);
end;

procedure TDonguriForm.SetButtonColors(button: TPanel; bkg, txt, dtx: TColor);
begin
  button.Color := bkg;
  if button.Enabled then
	  button.Font.Color := txt
  else
	  button.Font.Color := dtx;
end;

procedure TDonguriForm.PageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
	cpt: String;
begin
  case TabIndex of
    0: cpt := TabSheetHome.Caption;
    1: cpt := TabSheetHunter.Caption;
    2: cpt := TabSheetSetting.Caption;
  end;
  DrawTab(Control.Canvas, TabIndex, cpt, Rect, Active);
end;

procedure TDonguriForm.PageControlHunterDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
	cpt: String;
begin
  case TabIndex of
    0: cpt := TabSheetRename.Caption;
    1: cpt := TabSheetCraft.Caption;
    2: cpt := TabSheetChest.Caption;
  end;
  DrawTab(Control.Canvas, TabIndex, cpt, Rect, Active);
end;

procedure TDonguriForm.PageControlItemBagDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
	cpt: String;
begin
  case TabIndex of
    0: cpt := TabSheetUsing.Caption;
    1: cpt := TabSheetWeapon.Caption;
    2: cpt := TabSheetArmor.Caption;
  end;
  DrawTab(Control.Canvas, TabIndex, cpt, Rect, Active);
end;

procedure TDonguriForm.DrawTab(TabCanvas: TCanvas; TabIndex: Integer; TabCaption: String; const Rect: TRect; Active: Boolean);
var
  rct: TRect;
begin
	try
    TabCanvas.Brush.Style := bsSolid;
    TabCanvas.Brush.Color := COL_DARK_BKG1;
    TabCanvas.FillRect(Rect);

    rct := Rect;
  	if not Active then
      rct.Top  := rct.Top + 3;
    TabCanvas.Font.Color := COL_DARK_TEXT;
    Windows.DrawText(TabCanvas.Handle, PChar(TabCaption), Length(TabCaption),
    								rct, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  except
  end;
end;

procedure TDonguriForm.CannonMenuCheckBoxClick(Sender: TObject);
begin
  GikoSys.Setting.DonguriMenuTop := CannonMenuCheckBox.Checked;
	GikoForm.ShowDonguriCannonTopMenu;
end;

function TDonguriForm.GetCBAmount: Integer;
begin
	Result := StrToIntDef(Trim(CBAmountComboBox.Text), 0);
end;

procedure TDonguriForm.CBAmountComboBoxChange(Sender: TObject);
var
	amount: Integer;
  iron: Integer;
begin
	try
  	iron := 0;
		amount := GetCBAmount;
    if amount > 0 then
      iron := amount * 10;
  	CBIronLabel.Caption := IntToStr(iron);
  except
  end;
end;

procedure TDonguriForm.CraftCBPnlButtonClick(Sender: TObject);
var
	amount: Integer;
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	amount := GetCBAmount;
  if amount < 1 then begin
    MsgBox(Handle, '鉄の大砲の玉の作成数を入力してください。', '工作センター',
          	MB_OK or MB_ICONINFORMATION);
    Exit;
  end;

  if GikoSys.DonguriSys.CraftCB(amount, res) then
  	MsgBox(Handle, res, '鉄の大砲の玉作成', MB_OK or MB_ICONINFORMATION)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.BagPnlButtonClick(Sender: TObject);
var
	denied: Boolean;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	denied := False;
  if GikoSys.DonguriSys.Bag(FBag, denied) then
    ShowBag
  else if denied then
    MsgBox(Handle, 'アイテムバッグを参照できませんでした。' + #10 +
                   'どんぐりが枯れたかもしれません。' + #10 +
                   'ログインし直してみてください。',
                   'アイテムバッグ', MB_OK or MB_ICONWARNING)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.ShowBag;
var
  usedSlot: Integer;
  i: Integer;
  item: TListItem;
begin
	try
  	ListViewWeaponUsing.Items.Clear;
    ListViewArmorUsing.Items.Clear;
    ListViewWeapon.Items.Clear;
    ListViewArmor.Items.Clear;

  	usedSlot := FBag.WeaponList.Count + FBag.ArmorList.Count;
  	SlotLabel.Caption := Format('%d / %d', [usedSlot, FBag.Slot]);

    if FBag.UseWeapon.IsEmpty = False then begin
      item := ListViewWeaponUsing.Items.Add;
      FBag.UseWeapon.SetListItem(0, item);
    end;

    if FBag.UseArmor.IsEmpty = False then begin
      item := ListViewArmorUsing.Items.Add;
      FBag.UseArmor.SetListItem(0, item);
    end;

    for i := 0 to FBag.WeaponList.Count - 1 do begin
      item := ListViewWeapon.Items.Add;
      TDonguriWeapon(FBag.WeaponList.Items[i]).SetListItem(i + 1, item);
    end;

    for i := 0 to FBag.ArmorList.Count - 1 do begin
      item := ListViewArmor.Items.Add;
      TDonguriArmor(FBag.ArmorList.Items[i]).SetListItem(i + 1, item);
    end;

    RemWeaponPnlButton.Enabled := (FBag.UseWeapon.IsEmpty = False);
    RemArmorPnlButton.Enabled := (FBag.UseArmor.IsEmpty = False);
    LockWPnlButton.Enabled    := False;
    UnlockWPnlButton.Enabled  := False;
    RecycleWPnlButton.Enabled := False;
    UseWPnlButton.Enabled     := False;
    LockAPnlButton.Enabled    := False;
    UnlockAPnlButton.Enabled  := False;
    RecycleAPnlButton.Enabled := False;
    UseAPnlButton.Enabled     := False;
    SetButtonColor;

  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, 'アイテムバッグ', MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriForm.SlotPnlButtonClick(Sender: TObject);
var
	res: String;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

	if MsgBox(Handle, '木材 1000 をアイテムスロット 10 に交換します。' + #10 +
  									'よろしいですか？', 'アイテムバッグ',
                    MB_OKCANCEL or MB_ICONQUESTION) <> IDOK then
  	Exit;

  if GikoSys.DonguriSys.AddSlots(FBag, res) then begin
  	if FBag.Slot > 0 then
			ShowBag
    else if (Pos('<html', res) < 1) then
    	MsgBox(Handle, TrimTag(res), 'どんぐりシステム', MB_OK or MB_ICONINFORMATION)
    else if (Pos('<h1>どんぐりシステム</h1>', res) > 0) then begin
    	if Parsing(res) = False then
        MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました',
                  'どんぐりシステム', MB_OK or MB_ICONERROR);
  	end else	// 状況不明？？？
    	MsgBox(Handle, 'アイテムバッグ表示更新を行ってください。',
			      			'アイテムバッグ', MB_OK or MB_ICONINFORMATION);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.RemWeaponPnlButtonClick(Sender: TObject);
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	if FBag.UseWeapon.IsEmpty then
  	Exit;

  if GikoSys.DonguriSys.Unequip(FBag, True) then
		ShowBag
  else
  	ShowHttpError;
end;

procedure TDonguriForm.RemArmorPnlButtonClick(Sender: TObject);
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	if FBag.UseArmor.IsEmpty then
  	Exit;

  if GikoSys.DonguriSys.Unequip(FBag, False) then
		ShowBag
  else
  	ShowHttpError;
end;

procedure TDonguriForm.WeaponAllCheckBoxClick(Sender: TObject);
var
	check: Boolean;
  i: Integer;
begin
	try
    check := WeaponAllCheckBox.Checked;
    for i := 0 to ListViewWeapon.Items.Count - 1 do
      ListViewWeapon.Items.Item[i].Checked := check;
  except
  end;
end;

procedure TDonguriForm.ArmorAllCheckBoxClick(Sender: TObject);
var
	check: Boolean;
  i: Integer;
begin
	try
    check := ArmorAllCheckBox.Checked;
    for i := 0 to ListViewArmor.Items.Count - 1 do
      ListViewArmor.Items.Item[i].Checked := check;
  except
  end;
end;

procedure TDonguriForm.ChestPnlButtonClick(Sender: TObject);
var
  res: String;
  key: Integer;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	if MsgBox(Handle, '鉄のキーを10消費します。' + #10 + '宝箱を開けますか？',
  					'アイテムバッグ', MB_YESNO or MB_ICONQUESTION) <> IDYES then
    Exit;

  if GikoSys.DonguriSys.ChestOpen(FBag, res) then
		ShowBag
  else if res <> ''then begin
  	if Pos('<html', res) < 1 then begin
			MsgBox(Handle, res, 'アイテムバッグ', MB_OK or MB_ICONWARNING);
			Exit;
    end;
    if (Pos('<h1>どんぐりシステム</h1>', res) > 0) then begin
    	if Parsing(res) then begin
      	if FHunter then begin
          key := StrToIntDef(InfoGrid.Cells[1, Integer(idxIronKey)], -1);
          if (key >= 0) and (key < 10) then begin
            MsgBox(Handle, '鉄のキーが不足しています。', 'アイテムバッグ', MB_OK or MB_ICONWARNING);
            Exit;
          end;
        end else begin
          MsgBox(Handle, 'ハンターアカウントの機能にアクセスできませんでした。', 'アイテムバッグ', MB_OK or MB_ICONWARNING);
          Exit;
        end;
			end;
		end;
		MsgBox(Handle, '宝箱を開くことができませんでした。', 'アイテムバッグ', MB_OK or MB_ICONWARNING);
  end else
  	ShowHttpError;
end;


procedure TDonguriForm.RecycleAllPnlButtonClick(Sender: TObject);
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	if MsgBox(Handle, '解体した装備を元に戻すことはできません。' + #10 +
                    'ロックされていない装備をすべて解体しますか？',
  					'アイテムバッグ', MB_YESNO or MB_ICONQUESTION) <> IDYES then
    Exit;

  if GikoSys.DonguriSys.RecycleAll(FBag) then
		ShowBag
  else
  	ShowHttpError;
end;

procedure TDonguriForm.CheckCount(list: TListView; var lock, unlock: Integer);
var
  i: Integer;
begin
  lock := 0;
  unlock := 0;
	for i := 0 to list.Items.Count - 1 do begin
		if list.Items.Item[i].Checked and (list.Items.Item[i].Data <> nil) then begin
			if TDonguriItem(list.Items.Item[i].Data).Lock then
        Inc(lock)
      else
	      Inc(unlock);
    end;
  end;
end;

procedure TDonguriForm.LockAPnlButtonClick(Sender: TObject);
begin
	LockItem(ListViewArmor);
end;

procedure TDonguriForm.LockWPnlButtonClick(Sender: TObject);
begin
	LockItem(ListViewWeapon);
end;

procedure TDonguriForm.LockItem(list: TListView);
var
	i: Integer;
  item: TListItem;
	itemNoList: TStringList;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

	itemNoList := TStringList.Create;

	try
  	for i := 0 to list.Items.Count - 1 do begin
    	item := list.Items.Item[i];
      if item.Checked and (item.Data <> nil) and
      	 (TDonguriItem(item.Data).Lock = False) and
         (TDonguriItem(item.Data).ItemNo <> '') then
      	itemNoList.Add(TDonguriItem(item.Data).ItemNo);
    end;

		if itemNoList.Count < 1 then begin
      MsgBox(Handle, 'ロックする行にチェックを付けてください。',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.Lock(itemNoList, FBag) then
      ShowBag
    else
      ShowHttpError;
  finally
  	itemNoList.Free;
  end;
end;

procedure TDonguriForm.UnlockAPnlButtonClick(Sender: TObject);
begin
	UnlockItem(ListViewArmor);
end;

procedure TDonguriForm.UnlockWPnlButtonClick(Sender: TObject);
begin
	UnlockItem(ListViewWeapon);
end;

procedure TDonguriForm.UnlockItem(list: TListView);
var
	i: Integer;
  item: TListItem;
	itemNoList: TStringList;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

	itemNoList := TStringList.Create;

	try
  	for i := 0 to list.Items.Count - 1 do begin
    	item := list.Items.Item[i];
      if item.Checked and (item.Data <> nil) and
      	  TDonguriItem(item.Data).Lock and
         (TDonguriItem(item.Data).ItemNo <> '') then
      	itemNoList.Add(TDonguriItem(item.Data).ItemNo);
    end;

		if itemNoList.Count < 1 then begin
      MsgBox(Handle, 'アンロックする行にチェックを付けてください。',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.Unlock(itemNoList, FBag) then
      ShowBag
    else
      ShowHttpError;
  finally
  	itemNoList.Free;
  end;
end;

procedure TDonguriForm.RecycleAPnlButtonClick(Sender: TObject);
begin
	RecycleItem(ListViewArmor);
end;

procedure TDonguriForm.RecycleWPnlButtonClick(Sender: TObject);
begin
	RecycleItem(ListViewWeapon);
end;

procedure TDonguriForm.RecycleItem(list: TListView);
var
	i: Integer;
  item: TListItem;
	itemNoList: TStringList;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

	itemNoList := TStringList.Create;

	try
  	for i := 0 to list.Items.Count - 1 do begin
    	item := list.Items.Item[i];
      if item.Checked and (item.Data <> nil) and
      	 (TDonguriItem(item.Data).Lock = False) and
         (TDonguriItem(item.Data).ItemNo <> '') then
      	itemNoList.Add(TDonguriItem(item.Data).ItemNo);
    end;

		if itemNoList.Count < 1 then begin
      MsgBox(Handle, '分解する行にチェックを付けてください。',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.Recycle(itemNoList, FBag) then
      ShowBag
    else
      ShowHttpError;
  finally
  	itemNoList.Free;
  end;
end;

procedure TDonguriForm.UseAPnlButtonClick(Sender: TObject);
begin
	UseItem(ListViewArmor);
end;

procedure TDonguriForm.UseWPnlButtonClick(Sender: TObject);
begin
	UseItem(ListViewWeapon);
end;

procedure TDonguriForm.UseItem(list: TListView);
var
	i: Integer;
  item: TListItem;
	itemNo: String;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

	try
  	for i := 0 to list.Items.Count - 1 do begin
    	item := list.Items.Item[i];
      if item.Checked and (item.Data <> nil) and
      	 (TDonguriItem(item.Data).Used = False) and
         (TDonguriItem(item.Data).ItemNo <> '') then begin
        if itemNo <> '' then begin
          MsgBox(Handle, '一度に複数を装備することはできません。',
                    'どんぐりシステム', MB_OK or MB_ICONERROR);
        	Exit;
        end;
      	itemNo := TDonguriItem(item.Data).ItemNo;
			end;
    end;

		if itemNo = '' then begin
      MsgBox(Handle, '装備する行にチェックを付けてください。',
								'どんぐりシステム', MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.Equip(itemNo, FBag) then
      ShowBag
    else
      ShowHttpError;
  finally
  end;
end;


end.
