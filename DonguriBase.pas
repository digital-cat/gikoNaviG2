unit DonguriBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Jpeg, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, StrUtils, ComCtrls, Buttons, DonguriSystem,
  ImgList, Menus, Clipbrd, CommCtrl;

type
  TColumnType = (ctString, ctInteger, ctIntStr);

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
    PageControlItemBag: TPageControl;
    TabSheetUsing: TTabSheet;
    TabSheetWeapon: TTabSheet;
    TabSheetArmor: TTabSheet;
    BagTopPanel: TPanel;
    UsingWeaponLabel: TLabel;
    RemWeaponPnlButton: TPanel;
    UsingArmorLabel: TLabel;
    RemArmorPnlButton: TPanel;
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
    ModWPnlButton: TPanel;
    ModAPnlButton: TPanel;
    ModAGrid1: TStringGrid;
    ModBackAPnlButton: TPanel;
    Label26: TLabel;
    DefMinCurPanel: TPanel;
    Label35: TLabel;
    DefMinNewPanel: TPanel;
    Label36: TLabel;
    DefMinMrmPanel: TPanel;
    ModDefMinPnlButton: TPanel;
    Label37: TLabel;
    DefMaxCurPanel: TPanel;
    Label38: TLabel;
    DefMaxNewPanel: TPanel;
    Label39: TLabel;
    DefMaxMrmPanel: TPanel;
    ModDefMaxPnlButton: TPanel;
    Label40: TLabel;
    WeightCurPanel: TPanel;
    Label41: TLabel;
    WeightNewPanel: TPanel;
    Label42: TLabel;
    WeightMrmPanel: TPanel;
    ModWeightPnlButton: TPanel;
    Label43: TLabel;
    CritACurPanel: TPanel;
    Label44: TLabel;
    CritANewPanel: TPanel;
    Label45: TLabel;
    CritAMrmPanel: TPanel;
    ModCritAPnlButton: TPanel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    ModWGrid1: TStringGrid;
    ModBackWPnlButton: TPanel;
    DmgMinCurPanel: TPanel;
    DmgMinNewPanel: TPanel;
    DmgMinMrmPanel: TPanel;
    ModDmgMinPnlButton: TPanel;
    DmgMaxCurPanel: TPanel;
    DmgMaxNewPanel: TPanel;
    DmgMaxMrmPanel: TPanel;
    ModDmgMaxPnlButton: TPanel;
    SpeedCurPanel: TPanel;
    SpeedNewPanel: TPanel;
    SpeedMrmPanel: TPanel;
    ModSpeedPnlButton: TPanel;
    CritWCurPanel: TPanel;
    CritWNewPanel: TPanel;
    CritWMrmPanel: TPanel;
    ModCritWPnlButton: TPanel;
    ModWPanel: TPanel;
    ModAPanel: TPanel;
    Label59: TLabel;
    ModABasePanel: TPanel;
    Panel6: TPanel;
    ModWBasePanel: TPanel;
    Panel7: TPanel;
    TabSheetModW: TTabSheet;
    TabSheetModA: TTabSheet;
    ModWMarimoPanel: TPanel;
    Label58: TLabel;
    ModAMarimoPanel: TPanel;
    ModAImage: TImage;
    ModWImage: TImage;
    GridWeaponUsing1: TStringGrid;
    GridWeaponUsing2: TStringGrid;
    GridWeaponUsing3: TStringGrid;
    GridArmorUsing3: TStringGrid;
    GridArmorUsing2: TStringGrid;
    GridArmorUsing1: TStringGrid;
    ModWGrid2: TStringGrid;
    ModWGrid3: TStringGrid;
    Label60: TLabel;
    CritWDwnPanel: TPanel;
    CritWDMrPanel: TPanel;
    DwnCritWPnlButton: TPanel;
    Label61: TLabel;
    DmgMinDwnPanel: TPanel;
    DmgMinDMrPanel: TPanel;
    DwnDmgMinPnlButton: TPanel;
    Label62: TLabel;
    DmgMaxDwnPanel: TPanel;
    DmgMaxDMrPanel: TPanel;
    DwnDmgMaxPnlButton: TPanel;
    DwnSpeedPnlButton: TPanel;
    SpeedDMrPanel: TPanel;
    SpeedDwnPanel: TPanel;
    Label63: TLabel;
    ModAGrid3: TStringGrid;
    ModAGrid2: TStringGrid;
    Label64: TLabel;
    DefMinDwnPanel: TPanel;
    DefMinDMrPanel: TPanel;
    DwnDefMinPnlButton: TPanel;
    Label65: TLabel;
    DefMaxDwnPanel: TPanel;
    DefMaxDMrPanel: TPanel;
    DwnDefMaxPnlButton: TPanel;
    Label66: TLabel;
    WeightDwnPanel: TPanel;
    WeightDMrPanel: TPanel;
    DwnWeightPnlButton: TPanel;
    Label67: TLabel;
    CritADwnPanel: TPanel;
    CritADMrPanel: TPanel;
    DwnCritAPnlButton: TPanel;
    ModUseWPnlButton: TPanel;
    ModUseAPnlButton: TPanel;
    ReCreateIndyCheckBox: TCheckBox;
    Label68: TLabel;
    Label69: TLabel;
    LabelArenaLink: TLabel;
    LinkScrollBox: TScrollBox;
    Label70: TLabel;
    LabelALogLink: TLabel;
    LabelDummy: TLabel;
    CraftRPGroupBox: TGroupBox;
    Label71: TLabel;
    RPAmountComboBox: TComboBox;
    Label72: TLabel;
    RPKeyLabel: TLabel;
    Label74: TLabel;
    RPCostLabel: TLabel;
    CraftRPPnlButton: TPanel;
    DspTypeRadioGroup: TRadioGroup;
    SpeedButtonReload: TSpeedButton;
    TimerReload: TTimer;
    ImeDontCareCheckBox: TCheckBox;
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
    procedure ModWPnlButtonClick(Sender: TObject);
    procedure ModAPnlButtonClick(Sender: TObject);
    procedure ModBackAPnlButtonClick(Sender: TObject);
    procedure ModDefMinPnlButtonClick(Sender: TObject);
    procedure ModDefMaxPnlButtonClick(Sender: TObject);
    procedure ModWeightPnlButtonClick(Sender: TObject);
    procedure ModCritAPnlButtonClick(Sender: TObject);
    procedure ModBackWPnlButtonClick(Sender: TObject);
    procedure ModDmgMinPnlButtonClick(Sender: TObject);
    procedure ModDmgMaxPnlButtonClick(Sender: TObject);
    procedure ModSpeedPnlButtonClick(Sender: TObject);
    procedure ModCritWPnlButtonClick(Sender: TObject);
    procedure DrawGridCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DrawModGridCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DwnDmgMinPnlButtonClick(Sender: TObject);
    procedure DwnDmgMaxPnlButtonClick(Sender: TObject);
    procedure DwnSpeedPnlButtonClick(Sender: TObject);
    procedure DwnCritWPnlButtonClick(Sender: TObject);
    procedure DwnDefMinPnlButtonClick(Sender: TObject);
    procedure DwnDefMaxPnlButtonClick(Sender: TObject);
    procedure DwnWeightPnlButtonClick(Sender: TObject);
    procedure DwnCritAPnlButtonClick(Sender: TObject);
    procedure ModUseWPnlButtonClick(Sender: TObject);
    procedure ModUseAPnlButtonClick(Sender: TObject);
    procedure ReCreateIndyCheckBoxClick(Sender: TObject);
    procedure RPAmountComboBoxChange(Sender: TObject);
    procedure CraftRPPnlButtonClick(Sender: TObject);
    procedure DspTypeRadioGroupClick(Sender: TObject);
    procedure TimerReloadTimer(Sender: TObject);
    procedure SpeedButtonReloadClick(Sender: TObject);
    procedure ImeDontCareCheckBoxClick(Sender: TObject);
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
    function atoi(str: String; var numLen: Integer): Integer;
    function NumStrComp(text1, text2: String): Integer;
    procedure Login;
    procedure MailLogin(mail, pwd: String);
    procedure ShowModViewW(res: String);
    procedure ModWeapon(modType: TModifyWeapon);
    procedure ShowModViewA(res: String);
    procedure ModArmor(modType: TModifyArmor);
    function SetImageFromURL(image: TImage; url: String): Boolean;
    procedure EnableModButton(newVal, cost, button: TPanel);
    procedure SwitchItemTab(showTab: TTabSheet);
    procedure SetImeMode;
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
    idxHP        = 7,
    idxRowCount  = 8);

const
	COL_STSC: array [0..1] of string = (
    '　どんぐり大砲',
    '　大乱闘'
  );
  COL_NAME: array [0..7] of string  = (
    '　どんぐり残高',
  	'　木材',
    '　鉄',
    '　鉄のキー',
    '　マリモ',
    '　木製の大砲の玉',
    '　鉄の大砲の玉',
    '　HP'
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
  	ctIntStr,//ctString,
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
  	ctIntStr,//ctString,
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
  URL_ARENA : String = 'https://donguri.5ch.net/arena';
  URL_ALOGS : String = 'https://donguri.5ch.net/arenalogs';

//  CAP_USING_TOP: String = 'ﾛｯｸ／ﾚｱﾘﾃｨ';
  CAP_USING_TOP: String = 'レアリティ';

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
  colw: Integer;
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
  ImeDontCareCheckBox.Checked := GikoSys.Setting.DonguriImeDontCare;
  SetImeMode;
	SetColor;
  CannonMenuCheckBox.Checked := GikoSys.Setting.DonguriMenuTop;
  ReCreateIndyCheckBox.Checked := GikoSys.Setting.DonguriReCreateIndy;

  ClearInfoValue;

  hintText := 'レアリティ出現率';
  for i := Low(RARITY_TABLE) to High(RARITY_TABLE) do
    hintText := hintText + #10 + Format(' %s : %s', [RARITY_TABLE[i, 0], RARITY_TABLE[i, 1]]);
  ListViewWeapon.Hint := hintText;
  ListViewWeapon.ShowHint := True;
  ListViewArmor.Hint := hintText;
  ListViewArmor.ShowHint := True;

  GridWeaponUsing1.ColWidths[1] := GridWeaponUsing1.Width - GridWeaponUsing1.DefaultColWidth;
	colw := (GridWeaponUsing2.Width - GridWeaponUsing2.DefaultColWidth) div 2;
  GridWeaponUsing2.ColWidths[1] := colw;
  GridWeaponUsing2.ColWidths[2] := colw;
  GridWeaponUsing3.ColWidths[1] := colw;
  GridWeaponUsing3.ColWidths[2] := colw;
  GridWeaponUsing1.Selection := sel;
  GridWeaponUsing2.Selection := sel;
  GridWeaponUsing3.Selection := sel;
  GridWeaponUsing1.Cells[0, 0] := CAP_USING_TOP;
  GridWeaponUsing1.Cells[1, 0] := '名称';
  GridWeaponUsing1.Cells[2, 0] := 'ロック状態';	// 非表示セル
  GridWeaponUsing2.Cells[0, 0] := 'ATK';
  GridWeaponUsing2.Cells[1, 0] := 'SPD';
  GridWeaponUsing2.Cells[2, 0] := 'CRIT';
  GridWeaponUsing3.Cells[0, 0] := 'ELEM';
  GridWeaponUsing3.Cells[1, 0] := 'MOD';
  GridWeaponUsing3.Cells[2, 0] := 'マリモ';

  GridArmorUsing1.ColWidths[1] := GridArmorUsing1.Width - GridArmorUsing1.DefaultColWidth;
	colw := Integer(GridArmorUsing2.Width - GridArmorUsing2.DefaultColWidth) div 2;
  GridArmorUsing2.ColWidths[1] := colw;
  GridArmorUsing2.ColWidths[2] := colw;
  GridArmorUsing3.ColWidths[1] := colw;
  GridArmorUsing3.ColWidths[2] := colw;
  GridArmorUsing1.Selection := sel;
  GridArmorUsing2.Selection := sel;
  GridArmorUsing3.Selection := sel;
  GridArmorUsing1.Cells[0, 0] := CAP_USING_TOP;
  GridArmorUsing1.Cells[1, 0] := '名称';
  GridArmorUsing1.Cells[2, 0] := 'ロック状態';	// 非表示セル
  GridArmorUsing2.Cells[0, 0] := 'DEF';
  GridArmorUsing2.Cells[1, 0] := 'WT.';
  GridArmorUsing2.Cells[2, 0] := 'CRIT';
  GridArmorUsing3.Cells[0, 0] := 'ELEM';
  GridArmorUsing3.Cells[1, 0] := 'MOD';
  GridArmorUsing3.Cells[2, 0] := 'マリモ';

  ModWGrid1.ColWidths[1] := 130;
  ModWGrid1.Selection := sel;
  ModWGrid2.ColWidths[1] := 60;
  ModWGrid2.Selection := sel;
  ModWGrid3.ColWidths[1] := 80;
  ModWGrid3.Selection := sel;
  ModAGrid1.ColWidths[1] := 130;
  ModAGrid1.Selection := sel;
  ModAGrid2.ColWidths[1] := 60;
  ModAGrid2.Selection := sel;
  ModAGrid3.ColWidths[1] := 80;
  ModAGrid3.Selection := sel;

  TabSheetModW.TabVisible := False;
  TabSheetModA.TabVisible := False;

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
  LabelArenaLink.Caption  := URL_ARENA;
  LabelALogLink.Caption   := URL_ALOGS;

  KYCostLabel.Caption := IntToStr(GikoSys.Setting.DonguriKYCost);
  CBCostLabel.Caption := IntToStr(GikoSys.Setting.DonguriCBCost);
  RNCostLabel.Caption := GikoSys.Setting.DonguriRNCost + ' どんぐり';
  TRCostLabel.Caption := GikoSys.Setting.DonguriTRCost + ' どんぐり';

	mode := GikoSys.DonguriSys.BuildMode;
  if mode <> '' then
  	PanelTop.Caption := mode;

	TimerInit.Enabled := True;
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
	SpeedButtonReload.Down := GikoSys.Setting.DonguriReload;
  ShowRoot;
end;

procedure TDonguriForm.TimerReloadTimer(Sender: TObject);
var
  res: String;
begin
	TimerReload.Enabled := False;
	if GikoSys.Setting.DonguriReload then begin

    if GikoSys.DonguriSys.Processing then begin
			TimerReload.Interval := 30 * 1000;	// 30秒後にリトライ
			TimerReload.Enabled := True;
      Exit;
    end;

		//GikoSys.DonguriSys.DebugLog('TDonguriForm.TimerReloadTimer()');

    if GikoSys.DonguriSys.Root(res) then
      SetHomeInfo(res);
    //else
    //  ShowHttpError;

    // SetHomeInfo()内でタイマーが始動しなかった場合
    if not TimerReload.Enabled then begin
      TimerReload.Interval := 30 * 60 * 1000;
      TimerReload.Enabled := True;
    end;
  end;
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

procedure TDonguriForm.SpeedButtonReloadClick(Sender: TObject);
begin
	TimerReload.Enabled := False;
	if GikoSys.Setting.DonguriReload then begin
    SpeedButtonReload.Down := False;
		GikoSys.Setting.DonguriReload := False;
  end else begin
  	TimerReload.Interval := 30 * 60 * 1000;
  	TimerReload.Enabled := True;
    SpeedButtonReload.Down := True;
		GikoSys.Setting.DonguriReload := True;
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
    InfoGrid.Cells[1, Integer(idxHP)]       := IntToStr(home.HP);

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
    // ハンター識別
    DspTypeRadioGroup.Tag := 1;
    if FHunter and (home.DisplayType = dstOn) then
    	DspTypeRadioGroup.ItemIndex := 0
    else
    	DspTypeRadioGroup.ItemIndex := 1;
    DspTypeRadioGroup.Enabled := FHunter;
    DspTypeRadioGroup.Tag := 0;

    // 自動更新
		TimerReload.Enabled := False;
    if GikoSys.Setting.DonguriReload then begin
    	TimerReload.Interval := 30 * 60 * 1000;
			TimerReload.Enabled := True;
    end;

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

procedure TDonguriForm.DspTypeRadioGroupClick(Sender: TObject);
var
  res: String;
begin
	if DspTypeRadioGroup.Tag <> 0 then
  	Exit;
	if GikoSys.DonguriSys.Processing then
  	Exit;

  if GikoSys.DonguriSys.ToggleDisplayType(res) then
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
  ModAPnlButton.Enabled := ((lock + unlock) = 1);
  SetButtonColor;
end;

function TDonguriForm.atoi(str: String; var numLen: Integer): Integer;
var
  num, code, i: Integer;
begin
	numLen := 0;
	num := 0;
	for i := 1 to Length(str) do begin
  	code := Ord(str[i]);
    if (code and $F0) <> $30 then
    	Break;
    num := (num * 10) + (code and $0F);
    Int(numLen);
  end;
	Result := num;
end;

function TDonguriForm.NumComp(text1, text2: String): Integer;
var
	tmp: Integer;
begin
	Result := atoi(text1, tmp) - atoi(text2, tmp);
end;

function TDonguriForm.NumStrComp(text1, text2: String): Integer;
var
  diff: Integer;
  len1, len2: Integer;
  idx1, idx2: Integer;
  len11, len21: Integer;
  str1, str2: String;
begin
	len1 := 0;
  len2 := 0;
	diff := atoi(text1, len1) - atoi(text2, len2);
  if diff = 0 then begin
  	len11 := Length(text1);
  	len21 := Length(text2);
  	idx1 := len1 + 1;
  	idx2 := len2 + 1;
    len1 := len11 - len1;
    len2 := len21 - len2;
    if len1 > 0 then
      str1 := Copy(text1, idx1, len1);
    if len2 > 0 then
      str2 := Copy(text2, idx2, len2);
    diff := AnsiCompareStr(str1, str2);
  end;
	Result := diff;
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

	case typ of
  ctInteger: Compare := NumComp(text1, text2);
	ctIntStr:  Compare := NumStrComp(text1, text2);
  //ctString:
  else       Compare := AnsiCompareStr(text1, text2);
  end;

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

	case typ of
  ctInteger: Compare := NumComp(text1, text2);
	ctIntStr:  Compare := NumStrComp(text1, text2);
  //ctString:
  else       Compare := AnsiCompareStr(text1, text2);
  end;

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
  ModWPnlButton.Enabled := ((lock + unlock) = 1);
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
  parse: Boolean;
  dlg: TDonguriRegForm;
begin
	try
    if GikoSys.DonguriSys.Processing then
      Exit;

  	parse := False;
    if GikoSys.DonguriSys.RegisterPage(res, parse) then begin
      if Pos('<html', res) < 1 then
        MsgBox(Handle, res, CAP_MSG, MB_OK or MB_ICONINFORMATION)
      else if parse then begin
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
var
  btn: TPanel;
begin
  if Sender is TPanel then begin
    btn := TPanel(Sender);
    if btn.Enabled then begin
      if ColorRadioGroup.ItemIndex = 0 then
        btn.Font.Color := clWindowText
      else
        btn.Font.Color := COL_DARK_TEXT;
    end else begin
      if ColorRadioGroup.ItemIndex = 0 then
        btn.Font.Color := COL_LGHT_DTXT
      else
        btn.Font.Color := COL_DARK_DTXT;
    end;
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
        SetColors(RPAmountComboBox,    clWindow,  clWindowText);
        SetColors(KYAmountComboBox,    clWindow,  clWindowText);
			  SetColors(CBAmountComboBox,    clWindow,  clWindowText);
        SetColors(NewNameEdit,         clWindow,  clWindowText);
        SetColors(RIDEdit,             clWindow,  clWindowText);
        SetColors(TAmountEdit,         clWindow,  clWindowText);

        TabSheetChest.Font.Color := clWindowText;
        SetColors(BagTopPanel,         clBtnFace, clWindowText);
        SetColors(WeaponTopPanel,      clBtnFace, clWindowText);
        SetColors(ArmorTopPanel,       clBtnFace, clWindowText);
        SetColors(GridWeaponUsing1,    clWindow,  clWindowText); GridWeaponUsing1.FixedColor := clBtnFace;
        SetColors(GridWeaponUsing2,    clWindow,  clWindowText); GridWeaponUsing2.FixedColor := clBtnFace;
        SetColors(GridWeaponUsing3,    clWindow,  clWindowText); GridWeaponUsing3.FixedColor := clBtnFace;
        SetColors(GridArmorUsing1,     clWindow,  clWindowText); GridArmorUsing1.FixedColor := clBtnFace;
        SetColors(GridArmorUsing2,     clWindow,  clWindowText); GridArmorUsing2.FixedColor := clBtnFace;
        SetColors(GridArmorUsing3,     clWindow,  clWindowText); GridArmorUsing3.FixedColor := clBtnFace;
        SetColors(ListViewWeapon,      clWindow,  clWindowText);
        SetColors(ListViewArmor,       clWindow,  clWindowText);
      	SetColors(UsingPanel,          clBtnFace, clWindowText);
        SetColors(ModWPanel,           clBtnFace, clWindowText);
        SetColors(ModWGrid1,           clWindow,  clWindowText); ModWGrid1.FixedColor := clBtnFace;
        SetColors(ModWGrid2,           clWindow,  clWindowText); ModWGrid2.FixedColor := clBtnFace;
        SetColors(ModWGrid3,           clWindow,  clWindowText); ModWGrid3.FixedColor := clBtnFace;
        SetColors(ModWMarimoPanel,     clWindow,  clWindowText);
        SetColors(DmgMinCurPanel,      clWindow,  clWindowText);
        SetColors(DmgMinNewPanel,      clWindow,  clWindowText);
        SetColors(DmgMinMrmPanel,      clWindow,  clWindowText);
        SetColors(DmgMinDwnPanel,      clWindow,  clWindowText);
        SetColors(DmgMinDMrPanel,      clWindow,  clWindowText);
        SetColors(DmgMaxCurPanel,      clWindow,  clWindowText);
        SetColors(DmgMaxNewPanel,      clWindow,  clWindowText);
        SetColors(DmgMaxMrmPanel,      clWindow,  clWindowText);
        SetColors(DmgMaxDwnPanel,      clWindow,  clWindowText);
        SetColors(DmgMaxDMrPanel,      clWindow,  clWindowText);
        SetColors(SpeedCurPanel,       clWindow,  clWindowText);
        SetColors(SpeedNewPanel,       clWindow,  clWindowText);
        SetColors(SpeedMrmPanel,       clWindow,  clWindowText);
        SetColors(SpeedDwnPanel,       clWindow,  clWindowText);
        SetColors(SpeedDMrPanel,       clWindow,  clWindowText);
        SetColors(CritWCurPanel,       clWindow,  clWindowText);
        SetColors(CritWNewPanel,       clWindow,  clWindowText);
        SetColors(CritWMrmPanel,       clWindow,  clWindowText);
        SetColors(CritWDwnPanel,       clWindow,  clWindowText);
        SetColors(CritWDMrPanel,       clWindow,  clWindowText);
        SetColors(ModAPanel,           clBtnFace, clWindowText);
        SetColors(ModAGrid1,           clWindow,  clWindowText); ModAGrid1.FixedColor := clBtnFace;
        SetColors(ModAGrid2,           clWindow,  clWindowText); ModAGrid2.FixedColor := clBtnFace;
        SetColors(ModAGrid3,           clWindow,  clWindowText); ModAGrid3.FixedColor := clBtnFace;
        SetColors(ModAMarimoPanel,     clWindow,  clWindowText);
        SetColors(DefMinCurPanel,      clWindow,  clWindowText);
        SetColors(DefMinNewPanel,      clWindow,  clWindowText);
        SetColors(DefMinDwnPanel,      clWindow,  clWindowText);
        SetColors(DefMinMrmPanel,      clWindow,  clWindowText);
        SetColors(DefMinDMrPanel,      clWindow,  clWindowText);
        SetColors(DefMaxCurPanel,      clWindow,  clWindowText);
        SetColors(DefMaxNewPanel,      clWindow,  clWindowText);
        SetColors(DefMaxDwnPanel,      clWindow,  clWindowText);
        SetColors(DefMaxMrmPanel,      clWindow,  clWindowText);
        SetColors(DefMaxDMrPanel,      clWindow,  clWindowText);
        SetColors(WeightCurPanel,      clWindow,  clWindowText);
        SetColors(WeightNewPanel,      clWindow,  clWindowText);
        SetColors(WeightDwnPanel,      clWindow,  clWindowText);
        SetColors(WeightMrmPanel,      clWindow,  clWindowText);
        SetColors(WeightDMrPanel,      clWindow,  clWindowText);
        SetColors(CritACurPanel,       clWindow,  clWindowText);
        SetColors(CritANewPanel,       clWindow,  clWindowText);
        SetColors(CritADwnPanel,       clWindow,  clWindowText);
        SetColors(CritAMrmPanel,       clWindow,  clWindowText);
        SetColors(CritADMrPanel,       clWindow,  clWindowText);

      	TabSheetSetting.Font.Color := clWindowText;

        TabSheetLink.Font.Color := clWindowText;
      	SetColors(LinkScrollBox, clBtnFace, clWindowText);
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
        LabelArenaLink.Font.Color  := COL_LGHT_LINK;
        LabelALogLink.Font.Color   := COL_LGHT_LINK;

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
        SetColors(RPAmountComboBox,    COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(KYAmountComboBox,    COL_DARK_BKG2, COL_DARK_TEXT);
			  SetColors(CBAmountComboBox,    COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(NewNameEdit,         COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(RIDEdit,             COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(TAmountEdit,         COL_DARK_BKG2, COL_DARK_TEXT);

        TabSheetChest.Font.Color := COL_DARK_TEXT;
        SetColors(BagTopPanel,         COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(WeaponTopPanel,      COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(ArmorTopPanel,       COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(GridWeaponUsing1,    COL_DARK_BKG2, COL_DARK_TEXT); GridWeaponUsing1.FixedColor := COL_DARK_BKG1;
        SetColors(GridWeaponUsing2,    COL_DARK_BKG2, COL_DARK_TEXT); GridWeaponUsing2.FixedColor := COL_DARK_BKG1;
        SetColors(GridWeaponUsing3,    COL_DARK_BKG2, COL_DARK_TEXT); GridWeaponUsing3.FixedColor := COL_DARK_BKG1;
        SetColors(GridArmorUsing1,     COL_DARK_BKG2, COL_DARK_TEXT); GridArmorUsing1.FixedColor := COL_DARK_BKG1;
        SetColors(GridArmorUsing2,     COL_DARK_BKG2, COL_DARK_TEXT); GridArmorUsing2.FixedColor := COL_DARK_BKG1;
        SetColors(GridArmorUsing3,     COL_DARK_BKG2, COL_DARK_TEXT); GridArmorUsing3.FixedColor := COL_DARK_BKG1;
        SetColors(ListViewWeapon,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ListViewArmor,       COL_DARK_BKG2, COL_DARK_TEXT);
      	SetColors(UsingPanel,          COL_DARK_BKG1, COL_DARK_TEXT);
      	SetColors(ModWPanel,           COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(ModWGrid1,           COL_DARK_BKG2, COL_DARK_TEXT); ModWGrid1.FixedColor := COL_DARK_BKG1;
        SetColors(ModWGrid2,           COL_DARK_BKG2, COL_DARK_TEXT); ModWGrid2.FixedColor := COL_DARK_BKG1;
        SetColors(ModWGrid3,           COL_DARK_BKG2, COL_DARK_TEXT); ModWGrid3.FixedColor := COL_DARK_BKG1;
        SetColors(ModWMarimoPanel,     COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMinCurPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMinNewPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMinMrmPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMinDwnPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMinDMrPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMaxCurPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMaxNewPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMaxMrmPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMaxDwnPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DmgMaxDMrPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(SpeedCurPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(SpeedNewPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(SpeedMrmPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(SpeedDwnPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(SpeedDMrPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritWCurPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritWNewPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritWMrmPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritWDwnPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritWDMrPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(ModAPanel,           COL_DARK_BKG1, COL_DARK_TEXT);
        SetColors(ModAGrid1,           COL_DARK_BKG2, COL_DARK_TEXT); ModAGrid1.FixedColor := COL_DARK_BKG1;
        SetColors(ModAGrid2,           COL_DARK_BKG2, COL_DARK_TEXT); ModAGrid2.FixedColor := COL_DARK_BKG1;
        SetColors(ModAGrid3,           COL_DARK_BKG2, COL_DARK_TEXT); ModAGrid3.FixedColor := COL_DARK_BKG1;
        SetColors(ModAMarimoPanel,     COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMinCurPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMinNewPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMinDwnPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMinMrmPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMinDMrPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMaxCurPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMaxNewPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMaxDwnPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMaxMrmPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(DefMaxDMrPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(WeightCurPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(WeightNewPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(WeightDwnPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(WeightMrmPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(WeightDMrPanel,      COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritACurPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritANewPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritADwnPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritAMrmPanel,       COL_DARK_BKG2, COL_DARK_TEXT);
        SetColors(CritADMrPanel,       COL_DARK_BKG2, COL_DARK_TEXT);

      	TabSheetSetting.Font.Color := COL_DARK_TEXT;

        TabSheetLink.Font.Color := COL_DARK_TEXT;
      	SetColors(LinkScrollBox, COL_DARK_BKG1, COL_DARK_TEXT);
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
        LabelArenaLink.Font.Color  := COL_DARK_LINK;
        LabelALogLink.Font.Color   := COL_DARK_LINK;
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
var
	hdl: HWnd;
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
    hdl := TListView(control).Handle;
    if hdl <> 0 then begin
    	ListView_SetBkColor(    hdl, ColorToRGB(bkg));
      ListView_SetTextBkColor(hdl, ColorToRGB(bkg));
      //ListView_SetTextColor(  hdl, ColorToRGB(txt));
    end;
  end else if control is TScrollBox then begin
    TScrollBox(control).Color := bkg;
    TScrollBox(control).Font.Color := txt;
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
  SetButtonColors(ModUseWPnlButton,   bkg, txt, dtx);
  SetButtonColors(ModUseAPnlButton,   bkg, txt, dtx);
  SetButtonColors(LockWPnlButton,     bkg, txt, dtx);
  SetButtonColors(UnlockWPnlButton,   bkg, txt, dtx);
  SetButtonColors(RecycleWPnlButton,  bkg, txt, dtx);
  SetButtonColors(UseWPnlButton,      bkg, txt, dtx);
  SetButtonColors(LockAPnlButton,     bkg, txt, dtx);
  SetButtonColors(UnlockAPnlButton,   bkg, txt, dtx);
  SetButtonColors(RecycleAPnlButton,  bkg, txt, dtx);
  SetButtonColors(UseAPnlButton,      bkg, txt, dtx);
  SetButtonColors(RecycleAllPnlButton,bkg, txt, dtx);
	SetButtonColors(ModWPnlButton,      bkg, txt, dtx);
  SetButtonColors(ModBackWPnlButton,  bkg, txt, dtx);
  SetButtonColors(ModDmgMinPnlButton, bkg, txt, dtx);
  SetButtonColors(DwnDmgMinPnlButton, bkg, txt, dtx);
  SetButtonColors(ModDmgMaxPnlButton, bkg, txt, dtx);
  SetButtonColors(DwnDmgMaxPnlButton, bkg, txt, dtx);
  SetButtonColors(ModSpeedPnlButton,  bkg, txt, dtx);
  SetButtonColors(DwnSpeedPnlButton,  bkg, txt, dtx);
  SetButtonColors(ModCritWPnlButton,  bkg, txt, dtx);
  SetButtonColors(DwnCritWPnlButton,  bkg, txt, dtx);
  SetButtonColors(ModAPnlButton,      bkg, txt, dtx);
  SetButtonColors(ModBackAPnlButton,  bkg, txt, dtx);
  SetButtonColors(ModDefMinPnlButton, bkg, txt, dtx);
  SetButtonColors(DwnDefMinPnlButton, bkg, txt, dtx);
  SetButtonColors(ModDefMaxPnlButton, bkg, txt, dtx);
  SetButtonColors(DwnDefMaxPnlButton, bkg, txt, dtx);
  SetButtonColors(ModWeightPnlButton, bkg, txt, dtx);
  SetButtonColors(DwnWeightPnlButton, bkg, txt, dtx);
  SetButtonColors(ModCritAPnlButton,  bkg, txt, dtx);
  SetButtonColors(DwnCritAPnlButton,  bkg, txt, dtx);
  SetButtonColors(ResurrectPnlButton, bkg, txt, dtx);
  SetButtonColors(RenamePnlButton,    bkg, txt, dtx);
	SetButtonColors(TransferPnlButton,  bkg, txt, dtx);
  SetButtonColors(CraftPnlButton,     bkg, txt, dtx);
	SetButtonColors(CraftRPPnlButton,   bkg, txt, dtx);
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
    2:
      begin
        if TabSheetChest.TabVisible then
          cpt := TabSheetChest.Caption
        else if TabSheetModW.TabVisible then
          cpt := TabSheetModW.Caption
        else if TabSheetModA.TabVisible then
          cpt := TabSheetModA.Caption;
      end;
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

procedure TDonguriForm.DrawGridCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const
  RARITY: array [0..4] of String = ('N', 'R', 'SR', 'SSR', 'UR');
	UR_IDX: Integer = 4;		// 上記配列 RARITY における 'UR' のインデックス
  UR_SN: String = 'UR [';
var
  grid: TStringGrid;
  text: String;
  drwRct: TRect;
  imgIdx: Integer;
  fmt: Cardinal;
begin
	if Sender is TStringGrid then
  	grid := TStringGrid(Sender)
  else
  	Exit;

	text := grid.Cells[ACol, ARow];

  if (ARow and 1) = 0 then
		grid.Canvas.Brush.Color := grid.FixedColor
  else
		grid.Canvas.Brush.Color := grid.Color;
	grid.Canvas.FillRect(Rect);

	drwRct := Rect;
	drwRct.Left := Rect.Left + 4;
  if grid.Tag = 1 then
		drwRct.Right := Rect.Right - 4;

	if (ACol = 0) and (ARow = 1) and (grid.Cells[0, 0] = CAP_USING_TOP) then begin
  	imgIdx := IndexText(text, RARITY);
    if (imgIdx < 0) and (Pos(UR_SN, text) = 1) then		// S/N付きUR
			imgIdx := UR_IDX;
    if imgIdx >= 0 then begin
    	if (grid.ColCount >= 3) and (grid.Cells[2, 1] = '1') then
      	imgIdx := imgIdx + Length(RARITY);
    	BagImageList.Draw(grid.Canvas, drwRct.Left, drwRct.Top, imgIdx);
    end;
		drwRct.Left := drwRct.Left + BagImageList.Width + 4;
  end;

  grid.Canvas.Font := grid.Font;
  fmt := DT_SINGLELINE or DT_VCENTER;
  if grid.Tag = 1 then
	  fmt := fmt or DT_CENTER;
	DrawText(grid.Canvas.Handle, PChar(text), -1, drwRct, fmt);
end;


procedure TDonguriForm.DrawModGridCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  grid: TStringGrid;
  text: String;
  drwRct: TRect;
begin
	if Sender is TStringGrid then
  	grid := TStringGrid(Sender)
  else
  	Exit;

	text := grid.Cells[ACol, ARow];

  if (ACol and 1) = 0 then
		grid.Canvas.Brush.Color := grid.FixedColor
  else
		grid.Canvas.Brush.Color := grid.Color;
	grid.Canvas.FillRect(Rect);

	drwRct := Rect;
	drwRct.Left := Rect.Left + 4;

  grid.Canvas.Font := grid.Font;
	DrawText(grid.Canvas.Handle, PChar(text), -1, drwRct, DT_SINGLELINE or DT_VCENTER);
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

procedure TDonguriForm.ImeDontCareCheckBoxClick(Sender: TObject);
begin
	GikoSys.Setting.DonguriImeDontCare := ImeDontCareCheckBox.Checked;
  SetImeMode;
end;

procedure TDonguriForm.SetImeMode;
var
	mode: TImeMode;
begin
  if GikoSys.Setting.DonguriImeDontCare then
  	mode := imDontCare
  else
  	mode := imClose;

	RPAmountComboBox.ImeMode := mode;
  KYAmountComboBox.ImeMode := mode;
  CBAmountComboBox.ImeMode := mode;
  RIDEdit.ImeMode          := mode;
  TAmountEdit.ImeMode      := mode;
end;


// 工作コストチェック
procedure TDonguriForm.CraftPnlButtonClick(Sender: TObject);
var
  res: String;
  tmp: String;
  rpc: Integer;
  kyc: Integer;
  cbc: Integer;
  rnc: String;
  trc: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

  rpc := -1;
  kyc := -1;
  cbc := -1;

  if GikoSys.DonguriSys.Craft(res) then begin
		if DonguriSystem.Extract('各資源パックを開くには、', 'つの鉄のキーが必要です。', res, tmp) then begin
      rpc := StrToIntDef(tmp, -1);
      if rpc > 0 then begin
				GikoSys.Setting.DonguriRPCost := rpc;
        RPCostLabel.Caption := IntToStr(GikoSys.Setting.DonguriRPCost);
      end;
    end;
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
				 '　資源パック作成：';
  if rpc > 0 then
    tmp := tmp + Format('鉄のキー%d', [rpc])
  else
    tmp := tmp + '確認できませんでした。';
  tmp := tmp + #10 +
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

procedure TDonguriForm.RPAmountComboBoxChange(Sender: TObject);
var
	amount: Integer;
  ikey: Integer;
begin
	try
  	ikey := 0;
		amount := GetCmbAmount(RPAmountComboBox);
    if amount > 0 then
      ikey := amount * GikoSys.Setting.DonguriRPCost;
  	RPKeyLabel.Caption := IntToStr(ikey);
  except
  end;
end;

procedure TDonguriForm.CraftRPPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = '資源パック作成';
var
	amount: Integer;
  res: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	amount := GetCmbAmount(RPAmountComboBox);
  if amount < 1 then begin
    MsgBox(Handle, '資源パックの作成数を入力してください。', CAP_MSG,
          	MB_OK or MB_ICONINFORMATION);
    Exit;
  end;

  if MsgBox(Handle, Format('資源パック%dを作成するには鉄のキー%dが必要です。%s作成しますか？',
  												[amount, amount * GikoSys.Setting.DonguriRPCost, #10]),
						CAP_MSG, MB_YESNO or MB_ICONQUESTION) <> IDYES then
  	Exit;

  if GikoSys.DonguriSys.CraftRP(amount, res) then
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
  wItmNo: String;
  aItmNo: String;
  w: TDonguriWeapon;
  a: TDonguriArmor;
begin
	try
  	ListViewWeapon.Items.BeginUpdate();
    ListViewArmor.Items.BeginUpdate();
    ListViewWeapon.Items.Clear;
    ListViewArmor.Items.Clear;

  	usedSlot := FBag.WeaponList.Count + FBag.ArmorList.Count;
  	SlotLabel.Caption := Format('%d / %d', [usedSlot, FBag.Slot]);

    GridWeaponUsing1.Cells[0, 1] := FBag.UseWeapon.Rarity;
    GridWeaponUsing1.Cells[1, 1] := FBag.UseWeapon.Name;
		GridWeaponUsing1.Cells[2, 1] := '';
    GridWeaponUsing2.Cells[0, 1] := FBag.UseWeapon.ATK;
    GridWeaponUsing2.Cells[1, 1] := FBag.UseWeapon.SPD;
    GridWeaponUsing2.Cells[2, 1] := FBag.UseWeapon.CRIT;
    GridWeaponUsing3.Cells[0, 1] := FBag.UseWeapon.ELEM;
    GridWeaponUsing3.Cells[1, 1] := FBag.UseWeapon.Modify;
    GridWeaponUsing3.Cells[2, 1] := FBag.UseWeapon.Marimo;

    GridArmorUsing1.Cells[0, 1] := FBag.UseArmor.Rarity;
    GridArmorUsing1.Cells[1, 1] := FBag.UseArmor.Name;
		GridArmorUsing1.Cells[2, 1] := '';
    GridArmorUsing2.Cells[0, 1] := FBag.UseArmor.DEF;
    GridArmorUsing2.Cells[1, 1] := FBag.UseArmor.WT;
    GridArmorUsing2.Cells[2, 1] := FBag.UseArmor.CRIT;
    GridArmorUsing3.Cells[0, 1] := FBag.UseArmor.ELEM;
    GridArmorUsing3.Cells[1, 1] := FBag.UseArmor.Modify;
    GridArmorUsing3.Cells[2, 1] := FBag.UseArmor.Marimo;

  	wItmNo := FBag.UseWeapon.ItemNo;
    for i := 0 to FBag.WeaponList.Count - 1 do begin
      item := ListViewWeapon.Items.Add;
      w := TDonguriWeapon(FBag.WeaponList.Items[i]);
      w.SetListItem(i + 1, item);
      if (wItmNo <> '') and (wItmNo = w.ItemNo) and w.Lock then
		    GridWeaponUsing1.Cells[2, 1] := '1';
    end;

  	aItmNo := FBag.UseArmor.ItemNo;
    for i := 0 to FBag.ArmorList.Count - 1 do begin
      item := ListViewArmor.Items.Add;
      a := TDonguriArmor(FBag.ArmorList.Items[i]);
      a.SetListItem(i + 1, item);
      if (aItmNo <> '') and (aItmNo = a.ItemNo) and a.Lock then
		    GridArmorUsing1.Cells[2, 1] := '1';
    end;

    RemWeaponPnlButton.Enabled := (FBag.UseWeapon.IsEmpty = False);
		ModUseWPnlButton.Enabled   := (FBag.UseWeapon.IsEmpty = False);
    RemArmorPnlButton.Enabled := (FBag.UseArmor.IsEmpty = False);
		ModUseAPnlButton.Enabled  := (FBag.UseArmor.IsEmpty = False);
    LockWPnlButton.Enabled    := False;
    UnlockWPnlButton.Enabled  := False;
    RecycleWPnlButton.Enabled := False;
    UseWPnlButton.Enabled     := False;
    ModWPnlButton.Enabled     := False;
    LockAPnlButton.Enabled    := False;
    UnlockAPnlButton.Enabled  := False;
    RecycleAPnlButton.Enabled := False;
    UseAPnlButton.Enabled     := False;
    ModAPnlButton.Enabled     := False;
    SetButtonColor;

  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, 'アイテムバッグ', MB_OK or MB_ICONERROR);
    end;
  end;
  ListViewWeapon.Items.EndUpdate();
  ListViewArmor.Items.EndUpdate();
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


procedure TDonguriForm.ReCreateIndyCheckBoxClick(Sender: TObject);
begin
  GikoSys.Setting.DonguriReCreateIndy := ReCreateIndyCheckBox.Checked;
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
  except
    on e: Exception do begin
			MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriForm.SwitchItemTab(showTab: TTabSheet);
begin
  LockWindowUpdate(PageControl.Handle);
  try
    TabSheetChest.TabVisible := (showTab = TabSheetChest);
    TabSheetModW.TabVisible  := (showTab = TabSheetModW);
    TabSheetModA.TabVisible  := (showTab = TabSheetModA);
    PageControl.ActivePage := showTab;
  finally
	  LockWindowUpdate(0);
  end;
end;

procedure TDonguriForm.ModUseAPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'アイテムバッグ';
var
  res: String;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

  try
		if (FBag.UseArmor.IsEmpty) or (FBag.UseArmor.ItemNo = '') then begin
      MsgBox(Handle, '装備中の防具はありません。',
								CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.ModArmorView(FBag.UseArmor.ItemNo, res) then begin
    	ShowModViewA(res);

      SwitchItemTab(TabSheetModA);
    end else
      ShowHttpError;
  except
    on e: Exception do begin
			MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriForm.ModUseWPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'アイテムバッグ';
var
  res: String;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

  try
		if (FBag.UseWeapon.IsEmpty) or (FBag.UseWeapon.ItemNo = '') then begin
      MsgBox(Handle, '装備中の武器はありません。',
								CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.ModWeaponView(FBag.UseWeapon.ItemNo, res) then begin
    	ShowModViewW(res);

      SwitchItemTab(TabSheetModW);
    end else
      ShowHttpError;
  except
    on e: Exception do begin
			MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriForm.ModAPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'アイテムバッグ';
var
	i: Integer;
  item: TListItem;
	itemNo: String;
  res: String;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

	try
  	for i := 0 to ListViewArmor.Items.Count - 1 do begin
    	item := ListViewArmor.Items.Item[i];
      if item.Checked and (item.Data <> nil) and
         (TDonguriItem(item.Data).ItemNo <> '') then begin
        if itemNo <> '' then begin
          MsgBox(Handle, '一度に複数を強化することはできません。',
                    CAP_MSG, MB_OK or MB_ICONERROR);
        	Exit;
        end;
      	itemNo := TDonguriItem(item.Data).ItemNo;
			end;
    end;

		if itemNo = '' then begin
      MsgBox(Handle, '強化する行にチェックを付けてください。',
								CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.ModArmorView(itemNo, res) then begin
    	ShowModViewA(res);

      SwitchItemTab(TabSheetModA);
    end else
      ShowHttpError;
  except
    on e: Exception do begin
			MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
    end;
  end;
end;


procedure TDonguriForm.EnableModButton(newVal, cost, button: TPanel);
begin
  if (newVal.Caption <> '') and (cost.Caption <> '') then
  	button.Enabled := True
  else
  	button.Enabled := False;
  SetBtnCol(button);
end;

type
  ColIndexModA = (
   idxmaID     = 0,
   idxmaRank   = 1,
   idxmaType   = 2,
   idxmaName   = 3,
   idxmaDefMin = 4,
   idxmaDefMax = 5,
   idxmaWeight = 6,
   idxmaCritic = 7,
   idxmaMarimo = 8,
   idxmaMod    = 9,
   idxmaDemod  = 10,
   idxmaCount  = 11
  );

procedure TDonguriForm.ShowModViewA(res: String);
const
  COL_NAME_MODA: array [0..10] of String = (
    'ID',
    'ランク',
    'タイプ',
    '名前',
    'DEF(最小値)',
    'DEF(最大値)',
    'WT.',
    'CRIT',
    'マリモ',
    'MOD',
    'DEMOD'
  );
  KW_IMG1_S  = '<div class="upgrade-option"><img';
  KW_IMG1_E  = '>';
  KW_IMG2_S  = 'src="';
  KW_IMG2_E  = '"';
  KW_TTLM_S = '<div>持っているマリモの量:';
  KW_TTLM_E = '</div>';
  KW_ID_S   = '<span id="armorID">';
  KW_ID_E   = '</span>';
  KW_RANK_S = '<span id="armorRarity">';
  KW_RANK_E = '</span>';
  KW_MINT_S = '<span id="armorMint">';
  KW_MINT_E = '</span>';
  KW_TYPE_S = '<span id="armorType">';
  KW_TYPE_E = '</span>';
  KW_NAME_S = '<span id="armorNickName">';
  KW_NAME_E = '</span>';
  KW_DFMN_S = '<span id="armorHardnessMin">';
  KW_DFMN_E = '</span>';
  KW_DFMX_S = '<span id="armorHardnessMax">';
  KW_DFMX_E = '</span>';
  KW_WGHT_S = '<span id="armorWeight">';
  KW_WGHT_E = '</span>';
  KW_CRIT_S = '<span id="armorCritical">';
  KW_CRIT_E = '</span>';
  KW_MARI_S = '<span id="armorValue">';
  KW_MARI_E = '</span>';
  KW_MODC_S = '<span id="armorModCount">';
  KW_MODC_E = '</span>';
  KW_DMDC_S = '<span id="armorDeModCount">';
  KW_DMDC_E = '</span>';
  KW_FM_DFMN_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/armor/deflow/';
  KW_FM_DFMN_E = '</form>';
  KW_FM_DFMX_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/armor/defhigh/';
  KW_FM_DFMX_E = '</form>';
  KW_FM_WGHT_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/armor/weight/';
  KW_FM_WGHT_E = '</form>';
  KW_FM_CRIT_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/armor/critical/';
  KW_FM_CRIT_E = '</form>';
  KW_FM_DDMN_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/armor/deflowdown/';
  KW_FM_DDMN_E = '</form>';
  KW_FM_DDMX_S = '<form class="upgrade-option " action="https://donguri.5ch.net/modify/armor/defhighdown/';
  KW_FM_DDMX_E = '</form>';
  KW_FM_DWWT_S = '<form class="upgrade-option " action="https://donguri.5ch.net/modify/armor/weightdown/';
  KW_FM_DWWT_E = '</form>';
  KW_FM_DCRT_S = '<form class="upgrade-option " action="https://donguri.5ch.net/modify/armor/criticaldown/';
  KW_FM_DCRT_E = '</form>';
  KW_CURVAL_S  = '旧値:';
  KW_CURVAL_E  = '</span>';
  KW_NEWVAL_S  = '新値:';
  KW_NEWVAL_E  = '</span>';
  KW_MRCOST_S  = '<button type="submit">';
  KW_MRCOST_E  = 'マを消費して強化</button>';
  KW_DWCOST_S  = '<button class="downgrade" type="submit">';
  KW_DWCOST_E  = 'マを消費して降下</button>';
var
	i: Integer;
	i2: Integer;
	i3: Integer;
  rowCnt1: Integer;
  rowCnt2: Integer;
  rowCnt3: Integer;
  tmp: String;
  tm2: String;
begin
  rowCnt1 := ModAGrid1.RowCount;
  rowCnt2 := ModAGrid2.RowCount;
  rowCnt3 := ModAGrid3.RowCount;
  i2 := 0;
  i3 := 0;
	for i := 0 to Integer(idxmaCount) - 1 do begin
  	if i < rowCnt1 then begin
      ModAGrid1.Cells[0, i] := COL_NAME_MODA[i];
      ModAGrid1.Cells[1, i] := '';
    end else if i2 < rowCnt2 then begin
      ModAGrid2.Cells[0, i2] := COL_NAME_MODA[i];
      ModAGrid2.Cells[1, i2] := '';
      Inc(i2);
    end else if i3 < rowCnt3 then begin
      ModAGrid3.Cells[0, i3] := COL_NAME_MODA[i];
      ModAGrid3.Cells[1, i3] := '';
      Inc(i3);
    end;
  end;
  ModAMarimoPanel.Caption := '';
  DefMinCurPanel.Caption := '';
  DefMinNewPanel.Caption := '';
  DefMinDwnPanel.Caption := '';
  DefMinMrmPanel.Caption := '';
  DefMinDMrPanel.Caption := '';
  DefMaxCurPanel.Caption := '';
  DefMaxNewPanel.Caption := '';
  DefMaxDwnPanel.Caption := '';
  DefMaxMrmPanel.Caption := '';
  DefMaxDMrPanel.Caption := '';
  WeightCurPanel.Caption := '';
  WeightNewPanel.Caption := '';
  WeightDwnPanel.Caption := '';
  WeightMrmPanel.Caption := '';
  WeightDMrPanel.Caption := '';
  CritACurPanel.Caption := '';
  CritANewPanel.Caption := '';
  CritADwnPanel.Caption := '';
  CritAMrmPanel.Caption := '';
  CritADMrPanel.Caption := '';
  ModAImage.Visible := False;

	if Pos('<html', res) < 1 then
  	Exit;

	if Extract(KW_IMG1_S, KW_IMG1_E, res, tmp) and
		 Extract(KW_IMG2_S, KW_IMG2_E, tmp, tm2) and (tm2 <> '') then
			ModAImage.Visible := SetImageFromURL(ModAImage, tm2);

	if Extract(KW_TTLM_S, KW_TTLM_E, res, tmp) then
	  ModAMarimoPanel.Caption := TrimTag(tmp);

	if Extract(KW_ID_S, KW_ID_E, res, tmp) then
	  ModAGrid1.Cells[1, Integer(idxmaID)] := tmp;

	if Extract(KW_RANK_S, KW_RANK_E, res, tmp) then begin
		if Extract(KW_MINT_S, KW_MINT_E, res, tm2) then
    	tmp := tmp + tm2;
	  ModAGrid1.Cells[1, Integer(idxmaRank)] := tmp;
  end;

	if Extract(KW_TYPE_S, KW_TYPE_E, res, tmp) then
	  ModAGrid1.Cells[1, Integer(idxmaType)] := tmp;

	if Extract(KW_NAME_S, KW_NAME_E, res, tmp) then
	  ModAGrid1.Cells[1, Integer(idxmaName)] := tmp;

	if Extract(KW_DFMN_S, KW_DFMN_E, res, tmp) then
	  ModAGrid2.Cells[1, Integer(idxmaDefMin) - rowCnt1] := tmp;

	if Extract(KW_DFMX_S, KW_DFMX_E, res, tmp) then
	  ModAGrid2.Cells[1, Integer(idxmaDefMax) - rowCnt1] := tmp;

	if Extract(KW_WGHT_S, KW_WGHT_E, res, tmp) then
	  ModAGrid2.Cells[1, Integer(idxmaWeight) - rowCnt1] := tmp;

	if Extract(KW_CRIT_S, KW_CRIT_E, res, tmp) then
	  ModAGrid2.Cells[1, Integer(idxmaCritic) - rowCnt1] := tmp;

	if Extract(KW_MARI_S, KW_MARI_E, res, tmp) then
	  ModAGrid3.Cells[1, Integer(idxmaMarimo) - rowCnt1 - rowCnt2] := tmp;

	if Extract(KW_MODC_S, KW_MODC_E, res, tmp) then
	  ModAGrid3.Cells[1, Integer(idxmaMod)    - rowCnt1 - rowCnt2] := tmp;

	if Extract(KW_DMDC_S, KW_DMDC_E, res, tmp) then
	  ModAGrid3.Cells[1, Integer(idxmaDemod)  - rowCnt1 - rowCnt2] := tmp;

	if Extract(KW_FM_DFMN_S, KW_FM_DFMN_E, res, tmp) then begin

		if Extract(KW_CURVAL_S, KW_CURVAL_E, tmp, tm2) then
	    DefMinCurPanel.Caption := TrimTag(tm2);

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    DefMinNewPanel.Caption := TrimTag(tm2);

		if Extract(KW_MRCOST_S, KW_MRCOST_E, tmp, tm2) then
	    DefMinMrmPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(DefMinNewPanel, DefMinMrmPanel, ModDefMinPnlButton);

	if Extract(KW_FM_DDMN_S, KW_FM_DDMN_E, res, tmp) then begin

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    DefMinDwnPanel.Caption := TrimTag(tm2);

		if Extract(KW_DWCOST_S, KW_DWCOST_E, tmp, tm2) then
	    DefMinDMrPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(DefMinDwnPanel, DefMinDMrPanel, DwnDefMinPnlButton);

	if Extract(KW_FM_DFMX_S, KW_FM_DFMX_E, res, tmp) then begin

		if Extract(KW_CURVAL_S, KW_CURVAL_E, tmp, tm2) then
	    DefMaxCurPanel.Caption := TrimTag(tm2);

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    DefMaxNewPanel.Caption := TrimTag(tm2);

		if Extract(KW_MRCOST_S, KW_MRCOST_E, tmp, tm2) then
	    DefMaxMrmPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(DefMaxNewPanel, DefMaxMrmPanel, ModDefMaxPnlButton);

	if Extract(KW_FM_DDMX_S, KW_FM_DDMX_E, res, tmp) then begin

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    DefMaxDwnPanel.Caption := TrimTag(tm2);

		if Extract(KW_DWCOST_S, KW_DWCOST_E, tmp, tm2) then
	    DefMaxDMrPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(DefMaxDwnPanel, DefMaxDMrPanel, DwnDefMaxPnlButton);

	if Extract(KW_FM_WGHT_S, KW_FM_WGHT_E, res, tmp) then begin

		if Extract(KW_CURVAL_S, KW_CURVAL_E, tmp, tm2) then
	    WeightCurPanel.Caption := TrimTag(tm2);

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    WeightNewPanel.Caption := TrimTag(tm2);

		if Extract(KW_MRCOST_S, KW_MRCOST_E, tmp, tm2) then
	    WeightMrmPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(WeightNewPanel, WeightMrmPanel, ModWeightPnlButton);

	if Extract(KW_FM_DWWT_S, KW_FM_DWWT_E, res, tmp) then begin

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    WeightDwnPanel.Caption := TrimTag(tm2);

		if Extract(KW_DWCOST_S, KW_DWCOST_E, tmp, tm2) then
	    WeightDMrPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(WeightDwnPanel, WeightDMrPanel, DwnWeightPnlButton);

	if Extract(KW_FM_CRIT_S, KW_FM_CRIT_E, res, tmp) then begin

		if Extract(KW_CURVAL_S, KW_CURVAL_E, tmp, tm2) then
	    CritACurPanel.Caption := TrimTag(tm2);

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    CritANewPanel.Caption := TrimTag(tm2);

		if Extract(KW_MRCOST_S, KW_MRCOST_E, tmp, tm2) then
	    CritAMrmPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(CritANewPanel, CritAMrmPanel, ModCritAPnlButton);

	if Extract(KW_FM_DCRT_S, KW_FM_DCRT_E, res, tmp) then begin

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    CritADwnPanel.Caption := TrimTag(tm2);

		if Extract(KW_DWCOST_S, KW_DWCOST_E, tmp, tm2) then
	    CritADMrPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(CritADwnPanel, CritADMrPanel, DwnCritAPnlButton);

end;

procedure TDonguriForm.ModBackAPnlButtonClick(Sender: TObject);
begin
	SwitchItemTab(TabSheetChest);
end;

procedure TDonguriForm.ModBackWPnlButtonClick(Sender: TObject);
begin
	SwitchItemTab(TabSheetChest);
end;

procedure TDonguriForm.ModDmgMinPnlButtonClick(Sender: TObject);
begin
	ModWeapon(mdwDmgMin);
end;

procedure TDonguriForm.ModDmgMaxPnlButtonClick(Sender: TObject);
begin
	ModWeapon(mdwDmgMax);
end;

procedure TDonguriForm.ModSpeedPnlButtonClick(Sender: TObject);
begin
	ModWeapon(mdwSpeed);
end;

procedure TDonguriForm.ModCritWPnlButtonClick(Sender: TObject);
begin
	ModWeapon(mdwCrit);
end;

procedure TDonguriForm.DwnDmgMinPnlButtonClick(Sender: TObject);
begin
	ModWeapon(mdwDmgMinDwn);
end;

procedure TDonguriForm.DwnDmgMaxPnlButtonClick(Sender: TObject);
begin
	ModWeapon(mdwDmgMaxDwn);
end;

procedure TDonguriForm.DwnSpeedPnlButtonClick(Sender: TObject);
begin
	ModWeapon(mdwSpeedDwn);
end;

procedure TDonguriForm.DwnCritWPnlButtonClick(Sender: TObject);
begin
	ModWeapon(mdwCritDwn);
end;

procedure TDonguriForm.ModDefMinPnlButtonClick(Sender: TObject);
begin
	ModArmor(mdaDefMin);
end;

procedure TDonguriForm.ModDefMaxPnlButtonClick(Sender: TObject);
begin
	ModArmor(mdaDefMax);
end;

procedure TDonguriForm.ModWeightPnlButtonClick(Sender: TObject);
begin
	ModArmor(mdaWeight);
end;

procedure TDonguriForm.ModCritAPnlButtonClick(Sender: TObject);
begin
	ModArmor(mdaCrit);
end;

procedure TDonguriForm.DwnDefMinPnlButtonClick(Sender: TObject);
begin
	ModArmor(mdaDefMinDwn);
end;

procedure TDonguriForm.DwnDefMaxPnlButtonClick(Sender: TObject);
begin
	ModArmor(mdaDefMaxDwn);
end;

procedure TDonguriForm.DwnWeightPnlButtonClick(Sender: TObject);
begin
	ModArmor(mdaWeightDwn);
end;

procedure TDonguriForm.DwnCritAPnlButtonClick(Sender: TObject);
begin
	ModArmor(mdaCritDwn);
end;


procedure TDonguriForm.ModArmor(modType: TModifyArmor);
const
	CAP_MSG = '防具強化';
var
	res: String;
  itemNo: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	try
		itemNo := Trim(ModAGrid1.Cells[1, Integer(idxmaID)]);

    if (itemNo = '') or (StrToIntDef(itemNo, -1) < 1) then begin
    	MsgBox(Handle, '防具の情報が正しくありません。', CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

  	if GikoSys.DonguriSys.ModArmor(modType, itemNo, res) then begin
      if Pos('<html', res) < 1 then
        MsgBox(Handle, TrimTag(res), CAP_MSG, MB_OK or MB_ICONWARNING)
      else
	    	ShowModViewA(res);
    end else
      ShowHttpError;
  except
    on e: Exception do begin
			MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
    end;
  end;
end;


procedure TDonguriForm.ModWPnlButtonClick(Sender: TObject);
const
  CAP_MSG: String = 'アイテムバッグ';
var
	i: Integer;
  item: TListItem;
	itemNo: String;
  res: String;
begin

	if GikoSys.DonguriSys.Processing then
  	Exit;

	try
  	for i := 0 to ListViewWeapon.Items.Count - 1 do begin
    	item := ListViewWeapon.Items.Item[i];
      if item.Checked and (item.Data <> nil) and
         (TDonguriItem(item.Data).ItemNo <> '') then begin
        if itemNo <> '' then begin
          MsgBox(Handle, '一度に複数を強化することはできません。',
                    CAP_MSG, MB_OK or MB_ICONERROR);
        	Exit;
        end;
      	itemNo := TDonguriItem(item.Data).ItemNo;
			end;
    end;

		if itemNo = '' then begin
      MsgBox(Handle, '強化する行にチェックを付けてください。',
								CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.ModWeaponView(itemNo, res) then begin
    	ShowModViewW(res);

			SwitchItemTab(TabSheetModW);
    end else
      ShowHttpError;
  except
    on e: Exception do begin
			MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
    end;
  end;

end;

type
  ColIndexModW = (
   idxmwID     = 0,
   idxmwRank   = 1,
   idxmwType   = 2,
   idxmwName   = 3,
   idxmwDmgMin = 4,
   idxmwDmgMax = 5,
   idxmwSpeed  = 6,
   idxmwCritic = 7,
   idxmwMarimo = 8,
   idxmwMod    = 9,
   idxmwDemod  = 10,
   idxmwCount  = 11
  );

procedure TDonguriForm.ShowModViewW(res: String);
const
  COL_NAME_MODW: array [0..10] of String = (
    'ID',
    'ランク',
    'タイプ',
    '名前',
    'DMG(最小値)',
    'DMG(最大値)',
    'SPD',
    'CRIT',
    'マリモ',
    'MOD',
    'DEMOD'
  );
  KW_IMG1_S  = '<div class="upgrade-option"><img';
  KW_IMG1_E  = '>';
  KW_IMG2_S  = 'src="';
  KW_IMG2_E  = '"';
  KW_TTLM_S = '<div>持っているマリモの量:';
  KW_TTLM_E = '</div>';
  KW_ID_S   = '<span id="weaponID">';
  KW_ID_E   = '</span>';
  KW_RANK_S = '<span id="weaponRarity">';
  KW_RANK_E = '</span>';
  KW_MINT_S = '<span id="weaponMint">';
  KW_MINT_E = '</span>';
  KW_TYPE_S = '<span id="weaponType">';
  KW_TYPE_E = '</span>';
  KW_NAME_S = '<span id="weaponNickName">';
  KW_NAME_E = '</span>';
  KW_DMMN_S = '<span id="weaponDMGmin">';
  KW_DMMN_E = '</span>';
  KW_DMMX_S = '<span id="weaponHardnessMax">';
  KW_DMMX_E = '</span>';
  KW_WSPD_S = '<span id="weaponSpeed">';
  KW_WSPD_E = '</span>';
  KW_CRIT_S = '<span id="weaponCritical">';
  KW_CRIT_E = '</span>';
  KW_MARI_S = '<span id="weaponValue">';
  KW_MARI_E = '</span>';
  KW_MODC_S = '<span id="weaponModCount">';
  KW_MODC_E = '</span>';
  KW_DMDC_S = '<span id="weaponDeModCount">';
  KW_DMDC_E = '</span>';
  KW_FM_DMMN_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/weapon/dmglow/';
  KW_FM_DMMN_E = '</form>';
  KW_FM_DMMX_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/weapon/dmghigh/';
  KW_FM_DMMX_E = '</form>';
  KW_FM_WSPD_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/weapon/speed/';
  KW_FM_WSPD_E = '</form>';
  KW_FM_CRIT_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/weapon/critical/';
  KW_FM_CRIT_E = '</form>';
  KW_FM_DDMN_S = '<form class="upgrade-option " action="https://donguri.5ch.net/modify/weapon/dmglowdown/';
  KW_FM_DDMN_E = '</form>';
  KW_FM_DDMX_S = '<form class="upgrade-option " action="https://donguri.5ch.net/modify/weapon/dmghighdown/';
  KW_FM_DDMX_E = '</form>';
  KW_FM_DWSP_S = '<form class="upgrade-option" action="https://donguri.5ch.net/modify/weapon/speeddown/';
  KW_FM_DWSP_E = '</form>';
  KW_FM_DCRT_S = '<form class="upgrade-option " action="https://donguri.5ch.net/modify/weapon/criticaldown/';
  KW_FM_DCRT_E = '</form>';
  KW_CURVAL_S  = '旧値:';
  KW_CURVAL_E  = '</span>';
  KW_NEWVAL_S  = '新値:';
  KW_NEWVAL_E  = '</span>';
  KW_MRCOST_S  = '<button type="submit">';
  KW_MRCOST_E  = 'マを消費して強化</button>';
  KW_DWCOST_S  = '<button class="downgrade" type="submit">';
  KW_DWCOST_E  = 'マを消費して降下</button>';
var
	i: Integer;
	i2: Integer;
	i3: Integer;
  rowCnt1: Integer;
  rowCnt2: Integer;
  rowCnt3: Integer;
  tmp: String;
  tm2: String;
begin
  rowCnt1 := ModWGrid1.RowCount;
  rowCnt2 := ModWGrid2.RowCount;
  rowCnt3 := ModWGrid3.RowCount;
  i2 := 0;
  i3 := 0;
	for i := 0 to Integer(idxmwCount) - 1 do begin
  	if i < rowCnt1 then begin
      ModWGrid1.Cells[0, i] := COL_NAME_MODW[i];
      ModWGrid1.Cells[1, i] := '';
    end else if i2 < rowCnt2 then begin
      ModWGrid2.Cells[0, i2] := COL_NAME_MODW[i];
      ModWGrid2.Cells[1, i2] := '';
      Inc(i2);
    end else if i3 < rowCnt3 then begin
      ModWGrid3.Cells[0, i3] := COL_NAME_MODW[i];
      ModWGrid3.Cells[1, i3] := '';
      Inc(i3);
    end;
  end;
  ModWMarimoPanel.Caption := '';
  DmgMinCurPanel.Caption := '';
  DmgMinNewPanel.Caption := '';
  DmgMinMrmPanel.Caption := '';
  DmgMinDwnPanel.Caption := '';
  DmgMinDMrPanel.Caption := '';
  DmgMaxCurPanel.Caption := '';
  DmgMaxNewPanel.Caption := '';
  DmgMaxMrmPanel.Caption := '';
  DmgMaxDwnPanel.Caption := '';
  DmgMaxDMrPanel.Caption := '';
  SpeedCurPanel.Caption := '';
  SpeedNewPanel.Caption := '';
  SpeedMrmPanel.Caption := '';
  SpeedDwnPanel.Caption := '';
  SpeedDMrPanel.Caption := '';
  CritWCurPanel.Caption := '';
  CritWNewPanel.Caption := '';
  CritWMrmPanel.Caption := '';
  CritWDwnPanel.Caption := '';
  CritWDMrPanel.Caption := '';
  ModWImage.Visible := False;

	if Pos('<html', res) < 1 then
  	Exit;

	if Extract(KW_IMG1_S, KW_IMG1_E, res, tmp) and
		 Extract(KW_IMG2_S, KW_IMG2_E, tmp, tm2) and (tm2 <> '') then
			ModWImage.Visible := SetImageFromURL(ModWImage, tm2);

	if Extract(KW_TTLM_S, KW_TTLM_E, res, tmp) then
	  ModWMarimoPanel.Caption := TrimTag(tmp);

	if Extract(KW_ID_S, KW_ID_E, res, tmp) then
	  ModWGrid1.Cells[1, Integer(idxmaID)] := tmp;

	if Extract(KW_RANK_S, KW_RANK_E, res, tmp) then begin
		if Extract(KW_MINT_S, KW_MINT_E, res, tm2) then
    	tmp := tmp + tm2;
	  ModWGrid1.Cells[1, Integer(idxmwRank)] := tmp;
  end;

	if Extract(KW_TYPE_S, KW_TYPE_E, res, tmp) then
	  ModWGrid1.Cells[1, Integer(idxmwType)] := tmp;

	if Extract(KW_NAME_S, KW_NAME_E, res, tmp) then
	  ModWGrid1.Cells[1, Integer(idxmwName)] := tmp;

	if Extract(KW_DMMN_S, KW_DMMN_E, res, tmp) then
	  ModWGrid2.Cells[1, Integer(idxmwDmgMin) - rowCnt1] := tmp;

	if Extract(KW_DMMX_S, KW_DMMX_E, res, tmp) then
	  ModWGrid2.Cells[1, Integer(idxmwDmgMax) - rowCnt1] := tmp;

	if Extract(KW_WSPD_S, KW_WSPD_E, res, tmp) then
	  ModWGrid2.Cells[1, Integer(idxmwSpeed)  - rowCnt1] := tmp;

	if Extract(KW_CRIT_S, KW_CRIT_E, res, tmp) then
	  ModWGrid2.Cells[1, Integer(idxmwCritic) - rowCnt1] := tmp;

	if Extract(KW_MARI_S, KW_MARI_E, res, tmp) then
	  ModWGrid3.Cells[1, Integer(idxmwMarimo) - rowCnt1 - rowCnt2] := tmp;

	if Extract(KW_MODC_S, KW_MODC_E, res, tmp) then
	  ModWGrid3.Cells[1, Integer(idxmwMod)    - rowCnt1 - rowCnt2] := tmp;

	if Extract(KW_DMDC_S, KW_DMDC_E, res, tmp) then
	  ModWGrid3.Cells[1, Integer(idxmwDemod)  - rowCnt1 - rowCnt2] := tmp;

	if Extract(KW_FM_DMMN_S, KW_FM_DMMN_E, res, tmp) then begin

		if Extract(KW_CURVAL_S, KW_CURVAL_E, tmp, tm2) then
	    DmgMinCurPanel.Caption := TrimTag(tm2);

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    DmgMinNewPanel.Caption := TrimTag(tm2);

		if Extract(KW_MRCOST_S, KW_MRCOST_E, tmp, tm2) then
	    DmgMinMrmPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(DmgMinNewPanel, DmgMinMrmPanel, ModDmgMinPnlButton);

	if Extract(KW_FM_DDMN_S, KW_FM_DDMN_E, res, tmp) then begin

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    DmgMinDwnPanel.Caption := TrimTag(tm2);

		if Extract(KW_DWCOST_S, KW_DWCOST_E, tmp, tm2) then
	    DmgMinDMrPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(DmgMinDwnPanel, DmgMinDMrPanel, DwnDmgMinPnlButton);

	if Extract(KW_FM_DMMX_S, KW_FM_DMMX_E, res, tmp) then begin

		if Extract(KW_CURVAL_S, KW_CURVAL_E, tmp, tm2) then
	    DmgMaxCurPanel.Caption := TrimTag(tm2);

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    DmgMaxNewPanel.Caption := TrimTag(tm2);

		if Extract(KW_MRCOST_S, KW_MRCOST_E, tmp, tm2) then
	    DmgMaxMrmPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(DmgMaxNewPanel, DmgMaxMrmPanel, ModDmgMaxPnlButton);

	if Extract(KW_FM_DDMX_S, KW_FM_DDMX_E, res, tmp) then begin

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    DmgMaxDwnPanel.Caption := TrimTag(tm2);

		if Extract(KW_DWCOST_S, KW_DWCOST_E, tmp, tm2) then
	    DmgMaxDMrPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(DmgMaxDwnPanel, DmgMaxDMrPanel, DwnDmgMaxPnlButton);

	if Extract(KW_FM_WSPD_S, KW_FM_WSPD_E, res, tmp) then begin

		if Extract(KW_CURVAL_S, KW_CURVAL_E, tmp, tm2) then
	    SpeedCurPanel.Caption := TrimTag(tm2);

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    SpeedNewPanel.Caption := TrimTag(tm2);

		if Extract(KW_MRCOST_S, KW_MRCOST_E, tmp, tm2) then
	    SpeedMrmPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(SpeedNewPanel, SpeedMrmPanel, ModSpeedPnlButton);

	if Extract(KW_FM_DWSP_S, KW_FM_DWSP_E, res, tmp) then begin

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    SpeedDwnPanel.Caption := TrimTag(tm2);

		if Extract(KW_DWCOST_S, KW_DWCOST_E, tmp, tm2) then
	    SpeedDMrPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(SpeedDwnPanel, SpeedDMrPanel, DwnSpeedPnlButton);

	if Extract(KW_FM_CRIT_S, KW_FM_CRIT_E, res, tmp) then begin

		if Extract(KW_CURVAL_S, KW_CURVAL_E, tmp, tm2) then
	    CritWCurPanel.Caption := TrimTag(tm2);

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    CritWNewPanel.Caption := TrimTag(tm2);

		if Extract(KW_MRCOST_S, KW_MRCOST_E, tmp, tm2) then
	    CritWMrmPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(CritWNewPanel, CritWMrmPanel, ModCritWPnlButton);

	if Extract(KW_FM_DCRT_S, KW_FM_DCRT_E, res, tmp) then begin

		if Extract(KW_NEWVAL_S, KW_NEWVAL_E, tmp, tm2) then
	    CritWDwnPanel.Caption := TrimTag(tm2);

		if Extract(KW_DWCOST_S, KW_DWCOST_E, tmp, tm2) then
	    CritWDMrPanel.Caption := TrimTag(tm2);
  end;
  EnableModButton(CritWDwnPanel, CritWDMrPanel, DwnCritWPnlButton);

end;


function TDonguriForm.SetImageFromURL(image: TImage; url: String): Boolean;
var
  img: TMemoryStream;
  jpg: TJPEGImage;
begin
	Result := False;
  img := TMemoryStream.Create;
  try
    if GikoSys.DonguriSys.Download(url, '', img) and (img.Size > 0) then begin
      jpg := TJPEGImage.Create;
      try
        img.Position := 0;
        jpg.LoadFromStream(img);
        image.Picture.Assign(jpg);
        Result := True;
      finally
	      jpg.Free;
      end;
    end;
  finally
	  img.Free;
  end;
end;


procedure TDonguriForm.ModWeapon(modType: TModifyWeapon);
const
	CAP_MSG = '武器強化';
var
	res: String;
  itemNo: String;
begin
	if GikoSys.DonguriSys.Processing then
  	Exit;

	try
		itemNo := Trim(ModWGrid1.Cells[1, Integer(idxmaID)]);

    if (itemNo = '') or (StrToIntDef(itemNo, -1) < 1) then begin
    	MsgBox(Handle, '武器の情報が正しくありません。', CAP_MSG, MB_OK or MB_ICONERROR);
      Exit;
    end;

  	if GikoSys.DonguriSys.ModWeapon(modType, itemNo, res) then begin
      if Pos('<html', res) < 1 then
        MsgBox(Handle, TrimTag(res), CAP_MSG, MB_OK or MB_ICONWARNING)
      else
	    	ShowModViewW(res);
    end else
      ShowHttpError;
  except
    on e: Exception do begin
			MsgBox(Handle, e.Message, CAP_MSG, MB_OK or MB_ICONERROR);
    end;
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
