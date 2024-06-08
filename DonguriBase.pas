unit DonguriBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, StrUtils, ComCtrls, Buttons, DonguriSystem,
  ImgList, Menus, Clipbrd;

type
  TColumnType = (ctString, ctInteger);

  TDonguriForm = class(TForm)
    TimerInit: TTimer;
    InfoGrid: TStringGrid;
    PanelTop: TPanel;
    PageControl: TPageControl;
    TabSheetHome: TTabSheet;
    TabSheetService: TTabSheet;
    SpeedButtonTopMost: TSpeedButton;
    PanelService: TPanel;
    TabSheetSetting: TTabSheet;
    PanelHome: TPanel;
    EditName: TEdit;
    LabelID: TLabel;
    EditID: TEdit;
    Label3: TLabel;
    LabelPeriod: TLabel;
    ColorRadioGroup: TRadioGroup;
    EditLevel: TEdit;
    CraftKYGroupBox: TGroupBox;
    CraftCBGroupBox: TGroupBox;
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
    UsingWeaponLabel: TLabel;
    RemWeaponPnlButton: TPanel;
    UsingArmorLabel: TLabel;
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
    Label12: TLabel;
    Label13: TLabel;
    ExprProgressBar: TProgressBar;
    TimeProgressBar: TProgressBar;
    ExplorProgressBar: TProgressBar;
    MiningProgressBar: TProgressBar;
    WoodctProgressBar: TProgressBar;
    WeaponProgressBar: TProgressBar;
    ArmorcProgressBar: TProgressBar;
    ExprValLabel: TLabel;
    TimeValLabel: TLabel;
    ExplorValLabel: TLabel;
    MiningValLabel: TLabel;
    WoodctValLabel: TLabel;
    WeaponValLabel: TLabel;
    ArmorcValLabel: TLabel;
    ExplorPanel: TPanel;
    MiningPanel: TPanel;
    WoodctPanel: TPanel;
    WeaponPanel: TPanel;
    ArmorcPanel: TPanel;
    Label14: TLabel;
    KYAmountComboBox: TComboBox;
    Label15: TLabel;
    KYIronLabel: TLabel;
    CraftKYPnlButton: TPanel;
    TabSheetChest: TTabSheet;
    UsingPanel: TPanel;
    RenameGroupBox: TGroupBox;
    TransferGroupBox: TGroupBox;
    Label2: TLabel;
    RIDEdit: TEdit;
    Label10: TLabel;
    TAmountEdit: TEdit;
    Label11: TLabel;
    Label16: TLabel;
    NewNameEdit: TEdit;
    Label17: TLabel;
    TabSheetLink: TTabSheet;
    LinkPanel: TPanel;
    Label18: TLabel;
    LabelHomeLink: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    LabelFaqLink: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    LabelApiLink: TLabel;
    Label23: TLabel;
    LabelRankLink: TLabel;
    Label25: TLabel;
    LabelCLogLink: TLabel;
    Label27: TLabel;
    LabelFLogLink: TLabel;
    Label29: TLabel;
    LabelItemWLink: TLabel;
    Label31: TLabel;
    LabelAlertLink: TLabel;
    Label33: TLabel;
    LabelUpliftLink: TLabel;
    PopupMenuLink: TPopupMenu;
    ManuItemCopy: TMenuItem;
    ManuItemOpen: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PanelSetting: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    ChestB70PnlButton: TPanel;
    Label28: TLabel;
    LabelShopLink: TLabel;
    Label32: TLabel;
    Label4: TLabel;
    KYCostLabel: TLabel;
    Label5: TLabel;
    CBCostLabel: TLabel;
    CraftPnlButton: TPanel;
    StatisticsGrid: TStringGrid;
    Label24: TLabel;
    Label1: TLabel;
    RNCostLabel: TLabel;
    TRCostLabel: TLabel;
    NewRegPnlButton: TPanel;
    PopupMenuLogin: TPopupMenu;
    MItemLogin: TMenuItem;
    MItemHntLogin: TMenuItem;
    MItemGrdLogin: TMenuItem;
    AutoLoginCheckBox: TCheckBox;
    AutoLoginLabel: TLabel;
    ModePanel: TPanel;
    Label30: TLabel;
    Label34: TLabel;
    procedure TimerInitTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonTopMostClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure ColorRadioGroupClick(Sender: TObject);
    procedure PageControlDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
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
    procedure CraftKYPnlButtonClick(Sender: TObject);
    procedure KYAmountComboBoxChange(Sender: TObject);
    procedure LabelLinkClick(Sender: TObject);
    procedure ManuItemCopyClick(Sender: TObject);
    procedure LabelLinkContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ManuItemOpenClick(Sender: TObject);
    procedure ChestB70PnlButtonClick(Sender: TObject);
    procedure CraftPnlButtonClick(Sender: TObject);
    procedure ListViewArmorCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListViewWeaponCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListViewWeaponColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewArmorColumnClick(Sender: TObject; Column: TListColumn);
    procedure NewRegPnlButtonClick(Sender: TObject);
    procedure MItemLoginClick(Sender: TObject);
    procedure MItemHntLoginClick(Sender: TObject);
    procedure MItemGrdLoginClick(Sender: TObject);
    procedure AutoLoginCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    FHunter: Boolean;
    FBag: TDonguriBag;
    FLink: String;
    FWpnSortIdx: Integer;
    FArmSortIdx: Integer;
    FWpnSortAsc: Boolean;
    FArmSortAsc: Boolean;

    procedure SetColor;
    procedure SetButtonColor;
    procedure SetColors(control: TControl; bkg, txt: TColor);
    procedure SetButtonColors(button: TPanel; bkg, txt, dtx: TColor);
    procedure SetBtnCol(button: TPanel);
    procedure SetSkillPanelColor(panel: TPanel);
    procedure ClearInfoValue;
    procedure ShowRoot;
    procedure SetHomeInfo(res: String);
    procedure ShowHttpError;
    function MsgBox(const hWnd: HWND; const Text, Caption: string; Flags: Longint = MB_OK): Integer;
    procedure DrawTab(TabCanvas: TCanvas; TabIndex: Integer; TabCaption: String; const Rect: TRect; Active: Boolean);
    function GetCmbAmount(cmb: TComboBox): Integer;
    procedure RedrawControl(h: HWND);
    procedure ShowBag;
    procedure CheckCount(list: TListView; var lock, unlock: Integer);
    procedure LockItem(list: TListView);
    procedure UnlockItem(list: TListView);
    procedure RecycleItem(list: TListView);
    procedure UseItem(list: TListView);
		procedure SetSkillInfo(val: Integer; rate: Integer; sel: Boolean; panel: TPanel; prgbar: TProgressBar; prglbl: TLabel);
    procedure OpenChest(amount: Integer; chestName: String);
    function NumComp(text1, text2: String): Integer;
    function atoi(str: String): Integer;
    procedure Login;
    procedure MailLogin(mail, pwd: String);
	protected
		procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure UpdateHomeInfo;
  end;

var
  DonguriForm: TDonguriForm;

implementation

uses
	GikoSystem, IndyModule, DmSession5ch, GikoDataModule, GikoUtil, Giko, MojuUtils,
  DonguriRegister;

type
	StcIndex = (
  	idxCannon    = 0,
    idxFight     = 1,
    idxStcCount  = 2);
  ColIndex = (
    idxDonguri   = 0,
    idxNumWood   = 1,
    idxNumIron   = 2,
    idxIronKey   = 3,
    idxMarimo    = 4,
    idxWdCnBall  = 5,
    idxIrCnBall  = 6,
    idxRowCount  = 7);

const
	COL_STSC: array [0..1] of string = (
    '　どんぐり大砲',
    '　大乱闘'
  );
  COL_NAME: array [0..6] of string  = (
    '　どんぐり残高',
  	'　木材',
    '　鉄',
    '　鉄のキー',
    '　マリモ',
    '　木製の大砲の玉',
    '　鉄の大砲の玉'
    );
//  MODE_NAME: array[0..6] of String = (
//    '不明',
//    'ハンター',
//    'ハンター●',
//    'ハンター○',
//    '警備員',
//    '警備員●',
//    '警備員○'
//  );
//  COL_NAME_ACRN : String = '　どんぐり残高';
//  COL_NAME_SEED : String = '　種子残高';

	COL_DARK_BKG1 : TColor = $00202020;
	COL_DARK_BKG2 : TColor = $00404040;
	COL_DARK_BKG3 : TColor = $00303030;
  COL_DARK_TEXT : TColor = $00FFFFFF;
  COL_DARK_DTXT : TColor = $00808080;//00A0A0A0;
  COL_LGHT_DTXT : TColor = $00808080;
  COL_BDWN_TEXT : TColor = clRed;
  COL_LGHT_LINK : TColor = clBlue;
  COL_DARK_LINK : TColor = clLime;
  COL_LGHT_SKIL : TColor = $00f9b3b6;
  COL_DARK_SKIL : TColor = $008f0c12;

  RARITY_TABLE: array [0..4, 0..1] of string = (
    ( ' UR', ' 0.03%'),
    ( 'SSR', ' 0.17%'),
    ('  SR', ' 1.5%'),
    ( '　R', '15%'),
    ( '　N', '83.3%')
	  );

  COL_TYPE_WPN: array [0..8] of TColumnType = (
  	ctString,
  	ctString,
  	ctString,
    ctInteger,
    ctInteger,
    ctInteger,
  	ctString,
    ctInteger,
    ctInteger
  );
  COL_TYPE_ARM: array [0..8] of TColumnType = (
  	ctString,
  	ctString,
  	ctString,
    ctInteger,
    ctInteger,
    ctInteger,
  	ctString,
    ctInteger,
    ctInteger
  );

  URL_ROOT  : String = 'https://donguri.5ch.net/';
  URL_FAQ   : String = 'https://donguri.5ch.net/faq';
  URL_API   : String = 'https://donguri.5ch.net/api';
  URL_RANK  : String = 'https://donguri.5ch.net/rank';
  URL_CLOGS : String = 'https://donguri.5ch.net/cannonlogs';
  URL_FLOGS : String = 'https://donguri.5ch.net/fightlogs';
  URL_ITEMW : String = 'https://donguri.5ch.net/itemwatch';
  URL_ALERT : String = 'https://donguri.5ch.net/alert';
  URL_SHOP  : String = 'https://donguri.5ch.net/keyshop';
  URL_UPLIFT: String = 'https://uplift.5ch.net/';

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
	wp: TWindowPlacement;
  hintText: String;
  mode: String;
	sel: TGridRect;
begin
	FHunter := False;
	FBag := TDonguriBag.Create;
  FWpnSortIdx := 0;
  FArmSortIdx := 0;
  FWpnSortAsc := True;
  FArmSortAsc := True;

	PageControl.ActivePageIndex := 0;
  PageControlItemBag.ActivePageIndex := 0;

	sel.Left   := -1;
	sel.Top    := -1;
	sel.Right  := -1;
	sel.Bottom := -1;

	StatisticsGrid.RowCount := Integer(idxStcCount);
  StatisticsGrid.ColWidths[1] := 152;
	for i := 0 to Integer(idxStcCount) - 1 do
	  StatisticsGrid.Cells[0, i] := COL_STSC[i];
  StatisticsGrid.Selection := sel;

  InfoGrid.RowCount := Integer(idxRowCount);
  InfoGrid.ColWidths[1] := 152;
	for i := 0 to Integer(idxRowCount) - 1 do
	  InfoGrid.Cells[0, i] := COL_NAME[i];
  InfoGrid.Selection := sel;

	wp.length := sizeof(wp);
	wp.rcNormalPosition.Top    := GikoSys.Setting.DonguriTop;
	wp.rcNormalPosition.Left   := GikoSys.Setting.DonguriLeft;
	wp.rcNormalPosition.Bottom := GikoSys.Setting.DonguriTop + GikoSys.Setting.DonguriHeight;
	wp.rcNormalPosition.Right  := GikoSys.Setting.DonguriLeft + GikoSys.Setting.DonguriWidth;
	wp.showCmd := SW_SHOW;
	SetWindowPlacement(Handle, @wp);

  TaskBarCheckBox.Checked   := GikoSys.Setting.DonguriTaskBar;
	ColorRadioGroup.ItemIndex := GikoSys.Setting.DonguriTheme;
	SetColor;
  CannonMenuCheckBox.Checked := GikoSys.Setting.DonguriMenuTop;

  ClearInfoValue;

  hintText := 'レアリティ出現率';
  for i := Low(RARITY_TABLE) to High(RARITY_TABLE) do
    hintText := hintText + #10 + Format(' %s : %s', [RARITY_TABLE[i, 0], RARITY_TABLE[i, 1]]);
  ListViewWeaponUsing.Hint := hintText;
  ListViewWeaponUsing.ShowHint := True;
  ListViewArmorUsing.Hint := hintText;
  ListViewArmorUsing.ShowHint := True;
  ListViewWeapon.Hint := hintText;
  ListViewWeapon.ShowHint := True;
  ListViewArmor.Hint := hintText;
  ListViewArmor.ShowHint := True;

  LabelHomeLink.Caption   := URL_ROOT;
  LabelFaqLink.Caption    := URL_FAQ;
  LabelApiLink.Caption    := URL_API;
  LabelApiLink.Caption    := URL_API;
  LabelRankLink.Caption   := URL_RANK;
  LabelCLogLink.Caption   := URL_CLOGS;
  LabelFLogLink.Caption   := URL_FLOGS;
  LabelItemWLink.Caption  := URL_ITEMW;
  LabelAlertLink.Caption  := URL_ALERT;
  LabelShopLink.Caption   := URL_SHOP;
  LabelUpliftLink.Caption := URL_UPLIFT;

  KYCostLabel.Caption := IntToStr(GikoSys.Setting.DonguriKYCost);
  CBCostLabel.Caption := IntToStr(GikoSys.Setting.DonguriCBCost);
  RNCostLabel.Caption := GikoSys.Setting.DonguriRNCost + ' どんぐり';
  TRCostLabel.Caption := GikoSys.Setting.DonguriTRCost + ' どんぐり';

	mode := GikoSys.DonguriSys.BuildMode;
  if mode <> '' then
  	PanelTop.Caption := mode;

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
	LabelPeriod.Caption := ' ';
	EditName.Text := ' ';
	EditID.Text := ' ';
	EditLevel.Text := ' ';
  ExplorPanel.Caption := ' ';
  MiningPanel.Caption := ' ';
  WoodctPanel.Caption := ' ';
  WeaponPanel.Caption := ' ';
  ArmorcPanel.Caption := ' ';

	for i := 0 to Integer(idxStcCount) - 1 do
	  StatisticsGrid.Cells[1, i] := '';
	for i := 0 to Integer(idxRowCount) - 1 do
	  InfoGrid.Cells[1, i] := '';

  ExprProgressBar.Position := 0;
  TimeProgressBar.Position := 0;
  ExplorProgressBar.Position := 0;
  MiningProgressBar.Position := 0;
  WoodctProgressBar.Position := 0;
  WeaponProgressBar.Position := 0;
  ArmorcProgressBar.Position := 0;
  ExprValLabel.Caption := ' ';
  TimeValLabel.Caption := ' ';
  ExplorValLabel.Caption := ' ';
  MiningValLabel.Caption := ' ';
  WoodctValLabel.Caption := ' ';
  WeaponValLabel.Caption := ' ';
  ArmorcValLabel.Caption := ' ';
end;

procedure TDonguriForm.ShowRoot;
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Root(res) then
		SetHomeInfo(res)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.SetHomeInfo(res: String);
const
	CAP_MSG: String = 'どんぐりシステム';
var
	home: TDonguriHome;
begin
	try

  	if (res <> '') and (IsRootPage(res) = False) then begin
      if Pos('<html', res) < 1 then
        MsgBox(Handle, TrimTag(res), CAP_MSG, MB_OK or MB_ICONWARNING)
      else
        MsgBox(Handle, 'どんぐりシステムのページ解析に失敗しました', CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

  	ClearInfoValue;

    home := GikoSys.DonguriSys.Home;

    FHunter             := home.Hunter;
		ModePanel.Caption   := home.UserMode;
		EditName.Text       := home.UserName;
		EditID.Text         := home.UserID;
		EditLevel.Text      := home.Level;
		LabelPeriod.Caption := home.Period;
    // 経験値
		ExprProgressBar.Position := home.RateExpr;
		ExprValLabel.Caption     := IntToStr(home.RateExpr);
  	// 経過時間
		TimeProgressBar.Position := home.RatePrgr;
		TimeValLabel.Caption     := IntToStr(home.RatePrgr);
    // 探検
		SetSkillInfo(home.Explor, home.RateExplr, home.SelExplr, ExplorPanel, ExplorProgressBar, ExplorValLabel);
  	// 採掘
		SetSkillInfo(home.Mining, home.RateMnng,  home.SelMnng,  MiningPanel, MiningProgressBar, MiningValLabel);
  	// 木こり
		SetSkillInfo(home.Woodct, home.RateWdct,  home.SelWdct,  WoodctPanel, WoodctProgressBar, WoodctValLabel);
  	// 武器製作
		SetSkillInfo(home.Weapon, home.RateWpn,   home.SelWpn,   WeaponPanel, WeaponProgressBar, WeaponValLabel);
  	// 防具製作
		SetSkillInfo(home.Armorc, home.RateArmr,  home.SelArmr,  ArmorcPanel, ArmorcProgressBar, ArmorcValLabel);

    // 統計
		StatisticsGrid.Cells[1, Integer(idxCannon)] := home.SttCannon;
		StatisticsGrid.Cells[1, Integer(idxFight)]  := home.SttFight;
    // 保管庫
    InfoGrid.Cells[0, Integer(idxDonguri)]  := home.AcornTitle;
    InfoGrid.Cells[1, Integer(idxDonguri)]  := home.Acorn;
		InfoGrid.Cells[1, Integer(idxNumWood)]  := IntToStr(home.Wood);
    InfoGrid.Cells[1, Integer(idxNumIron)]  := IntToStr(home.Iron);
    InfoGrid.Cells[1, Integer(idxIronKey)]  := IntToStr(home.IronKey);
    InfoGrid.Cells[1, Integer(idxMarimo)]   := IntToStr(home.Marimo);
    InfoGrid.Cells[1, Integer(idxWdCnBall)] := IntToStr(home.WoodCB);
    InfoGrid.Cells[1, Integer(idxIrCnBall)] := IntToStr(home.IronCB);

    // 自動ログイン
    AutoLoginCheckBox.Tag := 1;
		AutoLoginCheckBox.Checked := (home.AutoLogin = atlOn);
		AutoLoginCheckBox.Enabled := (not FHunter) and (home.AutoLogin <> atlUnknown);
    AutoLoginLabel.Visible := FHunter;
    case home.AutoLogin of
    atlOn:  LoginPnlButton.Hint := '自動ログイン設定：ON';
    atlOff: LoginPnlButton.Hint := '自動ログイン設定：OFF';
    else    LoginPnlButton.Hint := '自動ログイン設定：不明';
    end;
    LoginPnlButton.ShowHint := True;
    AutoLoginCheckBox.Tag := 0;

    if home.Error <> '' then
      MsgBox(Handle, home.Error, CAP_MSG, MB_OK or MB_ICONERROR);
  except
  end;
end;

procedure TDonguriForm.SetSkillInfo(val: Integer; rate: Integer; sel: Boolean;
																		panel: TPanel; prgbar: TProgressBar; prglbl: TLabel);
begin
	if sel then
		panel.Tag := 1
  else
		panel.Tag := 0;
  panel.ShowHint := sel;
  panel.Caption := IntToStr(val);
  prgbar.Position := rate;
  prglbl.Caption := IntToStr(rate);

  SetSkillPanelColor(panel);
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

  if GikoSys.DonguriSys.Auth(res) then
		SetHomeInfo(res)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.AutoLoginCheckBoxClick(Sender: TObject);
var
  res: String;
begin
	if AutoLoginCheckBox.Tag <> 0 then
  	Exit;
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.ToggleAutoLogin(res) then
  	SetHomeInfo(res)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.LabelLinkClick(Sender: TObject);
var
	url: String;
begin
	try
    if Sender is TLabel then begin
    	url := TLabel(Sender).Caption;
      if url <> '' then
		  	GikoSys.OpenBrowser(url, gbtAuto);
    end;
  except
  	on e: Exception do
    	MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
  end;
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

function TDonguriForm.atoi(str: String): Integer;
var
  num, code, i: Integer;
begin
	num := 0;
	for i := 1 to Length(str) do begin
  	code := Ord(str[i]);
    if (code and $F0) <> $30 then
    	Break;
    num := (num * 10) + (code and $0F);
  end;
	Result := num;
end;

function TDonguriForm.NumComp(text1, text2: String): Integer;
begin
	Result := atoi(text1) - atoi(text2);
end;

procedure TDonguriForm.ListViewWeaponColumnClick(Sender: TObject;
  Column: TListColumn);
begin
	if FWpnSortIdx = Column.Index then
		FWpnSortAsc := not FWpnSortAsc
  else begin
		FWpnSortIdx := Column.Index;
		FWpnSortAsc := True;
  end;
	ListViewWeapon.SortType := stNone;
	ListViewWeapon.SortType := stData;
end;

procedure TDonguriForm.ListViewWeaponCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  text1, text2: String;
  typ: TColumnType;
begin
	if (FWpnSortIdx > 0) and (FWpnSortIdx <= Item1.SubItems.Count) then begin
  	text1 := Item1.SubItems.Strings[FWpnSortIdx - 1];
  	text2 := Item2.SubItems.Strings[FWpnSortIdx - 1];
  end else begin
    text1 := Item1.Caption;
    text2 := Item2.Caption;
  end;

	if (FWpnSortIdx >= Low(COL_TYPE_WPN)) and (FWpnSortIdx <= High(COL_TYPE_WPN)) then
    typ := COL_TYPE_WPN[FWpnSortIdx]
  else
  	typ := ctString;

	if typ = ctInteger then
  	Compare := NumComp(text1, text2)
  else
  	Compare := AnsiCompareStr(text1, text2);

  if not FWpnSortAsc then
  	Compare := Compare * -1;
end;

procedure TDonguriForm.ListViewArmorColumnClick(Sender: TObject;
  Column: TListColumn);
begin
	if FArmSortIdx = Column.Index then
  	FArmSortAsc := not FArmSortAsc
  else begin
		FArmSortIdx := Column.Index;
  	FArmSortAsc := True;
  end;
	ListViewArmor.SortType := stNone;
	ListViewArmor.SortType := stData;
end;

procedure TDonguriForm.ListViewArmorCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  text1, text2: String;
  typ: TColumnType;
begin
	if (FArmSortIdx > 0) and (FArmSortIdx <= Item1.SubItems.Count) then begin
  	text1 := Item1.SubItems.Strings[FArmSortIdx - 1];
  	text2 := Item2.SubItems.Strings[FArmSortIdx - 1];
  end else begin
    text1 := Item1.Caption;
    text2 := Item2.Caption;
  end;

	if (FArmSortIdx >= Low(COL_TYPE_ARM)) and (FArmSortIdx <= High(COL_TYPE_ARM)) then
    typ := COL_TYPE_ARM[FArmSortIdx]
  else
  	typ := ctString;

	if typ = ctInteger then
  	Compare := NumComp(text1, text2)
  else
  	Compare := AnsiCompareStr(text1, text2);

  if not FArmSortAsc then
  	Compare := Compare * -1;
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
const
  CAP_MSG: String = 'どんぐりシステム';
var
  hnt: Boolean;
  grd: Boolean;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  hnt := (GikoSys.Setting.UserID <> '') and (GikoSys.Setting.Password <> '');
  grd := (GikoSys.Setting.DonguriMail <> '') and (GikoSys.Setting.DonguriPwd <> '');

	if (hnt = False) and (grd = False) then begin
  	Login;
    Exit;
  end;

  MItemHntLogin.Enabled := hnt;
  MItemGrdLogin.Enabled := grd;

  PopupMenuLogin.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TDonguriForm.MItemGrdLoginClick(Sender: TObject);
begin
  MailLogin(GikoSys.Setting.DonguriMail, GikoSys.Setting.DonguriPwd);
end;

procedure TDonguriForm.MItemHntLoginClick(Sender: TObject);
begin
  MailLogin(GikoSys.Setting.UserID, GikoSys.Setting.Password);
end;

procedure TDonguriForm.MItemLoginClick(Sender: TObject);
begin
	Login;
end;

procedure TDonguriForm.Login;
const
  CAP_MSG: String = 'どんぐりシステム';
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Login(res) then begin
		SetHomeInfo(res);
    MsgBox(Handle, 'ログインしました。', CAP_MSG, MB_OK or MB_ICONINFORMATION);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.MailLogin(mail, pwd: String);
const
  CAP_MSG: String = 'どんぐりシステム';
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.MailLogin(mail, pwd, res) then begin
  	SetHomeInfo(res);
    MsgBox(Handle, 'ログインしました。', CAP_MSG, MB_OK or MB_ICONINFORMATION);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.LogoutPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'どんぐりシステム';
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Logout(res) then begin
  	SetHomeInfo(res);
	  MsgBox(Handle, 'ログアウトしました。', CAP_MSG, MB_OK or MB_ICONINFORMATION);
  end else
  	ShowHttpError;
end;

procedure TDonguriForm.NewRegPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'どんぐりシステム';
var
  res: String;
  dlg: TDonguriRegForm;
begin
	try
    if GikoSys.DonguriSys.Processing then
      Exit;

    if GikoSys.DonguriSys.RegisterPage(res) then begin
      if Pos('<html', res) < 1 then
        MsgBox(Handle, res, CAP_MSG, MB_OK or MB_ICONINFORMATION)
      else if (Pos('<h1>警備員登録サービス</h1>', res) > 0) and (Pos('<input type="submit"', res) > 0) then begin
			  dlg := TDonguriRegForm.Create(Self);
        try
          dlg.ShowModal;
        finally
          dlg.Free;
        end;
      end else
	      MsgBox(Handle, '警備員登録のページ解析に失敗しました',
								CAP_MSG, MB_OK or MB_ICONERROR);
    end else
      ShowHttpError;
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriForm.ExplorPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.Exploration(res) then
  	SetHomeInfo(res)
  else
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

  if GikoSys.DonguriSys.Mining(res) then
  	SetHomeInfo(res)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.WoodctPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.WoodCutting(res) then
  	SetHomeInfo(res)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.WeaponPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.WeaponCraft(res) then
  	SetHomeInfo(res)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.ArmorcPnlButtonClick(Sender: TObject);
var
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.ArmorCraft(res) then
  	SetHomeInfo(res)
  else
  	ShowHttpError;
end;

//=================

// 呼び名変更
procedure TDonguriForm.RenamePnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'ハンターネーム変更';
  // リネームページから取得できなかった場合の警告メッセージ　https://donguri.5ch.net/rename から取得 2024/05/29
  WRN_MSG: String = '・特定の人種、国籍、宗教、性差別等に対する誹謗中傷的な名前' + #10 +
										'・他人に対する脅迫、暴言、誹謗中傷と判断される名前' + #10 +
										'名前変更を使ってこれらに該当する名前にしたものやその報告があった場合は罰を受けることがあります。' + #10;
var
  res: String;
  newName: String;
  tmp: String;
  idx: Integer;
  msg: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  try
    newName := NewNameEdit.Text;
    if newName = '' then begin
			MsgBox(Handle, '新しいハンターネームを指定してください。', CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

    // リネームページから警告メッセージを取得
    if GikoSys.DonguriSys.RenamePage(res) = False then begin
      ShowHttpError;
      Exit;
    end;

    msg := 'ハンターネームを変更します。' + #10 +
           '　新しいハンターネーム：' + newName + #10;
  	idx := 0;

    if DonguriSystem.Extract('<form', '</form>', res, tmp) then begin
      idx := Pos('お知らせ：', tmp);
      if idx > 0 then begin
        Delete(tmp, 1, idx - 1);
        tmp := ReplaceString(tmp, '</small>', #10);
        tmp := ReplaceString(tmp, '<br>', #10);
        msg := msg + #10 + TrimTag(tmp);
      end;
    end;
    if idx < 1 then
      msg := msg + '　手数料どんぐり額：' + GikoSys.Setting.DonguriRNCost + 'どんぐり' + #10#10 +
             WRN_MSG;

    if MsgBox(Handle, msg + #10 + '実行してよろしいですか？',
                  CAP_MSG, MB_OKCANCEL or MB_ICONQUESTION) <> IDOK then
        Exit;

    if GikoSys.DonguriSys.Rename(newName, res) then
    	SetHomeInfo(res)
    else
      ShowHttpError;
  except
  	on e: Exception do
    	MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
  end;
end;

// 復活
procedure TDonguriForm.ResurrectPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = '復活サービス';
var
  res: String;
  cancel: Boolean;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	try
    if GikoSys.DonguriSys.Resurrect(res, cancel, Handle) then begin
      MsgBox(Handle, TrimTag(res), CAP_MSG, MB_OK or MB_ICONINFORMATION);
      ShowRoot;
    end else if cancel = False then begin
      if res <> '' then
        MsgBox(Handle, TrimTag(res), CAP_MSG, MB_OK or MB_ICONERROR)
      else
        ShowHttpError;
    end;
  except
  	on e: Exception do
    	MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
  end;
end;

procedure TDonguriForm.RootPnlButtonClick(Sender: TObject);
begin
	ShowRoot;
end;

// ドングリ転送
procedure TDonguriForm.TransferPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'どんぐり転送';
var
  res: String;
  rid: String;
  amn: String;
  chkAmn: Double;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  try
    rid := RIDEdit.Text;
    if rid = '' then begin
			MsgBox(Handle, '受取人IDを指定してください。', CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

    amn := TAmountEdit.Text;
    if amn = '' then begin
			MsgBox(Handle, '転送するどんぐり額を指定してください。', CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

    if TryStrToFloat(amn, chkAmn) = False then begin
			MsgBox(Handle, '転送するどんぐり額が正しくありません。' + #10 +
      							 '実数（小数点数）で指定してください。'	, CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

		if MsgBox(Handle, 'どんぐり転送を実行します。' + #10 +
    									'　受取人ID：' + rid + #10 +
                      '　転送どんぐり額：' + amn + #10 +
                      '　手数料どんぐり額：' + GikoSys.Setting.DonguriTRCost + #10 +
                      'どんぐり転送を後から取り消すことはできません。' + #10 +
                      '実行してよろしいですか？',
	    						CAP_MSG, MB_OKCANCEL or MB_ICONQUESTION) <> IDOK then
    	Exit;

	  if GikoSys.DonguriSys.Transfer(rid, amn, res) then
    	SetHomeInfo(res)
    else
      ShowHttpError;
  except
  	on e: Exception do
    	MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
  end;
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
        PageControlItemBag.OwnerDraw := False;

        Color := clBtnFace;
        SetColors(PanelTop,        clBtnFace, clWindowText);

			  SetColors(PanelHome,       clBtnFace, clWindowText);
        SetColors(ModePanel,       clWindow,  clWindowText);
			  SetColors(EditName,        clWindow,  clWindowText);
			  SetColors(EditID,          clWindow,  clWindowText);
			  SetColors(EditLevel,       clWindow,  clWindowText);
        SetColors(StatisticsGrid,  clWindow,  clWindowText);
			  SetColors(InfoGrid,        clWindow,  clWindowText);
        SetColors(ExplorPanel,     clWindow,  clWindowText);
        SetColors(MiningPanel,     clWindow,  clWindowText);
        SetColors(WoodctPanel,     clWindow,  clWindowText);
        SetColors(WeaponPanel,     clWindow,  clWindowText);
        SetColors(ArmorcPanel,     clWindow,  clWindowText);

        TabSheetService.Font.Color := clWindowText;
			  SetColors(PanelService,        clBtnFace, clWindowText);
        SetColors(KYAmountComboBox,    clWindow,  clWindowText);
			  SetColors(CBAmountComboBox,    clWindow,  clWindowText);
        SetColors(NewNameEdit,         clWindow,  clWindowText);
        SetColors(RIDEdit,             clWindow,  clWindowText);
        SetColors(TAmountEdit,         clWindow,  clWindowText);

        TabSheetChest.Font.Color := clWindowText;
        SetColors(BagTopPanel,         clBtnFace, clWindowText);
        SetColors(WeaponTopPanel,      clBtnFace, clWindowText);
        SetColors(ArmorTopPanel,       clBtnFace, clWindowText);
        SetColors(ListViewWeaponUsing, clWindow,  clWindowText);
        SetColors(ListViewArmorUsing,  clWindow,  clWindowText);
        SetColors(ListViewWeapon,      clWindow,  clWindowText);
        SetColors(ListViewArmor,       clWindow,  clWindowText);
      	SetColors(UsingPanel,          clBtnFace, clWindowText);

      	TabSheetSetting.Font.Color := clWindowText;

        TabSheetLink.Font.Color := clWindowText;
      	SetColors(LinkPanel,           clBtnFace, clWindowText);
        LabelHomeLink.Font.Color   := COL_LGHT_LINK;
        LabelFaqLink.Font.Color    := COL_LGHT_LINK;
        LabelApiLink.Font.Color    := COL_LGHT_LINK;
        LabelApiLink.Font.Color    := COL_LGHT_LINK;
        LabelRankLink.Font.Color   := COL_LGHT_LINK;
        LabelCLogLink.Font.Color   := COL_LGHT_LINK;
        LabelFLogLink.Font.Color   := COL_LGHT_LINK;
        LabelItemWLink.Font.Color  := COL_LGHT_LINK;
        LabelAlertLink.Font.Color  := COL_LGHT_LINK;
        LabelShopLink.Font.Color   := COL_LGHT_LINK;
        LabelUpliftLink.Font.Color := COL_LGHT_LINK;

      end;
      1: begin
        PageControl.OwnerDraw := True;
        PageControlItemBag.OwnerDraw := True;

        Color := COL_DARK_BKG1;
        SetColors(PanelTop,        COL_DARK_BKG1, COL_DARK_TEXT);

			  SetColors(PanelHome,       COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(ModePanel,       COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(EditName,        COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(EditID,          COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(EditLevel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(StatisticsGrid,  COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(InfoGrid,        COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ExplorPanel,     COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(MiningPanel,     COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(WoodctPanel,     COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(WeaponPanel,     COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ArmorcPanel,     COL_DARK_BKG2, COL_DARK_TEXT);

        TabSheetService.Font.Color := COL_DARK_TEXT;
			  SetColors(PanelService,        COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(KYAmountComboBox,    COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(CBAmountComboBox,    COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(NewNameEdit,         COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(RIDEdit,             COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(TAmountEdit,         COL_DARK_BKG2, COL_DARK_TEXT);

        TabSheetChest.Font.Color := COL_DARK_TEXT;
        SetColors(BagTopPanel,         COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(WeaponTopPanel,      COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(ArmorTopPanel,       COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(ListViewWeaponUsing, COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ListViewArmorUsing,  COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ListViewWeapon,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ListViewArmor,       COL_DARK_BKG2, COL_DARK_TEXT);
      	SetColors(UsingPanel,          COL_DARK_BKG1, COL_DARK_TEXT);

      	TabSheetSetting.Font.Color := COL_DARK_TEXT;

        TabSheetLink.Font.Color := COL_DARK_TEXT;
      	SetColors(LinkPanel,           COL_DARK_BKG1, COL_DARK_TEXT);
        LabelHomeLink.Font.Color   := COL_DARK_LINK;
        LabelFaqLink.Font.Color    := COL_DARK_LINK;
        LabelApiLink.Font.Color    := COL_DARK_LINK;
        LabelApiLink.Font.Color    := COL_DARK_LINK;
        LabelRankLink.Font.Color   := COL_DARK_LINK;
        LabelCLogLink.Font.Color   := COL_DARK_LINK;
        LabelFLogLink.Font.Color   := COL_DARK_LINK;
        LabelItemWLink.Font.Color  := COL_DARK_LINK;
        LabelAlertLink.Font.Color  := COL_DARK_LINK;
        LabelShopLink.Font.Color   := COL_DARK_LINK;
        LabelUpliftLink.Font.Color := COL_DARK_LINK;
      end;
    end;

    SetSkillPanelColor(ExplorPanel);
    SetSkillPanelColor(MiningPanel);
    SetSkillPanelColor(WoodctPanel);
    SetSkillPanelColor(WeaponPanel);
    SetSkillPanelColor(ArmorcPanel);

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
  SetButtonColors(NewRegPnlButton, bkg, txt, dtx);

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
  SetButtonColors(CraftPnlButton,     bkg, txt, dtx);
  SetButtonColors(CraftKYPnlButton,   bkg, txt, dtx);
  SetButtonColors(CraftCBPnlButton,   bkg, txt, dtx);
  SetButtonColors(BagPnlButton,       bkg, txt, dtx);
  SetButtonColors(ChestPnlButton,     bkg, txt, dtx);
  SetButtonColors(ChestB70PnlButton,  bkg, txt, dtx);
end;

procedure TDonguriForm.SetBtnCol(button: TPanel);
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

  button.Color := bkg;
  if button.Enabled then
	  button.Font.Color := txt
  else
	  button.Font.Color := dtx;
end;

procedure TDonguriForm.SetButtonColors(button: TPanel; bkg, txt, dtx: TColor);
begin
  button.Color := bkg;
  if button.Enabled then
	  button.Font.Color := txt
  else
	  button.Font.Color := dtx;
end;

procedure TDonguriForm.SetSkillPanelColor(panel: TPanel);
var
  bkg: TColor;
  txt: TColor;
begin
  if ColorRadioGroup.ItemIndex = 0 then begin
  	if panel.Tag = 1 then
	    bkg := COL_LGHT_SKIL
    else
	    bkg := clWindow;
    txt := clWindowText;
  end else {if ColorRadioGroup.ItemIndex = 1 then} begin
  	if panel.Tag = 1 then
	    bkg := COL_DARK_SKIL
    else
	    bkg := COL_DARK_BKG2;
    txt := COL_DARK_TEXT;
  end;
  panel.Color := bkg;
  panel.Font.Color := txt;
end;

procedure TDonguriForm.PageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
	cpt: String;
begin
  case TabIndex of
    0: cpt := TabSheetHome.Caption;
    1: cpt := TabSheetService.Caption;
    2: cpt := TabSheetChest.Caption;
    3: cpt := TabSheetLink.Caption;
    4: cpt := TabSheetSetting.Caption;
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

function TDonguriForm.GetCmbAmount(cmb: TComboBox): Integer;
begin
	Result := StrToIntDef(Trim(cmb.Text), 0);
end;

// 工作コストチェック
procedure TDonguriForm.CraftPnlButtonClick(Sender: TObject);
var
  res: String;
  tmp: String;
  kyc: Integer;
  cbc: Integer;
  rnc: String;
  trc: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  kyc := -1;
  cbc := -1;

  if GikoSys.DonguriSys.Craft(res) then begin
		if DonguriSystem.Extract('鉄のキーを作るには鉄が', '必要です。', res, tmp) then begin
      kyc := StrToIntDef(tmp, -1);
      if kyc > 0 then begin
				GikoSys.Setting.DonguriKYCost := kyc;
        KYCostLabel.Caption := IntToStr(GikoSys.Setting.DonguriKYCost);
      end;
    end;
		if DonguriSystem.Extract('鉄の大砲の玉を作るには鉄が', '必要です。', res, tmp) then begin
      cbc := StrToIntDef(tmp, -1);
      if cbc > 0 then begin
				GikoSys.Setting.DonguriCBCost := cbc;
        CBCostLabel.Caption := IntToStr(GikoSys.Setting.DonguriCBCost);
      end;
    end;
  end;

	tmp := '';
	res := '';
  if GikoSys.DonguriSys.RenamePage(res) then begin
		if DonguriSystem.Extract('お知らせ：ハンターネーム変更サービスの費用は', 'どんぐりポイントです。', res, tmp) then begin
    	if tmp <> '' then begin
	    	rnc := tmp;
      	GikoSys.Setting.DonguriRNCost := rnc;
        RNCostLabel.Caption := rnc + ' どんぐり';
      end;
    end;
  end;

	tmp := '';
	res := '';
  if GikoSys.DonguriSys.TransferPage(res) then begin
		if DonguriSystem.Extract('注意：どんぐりの転送には', 'どんぐりの手数料がかかります。', res, tmp) then begin
    	if tmp <> '' then begin
	    	trc := tmp;
      	GikoSys.Setting.DonguriTRCost := trc;
        TRCostLabel.Caption := trc + ' どんぐり';
      end;
    end;
  end;

  tmp := 'サービスコスト確認結果' + #10 +
         '　鉄のキー作成：';
  if kyc > 0 then
    tmp := tmp + Format('鉄%d', [kyc])
  else
    tmp := tmp + '確認できませんでした。';
  tmp := tmp + #10 +
         '　鉄の大砲の玉作成：';
  if cbc > 0 then
    tmp := tmp + Format('鉄%d', [cbc])
  else
    tmp := tmp + '確認できませんでした。';
  tmp := tmp + #10 +
         '　ハンターネーム変更：';
  if rnc <> '' then
    tmp := tmp + rnc + 'どんぐり'
  else
    tmp := tmp + '確認できませんでした。';
  tmp := tmp + #10 +
         '　どんぐり転送：';
  if trc <> '' then
    tmp := tmp + trc + 'どんぐり'
  else
    tmp := tmp + '確認できませんでした。';

  MsgBox(Handle, tmp, 'サービスコスト確認', MB_OK or MB_ICONINFORMATION);

end;

procedure TDonguriForm.CBAmountComboBoxChange(Sender: TObject);
var
	amount: Integer;
  iron: Integer;
begin
	try
  	iron := 0;
		amount := GetCmbAmount(CBAmountComboBox);
    if amount > 0 then
      iron := amount * GikoSys.Setting.DonguriCBCost;
  	CBIronLabel.Caption := IntToStr(iron);
  except
  end;
end;

procedure TDonguriForm.CraftCBPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = '鉄の大砲の玉作成';
var
	amount: Integer;
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	amount := GetCmbAmount(CBAmountComboBox);
  if amount < 1 then begin
    MsgBox(Handle, '鉄の大砲の玉の作成数を入力してください。', CAP_MSG,
          	MB_OK or MB_ICONINFORMATION);
    Exit;
  end;

  if MsgBox(Handle, Format('鉄の大砲の玉%dを作成するには鉄%dが必要です。%s作成しますか？',
  												[amount, amount * GikoSys.Setting.DonguriCBCost, #10]),
						CAP_MSG, MB_YESNO or MB_ICONQUESTION) <> IDYES then
  	Exit;

  if GikoSys.DonguriSys.CraftCB(amount, res) then
  	MsgBox(Handle, res, CAP_MSG, MB_OK or MB_ICONINFORMATION)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.KYAmountComboBoxChange(Sender: TObject);
var
	amount: Integer;
  iron: Integer;
begin
	try
  	iron := 0;
		amount := GetCmbAmount(KYAmountComboBox);
    if amount > 0 then
      iron := amount * GikoSys.Setting.DonguriKYCost;
  	KYIronLabel.Caption := IntToStr(iron);
  except
  end;
end;

procedure TDonguriForm.CraftKYPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = '鉄のキー作成';
var
	amount: Integer;
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

		amount := GetCmbAmount(KYAmountComboBox);
  if amount < 1 then begin
    MsgBox(Handle, '鉄のキーの作成数を入力してください。', CAP_MSG,
          	MB_OK or MB_ICONINFORMATION);
    Exit;
  end;

  if MsgBox(Handle, Format('鉄のキー%dを作成するには鉄%dが必要です。%s作成しますか？',
  												[amount, amount * GikoSys.Setting.DonguriKYCost, #10]),
						CAP_MSG, MB_YESNO or MB_ICONQUESTION) <> IDYES then
  	Exit;

  if GikoSys.DonguriSys.CraftKY(amount, res) then
  	MsgBox(Handle, res, CAP_MSG, MB_OK or MB_ICONINFORMATION)
  else
  	ShowHttpError;
end;

procedure TDonguriForm.BagPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'アイテムバッグ';
var
	res: String;
	denied: Boolean;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	denied := False;
  if GikoSys.DonguriSys.Bag(FBag, res, denied) then
    ShowBag
  else if denied then
    MsgBox(Handle, 'アイテムバッグを参照できませんでした。' + #10 +
                   'どんぐりが枯れたかもしれません。' + #10 +
                   'ログインし直してみてください。',
                   CAP_MSG, MB_OK or MB_ICONWARNING)
  else if Pos('<html', res) < 1 then
		MsgBox(Handle, TrimTag(res), CAP_MSG, MB_OK or MB_ICONINFORMATION)
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
const
  CAP_MSG: String = 'アイテムバッグ';
var
	res: String;
	denied: Boolean;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

	if MsgBox(Handle, '木材 1000 をアイテムスロット 10 に交換します。' + #10 +
  									'よろしいですか？', CAP_MSG,
                    MB_OKCANCEL or MB_ICONQUESTION) <> IDOK then
  	Exit;

  if GikoSys.DonguriSys.AddSlots(res) then begin
    if (Pos('<html', res) < 1) then begin
    	MsgBox(Handle, TrimTag(res), CAP_MSG, MB_OK or MB_ICONINFORMATION);

      // アイテムバッグ再表示
      res := '';
      denied := False;
      if GikoSys.DonguriSys.Bag(FBag, res, denied) then
        ShowBag
      else if (Pos('<html', res) < 1) then
	    	MsgBox(Handle, TrimTag(res), CAP_MSG, MB_OK or MB_ICONINFORMATION)
			else
		  	ShowHttpError;

  	end else	// 状況不明？？？
    	MsgBox(Handle, 'アイテムバッグ表示更新を行ってください。', CAP_MSG,
      							MB_OK or MB_ICONINFORMATION);
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

procedure TDonguriForm.ChestB70PnlButtonClick(Sender: TObject);
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;
	OpenChest(100, '大型の宝箱');
end;

procedure TDonguriForm.ChestPnlButtonClick(Sender: TObject);
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;
	OpenChest(10, '宝箱');
end;

{ 宝箱を開く }
procedure TDonguriForm.OpenChest(amount: Integer; chestName: String);
const
  CAP_MSG: String = 'アイテムバッグ';
var
  res: String;
  key: Integer;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	if MsgBox(Handle, Format('鉄のキーを%d消費します。%s%sを開けますか？', [amount, #10, chestName]),
  					CAP_MSG, MB_YESNO or MB_ICONQUESTION) <> IDYES then
    Exit;

  if GikoSys.DonguriSys.ChestOpen(amount, FBag, res) then
		ShowBag
  else if res <> ''then begin
  	if Pos('<html', res) < 1 then begin
			MsgBox(Handle, res, CAP_MSG, MB_OK or MB_ICONWARNING);
			Exit;
    end;

    if IsRootPage(res) then
    	SetHomeInfo(res)
    else
    	ShowRoot;
    key := GikoSys.DonguriSys.Home.IronKey;
    if (key >= 0) and (key < amount) then begin
      MsgBox(Handle, '鉄のキーが不足しています。', CAP_MSG, MB_OK or MB_ICONWARNING);
      Exit;
    end;

		MsgBox(Handle, chestName + 'を開くことができませんでした。', CAP_MSG, MB_OK or MB_ICONWARNING);
  end else
  	ShowHttpError;
end;


procedure TDonguriForm.RecycleAllPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'アイテムバッグ';
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	if MsgBox(Handle, '解体した装備を元に戻すことはできません。' + #10 +
                    'ロックされていない装備をすべて解体しますか？',
  					CAP_MSG, MB_YESNO or MB_ICONQUESTION) <> IDYES then
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
const
  CAP_MSG: String = 'アイテムバッグ';
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
								CAP_MSG, MB_OK or MB_ICONERROR);
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
const
  CAP_MSG: String = 'アイテムバッグ';
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
								CAP_MSG, MB_OK or MB_ICONERROR);
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
const
  CAP_MSG: String = 'アイテムバッグ';
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
								CAP_MSG, MB_OK or MB_ICONERROR);
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
  SetBtnCol(TPanel(Sender));
end;

procedure TDonguriForm.UseWPnlButtonClick(Sender: TObject);
begin
	UseItem(ListViewWeapon);
  SetBtnCol(TPanel(Sender));
end;

procedure TDonguriForm.UseItem(list: TListView);
const
  CAP_MSG: String = 'アイテムバッグ';
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
                    CAP_MSG, MB_OK or MB_ICONERROR);
        	Exit;
        end;
      	itemNo := TDonguriItem(item.Data).ItemNo;
			end;
    end;

		if itemNo = '' then begin
      MsgBox(Handle, '装備する行にチェックを付けてください。',
								CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.Equip(itemNo, FBag) then
      ShowBag
    else
      ShowHttpError;
  finally
  end;
end;


procedure TDonguriForm.LabelLinkContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
	try
    if Sender is TLabel then
      FLink := TLabel(Sender).Caption
    else
      FLink := '';
  except
  	on e: Exception do
    	MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
  end;
end;

procedure TDonguriForm.ManuItemCopyClick(Sender: TObject);
begin
	try
    if FLink <> '' then
      Clipboard.AsText := FLink;
  except
  	on e: Exception do
    	MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
  end;
end;


procedure TDonguriForm.ManuItemOpenClick(Sender: TObject);
begin
	try
    if FLink <> '' then
			GikoSys.OpenBrowser(FLink, gbtAuto);
  except
  	on e: Exception do
    	MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
  end;
end;

procedure TDonguriForm.UpdateHomeInfo;
begin
	SetHomeInfo('');
end;

end.
