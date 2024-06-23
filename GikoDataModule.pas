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
	CAPTION_NAME: string = '�M�R�i�r';
	USER_SETLINKBAR					= WM_USER + 2003;

	ITEM_ICON_SORT1					= 12;		//!< �\�[�g�A�C�R��
	ITEM_ICON_SORT2					= 13;		//!< �\�[�g�A�C�R��

	//�c�[���o�[�A�C�R��
	TOOL_ICON_HEIGHT_MAX 		= 16;		//!< �����ő�A�C�R��
	TOOL_ICON_HEIGHT_MIN 		= 17;		//!< �����ŏ��A�C�R��
	TOOL_ICON_HEIGHT_NORMAL = 18;		//!< �����W���A�C�R��
	TOOL_ICON_WIDTH_MAX 		= 19;		//!< ���ő�A�C�R��
	TOOL_ICON_WIDTH_MIN 		= 20;		//!< ���ŏ��A�C�R��
	TOOL_ICON_WIDTH_NORMAL 	= 21;		//!< ���W���A�C�R��

	TOOL_ICON_FAV_FOLDER		= 30;		//!< ���C�ɓ���t�H���_�A�C�R��
	TOOL_ICON_FAV_BOARD			= 31;		//!< ���C�ɓ���A�C�R��
	TOOL_ICON_FAV_THREAD		= 32;		//!< ���C�ɓ���X���A�C�R��

	//! HTTP
	PROTOCOL_HTTP : string = 'https://';
	//! �M�R�i�r�T�C�g��URL
	//URL_GIKONAVI: string = 'gikonavi.sourceforge.jp/';
	URL_GIKONAVI: string = 'gikonavi.osdn.jp/';
	//! �M�R�i�r(����)�T�C�g��URL
	//URL_GIKONAVIGO: string = 'gikonavigoeson.sourceforge.jp/';
	URL_GIKONAVIGO: string = 'gikonavigoeson.osdn.jp/';
	//! Monazilla�T�C�g��URL
	URL_MONAZILLA: string = 'www.monazilla.org/';   // ���̃T�C�g�͏���
	//! 2�����˂��URL
	URL_2ch: string = 'www.5ch.net/';
	//! �M�R�i�rWiki��URL
	//URL_Wiki: string = 'sourceforge.jp/projects/gikonavi/wiki/FAQ';
	URL_Wiki: string = 'ja.osdn.net/projects/gikonavi/wiki/FAQ';
	//! �M�R�i�r(����)Wiki��URL
	//URL_GoWiki: string = 'sourceforge.jp/projects/gikonavigoeson/wiki/FAQ';
	URL_GoWiki: string = 'ja.osdn.net/projects/gikonavigoeson/wiki/FAQ';

	SELECTCOMBOBOX_NAME: WideString = ''; // '�X���b�h�i������';
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
	{ Private �錾 }
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
    { Public �錾 }
    procedure RepaintStatusBar;
    function EditorFormExists(): boolean;
    procedure GetTabURLs(AStringList: TStringList);
    procedure OpenURLs(AStringList: TStringList);
    procedure MoveURLWithHistory(URL : String; KeyMask: Boolean = False);
    procedure SaveThreadSearchSetting;
    procedure DonguriHomeUpdate;
  published
	{ Published �錾 }
	//! TAction��GetActiveContent��nil�ȊO�ŗL���ɂȂ�
	procedure DependActiveCntentActionUpdate(Sender: TObject);
	//! TAction��GetActiveContent��nil�ȊO�����O�������Ă���ƗL���ɂȂ�
	procedure DependActiveCntentLogActionUpdate(Sender: TObject);
	//! TAction��ActiveList��TBoard(������)�ŗL���ɂȂ�
	procedure DependActiveListTBoardActionUpdate(Sender: TObject);
	//! TAction��ActiveList��TBoard�ŗL���ɂȂ�
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
	MSG_ERROR : string = '�G���[';

{$R *.dfm}
// *************************************************************************
//! TAction��GetActiveContent��nil�ȊO�ŗL���ɂȂ�
// *************************************************************************
procedure TGikoDM.DependActiveCntentActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveContent <> nil);
end;
// *************************************************************************
//! TAction��GetActiveContent��nil�ȊO�����O�������Ă���
// *************************************************************************
procedure TGikoDM.DependActiveCntentLogActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveContent <> nil)
									and (GikoForm.GetActiveContent.IsLogFile);
end;
// *************************************************************************
//! TAction��ActiveList��TBoard(������)�ŗL���ɂȂ�
// *************************************************************************
procedure TGikoDM.DependActiveListTBoardActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveList is TBoard) and
        (GikoForm.GetActiveList <> BoardGroup.SpecialBoard);
end;
// *************************************************************************
//! TAction��ActiveList��TBoard�ŗL���ɂȂ�
// *************************************************************************
procedure TGikoDM.DependActiveListTBoardWithSpeciapActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveList is TBoard);
end;
// *************************************************************************
//! NG���[�h�ҏW
// *************************************************************************
procedure TGikoDM.EditNGActionExecute(Sender: TObject);
begin
	//�e�L�X�g�Ɋ֘A�t����ꂽ�A�v����NG���[�h�t�@�C�����I�[�v��
	if (GikoSys.FAbon.EditNGwords(GikoForm) = True) then
        ReloadAction.Execute;
end;
// *************************************************************************
//! NG���[�h�ǂݍ��݁i�ēǂݍ��݁j
// *************************************************************************
procedure TGikoDM.ReloadActionExecute(Sender: TObject);
begin
	//�����[�h�����s�@���s�����烁�b�Z�[�W�o��
	if GikoSys.FAbon.ReLoadFromNGwordFile =false then begin
		MsgBox(GikoForm.Handle, 'NG���[�h�t�@�C���̍ēǂݍ��݂Ɏ��s���܂���',
			MSG_ERROR, MB_OK or MB_ICONEXCLAMATION);
	end else begin
		//�S�Ẵ^�u�ɍĕ`���ݒ�
		GikoForm.RepaintAllTabsBrowser();
	end;
end;
// *************************************************************************
//! NG���[�h�ǂݍ��݁i����j
// *************************************************************************
procedure TGikoDM.GoFowardActionExecute(Sender: TObject);
begin
	//����̓ǂݍ��݁@���s�����烁�b�Z�[�W�o��
	if GikoSys.FAbon.GoBack =false then begin
		MsgBox(GikoForm.Handle, '�����NG���[�h�t�@�C���̓ǂݍ��݂Ɏ��s���܂���',
			MSG_ERROR, MB_OK or MB_ICONEXCLAMATION);
	end else begin
		//�X�e�[�^�X�ɕ\�������NG���[�h�t�@�C�������X�V
		RepaintStatusBar;
		//�S�Ẵ^�u�ɍĕ`���ݒ�
		GikoForm.RepaintAllTabsBrowser();
	end;
end;
// *************************************************************************
//! NG���[�h�ǂݍ��݁i��O�j
// *************************************************************************
procedure TGikoDM.GoBackActionExecute(Sender: TObject);
begin
	//����̓ǂݍ��݁@���s�����烁�b�Z�[�W�o��
	if GikoSys.FAbon.GoForward =false then begin
		MsgBox(GikoForm.Handle, '��O��NG���[�h�t�@�C���̓ǂݍ��݂Ɏ��s���܂���',
			MSG_ERROR, MB_OK or MB_ICONEXCLAMATION);
	end else begin
		//�X�e�[�^�X�ɕ\�������NG���[�h�t�@�C�������X�V
		RepaintStatusBar;
		//�S�Ẵ^�u�ɍĕ`���ݒ�
		GikoForm.RepaintAllTabsBrowser();
	end;
end;
// *************************************************************************
//! NG���[�h��ύX������̃X�e�[�^�X�o�[�̍X�V����
// *************************************************************************
procedure TGikoDM.RepaintStatusBar;
var
	s : String;
begin
	//�X�e�[�^�X�ɕ\�������NG���[�h�t�@�C�������X�V
	s := GikoSys.FAbon.NGwordname;
	GikoForm.StatusBar.Panels.Items[GiKo.NGWORDNAME_PANEL].Text := s;
	//�X�e�[�^�X�̕\���T�C�Y�̃��T�C�Y
	GikoForm.StatusBar.Panels[GiKo.NGWORDNAME_PANEL].Width
		:= Max(GikoForm.StatusBar.Canvas.TextWidth(s), 100);
	GikoForm.StatusBarResize(nil);
end;
// *************************************************************************
//! �A�h���X�o�[�ɕ\�����Ă���A�h���X�ֈړ�����
// *************************************************************************
procedure TGikoDM.MoveToActionExecute(Sender: TObject);
begin
	//�A�h���X�R���{�{�b�N�X����URL���擾
	//URL�Ɉړ�
    MoveURLWithHistory( Trim(GikoForm.AddressComboBox.Text) );
end;
// *************************************************************************
//! ���C�ɓ���̒ǉ��_�C�A���O���J��
// *************************************************************************
procedure TGikoDM.FavoriteAddActionExecute(Sender: TObject);
begin
	GikoForm.ShowFavoriteAddDialog(GikoForm.GetActiveContent);
end;
// *************************************************************************
//! ���C�ɓ���̐����_�C�A���O���J��
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
	//�����N�o�[�ɍX�V��`����
	PostMessage( GikoForm.Handle, USER_SETLINKBAR, 0, 0 );
end;
// *************************************************************************
//! �c���[��S�ĕ���
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewCollapseActionExecute(Sender: TObject);
var
	node	: TTreeNode;
begin
	node := GikoForm.FavoriteTreeViewUC.Items.GetFirstNode;
	try
		//�m�[�h����������@�m�[�h���k��������
		while node <> nil do begin
			if node.HasChildren then
				node.Expanded := False;
			node := node.GetNext;
		end;
	except
	end;
end;
// *************************************************************************
//! ���C�ɓ���̖��O��ҏW����
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
		GikoForm.ClickNode.Text := InputBox( '���O�̕ύX', '���C�ɓ���̐V�������O����͂��Ă�������', GikoForm.ClickNode.Text );
	end;
	//�X�V�������Ƃ�������
	FavoriteDM.Modified := true;
	GikoForm.SetLinkBar;
end;
// *************************************************************************
//! �V�������C�ɓ���Ƀt�H���_���쐬����
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
		Node := GikoForm.FavoriteTreeViewUC.Items.AddChildObject(GikoForm.ClickNode, '�V�����t�H���_', NewFavFolder);
		Node.ImageIndex := 14;
		Node.SelectedIndex := 14;
	//			FClickNode.Selected.Expanded := True;
		GikoForm.FavoriteTreeViewUC.Selected := Node;
		GikoForm.ClickNode := Node;
		//�X�V�������Ƃ�������
		FavoriteDM.Modified := true;
		FavoriteTreeViewRenameAction.Execute;
	finally
	end;

end;
// *************************************************************************
//! ���̂��C�ɓ�����폜����
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewDeleteActionExecute(Sender: TObject);
const
	DEL_LINK_MSG = '�g�����N�h�̓����N�o�[�p�t�H���_�ł��B�폜���Ă�낵���ł����H';
	DEL_MSG = '�g^0�h���폜���܂��B��낵���ł����H';
	DEL_TITLE = '�폜�m�F';
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
	//�X�V�������Ƃ�������
	FavoriteDM.Modified := true;

	GikoForm.SetLinkBar;

end;
// *************************************************************************
//! ���̃t�H���_�ɓ����Ă��邨�C�ɓ����S�ĊJ��
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewBrowseFolderActionExecute(
  Sender: TObject);
begin
	GikoForm.FavoriteBrowseFolder( GikoForm.ClickNode );
end;
// *************************************************************************
//! �I������Ă��邨�C�ɓ�����_�E�����[�h����
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
//! �I������Ă��邨�C�ɓ����URL���R�s�[����
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewURLCopyActionExecute(Sender: TObject);
begin

	if GikoForm.ClickNode = nil then Exit;

	if (TObject(GikoForm.ClickNode.Data) is TFavoriteItem) then begin
		Clipboard.AsText := TFavoriteItem( GikoForm.ClickNode.Data ).URL + #13#10;
	end;
end;
// *************************************************************************
//! �I������Ă��邨�C�ɓ���̖��O���R�s�[����
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
//! �I������Ă��邨�C�ɓ���̖��O��URL���R�s�[����
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
//! �I������Ă��邨�C�ɓ���X���b�h���폜����
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewLogDeleteActionExecute(Sender: TObject);
const
	DEL_MSG = '�g^0�h�̃��O���폜���܂��B��낵���ł����H';
	DEL_TITLE = '�폜�m�F';
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
//! ���ݕ\�����Ă���X���b�h���u���E�U�ŕ\������
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
//! ���X�̍i���݃t�B���^�[����ɂ���
procedure TGikoDM.ClearResFilter;
var
	FilterList : TStringList;
begin
	// �t�B���^���������ɂ���
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
//! ���X�̕\���͈͂�ݒ肷��
// *************************************************************************
procedure TGikoDM.SetResRange(range: Integer);
begin
	if GikoSys.ResRange <> range then begin
		GikoSys.ResRange	:= range;
		// �t�B���^���������ɂ���
		ClearResFilter;
		GikoForm.RepaintAllTabsBrowser();
	end;
end;
// *************************************************************************
//! �ŐV100���X�̂ݕ\��
// *************************************************************************
procedure TGikoDM.OnlyAHundredResActionExecute(Sender: TObject);
begin
	if (GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil)
		and (GikoForm.ActiveContent.Browser.Busy) then Exit;

	GikoForm.ResRangeMenuSelect 	:= 100;
	OnlyAHundredResAction.Checked	:= True;
	//�@�\���͈͂�ݒ肷��B�ݒ�l����Ƃ��Ă���B
    SetResRange(GikoSys.Setting.ResRangeExCount);
end;
// *************************************************************************
//! ���ǃ��X�̂ݕ\��
// *************************************************************************
procedure TGikoDM.OnlyKokoResActionExecute(Sender: TObject);
begin
	if (GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil)
		and (GikoForm.ActiveContent.Browser.Busy) then Exit;

	GikoForm.ResRangeMenuSelect	:= Ord( grrKoko );
	OnlyKokoResAction.Checked	:= True;

	//�@�\���͈͂�ݒ肷��
	SetResRange(Ord( grrKoko ));
end;
// *************************************************************************
//! �V�����X�̂ݕ\��
// *************************************************************************
procedure TGikoDM.OnlyNewResActionExecute(Sender: TObject);
begin
	if (GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil)
		and (GikoForm.ActiveContent.Browser.Busy) then Exit;

	GikoForm.ResRangeMenuSelect	:= Ord( grrNew );
	OnlyNewResAction.Checked	:= True;

	//�@�\���͈͂�ݒ肷��
	SetResRange(Ord( grrNew ));
end;
// *************************************************************************
//! �X���b�h�\���G���A�ʏ�\���ɂ��� ��)ListOrientation = gloHorizontal�@
// *************************************************************************
procedure TGikoDM.SetThreadAreaHorNormal;
begin
	//�ʏ�\���ɂ���
	GikoForm.ViewPanel.Width := GikoForm.BrowserSizeWidth;
	BrowserMaxAction.ImageIndex := TOOL_ICON_WIDTH_MAX;
	BrowserMinAction.ImageIndex := TOOL_ICON_WIDTH_MIN;
	GikoSys.Setting.ListWidthState := glsNormal;
end;
// *************************************************************************
//! �X���b�h�\���G���A�ő�/�ŏ��\���ɂ��� ��)ListOrientation = gloHorizontal�@
// *************************************************************************
procedure TGikoDM.SetThreadAreaHorizontal(gls : TGikoListState);
begin
	if GikoSys.Setting.ListWidthState = glsNormal then
		GikoForm.BrowserSizeWidth := GikoForm.ViewPanel.Width;
	//�ő�\��
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
//! �X���b�h�\���G���A�ʏ�\���ɂ��� ��)ListOrientation = gloVertical
// *************************************************************************
procedure TGikoDM.SetThreadAreaVerNormal;
begin
	//�ʏ�\���ɂ���
	GikoForm.ViewPanel.Height := GikoForm.BrowserSizeHeight;
	BrowserMaxAction.ImageIndex := TOOL_ICON_HEIGHT_MAX;
	BrowserMinAction.ImageIndex := TOOL_ICON_HEIGHT_MIN;
	GikoSys.Setting.ListHeightState := glsNormal;
end;
// *************************************************************************
//! �X���b�h�\���G���A�ő�/�ŏ��\���ɂ��� ��)ListOrientation = gloVertical
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
//! �X���b�h�\���G���A��傫���\������
// *************************************************************************
procedure TGikoDM.BrowserMaxActionExecute(Sender: TObject);
begin
	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		case GikoSys.Setting.ListWidthState of
			glsMax: begin
				//�ʏ�\���ɂ���
				SetThreadAreaHorNormal;
			end;
			glsMin, glsNormal: begin
				//�ő�\���ɂ���
				SetThreadAreaHorizontal(glsMax);
			end;
		end;
	end else begin
		case GikoSys.Setting.ListHeightState of
			glsMax: begin
				//�ʏ�\���ɂ���
				SetThreadAreaVerNormal;
			end;
			glsMin, glsNormal: begin
				//�ő�\���ɂ���
				SetThreadAreaVertical(glsMax);
			end;
		end;
	end;
end;
// *************************************************************************
//! �X���b�h�\���G���A���������\������
// *************************************************************************
procedure TGikoDM.BrowserMinActionExecute(Sender: TObject);
begin
	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		case GikoSys.Setting.ListWidthState of
			glsMax, glsNormal: begin
				//�ŏ��\���ɂ���
				SetThreadAreaHorizontal(glsMin);
			end;
			glsMin: begin
				//�ʏ�\���ɂ���
				SetThreadAreaHorNormal;
			end;
		end;
	end else begin
		case GikoSys.Setting.ListHeightState of
			glsMax, glsNormal: begin
				//�ŏ��\���ɂ���
				SetThreadAreaVertical(glsMin);
			end;
			glsMin: begin
				//�ʏ�\���ɂ���
				SetThreadAreaVerNormal;
			end;
		end;
	end;
end;
// *************************************************************************
//! ���ݕ\�����Ă���X���b�h�̐擪�ֈړ�����
// *************************************************************************
procedure TGikoDM.ScrollTopActionExecute(Sender: TObject);
begin
	GikoForm.BrowserMovement('top');
end;
// *************************************************************************
//! ���ݕ\�����Ă���X���b�h�̍Ō�ֈړ�����
// *************************************************************************
procedure TGikoDM.ScrollLastActionExecute(Sender: TObject);
begin
	GikoForm.BrowserMovement('bottom');
end;
// *************************************************************************
//! ���ݕ\�����Ă���X���b�h�̐V���ֈړ�����
// *************************************************************************
procedure TGikoDM.ScrollNewActionExecute(Sender: TObject);
begin
	GikoForm.BrowserMovement('new');
end;
// *************************************************************************
//! ���ݕ\�����Ă���X���b�h�̃R�R�܂œǂ񂾂ֈړ�����
// *************************************************************************
procedure TGikoDM.ScrollKokoActionExecute(Sender: TObject);
begin
	GikoForm.BrowserMovement('koko');
end;
// *************************************************************************
//! ���ݕ\�����Ă���X���b�h�̃R�R�܂œǂ񂾂ֈړ������Update�C�x���g
// *************************************************************************
procedure TGikoDM.ScrollKokoActionUpdate(Sender: TObject);
begin
	ScrollKokoAction.Enabled := (GikoForm.GetActiveContent <> nil)
								and (GikoForm.GetActiveContent.IsLogFile)
								and (GikoForm.GetActiveContent.Kokomade <> -1);
end;
// *************************************************************************
//! ���X�������݃E�B���h�E��\������
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
//! �X�����u���E�U�ŕ\������
// *************************************************************************
procedure TGikoDM.IEActionExecute(Sender: TObject);
begin
	ShowThreadAction.Execute;
end;
// *************************************************************************
//! ���ݕ\�����Ă���X���b�h���u���E�U�ŕ\������
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
//! ���ݕ\�����Ă���X���b�h�̔��u���E�U�ŕ\������
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
//! ���ݕ\�����Ă���X���b�h��URL���R�s�[����
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
//! ���ݕ\�����Ă���X���b�h�����R�s�[����
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
//! ���ݕ\�����Ă���X���b�h����URL���R�s�[����
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
//! �\������Ă���X���b�h���_�E�����[�h����
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
//! ���݊J���Ă���^�u�����
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
//! �^�u���P�ȏ゠�ꂪ�L���ɂ���Update�C�x���g
// *************************************************************************
procedure TGikoDM.BrowserTabCloseActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 0);
end;
// *************************************************************************
//! ���݊J���Ă���^�u�ȊO�����
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
//! �^�u���Q�ȏ゠�ꂪ�L���ɂ���Update�C�x���g
// *************************************************************************
procedure TGikoDM.NotSelectTabCloseActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 1);
end;
// *************************************************************************
//! �S�Ẵ^�u�����
// *************************************************************************
procedure TGikoDM.AllTabCloseActionExecute(Sender: TObject);
var
	i: Integer;
begin
	if GikoSys.Setting.ShowDialogForAllTabClose then
		if(MessageDlg('�S�Ẵ^�u����Ă�낵���ł����H', mtConfirmation,[mbOk, mbCancel], 0) = mrCancel ) then
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
//! ���݊J���Ă���^�u�̃X���b�h���폜����
// *************************************************************************
procedure TGikoDM.ActiveLogDeleteActionExecute(Sender: TObject);
const
	DEL_MSG = '�g^0�h�̃��O���폜���܂��B��낵���ł����H';
	DEL_TITLE = '�폜�m�F';
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
//! ��ԍ��̃^�u��I������
// *************************************************************************
procedure TGikoDM.LeftmostTabSelectActionExecute(Sender: TObject);
begin
	if GikoForm.BrowserTabUC.Tabs.Count > 0 then begin
		GikoForm.BrowserTabUC.TabIndex := 0;
		GikoForm.BrowserTabUC.OnChange(nil);
	end;
end;
// *************************************************************************
//! ���̃^�u��I�������Update�C�x���g
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
//! �^�u�̐����P�ȏ�ŁA�^�u�̃C���f�b�N�X���O�ȊO�ŗL���ɂȂ�Update�C�x���g
// *************************************************************************
procedure TGikoDM.LeftmostTabSelectActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 0)
								and (GikoForm.BrowserTabUC.TabIndex <> 0);
end;
// *************************************************************************
//! ���̃^�u��I������
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
//! �E�̃^�u��I������
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
//! �E�̃^�u��I������Update�C�x���g
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
//! ��ԉE�̃^�u��I������
// *************************************************************************
procedure TGikoDM.RightmostTabSelectActionExecute(Sender: TObject);
begin
	if GikoForm.BrowserTabUC.Tabs.Count > 0 then begin
		GikoForm.BrowserTabUC.TabIndex := GikoForm.BrowserTabUC.Tabs.Count - 1;
		GikoForm.BrowserTabUC.OnChange(nil);
	end;
end;
// *************************************************************************
//! ��ԉE�̃^�u��I�������Update�C�x���g
// *************************************************************************
procedure TGikoDM.RightmostTabSelectActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 0)
								and (GikoForm.BrowserTabUC.TabIndex <> GikoForm.BrowserTabUC.Tabs.Count - 1);

end;
// *************************************************************************
//! �I������Ă���X���b�h�����C�ɓ���ɒǉ�
// *************************************************************************
procedure TGikoDM.ThreadFavoriteAddActionExecute(Sender: TObject);
begin
	if TObject(GikoForm.ListViewUC.Selected.Data) is TThreadItem then
		GikoForm.ShowFavoriteAddDialog(TObject(GikoForm.ListViewUC.Selected.Data));
end;
// *************************************************************************
//! �X���b�h�ꗗ�ŁA�X�����P�ȏ�I������Ă���L���ɂȂ�Update�C�x���g
// *************************************************************************
procedure TGikoDM.ThreadFavoriteAddActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveList is TBoard)
									and (GikoForm.ListViewUC.SelCount > 0);
end;
// *************************************************************************
//! ���X�̓��e���i�荞��
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
				// ����͂� OK �͍i�荞�݉����Ɠ��Ӌ`
				ResRangeAction.Execute;
			end else begin
				GikoSys.ResRange := Ord( grrSelect );

				// �Ō�ɐݒ肵�����̂��o���Ă���
				GikoForm.SelectResWord := Dlg.SelectComboBoxUC.Text;

				// ���������̍X�V
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

				// �t�B���^�̐ݒ�
				FilterList := TStringList.Create;
				try
					GikoSys.FSelectResFilter.Reverse := True;
					FilterList.Delimiter := ' '; //��؂�q�𔼊p�X�y�[�X�ɐݒ�
					FilterList.DelimitedText := Dlg.SelectComboBoxUC.EncodeText;

					GikoSys.FSelectResFilter.LoadFromStringList( FilterList );
				finally
					FilterList.Free;
				end;
				GikoForm.RepaintAllTabsBrowser();
			end;
		end else begin
			// �L�����Z��
			if GikoSys.ResRange <> Ord( grrSelect ) then
				ResRangeAction.Execute;
		end;
	finally
		Dlg.Release;
	end;

end;
// *************************************************************************
//! �S�Ẵ��X��\������
// *************************************************************************
procedure TGikoDM.AllResActionExecute(Sender: TObject);
begin
	if(GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil )
		and (GikoForm.ActiveContent.Browser.Busy) then Exit;

	GikoForm.ResRangeMenuSelect	:= Ord( grrAll );
	AllResAction.Checked		:= True;

	//�@�\���͈͂�ݒ肷��
	SetResRange(Ord( grrAll ));
end;
// *************************************************************************
//! ���X�̕\���͈͂�ݒ�
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
//! ���̃X���b�h���܂ރX���b�h�ꗗ��\��
// *************************************************************************
procedure TGikoDM.UpBoardActionExecute(Sender: TObject);
begin
	GikoForm.SelectTreeNode( GikoForm.GetActiveContent.ParentBoard, True );
end;
// *************************************************************************
//! �w�肵���ԍ��̃��X�ɔ��
// *************************************************************************
procedure TGikoDM.JumpToNumOfResActionExecute(Sender: TObject);
var
	str: string;
	res: integer;
begin
	str := '1';
	if( InputQuery('�w�肵���ԍ��̃��X�ɔ��', '�ԍ�����͂��Ă�������', str) ) then begin
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
//! �A�N�e�B�u�ȃ^�u���E�����
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
//! �^�u�̐����Q�ȏ�ŗL����Update�C�x���g
// *************************************************************************
procedure TGikoDM.RightTabCloseActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.BrowserTabUC.Tabs.Count > 1);
end;
// *************************************************************************
//! �A�N�e�B�u�ȃ^�u��荶�����
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
////////////////////////////////�X���b�h�܂ł����܂�/////////////////////
procedure TGikoDM.DataModuleCreate(Sender: TObject);
begin
    // GikoDM�������������������K�v������t�@�C��������Ƃ�����I�I
    // ���������Ԃɒ��ӂ��邱�ƁI�I
    //����N�����̏������t�@�C���ݒ�
    TDefaultFileManager.CopyDefaultFiles(GikoSys.Setting.GetDefaultFilesFileName);
end;
// *************************************************************************
//! ���O�����_�C�A���O��\������
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
//! �I�v�V�����_�C�A���O��\������
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
//! ����_�C�A���O��\������
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
//! �L�[�ݒ�_�C�A���O���J��
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
//! �L�[�ݒ�_�C�A���O���J��
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
//! �c�[���o�[�ݒ�_�C�A���O���J��
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

			//�œK�����Đݒ肷�邽�߂ɓK���ȃv���p�e�B����������
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
			//ListToolBar�ɂ��邩������Ȃ��i����ComboBox��z�u
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
//! �~���[�g
// *************************************************************************
procedure TGikoDM.MuteActionExecute(Sender: TObject);
begin
	GikoSys.Setting.Mute := not GikoSys.Setting.Mute;
end;
////////////////////////////////�c�[���܂ł����܂�/////////////////////
// *************************************************************************
//! �X���b�h�ꗗ���_�E�����[�h����
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
//! �I�����ꂽ�X���b�h���_�E�����[�h����
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
//! �I�����ꂽ��URL���R�s�[����
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
//! �I�����ꂽ�̖��O��URL���R�s�[����
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
//! ���C�ɓ���ɒǉ�����
// *************************************************************************
procedure TGikoDM.TreeSelectFavoriteAddActionExecute(Sender: TObject);
begin
	GikoForm.ShowFavoriteAddDialog(TObject(GikoForm.ClickNode.Data));
end;
// *************************************************************************
//! ������
// *************************************************************************
procedure TGikoDM.TreeSelectSearchBoardNameExecute(Sender: TObject);
var
	s : String;
	msg : String;
	CurItem : TTreeNode;
	next : boolean;
begin
	if InputQuery('������','���̓���',s) then begin
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
					msg := '�擪�ɖ߂�܂����H';
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
					msg := '���ɍs���܂����H';
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
//! �I�����ꂽ�̖��O���R�s�[����
// *************************************************************************
procedure TGikoDM.TreeSelectNameCopyExecute(Sender: TObject);
var
	s: string;
begin
	GikoForm.TreeViewUC.Selected := GikoForm.ClickNode;
	s := GikoForm.ClickNode.Text;
	SetClipboardFromEncAnsi(s);
end;
////////////////////////////////�c���[�|�b�v�A�b�v�܂ł����܂�/////////////////////
// *************************************************************************
//! ���O�C���^���O�A�E�g������
// *************************************************************************
procedure TGikoDM.LoginActionExecute(Sender: TObject);
var
	TmpCursor: TCursor;
//	msg : String;
begin
  if Session5ch = nil then
		Exit;

	if Session5ch.Connected then begin
		//���O�A�E�g
		Session5ch.Disconnect;
		LoginAction.Checked := False;
		GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmLogout), nil, gmiOK);
		LoginAction.Caption := '���O�C��(&L)';
	end else begin
		TmpCursor := GikoForm.ScreenCursor;
		GikoForm.ScreenCursor := crHourGlass;
		try
			//�ʏ탍�O�C��
      if Session5ch.Connect then begin
        LoginAction.Checked := True;
        GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmLogin) + GikoSys.Setting.UserID, nil, gmiOK);
        LoginAction.Caption := '���O�A�E�g(&L)';
        //LoginToolButton.Style := tbsCheck;
      end else begin
		//			MsgBox(Handle, '���O�C���o���܂���ł���', '�G���[', MB_OK or MB_ICONSTOP);
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
//! �{�[�h�X�V�_�C�A���O��\������
// *************************************************************************
procedure TGikoDM.NewBoardActionExecute(Sender: TObject);
var
	Dlg: TNewBoardDialog;
	Msg: string;
begin
	if (EditorFormExists) then begin
		Msg := '���X�G�f�B�^��S�ĕ��Ă�������';
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
//! �I������Ă���X���b�h���폜����
// *************************************************************************
procedure TGikoDM.LogDeleteActionExecute(Sender: TObject);
const
	DEL_MSG = '�g^0�h�̃��O���폜���܂��B��낵���ł����H';
	DEL_SAME_MSG = '����� ^0 �̃X���b�h�̃��O���폜���܂��B��낵���ł����H';
	DEL_TITLE = '�폜�m�F';
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
        GikoForm.TreeViewUC.Refresh;	// UnRead �̕\�����X�V
		GikoForm.ListViewUC.Refresh;
	finally
		List.Free;
	end;
end;
// *************************************************************************
//! ActiveList��TBoard�ŃX���ꗗ�łP�ȏ�I�����Ă���ƗL���ɂȂ�Action�ŋ���
// *************************************************************************
procedure TGikoDM.LogDeleteActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled := (GikoForm.GetActiveList is TBoard)
								and (GikoForm.ListViewUC.SelCount > 0);
end;
// *************************************************************************
//! �i���ݗ�������������
// *************************************************************************
procedure TGikoDM.SelectTextClearActionExecute(Sender: TObject);
const
	DEL_MSG = '�i���ݑS�������폜���܂��B��낵���ł����H';
	DEL_TITLE = '�폜�m�F';
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
//! ���X�G�f�B�^�̖��O��������������
// *************************************************************************
procedure TGikoDM.NameTextClearActionExecute(Sender: TObject);
const
	DEL_MSG = '���X�G�f�B�^���O�S�������폜���܂��B��낵���ł����H';
	DEL_TITLE = '�폜�m�F';
begin
	if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then
		if MsgBox(GikoForm.Handle, DEL_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
			Exit;
	GikoSys.Setting.NameList.Clear;
	ClearNameTextAllEditor
end;
// *************************************************************************
//! ���X�G�f�B�^�̃��[����������������
// *************************************************************************
procedure TGikoDM.MailTextClearActionExecute(Sender: TObject);
const
	DEL_MSG = '���X�G�f�B�^���[���S�������폜���܂��B��낵���ł����H';
	DEL_TITLE = '�폜�m�F';
begin
	if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then
		if MsgBox(GikoForm.Handle, DEL_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
			Exit;
	GikoSys.Setting.MailList.Clear;
	ClearMailAllEditor;
end;
// *************************************************************************
//! �M�R�i�r���I������
// *************************************************************************
procedure TGikoDM.ExitActionExecute(Sender: TObject);
begin
	GikoForm.Close;
end;
// *************************************************************************
//! ���C�ɓ���̃G�N�X�|�[�g�@���s�O����
// *************************************************************************
procedure TGikoDM.ExportFavoriteFileBeforeExecute(Sender: TObject);
begin
	ExportFavoriteFile.Dialog.FileName := FavoriteDM.GetFavoriteFilePath;
end;
// *************************************************************************
//! ���C�ɓ���̃G�N�X�|�[�g�@���s����
// *************************************************************************
procedure TGikoDM.ExportFavoriteFileAccept(Sender: TObject);
begin
	if FavoriteDM.SaveFavoriteFile( ExportFavoriteFile.Dialog.FileName ) Then begin
		ShowMessage('�t�@�C�����o�͂��܂���');
	end else begin
		ShowMessage('�t�@�C���̏o�͂Ɏ��s���܂���');
	end;
end;
// *************************************************************************
//! �I���X���b�h���t�@�C���ɕۑ�����
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
			ShowMessage('�X���b�h�ꗗ��\�����Ă�������')
		else if(List.Count = 0) then
			ShowMessage('�X���b�h��I�����Ă�������')
		else begin
			if dat then begin
				SaveDialog.Title := '�I���X���b�h��dat�̂܂ܕۑ�';
				SaveDialog.Filter := 'DAT�t�@�C��(*.dat)|*.dat';
			end else begin
				SaveDialog.Title := '�I���X���b�h��HTML�����ĕۑ�';
				SaveDialog.Filter := 'HTML�t�@�C��(*.html)|*.html';
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
//! �I���X���b�h��HTML�����ĕۑ�
// *************************************************************************
procedure TGikoDM.SelectItemSaveForHTMLExecute(Sender: TObject);
begin
	SelectThreadSaveToFile(false);
end;
// *************************************************************************
//! �I���X���b�h��DAT�`���̂܂ܕۑ�
// *************************************************************************
procedure TGikoDM.SelectItemSaveForDatExecute(Sender: TObject);
begin
	SelectThreadSaveToFile(true);
end;
// *************************************************************************
//! �^�u�̏��Ԃ�ۑ�
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
//! �u���E�U�^�u�ɐݒ肳��Ă���X���b�h��URL�擾
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
//! �w�肳�ꂽURL���J���C�擪�̃^�u�Ƀt�H�[�J�X����
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
                //�ŏ��̂P���ɐݒ�
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
//! �^�u�̏��Ԃ𕜌�
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
                    // ��̃t�@�C���̏ꍇ�C�o�b�N�A�b�v���폜���Ȃ����߂ɍ폜
                    SysUtils.DeleteFile(fileName);
                end else begin
                    OpenURLs(URLs);
                end;
    		except
	    		on EFOpenError do ShowMessage('�^�u�t�@�C�����J���܂���');
            end;
        end;
	finally
        URLs.Free;
	end;

    if (GikoForm.BrowserTabUC.Tabs.Count = 0) and
        (TabsOpenAction.Tag <> 1) then  begin
        ShowMessage('�\������^�u������܂���B');
    end;
end;
// *************************************************************************
//! Be2ch�Ƀ��O�C��/���O�A�E�g����
// *************************************************************************
procedure TGikoDM.BeLogInOutActionExecute(Sender: TObject);
var
	TmpCursor: TCursor;
//	msg : String;
begin
	if GikoSys.Belib.Connected then begin
		//���O�A�E�g
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
////////////////////////////////�t�@�C���܂ł����܂�/////////////////////
// *************************************************************************
//! �R�R�܂œǂ�
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
	//INFO 2005/11/19 ��U�B���A�K�v�Ȃ�GikoForm�̕��Ƀ��\�b�h��ǉ�����
	//Application.ProcessMessages;
end;
// *************************************************************************
//! �S���ǂ�
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
	//INFO 2005/11/19 ��U�B���A�K�v�Ȃ�GikoForm�̕��Ƀ��\�b�h��ǉ�����
	//Application.ProcessMessages;
end;
// *************************************************************************
//! �R�R�Ƀ��X
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
//! �I���������X���R�s�[����
// *************************************************************************
procedure TGikoDM.KoreCopyExecute(Sender: TObject);
begin
	GikoForm.KonoresCopy(GikoForm.KokoPopupMenu.Tag, true);
end;
// *************************************************************************
//! �I���������X���R�s�[����
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
//! ���̃��X���ځ`��@�i�ʏ�j
// *************************************************************************
procedure TGikoDM.IndividualAbon1ActionExecute(Sender: TObject);
begin
	GikoForm.IndividualAbon(GikoForm.KokoPopupMenu.Tag, 1);
end;
// *************************************************************************
//! ���̃��X���ځ`��@�i�����j
// *************************************************************************
procedure TGikoDM.IndividualAbon0ActionExecute(Sender: TObject);
begin
	GikoForm.IndividualAbon(GikoForm.KokoPopupMenu.Tag, 0);
end;
// *************************************************************************
//! ���̃��X���ځ`�����
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
					// �X�p��������
					ReadList.LoadFromFile( ThreadItem.GetThreadFileName );
					GikoSys.SpamCountWord( ReadList[ KokoPopupMenu.Tag - 1 ], wordCount );
					GikoSys.SpamForget( wordCount, True );	// �X�p��������
					GikoSys.SpamLearn( wordCount, False );	// �n���ɐݒ�
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
				msg := '���̃X���b�h�ł͌ʂ��ځ`����s���Ă܂���';
				MsgBox(GikoForm.Handle, msg, '���b�Z�[�W', MB_OK);
			end;
		end;
	finally
		IndividualForm.Release;
	end;
end;
// *************************************************************************
//! ���̃��X���ځ`��������X�ԍ��w��i�_�C�A���O�\���j
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
						// �X�p��������
						ReadList.LoadFromFile( ThreadItem.GetThreadFileName );
						for i := 0 to IndividualForm.DeleteList.Count - 1 do begin
							GikoSys.SpamCountWord( ReadList[ StrToInt(IndividualForm.DeleteList[i]) - 1 ], wordCount );
							GikoSys.SpamForget( wordCount, True );	// �X�p��������
							GikoSys.SpamLearn( wordCount, False );	// �n���ɐݒ�
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
				msg := '���̃X���b�h�ł͌ʂ��ځ`����s���Ă܂���';
				MsgBox(GikoForm.Handle, msg, '���b�Z�[�W', MB_OK);
			end;
		end;
	finally
		IndividualForm.Release;
	end;
end;
// *************************************************************************
//! ����ID���ځ`��@�ʏ�
// *************************************************************************
procedure TGikoDM.IndividualAbonID1ActionExecute(Sender: TObject);
begin
	GikoForm.IndividualAbonID(1);
end;
// *************************************************************************
//! ����ID���ځ`��@����
// *************************************************************************
procedure TGikoDM.IndividualAbonID0ActionExecute(Sender: TObject);
begin
	GikoForm.IndividualAbonID(0);
end;
// *************************************************************************
//! �͈͂��ځ`��i���̃��X�j
// *************************************************************************
procedure TGikoDM.RangeAbonActionExecute(Sender: TObject);
begin
  GikoForm.RangeAbon(GikoForm.KokoPopupMenu.Tag);
end;
// *************************************************************************
//! �͈͂��ځ`��i�X���b�h�j
// *************************************************************************
procedure TGikoDM.ThreadRangeAbonActionExecute(Sender: TObject);
begin
  GikoForm.RangeAbon(0);
end;
////////////////////////////////�u���E�U�|�b�v�A�b�v�܂ł����܂�/////////////////////
// *************************************************************************
//! �M�R�i�r�̃E�F�u�T�C�g��\������
// *************************************************************************
procedure TGikoDM.GikoNaviWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_GIKONAVI, gbtAuto);
end;
// *************************************************************************
//! �M�R�i�r(����)�̃E�F�u�T�C�g��\������
// *************************************************************************
procedure TGikoDM.GikoNaviGoesonWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_GIKONAVIGO, gbtAuto);
end;
// *************************************************************************
//! ���i�W���̃E�F�u�T�C�g��\������
// *************************************************************************
procedure TGikoDM.MonazillaWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_MONAZILLA, gbtAuto);
end;
// *************************************************************************
//! �Q�����˂�g�b�v�y�[�W��\������
// *************************************************************************
procedure TGikoDM.BBS2chWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_2ch, gbtAuto);
end;
// *************************************************************************
//! �M�R�i�r�̃t�H���_���J��
// *************************************************************************
procedure TGikoDM.GikoFolderOpenActionExecute(Sender: TObject);
begin
	GikoSys.CreateProcess('explorer.exe', '/e,"' + GikoSys.GetAppDir + '"');
end;
// *************************************************************************
//! �o�[�W��������\������
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
//! �M�R�i�r�̃w���v��\������
// *************************************************************************
procedure TGikoDM.GikoHelpActionExecute(Sender: TObject);
var
	FileName: string;
begin
	FileName := GikoSys.GetAppDir + 'batahlp.chm';
	if not FileExists(FileName) then begin
		MsgBox(
			GikoForm.Handle,
			'�w���v��������܂���ł���' + #13#10 +
			'�w���v�t�@�C�����M�R�i�r�̃t�H���_�ɒu���Ă�������' + #13#10 +
			'�w���v�̓M�R�i�r�̃T�C�g�ɒu���Ă���܂�',
			MSG_ERROR,
			MB_ICONSTOP);
		Exit;
	end;
	ShellExecute(GikoForm.Handle, 'open', PChar(FileName), '', PChar(GikoSys.GetAppDir), SW_SHOW);
end;
// *************************************************************************
//! �M�R�i�rWiki�̃E�F�u�T�C�g��\������
// *************************************************************************
procedure TGikoDM.WikiFAQWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_Wiki, gbtAuto);
end;
// *************************************************************************
//! �M�R�i�r(����)Wiki�̃E�F�u�T�C�g��\������
// *************************************************************************
procedure TGikoDM.GoWikiFAQWebPageActionExecute(Sender: TObject);
begin
	GikoSys.OpenBrowser(PROTOCOL_HTTP + URL_GoWiki, gbtAuto);
end;
////////////////////////////////�w���v�܂ł����܂�/////////////////////
// *************************************************************************
//! ���X�g�ԍ��\����ύX����
// *************************************************************************
procedure TGikoDM.ListNumberVisibleActionExecute(Sender: TObject);
begin
	GikoSys.Setting.ListViewNo := ListNumberVisibleAction.Checked;
	GikoForm.ListViewUC.Refresh;
end;
// *************************************************************************
//! ��ʃt�H���_�Ɉړ�����
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
//! ��ʃt�H���_�Ɉړ�����UpDate�C�x���g
// *************************************************************************
procedure TGikoDM.UpFolderActionUpdate(Sender: TObject);
begin
	UpFolderAction.Enabled := not (GikoForm.GetActiveList is TBBS) and
        (GikoForm.GetActiveList <> BoardGroup.SpecialBoard);
end;
// *************************************************************************
//! �\���@�\�����X�g�̃��[�h�ύX
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
//! SelectComboBox�̒l���N���A����
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
//! �X���b�h�����ׂĕ\������
// *************************************************************************
procedure TGikoDM.AllItemActionExecute(Sender: TObject);
begin
	try
		if GikoForm.ViewType <> gvtAll then
			GikoForm.SetListViewType(gvtAll);
		GikoSys.Setting.ThreadRange := gtrAll;
		AllItemAction.Checked		:= True;
		// SelectComboBox �̗������X�V���Ă���
		GikoForm.ModifySelectList;
		// SelectComboBox �̒l���N���A
		ClearSelectComboBox;
	except
	end;
end;
// *************************************************************************
//! ���O�L��X���b�h�݂̂�\������
// *************************************************************************
procedure TGikoDM.LogItemActionExecute(Sender: TObject);
begin
	try
		if GikoForm.ViewType <> gvtLog then
			GikoForm.SetListViewType(gvtLog);
		GikoSys.Setting.ThreadRange	:= gtrLog;
		LogItemAction.Checked := True;
		// SelectComboBox �̗������X�V���Ă���
		GikoForm.ModifySelectList;
		// SelectComboBox �̒l���N���A
		ClearSelectComboBox;
	except
	end;
end;
// *************************************************************************
//! �V���X���b�h�̂ݕ\������
// *************************************************************************
procedure TGikoDM.NewItemActionExecute(Sender: TObject);
begin
	try

		if GikoForm.ViewType <> gvtNew then
			GikoForm.SetListViewType(gvtNew);
		GikoSys.Setting.ThreadRange	:= gtrNew;
		NewItemAction.Checked := True;
		// SelectComboBox �̗������X�V���Ă���
		GikoForm.ModifySelectList;
		// SelectComboBox �̒l���N���A
		ClearSelectComboBox;
	except
	end;
end;
// *************************************************************************
//! DAT�����X���b�h�̂ݕ\������
// *************************************************************************
procedure TGikoDM.ArchiveItemActionExecute(Sender: TObject);
begin
	try
		if GikoForm.ViewType <> gvtArch then
			GikoForm.SetListViewType(gvtArch);
		GikoSys.Setting.ThreadRange	:= gtrArch;
		ArchiveItemAction.Checked := True;
		// SelectComboBox �̗������X�V���Ă���
		GikoForm.ModifySelectList;
		// SelectComboBox �̒l���N���A
		ClearSelectComboBox;
	except
	end;
end;
// *************************************************************************
//! �����X���b�h�̂ݕ\������
// *************************************************************************
procedure TGikoDM.LiveItemActionExecute(Sender: TObject);
begin
	try
		if GikoForm.ViewType <> gvtLive then
			GikoForm.SetListViewType(gvtLive);
		GikoSys.Setting.ThreadRange	:= gtrLive;
		LiveItemAction.Checked := True;
		// SelectComboBox �̗������X�V���Ă���
		GikoForm.ModifySelectList;
		// SelectComboBox �̒l���N���A
		ClearSelectComboBox;
	except
	end;
end;

// *************************************************************************
//! �X���b�h�̕\���͈͂�ݒ�
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
//! �X���b�h�i���݃_�C�A���O��\������
// *************************************************************************
procedure TGikoDM.SelectItemActionExecute(Sender: TObject);
var
	idx: Integer;
	Dlg: TListSelectDialog;
begin
	try
		if GikoForm.SelectComboBoxPanel.Visible then begin
			if GikoForm.SelectComboBoxPanel.Left + GikoForm.SelectComboBoxPanel.Width < GikoForm.ListToolBar.Width then begin
				// SelectComboBox ������ꍇ�̓t�H�[�J�X���ڂ�
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
//! �V�X���������݃E�B���h�E��\������
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
//! ���ݕ\�����Ă�����u���E�U�ŕ\������
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
//! �I������Ă���X���b�h��URL���R�s�[����
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
//! �I������Ă���X���b�h��URL���R�s�[����Update�C�x���g
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
//! �I������Ă���̖��O���R�s�[����
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
//! �I������Ă���̖��O���R�s�[����Update�C�x���g
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
//! �I������Ă���X���b�h�̖��O��URL���R�s�[����
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
//! �I������Ă���X���b�h�ꗗ���_�E�����[�h����
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
				msg := '5�ȏ�͎w��ł��܂���' + #13#10
						 + '�Q�����˂镉�׌y���ɂ����͂�������';
				MsgBox(GikoForm.Handle, msg, '�x��', MB_ICONEXCLAMATION);
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
//! �I������Ă���X���b�h�ꗗ���_�E�����[�h����Update�C�x���g
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
//! �I������Ă���X���b�h���_�E�����[�h����
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
			msg := '10�ȏ�͎w��ł��܂���' + #13#10
					 + '�Q�����˂镉�׌y���ɂ����͂�������';
			MsgBox(GikoForm.Handle, msg, '�x��', MB_ICONEXCLAMATION);
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
//! �I������Ă���X���b�h���_�E�����[�h����Update�C�x���g
// *************************************************************************
procedure TGikoDM.SelectThreadReloadActionUpdate(Sender: TObject);
begin
	TAction(Sender).Enabled :=
		(GikoForm.GetActiveList is TBoard) and (GikoForm.ListViewUC.SelCount > 0);
end;
// *************************************************************************
//! �X���b�h����\��
// *************************************************************************
procedure TGikoDM.SelectReservActionExecute(Sender: TObject);
begin
	//INFO 2005/11/19 �_�~�[�H�@by ������
	// ���̃R�����g�폜���Ă͑ʖ�
end;
// *************************************************************************
//! �X���b�h����\��Update�C�x���g
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
//! �I�����Ă���X���b�h�ɐV�������O�ŏ���\��
// *************************************************************************
procedure TGikoDM.SelectNewRoundNameExecute(Sender: TObject);
var
	s: string;
	Dlg: TRoundNameDialog;
		cnt: Integer;

begin
	//�Ăяo�������ATAction��ListView�ɑI�������Ȃ���΁AEXIT����
	if (Sender is TAction) and (GikoForm.ListViewUC.Selected = nil) then
		Exit;

	//�o�^����`�F�b�N
	cnt := RoundList.Count[grtBoard];
	cnt := cnt + RoundList.Count[grtItem];
	if cnt > 500 then begin
			MsgBox(GikoForm.Handle, '�����500�ȏ�o�^�ł��܂���', MSG_ERROR, MB_OK or MB_ICONSTOP);
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
//! �I������Ă��X���b�h�̏�����폜����
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
//! �I������Ă�������C�ɓ���ɒǉ�����
// *************************************************************************
procedure TGikoDM.BoardFavoriteAddActionExecute(Sender: TObject);
begin
	if TObject(GikoForm.ListViewUC.Selected.Data) is TBoard then
		GikoForm.ShowFavoriteAddDialog(TObject(GikoForm.ListViewUC.Selected.Data));
end;
// *************************************************************************
//! �I������Ă�������C�ɓ���ɒǉ�����Update�C�x���g
// *************************************************************************
procedure TGikoDM.BoardFavoriteAddActionUpdate(Sender: TObject);
begin
	BoardFavoriteAddAction.Enabled :=
		(GikoForm.GetActiveList is TCategory) and (GikoForm.ListViewUC.SelCount > 0);
end;
// *************************************************************************
//! Explorer��Log�t�H���_���J��
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
//! ActiveList��TBoard��TCategory�ŃX���ꗗ�łP�ȏ�I�����Ă���ƗL���ɂȂ�Actionde����
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
//! Header.txt���u���E�U�ŕ\������
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
		ShowMessage('�����ł��܂���ł����B');
	end;

end;
// *************************************************************************
//! �X���ꗗ�̕\�����Ă�����e�ɂ��������āA�\�[�g�J�����̈ʒu�ƕ������擾����
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
//! ���݂̃J�������\�[�g����
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
//! �E�ׂ̃J�������\�[�g
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
//! ���ׂ̃J�������\�[�g
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
////////////////////////////////�܂ł����܂�/////////////////////
// *************************************************************************
//! �W���c�[���o�[�̕\����Ԃ�ύX����
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
//! �A�h���X�o�[�̕\����Ԃ�ύX����
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
//! �����N�o�[�̕\����Ԃ�ύX����
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
//! ���X�g�c�[���o�[�̕\����Ԃ�ύX����
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
//! ���X�g���̂̕\����Ԃ�ύX����
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
//! �u���E�U�c�[���o�[�̕\����Ԃ�ύX����
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
//! �u���E�U���̂̕\����Ԃ�ύX����
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
//! ���b�Z�[�W�o�[�̕\����Ԃ�ύX����
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
//! ���b�Z�[�W�o�[�����
// *************************************************************************
procedure TGikoDM.MsgBarCloseActionExecute(Sender: TObject);
begin
	MsgBarVisibleAction.Execute;
end;
// *************************************************************************
//! �X�e�[�^�X�o�[�̕\����Ԃ�ύX����
// *************************************************************************
procedure TGikoDM.StatusBarVisibleActionExecute(Sender: TObject);
begin
	GikoForm.StatusBar.Visible := StatusBarVisibleAction.Checked;
	GikoSys.Setting.StatusBarVisible := StatusBarVisibleAction.Checked;
end;
// *************************************************************************
//! �L���r�l�b�g�̕\�����f���ɂ���
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
//! �L���r�l�b�g�̕\���𗚗����X�g�ɂ���
// *************************************************************************
procedure TGikoDM.CabinetHistoryActionExecute(Sender: TObject);
begin
	GikoForm.ShowHistoryTree;
end;
// *************************************************************************
//! �L���r�l�b�g�̕\�������C�ɓ��胊�X�g�ɂ���
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
			// CabinetMenu �� CabinetSelectPopupMenu �Ɠ����ƌ��߂��������Ⴄ
			GikoForm.CabinetMenu.Items[ i ].Checked := False;
		end;
	end;

	// �L���r�l�b�g�c�[���o�[�y�уL���r�l�b�g�̕\���ؑ�
	GikoForm.HistoryToolBar.Hide;
	GikoForm.FavoriteToolBar.Show;
	GikoForm.TreeViewUC.Visible := False;
	GikoForm.FavoriteTreeViewUC.Visible := True;

	GikoForm.CabinetSelectToolButton.Caption := '���C�ɓ���';
	GikoForm.TreeType := gttFavorite;

	// ���j���[�y�у{�^���̃`�F�b�N��ݒ�
	CabinetBBSAction.Checked := False;
	CabinetHistoryAction.Checked := False;

	// ���C�ɓ���̃c���[��W�J
	GikoForm.FavoriteTreeViewUC.Items.GetFirstNode.Expanded := True;

end;
// *************************************************************************
//! �L���r�l�b�g�̕\����Ԃ�ύX����
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
//! �L���r�l�b�g�����
// *************************************************************************
procedure TGikoDM.CabinetCloseActionExecute(Sender: TObject);
begin
	//INFO 2005/11/19 ���̃A�N�V�����ɂ͉����ݒ肳��Ă��Ȃ������@������
end;
// *************************************************************************
//! ���X�g��傫���A�C�R���\���ɂ���
// *************************************************************************
procedure TGikoDM.LargeIconActionExecute(Sender: TObject);
begin
	GikoForm.ListViewUC.ViewStyle := vsIcon;
	LargeIconAction.Checked := True;
end;
// *************************************************************************
//! ���X�g���������A�C�R���\���ɂ���
// *************************************************************************
procedure TGikoDM.SmallIconActionExecute(Sender: TObject);
begin
	GikoForm.ListViewUC.ViewStyle := vsSmallIcon;
	SmallIconAction.Checked := True;
end;
// *************************************************************************
//! ���X�g���ꗗ�\���ɂ���
// *************************************************************************
procedure TGikoDM.ListIconActionExecute(Sender: TObject);
begin
	GikoForm.ListViewUC.ViewStyle := vsList;
	ListIconAction.Checked := True;
end;
// *************************************************************************
//! ���X�g���ڍו\���ɂ���
// *************************************************************************
procedure TGikoDM.DetailIconActionExecute(Sender: TObject);
begin
	GikoForm.ListViewUC.ViewStyle := vsReport;
	DetailIconAction.Checked := True;
end;

// *************************************************************************
//! �_�E�����[�h�𒆎~����
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
//! ���X�g�ƃu���E�U�̏c���z�u��ύX����
// *************************************************************************
procedure TGikoDM.ArrangeActionExecute(Sender: TObject);
begin
	if ArrangeAction.Checked then begin
		//�c
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
		//��
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
//! �y�C���̃T�C�Y������������
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
//! �u���E�U�^�u�̕\����Ԃ�ύX����
// *************************************************************************
procedure TGikoDM.BrowserTabVisibleActionExecute(Sender: TObject);
begin
	GikoSys.Setting.BrowserTabVisible := BrowserTabVisibleAction.Checked;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! �u���E�U�^�u����ɕ\������
// *************************************************************************
procedure TGikoDM.BrowserTabTopActionExecute(Sender: TObject);
begin
	BrowserTabBottomAction.Checked := False;
	BrowserTabTopAction.Checked := True;
	GikoSys.Setting.BrowserTabPosition := gtpTop;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! �u���E�U�^�u�����ɕ\������
// *************************************************************************
procedure TGikoDM.BrowserTabBottomActionExecute(Sender: TObject);
begin
	BrowserTabTopAction.Checked := False;
	BrowserTabBottomAction.Checked := True;
	GikoSys.Setting.BrowserTabPosition := gtpBottom;
	GikoForm.SetBrowserTabState;
end;
// *************************************************************************
//! �u���E�U�^�u�̃X�^�C�����^�u�X�^�C���ɂ���
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
//! �u���E�U�^�u�̃X�^�C�����{�^���X�^�C���ɂ���
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
//! �u���E�U�^�u�̃X�^�C�����t���b�g�{�^���X�^�C���ɂ���
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
//! �u���E�U�Ƀt�H�[�J�X�𓖂Ă�
// *************************************************************************
procedure TGikoDM.SetFocusForBrowserActionExecute(Sender: TObject);
begin
    GikoForm.ActiveContent.Browser.SetFocus;
end;
// *************************************************************************
//! �u���E�U�Ƀt�H�[�J�X�𓖂Ă�Update�C�x���g
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
//! �X���b�h�ꗗ�Ƀt�H�[�J�X�𓖂Ă�
// *************************************************************************
procedure TGikoDM.SetFocusForThreadListActionExecute(Sender: TObject);
begin
	if GikoForm.ActiveContent <> nil then
		GikoForm.WebBrowserClick(GikoForm.ActiveContent.Browser); //���Browser�ɓ��ĂȂ��Ɠ����Ȃ��Ƃ�������
	GikoForm.ListViewUC.SetFocus;

	if( GikoForm.ListViewUC.Items.Count > 0 ) and (GikoForm.ListViewUC.ItemFocused = nil) then
		GikoForm.ListViewUC.Items.Item[0].Selected := true; //�I���A�C�e���������Ƃ��͐擪�̂�I������

	//�X�N���[��������
	if (GikoForm.ListViewUC.ItemFocused <> nil) then begin
		GikoForm.ListViewUC.ItemFocused.MakeVisible(False);
	end;
end;
// *************************************************************************
//! �L���r�l�b�g�Ƀt�H�[�J�X�𓖂Ă�
// *************************************************************************
procedure TGikoDM.SetFocusForCabinetActionExecute(Sender: TObject);
begin
	if GikoForm.ActiveContent <> nil then
		GikoForm.WebBrowserClick(GikoForm.ActiveContent.Browser); //���Browser�ɓ��ĂȂ��Ɠ����Ȃ��Ƃ�������
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
//! �L���r�l�b�g�Ƀt�H�[�J�X�𓖂Ă�Update�C�x���g
// *************************************************************************
procedure TGikoDM.SetFocusForCabinetActionUpdate(Sender: TObject);
begin
	SetFocusForCabinetAction.Enabled := GikoForm.CabinetPanel.Visible;
end;
// *************************************************************************
//! �X���b�h�ꗗ���ő剻���ăt�H�[�J�X�𓖂Ă�
// *************************************************************************
procedure TGikoDM.ThreadlistMaxAndFocusActionExecute(Sender: TObject);
begin
	BrowserMinAction.Execute;
	SetFocusForThreadListAction.Execute;
end;
// *************************************************************************
//! �X���\�����ő剻���ăt�H�[�J�X�𓖂Ă�
// *************************************************************************
procedure TGikoDM.BrowserMaxAndFocusActionExecute(Sender: TObject);
begin
	BrowserMaxAction.Execute;
	SetFocusForBrowserAction.Execute;
end;
// *************************************************************************
//! �X���b�h�ꗗ�̑I�����폜����
// *************************************************************************
procedure TGikoDM.UnSelectedListViewActionExecute(Sender: TObject);
begin
	if GikoForm.ListViewUC.Selected <> nil then begin
		GikoForm.ListViewUC.Selected.Focused := True;
		GikoForm.ListViewUC.Selected := nil;
	end;
end;
////////////////////////////////�\���܂ł����܂�/////////////////////
// *************************************************************************
//! �I������Ă���X���b�h�����ǂɂ���
// *************************************************************************
procedure TGikoDM.KidokuActionExecute(Sender: TObject);
begin
	SetThreadReadProperty(true);
end;
// *************************************************************************
//! �I������Ă���X���b�h�𖢓ǂɂ���
// *************************************************************************
procedure TGikoDM.MidokuActionExecute(Sender: TObject);
begin
	SetThreadReadProperty(false);
end;
// *************************************************************************
//! �I������Ă���X���b�h�̖��ǁE���ǂ�ݒ肷��   true : ���� false : ����
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
//! ���X�g��S�đI������
// *************************************************************************
procedure TGikoDM.AllSelectActionExecute(Sender: TObject);
begin
	GikoForm.ListViewAllSelect;
end;
// *************************************************************************
//! ���X�g��S�đI������Update�C�x���g
// *************************************************************************
procedure TGikoDM.AllSelectActionUpdate(Sender: TObject);
begin
	AllSelectAction.Enabled := GikoForm.ListViewUC.SelCount > 0;
end;
////////////////////////////////�ҏW�܂ł����܂�/////////////////////
//! �X���b�h�̃T�C�Y���Čv�Z����
procedure TGikoDM.ThreadSizeCalcForFileActionExecute(Sender: TObject);
const
	RECALC_MES : String = '�X���b�h�̗e�ʂ��t�@�C������Čv�Z���܂��B'#13#10 +
							'���̑��쒆�A�M�R�i�r�̑��̑��������ƃf�[�^���j�󂳂�鋰�ꂪ����܂��B' +
							'�܂����̑���́A���Ɏ��Ԃ�������ꍇ������܂����A��낵���ł����H';
	RECALC_TITLE : String = '�X���b�h�̗e�ʂ��t�@�C������Čv�Z';
	LIMIT_SIZE = 1024;
var
	limitSize : Integer;
	limitStr  : String;
begin
{ �܂��A���Ԃ������邱�Ƃ��x�����郁�b�Z�[�W���o��
  �Čv�Z����X���b�h�̃T�C�Y��臒l�i�f�t�H���g1024B)���m�F
  �v���O�C���𗘗p���Ȃ��Ƃ���őS�Ẵ��O�L��X���b�h������
  臒l�ȉ��̃T�C�Y�̏ꍇ�ADAT�̃t�@�C���T�C�Y�Ɣ�r�A����Ă���΁A
  DAT�̃t�@�C���T�C�Y�ōX�V����
}
	if MsgBox(GikoForm.Handle, RECALC_MES,
		RECALC_TITLE, MB_YESNO or MB_ICONWARNING) = ID_YES then begin
		//臒l�̊m�F
		limitSize := LIMIT_SIZE;
		limitStr  := IntToStr(limitSize);
		if InputQuery('臒l����', '�w�肵�����l B�ȉ��̗e�ʂ̃X���b�h�̂ݍČv�Z���܂�', limitStr) then begin
			limitSize := StrToInt(MojuUtils.ZenToHan(limitStr));
			if (limitSize < 0) then begin
				ShowMessage('臒l�ɕ��͎w��ł��܂���I');
				ThreadSizeCalcForFileActionExecute(nil);
			end else begin
				RecalcThreadSize(limitSize);
			end;
		end;
	end;
end;
//! limit�����T�C�Y�̏������X���b�h�̗e�ʂ�DAT�t�@�C������v�Z
procedure TGikoDM.RecalcThreadSize(limit : Integer);
var
	i, j, tmpSize : Integer;
	Obj   : TObject;
	Board : TBoard;
	Thread: TThreadItem;
	dat   : TStringList;
begin
	// �Čv�Z�X�^�[�g�@�v���O�C���𗘗p���Ȃ��Ƃ����S������I
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
	ShowMessage('�v�Z�I�����܂����B');
end;
// *************************************************************************
//! ���̓A�V�X�g�̐ݒ�t�H�[�����Ăяo��
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
//! ���ݕ\�����Ă���X���b�h�̌����_�C�A���O��\������
// *************************************************************************
procedure TGikoDM.OpenFindDialogActionExecute(Sender: TObject);
begin
	if( GikoForm.ActiveContent <> nil) and (GikoForm.ActiveContent.Browser <> nil) then begin
		GikoForm.ActiveContent.OpenFindDialog;
	end;
end;

// *************************************************************************
//! �I������Ă��邨�C�ɓ���̕\�������R�s�[����
// *************************************************************************
procedure TGikoDM.FavoriteTreeViewItemNameCopyActionExecute(
  Sender: TObject);
begin
	if GikoForm.ClickNode = nil then Exit;

	WideCtrls.SetClipboard(GikoForm.ClickNode.Text + #13#10);
end;

// *************************************************************************
//! �\������Ă��邷�ׂẴ��X�G�f�B�^�����
// *************************************************************************
procedure TGikoDM.CloseAllEditorActionExecute(Sender: TObject);
var
	i : Integer;
begin
	if ( EditorFormExists ) then begin
		//�X�N���[����̑S�Ẵt�H�[������AEditorForm�����
		for i := Screen.CustomFormCount - 1 downto 0 do begin
			if TObject(Screen.CustomForms[i]) is TEditorForm then begin
				TEditorForm(Screen.CustomForms[i]).Close;
			end;
		end;
	end;
end;
// *************************************************************************
//! �X�N���[����Ƀ��X�G�f�B�^�������ꍇ�C�L���ɂȂ�
// *************************************************************************
procedure TGikoDM.CloseAllEditorActionUpdate(Sender: TObject);
begin
    if (Sender is TAction) then begin
        TAction(Sender).Enabled := EditorFormExists;
    end;
end;

// *************************************************************************
//! �X�N���[�����EditorForm�����邩
// *************************************************************************
function TGikoDM.EditorFormExists(): boolean;
var
	i : Integer;
begin
	Result := false;
	//�X�N���[����̑S�Ẵt�H�[������AEditorForm��T��
	for i := Screen.CustomFormCount - 1 downto 0 do begin
		if (Screen.CustomForms[i] is TEditorForm) then begin
			Result := true;
			Break;
		end;
	end;
end;

// *************************************************************************
//! �X�N���[����ɂ��邷�ׂĂ�EditorForm���疼�O�̗������폜����
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
//! �X�N���[����ɂ��邷�ׂĂ�EditorForm���烁�[���������폜����
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
//! �����N������߂�̍X�V����
// *************************************************************************
procedure TGikoDM.PrevMoveHistoryUpdate(Sender: TObject);
begin
      PrevMoveHistory.Enabled :=
          (MoveHisotryManager.HisotryIndex > 0)
end;
// *************************************************************************
//! �����N������߂�
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
//! �����N��������
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
            //URL�Ɉړ�
            MoveURLWithHistory(item.ThreadItem.URL, True);
        end;
    end;
end;
//! ����������URL�ړ�
procedure TGikoDM.MoveURLWithHistory(URL : String; KeyMask: Boolean = False);
var
    idx : Integer;
begin
    //URL�Ɉړ�
    GikoForm.MoveToURL(URL, KeyMask);
    //�ȉ��A�����̏���
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
//! �����N������i�ނ̍X�V����
// *************************************************************************
procedure TGikoDM.NextMoveHistoryUpdate(Sender: TObject);
begin
    NextMoveHistory.Enabled :=
          (MoveHisotryManager.HisotryIndex < MoveHisotryManager.Count - 1);
end;
// *************************************************************************
//! �����N������i��
// *************************************************************************
procedure TGikoDM.NextMoveHistoryExecute(Sender: TObject);
begin
    BackToHistory(MoveHisotryManager.getNextItem);
end;
// *************************************************************************
//! �A�N�e�B�u�v�f�̃N���b�N
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
//! ���L�[�̃G�~�����[�g�A�N�V����
procedure TGikoDM.VKDownActionExecute(Sender: TObject);
begin
    keybd_event(VK_DOWN, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_DOWN, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
end;
//! ���L�[�̃G�~�����[�g�A�N�V����
procedure TGikoDM.VKUpActionExecute(Sender: TObject);
begin
    keybd_event(VK_UP, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_UP, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
end;
//! ���L�[�̃G�~�����[�g�A�N�V����
procedure TGikoDM.VKRightActionExecute(Sender: TObject);
begin
    keybd_event(VK_RIGHT, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_RIGHT, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
end;
//! ���L�[�̃G�~�����[�g�A�N�V����
procedure TGikoDM.VKLeftActionExecute(Sender: TObject);
begin
    keybd_event(VK_LEFT, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_LEFT, 0, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
end;
//! �^�X�N�g���C�Ɋi�[����
procedure TGikoDM.StoredTaskTrayActionExecute(Sender: TObject);
begin
    GikoForm.StoredTaskTray;
    StoredTaskTrayAction.Tag := -1;
end;

{
\breif  �����N�C���[�W�擾
�C���[�W�́C*.jpg, *.jpeg, *.gif, *.png
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
\breif  �V�����X�̃����N�C���[�W�擾
�C���[�W�́C*.jpg, *.jpeg, *.gif, *.png
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
\breif  �����NURL�擾
�Ώۊg���q�́A�ڍאݒ�Őݒ肳��Ă���
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
\breif  �V�����X�����NURL�擾
�Ώۊg���q�́A�ڍאݒ�Őݒ肳��Ă���
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
\brief  ���ݕ\�����Ă���X���b�h�̂��ׂẴ����N���擾����B
\return IHTMLElementCollection  �����N�̃R���N�V����
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
\brief  �����N��URL���擾����
\param  links   �擾���郊���N�̑S�̂̃R���N�V����
\param  URLs    �擾����URL�̕ۑ���
\param  Start   �ݒ肵�����X�ԍ��ȍ~���擾( > 0)
\param  Exts    �擾���郊���N�̊g���q
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
                // ���X�̔ԍ����X�V
                if (Pos('menu:', url) > 0) then begin
                    index := StrToInt64Def(
                        Copy(url, 6, Length(url)), index + 1
                    );
                end else begin
                    // �J�n���X�ԍ��ȍ~���`�F�b�N
                    if (index >= Start) then begin
                        ext := ExtractFileExt( AnsiLowerCase(url) );
                        // �g���q���`�F�b�N
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
\brief  �A�h���X�o�[�Ƀt�H�[�J�X�𓖂Ă�
\param  Sender   �C�x���g�̔�����
}
procedure TGikoDM.SetForcusForAddresBarActionExecute(Sender: TObject);
begin
    if ( GikoForm.AddressToolBar.Visible ) then begin
        GikoForm.AddressComboBox.SetFocus;
    end
end;
{
\brief  �ړ]������URL���擾����_�C�A�O������\������
}
procedure TGikoDM.NewBoardSearchActionExecute(Sender: TObject);
var
    form : TNewBoardURLForm;
	Msg: string;
begin
	if (EditorFormExists) then begin
		Msg := '���X�G�f�B�^��S�ĕ��Ă�������';
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
//! �u���E�U��1�y�[�W���X�N���[��������
procedure TGikoDM.ScrollPageDownActionExecute(Sender: TObject);
begin
    GikoForm.BrowserMovement(GikoForm.BrowserPanel.Height);
end;
//! �u���E�U��1�y�[�W���X�N���[��������
procedure TGikoDM.ScrollPageUpActionExecute(Sender: TObject);
begin
    GikoForm.BrowserMovement(-GikoForm.BrowserPanel.Height);
end;


//! ���̃��X��ID��NG���[�h�ɒǉ�����i����)
procedure TGikoDM.AddIDtoNGWord0ActionExecute(Sender: TObject);
begin
    GikoForm.AddIDtoNGWord(true);
end;
//! ���̃��X��ID��NG���[�h�ɒǉ�����
procedure TGikoDM.AddIDtoNGWord1ActionExecute(Sender: TObject);
begin
    GikoForm.AddIDtoNGWord(false);
end;
//! �N���b�v�{�[�h�̕������ID�Ƃ��ē���ID���X�A���J�[�\��
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
//! �^�u�̃X���b�h�ꗗ��\������
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
//! �t�Q�Ƃ��Ă��郌�X��ǉ�����
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
    // �A�N�e�B�u�^�u����S�Ẵ����N���擾����
    links := GetActiveThreadLinks;
    if (ThreadItem <> nil) and (links <> nil) then begin
        resNo := TStringList.Create;
        try
            currentNo := 0;
            alreadyExist := False;
            // �����N��S�đ�������
            for i := 0 to links.length - 1 do begin
                item := links.item(i, 0) as IHTMLElement;
                if (item <> nil) then begin
                    url := item.getAttribute('href', 0);
                    // ���X�̔ԍ����X�V
                    if (Pos('menu:', url) > 0) then begin
                        currentNo := StrToInt64Def(
                            Copy(url, 6, Length(url)), currentNo + 1
                        );
                        alreadyExist := False;
                    end else if (currentNo <> -1) and (not alreadyExist) then begin
                        // IE7�Ή�
                        if Pos('about:..', url) = 1 then begin
                            url := 'about:blank..' + Copy( url, Length('about:..')+1, Length(url) )
                        end;
                        // �����ւ̃����N���烌�X�|�b�v�p�̔ԍ��擾
                        if Pos('about:blank..', url) = 1 then begin
                            // No �Ԃւ̃����N������ΎQ�Ƃ���
                            url2 := THTMLCreate.GetRespopupURL(url, ThreadItem.URL);
                			PathRec := Gikosys.Parse2chURL2(url2);
                            if (not PathRec.FNoParam) then begin
                                Gikosys.GetPopupResNumber(url2,PathRec.FSt,PathRec.FTo);
			                end;
                            // �Ώۃ��X�������͂�����܂ނȂ�Q�Ƃ���Ƃ���
                            if (PathRec.FSt = No) or
                                ((PathRec.FSt <= No) and (PathRec.FTo >= No))  then begin
                                alreadyExist := True;
                                resNo.Add(IntToStr(currentNo));
                            end;
                        end;
                    end;
                end;
            end;
            // �������Ȃ̂�-1�Œ�
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
		Msg := '���X�G�f�B�^��S�ĕ��Ă�������';
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
        // �M�R�i�r�I��
        GikoForm.Close;
    end;

end;
//! ���̃��X��URL�R�s�[�iPATH_INFO)
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
            // �܂�BBS�p���u
            URL := MojuUtils.CustomStringReplace(URL, 'read.pl', 'read.cgi');
            URL := URL + '/' + ThreadItem.ParentBoard.BBSID + '/' + ChangeFileExt(ThreadItem.FileName, '')  + '/' + IntToStr(No);
        end;
    end;
    Clipboard.SetTextBuf( PChar(URL) );
end;
//! ���̃��X��URL�R�s�[�iQuery_STRING)
procedure TGikoDM.konoURLQueryActionExecute(Sender: TObject);
var
    No : Integer;
    ThreadItem : TThreadItem;
    URL, Protocol, Host, Path, Document, Port, Bookmark : String;
begin
	No := GikoForm.KokoPopupMenu.Tag;
	if No = 0 then Exit;

    ThreadItem := GikoForm.KokoPopupThreadItem;
    // 2ch�Ƃ�����΂́A���X�ԍ������܂��������Ă���Ȃ��̂ŗ��p�s��
    if ThreadItem.ParentBoard.Is2ch or not (Pos('?', ThreadItem.URL) > 0) then begin
        GikoSys.ParseURI(ThreadItem.URL, Protocol, Host, Path, Document, Port, Bookmark);
        URL := Protocol + '://' + Host + '/test/read.cgi?bbs=' + ThreadItem.ParentBoard.BBSID
            + '&key=' + ChangeFileExt(ThreadItem.FileName, '') + '&st=' + IntToStr(No) + '&to=' + IntToStr(No);
    end else begin
        URL := ThreadItem.URL;
        // �܂�BBS
        if Pos('&LAST=', URL) > 0 then begin
            URL := Copy(URL, 1, Pos('&LAST=', URL) - 1);
            URL := URL + '&START=' + IntToStr(No) + '&END=' + IntToStr(No);
        end;
        // ���̑��O����
        if Pos('&ls=', URL) > 0 then begin
            URL := Copy(URL, 1, Pos('&ls=', URL) - 1);
            URL := URL + '&st=' + IntToStr(No) + '&to=' + IntToStr(No);
        end;

    end;
    Clipboard.SetTextBuf( PChar(URL) );
end;
//! ���̃��X��URL�R�s�[�iQuery_STRING�j�̗��p�`�F�b�N
procedure TGikoDM.konoURLQueryActionUpdate(Sender: TObject);
//const
//	LIVEDOOR_URL = 'http://jbbs.shitaraba.net/';
begin
    // 2ch�Ƃ�����΂͗��p�ł��Ȃ��悤�ɂ���i���܂����X�w��ł��Ȃ��̂Łj
    konoURLQueryAction.Enabled := false;
    if (GikoForm.KokoPopupThreadItem <> nil) then begin
        konoURLQueryAction.Enabled := not GikoForm.KokoPopupThreadItem.ParentBoard.Is2ch;
        if konoURLQueryAction.Enabled then begin
            //konoURLQueryAction.Enabled := not (Pos(LIVEDOOR_URL, GikoForm.KokoPopupThreadItem.URL) = 1);
            konoURLQueryAction.Enabled := not GikoSys.IsShitarabaURL(GikoForm.KokoPopupThreadItem.URL);
        end;
    end;
end;
//! �|�b�v�A�b�v���j���[�ݒ�_�C�A���O���J��
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

// �h���O���V�X�e����ʕ\��
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
	  HintStr := Format('�ǂ񂮂�V�X�e��%s%s [%s]%sLv.%s [%s]', [
    			#10, GikoSys.DonguriSys.Home.UserMode,
          		 GikoSys.DonguriSys.Home.UserID,
          #10, GikoSys.DonguriSys.Home.Level,
          		 GikoSys.DonguriSys.Home.UserName])
  else
		HintStr := '�ǂ񂮂�V�X�e����\������';
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
      msg := '�ǂ񂮂�V�X�e���Ƀ��O�C���ł��܂���ł����B';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('�ǂ񂮂�V�X�e���Ƀ��O�C���ł��܂���ł����B' + e.Message, nil, gmiNG);
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
      GikoForm.AddMessageList('�ǂ񂮂�V�X�e�����O�C���G���[�FUPLIFT�̐ݒ肪����������܂���B', nil, gmiNG);
      GikoForm.PlaySound('Error');
      Exit;
    end;

    if GikoSys.DonguriSys.Processing then
      Exit;

    if GikoSys.DonguriSys.MailLogin(GikoSys.Setting.UserID, GikoSys.Setting.Password, res) then begin
      GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmDngMailLogin) + GikoSys.Setting.UserID, nil, gmiOK);
      DonguriHomeUpdate;
    end else begin
      msg := '�ǂ񂮂�V�X�e���Ƀ��O�C���ł��܂���ł����B';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('�ǂ񂮂�V�X�e���Ƀ��O�C���ł��܂���ł����B' + e.Message, nil, gmiNG);
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
      GikoForm.AddMessageList('�ǂ񂮂�V�X�e�����O�C���G���[�F�x�����A�J�E���g�̐ݒ肪����������܂���B', nil, gmiNG);
      GikoForm.PlaySound('Error');
      Exit;
    end;

    if GikoSys.DonguriSys.Processing then
      Exit;

    if GikoSys.DonguriSys.MailLogin(GikoSys.Setting.DonguriMail, GikoSys.Setting.DonguriPwd, res) then begin
      GikoForm.AddMessageList(GikoSys.GetGikoMessage(gmDngMailLogin) + GikoSys.Setting.DonguriMail, nil, gmiOK);
      DonguriHomeUpdate;
    end else begin
      msg := '�ǂ񂮂�V�X�e���Ƀ��O�C���ł��܂���ł����B';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('�ǂ񂮂�V�X�e���Ƀ��O�C���ł��܂���ł����B' + e.Message, nil, gmiNG);
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
      msg := '�ǂ񂮂�V�X�e�����烍�O�A�E�g�ł��܂���ł����B';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('�ǂ񂮂�V�X�e�����烍�O�A�E�g�ł��܂���ł����B' + e.Message, nil, gmiNG);
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
      msg := '�ǂ񂮂�V�X�e���̍ĔF�؂����s���܂����B';
      if Pos('<html', res) < 1 then
        msg := msg + res
      else if GikoSys.DonguriSys.Home.Error <> '' then
        msg := msg + GikoSys.DonguriSys.Home.Error;
      GikoForm.AddMessageList(msg, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  except
    on e: Exception do begin
      GikoForm.AddMessageList('�ǂ񂮂�V�X�e���̍ĔF�؂����s���܂����B' + e.Message, nil, gmiNG);
      GikoForm.PlaySound('Error');
    end;
  end;
end;

// �ǂ񂮂��C�L�������X�V
procedure TGikoDM.DonguriCannonActionUpdate(Sender: TObject);
var
	ThreadItem : TThreadItem;
begin
	try
		ThreadItem := GikoForm.GetActiveContent(True);
		TAction(Sender).Enabled := (ThreadItem <> nil) and
																ThreadItem.ParentBoard.Is2ch and		// �T�����̂�
                                (Pos('.bbspink.com/', ThreadItem.URL) < 1) and	// BBSPINK�͌��ݔ�Ή�
																(GikoSys.Setting.UserID <> '') and	// �n���^�[�̂�
																(GikoSys.Setting.Password <> '');		// �i�Ƃ肠����UPLIFT�̃��O�C���ݒ肪����ꍇ�̂݁j
  except
  end;
end;

// �ǂ񂮂��C
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

// Cookie�Ǘ���ʕ\��
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

