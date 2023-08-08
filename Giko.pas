unit Giko;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	OleCtrls,	ComCtrls, ExtCtrls, Menus, StdCtrls, MMSystem, DateUtils,
{$IF Defined(DELPRO) }
	//SHDocVw,
	MSHTML,
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB,
{$IFEND}
	IdHTTP, ActiveX, ActnList, ImgList,
	ToolWin, Buttons, IdComponent, UrlMon, Tabs, IdGlobal, StrUtils,
	CommCtrl, Dialogs, GikoSystem, Setting, BoardGroup, ThreadControl, ItemDownload,
	Editor, RoundData, GikoPanel, Favorite, HTMLDocumentEvent,
	{HintWindow,} GikoCoolBar, GikoListView, Search, ExternalBoardManager,
	ExternalBoardPlugInMain, StdActns, Variants, ExtActns,IdTCPConnection,
	IdBaseComponent, IdTCPClient, AppEvnts, BrowserRecord, MoveHistoryItem,
    ShellAPI,Preview, HistoryList, ResPopupBrowser, ExtPreviewDatamodule,
  SHDocVw;

const
	NGWORDNAME_PANEL = 3;
	THREADSIZE_PANEL = 2;
    USER_POPUPCLEAR		= WM_USER + 2005;	///< wParam : TWebBrowser
type

	TToolBarSettingSenderType = (tssNone, tssMain, tssList, tssBrowser);
	TMinimizeType = (mtNone, mtMinimizing, mtMinimized);
	TResizeType = (rtNone, rtResizing);

//	TBrowserRecord = class;

	TGikoForm = class(TForm)
		StatusBar: TStatusBar;
		MainPanel: TPanel;
		ClientPanel: TPanel;
		TreeSplitter: TSplitter;
		CabinetPanel: TPanel;
		TreeView: TTreeView;
		ThreadMainPanel: TPanel;
		ListSplitter: TSplitter;
		ViewPanel: TPanel;
		ListView: TGikoListView;
		ThreadPanel: TPanel;
		MessagePanel: TPanel;
		MessageBar: TPanel;
		MessageHideButton: TSpeedButton;
		MessageListView: TListView;
		MessageSplitter: TSplitter;
		Panel3: TPanel;
    CabinetCloseSpeedButton: TSpeedButton;
		ToolBar1: TToolBar;
		CabinetSelectToolButton: TToolButton;
		HistoryToolBar: TToolBar;
    HistoryShowToolButton: TToolButton;
    HistoryAllClearToolButton: TToolButton;
		ItemIcon16: TImageList;
		ItemIcon32: TImageList;
		HotToobarImageList: TImageList;
		ItemImageList: TImageList;
		MainMenu: TMainMenu;
		FileMenu: TMenuItem;
		DeleteMenu: TMenuItem;
		ExitMenu: TMenuItem;
		KidokuMenu: TMenuItem;
		MidokuMenu: TMenuItem;
		AllSelectMenu: TMenuItem;
		ViewMenu: TMenuItem;
		StdToolBarMenu: TMenuItem;
		CabinetMenu: TMenuItem;
		H1: TMenuItem;
		N4: TMenuItem;
		CabinetVisibleMenu: TMenuItem;
		MessageMenu: TMenuItem;
		StatusBarMenu: TMenuItem;
		MMSep03: TMenuItem;
		LargeIconMenu: TMenuItem;
		SmallIconMenu: TMenuItem;
		ListMenu: TMenuItem;
		DetailMenu: TMenuItem;
		ToolMenu: TMenuItem;
		Find1: TMenuItem;
		RoundMenu: TMenuItem;
		Search1: TMenuItem;
		MMSep04: TMenuItem;
		OptionMenu: TMenuItem;
		HelpMenu: TMenuItem;
		G1: TMenuItem;
		N1: TMenuItem;
		AboutMenu: TMenuItem;
		BrowserPopupMenu: TPopupMenu;
		ShowThreadMenu: TMenuItem;
		ShowBoardMenu: TMenuItem;
		ListIconPopupMenu: TPopupMenu;
		LargeIconPMenu: TMenuItem;
		SmallIconPMenu: TMenuItem;
		ListPMenu: TMenuItem;
		DetailPMenu: TMenuItem;
		ClosePopupMenu: TPopupMenu;
		CloseMenu: TMenuItem;
		U1: TMenuItem;
		N3: TMenuItem;
		B1: TMenuItem;
		S1: TMenuItem;
		N2: TMenuItem;
		A1: TMenuItem;
		L1: TMenuItem;
		N5: TMenuItem;
		S2: TMenuItem;
		ListPopupMenu: TPopupMenu;
		ListRoundPMenu: TMenuItem;
		ListReservPMenu: TMenuItem;
		LPMSep01: TMenuItem;
		ItemRoundPMenu: TMenuItem;
		LPMSep02: TMenuItem;
		KidokuPMenu: TMenuItem;
		MidokuPMenu: TMenuItem;
		AllSelectPMenu: TMenuItem;
		UrlCopyPMenu: TMenuItem;
		LPMSep05: TMenuItem;
		DeletePMenu: TMenuItem;
		LPMSep06: TMenuItem;
		ViewPMenu: TMenuItem;
		LargeIconLPMenu: TMenuItem;
		SmallIconLPMenu: TMenuItem;
		ListLPMenu: TMenuItem;
		DetailLPMenu: TMenuItem;
		T1: TMenuItem;
		B2: TMenuItem;
		N8: TMenuItem;
		URLC1: TMenuItem;
		N9: TMenuItem;
		N10: TMenuItem;
		G2: TMenuItem;
		N11: TMenuItem;
		T3: TMenuItem;
		L2: TMenuItem;
		N12: TMenuItem;
		K1: TMenuItem;
		N13: TMenuItem;
		N14: TMenuItem;
		R1: TMenuItem;
		A2: TMenuItem;
		N15: TMenuItem;
		KokoPopupMenu: TPopupMenu;
		KokomadePMenu: TMenuItem;
		AllPMenu: TMenuItem;
		MenuItem1: TMenuItem;
		MenuItem2: TMenuItem;
		BrowserTabPopupMenu: TPopupMenu;
		Close1: TMenuItem;
		A3: TMenuItem;
		N16: TMenuItem;
		A4: TMenuItem;
		TreePopupMenu: TPopupMenu;
		TreeSelectThreadPupupMenu: TMenuItem;
		TreeSelectBoardPupupMenu: TMenuItem;
		TPMSep01: TMenuItem;
		TreeSelectURLPupupMenu: TMenuItem;
		T2: TMenuItem;
		L3: TMenuItem;
		B3: TMenuItem;
		BrowserBottomPanel: TGikoPanel;
		CabinetSelectPopupMenu: TPopupMenu;
		H2: TMenuItem;
		ItemReservPMenu: TMenuItem;
		RoundNamePopupMenu: TPopupMenu;
		N7: TMenuItem;
		B4: TMenuItem;
		L4: TMenuItem;
		K2: TMenuItem;
		A5: TMenuItem;
		A6: TMenuItem;
		C1: TMenuItem;
		V1: TMenuItem;
		N19: TMenuItem;
		D1: TMenuItem;
		D2: TMenuItem;
		MessageImageList: TImageList;
		ProgressBar: TProgressBar;
		URL1: TMenuItem;
		NameUrlCopyPMenu: TMenuItem;
		URLC2: TMenuItem;
		URLN1: TMenuItem;
		N21: TMenuItem;
		URLC3: TMenuItem;
		URLN2: TMenuItem;
		N23: TMenuItem;
		ListCoolBar: TGikoCoolBar;
		ListToolBar: TToolBar;
		BrowserCoolBar: TGikoCoolBar;
		BrowserToolBar: TToolBar;
		ListNameToolBar: TToolBar;
		ListNameLabel: TLabel;
		FolderImage: TImage;
		BrowserNameToolBar: TToolBar;
		ItemBoardImage: TImage;
		BrowserBoardNameLabel: TLabel;
		ItemImage: TImage;
		BrowserNameLabel: TLabel;
		D3: TMenuItem;
		N25: TMenuItem;
		N26: TMenuItem;
		D4: TMenuItem;
		S3: TMenuItem;
		R2: TMenuItem;
		TreeSelectNameURLPupupMenu: TMenuItem;
		N27: TMenuItem;
		H3: TMenuItem;
		I1: TMenuItem;
		BrowserTabToolBar: TToolBar;
		BrowserTab: TTabControl;
		About1: TMenuItem;
		N28: TMenuItem;
		S4: TMenuItem;
		N29: TMenuItem;
		N30: TMenuItem;
		N31: TMenuItem;
		L5: TMenuItem;
		L6: TMenuItem;
		A7: TMenuItem;
		R3: TMenuItem;
		FavoriteMenu: TMenuItem;
		N32: TMenuItem;
		BoardFavoriteAddMenu: TMenuItem;
		ThreadFavoriteAddMenu: TMenuItem;
		N33: TMenuItem;
		TreeSelectFavoriteAddPupupMenu: TMenuItem;
		FavoriteTreeView: TTreeView;
		StateIconImageList: TImageList;
		TopPanel: TPanel;
		TopRightPanel: TPanel;
		AnimePanel: TPanel;
		Animate: TAnimate;
		TopCoolPanel: TPanel;
		MainCoolBar: TGikoCoolBar;
		MenuToolBar: TToolBar;
		StdToolBar: TToolBar;
		AddressToolBar: TToolBar;
		AddressComboBox: TComboBox;
		MoveToToolButton: TToolButton;
		AddressImageList: TImageList;
		AddressToolBarMenu: TMenuItem;
		T4: TMenuItem;
		Show1: TMenuItem;
		N34: TMenuItem;
		T5: TMenuItem;
		B5: TMenuItem;
		N35: TMenuItem;
		A8: TMenuItem;
		U2: TMenuItem;
		F1: TMenuItem;
		PreviewTimer: TTimer;
		MonazillaWebPageAction1: TMenuItem;
		N36: TMenuItem;
		H4: TMenuItem;
		K3: TMenuItem;
		L7: TMenuItem;
		N37: TMenuItem;
		A9: TMenuItem;
		ChevronPopupMenu: TPopupMenu;
		N2N1: TMenuItem;
		N38: TMenuItem;
		F2: TMenuItem;
		LinkToolBar: TToolBar;
		a10: TMenuItem;
		N39: TMenuItem;
		T6: TMenuItem;
		N40: TMenuItem;
		LinkBarPopupMenu: TPopupMenu;
		T7: TMenuItem;
		ThreadPopupMenu: TPopupMenu;
		MenuItem4: TMenuItem;
		MenuItem5: TMenuItem;
		MenuItem6: TMenuItem;
		T8: TMenuItem;
		URLN3: TMenuItem;
		SelectItemNameCopyAction1: TMenuItem;
		B6: TMenuItem;
		T9: TMenuItem;
    NameCopyPMenu: TMenuItem;
		SelectComboBox: TComboBox;
		MainCoolBarPopupMenu: TPopupMenu;
		StdToolBarVisiblePMenu: TMenuItem;
		AddressToolBarVisiblePMenu: TMenuItem;
		LinkToolBarVisiblePMenu: TMenuItem;
		NG1: TMenuItem;
		NG2: TMenuItem;
		N43: TMenuItem;
		N44: TMenuItem;
		L9: TMenuItem;
		I3: TMenuItem;
		N45: TMenuItem;
		B9: TMenuItem;
		R5: TMenuItem;
		T12: TMenuItem;
		Show3: TMenuItem;
		N46: TMenuItem;
		T13: TMenuItem;
		B10: TMenuItem;
		N47: TMenuItem;
		A12: TMenuItem;
		U4: TMenuItem;
		F4: TMenuItem;
		N48: TMenuItem;
		T14: TMenuItem;
		N50: TMenuItem;
		A11: TMenuItem;
		S5: TMenuItem;
		Reload: TMenuItem;
		GoBack: TMenuItem;
		GoFoward: TMenuItem;
		IndividualAbon1: TMenuItem;
		N41: TMenuItem;
		IndividualAbon2: TMenuItem;
    AntiIndivAbonMenuItem: TMenuItem;
		AntiIndividualAbon: TMenuItem;
		N49: TMenuItem;
		N51: TMenuItem;
		N52: TMenuItem;
		SearchBoardName: TMenuItem;
    TreeSelectLogDeleteSeparator: TMenuItem;
		N54: TMenuItem;
		A13: TMenuItem;
		FavoriteTreePopupMenu: TPopupMenu;
		FavoriteTreeRenamePopupMenu: TMenuItem;
		FavoriteTreeNewFolderPopupMenu: TMenuItem;
		N56: TMenuItem;
		FavoriteTreeDeletePopupMenu: TMenuItem;
		FavoriteToolBar: TToolBar;
    FavoriteAddToolButton: TToolButton;
    FavoriteArrangeToolButton: TToolButton;
		FavoriteTreeBrowseFolderPopupMenu: TMenuItem;
		N57: TMenuItem;
		FavoriteTreeReloadPopupMenu: TMenuItem;
		N58: TMenuItem;
		FavoriteTreeURLCopyPopupMenu: TMenuItem;
		FavoriteTreeNameCopyPopupMenu: TMenuItem;
		FavoriteTreeLogDeletePopupMenu: TMenuItem;
		N59: TMenuItem;
		FavoriteTreeNameURLCopyPopupMenu: TMenuItem;
		N60: TMenuItem;
		ExportFavoriteFileAction1: TMenuItem;
		N6: TMenuItem;
		N17: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
	N24: TMenuItem;
    N62: TMenuItem;
	N61: TMenuItem;
	N63: TMenuItem;
    N64: TMenuItem;
    dummy1: TMenuItem;
	TreeSelectLogDeletePopupMenu: TMenuItem;
	N65: TMenuItem;
    BBSSelectPopupMenu: TPopupMenu;
		PlugInMenu: TMenuItem;
	TreeSelectNamePupupMenu: TMenuItem;
    BrowserPanel: TPanel;
	SelectTimer: TTimer;
    SelectThreadSave: TMenuItem;
    N55: TMenuItem;
    N66: TMenuItem;
    dat1: TMenuItem;
		OpenLogFolder: TMenuItem;
    Browser: TWebBrowser;
    TabSave: TMenuItem;
	TabOpen: TMenuItem;
    ResRangePopupMenu: TPopupMenu;
    ResRangeHundPMenuItem: TMenuItem;
    ResRangeKokoPMenuItem: TMenuItem;
    ResRangeNewPMenuItem: TMenuItem;
    ResRangeAllPMenuItem: TMenuItem;
	BrowsBoradHeadAction1: TMenuItem;
    ThreadRangePopupMenu: TPopupMenu;
    A15: TMenuItem;
    L8: TMenuItem;
	N67: TMenuItem;
    N68: TMenuItem;
    S6: TMenuItem;
    N69: TMenuItem;
    ResRangeSelectPMenuItem: TMenuItem;
    ListColumnPopupMenu: TPopupMenu;
    N70: TMenuItem;
    ID1: TMenuItem;
    ID2: TMenuItem;
    N53: TMenuItem;
    ID3: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    SelectComboBoxPanel: TPanel;
    SelectComboBoxSplitter: TImage;
    N74: TMenuItem;
    WikiFAQ: TMenuItem;
    GikoApplicationEvents: TApplicationEvents;
    N22: TMenuItem;
    N42: TMenuItem;
    DAT2: TMenuItem;
    N75: TMenuItem;
    DAT3: TMenuItem;
    N76: TMenuItem;
    FavoriteTreeItemNameCopyPopupMenu: TMenuItem;
    N77: TMenuItem;
    N78: TMenuItem;
    SaveThreadFile: TMenuItem;
    N79: TMenuItem;
    HTML1: TMenuItem;
    DAT4: TMenuItem;
    N80: TMenuItem;
    SameBoardThreadItem: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    IDNG1: TMenuItem;
    IDNG2: TMenuItem;
    ResPopupClearTimer: TTimer;
    TaskTrayPopupMenu: TPopupMenu;
    Exit1: TMenuItem;
    N83: TMenuItem;
    UpdateGikonaviAction1: TMenuItem;
    N84: TMenuItem;
    N85: TMenuItem;
    URL2: TMenuItem;
    URLPATHINFO1: TMenuItem;
    URLQUERYSTRING1: TMenuItem;
    N86: TMenuItem;
    K4: TMenuItem;
    WikiFAQ1: TMenuItem;
    ThrNGEdit: TMenuItem;
				procedure FormCreate(Sender: TObject);
		procedure FormDestroy(Sender: TObject);
        procedure SaveSettingAll();
		procedure BrowserStatusTextChange(Sender: TObject;
			const Text: WideString);
		procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure TreeViewChanging(Sender: TObject; Node: TTreeNode;
			var AllowChange: Boolean);
		procedure ListViewKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
		procedure ListViewColumnClick(Sender: TObject; Column: TListColumn);
		procedure MenuToolBarCustomDrawButton(Sender: TToolBar;
			Button: TToolButton; State: TCustomDrawState;
			var DefaultDraw: Boolean);
		procedure BrowserBeforeNavigate2(Sender: TObject;
			const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
			Headers: OleVariant; var Cancel: WordBool);
		procedure TreeViewCustomDraw(Sender: TCustomTreeView;
			const ARect: TRect; var DefaultDraw: Boolean);
		procedure TreeViewCustomDrawItem(Sender: TCustomTreeView;
			Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
		procedure TreeViewExpanded(Sender: TObject; Node: TTreeNode);
		procedure ListViewCustomDraw(Sender: TCustomListView;
			const ARect: TRect; var DefaultDraw: Boolean);
		procedure ListViewMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure TreeViewCollapsed(Sender: TObject; Node: TTreeNode);
		procedure MessageListViewResize(Sender: TObject);
		procedure	CabinetVisible( isVisible : Boolean );
		procedure FormResize(Sender: TObject);
		procedure ListPopupMenuPopup(Sender: TObject);
		procedure TreePopupMenuPopup(Sender: TObject);
		procedure BrowserNewWindow2(Sender: TObject; var ppDisp: IDispatch;
			var Cancel: WordBool);
		procedure ListSplitterMoved(Sender: TObject);
		procedure BrowserTabChange(Sender: TObject);
		procedure BrowserTabMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure BrowserTabDragOver(Sender, Source: TObject; X, Y: Integer;
			State: TDragState; var Accept: Boolean);
		procedure BrowserTabDragDrop(Sender, Source: TObject; X, Y: Integer);
		procedure BrowserTabMouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);
		procedure BrowserDocumentComplete(Sender: TObject;
			const pDisp: IDispatch; var URL: OleVariant);
		procedure RoundNamePopupMenuPopup(Sender: TObject);
		procedure FormShow(Sender: TObject);
		procedure BrowserTabToolBarResize(Sender: TObject);
		procedure FavoriteMenuClick(Sender: TObject);
		procedure MainCoolBarResize(Sender: TObject);
		procedure AddressToolBarResize(Sender: TObject);
		procedure AddressComboBoxKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
		procedure BrowserEnter(Sender: TObject);
		procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
		procedure PreviewTimerTimer(Sender: TObject);
		procedure MessageHideButtonClick(Sender: TObject);
		procedure HistoryAllClearToolButtonClick(Sender: TObject);
		procedure MainCoolBarBandInfo(Sender: TObject;
			var BandInfo: PReBarBandInfoA);
		procedure MainCoolBarChevronClick(Sender: TObject;
			RebarChevron: PNMRebarChevron);
		procedure ListCoolBarBandInfo(Sender: TObject;
			var BandInfo: PReBarBandInfoA);
		procedure ListCoolBarChevronClick(Sender: TObject;
			RebarChevron: PNMRebarChevron);
		procedure BrowserCoolBarBandInfo(Sender: TObject;
			var BandInfo: PReBarBandInfoA);
		procedure BrowserCoolBarChevronClick(Sender: TObject;
			RebarChevron: PNMRebarChevron);
		procedure ListViewColumnInfo(Sender: TObject; var Column: PLVColumnA);
		procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
			WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
		procedure SelectComboBoxChange(Sender: TObject);
		procedure SelectComboBoxKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
		procedure SelectComboBoxExit(Sender: TObject);
		procedure SelectComboBoxSplitterMouseMove(Sender: TObject;
			Shift: TShiftState; X, Y: Integer);
		procedure SelectComboBoxSplitterMouseDown(Sender: TObject;
			Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
		procedure SelectComboBoxSplitterMouseUp(Sender: TObject;
			Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
		procedure StatusBarResize(Sender: TObject);
		procedure SelectComboBoxEnter(Sender: TObject);
		procedure FavoriteTreeViewDragDrop(Sender, Source: TObject; X,
			Y: Integer);
		procedure FavoriteTreeViewDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
		procedure FavoriteTreeViewEdited(Sender: TObject; Node: TTreeNode;
			var S: String);
		procedure FavoriteTreeViewKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
		procedure FavoriteTreePopupMenuPopup(Sender: TObject);
		procedure LinkToolBarDragDrop(Sender, Source: TObject; X, Y: Integer);
		procedure BrowserTabMouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure LinkToolBarDragOver(Sender, Source: TObject; X, Y: Integer;
			State: TDragState; var Accept: Boolean);
		procedure FavoriteTreeViewEndDrag(Sender, Target: TObject; X,
			Y: Integer);
		procedure FavoriteTreeBrowseBoardPopupMenuClick(Sender: TObject);
    procedure BrowserTabContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure BrowserTabPopupMenuPopup(Sender: TObject);
    procedure BrowserTabResize(Sender: TObject);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FavoriteTreeViewMouseDown(Sender: TObject;
			Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MessagePanelResize(Sender: TObject);
		procedure OnResized;
	procedure SelectTimerTimer(Sender: TObject);
		procedure ListViewColumnRightClick(Sender: TObject;
      Column: TListColumn; Point: TPoint);
	procedure ListViewCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure BrowserPanelResize(Sender: TObject);
    procedure MenuToolBarResize(Sender: TObject);
    procedure ListToolBarResize(Sender: TObject);
    procedure BrowserToolBarResize(Sender: TObject);
	procedure KokoPopupMenuPopup(Sender: TObject);
	procedure ListViewKeyUp(Sender: TObject; var Key: Word;
	  Shift: TShiftState);
    procedure FavoriteTreeViewEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
	procedure CabinetCloseSpeedButtonClick(Sender: TObject);
    procedure FavoriteArrangeToolButtonClick(Sender: TObject);
    procedure GikoApplicationEventsMessage(var Msg: tagMSG;
	  var Handled: Boolean);
    procedure GikoApplicationEventsDeactivate(Sender: TObject);
    procedure GikoApplicationEventsException(Sender: TObject; E: Exception);
    procedure TreeViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GetResURLMenuClick(Sender: TObject);
    procedure MainCoolBarContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ResPopupClearTimerTimer(Sender: TObject);
	private
		{ Private �錾 }
		FEnabledCloseButton: Boolean;
		FClickNode: TTreeNode;
		FHttpState: Boolean;
		FPreviewBrowser: TPreviewBrowser;
		FPreviewURL: string;
		FBrowserSizeHeight: Integer;
		FBrowserSizeWidth: Integer;
		FTabHintIndex: Integer;
		FListStyle: TViewStyle;				//���X�g�A�C�R���X�^�C��
		FItemNoVisible: Boolean;			//���X�g�ԍ��\���t���O
		FViewType: TGikoViewType;			//���X�g�A�C�e���\���^�C�v
		FActiveList: TObject;
		FActiveContent: TBrowserRecord;	/// 
		FActiveBBS : TBBS;
		FHistoryList: THistoryList;					//�q�X�g�����X�g
		FTreeType: TGikoTreeType;
		FWorkCount: Integer;
		FNameCookie: string;
		FMailCookie: string;
		FDownloadTitle: string;				//�_�E�����[�h���̃^�C�g����
		FDownloadMax: Integer;				//�_�E�����[�h���̍ő�T�C�Y
		FEvent: THTMLDocumentEventSink;//�u���E�U�h�L�������g�C�x���g
		IsDraggingSelectComboBox : Boolean;
		DraggingSelectComboBoxPosition : TPoint;
		FSearchDialog: TSearchDialog;
		FDropSpaceNode: TTreeNode;
		FDragTime : Cardinal;								///< �����N��D&D�p
		FDragButton : TToolButton;					///< �����N��D&D�p��Drag���Ă�Button�ۑ�
		FDragWFirst : Boolean;							///< WebTab��D&D�p
		FListViewBackGroundColor : TColor;	///< ListView��BackGroundColor
		FUseOddResOddColor : Boolean; 			///< �擾���X���ƃX���b�h�̃��X����������Ƃ��ɑ��̐F�ŕ\��
		FOddColor : TColor;					 				///< ���̐F
		FSelectResWord	: string;						///< ���X�i�����[�h
		FIsIgnoreResize	: TResizeType;			///< ���T�C�Y�C�x���g�𖳎����邩�ǂ���
		FIsMinimize			: TMinimizeType;		///< �ŏ������Ă���Œ���
		FOldFormWidth		: Integer;					///< ���O�̃E�B���h�E�̕�
		FToolBarSettingSender : TToolBarSettingSenderType;	///< �c�[���o�[�ݒ���N���b�N�����N�[���o�[
		FMouseDownPos		: TPoint; 					///< �u���E�U�^�u�Ń}�E�X���������Ƃ��̍��W
		FBrowsers: TList;
		FResRangeMenuSelect	: Longint;			///< ResRangeButton �őI������Ă��鍀�� (�t�H�[�}�b�g�� ResRange �݊�)
		FStartUp : Boolean;
		FIsHandledWheel	: Boolean;			///< ���Ɏ󂯎���� WM_MOUSEWHEEL ���ǂ���
				DiffComp: Boolean;                      //Add by Genyakun �X�����X�V���ꂽ�Ƃ���True�ɂȂ�
		FOrigenCaption: String;				//���C�ɓ���c���[�̃A�C�e���ҏW���̕ҏW�O�̕�����
		FPreviewBrowserRect: TRect;			///< �v���r���[�̕\���ʒu���L������
		FActionListGroupIndexes: array of Integer;	///<GikoDM��̃A�N�V�������X�g�̊e�A�N�V�����ɐݒ肳�ꂽGroupIndex��ۑ�����z��
        FResPopupBrowser: TResPopupBrowser;
        FUpdateExePath: string;    ///�M�R�i�r�X�V�C���X�g�[���p�X
        FUpdateExeArgs: string;    ///�M�R�i�r�X�V�C���X�g�[������
        FKokoPopupThreadItem: TThreadItem;
        FCwSave: Word;  // 8087CW�l�ۑ�
		procedure DownloadEnd(Sender: TObject; Item: TDownloadItem);
		procedure DownloadMsg(Sender: TObject; Item: TDownloadItem; Msg: string; Icon: TGikoMessageIcon);
		procedure WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer; Number: Integer; const AWorkTitle: string);
		procedure WorkEnd(Sender: TObject; AWorkMode: TWorkMode; Number: Integer);
		procedure Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer; Number: Integer);
		procedure ListClick;
		procedure ListDoubleClick(Shift: TShiftState);
		function Hook(var Message: TMessage): Boolean;
		procedure AddRoundNameMenu(MenuItem: TMenuItem);
		procedure SetMenuFont;
		procedure CreateFavMenu(Node: TTreeNode; MenuItem: TMenuItem);
		procedure FavoriteClick(Sender: TObject; ActiveTab: Boolean); overload;
		procedure FavoriteClick(Sender: TObject); overload;
		procedure FavoriteDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
		function OnDocumentContextMenu(Sender: TObject): WordBool;
		function GetWidthAllToolButton(ToolBar: TToolBar): Integer;
		procedure MenuBarChevronMenu;
		procedure LinkBarChevronMenu;
		procedure ToolBarChevronMenu(ToolBar: TToolBar);
		procedure LinkToolButtonDragDrop(Sender, Source: TObject; X, Y: Integer);
		procedure LinkToolButtonOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
		procedure LinkToolButtonOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
		procedure LinkToolButtonOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
		procedure LinkToolButtonStartDrag(Sender: TObject; var DragObject: TDragObject);
		function TreeNodeDataFind(Node: TTreeNode; FindPointer: Pointer): TTreeNode;
		procedure FavoriteMoveTo( SenderNode, SourceNode: TTreeNode );
		procedure FavoriteAddTo( SenderNode: TTreeNode; Source: TObject );
		procedure FavoriteDragDrop( SenderNode: TTreeNode; Source: TObject );
		/// 
		procedure SetListViewBackGroundColor(value: TColor);
		procedure BBSMenuItemOnClick( Sender : TObject );
		/// CoolBar �̐ݒ��ϐ��ɕۑ�
		procedure	SaveCoolBarSettings;
		procedure	SaveMainCoolBarSettings;
		procedure	SaveBoardCoolBarSettings;
		procedure	SaveBrowserCoolBarSettings;
		/// CoolBar �̐ݒ��ϐ����畜��
		procedure	LoadCoolBarSettings;
		/// �ŏ��������
		procedure OnMinimize;
		/// �ŏ������ꂽ
		procedure OnMinimized;
		/// TreeView ���N���b�N���ꂽ
		procedure TreeClick( Node : TTreeNode );
		/// TreeView ���_�u���N���b�N���ꂽ
		procedure TreeDoubleClick( Node : TTreeNode );
		/// �e���ɂ���L���r�l�b�g�E BBS ���j���[���Z�b�g�^�X�V
		procedure SetBBSMenu;
		/// ListColumnPopupMenu �A�C�e���̃N���b�N�C�x���g
		procedure	ListColumnPopupMenuOnClick( Sender : TObject );
		//! �i�荞�ݕ�����ݒ�
		procedure SetSelectWord( const text : string );
		//���݂̃J�[�\�����擾����
		function GetScreenCursor(): TCursor;
		//�J�[�\����ݒ肷��
		procedure SetScreenCursor(Cursor : TCursor);
		//! �_�E�����[�h�R���g���[���X���b�h�̐���
		procedure CreateControlThread();
		//! �u���E�U�̐���
		procedure CreateBrowsers(count: Integer);
		//! ActionList��GroupIndex�̕ۑ�
		procedure GetGroupIndex(ActionList: TActionList);
		//! ActionList��GroupIndex�̐ݒ�
		procedure SetGroupIndex(ActionList: TActionList);
		//! �w�肳�ꂽ�X���b�h���J��(���O�������Ƃ� or �w��JUMP�܂ő���Ȃ��Ƃ���DL����)
		procedure OpenThreadItem(Thread: TThreadItem; URL: String);
		//! ListView�i�X���b�h�ꗗ�j���X�V����
		procedure RefreshListView(Thread: TThreadItem);
		//! �X���b�h�ꗗ�̕\���͈͐ݒ�`�F�b�N�N���A
		procedure ClearThreadRengeAction;
        //! �^�X�N�g���C�̃A�C�R���폜���t�H�[���\��
        procedure UnStoredTaskTray;
        //! ���X�G�f�B�^�̕\����\��
        procedure ShowEditors(nCmdShow: Integer);
        //! �����Ƃ��Â�Browser�̊J��
        procedure ReleaseOldestBrowser;
        //! �A�N�e�B�u�ȃ^�u�Ɠ����̊J���Ă���X���b�h�����j���[�A�C�e���ɒǉ�
        procedure AddMenuSameBoardThread(MenuItem: TMenuItem);
        //!  �A�N�e�B�u�ȃ^�u�Ɠ����̊J���Ă���X���b�h�N���b�N�C�x���g
        procedure SameBoardThreadSubItemOnClick(Sender: TObject);
        //! �|�b�v�A�b�v�u���E�U�쐬
        procedure CreateResPopupBrowser;
        //! �t�@�C���`�F�b�N
        function isValidFile(FileName: String) : boolean;
        //! ListView��D&D�󂯎��
        procedure AcceptDropFiles(var Msg: TMsg);
        //! �X���b�h�ꗗ�X�V����
        procedure UpdateListView();
        //! �A�C�R���ǂݍ���
        procedure LoadIcon();
        //! �|�b�v�A�b�v���j���[�ǂݍ���
        procedure LoadPopupMenu();
	protected
		procedure CreateParams(var Params: TCreateParams); override;
		procedure WndProc(var Message: TMessage); override;
		procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
		procedure WMSettingChange(var Message: TWMWinIniChange); message WM_SETTINGCHANGE;
		procedure WMCopyData(var Message: TWMCopyData); message WM_COPYDATA;
	public
		{ Public �錾 }
		LastRoundTime: TDateTime;
		BrowserNullTab: TBrowserRecord;
		FControlThread: TThreadControl;
        FIconData : TNotifyIconData;
		procedure MoveToURL(const inURL: string; KeyMask: Boolean = False);
		function InsertBrowserTab(ThreadItem: TThreadItem; ActiveTab: Boolean = True) : TBrowserRecord;
		procedure ReloadBBS;
		function GetHttpState: Boolean;
		procedure SetEnabledCloseButton(Enabled: Boolean);
		function GetTreeNode(Data: TObject): TTreeNode;
		procedure ListViewAllSelect;
		property ListStyle: TViewStyle read FListStyle write FListStyle;
		property ItemNoVisible: Boolean read FItemNoVisible write FItemNoVisible;
		property ViewType: TGikoViewType read FViewType write FViewType;
		property NameCookie: string read FNameCookie write FNameCookie;
		property MailCookie: string read FMailCookie write FMailCookie;
		property ClickNode: TTreeNode read FClickNode write FClickNode;
		property TreeType: TGikoTreeType read FTreeType write FTreeType;
		property ActiveContent: TBrowserRecord read FActiveContent write FActiveContent;
		property ResRangeMenuSelect: Longint read FResRangeMenuSelect write FResRangeMenuSelect;
		property SelectResWord	: string read FSelectResWord write FSelectResWord;
		property BrowserSizeWidth: Integer read FBrowserSizeWidth write FBrowserSizeWidth;
		property BrowserSizeHeight: Integer read FBrowserSizeHeight write FBrowserSizeHeight;
		property SearchDialog: TSearchDialog read FSearchDialog write FSearchDialog;
		property ToolBarSettingSender : TToolBarSettingSenderType
						 read FToolBarSettingSender write FToolBarSettingSender;
		property ScreenCursor : TCursor read GetScreenCursor write SetScreenCursor;
		property ActiveBBS : TBBS read FActiveBBS write FActiveBBS;
		property WorkCount: Integer read FWorkCount write FWorkCount;
        property UpdateExePath: string read FUpdateExePath write FUpdateExePath;
        property UpdateExeArgs: string read FUpdateExeArgs write FUpdateExeArgs;

		procedure SetContent(inThread: TBrowserRecord);
		function GetActiveContent(popup :Boolean = false): TThreadItem;
		function GetActiveList: TObject;

		procedure SetListViewType(AViewType: TGikoViewType); overload;
		procedure SetListViewType(AViewType: TGikoViewType; SelectText: string; KubetsuChk: Boolean); overload;
		procedure PlaySound(SoundEventName: string);
		procedure ShowBBSTree( inBBS : TBBS );
		procedure ShowBBSTreeOld( inBBS : TBBS );
		procedure ShowHistoryTree;
		procedure AddMessageList(ACaption: string; AObject: TObject; Icon: TGikoMessageIcon);
		procedure SetBrowserTabState;
		procedure SetToolBarPopup;
		procedure ShowFavoriteAddDialog( Item : TObject );
		procedure FavoritesURLReplace(oldURLs: TStringList; newURLs: TStringList);
		procedure RoundListURLReplace(oldURLs: TStringList; newURLs: TStringList);
		property ListViewBackGroundColor: TColor read FListViewBackGroundColor write SetListViewBackGroundColor;
		property UseOddResOddColor : Boolean read FUseOddResOddColor write FUseOddResOddColor;
		property OddColor : TColor read FOddColor write FOddColor;
        //! ���X���j���[�A�N�e�B�u�X���b�h�A�C�e��
        property KokoPopupThreadItem : TThreadItem read FKokoPopupThreadItem;

		function FindToolBarButton( bar : TToolBar; action : TAction ) : TToolButton;
		procedure OnPlugInMenuItem( Sender : TObject );
		procedure TabFileURLReplace(oldURLs: TStringList; newURLs: TStringList);
		/// ListView �̃J����������шʒu�̕ۑ� KuroutSetting�����т��������̂�
		procedure ActiveListColumnSave;
		procedure SetActiveList(Obj: TObject);
		property ActiveList: TObject read GetActiveList write SetActiveList;
		/// CoolBar ���T�C�Y�ύX���ꂽ
		procedure	CoolBarResized(Sender: TObject; CoolBar: TCoolBar);
		//����ID�̂��ځ`��
		procedure IndividualAbonID(Atype : Integer);
		//���̃��X���ځ`��
		procedure IndividualAbon(Atag, Atype : Integer);
        //����ID��NG���[�h�ɓo�^
        procedure AddIDtoNGWord(invisible : boolean);
		//�u���E�U�̍ĕ`�� true:�S�Ẵ^�u false:�A�N�e�B�u�ȃ^�u�̂�
		procedure RepaintAllTabsBrowser();
		//�����N�o�[�ݒ�
		procedure SetLinkBar;
		procedure FavoriteBrowseFolder( node: TTreeNode );
		//�X���b�h�̃_�E�����[�h
		procedure DownloadContent(ThreadItem: TThreadItem; ForceDownload: Boolean = False);
		//�̃_�E�����[�h
		procedure DownloadList(Board: TBoard; ForceDownload: Boolean = False);
		//��������폜
		procedure DeleteHistory( threadItem: TThreadItem );
		//�^�u���폜 �X���b�h�w��
		procedure DeleteTab(ThreadItem: TThreadItem); overload;
		//�^�u���폜 �u���E�U���R�[�h�i�^�u�j�w��
		procedure DeleteTab(BrowserRecord: TBrowserRecord); overload;
        // �^�u�폜�i�������j
        procedure DeleteTab(index, selectIndex: Integer); overload;
		//���ݕ\�����Ă���X���b�h���X�N���[��
		procedure BrowserMovement(const AName: string); overload;
		//���ݕ\�����Ă���X���b�h���X�N���[��
		procedure BrowserMovement(scroll: Integer); overload;
		//Application��MainForm���擾����
		function GetMainForm(): TComponent;
		procedure SelectTreeNode(Item: TObject; CallEvent: Boolean);
		//! �}�E�X�W�F�X�`���[�J�n
		procedure OnGestureStart(Sender: TObject);
		//! �}�E�X�W�F�X�`���[��
		procedure OnGestureMove(Sender: TObject);
		//! �}�E�X�W�F�X�`���[�I��
		procedure OnGestureEnd(Sender: TObject);
		/// �o���h�����Čv�Z�E�Đݒ肷��
		procedure ResetBandInfo( bar : TGikoCoolBar; band : TToolBar );
		//ListView�őI������Ă���A�C�e�����擾����
		procedure SelectListItem(List: TList);
		//�w�肵�����X���R�s�[����
		procedure KonoresCopy(Number: Integer; ReplaceTag : Boolean);
		///
		procedure ModifySelectList;
		///
		procedure SetSelectItemRound(RoundFlag: Boolean; RoundName: string); overload;
		///
		procedure SetSelectItemRound(RoundFlag: Boolean; RoundName: string; ParentName: string); overload;
		///
		procedure SetSelectRoundName(Sender: TObject);
		///
		function GetCoolBand(CoolBar: TCoolBar; Control: TWinControl): TCoolBand;
		///
		function WebBrowserClick(Sender: TObject): WordBool;
		//! �c�[���o�[�ɃX���i���݃R���{�{�b�N�X��ݒ肷��
		procedure SetSelectComboBox();

        //! �^�X�N�g���C�Ɋi�[�����A�C�R�����N���b�N�����Ƃ��̏���
        procedure TaskTrayIconMessage(var Msg : TMsg); message WM_USER + 2010;
        //! �^�X�N�g���C�ɃA�C�R���o�^���t�H�[���B��
        procedure StoredTaskTray;
        //! ��ID���X�A���J�[�\��
        procedure ShowSameIDAncher(const AID: String);
        //! �X���^�C�\���X�V
        procedure UpdateThreadTitle;
	published
		property EnabledCloseButton: Boolean read FEnabledCloseButton write SetEnabledCloseButton;
	end;

	TFavoriteMenuItem = class(TMenuItem)
	private
		FData : Pointer;
	public
		property Data: Pointer read FData write FData;
	end;

	TBBSMenuItem = class(TMenuItem)
	private
		FData : Pointer;
	public
		property Data: Pointer read FData write FData;
	end;

	TLinkToolButton = class(TToolButton)
	private
		FData : Pointer;
	public
		property Data: Pointer read FData write FData;
	end;

var
	GikoForm: TGikoForm;
    g_AppTerminated: Boolean = False;

implementation

uses
	GikoUtil, IndividualAbon, Math, Kotehan, KeySetting,
	YofUtils, ToolBarUtil, ToolBarSetting,
	GikoXMLDoc, RoundName, IniFiles, FavoriteAdd,
	FavoriteArrange, AddressHistory, Gesture,
	About, Option, Round, Splash, Sort, ListSelect, Imm,
	NewBoard, MojuUtils, Clipbrd, GikoBayesian,Y_TextConverter,
	HTMLCreate, ListViewUtils, GikoDataModule, GikoMessage,
  InputAssistDataModule, Types, ReplaceDataModule, PopupMenuUtil;

const
	BLANK_HTML: string = 'about:blank';
	BROWSER_COUNT		= 5;	//�u���E�U�̐�
	//D&D臒l
	DandD_THRESHOLD	= 5;	//D&D��臒l�ipixcel)
	//�v���r���[�t�@�C����
	HTML_FILE_NAME 	= 'temp_preview.html';
	//���b�Z�[�WID
	USER_TREECLICK					= WM_USER + 2000;
	USER_RESIZED            = WM_USER + 2001;
	USER_MINIMIZED					= WM_USER + 2002;
	USER_SETLINKBAR					= WM_USER + 2003;
	USER_DOCUMENTCOMPLETE		= WM_USER + 2004;	///< wParam : TWebBrowser
    USER_TASKTRAY               = WM_USER + 2010;
{$R *.DFM}

procedure TGikoForm.CreateParams(var Params: TCreateParams);
begin
	inherited;
	if FormStyle in [fsNormal, fsStayOnTop] then begin
		if BorderStyle in [bsSingle, bsSizeable] then begin
			Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
			Params.WndParent := 0;
		end;
	end;
end;

procedure TGikoForm.FormCreate(Sender: TObject);
const
	TVS_NOTOOLTIPS = $0080;
var
	FileName: string;
	Style: DWORD;
	msg: string;
	i: Integer;
	wp: TWindowPlacement;
begin
{$IFDEF DEBUG}
	AllocConsole;
	Writeln('============================================================');
	Writeln(' �M�R�i�r�f�o�b�O �R���\�[��');
	Writeln('');
	Writeln(' ���̉�ʂ���Ȃ��ł��������B');
	Writeln(' �I�����́A�M�R�i�r�E�B���h�E����Ă�������');
	Writeln('============================================================');
{$ENDIF}
//try
    // �[������O�̌��݂̐ݒ��ۑ�����
    FCwSave := Get8087CW;
    if ( AnsiPos('9.0', GikoSys.GetIEVersion()) = 1 ) then begin
        // IE 9�̏ꍇ�����A�����r�b�g�𗧂Ă�
        Set8087CW(FCwSave or $0004);
    end;
	Sort.SetSortDate(Now());

	FTreeType := gttNone;
	// �N�����ɕۑ�����Ă��܂��΍�
	FStartUp := true;
	Application.HookMainWindow(Hook);
	FIsIgnoreResize := rtResizing;
	//ActionList��GuoupIndex��ۑ����āA0�ɃN���A����B
	//(�N�����Ƀc�[���{�^����Down�v���p�e�B�𔽉f������s����GroupIndex�͐ݒ�ł��Ȃ�)
	//����Ȍ�Set�`�ōĐݒ肷��܂ŁAAction��Checked��������Ƃ��͒��ӁI
	GetGroupIndex(GikoDM.GikoFormActionList);
	FSearchDialog := nil;
    FResPopupBrowser := nil;
	CreateBrowsers(BROWSER_COUNT);
    FIconData.uID := 0;
    FUpdateExePath := '';
    FUpdateExeArgs := '';

	//���j���[�t�H���g
	SetMenuFont;

	//��̃J�[�\��
	Screen.Cursors[5] := LoadCursor(HInstance, 'GIKOHAND');

    // �A�C�R���̓ǂݎ��
    LoadIcon;

	//�A�h���X����ǂݍ���
	AddressHistoryDM.ReadHistory(AddressComboBox.Items, GikoSys.Setting.MaxRecordCount);

	EnabledCloseButton := True;

	//���X�g�X�^�C��
	ListView.ViewStyle := GikoSys.Setting.ListStyle;

	//�A�j���p�l���ʒu
	AnimePanel.Top := 0;
	AnimePanel.Left := 0;

	//�e�����ԂȂǐݒ�

	//�L���r�l�b�g
	CabinetPanel.Width := GikoSys.Setting.CabinetWidth;

	//���b�Z�[�W�o�[
	GikoDM.MsgBarVisibleAction.Checked := GikoSys.Setting.MessageBarVisible;
	GikoDM.MsgBarVisibleActionExecute(nil);
	MessagePanel.Height := GikoSys.Setting.MessegeBarHeight;

	//�X�e�[�^�X�o�[
	GikoDM.StatusBarVisibleAction.Checked := GikoSys.Setting.StatusBarVisible;
	GikoDM.StatusBarVisibleActionExecute(nil);

	//�t�H���g�E�F�ݒ�
	TreeView.Items.BeginUpdate;
	FavoriteTreeView.Items.BeginUpdate;
	ListView.Items.BeginUpdate;
	try
		TreeView.Font.Name := GikoSys.Setting.CabinetFontName;
		TreeView.Font.Size := GikoSys.Setting.CabinetFontSize;
		TreeView.Font.Color := GikoSys.Setting.CabinetFontColor;
		TreeView.Color := GikoSys.Setting.CabinetBackColor;
		FavoriteTreeView.Font.Assign(TreeView.Font);
		FavoriteTreeView.Color := GikoSys.Setting.CabinetBackColor;

		ListView.Font.Name := GikoSys.Setting.ListFontName;
		ListView.Font.Size := GikoSys.Setting.ListFontSize;
		ListView.Font.Color := GikoSys.Setting.ListFontColor;
		ListView.Font.Style := [];
		if GikoSys.Setting.ListFontBold then
			ListView.Font.Style := [fsbold];
		if GikoSys.Setting.ListFontItalic then
			ListView.Font.Style := ListView.Font.Style + [fsitalic];

		ListViewBackGroundColor := clWhite;												// �f�t�H���g�ɐݒ肵���̂�
		ListViewBackGroundColor := GikoSys.Setting.ListBackColor;	// ���[�U��`�ɕύX
		FUseOddResOddColor := GikoSys.Setting.UseOddColorOddResNum;
		FOddColor := GikoSys.Setting.OddColor;

	finally
		TreeView.Items.EndUpdate;
		FavoriteTreeView.Items.EndUpdate;
		ListView.Items.EndUpdate;
	end;
	//ViewNoButton.Down := GikoSys.Setting.ListViewNo;
	GikoDM.ListNumberVisibleAction.Checked := GikoSys.Setting.ListViewNo;

	//�~���[�g�̏�Ԃ�ݒ�
	GikoDM.MuteAction.Checked := GikoSys.Setting.Mute;

	// ���X�\���͈�
	FResRangeMenuSelect := GikoSys.ResRange;
	case GikoSys.ResRange of
	Ord( grrAll ):
		begin
			GikoDM.AllResAction.Execute;
		end;
	Ord( grrSelect ):
		begin
			SelectComboBox.Text := SelectComboBox.Items[ 1 ];
			GikoDM.SelectResAction.Checked := True;
		end;
	else
		case FResRangeMenuSelect of
		Ord( grrKoko ):	GikoDM.OnlyKokoResAction.Checked	:= True;
		Ord( grrNew ):	GikoDM.OnlyNewResAction.Checked	:= True;
		10..65535:
            begin
                GikoDM.OnlyAHundredResAction.Checked		:= True;
                GikoSys.ResRange := GikoSys.Setting.ResRangeExCount;
            end;
		end;
	end;

	// �X���b�h�ꗗ�\���͈�
	case GikoSys.Setting.ThreadRange of
	gtrAll:
		begin
			GikoDM.AllItemAction.Checked := True;
			ViewType := gvtAll;
		end;
	gtrLog:
		begin
			GikoDM.LogItemAction.Checked := True;
			ViewType := gvtLog;
		end;
	gtrNew:
		begin
			GikoDM.NewItemAction.Checked := True;
			ViewType := gvtNew;
		end;
	gtrLive:
		begin
			GikoDM.LiveItemAction.Checked := True;
			ViewType := gvtLive;
		end;
	gtrArch:
		begin
			GikoDM.ArchiveItemAction.Checked := True;
			ViewType := gvtArch;
		end;
	end;


	//�u���E�U�^�u�t�H���g
	BrowserTab.Font.Name := GikoSys.Setting.BrowserTabFontName;
	BrowserTab.Font.Size := GikoSys.Setting.BrowserTabFontSize;
	BrowserTab.Font.Style := [];
	if GikoSys.Setting.BrowserTabFontBold then
		BrowserTab.Font.Style := [fsBold];
	if GikoSys.Setting.BrowserTabFontItalic then
		BrowserTab.Font.Style := GikoForm.BrowserTab.Font.Style + [fsItalic];

	BrowserTab.DoubleBuffered := True;
	FDragWFirst := false;
	SetContent(BrowserNullTab);													//�u���E�U���󔒕\��

	//�u���E�U�^�u
	GikoDM.BrowserTabVisibleAction.Checked := GikoSys.Setting.BrowserTabVisible;

	if GikoSys.Setting.BrowserTabPosition = gtpTop then begin
		GikoDM.BrowserTabTopAction.Checked := True;
	end else begin
		GikoDM.BrowserTabBottomAction.Checked := True;
	end;

	if GikoSys.Setting.BrowserTabStyle = gtsTab then begin
		GikoDM.BrowserTabTabStyleAction.Checked := True;
	end else if GikoSys.Setting.BrowserTabStyle = gtsButton then begin
		GikoDM.BrowserTabButtonStyleAction.Checked := True;
	end else begin
		GikoDM.BrowserTabFlatStyleAction.Checked := True;
	end;

	//�v���O���X�o�[�̏�����
	ProgressBar.Parent := StatusBar;
	ProgressBar.Top := 2;
	ProgressBar.Left := 0;
	ProgressBar.Width := StatusBar.Panels[0].Width;
	ProgressBar.Height := StatusBar.Height - 2;
	ProgressBar.Position := 0;

    // �X���b�h��NG���X�g
    ThreadNgList := TThreadNgList.Create;

	// �O���v���O�C�������[�h(ReadBoardFile, LoadHistory ����ɍs������)
	InitializeBoardPlugIns;

	// �{�[�h�t�@�C����(ReadFavorite ����ɍs������)
	GikoSys.ListBoardFile;
	//�@�A���N�����ɃX�v���b�V���E�B���h�E�̃��������s���
	try
	// �X�v���b�V���E�B���h�E�̃v���O���X�o�[�̐ݒ�
		if (SplashWindow <> nil) then begin
			SplashWindow.ProgressBar.Max := Length(BBSs) * 20;
		end;
	except
	end;
	// ���ׂĂ�BBS��ǂݍ���ł���
	for i := Length(BBSs) - 1 downto 0 do begin
		if not BBSs[i].IsBoardFileRead then
			GikoSys.ReadBoardFile(BBSs[i]);

		if SplashWindow <> nil then begin
			SplashWindow.ProgressBar.StepBy(20);
			SplashWindow.Update;
		end;
	end;

	//����f�[�^�ǂݍ���
	RoundList := TRoundList.Create;
	RoundList.LoadRoundBoardFile;
	RoundList.LoadRoundThreadFile;

	//TreeView�̎ז��L��ToolTip���\��
	Style := GetWindowLong(TreeView.Handle, GWL_STYLE);
	Style := Style or TVS_NOTOOLTIPS;
	SetWindowLong(TreeView.Handle, GWL_STYLE, Style);

	// �c���[�����C�������\���ɂ��čő剻
	TreeView.Align := alClient;
	FavoriteTreeView.Align := alClient;
	FavoriteTreeView.Visible := False;

	// ���j���[�ɒǉ�
	SetBBSMenu;

	//�ő剻�E�E�B���h�E�ʒu����
	wp.length := sizeof(wp);
	wp.rcNormalPosition.Top := GikoSys.Setting.WindowTop;
	wp.rcNormalPosition.Left := GikoSys.Setting.WindowLeft;
	wp.rcNormalPosition.Bottom := GikoSys.Setting.WindowTop + GikoSys.Setting.WindowHeight;
	wp.rcNormalPosition.Right := GikoSys.Setting.WindowLeft + GikoSys.Setting.WindowWidth;
	wp.showCmd := SW_HIDE;
	SetWindowPlacement(Handle, @wp);
	//Self.Update;

	if GikoSys.Setting.WindowMax then
		WindowState := wsMaximized;

	//�M�R�A�j��
	try
		FileName := GikoSys.GetAppDir + 'gikoNavi.avi';
		if FileExists(FileName) then
			Animate.FileName := FileName;
	except
	end;

	//�N�b�L�[
	FNameCookie := '';
	FMailCookie := '';

	//�u���E�U�T�C�Y�ύX�̏�����
	FBrowserSizeHeight := GikoSys.Setting.ListHeight;
	FBrowserSizeWidth := GikoSys.Setting.ListWidth;


	// �q�X�g�����X�g(LoadHistory ������ɍs������)
	FHistoryList := THistoryList.Create;

	// ����ǂݍ���
	FHistoryList.LoadFromFile(GikoSys.GetConfigDir + 'History.xml',
        TreeView, FTreeType);

	//���C�ɓ���ǂݍ���
	FavoriteDM.SetFavTreeView(FavoriteTreeView);
	FavoriteDM.ReadFavorite;

	GikoDM.ArrangeAction.Checked := not (GikoSys.Setting.ListOrientation = gloVertical);
	GikoDM.ArrangeAction.Execute;

	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		case GikoSys.Setting.ListWidthState of
			glsMax: begin
				ViewPanel.Width := 1;
				GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_NORMAL;
				GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_MIN;
			end;
			glsMin: begin
				ViewPanel.Width := GikoSys.Setting.ListWidth;
				GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_MAX;
				GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_NORMAL;
			end;
			else begin
				ViewPanel.Width := GikoSys.Setting.ListWidth;
				GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_MAX;
				GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_MIN;
			end;
		end;
	end else begin
		case GikoSys.Setting.ListHeightState of
			glsMax: begin
				ViewPanel.Height := 1;
				GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_NORMAL;
				GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_MIN;
			end;
			glsMin: begin
				ViewPanel.Height := GikoSys.Setting.ListHeight;
				GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_MAX;
				GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_NORMAL;
			end;
			else begin
				ViewPanel.Height := GikoSys.Setting.ListHeight;
				GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_MAX;
				GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_MIN;
			end;
		end;
	end;

	//�_�E�����[�h�I�u�W�F�N�g
	CreateControlThread();

  // �c�[���o�[�̏������̉e���H�ŃR���{�{�b�N�X�������������(�H)���ߍŌ�̕��ֈړ� for D2007
	//// �i����������
	//SelectComboBox.Items.Assign( GikoSys.Setting.SelectTextList );

	//�u���E�U�^�u�ݒ�
	SetBrowserTabState;

	BrowserBoardNameLabel.Caption := '';
	BrowserNameLabel.Caption := '';
	FWorkCount := 0;

	FTabHintIndex := -1;

	//�c�[���o�[Wrapable
	ListToolBar.Wrapable := GikoSys.Setting.ListToolBarWrapable;
	BrowserToolBar.Wrapable := GikoSys.Setting.BrowserToolBarWrapable;

	MakeDefaultINIFile();
	//�c�[���{�^���ǂݍ���
	ReadToolBarSetting(GikoDM.GikoFormActionList, StdToolBar);
	ReadToolBarSetting(GikoDM.GikoFormActionList, ListToolBar);
	ReadToolBarSetting(GikoDM.GikoFormActionList, BrowserToolBar);
	SetToolBarPopup;

	//ListToolBar�ɂ��邩������Ȃ��i����ComboBox��z�u
	SetSelectComboBox();

	//�A�h���X�o�[
	AddressComboBox.TabStop := GikoSys.Setting.AddressBarTabStop;

	//�����N�o�[
	SetLinkBar;
	//�N�[���o�[������FormShow�Ɉړ�����

	//�{�[�h�t�@�C���������ꍇ�̓��b�Z�[�W�\��
	if not FileExists(GikoSys.GetBoardFileName) then begin
		msg := '���̃��b�Z�[�W�̓M�R�i�r�����߂Ďg�p����Ƃ��ɂP�񂾂��\������܂�' + #13#10#13#10
				 + '���ꂩ��A�u�Q�����˂�v�̃A�h���X�ꗗ���_�E�����[�h���܂�' + #13#10
				 + '���ɏo�Ă����ʂŁA�u�X�V�v�{�^���������Ă��������B';
		MsgBox(SplashWindow.Handle, msg, '�M�R�i�r', MB_OK or MB_ICONINFORMATION);
		GikoDM.NewBoardAction.Execute;
	end;

	//�L�[�ݒ�ǂݍ���
	GikoSys.LoadKeySetting(GikoDM.GikoFormActionList, GikoSys.GetMainKeyFileName);

	//�ŏI���񎞊�
//	FLastRoundTime := 0;

	ListView.OnData := TListViewUtils.ListViewData;

	// �Ō�ɑI�����ꂽ�L���r�l�b�g�̕���
	CabinetVisible( False );
	if GikoSys.Setting.CabinetVisible then begin
		i := CabinetSelectPopupMenu.Items.Count - 1;
		if GikoSys.Setting.CabinetIndex = i - 1 then
			GikoDM.CabinetHistoryAction.Execute
		else if GikoSys.Setting.CabinetIndex = i then
			GikoDM.CabinetFavoriteAction.Execute
		else begin
			if GikoSys.Setting.CabinetIndex < Length( BBSs ) then
				ShowBBSTree( BBSs[ GikoSys.Setting.CabinetIndex ] );
			// �N�����ɕۑ�����Ă��܂��΍� 2
			FIsIgnoreResize := rtResizing;
			GikoDM.CabinetBBSAction.Execute;
		end;
	end else begin
		ShowBBSTreeOld( BBSs[ 0 ] );
		PostMessage( Handle, USER_TREECLICK, 0, 0 );
	end;

	//��������������X�����J���i���擾�Ȃ�_�E�����[�h�j
	for i := 1 to ParamCount do	begin
		MoveToURL(ParamStr(i));
	end;

	GikoDM.RepaintStatusBar;
	StatusBarResize(Sender);

//	dummy1.Caption	:= ItemReservPMenu.Caption;
//	dummy1.Hint     := ItemReservPMenu.Hint;
    // �u���E�U�|�b�v�A�b�v���j���[�̏�����
    PopupMenuUtil.ReadSetting(GikoDM.GikoFormActionList, BrowserTabPopupMenu);
    // �}�E�X�W�F�X�`���[
    MouseGesture := TMouseGesture.Create;

{$IFDEF SPAM_FILTER_ENABLED}
	// �X�p���t�B���^�w�K����
	GikoSys.Bayesian.LoadFromFile( GikoSys.Setting.GetSpamFilterFileName );
{$ENDIF}

	//2ch����ǂݏo��
	GikoSys.SetGikoMessage;

	//�I�[�g���O�C��
	if GikoSys.Setting.AutoLogin then
		GikoDM.LoginAction.Execute;

    if GikoSys.Setting.BeAutoLogin then
        GikoDM.BeLogInOutAction.Execute;

	//�L���v�V�������㏑������Ă��܂��̂ŁA�����ōĐݒ�
	FavoriteAddToolButton.Caption := '�ǉ�...';
	AntiIndivAbonMenuItem.Caption := '�ʂ��ځ`�����';

	//���̓A�V�X�g�@�\�̏�����
	InputAssistDM.Init(GikoSys.GetInputAssistFileName);

    //�u���ݒ�t�@�C���̓ǂݍ���
    ReplaceDM.LoadFromFile(GikoSys.GetReplaceFileName);

    //���X�|�b�v�A�b�v�����^�C�}�[
    ResPopupClearTimer.Interval := GikoSys.Setting.RespopupWait;

    // D&D���󂯎��
    DragAcceptFiles(ListView.Handle, True);

  // �c�[���o�[�̏������̉e���H�ŃR���{�{�b�N�X�������������(�H)���ߏォ�炱���ֈړ� for D2007
	// �i����������
	SelectComboBox.Items.Assign( GikoSys.Setting.SelectTextList );

    // �������Ɏ��s�������W���[���`�F�b�N
    if (FavoriteDM.AbEnd) then begin
        GikoUtil.MsgBox(Self.Handle,
            '���C�ɓ���̏������Ɏ��s���܂����B�M�R�i�r���I�����܂��B'#13#10 +
            '�M�R�i�r�t�H���_���J���܂��Aconfig/' + Favorite.FAVORITE_FILE_NAME +
            ' �� config/~' + Favorite.FAVORITE_FILE_NAME + '(�O��N�����̂��C�ɓ���)��'#13#10 +
             '�u�������鎖�Œ���\��������܂��B',
            '�������ُ�');
        GikoDM.GikoFolderOpenAction.Execute;
        Self.Close;
    end;

end;

// CoolBar �̐ݒ��ϐ��ɕۑ�
procedure TGikoForm.SaveCoolBarSettings;
begin

	if IsIconic( Handle ) or (FIsIgnoreResize <> rtNone) then
		Exit;
	SaveMainCoolBarSettings;
	SaveBoardCoolBarSettings;
	SaveBrowserCoolBarSettings;

end;
procedure TGikoForm.SaveMainCoolBarSettings;
var
	i : Integer;
	CoolSet	: TCoolSet;
begin
	//�N�[���o�[�ۑ�(Main)
	for i := 0 to MAIN_COOLBAND_COUNT - 1 do begin
		CoolSet.FCoolID := MainCoolBar.Bands[i].ID;
		CoolSet.FCoolWidth := MainCoolBar.Bands[i].Width;
		CoolSet.FCoolBreak := MainCoolBar.Bands[i].Break;
		GikoSys.Setting.MainCoolSet[i] := CoolSet;
	end;
end;
procedure TGikoForm.SaveBoardCoolBarSettings;
var
	i : Integer;
	CoolSet	: TCoolSet;
begin
	//�N�[���o�[�ۑ�(Board)
	for i := 0 to LIST_COOLBAND_COUNT - 1 do begin
		CoolSet.FCoolID := ListCoolBar.Bands[i].ID;
		CoolSet.FCoolWidth := ListCoolBar.Bands[i].Width;
		CoolSet.FCoolBreak := ListCoolBar.Bands[i].Break;
		GikoSys.Setting.ListCoolSet[i] := CoolSet;
	end;
end;
procedure TGikoForm.SaveBrowserCoolBarSettings;
var
	i : Integer;
	CoolSet	: TCoolSet;
begin
	//�N�[���o�[�ۑ�(Browser)
	for i := 0 to BROWSER_COOLBAND_COUNT - 1 do begin
		CoolSet.FCoolID := BrowserCoolBar.Bands[i].ID;
		CoolSet.FCoolWidth := BrowserCoolBar.Bands[i].Width;
		CoolSet.FCoolBreak := BrowserCoolBar.Bands[i].Break;
		GikoSys.Setting.BrowserCoolSet[i] := CoolSet;
	end;
end;
// CoolBar �̐ݒ��ϐ����畜��
procedure TGikoForm.LoadCoolBarSettings;
var
	i				: Integer;
	CoolSet	: TCoolSet;
begin

	//�N�[���o�[����(Main)
	MainCoolBar.Bands.BeginUpdate;
	try
//		for i := 0 to MainCoolBar.Bands.Count - 1 do begin
		for i := MAIN_COOLBAND_COUNT - 1 downto 0 do begin
			CoolSet := GikoSys.Setting.MainCoolSet[i];
			if (CoolSet.FCoolID = -1) or (CoolSet.FCoolWidth = -1) then begin
				FIsIgnoreResize := rtNone;
				SaveCoolBarSettings;
				Exit;
			end;
			MainCoolBar.Bands.FindItemID(CoolSet.FCoolID).Index := i;
			MainCoolBar.Bands[i].Break := CoolSet.FCoolBreak;
			MainCoolBar.Bands[i].Width := CoolSet.FCoolWidth;
		end;
	finally
		MainCoolBar.Bands.EndUpdate;
	end;

	//�N�[���o�[����(Board)
	ListCoolBar.Bands.BeginUpdate;
	try
//		for i := 0 to ListCoolBar.Bands.Count - 1 do begin
		for i := LIST_COOLBAND_COUNT - 1 downto 0 do begin
			CoolSet := GikoSys.Setting.ListCoolSet[i];
			if (CoolSet.FCoolID = -1) or (CoolSet.FCoolWidth = -1) then begin
				FIsIgnoreResize := rtNone;
				SaveCoolBarSettings;
				Exit;
			end;
			ListCoolBar.Bands.FindItemID(CoolSet.FCoolID).Index := i;
			ListCoolBar.Bands[i].Break := CoolSet.FCoolBreak;
			ListCoolBar.Bands[i].Width := CoolSet.FCoolWidth;
		end;
	finally
		ListCoolBar.Bands.EndUpdate;
	end;

	//�N�[���o�[����(Browser)
	BrowserCoolBar.Bands.BeginUpdate;
	try
//		for i := 0 to BrowserCoolBar.Bands.Count - 1 do begin
		for i := BROWSER_COOLBAND_COUNT - 1 downto 0 do begin
			CoolSet := GikoSys.Setting.BrowserCoolSet[i];
			if (CoolSet.FCoolID = -1) or (CoolSet.FCoolWidth = -1) then begin
				FIsIgnoreResize := rtNone;
				SaveCoolBarSettings;
				Exit;
			end;
			BrowserCoolBar.Bands.FindItemID(CoolSet.FCoolID).Index := i;
			BrowserCoolBar.Bands[i].Break := CoolSet.FCoolBreak;
			BrowserCoolBar.Bands[i].Width := CoolSet.FCoolWidth;
		end;
	finally
		BrowserCoolBar.Bands.EndUpdate;
	end;

end;
///
procedure TGikoForm.FormShow(Sender: TObject);
var
   	item        : TThreadItem;
    MonCnt: Integer;
    MonOk: Boolean;
    MonR: Integer;
    MonB: Integer;
    Right: Integer;
    Bottom: Integer;
begin
	if FStartUp then begin
    	FStartUp := false;
		ShowWindow(Application.Handle, SW_HIDE);
		//FormCreate�ł��Ɖ��ݒ肪���f����Ȃ��ꍇ������̂�FormShow�ł�邱�Ƃɂ���
		//�c�[���o�[�\��
		GikoDM.StdToolBarVisibleAction.Checked := GikoSys.Setting.StdToolBarVisible;
		GikoDM.StdToolBarVisibleActionExecute( nil );
		GikoDM.AddressBarVisibleAction.Checked := GikoSys.Setting.AddressBarVisible;
		GikoDM.AddressBarVisibleActionExecute( nil );
		GikoDM.LinkBarVisibleAction.Checked := GikoSys.Setting.LinkBarVisible;
		GikoDM.LinkBarVisibleActionExecute( nil );
		GikoDM.ListToolBarVisibleAction.Checked := GikoSys.Setting.ListToolBarVisible;
		GikoDM.ListToolBarVisibleActionExecute( nil );
		GikoDM.ListNameBarVisibleAction.Checked := GikoSys.Setting.ListNameBarVisible;
		GikoDM.ListNameBarVisibleActionExecute( nil );
		GikoDM.BrowserToolBarVisibleAction.Checked := GikoSys.Setting.BrowserToolBarVisible;
		GikoDM.BrowserToolBarVisibleActionExecute( nil );
		GikoDM.BrowserNameBarVisibleAction.Checked := GikoSys.Setting.BrowserNameBarVisible;
		GikoDM.BrowserNameBarVisibleActionExecute( nil );

		// CoolBar ����
		LoadCoolBarSettings;

		//�d�v�@���ꂪ�Ȃ��ƃc�[���{�^���̍X�V�����������Ȃ�
//		ResetBandInfo( ListCoolBar, ListToolBar );
		FIsIgnoreResize := rtNone;

        //ActionList��GroupIndex�����ɖ߂�
		SetGroupIndex(GikoDM.GikoFormActionList);

		//FormCrete����ړ��B
		if GikoSys.Setting.TabAutoLoadSave then begin
            GikoDM.TabsOpenAction.Tag := 1;
			GikoDM.TabsOpenAction.Execute;
            GikoDM.TabsOpenAction.Tag := 0;
            if (GikoSys.Setting.LastCloseTabURL <> '') then begin
                if ( FActiveContent <> nil) and (FActiveContent.Browser <> nil) then begin
            		while (FActiveContent.Browser.ReadyState <> READYSTATE_COMPLETE) and
    			    	(FActiveContent.Browser.ReadyState <> READYSTATE_INTERACTIVE) do begin
                        // ���b�Z�[�W���󂯎��Ȃ��悤�ɃX���[�v�ɕύX
                        Sleep(1);
                    end;
		        end;
                item := BBSsFindThreadFromURL( GikoSys.Setting.LastCloseTabURL );
                GikoSys.Setting.LastCloseTabURL := '';
                if (item <> nil) and (item.IsLogFile) then begin
                    OpenThreadItem(item, item.URL);
                end;
                //ShowWindow(Self.Handle, SW_SHOW);
            end;
		end;

//===== �}���`���j�^����FormCreate�ł̓t�H�[���ʒu�����������f����Ȃ��ꍇ
//===== �����邽��FormShow����ō��W�ݒ���s��
        Top := GikoSys.Setting.WindowTop;
        Left := GikoSys.Setting.WindowLeft;
        Height := GikoSys.Setting.WindowHeight;
        Width := GikoSys.Setting.WindowWidth;

        //�E�B���h�E����ʊO�Ȃ��ʓ��Ɉړ�����
        Right := Left + Width;
        Bottom := Top + Height;
        MonOk := False;
        MonCnt := 0;
        while (MonCnt < Screen.MonitorCount) do begin
            MonR := Screen.Monitors[MonCnt].Left + Screen.Monitors[MonCnt].Width;
            MonB := Screen.Monitors[MonCnt].Top  + Screen.Monitors[MonCnt].Height;

            if ((Left  >= Screen.Monitors[MonCnt].Left) and (Left   <  MonR) and
                (Top   >= Screen.Monitors[MonCnt].Top)  and (Top    <  MonB) and
                (Right  > Screen.Monitors[MonCnt].Left) and (Right  <= MonR) and
                (Bottom > Screen.Monitors[MonCnt].Top)  and (Bottom <= MonB)) then begin
                MonOk := True;
                Break;
            end;

            MonCnt := MonCnt + 1;
        end;

        if (MonOk = False) then begin
            Left := 0;
            Top := 0;
        end;

        if GikoSys.Setting.WindowMax then
            WindowState := wsMaximized;
//==========================================================================
	end;
end;

procedure TGikoForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//	if GikoForm.WindowState <> wsMinimized then
//		SaveCoolBarSettings;
	CanClose := True;
	if ( GikoSys.Setting.ShowDialogForEnd ) and
			(MessageDlg('�M�R�i�r���I�����Ă�낵���ł����H', mtConfirmation,[mbOk, mbCancel], 0) = mrCancel ) then begin
		CanClose := false;
			Exit;
	end;

    g_AppTerminated := True;

    GikoSys.Setting.LastCloseTabURL := '';
	if GikoSys.Setting.TabAutoLoadSave then begin
		GikoDM.TabsSaveAction.Execute;
        if (GetActiveContent <> nil) and
            (GetActiveContent.IsLogFile) then begin
            GikoSys.Setting.LastCloseTabURL := GetActiveContent.URL;
        end;
	end;

	if (SearchDialog <> nil) then begin
		if (SearchDialog.Visible) then begin
			SearchDialog.Close;
		end;
        try
            SearchDialog.Release;
        except
        end;
        SearchDialog := nil;
	end;

   	//�X�N���[����̑S�Ẵt�H�[������AEditorForm�����
    GikoDM.CloseAllEditorAction.Execute;

	Application.UnhookMainWindow(Hook);
    //�A�v���P�[�V�����I���̑O�Ƀ_�E�����[�h�X���b�h�ɐ���I���𑣂�
    FControlThread.DownloadAbort;
    FControlThread.Terminate;

    //OnDestory���ƍċN�����������Ƃ��Ȃǂɕۑ�����Ȃ��̂�OnCloseQuery�Őݒ�ۑ�
    SaveSettingAll();

	Application.Terminate;
end;

procedure TGikoForm.SaveSettingAll();
var
	wp			: TWindowPlacement;
    WindowPlacement: TWindowPlacement;
begin
	try
		GikoDM.SaveThreadSearchSetting;
	except
	end;

	try
		ActiveListColumnSave;
	except
	end;

	try
        WindowPlacement.length := SizeOf(TWindowPlacement);
        GetWindowPlacement(Self.Handle, @WindowPlacement);

		//�ő剻�E�E�B���h�E�ʒu�ۑ�
		wp.length := sizeof(wp);
		GetWindowPlacement(Handle, @wp);
		GikoSys.Setting.WindowTop := wp.rcNormalPosition.Top;
		GikoSys.Setting.WindowLeft := wp.rcNormalPosition.Left;
		GikoSys.Setting.WindowHeight := wp.rcNormalPosition.Bottom - wp.rcNormalPosition.Top;
		GikoSys.Setting.WindowWidth := wp.rcNormalPosition.Right - wp.rcNormalPosition.Left;
		GikoSys.Setting.WindowMax := (WindowState = wsMaximized) or
                                        (WindowPlacement.flags = WPF_RESTORETOMAXIMIZED);
		GikoSys.Setting.ListStyle := ListView.ViewStyle;
		GikoSys.Setting.CabinetVisible := GikoDM.CabinetVisibleAction.Checked;
		GikoSys.Setting.CabinetWidth := CabinetPanel.Width;
		GikoSys.Setting.ListHeight := FBrowserSizeHeight;
		GikoSys.Setting.ListWidth := FBrowserSizeWidth;
		if GikoDM.ArrangeAction.Checked then
			GikoSys.Setting.ListOrientation := gloVertical
		else
			GikoSys.Setting.ListOrientation := gloHorizontal;
		GikoSys.Setting.MessegeBarHeight := MessagePanel.Height;
	except
	end;

	try
		// ���X�\���͈�
		if not GikoSys.Setting.ResRangeHold then
			GikoSys.Setting.ResRange := FResRangeMenuSelect;
	except
	end;
    //����winodw�̃X�^�C����CoolBar�̈ʒu�A�E�B���h�E�̈ʒu��ۑ�
    SaveCoolBarSettings;
    GikoSys.Setting.WriteWindowSettingFile;
    // ���O�ƃ��[���̕ۑ��Ȃ̂ŃG�f�B�^��������Ȃ炢�ł�����
    GikoSys.Setting.WriteNameMailSettingFile;
    // �`���̏��̕ۑ�
    GikoSys.Setting.WriteBoukenSettingFile;
	//���̓A�V�X�g�@�\�̐ݒ�̕ۑ�
	InputAssistDM.SaveToFile(GikoSys.GetInputAssistFileName);

	//���C�ɓ���ۑ�
	try
		//FavoriteDM�͎��������t�H�[���Ȃ̂ŁA����͎����I�ɂ����
        // �������ُ펞����̏I���ł͕ۑ����Ȃ�
        if not (FavoriteDM.AbEnd) then begin
    		FavoriteDM.WriteFavorite;
        end;
	except
	end;

	//�A�h���X����ۑ�
	try
		//AddressHistoryDM�͎��������t�H�[���Ȃ̂ŁA����͎����I�ɂ����B
		AddressHistoryDM.WriteHistory(AddressComboBox.Items, GikoSys.Setting.MaxRecordCount);
	except
	end;

	//�q�X�g�����X�g�ۑ�
	try
		FHistoryList.SaveToFile(GikoSys.GetConfigDir + 'History.xml');
	except
	end;

	//���񃊃X�g�ۑ�
	try
		RoundList.SaveRoundFile;
	except
	end;

    // �^�X�N�g���C�̃A�C�R���폜
    if (FIconData.uID <> 0) then begin
        Shell_NotifyIcon(NIM_DELETE, @FIconData);
    end;

end;

procedure TGikoForm.FormDestroy(Sender: TObject);
var
	i				: Integer;
	tmpBool	: Boolean;
begin
    //�ꎞ�I�ɒʏ�X�^�C���ɖ߂���CoolBar�̈ʒu�A�E�B���h�E�̈ʒu��ۑ�
    //�����ӁFOnDestroy�Ŏg�����Ƃ����l������Ă��Ȃ�
    //        ���ł��ƍĕ`�悪��������
  	if WindowState <> wsNormal then begin
   		WindowState := wsNormal;
        try
        	SaveCoolBarSettings;
		    GikoSys.Setting.WriteWindowSettingFile;
    	except
	    end;
    end;

	// �}�E�X�W�F�X�`���[�J��
	try
        if GikoSys.Setting.GestureEnabled then begin
	    	MouseGesture.OnGestureStart := nil;
		    MouseGesture.OnGestureMove := nil;
		    MouseGesture.OnGestureEnd := nil;
        end;
        MouseGesture.Clear;
		MouseGesture.UnHook;
        MouseGesture.Free;
	except
	end;

	//���C�ɓ���j��
	try
		FavoriteDM.Clear;
	except
	end;

	try
		//�^�u�N���[�Y
		tmpBool := GikoSys.Setting.ShowDialogForAllTabClose;
		GikoSys.Setting.ShowDialogForAllTabClose := false;
		GikoDM.AllTabCloseAction.Execute;
		GikoSys.Setting.ShowDialogForAllTabClose := tmpBool;
	except
	end;

	try
		for i := FBrowsers.Count - 1 downto 0 do begin
            GikoSys.ShowRefCount('browser' + IntToStr(i), TWebBrowser(FBrowsers[i]).ControlInterface);
            GikoSys.ShowRefCount('document' + IntToStr(i), TWebBrowser(FBrowsers[i]).ControlInterface.Document);
		end;

		for i := FBrowsers.Count - 1 downto 0 do begin
			TWebBrowser(FBrowsers[i]).Free;
		end;
		FBrowsers.Clear;
		FBrowsers.Capacity := 0;
	finally
		FBrowsers.Free;
	end;

	try
		if BrowserNullTab <> nil then begin
			BrowserNullTab.Browser := nil;  {*BrowserNullTab��Browser�͐݌v���ɓ\��t���Ă�z
											 *�Ȃ̂ł�����Free�����ƍ���̂ł͂����Ă��܂��B
											 *}
			BrowserNullTab.Free;
		end;
	except
	end;

	try
		TreeView.Items.BeginUpdate;
		TreeView.Items.GetFirstNode.Free;
		TreeView.Items.Clear;
		TreeView.Items.EndUpdate;
	except
	end;

	try
		try
			FHistoryList.Clear;
		except
		end;
	finally
		FHistoryList.Free;
	end;


	try
		try
			RoundList.Clear;
		except
		end;
	finally
		RoundList.Free;
	 end;

	try
        try
            //FControlThread.DownloadAbort;
            FControlThread.Terminate;
            FControlThread.WaitFor;
        except
        end;
    finally
        FControlThread.Free;
	end;
    // �v���O�C���ɂ���Ēǉ����ꂽ���j���[���J������
    for i := GikoForm.PlugInMenu.Count - 1 downto 0 do begin
		GikoForm.PlugInMenu.items[i].Free;
	end;
    GikoForm.PlugInMenu.Clear;


	// TBBS �͕ێ����Ă��� TCategory, TBoard, TThreadItem ���ׂĂ��J������
	// TBoard, TThreadItem �̃f�X�g���N�^�̓v���O�C���ɔj����`����̂�
	// BoardPluteIns �̊J������ɍs������
	for i := Length(BoardGroups) - 1 downto 0 do begin
		//BoardGroups[i].Clear;
		BoardGroups[i].Free;
	end;

	try
		for i := Length( BBSs ) - 1 downto 0 do begin
			if BBSs[ i ] <> nil then
				BBSs[ i ].Free;
			BBSs[ i ] := nil;
		end;
        DestorySpecialBBS(BoardGroup.SpecialBBS);
	except
	end;

    ThreadNgList.Free;

	try
		if FEvent <> nil then
			FEvent.Free;

        try
            if FResPopupBrowser <> nil then  begin
                TOleControl(FResPopupBrowser).Parent := nil;
                FResPopupBrowser.Free;
            end;

        except
        end;
		//Preview�j��
		if FPreviewBrowser <> nil then begin
			FPreviewBrowser.Free;
			FPreviewBrowser := nil;
		end;
	except
	end;

    // Update������Ύ��s����
    if FileExists(FUpdateExePath) then begin
        // �A�b�v�f�[�g���s
        GikoSys.CreateProcess(FUpdateExePath, FUpdateExeArgs);
    end;
    // �[������O�����ɖ߂�
    Set8087CW(FCwSave);
end;

// �e���ɂ���L���r�l�b�g�E BBS ���j���[���Z�b�g�^�X�V
procedure TGikoForm.SetBBSMenu;
var
	i			: Integer;
	item	: TBBSMenuItem;
begin

	// ���j���[���폜
	for i := CabinetSelectPopupMenu.Items.Count - 1 downto 0 do begin
		try
			if CabinetSelectPopupMenu.Items[ i ] is TBBSMenuItem then begin
				CabinetSelectPopupMenu.Items[ i ].Free;
				CabinetMenu.Items[ i ].Free;
				BBSSelectPopupMenu.Items[ i ].Free;
			end;
		except
		end;
	end;

	// ���j���[��ݒ�
	for i := Length( BBSs ) - 1 downto 0 do begin
		try
			item					:= TBBSMenuItem.Create( PopupMenu );
			item.Caption	:= BBSs[ i ].Title;
			item.Data			:= BBSs[ i ];
			item.OnClick	:= BBSMenuItemOnClick;
			CabinetSelectPopupMenu.Items.Insert( 0, item );
			item					:= TBBSMenuItem.Create( PopupMenu );
			item.Caption	:= BBSs[ i ].Title;
			item.Data			:= BBSs[ i ];
			item.OnClick	:= BBSMenuItemOnClick;
			CabinetMenu.Insert( 0, item );
			item					:= TBBSMenuItem.Create( PopupMenu );
			item.Caption	:= BBSs[ i ].Title;
			item.Data			:= BBSs[ i ];
			item.OnClick	:= BBSMenuItemOnClick;
			BBSSelectPopupMenu.Items.Insert( 0, Item );
		except
		end;
	end;

end;

procedure TGikoForm.ReloadBBS;
var
	i			: Integer;
	tmpBool: Boolean;
begin
    LockWindowUpdate(Self.Handle);

	//�^�u�N���[�Y
	tmpBool := GikoSys.Setting.ShowDialogForAllTabClose;
	GikoSys.Setting.ShowDialogForAllTabClose := false;
	GikoDM.AllTabCloseAction.Execute;
	GikoSys.Setting.ShowDialogForAllTabClose := tmpBool;
	SetContent(BrowserNullTab);
	//TreeView�N���A�iBBS2ch.Free�̌�ɃN���A�����XP�X�^�C�����ɃG���[�o��j
	TreeView.Items.Clear;

	//���񃊃X�g�ۑ�
	try
		RoundList.SaveRoundFile;
	except
	end;
	//���񃊃X�g��j��
	try
		RoundList.Clear;
	except
	end;

	//�����̕ۑ��Ɣj��
	try
		FHistoryList.SaveToFile(GikoSys.GetConfigDir + 'History.xml');
		FHistoryList.Clear;
	except
	end;

	//���C�ɓ���̕ۑ��Ɣj��
	try
		FavoriteDM.WriteFavorite;
		FavoriteDM.Clear;
	except
	end;

	//�E�X���EPLUGIN�̔j��
	for i := Length(BoardGroups) - 1 downto 0 do begin
		try
			BoardGroups[i].Free;
		except
		end;
	end;
	//BBS�j��
	try
		for i := Length( BBSs ) - 1 downto 0 do begin
			if BBSs[ i ] <> nil then
				BBSs[ i ].Free;
			BBSs[ i ] := nil;
		end;
	except
	end;

	ActiveList := nil;

	FTreeType := gttNone;

	//============�������牺�ŁA�Đ�================================//

	// �O���v���O�C�������[�h(ReadBoardFile, LoadHistory ����ɍs������)
	InitializeBoardPlugIns;

	GikoSys.ListBoardFile;		//�{�[�h�t�@�C���Ǎ�

	// ���ׂĂ�BBS��ǂݍ���ł���
	for i := Length(BBSs) - 1 downto 0 do begin
		if not BBSs[i].IsBoardFileRead then
			GikoSys.ReadBoardFile(BBSs[i]);
	end;

	// BBS ���j���[�̍X�V
	SetBBSMenu;

	ShowBBSTree( BBSs[ 0 ] );

	// ����ǂݍ���
    FHistoryList.LoadFromFile(GikoSys.GetConfigDir + 'History.xml',
        TreeView, FTreeType);

	//���C�ɓ���ǂݍ���
	FavoriteDM.ReadFavorite;

	SetLinkBar;

	//����̓ǂݍ���
	RoundList.LoadRoundBoardFile;
	RoundList.LoadRoundThreadFile;

	LockWindowUpdate(0);
end;

{!
\todo ���� IE 7 �ł� about:.. �ɂȂ�̂�
      (IE 7 �� about:.. ��ǉ����Ă���̂��A�M�R�i�r���ǉ����Ă���̂�)
      �������邱��
}
procedure TGikoForm.BrowserStatusTextChange(Sender: TObject; const Text: WideString);
var
	p: TPoint;
	s: string;
	tmp2: string;
	URL: string;
	ATitle: Boolean;

	threadItem	: TThreadItem;
	board				: TBoard;
	Protocol, Host, Path, Document, Port, Bookmark: string;

	wkInt: Integer;
	wkIntSt: Integer;
	wkIntTo: Integer;
	ActiveFileName: string;
	e: IHTMLElement;
	Ext: string;
	PathRec: TPathRec;
    Text2: string;
    cResPopup: TResPopupBrowser;
    senderBrowser :TWebBrowser;
    doc: IHTMLDocument2;
begin
    // �M�R�i�r�̓��X�A���J�[�� about:blank.. �Ŏn�܂邱�Ƃ����҂��Ă��邪
    // IE 7 �ł� about:blank.. �ł͂Ȃ� about:.. �ɂȂ�̂ŁA�u������(�������)
    if Pos('about:..', Text) = 1 then
        Text2 := 'about:blank..' + Copy( Text, Length('about:..')+1, Length(Text) )
    else
        Text2 := Text;

	if not( TObject(Sender) is TWebBrowser )then
		Exit;

    senderBrowser := TWebBrowser(Sender);
    doc := senderBrowser.ControlInterface.Document as IHTMLDocument2;

	try
		try
			if ((not senderBrowser.Busy) and Assigned(doc)) then begin
				if LowerCase(doc.charset) <> 'shift_jis' then begin
					doc.charset := 'shift_jis';
				end;
			end;
		except
		end;
	finally
	end;

	if PreviewTimer.Enabled then
		PreviewTimer.Enabled := False;

	Application.CancelHint;

	try
		if GetActiveContent <> nil then
			ActiveFileName := ChangeFileExt(ExtractFileName(GetActiveContent.FileName), '')
		else
			ActiveFileName := '';
	except
		FActiveContent := nil;
		Exit;
	end;

    // �O��Ɠ����ꍇ�I��
    if (StatusBar.Panels[1].Text = Text2) then begin
        if Text2 = '' then begin
            if FResPopupBrowser <> nil then begin
                if not(Sender is TResPopupBrowser) then
                    FResPopupBrowser.Clear
                else begin
                    TResPopupBrowser(Sender).ChildClear;
                end;
            end;
        end;
        Exit;
    end;
	StatusBar.Panels[1].Text := Text2;


	if FPreviewBrowser <> nil then
		ShowWindow(FPreviewBrowser.Handle, SW_HIDE);

    if FResPopupBrowser <> nil then begin
        if not(Sender is TResPopupBrowser) then begin
            if ((doc <> nil) and (FResPopupBrowser.Visible)) then begin
                if ResPopupClearTimer.Interval > 0 then begin
                    ResPopupClearTimer.Enabled := True;
                    ResPopupClearTimer.Tag := 0;
                end else begin
                    FResPopupBrowser.Clear;
                end;
            end;
        end else begin
            if ResPopupClearTimer.Interval > 0 then begin
                ResPopupClearTimer.Enabled := True;
                ResPopupClearTimer.Tag := 1;
            end else begin
                TResPopupBrowser(Sender).ChildClear;
            end;
        end;
    end;
    cResPopup := nil;
    
    if not(Sender is TResPopupBrowser) then
    	if not GikoSys.Setting.UnActivePopup then
	    	if not GikoForm.Active then
		    	Exit;



//file:///C:/Borland/Projects/gikoNavi/test/read.cgi/qa/990576336/10
//file:///C:/Borland/Projects/gikoNavi/test/read.cgi/qa/990576336/10-15
    // ���̃A�v���ŏ�������URL���m�F
    if (ExtPreviewDM.PreviewURL(Text2)) then begin
        Exit;
    end;
	s := '';
	Ext := AnsiLowerCase(ExtractFileExt(Text2));
//	if (Pos('http://', Text2) = 1) and (GikoSys.Setting.PreviewVisible) and
	if ((Pos('http://', Text2) = 1) or (Pos('https://', Text2) = 1)) and (GikoSys.Setting.PreviewVisible) and
			((Ext = '.jpg') or (Ext = '.jpeg') or (Ext = '.gif') or (Ext = '.png')) or
        (Pos('http://www.nicovideo.jp/watch/', Text2) = 1)  then begin
		if FPreviewBrowser = nil then begin
			FPreviewBrowser := TPreviewBrowser.Create(Self);
			ShowWindow(FPreviewBrowser.Handle, SW_HIDE);
			TOleControl(FPreviewBrowser).Parent := nil;
		end;
		FPreviewBrowser.Navigate(BLANK_HTML);//�O��̃v���r���[�摜�����p
		FPreviewURL := Text2;
		PreviewTimer.Interval := GikoSys.Setting.PreviewWait;
		PreviewTimer.Enabled := True;
	end else if (Pos('about:blank', Text2) = 1) or (Pos('http://', Text2) = 1) or (Pos('https://', Text2) = 1) or (Pos('mailto:', Text2) = 1) then begin
		if (Pos('mailto:', Text2) = 1) and (GikoSys.Setting.RespopupMailTo) then begin
			s := StringReplace(Text2, 'mailto:', '', [rfIgnoreCase]);
			//�M�R�i�r�X�� �p�[�g3��466���Ɋ���
			GetCursorPos(p);
			p.x := p.x - senderBrowser.ClientOrigin.x;
			p.y := p.y - senderBrowser.ClientOrigin.y;
			e := doc.elementFromPoint(p.x, p.y);
			if (Assigned(e)) then begin
                CreateResPopupBrowser;

                if not(Sender is TResPopupBrowser) then begin
                    if (FResPopupBrowser.Visible) then begin
                        FResPopupBrowser.Clear;
                    end;
                end else begin
                    TResPopupBrowser(Sender).ChildClear;
                end;

                cResPopup := FResPopupBrowser.CreateNewBrowser;
				tmp2 := Trim(ZenToHan(e.Get_outerText));
				if (GikoSys.IsNumeric(tmp2)) then begin
					//���̓��X�ԍ����ۂ������B
					wkIntSt := StrToInt64(tmp2);
					wkIntTo := StrToInt64(tmp2);
                    cResPopup.PopupType := gptThread;
					HTMLCreater.SetResPopupText(cResPopup, GetActiveContent(true), wkIntSt, wkIntTo, False, False);
				end else begin
                    cResPopup.PopupType := gptRaw;
                    cResPopup.Title := s;
				end;
			end;
		end else begin
            CreateResPopupBrowser;

            if not(Sender is TResPopupBrowser) then begin
                if (FResPopupBrowser.Visible) then begin
                    FResPopupBrowser.Clear;
                end;
            end else begin
                TResPopupBrowser(Sender).ChildClear;
            end;

			threadItem := GetActiveContent(true);
			URL := THTMLCreate.GetRespopupURL(Text2, threadItem.URL);
			PathRec := Gikosys.Parse2chURL2(URL);
			if (PathRec.FNoParam) then begin
				PathRec.FSt := 1;
				PathRec.FTo := 1;
			end else begin
				Gikosys.GetPopupResNumber(URL,PathRec.FSt,PathRec.FTo);
			end;
			GikoSys.ParseURI( URL, Protocol, Host, Path, Document, Port, Bookmark );

			if PathRec.FDone or (not GikoSys.Is2chHost( Host )) then begin

				URL := GikoSys.GetBrowsableThreadURL( URL );
				wkIntSt := PathRec.FSt;
				wkIntTo := PathRec.FTo;

				if (wkIntSt = 0) and (wkIntTo = 0) then begin
					wkIntSt := 1;
					wkIntTo := 1;
				end else if (wkIntSt = 0) and (wkIntTo > 0) then begin
					wkIntSt := wkIntTo;
				end else if (wkIntSt > 0) and (wkIntTo = 0) then begin
					wkIntTo := wkIntSt;
				end else if wkIntSt > wkIntTo then begin
					wkInt := wkIntTo;
					wkIntTo := wkIntSt;
					wkIntSt := wkInt;
				end;
				if (FActiveContent <> nil) and (FActiveContent.Thread.URL = URL) then
					ATitle := false
				else
					ATitle := true;

				threadItem := BBSsFindThreadFromURL( URL );

				if (threadItem = nil) and GikoSys.Is2chHost( Host ) then begin
					board := BBSs[ 0 ].FindBBSID( PathRec.FBBS );
					if board <> nil then begin
						if not board.IsThreadDatRead then
							GikoSys.ReadSubjectFile( board );
						threadItem := board.FindThreadFromFileName( PathRec.FKey + '.dat' );
					end;
				end;

				if threadItem <> nil then begin
					//HintData := GetThreadText(PathRec.FBBS, PathRec.FKey, wkIntSt, wkIntTo, ATitle, PathRec.FFirst);
					//URL�̍Ō��/���t���Ă��Ȃ��Ƃ��p
					if ( IntToStr(wkIntSt) = ChangeFileExt(threadItem.FileName, '') ) then begin
						wkIntSt := 1;
						wkIntTo := 1;
					end;
                    cResPopup := FResPopupBrowser.CreateNewBrowser;
                    cResPopup.PopupType := gptThread;
					HTMLCreater.SetResPopupText(cResPopup, threadItem, wkIntSt, wkIntTo, ATitle, PathRec.FFirst );
				end;
			end;
		end;
        if (cResPopup <> nil) then begin
            ResPopupClearTimer.Enabled := False;

            if cResPopup.PopupType = gptRaw then begin
                if cResPopup.Title <> '' then begin
                    cResPopup.TitlePopup;
                end;
            end else begin
                if cResPopup.RawDocument <> '' then begin
                    cResPopup.Popup;
                end else if cResPopup.Title <> '' then begin
                    cResPopup.TitlePopup;
                end;
            end;
        end;
	end;
end;

procedure TGikoForm.SetEnabledCloseButton(Enabled: Boolean);
var
	SysMenu: HMenu;
begin
	FEnabledCloseButton := Enabled;
	SysMenu := GetSystemMenu(Handle, False);

	if Enabled then begin
		EnableMenuItem(SysMenu, SC_CLOSE, MF_BYCOMMAND or MF_ENABLED);
	end else begin
		EnableMenuItem(SysMenu, SC_CLOSE, MF_BYCOMMAND or MF_GRAYED);
	end;

	DrawMenuBar(Handle);
end;

procedure TGikoForm.TreeViewChanging(Sender: TObject; Node: TTreeNode;
	var AllowChange: Boolean);
begin
//�\�[�g����ۑ�����悤�ɂ����̂ō폜
//	if FTreeType = gtt2ch then
//		FSortIndex := -1;
end;

procedure TGikoForm.ListViewKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
var
	pos 	: TPoint;
begin
	if GetActiveList is TBoard then begin
		case Key of
		VK_BACK:;	//	UpFolderButtonClick(Sender);
		VK_SPACE:			ListDoubleClick(Shift);
		VK_RETURN:		ListClick;
		VK_APPS:
			begin
				if ListView.Selected <> nil then begin
					pos.X := ListView.Column[ 0 ].Width;
					pos.Y := ListView.Selected.Top;
				end else begin
					pos.X := ListView.Left;
					pos.Y := ListView.Top;
				end;
				Windows.ClientToScreen( ListView.Handle, pos );
				ListPopupMenu.Popup( pos.X, pos.Y );
			end;
		end;
	end else begin // TBBS, TCategory
		case Key of
		VK_BACK:;	//	UpFolderButtonClick(Sender);
		VK_SPACE:			ListClick;
		VK_RETURN:		ListDoubleClick(Shift);
		VK_APPS:
			begin
				if ListView.Selected <> nil then begin
					pos.X := ListView.Column[ 0 ].Width;
					pos.Y := ListView.Selected.Top;
				end else begin
					pos.X := ListView.Left;
					pos.Y := ListView.Top;
				end;
				Windows.ClientToScreen( ListView.Handle, pos );
				ListPopupMenu.Popup( pos.X, pos.Y );
			end;
		end;
	end;
end;

function TGikoForm.GetHttpState: Boolean;
begin
	Result := FHttpState;
end;

procedure TGikoForm.ListViewColumnClick(Sender: TObject;
	Column: TListColumn);
var
	id, idx			: Integer;
	orderList		: TList;
	vSortIndex		: Integer;
	vSortOrder		: Boolean;
begin
	idx := TListViewUtils.ActiveListTrueColumn( Column ).Tag;
	if TObject( FActiveList ) is TBBS then begin
		orderList := GikoSys.Setting.BBSColumnOrder;
		vSortIndex := GikoSys.Setting.BBSSortIndex;
		vSortOrder := GikoSys.Setting.BBSSortOrder;
	end else if TObject( FActiveList ) is TCategory then begin
		orderList := GikoSys.Setting.CategoryColumnOrder;
		vSortIndex := GikoSys.Setting.CategorySortIndex;
		vSortOrder := GikoSys.Setting.CategorySortOrder;
	end else if TObject( FActiveList ) is TBoard then begin
		orderList := GikoSys.Setting.BoardColumnOrder;
		vSortIndex := GikoSys.Setting.BoardSortIndex;
		vSortOrder := GikoSys.Setting.BoardSortOrder;
	end else
		Exit;

	id := Integer( orderList[ idx ] );


	if vSortIndex = id then
		vSortOrder := not vSortOrder
	else begin
		vSortOrder := id = 0;
	end;

	TListViewUtils.ListViewSort(Sender, ListView, Column, GikoDM.ListNumberVisibleAction.Checked, vSortOrder);
end;

procedure TGikoForm.MenuToolBarCustomDrawButton(Sender: TToolBar;
	Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
	ARect: TRect;
begin
	DefaultDraw := True;
// �Ȃ�����������Exit���Ă���
	Exit;
	DefaultDraw := False;
	if (cdsSelected in State) or (cdsHot in State) then begin
		Sender.Canvas.Brush.Color := clHighlight;
		Sender.Canvas.Font.Color := clHighlightText;
	end else begin
		Sender.Canvas.Brush.Color := clBtnFace;
		Sender.Canvas.Font.Color := clBtnText;
	end;
	ARect := Rect(Button.Left, Button.Top, Button.Left + Button.Width, Button.Top + Button.Height);
	Sender.Canvas.FillRect(ARect);
	DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, ARect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
end;

function TGikoForm.GetTreeNode(Data: TObject): TTreeNode;
var
	Nodes: TTreeNodes;
	i: integer;
begin
	Nodes := TreeView.Items;

	for i := 0 to Nodes.Count - 1 do begin
		if Nodes.Item[i].Data = Data then begin
			Result := Nodes.Item[i];
			Exit;
		end;
	end;
	Result := nil;
end;

procedure TGikoForm.BrowserBeforeNavigate2(Sender: TObject;
	const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
	Headers: OleVariant; var Cancel: WordBool);
var
	sNo: string;
	p: TPoint;
const
	kMenuName: string = 'menu:';
begin
{$IFDEF DEBUG}
	Writeln(URL);
{$ENDIF}
    FKokoPopupThreadItem := nil;
	if Pos(kMenuName, URL) <> 0 then begin
		sNo := Copy( URL, Pos( kMenuName, URL ) + Length( kMenuName ), Length( URL ) );

		if not GikoSys.IsNumeric(sNo) then Exit;

		Cancel := True;
		GetCursorpos(p);
        KokoPopupMenu.PopupComponent := nil;
        if (Sender is TComponent) then
            KokoPopupMenu.PopupComponent := TComponent(Sender);
        // �딚�΍� �N���b�N�����u���E�U�ƈقȂ�Ƃ��ɏ���������ǉ�
        if not (Sender is TResPopupBrowser) then begin
            if (FResPopupBrowser <> nil) and (FResPopupBrowser.CurrentBrowser.Visible = True) then begin
                FResPopupBrowser.Clear;
            end;
        end else begin
            if (Sender <> FResPopupBrowser.CurrentBrowser) then begin
                TResPopupBrowser(Sender).ChildClear;
            end;
        end;
        FKokoPopupThreadItem := GetActiveContent(true);
		KokoPopupMenu.Tag := StrToInt(sNo);
		KokoPopupMenu.Popup(p.x, p.y);
	end else if Pos('mailto', LowerCase(URL)) <> 0 then begin
		Cancel := not GikoSys.Setting.OpenMailer;

        //@��.���܂܂Ȃ�URL�̓��[���A�h���X�Ƃ݂Ȃ��Ȃ�
        //���age�Asage�΍�
        if (Pos('@', URL) = 0) or (Pos('.', URL) = 0) then begin
            Cancel := True;
        end;
	end;

end;

procedure TGikoForm.TreeViewCustomDraw(Sender: TCustomTreeView;
	const ARect: TRect; var DefaultDraw: Boolean);
var
	NodeRect: TRect;
	i, j: Integer;
	IsBoardNode: Boolean;
	Cnt: Integer;
	CntText: string;
	TextWidth: Integer;
	TextRect: TRect;
	Board: TBoard;
	Category: TCategory;
	Bitmap: TBitmap;
	NodeWidth: Integer;
begin
	DefaultDraw := True;

	if FTreeType = gttHistory then Exit;

	TreeView.Canvas.Font.Color := clBlue;
	IsBoardNode := False;
	for i := 0 to TreeView.Items.Count - 1 do begin
		Cnt := 0;
		if not TreeView.Items[i].IsVisible then
			continue;

		if TObject(TreeView.Items[i].Data) is TCategory then begin
			if TreeView.Items[i].Expanded then
				continue;

			IsBoardNode := False;
			Category := TCategory(TreeView.Items[i].Data);
			for j := 0 to Category.Count - 1 do begin
				Board := Category.Items[j];
				if Board <> nil then begin
					if Board.UnRead > 0 then begin
						Cnt := 1;
						Break;
					end;
				end;
			end;
			if Cnt <> 1 then
				continue;
		end else if TObject(TreeView.Items[i].Data) is TBoard then begin
			IsBoardNode := True;
			Board := TBoard(TreeView.Items[i].Data);

			Cnt := Board.UnRead;
			if Cnt <= 0 then
				continue;
		end else
			continue;

		Bitmap := TBitmap.Create;
		try
			Bitmap.Canvas.Font.Assign(TreeView.Canvas.Font);
			Bitmap.Canvas.Font.Style := [fsBold];
			NodeWidth := Bitmap.Canvas.TextWidth(TreeView.Items[i].Text);
		finally
			Bitmap.Free;
		end;

		NodeRect := TreeView.Items[i].DisplayRect(True);

		if IsBoardNode then
			CntText := '(' + IntToStr(Cnt) + ')'
		else if Cnt = 1 then
			CntText := '(+)';


		TextWidth := TreeView.Canvas.TextWidth(CntText);

		TextRect := Rect(NodeRect.Left + NodeWidth + 8,
										 NodeRect.Top,
										 NodeRect.Left + NodeWidth + TextWidth + 8,
										 NodeRect.Bottom);
		DrawText(TreeView.Canvas.Handle,
						 PChar(CntText),
						 -1,
						 TextRect,
						 DT_SINGLELINE or DT_VCENTER);
	end;
	TreeViewCustomDrawItem(nil, nil, [], DefaultDraw);
end;

procedure TGikoForm.TreeViewCustomDrawItem(Sender: TCustomTreeView;
	Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
	Board: TBoard;
	Category: TCategory;
	i: Integer;
begin
	DefaultDraw := True;

	if FTreeType = gttHistory then Exit;

	TreeView.Canvas.Font.Style := [];
	if Node <> nil then begin
		if TObject(Node.Data) is TCategory then begin
			Category := TCategory(Node.Data);
			for i := 0 to Category.Count - 1 do begin
				Board := Category.Items[i];
				if Board <> nil then begin
					if Board.UnRead > 0 then begin
						TreeView.Canvas.Font.Style := [fsBold];
						Break;
					end;
				end;
			end;
		end else if TObject(Node.Data) is TBoard then begin
			Board := TBoard(Node.Data);
			if Board.UnRead > 0 then
				TreeView.Canvas.Font.Style := [fsBold];
		end;
	end;
end;

procedure TGikoForm.TreeViewExpanded(Sender: TObject; Node: TTreeNode);
begin
	TreeView.Invalidate;

	if TObject(Node.Data) is TBBS then begin
		TBBS(Node.Data).NodeExpand := True;
	end else if TObject(Node.Data) is TCategory then begin
		TCategory(Node.Data).NodeExpand := True;
	end else if TObject(Node.Data) is TBoard then begin
		TBoard(Node.Data).NodeExpand := True;
	end;
end;

procedure TGikoForm.ListViewAllSelect;
begin
	ListView.SetFocus;
	ListView.SelectAll;
end;
procedure TGikoForm.DownloadMsg(Sender: TObject; Item: TDownloadItem; Msg: string; Icon: TGikoMessageIcon);
begin
    if csDestroying in Self.ComponentState then
        Exit;
	AddMessageList(Msg, nil, Icon);
end;
// *************************************************************************
//! �_�E�����[�h�����������Ƃ��ɔ�������C�x���g
// *************************************************************************
procedure TGikoForm.DownloadEnd(Sender: TObject; Item: TDownloadItem);
var
	ATitle: string;
	s: string;
	boardPlugIn : TBoardPlugIn;
	i: Integer;
	Res : TResRec;
begin
	try
        if csDestroying in Self.ComponentState then
	    	Exit;
		if Item.DownType = gdtBoard then
			ATitle := Item.Board.Title
		else
			ATitle := Item.ThreadItem.Title;
		if ATitle = '' then
			ATitle := GikoSys.GetGikoMessage(gmUnKnown);

		if Item.State in [gdsComplete, gdsDiffComplete] then begin
			//����I��
			if Item.DownType = gdtBoard then begin
				//��
				Item.SaveListFile;
				AddMessageList(ATitle + ' ' + GikoSys.GetGikoMessage(gmSureItiran), nil, gmiOK);
				if GetActiveList = Item.Board then begin
					FActiveList := nil;
					//�����\�[�g�̏ꍇ�ꗗ�̃\�[�g�����N���A����
					if (GikoSys.Setting.AutoSortThreadList) then begin
						GikoSys.Setting.BoardSortIndex := 0;
						GikoSys.Setting.BoardSortOrder := True;
					end;
					Sort.SetSortDate(Now());
					SetActiveList(Item.Board);
				end;
				Item.Board.Modified := True;
				Item.Board.IsThreadDatRead := True;
				PlaySound('New');
				ListView.Refresh;
			end else if Item.DownType = gdtThread then begin
				//�X��
				Item.SaveItemFile;
				Item.ThreadItem.NewArrival := True;
				//if (Item.ThreadItem.IsBoardPlugInAvailable) and (Item.ThreadItem.Title = '') then begin
				if (Item.ThreadItem.ParentBoard.IsBoardPlugInAvailable) and (Item.ThreadItem.Title = '') then begin
					//boardPlugIn		:= Item.ThreadItem.BoardPlugIn;
					boardPlugIn		:= Item.ThreadItem.ParentBoard.BoardPlugIn;
					THTMLCreate.DivideStrLine(boardPlugIn.GetDat( DWORD( Item.ThreadItem ), 1 ), @Res);
					Item.ThreadItem.Title := Res.FTitle;
					ATitle := Item.ThreadItem.Title;
				end else if ATitle = '�i���̕s���j' then begin
					THTMLCreate.DivideStrLine(GikoSys.ReadThreadFile(Item.ThreadItem.GetThreadFileName, 1), @Res);
					ATitle := Res.FTitle;
				end;
				for i := BrowserTab.Tabs.Count - 1 downto 0 do begin
					if TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread = Item.ThreadItem then begin
						TBrowserRecord(BrowserTab.Tabs.Objects[i]).Repaint := true;
						break;
					end;
				end;
				if GikoSys.Setting.BrowserTabVisible then begin
					if GetActiveContent = Item.ThreadItem then
						InsertBrowserTab(Item.ThreadItem)
					else if (ListView.Selected <> nil ) and ( TObject(ListView.Selected.Data) is TThreadItem ) and ( Item.ThreadItem = TThreadItem(ListView.Selected.Data)) then
						InsertBrowserTab(Item.ThreadItem, True)
					else
						InsertBrowserTab(Item.ThreadItem, False);

				end else begin
					if (GetActiveContent = Item.ThreadItem) or (FActiveContent = nil) or(FActiveContent.Browser = BrowserNullTab.Browser) then
												InsertBrowserTab(Item.ThreadItem);
				end;

								Application.ProcessMessages;

				if Item.State = gdsComplete then begin
					PlaySound('New');
										AddMessageList(ATitle + ' ' + GikoSys.GetGikoMessage(gmSureSyutoku), nil, gmiOK);
										//Add by Genyakun
										DiffComp := True;
				end else begin
					PlaySound('NewDiff');
										AddMessageList(ATitle + ' ' + GikoSys.GetGikoMessage(gmSureDiff), nil, gmiOK);
										//Add by Genyakun
										DiffComp := True;
				end;

				//���񂠂�̏ꍇ���P�O�O�O���͏���폜
				if (Item.ThreadItem.Round) and (Item.ThreadItem.Count > 1000) then begin
                    // 2ch�ȊO�́A1000���ō����s���Ȃ̂ŁA2ch����ɂ���
                    if (Item.ThreadItem.ParentBoard.Is2ch) then begin
    					Item.ThreadItem.Round := False;
	    				AddMessageList('��1000�����𒴂����̂ŏ�����폜���܂��� - [' + Item.ThreadItem.Title + ']', nil, gmiOK);
                    end;
				end;
				TreeView.Refresh;
				//ListView�ł��̃X�����܂܂���\�����Ă���Ƃ��̍X�V����
                UpdateListView();
				RefreshListView(Item.ThreadItem);
			end;

		end else if Item.State = gdsNotModify then begin
			//�ύX�i�V
{			if (Item.DownType = gdtThread) and (AddHistory(Item.ThreadItem)) then begin
				//SetContent(Item.ThreadItem);
				InsertBrowserTab(Item.ThreadItem);
			end;}
						AddMessageList(ATitle + ' ' + GikoSys.GetGikoMessage(gmNotMod), nil, gmiSAD);
			PlaySound('NoChange');
			Screen.Cursor := crDefault;
		end else if Item.State = gdsAbort then begin
			//���f
						AddMessageList(ATitle + ' ' + GikoSys.GetGikoMessage(gmAbort), nil, gmiOK);
		end else if Item.State = gdsError then begin
			//�G���[
			s := Item.ErrText;
			if s <> '' then
				s := ':' + s;
                        AddMessageList(ATitle + ' ' + GikoSys.GetGikoMessage(gmError) + ' (' + IntToStr(Item.ResponseCode) + ')' + s, nil, gmiNG);
//			if Item.ResponseCode = 302 then
//				AddMessageList('���ړ]������������Ȃ��̂ŔX�V���s���Ă��������B', nil, gmiNG);
			PlaySound('Error');
		end;
	finally
		Item.Free;
		Dec(FWorkCount);
		if FWorkCount < 0 then FWorkCount := 0;
		if FWorkCount = 0 then begin
			try
				Animate.Active := False;
			finally
				Screen.Cursor := crDefault;
			end;
		end;

	end;
end;

procedure TGikoForm.WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer; Number: Integer; const AWorkTitle: string);
begin
//	SetProgressValue(Number, 0, AWorkCountMax);
//	ProgressBar.Visible := True;
    if csDestroying in Self.ComponentState then
        Exit;

	ProgressBar.Position := 0;
	ProgressBar.Max := AWorkCountMax;
	FDownloadTitle := AWorkTitle;
	StatusBar.Panels[1].Text := FDownloadTitle + ' - �_�E�����[�h���J�n���܂�';
	FDownloadMax := AWorkCountMax;
end;

procedure TGikoForm.WorkEnd(Sender: TObject; AWorkMode: TWorkMode; Number: Integer);
begin
    if csDestroying in Self.ComponentState then
        Exit;
	ProgressBar.Position := 0;
	if FDownloadMax <> 0 then
		StatusBar.Panels[1].Text := FDownloadTitle + ' - �_�E�����[�h���������܂���';
end;

procedure TGikoForm.Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer; Number: Integer);
begin
    if csDestroying in Self.ComponentState then
        Exit;
	ProgressBar.Position := AWorkCount;
//	SetProgressValue(Number, AWorkCount);
	StatusBar.Panels[1].Text := FDownloadTitle + ' - �_�E�����[�h�� (' + IntToStr(AWorkCount) + '/' + IntToStr(FDownloadMax) + ')';
end;

procedure TGikoForm.AddMessageList(ACaption: string; AObject: TObject; Icon: TGikoMessageIcon);
var
	ListItem: TListItem;
begin
	MessageListView.Items.BeginUpdate;
	try
		ListItem := MessageListView.Items.Add;
		ListItem.Caption := ACaption;
		ListItem.Data := AObject;
		ListItem.MakeVisible(False);
		case Icon of
			gmiOK:	 ListItem.ImageIndex := 0;
			gmiSAD:	ListItem.ImageIndex := 1;
			gmiNG:	 ListItem.ImageIndex := 2;
			gmiWhat: ListItem.ImageIndex := 3;
		end;
	finally
		MessageListView.Items.EndUpdate;
	end;
end;

//! �����Ƃ��Â�Browser�̊J��
procedure TGikoForm.ReleaseOldestBrowser;
var
    i: Integer;
begin
    for i := BrowserTab.Tabs.Count - 1 downto 0 do begin
        if TBrowserRecord(BrowserTab.Tabs.Objects[i]).Browser =
                TWebBrowser(FBrowsers[BROWSER_COUNT - 1]) then begin
            ReleaseBrowser(TBrowserRecord(BrowserTab.Tabs.Objects[i]));
            break;
        end;
    end;
end;

function TGikoForm.InsertBrowserTab(
	ThreadItem	: TThreadItem;
	ActiveTab		: Boolean = True
) : TBrowserRecord;
var
	i, j, idx		: Integer;
	favItem			: TFavoriteThreadItem;
	newBrowser	: TBrowserRecord;
    ins : Integer;
begin

	Result := nil;
	if Threaditem = nil then Exit;

	if ThreadItem.IsLogFile then begin
		//���C�ɓ���̑S�ĊJ���Ƃ����ƁA���J���Ă�X����browser��t���ւ��鋰�ꂪ����
		//��ɂS�Ԗڂ�Active�̃u���E�U�����Ȃ��悤�Ɉړ�������
		if (FActiveContent <> nil) and (FActiveContent.Browser <> nil) and
			(FActiveContent.Browser <> BrowserNullTab.Browser)then begin
			j := FBrowsers.IndexOf(FActiveContent.Browser);
			if j = BROWSER_COUNT - 1 then
				FBrowsers.Move(BROWSER_COUNT - 1, 0);
		end;
		favItem := TFavoriteThreadItem.Create(ThreadItem.URL, ThreadItem.Title );
		if not FHistoryList.AddHistory( favItem, TreeView, FTreeType ) then
			favItem.Free;

		for i := 0 to BrowserTab.Tabs.Count - 1 do begin
			if TObject(BrowserTab.Tabs.Objects[i]) is TBrowserRecord then begin
				if TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread = ThreadItem then begin
					Result := TBrowserRecord( BrowserTab.Tabs.Objects[i] );
					if TBrowserRecord(BrowserTab.Tabs.Objects[i]).Browser = nil then begin
                        //��ԌÂ��u���E�U���J������
                        ReleaseOldestBrowser;
						TBrowserRecord(BrowserTab.Tabs.Objects[i]).Browser := TWebBrowser(FBrowsers[BROWSER_COUNT - 1]);
						TBrowserRecord(BrowserTab.Tabs.Objects[i]).Repaint := true;
						FBrowsers.Move(BROWSER_COUNT - 1, 0);
					end;
					if ActiveTab then begin
						BrowserTab.TabIndex := i;
							BrowserTab.OnChange(nil);
						BrowserTab.Repaint;
					end;
					Exit;
				end;
			end;
		end;
		idx := BrowserTab.TabIndex;
        newBrowser := TBrowserRecord.Create;
        // ��ԌÂ��u���E�U���J������
        ReleaseOldestBrowser;
        newBrowser.Browser := TWebBrowser(FBrowsers[BROWSER_COUNT - 1]);
        FBrowsers.Move(BROWSER_COUNT - 1, 0);
        newBrowser.thread := ThreadItem;
        newBrowser.Repaint := true;

		if GikoSys.Setting.BrowserTabAppend = gtaFirst then begin
			BrowserTab.Tabs.InsertObject(0, GikoSys.GetShortName(ThreadItem.Title, 20), newBrowser);
			if (not GikoSys.Setting.BrowserTabVisible) and (BrowserTab.Tabs.Count > 1) then begin
				DeleteTab( TBrowserRecord( BrowserTab.Tabs.Objects[ 1 ] ) );
			end;// else begin
			//end;
			BrowserTab.Repaint;
			if ActiveTab then begin
				BrowserTab.TabIndex := 0;
			end;
		end else if GikoSys.Setting.BrowserTabAppend = gtaLast then begin
			i := BrowserTab.Tabs.AddObject(GikoSys.GetShortName(ThreadItem.Title, 20), newBrowser);
			if (not GikoSys.Setting.BrowserTabVisible) and (BrowserTab.Tabs.Count > 1) then begin
				DeleteTab( TBrowserRecord( BrowserTab.Tabs.Objects[ 0 ] ) );
			end;
			//end;
			BrowserTab.Repaint;
			if ActiveTab then begin
				if (not GikoSys.Setting.BrowserTabVisible) and (BrowserTab.Tabs.Count > 0) then
					BrowserTab.TabIndex := 0
				else
					BrowserTab.TabIndex := i;
			end;
		end else begin
            // �^�u�ʒu���擾
            ins := -1;
            for i := BrowserTab.Tabs.Count - 1 downto 0 do begin
            if TBrowserRecord(BrowserTab.Tabs.Objects[i]).Browser =
                    TWebBrowser(FBrowsers[1]) then begin
                    ins := i;
                    break;
                end;
            end;
            if GikoSys.Setting.BrowserTabAppend = gtaRight then begin
                Inc(ins);
		    end;
            // �^�u�������Ƃ��ȂǑ΍�
            if (ins < 0) then begin
                ins := 0;
            end;
			BrowserTab.Tabs.InsertObject(ins, GikoSys.GetShortName(ThreadItem.Title, 20), newBrowser);
			if (not GikoSys.Setting.BrowserTabVisible) and (BrowserTab.Tabs.Count > 1) then begin
                if GikoSys.Setting.BrowserTabAppend = gtaRight then begin
    				DeleteTab( TBrowserRecord( BrowserTab.Tabs.Objects[ 0 ] ) );
                end else begin
                    DeleteTab( TBrowserRecord( BrowserTab.Tabs.Objects[ 1 ] ) );
                end;
			end;
			//end;
			BrowserTab.Repaint;
			if ActiveTab then begin
				if (not GikoSys.Setting.BrowserTabVisible) and (BrowserTab.Tabs.Count > 0) then
					BrowserTab.TabIndex := 0
				else
					BrowserTab.TabIndex := ins;
			end;
        end;
		Result := newBrowser;
		if(ActiveTab) or (idx = -1) then begin
			BrowserTab.OnChange(nil);
		end;
	end else begin
		if BrowserNullTab = nil then begin
			BrowserNullTab := TBrowserRecord.Create;
			BrowserNullTab.Browser := Browser;
		end;
//		if BrowserNullTab.thread <> ThreadItem then begin
//			BrowserNullTab.Movement := '';
//		end;
		BrowserNullTab.thread := ThreadItem;
		Result := BrowserNullTab;
		BrowserTab.TabIndex := -1;
		SetContent(BrowserNullTab);
	end;

	if GikoSys.Setting.URLDisplay then
		AddressComboBox.Text := ThreadItem.URL;

end;

procedure TGikoForm.SetContent(inThread : TBrowserRecord);
var
	BBSID: string;
	FileName: string;
	sTitle: string;
	doc: OleVariant;
	s: string;
	idx: Integer;
	ThreadItem: TThreadItem;
	Thread: TBrowserRecord;
	ThreadTitle, ThreadPTitle: string;
	ThreadIsLog, {ThreadUnRead,} ThreadNewArraical: boolean;
begin
	Thread := inThread;
	idx := BrowserTab.TabIndex;
	if  (not FStartUp) and
        (FActiveContent <> nil) and
		(FActiveContent.Thread <> Thread.Thread) and
		(FActiveContent.Browser <> nil) and
		(Assigned(FActiveContent.Browser.ControlInterface.Document)) then begin
        try
            try
                FActiveContent.Thread.ScrollTop := FActiveContent.Browser.OleObject.Document.Body.ScrollTop;
            except
            on E: Exception do
                MsgBox(Handle, E.Message, 'SetContent[<-ScrollTop]', 0);
        end;
		finally
		end;
	end;
	if not (Assigned(Thread)) or (Thread.Thread = nil) then begin
		Thread.Browser.Navigate(BLANK_HTML);
		BrowserBoardNameLabel.Caption := '';
		ItemBoardImage.Picture := nil;
		BrowserNameLabel.Caption := '';
		ItemImage.Picture := nil;
        BrowserNullTab.Thread := nil;
		//TOleControl(BrowserNullTab.Browser).Visible := true;
		ShowWindow(BrowserNullTab.Browser.Handle, SW_SHOW);
		FActiveContent := nil;
		Exit;
	end	else if Thread.Browser = nil then begin
		if FActiveContent.Browser = TWebBrowser(FBrowsers[BROWSER_COUNT - 1]) then
			FBrowsers.Move(BROWSER_COUNT - 1, 0);
        // ��ԌÂ��u���E�U���J������
        ReleaseOldestBrowser;
		Thread.Browser := TWebBrowser(FBrowsers[BROWSER_COUNT - 1]);
		FBrowsers.Move(BROWSER_COUNT - 1, 0);
	end;

	ThreadTitle := Thread.Thread.Title;
	ThreadPTitle := Thread.Thread.ParentBoard.Title;
	//ThreadScrollTop := Thread.Thread.ScrollTop;
    if Thread.Thread.IsLogFile then  begin
        if not FileExists(Thread.Thread.GetThreadFileName) then begin
            Thread.Thread.DeleteLogFile;
        end;
    end;

	ThreadIsLog := Thread.Thread.IsLogFile;
	ThreadItem := Thread.Thread;
	ThreadNewArraical :=  Thread.Thread.NewArrival;
	//ThreadUnRead := Thread.Thread.UnRead;
	BBSID := ThreadItem.ParentBoard.BBSID;
	FileName := ThreadItem.FileName;

	if GetCapture = ListView.Handle then
		ReleaseCapture;

	Screen.Cursor := crHourGlass;


	try
		if(FActiveContent <> nil) and (FActiveContent <> Thread) then begin
			if (FActiveContent.Browser <> BrowserNullTab.Browser) then
				ShowWindow(FActiveContent.Browser.Handle, SW_HIDE);
		end;
		ShowWindow(Thread.Browser.Handle, SW_SHOW);
		if (not Assigned(Thread.Browser.ControlInterface.Document)) then begin
			Thread.Browser.Navigate('about:blank');
		end;
		while (Thread.Browser.ReadyState <> READYSTATE_COMPLETE) and
				(Thread.Browser.ReadyState <> READYSTATE_INTERACTIVE) do begin
			Application.ProcessMessages;
			if idx <> BrowserTab.TabIndex then begin
				Exit;
			end;
		end;

		if (Thread <> nil) and (ThreadItem <>nil) then begin
			BrowserBoardNameLabel.Caption := ThreadPTitle;
			ItemIcon16.GetBitmap(4, ItemBoardImage.Picture.Bitmap);
            BrowserNameLabel.Caption := GikoSys.TrimThreadTitle(ThreadTitle);
			ItemImage.Picture := nil;
			if ThreadIsLog then
				if ThreadNewArraical then
					ItemImageList.GetBitmap(2, ItemImage.Picture.Bitmap)
				else
					ItemImageList.GetBitmap(0, ItemImage.Picture.Bitmap)
			else
				ItemImageList.GetBitmap(1, ItemImage.Picture.Bitmap);

			ItemImage.Left := BrowserBoardNameLabel.Left + BrowserBoardNameLabel.Width + 8;
			BrowserNameLabel.Left := ItemImage.Left + 20;

		end;
		//ActiveContent�@�̍X�V
		FActiveContent := Thread;

		if not ThreadIsLog then begin
			Self.Caption := GikoDataModule.CAPTION_NAME ;
			//�X�e�[�^�X�o�[�ɕ\�����Ă���X���̗e�ʂ�����
			StatusBar.Panels[THREADSIZE_PANEL].Text := '';
			try
				Thread.Browser.BringToFront;
				s := '<HTML><BODY><CENTER>���̃X���b�h�͎擾���Ă��܂���</CENTER></BODY></HTML>';
				doc := Thread.Browser.OleObject.Document;
				doc.open;
				doc.charset := 'Shift_JIS';
				doc.Write(s);
				doc.Close;
			finally
				
			end;
		end else begin
			Self.Caption := GikoDataModule.CAPTION_NAME + ' - [' + GikoSys.TrimThreadTitle(ThreadTitle) + ']';
			//�X�e�[�^�X�o�[�ɕ\�����Ă���X���̗e�ʂ�\��
			StatusBar.Panels[THREADSIZE_PANEL].Text := Format('%6.2f kB', [ThreadItem.Size / 1024]);
			StatusBar.Panels[THREADSIZE_PANEL].Width :=
				Max(StatusBar.Canvas.TextWidth(StatusBar.Panels[THREADSIZE_PANEL].Text), 70);
			//Thread.Repaint�́A�X�L�����̐ݒ��ύX�����Ƃ��AThread���_�E�����[�h�����Ƃ�
			//�V�K��Thread���J�����Ƃ��ɐ^�ɂȂ��Ă���B
			if Thread.Repaint then begin
				Thread.Repaint := false;

				Thread.Browser.OnStatusTextChange := nil;
				LockWindowUpdate(Thread.Browser.ParentWindow);
				HTMLCreater.CreateHTML2(Thread.Browser, ThreadItem, sTitle);
				Thread.Browser.OnStatusTextChange := BrowserStatusTextChange;
				PostMessage( Handle, USER_DOCUMENTCOMPLETE, Integer( Thread.Browser ), 0 );
			end;
		end;

		RefreshListView(ThreadItem);
	finally
		Screen.Cursor := crDefault;
	end;
end;

function TGikoForm.GetActiveContent(popup :Boolean = false): TThreadItem;
begin
	try
		if FActiveContent <> nil then begin
			Result := FActiveContent.Thread;
            if (popup) and
                (FResPopupBrowser <> nil) and (FResPopupBrowser.CurrentBrowser.Visible = True) then
                if (FResPopupBrowser.CurrentBrowser.Thread <> nil) then begin
                    Result := FResPopupBrowser.CurrentBrowser.Thread;
                end;
		end else
			Result := nil;
	except
		Result := nil;
	end;

end;

procedure TGikoForm.SetActiveList(Obj: TObject);
var
	idx	: Integer;
begin
//	if FActiveList <> Obj then begin
		FActiveList := Obj;
        try
			if ListView.Selected <> nil then
				idx := ListView.Selected.Index
			else
				idx := -1;
        except
        	idx := -1;
        end;
		ListView.Items.Count := 0;
		ListView.Items.Clear;
		ListView.Selected := nil;
//	ListView.Columns.Clear;
		if (FActiveContent <> nil) and (FActiveContent.Thread <> nil)
			and (FActiveContent.Thread.IsLogFile) then begin
			try
				Self.Caption := GikoDataModule.CAPTION_NAME + ' - [' + GikoSys.TrimThreadTitle(FActiveContent.Thread.Title) + ']'
			except
				on E: Exception do begin
					//�X���ꗗDL��Ȃǂ�FActiveContent�̎���Thread��
					//�폜����Ă���ꍇ������̂ł����ď�������
					ReleaseBrowser(FActiveContent);
					FActiveContent.Thread := nil;
					Self.Caption := GikoDataModule.CAPTION_NAME;
				end;
			end;
		end else
			Self.Caption := GikoDataModule.CAPTION_NAME;
		//Application.Title := CAPTION_NAME;

//		ActiveListColumnSave;

		Screen.Cursor := crHourGlass;
		try
			if Obj is TBBS then begin
				TListViewUtils.SetCategoryListItem(TBBS(obj), ListView, GikoDM.ListNumberVisibleAction.Checked);
			end else if Obj is TCategory then begin
				TListViewUtils.SetBoardListItem(TCategory(Obj), ListView, GikoDM.ListNumberVisibleAction.Checked);
			end else if Obj is TBoard then begin
				TListViewUtils.SetThreadListItem(TBoard(Obj), ListView,  GikoDM.ListNumberVisibleAction.Checked);
			end;
		finally
			Screen.Cursor := crDefault;
		end;

		if idx >= 0  then begin
			if idx >= ListView.Items.Count then
				idx := ListView.Items.Count - 1;
			ListView.ItemIndex := idx;
			ListView.ItemFocused := ListView.Items.Item[ idx ];
		end;
//	end;
end;


//�����q�����L����
//���̂���interface���g��
function TGikoForm.GetActiveList: TObject;
begin
	Result := FActiveList;
end;

procedure TGikoForm.SetListViewType(AViewType: TGikoViewType);
begin
	SetListViewType(AViewType, '', False);
end;

procedure TGikoForm.SetListViewType(AViewType: TGikoViewType; SelectText: string; KubetsuChk: Boolean);
var
	Board: TBoard;
	i: Integer;
begin
	for i := Length( BBSs ) - 1 downto 0 do begin
		BBSs[i].SelectText := SelectText;
		BBSs[i].KubetsuChk := KubetsuChk;
	end;
    BoardGroup.SpecialBBS.SelectText := SelectText;
    BoardGroup.SpecialBBS.KubetsuChk := KubetsuChk;
    
	ViewType := AViewType;
	if ActiveList is TBoard then begin
		Board := TBoard(ActiveList);
		case ViewType of
			//gvtAll: ListView.Items.Count := Board.Count;
			gvtLog: Board.LogThreadCount := Board.GetLogThreadCount;
			gvtNew: Board.NewThreadCount := Board.GetNewThreadCount;
			gvtArch: Board.ArchiveThreadCount := Board.GetArchiveThreadCount;
			gvtLive: Board.LiveThreadCount := Board.GetLiveThreadCount;
			gvtUser: Board.UserThreadCount:= Board.GetUserThreadCount;

		end;

		SetActiveList(Board);
	end;
end;

procedure TGikoForm.ListViewCustomDraw(Sender: TCustomListView;
	const ARect: TRect; var DefaultDraw: Boolean);
var
	s: string;
	p: TPoint;
//	Board: TBoard;
begin
	if ListView.Items.Count = 0 then begin
		DefaultDraw := true;
		ListView.Canvas.Brush.Color := ListView.Color;
		ListView.Canvas.FillRect(ARect);

		case ViewType of
			gvtAll: begin
				ListView.Canvas.Font.Color := clWindowText;
				s := '���̃r���[�ɂ̓A�C�e��������܂���B';
			end;
			gvtLog: begin
				ListView.Canvas.Font.Color := clBlue;
				s := '���̃r���[�ɂ̓��O�L��A�C�e��������܂���B';
			end;
			gvtNew: begin
				ListView.Canvas.Font.Color := clGreen;
				s := '���̃r���[�ɂ͐V���A�C�e��������܂���B';
			end;
			gvtArch: begin
				ListView.Canvas.Font.Color := clFuchsia;
				s := '���̃r���[�ɂ�DAT�����A�C�e��������܂���B';
			end;
			gvtLive: begin
				ListView.Canvas.Font.Color := clMaroon;
				s := '���̃r���[�ɂ͐����A�C�e��������܂���B';
			end;
			gvtUser: begin
				ListView.Canvas.Font.Color := clNavy;
				s := '���̃r���[�ɂ̓^�C�g�����u%s�v���܂ރA�C�e��������܂���B';
				if GetActiveList is TBoard then
					s := Format(s, [TBoard(GetActiveList).ParentCategory.ParenTBBS.SelectText]);
//					SelectText]);
			end;
			else begin
				s := '';
			end;
		end;

		p := Point((ListView.ClientWidth div 2) - (ListView.Canvas.TextWidth(s) div 2),
							 (ListView.ClientHeight div 2) - (ListView.Canvas.TextHeight(s) div 2));
		ListView.Canvas.TextOut(p.X, p.Y, s);
	end else begin
		DefaultDraw := True;
	end;
end;

procedure TGikoForm.DownloadList(Board: TBoard; ForceDownload: Boolean = False);
var
	Item: TDownloadItem;
begin
	if not Board.IsThreadDatRead then
		GikoSys.ReadSubjectFile(Board);
	Item := TDownloadItem.Create;
	try
		Item.Board := Board;
		Item.DownType := gdtBoard;
		Item.ForceDownload := ForceDownload;
		FControlThread.AddItem(Item);
		if FWorkCount = 0 then begin
			try
				Animate.Active := True;
			except
			end;
			Screen.Cursor := crAppStart;
		end;
		Inc(FWorkCount);
	finally
		//Item.Free;
	end;
end;

procedure TGikoForm.DownloadContent(ThreadItem: TThreadItem; ForceDownload: Boolean = False);
var
	Item: TDownloadItem;
begin
	Item := TDownloadItem.Create;
	try
		Item.ThreadItem := ThreadItem;
		Item.DownType := gdtThread;
		Item.ForceDownload := ForceDownload;
		FControlThread.AddItem(Item);
		if FWorkCount = 0 then begin
			try
				Animate.Active := True;
			except
			end;
			Screen.Cursor := crAppStart;
		end;
		Inc(FWorkCount);
	finally
//		Item.Free;
	end;
end;

procedure TGikoForm.PlaySound(SoundEventName: string);
var
	FileName: string;
begin
	if not GikoSys.Setting.Mute then begin
		FileName := GikoSys.Setting.FindSoundFileName(SoundEventName);
		if FileExists(FileName) then begin
			if not sndPlaySound(PChar(FileName), SND_ASYNC or SND_NOSTOP) then begin
				sndPlaySound(nil, SND_SYNC);
				Application.ProcessMessages;
				Sleep(10);
				sndPlaySound(PChar(FileName), SND_ASYNC);
			end;
		end;
	end;
end;

//��������폜
procedure TGikoForm.DeleteHistory( threadItem: TThreadItem );
begin
    FHistoryList.DeleteHistory( threadItem, TreeView, TreeType );
end;

procedure TGikoForm.ShowBBSTreeOld(
	inBBS : TBBS
);
var
	i, b		: Integer;
	item		: TMenuItem;
begin
	try
		FavoriteTreeView.Visible := False;
		FavoriteToolBar.Hide;
		TreeView.Visible := True;

		b := CabinetSelectPopupMenu.Items.Count - 1;
		for i := 0 to b do begin
			item := CabinetSelectPopupMenu.Items[ i ];
			if item is TBBSMenuItem then begin
				if TBBSMenuItem( item ).Data = inBBS then begin
					item.Checked := True;
					// CabinetMenu ?? CabinetSelectPopupMenu ??????????????
					CabinetMenu.Items[ i ].Checked := True;
					GikoSys.Setting.CabinetIndex := i;
					Continue;
				end;
			end;
			item.Checked := False;
			// CabinetMenu ?? CabinetSelectPopupMenu ??????????????
			CabinetMenu.Items[ i ].Checked := False;
		end;
		CabinetSelectToolButton.Caption := inBBS.Title;

		GikoDM.CabinetHistoryAction.Checked := False;
		GikoDM.CabinetFavoriteAction.Checked := False;

		if (FTreeType <> gtt2ch) or (FActiveBBS <> inBBS) then begin
			FTreeType := gtt2ch;
			HistoryToolBar.Hide;
			FActiveBBS := inBBS;
			TListViewUtils.SetBoardTreeNode(inBBS, TreeView);
			TreeView.Items.GetFirstNode.Expanded := True;				//?c???[?g?b?v???????J??
			//?c???[??g?b?v?????I????
			if GetActiveList = nil then
				TreeView.Selected := TreeView.Items[0]
			else begin
				for i := 0 to TreeView.Items.Count - 1 do begin
					if TreeView.Items[i].Data = GetActiveList then begin
						TreeView.Selected := TreeView.Items[i];
						Exit;
					end;
				end;
				TreeView.Selected := TreeView.Items[0]
			end;
		end;
	except
	end;

end;

procedure TGikoForm.ShowBBSTree(
	inBBS : TBBS
);
var
	i, b		: Integer;
	item		: TMenuItem;
begin

	try
		FavoriteTreeView.Visible := False;
		FavoriteToolBar.Hide;
		TreeView.Visible := True;

		b := CabinetSelectPopupMenu.Items.Count - 1;
		for i := 0 to b do begin
			item := CabinetSelectPopupMenu.Items[ i ];
			if item is TBBSMenuItem then begin
				if TBBSMenuItem( item ).Data = inBBS then begin
					item.Checked := True;
					// CabinetMenu �� CabinetSelectPopupMenu �Ɠ����ƌ��߂��������Ⴄ
					CabinetMenu.Items[ i ].Checked := True;
					GikoSys.Setting.CabinetIndex := i;
					Continue;
				end;
			end;
			item.Checked := False;
			// CabinetMenu �� CabinetSelectPopupMenu �Ɠ����ƌ��߂��������Ⴄ
			CabinetMenu.Items[ i ].Checked := False;
		end;
		CabinetSelectToolButton.Caption := inBBS.Title;

		GikoDM.CabinetHistoryAction.Checked := False;
		GikoDM.CabinetFavoriteAction.Checked := False;

		if (FTreeType <> gtt2ch) or (FActiveBBS <> inBBS)
			or (not (CabinetPanel.Visible)) then begin
			FTreeType := gtt2ch;
			HistoryToolBar.Hide;
			FActiveBBS := inBBS;
			TListViewUtils.SetBoardTreeNode(inBBS, TreeView);
			TreeView.Items.GetFirstNode.Expanded := True;				//�c���[�g�b�v���ڂ������J��
			//�c���[�̃g�b�v���ڂ�I������
			if GetActiveList = nil then begin
				try
					TreeClick( TreeView.Items[0] );
				except
				end;
			end else begin
				for i := 0 to TreeView.Items.Count - 1 do begin
					if TreeView.Items[i].Data = GetActiveList then begin
						TreeClick( TreeView.Items[i] );
						Exit;
					end;
				end;
				TreeClick( TreeView.Items[0] );
			end;
		end;
	except
	end;

end;

procedure TGikoForm.ShowHistoryTree;
var
	i, b : Integer;
	item : TMenuItem;
begin
	if CabinetPanel.Visible then begin
		if FTreeType = gttHistory then begin
			CabinetVisible( False );
			GikoDM.CabinetHistoryAction.Checked := False;
		end else begin
			GikoDM.CabinetHistoryAction.Checked := True;
		end;
	end else begin
		CabinetVisible( True );
		GikoDM.CabinetHistoryAction.Checked := True;
	end;

	// BBS...BBS, History, Favorite
	GikoSys.Setting.CabinetIndex := CabinetSelectPopupMenu.Items.Count - 2;

	FavoriteTreeView.Visible := False;
	TreeView.Visible := True;

	GikoDM.CabinetBBSAction.Checked := False;
	GikoDM.CabinetFavoriteAction.Checked := False;

	if FTreeType <> gttHistory then begin
		b := CabinetSelectPopupMenu.Items.Count - 1;
		for i := 0 to b do begin
			item := CabinetSelectPopupMenu.Items[ i ];
			if item is TBBSMenuItem then begin
				item.Checked := False;
				// CabinetMenu �� CabinetSelectPopupMenu �Ɠ����ƌ��߂��������Ⴄ
				CabinetMenu.Items[ i ].Checked := False;
			end;
		end;

		FTreeType := gttHistory;
		HistoryToolBar.Show;
		FavoriteToolBar.Hide;
        FHistoryList.SetTreeNode( TreeView );
		CabinetSelectToolButton.Caption := '�������X�g';
	end;
end;

procedure TGikoForm.SelectTreeNode(Item: TObject; CallEvent: Boolean);
var
	ChangeEvent: TTVChangedEvent;
	ChangingEvent: TTVChangingEvent;
	i: Integer;
	bbs : TBBS;
begin
	if Item is TCategory then
		bbs := TCategory( Item ).ParenTBBS
	else if Item is TBoard then
		bbs := TBoard( Item ).ParentCategory.ParenTBBS
	else
		bbs := nil;

	if (FTreeType = gtt2ch) and (FActiveBBS = bbs) then begin
		if Item <> FActiveList then begin
			ChangeEvent := nil;
			ChangingEvent := nil;

			if not CallEvent then begin
				ChangeEvent := TreeView.OnChange;
				ChangingEvent := TreeView.OnChanging;
			end;
			try
				if not CallEvent then begin
					TreeView.OnChange := nil;
					TreeView.OnChanging := nil;
				end;
				//Application.ProcessMessages;
				for i := 0 to TreeView.Items.Count - 1 do begin
					if TreeView.Items[i].Data = Item then begin
						TreeView.Items[i].Selected := True;
						if CallEvent then
							TreeClick(TreeView.Items[i]);
						Break;
					end;
				end;
				//Application.ProcessMessages;
			finally
				if not CallEvent then begin
					TreeView.OnChange := ChangeEvent;
					TreeView.OnChanging := ChangingEvent;
				end;
			end;
		end;
	end else begin
		if Item <> FActiveList then begin
			ActiveListColumnSave;
			if (Item is TBBS) or (Item is TCategory) then begin
				ListView.Columns.Clear;
				SetActiveList( Item );
			end else if Item is TBoard then begin
				if not TBoard( Item ).IsThreadDatRead then begin
					Screen.Cursor := crHourGlass;
					try
						if not TBoard( Item ).IsThreadDatRead then
							GikoSys.ReadSubjectFile(TBoard( Item ));
					finally
						Screen.Cursor := crDefault;
					end;
				end;
				Sort.SetSortDate(Now());
				SetActiveList( Item );
			end;
		end;
	end;

	if Item is TBoard then begin // not TCategory
		if GikoSys.Setting.ListOrientation = gloHorizontal then begin
			if GikoSys.Setting.ListWidthState = glsMax then begin
				GikoDM.BrowserMinAction.Execute;
				if GikoForm.Visible then
					ListView.SetFocus;
			end;
		end else begin
			if GikoSys.Setting.ListHeightState = glsMax then begin
				GikoDM.BrowserMinAction.Execute;
				if GikoForm.Visible then
					ListView.SetFocus;
			end;
		end;
	end;
end;

procedure TGikoForm.ListViewMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	listItem		: TListItem;
	threadItem	: TThreadItem;
	pos					: TPoint;
//	t: Cardinal;
begin
	case Button of
	mbMiddle:
		begin
			if not (GetActiveList is TBoard) then Exit;
			listItem := ListView.GetItemAt( X, Y );
			if listItem = nil then Exit;
			if not (TObject(listItem.Data) is TThreadItem) then Exit;

			threadItem := TThreadItem(ListItem.Data);
			InsertBrowserTab(threadItem, False);
			if threadItem.IsLogFile then
				ListView.UpdateItems(listItem.Index, listItem.Index);
		end;
	mbLeft:
		begin
			//������DblClick�E��Ȃ��ƁAClick�C�x���g���D�悵�ċN���Ă��܂��̂�
			if (ssDouble in Shift) then
				ListDoubleClick(Shift)
			else
				ListClick;
		end;
	mbRight:
		begin
			pos.X := X;
			pos.Y := Y;
			Windows.ClientToScreen( ListView.Handle, pos );
			ListPopupMenu.Popup( pos.X, pos.Y );
		end;
	end;

end;

procedure TGikoForm.ListClick;
var
	ListItem: TListItem;
	ThreadItem: TThreadItem;
begin
	if ListView.SelCount <> 1 then Exit;
	ListItem := ListView.Selected;
	if ListItem = nil then Exit;
	if not (TObject(ListItem.Data) is TThreadItem) then Exit;

	ThreadItem := TThreadItem(ListItem.Data);
	if ThreadItem.IsLogFile then begin
		InsertBrowserTab(ThreadItem);
		ListView.UpdateItems(ListItem.Index, ListItem.Index);
	end else begin
		InsertBrowserTab(ThreadItem);
	end;

	if GikoSys.Setting.BrowserAutoMaximize = gbmClick then begin
		if GikoSys.Setting.ListOrientation = gloHorizontal then begin
			if GikoSys.Setting.ListWidthState = glsMin then begin
				GikoDM.BrowserMaxAndFocusAction.Execute;
			end;
		end else begin
			if GikoSys.Setting.ListHeightState = glsMin then begin
				GikoDM.BrowserMaxAndFocusAction.Execute;
			end;
		end;
	end;
end;

procedure TGikoForm.ListDoubleClick(Shift: TShiftState);
var
	ThreadItem: TThreadItem;
	shiftDown: Boolean;
begin
	shiftDown := (ssShift in Shift);

	if ListView.Selected = nil then Exit;

	if TObject(ListView.Selected.Data) is TCategory then begin
		SelectTreeNode(ListView.Selected.Data, True);
	end else if TObject(ListView.Selected.Data) is TBoard then begin
		SelectTreeNode(ListView.Selected.Data, True)
	end else if TObject(ListView.Selected.Data) is TThreadItem then begin
		Application.ProcessMessages;
		ThreadItem := TThreadItem(ListView.Selected.Data);
		DownloadContent(ThreadItem, shiftDown);

		if GikoSys.Setting.BrowserAutoMaximize = gbmDoubleClick then begin
			if GikoSys.Setting.ListOrientation = gloHorizontal then begin
				if GikoSys.Setting.ListWidthState = glsMin then begin
					GikoDM.BrowserMaxAction.Execute;
					GikoDM.SetFocusForBrowserAction.Execute;
				end;
			end else begin
				if GikoSys.Setting.ListHeightState = glsMin then begin
					GikoDM.BrowserMaxAction.Execute;
					GikoDM.SetFocusForBrowserAction.Execute;
				end;
			end;
		end;
	end;
end;

procedure TGikoForm.BrowserMovement(const AName: string);
begin
	// Access Violation ���N���鎖������̂ō���v�`�F�b�N
	if(BrowserTab.Tabs.Count > 0) and (BrowserTab.TabIndex >= 0)
		and (FActiveContent <> nil) then begin
		FActiveContent.Move(AName);
	end;
end;
//���ݕ\�����Ă���X���b�h���X�N���[��
procedure TGikoForm.BrowserMovement(scroll: Integer);
begin
	if(BrowserTab.Tabs.Count > 0) and (BrowserTab.TabIndex >= 0)
		and (FActiveContent <> nil) then begin
		FActiveContent.Move(scroll);
	end;
end;
procedure TGikoForm.TreeViewCollapsed(Sender: TObject; Node: TTreeNode);
begin
	if TObject(Node.Data) is TBBS then begin
		TBBS(Node.Data).NodeExpand := False;
	end else if TObject(Node.Data) is TCategory then begin
		TCategory(Node.Data).NodeExpand := False;
	end else if TObject(Node.Data) is TBoard then begin
		TBoard(Node.Data).NodeExpand := False;
	end;
	if (TreeView.Selected <> nil) and (TreeView.Selected = Node) then begin
    	TreeClick(TreeView.Selected);
	end;
end;

procedure TGikoForm.MessageListViewResize(Sender: TObject);
begin
//	MessageListView.Column[0].Width := MessageListView.ClientWidth - 16;
end;
procedure	TGikoForm.CabinetVisible( isVisible : Boolean );
begin
	TreeSplitter.Visible := isVisible;
	CabinetPanel.Visible := isVisible;
	GikoDM.CabinetVisibleAction.Checked := isVisible;
end;

procedure TGikoForm.SelectListItem(List: TList);
var
	TmpListItem: TListItem;
begin
	List.Clear;
	List.Capacity := 0;
	TmpListItem := ListView.Selected;
	while TmpListItem <> nil do begin
		List.Add(TmpListItem.Data);
		TmpListItem := ListView.GetNextItem(TmpListItem, sdAll, [isSelected]);
	end;

end;

procedure TGikoForm.FormResize(Sender: TObject);
begin

	MessageListView.Column[0].Width := MessageListView.ClientWidth - 32;
	MainCoolBar.Width := TopPanel.Width - TopRightPanel.Width;

	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		if GikoSys.Setting.ListWidthState = glsMin then begin
			// �ŏ��\���ɂ���
			ViewPanel.Width := ThreadMainPanel.Width - 80;
		end;
	end else begin
		if GikoSys.Setting.ListHeightState = glsMin then begin
			// �ŏ��\���ɂ���
			ViewPanel.Height := ThreadMainPanel.Height - BrowserCoolBar.Height - 7;
		end;
	end;

	FIsIgnoreResize := rtResizing;
	PostMessage( Handle, USER_RESIZED, 0, 0 );


end;

procedure TGikoForm.DeleteTab(BrowserRecord: TBrowserRecord);
var
	i: Integer;
begin
	FTabHintIndex := -1;
	for i := 0 to BrowserTab.Tabs.Count - 1 do begin
		if TBrowserRecord(BrowserTab.Tabs.Objects[i]) = BrowserRecord then begin
            DeleteTab(i, BrowserTab.TabIndex);
			Break;
		end;
	end;
end;
procedure TGikoForm.DeleteTab(ThreadItem: TThreadItem);
var
	i: Integer;
begin
	FTabHintIndex := -1;
	for i := 0 to BrowserTab.Tabs.Count - 1 do begin
		if TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread = ThreadItem then begin
            DeleteTab(i, BrowserTab.TabIndex);
			Break;
		end;
	end;
end;
procedure TGikoForm.DeleteTab(index, selectIndex: Integer);
var
    browserRec : TBrowserRecord;
    doc: OleVariant;
    j: Integer;
begin
    browserRec := TBrowserRecord(BrowserTab.Tabs.Objects[index]);
    try
        if browserRec.Browser <> nil then begin
            doc := browserRec.Browser.OleObject.Document;
            browserRec.Thread.ScrollTop := doc.Body.ScrollTop;
        end;
    except
        browserRec.Thread.ScrollTop := 0;
    end;

    if(FActiveContent = browserRec) then
        FActiveContent := nil;
    if browserRec.Browser <> nil then begin
        j := FBrowsers.IndexOf(browserRec.Browser);
        if j <> -1 then
            FBrowsers.Move(j, BROWSER_COUNT - 1);
    end;

    BrowserTab.Tabs.BeginUpdate;
    try
        GikoSys.Setting.LastCloseTabURL := browserRec.Thread.URL;
        browserRec.Free;
        if ( BrowserTab.Tabs.Count - 1 = index ) and
            ( BrowserTab.TabRect(index).Left
                <= BrowserTab.DisplayRect.Left ) then begin
            BrowserTab.ScrollTabs(-1);
        end;
        BrowserTab.Tabs.Delete(index);
        if selectIndex > index then begin
            BrowserTab.TabIndex := selectIndex - 1;
        end else begin
            if BrowserTab.Tabs.Count -1 >= selectIndex then
                BrowserTab.TabIndex := selectIndex
            else
                BrowserTab.TabIndex := BrowserTab.Tabs.Count - 1;
        end;
    finally
        BrowserTab.Tabs.EndUpdate;
    end;
    if BrowserTab.Tabs.Count = 0 then begin
        BrowserNullTab.Thread := nil;
    end;

    if(BrowserTab.TabIndex <> -1) and
        ( TBrowserRecord(BrowserTab.Tabs.Objects[BrowserTab.TabIndex]).Browser = nil) then begin
        // ��ԌÂ��u���E�U���J������
        ReleaseOldestBrowser;

        TBrowserRecord(BrowserTab.Tabs.Objects[BrowserTab.TabIndex]).Browser
             :=  TWebBrowser(FBrowsers[BROWSER_COUNT - 1]);
        TBrowserRecord(BrowserTab.Tabs.Objects[BrowserTab.TabIndex]).Repaint := true;
        FBrowsers.Move(BROWSER_COUNT - 1, 0);
    end;

    if( FActiveContent = nil) then
        BrowserTab.OnChange(nil);
end;
function TGikoForm.Hook(var Message: TMessage): Boolean;
begin
	//�T�u�t�H�[�������C�����j���[�������Ȃ��Ƃ��ɁA���C���t�H�[����
	//���j���[�̃V���[�g�J�b�g�L�[���T�u���j���[������͂����̂����
	Result := False;
	case Message.Msg of
	CM_APPKEYDOWN:
		Result := True;		//�V���[�g�J�b�g�L�[����
	CM_APPSYSCOMMAND:
		Result := True;  // �A�N�Z�����[�^�𖳌��ɂ���
	end;
end;

procedure TGikoForm.ListPopupMenuPopup(Sender: TObject);
var
    bBoard, bCategory : Boolean;
begin
    bBoard := (GetActiveList is TBoard);
    bCategory := (GetActiveList is TCategory);
	ItemRoundPMenu.Visible := bBoard;
	ItemReservPMenu.Visible := bBoard;
	LPMSep01.Visible := bBoard;
	ListRoundPMenu.Visible := bCategory;// or (GetActiveList is TBoard);
	ListReservPMenu.Visible := bCategory;// or (GetActiveList is TBoard);
	LPMSep02.Visible := bCategory or bBoard;
	KidokuPMenu.Visible := bBoard;
	MidokuPMenu.Visible := bBoard;
	UrlCopyPMenu.Visible := bCategory or bBoard;
	NameUrlCopyPMenu.Visible := bCategory or bBoard;
	AllSelectPMenu.Visible := bCategory or bBoard;
	LPMSep05.Visible := bCategory or bBoard;
	DeletePMenu.Visible := bBoard;
	LPMSep06.Visible := bCategory or bBoard;
	BoardFavoriteAddMenu.Visible := bCategory;
	ThreadFavoriteAddMenu.Visible := bBoard;
    SaveThreadFile.Visible := bBoard;
	AddRoundNameMenu(ItemReservPMenu);
	AddRoundNameMenu(ListReservPMenu);
end;

procedure TGikoForm.TreePopupMenuPopup(Sender: TObject);
begin
	FClickNode := TreeView.Selected;
	if FClickNode = nil then begin
		TreeSelectThreadPupupMenu.Visible := False;
		TreeSelectBoardPupupMenu.Visible := False;
		TPMSep01.Visible := False;
		TreeSelectURLPupupMenu.Visible := False;
		TreeSelectNamePupupMenu.Visible := False;
		TreeSelectNameURLPupupMenu.Visible := False;
		TreeSelectFavoriteAddPupupMenu.Visible := False;
		TreeSelectLogDeleteSeparator.Visible := False;
		TreeSelectLogDeletePopupMenu.Visible := False;
        SearchBoardName.Visible := False;
	end else if TObject(FClickNode.Data) is TBoard then begin
		TreeSelectThreadPupupMenu.Visible := False;
		TreeSelectBoardPupupMenu.Visible := True;
		TPMSep01.Visible := True;
		TreeSelectURLPupupMenu.Visible := True;
		TreeSelectNamePupupMenu.Visible := True;
		TreeSelectNameURLPupupMenu.Visible := True;
		TreeSelectFavoriteAddPupupMenu.Visible := True;
		TreeSelectLogDeleteSeparator.Visible := False;
		TreeSelectLogDeletePopupMenu.Visible := False;
        SearchBoardName.Visible := True;
	end else if TObject(FClickNode.Data) is TFavoriteBoardItem then begin
		TreeSelectThreadPupupMenu.Visible := False;
		TreeSelectBoardPupupMenu.Visible := True;
		TPMSep01.Visible := True;
		TreeSelectURLPupupMenu.Visible := True;
		TreeSelectNamePupupMenu.Visible := True;
		TreeSelectNameURLPupupMenu.Visible := True;
		TreeSelectFavoriteAddPupupMenu.Visible := True;
		TreeSelectLogDeleteSeparator.Visible := False;
		TreeSelectLogDeletePopupMenu.Visible := False;
        SearchBoardName.Visible := False;
	end else if (TObject(FClickNode.Data) is TThreadItem) then begin
		TreeSelectThreadPupupMenu.Visible := True;
		TreeSelectBoardPupupMenu.Visible := False;
		TPMSep01.Visible := True;
		TreeSelectURLPupupMenu.Visible := True;
		TreeSelectNamePupupMenu.Visible := True;
		TreeSelectNameURLPupupMenu.Visible := True;
		TreeSelectFavoriteAddPupupMenu.Visible := True;
		TreeSelectLogDeleteSeparator.Visible := True;
		TreeSelectLogDeletePopupMenu.Visible := True;
        SearchBoardName.Visible := False;
	end else if (TObject(FClickNode.Data) is TFavoriteThreadItem) then begin
		TreeSelectThreadPupupMenu.Visible := True;
		TreeSelectBoardPupupMenu.Visible := False;
		TPMSep01.Visible := True;
		TreeSelectURLPupupMenu.Visible := True;
		TreeSelectNamePupupMenu.Visible := True;
		TreeSelectNameURLPupupMenu.Visible := True;
		TreeSelectFavoriteAddPupupMenu.Visible := True;
		TreeSelectLogDeleteSeparator.Visible := True;
		TreeSelectLogDeletePopupMenu.Visible := True;
        SearchBoardName.Visible := False;
	end else if (TObject(FClickNode.Data) is TCategory) then begin
		TreeSelectThreadPupupMenu.Visible := False;
		TreeSelectBoardPupupMenu.Visible := False;
		TPMSep01.Visible := False;
		TreeSelectURLPupupMenu.Visible := False;
		TreeSelectNamePupupMenu.Visible := True;
		TreeSelectNameURLPupupMenu.Visible := False;
		TreeSelectFavoriteAddPupupMenu.Visible := False;
		TreeSelectLogDeleteSeparator.Visible := False;
		TreeSelectLogDeletePopupMenu.Visible := False;
        SearchBoardName.Visible := True;
	end else if FClickNode.IsFirstNode then begin
		TreeSelectThreadPupupMenu.Visible := False;
		TreeSelectBoardPupupMenu.Visible := False;
		TPMSep01.Visible := False;
		TreeSelectURLPupupMenu.Visible := False;
		TreeSelectNamePupupMenu.Visible := True;
		TreeSelectNameURLPupupMenu.Visible := False;
		TreeSelectFavoriteAddPupupMenu.Visible := False;
		TreeSelectLogDeleteSeparator.Visible := False;
		TreeSelectLogDeletePopupMenu.Visible := False;
        SearchBoardName.Visible := True;
	end else begin
		TreeSelectThreadPupupMenu.Visible := False;
		TreeSelectBoardPupupMenu.Visible := False;
		TPMSep01.Visible := False;
		TreeSelectURLPupupMenu.Visible := False;
		TreeSelectNamePupupMenu.Visible := False;
		TreeSelectNameURLPupupMenu.Visible := False;
		TreeSelectFavoriteAddPupupMenu.Visible := False;
		TreeSelectLogDeleteSeparator.Visible := False;
		TreeSelectLogDeletePopupMenu.Visible := False;
        SearchBoardName.Visible := False;
	end;
end;

procedure TGikoForm.BrowserNewWindow2(Sender: TObject;
	var ppDisp: IDispatch; var Cancel: WordBool);
var
	Text: string;
	Html: string;
	URL: string;
	idx: Integer;
	wkIntSt: Integer;
	wkIntTo: Integer;
    BNum, BRes: string;
    threadItem: TThreadItem;
    aElement : IHTMLElement;
    senderBrowser : TWebBrowser;
    doc : IHTMLDocument2;
begin
{$IFDEF DEBUG}
	Writeln(IntToStr(Integer(ppDisp)));
{$ENDIF}
	Cancel := True;

	if not( TObject(Sender) is TWebBrowser )then
		Exit;

    senderBrowser := TWebBrowser(Sender);
    doc := senderBrowser.ControlInterface.Document as IHTMLDocument2;
	if not Assigned(doc) then
		Exit;

	aElement := doc.activeElement;
	if not Assigned(aElement) then
		Exit;

	Text := aElement.Get_outerText;
	Html := aElement.Get_outerHTML;

	if(AnsiPos('>>', Text) = 1) or (AnsiPos('>', Text) = 1)
		or (AnsiPos('����', Text) = 1) or (AnsiPos('��', Text) = 1) then begin
		if GikoSys.Setting.ResAnchorJamp then begin

			Text := ZenToHan(Trim(Text));

			if(AnsiPos('>>', Text) = 1) then begin
				//Text := Copy(Text, 3, Length(Text) - 2);
				Delete(Text, 1, 2);
			end else begin
				//Text := Copy(Text, 2, Length(Text) - 1);
				Delete(Text, 1, 1);
			end;

			if AnsiPos('-', Text) <> 0 then begin
				wkIntSt := StrToIntDef(Copy(Text, 1, AnsiPos('-', Text) - 1), 0);
				Text := Copy(Text, AnsiPos('-', Text) + 1, Length(Text));
				wkIntTo := StrToIntDef(Text, 0);
				if wkIntTo < wkIntSt then
					wkIntSt := wkIntTo;
			end else begin
				wkIntSt := StrToIntDef(Text, 0);
			end;

			if wkIntSt <> 0 then begin
            	FActiveContent.IDAnchorPopup('');
                MoveHisotryManager.pushItem(FActiveContent);
                if (Sender is TResPopupBrowser) then begin
                    TResPopupBrowser(Sender).ChildClear;
                    OpenThreadItem(
                        GetActiveContent(true),
                        GetActiveContent(true).URL + '&st=' +
                             IntToStr(wkIntSt) + '&to=' + IntToStr(wkIntSt));
                end else begin
					BrowserMovement(IntToStr(wkIntSt));
                end;
            end;
		end;
	end else begin
        ////'http://be.2ch.net/test/p.php?i='+id+'&u=d:'+bas+num

		URL := GikoSys.GetHRefText(Html);
		URL := GikoSys.HTMLDecode(URL);
        if AnsiPos('BE:', URL) = 1 then begin
			BNum := Copy(URL, 4, AnsiPos('/', URL) - 4);
			BRes := Copy(URL, AnsiPos('/', URL) + 1,  Length(URL));
            threadItem := FActiveContent.Thread;
            if threadItem = nil then Exit;
            URL := BE_PHP_URL + BNum + '&u=d'
            	+ CustomStringReplace(threadItem.URL, 'l50', '') + BRes;
        end;

		if( AnsiPos('http://', URL) = 1) or (AnsiPos('https://', URL) = 1) or
			( AnsiPos('ftp://', URL) = 1) then begin
			//�A�h���X�o�[�̗���
			if GikoSys.Setting.LinkAddAddressBar then begin
				idx := AddressComboBox.Items.IndexOf(URL);
				if idx = -1 then begin
					AddressComboBox.Items.Insert(0, URL);
					if AddressComboBox.Items.Count > GikoSys.Setting.AddressHistoryCount then
						AddressComboBox.Items.Delete(AddressComboBox.Items.Count - 1);
				end else begin
					AddressComboBox.Items.Delete(idx);
					AddressComboBox.Items.Insert(0, URL);
				end;
			end;
            if (Sender is TResPopupBrowser) then begin
                TResPopupBrowser(Sender).ChildClear
            end;

            MoveHisotryManager.pushItem(FActiveContent);
			MoveToURL( URL );
		end;
	end;

end;

procedure TGikoForm.ListSplitterMoved(Sender: TObject);
begin
	if Mouse.Capture <> 0 then
		Exit;
	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		if (ViewPanel.Width > 1) and (ViewPanel.Width <= (ThreadMainPanel.Width - 80)) then
			FBrowserSizeWidth := ViewPanel.Width;
	end else begin
		if (ViewPanel.Height > 1) and (ViewPanel.Height <= (ThreadMainPanel.Height - BrowserCoolBar.Height)) then
			FBrowserSizeHeight := ViewPanel.Height;
	end;
	if GikoSys.Setting.ListOrientation = gloHorizontal then begin
		if ViewPanel.Width < 2 then begin
			ViewPanel.Width := 1;
			GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_NORMAL;
			GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_MIN;
			GikoSys.Setting.ListWidthState := glsMax;
		end else if ViewPanel.Width > (ThreadMainPanel.Width - 80) then begin
			GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_MAX;
			GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_NORMAL;
			GikoSys.Setting.ListWidthState := glsMin;
		end else begin
			GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_MAX;
			GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_WIDTH_MIN;
			GikoSys.Setting.ListWidthState := glsNormal;
		end;
	end else begin
		if ViewPanel.Height < 2 then begin
			ViewPanel.Height := 1;
			GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_NORMAL;
			GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_MIN;
			GikoSys.Setting.ListHeightState := glsMax;
		end else if ViewPanel.Height > (ThreadMainPanel.Height - BrowserCoolBar.Height - 7) then begin
			GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_MAX;
			GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_NORMAL;
			GikoSys.Setting.ListHeightState := glsMin;
		end else begin
			GikoDM.BrowserMaxAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_MAX;
			GikoDM.BrowserMinAction.ImageIndex := GikoDataModule.TOOL_ICON_HEIGHT_MIN;
			GikoSys.Setting.ListHeightState := glsNormal;
		end;
	end;
{	if (Mouse.Capture = 0) and (ViewPanel.Height > 1) and (not ArrangeAction.Checked) then
		FBrowserSizeHeight := ViewPanel.Height
	else if (Mouse.Capture = 0) and (ViewPanel.Width > 1) and (ArrangeAction.Checked) then
		FBrowserSizeWidth := ViewPanel.Width;}
end;

procedure TGikoForm.BrowserTabChange(Sender: TObject);
var
	j: Integer;
	idx: Integer;
begin
	BrowserTab.Tabs.BeginUpdate;
	try
		if not BrowserTab.Dragging then begin
			FTabHintIndex := -1;
			BrowserTab.Hint := '';
			idx := BrowserTab.TabIndex;
			if idx = -1 then begin
				SetContent(BrowserNullTab);

			end else if(BrowserTab.Tabs.Objects[idx] <> nil) and (BrowserTab.Tabs.Objects[idx] is TBrowserRecord) then begin
				if TBrowserRecord(BrowserTab.Tabs.Objects[idx]).Browser <> nil then begin
					j := FBrowsers.IndexOf(TBrowserRecord(BrowserTab.Tabs.Objects[idx]).Browser);
					if j <> -1 then
						FBrowsers.Move(j ,0);
				end else begin
					if( FActiveContent <> nil ) and (FActiveContent.Browser <> nil) and
						(FActiveContent.Browser <> BrowserNullTab.Browser) and
						(FActiveContent.Browser = TWebBrowser(FBrowsers[BROWSER_COUNT - 1])) then
						FBrowsers.Move(BROWSER_COUNT - 1, 0);

                    // ��ԌÂ��u���E�U���J������
                    ReleaseOldestBrowser;

					TBrowserRecord(BrowserTab.Tabs.Objects[idx]).Browser := TWebBrowser(FBrowsers[BROWSER_COUNT - 1]);
					TBrowserRecord(BrowserTab.Tabs.Objects[idx]).Repaint := true;
					FBrowsers.Move(BROWSER_COUNT - 1, 0);
				end;
				MoveWindow(TBrowserRecord(BrowserTab.Tabs.Objects[idx]).Browser.Handle, 0, 0, BrowserPanel.Width, BrowserPanel.Height, false);
				TOleControl(TBrowserRecord(BrowserTab.Tabs.Objects[idx]).Browser).BringToFront;
				SetContent(TBrowserRecord(BrowserTab.Tabs.Objects[idx]));

				if (GikoSys.Setting.URLDisplay) and (GetActiveContent <> nil) then
					AddressComboBox.Text := GetActiveContent.URL;

				if ((TreeView.Visible) and (TreeView.Focused)) or ((FavoriteTreeView.Visible) and (FavoriteTreeView.Focused)) or
					(ListView.Focused) or (SelectComboBox.Focused) or (AddressComboBox.Focused)
				then
				else
					GikoDM.SetFocusForBrowserAction.Execute;
			end;
		end;
	finally
		BrowserTab.Tabs.EndUpdate;
	end;
end;


procedure TGikoForm.BrowserTabMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	p: TPoint;
	p2: TPoint;
	idx: Integer;
begin
	if Button = mbMiddle then begin
		// �}�E�X���{�^��
		GetCursorPos(p);
		p2 := p;
		p := BrowserTab.ScreenToClient(p);
		idx := BrowserTab.IndexOfTabAt(p.X, p.Y);
		if idx <> -1 then
			DeleteTab(TBrowserRecord(BrowserTab.Tabs.Objects[idx]));
	end else if Button = mbLeft then begin
		FDragWFirst := true;
		FMouseDownPos.X := X;
		FMouseDownPos.Y := Y;
	end;

end;

procedure TGikoForm.SetBrowserTabState;
var
	CoolBand: TCoolBand;
begin
	BrowserBottomPanel.AutoSize := False;
	if GikoSys.Setting.BrowserTabVisible then begin
		BrowserTab.Hide;
		BrowserTab.Tabs.BeginUpdate;
		try
			if GikoSys.Setting.BrowserTabStyle = gtsTab then begin
				BrowserTab.Style := tsTabs;
				if GikoSys.Setting.BrowserTabPosition = gtpTop then
					BrowserTab.TabPosition := tpTop
				else
					BrowserTab.TabPosition := tpBottom;
			end else if GikoSys.Setting.BrowserTabStyle = gtsButton then begin
				BrowserTab.TabPosition := tpTop;
				BrowserTab.Style := tsButtons;
			end else begin
				BrowserTab.TabPosition := tpTop;
				BrowserTab.Style := tsFlatButtons
			end;

			if GikoSys.Setting.BrowserTabPosition = gtpTop then begin
				BrowserTab.Parent := BrowserTabToolBar;
				BrowserBottomPanel.Hide;
				CoolBand := GetCoolBand(BrowserCoolBar, BrowserTabToolBar);
				if CoolBand <> nil then
					CoolBand.Visible := True;
			end else begin
				BrowserTab.Parent := BrowserBottomPanel;
				BrowserTab.Top := 0;
				BrowserTab.Left := 0;
				BrowserBottomPanel.Show;
				CoolBand := GetCoolBand(BrowserCoolBar, BrowserTabToolBar);
				if CoolBand <> nil then
					CoolBand.Visible := False;
			end;
		finally
			BrowserTab.Tabs.EndUpdate;
			BrowserTab.Show;
		end;
	end else begin
		CoolBand := GetCoolBand(BrowserCoolBar, BrowserTabToolBar);
		if CoolBand <> nil then
			CoolBand.Visible := False;
		BrowserBottomPanel.Visible := False;
		GikoDM.AllTabCloseAction.Execute;
	end;
end;

procedure TGikoForm.BrowserTabDragOver(Sender, Source: TObject; X,
	Y: Integer; State: TDragState; var Accept: Boolean);
var
	idx: Integer;
begin
	idx := BrowserTab.IndexOfTabAt(X, Y);
	Accept := (Source = BrowserTab) and (BrowserTab.TabIndex <> idx);
end;

procedure TGikoForm.BrowserTabDragDrop(Sender, Source: TObject; X,
	Y: Integer);
var
	idx: Integer;
begin
    FDragWFirst := False;
	idx := BrowserTab.IndexOfTabAt(X, Y);
	if idx <> -1 then
		BrowserTab.Tabs.Move(BrowserTab.TabIndex, idx);
end;

procedure TGikoForm.BrowserTabMouseMove(Sender: TObject;
	Shift: TShiftState; X, Y: Integer);
var
	TabIdx: Integer;
	ThreadItem: TThreadItem;
begin

	TabIdx := BrowserTab.IndexOfTabAt(x, y);

	if ( ssLeft in Shift ) then begin
        if (FDragWFirst) then begin
			BrowserTab.EndDrag(false);
			BrowserTab.BeginDrag(false, DandD_THRESHOLD);
        end;
	end else begin
		BrowserTab.EndDrag(false);
		FDragWFirst := false;
	end;
	
	if (FTabHintIndex <> TabIdx) and (TabIdx <> -1) then begin
		Application.CancelHint;
		ThreadItem := TBrowserRecord(BrowserTab.Tabs.Objects[TabIdx]).Thread;
		if ThreadItem.Title <> BrowserTab.Tabs[TabIdx] then begin
			BrowserTab.Hint := ThreadItem.Title;
			Application.ShowHint := True;
		end else begin
			BrowserTab.Hint := '';
			Application.ShowHint := True;
		end;
		FTabHintIndex := TabIdx;
	end;

end;

procedure TGikoForm.BrowserDocumentComplete(Sender: TObject;
	const pDisp: IDispatch; var URL: OleVariant);
var
	BrowserRecord :TBrowserRecord;
	i :Integer;
	doc	: IHTMLDocument2;
	threadItem	: TThreadItem;
begin
	if TObject(Sender) is TWebBrowser then begin
		BrowserRecord := nil;
		if TWebBrowser(Sender) <> Browser then begin
			for i := BrowserTab.Tabs.Count - 1 downto 0 do begin
				if TBrowserRecord(BrowserTab.Tabs.Objects[i]).Browser = TWebBrowser(Sender) then begin
						BrowserRecord := TBrowserRecord(BrowserTab.Tabs.Objects[i]);
						break;
				end;
			end;
			if BrowserRecord <> nil then begin
				if BrowserRecord.Event <> nil then
					BrowserRecord.Event.Free;
				BrowserRecord.Event := THTMLDocumentEventSink.Create(Self, BrowserRecord.Browser.ControlInterface.Document, HTMLDocumentEvents2);
				BrowserRecord.Event.OnContextMenu := OnDocumentContextMenu;
				BrowserRecord.Event.OnClick := WebBrowserClick;  //�ǉ�����OnClick�C�x���g
			end;
		end else begin
			if GetActiveContent <> nil then begin
				if FEvent <> nil then
					FEvent.Free;
				FEvent := THTMLDocumentEventSink.Create(Self, Browser.ControlInterface.Document, HTMLDocumentEvents2);
				FEvent.OnContextMenu := OnDocumentContextMenu;
				FEvent.OnClick := WebBrowserClick;  //�ǉ�����OnClick�C�x���g
			end else begin
				if FEvent <> nil then begin
					FEvent.Free;
					FEvent := nil;
				end;
			end;

		end;

		if (BrowserRecord <> nil) and
			 Assigned( BrowserRecord.Thread ) then begin
			threadItem := BrowserRecord.Thread;

			if (threadItem.JumpAddress > 0) then begin
				if threadItem.UnRead then begin
					threadItem.UnRead := False;
					TreeView.Refresh;
					RefreshListView(threadItem);
				end;
				// �X�N���[���悪�擾�O�̃��X�̎��͏I�[�Ɉړ�
				//if (StrToIntDef(BrowserRecord.Movement, 0) <= BrowserRecord.Thread.Count) then begin
				if (threadItem.JumpAddress <= BrowserRecord.Thread.Count) then begin
					BrowserRecord.Move(IntToStr(threadItem.JumpAddress));
					threadItem.JumpAddress := 0;
				end else begin
					BrowserRecord.Move(IntToStr(BrowserRecord.Thread.Count));
				end;

			end else if threadItem.UnRead then begin
				threadItem.UnRead := False;
				TreeView.Refresh;
				BrowserRecord.Move('new');
				RefreshListView(threadItem);
			end else if threadItem.ScrollTop <> 0 then begin
				try
					doc := BrowserRecord.Browser.ControlInterface.Document as IHTMLDocument2;
					(doc.body as IHTMLElement2).ScrollTop := threadItem.ScrollTop;
				except
					on E: Exception do
						MsgBox(Handle, E.Message, 'SetContent[ScrollTop<-]', 0);
				end;
			end;
		end;
	end;
	LockWindowUpdate(0);
end;

procedure TGikoForm.RoundNamePopupMenuPopup(Sender: TObject);
begin
	AddRoundNameMenu(RoundNamePopupMenu.Items);
end;

procedure TGikoForm.AddRoundNameMenu(MenuItem: TMenuItem);
var
	i: Integer;
	Item: TMenuItem;
begin
	MenuItem.Clear;
	Item := TMenuItem.Create(Self);
	Item.Caption := '�V�������O�ŏ���\��(&N)...';
	Item.OnClick := GikoDM.SelectNewRoundNameExecute;
	MenuItem.Add(Item);
	Item := TMenuItem.Create(Self);
	Item.Caption := '���񃊃X�g����폜(&D)';
	Item.OnClick := GikoDM.SelectDeleteRoundExecute;
	MenuItem.Add(Item);
	Item := TMenuItem.Create(Self);
	Item.Caption := '-';
	MenuItem.Add(Item);
	for i := 0 to RoundList.RoundNameList.Count - 1 do begin
		Item := TMenuItem.Create(Self);
		Item.Caption := RoundList.RoundNameList[i];
		Item.OnClick := SetSelectRoundName;
		MenuItem.Add(Item);
	end;
end;

procedure TGikoForm.SetSelectItemRound(RoundFlag: Boolean; RoundName: string; ParentName: string);
var
	threadItem : TThreadItem;
begin
	if ParentName <> 'RoundItem' then begin
		SetSelectItemRound(RoundFlag, RoundName);
	end else begin
		threadItem := GetActiveContent;
		if threadItem <> nil then begin
			threadItem.RoundName := RoundName;
			if RoundFlag then
				RoundList.RoundNameList.Add(RoundName);
			threadItem.Round := RoundFlag;
		end;
	end;
end;

procedure TGikoForm.SetSelectItemRound(RoundFlag: Boolean; RoundName: string);
var
	i{, idx}: Integer;
	List: TList;
begin
	List := TList.Create;
	try
		SelectListItem(List);
		for i := 0 to List.Count - 1 do begin
			if TObject(List[i]) is TBoard then begin
				TBoard(List[i]).RoundName := RoundName;
				if RoundFlag then
					RoundList.RoundNameList.Add(RoundName);
				TBoard(List[i]).Round := RoundFlag;
			end else if TObject(List[i]) is TThreadItem then begin
				if TThreadItem(List[i]).IsLogFile then begin
					TThreadItem(List[i]).RoundName := RoundName;
					if RoundFlag then
						RoundList.RoundNameList.Add(RoundName);
					TThreadItem(List[i]).Round := RoundFlag;
				end;
			end;
		end;
	finally
		List.Free;
	end;
end;

procedure TGikoForm.SetSelectRoundName(Sender: TObject);
var
	MenuItem: TMenuItem;
begin
	if Sender is TMenuItem then begin
		MenuItem := TMenuItem(Sender);
		SetSelectItemRound(True, StripHotKey(MenuItem.Caption), TMenuItem(Sender).Parent.Name);
		ListView.Refresh;
	end;
end;

function TGikoForm.GetCoolBand(CoolBar: TCoolBar; Control: TWinControl): TCoolBand;
var
	i: Integer;
begin
	Result := nil;
	if CoolBar = nil then
		Exit;
	for i := 0 to CoolBar.Bands.Count - 1 do begin
		if CoolBar.Bands[i].Control = Control then begin
			Result := CoolBar.Bands[i];
			Exit;
		end;
	end;
end;

procedure TGikoForm.BrowserTabToolBarResize(Sender: TObject);
begin
	if BrowserTab.Parent = BrowserTabToolBar then
		BrowserTab.Width := BrowserTabToolBar.Width;
end;

procedure TGikoForm.WMSettingChange(var Message: TWMWinIniChange);
begin
	SetMenuFont;
end;

procedure TGikoForm.SetMenuFont;
begin
//	GikoSys.MenuFont(MenuToolBar.Font);
//	MenuToolBar.Buttons[0].AutoSize := False;
//	MenuToolBar.Buttons[0].AutoSize := True;
//	MenuToolBar.Font.Color := clMenuText;
	GikoSys.MenuFont(MainCoolBar.Font);
	MenuToolBar.Buttons[0].AutoSize := False;
	MenuToolBar.Buttons[0].AutoSize := True;
	MainCoolBar.AutoSize := False;
	MainCoolBar.AutoSize := True;
	GikoSys.MenuFont(ListCoolBar.Font);
	GikoSys.MenuFont(BrowserCoolBar.Font);
//	MenuToolBar.Font.Color := clMenuText;
end;

procedure TGikoForm.FavoriteMenuClick(Sender: TObject);
var
	NewMenu: TMenuItem;
begin
	if FavoriteDM.Modified then begin
		FavoriteMenu.Clear;

		//���C�ɓ���̒ǉ�
		NewMenu := TMenuItem.Create(MainMenu);
		NewMenu.Action := GikoDM.FavoriteAddAction;
		FavoriteMenu.Add(NewMenu);
		//���C�ɓ���̐���
		NewMenu := TMenuItem.Create(FavoriteMenu);
		NewMenu.Action := GikoDM.FavoriteArrangeAction;
		FavoriteMenu.Add(NewMenu);
		//�Z�p���[�^
		FavoriteMenu.InsertNewLineAfter(NewMenu);
		CreateFavMenu(FavoriteDM.TreeView.Items.GetFirstNode, FavoriteMenu);
		FavoriteDM.Modified := false;
	end;
end;

procedure TGikoForm.CreateFavMenu(Node: TTreeNode; MenuItem: TMenuItem);
var
	i: Integer;
	NewMenu: array of TMenuItem;
begin
	SetLength(NewMenu, Node.Count);
	Node := Node.getFirstChild;
	i := 0;
	while ( Node <> nil ) do begin
		NewMenu[i] := TFavoriteMenuItem.Create(nil);
		NewMenu[i].AutoHotkeys := maAutomatic;
		NewMenu[i].Caption := CustomStringReplace(Node.Text, '&', '&&');
		TFavoriteMenuItem(NewMenu[i]).Data := Node.Data;

		if TObject(Node.Data) is TFavoriteFolder then begin
			NewMenu[i].ImageIndex := GikoDataModule.TOOL_ICON_FAV_FOLDER;
			CreateFavMenu(Node, NewMenu[i]);
		end else if TObject(Node.Data) is TFavoriteBoardItem then begin
			NewMenu[i].ImageIndex := GikoDataModule.TOOL_ICON_FAV_BOARD;
			NewMenu[i].OnClick := FavoriteClick;
		end else if TObject(Node.Data) is TFavoriteThreadItem then begin
			NewMenu[i].ImageIndex := GikoDataModule.TOOL_ICON_FAV_THREAD;
			NewMenu[i].OnClick := FavoriteClick;
		end;
        Inc(i);
		Node := Node.getNextSibling;
	end;
	MenuItem.Add(NewMenu);
end;

procedure TGikoForm.ShowFavoriteAddDialog( Item : TObject );
const
	MsgAdd : String = '���ɂ��C�ɓ���ɓo�^����Ă��܂��B����ł��ǉ����܂����H';
	TitleAdd: String =  '���C�ɓ���̒ǉ�';
var
	Dlg			: TFavoriteAddDialog;
	ItemURL	: string;
	Data		: Pointer;
	Node		: TTreeNode;
begin

	if Item is TFavoriteBoardItem then
		Item := TFavoriteBoardItem( Item ).Item
	else if Item is TFavoriteThreadItem then
		Item := TFavoriteThreadItem( Item ).Item;

	Node := FavoriteTreeView.Items.GetFirstNode;
	if Item is TBoard then begin
		ItemURL := TBoard( Item ).URL;
		while Node <> nil do begin
			Data := Node.Data;
			if TObject( Data ) is TFavoriteBoardItem then begin
				if ItemURL = TFavoriteBoardItem( Data ).URL then begin
					if Application.MessageBox(PChar(MsgAdd) , PChar(TitleAdd), MB_YESNO ) = IDNO then
						Exit;
					Break;
				end;
			end;
			Node := Node.GetNext;
		end;
		Dlg := TFavoriteAddDialog.Create(Self);
		try
			Dlg.SetBoard( TBoard( Item ) );
			Dlg.ShowModal;
		finally
			Dlg.Release;
		end;
	end else if Item is TThreadItem then begin
		ItemURL := TThreadItem( Item ).URL;
		while Node <> nil do begin
			Data := Node.Data;
			if TObject( Data ) is TFavoriteThreadItem then begin
				if ItemURL = TFavoriteThreadItem( Data ).URL then begin
					if Application.MessageBox( PChar(MsgAdd), PChar(TitleAdd), MB_YESNO ) = IDNO then
						Exit;
					Break;
				end;
			end;
			Node := Node.GetNext;
		end;
		Dlg := TFavoriteAddDialog.Create(Self);
		try
			Dlg.SetThreadItem( TThreadItem( Item ) );
			Dlg.ShowModal;
		finally
			Dlg.Release;
		end;
	end;

	SetLinkBar;
end;

procedure TGikoForm.FavoriteClick(Sender: TObject);
begin
	FavoriteClick( Sender, True );
end;

procedure TGikoForm.FavoriteClick(Sender: TObject; ActiveTab: Boolean);
var
	Board: TBoard;
	ThreadItem: TThreadItem;
	FavBoard: TFavoriteBoardItem;
	FavThread: TFavoriteThreadItem;
	Item: TObject;
begin
//	Item := nil;
	if Sender is TFavoriteMenuItem then
		Item := TFavoriteMenuItem(Sender).Data
	else if Sender is TLinkToolButton then
		Item := TLinkToolButton(Sender).Data
	else if Sender is TTreeNode then
		Item := TTreeNode( Sender ).Data
	else
		Exit;

	if TObject(Item) is TFavoriteBoardItem then begin
		FavBoard := TFavoriteBoardItem(Item);
		Board := FavBoard.Item;
		if Board <> nil then begin
			if (FTreeType = gtt2ch) and (FActiveBBS <> Board.ParentCategory.ParenTBBS) then
				ShowBBSTree( Board.ParentCategory.ParenTBBS );
			SelectTreeNode(Board, True);
		end;
	end else if TObject(Item) is TFavoriteThreadItem then begin
		FavThread := TFavoriteThreadItem(Item);
		ThreadItem := FavThread.Item;
		if ThreadItem = nil then
			Exit;

		InsertBrowserTab(ThreadItem, ActiveTab);

		if GikoSys.Setting.ListOrientation = gloHorizontal then begin
			if GikoSys.Setting.ListWidthState = glsMin then begin
				GikoDM.BrowserMaxAndFocusAction.Execute;
			end;
		end else begin
			if GikoSys.Setting.ListHeightState = glsMin then begin
				GikoDM.BrowserMaxAndFocusAction.Execute;
			end;
		end;
	end;
end;

procedure TGikoForm.BBSMenuItemOnClick(
	Sender	: TObject
);
begin

	if Sender is TBBSMenuItem then
		ShowBBSTree( TBBSMenuItem( Sender ).Data );

end;

procedure TGikoForm.MainCoolBarResize(Sender: TObject);
begin
	TopPanel.Height := Max(MainCoolBar.Height, AnimePanel.Height);

end;
//! �w�肳�ꂽ�X���b�h���J��(���O�������Ƃ� or �w��JUMP�܂ő���Ȃ��Ƃ���DL����)
procedure TGikoForm.OpenThreadItem(Thread: TThreadItem; URL: String);
var
	stRes, edRes : Int64;
	browserRec : TBrowserRecord;
	threadNumber : String;
	doc : IHTMLDocument2;
begin
	stRes := 0;
	edRes := 0;
	Thread.JumpAddress := 0;
	// �^�u�𐶐�
	browserRec := InsertBrowserTab(Thread);
	if (browserRec <> nil) then begin
		// JUMP���ׂ����X�ԍ������邩�`�F�b�N����
		threadNumber := ChangeFileExt(Thread.FileName, '');
		GikoSys.GetPopupResNumber( URL, stRes, edRes );
		// �X���̔ԍ������X�Ԃƌ���ĔF�����Ă���̂��N���A
		if (StrToInt64(threadNumber) = stRes) then begin
			if not (AnsiEndsText(threadNumber + '/' + threadNumber, URL))
				and (Pos('&st=' + threadNumber , URL) = 0) then begin
				stRes := 0;
			end;
		end;
		if ( stRes > 0 ) then begin
			Thread.JumpAddress := stRes;
		end;
		// ���O�������Ă��Ȃ��� JUMP���ׂ����X�ԍ��܂Ŏ擾���Ă��Ȃ��Ƃ���DL����
		if (not Thread.IsLogFile) or (stRes > Thread.Count) then begin
			DownloadContent(Thread);
		end else if (not browserRec.Repaint) and (stRes > 0) then begin
			browserRec.Move(IntToStr(stRes));
			Thread.JumpAddress := 0;
			try
                doc := browserRec.Browser.ControlInterface.Document as IHTMLDocument2;
                if Assigned(doc) then
    				Thread.ScrollTop := (doc.body as IHTMLElement2).ScrollTop;
			except
			end;
		end;
	end;
end;

procedure TGikoForm.MoveToURL(const inURL: string; KeyMask: Boolean = False);
var
	protocol, host, path, document, port, bookmark : string;
	URL, protocol2, host2, path2, document2, port2, bookmark2 : string;
	tmp1, tmp2: string;
	BBSID, BBSKey: string;
	{tmpBoard,} Board: TBoard;
	ThreadItem: TThreadItem;
	i, bi					: Integer;
	boardURL			: string;
	tmpThread			: TThreadItem;
	shiftDown			: Boolean;
	ctrlDown			: Boolean;
begin

	GikoSys.ParseURI( inURL, protocol, host, path, document, port, bookmark );
	GikoSys.Parse2chURL( inURL, path, document, BBSID, BBSKey );
    // �A�N�V��������Ă΂���shift/ctrl�͂������ς̏ꍇ���قƂ�ǂȂ̂Ń}�X�N����
    if not KeyMask then begin
        shiftDown	:= GetAsyncKeyState(VK_SHIFT) = Smallint($8001);
        ctrlDown	:= GetAsyncKeyState(VK_CONTROL) = Smallint($8001);
        if shiftDown then begin
            GikoSys.OpenBrowser(inURL, gbtUserApp);
            Exit;
        end else if ctrlDown then begin
            GikoSys.OpenBrowser(inURL, gbtIE);
            Exit;
        end;
    end;

	//===== �v���O�C��
	try
		//��ƒ�//
		bi := Length(BoardGroups) - 1;
		for i := 1 to bi do begin
			if (BoardGroups[i].BoardPlugIn <> nil) and (Assigned(Pointer(BoardGroups[i].BoardPlugIn.Module))) then begin
				case BoardGroups[i].BoardPlugIn.AcceptURL( inURL ) of
				atThread:
					begin
						boardURL 	:= BoardGroups[i].BoardPlugIn.ExtractBoardURL( inURL );
						Board		:= BBSsFindBoardFromURL( boardURL );


						if Board = nil then begin
							//break;
							// ������Ă��ǉ�����Ƃ��낪�����̂Ō������ۗ�
							//GikoSys.OpenBrowser(inURL, gbtUserApp);
							//Exit;
							{
							Board := GikoSys.GetUnknownBoard( tmpThread.BoardPlugIn, boardURL );
							if (FTreeType = gtt2ch) and (FActiveBBS = BBSs[ 1 ]) then
								ShowBBSTree( BBSs[ 1 ] );
							}
						end else begin
							tmpThread		:= TThreadItem.Create( BoardGroups[i].BoardPlugIn, Board, inURL );
							if not Board.IsThreadDatRead then begin
								GikoSys.ReadSubjectFile( Board );
								tmpThread.Free;
								Exit;
							end;
							ThreadItem := Board.FindThreadFromFileName( tmpThread.FileName );
							if ThreadItem = nil then begin
								//tmpThread���������͊J�����Ă͂����Ȃ�
								ThreadItem := tmpThread;
								Board.Insert( 0, ThreadItem );
								if ActiveList is TBoard then begin
									if TBoard(ActiveList) = Board then
										ListView.Items.Count := ListView.Items.Count + 1;
								end;
							end else begin
								tmpThread.Free;
							end;
							OpenThreadItem(ThreadItem, inURL);
							Exit;
						end;
					end;

				atBoard:
					begin
						Board := BBSsFindBoardFromURL(
									BoardGroups[i].BoardPlugIn.ExtractBoardURL( inURL )
									);
						if Board <> nil then begin
							if FActiveBBS <> Board.ParentCategory.ParenTBBS then
								ShowBBSTree( Board.ParentCategory.ParenTBBS );
							SelectTreeNode( Board, True );
							Exit;
						end;
					end;
				end;
			end;
		end;
	except
		// exception �����������ꍇ�͓��������ɔC�������̂ł����ł͉������Ȃ�
	end;


	if (Length( Trim(BBSKey) ) > 0) and (Length( Trim(BBSID) ) > 0) then begin
		boardURL := GikoSys.Get2chThreadURL2BoardURL( inURL );
		Board := BBSsFindBoardFromURL( boardURL );
		if Board = nil then begin
			 // ����ׂ���������Ȃ������̂ŁA���ʂ̃u���E�U�ŊJ��
			 GikoSys.OpenBrowser(inURL, gbtUserApp);
			 Exit;
		end else begin
			// �O���̔Ȃ̂�2ch��URL�ɂ���Ă��܂����z�������Ŋm�F����
			URL :=  Board.URL;
			GikoSys.ParseURI(URL , protocol2, host2, path2, document2, port2, bookmark2 );
			tmp1 := Copy(host, AnsiPos('.', host) + 1, Length(host));
			tmp2 := Copy(host2, AnsiPos('.', host2) + 1, Length(host2));
			if ( not GikoSys.Is2chHost(tmp1)) and (tmp1 <> tmp2) then begin
				GikoSys.OpenBrowser(inURL, gbtUserApp);
				Exit;
			end;
		end;

		if not Board.IsThreadDatRead then
			GikoSys.ReadSubjectFile(Board);
		URL := GikoSys.Get2chBrowsableThreadURL( inURL );
		ThreadItem := Board.FindThreadFromURL( URL );
		//�@�ߋ����O�q�ɂ���A�_�E�\�����X���������ł��Ȃ��̂ł����ŒT���悤�ɂ��� (2004/01/22)
		if ThreadItem = nil then begin
			ThreadItem := Board.FindThreadFromFileName( BBSKey + '.dat' );
		end;
		try
			// �X���b�h�A�C�e�����Ȃ��Ȃ琶������B
			if ThreadItem = nil then begin
				ThreadItem := TThreadItem.Create( nil, Board, URL );
				ThreadItem.FileName := ChangeFileExt(BBSKey, '.dat');
				Board.Insert(0, ThreadItem);
				if ActiveList is TBoard then begin
					if TBoard(ActiveList) = Board then
						ListView.Items.Count := ListView.Items.Count + 1;
				end;
			end;
			// ���O�Ȃ��X���b�h�̂Ƃ��́A�z�X�g���̃`�F�b�N������
			if (not ThreadItem.IsLogFile) then begin
				if AnsiPos(Host, Board.URL) = 0 then
					ThreadItem.DownloadHost := Host
				else
					ThreadItem.DownloadHost := '';
			end;
			OpenThreadItem(ThreadItem, inURL);
		except
		end;
	end else begin
		Board := BBSsFindBoardFromURL( inURL );
		if Board = nil then begin
			GikoSys.OpenBrowser(inURL, gbtAuto);
		end else begin
			if FActiveBBS <> Board.ParentCategory.ParenTBBS then
				ShowBBSTree( Board.ParentCategory.ParenTBBS );
			SelectTreeNode( Board, True );
		end;
	end;
end;

procedure TGikoForm.AddressToolBarResize(Sender: TObject);
begin
	AddressComboBox.Width := AddressToolBar.Width - MoveToToolButton.Width - 10;
	CoolBarResized( Sender, MainCoolBar );
end;

procedure TGikoForm.AddressComboBoxKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if Key = VK_RETURN then
		GikoDM.MoveToAction.Execute;
end;

procedure TGikoForm.BrowserEnter(Sender: TObject);
begin
    Browser.DoObjectVerb(OLEIVERB_UIACTIVATE);
end;

procedure TGikoForm.WMCopyData(var Message: TWMCopyData);
var
	CDS:PCopyDataStruct;
	PC:PChar;
	sURL: string;
begin
	CDS := Message.CopyDataStruct;
	GetMem(PC, CDS^.cbData);
	try
		lstrcpy(PC,CDS^.lpData);
		SetString(sURL, PC,lstrlen(PC));
		MoveToURL(sURL);
	finally
		FreeMem(PC);
	end;
	Message.Result := 1;
end;

procedure TGikoForm.WndProc(var Message: TMessage);
var
	senderBrowser : TWebBrowser;
	url : OleVariant;
begin
	try
		case Message.Msg of
		CM_DIALOGCHAR:
			if not (ssAlt in KeyDataToShiftState(TWMChar(Message).KeyData)) then
				Exit;
		WM_SYSCOMMAND:
			if Message.WParam = SC_MINIMIZE then begin
				OnMinimize;
                PostMessage(Handle, USER_MINIMIZED, 0, 0);
            end;
		USER_TREECLICK:
			TreeClick( TreeView.Selected );
		USER_RESIZED:
			OnResized;
		USER_MINIMIZED:
            begin
                if (GikoSys.Setting.StoredTaskTray) then begin
                    StoredTaskTray;
                end;
                OnMinimized;
            end;
		USER_SETLINKBAR:
			SetLinkBar;
		USER_DOCUMENTCOMPLETE:
			if (Message.WParam <> 0) and
				 (TObject(Message.WParam) is TWebBrowser) then begin
				senderBrowser := TWebBrowser( Message.WParam );
				BrowserDocumentComplete( senderBrowser, senderBrowser.Parent, url );
			end;
        USER_POPUPCLEAR:
            if (TObject(Message.WParam) is TResPopupBrowser) then begin
                try
    				TResPopupBrowser( Message.WParam ).Clear;
                except
                end;
			end else if (TObject(Message.WParam) is TPreviewBrowser) then begin
                if FPreviewBrowser <> nil then begin
            		ShowWindow(FPreviewBrowser.Handle, SW_HIDE);
                end;
			end;
		end;

		inherited;
	except
	end;
end;

procedure TGikoForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
var
	handle: THandle;
begin
	Handled := False;
	//�A�h���X�������͍i�荞�݃R���{�{�b�N�X�������͂��C�ɓ��肪�ҏW����
	//�V���[�g�J�b�g�Ȃǂ𖳌��ɂ���
	if ((FavoriteTreeView.Visible) and (FavoriteTreeView.IsEditing)) then begin
		if Msg.CharCode in [VK_BACK] then begin
			//BS���Q�񑗂���s����
			if Msg.KeyData > 0 then begin
				handle := GetFocus;
				if handle <> 0 then
					SendMessage(handle, WM_CHAR, Msg.CharCode, Msg.KeyData);
				Handled := True;
			end;
		end else
		//���C�ɓ����ESC�ŒE�o�������̂ŁA���������
		if Msg.CharCode in [VK_INSERT, VK_DELETE, VK_HOME, VK_END, VK_PRIOR, VK_NEXT, VK_ESCAPE] then begin
			handle := GetFocus;
			if handle <> 0 then
				SendMessage(handle, WM_KEYDOWN, Msg.CharCode, Msg.KeyData);
			Handled := True;
		end;
	end	else if (AddressComboBox.Focused) or (SelectComboBox.Focused) then begin
		if Msg.CharCode in [VK_BACK] then begin
			//BS���Q�񑗂���s����
			if Msg.KeyData > 0 then begin
				handle := GetFocus;
				if handle <> 0 then
					SendMessage(handle, WM_CHAR, Msg.CharCode, Msg.KeyData);
				Handled := True;
			end;
		end else if Msg.CharCode in [VK_INSERT, VK_DELETE, VK_HOME, VK_END, VK_PRIOR, VK_NEXT] then begin
			handle := GetFocus;
			if handle <> 0 then
				SendMessage(handle, WM_KEYDOWN, Msg.CharCode, Msg.KeyData);
			Handled := True;
		end;
	end else begin
		Handled := GikoDM.GikoFormActionList.IsShortCut(Msg);
	end;
end;

procedure TGikoForm.PreviewTimerTimer(Sender: TObject);
var
	p: TPoint;
	ARect: TRect;
begin
	PreviewTimer.Enabled := False;

	GetCursorpos(p);

    ARect := FPreviewBrowser.GetWindowRect(p);

    FPreviewBrowser.PreviewImage(FPreviewURL);

	if ARect.Bottom > Screen.DesktopHeight then begin
        OffsetRect(ARect, 0, -(ARect.Bottom - Screen.DesktopHeight));
    end;
	if (ARect.Right > Screen.DesktopWidth) then begin
        OffsetRect(ARect, -(ARect.Right - Screen.DesktopWidth), 0);
    end;
	if (ARect.Left < Screen.DesktopLeft) then begin
        OffsetRect(ARect, +(Screen.DesktopLeft - ARect.Left), 0);
    end;
	if (ARect.Top < Screen.DesktopTop) then begin
        OffsetRect(ARect, 0, (Screen.DesktopTop - ARect.Top));
    end;

	SetWindowPos(FPreviewBrowser.Handle, HWND_TOPMOST,
        ARect.Left, ARect.Top,
        (ARect.Right - ARect.Left), (ARect.Bottom - ARect.Top),
        SWP_NOACTIVATE or SWP_HIDEWINDOW);

	ShowWindow(FPreviewBrowser.Handle, SW_SHOWNOACTIVATE);
	FPreviewBrowserRect := ARect;
end;

procedure TGikoForm.WMSetCursor(var Message: TWMSetCursor);
var
	Pos : TPoint;
begin
	if PreviewTimer.Enabled then
		PreviewTimer.Enabled := False;

    //Window�O�Ɉړ������Ƃ��͏�����悤�ɂ��邽�ߕ���
    if (FResPopupBrowser <> nil) and (IsWindowVisible(FResPopupBrowser.Handle)) then begin
        // �E�N���b�N�̎��͏����Ȃ��悤�ɏ����ǉ�
        if (Message.MouseMsg <> WM_RBUTTONUP) then begin
            FResPopupBrowser.Clear;
        end;
    end;

	if (FPreviewBrowser <> nil)
		and (IsWindowVisible(FPreviewBrowser.Handle)) then begin
        //�����ŏ������̂����
        //���Ԃ񂱂�ŕ\���͈͔���ł��Ă���͂�
		Pos := Mouse.CursorPos;
		Pos.X := Pos.X + Left;
		Pos.Y := Pos.Y + Top;
		if (FPreviewBrowserRect.Left > Pos.X) or
			(FPreviewBrowserRect.Right < Pos.X) or
			(FPreviewBrowserRect.Top > Pos.Y) or
			(FPreviewBrowserRect.Bottom < Pos.Y) then begin
			ShowWindow(FPreviewBrowser.Handle, SW_HIDE);
		end;
	end;

	Message.Result := 1;
	inherited;
end;
procedure TGikoForm.MessageHideButtonClick(Sender: TObject);
begin
	GikoDM.MsgBarCloseAction.Execute;
end;

function TGikoForm.OnDocumentContextMenu(Sender: TObject): WordBool;
var
	doc: IHtmlDocument2;
	Range: IHTMLTxtRange;
	s: string;
	Num: Integer;
	ThreadItem: TThreadItem;
begin
	Result := False;
	FactiveContent.IDAnchorPopup('');

	doc := FactiveContent.Browser.ControlInterface.Document as IHtmlDocument2;
	if not Assigned(doc) then
        Exit;

	Range := doc.selection.createRange as IHTMLTxtRange;
	if not Assigned(Range) then
        Exit;

	s := CustomStringReplace(Range.text, '�@', ' ');//�S�p�󔒂𔼊p�󔒂�
	s := ZenToHan(Trim(s));
	if GikoSys.IsNumeric(s) then begin
		Num := StrToInt64Def(s, -1);
		ThreadItem := GetActiveContent(true);
		if (ThreadItem <> nil) and (Num <= ThreadItem.Count)
           and (Num > 0)then begin
           CreateResPopupBrowser;
           FResPopupBrowser.CreateNewBrowser.PopupType := gptThread;
			HTMLCreater.SetResPopupText(FResPopupBrowser.CreateNewBrowser, ThreadItem, Num, Num, False, False);
            FResPopupBrowser.Popup;
	    	Result := False;
		end else
			Result := True;
    end else begin
		Result := True;
	end;
end;

procedure TGikoForm.HistoryAllClearToolButtonClick(Sender: TObject);
const
	DEL_MSG = '�S�������폜���܂��B��낵���ł����H';
	DEL_TITLE = '�폜�m�F';
begin
	if FTreeType = gttHistory then begin
		if (GetKeyState( VK_SHIFT ) and $80000000) = 0 then
			if MsgBox(Handle, DEL_MSG, DEL_TITLE, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) <> ID_YES then
				Exit;
		FHistoryList.Clear;
		TreeView.Items.Clear;
	end;
end;

procedure TGikoForm.SetLinkBar;
var
	i: Integer;
	j: Integer;
	ToolButton: TLinkToolButton;
	MenuItem: TMenuItem;
	oldIgnoreResize : TResizeType;
begin
	oldIgnoreResize := FIsIgnoreResize;
	FIsIgnoreResize := rtResizing;
	MainCoolBar.Bands.BeginUpdate;
	try
		LinkBarPopupMenu.Items.Clear;
		for i := LinkToolBar.ButtonCount - 1 downto 0 do
			//LinkToolBar.RemoveControl(LinkToolBar.Buttons[i]);
			LinkToolBar.Buttons[i].Free;
		for i := 0 to FavoriteTreeView.Items.Count - 1 do begin
			if FavoriteTreeView.Items[i].Text = Favorite.FAVORITE_LINK_NAME then begin
				for j := 0 to FavoriteTreeView.Items[i].Count - 1 do begin
					ToolButton := TLinkToolButton.Create(LinkToolBar);
//                    ToolButton.Parent := LinkToolBar;
					if TObject(FavoriteTreeView.Items[i].Item[j].Data) is TFavoriteFolder then begin
						MenuItem := TMenuItem.Create(Self);
						CreateFavMenu(FavoriteTreeView.Items[i].Item[j], MenuItem);
						LinkBarPopupMenu.Items.Add(MenuItem);
						ToolButton.MenuItem := MenuItem;
						ToolButton.ImageIndex := GikoDataModule.TOOL_ICON_FAV_FOLDER;
					end else if TObject(FavoriteTreeView.Items[i].Item[j].Data) is TFavoriteBoardItem then begin
						ToolButton.ImageIndex := GikoDataModule.TOOL_ICON_FAV_BOARD;
						ToolButton.OnClick := FavoriteClick;
					end else if TObject(FavoriteTreeView.Items[i].Item[j].Data) is TFavoriteThreadItem then begin
						ToolButton.ImageIndex := GikoDataModule.TOOL_ICON_FAV_THREAD;
						ToolButton.OnClick := FavoriteClick;
					end;
					ToolButton.Caption := FavoriteTreeView.Items[i].Item[j].Text;
					ToolButton.Left := 10000;
					ToolButton.Data := FavoriteTreeView.Items[i].Item[j].Data;
					ToolButton.AutoSize := True;
					ToolButton.OnDragDrop := LinkToolButtonDragDrop;
					ToolButton.OnDragOver := FavoriteDragOver;
					ToolButton.OnMouseDown := LinkToolButtonOnMouseDown;
					ToolButton.OnMouseMove := LinkToolButtonOnMouseMove;
					ToolButton.OnMouseUp := LinkToolButtonOnMouseUp;
					ToolButton.OnStartDrag := LinkToolButtonStartDrag;
					//ToolButton.DragMode := dmAutomatic;
					ToolButton.DragMode := dmManual;
					ToolButton.PopupMenu := FavoriteTreePopupMenu;

					LinkToolBar.InsertControl(ToolButton);
				end;
				break;
			end;
		end;
{		if LinkToolBar.ButtonCount = 0 then begin
			ToolButton := TLinkToolButton.Create(LinkToolBar);
			ToolButton.Style := tbsButton;
			ToolButton.ImageIndex := -1;
			ToolButton.Caption := '';
			LinkToolBar.InsertControl(ToolButton);
		end;}
	finally
		MainCoolBar.Bands.EndUpdate;
		LoadCoolBarSettings;
		FIsIgnoreResize := oldIgnoreResize;
	end;
end;

procedure TGikoForm.FavoriteDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
	Node: TTreeNode;
	bound: TRect;
	height: Integer;
	Change: Boolean;
begin

	if Sender = FavoriteTreeView then begin
		Node := FavoriteTreeView.GetNodeAt(X, Y);

		if Node = nil then
			Exit;

		bound := Node.DisplayRect( False );
		height := bound.Bottom - bound.Top;
		if (bound.Top + height / 2) <= Y then
			Node := FavoriteTreeView.GetNodeAt(X, Y + height);

		if Node = nil then
			Exit;

		if Node.IsFirstNode then
			Exit;

		Change := True;

		if FDropSpaceNode <> nil then
			if FDropSpaceNode.AbsoluteIndex = Node.AbsoluteIndex then
				Change := False;

		if Change then begin
			if FDropSpaceNode <> nil then
				FDropSpaceNode.Free;

			FDropSpaceNode := FavoriteDM.TreeView.Items.AddChildObjectFirst(Node.Parent, '', nil );
			FDropSpaceNode.MoveTo( Node, naInsert );
			FDropSpaceNode.ImageIndex := -1;
			FDropSpaceNode.SelectedIndex := -1;
		end;
	end;

	if Source = FavoriteTreeView then begin
		if FavoriteTreeView.Selected = FavoriteTreeView.Items.GetFirstNode then begin
			Accept := False;
			Exit;
		end;
		Accept := True;
	end else if Source = BrowserTab then
		Accept := True
	else if Source = ListView then
		Accept := True
	else if Source is TLinkToolButton then
		Accept := True
	else if Source = TreeView then
		Accept := True
	else
		Accept := False;
end;

procedure TGikoForm.FavoriteTreeViewDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin

	FavoriteDragOver( Sender, Source, X, Y, State, Accept );

end;
procedure TGikoForm.LinkToolButtonStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
	 //	FDragging := true;
end;

procedure TGikoForm.LinkToolButtonDragDrop(Sender, Source: TObject; X, Y: Integer);
var
	SenderNode: TTreeNode;
	LinkToolButton: TLinkToolButton;
begin

	LinkToolButton := TLinkToolButton( Sender );
	SenderNode := TreeNodeDataFind( FavoriteTreeView.Items.GetFirstNode, LinkToolButton.Data );
	SenderNode.Selected := False;
	FavoriteDragDrop( SenderNode, Source );

	PostMessage( Handle, USER_SETLINKBAR, 0, 0 );
end;

procedure TGikoForm.LinkToolButtonOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	favButton			: TLinkToolButton;
	favThreadItem	: TFavoriteThreadItem;
begin

	case Button of
	mbMiddle:
		begin
			if Sender is TLinkToolButton then begin
				favButton := TLinkToolButton( Sender );
				if TObject( favButton.Data ) is TFavoriteThreadItem then begin
					favThreadItem := TFavoriteThreadItem( favButton.Data );
					if favThreadItem.Item <> nil then
						InsertBrowserTab( favThreadItem.Item, False );
				end;
			end;
		end;
	end;

end;

procedure TGikoForm.LinkToolButtonOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
	Now : Cardinal;
begin
	TToolButton( Sender ).DragMode := dmManual;
	if ssLeft in Shift then begin
//		TToolButton( Sender ).Down := true;   // �����N�c�[���o�[�̋����s�R�̌����̂悤�Ȃ̂ŃR�����g�A�E�g����(2003-dec-02)
		if FDragTime = 0 then begin
			FDragTime := GetTickCount();
		end else begin
			Now := GetTickCount();
			if (Now - FDragTime) > 500 then begin
				if FDragButton <> TToolButton( Sender ) then begin
					try
						FDragButton := TToolButton( Sender );
						TToolButton(Sender).BeginDrag(false ,5);
						FDragTime := 0;
					except
						{$IF Defined(debug)}
						ShowMessage('Error');
						{$IFEND}
					end;
				end;
			end;
		end;
	end else begin
		FDragTime := 0;
	end;
end;

procedure TGikoForm.LinkToolButtonOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	FDragTime := 0;
end;

function TGikoForm.GetWidthAllToolButton(ToolBar: TToolBar): Integer;
var
	i: Integer;
begin
	Result := 0;
	for i := 0 to ToolBar.ButtonCount - 1 do
		if ToolBar.Buttons[i].Visible then
			Result := Result + ToolBar.Buttons[i].Width;
end;

procedure TGikoForm.MainCoolBarBandInfo(Sender: TObject; var BandInfo: PReBarBandInfoA);
var
	Control : TWinControl;
	i, idx	: Integer;
begin
	Control := FindControl(BandInfo^.hwndChild);
	if Control = nil then
		Exit;
	idx := 0;
	for i := MainCoolBar.Bands.Count - 1 downto 0 do begin
		if MainCoolBar.Bands[ i ].Control.Handle = Control.Handle then begin
			idx := MainCoolBar.Bands[ i ].ID;
			Break;
		end;
	end;
	Canvas.Font.Handle := GetStockObject( DEFAULT_GUI_FONT );
	if (Control = MenuToolBar) or (Control = StdToolBar) then begin
		BandInfo^.fMask				:= BandInfo.fMask or RBBIM_CHILDSIZE or RBBIM_STYLE or RBBIM_IDEALSIZE;
		BandInfo^.fStyle			:= BandInfo.fStyle or RBBS_USECHEVRON;
		BandInfo^.cxMinChild	:= 0;
		BandInfo^.cx					:= GikoSys.Setting.MainCoolSet[ idx ].FCoolWidth;
		BandInfo^.cxIdeal			:= GetWidthAllToolButton(TToolBar(Control));
	end else if Control = LinkToolBar then begin
		BandInfo^.fMask				:= BandInfo.fMask or RBBIM_CHILDSIZE or RBBIM_STYLE or RBBIM_IDEALSIZE;
		BandInfo^.fStyle			:= BandInfo.fStyle or RBBS_USECHEVRON;
		BandInfo^.cxMinChild	:= 0;
		BandInfo^.cx					:= GikoSys.Setting.MainCoolSet[ idx ].FCoolWidth + Canvas.TextWidth( '�����N' );
		BandInfo^.cxIdeal			:= GetWidthAllToolButton(TToolBar(Control));
	end else begin // AddressToolBar
		BandInfo^.fMask				:= BandInfo.fMask or RBBIM_CHILDSIZE;
		BandInfo^.cxMinChild	:= 0;
		BandInfo^.cx					:= GikoSys.Setting.MainCoolSet[ idx ].FCoolWidth + Canvas.TextWidth( '�A�h���X' );
	end;
end;

procedure TGikoForm.MainCoolBarChevronClick(Sender: TObject; RebarChevron: PNMRebarChevron);
var
	i : Integer;
	Idx: Integer;
	p: TPoint;
begin
	ChevronPopupMenu.Items.Clear;
	Idx := 0;
	for i := 0 to MainCoolBar.Bands.Count - 1 do begin
		if MainCoolBar.Bands[ i ].Visible then begin
			if Idx = Int64(RebarChevron^.uBand) then begin
				Idx := i;
				break;
			end;
			Inc( Idx );
		end;
	end;
	if (Idx >= 0) and (MainCoolBar.Bands.Count > Idx) then begin
		if MainCoolBar.Bands[Idx].Control = MenuToolbar then begin
			MenuBarChevronMenu;
		end else if MainCoolBar.Bands[Idx].Control = StdToolbar then begin
			ToolBarChevronMenu(StdToolBar);
		end else if MainCoolBar.Bands[Idx].Control = LinkToolbar then begin
			LinkBarChevronMenu;
		end else
			Exit;
		p := MainCoolBar.ClientToScreen(Point(RebarChevron^.rc.left, RebarChevron^.rc.bottom));
		ChevronPopupMenu.Popup(p.x, p.y);
	end;
end;

procedure TGikoForm.MenuBarChevronMenu;
	procedure SetSubMenu(MenuItem: TMenuItem; PopupItem: TMenuItem);
	var
		i: Integer;
		Item: TMenuItem;
	begin
		MenuItem.Click;
		for i := 0 to MenuItem.Count - 1 do begin
//			Item := nil;
			if MenuItem[i] is TFavoriteMenuItem then begin
				Item := TFavoriteMenuItem.Create(Self);
				TFavoriteMenuItem(Item).Data := TFavoriteMenuItem(MenuItem[i]).Data;
			end else
				Item := TMenuItem.Create(Self);
			Item.Caption := MenuItem[i].Caption;
			Item.Action := MenuItem[i].Action;
			Item.ImageIndex := MenuItem[i].ImageIndex;
			Item.OnClick := MenuItem[i].OnClick;
			PopupItem.Add(Item);
			if MenuItem[i].Count > 0 then
				SetSubMenu(MenuItem[i], Item);
		end;
	end;
var
	i: Integer;
	w: Integer;
	bw: Integer;
	Item: TMenuItem;
begin
	ChevronPopupMenu.Items.Clear;
	ChevronPopupMenu.Images := MainMenu.Images;
	bw := GetWidthAllToolButton(MenuToolBar);
	if MenuToolBar.Width < bw then begin
		w := 0;
		for i := 0 to MenuToolBar.ButtonCount - 1 do begin
			w := w + MenuToolBar.Buttons[i].Width;
			if MenuToolBar.Width <= w then begin
				Item := TMenuItem.Create(Self);
				Item.Caption := MenuToolBar.Buttons[i].MenuItem.Caption;
				//Item.Action := MenuToolBar.Buttons[i].MenuItem.Action;
				ChevronPopupMenu.Items.Add(Item);
				SetSubMenu(MenuToolbar.Buttons[i].MenuItem, Item);
			end;
		end;
	end;
end;

procedure TGikoForm.ToolBarChevronMenu(ToolBar: TToolBar);
	procedure SetSubMenu(PopupMenu: TPopupMenu; PopupItem: TMenuItem);
	var
		i: Integer;
		Item: TMenuItem;
	begin
		if Assigned(PopupMenu.OnPopup) then
			PopupMenu.OnPopup(nil);
		for i := 0 to PopupMenu.Items.Count - 1 do begin
//			Item := nil;
			if PopupMenu.Items[i] is TFavoriteMenuItem then begin
				Item := TFavoriteMenuItem.Create(Self);
				TFavoriteMenuItem(Item).Data := TFavoriteMenuItem(PopupMenu.Items[i]).Data;
			end else
			Item := TMenuItem.Create(Self);
			Item.Caption := PopupMenu.Items[i].Caption;
			Item.Action := PopupMenu.Items[i].Action;
			Item.ImageIndex := PopupMenu.Items[i].ImageIndex;
			Item.OnClick := PopupMenu.Items[i].OnClick;
			PopupItem.Add(Item);
		end;
	end;
var
	i: Integer;
	w: Integer;
	bw: Integer;
	Item: TMenuItem;
begin
	ChevronPopupMenu.Items.Clear;
	ChevronPopupMenu.Images := ToolBar.HotImages;
	bw := GetWidthAllToolButton(ToolBar);
	if ToolBar.Width < bw then begin
		w := 0;
		for i := 0 to ToolBar.ButtonCount - 1 do begin
			if ToolBar.Buttons[i].Visible then
				w := w + ToolBar.Buttons[i].Width;
			if ToolBar.Width <= w then begin
				if ToolBar.Buttons[i].Tag = 0 then begin
					Item := TMenuItem.Create(Self);
					if ToolBar.Buttons[i].Style = tbsSeparator then
						Item.Caption := '-'
					else begin
						//�X���i����ComBox��TPanel��r������
						if TObject(ToolBar.Buttons[i]) is TPanel then begin
							Continue;
						end else begin
							Item.Caption := ToolBar.Buttons[i].Caption;
							Item.Action := ToolBar.Buttons[i].Action;
						end;
						//Item.Visible := True;
					end;
					ChevronPopupMenu.Items.Add(Item);
					if ToolBar.Buttons[i].DropdownMenu <> nil then begin
						Item.Action := nil;
						Item.OnClick := nil;
						SetSubMenu(ToolBar.Buttons[i].DropdownMenu, Item);
					end;
				end;
			end;
		end;
	end;
end;

procedure TGikoForm.LinkBarChevronMenu;
var
	i: Integer;
	j: Integer;
	w: Integer;
	Item: TFavoriteMenuItem;
	bw: Integer;
	Button: TLinkToolButton;
begin
	ChevronPopupMenu.Items.Clear;
	ChevronPopupMenu.Images := LinkToolBar.Images;
	bw := GetWidthAllToolButton(LinkToolBar);
	if LinkToolBar.Width < bw then begin
		w := 0;
		for i := 0 to FavoriteTreeView.Items.Count - 1 do begin
			if FavoriteTreeView.Items[i].Text = Favorite.FAVORITE_LINK_NAME then begin
				for j := 0 to FavoriteTreeView.Items[i].Count - 1 do begin
					w := w + LinkToolBar.Buttons[j].Width;
					if LinkToolBar.Width <= w then begin
						if LinkToolBar.Buttons[j] is TLinkToolButton then begin
							Button := TLinkToolButton(LinkToolBar.Buttons[j]);
							Item := TFavoriteMenuItem.Create(Self);
							if TObject(Button.Data) is TFavoriteFolder then begin
								CreateFavMenu(FavoriteTreeView.Items[i].Item[j], Item);
							end else if TObject(Button.Data) is TFavoriteBoardItem then begin
								Item.OnClick := FavoriteClick;
							end else if TObject(Button.Data) is TFavoriteThreadItem then begin
								Item.OnClick := FavoriteClick;
							end;
							Item.Data := Button.Data;
							Item.Caption := LinkToolBar.Buttons[j].Caption;
							Item.ImageIndex := LinkToolBar.Buttons[j].ImageIndex;
							ChevronPopupMenu.Items.Add(Item);
						end;
					end;
				end;
				break;
			end;
		end;
	end;
end;

{!
\brief	�o���h�����Čv�Z�E�Đݒ肷��
\param	bar		�o���h���������� CoolBar
\param	band	�Čv�Z�E�Đݒ肷��o���h

�Ǝ��Ƀo���h�ɔz�u����Ă���R���g���[���̃T�C�Y��ύX�����ꍇ��
�V�F�u�����̕\���ʒu���Đݒ肷�邽�߂Ɏg�p���܂��B
}
procedure TGikoForm.ResetBandInfo( bar : TGikoCoolBar; band : TToolBar );
var
	bandInfo	: tagREBARBANDINFOA;
	pBandInfo	: PReBarBandInfoA;
	lResult		: Integer;
	h					: HWND;
	i, idx		: Integer;
begin

	h										:= band.Handle;
	pBandInfo := @bandInfo;
	ZeroMemory( pBandInfo, sizeof( bandInfo ) );
	bandInfo.cbSize			:= sizeof( bandInfo );
	bandInfo.hwndChild	:= h;
	bandInfo.cyMinChild	:= bar.Height;
	bar.OnBandInfo( nil, pBandInfo );
	// band �̃C���f�b�N�X��T��
	idx := 0;
	for i := bar.Bands.Count - 1 downto 0 do begin
		if bar.Bands[ i ].Control.Handle = h then begin
			idx := i;
			Break;
		end;
	end;
	// �ݒ�
	lResult := SendMessage( bar.Handle, RB_SETBANDINFO, idx, Integer( pBandInfo ) );

end;

procedure TGikoForm.ListCoolBarBandInfo(Sender: TObject; var BandInfo: PReBarBandInfoA);
var
	Control: TWinControl;
	i, idx	: Integer;
begin
	Control := FindControl(BandInfo^.hwndChild);
	if Control = nil then
		Exit;
	idx := 0;
	for i := ListCoolBar.Bands.Count - 1 downto 0 do begin
		if ListCoolBar.Bands[ i ].Control.Handle = Control.Handle then begin
			idx := ListCoolBar.Bands[ i ].ID;
			Break;
		end;
	end;
	if Control = ListToolBar then begin
		BandInfo^.fMask				:= BandInfo.fMask or RBBIM_CHILDSIZE or RBBIM_STYLE or RBBIM_IDEALSIZE;
		BandInfo^.fStyle			:= BandInfo.fStyle or RBBS_USECHEVRON;
		BandInfo^.cxMinChild	:= 0;
		BandInfo^.cx					:= GikoSys.Setting.ListCoolSet[ idx ].FCoolWidth;
		BandInfo^.cxIdeal			:= GetWidthAllToolButton(TToolBar(Control));
	end else begin
		BandInfo^.fMask				:= BandInfo.fMask or RBBIM_CHILDSIZE;
		BandInfo^.cxMinChild	:= 0;
		BandInfo^.cx					:= GikoSys.Setting.ListCoolSet[ idx ].FCoolWidth;
	end;
end;

procedure TGikoForm.ListCoolBarChevronClick(Sender: TObject; RebarChevron: PNMRebarChevron);
var
	Idx: Integer;
	p: TPoint;
begin
	ChevronPopupMenu.Items.Clear;
	Idx := RebarChevron^.uBand;
	if (Idx >= 0) and (ListCoolBar.Bands.Count > Idx) then begin
		if ListCoolBar.Bands[Idx].Control = ListToolBar then begin
			ToolBarChevronMenu(ListToolBar);
		end else
			Exit;
		p := ListCoolBar.ClientToScreen(Point(RebarChevron^.rc.left, RebarChevron^.rc.bottom));
		ChevronPopupMenu.Popup(p.x, p.y);
	end;
end;

procedure TGikoForm.BrowserCoolBarBandInfo(Sender: TObject; var BandInfo: PReBarBandInfoA);
var
	Control: TWinControl;
	i, idx	: Integer;
begin
	Control := FindControl(BandInfo^.hwndChild);
	if Control = nil then
		Exit;
	idx := 0;
	for i := BrowserCoolBar.Bands.Count - 1 downto 0 do begin
		if BrowserCoolBar.Bands[ i ].Control.Handle = Control.Handle then begin
			idx := BrowserCoolBar.Bands[ i ].ID;
			Break;
		end;
	end;
	if Control = BrowserToolBar then begin
		BandInfo^.fMask				:= BandInfo.fMask or RBBIM_CHILDSIZE or RBBIM_STYLE or RBBIM_IDEALSIZE;
		BandInfo^.fStyle			:= BandInfo.fStyle or RBBS_USECHEVRON;
		BandInfo^.cxMinChild	:= 0;
		BandInfo^.cx					:= GikoSys.Setting.BrowserCoolSet[ idx ].FCoolWidth;
		BandInfo^.cxIdeal			:= GetWidthAllToolButton(TToolBar(Control));
	end else begin
		BandInfo^.fMask				:= BandInfo.fMask or RBBIM_CHILDSIZE;
		BandInfo^.cxMinChild	:= 0;
		BandInfo^.cx					:= GikoSys.Setting.BrowserCoolSet[ idx ].FCoolWidth;
	end;
end;

procedure TGikoForm.BrowserCoolBarChevronClick(Sender: TObject; RebarChevron: PNMRebarChevron);
var
	Idx: Integer;
	p: TPoint;
begin
	ChevronPopupMenu.Items.Clear;
	Idx := RebarChevron^.uBand;
	if (Idx >= 0) and (BrowserCoolBar.Bands.Count > Idx) then begin
		if BrowserCoolBar.Bands[Idx].Control = BrowserToolBar then
			ToolBarChevronMenu(BrowserToolBar)
		else
			Exit;
		p := BrowserCoolBar.ClientToScreen(Point(RebarChevron^.rc.left, RebarChevron^.rc.bottom));
		ChevronPopupMenu.Popup(p.x, p.y);
	end;
end;

procedure TGikoForm.ListViewColumnInfo(Sender: TObject;	var Column: PLVColumnA);
begin
	if Column^.iImage = -1 then begin
		Column^.mask := Column^.mask or LVCF_FMT;
	end else begin
		Column^.mask := Column^.mask or LVCF_FMT or LVCF_IMAGE;
		Column^.fmt := Column^.fmt or LVCFMT_IMAGE or LVCFMT_BITMAP_ON_RIGHT;
	end;
end;

function TGikoForm.FindToolBarButton( bar : TToolBar; action : TAction ) : TToolButton;
var
	i : Integer;
begin
	Result := nil;
	for i := bar.ButtonCount - 1 downto 0 do begin
		if bar.Buttons[ i ].Action = action then begin
			Result := bar.Buttons[ i ];
			Break;
		end;
	end;
end;

procedure TGikoForm.SetToolBarPopup;
var
	i									: Integer;
	aIEButton					: TToolButton;
	aCabinetBBSButton	: TToolButton;
	aResRangeButton		: TToolButton;
	aThreadRangeButton:	TToolButton;
begin
	for i := 0 to StdToolBar.ButtonCount - 1 do begin
	end;
	for i := 0 to ListToolBar.ButtonCount - 1 do begin
		if ListToolBar.Buttons[i].Action = GikoDM.IconStyle then
			ListToolBar.Buttons[i].DropdownMenu := ListIconPopupMenu;
		if ListToolBar.Buttons[i].Action = GikoDM.SelectReservAction then
			ListToolBar.Buttons[i].DropdownMenu := RoundNamePopupMenu;
	end;
	aIEButton					:= FindToolBarButton( BrowserToolBar, GikoDM.IEAction );
	if aIEButton <> nil then
		aIEButton.DropdownMenu					:= BrowserPopupMenu;
	aCabinetBBSButton	:= FindToolBarButton( StdToolBar, GikoDM.CabinetBBSAction );
	if aCabinetBBSButton <> nil then
		aCabinetBBSButton.DropdownMenu	:= BBSSelectPopupMenu;
	aResRangeButton		:= FindToolBarButton( BrowserToolBar, GikoDM.ResRangeAction );
	if aResRangeButton <> nil then
		aResRangeButton.DropdownMenu		:= ResRangePopupMenu;
	aThreadRangeButton:= FindToolBarButton( ListToolBar, GikoDM.ThreadRangeAction );
	if aThreadRangeButton <> nil then
		aThreadRangeButton.DropdownMenu	:= ThreadRangePopupMenu;
end;

procedure TGikoForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
	WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
	Wnd: THandle;
	delta: Integer;
//	browserPos : TPoint;
const
	ICON_SIZE = 16;
begin
	Wnd := WindowFromPoint(Mouse.CursorPos);
	Handled := True;
	if WheelDelta > 0 then
		Delta := -1
	else
		Delta := 1;

	if (Wnd = BrowserTab.Handle) or
		 (Wnd = BrowserTab.Parent.Handle) then begin
		BrowserTab.ScrollTabs(Delta);
	end else begin
		if FIsHandledWheel then begin
			FIsHandledWheel := False;
			Handled := False;
		end else begin
			FIsHandledWheel := True;
			if (Wnd = TreeView.Handle) or  (Wnd = FavoriteTreeView.Handle)
			or (Wnd = ListView.Handle) or (Wnd = MessageListView.Handle)
			then
				SendMessage( Wnd, WM_MOUSEWHEEL, WheelDelta shl 16, (Mouse.CursorPos.X shl 16) or Mouse.CursorPos.Y )
			else
				Handled := False;

		end;
	end;
end;

procedure TGikoForm.SetSelectWord( const text : string );
begin
	// �X���ꗗ�͈͎̔w�������
	ClearThreadRengeAction;

	if Length( text ) = 0 then
	begin
		GikoDM.AllItemAction.Checked := True;
		SetListViewType( gvtAll )
	end else begin
		SetListViewType( gvtUser, text, false );
	end;
end;

procedure TGikoForm.SelectComboBoxChange(Sender: TObject);
begin

	SetSelectWord( SelectComboBox.Text );

end;

procedure TGikoForm.SelectComboBoxKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
var
  IMC: HIMC;
  Len, idx: integer;
  Str: string;
  tmp: string;
begin

	if Key = VK_Return then
	begin
		ModifySelectList;
	end else if Key = 229 then begin
		if GikoSys.Setting.UseUndecided then begin
			IMC := ImmGetContext(SelectComboBox.Handle); //�R���e�L�X�g�擾
			Len := ImmGetCompositionString(IMC, GCS_COMPSTR, nil, 0); //�܂��������擾
			SetLength(Str, Len + 1); //Buffer�̃�������ݒ�
			ImmGetCompositionString(IMC, GCS_COMPSTR, PChar(Str), Len + 1); //�܂��������擾
			ImmReleaseContext(SelectComboBox.Handle, IMC);  //�R���e�L�X�g���
			SetLength(Str, Len);
			if SelectComboBox.SelLength > 0 then begin //�I�𒆂̕����񂪂��邩
				tmp := Copy(SelectComboBox.Text, 1, SelectComboBox.SelStart);
				Str := tmp + Str + Copy(SelectComboBox.Text, SelectComboBox.SelStart + SelectComboBox.SelLength + 1, Length(SelectComboBox.Text));
			end else
				Str := SelectComboBox.Text + Str;

			if (Length(Str) > 0) then begin
				SetSelectWord(Str);
			end;
		end;
    end else if (Key = Windows.VK_DELETE) and (ssCtrl in Shift) then begin
        // Ctrl + DEL �ō폜����
        Str := SelectComboBox.Text;
        idx := GikoSys.Setting.SelectTextList.IndexOf( Str );
        if idx <> -1 then begin
            GikoSys.Setting.SelectTextList.Delete( idx );
        end;
        idx := SelectComboBox.Items.IndexOf( Str );
		if idx <> -1 then begin
            SelectComboBox.Items.Delete( idx );
        end;
        SelectComboBox.Text := '';
        // �i���݂��������邽�߂ɕύX�C�x���g���Ăяo��
        SelectComboBox.OnChange(Sender);
	end else if Length( SelectComboBox.Text ) = 0 then
	begin
		{* SelectComboBox.Text����ł��A���͓r����Esc�����Ƃ�
		 * ��̂Ƃ���Del�L�[���������Ƃ��Ȃ̂ŁA�X���̍i���݂��ێ�����B
		 * �i�����ł͉������Ȃ��j
		 *}
	end else begin
        // �X���ꗗ�͈͎̔w�������
		ClearThreadRengeAction;
	end;

end;
//! �X���b�h�ꗗ�̕\���͈͐ݒ�`�F�b�N�N���A
procedure TGikoForm.ClearThreadRengeAction;
begin
	// �`�����ƌ�������A�ꉞ�����Ă���Ƃ�������������
	if GikoDM.AllItemAction.Checked then
		GikoDM.AllItemAction.Checked := False;
	if GikoDM.LogItemAction.Checked then
		GikoDM.LogItemAction.Checked := False;
	if GikoDM.NewItemAction.Checked then
		GikoDM.NewItemaction.Checked := False;
	if GikoDM.LiveItemAction.Checked then
		GikoDM.LiveItemAction.Checked := False;
	if GikoDM.ArchiveItemAction.Checked then
		GikoDM.ArchiveItemAction.Checked := False;

end;

procedure TGikoForm.SelectComboBoxExit(Sender: TObject);
begin

	ModifySelectList;

	if Length( SelectComboBox.Text ) = 0 then
	begin
		SelectComboBox.Text := GikoDataModule.SELECTCOMBOBOX_NAME;
		SelectComboBox.Color := GikoDataModule.SELECTCOMBOBOX_COLOR;
	end;

end;

// �i�荞�݌����̗����X�V
procedure TGikoForm.ModifySelectList;
var
	idx : Integer;
	oldText : string;
begin

	try
		if not SelectComboBoxPanel.Visible then
			exit;

		if Length( SelectComboBox.Text ) > 0 then
		begin
			oldText := SelectComboBox.Text;
			idx := GikoSys.Setting.SelectTextList.IndexOf( oldText );
			if idx <> -1 then
				GikoSys.Setting.SelectTextList.Delete( idx );
			idx := SelectComboBox.Items.IndexOf( oldText );
			if idx <> -1 then
				SelectComboBox.Items.Delete( idx );
			GikoSys.Setting.SelectTextList.Insert( 0, oldText );
			SelectComboBox.Items.Insert( 0, oldText );
			SelectComboBox.Text := oldText;
		end;
	except
	end;

end;


procedure TGikoForm.SelectComboBoxSplitterMouseMove(Sender: TObject;
	Shift: TShiftState; X, Y: Integer);
var
	pos				: TPoint;
	w					: Integer;
begin
	If (SelectComboBoxPanel.Visible) and (IsDraggingSelectComboBox) Then begin
		pos.X := X;
		pos.Y := Y;
		pos := SelectComboBoxSplitter.ClientToScreen( pos );
		//w := SelectComboBox.Width + (pos.X - DraggingSelectComboBoxPosition.X);
		w := SelectComboBoxPanel.Width + (pos.X - DraggingSelectComboBoxPosition.X);

		If w <= 50 Then Begin
			// ���̈ړ��̊���u�߂��Ă��܂����ʒu�v�ł͂Ȃ�
			// �u�~�܂���(50pixel)�ʒu�v�ɂȂ�悤��
			pos.X := pos.X + (50 - w);

			// �������Ȃ肷���Ȃ��悤��
			w := 50;
		End;

		// �`�����y���̈�
		//If SelectComboBox.Width <> w Then Begin
		If SelectComboBoxPanel.Width <> w Then Begin
			SelectComboBoxPanel.Width := w;
			SelectComboBox.Width := SelectComboBoxPanel.Width - SelectComboBoxSplitter.Width;
			GikoSys.Setting.SelectComboBoxWidth := w;
			DraggingSelectComboBoxPosition := pos;

			// �V�F�u�����ʒu���ς��̂� BandInfo �̍Đݒ�
			ResetBandInfo( ListCoolBar, ListToolBar );
		End;
	End;

end;

procedure TGikoForm.SelectComboBoxSplitterMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	pos : TPoint;
begin
	IsDraggingSelectComboBox := True;
	pos.X := X;
	pos.Y := Y;
	DraggingSelectComboBoxPosition := SelectComboBoxSplitter.ClientToScreen( pos );

end;

procedure TGikoForm.SelectComboBoxSplitterMouseUp(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	IsDraggingSelectComboBox := False;

end;

procedure TGikoForm.StatusBarResize(Sender: TObject);
begin
	StatusBar.Panels[1].Width := StatusBar.Width -
					StatusBar.Panels[0].Width -
					StatusBar.Panels[THREADSIZE_PANEL].Width -
					StatusBar.Panels[NGWORDNAME_PANEL].Width;
end;
procedure TGikoForm.SelectComboBoxEnter(Sender: TObject);
begin

	if (Length( SelectComboBox.Text ) = 0) or
		(SelectComboBox.Text = GikoDataModule.SELECTCOMBOBOX_NAME) then
	begin
		SelectComboBox.Text := '';
		SelectComboBox.Color := clWindow;
	end;

end;

procedure TGikoForm.FavoriteMoveTo( SenderNode, SourceNode: TTreeNode );
begin

	if (SenderNode = nil) or (SourceNode = nil) or (SenderNode = SourceNode) then
		Exit;

	if TObject(SenderNode.Data) is TFavoriteFolder then
		SourceNode.MoveTo(SenderNode, naAddChild)
	else
		SourceNode.MoveTo(SenderNode, naInsert);

end;

procedure TGikoForm.FavoriteAddTo( SenderNode: TTreeNode; Source: TObject );
var
	Node: TTreeNode;
	FavNode: TTreeNode;
	FavoBoardItem: TFavoriteBoardItem;
	FavoThreadItem: TFavoriteThreadItem;
	Board: TBoard;
	ThreadItem: TThreadItem;
begin

	if (SenderNode = nil) or (Source = nil) then
		Exit;

	if not (TObject(SenderNode.Data) is TFavoriteFolder) then
		FavNode := SenderNode.Parent
	else
		FavNode := SenderNode;

	Node := nil;

	if Source is TBoard then begin
		Board := TBoard( Source );
		FavoBoardItem			 	:= TFavoriteBoardItem.CreateWithItem( Board );
		Node := FavoriteDM.TreeView.Items.AddChildObject(FavNode, Board.Title, FavoBoardItem);
		Node.ImageIndex := 15;
		Node.SelectedIndex := 15;
	end else if Source is TFavoriteBoardItem then begin
		FavoBoardItem := TFavoriteBoardItem( Source );
		Board := FavoBoardItem.Item;
		if Board <> nil then
			if not Board.IsThreadDatRead then
				GikoSys.ReadSubjectFile(Board);
		Node := FavoriteDM.TreeView.Items.AddChildObject(FavNode, Board.Title, Source);
		Node.ImageIndex := 15;
		Node.SelectedIndex := 15;
	end else if Source is TThreadItem then begin
		ThreadItem := TThreadItem( Source );
		FavoThreadItem				:= TFavoriteThreadItem.CreateWithItem( ThreadItem );
		Node := FavoriteDM.TreeView.Items.AddChildObject(FavNode, ThreadItem.Title, FavoThreadItem);
		Node.ImageIndex := 16;
		Node.SelectedIndex := 16;
	end else if Source is TBrowserRecord then begin
		ThreadItem := TBrowserRecord( Source ).Thread;
		FavoThreadItem				:= TFavoriteThreadItem.CreateWithItem( ThreadItem );
		Node := FavoriteDM.TreeView.Items.AddChildObject(FavNode, ThreadItem.Title, FavoThreadItem);
		Node.ImageIndex := 16;
		Node.SelectedIndex := 16;
	end else if Source is TFavoriteThreadItem then begin
		FavoThreadItem := TFavoriteThreadItem( Source );
		ThreadItem := FavoThreadItem.Item;
		Node := FavoriteDM.TreeView.Items.AddChildObject(FavNode, ThreadItem.Title, Source);
		Node.ImageIndex := 16;
		Node.SelectedIndex := 16;
	end;

	if not (TObject(SenderNode.Data) is TFavoriteFolder) then
		if Node <> nil then
			FavoriteMoveTo( SenderNode, Node );

end;

procedure TGikoForm.FavoriteDragDrop( SenderNode: TTreeNode; Source: TObject );
var
	idx: Integer;
	SourceNode: TTreeNode;
	LinkToolButton: TLinkToolButton;
begin

	if SenderNode = nil then
		Exit;

	if not (TObject( SenderNode.Data ) is TFavoriteFolder) then
		if FDropSpaceNode <> nil then
			SenderNode := FDropSpaceNode;

	if Source = FavoriteTreeView then begin
		SourceNode := FavoriteTreeView.Selected;
		FavoriteMoveTo( SenderNode, SourceNode );
	end else if Source is TLinkToolButton then begin
		LinkToolButton := TLinkToolButton( Source );
		SourceNode := TreeNodeDataFind( FavoriteTreeView.Items.GetFirstNode, LinkToolButton.Data );
		FavoriteMoveTo( SenderNode, SourceNode );
	end else if Source = BrowserTab then begin
		idx := BrowserTab.TabIndex;
		FavoriteAddTo( SenderNode, BrowserTab.Tabs.Objects[idx] );
	end else if Source = ListView then begin
		FavoriteAddTo( SenderNode, ListView.Selected.Data );
	end else if Source = TreeView then begin
		FavoriteAddTo( SenderNode, TreeView.Selected.Data );
	end;
end;

procedure TGikoForm.FavoriteTreeViewDragDrop(Sender, Source: TObject; X,
	Y: Integer);
var
	SenderNode: TTreeNode;
begin

	SenderNode := FavoriteTreeView.GetNodeAt(X, Y);
	if SenderNode <> nil then begin
		FavoriteDragDrop( SenderNode, Source );
	end;

	//�󔒍��ڂ�������폜����
	if FDropSpaceNode <> nil then begin
		try
			FDropSpaceNode.Delete;
		finally
			FDropSpaceNode := nil;
		end;
	end;
	//�X�V�������Ƃ�������
	FavoriteDM.Modified := true;

	SetLinkBar;

end;

procedure TGikoForm.FavoriteTreeViewEdited(Sender: TObject;
	Node: TTreeNode; var S: String);
begin
	//�X�V�������Ƃ�������
	FavoriteDM.Modified := true;

	FavoriteTreeView.ReadOnly := True;
	SetLinkBar;

end;

procedure TGikoForm.FavoriteTreeViewKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if not TTreeView(Sender).IsEditing then begin
		Case Key of
		VK_F2:
			begin
				FClickNode := FavoriteTreeView.Selected;
				GikoDM.FavoriteTreeViewRenameActionExecute( Sender );
			end;
		VK_DELETE:
			begin
				FClickNode := FavoriteTreeView.Selected;
				GikoDM.FavoriteTreeViewDeleteActionExecute( Sender );
			end;
		VK_RETURN:
			begin
			FavoriteClick( FavoriteTreeView.Selected );
			FavoriteTreeView.Selected.Expanded := not FavoriteTreeView.Selected.Expanded;
			end;
		VK_SPACE:
			begin
			FClickNode := FavoriteTreeView.Selected;
			GikoDM.FavoriteTreeViewReloadActionExecute( Sender );
			end;
		end;
	end else begin
		//�ҏW����ESC����������A�ҏW���I�����āA���̕�����ɖ߂�
		if Key = VK_ESCAPE then begin
			if (TTreeView(Sender).Selected <> nil) then begin
				TTreeView(Sender).Selected.Text := FOrigenCaption;
			end;
			TTreeView(Sender).Selected.Focused := False;
		end;
	end;

end;

procedure TGikoForm.FavoriteTreePopupMenuPopup(Sender: TObject);
var
	i: Integer;
	LinkToolButton: TLinkToolButton;
begin

	if FavoriteTreePopupMenu.PopupComponent = FavoriteTreeView then begin
	
		FClickNode := FavoriteTreeView.Selected;

	end else if FavoriteTreePopupMenu.PopupComponent is TLinkToolButton then begin

		LinkToolButton := TLinkToolButton( FavoriteTreePopupMenu.PopupComponent );
		for i := 0 to FavoriteTreeView.Items.Count - 1 do begin
			if FavoriteTreeView.Items[i].Text = Favorite.FAVORITE_LINK_NAME then begin
				FClickNode := FavoriteTreeView.Items[i];
				Break;
			end;
		end;
		for i := 0 to FClickNode.Count - 1 do begin
			if FClickNode.Item[i].Data = LinkToolButton.Data then begin
				FClickNode := FClickNode.Item[i];
				Break;
			end;
		end;

	end;

	if FClickNode = nil then begin
		FavoriteTreeBrowseFolderPopupMenu.Visible := False;
		FavoriteTreeDeletePopupMenu.Visible := False;
		FavoriteTreeRenamePopupMenu.Visible := False;
		FavoriteTreeNewFolderPopupMenu.Visible := False;
		FavoriteTreeURLCopyPopupMenu.Visible := False;
		FavoriteTreeNameCopyPopupMenu.Visible := False;
		FavoriteTreeNameURLCopyPopupMenu.Visible := False;
		FavoriteTreeReloadPopupMenu.Visible := False;
		FavoriteTreeLogDeletePopupMenu.Visible := False;
		FavoriteTreeItemNameCopyPopupMenu.Visible := False;
	end else if FClickNode.IsFirstNode then begin
		FavoriteTreeBrowseFolderPopupMenu.Visible := True;
		FavoriteTreeDeletePopupMenu.Visible := False;
		FavoriteTreeRenamePopupMenu.Visible := False;
		FavoriteTreeNewFolderPopupMenu.Visible := True;
		FavoriteTreeURLCopyPopupMenu.Visible := False;
		FavoriteTreeNameCopyPopupMenu.Visible := False;
		FavoriteTreeNameURLCopyPopupMenu.Visible := False;
		FavoriteTreeReloadPopupMenu.Visible := False;
		FavoriteTreeLogDeletePopupMenu.Visible := False;
		FavoriteTreeItemNameCopyPopupMenu.Visible := True;
	end else if FClickNode.Text = Favorite.FAVORITE_LINK_NAME then begin
		FavoriteTreeBrowseFolderPopupMenu.Visible := True;
		FavoriteTreeDeletePopupMenu.Visible := True;
		FavoriteTreeRenamePopupMenu.Visible := False;
		FavoriteTreeNewFolderPopupMenu.Visible := True;
		FavoriteTreeURLCopyPopupMenu.Visible := False;
		FavoriteTreeNameCopyPopupMenu.Visible := False;
		FavoriteTreeNameURLCopyPopupMenu.Visible := False;
		FavoriteTreeReloadPopupMenu.Visible := False;
		FavoriteTreeLogDeletePopupMenu.Visible := False;
		FavoriteTreeItemNameCopyPopupMenu.Visible := True;
	end else if TObject(FClickNode.Data) is TFavoriteFolder then begin
		FavoriteTreeBrowseFolderPopupMenu.Visible := True;
		FavoriteTreeDeletePopupMenu.Visible := True;
		FavoriteTreeRenamePopupMenu.Visible := True;
		FavoriteTreeNewFolderPopupMenu.Visible := True;
		FavoriteTreeURLCopyPopupMenu.Visible := False;
		FavoriteTreeNameCopyPopupMenu.Visible := True;
		FavoriteTreeNameURLCopyPopupMenu.Visible := False;
		FavoriteTreeReloadPopupMenu.Visible := False;
		FavoriteTreeLogDeletePopupMenu.Visible := False;
		FavoriteTreeItemNameCopyPopupMenu.Visible := True;
	end else if TObject(FClickNode.Data) is TFavoriteThreadItem then begin
		FavoriteTreeBrowseFolderPopupMenu.Visible := False;
		FavoriteTreeDeletePopupMenu.Visible := True;
		FavoriteTreeRenamePopupMenu.Visible := True;
		FavoriteTreeNewFolderPopupMenu.Visible := True;
		FavoriteTreeURLCopyPopupMenu.Visible := True;
		FavoriteTreeNameCopyPopupMenu.Visible := True;
		FavoriteTreeNameURLCopyPopupMenu.Visible := True;
		FavoriteTreeReloadPopupMenu.Visible := True;
		FavoriteTreeLogDeletePopupMenu.Visible := True;
		FavoriteTreeItemNameCopyPopupMenu.Visible := True;
	end else if TObject(FClickNode.Data) is TFavoriteBoardItem then begin
		FavoriteTreeBrowseFolderPopupMenu.Visible := False;
		FavoriteTreeDeletePopupMenu.Visible := True;
		FavoriteTreeRenamePopupMenu.Visible := True;
		FavoriteTreeNewFolderPopupMenu.Visible := True;
		FavoriteTreeURLCopyPopupMenu.Visible := True;
		FavoriteTreeNameCopyPopupMenu.Visible := True;
		FavoriteTreeNameURLCopyPopupMenu.Visible := True;
		FavoriteTreeReloadPopupMenu.Visible := True;
		FavoriteTreeLogDeletePopupMenu.Visible := False;
		FavoriteTreeItemNameCopyPopupMenu.Visible := True;
	end else begin
		FavoriteTreeBrowseFolderPopupMenu.Visible := False;
		FavoriteTreeDeletePopupMenu.Visible := False;
		FavoriteTreeRenamePopupMenu.Visible := False;
		FavoriteTreeNewFolderPopupMenu.Visible := False;
		FavoriteTreeURLCopyPopupMenu.Visible := False;
		FavoriteTreeNameCopyPopupMenu.Visible := False;
		FavoriteTreeNameURLCopyPopupMenu.Visible := False;
		FavoriteTreeReloadPopupMenu.Visible := False;
		FavoriteTreeLogDeletePopupMenu.Visible := False;
		FavoriteTreeItemNameCopyPopupMenu.Visible := False;
	end;

end;

procedure TGikoForm.FavoriteBrowseFolder( node: TTreeNode );
var
	i: Integer;
begin

	if not (TObject(node.Data) is TFavoriteFolder) then
		exit;

	for i := 0 to node.Count - 1 do
	begin
		if TObject(node.Item[i].Data) is TFavoriteFolder then
			FavoriteBrowseFolder( node.Item[i] )
		else if TObject(node.Item[i].Data) is TFavoriteThreadItem then
			FavoriteClick( node.Item[i], False );
	end;

end;
function TGikoForm.TreeNodeDataFind(Node: TTreeNode; FindPointer: Pointer): TTreeNode;
var
	Found: TTreeNode;
	i: Integer;
begin

	for i := 0 to Node.Count - 1 do begin
		if Node.Item[i].Data = FindPointer then begin
			Result := Node.Item[i];
			Exit;
		end else if Node.Item[i].Count > 0 then begin
			Found := TreeNodeDataFind( Node.Item[i], FindPointer );
			if Found <> nil then begin
				Result := Found;
				Exit;
			end;
		end;
	end;

	Result := nil;

end;

procedure TGikoForm.LinkToolBarDragDrop(Sender, Source: TObject; X,
	Y: Integer);
var
	i: Integer;
	SenderNode: TTreeNode;
begin

	SenderNode := nil;
	for i := 0 to FavoriteTreeView.Items.Count - 1 do begin
		if FavoriteTreeView.Items[i].Text = Favorite.FAVORITE_LINK_NAME then begin
			SenderNode := FavoriteTreeView.Items[i];
			Break;
		end;
	end;
	SenderNode.Selected := False;
	
	FavoriteDragDrop( SenderNode, Source );

	SetLinkBar;
end;

procedure TGikoForm.BrowserTabMouseUp(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if FDragWFirst = true then
		FDragWFirst := false;

    // �}�E�X�̒��{�^���ŕ����Ƃ��ɍő剻���Ă��܂��̂�h���@
    if Button <> mbMiddle then begin
        if GikoSys.Setting.ListOrientation = gloHorizontal then begin
            if GikoSys.Setting.ListWidthState = glsMin then begin
                GikoDM.BrowserMaxAndFocusAction.Execute;
            end;
        end else begin
            if GikoSys.Setting.ListHeightState = glsMin then begin
                GikoDM.BrowserMaxAndFocusAction.Execute;
            end;
        end;
    end;
end;

procedure TGikoForm.LinkToolBarDragOver(Sender, Source: TObject; X,
	Y: Integer; State: TDragState; var Accept: Boolean);
begin

	FavoriteDragOver( Sender, Source, X, Y, State, Accept );

end;

procedure TGikoForm.FavoriteTreeViewEndDrag(Sender, Target: TObject; X,
	Y: Integer);
begin

	if FDropSpaceNode <> nil then begin
		try
			FDropSpaceNode.Delete;
		finally
			FDropSpaceNode := nil;
		end;
		//�X�V�������Ƃ�������
		FavoriteDM.Modified := true;
		SetLinkBar;
	end;

end;

procedure TGikoForm.SetListViewBackGroundColor(value: TColor);
begin
	if FListViewBackGroundColor <> value then begin
		FListViewBackGroundColor := value;
		ListView.Color := FListViewBackGroundColor;
	end;
end;
procedure TGikoForm.FavoriteTreeBrowseBoardPopupMenuClick(Sender: TObject);
var
	threadItem	: TThreadItem;
	boardItem		: TBoard;
begin

	if FClickNode = nil then Exit;

	if (TObject(FClickNode.Data) is TFavoriteThreadItem) then begin

		threadItem := TFavoriteThreadItem( FClickNode.Data ).Item;
		if threadItem = nil then
			Exit;
		GikoSys.OpenBrowser( threadItem.ParentBoard.URL, gbtAuto );

	end else if (TObject(FClickNode.Data) is TFavoriteBoardItem) then begin

		boardItem := TFavoriteBoardItem( FClickNode.Data ).Item;
		if boardItem = nil then
			Exit;
		GikoSys.OpenBrowser( boardItem.URL, gbtAuto );

	end;

end;

procedure TGikoForm.BrowserTabContextPopup(Sender: TObject;
	MousePos: TPoint; var Handled: Boolean);
var
	idx : Integer;
begin
		idx := BrowserTab.IndexOfTabAt(MousePos.X, MousePos.Y);
		if BrowserTab.TabIndex <> idx then begin
		BrowserTab.TabIndex := idx;
			BrowserTab.OnChange(nil);
		end;
end;

procedure TGikoForm.KonoresCopy(Number: Integer; ReplaceTag : Boolean);
var
	ThreadItem: TThreadItem;
	tmp: string;
	FileName: string;
	Res: TResRec;
	Header: string;
	Body: string;
	boardPlugIn : TBoardPlugIn;
begin
	if Number = 0 then Exit;
	ThreadItem := GetActiveContent(True);

	if ThreadItem <> nil then begin
		//if ThreadItem.IsBoardPlugInAvailable then begin
        if ThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
			//===== �v���O�C���ɂ��\��
			//boardPlugIn		:= ThreadItem.BoardPlugIn;
            boardPlugIn		:= ThreadItem.ParentBoard.BoardPlugIn;

			// �t�H���g��T�C�Y�̐ݒ�
			// �����R�[�h�̓v���O�C���ɔC����
			//�����łQ�����˂��dat�̌`���łP�s�ǂݍ��߂�Υ���B
			tmp := boardPlugIn.GetDat( DWORD( threadItem ), Number );
		end else begin
      FileName := ThreadItem.FilePath;
      tmp := GikoSys.ReadThreadFile(FileName, Number);
		end;
		if tmp <> '' then begin
			THTMLCreate.DivideStrLine(tmp, @Res);

			Header := IntToStr(Number) + ' �F' + Res.FName + ' �F' + Res.FDateTime + #13#10;
			if ReplaceTag then begin
				Header := CustomStringReplace(Header, '</b>', '',true);
				Header := CustomStringReplace(Header, '<b>', '',true);
				Header := CustomStringReplace(Header, '<br>', '',true);
				Header := DeleteFontTag(Header);
			end;
			//if ThreadItem.IsBoardPlugInAvailable then begin
            if ThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
				Body := CustomStringReplace(Res.FBody, '<br>', #13#10,true);
				Body := CustomStringReplace(Body, '<br>', #13#10,true);
			end else begin
				Body := CustomStringReplace(Res.FBody, ' <br> ', #13#10,true);
				Body := CustomStringReplace(Body, ' <br>', #13#10,true);
				Body := CustomStringReplace(Body, '<br> ', #13#10,true);
				Body := CustomStringReplace(Body, '<br>', #13#10,true);

			end;
			Body := CustomStringReplace(Body, '</a>', '',true);

			Body := HTMLCreater.DeleteLink(Body);
			if ReplaceTag then begin
				Body := CustomStringReplace(Body, '&lt;', '<');
				Body := CustomStringReplace(Body, '&gt;', '>');
				Body := CustomStringReplace(Body, '&quot;', '"');
				Body := CustomStringReplace(Body, '&amp;', '&');
				//Body := CustomStringReplace(Body, '&nbsp;', ' ');
			end;

			Header := Header + Body;

			Clipboard.SetTextBuf( PChar(Header) );
		end;
	end;
end;


procedure TGikoForm.BrowserTabPopupMenuPopup(Sender: TObject);
var
    i:Integer;
begin
    for i := 0  to BrowserTabPopupMenu.Items.Count - 1 do begin
        if (BrowserTabPopupMenu.Items[i].Name='RoundItem') then begin
            AddRoundNameMenu(BrowserTabPopupMenu.Items[i]);
        end else if (BrowserTabPopupMenu.Items[i].Name='BoardThreadItem') then begin
            AddMenuSameBoardThread(BrowserTabPopupMenu.Items[i])
        end;
    end;
end;
//! �A�N�e�B�u�ȃ^�u�Ɠ����̊J���Ă���X���b�h�����j���[�A�C�e���ɒǉ�
procedure TGikoForm.AddMenuSameBoardThread(MenuItem: TMenuItem);
var
	i: Integer;
	Item: TMenuItem;
begin
    MenuItem.Clear;
    for i := 0 to BrowserTab.Tabs.Count - 1 do begin
        // �������ǂ���
        if (FActiveContent.Thread.ParentBoard =
            TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread.ParentBoard) then begin
            // �����͊O��
            if FActiveContent.Thread <>
                TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread then begin
                Item := TMenuItem.Create(Self);
                Item.Caption := TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread.Title;
                Item.Hint    := TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread.URL;
                Item.OnClick := SameBoardThreadSubItemOnClick;
                MenuItem.Add(Item);
            end;
        end;
    end;
    // ���������Ȃ�g�p�ł��Ȃ��悤�ɂ���
    MenuItem.Enabled := MenuItem.Count > 0;
end;
//!  �A�N�e�B�u�ȃ^�u�Ɠ����̊J���Ă���X���b�h�N���b�N�C�x���g
procedure TGikoForm.SameBoardThreadSubItemOnClick(Sender: TObject);
var
	i: Integer;
	MenuItem: TMenuItem;
begin
	if Sender is TMenuItem then begin
        try
            MenuItem := TMenuItem(Sender);
            for i := 0 to BrowserTab.Tabs.Count - 1 do begin
                // �������ǂ���
                if (FActiveContent.Thread.ParentBoard =
                    TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread.ParentBoard) then begin
                    if FActiveContent.Thread <>
                        TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread then begin
                        if (MenuItem.Hint = TBrowserRecord(BrowserTab.Tabs.Objects[i])
                                .Thread.URL) then begin
                            MoveToURL( MenuItem.Hint);
                            Exit;
                        end;
                    end;
                end;
            end;
        except
        end;
	end;
end;
procedure TGikoForm.FavoritesURLReplace(oldURLs: TStringList; newURLs: TStringList);
begin
	FavoriteDM.URLReplace(oldURLs, newURLs);
end;

procedure TGikoForm.RoundListURLReplace(oldURLs: TStringList; newURLs: TStringList);
begin
	RoundList.URLReplace(oldURLs, newURLs);
end;

procedure TGikoForm.TabFileURLReplace(oldURLs: TStringList; newURLs: TStringList);
const
	Filename = 'tab.sav';
	bFilename = '~tab.sav';
var
	i, j: Integer;
	tempString: string;
	tmpURL: string;
	oldHost: string;
	oldBoardName: string;
	newHost: string;
	newBoardName: string;
	TabList: TStringList;
begin

	if oldURLs.Count <> newURLs.Count then begin
		Exit;
	end;
	if FileExists(GikoSys.GetAppDir + 'tab.sav') then begin
		TabList := TStringList.Create;
		try
			TabList.LoadFromFile(GikoSys.GetAppDir + Filename);

			//��������AThread��URL�̕ύX
			//�ʓ|������thread�͂��ꂼ��URL���`���b�N���Ȃ������Ă��Ȃ��Ⴂ���Ȃ��B
			for i := 0 to oldURLs.Count - 1 do begin
					tmpURL 			:= Copy(oldURLs[i], 1, Length(oldURLs[i]) -1);
					oldHost			:= Copy(tmpURL, 1, LastDelimiter('/', tmpURL) );
					oldBoardName    := Copy(tmpURL, LastDelimiter('/', tmpURL), Length(tmpURL) ) + '/';
					tmpURL 			:= Copy(newURLs[i], 1, Length(newURLs[i]) -1);
					newHost			:= Copy(tmpURL, 1, LastDelimiter('/', tmpURL) );
					newBoardName    := Copy(tmpURL, LastDelimiter('/', tmpURL), Length(tmpURL) ) + '/';

					for j := 0 to TabList.Count - 1 do begin
							tempString := TabList[j];
							if ( AnsiPos(oldBoardName, tempString) <> 0 ) and ( AnsiPos(oldHost, tempString ) <> 0 ) then begin
								tempString := StringReplace(tempString, oldHost, newHost,[]);
								TabList[j] := tempString;
							end;
					end;
			end;
			//�����܂ŁAThread��URL�̕ύX

			if FileExists( GikoSys.GetAppDir + Filename) then begin
				if FileExists( GikoSys.GetAppDir + bFilename) then
					DeleteFile(GikoSys.GetAppDir + bFilename);

				//�o�b�N�A�b�v�����B
				RenameFile(GikoSys.GetAppDir + Filename, GikoSys.GetAppDir + bFilename);
			end;

			TabList.SaveToFile(GikoSys.GetAppDir + Filename);
		finally
			TabList.Free;
		end;
	end;

end;

/// �ŏ��������
procedure TGikoForm.OnMinimize;
var
    doc: IHTMLDocument2;
begin
	if FActiveContent <> nil then begin
		FIsMinimize := mtMinimizing;
        doc := FActiveContent.Browser.ControlInterface.Document as IHTMLDocument2;
        if Assigned(doc) then begin
    		FActiveContent.Thread.ScrollTop := (doc.body as IHTMLElement2).ScrollTop;
        end;
	end;
end;

/// �ŏ������ꂽ (OnResized ����Ă΂��)
procedure TGikoForm.OnMinimized;
begin
	FIsMinimize := mtMinimized;
end;


procedure TGikoForm.BrowserTabResize(Sender: TObject);
begin
	CoolBarResized( Sender, BrowserCoolBar );
end;

// *************************************************************************
// ExternalBoardPlugInMain
// �v���O�C�����j���[�̍��ڂ����s���ꂽ
// *************************************************************************
procedure TGikoForm.OnPlugInMenuItem( Sender : TObject );
var
	item				: TMenuItem;
	boardPlugIn	: TBoardPlugIn;
begin

	if not (Sender is TMenuItem) then
		Exit;

	item := TMenuItem( Sender );
	if not Assigned( Pointer( item.Tag ) ) then
		Exit;

	// �v���O�C���̃��j���[�n���h�����Ăяo��
	boardPlugIn := TBoardPlugIn( item.Tag );
	boardPlugIn.PlugInMenu( item.Handle );

end;
// TreeView ���N���b�N���ꂽ
procedure TGikoForm.TreeClick( Node : TTreeNode );
begin

	if Node = nil then
		Exit;

	if FTreeType = gttHistory then begin
		if Node <> nil then
			if TObject( Node.Data ) is TFavoriteThreadItem then
				if GetActiveContent <> TFavoriteThreadItem( Node.Data ).Item then
					FavoriteClick( Node );
		Exit;
	end;
    //���ݕ\�����Ă���̂Ɠ����Ȃ�ĕ`�悵�Ȃ�
	if ActiveList = Node.Data then
		Exit;

	ActiveListColumnSave;

	if TObject(Node.Data) is TBBS then begin
		SetActiveList(Node.data);
	end else if TObject(Node.Data) is TCategory then begin
		SetActiveList(Node.data);
	end else if TObject(Node.Data) is TBoard then begin
		if not TBoard(Node.Data).IsThreadDatRead then begin
			Screen.Cursor := crHourGlass;
			try
		if not TBoard(Node.Data).IsThreadDatRead then
					GikoSys.ReadSubjectFile(Node.Data);
			finally
				Screen.Cursor := crDefault;
			end;
		end;
		Sort.SetSortDate(Now());
		SetActiveList(Node.data);
	end;

	if TObject( Node.Data ) is TBoard then begin // not TCategory
		if GikoSys.Setting.ListOrientation = gloHorizontal then begin
			if GikoSys.Setting.ListWidthState = glsMax then begin
				GikoDM.BrowserMinAction.Execute;
				if GikoForm.Visible then
					ListView.SetFocus;
			end;
		end else begin
			if GikoSys.Setting.ListHeightState = glsMax then begin
				GikoDM.BrowserMinAction.Execute;
				if GikoForm.Visible then
					ListView.SetFocus;
			end;
		end;
	end;

end;

// TreeView ���_�u���N���b�N���ꂽ
procedure TGikoForm.TreeDoubleClick( Node : TTreeNode );
var
	Board				: TBoard;
	ThreadItem	: TThreadItem;
	shiftDown	: Boolean;
begin

	if Node = nil then Exit;

	shiftDown	:= GetAsyncKeyState(VK_SHIFT) = Smallint($8001);

	if FTreeType = gtt2ch then begin
		if not (TObject(Node.Data) is TBoard) then Exit;
		Board := TBoard(Node.Data);
		DownloadList(Board, shiftDown);
	end else if FTreeType = gttHistory then begin
		if not (TObject(Node.Data) is TFavoriteThreadItem) then Exit;
		ThreadItem := TFavoriteThreadItem(Node.Data).Item;
		DownloadContent(ThreadItem, shiftDown);
	end;

end;
// *************************************************************************
//! �c���[�r���[��KeyDown�C�x���g
// *************************************************************************
procedure TGikoForm.TreeViewKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if Key = VK_BACK then begin
//		UpFolderButtonClick(Sender);
	end else if Key = VK_SPACE then begin
		TreeDoubleClick( TreeView.Selected );
	end else if Key = VK_RETURN then begin
		TreeClick( TreeView.Selected );
        // �����̏ꍇ�A������Ă���̂Ń`�F�b�N����
        if (TreeView.Selected <> nil) then begin
    		TreeView.Selected.Expanded := not TreeView.Selected.Expanded;
        end;
	end;
end;
//! ���C�ɓ����MouseDown�C�x���g
procedure TGikoForm.FavoriteTreeViewMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	favItem				: TTreeNode;
	favThreadItem	: TFavoriteThreadItem;
	rect: TRect;
begin
	case Button of
	mbLeft:
		begin
			if not (ssAlt in Shift) and (FavoriteTreeView.Selected <> nil) and 
				(FavoriteTreeView.Selected = FavoriteTreeView.GetNodeAt(X, Y)) then begin
				//�}�E�X��node�̏�ɂ��邩
				rect := FavoriteTreeView.Selected.DisplayRect(true);
				// �A�C�R�������ɂ��炷
				if ((rect.Left - FavoriteTreeView.Indent <= X) and (rect.Right >= X)) and
					((rect.Bottom >= Y) and (rect.Top <= Y)) then begin
					if ssDouble in Shift then begin
						FClickNode := FavoriteTreeView.Selected;
						GikoDM.FavoriteTreeViewReloadActionExecute(Sender);
						FClickNode := nil;
					end else begin
						FavoriteClick(
							TObject(FavoriteTreeView.Selected));
					end;
				end;
			end;
		end;
	mbMiddle:
		begin
			favItem := FavoriteTreeView.GetNodeAt( X, Y );
			if favItem = nil then Exit;

			if TObject( favItem.Data ) is TFavoriteThreadItem then begin
				favThreadItem := TFavoriteThreadItem( favItem.Data );
				if favThreadItem.Item <> nil then
					InsertBrowserTab( favThreadItem.Item, False );
			end;
		end;
	end;

end;

procedure TGikoForm.MessagePanelResize(Sender: TObject);
begin

	if FIsIgnoreResize <> rtNone then
		Exit;

	if GikoSys.Setting.ListOrientation = gloVertical then begin
		if GikoSys.Setting.ListHeightState = glsMin then begin
			// �ŏ��\���ɂ���
			ViewPanel.Height := ThreadMainPanel.Height - BrowserCoolBar.Height - 7;
		end;
	end;

end;

procedure TGikoForm.OnResized;
var
	doc : IHTMLDocument2;
begin
	FOldFormWidth := Width;
	FIsIgnoreResize := rtNone;

	case FIsMinimize of
	mtMinimizing:
		begin
			// �ŏ������ł���
			PostMessage( Handle, USER_MINIMIZED, 0, 0 );
		end;

	mtMinimized:
		begin
			// �ŏ����͊��Ɋ������Ă��� (�܂�^�X�N�o�[����E�B���h�E�𕜌���)
			if FActiveContent <> nil then begin
				doc := FActiveContent.Browser.ControlInterface.Document as IHTMLDocument2;
				(doc.body as IHTMLElement2).ScrollTop := FActiveContent.Thread.ScrollTop;
			end;
			FIsMinimize := mtNone;
		end;
	end;

end;
// *************************************************************************
//! �X���b�h�u���E�U�N���b�N�C�x���g
// *************************************************************************
function TGikoForm.WebBrowserClick(Sender: TObject): WordBool;
var
	e: IHTMLElement;
    doc : IHTMLDocument2;
    FOleInPlaceActiveObject: IOleInPlaceActiveObject;
	p : TPoint;
	AID: string;
begin
	result := true;
    if not Assigned(FActiveContent) then
        Exit;
    if not Assigned(FActiveContent.Browser) then
        Exit;

	try
		FOleInPlaceActiveObject := FActiveContent.Browser.ControlInterface as IOleInPlaceActiveObject;
		FOleInPlaceActiveObject.OnFrameWindowActivate(True);
		GetCursorPos(p);

		p.x := p.x - FActiveContent.Browser.ClientOrigin.x;
		p.y := p.y - FActiveContent.Browser.ClientOrigin.y;

		doc := FActiveContent.Browser.ControlInterface.Document as IHTMLDocument2;
		if not Assigned(doc) then
			Exit;

		e := doc.elementFromPoint(p.x, p.y);
		if not Assigned(e) then
			Exit;

		if (e.className = 'date') or (e.id = 'date') then begin
			AID := GikoSys.ExtructResID(e.innerText);
            ShowSameIDAncher(AID);
		end;
	except
	end;
end;
procedure TGikoForm.ShowSameIDAncher(const AID: String);
const
    LIMIT = 20;
var
	numbers : TStringList;
    limited : Integer;
begin
    numbers := TStringList.Create;
    try

        GikoSys.GetSameIDRes(AID, FActiveContent.Thread, numbers);
        limited := LIMIT;
        if not (GikoSys.Setting.LimitResCountMessage) then begin
            limited := -1;
        end else if (numbers.Count > LIMIT) then begin
            if (GikoUtil.MsgBox(Handle,
                    IntToStr(LIMIT) + '�ȏ゠��܂����A���ׂĕ\�����܂����H',
                    'ID�|�b�v�A�b�v�x��',
                    MB_YESNO or MB_ICONQUESTION) = ID_YES) then begin
                limited := -1;
            end
        end;
        FActiveContent.IDAnchorPopup(
            GikoSys.CreateResAnchor(numbers, FActiveContent.Thread, limited));
    finally
        numbers.Free;
    end;
end;
//�X���b�h�ꗗ���ő剻���ăt�H�[�J�X�𓖂Ă�
procedure TGikoForm.SelectTimerTimer(Sender: TObject);
begin
	SelectTimer.Interval := 0;
	if not (ListView.Selected = nil) then
		if( FActiveContent = nil) or
				(GetActiveContent <> TThreadItem(ListView.Selected.Data) ) then begin
			ListClick;
		end;
end;

/// ListView �̃J����������шʒu�̕ۑ�
procedure TGikoForm.ActiveListColumnSave;
var
	ActivListObj	: TObject;
	i, id, idx		: Integer;
	BBSOrder			: TGikoBBSColumnList;
	CategoryOrder	: TGikoCategoryColumnList;
	BoardOrder		: TGikoBoardColumnList;
begin

	ActivListObj := ActiveList;
	if ActivListObj is TBBS then begin
		//===== �J�e�S�����X�g =====
		BBSOrder := TGikoBBSColumnList.Create;
		try
			for i := 0 to ListView.Columns.Count - 1 do begin
				// �����̎擾
				idx := ListView.Column[ i ].Tag;
				id := Ord( GikoSys.Setting.BBSColumnOrder[ idx ] );
				BBSOrder.Add( TGikoBBSColumnID( id ) );
				// ���̕ۑ�
				GikoSys.Setting.BBSColumnWidth[ id ] := ListView.Column[ i ].Width;
			end;
			for i := 0 to ListView.Columns.Count - 1 do
				// �����̕ۑ�
				GikoSys.Setting.BBSColumnOrder[ i ] := BBSOrder[ i ];
		finally
			BBSOrder.Free;
		end;
	end else if ActivListObj is TCategory then begin
		//===== ���X�g =====
		CategoryOrder := TGikoCategoryColumnList.Create;
		try
			for i := 0 to ListView.Columns.Count - 1 do begin
				// �����̎擾
				idx := ListView.Column[ i ].Tag;
				id := Ord( GikoSys.Setting.CategoryColumnOrder[ idx ] );
				CategoryOrder.Add( TGikoCategoryColumnID( id ) );
				// ���̕ۑ�
				GikoSys.Setting.CategoryColumnWidth[ id ] := ListView.Column[ i ].Width;
			end;
			for i := 0 to ListView.Columns.Count - 1 do
				// �����̕ۑ�
				GikoSys.Setting.CategoryColumnOrder[ i ] := CategoryOrder[ i ];
		finally
			CategoryOrder.Free;
		end;
	end else if ActivListObj is TBoard then begin
		//===== �X�����X�g =====
		BoardOrder := TGikoBoardColumnList.Create;
		try
			for i := 0 to ListView.Columns.Count - 1 do begin
				// �����̎擾
				idx := ListView.Column[ i ].Tag;
				id := Ord( GikoSys.Setting.BoardColumnOrder[ idx ] );
				BoardOrder.Add( TGikoBoardColumnID( id ) );
				// ���̕ۑ�
				GikoSys.Setting.BoardColumnWidth[ id ] := ListView.Column[ i ].Width;
			end;
			for i := 0 to ListView.Columns.Count - 1 do
				// �����̕ۑ�
				GikoSys.Setting.BoardColumnOrder[ i ] := BoardOrder[ i ];
		finally
			BoardOrder.Free;
		end;
	end;

end;

procedure TGikoForm.ListViewColumnRightClick(Sender: TObject;
	Column: TListColumn; Point: TPoint);
var
	i, j	: Integer;
	item	: TMenuItem;
begin

	// �|�b�v�A�b�v���j���[���N���A
	for i := ListColumnPopupMenu.Items.Count - 1 downto 0 do
		ListColumnPopupMenu.Items.Items[ i ].Free;

	// ���j���[�̍쐬 (���C���J�����͕K�{�Ȃ̂Ń��j���[�Ɋ܂߂Ȃ�)
	if TObject( FActiveList ) is TBBS then begin

		//===== �J�e�S�����X�g =====
		for i := 1 to Length( GikoBBSColumnCaption ) - 1 do begin
			item := TMenuItem.Create( ListColumnPopupMenu );
			item.Caption := GikoBBSColumnCaption[ i ];
			item.Tag := i;
			item.OnClick := ListColumnPopupMenuOnClick;
			for j := GikoSys.Setting.BBSColumnOrder.Count - 1 downto 0 do begin
				if GikoSys.Setting.BBSColumnOrder[ j ] = TGikoBBSColumnID( i ) then begin
					item.Checked := True;
					Break;
				end;
			end;
			ListColumnPopupMenu.Items.Add( item );
		end;

	end else if TObject( FActiveList ) is TCategory then begin

		//===== ���X�g =====
		for i := 1 to Length( GikoCategoryColumnCaption ) - 1 do begin
			item := TMenuItem.Create( ListColumnPopupMenu );
			item.Caption := GikoCategoryColumnCaption[ i ];
			item.Tag := i;
			item.OnClick := ListColumnPopupMenuOnClick;
			for j := GikoSys.Setting.CategoryColumnOrder.Count - 1 downto 0 do begin
				if GikoSys.Setting.CategoryColumnOrder[ j ] = TGikoCategoryColumnID( i ) then begin
					item.Checked := True;
					Break;
				end;
			end;
			ListColumnPopupMenu.Items.Add( item );
		end;

	end else if TObject( FActiveList ) is TBoard then begin

		//===== �X�����X�g =====
		for i := 1 to Length( GikoBoardColumnCaption ) - 1 do begin
			item := TMenuItem.Create( ListColumnPopupMenu );
			item.Caption := GikoBoardColumnCaption[ i ];
			item.Tag := i;
			item.OnClick := ListColumnPopupMenuOnClick;
			for j := GikoSys.Setting.BoardColumnOrder.Count - 1 downto 0 do begin
				if GikoSys.Setting.BoardColumnOrder[ j ] = TGikoBoardColumnID( i ) then begin
					item.Checked := True;
					Break;
				end;
			end;
			ListColumnPopupMenu.Items.Add( item );
		end;

	end;

	// ���j���[�̕\��
	Point := ListView.ClientToScreen( Point );
	if ListColumnPopupMenu.Items.Count > 0 then
		ListColumnPopupMenu.Popup( Point.X, Point.Y );

end;

/// ListColumnPopupMenu �A�C�e���̃N���b�N�C�x���g
procedure	TGikoForm.ListColumnPopupMenuOnClick( Sender : TObject );
var
	i					: Integer;
	orderList	: TList;
	item			: TMenuItem;
begin

	if not (Sender is TMenuItem) then
		Exit;

	ActiveListColumnSave;
	item := TMenuItem( Sender );

	if TObject( FActiveList ) is TBBS then
		orderList := GikoSys.Setting.BBSColumnOrder
	else if TObject( FActiveList ) is TCategory then
		orderList := GikoSys.Setting.CategoryColumnOrder
	else if TObject( FActiveList ) is TBoard then
		orderList := GikoSys.Setting.BoardColumnOrder
	else
		Exit;

	if item.Checked then begin
		// �J�����̍폜
		for i := orderList.Count - 1 downto 0 do begin
			if Integer( orderList[ i ] ) = item.Tag then begin
				orderList.Delete( i );
				Break;
			end;
		end;
	end else begin
		// �J�����̒ǉ�
		orderList.Add( Pointer( item.Tag ) );
	end;

	SetActiveList( FActiveList );

end;

procedure TGikoForm.OnGestureStart(Sender: TObject);
begin
//
end;

procedure TGikoForm.OnGestureMove(Sender: TObject);
var
	s: string;
	Action: TAction;
	ActStr: string;
	P : TPoint;
begin
	//�}�E�X�ʒu�̎擾
	GetCursorPos(P);
	//�R���|�[�l���g���擾
	s := MouseGesture.GetGestureStr;
	ActStr := '';
	Action := GikoSys.Setting.Gestures.GetGestureAction(s);
	if Action <> nil then
		ActStr := '�i' + Action.Caption + '�j';
	s := '�W�F�X�`���[: ' + s + ActStr;
	StatusBar.Panels[1].Text := s;
end;

procedure TGikoForm.OnGestureEnd(Sender: TObject);
var
	s: string;
	Action: TAction;
begin
	s := MouseGesture.GetGestureStr;
    MouseGesture.Clear;
	Action := GikoSys.Setting.Gestures.GetGestureAction(s);
	if Action <> nil then
		Action.Execute;
	StatusBar.Panels[1].Text := '';
end;

procedure TGikoForm.ListViewCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
	ThreadItem: TThreadItem;
begin
	DefaultDraw := true;
	if TObject(Item.Data) is TThreadItem then begin
		ThreadItem := TThreadItem(Item.Data);
		if ( FUseOddResOddColor ) and ( ThreadItem.Count <> 0 ) and ( ThreadItem.AllResCount <> ThreadItem.Count) then begin
			ListView.Canvas.Brush.Color := FOddColor;
			//�I������Ă��邯�ǁA�t�H�[�J�X���Ȃ��ƁA�O���C�ɂȂ�̂ŁA�����ɕύX
			if (GikoSys.Setting.UnFocusedBold) and
			 (Item.Selected) and (not ListView.Focused) then begin
				ListView.Canvas.Font.Style := [fsBold];
			end;
		end else begin
			ListView.Canvas.Brush.Color := FListViewBackGroundColor;
		end;

		if ThreadItem.UnRead then
			ListView.Canvas.Font.Style := [fsBold];
	end;

end;

procedure TGikoForm.FormActivate(Sender: TObject);
begin
	if GikoSys.Setting.GestureEnabled then begin
		GikoSys.Setting.Gestures.ClearGesture;
		GikoSys.Setting.Gestures.LoadGesture(
			GikoSys.Setting.GetGestureFileName, GikoDM.GikoFormActionList );
		MouseGesture.UnHook;
		MouseGesture.OnGestureStart := OnGestureStart;
		MouseGesture.OnGestureMove := OnGestureMove;
		MouseGesture.OnGestureEnd := OnGestureEnd;
		MouseGesture.SetHook(Handle);
	end else begin
		//MouseGesture.UnHook;
		MouseGesture.OnGestureStart := nil;
		MouseGesture.OnGestureMove := nil;
		MouseGesture.OnGestureEnd := nil;
	end;
end;

procedure TGikoForm.BrowserPanelResize(Sender: TObject);
begin
    if (FIsMinimize <> mtMinimizing) then begin
    	if (FActiveContent <> nil) and (FActiveContent.Browser <> nil) then begin
	    	MoveWindow(FActiveContent.Browser.Handle, 0, 0, BrowserPanel.ClientWidth, BrowserPanel.ClientHeight, false);
    	end;
    end;
end;
procedure TGikoForm.CoolBarResized(Sender: TObject; CoolBar: TCoolBar);
var
	coolSet 			: TCoolSet;
	toolbar				: TToolBar;
	band					: TCoolBand;
	affectedBand	: TCoolBand;
	i							: Integer;
begin
	if (FOldFormWidth = Width) and not IsIconic( Handle ) and (FIsIgnoreResize = rtNone) then begin
		FIsIgnoreResize := rtResizing;
		PostMessage( Handle, USER_RESIZED, 0, 0 );
		band := nil;
		// �ύX���ꂽ�N�[���o�[�̒l��ۑ�
		if CoolBar = MainCoolBar then begin
			for i := 0 to MAIN_COOLBAND_COUNT - 1 do begin
				CoolSet.FCoolID := CoolBar.Bands[i].ID;
				CoolSet.FCoolWidth := CoolBar.Bands[i].Width;
				CoolSet.FCoolBreak := CoolBar.Bands[i].Break;
				GikoSys.Setting.MainCoolSet[i] := CoolSet;
			end;
		end else if CoolBar = ListCoolBar then begin
			for i := 0 to LIST_COOLBAND_COUNT - 1 do begin
				CoolSet.FCoolID := CoolBar.Bands[i].ID;
				CoolSet.FCoolWidth := CoolBar.Bands[i].Width;
				CoolSet.FCoolBreak := CoolBar.Bands[i].Break;
				GikoSys.Setting.ListCoolSet[i] := CoolSet;
			end;
		end else if CoolBar = BrowserCoolBar then begin
			for i := 0 to BROWSER_COOLBAND_COUNT - 1 do begin
				CoolSet.FCoolID := CoolBar.Bands[i].ID;
				CoolSet.FCoolWidth := CoolBar.Bands[i].Width;
				CoolSet.FCoolBreak := CoolBar.Bands[i].Break;
				GikoSys.Setting.BrowserCoolSet[i] := CoolSet;
			end;
		end;
		if not (Sender is TToolBar) or (CoolBar = nil) then
			Exit;
		toolbar := TToolBar( Sender );
		// ���̕ύX���ꂽ�o���h��������
		affectedBand := nil;
		for i := CoolBar.Bands.Count - 1 downto 0 do begin
			if CoolBar.Bands[ i ].Control.Handle = toolbar.Handle then begin
				band	:= CoolBar.Bands[ i ];
				if band.Break or (i = 0) then begin
					if i + 1 < CoolBar.Bands.Count then
						if not CoolBar.Bands[ i + 1 ].Break then
							affectedBand := CoolBar.Bands[ i + 1 ];
				end else begin
					if i > 0 then
						affectedBand := CoolBar.Bands[ i - 1 ];
				end;
				Break;
			end;
		end;
		// �h���b�O���� band.Width ���X�V����Ȃ��̂ŁA�����̃T�C�Y����Ђ˂�o��
		if CoolBar = MainCoolBar then begin
			coolSet := GikoSys.Setting.MainCoolSet[ band.ID ];
			coolSet.FCoolWidth := toolbar.Width + 25;
			GikoSys.Setting.MainCoolSet[ band.ID ] := coolSet;
			if affectedBand <> nil then begin
				coolSet := GikoSys.Setting.MainCoolSet[ affectedBand.ID ];
				coolSet.FCoolWidth := affectedBand.Control.Width + 25;
				GikoSys.Setting.MainCoolSet[ affectedBand.ID ] := coolSet;
			end;
		end else if CoolBar = ListCoolBar then begin
			coolSet := GikoSys.Setting.ListCoolSet[ band.ID ];
			coolSet.FCoolWidth := toolbar.Width + 25;
			GikoSys.Setting.ListCoolSet[ band.ID ] := coolSet;
			if affectedBand <> nil then begin
				coolSet := GikoSys.Setting.ListCoolSet[ affectedBand.ID ];
				coolSet.FCoolWidth := affectedBand.Control.Width + 25;
				GikoSys.Setting.ListCoolSet[ affectedBand.ID ] := coolSet;
			end;
		end else if CoolBar = BrowserCoolBar then begin
			coolSet := GikoSys.Setting.BrowserCoolSet[ band.ID ];
			coolSet.FCoolWidth := toolbar.Width + 25;
			GikoSys.Setting.BrowserCoolSet[ band.ID ] := coolSet;
			if affectedBand <> nil then begin
				coolSet := GikoSys.Setting.BrowserCoolSet[ affectedBand.ID ];
				coolSet.FCoolWidth := affectedBand.Control.Width + 25;
				GikoSys.Setting.BrowserCoolSet[ affectedBand.ID ] := coolSet;
			end;
		end;
	end;
end;


procedure TGikoForm.MenuToolBarResize(Sender: TObject);
begin
	CoolBarResized( Sender, MainCoolBar );
end;

procedure TGikoForm.ListToolBarResize(Sender: TObject);
begin
	CoolBarResized( Sender, ListCoolBar );
end;

procedure TGikoForm.BrowserToolBarResize(Sender: TObject);
begin
	CoolBarResized( Sender, BrowserCoolBar );
end;

//���̃��X���ځ`��
procedure TGikoForm.IndividualAbon(Atag, Atype : Integer);
var
    doc : IHTMLDocument2;
	ThreadItem : TThreadItem;
	ReadList : TStringList;
	wordCount : TWordCount;
begin
    if not Assigned(FActiveContent) then
        Exit;
    doc := FActiveContent.Browser.ControlInterface.Document as IHTMLDocument2;
    if not Assigned(doc) then
        Exit;

	ThreadItem := GetActiveContent(True);
	ReadList := TStringList.Create;
	wordCount := TWordCount.Create;
	try
		ThreadItem.ScrollTop := (doc.body as IHTMLElement2).ScrollTop;
{$IFDEF SPAM_FILTER_ENABLED}
		// �X�p���ɐݒ�
		ReadList.LoadFromFile( ThreadItem.GetThreadFileName );
		GikoSys.SpamCountWord( ReadList[ ATag - 1 ], wordCount );
		GikoSys.SpamForget( wordCount, False );	// �n��������
		GikoSys.SpamLearn( wordCount, True );		// �X�p���ɐݒ�
{$ENDIF}
		// ���ځ[��ɐݒ�
		GikoSys.FAbon.AddIndividualAbon(Atag, Atype, ChangeFileExt(ThreadItem.GetThreadFileName, '.NG'));
	finally
		wordCount.Free;
		ReadList.Free;
	end;
	FActiveContent.Repaint := true;
	if ThreadItem <> nil then
		InsertBrowserTab( ThreadItem, True );
end;
//����ID��NG���[�h�ɓo�^
procedure TGikoForm.AddIDtoNGWord(invisible : boolean);
var
    doc : IHTMLDocument2;
	ThreadItem : TThreadItem;
	No : Integer;
{$IFDEF SPAM_FILTER_ENABLED}
	body : TStringList;
	ReadList		: TStringList;
	wordCount		: TWordCount;
{$ENDIF}
    id, dateStr: String;
    ThreadTitle: String;
    Idx: Integer;
begin
	No := KokoPopupMenu.Tag;
	if No = 0 then Exit;
	ThreadItem := GikoForm.KokoPopupThreadItem;
	if ThreadItem = nil then Exit;

    id := GikoSys.GetResID(No, ThreadItem);
    if (id <> '') and (not IsNoValidID(id)) then begin
        ThreadTitle := ThreadItem.Title;
        while (True) do begin
            Idx := Pos(#9, ThreadTitle);
            if (Idx < 1) then
                Break;
            Delete(ThreadTitle, Idx, 1);
        end;
        // �R�����g�Ƃ��āA�X���b�h���ƍ����̓��t��ǉ�
        DateTimeToString(dateStr, 'yyyymmdd', Now);
        id := id + #9'>>add ' + dateStr + ',' + ThreadTitle;
        if (GikoSys.FAbon.AddToken(id, invisible)) then begin
            GikoSys.FAbon.ReLoadFromNGwordFile;
            FActiveContent.Repaint := True;
        end;
    end else begin
        ShowMessage('ID���擾�ł��܂���ł����B');
    end;
{$IFDEF SPAM_FILTER_ENABLED}
    body := TStringList.Create;
    try
        GikoSys.GetSameIDRes(id, ThreadItem, body);
        ReadList		:= TStringList.Create;
        wordCount		:= TWordCount.Create;
        try
            // �X�p���ɐݒ�
            ReadList.LoadFromFile( ThreadItem.GetThreadFileName );
            for i := 0 to body.Count - 1 do begin
                GikoSys.SpamCountWord( ReadList[ i ], wordCount );
                GikoSys.SpamForget( wordCount, False );	// �n��������
                GikoSys.SpamLearn( wordCount, True );		// �X�p���ɐݒ�
            end;
        finally
            wordCount.Free;
            ReadList.Free;
        end;
    finally
        body.Free;
    end;
{$ENDIF}
    if (FActiveContent.Repaint) then begin
        doc := FActiveContent.Browser.ControlInterface.Document as IHTMLDocument2;

        if not Assigned(doc) then
            Exit;
        ThreadItem.ScrollTop := (doc.body as IHTMLElement2).ScrollTop;
        if ThreadItem <> nil then
            InsertBrowserTab( ThreadItem, True );
    end;
end;

//����ID�̂��ځ`��
procedure TGikoForm.IndividualAbonID(Atype : Integer);
var
	ThreadItem : TThreadItem;
	i, No : Integer;
	body : TStringList;
	ReadList		: TStringList;
	wordCount		: TWordCount;
begin
	No := KokoPopupMenu.Tag;
	if No = 0 then Exit;
	ThreadItem := GikoForm.KokoPopupThreadItem;
	if ThreadItem = nil then Exit;
	body := TStringList.Create;
	try
		GikoSys.GetSameIDRes(No, ThreadItem, body);

		ReadList		:= TStringList.Create;
		wordCount		:= TWordCount.Create;
		try
			ThreadItem.ScrollTop := FActiveContent.Browser.OleObject.Document.Body.ScrollTop;
{$IFDEF SPAM_FILTER_ENABLED}
			// �X�p���ɐݒ�
			ReadList.LoadFromFile( ThreadItem.GetThreadFileName );
{$ENDIF}
			for i := 0 to body.Count - 1 do begin
{$IFDEF SPAM_FILTER_ENABLED}
				GikoSys.SpamCountWord( ReadList[ i ], wordCount );
				GikoSys.SpamForget( wordCount, False );	// �n��������
				GikoSys.SpamLearn( wordCount, True );		// �X�p���ɐݒ�
{$ENDIF}
				// ���ځ[��ɐݒ�
				GikoSys.FAbon.AddIndividualAbon(StrToInt(body[i]), Atype, ChangeFileExt(ThreadItem.GetThreadFileName, '.NG'));
			end;
		finally
			wordCount.Free;
			ReadList.Free;
		end;
		FActiveContent.Repaint := true;
		if ThreadItem <> nil then
			InsertBrowserTab( ThreadItem, True );
	finally
		body.Free;
	end;

end;

procedure TGikoForm.KokoPopupMenuPopup(Sender: TObject);
var
	firstElement: IHTMLElement;
	doc: IHTMLDocument2;
begin
    try
    	doc := FActiveContent.Browser.ControlInterface.Document as IHTMLDocument2;
	    if Assigned(doc) then
		    firstElement := doc.all.item('idSearch', 0) as IHTMLElement;
    		if Assigned(firstElement) then
	    		if firstElement.style.visibility <> 'hidden' then
		    		firstElement.style.visibility := 'hidden';
    except
    end;
end;

procedure TGikoForm.RepaintAllTabsBrowser();
var
	i : Integer;
	ThreadItem: TThreadItem;
begin
	for i := BrowserTab.Tabs.Count - 1 downto 0 do
		TBrowserRecord(BrowserTab.Tabs.Objects[i]).Repaint := true;

	ThreadItem := GetActiveContent;
	if ThreadItem <> nil then
		InsertBrowserTab( ThreadItem, True );

end;

//ListView�̑I����Ԃ���������
procedure TGikoForm.ListViewKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	//�u���E�U�^�u�����ŁA�L�[�ړ��œǂݔ�΂����\�ɂ��邽�߂�
	//�������Ԃ�Timer�̏���
	//�Ƃ肠�����A�^�C�}�[���~����B
	SelectTimer.Interval := 0;
	if not (GikoSys.Setting.BrowserTabVisible) then begin
		if (GetActiveList is TBoard) then begin
			//Shift Alt Ctrl���b���ꂽ�Ƃ��́A�����L�[�𗣂��Ă��Ă�����
			if not ((ssShift in Shift) or (ssAlt in Shift) or (ssCtrl in Shift))  and
				(( Key = VK_LEFT) or (Key = VK_RIGHT) or
						(Key = VK_UP) or (Key = VK_DOWN)) then
					SelectTimer.Interval := GikoSys.Setting.SelectInterval;
		end;
	end;
end;
// *************************************************************************
//! ���C�ɓ���̕ҏW�J�n�C�x���g
// *************************************************************************
procedure TGikoForm.FavoriteTreeViewEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
	//�ҏW�O�̕�������ꎞ�ۑ�����
	FOrigenCaption := Node.Text;
end;
// *************************************************************************
//! Application��MainForm���擾����
// *************************************************************************
function TGikoForm.GetMainForm(): TComponent;
begin
	Result := Application.MainForm;
end;
// *************************************************************************
//! ���݂̃J�[�\�����擾����
// *************************************************************************
function TGikoForm.GetScreenCursor(): TCursor;
begin
	Result := Screen.Cursor;
end;
// *************************************************************************
//! �J�[�\����ݒ肷��
// *************************************************************************
procedure TGikoForm.SetScreenCursor(Cursor : TCursor);
begin
	if (Screen.Cursor <> Cursor) then
		Screen.Cursor := Cursor;
end;
// *************************************************************************
//! �L���r�l�b�g�����~�{�^���̃N���b�N�C�x���g
// *************************************************************************
procedure TGikoForm.CabinetCloseSpeedButtonClick(Sender: TObject);
begin
	//Action�Őݒ肷��ƃL���v�V�����������Ȃ��̂ŁAOnClick�C�x���g�ł�
	//�Ăяo���ɂ����@by ������
	if GikoDM.CabinetVisibleAction.Enabled then begin
		GikoDM.CabinetVisibleAction.Execute;
	end;
end;
// *************************************************************************
//! ���C�ɓ���L���r�l�b�g�̐����{�^���̃N���b�N�C�x���g
// *************************************************************************
procedure TGikoForm.FavoriteArrangeToolButtonClick(Sender: TObject);
begin
	if GikoDM.FavoriteArrangeAction.Enabled then begin
		GikoDM.FavoriteArrangeAction.Execute;
	end;
end;
// *************************************************************************
//! �M�R�i�r�̃��b�Z�[�W�n���h�����O	(���Ӂj�����ʂɒ��ӁI
// *************************************************************************
procedure TGikoForm.GikoApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
var
	wmMsg: TWMKey;
begin
	//GikoForm���A�N�e�B�u�ȂƂ������󂯎�� ���̃t�H�[���̂�����肵�Ȃ�����
	if Self.Active then begin
		case Msg.message of
			//�L�[���͂��ׂ�
			WM_KEYFIRST..WM_KEYLAST :
			begin
				//�L�[�A�b�v�͖�������@KeyDown�ƍ��킹�ĂQ��Ă΂�邩��
				if (Msg.message <> WM_KEYUP)
                    and (Msg.message <> WM_CHAR)
                    and (Msg.message <> WM_SYSKEYUP) then begin
					wmMsg.Msg := Msg.message;
					wmMsg.CharCode := Word(Msg.wParam);
					wmMsg.KeyData := Msg.lParam;
					//�t�H�[���̃V���[�g�J�b�g�̏����ɓ]��
					Self.OnShortCut(wmMsg, Handled);
				end;
			end;
		end;
	end else begin
        // Explorer��D&D���󂯂�Ƃ̔�A�N�e�B�u
        if Msg.message = WM_DROPFILES then begin
            AcceptDropFiles(Msg);
            Handled := True;
        end;
    end;
end;
// *************************************************************************
//! �A�v���P�[�V�������A�N�e�B�u�łȂ��Ȃ����Ƃ��̃C�x���g
// *************************************************************************
procedure TGikoForm.GikoApplicationEventsDeactivate(Sender: TObject);
begin
	Application.ProcessMessages;
	if not Application.Terminated then begin
		if PreviewTimer.Enabled then
    		PreviewTimer.Enabled := False;
		//�t�H�[�J�X�����̃A�v���ɕς�����Ƃ��Ƀ|�b�v�A�b�v����
        if (FResPopupBrowser <> nil) then
            FResPopupBrowser.Clear;

		//�v���r���[���B��
		if FPreviewBrowser <> nil then
			ShowWindow(FPreviewBrowser.Handle, SW_HIDE);
	end;

end;
// *************************************************************************
//! �A�v���P�[�V��������������Ȃ���O���E�����Ƃ��̃C�x���g
// *************************************************************************
procedure TGikoForm.GikoApplicationEventsException(Sender: TObject;
  E: Exception);
var
	s : String;
begin
	if (Sender <> nil) then begin
		s := ' [' + Sender.ClassName + ']' + #13#10;
	end else begin
		s := ' [ Sender is nil ] ' + #13#10;
	end;
	s := s + E.Message;
	MsgBox(Handle, s, '��������Ȃ�������O', MB_OK or MB_ICONSTOP);
end;
// *************************************************************************
//! �_�E�����[�h�R���g���[���X���b�h�̐���
// *************************************************************************
procedure TGikoForm.CreateControlThread();
begin
	//�_�E�����[�h�I�u�W�F�N�g
	FControlThread := TThreadControl.Create(True);
	FControlThread.MaxThreadCount := 1;
	FControlThread.Resume;
	FControlThread.OnDownloadEnd := DownloadEnd;
	FControlThread.OnDownloadMsg := DownloadMsg;
	FControlThread.OnWork := Work;
	FControlThread.OnWorkBegin := WorkBegin;
	FControlThread.OnWorkEnd := WorkEnd;
end;
// *************************************************************************
//! �u���E�U�̐���
// *************************************************************************
procedure TGikoForm.CreateBrowsers(count: Integer);
var
	i: Integer;
	newBrowser: TWebBrowser;
begin
	BrowserNullTab := TBrowserRecord.Create;
	BrowserNullTab.Browser := Browser;
	BrowserNullTab.Browser.Navigate(BLANK_HTML);

	FBrowsers := TList.Create;

	for i := 0 to count -1 do begin
		FBrowsers.Add(TWebBrowser.Create(BrowserPanel));
		newBrowser := FBrowsers[FBrowsers.Count - 1];
		TOleControl(newBrowser).Parent := BrowserPanel;
		TOleControl(newBrowser).Align := alNone;
		TOleControl(newBrowser).Left	:= 0;
		TOleControl(newBrowser).Top	:= 0;
		newBrowser.RegisterAsDropTarget := False;
		newBrowser.OnDocumentComplete	:= BrowserDocumentComplete;
		newBrowser.OnBeforeNavigate2 	:= BrowserBeforeNavigate2;
		newBrowser.OnEnter				:= BrowserEnter;
		newBrowser.OnNewWindow2			:= BrowserNewWindow2;
		newBrowser.OnStatusTextChange	:= BrowserStatusTextChange;
		newBrowser.Navigate(BLANK_HTML);
		ShowWindow(newBrowser.Handle, SW_HIDE);
        GikoSys.ShowRefCount('Browser' + IntToStr(i), newBrowser.ControlInterface);
        GikoSys.ShowRefCount('Document' + IntToStr(i), newBrowser.ControlInterface.Document);
	end;
	BrowserNullTab.Browser.BringToFront;
	ShowWindow(BrowserNullTab.Browser.Handle, SW_SHOW);

	//�N�����Ƀ^�u�������������Ă���ƁA��y�[�W�p��Browser��
	//�`�悪�I����Ă��Ȃ��āA�N���b�N�C�x���g�̐ݒ蓙�ɓ˓�����̂�
	//�����ŏI��点�Ă���
	while (Browser.ReadyState <> READYSTATE_COMPLETE) and
		(Browser.ReadyState <> READYSTATE_INTERACTIVE) do begin
		Application.ProcessMessages;
	end;
end;
// *************************************************************************
//! �c�[���o�[�ɃX���i���݃R���{�{�b�N�X��ݒ肷��
// *************************************************************************
procedure TGikoForm.SetSelectComboBox();
const
	DUMMYCOMPNAME = 'SelectComboBoxDummy';
var
	i: Integer;
	ToolButton: TToolButton;
begin
	//ListToolBar�ɂ��邩������Ȃ��i����ComboBox��z�u
	SelectComboBoxPanel.Visible := False;
	try
		for i := ListToolBar.ControlCount - 1 downto 0 do
		begin
			if ListToolBar.Controls[ i ].Action = GikoDM.SelectItemAction then
			begin
				SelectComboBoxPanel.Left := ListToolBar.Controls[ i ].Left;
				SelectComboBoxPanel.Width := GikoSys.Setting.SelectComboBoxWidth;
				SelectComboBoxPanel.Parent := ListToolBar;
				SelectComboBoxPanel.Visible := True;

				SelectComboBox.Left := 0;
				SelectComboBox.Top  := 0;
				SelectComboBox.Height := SelectComboBoxPanel.ClientHeight;
				SelectComboBox.Width := SelectComboBoxPanel.Width -
										SelectComboBoxSplitter.Width;

				//������Ȃ��{�^����˂�����
				ToolButton := TToolButton(ListToolBar.FindComponent(DUMMYCOMPNAME));
				if ToolButton = nil then begin
					ToolButton := TToolButton.Create(ListToolBar);
					ToolButton.Name := DUMMYCOMPNAME;
				end;
				ToolButton.Style := tbsSeparator;
				ToolButton.Width := 0;
				ToolButton.Left  := ListToolBar.Controls[ i ].Left;
				ListToolBar.InsertControl(ToolButton);
				ToolButton.Visible := False;

				// �X���b�h�i���ׂ̗ɃZ�p���[�^������ꍇ�͉B��
				if (i + 1) < ListToolBar.ControlCount then
					if ListToolBar.Controls[ i + 1 ] is TToolButton then
						if TToolButton( ListToolBar.Controls[ i + 1 ] ).Style = tbsSeparator then
							ListToolBar.Controls[ i + 1 ].Visible := False;


				// �X���b�h�i���{�^�����B��
				ListToolBar.Controls[ i ].Visible := False;

				break;
			end;
		end;
	except
	end;
end;
//! �L���r�l�b�g�̃}�E�X�_�E���C�x���g
procedure TGikoForm.TreeViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	rect : TRect;
begin
	case Button of
	mbLeft:
		begin
			if (TreeView.Selected <> nil) and
				(TreeView.Selected = TreeView.GetNodeAt(X, Y)) then begin
				//�}�E�X��node�̏�ɂ��邩
				rect := TreeView.Selected.DisplayRect(true);
				// �A�C�R�����������ɂ��炷
				if ((rect.Left - TreeView.Indent <= X) and (rect.Right >= X)) and
					((rect.Bottom >= Y) and (rect.Top <= Y)) then begin
					// �N���b�N�ƃ_�u���N���b�N���R�R�Ŕ���
					if ssDouble in Shift then begin
						TreeDoubleClick( TreeView.Selected );
					end else begin
						TreeClick(TreeView.Selected);
					end;
				end;
			end;
		end;
	end;
end;
//! ActionList��GroupIndex�̕ۑ�
procedure TGikoForm.GetGroupIndex(ActionList: TActionList);
var
	i: Integer;
begin
	if ActionList <> nil then begin
		SetLength(FActionListGroupIndexes, ActionList.ActionCount);

		for i := 0 to ActionList.ActionCount - 1 do begin
			try
				FActionListGroupIndexes[i] :=
					TCustomAction(ActionList.Actions[i]).GroupIndex;
				TCustomAction(ActionList.Actions[i]).GroupIndex
					:= 0;
			except
				;//Cast�ł��Ȃ��Ƃ��΍�
			end;
		end;

	end;
end;
//! ActionList��GroupIndex�̐ݒ�
procedure TGikoForm.SetGroupIndex(ActionList: TActionList);
var
	i: Integer;
begin
	if ActionList <> nil then begin
		if Length( FActionListGroupIndexes ) = ActionList.ActionCount then begin
			for i := 0 to ActionList.ActionCount - 1 do begin
				try
					TCustomAction(ActionList.Actions[i]).GroupIndex
						:= FActionListGroupIndexes[i];
				except
					;//Cast�ł��Ȃ��Ƃ��΍�
				end;
			end;
		end;
	end;
end;
//! ���̃��X��URL�擾
procedure TGikoForm.GetResURLMenuClick(Sender: TObject);
begin
;
end;
//! ListView�i�X���b�h�ꗗ�j���X�V����
procedure TGikoForm.RefreshListView(Thread: TThreadItem);
begin
	//Thread�̔ƕ\�����Ă���������Ȃ�`����X�V����
	if (FActiveList is TBoard) and (TBoard(ActiveList) = Thread.ParentBoard) then begin
		ListView.Refresh;
	end;
end;

procedure TGikoForm.MainCoolBarContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
    pos : TPoint;
    coolBar: TGikoCoolBar;
begin
    Handled := False;
    if (Sender <> nil) and (Sender is TGikoCoolBar) then begin
        coolBar := TGikoCoolBar(Sender);
        if (coolBar = MainCoolBar) then begin
            FToolBarSettingSender := tssMain;
        end else if (coolBar = ListCoolBar) then begin
            FToolBarSettingSender := tssList;
        end else if (coolBar = BrowserCoolBar) then begin
            FToolBarSettingSender := tssBrowser;
        end else begin
            FToolBarSettingSender := tssNone;
        end;
        pos := coolBar.ClientToScreen( MousePos );
        MainCoolBarPopupMenu.Popup( pos.X, pos.Y );
        Handled := True;
    end;
end;

procedure TGikoForm.TaskTrayIconMessage(var Msg: TMsg);
var
    p: TPoint;
begin
    //  ���N���b�N�Ȃ畜������
    if  (Msg.wParam = WM_LBUTTONUP) then  begin
        UnStoredTaskTray;
    end else if (Msg.wParam=WM_RBUTTONUP) then begin
        // �E�N���b�N�Ȃ�I������
        GetCursorPos ( p );
        SetForegroundWindow ( Self.Handle );
        TaskTrayPopupMenu.Popup ( p.X, p.Y );
    end;
end;
//! �^�X�N�g���C�ɃA�C�R���o�^���t�H�[���B��
procedure TGikoForm.StoredTaskTray;
begin
    try
        if (FIconData.uID = 0) then begin
            FIconData.cbSize  :=  SizeOf(TNotifyIconData);
            FIconData.uID     :=  Self.Handle;
            FIconData.Wnd     :=  Handle;
            FIconData.uFlags  :=  NIF_MESSAGE or NIF_ICON or NIF_TIP;
            FIconData.uCallbackMessage  :=  USER_TASKTRAY;
            FIconData.hIcon   :=  Application.Icon.Handle;  {�A�C�R���w��}
            FIconData.szTip   :=  '�M�R�i�r';      {�q���g������}
            Shell_NotifyIcon(NIM_ADD, @FIconData);
            ShowEditors(SW_HIDE);
            ShowWindow(Self.Handle, SW_HIDE);
        end;
    except
    end;
end;
//! �^�X�N�g���C�̃A�C�R���폜���t�H�[���\��
procedure TGikoForm.UnStoredTaskTray;
begin
    try
        try
            Shell_NotifyIcon(NIM_DELETE, @FIconData);
            SetForegroundWindow(Application.Handle);
        except
        end;
    finally
        FIconData.uID := 0;
        // Action����i�[�����Ƃ���Tag�̒l��0�ȊO
        if (GikoDM.StoredTaskTrayAction.Tag = 0) then begin
            ShowWindow(Self.Handle, SW_RESTORE);
        end else begin
            ShowWindow(Self.Handle, SW_SHOW);
        end;
        ShowEditors(SW_SHOW);
        GikoDM.StoredTaskTrayAction.Tag := 0;
    end;
end;
{
\brief ���X�G�f�B�^�̕\����\��
\param nCmdShow Windows.ShowWindow�ɑ���p�����[�^�Ɠ���
}
procedure TGikoForm.ShowEditors(nCmdShow: Integer);
var
    i : Integer;
begin
    // ���X�G�f�B�^��T��
    for i := 0 to Screen.CustomFormCount - 1 do begin
        if TObject(Screen.CustomForms[i]) is TEditorForm then
            ShowWindow(Screen.CustomForms[i].Handle, nCmdShow);

    end;
end;
//! �|�b�v�A�b�v�u���E�U�쐬
procedure TGikoForm.CreateResPopupBrowser;
begin
    if (FResPopupBrowser = nil) then begin
        FResPopupBrowser := TResPopupBrowser.Create(BrowserPanel);
    end;
end;
//! ListView��D&D�󂯎��
procedure TGikoForm.AcceptDropFiles(var Msg: TMsg);
var
    FileName: Array[0..MAX_PATH] of Char;
    Cnt, K: Integer;
    Board: TBoard;
    LogFolder: String;
    datList: TStringList;
begin
    // �\�����Ă���̔̂Ƃ��ȊO�͋���
    if GetActiveList is TBoard then begin
        Board := TBoard(GetActiveList);
        if MsgBox(Handle, Board.Title
            + ' �ɓ���Ă����ł����H', '�M�R�i�r', MB_YESNO or MB_ICONQUESTION) = IDYES	then begin
            // �̎��́A���O�t�H���_�ɃR�s�[���Ă͂��ꃍ�O�Ή��Ɠ��������H
            datList := TStringList.Create;
            try
                Cnt := DragQueryFile(Msg.WParam, $FFFFFFFF, FileName, SizeOf(FileName));
                for K := 0 to Cnt - 1 do begin
                    DragQueryFile(Msg.WParam, K, FileName, SizeOf(FileName));
                    // FileName��drop���ꂽ�t�@�C�����������Ă���̂ŁA�����ŉ��炩�̏���������B���Ƃ��Ύ��̍s
                    // �t�@�C���̃`�F�b�N
                    if (isValidFile(FileName)) then begin
                        LogFolder := ExtractFilePath(Board.FilePath);
                        if (FileExists( LogFolder + ExtractFileName(FileName))) then begin
                            GikoUtil.MsgBox(Handle, LogFolder + '��' + ExtractFileName(FileName) + '�����ɑ��݂��܂��B', '�G���[', MB_ICONSTOP or MB_OK);
                        end else begin
                            if (not DirectoryExists(LogFolder)) then begin
                                if (not GikoSys.ForceDirectoriesEx(LogFolder) ) then begin
                                    GikoUtil.MsgBox(Handle, LogFolder + '�̐����Ɏ��s���܂����B', '�G���[', MB_ICONSTOP or MB_OK);
                                end;
                            end;
                            if (not Windows.CopyFile(FileName,  PChar(LogFolder + ExtractFileName(FileName)), true)) then begin
                                GikoUtil.MsgBox(Handle, FileName + '�̃R�s�[�Ɏ��s���܂����B', '�G���[', MB_ICONSTOP or MB_OK);
                            end else begin
                                datList.Add(ExtractFileName(FileName));
                            end;
                        end;
                    end;
                end;
                DragFinish(Msg.WParam);
                if (datList.Count > 0) then begin
                    GikoSys.AddOutofIndexDat(Board, datList, False);
                    ShowMessage(IntToStr(datList.Count) + '��dat�t�@�C�����R�s�[����܂����B' );
              		if GikoForm.TreeView.Visible then begin
            			GikoForm.TreeView.Refresh;
                    end;
		            if GikoForm.ListView.Visible then begin
        		    	UpdateListView();
                    end;
                end else begin
                    ShowMessage('����R�s�[����܂���ł����B' );
                end;
            finally
                datList.Free;
            end;

        end;
    end else begin
        ShowMessage('��\�����Ă��������B');
    end;
end;
procedure TGikoForm.UpdateListView();
begin
    //ListView�ł��̃X�����܂܂���\�����Ă���Ƃ��̍X�V����
    if (ActiveList <> nil) and (ActiveList is TBoard) then begin
        TBoard(ActiveList).LogThreadCount := TBoard(ActiveList).GetLogThreadCount;
        TBoard(ActiveList).NewThreadCount := TBoard(ActiveList).GetNewThreadCount;
        TBoard(ActiveList).UserThreadCount:= TBoard(ActiveList).GetUserThreadCount;
        //ListView�̃A�C�e���̌����X�V
        case GikoForm.ViewType of
            gvtAll: ListView.Items.Count := TBoard(ActiveList).Count;
            gvtLog: ListView.Items.Count := TBoard(ActiveList).LogThreadCount;
            gvtNew: ListView.Items.Count := TBoard(ActiveList).NewThreadCount;
            gvtArch: ListView.Items.Count := TBoard(ActiveList).ArchiveThreadCount;
            gvtLive: ListView.Items.Count := TBoard(ActiveList).LiveThreadCount;
            gvtUser: ListView.Items.Count := TBoard(ActiveList).UserThreadCount;
        end;
    end;
    ListView.Refresh;
end;
//! �t�@�C���`�F�b�N
function TGikoForm.isValidFile(FileName: String) : boolean;
var
    dt: TDateTime;
begin
    Result := True;
    // ���݂��邩�A�g���qdat�A�t�@�C����
    if ( not FileExists(FileName) ) then begin
        Result := False;
        GikoUtil.MsgBox(Handle, FileName + '�͑��݂��܂���B', '�G���[', MB_ICONSTOP or MB_OK);
    end else if (ExtractFileExt(ExtractFileName(FileName)) <> '.dat' ) then begin
        Result := False;
        GikoUtil.MsgBox(Handle, ExtractFileName(FileName) + '�̊g���q��".dat"�ł���܂���B', '�G���[', MB_ICONSTOP or MB_OK);
    end else begin
        // ���O�t�@�C���̊g���q���͂��������̂��X���쐬����
        try
            dt := GikoSys.GetCreateDateFromName(ExtractFileName(FileName));
            if ((UnixToDateTime(ZERO_DATE) + OffsetFromUTC) = dt) then begin
                Result := False;
                GikoUtil.MsgBox(Handle, ExtractFileName(FileName) + '�̃t�@�C�������s���ł��B', '�G���[', MB_ICONSTOP or MB_OK);
            end;
        except
            Result := False;
            GikoUtil.MsgBox(Handle, ExtractFileName(FileName) + '�̃t�@�C�������s���ł��B', '�G���[', MB_ICONSTOP or MB_OK);
        end;
    end;
end;

procedure TGikoForm.ResPopupClearTimerTimer(Sender: TObject);
begin
    ResPopupClearTimer.Enabled := False;
    if ResPopupClearTimer.Tag = 0 then begin
        FResPopupBrowser.Clear;
    end else begin
        FResPopupBrowser.CurrentBrowser.ChildClear;
    end;
end;
//! �A�C�R���ǂݍ���
procedure TGikoForm.LoadIcon();
const
    ICONI6 = 'icon16.bmp';
    ICON32 = 'icon32.bmp';
    ICONSTAT  = 'state_icon.bmp';
    ICONMES = 'message_icon.bmp';
    ICONADD = 'address_icon.bmp';
    ICONITEM = 'item_icon.bmp';
    ICONTOOL = 'hottoolbar_icon.bmp';
begin
    if FileExists(GikoSys.Setting.GetAppDir + ICONI6) then begin
        ItemIcon16.Clear;
        ItemIcon16.FileLoad(rtBitmap,
            GikoSys.Setting.GetAppDir + ICONI6, clPurple);
    end;
    if FileExists(GikoSys.Setting.GetAppDir + ICON32) then begin
        ItemIcon32.Clear;
        ItemIcon32.FileLoad(rtBitmap,
            GikoSys.Setting.GetAppDir + ICON32, clPurple);
    end;
    if FileExists(GikoSys.Setting.GetAppDir + ICONSTAT) then begin
        StateIconImageList.Clear;
        StateIconImageList.FileLoad(rtBitmap,
            GikoSys.Setting.GetAppDir + ICONSTAT, clPurple);
    end;
    if FileExists(GikoSys.Setting.GetAppDir + ICONMES) then begin
        MessageImageList.Clear;
        MessageImageList.FileLoad(rtBitmap,
            GikoSys.Setting.GetAppDir + ICONMES, clPurple);
    end;
    if FileExists(GikoSys.Setting.GetAppDir + ICONADD) then begin
        AddressImageList.Clear;
        AddressImageList.FileLoad(rtBitmap,
            GikoSys.Setting.GetAppDir + ICONADD, clPurple);
    end;
    if FileExists(GikoSys.Setting.GetAppDir + ICONITEM) then begin
        ItemImageList.Clear;
        ItemImageList.FileLoad(rtBitmap,
            GikoSys.Setting.GetAppDir + ICONITEM, clPurple);
    end;
    if FileExists(GikoSys.Setting.GetAppDir + ICONTOOL) then begin
        HotToobarImageList.Clear;
        HotToobarImageList.FileLoad(rtBitmap,
            GikoSys.Setting.GetAppDir + ICONTOOL, clPurple);
    end;
end;

//! �X���^�C�\���X�V
procedure TGikoForm.UpdateThreadTitle;
var
	i: Integer;
    DspTitle: String;
begin
    BrowserTab.Tabs.BeginUpdate;
    for i := 0 to BrowserTab.Tabs.Count - 1 do begin
        BrowserTab.Tabs.Strings[i] :=
            GikoSys.GetShortName(TBrowserRecord(BrowserTab.Tabs.Objects[i]).Thread.Title, 20);
    end;
    BrowserTab.Tabs.EndUpdate;

    if (FActiveContent <> nil) and (FActiveContent.Thread <> nil) then begin
        DspTitle := GikoSys.TrimThreadTitle(FActiveContent.Thread.Title);
        BrowserNameLabel.Caption := DspTitle;
        Self.Caption := GikoDataModule.CAPTION_NAME + ' - [' + DspTitle + ']';
    end;
end;

//! �|�b�v�A�b�v���j���[�ǂݍ���
procedure TGikoForm.LoadPopupMenu();
begin


end;

initialization
				OleInitialize(nil);
finalization
				OleUninitialize;


end.
