unit GikoDataModule;

interface

uses
  SysUtils, Classes, ExtActns, StdActns, ActnList, ImgList, Controls,
{$IF Defined(DELPRO) }
	SHDocVw,
	MSHTML,
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB,
{$IFEND}
  ComCtrls, BrowserRecord, Graphics, Messages, Setting, Dialogs, StrUtils,
  ActiveX, GikoSystem, MoveHistoryItem, HistoryList, TntComCtrls, WideCtrls;

const
	CAPTION_NAME: string = 'ギコナビ';
	USER_SETLINKBAR					= WM_USER + 2003;

	ITEM_ICON_SORT1					= 12;		//!< ソートアイコン
	ITEM_ICON_SORT2					= 13;		//!< ソートアイコン

	//ツールバーアイコン
	TOOL_ICON_HEIGHT_MAX 		= 16;		//!< 高さ最大アイコン
	TOOL_ICON_HEIGHT_MIN 		= 17;		//!< 高さ最小アイコン
	TOOL_ICON_HEIGHT_NORMAL = 18;		//!< 高さ標準アイコン
	TOOL_ICON_WIDTH_MAX 		= 19;		//!< 幅最大アイコン
	TOOL_ICON_WIDTH_MIN 		= 20;		//!< 幅最小アイコン
	TOOL_ICON_WIDTH_NORMAL 	= 21;		//!< 幅標準アイコン

	TOOL_ICON_FAV_FOLDER		= 30;		//!< お気に入りフォルダアイコン
	TOOL_ICON_FAV_BOARD			= 31;		//!< お気に入り板アイコン
	TOOL_ICON_FAV_THREAD		= 32;		//!< お気に入りスレアイコン

	//! HTTP
	PROTOCOL_HTTP : string = 'https://';
	//! ギコナビサイトのURL
	//URL_GIKONAVI: string = 'gikonavi.sourceforge.jp/';
	URL_GIKONAVI: string = 'gikonavi.osdn.jp/';
	//! ギコナビ(避難所版)サイトのURL
	//URL_GIKONAVIGO: string = 'gikonavigoeson.sourceforge.jp/';
	URL_GIKONAVIGO: string = 'gikonavigoeson.osdn.jp/';
	//! MonazillaサイトのURL
	URL_MONAZILLA: string = 'www.monazilla.org/';   // このサイトは消滅
	//! 2ちゃんねるのURL
	URL_2ch: string = 'www.5ch.net/';
	//! ギコナビWikiのURL
	//URL_Wiki: string = 'sourceforge.jp/projects/gikonavi/wiki/FAQ';
	URL_Wiki: string = 'ja.osdn.net/projects/gikonavi/wiki/FAQ';
	//! ギコナビ(避難所版)WikiのURL
	//URL_GoWiki: string = 'sourceforge.jp/projects/gikonavigoeson/wiki/FAQ';
	URL_GoWiki: string = 'ja.osdn.net/projects/gikonavigoeson/wiki/FAQ';

	SELECTCOMBOBOX_NAME: WideString = ''; // 'スレッド絞込検索';
	SELECTCOMBOBOX_COLOR: TColor = clWindow;


type

  TGikoDM = class(TDataModule)
	GikoFormActionList: TActionList;
	OnlyAHundredResAction: TAction;
	OnlyKokoResAction: TAction;
	LoginAction: TAction;
	NewBoardAction: TAction;
	LogDeleteAction: TAction;
	KidokuAction: TAction;
	StdToolBarVisibleAction: TAction;
	AddressBarVisibleAction: TAction;
	LinkBarVisibleAction: TAction;
	ListToolBarVisibleAction: TAction;
	SearchAction: TAction;
	GikoNaviWebPageAction: TAction;
	MonazillaWebPageAction: TAction;
	BBS2chWebPageAction: TAction;
	GikoFolderOpenAction: TAction;
	AboutAction: TAction;
	SelectTextClearAction: TAction;
	NameTextClearAction: TAction;
	MailTextClearAction: TAction;
	ExitAction: TAction;
	ListNameBarVisibleAction: TAction;
	BrowserToolBarVisibleAction: TAction;
	BrowserNameBarVisibleAction: TAction;
	MsgBarVisibleAction: TAction;
	MsgBarCloseAction: TAction;
	StatusBarVisibleAction: TAction;
	CabinetBBSAction: TAction;
	CabinetHistoryAction: TAction;
	OnlyNewResAction: TAction;
	CabinetFavoriteAction: TAction;
	CabinetVisibleAction: TAction;
	ListNumberVisibleAction: TAction;
	UpFolderAction: TAction;
	CabinetCloseAction: TAction;
	IconStyle: TAction;
	LargeIconAction: TAction;
	SmallIconAction: TAction;
	ListIconAction: TAction;
	DetailIconAction: TAction;
	MidokuAction: TAction;
	AllSelectAction: TAction;
	AllItemAction: TAction;
	LogItemAction: TAction;
	NewItemAction: TAction;
	ThreadRangeAction: TAction;
	SelectItemAction: TAction;
	StopAction: TAction;
	OptionAction: TAction;
	RoundAction: TAction;
	BrowserMaxAction: TAction;
	BrowserMinAction: TAction;
	ScrollTopAction: TAction;
	ScrollLastAction: TAction;
	ScrollNewAction: TAction;
	ScrollKokoAction: TAction;
	EditorAction: TAction;
	IEAction: TAction;
	ShowThreadAction: TAction;
	ShowBoardAction: TAction;
	URLCopyAction: TAction;
	NameCopyAction: TAction;
	NameURLCopyAction: TAction;
	ItemReloadAction: TAction;
	ThreadEditorAction: TAction;
	BoardIEAction: TAction;
	SelectItemURLCopyAction: TAction;
	SelectItemNameCopyAction: TAction;
	SelectItemNameURLCopyAction: TAction;
	SelectListReloadAction: TAction;
	SelectThreadReloadAction: TAction;
	BrowserTabCloseAction: TAction;
	NotSelectTabCloseAction: TAction;
	AllTabCloseAction: TAction;
	KokomadeAction: TAction;
	ZenbuAction: TAction;
	KokoResAction: TAction;
	TreeSelectBoradReload: TAction;
	TreeSelectThreadReload: TAction;
	TreeSelectURLCopy: TAction;
	SelectReservAction: TAction;
	SelectNewRoundName: TAction;
	SelectDeleteRound: TAction;
	KeySettingAction: TAction;
	ArrangeAction: TAction;
	ActiveLogDeleteAction: TAction;
	TreeSelectNameURLCopy: TAction;
	PaneInitAction: TAction;
	LeftmostTabSelectAction: TAction;
	LeftTabSelectAction: TAction;
	RightTabSelectAction: TAction;
	RightmostTabSelectAction: TAction;
	FavoriteAddAction: TAction;
	BoardFavoriteAddAction: TAction;
	ThreadFavoriteAddAction: TAction;
	TreeSelectFavoriteAddAction: TAction;
	FavoriteArrangeAction: TAction;
	MoveToAction: TAction;
	BrowserTabVisibleAction: TAction;
	BrowserTabTopAction: TAction;
	BrowserTabBottomAction: TAction;
	BrowserTabTabStyleAction: TAction;
	BrowserTabButtonStyleAction: TAction;
	BrowserTabFlatStyleAction: TAction;
	GikoHelpAction: TAction;
	KotehanAction: TAction;
	ToolBarSettingAction: TAction;
	SelectResAction: TAction;
	AllResAction: TAction;
	EditNGAction: TAction;
	ReloadAction: TAction;
	GoFowardAction: TAction;
	GoBackAction: TAction;
	TreeSelectSearchBoardName: TAction;
	FavoriteTreeViewRenameAction: TAction;
	FavoriteTreeViewNewFolderAction: TAction;
	FavoriteTreeViewDeleteAction: TAction;
	FavoriteTreeViewBrowseFolderAction: TAction;
	FavoriteTreeViewReloadAction: TAction;
	FavoriteTreeViewURLCopyAction: TAction;
	FavoriteTreeViewNameCopyAction: TAction;
	FavoriteTreeViewNameURLCopyAction: TAction;
	FavoriteTreeViewLogDeleteAction: TAction;
	ResRangeAction: TAction;
	ExportFavoriteFile: TFileSaveAs;
	FavoriteTreeViewBrowseBoardAction: TAction;
	FavoriteTreeViewBrowseThreadAction: TAction;
	UpBoardAction: TAction;
	KoreCopy: TAction;
	TreeSelectNameCopy: TAction;
	SetFocusForBrowserAction: TAction;
	SetFocusForThreadListAction: TAction;
	SetFocusForCabinetAction: TAction;
	FileRun1: TFileRun;
	ThreadlistMaxAndFocusAction: TAction;
	BrowserMaxAndFocusAction: TAction;
	SelectItemSaveForHTML: TAction;
	SelectItemSaveForDat: TAction;
	LogFolderOpenAction: TAction;
	TabsSaveAction: TAction;
	TabsOpenAction: TAction;
	BrowsBoradHeadAction: TAction;
	JumpToNumOfResAction: TAction;
	FavoriteTreeViewCollapseAction: TAction;
	RightTabCloseAction: TAction;
	LeftTabCloseAction: TAction;
	SameIDResAnchorAction: TAction;
	IndividualAbon1Action: TAction;
	IndividualAbon0Action: TAction;
	AntiIndividualAbonAction: TAction;
	AntiIndividualAbonDlgAction: TAction;
	IndividualAbonID1Action: TAction;
	IndividualAbonID0Action: TAction;
	MuteAction: TAction;
	SortActiveColumnAction: TAction;
	SortNextColumnAction: TAction;
	SortPrevColumnAction: TAction;
	BeLogInOutAction: TAction;
	UnSelectedListViewAction: TAction;
	WikiFAQWebPageAction: TAction;
	ToobarImageList: TImageList;
    SaveDialog: TSaveDialog;
    ThreadSizeCalcForFileAction: TAction;
    SetInputAssistAction: TAction;
    OpenFindDialogAction: TAction;
    ArchiveItemAction: TAction;
    LiveItemAction: TAction;
    FavoriteTreeViewItemNameCopyAction: TAction;
    CloseAllEditorAction: TAction;
    PrevMoveHistory: TAction;
    NextMoveHistory: TAction;
    ClickActiveElementAction: TAction;
    VKDownAction: TAction;
    VKUpAction: TAction;
    VKRightAction: TAction;
    VKLeftAction: TAction;
    StoredTaskTrayAction: TAction;
    AllImageLinkToClipbordAction: TAction;
    NewImageLinkToClipBoardAction: TAction;
    SetForcusForAddresBarAction: TAction;
    NewBoardSearchAction: TAction;
    NGWordEditFormAction: TAction;
    ScrollPageDownAction: TAction;
    ScrollPageUpAction: TAction;
    AllLinkToClipboardAction: TAction;
    NewLinkToClipboardAction: TAction;
    AddIDtoNGWord0Action: TAction;
    AddIDtoNGWord1Action: TAction;
    ExtractSameIDAction: TAction;
    ShowTabListAction: TAction;
    DereferenceResAction: TAction;
    UpdateGikonaviAction: TAction;
    konoURLPATHAction: TAction;
    konoURLQueryAction: TAction;
    PopupMenuSettingAction: TAction;
    GikoNaviGoesonWebPageAction: TAction;
    GoWikiFAQWebPageAction: TAction;
    ThreadSearchAction: TAction;
    ThreadNgEditAction: TAction;
    RangeAbonAction: TAction;
    ThreadRangeAbonAction: TAction;
    DonguriAction: TAction;
    DonguriCannonAction: TAction;
    CookieMngAction: TAction;
    DonguriLoginAction: TAction;
    DonguriHntLoginAction: TAction;
    DonguriGrdLoginAction: TAction;
    DonguriLogoutAction: TAction;
    DonguriAuthAction: TAction;
	procedure EditNGActionExecute(Sender: TObject);
	procedure ReloadActionExecute(Sender: TObject);
	procedure GoFowardActionExecute(Sender: TObject);
	procedure GoBackActionExecute(Sender: TObject);
	procedure MoveToActionExecute(Sender: TObject);
	procedure FavoriteAddActionExecute(Sender: TObject);
	procedure FavoriteArrangeActionExecute(Sender: TObject);
	procedure FavoriteTreeViewCollapseActionExecute(Sender: TObject);
	procedure FavoriteTreeViewRenameActionExecute(Sender: TObject);
	procedure FavoriteTreeViewNewFolderActionExecute(Sender: TObject);
	procedure FavoriteTreeViewDeleteActionExecute(Sender: TObject);
	procedure FavoriteTreeViewBrowseFolderActionExecute(Sender: TObject);
	procedure FavoriteTreeViewReloadActionExecute(Sender: TObject);
	procedure FavoriteTreeViewURLCopyActionExecute(Sender: TObject);
	procedure FavoriteTreeViewNameCopyActionExecute(Sender: TObject);
	procedure FavoriteTreeViewNameURLCopyActionExecute(Sender: TObject);
	procedure FavoriteTreeViewLogDeleteActionExecute(Sender: TObject);
	procedure FavoriteTreeViewBrowseThreadActionExecute(Sender: TObject);
	procedure OnlyAHundredResActionExecute(Sender: TObject);
	procedure OnlyKokoResActionExecute(Sender: TObject);
	procedure OnlyNewResActionExecute(Sender: TObject);
	procedure BrowserMaxActionExecute(Sender: TObject);
	procedure BrowserMinActionExecute(Sender: TObject);
	procedure ScrollTopActionExecute(Sender: TObject);
	procedure ScrollLastActionExecute(Sender: TObject);
	procedure ScrollNewActionExecute(Sender: TObject);
	procedure ScrollKokoActionExecute(Sender: TObject);
	procedure ScrollKokoActionUpdate(Sender: TObject);
	procedure EditorActionExecute(Sender: TObject);
	procedure IEActionExecute(Sender: TObject);
	procedure ShowThreadActionExecute(Sender: TObject);
	procedure ShowBoardActionExecute(Sender: TObject);
	procedure URLCopyActionExecute(Sender: TObject);
	procedure NameCopyActionExecute(Sender: TObject);
	procedure NameURLCopyActionExecute(Sender: TObject);
	procedure ItemReloadActionExecute(Sender: TObject);
	procedure BrowserTabCloseActionExecute(Sender: TObject);
	procedure BrowserTabCloseActionUpdate(Sender: TObject);
	procedure NotSelectTabCloseActionExecute(Sender: TObject);
	procedure NotSelectTabCloseActionUpdate(Sender: TObject);
	procedure AllTabCloseActionExecute(Sender: TObject);
	procedure ActiveLogDeleteActionExecute(Sender: TObject);
	procedure LeftmostTabSelectActionExecute(Sender: TObject);
	procedure LeftmostTabSelectActionUpdate(Sender: TObject);
	procedure LeftTabSelectActionExecute(Sender: TObject);
	procedure RightTabSelectActionExecute(Sender: TObject);
	procedure RightTabSelectActionUpdate(Sender: TObject);
	procedure RightmostTabSelectActionExecute(Sender: TObject);
	procedure ThreadFavoriteAddActionExecute(Sender: TObject);
	procedure ThreadFavoriteAddActionUpdate(Sender: TObject);
	procedure SelectResActionExecute(Sender: TObject);
	procedure AllResActionExecute(Sender: TObject);
	procedure ResRangeActionExecute(Sender: TObject);
	procedure UpBoardActionExecute(Sender: TObject);
	procedure JumpToNumOfResActionExecute(Sender: TObject);
	procedure RightTabCloseActionExecute(Sender: TObject);
	procedure RightTabCloseActionUpdate(Sender: TObject);
	procedure LeftTabCloseActionExecute(Sender: TObject);
	procedure DataModuleCreate(Sender: TObject);
	procedure SearchActionExecute(Sender: TObject);
	procedure OptionActionExecute(Sender: TObject);
	procedure RoundActionExecute(Sender: TObject);
	procedure KeySettingActionExecute(Sender: TObject);
	procedure KotehanActionExecute(Sender: TObject);
	procedure ToolBarSettingActionExecute(Sender: TObject);
	procedure MuteActionExecute(Sender: TObject);
	procedure TreeSelectBoradReloadExecute(Sender: TObject);
	procedure TreeSelectThreadReloadExecute(Sender: TObject);
	procedure TreeSelectURLCopyExecute(Sender: TObject);
	procedure TreeSelectNameURLCopyExecute(Sender: TObject);
	procedure TreeSelectFavoriteAddActionExecute(Sender: TObject);
	procedure TreeSelectSearchBoardNameExecute(Sender: TObject);
	procedure TreeSelectNameCopyExecute(Sender: TObject);
	procedure LoginActionExecute(Sender: TObject);
	procedure NewBoardActionExecute(Sender: TObject);
	procedure LogDeleteActionExecute(Sender: TObject);
	procedure LogDeleteActionUpdate(Sender: TObject);
	procedure SelectTextClearActionExecute(Sender: TObject);
	procedure NameTextClearActionExecute(Sender: TObject);
	procedure MailTextClearActionExecute(Sender: TObject);
	procedure ExitActionExecute(Sender: TObject);
	procedure ExportFavoriteFileBeforeExecute(Sender: TObject);
	procedure ExportFavoriteFileAccept(Sender: TObject);
	procedure SelectItemSaveForHTMLExecute(Sender: TObject);
	procedure SelectItemSaveForDatExecute(Sender: TObject);
	procedure TabsSaveActionExecute(Sender: TObject);
	procedure TabsOpenActionExecute(Sender: TObject);
	procedure BeLogInOutActionExecute(Sender: TObject);
	procedure KokomadeActionExecute(Sender: TObject);
	procedure ZenbuActionExecute(Sender: TObject);
	procedure KokoResActionExecute(Sender: TObject);
	procedure KoreCopyExecute(Sender: TObject);
	procedure SameIDResAnchorActionExecute(Sender: TObject);
	procedure IndividualAbon1ActionExecute(Sender: TObject);
	procedure IndividualAbon0ActionExecute(Sender: TObject);
	procedure AntiIndividualAbonActionExecute(Sender: TObject);
	procedure AntiIndividualAbonDlgActionExecute(Sender: TObject);
	procedure IndividualAbonID1ActionExecute(Sender: TObject);
	procedure IndividualAbonID0ActionExecute(Sender: TObject);
	procedure GikoNaviWebPageActionExecute(Sender: TObject);
	procedure MonazillaWebPageActionExecute(Sender: TObject);
	procedure BBS2chWebPageActionExecute(Sender: TObject);
	procedure GikoFolderOpenActionExecute(Sender: TObject);
	procedure AboutActionExecute(Sender: TObject);
	procedure GikoHelpActionExecute(Sender: TObject);
	procedure WikiFAQWebPageActionExecute(Sender: TObject);
	procedure ListNumberVisibleActionExecute(Sender: TObject);
	procedure UpFolderActionExecute(Sender: TObject);
	procedure UpFolderActionUpdate(Sender: TObject);
	procedure IconStyleExecute(Sender: TObject);
	procedure AllItemActionExecute(Sender: TObject);
	procedure LogItemActionExecute(Sender: TObject);
	procedure NewItemActionExecute(Sender: TObject);
	procedure ThreadRangeActionExecute(Sender: TObject);
	procedure SelectItemActionExecute(Sender: TObject);
	procedure ThreadEditorActionExecute(Sender: TObject);
	procedure BoardIEActionExecute(Sender: TObject);
	procedure SelectItemURLCopyActionExecute(Sender: TObject);
	procedure SelectItemURLCopyActionUpdate(Sender: TObject);
	procedure SelectItemNameCopyActionExecute(Sender: TObject);
	procedure SelectItemNameCopyActionUpdate(Sender: TObject);
	procedure SelectItemNameURLCopyActionExecute(Sender: TObject);
	procedure SelectListReloadActionExecute(Sender: TObject);
	procedure SelectListReloadActionUpdate(Sender: TObject);
	procedure SelectThreadReloadActionExecute(Sender: TObject);
	procedure SelectThreadReloadActionUpdate(Sender: TObject);
	procedure SelectReservActionExecute(Sender: TObject);
	procedure SelectReservActionUpdate(Sender: TObject);
	procedure SelectNewRoundNameExecute(Sender: TObject);
	procedure SelectDeleteRoundExecute(Sender: TObject);
	procedure BoardFavoriteAddActionExecute(Sender: TObject);
	procedure BoardFavoriteAddActionUpdate(Sender: TObject);
	procedure LogFolderOpenActionExecute(Sender: TObject);
	procedure LogFolderOpenActionUpdate(Sender: TObject);
	procedure BrowsBoradHeadActionExecute(Sender: TObject);
	procedure SortActiveColumnActionExecute(Sender: TObject);
	procedure SortNextColumnActionExecute(Sender: TObject);
	procedure SortPrevColumnActionExecute(Sender: TObject);
	procedure StdToolBarVisibleActionExecute(Sender: TObject);
	procedure AddressBarVisibleActionExecute(Sender: TObject);
	procedure LinkBarVisibleActionExecute(Sender: TObject);
	procedure ListToolBarVisibleActionExecute(Sender: TObject);
	procedure ListNameBarVisibleActionExecute(Sender: TObject);
	procedure BrowserToolBarVisibleActionExecute(Sender: TObject);
	procedure BrowserNameBarVisibleActionExecute(Sender: TObject);
	procedure MsgBarVisibleActionExecute(Sender: TObject);
	procedure MsgBarCloseActionExecute(Sender: TObject);
	procedure StatusBarVisibleActionExecute(Sender: TObject);
	procedure CabinetBBSActionExecute(Sender: TObject);
	procedure CabinetHistoryActionExecute(Sender: TObject);
	procedure CabinetFavoriteActionExecute(Sender: TObject);
	procedure CabinetVisibleActionExecute(Sender: TObject);
	procedure CabinetCloseActionExecute(Sender: TObject);
	procedure LargeIconActionExecute(Sender: TObject);
	procedure SmallIconActionExecute(Sender: TObject);
	procedure ListIconActionExecute(Sender: TObject);
	procedure DetailIconActionExecute(Sender: TObject);
	procedure StopActionExecute(Sender: TObject);
	procedure ArrangeActionExecute(Sender: TObject);
	procedure PaneInitActionExecute(Sender: TObject);
	procedure BrowserTabVisibleActionExecute(Sender: TObject);
	procedure BrowserTabTopActionExecute(Sender: TObject);
	procedure BrowserTabBottomActionExecute(Sender: TObject);
	procedure BrowserTabTabStyleActionExecute(Sender: TObject);
	procedure BrowserTabButtonStyleActionExecute(Sender: TObject);
	procedure BrowserTabFlatStyleActionExecute(Sender: TObject);
	procedure SetFocusForBrowserActionExecute(Sender: TObject);
	procedure SetFocusForBrowserActionUpdate(Sender: TObject);
	procedure SetFocusForThreadListActionExecute(Sender: TObject);
	procedure SetFocusForCabinetActionExecute(Sender: TObject);
	procedure SetFocusForCabinetActionUpdate(Sender: TObject);
	procedure ThreadlistMaxAndFocusActionExecute(Sender: TObject);
	procedure BrowserMaxAndFocusActionExecute(Sender: TObject);
	procedure UnSelectedListViewActionExecute(Sender: TObject);
	procedure KidokuActionExecute(Sender: TObject);
	procedure MidokuActionExecute(Sender: TObject);
	procedure AllSelectActionExecute(Sender: TObject);
	procedure AllSelectActionUpdate(Sender: TObject);
    procedure ThreadSizeCalcForFileActionExecute(Sender: TObject);
    procedure SetInputAssistActionExecute(Sender: TObject);
    procedure OpenFindDialogActionExecute(Sender: TObject);
    procedure ArchiveItemActionExecute(Sender: TObject);
    procedure LiveItemActionExecute(Sender: TObject);
    procedure FavoriteTreeViewItemNameCopyActionExecute(Sender: TObject);
    procedure CloseAllEditorActionExecute(Sender: TObject);
    procedure CloseAllEditorActionUpdate(Sender: TObject);
    procedure PrevMoveHistoryUpdate(Sender: TObject);
    procedure PrevMoveHistoryExecute(Sender: TObject);
    procedure NextMoveHistoryUpdate(Sender: TObject);
    procedure NextMoveHistoryExecute(Sender: TObject);
    procedure ClickActiveElementActionExecute(Sender: TObject);
    procedure VKDownActionExecute(Sender: TObject);
    procedure VKUpActionExecute(Sender: TObject);
    procedure VKRightActionExecute(Sender: TObject);
    procedure VKLeftActionExecute(Sender: TObject);
    procedure StoredTaskTrayActionExecute(Sender: TObject);
    procedure LeftTabSelectActionUpdate(Sender: TObject);
    procedure RightmostTabSelectActionUpdate(Sender: TObject);
    procedure NewImageLinkToClipBoardActionExecute(Sender: TObject);
    procedure AllImageLinkToClipbordActionExecute(Sender: TObject);
    procedure SetForcusForAddresBarActionExecute(Sender: TObject);
    procedure NewBoardSearchActionExecute(Sender: TObject);
    procedure ScrollPageDownActionExecute(Sender: TObject);
    procedure ScrollPageUpActionExecute(Sender: TObject);
    procedure AllLinkToClipboardActionExecute(Sender: TObject);
    procedure NewLinkToClipboardActionExecute(Sender: TObject);
    procedure AddIDtoNGWord0ActionExecute(Sender: TObject);
    procedure AddIDtoNGWord1ActionExecute(Sender: TObject);
    procedure ExtractSameIDActionExecute(Sender: TObject);
    procedure ShowTabListActionExecute(Sender: TObject);
    procedure DereferenceResActionExecute(Sender: TObject);
    procedure UpdateGikonaviActionExecute(Sender: TObject);
    procedure konoURLPATHActionExecute(Sender: TObject);
    procedure konoURLQueryActionExecute(Sender: TObject);
    procedure konoURLQueryActionUpdate(Sender: TObject);
    procedure PopupMenuSettingActionExecute(Sender: TObject);
    procedure GikoNaviGoesonWebPageActionExecute(Sender: TObject);
    procedure GoWikiFAQWebPageActionExecute(Sender: TObject);
    procedure ThreadSearchActionExecute(Sender: TObject);
    procedure ThreadNgEditActionExecute(Sender: TObject);
    procedure RangeAbonActionExecute(Sender: TObject);
    procedure ThreadRangeAbonActionExecute(Sender: TObject);
    procedure DonguriActionExecute(Sender: TObject);
    procedure DonguriActionUpdate(Sender: TObject);
    procedure DonguriCannonActionExecute(Sender: TObject);
    procedure DonguriCannonActionUpdate(Sender: TObject);
    procedure CookieMngActionExecute(Sender: TObject);
    procedure DonguriActionHint(var HintStr: string; var CanShow: Boolean);
    procedure DonguriLoginActionExecute(Sender: TObject);
    procedure DonguriHntLoginActionExecute(Sender: TObject);
    procedure DonguriGrdLoginActionExecute(Sender: TObject);
    procedure DonguriLogoutActionExecute(Sender: TObject);
    procedure DonguriAuthActionExecute(Sender: TObject);
    procedure DonguriHntLoginActionUpdate(Sender: TObject);
    procedure DonguriGrdLoginActionUpdate(Sender: TObject);
  private
	{ Private 宣言 }
	procedure ClearResFilter;
	procedure SetResRange(range: Integer);
	procedure SetThreadAreaHorNormal;
	procedure SetThreadAreaHorizontal(gls : TGikoListState);
	procedure SetThreadAreaVerNormal;
	procedure SetThreadAreaVertical(gls : TGikoListState);
	procedure SetThreadReadProperty(read: Boolean);
	procedure SelectThreadSaveToFile(dat: Boolean);
	function GetSortProperties(List: TObject;var vSortOrder: Boolean): Boolean;
	procedure RecalcThreadSize(limit : Integer);
	procedure ClearSelectComboBox;
    procedure ClearMailAllEditor();
    procedure ClearNameTextAllEditor();
//    procedure MoveURLWithHistory(URL : String; KeyMask: Boolean = False);
    procedure BackToHistory(item: TMoveHistoryItem);
    function GetActiveThreadLinks : IHTMLElementCollection;
    procedure GetLinkURLs(links : IHTMLElementCollection;
        URLs : TStringList; const Start: Integer; Exts : TStringList);
  public
    { Public 宣言 }
    procedure RepaintStatusBar;
    function EditorFormExists(): boolean;
    procedure GetTabURLs(AStringList: TStringList);
    procedure OpenURLs(AStringList: TStringList);
    procedure MoveURLWithHistory(URL : String; KeyMask: Boolean = False);
    procedure SaveThreadSearchSetting;
    procedure DonguriHomeUpdate;
  published
	{ Published 宣言 }
	//! TActionでGetActiveContentがnil以外で有効になる
	procedure DependActiveCntentActionUpdate(Sender: TObject);
	//! TActionでGetActiveContentがnil以外かつログを持っていると有効になる
	procedure DependActiveCntentLogActionUpdate(Sender: TObject);
	//! TActionでActiveListがTBoard(非特殊板)で有効になる
	procedure DependActiveListTBoardActionUpdate(Sender: TObject);
	//! TActionでActiveListがTBoardで有効になる
	procedure DependActiveListTBoardWithSpeciapActionUpdate(Sender: TObject);
  end;

var
  GikoDM: TGikoDM;


implementation

uses
	Windows, Math, Clipbrd,
	Giko, GikoUtil, BoardGroup,
	FavoriteArrange, Favorite, MojuUtils,
	Editor, ListSelect, Search, Option, Round,
	KeySetting, Gesture, Kotehan, ToolBarSetting,
	ToolBarUtil, NewBoard, HTMLCreate, IndividualAbon,
	GikoBayesian, About, ShellAPI,
	RoundName, RoundData, Menus, ListViewUtils,
	ThreadControl, GikoMessage, InputAssist,
  DefaultFileManager, Forms, NewBoardURL, UpdateCheck,
  PopupMenuSetting, ThreadSearch, ThreadNGEdt, DmSession5ch, DonguriBase,
  CookieManager;

const
	MSG_ERROR : string = 'エラー';

{$R *.dfm}
// *************************************************************************
//! TActionでGetActiveContentがnil以外で有効になる
// *************************************************************************
procedure TGikoDM.DependActiveCntentActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveContent <> nil);
end;
// *************************************************************************
//! TActionでGetActiveContentがnil以外かつログを持っている
// *************************************************************************
procedure TGikoDM.DependActiveCntentLogActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveContent <> nil)
									and (GikoForm.GetActiveContent.IsLogFile);
end;
// *************************************************************************
//! TActionでActiveListがTBoard(非特殊板)で有効になる
// *************************************************************************
procedure TGikoDM.DependActiveListTBoardActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveList is TBoard) and
        (GikoForm.GetActiveList <> BoardGroup.SpecialBoard);
end;
// *************************************************************************
//! TActionでActiveListがTBoardで有効になる
// *************************************************************************
procedure TGikoDM.DependActiveListTBoardWithSpeciapActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveList is TBoard);
end;
// *************************************************************************
//! NGワード編集
// *************************************************************************
procedure TGikoDM.EditNGActionExecute(Sender: TObject);
begin
	//テキストに関連付けられたアプリでNGワードファイルをオープン
	if (GikoSys.FAbon.EditNGwords(GikoForm) = True) then
        ReloadAction.Execute;
end;
// *************************************************************************
//! NGワード読み込み（再読み込み）
// *************************************************************************
procedure TGikoDM.ReloadActionExecute(Sender: TObject);
begin
	//リロードを実行　失敗したらメッセージ出力
	if GikoSys.FAbon.ReLoadFromNGwordFile =false then begin
		MsgBox(GikoForm.Handle, 'NGワードファイルの再読み込みに失敗しました',
			MSG_ERROR, MB_OK or MB_ICONEXCLAMATION);
	end else begin
		//全てのタブに再描画を設定
		GikoForm.RepaintAllTabsBrowser();
	end;
end;
// *************************************************************************
//! NGワード読み込み（一つ後ろ）
// *************************************************************************
procedure TGikoDM.GoFowardActionExecute(Sender: TObject);
begin
	//一つ後ろの読み込み　失敗したらメッセージ出力
	if GikoSys.FAbon.GoBack =false then begin
		MsgBox(GikoForm.Handle, '一つ後ろのNGワードファイルの読み込みに失敗しました',
			MSG_ERROR, MB_OK or MB_ICONEXCLAMATION);
	end else begin
		//ステータスに表示されるNGワードファイル名を更新
		RepaintStatusBar;
		//全てのタブに再描画を設定
		GikoForm.RepaintAllTabsBrowser();
	end;
end;
// *************************************************************************
//! NGワード読み込み（一つ前）
// *************************************************************************
procedure TGikoDM.GoBackActionExecute(Sender: TObject);
begin
	//一つ後ろの読み込み　失敗したらメッセージ出力
	if GikoSys.FAbon.GoForward =false then begin
		MsgBox(GikoForm.Handle, '一つ前のNGワードファイルの読み込みに失敗しました',
			MSG_ERROR, MB_OK or MB_ICONEXCLAMATION);
	end else begin
		//ステータスに表示されるNGワードファイル名を更新
		RepaintStatusBar;
		//全てのタブに再描画を設定
		GikoForm.RepaintAllTabsBrowser();
	end;
end;
// *************************************************************************
//! NGワードを変更した後のステータスバーの更新処理
// *************************************************************************
procedure TGikoDM.RepaintStatusBar;
var
	s : String;
begin
	//ステータスに表示されるNGワードファイル名を更新
	s := GikoSys.FAbon.NGwordname;
	GikoForm.StatusBar.Panels.Items[GiKo.NGWORDNAME_PANEL].Text := s;
	//ステータスの表示サイズのリサイズ
	GikoForm.StatusBar.Panels[GiKo.NGWORDNAME_PANEL].Width
		:= Max(GikoForm.StatusBar.Canvas.TextWidth(s), 100);
	GikoForm.StatusBarResize(nil);
end;
// *************************************************************************
//! アドレスバーに表示しているアドレスへ移動する
// *************************************************************************
procedure TGikoDM.MoveToActionExecute(Sender: TObject);
begin
	//アドレスコンボボックスからURLを取得
	//URLに移動
    MoveURLWithHistory( Trim(GikoForm.AddressComboBox.Text) );
end;
// *************************************************************************
//! お気に入りの追加ダイアログを開く
// *************************************************************************
procedure TGikoDM.FavoriteAddActionExecute(Sender: TObject);
begin
	GikoForm.ShowFavoriteAddDialog(GikoForm.GetActiveContent);
end;
// *************************************************************************
//! お気に入りの整理ダイアログを開く
// *************************************************************************
procedure TGikoDM.FavoriteArrangeActionExecute(Sender: TObject);
var
	Dlg: TFavoriteArrangeDialog;
begin
	Dlg := TFavoriteArrangeDialog.Create(GikoForm);
	try
		Dlg.ShowModal;
	finally
		Dlg.Release;
	end;
	//リンクバーに更新を伝える
	PostMessage( GikoForm.Handle, USER_SETLINKBAR, 0, 0 );
end;
// *************************************************************************
//! ツリーを全て閉じる
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewCollapseActionExecute(Sender: TObject);
var
	node	: TTreeNode;
begin
	node := GikoForm.FavoriteTreeViewUC.Items.GetFirstNode;
	try
		//ノードが続く限り　ノードを縮小させる
		while node <> nil do begin
			if node.HasChildren then
				node.Expanded := False;
			node := node.GetNext;
		end;
	except
	end;
end;
// *************************************************************************
//! お気に入りの名前を編集する
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewRenameActionExecute(Sender: TObject);
var
	node : TTreeNode;
begin

	if GikoForm.ClickNode = nil then
		Exit;
	if GikoForm.ClickNode.IsFirstNode then
		Exit;
	if GikoForm.ClickNode.Text = Favorite.FAVORITE_LINK_NAME then
		Exit;
	GikoForm.FavoriteTreeViewUC.ReadOnly := False;
	if (GikoForm.TreeType = gttFavorite) and (GikoForm.CabinetPanel.Visible) then begin
		node := GikoForm.ClickNode.Parent;
		while node <> nil do begin
			node.Expanded	:= True;
			node					:= node.Parent;
		end;
		GikoForm.ClickNode.EditText;
	end else begin
		GikoForm.ClickNode.Text := InputBox( '名前の変更', 'お気に入りの新しい名前を入力してください', GikoForm.ClickNode.Text );
	end;
	//更新したことを教える
	FavoriteDM.Modified := true;
	GikoForm.SetLinkBar;
end;
// *************************************************************************
//! 新しくお気に入りにフォルダを作成する
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewNewFolderActionExecute(Sender: TObject);
var
	NewFavFolder: TFavoriteFolder;
	Node: TTntTreeNode;
begin

	if GikoForm.ClickNode = nil then
		Exit;

	try
		if not (TObject(GikoForm.ClickNode.Data) is TFavoriteFolder) then begin
			TTreeView(GikoForm.FavoriteTreeViewUC).Selected := GikoForm.ClickNode.Parent;
			GikoForm.ClickNode := GikoForm.ClickNode.Parent;
		end;

		NewFavFolder := TFavoriteFolder.Create;
		Node := GikoForm.FavoriteTreeViewUC.Items.AddChildObject(GikoForm.ClickNode, '新しいフォルダ', NewFavFolder);
		Node.ImageIndex := 14;
		Node.SelectedIndex := 14;
	//			FClickNode.Selected.Expanded := True;
		GikoForm.FavoriteTreeViewUC.Selected := Node;
		GikoForm.ClickNode := Node;
		//更新したことを教える
		FavoriteDM.Modified := true;
		FavoriteTreeViewRenameAction.Execute;
	finally
	end;

end;
// *************************************************************************
//! このお気に入りを削除する
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewDeleteActionExecute(Sender: TObject);
const
	DEL_LINK_MSG = '“リンク”はリンクバー用フォルダです。削除してよろしいですか？';
	DEL_MSG = '“^0”を削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
begin

	if GikoForm.ClickNode = nil then
		Exit;
	if GikoForm.ClickNode.IsFirstNode then
		Exit;
	if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then begin
		if GikoForm.ClickNode.Text = Favorite.FAVORITE_LINK_NAME then begin
			if MsgBox(GikoForm.Handle, DEL_LINK_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
				Exit;
		end else begin
			if MsgBox(GikoForm.Handle, StringReplace( DEL_MSG, '^0', GikoForm.ClickNode.Text, [rfReplaceAll] ) , DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
				Exit;
		end;
	end;

	GikoForm.ClickNode.Delete;
	//更新したことを教える
	FavoriteDM.Modified := true;

	GikoForm.SetLinkBar;

end;
// *************************************************************************
//! このフォルダに入っているお気に入りを全て開く
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewBrowseFolderActionExecute(
  Sender: TObject);
begin
	GikoForm.FavoriteBrowseFolder( GikoForm.ClickNode );
end;
// *************************************************************************
//! 選択されているお気に入りをダウンロードする
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewReloadActionExecute(Sender: TObject);
var
	FavThread: TFavoriteThreadItem;
	FavBoard: TFavoriteBoardItem;
	shiftDown: Boolean;
begin
	if (GikoForm.ClickNode = nil) then Exit;

	shiftDown := GetAsyncKeyState(VK_SHIFT) = Smallint($8001);

	if TObject( GikoForm.ClickNode.Data ) is TFavoriteThreadItem then begin
		FavThread := TFavoriteThreadItem( GikoForm.ClickNode.Data );
		if FavThread.Item <> nil then
			GikoForm.DownloadContent(FavThread.Item, shiftDown);
	end else if TObject( GikoForm.ClickNode.Data ) is TFavoriteBoardItem then begin
		FavBoard := TFavoriteBoardItem( GikoForm.ClickNode.Data );
		GikoForm.DownloadList(FavBoard.Item, shiftDown);
	end;

end;
// *************************************************************************
//! 選択されているお気に入りのURLをコピーする
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewURLCopyActionExecute(Sender: TObject);
begin

	if GikoForm.ClickNode = nil then Exit;

	if (TObject(GikoForm.ClickNode.Data) is TFavoriteItem) then begin
		Clipboard.AsText := TFavoriteItem( GikoForm.ClickNode.Data ).URL + #13#10;
	end;
end;
// *************************************************************************
//! 選択されているお気に入りの名前をコピーする
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewNameCopyActionExecute(Sender: TObject);
begin

	if GikoForm.ClickNode = nil then Exit;

	if (TObject(GikoForm.ClickNode.Data) is TFavoriteItem) then begin
		SetClipboardFromEncAnsi(
			TFavoriteItem(GikoForm.ClickNode.Data).GetItemTitle + #13#10);
	end else begin
		SetClipboardFromEncAnsi(
			GikoForm.ClickNode.Text + #13#10);
	end;
end;
// *************************************************************************
//! 選択されているお気に入りの名前とURLをコピーする
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewNameURLCopyActionExecute(
  Sender: TObject);
var
	favItem : TFavoriteItem;
begin

	if GikoForm.ClickNode = nil then Exit;

	if (TObject(GikoForm.ClickNode.Data) is TFavoriteItem) then begin
		favItem := TFavoriteItem(GikoForm.ClickNode.Data);
		SetClipboardFromEncAnsi(favItem.GetItemTitle  + #13#10 +
														favItem.URL + #13#10);
	end;

end;
// *************************************************************************
//! 選択されているお気に入りスレッドを削除する
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewLogDeleteActionExecute(Sender: TObject);
const
	DEL_MSG = '“^0”のログを削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
var
	ThreadItem: TThreadItem;
	FavThread: TFavoriteThreadItem;
begin

	if GikoForm.ClickNode = nil then Exit;
	if not (TObject(GikoForm.ClickNode.Data) is TFavoriteThreadItem) then Exit;

	FavThread := TFavoriteThreadItem( GikoForm.ClickNode.Data );
	ThreadItem := FavThread.Item;

	try
		if GikoSys.Setting.DeleteMsg then begin
			if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then
				if MsgBox(GikoForm.Handle, StringReplace( DEL_MSG, '^0', GikoForm.ClickNode.Text, [rfReplaceAll] ) , DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
					Exit;
		end;

		GikoForm.DeleteHistory(ThreadItem);
		GikoForm.DeleteTab(ThreadItem);
		ThreadItem.DeleteLogFile;

		GikoForm.ListViewUC.Refresh;
	finally
	end;

end;
// *************************************************************************
//! 現在表示しているスレッドをブラウザで表示する
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewBrowseThreadActionExecute(
  Sender: TObject);
var
	threadItem	: TThreadItem;
begin

	if GikoForm.ClickNode = nil then Exit;

	if (TObject(GikoForm.ClickNode.Data) is TFavoriteThreadItem) then begin

		threadItem := TFavoriteThreadItem( GikoForm.ClickNode.Data ).Item;
		if threadItem = nil then
			Exit;
		GikoSys.OpenBrowser( threadItem.URL, gbtAuto );

	end;
end;
//! レスの絞込みフィルターを空にする
procedure TGikoDM.ClearResFilter;
var
	FilterList : TStringList;
begin
	// フィルタ文字列を空にする
	FilterList := TStringList.Create;
	try
		GikoSys.FSelectResFilter.LoadFromStringList( FilterList );
		GikoSys.FSelectResFilter.Reverse := False;
	finally
		FilterList.Free;
	end;
	GikoForm.SelectResWord := '';
end;
// *************************************************************************
//! レスの表示範囲を設定する
// *************************************************************************
procedure TGikoDM.SetResRange(range: Integer);
begin
	if GikoSys.ResRange <> range then begin
		GikoSys.ResRange	:= range;
		// フィルタ文字列を空にする
		ClearResFilter;
		GikoForm.RepaintAllTabsBrowser();
	end;
end;
// *************************************************************************
//! 最新100レスのみ表示
// *************************************************************************
procedure TGikoDM.OnlyAHundredResActionExecute(Sender: TObject);
begin
	if (GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil)
		and (GikoForm.ActiveContent.Browser.Busy) then Exit;

	GikoForm.ResRangeMenuSelect 	:= 100;
	OnlyAHundredResAction.Checked	:= True;
	//　表示範囲を設定する。設定値からとってくる。
    SetResRange(GikoSys.Setting.ResRangeExCount);
end;
// *************************************************************************
//! 未読レスのみ表示
// *************************************************************************
procedure TGikoDM.OnlyKokoResActionExecute(Sender: TObject);
begin
	if (GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil)
		and (GikoForm.ActiveContent.Browser.Busy) then Exit;

	GikoForm.ResRangeMenuSelect	:= Ord( grrKoko );
	OnlyKokoResAction.Checked	:= True;

	//　表示範囲を設定する
	SetResRange(Ord( grrKoko ));
end;
// *************************************************************************
//! 新着レスのみ表示
// *************************************************************************
procedure TGikoDM.OnlyNewResActionExecute(Sender: TObject);
begin
	if (GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil)
		and (GikoForm.ActiveContent.Browser.Busy) then Exit;

	GikoForm.ResRangeMenuSelect	:= Ord( grrNew );
	OnlyNewResAction.Checked	:= True;

	//　表示範囲を設定する
	SetResRange(Ord( grrNew ));
end;
// *************************************************************************
//! スレッド表示エリア通常表示にする 注)ListOrientation = gloHorizontal　
// *************************************************************************
procedure TGikoDM.SetThreadAreaHorNormal;
begin
	//通常表示にする
	GikoForm.ViewPanel.Width := GikoForm.BrowserSizeWidth;
	BrowserMaxAction.ImageIndex := TOOL_ICON_WIDTH_MAX;
	BrowserMinAction.ImageIndex := TOOL_ICON_WIDTH_MIN;
	GikoSys.Setting.ListWidthState := glsNormal;
end;
// *************************************************************************
//! スレッド表示エリア最大/最小表示にする 注)ListOrientation = gloHorizontal　
// *************************************************************************
procedure TGikoDM.SetThreadAreaHorizontal(gls : TGikoListState);
begin
	if GikoSys.Setting.ListWidthState = glsNormal then
		GikoForm.BrowserSizeWidth := GikoForm.ViewPanel.Width;
	//最大表示
	if (gls = glsMax) then begin
		GikoForm.ViewPanel.Width := 1;
		BrowserMaxAction.ImageIndex := TOOL_ICON_WIDTH_NORMAL;
		BrowserMinAction.ImageIndex := TOOL_ICON_WIDTH_MIN;
		GikoSys.Setting.ListWidthState := glsMax;
	end else if (gls = glsMin) then begin
		GikoForm.ViewPanel.Width := GikoForm.ThreadMainPanel.Width - 80;
		BrowserMaxAction.ImageIndex := TOOL_ICON_WIDTH_MAX;
		BrowserMinAction.ImageIndex := TOOL_ICON_WIDTH_NORMAL;
		GikoSys.Setting.ListWidthState := glsMin;
	end;
end;
// *************************************************************************
//! スレッド表示エリア通常表示にする 注)ListOrientation = gloVertical
// *************************************************************************
procedure TGikoDM.SetThreadAreaVerNormal;
begin
	//通常表示にする
	GikoForm.ViewPanel.Height := GikoForm.BrowserSizeHeight;
	BrowserMaxAction.ImageIndex := TOOL_ICON_HEIGHT_MAX;
	BrowserMinAction.ImageIndex := TOOL_ICON_HEIGHT_MIN;
	GikoSys.Setting.ListHeightState := glsNormal;
end;
// *************************************************************************
//! スレッド表示エリア最大/最小表示にする 注)ListOrientation = gloVertical
// *************************************************************************
procedure TGikoDM.SetThreadAreaVertical(gls : TGikoListState);
begin
	if GikoSys.Setting.ListHeightState = glsNormal then
		GikoForm.BrowserSizeHeight := GikoForm.ViewPanel.Height;
	if (gls = glsMin) then begin
		GikoForm.ViewPanel.Height := GikoForm.ThreadMainPanel.Height - GikoForm.BrowserCoolBar.Height - 7;
		BrowserMaxAction.ImageIndex := TOOL_ICON_HEIGHT_MAX;
		BrowserMinAction.ImageIndex := TOOL_ICON_HEIGHT_NORMAL;
		GikoSys.Setting.ListHeightState := glsMin;
	end else if (gls = glsMax) then begin
		GikoForm.ViewPanel.Height := 1;
		BrowserMaxAction.ImageIndex := TOOL_ICON_HEIGHT_NORMAL;
		BrowserMinAction.ImageIndex := TOOL_ICON_HEIGHT_MIN;
		GikoSys.Setting.ListHeightState := glsMax;
	end;
end;
// *************************************************************************
//! スレッド表示エリアを大きく表示する
// *************************************************************************
procedure TGikoDM.BrowserMaxActionExecute(Sender: TObject);
begin
	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		case GikoSys.Setting.ListWidthState of
			glsMax: begin
				//通常表示にする
				SetThreadAreaHorNormal;
			end;
			glsMin, glsNormal: begin
				//最大表示にする
				SetThreadAreaHorizontal(glsMax);
			end;
		end;
	end else begin
		case GikoSys.Setting.ListHeightState of
			glsMax: begin
				//通常表示にする
				SetThreadAreaVerNormal;
			end;
			glsMin, glsNormal: begin
				//最大表示にする
				SetThreadAreaVertical(glsMax);
			end;
		end;
	end;
end;
// *************************************************************************
//! スレッド表示エリアを小さく表示する
// *************************************************************************
procedure TGikoDM.BrowserMinActionExecute(Sender: TObject);
begin
	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		case GikoSys.Setting.ListWidthState of
			glsMax, glsNormal: begin
				//最小表示にする
				SetThreadAreaHorizontal(glsMin);
			end;
			glsMin: begin
				//通常表示にする
				SetThreadAreaHorNormal;
			end;
		end;
	end else begin
		case GikoSys.Setting.ListHeightState of
			glsMax, glsNormal: begin
				//最小表示にする
				SetThreadAreaVertical(glsMin);
			end;
			glsMin: begin
				//通常表示にする
				SetThreadAreaVerNormal;
			end;
		end;
	end;
end;
// *************************************************************************
//! 現在表示しているスレッドの先頭へ移動する
// *************************************************************************
procedure TGikoDM.ScrollTopActionExecute(Sender: TObject);
begin
	GikoForm.BrowserMovement('top');
end;
// *************************************************************************
//! 現在表示しているスレッドの最後へ移動する
// *************************************************************************
procedure TGikoDM.ScrollLastActionExecute(Sender: TObject);
begin
	GikoForm.BrowserMovement('bottom');
end;
// *************************************************************************
//! 現在表示しているスレッドの新着へ移動する
// *************************************************************************
procedure TGikoDM.ScrollNewActionExecute(Sender: TObject);
begin
	GikoForm.BrowserMovement('new');
end;
// *************************************************************************
//! 現在表示しているスレッドのココまで読んだへ移動する
// *************************************************************************
procedure TGikoDM.ScrollKokoActionExecute(Sender: TObject);
begin
	GikoForm.BrowserMovement('koko');
end;
// *************************************************************************
//! 現在表示しているスレッドのココまで読んだへ移動するのUpdateイベント
// *************************************************************************
procedure TGikoDM.ScrollKokoActionUpdate(Sender: TObject);
begin
	ScrollKokoAction.Enabled := (GikoForm.GetActiveContent <> nil)
								and (GikoForm.GetActiveContent.IsLogFile)
								and (GikoForm.GetActiveContent.Kokomade <> -1);
end;
// *************************************************************************
//! レス書き込みウィンドウを表示する
// *************************************************************************
procedure TGikoDM.EditorActionExecute(Sender: TObject);
var
	Editor: TEditorForm;
	Item: TThreadItem;
begin
	Item := GikoForm.GetActiveContent;
	if Item = nil then Exit;
	Editor := TEditorForm.Create(GikoForm.GetMainForm);
	Editor.SetThreadItem(Item);
	Editor.Show;
    Editor.SetFocusEdit;
end;
// *************************************************************************
//! スレをブラウザで表示する
// *************************************************************************
procedure TGikoDM.IEActionExecute(Sender: TObject);
begin
	ShowThreadAction.Execute;
end;
// *************************************************************************
//! 現在表示しているスレッドをブラウザで表示する
// *************************************************************************
procedure TGikoDM.ShowThreadActionExecute(Sender: TObject);
var
	ThreadItem: TThreadItem;
begin
	ThreadItem := GikoForm.GetActiveContent;
	if ThreadItem = nil then Exit;
	GikoSys.OpenBrowser(ThreadItem.URL, gbtAuto);
end;
// *************************************************************************
//! 現在表示しているスレッドの板をブラウザで表示する
// *************************************************************************
procedure TGikoDM.ShowBoardActionExecute(Sender: TObject);
var
	ThreadItem: TThreadItem;
begin
	ThreadItem := GikoForm.GetActiveContent;
	if ThreadItem = nil then Exit;
	GikoSys.OpenBrowser(ThreadItem.ParentBoard.URL, gbtAuto);
end;
// *************************************************************************
//! 現在表示しているスレッドのURLをコピーする
// *************************************************************************
procedure TGikoDM.URLCopyActionExecute(Sender: TObject);
var
	s: string;
begin
	s := '';
	if TObject(GikoForm.GetActiveContent) is TBoard then
		s := s + TBoard(GikoForm.GetActiveContent).URL + #13#10
	else if TObject(GikoForm.GetActiveContent) is TThreadItem then
		s := s + TThreadItem(GikoForm.GetActiveContent).URL + #13#10;
	if s <> '' then
		Clipboard.AsText := s;
end;
// *************************************************************************
//! 現在表示しているスレッド名をコピーする
// *************************************************************************
procedure TGikoDM.NameCopyActionExecute(Sender: TObject);
var
	s: string;
begin
	s := '';
	if TObject(GikoForm.GetActiveContent) is TBoard then
		s := s + TBoard(GikoForm.GetActiveContent).Title + #13#10
	else if TObject(GikoForm.GetActiveContent) is TThreadItem then
		s := s + TThreadItem(GikoForm.GetActiveContent).Title + #13#10;
	if s <> '' then
		SetClipboardFromEncAnsi(s);
end;
// *************************************************************************
//! 現在表示しているスレッド名とURLをコピーする
// *************************************************************************
procedure TGikoDM.NameURLCopyActionExecute(Sender: TObject);
var
	s: string;
begin
	s := '';
	if TObject(GikoForm.GetActiveContent) is TBoard then
		s := s + TBoard(GikoForm.GetActiveContent).Title + #13#10 + TBoard(GikoForm.GetActiveContent).URL + #13#10
	else if TObject(GikoForm.GetActiveContent) is TThreadItem then
		s := s + TThreadItem(GikoForm.GetActiveContent).Title + #13#10 + TThreadItem(GikoForm.GetActiveContent).URL + #13#10;
	if s <> '' then
		SetClipboardFromEncAnsi(s);
end;
// *************************************************************************
//! 表示されているスレッドをダウンロードする
// *************************************************************************
procedure TGikoDM.ItemReloadActionExecute(Sender: TObject);
var
	ThreadItem: TThreadItem;
	shiftDown: Boolean;
begin
	ThreadItem := GikoForm.GetActiveContent;
	shiftDown := GetAsyncKeyState(VK_SHIFT) = Smallint($8001);
	if ThreadItem <> nil then
		GikoForm.DownloadContent(ThreadItem, shiftDown);
end;
// *************************************************************************
//! 現在開いているタブを閉じる
// *************************************************************************
procedure TGikoDM.BrowserTabCloseActionExecute(Sender: TObject);
var
	idx: Integer;
begin
	idx := GikoForm.BrowserTabUC.TabIndex;
	if idx <> -1 then begin
		if GikoForm.BrowserTabUC.Tabs.Objects[idx] <> nil then begin
			GikoForm.DeleteTab(TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[idx]));
		end;
	end;
end;
// *************************************************************************
//! タブが１つ以上あれが有効にするUpdateイベント
// *************************************************************************
procedure TGikoDM.BrowserTabCloseActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 0);
end;
// *************************************************************************
//! 現在開いているタブ以外を閉じる
// *************************************************************************
procedure TGikoDM.NotSelectTabCloseActionExecute(Sender: TObject);
var
	i: Integer;
	idx: Integer;
begin
	idx := GikoForm.BrowserTabUC.TabIndex;
	if idx = -1 then Exit;
	GikoForm.BrowserTabUC.Tabs.BeginUpdate;
	for i := GikoForm.BrowserTabUC.Tabs.Count - 1 downto GikoForm.BrowserTabUC.TabIndex + 1 do begin
		TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[i]).Free;
		GikoForm.BrowserTabUC.Tabs.Delete(i);
	end;
	if idx > 0 then begin
		for i := GikoForm.BrowserTabUC.TabIndex - 1 downto 0 do begin
			TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[i]).Free;
			GikoForm.BrowserTabUC.Tabs.Delete(i);
		end;
	end;
	GikoForm.BrowserTabUC.Tabs.EndUpdate;
end;
// *************************************************************************
//! タブが２つ以上あれが有効にするUpdateイベント
// *************************************************************************
procedure TGikoDM.NotSelectTabCloseActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 1);
end;
// *************************************************************************
//! 全てのタブを閉じる
// *************************************************************************
procedure TGikoDM.AllTabCloseActionExecute(Sender: TObject);
var
	i: Integer;
begin
	if GikoSys.Setting.ShowDialogForAllTabClose then
		if(MessageDlg('全てのタブを閉じてよろしいですか？', mtConfirmation,[mbOk, mbCancel], 0) = mrCancel ) then
			Exit;

	GikoForm.ActiveContent := nil;
	GikoForm.BrowserNullTab.Thread := nil;
	GikoForm.BrowserTabUC.OnChange := nil;
	GikoForm.BrowserTabUC.Tabs.BeginUpdate;
	for i := GikoForm.BrowserTabUC.Tabs.Count - 1 downto 0 do begin
		TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[i]).Free;
	end;
	GikoForm.BrowserTabUC.Tabs.Clear;
	GikoForm.BrowserTabUC.Tabs.EndUpdate;
	GikoForm.BrowserTabUC.OnChange := GikoForm.BrowserTabChange;
	GikoForm.SetContent(GikoForm.BrowserNullTab);
	GikoForm.SetFormCaption('');
end;
// *************************************************************************
//! 現在開いているタブのスレッドを削除する
// *************************************************************************
procedure TGikoDM.ActiveLogDeleteActionExecute(Sender: TObject);
const
	DEL_MSG = '“^0”のログを削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
var
	idx: Integer;
	ThreadItem: TThreadItem;
begin
	idx := GikoForm.BrowserTabUC.TabIndex;
	if idx <> -1 then begin
		if GikoForm.BrowserTabUC.Tabs.Objects[idx] <> nil then begin
			ThreadItem := TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[idx]).Thread;
			if GikoSys.Setting.DeleteMsg then
				if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then
					if MsgBox(GikoForm.Handle, StringReplace( DEL_MSG, '^0', ThreadItem.Title, [rfReplaceAll] ) , DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
						Exit;
			GikoForm.DeleteTab(TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[idx]));
            GikoForm.DeleteHistory(ThreadItem);
			ThreadItem.DeleteLogFile;
			if ThreadItem.ParentBoard = GikoForm.ActiveList then
				GikoForm.ListViewUC.Refresh;
		end;
	end;
end;
// *************************************************************************
//! 一番左のタブを選択する
// *************************************************************************
procedure TGikoDM.LeftmostTabSelectActionExecute(Sender: TObject);
begin
	if GikoForm.BrowserTabUC.Tabs.Count > 0 then begin
		GikoForm.BrowserTabUC.TabIndex := 0;
		GikoForm.BrowserTabUC.OnChange(nil);
	end;
end;
// *************************************************************************
//! 左のタブを選択するのUpdateイベント
// *************************************************************************
procedure TGikoDM.LeftTabSelectActionUpdate(Sender: TObject);
begin
    if ( not GikoSys.Setting.LoopBrowserTabs ) then begin
        LeftmostTabSelectActionUpdate(Sender);
    end else begin
        TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 1);
    end;
end;

// *************************************************************************
//! タブの数が１以上で、タブのインデックスが０以外で有効になるUpdateイベント
// *************************************************************************
procedure TGikoDM.LeftmostTabSelectActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 0)
								and (GikoForm.BrowserTabUC.TabIndex <> 0);
end;
// *************************************************************************
//! 左のタブを選択する
// *************************************************************************
procedure TGikoDM.LeftTabSelectActionExecute(Sender: TObject);
begin
	if GikoForm.BrowserTabUC.Tabs.Count > 0 then begin
		if GikoForm.BrowserTabUC.TabIndex = -1 then begin
			GikoForm.BrowserTabUC.TabIndex := 0;
			GikoForm.BrowserTabUC.OnChange(nil);
		end else if GikoForm.BrowserTabUC.TabIndex > 0 then begin
			GikoForm.BrowserTabUC.TabIndex := GikoForm.BrowserTabUC.TabIndex - 1;
			GikoForm.BrowserTabUC.OnChange(nil);
		end else begin
            if (GikoSys.Setting.LoopBrowserTabs) and
                (GikoForm.BrowserTabUC.TabIndex = 0) then begin
    			GikoForm.BrowserTabUC.TabIndex := GikoForm.BrowserTabUC.Tabs.Count - 1;
	    		GikoForm.BrowserTabUC.OnChange(nil);
            end;
        end;
	end;
end;
// *************************************************************************
//! 右のタブを選択する
// *************************************************************************
procedure TGikoDM.RightTabSelectActionExecute(Sender: TObject);
begin
	if GikoForm.BrowserTabUC.Tabs.Count > 0 then begin
		if GikoForm.BrowserTabUC.TabIndex = -1 then begin
			GikoForm.BrowserTabUC.TabIndex := GikoForm.BrowserTabUC.Tabs.Count - 1;
			GikoForm.BrowserTabUC.OnChange(nil);
		end else if GikoForm.BrowserTabUC.TabIndex < (GikoForm.BrowserTabUC.Tabs.Count - 1) then begin
			GikoForm.BrowserTabUC.TabIndex := GikoForm.BrowserTabUC.TabIndex + 1;
			GikoForm.BrowserTabUC.OnChange(nil);
		end else begin
            if (GikoSys.Setting.LoopBrowserTabs) and
                (GikoForm.BrowserTabUC.TabIndex = (GikoForm.BrowserTabUC.Tabs.Count - 1)) then begin
    			GikoForm.BrowserTabUC.TabIndex := 0;
	    		GikoForm.BrowserTabUC.OnChange(nil);
            end;
        end;
	end;
end;
// *************************************************************************
//! 右のタブを選択するUpdateイベント
// *************************************************************************
procedure TGikoDM.RightTabSelectActionUpdate(Sender: TObject);
begin
    if ( not GikoSys.Setting.LoopBrowserTabs ) then begin
        RightmostTabSelectActionUpdate(Sender);
    end else begin
        TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 1);
    end;
end;

// *************************************************************************
//! 一番右のタブを選択する
// *************************************************************************
procedure TGikoDM.RightmostTabSelectActionExecute(Sender: TObject);
begin
	if GikoForm.BrowserTabUC.Tabs.Count > 0 then begin
		GikoForm.BrowserTabUC.TabIndex := GikoForm.BrowserTabUC.Tabs.Count - 1;
		GikoForm.BrowserTabUC.OnChange(nil);
	end;
end;
// *************************************************************************
//! 一番右のタブを選択するのUpdateイベント
// *************************************************************************
procedure TGikoDM.RightmostTabSelectActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 0)
								and (GikoForm.BrowserTabUC.TabIndex <> GikoForm.BrowserTabUC.Tabs.Count - 1);

end;
// *************************************************************************
//! 選択されているスレッドをお気に入りに追加
// *************************************************************************
procedure TGikoDM.ThreadFavoriteAddActionExecute(Sender: TObject);
begin
	if TObject(GikoForm.ListViewUC.Selected.Data) is TThreadItem then
		GikoForm.ShowFavoriteAddDialog(TObject(GikoForm.ListViewUC.Selected.Data));
end;
// *************************************************************************
//! スレッド一覧で、スレが１つ以上選択されている有効になるUpdateイベント
// *************************************************************************
procedure TGikoDM.ThreadFavoriteAddActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveList is TBoard)
									and (GikoForm.ListViewUC.SelCount > 0);
end;
// *************************************************************************
//! レスの内容を絞り込む
// *************************************************************************
procedure TGikoDM.SelectResActionExecute(Sender: TObject);
var
	Dlg: TListSelectDialog;
	FilterList : TStringList;
	idx : Integer;
begin
	Dlg := TListSelectDialog.Create(GikoForm);
	try
		Dlg.SelectComboBoxUC.Items_Assign(GikoSys.Setting.SelectTextList);
		Dlg.SelectComboBoxUC.Text := GikoForm.SelectResWord;
		Dlg.ShowModal;
		if Dlg.ModalResult = mrOK then begin
			SelectResAction.Checked := True;
			if Length( Dlg.SelectComboBoxUC.Text ) = 0 then begin
				// 空入力で OK は絞り込み解除と同意義
				ResRangeAction.Execute;
			end else begin
				GikoSys.ResRange := Ord( grrSelect );

				// 最後に設定したものを覚えておく
				GikoForm.SelectResWord := Dlg.SelectComboBoxUC.Text;

				// 検索履歴の更新
				idx := GikoSys.Setting.SelectTextList.IndexOf(Dlg.SelectComboBoxUC.EncodeText);
				if idx <> -1 then
					GikoSys.Setting.SelectTextList.Delete(idx);
				GikoSys.Setting.SelectTextList.Insert(0, Dlg.SelectComboBoxUC.EncodeText);
				while Dlg.SelectComboBoxUC.Items.Count > 100 do begin
					Dlg.SelectComboBoxUC.Items.Delete(Dlg.SelectComboBoxUC.Items.Count - 1);
				end;

				try
					if GikoForm.SelectComboBoxPanel.Visible then
						GikoForm.SelectComboBoxUC.Items_Assign( GikoSys.Setting.SelectTextList );
				except
				end;

				// フィルタの設定
				FilterList := TStringList.Create;
				try
					GikoSys.FSelectResFilter.Reverse := True;
					FilterList.Delimiter := ' '; //区切り子を半角スペースに設定
					FilterList.DelimitedText := Dlg.SelectComboBoxUC.EncodeText;

					GikoSys.FSelectResFilter.LoadFromStringList( FilterList );
				finally
					FilterList.Free;
				end;
				GikoForm.RepaintAllTabsBrowser();
			end;
		end else begin
			// キャンセル
			if GikoSys.ResRange <> Ord( grrSelect ) then
				ResRangeAction.Execute;
		end;
	finally
		Dlg.Release;
	end;

end;
// *************************************************************************
//! 全てのレスを表示する
// *************************************************************************
procedure TGikoDM.AllResActionExecute(Sender: TObject);
begin
	if(GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil )
		and (GikoForm.ActiveContent.Browser.Busy) then Exit;

	GikoForm.ResRangeMenuSelect	:= Ord( grrAll );
	AllResAction.Checked		:= True;

	//　表示範囲を設定する
	SetResRange(Ord( grrAll ));
end;
// *************************************************************************
//! レスの表示範囲を設定
// *************************************************************************
procedure TGikoDM.ResRangeActionExecute(Sender: TObject);
begin
	case GikoForm.ResRangeMenuSelect of
	Ord( grrAll ):	AllResAction.Execute;
	Ord( grrKoko ):	OnlyKokoResAction.Execute;
	Ord( grrNew ):	OnlyNewResAction.Execute;
	100:			OnlyAHundredResAction.Execute;
	end;

end;
// *************************************************************************
//! このスレッドを含むスレッド一覧を表示
// *************************************************************************
procedure TGikoDM.UpBoardActionExecute(Sender: TObject);
begin
	GikoForm.SelectTreeNode( GikoForm.GetActiveContent.ParentBoard, True );
end;
// *************************************************************************
//! 指定した番号のレスに飛ぶ
// *************************************************************************
procedure TGikoDM.JumpToNumOfResActionExecute(Sender: TObject);
var
	str: string;
	res: integer;
begin
	str := '1';
	if( InputQuery('指定した番号のレスに飛ぶ', '番号を入力してください', str) ) then begin
		str := ZenToHan(str);
		res := StrToIntDef(str, -1);
		if (res > 0) and (res <= GikoForm.GetActiveContent.Count) then begin
			GikoForm.ActiveContent.Move(IntToStr(res));
			SetFocusForBrowserAction.Execute;
		end else if res > GikoForm.GetActiveContent.Count then begin
			GikoForm.ActiveContent.Move(IntToStr(GikoForm.GetActiveContent.Count));
			SetFocusForBrowserAction.Execute;
		end;
	end;
end;
// *************************************************************************
//! アクティブなタブより右を閉じる
// *************************************************************************
procedure TGikoDM.RightTabCloseActionExecute(Sender: TObject);
var
	i: Integer;
	idx: Integer;
begin
	idx := GikoForm.BrowserTabUC.TabIndex;
	if idx = -1 then Exit;
	GikoForm.BrowserTabUC.Tabs.BeginUpdate;
	for i := GikoForm.BrowserTabUC.Tabs.Count - 1 downto idx + 1 do begin
		TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[i]).Free;
		GikoForm.BrowserTabUC.Tabs.Delete(i);
	end;
	GikoForm.BrowserTabUC.Tabs.EndUpdate;
end;
// *************************************************************************
//! タブの数が２以上で有効なUpdateイベント
// *************************************************************************
procedure TGikoDM.RightTabCloseActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 1);
end;
// *************************************************************************
//! アクティブなタブより左を閉じる
// *************************************************************************
procedure TGikoDM.LeftTabCloseActionExecute(Sender: TObject);
var
	i: Integer;
	idx: Integer;
begin
	idx := GikoForm.BrowserTabUC.TabIndex;
	if idx = -1 then Exit;
	GikoForm.BrowserTabUC.Tabs.BeginUpdate;
	if idx > 0 then begin
		for i := idx - 1 downto 0 do begin
			TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[i]).Free;
			GikoForm.BrowserTabUC.Tabs.Delete(i);
		end;
	end;
	GikoForm.BrowserTabUC.Tabs.EndUpdate;
end;
////////////////////////////////スレッドまでおしまい/////////////////////
procedure TGikoDM.DataModuleCreate(Sender: TObject);
begin
    // GikoDMよりも早く初期化される必要があるファイルがいるとこける！！
    // 初期化順番に注意すること！！
    //初回起動時の初期化ファイル設定
    TDefaultFileManager.CopyDefaultFiles(GikoSys.Setting.GetDefaultFilesFileName);
end;
// *************************************************************************
//! ログ検索ダイアログを表示する
// *************************************************************************
procedure TGikoDM.SearchActionExecute(Sender: TObject);
var
	chk: TObject;
begin

	if GikoForm.SearchDialog = nil then begin
		if (GikoForm.GetActiveList is TCategory) or (GikoForm.GetActiveList is TBoard) then
			chk := GikoForm.GetActiveList
		else
			chk := nil;

		GikoForm.SearchDialog := TSearchDialog.Create(GikoForm, chk);
		GikoForm.SearchDialog.SearchComboBox.Items.Assign( GikoSys.Setting.SelectTextList );
	end;

	try
		GikoForm.SearchDialog.Show;
	except
	end;
end;
// *************************************************************************
//! オプションダイアログを表示する
// *************************************************************************
procedure TGikoDM.OptionActionExecute(Sender: TObject);
var
	Dlg: TOptionDialog;
begin
	Dlg := TOptionDialog.Create(GikoForm);
	try
		Dlg.ShowModal;
	finally
		Dlg.Release;
	end;
end;
// *************************************************************************
//! 巡回ダイアログを表示する
// *************************************************************************
procedure TGikoDM.RoundActionExecute(Sender: TObject);
var
	Dlg: TRoundDialog;
begin
	Dlg := TRoundDialog.Create(GikoForm);
	try
		Dlg.ShowModal;
	finally
		Dlg.Release;
	end;
end;
// *************************************************************************
//! キー設定ダイアログを開く
// *************************************************************************
procedure TGikoDM.KeySettingActionExecute(Sender: TObject);
var
	Dlg: TKeySettingForm;
begin
	Dlg := TKeySettingForm.Create(GikoForm);
	try
		if Dlg.ShowModal = mrOk then begin
			GikoSys.SaveKeySetting(GikoFormActionList, Setting.KEY_SETTING_FILE_NAME);
			GikoSys.SaveKeySetting(Dlg.EditorForm.ActionList, Setting.EKEY_SETTING_FILE_NAME);
			GikoSys.Setting.Gestures.SaveGesture( GikoSys.Setting.GetGestureFileName );
		end;

	finally
		Dlg.Release;
		MouseGesture.UnHook;
		MouseGesture.OnGestureStart := GikoForm.OnGestureStart;
		MouseGesture.OnGestureMove := GikoForm.OnGestureMove;
		MouseGesture.OnGestureEnd := GikoForm.OnGestureEnd;
		if GikoSys.Setting.GestureEnabled then begin
			GikoSys.Setting.Gestures.ClearGesture;
			GikoSys.Setting.Gestures.LoadGesture(
				GikoSys.Setting.GetGestureFileName, GikoFormActionList );
			MouseGesture.SetHook( GikoForm.Handle );
		end;
	end;
end;
// *************************************************************************
//! キー設定ダイアログを開く
// *************************************************************************
procedure TGikoDM.KotehanActionExecute(Sender: TObject);
var
	Dlg: TKotehanDialog;
begin
	Dlg := TKotehanDialog.Create(GikoForm);
	try
		Dlg.ShowModal;
	finally
		Dlg.Release;
	end;
end;
// *************************************************************************
//! ツールバー設定ダイアログを開く
// *************************************************************************
procedure TGikoDM.ToolBarSettingActionExecute(Sender: TObject);
var
	Dlg: TToolBarSettingDialog;
	i: Integer;
begin
	Dlg := TToolBarSettingDialog.Create(GikoForm, GikoFormActionList);
	try
		Dlg.AddToolBar(GikoForm.StdToolBar, gttStandard);
		Dlg.AddToolBar(GikoForm.ListToolBar, gttList);
		Dlg.AddToolBar(GikoForm.BrowserToolBar, gttBrowser);
		case GikoForm.ToolBarSettingSender of
		tssMain:		Dlg.ToolBarIndex := 0;
		tssList:		Dlg.ToolBarIndex := 1;
		tssBrowser: Dlg.ToolBarIndex := 2;
		end;
		if Dlg.ShowModal = mrOK then begin
			GikoForm.SetToolBarPopup;

			//最適幅を再設定するために適当なプロパティをいじくる
			for i := 0 to GikoForm.MainCoolBar.Bands.Count - 1 do begin
				GikoForm.MainCoolBar.Bands[i].MinWidth :=
					GikoForm.MainCoolBar.Bands[i].MinWidth + 1;
				GikoForm.MainCoolBar.Bands[i].MinWidth :=
					GikoForm.MainCoolBar.Bands[i].MinWidth - 1;
			end;
			for i := 0 to GikoForm.ListCoolBar.Bands.Count - 1 do begin
				GikoForm.ListCoolBar.Bands[i].MinWidth :=
					GikoForm.ListCoolBar.Bands[i].MinWidth + 1;
				GikoForm.ListCoolBar.Bands[i].MinWidth :=
					GikoForm.ListCoolBar.Bands[i].MinWidth - 1;
			end;
			for i := 0 to GikoForm.BrowserCoolBar.Bands.Count - 1 do begin
				GikoForm.BrowserCoolBar.Bands[i].MinWidth :=
					GikoForm.BrowserCoolBar.Bands[i].MinWidth + 1;
				GikoForm.BrowserCoolBar.Bands[i].MinWidth :=
					GikoForm.BrowserCoolBar.Bands[i].MinWidth - 1;
			end;

			SaveToolBarSetting(GikoForm.StdToolBar);
			SaveToolBarSetting(GikoForm.ListToolBar);
			//ListToolBarにいるかもしれない絞込みComboBoxを配置
			GikoForm.SetSelectComboBox;
			GikoForm.ResetBandInfo( GikoForm.ListCoolBar, GikoForm.ListToolBar );
			SaveToolBarSetting(GikoForm.BrowserToolBar);
		end;
	finally
		Dlg.Release;
		GikoForm.ToolBarSettingSender := tssNone;
	end;
end;
// *************************************************************************
//! ミュート
// *************************************************************************
procedure TGikoDM.MuteActionExecute(Sender: TObject);
begin
	GikoSys.Setting.Mute := not GikoSys.Setting.Mute;
end;
////////////////////////////////ツールまでおしまい/////////////////////
// *************************************************************************
//! スレッド一覧をダウンロードする
// *************************************************************************
procedure TGikoDM.TreeSelectBoradReloadExecute(Sender: TObject);
var
	Board: TBoard;
	TmpTreeNode: TTreeNode;
begin
	TmpTreeNode := GikoForm.ClickNode;
	GikoForm.TreeViewUC.Selected := GikoForm.ClickNode;
	Board := nil;

	if TObject(TmpTreeNode.Data) is TBoard then
		Board := TBoard(TmpTreeNode.Data)
	else if TObject(TmpTreeNode.Data) is TFavoriteBoardItem then
		Board := TFavoriteBoardItem(TmpTreeNode.Data).Item;

	if Board <> nil then
		GikoForm.DownloadList(Board);
end;
// *************************************************************************
//! 選択されたスレッドをダウンロードする
// *************************************************************************
procedure TGikoDM.TreeSelectThreadReloadExecute(Sender: TObject);
var
	ThreadItem: TThreadItem;
	TmpTreeNode: TTreeNode;
begin
	TmpTreeNode := GikoForm.ClickNode;
	GikoForm.TreeViewUC.Selected := GikoForm.ClickNode;
	ThreadItem := nil;

	if TObject(TmpTreeNode.Data) is TThreadItem then
		ThreadItem := TThreadItem(TmpTreeNode.Data)
	else if TObject(TmpTreeNode.Data) is TFavoriteThreadItem then
		ThreadItem := TFavoriteThreadItem(TmpTreeNode.Data).Item;

	if ThreadItem <> nil then
		GikoForm.DownloadContent(ThreadItem);
end;
// *************************************************************************
//! 選択された板のURLをコピーする
// *************************************************************************
procedure TGikoDM.TreeSelectURLCopyExecute(Sender: TObject);
var
	TmpTreeNode: TTreeNode;
	s: string;
begin
	TmpTreeNode := GikoForm.ClickNode;
	GikoForm.TreeViewUC.Selected := GikoForm.ClickNode;
	if TObject(TmpTreeNode.Data) is TBoard then begin
		s := TBoard(TmpTreeNode.Data).URL + #13#10;
	end else if TObject(TmpTreeNode.Data) is TFavoriteBoardItem then begin
		s := TFavoriteBoardItem(TmpTreeNode.Data).URL + #13#10;
	end else if (TObject(TmpTreeNode.Data) is TThreadItem) then begin
		s := TThreadItem(TmpTreeNode.Data).URL + #13#10;
	end else if TObject(TmpTreeNode.Data) is TFavoriteThreadItem then begin
		s := TFavoriteThreadItem(TmpTreeNode.Data).URL + #13#10;
	end;
	Clipboard.AsText := s;
end;
// *************************************************************************
//! 選択された板の名前とURLをコピーする
// *************************************************************************
procedure TGikoDM.TreeSelectNameURLCopyExecute(Sender: TObject);
var
	TmpTreeNode: TTreeNode;
	s: string;
begin
	TmpTreeNode := GikoForm.ClickNode;
	GikoForm.TreeViewUC.Selected := GikoForm.ClickNode;
	if TObject(TmpTreeNode.Data) is TBoard then begin
		s := TBoard(TmpTreeNode.Data).Title + #13#10 + TBoard(TmpTreeNode.Data).URL + #13#10;
	end else if TObject(TmpTreeNode.Data) is TFavoriteBoardItem then begin
		s := TFavoriteBoardItem(TmpTreeNode.Data).Item.Title + #13#10 + TFavoriteBoardItem(TmpTreeNode.Data).URL + #13#10;
	end else if (TObject(TmpTreeNode.Data) is TThreadItem) then begin
		s := TThreadItem(TmpTreeNode.Data).Title + #13#10 + TThreadItem(TmpTreeNode.Data).URL + #13#10;
	end else if TObject(TmpTreeNode.Data) is TFavoriteThreadItem then begin
		s := TFavoriteThreadItem(TmpTreeNode.Data).Item.Title + #13#10 + TFavoriteThreadItem(TmpTreeNode.Data).URL + #13#10;
	end;
	SetClipboardFromEncAnsi(s);
end;
// *************************************************************************
//! お気に入りに追加する
// *************************************************************************
procedure TGikoDM.TreeSelectFavoriteAddActionExecute(Sender: TObject);
begin
	GikoForm.ShowFavoriteAddDialog(TObject(GikoForm.ClickNode.Data));
end;
// *************************************************************************
//! 板名検索
// *************************************************************************
procedure TGikoDM.TreeSelectSearchBoardNameExecute(Sender: TObject);
var
	s : String;
	msg : String;
	CurItem : TTreeNode;
	next : boolean;
begin
	if InputQuery('板名検索','板名の入力',s) then begin
		next := true;
		while next do begin
			if GikoForm.TreeViewUC.Selected = nil then
				CurItem := GikoForm.TreeViewUC.Items.GetFirstNode
			else begin
				CurItem := GikoForm.TreeViewUC.Selected.GetNext;
				if CurItem = nil then
					CurItem := GikoForm.TreeViewUC.Items.GetFirstNode;
			end;
			while CurItem <> nil do begin
				if (CurItem.ImageIndex <> 2) and (VaguePos(s,CurItem.Text) <> 0) then begin
					break;
				end;
				CurItem := CurItem.GetNext;
			end;
			try
				if CurItem = nil then begin
					msg := '先頭に戻りますか？';
					if MsgBox(GikoForm.Handle, msg, '', MB_YESNO or MB_ICONEXCLAMATION) = mrYes	then begin
						CurItem := GikoForm.TreeViewUC.Items.GetFirstNode;
					end else begin
						Exit;
					end;
					GikoForm.TreeViewUC.Select(CurItem);
					GikoForm.TreeViewUC.SetFocus;
				end else begin
					GikoForm.TreeViewUC.Select(CurItem);
					GikoForm.TreeViewUC.SetFocus;
					msg := '次に行きますか？';
					if MsgBox(GikoForm.Handle, msg, '', MB_YESNO or MB_ICONEXCLAMATION) = mrYes	then begin
						next := true;
					end else begin
						next := false;
					end;
				end;

			except
				Exit;
			end;
		end;
	end;
end;
// *************************************************************************
//! 選択された板の名前をコピーする
// *************************************************************************
procedure TGikoDM.TreeSelectNameCopyExecute(Sender: TObject);
var
	s: string;
begin
	GikoForm.TreeViewUC.Selected := GikoForm.ClickNode;
	s := GikoForm.ClickNode.Text;
	SetClipboardFromEncAnsi(s);
end;
////////////////////////////////ツリーポップアップまでおしまい/////////////////////
// *************************************************************************
//! ログイン／ログアウトをする
// *************************************************************************
procedure TGikoDM.LoginActionExecute(Sender: TObject);
var
	TmpCursor: TCursor;
//	msg : String;
begin
  if Session5ch = nil then
		Exit;

	if Session5ch.Connected then begin
		//ログアウト
		Session5ch.Disconnect;
		LoginAction.Checked := False;
		GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmLogout), nil, gmiOK);
		LoginAction.Caption := 'ログイン(&L)';
	end else begin
		TmpCursor := GikoForm.ScreenCursor;
		GikoForm.ScreenCursor := crHourGlass;
		try
			//通常ログイン
      if Session5ch.Connect then begin
        LoginAction.Checked := True;
        GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmLogin) + GikoSys.Setting.UserID, nil, gmiOK);
        LoginAction.Caption := 'ログアウト(&L)';
        //LoginToolButton.Style := tbsCheck;
      end else begin
		//			MsgBox(Handle, 'ログイン出来ませんでした', 'エラー', MB_OK or MB_ICONSTOP);
        GikoForm.AddMessageList(Session5ch.ErrorMsg, nil, gmiNG);
        GikoForm.PlaySound('Error');
        LoginAction.Checked := False;
        //LoginToolButton.Down := False;
        ///LoginToolButton.Style := tbsButton;
      end;
		finally
			GikoForm.ScreenCursor := TmpCursor;
		end;
	end;
end;
// *************************************************************************
//! ボード更新ダイアログを表示する
// *************************************************************************
procedure TGikoDM.NewBoardActionExecute(Sender: TObject);
var
	Dlg: TNewBoardDialog;
	Msg: string;
begin
	if (EditorFormExists) then begin
		Msg := 'レスエディタを全て閉じてください';
		MsgBox(GikoForm.Handle, Msg, MSG_ERROR, MB_OK or MB_ICONSTOP);
		Exit;
	end;
	Dlg := TNewBoardDialog.Create(GikoForm);
	try
		Dlg.ShowModal;
	finally
		Dlg.Release;
	end;
end;
// *************************************************************************
//! 選択されているスレッドを削除する
// *************************************************************************
procedure TGikoDM.LogDeleteActionExecute(Sender: TObject);
const
	DEL_MSG = '“^0”のログを削除します。よろしいですか？';
	DEL_SAME_MSG = 'これら ^0 個のスレッドのログを削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
var
	ThreadItem: TThreadItem;
	TmpListItem: TListItem;
	List: TList;
	i: Integer;
begin
	List := TList.Create;
	try
		TmpListItem := GikoForm.ListViewUC.Selected;
		while TmpListItem <> nil do begin
			if TObject(TmpListItem.Data) is TThreadItem then begin
				ThreadItem := TThreadItem(TmpListItem.Data);
				if ThreadItem.IsLogFile then
					List.Add(ThreadItem);
			end;
			TmpListItem := GikoForm.ListViewUC.GetNextItem(TmpListItem, sdAll, [isSelected]);
		end;

		if GikoSys.Setting.DeleteMsg and (List.Count > 0) then begin
			if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then begin
				if List.Count = 1 then begin
					if MsgBox(GikoForm.Handle, StringReplace( DEL_MSG, '^0', TThreadItem( List[ 0 ] ).Title, [rfReplaceAll] ) , DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
						Exit;
				end else begin
					if MsgBox(GikoForm.Handle, StringReplace( DEL_SAME_MSG, '^0', IntToStr( List.Count ), [rfReplaceAll] ), DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> IDYES then
						Exit;
				end;
			end;
		end;

		for i := 0 to List.Count - 1 do begin
			ThreadItem := TThreadItem(List[i]);
			GikoForm.DeleteHistory(ThreadItem);
			GikoForm.DeleteTab(ThreadItem);
			ThreadItem.DeleteLogFile;
		end;
        GikoForm.TreeViewUC.Refresh;	// UnRead の表示を更新
		GikoForm.ListViewUC.Refresh;
	finally
		List.Free;
	end;
end;
// *************************************************************************
//! ActiveListがTBoardでスレ一覧で１つ以上選択していると有効になるActionで共通
// *************************************************************************
procedure TGikoDM.LogDeleteActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveList is TBoard)
								and (GikoForm.ListViewUC.SelCount > 0);
end;
// *************************************************************************
//! 絞込み履歴を消去する
// *************************************************************************
procedure TGikoDM.SelectTextClearActionExecute(Sender: TObject);
const
	DEL_MSG = '絞込み全履歴を削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
begin
	if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then
		if MsgBox(GikoForm.Handle, DEL_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
			Exit;
	GikoSys.Setting.SelectTextList.Clear;
	GikoForm.SelectComboBoxUC.Items.Clear;
	GikoForm.SelectComboBoxUC.Text := '';
	GikoForm.SetListViewType( gvtAll );
end;
// *************************************************************************
//! レスエディタの名前履歴を消去する
// *************************************************************************
procedure TGikoDM.NameTextClearActionExecute(Sender: TObject);
const
	DEL_MSG = 'レスエディタ名前全履歴を削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
begin
	if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then
		if MsgBox(GikoForm.Handle, DEL_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
			Exit;
	GikoSys.Setting.NameList.Clear;
	ClearNameTextAllEditor
end;
// *************************************************************************
//! レスエディタのメール履歴を消去する
// *************************************************************************
procedure TGikoDM.MailTextClearActionExecute(Sender: TObject);
const
	DEL_MSG = 'レスエディタメール全履歴を削除します。よろしいですか？';
	DEL_TITLE = '削除確認';
begin
	if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then
		if MsgBox(GikoForm.Handle, DEL_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
			Exit;
	GikoSys.Setting.MailList.Clear;
	ClearMailAllEditor;
end;
// *************************************************************************
//! ギコナビを終了する
// *************************************************************************
procedure TGikoDM.ExitActionExecute(Sender: TObject);
begin
	GikoForm.Close;
end;
// *************************************************************************
//! お気に入りのエクスポート　実行前処理
// *************************************************************************
procedure TGikoDM.ExportFavoriteFileBeforeExecute(Sender: TObject);
begin
	ExportFavoriteFile.Dialog.FileName := FavoriteDM.GetFavoriteFilePath;
end;
// *************************************************************************
//! お気に入りのエクスポート　実行処理
// *************************************************************************
procedure TGikoDM.ExportFavoriteFileAccept(Sender: TObject);
begin
	if FavoriteDM.SaveFavoriteFile( ExportFavoriteFile.Dialog.FileName ) Then begin
		ShowMessage('ファイルを出力しました');
	end else begin
		ShowMessage('ファイルの出力に失敗しました');
	end;
end;
// *************************************************************************
//! 選択スレッドをファイルに保存する
// *************************************************************************
procedure TGikoDM.SelectThreadSaveToFile(dat: Boolean);
var
	List: TList;
	i: Integer;
	html: TStringList;
	title: string;
begin
	List := TList.Create;
	try
		GikoForm.ScreenCursor := crHourGlass;
		GikoForm.SelectListItem(List);
		if ((GikoSys.Setting.ListOrientation = gloVertical) and
			(GikoSys.Setting.ListHeightState = glsMax)) or
			((GikoSys.Setting.ListOrientation = gloHorizontal) and
			(GikoSys.Setting.ListWidthState = glsMax))	then
			ShowMessage('スレッド一覧を表示してください')
		else if(List.Count = 0) then
			ShowMessage('スレッドを選択してください')
		else begin
			if dat then begin
				SaveDialog.Title := '選択スレッドをdatのまま保存';
				SaveDialog.Filter := 'DATファイル(*.dat)|*.dat';
			end else begin
				SaveDialog.Title := '選択スレッドをHTML化して保存';
				SaveDialog.Filter := 'HTMLファイル(*.html)|*.html';
			end;
			for i := 0 to List.Count - 1 do begin
				if (TObject(List[i]) is TThreadItem) and (TThreadItem(List[i]).IsLogFile) then begin
					if dat then begin
						SaveDialog.FileName := TThreadItem(List[i]).FileName;
					end else begin
						SaveDialog.FileName := ReplaseNoValidateChar(TThreadItem(List[i]).Title) + '.html';
					end;
					if SaveDialog.Execute then begin
						if dat then begin
							CopyFile(PChar(TThreadItem(List[i]).FilePath),
									PChar(SaveDialog.FileName), true);
						end else begin
							html := TStringList.Create;
							title := TThreadItem(List[i]).Title;
							try
								HTMLCreater.CreateHTML3(html, TThreadItem(List[i]), title);
								html.SaveToFile(SaveDialog.FileName);
								THTMLCreate.SkinorCSSFilesCopy(ExtractFilePath(SaveDialog.FileName));
							finally
								html.Free;
							end;
						end;
					end;
				end;
			end;
		end;
	finally
		GikoForm.ScreenCursor := crDefault;
		List.Free;
	end;
end;
// *************************************************************************
//! 選択スレッドをHTML化して保存
// *************************************************************************
procedure TGikoDM.SelectItemSaveForHTMLExecute(Sender: TObject);
begin
	SelectThreadSaveToFile(false);
end;
// *************************************************************************
//! 選択スレッドをDAT形式のまま保存
// *************************************************************************
procedure TGikoDM.SelectItemSaveForDatExecute(Sender: TObject);
begin
	SelectThreadSaveToFile(true);
end;
// *************************************************************************
//! タブの順番を保存
// *************************************************************************
procedure TGikoDM.TabsSaveActionExecute(Sender: TObject);
const
	Filename = 'tab.sav';
	bFilename = '~tab.sav';
var
	SaveStringList: TStringList;
begin
	SaveStringList := TStringList.Create;
	try
		GetTabURLs(SaveStringList);
        try
            if FileExists( GikoSys.GetAppDir + Filename) then begin
                CopyFile(PChar(GikoSys.GetAppDir + Filename),
                    PChar(GikoSys.GetAppDir + bFilename), False);
            end;
        except
        end;
        SaveStringList.SaveToFile(GikoSys.GetAppDir + Filename);
	finally
		SaveStringList.Free;
	end;
end;
// *************************************************************************
//! ブラウザタブに設定されているスレッドのURL取得
// *************************************************************************
procedure TGikoDM.GetTabURLs(AStringList: TStringList);
var
  rec : TBrowserRecord;
  i : Integer;
begin
    for i := 0 to GikoForm.BrowserTabUC.Tabs.Count -1 do begin
        try
            rec := TBrowserRecord( GikoForm.BrowserTabUC.Tabs.Objects[ i ] );
            if( rec <> nil) and (rec.Thread <> nil) then
                AStringList.Add( rec.Thread.URL );
        except
        end;
    end;
end;
// *************************************************************************
//! 指定されたURLを開き，先頭のタブにフォーカスする
// *************************************************************************
procedure TGikoDM.OpenURLs(AStringList: TStringList);
var
    GikoTab			: TGikoTabAppend;
    i, bound : Integer;
   	item        : TThreadItem;
begin
    if (AStringList <> nil) then begin
        GikoTab := GikoSys.Setting.BrowserTabAppend;
        try
            bound    := AStringList.Count - 1;
            if bound > -1 then begin
                GikoSys.Setting.BrowserTabAppend := gtaLast;
                for i := 0 to bound do begin
                    item := BBSsFindThreadFromURL( AStringList[ i ] );
                    if item <> nil then
                        GikoForm.InsertBrowserTab( item, false );
                end;
                //最初の１枚に設定
                if (GikoSys.Setting.URLDisplay) and
                    (GikoForm.BrowserTabUC.Tabs.Count > 0) then begin
					GikoForm.AddressComboBox.Text :=
                        TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[0]).Thread.URL;
                end;
            end;
        finally
            GikoSys.Setting.BrowserTabAppend := GikoTab;
        end;
    end;
end;
// *************************************************************************
//! タブの順番を復元
// *************************************************************************
procedure TGikoDM.TabsOpenActionExecute(Sender: TObject);
const
	TABFILE = 'tab.sav';
var
	URLs				: TStringList;
	fileName		: string;
begin
    URLs := TStringList.Create();
	try
       	fileName := GikoSys.GetAppDir + TABFILE;
		if FileExists(fileName) then begin
		    try
				URLs.LoadFromFile(fileName);
                if (URLs.Count = 0) then begin
                    // 空のファイルの場合，バックアップを削除しないために削除
                    SysUtils.DeleteFile(fileName);
                end else begin
                    OpenURLs(URLs);
                end;
    		except
	    		on EFOpenError do ShowMessage('タブファイルが開けません');
            end;
        end;
	finally
        URLs.Free;
	end;

    if (GikoForm.BrowserTabUC.Tabs.Count = 0) and
        (TabsOpenAction.Tag <> 1) then  begin
        ShowMessage('表示するタブがありません。');
    end;
end;
// *************************************************************************
//! Be2chにログイン/ログアウトする
// *************************************************************************
procedure TGikoDM.BeLogInOutActionExecute(Sender: TObject);
var
	TmpCursor: TCursor;
//	msg : String;
begin
	if GikoSys.Belib.Connected then begin
		//ログアウト
		GikoSys.Belib.Disconnect;
		BeLogInOutAction.Checked := False;
		GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmBeLogout), nil, gmiOK);
	end else begin
		TmpCursor := GikoForm.ScreenCursor;
		GikoForm.ScreenCursor := crHourGlass;
		try
			GikoSys.Belib.ClientUA := 'gikoNavi/1.00';
			GikoSys.Belib.UserName := GikoSys.Setting.BeUserID;
			GikoSys.Belib.Password := GikoSys.Setting.BePassword;
            if GikoSys.Setting.ReadProxy then begin
				GikoSys.Belib.ProxyAddress := GikoSys.Setting.ReadProxyAddress;
				GikoSys.Belib.ProxyPort := GikoSys.Setting.ReadProxyPort;
			end else begin
                GikoSys.Belib.ProxyAddress := '';
				GikoSys.Belib.ProxyPort := 0;
            end;
            if GikoSys.Belib.Connect then begin
                GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmBeLogin) + GikoSys.Setting.BeUserID, nil, gmiOK);
                BeLogInOutAction.Checked := True;
            end else begin
                GikoForm.AddMessageList(GikoSys.Belib.ErrorMsg, nil, gmiNG);
                GikoForm.PlaySound('Error');
                BeLogInOutAction.Checked := False;
			end;
		finally
			GikoForm.ScreenCursor := TmpCursor;
		end;
	end;
end;
////////////////////////////////ファイルまでおしまい/////////////////////
// *************************************************************************
//! ココまで読んだ
// *************************************************************************
procedure TGikoDM.KokomadeActionExecute(Sender: TObject);
var
	No: Integer;
	ThreadItem: TThreadItem;
begin
	No := GikoForm.KokoPopupMenu.Tag;
	if No = 0
        then Exit;
	ThreadItem := GikoForm.KokoPopupThreadItem;
	if not Assigned(ThreadItem) then
        Exit;
	ThreadItem.Kokomade := No;
	GikoForm.ActiveContent.Thread.ScrollTop := GikoForm.ActiveContent.Browser.OleObject.Document.Body.ScrollTop;
	GikoForm.ActiveContent.Repaint := true;
	GikoForm.InsertBrowserTab(GikoForm.ActiveContent.Thread, true);
	//INFO 2005/11/19 一旦隠蔽、必要ならGikoFormの方にメソッドを追加する
	//Application.ProcessMessages;
end;
// *************************************************************************
//! 全部読んだ
// *************************************************************************
procedure TGikoDM.ZenbuActionExecute(Sender: TObject);
var
	ThreadItem: TThreadItem;
begin
	ThreadItem := GikoForm.GetActiveContent(True);
	if ThreadItem = nil then Exit;
	ThreadItem.Kokomade := -1;
	GikoForm.ActiveContent.Thread.ScrollTop := GikoForm.ActiveContent.Browser.OleObject.Document.Body.ScrollTop;
	GikoForm.ActiveContent.Repaint := true;
	GikoForm.InsertBrowserTab(GikoForm.ActiveContent.Thread, true);
	//INFO 2005/11/19 一旦隠蔽、必要ならGikoFormの方にメソッドを追加する
	//Application.ProcessMessages;
end;
// *************************************************************************
//! ココにレス
// *************************************************************************
procedure TGikoDM.KokoResActionExecute(Sender: TObject);
var
	Editor: TEditorForm;
	Item: TThreadItem;
	Number: Integer;
begin
	Number := GikoForm.KokoPopupMenu.Tag;
	if Number = 0 then Exit;
	Item := GikoForm.KokoPopupThreadItem;
	if Item = nil then Exit;

	Editor := TEditorForm.Create(GikoForm);
	Editor.SetThreadItem(Item);
    Editor.SetTextEdit('>>' + IntToStr(Number) + #13#10);
	Editor.Show;
    Editor.SetFocusEdit;
end;
// *************************************************************************
//! 選択したレスをコピーする
// *************************************************************************
procedure TGikoDM.KoreCopyExecute(Sender: TObject);
begin
	GikoForm.KonoresCopy(GikoForm.KokoPopupMenu.Tag, true);
end;
// *************************************************************************
//! 選択したレスをコピーする
// *************************************************************************
procedure TGikoDM.SameIDResAnchorActionExecute(Sender: TObject);
const
    LIMIT = 20;
var
	ThreadItem : TThreadItem;
	No : Integer;
	AID: string;
begin
	No := GikoForm.KokoPopupMenu.Tag;
	if No = 0 then Exit;
	ThreadItem := GikoForm.KokoPopupThreadItem;
	if ThreadItem = nil then Exit;

    AID := GikoSys.GetResID(No, ThreadItem);
    if not IsNoValidID(AID) then begin
        GikoForm.ShowSameIDAncher(AID);
    end;
end;
// *************************************************************************
//! このレスあぼ～ん　（通常）
// *************************************************************************
procedure TGikoDM.IndividualAbon1ActionExecute(Sender: TObject);
begin
	GikoForm.IndividualAbon(GikoForm.KokoPopupMenu.Tag, 1);
end;
// *************************************************************************
//! このレスあぼ～ん　（透明）
// *************************************************************************
procedure TGikoDM.IndividualAbon0ActionExecute(Sender: TObject);
begin
	GikoForm.IndividualAbon(GikoForm.KokoPopupMenu.Tag, 0);
end;
// *************************************************************************
//! このレスあぼ～ん解除
// *************************************************************************
procedure TGikoDM.AntiIndividualAbonActionExecute(Sender: TObject);
var
	IndividualForm :TIndividualAbonForm;
	ThreadItem : TThreadItem;
	msg : String;
	ReadList		: TStringList;
	wordCount		: TWordCount;
begin
	IndividualForm := TIndividualAbonForm.Create(GikoForm);
	try
		ThreadItem := GikoForm.GetActiveContent(True);
		ThreadItem.ScrollTop := GikoForm.ActiveContent.Browser.OleObject.Document.Body.ScrollTop;
		if (ThreadItem <> nil) and (ThreadItem.IsLogFile) then begin
			if IndividualForm.SetThreadLogFileName(ThreadItem.GetThreadFileName) then begin
				ReadList		:= TStringList.Create;
				wordCount		:= TWordCount.Create;
				try
{$IFDEF SPAM_FILTER_ENABLED}
					// スパムを解除
					ReadList.LoadFromFile( ThreadItem.GetThreadFileName );
					GikoSys.SpamCountWord( ReadList[ KokoPopupMenu.Tag - 1 ], wordCount );
					GikoSys.SpamForget( wordCount, True );	// スパムを解除
					GikoSys.SpamLearn( wordCount, False );	// ハムに設定
{$ENDIF}
					if IndividualForm.DeleteNG(GikoForm.KokoPopupMenu.Tag) then begin
						GikoForm.ActiveContent.Repaint := true;
						GikoForm.InsertBrowserTab( ThreadItem, True );
					end;
				finally
					wordCount.Free;
					ReadList.Free;
				end;
			end else begin
				msg := 'このスレッドでは個別あぼ～んを行ってません';
				MsgBox(GikoForm.Handle, msg, 'メッセージ', MB_OK);
			end;
		end;
	finally
		IndividualForm.Release;
	end;
end;
// *************************************************************************
//! このレスあぼ～ん解除レス番号指定（ダイアログ表示）
// *************************************************************************
procedure TGikoDM.AntiIndividualAbonDlgActionExecute(Sender: TObject);
var
	IndividualForm :TIndividualAbonForm;
	ThreadItem : TThreadItem;
	msg : String;
	ReadList		: TStringList;
	wordCount		: TWordCount;
{$IFDEF SPAM_FILTER_ENABLED}
	i : Integer;
{$ENDIF}
begin
	IndividualForm := TIndividualAbonForm.Create(GikoForm);
	try
		ThreadItem := GikoForm.GetActiveContent(True);
		ThreadItem.ScrollTop := GikoForm.ActiveContent.Browser.OleObject.Document.Body.ScrollTop;
		if (ThreadItem <> nil) and (ThreadItem.IsLogFile) then begin
			if IndividualForm.SetThreadLogFileName(ThreadItem.GetThreadFileName) then begin
				if (IndividualForm.ShowModal = mrOK) then begin
					ReadList		:= TStringList.Create;
					wordCount		:= TWordCount.Create;
					try
{$IFDEF SPAM_FILTER_ENABLED}
						// スパムを解除
						ReadList.LoadFromFile( ThreadItem.GetThreadFileName );
						for i := 0 to IndividualForm.DeleteList.Count - 1 do begin
							GikoSys.SpamCountWord( ReadList[ StrToInt(IndividualForm.DeleteList[i]) - 1 ], wordCount );
							GikoSys.SpamForget( wordCount, True );	// スパムを解除
							GikoSys.SpamLearn( wordCount, False );	// ハムに設定
						end;
{$ENDIF}
						if IndividualForm.FRepaint then begin
							GikoForm.ActiveContent.Repaint := true;
							GikoForm.InsertBrowserTab( ThreadItem, True );
						end;
					finally
						wordCount.Free;
						ReadList.Free;
					end;
				end;
			end else begin
				msg := 'このスレッドでは個別あぼ～んを行ってません';
				MsgBox(GikoForm.Handle, msg, 'メッセージ', MB_OK);
			end;
		end;
	finally
		IndividualForm.Release;
	end;
end;
// *************************************************************************
//! このIDあぼ～ん　通常
// *************************************************************************
procedure TGikoDM.IndividualAbonID1ActionExecute(Sender: TObject);
begin
	GikoForm.IndividualAbonID(1);
end;
// *************************************************************************
//! このIDあぼ～ん　透明
// *************************************************************************
procedure TGikoDM.IndividualAbonID0ActionExecute(Sender: TObject);
begin
	GikoForm.IndividualAbonID(0);
end;
// *************************************************************************
//! 範囲あぼ～ん（このレス）
// *************************************************************************
procedure TGikoDM.RangeAbonActionExecute(Sender: TObject);
begin
  GikoForm.RangeAbon(GikoForm.KokoPopupMenu.Tag);
end;
// *************************************************************************
//! 範囲あぼ～ん（スレッド）
// *************************************************************************
procedure TGikoDM.ThreadRangeAbonActionExecute(Sender: TObject);
begin
  GikoForm.RangeAbon(0);
end;
////////////////////////////////ブラウザポップアップまでおしまい/////////////////////
// *************************************************************************
//! ギコナビのウェブサイトを表示する
// *************************************************************************
procedure TGikoDM.GikoNaviWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_GIKONAVI, gbtAuto);
end;
// *************************************************************************
//! ギコナビ(避難所版)のウェブサイトを表示する
// *************************************************************************
procedure TGikoDM.GikoNaviGoesonWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_GIKONAVIGO, gbtAuto);
end;
// *************************************************************************
//! モナジラのウェブサイトを表示する
// *************************************************************************
procedure TGikoDM.MonazillaWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_MONAZILLA, gbtAuto);
end;
// *************************************************************************
//! ２ちゃんねるトップページを表示する
// *************************************************************************
procedure TGikoDM.BBS2chWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_2ch, gbtAuto);
end;
// *************************************************************************
//! ギコナビのフォルダを開く
// *************************************************************************
procedure TGikoDM.GikoFolderOpenActionExecute(Sender: TObject);
begin
	GikoSys.CreateProcess('explorer.exe', '/e,"' + GikoSys.GetAppDir + '"');
end;
// *************************************************************************
//! バージョン情報を表示する
// *************************************************************************
procedure TGikoDM.AboutActionExecute(Sender: TObject);
var
	Dlg: TAboutDialog;
begin
	Dlg := TAboutDialog.Create(GikoForm);
	try
		Dlg.ShowModal;
	finally
		Dlg.Release;
	end;
end;
// *************************************************************************
//! ギコナビのヘルプを表示する
// *************************************************************************
procedure TGikoDM.GikoHelpActionExecute(Sender: TObject);
var
	FileName: string;
begin
	FileName := GikoSys.GetAppDir + 'batahlp.chm';
	if not FileExists(FileName) then begin
		MsgBox(
			GikoForm.Handle,
			'ヘルプが見つかりませんでした' + #13#10 +
			'ヘルプファイルをギコナビのフォルダに置いてください' + #13#10 +
			'ヘルプはギコナビのサイトに置いてあります',
			MSG_ERROR,
			MB_ICONSTOP);
		Exit;
	end;
	ShellExecute(GikoForm.Handle, 'open', PChar(FileName), '', PChar(GikoSys.GetAppDir), SW_SHOW);
end;
// *************************************************************************
//! ギコナビWikiのウェブサイトを表示する
// *************************************************************************
procedure TGikoDM.WikiFAQWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_Wiki, gbtAuto);
end;
// *************************************************************************
//! ギコナビ(避難所版)Wikiのウェブサイトを表示する
// *************************************************************************
procedure TGikoDM.GoWikiFAQWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_GoWiki, gbtAuto);
end;
////////////////////////////////ヘルプまでおしまい/////////////////////
// *************************************************************************
//! リスト番号表示を変更する
// *************************************************************************
procedure TGikoDM.ListNumberVisibleActionExecute(Sender: TObject);
begin
	GikoSys.Setting.ListViewNo := ListNumberVisibleAction.Checked;
	GikoForm.ListViewUC.Refresh;
end;
// *************************************************************************
//! 上位フォルダに移動する
// *************************************************************************
procedure TGikoDM.UpFolderActionExecute(Sender: TObject);
begin
	if GikoForm.GetActiveList is TBoard then begin
		if TBoard(GikoForm.GetActiveList).ParentCategory <> nil then
			GikoForm.SelectTreeNode(TBoard(GikoForm.GetActiveList).ParentCategory, True);
	end else if GikoForm.GetActiveList is TCategory then begin
		GikoForm.SelectTreeNode(TCategory(GikoForm.GetActiveList).ParenTBBS, True);
	end;
end;
// *************************************************************************
//! 上位フォルダに移動するUpDateイベント
// *************************************************************************
procedure TGikoDM.UpFolderActionUpdate(Sender: TObject);
begin
	UpFolderAction.Enabled := not (GikoForm.GetActiveList is TBBS) and
        (GikoForm.GetActiveList <> BoardGroup.SpecialBoard);
end;
// *************************************************************************
//! 表示　表示リストのモード変更
// *************************************************************************
procedure TGikoDM.IconStyleExecute(Sender: TObject);
begin
	case GikoForm.ListViewUC.ViewStyle of
		vsIcon: SmallIconAction.Execute;
		vsSmallIcon: ListIconAction.Execute;
		vsList: DetailIconAction.Execute;
		vsReport: LargeIconAction.Execute;
	end;
end;
// *************************************************************************
//! SelectComboBoxの値をクリアする
// *************************************************************************
procedure TGikoDM.ClearSelectComboBox;
begin
	if GikoForm.SelectComboBoxPanel.Visible then begin
		GikoForm.SelectComboBoxUC.Text := SELECTCOMBOBOX_NAME;
		GikoForm.SelectComboBoxUC.Color := SELECTCOMBOBOX_COLOR;
		GikoForm.ListViewUC.SetFocus;
	end;
end;
// *************************************************************************
//! スレッドをすべて表示する
// *************************************************************************
procedure TGikoDM.AllItemActionExecute(Sender: TObject);
begin
	try
		if GikoForm.ViewType <> gvtAll then
			GikoForm.SetListViewType(gvtAll);
		GikoSys.Setting.ThreadRange := gtrAll;
		AllItemAction.Checked		:= True;
		// SelectComboBox の履歴を更新しておく
		GikoForm.ModifySelectList;
		// SelectComboBox の値をクリア
		ClearSelectComboBox;
	except
	end;
end;
// *************************************************************************
//! ログ有りスレッドのみを表示する
// *************************************************************************
procedure TGikoDM.LogItemActionExecute(Sender: TObject);
begin
	try
		if GikoForm.ViewType <> gvtLog then
			GikoForm.SetListViewType(gvtLog);
		GikoSys.Setting.ThreadRange	:= gtrLog;
		LogItemAction.Checked := True;
		// SelectComboBox の履歴を更新しておく
		GikoForm.ModifySelectList;
		// SelectComboBox の値をクリア
		ClearSelectComboBox;
	except
	end;
end;
// *************************************************************************
//! 新着スレッドのみ表示する
// *************************************************************************
procedure TGikoDM.NewItemActionExecute(Sender: TObject);
begin
	try

		if GikoForm.ViewType <> gvtNew then
			GikoForm.SetListViewType(gvtNew);
		GikoSys.Setting.ThreadRange	:= gtrNew;
		NewItemAction.Checked := True;
		// SelectComboBox の履歴を更新しておく
		GikoForm.ModifySelectList;
		// SelectComboBox の値をクリア
		ClearSelectComboBox;
	except
	end;
end;
// *************************************************************************
//! DAT落ちスレッドのみ表示する
// *************************************************************************
procedure TGikoDM.ArchiveItemActionExecute(Sender: TObject);
begin
	try
		if GikoForm.ViewType <> gvtArch then
			GikoForm.SetListViewType(gvtArch);
		GikoSys.Setting.ThreadRange	:= gtrArch;
		ArchiveItemAction.Checked := True;
		// SelectComboBox の履歴を更新しておく
		GikoForm.ModifySelectList;
		// SelectComboBox の値をクリア
		ClearSelectComboBox;
	except
	end;
end;
// *************************************************************************
//! 生存スレッドのみ表示する
// *************************************************************************
procedure TGikoDM.LiveItemActionExecute(Sender: TObject);
begin
	try
		if GikoForm.ViewType <> gvtLive then
			GikoForm.SetListViewType(gvtLive);
		GikoSys.Setting.ThreadRange	:= gtrLive;
		LiveItemAction.Checked := True;
		// SelectComboBox の履歴を更新しておく
		GikoForm.ModifySelectList;
		// SelectComboBox の値をクリア
		ClearSelectComboBox;
	except
	end;
end;

// *************************************************************************
//! スレッドの表示範囲を設定
// *************************************************************************
procedure TGikoDM.ThreadRangeActionExecute(Sender: TObject);
begin
	case GikoSys.Setting.ThreadRange of
	gtrAll:	AllItemAction.Execute;
	gtrLog:	LogItemAction.Execute;
	gtrNew:	NewItemAction.Execute;
	gtrArch: ArchiveItemAction.Execute;
	gtrLive: LiveItemAction.Execute;
	end;
end;
// *************************************************************************
//! スレッド絞込みダイアログを表示する
// *************************************************************************
procedure TGikoDM.SelectItemActionExecute(Sender: TObject);
var
	idx: Integer;
	Dlg: TListSelectDialog;
begin
	try
		if GikoForm.SelectComboBoxPanel.Visible then begin
			if GikoForm.SelectComboBoxPanel.Left + GikoForm.SelectComboBoxPanel.Width < GikoForm.ListToolBar.Width then begin
				// SelectComboBox がある場合はフォーカスを移す
				if GikoSys.Setting.ListOrientation = gloHorizontal then begin
					if GikoSys.Setting.ListWidthState = glsMax then
						BrowserMinAction.Execute;
				end else begin
					if GikoSys.Setting.ListHeightState = glsMax then
						BrowserMinAction.Execute;
				end;
				GikoForm.SelectComboBoxUC.SetFocus;
				exit;
			end;
		end;
	except
	end;

	if GikoForm.SelectComboBoxUC.Text = SELECTCOMBOBOX_NAME then begin
		GikoForm.SelectComboBoxUC.Text := '';
		GikoForm.SelectComboBoxUC.Color := clWindow;
	end;

	AllItemAction.Checked := False;
	LogItemAction.Checked := False;
	NewItemAction.Checked := False;
	//SelectItemAction.Checked := True;
	GikoForm.ModifySelectList;
	Dlg := TListSelectDialog.Create(GikoForm);
	try
		Dlg.SelectComboBoxUC.Items_Assign(GikoSys.Setting.SelectTextList);
		Dlg.SelectComboBoxUC.Text := GikoForm.SelectComboBoxUC.Text;
		Dlg.ShowModal;
		if Dlg.ModalResult = mrCancel then begin
			if Length( GikoForm.SelectComboBoxUC.Text ) = 0 then begin
				AllItemAction.Checked := True;
				GikoForm.SelectComboBoxUC.Text := SELECTCOMBOBOX_NAME;
				GikoForm.SelectComboBoxUC.Color := SELECTCOMBOBOX_COLOR;
			end;

			if GikoForm.GetActiveList is TBoard then
				GikoForm.SetListViewType(gvtUser, TBoard(GikoForm.GetActiveList).ParentCategory.ParenTBBS.SelectText , Dlg.KubetsuCheckBox.Checked);
		end else begin
			idx := GikoSys.Setting.SelectTextList.IndexOf(Dlg.SelectComboBoxUC.EncodeText);
			if idx <> -1 then
				GikoSys.Setting.SelectTextList.Delete(idx);
			GikoSys.Setting.SelectTextList.Insert(0, Dlg.SelectComboBoxUC.EncodeText);
			while Dlg.SelectComboBoxUC.Items.Count > 100 do begin
				Dlg.SelectComboBoxUC.Items.Delete(Dlg.SelectComboBoxUC.Items.Count - 1);
			end;

			if Length( Dlg.SelectComboBoxUC.Text ) = 0 then begin
				GikoForm.SelectComboBoxUC.Text := SELECTCOMBOBOX_NAME;
				GikoForm.SelectComboBoxUC.Color := SELECTCOMBOBOX_COLOR;
			end else begin
				GikoForm.SelectComboBoxUC.Text := Dlg.SelectComboBoxUC.Text;
				GikoForm.SelectComboBoxUC.Color := clWindow;
			end;
			GikoForm.SetListViewType(gvtUser, Dlg.SelectComboBoxUC.EncodeText, Dlg.KubetsuCheckBox.Checked);
		end;
	finally
		Dlg.Release;
	end;
end;
// *************************************************************************
//! 新スレ書き込みウィンドウを表示する
// *************************************************************************
procedure TGikoDM.ThreadEditorActionExecute(Sender: TObject);
var
	Editor: TEditorForm;
begin
	if not (GikoForm.GetActiveList is TBoard) then
		Exit;
	Editor := TEditorForm.Create(GikoForm);
	Editor.SetBoard(TBoard(GikoForm.GetActiveList));
	Editor.Show;
    Editor.SetFocusEdit;
end;
// *************************************************************************
//! 現在表示している板をブラウザで表示する
// *************************************************************************
procedure TGikoDM.BoardIEActionExecute(Sender: TObject);
var
	URL: string;
begin
	if GikoForm.GetActiveList is TBoard then begin
		URL := TBoard(GikoForm.GetActiveList).URL;
		GikoSys.OpenBrowser(URL, gbtAuto);
	end;
end;
// *************************************************************************
//! 選択されているスレッドのURLをコピーする
// *************************************************************************
procedure TGikoDM.SelectItemURLCopyActionExecute(Sender: TObject);
var
	List: TList;
	i: Integer;
	s: string;
begin
	s := '';
	List := TList.Create;
	try
		GikoForm.SelectListItem(List);
		for i := 0 to List.Count - 1 do begin
			if TObject(List[i]) is TBoard then
				s := s + TBoard(List[i]).URL + #13#10
			else if TObject(List[i]) is TThreadItem then
				s := s + TThreadItem(List[i]).URL + #13#10;
		end;
		if s <> '' then
			Clipboard.AsText := s;
	finally
		List.Free;
	end;
end;
// *************************************************************************
//! 選択されているスレッドのURLをコピーするUpdateイベント
// *************************************************************************
procedure TGikoDM.SelectItemURLCopyActionUpdate(Sender: TObject);
begin
	if ((GikoForm.GetActiveList is TBoard) or
		(GikoForm.GetActiveList is TCategory))and (GikoForm.ListViewUC.SelCount > 0) then
		TAction(Sender).Enabled := True
	else
		TAction(Sender).Enabled := False;
end;
// *************************************************************************
//! 選択されている板の名前をコピーする
// *************************************************************************
procedure TGikoDM.SelectItemNameCopyActionExecute(Sender: TObject);
var
	List: TList;
	i: Integer;
	s: string;
begin
	s := '';
	List := TList.Create;
	try
		GikoForm.SelectListItem(List);
		for i := 0 to List.Count - 1 do begin
            if TObject(List[i]) is TCategory then
                s := s + TCategory(List[i]).Title + #13#10
			else if TObject(List[i]) is TBoard then
				s := s + TBoard(List[i]).Title + #13#10
			else if TObject(List[i]) is TThreadItem then
				s := s + TThreadItem(List[i]).Title + #13#10;
		end;
		if s <> '' then
			SetClipboardFromEncAnsi(s);
	finally
		List.Free;
	end;
end;
// *************************************************************************
//! 選択されている板の名前をコピーするUpdateイベント
// *************************************************************************
procedure TGikoDM.SelectItemNameCopyActionUpdate(Sender: TObject);
begin
	if ((GikoForm.GetActiveList is TBBS) or
        (GikoForm.GetActiveList is TBoard) or
		(GikoForm.GetActiveList is TCategory))and (GikoForm.ListViewUC.SelCount > 0) then
		TAction(Sender).Enabled := True
	else
		TAction(Sender).Enabled := False;
end;
// *************************************************************************
//! 選択されているスレッドの名前とURLをコピーする
// *************************************************************************
procedure TGikoDM.SelectItemNameURLCopyActionExecute(Sender: TObject);
var
	List: TList;
	i: Integer;
	s: string;
begin
	s := '';
	List := TList.Create;
	try
		GikoForm.SelectListItem(List);
		for i := 0 to List.Count - 1 do begin
			if TObject(List[i]) is TBoard then
				s := s + TBoard(List[i]).Title + #13#10 + TBoard(List[i]).URL + #13#10
			else if TObject(List[i]) is TThreadItem then
				s := s + TThreadItem(List[i]).Title + #13#10 + TThreadItem(List[i]).URL + #13#10;
		end;
		if s <> '' then
			SetClipboardFromEncAnsi(s);
	finally
		List.Free;
	end;
end;
// *************************************************************************
//! 選択されているスレッド一覧をダウンロードする
// *************************************************************************
procedure TGikoDM.SelectListReloadActionExecute(Sender: TObject);
var
	i: Integer;
	List: TList;
	msg: string;
	shiftDown: Boolean;
begin
	shiftDown := GetAsyncKeyState(VK_SHIFT) = Smallint($8001);
    GikoForm.ActiveListColumnSave;
	if GikoForm.GetActiveList is TCategory then begin
		List := TList.Create;
		try
			GikoForm.SelectListItem(List);
			if List.Count > 5 then begin
				msg := '5個以上は指定できません' + #13#10
						 + '２ちゃんねる負荷軽減にご協力ください';
				MsgBox(GikoForm.Handle, msg, '警告', MB_ICONEXCLAMATION);
				Exit;
			end;
			for i := 0 to List.Count - 1 do begin
				if TObject(List[i]) is TBoard then
					GikoForm.DownloadList(TBoard(List[i]), shiftDown);
			end;
		finally
			List.Free;
		end;
	end else if GikoForm.GetActiveList is TBoard then begin
		GikoForm.DownloadList(TBoard(GikoForm.GetActiveList), shiftDown);
	end;
end;
// *************************************************************************
//! 選択されているスレッド一覧をダウンロードするUpdateイベント
// *************************************************************************
procedure TGikoDM.SelectListReloadActionUpdate(Sender: TObject);
begin
	if (GikoForm.GetActiveList is TCategory) and (GikoForm.ListViewUC.SelCount > 0) then
		TAction(Sender).Enabled := True
	else if GikoForm.GetActiveList is TBoard then begin
		TAction(Sender).Enabled :=
            (GikoForm.GetActiveList <> BoardGroup.SpecialBoard);
	end else
		TAction(Sender).Enabled := False;
end;
// *************************************************************************
//! 選択されているスレッドをダウンロードする
// *************************************************************************
procedure TGikoDM.SelectThreadReloadActionExecute(Sender: TObject);
var
	List: TList;
	i: Integer;
	msg: string;
	shiftDown: Boolean;
begin
	shiftDown := GetAsyncKeyState(VK_SHIFT) = Smallint($8001);
	List := TList.Create;
	try
		GikoForm.SelectListItem(List);
		if List.Count > 10 then begin
			msg := '10個以上は指定できません' + #13#10
					 + '２ちゃんねる負荷軽減にご協力ください';
			MsgBox(GikoForm.Handle, msg, '警告', MB_ICONEXCLAMATION);
			Exit;
		end;
		for i := 0 to List.Count - 1 do begin
			if TObject(List[i]) is TThreadItem then
				GikoForm.DownloadContent(TThreadItem(List[i]), shiftDown);
		end;
	finally
		List.Free;
	end;
end;
// *************************************************************************
//! 選択されているスレッドをダウンロードするUpdateイベント
// *************************************************************************
procedure TGikoDM.SelectThreadReloadActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled :=
		(GikoForm.GetActiveList is TBoard) and (GikoForm.ListViewUC.SelCount > 0);
end;
// *************************************************************************
//! スレッド巡回予約
// *************************************************************************
procedure TGikoDM.SelectReservActionExecute(Sender: TObject);
begin
	//INFO 2005/11/19 ダミー？　by もじゅ
	// このコメント削除しては駄目
end;
// *************************************************************************
//! スレッド巡回予約Updateイベント
// *************************************************************************
procedure TGikoDM.SelectReservActionUpdate(Sender: TObject);
var
	i: Integer;
	List: TList;
begin
	if (GikoForm.GetActiveList is TBoard) and (GikoForm.ListViewUC.SelCount > 0) then begin
		List := TList.Create;
		try
			GikoForm.SelectListItem(List);
			for i := 0 to List.Count - 1 do begin
				if TObject(List[i]) is TThreadItem then begin
					if TThreadItem(List[i]).IsLogFile then begin
						SelectReservAction.Enabled := True;
						Exit;
					end;
				end;
			end;
			SelectReservAction.Enabled := False;
		finally
			List.Free;
		end;
	end else if (GikoForm.GetActiveList is TCategory) and (GikoForm.ListViewUC.SelCount > 0) then
		SelectReservAction.Enabled := True
	else
		SelectReservAction.Enabled := False;
end;
// *************************************************************************
//! 選択しているスレッドに新しい名前で巡回予約
// *************************************************************************
procedure TGikoDM.SelectNewRoundNameExecute(Sender: TObject);
var
	s: string;
	Dlg: TRoundNameDialog;
		cnt: Integer;

begin
	//呼び出し元が、TActionでListViewに選択がいなければ、EXITする
	if (Sender is TAction) and (GikoForm.ListViewUC.Selected = nil) then
		Exit;

	//登録上限チェック
	cnt := RoundList.Count[grtBoard];
	cnt := cnt + RoundList.Count[grtItem];
	if cnt > 500 then begin
			MsgBox(GikoForm.Handle, '巡回は500以上登録できません', MSG_ERROR, MB_OK or MB_ICONSTOP);
			Exit;
	end;

	Dlg := TRoundNameDialog.Create(GikoForm);
	try
		Dlg.ShowModal;
		if Dlg.ModalResult <> mrCancel then begin
			s := Trim(Dlg.RoundNameEdit.Text);
			if (Sender is TMenuItem) then begin
				GikoForm.SetSelectItemRound(True, s, TMenuItem(Sender).Parent.Name);
			end else if (Sender is TAction) then begin
				if (GikoForm.ListViewUC.Selected <> nil) then begin
					if (TObject(GikoForm.ListViewUC.Selected.Data) is TThreadItem) then begin
						GikoForm.SetSelectItemRound(True, s,
							TThreadItem(GikoForm.ListViewUC.Selected.Data).Title);
					end else if (TObject(GikoForm.ListViewUC.Selected.Data) is TBoard) then begin
						GikoForm.SetSelectItemRound(True, s,
							TBoard(GikoForm.ListViewUC.Selected.Data).Title);
					end;
				end;
			end;
			GikoForm.ListViewUC.Refresh;
		end;
	finally
		Dlg.Free;
	end;
end;
// *************************************************************************
//! 選択されていスレッドの巡回を削除する
// *************************************************************************
procedure TGikoDM.SelectDeleteRoundExecute(Sender: TObject);
var
	s : String;
begin
	if (Sender is TMenuItem) then begin
		try
			GikoForm.SetSelectItemRound(False, '', TMenuItem(Sender).Parent.Name);
		except
		end;
	end else if (Sender is TAction) then begin
		try
			if GikoForm.ListViewUC.Selected <> nil then begin
				if (TObject(GikoForm.ListViewUC.Selected.Data) is TThreadItem) then begin
					s := TThreadItem(GikoForm.ListViewUC.Selected.Data).Title;
				end else if (TObject(GikoForm.ListViewUC.Selected.Data) is TBoard) then begin
					s := TBoard(GikoForm.ListViewUC.Selected.Data).Title;
				end;
				GikoForm.SetSelectItemRound(False, '', s);

			end;
		except
		end;
	end;
	GikoForm.ListViewUC.Refresh;
end;
// *************************************************************************
//! 選択されている板をお気に入りに追加する
// *************************************************************************
procedure TGikoDM.BoardFavoriteAddActionExecute(Sender: TObject);
begin
	if TObject(GikoForm.ListViewUC.Selected.Data) is TBoard then
		GikoForm.ShowFavoriteAddDialog(TObject(GikoForm.ListViewUC.Selected.Data));
end;
// *************************************************************************
//! 選択されている板をお気に入りに追加するUpdateイベント
// *************************************************************************
procedure TGikoDM.BoardFavoriteAddActionUpdate(Sender: TObject);
begin
	BoardFavoriteAddAction.Enabled :=
		(GikoForm.GetActiveList is TCategory) and (GikoForm.ListViewUC.SelCount > 0);
end;
// *************************************************************************
//! ExplorerでLogフォルダを開く
// *************************************************************************
procedure TGikoDM.LogFolderOpenActionExecute(Sender: TObject);
var
	List: TList;
begin
	if ((GikoSys.Setting.ListOrientation = gloVertical) and
		(GikoSys.Setting.ListHeightState = glsMax)) or
		((GikoSys.Setting.ListOrientation = gloHorizontal) and
		(GikoSys.Setting.ListWidthState = glsMax))	then begin
		if(GikoForm.GetActiveContent <> nil) then begin
			GikoSys.CreateProcess('explorer.exe', '/e,"' + ExtractFilePath(GikoForm.GetActiveContent.FilePath) + '"');
		end;
	end else if GikoForm.GetActiveList is TCategory then begin
		List := TList.Create;
		try
			GikoForm.SelectListItem(List);
			GikoSys.CreateProcess('explorer.exe', '/e,"' + ExtractFilePath(TBoard(List[0]).FilePath) + '"');
		finally
			List.Free;
		end;
	end else if GikoForm.GetActiveList is TBoard then begin
		GikoSys.CreateProcess('explorer.exe', '/e,"' + ExtractFilePath(TBoard(GikoForm.GetActiveList).FilePath) + '"');
	end;

end;
// *************************************************************************
//! ActiveListがTBoardかTCategoryでスレ一覧で１つ以上選択していると有効になるActionde共通
// *************************************************************************
procedure TGikoDM.LogFolderOpenActionUpdate(Sender: TObject);
begin
	if (((GikoForm.GetActiveList is TBoard) and
        (GikoForm.GetActiveList <> BoardGroup.SpecialBoard))
        or (GikoForm.GetActiveList is TCategory))
	    	and (GikoForm.ListViewUC.SelCount > 0) then
		TAction(Sender).Enabled := True
	else
		TAction(Sender).Enabled := False;
end;
// *************************************************************************
//! Header.txtをブラウザで表示する
// *************************************************************************
procedure TGikoDM.BrowsBoradHeadActionExecute(Sender: TObject);
var
	RefURL, URL : string;
	List : TList;
begin
	RefURL := '';
	if GikoForm.GetActiveList is TCategory then begin
		List := TList.Create;
		try
			GikoForm.SelectListItem(List);
			RefURL := TBoard(List[0]).URL;
		finally
			List.Free;
		end;
	end else if GikoForm.GetActiveList is TBoard then begin
		RefURL := TBoard(GikoForm.GetActiveList).URL
	end;
	if RefURL <> '' then begin
		if RefURL[Length(RefURL)] <> '/' then
			URL	:= RefURL + '/' + 'head.txt'
		else
			URL	:= RefURL + 'head.txt';

		GikoForm.MoveToURL(URL);
	end else begin
		ShowMessage('板を特定できませんでした。');
	end;

end;
// *************************************************************************
//! スレ一覧の表示している内容にしたがって、ソートカラムの位置と方向を取得する
// *************************************************************************
function TGikoDM.GetSortProperties(List: TObject;
 var vSortOrder: Boolean): Boolean;
begin
	Result := True;
	if (List <> nil) then begin
		if (List is TBBS) then begin
			vSortOrder := GikoSys.Setting.BBSSortOrder;
		end else if (List is TCategory) then begin
			vSortOrder := GikoSys.Setting.CategorySortOrder;
		end else if (List is TBoard) then begin
			vSortOrder := GikoSys.Setting.BoardSortOrder;
		end else begin
			Result := False;
		end;
	end else begin
		Result := False;
	end;
end;
// *************************************************************************
//! 現在のカラムをソートする
// *************************************************************************
procedure TGikoDM.SortActiveColumnActionExecute(Sender: TObject);
var
	i	: Integer;
	so : boolean;
begin
	if GetSortProperties(GikoForm.GetActiveList, so) then begin
		for i := 0 to GikoForm.ListViewUC.Columns.Count - 1 do begin
			if (GikoForm.ListViewUC.Column[ i ].ImageIndex = ITEM_ICON_SORT1) or
				(GikoForm.ListViewUC.Column[ i ].ImageIndex = ITEM_ICON_SORT2) then begin
				so := not so;
				TListViewUtils.ListViewSort(nil, GikoForm.ListViewUC,
					 GikoForm.ListViewUC.Column[ i ], ListNumberVisibleAction.Checked,
					 so);
				break;
			end;
		end;
	end;
end;
// *************************************************************************
//! 右隣のカラムをソート
// *************************************************************************
procedure TGikoDM.SortNextColumnActionExecute(Sender: TObject);
var
	i, id	: Integer;
begin
	for i := 0 to GikoForm.ListViewUC.Columns.Count - 1 do begin
		if (GikoForm.ListViewUC.Column[ i ].ImageIndex = ITEM_ICON_SORT1) or
			(GikoForm.ListViewUC.Column[ i ].ImageIndex = ITEM_ICON_SORT2) then begin
			id := i + 1;
			if id > GikoForm.ListViewUC.Columns.Count - 1 then
				id := 0;
			TListViewUtils.ListViewSort( nil, GikoForm.ListViewUC,
				GikoForm.ListViewUC.Column[ id ], ListNumberVisibleAction.Checked,
				id = 0);
			break;
		end;
	end;
end;
// *************************************************************************
//! 左隣のカラムをソート
// *************************************************************************
procedure TGikoDM.SortPrevColumnActionExecute(Sender: TObject);
var
	i, id	: Integer;
begin
	for i := 0 to GikoForm.ListViewUC.Columns.Count - 1 do begin
		if (GikoForm.ListViewUC.Column[ i ].ImageIndex = ITEM_ICON_SORT1) or
			(GikoForm.ListViewUC.Column[ i ].ImageIndex = ITEM_ICON_SORT2) then begin
			id := i - 1;
			if id < 0 then
				id := GikoForm.ListViewUC.Columns.Count - 1;
			TListViewUtils.ListViewSort( nil, GikoForm.ListViewUC,
				GikoForm.ListViewUC.Column[ id ], ListNumberVisibleAction.Checked,
				id = 0);
			break;
		end;
	end;
end;
////////////////////////////////板までおしまい/////////////////////
// *************************************************************************
//! 標準ツールバーの表示状態を変更する
// *************************************************************************
procedure TGikoDM.StdToolBarVisibleActionExecute(Sender: TObject);
var
	CoolBand: TCoolBand;
begin
	CoolBand := GikoForm.GetCoolBand(GikoForm.MainCoolBar, GikoForm.StdToolBar);
	if CoolBand = nil then
		Exit;
	GikoSys.Setting.StdToolBarVisible := StdToolBarVisibleAction.Checked;
	CoolBand.Visible := GikoSys.Setting.StdToolBarVisible;
	GikoForm.StdToolBarVisiblePMenu.Checked := GikoSys.Setting.StdToolBarVisible;
end;
// *************************************************************************
//! アドレスバーの表示状態を変更する
// *************************************************************************
procedure TGikoDM.AddressBarVisibleActionExecute(Sender: TObject);
var
	CoolBand: TCoolBand;
begin
	CoolBand := GikoForm.GetCoolBand(GikoForm.MainCoolBar, GikoForm.AddressToolBar);
	if CoolBand = nil then
		Exit;
	GikoSys.Setting.AddressBarVisible := AddressBarVisibleAction.Checked;
	CoolBand.Visible := GikoSys.Setting.AddressBarVisible;
	GikoForm.AddressToolBarVisiblePMenu.Checked := GikoSys.Setting.AddressBarVisible;
end;
// *************************************************************************
//! リンクバーの表示状態を変更する
// *************************************************************************
procedure TGikoDM.LinkBarVisibleActionExecute(Sender: TObject);
var
	CoolBand: TCoolBand;
begin
	CoolBand := GikoForm.GetCoolBand(GikoForm.MainCoolBar, GikoForm.LinkToolBarUC);
	if CoolBand = nil then
		Exit;
	GikoSys.Setting.LinkBarVisible := LinkBarVisibleAction.Checked;
	CoolBand.Visible := GikoSys.Setting.LinkBarVisible;
	GikoForm.LinkToolBarVisiblePMenu.Checked := GikoSys.Setting.LinkBarVisible;
end;
// *************************************************************************
//! リストツールバーの表示状態を変更する
// *************************************************************************
procedure TGikoDM.ListToolBarVisibleActionExecute(Sender: TObject);
var
	CoolBand: TCoolBand;
begin
	CoolBand := GikoForm.GetCoolBand(GikoForm.ListCoolBar, GikoForm.ListToolBar);
	if CoolBand = nil then
		Exit;
	CoolBand.Visible := ListToolBarVisibleAction.Checked;
	GikoSys.Setting.ListToolBarVisible := ListToolBarVisibleAction.Checked;
end;
// *************************************************************************
//! リスト名称の表示状態を変更する
// *************************************************************************
procedure TGikoDM.ListNameBarVisibleActionExecute(Sender: TObject);
var
	CoolBand: TCoolBand;
begin
	CoolBand := GikoForm.GetCoolBand(GikoForm.ListCoolBar, GikoForm.ListNameToolBar);
	if CoolBand = nil then
		Exit;
	CoolBand.Visible := ListNameBarVisibleAction.Checked;
	GikoSys.Setting.ListNameBarVisible := ListNameBarVisibleAction.Checked;
end;
// *************************************************************************
//! ブラウザツールバーの表示状態を変更する
// *************************************************************************
procedure TGikoDM.BrowserToolBarVisibleActionExecute(Sender: TObject);
var
	CoolBand: TCoolBand;
begin
	CoolBand := GikoForm.GetCoolBand(GikoForm.BrowserCoolBar, GikoForm.BrowserToolBar);
	if CoolBand = nil then
		Exit;
	CoolBand.Visible := BrowserToolBarVisibleAction.Checked;
	GikoSys.Setting.BrowserToolBarVisible := BrowserToolBarVisibleAction.Checked;
end;
// *************************************************************************
//! ブラウザ名称の表示状態を変更する
// *************************************************************************
procedure TGikoDM.BrowserNameBarVisibleActionExecute(Sender: TObject);
var
	CoolBand: TCoolBand;
begin
	CoolBand := GikoForm.GetCoolBand(GikoForm.BrowserCoolBar, GikoForm.BrowserNameToolBar);
	if CoolBand = nil then
		Exit;
	CoolBand.Visible := BrowserNameBarVisibleAction.Checked;
	GikoSys.Setting.BrowserNameBarVisible := BrowserNameBarVisibleAction.Checked;
end;
// *************************************************************************
//! メッセージバーの表示状態を変更する
// *************************************************************************
procedure TGikoDM.MsgBarVisibleActionExecute(Sender: TObject);
begin
	GikoForm.MessageSplitter.Visible := MsgBarVisibleAction.Checked;
	GikoForm.MessagePanel.Top :=
		GikoForm.MessageSplitter.Top + GikoForm.MessageSplitter.Height;
	GikoForm.MessageSplitter.Top := GikoForm.MessagePanel.Top + 1;
	GikoForm.MessagePanel.Visible := MsgBarVisibleAction.Checked;
	GikoSys.Setting.MessageBarVisible := MsgBarVisibleAction.Checked;
end;
// *************************************************************************
//! メッセージバーを閉じる
// *************************************************************************
procedure TGikoDM.MsgBarCloseActionExecute(Sender: TObject);
begin
	MsgBarVisibleAction.Execute;
end;
// *************************************************************************
//! ステータスバーの表示状態を変更する
// *************************************************************************
procedure TGikoDM.StatusBarVisibleActionExecute(Sender: TObject);
begin
	GikoForm.StatusBar.Visible := StatusBarVisibleAction.Checked;
	GikoSys.Setting.StatusBarVisible := StatusBarVisibleAction.Checked;
end;
// *************************************************************************
//! キャビネットの表示を掲示板にする
// *************************************************************************
procedure TGikoDM.CabinetBBSActionExecute(Sender: TObject);
begin

	if GikoForm.CabinetPanel.Visible then begin
		if GikoForm.TreeType = gtt2ch then begin
			GikoForm.CabinetVisible( False );

			CabinetBBSAction.Checked := False;
		end else begin
			CabinetBBSAction.Checked := True;
		end;
	end else begin
		GikoForm.CabinetVisible( True );
		CabinetBBSAction.Checked := True;
	end;

	if GikoForm.ActiveBBS = nil then
		GikoForm.ShowBBSTree( BBSs[ 0 ] )
	else
		GikoForm.ShowBBSTree( GikoForm.ActiveBBS );

end;
// *************************************************************************
//! キャビネットの表示を履歴リストにする
// *************************************************************************
procedure TGikoDM.CabinetHistoryActionExecute(Sender: TObject);
begin
	GikoForm.ShowHistoryTree;
end;
// *************************************************************************
//! キャビネットの表示をお気に入りリストにする
// *************************************************************************
procedure TGikoDM.CabinetFavoriteActionExecute(Sender: TObject);
var
	i, b : Integer;
	item : TMenuItem;
begin

	if GikoForm.CabinetPanel.Visible then begin
		if GikoForm.TreeType = gttFavorite then begin
			GikoForm.CabinetVisible( False );
			CabinetFavoriteAction.Checked := False;
		end else begin
			CabinetFavoriteAction.Checked := True;
		end;
	end else begin
		GikoForm.CabinetVisible( True );
		CabinetFavoriteAction.Checked := True;
	end;

	// BBS...BBS, History, Favorite
	GikoSys.Setting.CabinetIndex := GikoForm.CabinetSelectPopupMenu.Items.Count - 1;

	b := GikoForm.CabinetSelectPopupMenu.Items.Count - 1;
	for i := 0 to b do begin
		item := GikoForm.CabinetSelectPopupMenu.Items[ i ];
		if item is TBBSMenuItem then begin
			item.Checked := False;
			// CabinetMenu は CabinetSelectPopupMenu と同じと決めうちしちゃう
			GikoForm.CabinetMenu.Items[ i ].Checked := False;
		end;
	end;

	// キャビネットツールバー及びキャビネットの表示切替
	GikoForm.HistoryToolBar.Hide;
	GikoForm.FavoriteToolBar.Show;
	GikoForm.TreeViewUC.Visible := False;
	GikoForm.FavoriteTreeViewUC.Visible := True;

	GikoForm.CabinetSelectToolButton.Caption := 'お気に入り';
	GikoForm.TreeType := gttFavorite;

	// メニュー及びボタンのチェックを設定
	CabinetBBSAction.Checked := False;
	CabinetHistoryAction.Checked := False;

	// お気に入りのツリーを展開
	GikoForm.FavoriteTreeViewUC.Items.GetFirstNode.Expanded := True;

end;
// *************************************************************************
//! キャビネットの表示状態を変更する
// *************************************************************************
procedure TGikoDM.CabinetVisibleActionExecute(Sender: TObject);
begin
	case GikoForm.TreeType of
	gttHistory:		CabinetHistoryAction.Execute;
	gttFavorite:	CabinetFavoriteAction.Execute;
	else
		CabinetBBSAction.Execute;
	end;
end;
// *************************************************************************
//! キャビネットを閉じる
// *************************************************************************
procedure TGikoDM.CabinetCloseActionExecute(Sender: TObject);
begin
	//INFO 2005/11/19 このアクションには何も設定されていなかった　もじゅ
end;
// *************************************************************************
//! リストを大きいアイコン表示にする
// *************************************************************************
procedure TGikoDM.LargeIconActionExecute(Sender: TObject);
begin
	GikoForm.ListViewUC.ViewStyle := vsIcon;
	LargeIconAction.Checked := True;
end;
// *************************************************************************
//! リストを小さいアイコン表示にする
// *************************************************************************
procedure TGikoDM.SmallIconActionExecute(Sender: TObject);
begin
	GikoForm.ListViewUC.ViewStyle := vsSmallIcon;
	SmallIconAction.Checked := True;
end;
// *************************************************************************
//! リストを一覧表示にする
// *************************************************************************
procedure TGikoDM.ListIconActionExecute(Sender: TObject);
begin
	GikoForm.ListViewUC.ViewStyle := vsList;
	ListIconAction.Checked := True;
end;
// *************************************************************************
//! リストを詳細表示にする
// *************************************************************************
procedure TGikoDM.DetailIconActionExecute(Sender: TObject);
begin
	GikoForm.ListViewUC.ViewStyle := vsReport;
	DetailIconAction.Checked := True;
end;

// *************************************************************************
//! ダウンロードを中止する
// *************************************************************************
procedure TGikoDM.StopActionExecute(Sender: TObject);
begin
	GikoForm.FControlThread.DownloadAbort;
	if GikoForm.WorkCount <> 0 then GikoForm.WorkCount := 0;
	try
		GikoForm.Animate.Active := False;
	except
	end;
	GikoForm.ScreenCursor := crDefault;
end;
// *************************************************************************
//! リストとブラウザの縦横配置を変更する
// *************************************************************************
procedure TGikoDM.ArrangeActionExecute(Sender: TObject);
begin
	if ArrangeAction.Checked then begin
		//縦
		GikoForm.ViewPanel.Align := alNone;
		GikoForm.ListSplitter.Align := alNone;
		GikoForm.ThreadPanel.Align := alNone;

		GikoForm.ViewPanel.Width := GikoForm.BrowserSizeWidth;
		GikoForm.ViewPanel.Align := alLeft;

		GikoForm.ListSplitter.Width := 5;
		GikoForm.ListSplitter.Align := alLeft;

		GikoForm.ViewPanel.Left := -10;

		GikoForm.ThreadPanel.Align := alClient;

		GikoSys.Setting.ListOrientation := gloHorizontal;
		case GikoSys.Setting.ListWidthState of
			glsMax: begin
				BrowserMaxAction.ImageIndex := TOOL_ICON_WIDTH_NORMAL;
				BrowserMinAction.ImageIndex := TOOL_ICON_WIDTH_MIN;
				GikoForm.ViewPanel.Width := 1;
			end;
			glsNormal: begin
				BrowserMaxAction.ImageIndex := TOOL_ICON_WIDTH_MAX;
				BrowserMinAction.ImageIndex := TOOL_ICON_WIDTH_MIN;
			end;
			glsMin: begin
				BrowserMaxAction.ImageIndex := TOOL_ICON_WIDTH_MAX;
				BrowserMinAction.ImageIndex := TOOL_ICON_WIDTH_NORMAL;
				GikoForm.ViewPanel.Width := GikoForm.ThreadMainPanel.Width - 80;
			end;
		end;
	end else begin
		//横
		GikoForm.ViewPanel.Align := alNone;
		GikoForm.ListSplitter.Align := alNone;
		GikoForm.ThreadPanel.Align := alNone;

		GikoForm.ViewPanel.Height := GikoForm.BrowserSizeHeight;
		GikoForm.ViewPanel.Align := alTop;

		GikoForm.ListSplitter.Height := 5;
		GikoForm.ListSplitter.Align := alTop;

		GikoForm.ViewPanel.Top := -10;

		GikoForm.ThreadPanel.Align := alClient;
		GikoSys.Setting.ListOrientation := gloVertical;
		case GikoSys.Setting.ListHeightState of
			glsMax: begin
				BrowserMaxAction.ImageIndex := TOOL_ICON_HEIGHT_NORMAL;
				BrowserMinAction.ImageIndex := TOOL_ICON_HEIGHT_MIN;
				GikoForm.ViewPanel.Height := 1;
			end;
			glsNormal: begin
				BrowserMaxAction.ImageIndex := TOOL_ICON_HEIGHT_MAX;
				BrowserMinAction.ImageIndex := TOOL_ICON_HEIGHT_MIN;
			end;
			glsMin: begin
				BrowserMaxAction.ImageIndex := TOOL_ICON_HEIGHT_MAX;
				BrowserMinAction.ImageIndex := TOOL_ICON_HEIGHT_NORMAL;
				GikoForm.ViewPanel.Height :=
					GikoForm.ThreadMainPanel.Height - GikoForm.BrowserCoolBar.Height - 7;
			end;
		end;
	end;
end;
// *************************************************************************
//! ペインのサイズを初期化する
// *************************************************************************
procedure TGikoDM.PaneInitActionExecute(Sender: TObject);
begin
	GikoForm.CabinetPanel.Width := 150;
	GikoForm.MessagePanel.Height := 40;

	GikoForm.BrowserSizeWidth := 200;
	GikoForm.BrowserSizeHeight := 200;
	if ArrangeAction.Checked then begin
		GikoForm.ViewPanel.Width := GikoForm.BrowserSizeWidth;
	end else begin
		GikoForm.ViewPanel.Height := GikoForm.BrowserSizeHeight;
	end;
	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		if GikoSys.Setting.ListHeightState = glsMax then begin
			BrowserMaxAction.ImageIndex := TOOL_ICON_HEIGHT_MAX;
			GikoSys.Setting.ListHeightState := glsNormal;
		end;
	end else begin
		if GikoSys.Setting.ListWidthState = glsMax then begin
			BrowserMaxAction.ImageIndex := TOOL_ICON_WIDTH_MAX;
			GikoSys.Setting.ListWidthState := glsNormal;
		end;
	end;
end;
// *************************************************************************
//! ブラウザタブの表示状態を変更する
// *************************************************************************
procedure TGikoDM.BrowserTabVisibleActionExecute(Sender: TObject);
begin
	GikoSys.Setting.BrowserTabVisible := BrowserTabVisibleAction.Checked;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! ブラウザタブを上に表示する
// *************************************************************************
procedure TGikoDM.BrowserTabTopActionExecute(Sender: TObject);
begin
	BrowserTabBottomAction.Checked := False;
	BrowserTabTopAction.Checked := True;
	GikoSys.Setting.BrowserTabPosition := gtpTop;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! ブラウザタブを下に表示する
// *************************************************************************
procedure TGikoDM.BrowserTabBottomActionExecute(Sender: TObject);
begin
	BrowserTabTopAction.Checked := False;
	BrowserTabBottomAction.Checked := True;
	GikoSys.Setting.BrowserTabPosition := gtpBottom;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! ブラウザタブのスタイルをタブスタイルにする
// *************************************************************************
procedure TGikoDM.BrowserTabTabStyleActionExecute(Sender: TObject);
begin
	BrowserTabButtonStyleAction.Checked := False;
	BrowserTabFlatStyleAction.Checked := False;
	BrowserTabTabStyleAction.Checked := True;
	GikoSys.Setting.BrowserTabStyle := gtsTab;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! ブラウザタブのスタイルをボタンスタイルにする
// *************************************************************************
procedure TGikoDM.BrowserTabButtonStyleActionExecute(Sender: TObject);
begin
	BrowserTabTabStyleAction.Checked := False;
	BrowserTabFlatStyleAction.Checked := False;
	BrowserTabButtonStyleAction.Checked := True;
	GikoSys.Setting.BrowserTabStyle := gtsButton;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! ブラウザタブのスタイルをフラットボタンスタイルにする
// *************************************************************************
procedure TGikoDM.BrowserTabFlatStyleActionExecute(Sender: TObject);
begin
	BrowserTabFlatStyleAction.Checked := True;
	BrowserTabTabStyleAction.Checked := False;
	BrowserTabButtonStyleAction.Checked := False;
	GikoSys.Setting.BrowserTabStyle := gtsFlat;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! ブラウザにフォーカスを当てる
// *************************************************************************
procedure TGikoDM.SetFocusForBrowserActionExecute(Sender: TObject);
begin
    GikoForm.ActiveContent.Browser.SetFocus;
end;
// *************************************************************************
//! ブラウザにフォーカスを当てるUpdateイベント
// *************************************************************************
procedure TGikoDM.SetFocusForBrowserActionUpdate(Sender: TObject);
begin
	if( GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil) and
		(GikoForm.ActiveContent.Browser <> GikoForm.BrowserNullTab.Browser) then
		TAction(Sender).Enabled := true
	else
		TAction(Sender).Enabled := false;
end;
// *************************************************************************
//! スレッド一覧にフォーカスを当てる
// *************************************************************************
procedure TGikoDM.SetFocusForThreadListActionExecute(Sender: TObject);
begin
	if GikoForm.ActiveContent <> nil then
		GikoForm.WebBrowserClick(GikoForm.ActiveContent.Browser); //一回Browserに当てないと動かないときがある
	GikoForm.ListViewUC.SetFocus;

	if( GikoForm.ListViewUC.Items.Count > 0 ) and (GikoForm.ListViewUC.ItemFocused = nil) then
		GikoForm.ListViewUC.Items.Item[0].Selected := true; //選択アイテムが無いときは先頭のを選択する

	//スクロールさせる
	if (GikoForm.ListViewUC.ItemFocused <> nil) then begin
		GikoForm.ListViewUC.ItemFocused.MakeVisible(False);
	end;
end;
// *************************************************************************
//! キャビネットにフォーカスを当てる
// *************************************************************************
procedure TGikoDM.SetFocusForCabinetActionExecute(Sender: TObject);
begin
	if GikoForm.ActiveContent <> nil then
		GikoForm.WebBrowserClick(GikoForm.ActiveContent.Browser); //一回Browserに当てないと動かないときがある
	if GikoForm.TreeViewUC.Visible then begin
		GikoForm.TreeViewUC.SetFocus;
		if(GikoForm.TreeViewUC.Items.Count > 0) and ( GikoForm.TreeViewUC.Selected = nil ) then
			GikoForm.TreeViewUC.Items.Item[0].Selected := true;
	end else if GikoForm.FavoriteTreeViewUC.Visible then begin
		GikoForm.FavoriteTreeViewUC.SetFocus;
		if(GikoForm.FavoriteTreeViewUC.Items.Count > 0) and (GikoForm.FavoriteTreeViewUC.Selected = nil) then
			GikoForm.FavoriteTreeViewUC.Items.Item[0].Selected := true;
	end;
end;
// *************************************************************************
//! キャビネットにフォーカスを当てるUpdateイベント
// *************************************************************************
procedure TGikoDM.SetFocusForCabinetActionUpdate(Sender: TObject);
begin
	SetFocusForCabinetAction.Enabled := GikoForm.CabinetPanel.Visible;
end;
// *************************************************************************
//! スレッド一覧を最大化してフォーカスを当てる
// *************************************************************************
procedure TGikoDM.ThreadlistMaxAndFocusActionExecute(Sender: TObject);
begin
	BrowserMinAction.Execute;
	SetFocusForThreadListAction.Execute;
end;
// *************************************************************************
//! スレ表示を最大化してフォーカスを当てる
// *************************************************************************
procedure TGikoDM.BrowserMaxAndFocusActionExecute(Sender: TObject);
begin
	BrowserMaxAction.Execute;
	SetFocusForBrowserAction.Execute;
end;
// *************************************************************************
//! スレッド一覧の選択を削除する
// *************************************************************************
procedure TGikoDM.UnSelectedListViewActionExecute(Sender: TObject);
begin
	if GikoForm.ListViewUC.Selected <> nil then begin
		GikoForm.ListViewUC.Selected.Focused := True;
		GikoForm.ListViewUC.Selected := nil;
	end;
end;
////////////////////////////////表示までおしまい/////////////////////
// *************************************************************************
//! 選択されているスレッドを既読にする
// *************************************************************************
procedure TGikoDM.KidokuActionExecute(Sender: TObject);
begin
	SetThreadReadProperty(true);
end;
// *************************************************************************
//! 選択されているスレッドを未読にする
// *************************************************************************
procedure TGikoDM.MidokuActionExecute(Sender: TObject);
begin
	SetThreadReadProperty(false);
end;
// *************************************************************************
//! 選択されているスレッドの未読・既読を設定する   true : 既読 false : 未読
// *************************************************************************
procedure TGikoDM.SetThreadReadProperty(read: Boolean);
var
	List: TList;
	i: Integer;
begin
	List := TList.Create;
	try
		GikoForm.SelectListItem(List);
		for i := 0 to List.Count - 1 do begin
			if TObject(List[i]) is TThreadItem then begin
				if (TThreadItem(List[i]).IsLogFile) then begin
					TThreadItem(List[i]).UnRead := not read;
				end;
			end;
		end;
		if GikoForm.TreeViewUC.Visible then
			GikoForm.TreeViewUC.Refresh;
		if GikoForm.ListViewUC.Visible then
			GikoForm.ListViewUC.Refresh;
	finally
		List.Free;
	end;
end;
// *************************************************************************
//! リストを全て選択する
// *************************************************************************
procedure TGikoDM.AllSelectActionExecute(Sender: TObject);
begin
	GikoForm.ListViewAllSelect;
end;
// *************************************************************************
//! リストを全て選択するUpdateイベント
// *************************************************************************
procedure TGikoDM.AllSelectActionUpdate(Sender: TObject);
begin
	AllSelectAction.Enabled := GikoForm.ListViewUC.SelCount > 0;
end;
////////////////////////////////編集までおしまい/////////////////////
//! スレッドのサイズを再計算する
procedure TGikoDM.ThreadSizeCalcForFileActionExecute(Sender: TObject);
const
	RECALC_MES : String = 'スレッドの容量をファイルから再計算します。'#13#10 +
							'この操作中、ギコナビの他の操作をするとデータが破壊される恐れがあります。' +
							'またこの操作は、非常に時間がかかる場合がありますが、よろしいですか？';
	RECALC_TITLE : String = 'スレッドの容量をファイルから再計算';
	LIMIT_SIZE = 1024;
var
	limitSize : Integer;
	limitStr  : String;
begin
{ まず、時間がかかることを警告するメッセージを出力
  再計算するスレッドのサイズの閾値（デフォルト1024B)を確認
  プラグインを利用しないところで全てのログ有りスレッドを検索
  閾値以下のサイズの場合、DATのファイルサイズと比較、ずれていれば、
  DATのファイルサイズで更新する
}
	if MsgBox(GikoForm.Handle, RECALC_MES,
		RECALC_TITLE, MB_YESNO or MB_ICONWARNING) = ID_YES then begin
		//閾値の確認
		limitSize := LIMIT_SIZE;
		limitStr  := IntToStr(limitSize);
		if InputQuery('閾値入力', '指定した数値 B以下の容量のスレッドのみ再計算します', limitStr) then begin
			limitSize := StrToInt(MojuUtils.ZenToHan(limitStr));
			if (limitSize < 0) then begin
				ShowMessage('閾値に負は指定できません！');
				ThreadSizeCalcForFileActionExecute(nil);
			end else begin
				RecalcThreadSize(limitSize);
			end;
		end;
	end;
end;
//! limitよりもサイズの小さいスレッドの容量をDATファイルから計算
procedure TGikoDM.RecalcThreadSize(limit : Integer);
var
	i, j, tmpSize : Integer;
	Obj   : TObject;
	Board : TBoard;
	Thread: TThreadItem;
	dat   : TStringList;
begin
	// 再計算スタート　プラグインを利用しないところを全部見る！
	GikoForm.ScreenCursor := crHourGlass;
	try
		GikoForm.ProgressBar.Max := BoardGroups[0].Count;
		for i := 0 to BoardGroups[0].Count - 1 do begin
			Obj := BoardGroups[0].Objects[i];
			if (Obj <> nil) then begin
				Board := TBoard(Obj);
				if not Board.IsThreadDatRead then begin
					GikoSys.ReadSubjectFile(Board);
				end;
				for j := 0 to Board.Count - 1 do begin
					Thread := Board.Items[j];
					if (Thread <> nil) and (Thread.IsLogFile)
						and (Thread.Size <= limit) then begin
						dat := TStringList.Create;
						try
							tmpSize := Thread.Size;
							try
								dat.LoadFromFile(Thread.GetThreadFileName);
								tmpSize := Length(dat.Text);
								tmpSize := tmpSize - dat.Count;
							except
							end;
							Thread.Size := tmpSize;
						finally
							dat.Free;
						end;
					end;
				end;
			end;
			GikoForm.ProgressBar.StepBy(1);
		end;
	finally
		GikoForm.ScreenCursor := crDefault;
	end;
	GikoForm.ProgressBar.Position := 0;
	ShowMessage('計算終了しました。');
end;
// *************************************************************************
//! 入力アシストの設定フォームを呼び出す
// *************************************************************************
procedure TGikoDM.SetInputAssistActionExecute(Sender: TObject);
var
	form : TInputAssistForm;
begin
	form := TInputAssistForm.Create(GikoForm);
	try
		form.SetUpFromMain;
		form.ShowModal;
	finally
		form.Release;
	end;
end;
// *************************************************************************
//! 現在表示しているスレッドの検索ダイアログを表示する
// *************************************************************************
procedure TGikoDM.OpenFindDialogActionExecute(Sender: TObject);
begin
	if( GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil) then begin
		GikoForm.ActiveContent.OpenFindDialog;
	end;
end;

// *************************************************************************
//! 選択されているお気に入りの表示名をコピーする
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewItemNameCopyActionExecute(
  Sender: TObject);
begin
	if GikoForm.ClickNode = nil then Exit;

	WideCtrls.SetClipboard(GikoForm.ClickNode.Text + #13#10);
end;

// *************************************************************************
//! 表示されているすべてのレスエディタを閉じる
// *************************************************************************
procedure TGikoDM.CloseAllEditorActionExecute(Sender: TObject);
var
	i : Integer;
begin
	if ( EditorFormExists ) then begin
		//スクリーン上の全てのフォームから、EditorFormを閉じる
		for i := Screen.CustomFormCount - 1 downto 0 do begin
			if TObject(Screen.CustomForms[i]) is TEditorForm then begin
				TEditorForm(Screen.CustomForms[i]).Close;
			end;
		end;
	end;
end;
// *************************************************************************
//! スクリーン上にレスエディタがいた場合，有効になる
// *************************************************************************
procedure TGikoDM.CloseAllEditorActionUpdate(Sender: TObject);
begin
    if (Sender is TAction) then begin
        TAction(Sender).Enabled := EditorFormExists;
    end;
end;

// *************************************************************************
//! スクリーン上にEditorFormがいるか
// *************************************************************************
function TGikoDM.EditorFormExists(): boolean;
var
	i : Integer;
begin
	Result := false;
	//スクリーン上の全てのフォームから、EditorFormを探す
	for i := Screen.CustomFormCount - 1 downto 0 do begin
		if (Screen.CustomForms[i] is TEditorForm) then begin
			Result := true;
			Break;
		end;
	end;
end;

// *************************************************************************
//! スクリーン上にいるすべてのEditorFormから名前の履歴を削除する
// *************************************************************************
procedure TGikoDM.ClearNameTextAllEditor();
var
	i : Integer;
begin
	for i := 0 to Screen.CustomFormCount - 1 do begin
		if (Screen.CustomForms[i] is TEditorForm) then begin
			TEditorForm(Screen.CustomForms[i]).NameComboBox.Items.Clear;
        end;
	end;
end;
// *************************************************************************
//! スクリーン上にいるすべてのEditorFormからメール履歴を削除する
// *************************************************************************
procedure TGikoDM.ClearMailAllEditor();
var
	i : Integer;
begin
	for i := 0 to Screen.CustomFormCount - 1 do begin
		if TObject(Screen.CustomForms[i]) is TEditorForm then
			TEditorForm(Screen.CustomForms[i]).MailComboBox.Items.Clear;
	end;
end;

// *************************************************************************
//! リンク履歴を戻るの更新処理
// *************************************************************************
procedure TGikoDM.PrevMoveHistoryUpdate(Sender: TObject);
begin
      PrevMoveHistory.Enabled :=
          (MoveHisotryManager.HisotryIndex > 0)
end;
// *************************************************************************
//! リンク履歴を戻る
// *************************************************************************
procedure TGikoDM.PrevMoveHistoryExecute(Sender: TObject);
begin
    if ( GikoForm.BrowserTabUC.TabIndex >= 0 ) then begin
        BackToHistory(MoveHisotryManager.getPrevItem
            (TBrowserRecord(GikoForm.BrowserTabUC.Tabs
                    .Objects[GikoForm.BrowserTabUC.TabIndex])));
    end else begin
        BackToHistory(MoveHisotryManager.getPrevItem( nil ) );
    end;
end;
//! リンク履歴処理
procedure TGikoDM.BackToHistory(item: TMoveHistoryItem);
var
    browser : TWebBrowser;
    doc : IHTMLDocument2;
begin
    if ( item <> nil ) then begin
        if ( GikoForm.GetActiveContent = item.ThreadItem ) then begin
            browser := TBrowserRecord(GikoForm.BrowserTabUC.Tabs
                .Objects[GikoForm.BrowserTabUC.TabIndex]).Browser;
            if (browser <> nil) then begin
                try
                    doc := browser.ControlInterface.Document as IHTMLDocument2;
                    (doc.body as IHTMLElement2).ScrollTop := item.ScrollTop;
                except
                end;
            end;
        end else begin
            //URLに移動
            MoveURLWithHistory(item.ThreadItem.URL, True);
        end;
    end;
end;
//! 履歴処理つきURL移動
procedure TGikoDM.MoveURLWithHistory(URL : String; KeyMask: Boolean = False);
var
    idx : Integer;
begin
    //URLに移動
    GikoForm.MoveToURL(URL, KeyMask);
    //以下、履歴の処理
    idx := GikoForm.AddressComboBox.Items.IndexOf(URL);
    if idx = -1 then begin
        GikoForm.AddressComboBox.Items.Insert(0, URL);
        if GikoForm.AddressComboBox.Items.Count > GikoSys.Setting.AddressHistoryCount then
            GikoForm.AddressComboBox.Items.Delete(GikoForm.AddressComboBox.Items.Count - 1);
    end else begin
        GikoForm.AddressComboBox.Items.Delete(idx);
        GikoForm.AddressComboBox.Items.Insert(0, URL);
    end;
end;
// *************************************************************************
//! リンク履歴を進むの更新処理
// *************************************************************************
procedure TGikoDM.NextMoveHistoryUpdate(Sender: TObject);
begin
    NextMoveHistory.Enabled :=
          (MoveHisotryManager.HisotryIndex < MoveHisotryManager.Count - 1);
end;
// *************************************************************************
//! リンク履歴を進む
// *************************************************************************
procedure TGikoDM.NextMoveHistoryExecute(Sender: TObject);
begin
    BackToHistory(MoveHisotryManager.getNextItem);
end;
// *************************************************************************
//! アクティブ要素のクリック
// *************************************************************************
procedure TGikoDM.ClickActiveElementActionExecute(Sender: TObject);
var
    browser : TWebBrowser;
    elem : IHTMLElement;
    doc : IHTMLDocument2;
begin
    if (GikoForm.GetActiveContent <> nil) then begin
        if (GikoForm.BrowserTabUC.Tabs.Count > 0) and
            (GikoForm.BrowserTabUC.TabIndex >= 0) then begin
            browser := TBrowserRecord(GikoForm.BrowserTabUC.Tabs
                .Objects[GikoForm.BrowserTabUC.TabIndex]).Browser;
            if (browser <> nil) then begin
                try
                    doc := browser.ControlInterface.Document as IHTMLDocument2;
                    if Assigned(doc) then begin
                        elem := doc.activeElement;
                        if Assigned(elem) then begin
                            elem.click;
                        end;
                    end;
                except
                end;
            end;

        end;
    end;
end;
//! ↓キーのエミュレートアクション
procedure TGikoDM.VKDownActionExecute(Sender: TObject);
begin
    keybd_event(VK_DOWN, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_DOWN, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
end;
//! ↑キーのエミュレートアクション
procedure TGikoDM.VKUpActionExecute(Sender: TObject);
begin
    keybd_event(VK_UP, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_UP, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
end;
//! →キーのエミュレートアクション
procedure TGikoDM.VKRightActionExecute(Sender: TObject);
begin
    keybd_event(VK_RIGHT, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_RIGHT, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
end;
//! ←キーのエミュレートアクション
procedure TGikoDM.VKLeftActionExecute(Sender: TObject);
begin
    keybd_event(VK_LEFT, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_LEFT, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
end;
//! タスクトレイに格納する
procedure TGikoDM.StoredTaskTrayActionExecute(Sender: TObject);
begin
    GikoForm.StoredTaskTray;
    StoredTaskTrayAction.Tag := -1;
end;

{
\breif  リンクイメージ取得
イメージは，*.jpg, *.jpeg, *.gif, *.png
}
procedure TGikoDM.AllImageLinkToClipbordActionExecute(Sender: TObject);
var
    links : IHTMLElementCollection;
    urls, exts : TStringList;
begin
    links := GetActiveThreadLinks;
    if (links <> nil) then begin
        urls := TStringList.Create;
        exts := TStringList.Create;
        try
            exts.CaseSensitive := False;
            exts.Sorted := True;
            exts.Delimiter := ';';
            exts.DelimitedText := '.gif;.jpg;.jpeg;.png';
            GetLinkURLs(links, urls, 0, exts);
            Clipboard.SetTextBuf(urls.GetText);
        finally
            exts.Free;
            urls.Free;
        end;
    end;
end;

{
\breif  新着レスのリンクイメージ取得
イメージは，*.jpg, *.jpeg, *.gif, *.png
}
procedure TGikoDM.NewImageLinkToClipBoardActionExecute(Sender: TObject);
var
    links : IHTMLElementCollection;
    urls, exts : TStringList;
    ThreadItem : TThreadItem;
begin
    ThreadItem := GikoForm.GetActiveContent;
    links := GetActiveThreadLinks;
    if (ThreadItem <> nil) and (links <> nil) then begin
        urls := TStringList.Create;
        exts := TStringList.Create;
        try
            exts.CaseSensitive := False;
            exts.Sorted := True;
            exts.Delimiter := ';';
            exts.DelimitedText := '.gif;.jpg;.jpeg;.png';

            GetLinkURLs(links, urls,
                (ThreadItem.Count - ThreadItem.NewResCount + 1), exts );
            Clipboard.SetTextBuf(urls.GetText);
        finally
            exts.Free;
            urls.Free;
        end;
    end;
end;
{
\breif  リンクURL取得
対象拡張子は、詳細設定で設定されている
}
procedure TGikoDM.AllLinkToClipboardActionExecute(Sender: TObject);
var
    links : IHTMLElementCollection;
    urls, exts : TStringList;
begin
    links := GetActiveThreadLinks;
    if (links <> nil) then begin
        urls := TStringList.Create;
        exts := TStringList.Create;
        try
            exts.CaseSensitive := False;
            exts.Sorted := True;
            exts.Delimiter := ';';
            exts.DelimitedText :=
                MojuUtils.CustomStringReplace(GikoSys.Setting.ExtList, '*', '');
            GetLinkURLs(links, urls, 0, exts);
            Clipboard.SetTextBuf(urls.GetText);
        finally
            exts.Free;
            urls.Free;
        end;
    end;
end;
{
\breif  新着レスリンクURL取得
対象拡張子は、詳細設定で設定されている
}
procedure TGikoDM.NewLinkToClipboardActionExecute(Sender: TObject);
var
    links : IHTMLElementCollection;
    urls, exts : TStringList;
    ThreadItem : TThreadItem;
begin
    ThreadItem := GikoForm.GetActiveContent;
    links := GetActiveThreadLinks;
    if (ThreadItem <> nil) and (links <> nil) then begin
        urls := TStringList.Create;
        exts := TStringList.Create;
        try
            exts.CaseSensitive := False;
            exts.Sorted := True;
            exts.Delimiter := ';';
            exts.DelimitedText :=
                MojuUtils.CustomStringReplace(GikoSys.Setting.ExtList, '*', '');
            GetLinkURLs(links, urls,
                (ThreadItem.Count - ThreadItem.NewResCount + 1), exts );
            Clipboard.SetTextBuf(urls.GetText);
        finally
            exts.Free;
            urls.Free;
        end;
    end;
end;

{
\brief  現在表示しているスレッドのすべてのリンクを取得する。
\return IHTMLElementCollection  リンクのコレクション
}
function TGikoDM.GetActiveThreadLinks : IHTMLElementCollection;
var
    browser : TWebBrowser;
    doc : IHTMLDocument2;
begin
    Result := nil;
    if (GikoForm.GetActiveContent <> nil) then begin
        if (GikoForm.BrowserTabUC.Tabs.Count > 0) and
            (GikoForm.BrowserTabUC.TabIndex >= 0) then begin
            browser := TBrowserRecord(GikoForm.BrowserTabUC.Tabs
                .Objects[GikoForm.BrowserTabUC.TabIndex]).Browser;
            if (browser <> nil) then begin
                try
                    doc := browser.ControlInterface.Document as IHTMLDocument2;
                    if Assigned(doc) then begin
                        Result := doc.links;
                    end;
                except
                    Result := nil;
                end;
            end;

        end;
    end;
end;
{
\brief  リンクのURLを取得する
\param  links   取得するリンクの全体のコレクション
\param  URLs    取得したURLの保存先
\param  Start   設定したレス番号以降を取得( > 0)
\param  Exts    取得するリンクの拡張子
}
procedure TGikoDM.GetLinkURLs(links : IHTMLElementCollection;
        URLs : TStringList; const Start: Integer; Exts : TStringList);
var
    index ,i, j : Integer;
    item : IHTMLElement;
    url, ext : string;
begin
    if (links <> nil) then begin
        index := 0;
        for i := 0 to links.length - 1 do begin
            item := links.item(i, 0) as IHTMLElement;
            if (item <> nil) then begin
                url := item.getAttribute('href', 0);
                // レスの番号を更新
                if (Pos('menu:', url) > 0) then begin
                    index := StrToInt64Def(
                        Copy(url, 6, Length(url)), index + 1
                    );
                end else begin
                    // 開始レス番号以降かチェック
                    if (index >= Start) then begin
                        ext := ExtractFileExt( AnsiLowerCase(url) );
                        // 拡張子をチェック
                        if Exts.Find(ext, j) then begin
                            urls.Add(url)
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
{
\brief  アドレスバーにフォーカスを当てる
\param  Sender   イベントの発生元
}
procedure TGikoDM.SetForcusForAddresBarActionExecute(Sender: TObject);
begin
    if ( GikoForm.AddressToolBar.Visible ) then begin
        GikoForm.AddressComboBox.SetFocus;
    end
end;
{
\brief  移転した板のURLを取得するダイアグラムを表示する
}
procedure TGikoDM.NewBoardSearchActionExecute(Sender: TObject);
var
    form : TNewBoardURLForm;
	Msg: string;
begin
	if (EditorFormExists) then begin
		Msg := 'レスエディタを全て閉じてください';
		MsgBox(GikoForm.Handle, Msg, MSG_ERROR, MB_OK or MB_ICONSTOP);
		Exit;
	end;
    form := TNewBoardURLForm.Create(Self);
    try
        form.ShowModal;
    finally
        form.Release;
    end;
end;
//! ブラウザを1ページ分スクロールさせる
procedure TGikoDM.ScrollPageDownActionExecute(Sender: TObject);
begin
    GikoForm.BrowserMovement(GikoForm.BrowserPanel.Height);
end;
//! ブラウザを1ページ分スクロールさせる
procedure TGikoDM.ScrollPageUpActionExecute(Sender: TObject);
begin
    GikoForm.BrowserMovement(-GikoForm.BrowserPanel.Height);
end;


//! このレスのIDをNGワードに追加する（透明)
procedure TGikoDM.AddIDtoNGWord0ActionExecute(Sender: TObject);
begin
    GikoForm.AddIDtoNGWord(true);
end;
//! このレスのIDをNGワードに追加する
procedure TGikoDM.AddIDtoNGWord1ActionExecute(Sender: TObject);
begin
    GikoForm.AddIDtoNGWord(false);
end;
//! クリップボードの文字列をIDとして同一IDレスアンカー表示
procedure TGikoDM.ExtractSameIDActionExecute(Sender: TObject);
var
    ID: String;
begin
    ID := Trim(Clipboard.AsText);
    if (Length(ID) > 0) then begin
        if not IsNoValidID(ID) then begin
            GikoForm.ShowSameIDAncher(ID);
        end;
    end;
end;
//! タブのスレッド一覧を表示する
procedure TGikoDM.ShowTabListActionExecute(Sender: TObject);
var
    i : Integer;
begin
    GikoForm.ListViewUC.Items.BeginUpdate;
    GikoForm.ListViewUC.Items.Clear;
    BoardGroup.SpecialBoard.Clear;
	for i := GikoForm.BrowserTabUC.Tabs.Count - 1 downto 0 do begin
        BoardGroup.SpecialBoard.Add(
    		TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[i]).Thread);
	end;
    GikoForm.ListViewUC.Items.EndUpdate;
    GikoForm.SetActiveList(BoardGroup.SpecialBoard);
end;
//! 逆参照しているレスを追加する
procedure TGikoDM.DereferenceResActionExecute(Sender: TObject);
var
	i, currentNo, No : Integer;
    links : IHTMLElementCollection;
    threadItem : TThreadItem;
    item : IHTMLElement;
    url, url2 : string;
    resNo : TStringList;
    alreadyExist : Boolean;
  	PathRec: TPathRec;
begin
	No := GikoForm.KokoPopupMenu.Tag;
	if No = 0 then Exit;

    ThreadItem := GikoForm.KokoPopupThreadItem;
    // アクティブタブから全てのリンクを取得する
    links := GetActiveThreadLinks;
    if (ThreadItem <> nil) and (links <> nil) then begin
        resNo := TStringList.Create;
        try
            currentNo := 0;
            alreadyExist := False;
            // リンクを全て走査する
            for i := 0 to links.length - 1 do begin
                item := links.item(i, 0) as IHTMLElement;
                if (item <> nil) then begin
                    url := item.getAttribute('href', 0);
                    // レスの番号を更新
                    if (Pos('menu:', url) > 0) then begin
                        currentNo := StrToInt64Def(
                            Copy(url, 6, Length(url)), currentNo + 1
                        );
                        alreadyExist := False;
                    end else if (currentNo <> -1) and (not alreadyExist) then begin
                        // IE7対応
                        if Pos('about:..', url) = 1 then begin
                            url := 'about:blank..' + Copy( url, Length('about:..')+1, Length(url) )
                        end;
                        // 自分へのリンクからレスポップ用の番号取得
                        if Pos('about:blank..', url) = 1 then begin
                            // No 番へのリンクがあれば参照あり
                            url2 := THTMLCreate.GetRespopupURL(url, ThreadItem.URL);
                			PathRec := Gikosys.Parse2chURL2(url2);
                            if (not PathRec.FNoParam) then begin
                                Gikosys.GetPopupResNumber(url2,PathRec.FSt,PathRec.FTo);
			                end;
                            // 対象レスもしくはそれを含むなら参照ありとする
                            if (PathRec.FSt = No) or
                                ((PathRec.FSt <= No) and (PathRec.FTo >= No))  then begin
                                alreadyExist := True;
                                resNo.Add(IntToStr(currentNo));
                            end;
                        end;
                    end;
                end;
            end;
            // 無制限なので-1固定
            GikoForm.ActiveContent.IDAnchorPopup(
                GikoSys.CreateResAnchor(resNo, ThreadItem, -1));
        finally
            resNo.Clear;
            resNo.Free;
        end;
    end;
end;

procedure TGikoDM.UpdateGikonaviActionExecute(Sender: TObject);
var
    form : TUpdateCheckForm;
	Msg: string;
    shutdown: boolean;
begin
	if (EditorFormExists) then begin
		Msg := 'レスエディタを全て閉じてください';
		MsgBox(GikoForm.Handle, Msg, MSG_ERROR, MB_OK or MB_ICONSTOP);
		Exit;
	end;
    GikoForm.UpdateExePath := '';
    GikoForm.UpdateExeArgs := '';
    form := TUpdateCheckForm.Create(GikoForm);
    try
        form.ShowModal;
        shutdown := form.Allowshutdown;
        if shutdown then begin
            GikoForm.UpdateExePath := form.ExecPath;
            GikoForm.UpdateExeArgs := form.ExecArgs;
        end;
    finally
        form.Release;
    end;
    if shutdown then begin
        // ギコナビ終了
        GikoForm.Close;
    end;

end;
//! このレスのURLコピー（PATH_INFO)
procedure TGikoDM.konoURLPATHActionExecute(Sender: TObject);
var
    No : Integer;
    ThreadItem : TThreadItem;
    URL, Protocol, Host, Path, Document, Port, Bookmark : String;
begin
	No := GikoForm.KokoPopupMenu.Tag;
	if No = 0 then Exit;

    ThreadItem := GikoForm.KokoPopupThreadItem;
    if (ThreadItem.ParentBoard.Is2ch) or not (Pos('?', ThreadItem.URL) > 0) then begin
        GikoSys.ParseURI(ThreadItem.URL,Protocol, Host, Path, Document, Port, Bookmark);
        URL := Protocol + '://' + Host + Path + IntToStr(No);
    end else begin
        if Pos('?', ThreadItem.URL) > 0 then begin
            URL := Copy(ThreadItem.URL, 1, Pos('?', ThreadItem.URL)-1);
            // まちBBS用処置
            URL := MojuUtils.CustomStringReplace(URL, 'read.pl', 'read.cgi');
            URL := URL + '/' + ThreadItem.ParentBoard.BBSID + '/' + ChangeFileExt(ThreadItem.FileName, '')  + '/' + IntToStr(No);
        end;
    end;
    Clipboard.SetTextBuf( PChar(URL) );
end;
//! このレスのURLコピー（Query_STRING)
procedure TGikoDM.konoURLQueryActionExecute(Sender: TObject);
var
    No : Integer;
    ThreadItem : TThreadItem;
    URL, Protocol, Host, Path, Document, Port, Bookmark : String;
begin
	No := GikoForm.KokoPopupMenu.Tag;
	if No = 0 then Exit;

    ThreadItem := GikoForm.KokoPopupThreadItem;
    // 2chとしたらばは、レス番号をうまく処理してくれないので利用不可
    if ThreadItem.ParentBoard.Is2ch or not (Pos('?', ThreadItem.URL) > 0) then begin
        GikoSys.ParseURI(ThreadItem.URL, Protocol, Host, Path, Document, Port, Bookmark);
        URL := Protocol + '://' + Host + '/test/read.cgi?bbs=' + ThreadItem.ParentBoard.BBSID
            + '&key=' + ChangeFileExt(ThreadItem.FileName, '') + '&st=' + IntToStr(No) + '&to=' + IntToStr(No);
    end else begin
        URL := ThreadItem.URL;
        // まちBBS
        if Pos('&LAST=', URL) > 0 then begin
            URL := Copy(URL, 1, Pos('&LAST=', URL) - 1);
            URL := URL + '&START=' + IntToStr(No) + '&END=' + IntToStr(No);
        end;
        // その他外部板
        if Pos('&ls=', URL) > 0 then begin
            URL := Copy(URL, 1, Pos('&ls=', URL) - 1);
            URL := URL + '&st=' + IntToStr(No) + '&to=' + IntToStr(No);
        end;

    end;
    Clipboard.SetTextBuf( PChar(URL) );
end;
//! このレスのURLコピー（Query_STRING）の利用チェック
procedure TGikoDM.konoURLQueryActionUpdate(Sender: TObject);
//const
//	LIVEDOOR_URL = 'http://jbbs.shitaraba.net/';
begin
    // 2chとしたらばは利用できないようにする（うまくレス指定できないので）
    konoURLQueryAction.Enabled := false;
    if (GikoForm.KokoPopupThreadItem <> nil) then begin
        konoURLQueryAction.Enabled := not GikoForm.KokoPopupThreadItem.ParentBoard.Is2ch;
        if konoURLQueryAction.Enabled then begin
            //konoURLQueryAction.Enabled := not (Pos(LIVEDOOR_URL, GikoForm.KokoPopupThreadItem.URL) = 1);
            konoURLQueryAction.Enabled := not GikoSys.IsShitarabaURL(GikoForm.KokoPopupThreadItem.URL);
        end;
    end;
end;
//! ポップアップメニュー設定ダイアログを開く
procedure TGikoDM.PopupMenuSettingActionExecute(Sender: TObject);
var
	Dlg: TPopupMenuSettingDialog;
begin
	Dlg := TPopupMenuSettingDialog.Create(GikoForm, GikoFormActionList);
	try
		Dlg.ShowModal;
	finally
		Dlg.Release;
	end;
end;

procedure TGikoDM.ThreadSearchActionExecute(Sender: TObject);
begin
    if (ThreadSrch <> nil) and (ThreadSrch.Visible = False) then begin
        ThreadSrch.Free;
        ThreadSrch := nil;
    end;
    if (ThreadSrch = nil) then begin
        ThreadSrch := TThreadSrch.Create(GikoForm);
    end;
    ThreadSrch.Show;
end;

procedure TGikoDM.SaveThreadSearchSetting;
begin
    if (ThreadSrch <> nil) and (ThreadSrch.Visible = True) then
        ThreadSrch.SaveSetting;
end;

procedure TGikoDM.ThreadNgEditActionExecute(Sender: TObject);
begin
    ThreadNGEdit := TThreadNGEdit.Create(GikoForm);
    if (ThreadNGEdit.ShowModal = mrOk) then begin
        if GikoForm.ListViewUC.Visible then
        	GikoForm.UpdateListView();
    end;
    ThreadNGEdit.Free;
    ThreadNGEdit := nil;
end;

// ドングリシステム画面表示
procedure TGikoDM.DonguriActionExecute(Sender: TObject);
begin
	try
    if DonguriForm = nil then begin
      DonguriForm := TDonguriForm.Create(GikoForm);
    end;

  	if DonguriForm.Visible = False then
      DonguriForm.Show;

  	if DonguriForm.WindowState = wsMinimized then
      DonguriForm.WindowState := wsNormal;

    if GikoSys.Setting.DonguriStay = False then begin
	  	SetWindowPos(DonguriForm.Handle, HWND_TOPMOST,   0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
	  	SetWindowPos(DonguriForm.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
    end;
	except
  end;
end;

procedure TGikoDM.DonguriActionHint(var HintStr: string; var CanShow: Boolean);
begin
  if (GikoSys.DonguriSys.Home.UserMode <> '') or
     (GikoSys.DonguriSys.Home.UserID   <> '') or
     (GikoSys.DonguriSys.Home.Level    <> '') or
     (GikoSys.DonguriSys.Home.UserName <> '') then
	  HintStr := Format('どんぐりシステム%s%s [%s]%sLv.%s [%s]', [
    			#10, GikoSys.DonguriSys.Home.UserMode,
          		 GikoSys.DonguriSys.Home.UserID,
          #10, GikoSys.DonguriSys.Home.Level,
          		 GikoSys.DonguriSys.Home.UserName])
  else
		HintStr := 'どんぐりシステムを表示する';
	CanShow := True;
end;

procedure TGikoDM.DonguriActionUpdate(Sender: TObject);
begin
//
end;

procedure TGikoDM.DonguriHomeUpdate;
begin
	try
    if (DonguriForm <> nil) and (DonguriForm.Visible) then
      DonguriForm.UpdateHomeInfo;
  except
  end;
end;

procedure TGikoDM.DonguriLoginActionExecute(Sender: TObject);
var
	res: String;
  msg: String;
begin
	try
    if GikoSys.DonguriSys.Processing then
      Exit;

    if GikoSys.DonguriSys.Login(res) then begin
      GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmDngLogin), nil, gmiOK);
      DonguriHomeUpdate;
    end else begin
      msg := 'どんぐりシステムにログインできませんでした。';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('どんぐりシステムにログインできませんでした。' + e.Message, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  end;
end;

procedure TGikoDM.DonguriHntLoginActionUpdate(Sender: TObject);
begin
	DonguriHntLoginAction.Enabled := (GikoSys.Setting.UserID <> '') and (GikoSys.Setting.Password <> '');
end;

procedure TGikoDM.DonguriHntLoginActionExecute(Sender: TObject);
var
	res: String;
  msg: String;
begin
	try
  	if (GikoSys.Setting.UserID = '') or (GikoSys.Setting.Password = '') then begin
      GikoForm.AddMessageList('どんぐりシステムログインエラー：UPLIFTの設定が正しくありません。', nil, gmiNG);
      GikoForm.PlaySound('Error');
      Exit;
    end;

    if GikoSys.DonguriSys.Processing then
      Exit;

    if GikoSys.DonguriSys.MailLogin(GikoSys.Setting.UserID, GikoSys.Setting.Password, res) then begin
      GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmDngMailLogin) + GikoSys.Setting.UserID, nil, gmiOK);
      DonguriHomeUpdate;
    end else begin
      msg := 'どんぐりシステムにログインできませんでした。';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('どんぐりシステムにログインできませんでした。' + e.Message, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  end;
end;

procedure TGikoDM.DonguriGrdLoginActionUpdate(Sender: TObject);
begin
	DonguriGrdLoginAction.Enabled := (GikoSys.Setting.DonguriMail <> '') and (GikoSys.Setting.DonguriPwd <> '');
end;

procedure TGikoDM.DonguriGrdLoginActionExecute(Sender: TObject);
var
	res: String;
  msg: String;
begin
	try
  	if (GikoSys.Setting.DonguriMail = '') or (GikoSys.Setting.DonguriPwd = '') then begin
      GikoForm.AddMessageList('どんぐりシステムログインエラー：警備員アカウントの設定が正しくありません。', nil, gmiNG);
      GikoForm.PlaySound('Error');
      Exit;
    end;

    if GikoSys.DonguriSys.Processing then
      Exit;

    if GikoSys.DonguriSys.MailLogin(GikoSys.Setting.DonguriMail, GikoSys.Setting.DonguriPwd, res) then begin
      GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmDngMailLogin) + GikoSys.Setting.DonguriMail, nil, gmiOK);
      DonguriHomeUpdate;
    end else begin
      msg := 'どんぐりシステムにログインできませんでした。';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('どんぐりシステムにログインできませんでした。' + e.Message, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  end;
end;

procedure TGikoDM.DonguriLogoutActionExecute(Sender: TObject);
var
  res: String;
  msg: String;
begin
	try
    if GikoSys.DonguriSys.Processing then
      Exit;

    if GikoSys.DonguriSys.Logout(res) then begin
      GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmDngLogout), nil, gmiOK);
      DonguriHomeUpdate;
    end else begin
      msg := 'どんぐりシステムからログアウトできませんでした。';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('どんぐりシステムからログアウトできませんでした。' + e.Message, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  end;
end;

procedure TGikoDM.DonguriAuthActionExecute(Sender: TObject);
var
  res: String;
  msg: String;
begin
  try
    if GikoSys.DonguriSys.Processing then
      Exit;

    if GikoSys.DonguriSys.Auth(res) then begin
      GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmDngAuth), nil, gmiOK);
      DonguriHomeUpdate;
    end else begin
      msg := 'どんぐりシステムの再認証が失敗しました。';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('どんぐりシステムの再認証が失敗しました。' + e.Message, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  end;
end;

// どんぐり大砲有効無効更新
procedure TGikoDM.DonguriCannonActionUpdate(Sender: TObject);
var
	ThreadItem : TThreadItem;
begin
	try
		ThreadItem := GikoForm.GetActiveContent(True);
		TAction(Sender).Enabled := (ThreadItem <> nil) and
																ThreadItem.ParentBoard.Is2ch and		// ５ちゃんのみ
                                (Pos('.bbspink.com/', ThreadItem.URL) < 1) and	// BBSPINKは現在非対応
																(GikoSys.Setting.UserID <> '') and	// ハンターのみ
																(GikoSys.Setting.Password <> '');		// （とりあえずUPLIFTのログイン設定がある場合のみ）
  except
  end;
end;

// どんぐり大砲
procedure TGikoDM.DonguriCannonActionExecute(Sender: TObject);
var
	No : Integer;
	ThreadItem : TThreadItem;
	URL, Protocol, Host, Path, Document, Port, Bookmark : String;
  tmp: String;
  date: String;
  idx1: Integer;
  idx2: Integer;
	Res: TResRec;
begin
	try
    No := GikoForm.KokoPopupMenu.Tag;
    if No = 0 then
    	Exit;
    ThreadItem := GikoForm.KokoPopupThreadItem;
    if (not ThreadItem.ParentBoard.Is2ch) or (Pos('.bbspink.com/', ThreadItem.URL) > 0) then
    	Exit;

    GikoSys.ParseURI(ThreadItem.URL, Protocol, Host, Path, Document, Port, Bookmark);
    URL := Protocol + '://' + Host + Path + IntToStr(No);

		tmp := GikoSys.ReadThreadFile(ThreadItem.FilePath, No);
		if tmp = '' then
    	Exit;

    THTMLCreate.DivideStrLine(tmp, @Res);
    date := Res.FDateTime;
    idx1 := Pos(' ', date);
    if idx1 > 1 then begin
      idx2 := PosEx(' ', date, idx1 + 1);
      if idx2 > 0 then
        SetLength(date, idx2 - 1);
    end;

    GikoSys.DonguriSys.Cannon(url, date, No);

  except
  end;
end;

// Cookie管理画面表示
procedure TGikoDM.CookieMngActionExecute(Sender: TObject);
var
  dlg: TCookieForm;
begin
	dlg := TCookieForm.Create(GikoForm);
	try
		dlg.ShowModal;
	finally
		dlg.Release;
	end;
end;

end.

