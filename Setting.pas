unit Setting;


interface

uses
	SysUtils, Classes, Graphics, Forms, {Math, IniFiles, UCryptAuto, UBase64,}
	ComCtrls, GestureModel, IniFiles, SkinFiles, Belib;

const
	MAIN_COOLBAND_COUNT = 4;		//メインCoolBandの数
	LIST_COOLBAND_COUNT = 2;		//板CoolBandの数
	BROWSER_COOLBAND_COUNT = 3;	//ブラウザCoolBandの数


type
	TGikoTabPosition = (gtpTop, gtpBottom);								// タブ位置
	TGikoTabAppend = (gtaFirst, gtaLast, gtaRight, gtaLeft);									// タブ追加位置
	TGikoTabStyle = (gtsTab, gtsButton, gtsFlat);					// タブスタイル
	TGikoListOrientation = (gloHorizontal, gloVertical);	// リスト垂直・水平
	TGikoListState = (glsMax, glsNormal, glsMin);					// リストサイズ状態
																												// ポップアップ表示位置
	TGikoPopupPosition = (gppLeftTop = 0, gppTop, gppRightTop,
												gppLeft, gppCenter, gppRight,
												gppLeftBottom, gppBottom, gppRightBottom);
																												//プレビューサイズ
	TGikoPreviewSize = (gpsXLarge, gpsLarge, gpsMedium, gpsSmall, gpsXSmall);
	TGikoBrowserAutoMaximize	= (gbmNone, gbmClick, gbmDoubleClick);
																												// ブラウザを自動的に最大化する条件
	/// レス表示範囲。10 ～ 65535 は最新 n レス扱い。
	/// 将来 201-300 のような範囲を持たせる可能性も考えて上位 2 byte は予約。
	TGikoResRange = (grrAll, grrSelect, grrKoko, grrNew);

	/// スレッド一覧表示範囲
	TGikoThreadRange = (gtrAll, gtrSelect, gtrLog, gtrNew, gtrLive, gtrArch);

	//! スパムフィルターアルゴリズム
	TGikoSpamFilterAlgorithm = (
		gsfaNone, gsfaPaulGraham, gsfaGaryRobinson, gsfaGaryRobinsonFisher);


	/// カテゴリリストのカラム ID
	type	TGikoBBSColumnID = (gbbscTitle);
	/// カテゴリリストのカラム名
	const	GikoBBSColumnCaption : array[0..0] of string =
		( 'カテゴリ名' );
	/// カテゴリリストカラム配列
	type	TGikoBBSColumnList = class( TList )
	private
		function GetItem( index : integer ) : TGikoBBSColumnID;
		procedure SetItem( index : integer; value : TGikoBBSColumnID);
	public
		constructor Create;
		destructor Destroy;	override;
		function Add( value : TGikoBBSColumnID ) : Integer;
		property Items[index : integer]: TGikoBBSColumnID read GetItem write SetItem; default;
	end;
	/// 板リストのカラム ID
	type	TGikoCategoryColumnID = (gccTitle, gccRoundName, gccLastModified);
	/// 板リストのカラム名
	const GikoCategoryColumnCaption : array[0..2] of string =
		( '板名', '巡回予約', '取得日時' );
	/// 板リストカラム配列
	type	TGikoCategoryColumnList = class( TList )
	private
		function GetItem( index : integer ) : TGikoCategoryColumnID;
		procedure SetItem( index : integer; value : TGikoCategoryColumnID);
	public
		constructor Create;
		destructor Destroy;	override;
		function Add( value : TGikoCategoryColumnID ) : Integer;
		property Items[index : integer]: TGikoCategoryColumnID read GetItem write SetItem; default;
	end;
	/// スレリストのカラム ID
	type	TGikoBoardColumnID = (gbcTitle, gbcAllCount, gbcLocalCount, gbcNonAcqCount,
		gbcNewCount, gbcUnReadCount, gbcRoundName, gbcRoundDate, gbcCreated, gbcLastModified, gbcVigor );{gbcLastModified,}
	/// スレリストのカラム名
	const	GikoBoardColumnCaption : array[0..10] of string =
		( 'スレッド名', 'カウント', '取得', '未取得', '新着',
		'未読', '巡回予約', '取得日時', 'スレ作成日時', '最終更新日時', '勢い' );
	const GikoBoardColumnAlignment : array[0..10] of TAlignment = (
		taLeftJustify, taRightJustify, taRightJustify, taRightJustify,
		taRightJustify, taRightJustify, taLeftJustify, taLeftJustify,
		taLeftJustify, taLeftJustify, taRightJustify);
	/// スレリストカラム配列
	type	TGikoBoardColumnList = class( TList )
	private
		function GetItem( index : integer ) : TGikoBoardColumnID;
		procedure SetItem( index : integer; value : TGikoBoardColumnID);
	public
		constructor Create;
		destructor Destroy;	override;
		function Add( value : TGikoBoardColumnID ) : Integer;
		property Items[index : integer]: TGikoBoardColumnID read GetItem write SetItem; default;
	end;

type
	//CoolBar設定レコード
	TCoolSet = record
		FCoolID: Integer;
		FCoolWidth: Integer;
		FCoolBreak: Boolean;
	end;

	TSetting = class(TObject)
	private
		//受信バッファサイズ
		//FRecvBufferSize: Integer;
		//HTTP1.1使用
		FProtocol: Boolean;
		//プロキシ接続HTTP1.1使用
		FProxyProtocol: Boolean;
  	//IPv6使用
    FIPv6: Boolean;
    FIPv4List: TStringList;

		//プロキシ（読込用）
		FReadProxy: Boolean;
		FReadProxyAddress: string;
		FReadProxyPort: Integer;
		FReadProxyUserID: string;
		FReadProxyPassword: string;

		//プロキシ（書込用）
		FWriteProxy: Boolean;
		FWriteProxyAddress: string;
		FWriteProxyPort: Integer;
		FWriteProxyUserID: string;
		FWriteProxyPassword: string;

		//キャビネット
		FCabinetFontName: string;
		FCabinetFontSize: Integer;
		FCabinetFontBold: Boolean;
		FCabinetFontItalic: Boolean;
		FCabinetFontColor: TColor;
		FCabinetBackColor: TColor;

		//リスト
		FListFontName: string;
		FListFontSize: Integer;
		FListFontBold: Boolean;
		FListFontItalic: Boolean;
		FListFontColor: TColor;
		FListBackColor: TColor;

		//メッセージリスト
		FMessageFontName: string;
		FMessageFontSize: Integer;
		FMessageFontBold: Boolean;
		FMessageFontItalic: Boolean;
		FMessageFontColor: TColor;
		FMessageBackColor: TColor;

		//ブラウザ
		FBrowserFontName: string;			// ''...default
		FBrowserFontSize: Integer;		// 0...default
		FBrowserFontBold: Integer;		// 0...default, -1...False, 1...True
		FBrowserFontItalic: Integer;	// 上に同じ
		FBrowserFontColor: Integer;		// -1...default
		FBrowserBackColor: Integer;		// 上に同じ

		//エディタ
		FEditorFontName: string;
		FEditorFontSize: Integer;
		FEditorFontBold: Boolean;
		FEditorFontItalic: Boolean;
		FEditorFontColor: TColor;
		FEditorBackColor: TColor;

		//タブフォント
		FBrowserTabFontName: string;
		FBrowserTabFontSize: Integer;
		FBrowserTabFontBold: Boolean;
		FBrowserTabFontItalic: Boolean;

		//ヒントウィンドウ
		FHintFontName: string;
		FHintFontSize: Integer;
		//FHintFontBold: Boolean;
		//FHintFontItalic: Boolean;
		FHintFontColor: TColor;
		FHintBackColor: TColor;

		//ウィンドウサイズ
		FWindowTop: Integer;
		FWindowLeft: Integer;
		FWindowHeight: Integer;
		FWindowWidth: Integer;
		FWindowMax: Boolean;
		//リストビュースタイル
		FListStyle: TViewStyle;

		//ツールバー表示
		FStdToolBarVisible: Boolean;
		FAddressBarVisible: Boolean;
		FLinkBarVisible: Boolean;
		FListToolBarVisible: Boolean;
		FListNameBarVisible: Boolean;
		FBrowserToolBarVisible: Boolean;
		FBrowserNameBarVisible: Boolean;

		//ブラウザタブ
		FBrowserTabVisible: Boolean;
		FBrowserTabPosition: TGikoTabPosition;
		FBrowserTabAppend: TGikoTabAppend;
		FBrowserTabStyle: TGikoTabStyle;

		//メッセージバー
		FMessageBarVisible: Boolean;
		FMessegeBarHeight: Integer;

		//ステータスバー
		FStatusBarVisible: Boolean;

		//キャビネット可視・サイズ
		FCabinetVisible: Boolean;
		FCabinetWidth: Integer;

		//リスト・ブラウザサイズ
		FListOrientation: TGikoListOrientation;
		FListHeight: Integer;
		FListHeightState: TGikoListState;
		FListWidth: Integer;
		FListWidthState: TGikoListState;
//		FListHeightMax: Boolean;
//		FListWidthMax: Boolean;

		//送信用名前・メール
		FNameList: TStringList;
		FMailList: TStringList;

		//エディターウィンドウサイズ
		FEditWindowTop: Integer;
		FEditWindowLeft: Integer;
		FEditWindowHeight: Integer;
		FEditWindowWidth: Integer;
		FEditWindowMax: Boolean;
    FEditWindowStay: Boolean;
    FEditWindowTranslucent: Boolean;

		//リスト番号表示
		FListViewNo: Boolean;
		//CSS表示
		FUseCSS: Boolean;
		// スキン表示(一時的なもので ini に保存はされない)
		FUseSkin: Boolean;
		//かちゅ～しゃ用のSkinを利用するか
		FUseKatjushaType : Boolean;
		//mail欄表示
		FShowMail: Boolean;
		/// レス表示範囲
		FResRange			: Longint;
		/// 起動時レス表示範囲の固定
		FResRangeHold	: Boolean;
		/// スレッド一覧表示範囲
		FThreadRange	: TGikoThreadRange;
		//非アクティブ時レスポップアップ表示
		FUnActivePopup: Boolean;
		//レスポップアップヘッダーボールド
		FResPopupHeaderBold: Boolean;
    // BEアイコン・Emoticon画像表示
    FIconImageDisplay: Boolean;
    // スレタイ特定文字列除去
    FThreadTitleTrim: Boolean;

		//ログフォルダ
		FLogFolder: string;
        FLogFolderP: string; //パス名がパス区切り記号で終わっている。
		FNewLogFolder: string;

		//リストカラムヘッダーサイズ
		FBBSColumnWidth: array[0..0] of Integer;
		FCategoryColumnWidth: array[0..2] of Integer;
		FBoardColumnWidth: array[0..10] of Integer;

		/// カテゴリリストカラム順序
		FBBSColumnOrder : TGikoBBSColumnList;
		/// 板リストカラム順序
		FCategoryColumnOrder : TGikoCategoryColumnList;
		/// スレリストカラム順序
		FBoardColumnOrder : TGikoBoardColumnList;

		//ソート順
		FBBSSortIndex: Integer;
		FBBSSortOrder: Boolean;
		FCategorySortIndex: Integer;
		FCategorySortOrder: Boolean;
		FBoardSortIndex: Integer;
		FBoardSortOrder: Boolean;

		//Dat落ちスレソート順
		FDatOchiSortIndex: Integer;
		FDatOchiSortOrder: Boolean;

		//絞込み文字列
		FSelectTextList: TStringList;

		//板一覧URL
		//FBoardURL2ch: string;
		FBoardURLs: TStringList;
		FBoardURLSelected: Integer;

		//ユーザID・パスワード
		FUserID: string;
		FPassword: string;
		FAutoLogin: Boolean;
		FForcedLogin: Boolean;
//		FDolibURL: string;

  	// User-Agentバージョン番号固定
    FUAVersion: Integer;

		//URLクリック時起動アプリ
		FURLApp: Boolean;
		FURLAppFile: string;

		//mailtoクリック時動作
		FOpenMailer: Boolean;

		//削除確認
		FDeleteMsg: Boolean;

		//CoolBar（メイン・板・ブラウザ）
		FMainCoolBar: array[0..MAIN_COOLBAND_COUNT - 1] of TCoolSet;
		FListCoolBar: array[0..LIST_COOLBAND_COUNT - 1] of TCoolSet;
		FBrowserCoolBar: array[0..BROWSER_COOLBAND_COUNT - 1] of TCoolSet;

		//ToolBar Wrapable
		FListToolBarWrapable: Boolean;
		FBrowserToolBarWrapable: Boolean;

		//ポップアップ位置
		FPopupPosition: TGikoPopupPosition;

		//アドレスバー
		FURLDisplay: Boolean;
		FAddressBarTabStop: Boolean;
		FLinkAddAddressBar: Boolean;
		FAddressHistoryCount: Integer;

		//画像プレビュー
		FPreviewVisible: Boolean;
		FPreviewSize: TGikoPreviewSize;
		FPreviewWait: Integer;

		// ブラウザ
		FBrowserAutoMaximize: TGikoBrowserAutoMaximize;

		//スレッド一覧更新アイコン表示
		FListIconVisible: Boolean;

		//スレッド一覧でLogのあるスレッドのみスレ作成日を表示するか
		FCreationTimeLogs: Boolean;
		//スレッド一覧のスレ生成日で未来のスレの生成日を表示しない
		FFutureThread: Boolean;

		//書き込み時マシン時間使用設定
		FUseMachineTime: Boolean;
		FTimeAdjustSec: Integer;
		FTimeAdjust: Boolean;

		//あぼ～ん
		FAbonDeleterlo : Boolean; //&rlo;を削るか
		FAbonReplaceul : Boolean; //<ul>タグを<br>タグに置換するか
		FPopUpAbon		 : Boolean; //レスポップアップ時のあぼ～ん有効
		FShowNGLinesNum : Boolean; //該当したＮＧワードファイルの行数を表示
		FAddResAnchor : Boolean; //NGレスへのレスアンカーを追加する
		FDeleteSyria : Boolean;	//シリア語ブラクラ対策
		FIgnoreKana	: Boolean;	//全半角ひらカナの違いを無視するか
    FKeepNgFile : Boolean;	//スレ全体再取得時に手動あぼ～ん情報をクリアしない

		//NGワード編集
		FNGTextEditor: Boolean; //編集にテキストエディタを使用するか
		FNGWindowTop: Integer;
		FNGWindowLeft: Integer;
		FNGWindowHeight: Integer;
		FNGWindowWidth: Integer;
		FNGWindowMax: Boolean;

		// スレッド絞込フィールドの幅
		FSelectComboBoxWidth : Integer;

		// 最後に選択されたオプションダイアログのタブ
		FOptionDialogTabIndex: Integer;

		// 最後に選択されたキャビネット
		FCabinetIndex: Integer;

		//終了時に確認ダイアログを表示するか
		FShowDialogForEnd : Boolean;
		//全てのタブ閉じるのときに確認ダイアログを表示する
		FShowDialogForAllTabClose: Boolean;
		//取得レス数とスレッドのレス数が異なったときに通常背景色と違った色の背景色を使用するか
		FUseOddColorOddResNum: Boolean;
		FOddColor: TColor;
		//レス数増減強調時に、選択アイテムにフォーカスが無いときに太字にするか
		FUnFocusedBold : Boolean;
		//エディタテキストのフォント設定を板情報表示にも使用するか
		FSetBoardInfoStyle: Boolean;

		//Samba24対策機能を使うか
		FUseSamba: Boolean;

		//レスアンカーをクリックしてジャンプするか
		FResAnchorJamp: Boolean;

    //Tab自動保存
    FTabAutoLoadSave : Boolean;
    //最後に開いていたスレッドのURL
    FLastCloseTabURL: String;
    //にちゃん語案内サポート機能
    F2chSupport : Boolean;

		// エディタ
		FSpaceToNBSP	: Boolean;	///< 半角スペース、Tab を &nbsp; に置換
		FAmpToCharRef	: Boolean;	///< '&' を &amp; に置換

		//ブラウザタブ非表示の時のスレ一覧でのカーソルキー移動の無反応時間
		FSelectInterval	: Integer;

		//KuroutSettingTab 詳細設定タブのActiveTab
		FKuroutSettingTabIndex: Integer;

		//! マウスジェスチャー
		FGestures	: TGestureModel;
		//! マウスジェスチャーを使用するかどうか
		FGestureEnabled : Boolean;
		//! マウスジェスチャーをコンテキスト等の上で無効
		FGestureIgnoreContext : Boolean;
		//フシアナトラップ設定
		FLocalTrapAtt : Boolean;
		FRemoteTrapAtt : Boolean;
		FReadTimeOut: Integer;

		//! 使用するスパムフィルター
		FSpamFilterAlgorithm : TGikoSpamFilterAlgorithm;
		//ミュートしてるか
		FMute: Boolean;
		//スレ絞込みで未確定文字も有効にするか
		FUseUndecided: Boolean;

				//Be2ch
                //認証用ユーザID・パスワード
		FBeUserID: String;
		FBePassword: String;
		FBeAutoLogin: Boolean;
		FBeLogin: Boolean;
		//履歴の最大保存件数
		FMaxRecordCount : Integer;

		//スレッド一覧をダウンロード後にソートするか
		FAutoSortThreadList : Boolean;

		//InputAssistフォームの位置
		FInputAssistFormLeft :Integer;
		FInputAssistFormTop :Integer;
		//InputAssistフォームのサイズ
		FInputAssistFormWidth: Integer;
		FInputAssistFormHeight: Integer;

		//! Cookieに付加する固定コード
		FFixedCookie: String;
    //! リンク移動履歴の保持数
    FMoveHistorySize : Integer;
    //! 最小化したときにタスクトレイに格納するか
    FStoredTaskTray : Boolean;
    //! タブの移動でループを許可する
    FLoopBrowserTabs : Boolean;
    //! 100レス表示の先頭表示レス数
    FHeadResCount : Integer;
    //! 100レス表示数（拡張用）
    FResRangeExCount: Integer;
    //! 関連キーワード追加フラグ
    FAddKeywordLink: Boolean;
    //! dat置換を有効にする
    FReplaceDat: Boolean;
    //! sent.iniファイルのサイズ（単位MB）
    FSentIniFileSize: Integer;
    //! リンクURL取得の対象拡張子
    FExtList: String;
    //! Skin関連
    FSkinFiles: TSkinFiles;
    //! indexファイルを読み時にdatを検索する
    FCheckDatFile: Boolean;
    //! 同IDレスアンカー表示
    FLimitResCountMessage: Boolean;
    //! レスポップアップ表示位置deltaX
    FRespopupDeltaX: Integer;
    //! レスポップアップ表示位置deltaY
    FRespopupDeltaY: Integer;
    //! レスポップアップタイマー
    FRespopupWait: Integer;
    //! メール欄レスポップアップ
    FRespopupMailTo: Boolean;
    //! 誤爆チェック
    FUseGobakuCheck: Boolean;
    //! Unicode版エディタ
    FUseUnicode: Boolean;
    //! プレビュー表示にCSSまたはスキンを適用する
    FPreviewStyle: Boolean;
    //! お絵描き（画像添付）を有効にする
    FOekaki: Boolean;
    //! 削除要請板を特別扱い
    FSakuBoard: Boolean;

		//! スレタイ検索ウィンドウ
		FThrdSrchTop: Integer;
		FThrdSrchLeft: Integer;
		FThrdSrchWidth: Integer;
		FThrdSrchHeight: Integer;
		FThrdSrchMax: Boolean;
    FThrdSrchStay: Boolean;
    FThrdSrchCol1W: Integer;
    FThrdSrchCol2W: Integer;
    FThrdSrchCol3W: Integer;
    FThrdSrchCol4W: Integer;
    FThrdSrchHistory: TStringList;

    //! 冒険の書用Cookie
    FBoukenCookieList: TStringList;

		//! どんぐりシステムウィンドウ
		FDonguriTop: Integer;
		FDonguriLeft: Integer;
		FDonguriWidth: Integer;
		FDonguriHeight: Integer;
		FDonguriStay: Boolean;
    FDonguriTheme: Integer;
    FDonguriTaskBar: Boolean;
		//! どんぐり関連
    FDonguriMenuTop: Boolean;


		function GetMainCoolSet(Index: Integer): TCoolSet;
		function GetBoardCoolSet(Index: Integer): TCoolSet;
		function GetBrowserCoolSet(Index: Integer): TCoolSet;
		procedure SetMainCoolSet(Index: Integer; CoolSet: TCoolSet);
		procedure SetBoardCoolSet(Index: Integer; CoolSet: TCoolSet);
		procedure SetBrowserCoolSet(Index: Integer; CoolSet: TCoolSet);

		function GetBBSColumnWidth(index: Integer): Integer;
		function GetCategoryColumnWidth(index: Integer): Integer;
		function GetBoardColumnWidth(index: Integer): Integer;
		procedure SetBBSColumnWidth(index: Integer; value: Integer);
		procedure SetCategoryColumnWidth(index: Integer; value: Integer);
		procedure SetBoardColumnWidth(index: Integer; value: Integer);

		function GetSoundName(Index: Integer): string;
		function GetSoundViewName(Index: Integer): string;
		function GetSoundFileName(Index: Integer): string;
		procedure SetSoundFileName(Index: Integer; value: string);
		function Encrypt(s: string): string;
		function Decrypt(s: string): string;

		procedure MakeURLIniFile();

		procedure SetUseCSS( value: Boolean );
		procedure SetCSSFileName( fileName: string );
    function GetCSSFileName: string;
    //! プロキシ設定読み込み
    procedure ReadProxySettings(memIni: TMemIniFile);
    //! 各種ウィンドウ設定読み込み
    procedure ReadWindowSettings(memIni: TMemIniFile);
    //! 入力履歴読み込み（検索＋メール欄＋名前）
    procedure ReadInputHisotrys(memIni: TMemIniFile);
    //! リストカラム幅読み込み
    procedure ReadListColumnWidth(memIni: TMemIniFile);
    //! カテゴリリストカラム順序読み込み
    procedure ReadOrdColumn(memIni: TMemIniFile);
	protected

	public
		constructor Create;
		destructor Destroy; override;
		function GetFileName: string;
		function GetBoardURLFileName: string;
		procedure ReadSettingFile;
		procedure ReadBoardURLsFile;
		procedure WriteSystemSettingFile;
		procedure WriteWindowSettingFile;
		procedure WriteNameMailSettingFile;
		procedure WriteFolderSettingFile();
		procedure WriteBoardURLSettingFile;
		procedure WriteBoukenSettingFile;
		function GetSoundCount: Integer;
		function FindSoundFileName(Name: string): string;

		function GetBoardFileName: string;
		function GetCustomBoardFileName: string;
		function GetBoardDir: string;
		function GetHtmlTempFileName: string;
		function GetAppDir: string;
		function GetTempFolder: string;
		function GetSentFileName: string;
		function GetConfigDir: string;
		function GetSkinDir: string;
		function GetStyleSheetDir: string;
		function GetOutBoxFileName: string;
		function GetDefaultFilesFileName: string;
		function GetNGWordsDir: string;
		function GetBoardPlugInDir: string;
		function GetSambaFileName: string;
		function GetIgnoreFileName: string;
		function GetGestureFileName : string;
		function GetSpamFilterFileName : string;
		function GetLanguageFileName: string;
		function GetMainKeyFileName: String;
		function GetEditorKeyFileName: String;
		procedure WriteLogFolder(AVal : String);
		function GetInputAssistFileName : String;
    function GetReplaceFileName: String;
    function GetExtprevieFileName: String;
    function GetBoukenCookie(AHostName: String): String;
    procedure SetBoukenCookie(ACookieValue, AHostName: String);
    procedure GetBouken(AHostName: String; var Domain:String; var Cookie:String);
    procedure GetDefaultIPv4Domain(dest: TStrings);
    {
    \brief  リンク履歴の保持サイズのsetter
    \param  AVal    設定するサイズ( >0)
    }
    procedure SetMoveHistorySize(AVal : Integer);
		//受信バッファサイズ   ※Indy10で使わなくなった
		//property RecvBufferSize: Integer read FRecvBufferSize write FRecvBufferSize;
		//HTTP1.1使用
		property Protocol: Boolean read FProtocol write FProtocol;
		//プロキシ接続HTTP1.1使用
		property ProxyProtocol: Boolean read FProxyProtocol write FProxyProtocol;
  	// IPv6使用
  	property IPv6: Boolean read FIPv6 write FIPv6;
    property IPv4List: TStringList read FIPv4List write FIPv4List;

		property ReadProxy: Boolean read FReadProxy write FReadProxy;
		property ReadProxyAddress: string read FReadProxyAddress write FReadProxyAddress;
		property ReadProxyPort: Integer read FReadProxyPort write FReadProxyPort;
		property ReadProxyUserID: string read FReadProxyUserID write FReadProxyUserID;
		property ReadProxyPassword: string read FReadProxyPassword write FReadProxyPassword;

		property WriteProxy: Boolean read FWriteProxy write FWriteProxy;
		property WriteProxyAddress: string read FWriteProxyAddress write FWriteProxyAddress;
		property WriteProxyPort: Integer read FWriteProxyPort write FWriteProxyPort;
		property WriteProxyUserID: string read FWriteProxyUserID write FWriteProxyUserID;
		property WriteProxyPassword: string read FWriteProxyPassword write FWriteProxyPassword;

		property CabinetFontName: string read FCabinetFontName write FCabinetFontName;
		property CabinetFontSize: Integer read FCabinetFontSize write FCabinetFontSize;
		property CabinetFontBold: Boolean read FCabinetFontBold write FCabinetFontBold;
		property CabinetFontItalic: Boolean read FCabinetFontItalic write FCabinetFontItalic;
		property CabinetFontColor: TColor read FCabinetFontColor write FCabinetFontColor;
		property CabinetBackColor: TColor read FCabinetBackColor write FCabinetBackColor;

		property ListFontName: string read FListFontName write FListFontName;
		property ListFontSize: Integer read FListFontSize write FListFontSize;
		property ListFontBold: Boolean read FListFontBold write FListFontBold;
		property ListFontItalic: Boolean read FListFontItalic write FListFontItalic;
		property ListFontColor: TColor read FListFontColor write FListFontColor;
		property ListBackColor: TColor read FListBackColor write FListBackColor;

		property MessageFontName: string read FMessageFontName write FMessageFontName;
		property MessageFontSize: Integer read FMessageFontSize write FMessageFontSize;
		property MessageFontBold: Boolean read FMessageFontBold write FMessageFontBold;
		property MessageFontItalic: Boolean read FMessageFontItalic write FMessageFontItalic;
		property MessageFontColor: TColor read FMessageFontColor write FMessageFontColor;
		property MessageBackColor: TColor read FMessageBackColor write FMessageBackColor;

		property BrowserFontName: string read FBrowserFontName write FBrowserFontName;
		property BrowserFontSize: Integer read FBrowserFontSize write FBrowserFontSize;
		property BrowserFontBold: Integer read FBrowserFontBold write FBrowserFontBold;
		property BrowserFontItalic: Integer read FBrowserFontItalic write FBrowserFontItalic;
		property BrowserFontColor: Integer read FBrowserFontColor write FBrowserFontColor;
		property BrowserBackColor: Integer read FBrowserBackColor write FBrowserBackColor;

		property EditorFontName: string read FEditorFontName write FEditorFontName;
		property EditorFontSize: Integer read FEditorFontSize write FEditorFontSize;
		property EditorFontBold: Boolean read FEditorFontBold write FEditorFontBold;
		property EditorFontItalic: Boolean read FEditorFontItalic write FEditorFontItalic;
		property EditorFontColor: TColor read FEditorFontColor write FEditorFontColor;
		property EditorBackColor: TColor read FEditorBackColor write FEditorBackColor;

		property BrowserTabFontName: string read FBrowserTabFontName write FBrowserTabFontName;
		property BrowserTabFontSize: Integer read FBrowserTabFontSize write FBrowserTabFontSize;
		property BrowserTabFontBold: Boolean read FBrowserTabFontBold write FBrowserTabFontBold;
		property BrowserTabFontItalic: Boolean read FBrowserTabFontItalic write FBrowserTabFontItalic;

		property HintFontName: string read FHintFontName write FHintFontName;
		property HintFontSize: Integer read FHintFontSize write FHintFontSize;
		//property HintFontBold: Boolean read FHintFontBold write FHintFontBold;
		//property HintFontItalic: Boolean read FHintFontItalic write FHintFontItalic;
		property HintFontColor: TColor read FHintFontColor write FHintFontColor;
		property HintBackColor: TColor read FHintBackColor write FHintBackColor;

		property WindowTop: Integer read FWindowTop write FWindowTop;
		property WindowLeft: Integer read FWindowLeft write FWindowLeft;
		property WindowHeight: Integer read FWindowHeight write FWindowHeight;
		property WindowWidth: Integer read FWindowWidth write FWindowWidth;
		property WindowMax: Boolean read FWindowMax write FWindowMax;
		property ListStyle: TViewStyle read FListStyle write FListStyle;

		property StdToolBarVisible: Boolean read FStdToolBarVisible write FStdToolBarVisible;
		property AddressBarVisible: Boolean read FAddressBarVisible write FAddressBarVisible;
		property LinkBarVisible: Boolean read FLinkBarVisible write FLinkBarVisible;
		property ListToolBarVisible: Boolean read FListToolBarVisible write FListToolBarVisible;
		property ListNameBarVisible: Boolean read FListNameBarVisible write FListNameBarVisible;
		property BrowserToolBarVisible: Boolean read FBrowserToolBarVisible write FBrowserToolBarVisible;
		property BrowserNameBarVisible: Boolean read FBrowserNameBarVisible write FBrowserNameBarVisible;

		property BrowserTabVisible: Boolean read FBrowserTabVisible write FBrowserTabVisible;
		property BrowserTabPosition: TGikoTabPosition read FBrowserTabPosition write FBrowserTabPosition;
		property BrowserTabAppend: TGikoTabAppend read FBrowserTabAppend write FBrowserTabAppend;
		property BrowserTabStyle: TGikoTabStyle read FBrowserTabStyle write FBrowserTabStyle;

		property MessageBarVisible: Boolean read FMessageBarVisible write FMessageBarVisible;
		property MessegeBarHeight: Integer read FMessegeBarHeight write FMessegeBarHeight;

		property StatusBarVisible: Boolean read FStatusBarVisible write FStatusBarVisible;

		property CabinetVisible: Boolean read FCabinetVisible write FCabinetVisible;
		property CabinetWidth: Integer read FCabinetWidth write FCabinetWidth;

		property ListOrientation: TGikoListOrientation read FListOrientation write FListOrientation;
		property ListHeight: Integer read FListHeight write FListHeight;
		property ListHeightState: TGikoListState read FListHeightState write FListHeightState;
		property ListWidth: Integer read FListWidth write FListWidth;
		property ListWidthState: TGikoListState read FListWidthState write FListWidthState;
//		property ListHeightMax: Boolean read FListHeightMax write FListHeightMax;
//		property ListWidthMax: Boolean read FListWidthMax write FListWidthMax;

		property NameList: TStringList read FNameList write FNameList;
		property MailList: TStringList read FMailList write FMailList;
		property SelectTextList: TStringList read FSelectTextList write FSelectTextList;

		property EditWindowTop: Integer read FEditWindowTop write FEditWindowTop;
		property EditWindowLeft: Integer read FEditWindowLeft write FEditWindowLeft;
		property EditWindowHeight: Integer read FEditWindowHeight write FEditWindowHeight;
		property EditWindowWidth: Integer read FEditWindowWidth write FEditWindowWidth;
		property EditWindowMax: Boolean read FEditWindowMax write FEditWindowMax;
		property EditWindowStay: Boolean read FEditWindowStay write FEditWindowStay;
		property EditWindowTranslucent: Boolean read FEditWindowTranslucent write FEditWindowTranslucent;

		property ListViewNo: Boolean read FListViewNo write FListViewNo;
		property UseCSS: Boolean read FUseCSS write SetUseCSS;
		property CSSFileName: string read GetCSSFileName write SetCSSFileName;
		property UseKatjushaType : Boolean read FUseKatjushaType write FUseKatjushaType;
		property UseSkin: Boolean read FUseSkin;

		property ShowMail: Boolean read FShowMail write FShowMail;
		property ResRange : Longint read FResRange write FResRange;
		property ResRangeHold : Boolean read FResRangeHold write FResRangeHold;
		property ThreadRange	: TGikoThreadRange read FThreadRange write FThreadRange;
		property UnActivePopup: Boolean read FUnActivePopup write FUnActivePopup;
		property ResPopupHeaderBold: Boolean read FResPopupHeaderBold write FResPopupHeaderBold;
		property IconImageDisplay: Boolean read FIconImageDisplay write FIconImageDisplay;
		property ThreadTitleTrim: Boolean read FThreadTitleTrim write FThreadTitleTrim;

		property LogFolder: string read FLogFolder write WriteLogFolder;
		property LogFolderP: string read FLogFolderP;
		property NewLogFolder: string read FNewLogFolder write FNewLogFolder;

		property BBSColumnWidth[index: Integer]: Integer read GetBBSColumnWidth write SetBBSColumnWidth;
		property CategoryColumnWidth[index: Integer]: Integer read GetCategoryColumnWidth write SetCategoryColumnWidth;
		property BoardColumnWidth[index: Integer]: Integer read GetBoardColumnWidth write SetBoardColumnWidth;

		property BBSColumnOrder : TGikoBBSColumnList read FBBSColumnOrder write FBBSColumnOrder;
		property CategoryColumnOrder : TGikoCategoryColumnList read FCategoryColumnOrder write FCategoryColumnOrder;
		property BoardColumnOrder : TGikoBoardColumnList read FBoardColumnOrder write FBoardColumnOrder;

		property SoundName[index: Integer]: string read GetSoundName;
		property SoundViewName[index: Integer]: string read GetSoundViewName;
		property SoundFileName[index: Integer]: string read GetSoundFileName write SetSoundFileName;

		property BBSSortIndex: Integer read FBBSSortIndex write FBBSSortIndex;
		property BBSSortOrder: Boolean read FBBSSortOrder write FBBSSortOrder;
		property CategorySortIndex: Integer read FCategorySortIndex write FCategorySortIndex;
		property CategorySortOrder: Boolean read FCategorySortOrder write FCategorySortOrder;
		property BoardSortIndex: Integer read FBoardSortIndex write FBoardSortIndex;
		property BoardSortOrder: Boolean read FBoardSortOrder write FBoardSortOrder;

		property DatOchiSortIndex: Integer read FDatOchiSortIndex write FDatOchiSortIndex;
		property DatOchiSortOrder: Boolean read FDatOchiSortOrder write FDatOchiSortOrder;

		//property BoardURL2ch: string read FBoardURL2ch write FBoardURL2ch;
		property BoardURLs: TStringList read FBoardURLs write FBoardURLs;
		property BoardURLSelected: Integer read FBoardURLSelected write FBoardURLSelected;
		property UserID: string read FUserID write FUserID;
		property Password: string read FPassword write FPassword;
		property AutoLogin: Boolean read FAutoLogin write FAutoLogin;
		property ForcedLogin: Boolean read FForcedLogin write FForcedLogin;
//		property DolibURL: string read FDolibURL write FDolibURL;
    property UAVersion: Integer read FUAVersion write FUAVersion;

		property URLApp: Boolean read FURLApp write FURLApp;
		property URLAppFile: string read FURLAppFile write FURLAppFile;

		property OpenMailer: Boolean read FOpenMailer write FOpenMailer;

		property DeleteMsg: Boolean read FDeleteMsg write FDeleteMsg;

		property MainCoolSet[Index: Integer]: TCoolSet read GetMainCoolSet write SetMainCoolSet;
		property ListCoolSet[Index: Integer]: TCoolSet read GetBoardCoolSet write SetBoardCoolSet;
		property BrowserCoolSet[Index: Integer]: TCoolSet read GetBrowserCoolSet write SetBrowserCoolSet;

		property ListToolBarWrapable: Boolean read FListToolBarWrapable write FListToolBarWrapable;
		property BrowserToolBarWrapable: Boolean read FBrowserToolBarWrapable write FBrowserToolBarWrapable;

		property PopupPosition: TGikoPopupPosition read FPopupPosition write FPopupPosition;

		property URLDisplay: Boolean read FURLDisplay write FURLDisplay;
		property AddressBarTabStop: Boolean read FAddressBarTabStop write FAddressBarTabStop;
		property LinkAddAddressBar: Boolean read FLinkAddAddressBar write FLinkAddAddressBar;
		property AddressHistoryCount: Integer read FAddressHistoryCount write FAddressHistoryCount;

		property PreviewVisible: Boolean read FPreviewVisible write FPreviewVisible;
		property PreviewSize: TGikoPreviewSize read FPreviewSize write FPreviewSize;
		property PreviewWait: Integer read FPreviewWait write FPreviewWait;
		property BrowserAutoMaximize: TGikoBrowserAutoMaximize read FBrowserAutoMaximize write FBrowserAutoMaximize;

		property ListIconVisible: Boolean read FListIconVisible write FListIconVisible;
		property CreationTimeLogs: Boolean read FCreationTimeLogs write FCreationTimeLogs;
		property FutureThread: Boolean read FFutureThread write FFutureThread;

		property UseMachineTime: Boolean read FUseMachineTime write FUseMachineTime;
		property TimeAdjustSec: Integer read FTimeAdjustSec write FTimeAdjustSec;
		property TimeAdjust: Boolean read FTimeAdjust write FTimeAdjust;

		//あぼ～ん
		property AbonDeleterlo : Boolean read FAbonDeleterlo write FAbonDeleterlo;
		property AbonReplaceul : Boolean read FAbonReplaceul write FAbonReplaceul;
		property PopUpAbon		 : Boolean read FPopUpAbon write FPopUpAbon;
		property ShowNGLinesNum : Boolean read FShowNGLinesNum write FShowNGLinesNum;
		property AddResAnchor : Boolean read FAddResAnchor write FAddResAnchor;
		property DeleteSyria : Boolean read FDeleteSyria write FDeleteSyria;
		property IgnoreKana : Boolean read FIgnoreKana write FIgnoreKana;
    property KeepNgFile : Boolean read FKeepNgFile write FKeepNgFile;

		//NGワード編集
		property NGTextEditor: Boolean read FNGTextEditor write FNGTextEditor;
		property NGWindowTop: Integer read FNGWindowTop write FNGWindowTop;
		property NGWindowLeft: Integer read FNGWindowLeft write FNGWindowLeft;
		property NGWindowHeight: Integer read FNGWindowHeight write FNGWindowHeight;
		property NGWindowWidth: Integer read FNGWindowWidth write FNGWindowWidth;
		property NGWindowMax: Boolean read FNGWindowMax write FNGWindowMax;

		// スレッド絞込フィールドの幅
		property SelectComboBoxWidth : Integer read FSelectComboBoxWidth write FSelectComboBoxWidth;

		// 最後に選択されたオプションダイアログのタブ
		property OptionDialogTabIndex : Integer read FOptionDialogTabIndex write FOptionDialogTabIndex;

		// 最後に選択されたキャビネット
		property CabinetIndex : Integer read FCabinetIndex write FCabinetIndex;

		//終了時に確認ダイアログを表示するか
		property ShowDialogForEnd : Boolean read FShowDialogForEnd write FShowDialogForEnd;
		property ShowDialogForAllTabClose: Boolean read FShowDialogForAllTabClose write FShowDialogForAllTabClose;
		//取得レス数とスレッドのレス数が異なったときに通常背景色と違った色の背景色を使用するか
		property UseOddColorOddResNum: Boolean read FUseOddColorOddResNum write FUseOddColorOddResNum;
		property OddColor: TColor read FOddColor write FOddColor;
		property UnFocusedBold : Boolean read FUnFocusedBold write FUnFocusedBold;
		//エディタテキストのフォント設定を板情報表示にも使用するか
		property SetBoardInfoStyle: Boolean read FSetBoardInfoStyle write FSetBoardInfoStyle;
		property UseSamba: Boolean read FUseSamba write FUseSamba;
		property ResAnchorJamp: Boolean read FResAnchorJamp write FResAnchorJamp;

		// エディタ
		property SpaceToNBSP	: Boolean	read FSpaceToNBSP		write FSpaceToNBSP;
		property AmpToCharRef	: Boolean	read FAmpToCharRef	write FAmpToCharRef;

		property SelectInterval	: Integer	read FSelectInterval	write FSelectInterval;
		//Tab保存
		property TabAutoLoadSave: Boolean           read FTabAutoLoadSave      write FTabAutoLoadSave;
    //タブの復元とか用
    property LastCloseTabURL: String read FLastCloseTabURL write FLastCloseTabURL;
    //property Gengo: TStringList read F2chLanguage write F2chLanguage;
    property GengoSupport : Boolean read F2chSupport write F2chSupport;
		property KuroutSettingTabIndex: Integer read FKuroutSettingTabIndex write FKuroutSettingTabIndex;
		//! マウスジェスチャー
		property Gestures : TGestureModel read FGestures write FGestures;
		//! マウスジェスチャーを使用するかどうか
		property GestureEnabled : Boolean read FGestureEnabled write FGestureEnabled;
        property GestureIgnoreContext : Boolean read FGestureIgnoreContext write FGestureIgnoreContext;
		//フシアナトラップ設定
		property LocalTrapAtt : Boolean read FLocalTrapAtt write FLocalTrapAtt;
		property RemoteTrapAtt : Boolean read FRemoteTrapAtt write FRemoteTrapAtt;
		property ReadTimeOut: Integer read FReadTimeOut write FReadTimeOut;
		//! 使用するスパムフィルタ
		property SpamFilterAlgorithm : TGikoSpamFilterAlgorithm
			read FSpamFilterAlgorithm write FSpamFilterAlgorithm;
		property Mute: Boolean read FMute write FMute;
		property UseUndecided: Boolean read FUseUndecided write FUseUndecided;

		property BeUserID: string read FBeUserID write FBeUserID;
		property BePassword: string read FBePassword write FBePassword;
		property BeAutoLogin: Boolean read FBeAutoLogin write FBeAutoLogin;
		property BeLogin: Boolean read FBeLogin write FBeLogin;
		property MaxRecordCount : Integer read FMaxRecordCount write FMaxRecordCount;
		//! スレッド一覧ダウンロード後にスレッド名で昇順ソートするか
		property AutoSortThreadList : Boolean read FAutoSortThreadList write FAutoSortThreadList;
		//! InputAssistフォームの位置
		property InputAssistFormLeft :Integer read FInputAssistFormLeft write FInputAssistFormLeft;
		property InputAssistFormTop :Integer read FInputAssistFormTop write FInputAssistFormTop;
		//! InputAssistフォームのサイズ
		property InputAssistFormWidth: Integer read FInputAssistFormWidth write FInputAssistFormWidth;
		property InputAssistFormHeight: Integer read FInputAssistFormHeight write FInputAssistFormHeight;
		//! Cookieに付加する固定コード
		property FixedCookie: String read FFixedCookie write FFixedCookie;
    //! リンク移動履歴の保持数
    property MoveHistorySize : Integer read FMoveHistorySize write SetMoveHistorySize;
    //! 最小化時にタスクトレイに格納するか
    property StoredTaskTray : Boolean read FStoredTaskTray write FStoredTaskTray;
    //! ブラウザタブのループを許可する
    property LoopBrowserTabs : Boolean read FLoopBrowserTabs write FLoopBrowserTabs;
    //! 100レス表示の先頭表示レス数
    property HeadResCount : Integer read FHeadResCount write FHeadResCount;
    //! 100レス表示数（拡張用）
    property ResRangeExCount: Integer read FResRangeExCount write FResRangeExCount;
    //! 関連キーワード追加フラグ
    property AddKeywordLink: Boolean read FAddKeywordLink write FAddKeywordLink;
    //! datの置換を有効にするか
    property ReplaceDat: Boolean read FReplaceDat write FReplaceDat;
    //! sent.iniファイルのサイズ（単位MB）
    property SentIniFileSize: Integer read FSentIniFileSize write FSentIniFileSize;
    //! リンクURL取得の対象拡張子
    property ExtList: String read FExtList write FExtList;
    //! Skinファイル管理
    property SkinFiles: TSkinFiles read FSkinFiles;
    //! インデックス読み込み時datファイルチェック
    property CheckDatFile: Boolean read FCheckDatFile write FCheckDatFile;
    property LimitResCountMessage: Boolean read FLimitResCountMessage write FLimitResCountMessage;
    //! レスポップアップ表示位置deltaX
    property  RespopupDeltaX: Integer read FRespopupDeltaX write FRespopupDeltaX;
    //! レスポップアップ表示位置deltaY
    property RespopupDeltaY: Integer read FRespopupDeltaY write FRespopupDeltaY;
    //! レスポップアップタイマー
    property RespopupWait: Integer read FRespopupWait write FRespopupWait;
    property RespopupMailTo: Boolean read FRespopupMailTo write FRespopupMailTo;
    //! 誤爆チェック
    property UseGobakuCheck: Boolean read FUseGobakuCheck write FUseGobakuCheck;
    //! Unicode版エディタ
    property UseUnicode: Boolean read FUseUnicode write FUseUnicode;
    //! プレビュー表示にCSSまたはスキンを適用する
    property PreviewStyle: Boolean read FPreviewStyle write FPreviewStyle;
    //! お絵描き（画像添付）を有効にする
    property Oekaki: Boolean read FOekaki write FOekaki;
    //! 削除要請板を特別扱い
    property SakuBoard: Boolean read FSakuBoard write FSakuBoard;
		//! スレタイ検索ウィンドウ
		//! スレタイ検索ウィンドウ
		property ThrdSrchTop: Integer read FThrdSrchTop write FThrdSrchTop;
		property ThrdSrchLeft: Integer read FThrdSrchLeft write FThrdSrchLeft;
		property ThrdSrchWidth: Integer read FThrdSrchWidth write FThrdSrchWidth;
		property ThrdSrchHeight: Integer read FThrdSrchHeight write FThrdSrchHeight;
		property ThrdSrchMax: Boolean read FThrdSrchMax write FThrdSrchMax;
    property ThrdSrchStay: Boolean read FThrdSrchStay write FThrdSrchStay;
    property ThrdSrchCol1W: Integer read FThrdSrchCol1W write FThrdSrchCol1W;
    property ThrdSrchCol2W: Integer read FThrdSrchCol2W write FThrdSrchCol2W;
    property ThrdSrchCol3W: Integer read FThrdSrchCol3W write FThrdSrchCol3W;
    property ThrdSrchCol4W: Integer read FThrdSrchCol4W write FThrdSrchCol4W;
    property ThrdSrchHistory: TStringList read FThrdSrchHistory write FThrdSrchHistory;
    //! 冒険の書
    property BoukenCookieList: TStringList read FBoukenCookieList write FBoukenCookieList;
		//! どんぐりシステムウィンドウ
		property DonguriTop: Integer read FDonguriTop write FDonguriTop;
		property DonguriLeft: Integer read FDonguriLeft write FDonguriLeft;
		property DonguriWidth: Integer read FDonguriWidth write FDonguriWidth;
		property DonguriHeight: Integer read FDonguriHeight write FDonguriHeight;
		property DonguriStay: Boolean read FDonguriStay write FDonguriStay;
    property DonguriTheme: Integer read FDonguriTheme write FDonguriTheme;
    property DonguriTaskBar: Boolean read FDonguriTaskBar write FDonguriTaskBar;
		//! どんぐり関連
    property DonguriMenuTop: Boolean read FDonguriMenuTop write FDonguriMenuTop;
	end;


const
//	MAIN_COOLBAND_COUNT = 4;		//メインCoolBandの数
//	LIST_COOLBAND_COUNT = 2;		//板CoolBandの数
//	BROWSER_COOLBAND_COUNT = 3;	//ブラウザCoolBandの数

	BOARD_FILE_NAME							 	= 'board.2ch';
	CUSTOMBOARD_FILE_NAME				 	= 'custom.2ch';
	BOARD_DIR_NAME								= 'Board';
	KEY_SETTING_FILE_NAME				 	= 'key.ini';
	EKEY_SETTING_FILE_NAME			 	= 'Ekey.ini';
	TEMP_FOLDER									 	= 'Temp';
	OUTBOX_FILE_NAME							= 'outbox.ini';
	SENT_FILE_NAME								= 'sent.ini';
	DEFFILES_FILE_NAME						= 'defaultFiles.ini';
	CONFIG_DIR_NAME							 	= 'config';
	CSS_DIR_NAME									= 'css';
	SKIN_DIR_NAME							 		= 'skin';
	NGWORDs_DIR_NAME:      String = 'NGwords';
	BOARD_PLUGIN_DIR_NAME					= 'BoardPlugin';
	SAMBATIME_FILE_NAME:   String = 'Samba.ini';
	IGNORE_FILE_NAME:      String = 'Ignore.txt';
//	DOLIB_LOGIN_URL     = '/~tora3n2c/futen.cgi';
	MAX_POPUP_RES:        Integer = 10;
	GESTURE_FILE_NAME							= 'Gestures.ini';
	SPAMFILTER_FILE_NAME					= 'SpamFilter.ini';
	LANGUAGE_FILE_NAME            = 'language.ini';
	INPUTASSIST_FILE_NAME         = 'InputAssist.ini';
  FIXED_COOKIE                  = '';
  REPLACE_FILE_NAME             = 'replace.ini';
  EXT_PREVIEW_FILE_NAME         = 'extpreview.ini';

implementation

uses
	Math, UCryptAuto, UBase64, Windows,GikoUtil;

type
	TSoundName = record
		Name: string;
		ViewName: string;
		FileName: string;
	end;

const
	INI_FILE_NAME:           string = 'gikoNavi.ini';
	BOARD_URL_INI_FILE_NAME: string = 'url.ini';
	DEFAULT_FONT_NAME:       string = 'ＭＳ Ｐゴシック';
	DEFAULT_FONT_SIZE:      Integer = 9;
	DEFAULT_FONT_COLOR:      string = 'clWindowText';
	DEFAULT_WINDOW_COLOR:    string = 'clWindow';
	DEFAULT_TAB_FONT_NAME:   string = 'ＭＳ Ｐゴシック';
	DEFAULT_TAB_FONT_SIZE:  Integer = 9;
	DEFAULT_2CH_BOARD_URL1:  string = 'https://menu.5ch.net/bbsmenu.html';
	GIKO_ENCRYPT_TEXT:       string = 'gikoNaviEncryptText';

  // IPv6で接続しないドメイン
  DEFAULT_IPV4_DOMAIN: array [0..4] of string = (
  	'flounder.s27.xrea.com',	// 非公式ギコナビ板
    'be.5ch.net',							// beログインホスト
    'shitaraba.com',					// したらばJBBS
    'shitaraba.net',					// したらばJBBS
    'machi.to'                // まちBBS
  );

var
	SOUND_NAME: array[0..4] of TSoundName = (
		(Name: 'New';				ViewName: '取得成功';					 FileName: ''),
		(Name: 'NewDiff';		ViewName: '取得成功(差分)';		 FileName: ''),
		(Name: 'NoChange';	 ViewName: '未更新';						 FileName: ''),
//		(Name: 'RoundEnd';	 ViewName: '巡回終了(取得あり)'; FileName: ''),
//		(Name: 'RoundNone';	ViewName: '巡回終了(取得なし)'; FileName: ''),
		(Name: 'ResEnd';		 ViewName: 'レス送信完了';			 FileName: ''),
		(Name: 'Error';			ViewName: 'エラー';						 FileName: ''));

constructor TGikoBBSColumnList.Create;
begin
	inherited;
end;

destructor TGikoBBSColumnList.Destroy;
begin
	inherited;
end;

function TGikoBBSColumnList.GetItem( index : integer ) : TGikoBBSColumnID;
begin
	Result := TGikoBBSColumnID( inherited Items[ index ] );
end;

procedure TGikoBBSColumnList.SetItem( index : integer; value : TGikoBBSColumnID);
begin
	inherited Items[ index ] := Pointer( value );
end;

function TGikoBBSColumnList.Add( value : TGikoBBSColumnID ) : Integer;
begin
	Result := inherited Add( Pointer( value ) );
end;

constructor TGikoCategoryColumnList.Create;
begin
	inherited;
end;

destructor TGikoCategoryColumnList.Destroy;
begin
	inherited;
end;

function TGikoCategoryColumnList.GetItem( index : integer ) : TGikoCategoryColumnID;
begin
	Result := TGikoCategoryColumnID( inherited Items[ index ] );
end;

procedure TGikoCategoryColumnList.SetItem( index : integer; value : TGikoCategoryColumnID);
begin
	inherited Items[ index ] := Pointer( value );
end;

function TGikoCategoryColumnList.Add( value : TGikoCategoryColumnID ) : Integer;
begin
	Result := inherited Add( Pointer( value ) );
end;

constructor TGikoBoardColumnList.Create;
begin
	inherited;
end;

destructor TGikoBoardColumnList.Destroy;
begin
	inherited;
end;

function TGikoBoardColumnList.GetItem( index : integer ) : TGikoBoardColumnID;
begin
	Result := TGikoBoardColumnID( inherited Items[ index ] );
end;

procedure TGikoBoardColumnList.SetItem( index : integer; value : TGikoBoardColumnID);
begin
	inherited Items[ index ] := Pointer( value );
end;

function TGikoBoardColumnList.Add( value : TGikoBoardColumnID ) : Integer;
begin
	Result := inherited Add( Pointer( value ) );
end;

//コンストラクタ
constructor TSetting.Create();
begin
	FNameList := TStringList.Create;
	FMailList := TStringList.Create;
	FSelectTextList := TStringList.Create;
	FBoardURLs := TStringList.Create;
	FBBSColumnOrder := TGikoBBSColumnList.Create;
	FCategoryColumnOrder := TGikoCategoryColumnList.Create;
	FBoardColumnOrder := TGikoBoardColumnList.Create;
	FGestures := TGestureModel.Create;
	FSkinFiles := TSkinFiles.Create;
	FNameList.Duplicates := dupIgnore;
	FMailList.Duplicates := dupIgnore;
	FBoardURLs.Duplicates := dupIgnore;
	FSelectTextList.Duplicates := dupIgnore;
  FThrdSrchHistory := TStringList.Create;
  FBoukenCookieList := TStringList.Create;
	FIPv4List := TStringList.Create;
	ReadSettingFile();
	ReadBoardURLsFile();
end;

//デストラクタ
destructor TSetting.Destroy();
begin
  FThrdSrchHistory.Free;
  FBoukenCookieList.Free;
 	FBoardColumnOrder.Free;
 	FCategoryColumnOrder.Free;
 	FBBSColumnOrder.Free;
 	FSelectTextList.Free;
 	FBoardURLs.Free;
 	FMailList.Free;
 	FNameList.Free;
 	FGestures.Free;
	FSkinFiles.Free;
	FIPv4List.Free;
	inherited;
end;

//初期化ファイル名取得（パス＋ファイル名）
function TSetting.GetFileName(): string;
begin
	Result := GetAppDir + INI_FILE_NAME;
end;

//板更新用URL設定ファイル名（パス＋ファイル名）
function TSetting.GetBoardURLFileName(): string;
begin
	Result := GetAppDir + BOARD_URL_INI_FILE_NAME;
end;

//設定ファイル読込
procedure TSetting.ReadSettingFile();
var
	ini: TMemIniFile;
	i: Integer;
	Exists: Boolean;
	s: string;
	CoolSet: TCoolSet;
  msg: String;
  hostList: TStringList;
  Cnt: Integer;
  key: String;
begin
	Exists := FileExists(GetFileName);
	ini := TMemIniFile.Create(GetFileName);
	try
		//受信バッファサイズ
		//FRecvBufferSize := ini.ReadInteger('HTTP', 'RecvBufferSize', 4096);
		//HTTP1.1使用
		FProtocol := ini.ReadBool('HTTP', 'Protocol', True);
		//プロキシ接続HTTP1.1使用
		FProxyProtocol := ini.ReadBool('HTTP', 'ProxyProtocol', False);
  	// IPv6
    FIPv6 := ini.ReadBool('HTTP', 'IPv6', False);
    Cnt := ini.ReadInteger('HTTP', 'IPv4DomainCount', -9999);
    if Cnt = -9999 then begin
    	for i := Low(DEFAULT_IPV4_DOMAIN) to High(DEFAULT_IPV4_DOMAIN) do
	    	FIpv4List.Add(DEFAULT_IPV4_DOMAIN[i]);
    end else begin
      for i := 1 to Cnt do begin
        key := Format('IPv4Domain%d', [i]);
        s := Trim(ini.ReadString('HTTP', key, ''));
        if s <> '' then
          FIpv4List.Add(s);
      end;
    end;


    // プロキシ設定読み込み
    ReadProxySettings( ini );

    // 各種ウィンドウの設定読み込み
    ReadWindowSettings( ini );

		FWindowTop := ini.ReadInteger('WindowSize', 'Top', -1);
		FWindowLeft := ini.ReadInteger('WindowSize', 'Left', -1);
		FWindowHeight := ini.ReadInteger('WindowSize', 'Height', -1);
		FWindowWidth := ini.ReadInteger('WindowSize', 'Width', -1);
		FWindowMax := ini.ReadBool('WindowSize', 'Max', false);

		if FWindowHeight <= 0 then	FWindowHeight := 400;
		if FWindowWidth <= 0 then FWindowWidth := 600;

		FListStyle := TViewStyle(ini.ReadInteger('ViewStyle', 'ListView', Ord(vsReport)));

		FEditWindowTop := ini.ReadInteger('EditorWindowSize', 'Top', -1);
		FEditWindowLeft := ini.ReadInteger('EditorWindowSize', 'Left', -1);
		FEditWindowHeight := ini.ReadInteger('EditorWindowSize', 'Height', -1);
		FEditWindowWidth := ini.ReadInteger('EditorWindowSize', 'Width', -1);
		FEditWindowMax := ini.ReadBool('EditorWindowSize', 'Max', False);
		FEditWindowStay := ini.ReadBool('EditorWindowSize', 'Stay', False);
                FEditWindowTranslucent := ini.ReadBool('EditorWindowSize', 'Translucent', False);

		FOptionDialogTabIndex := ini.ReadInteger('OptionDialog', 'TabIndex', 0);

		//ツールバー
		FStdToolBarVisible := ini.ReadBool('ToolBar', 'StdVisible', True);
		FAddressBarVisible := ini.ReadBool('ToolBar', 'AddressVisible', True);
		FLinkBarVisible := ini.ReadBool('ToolBar', 'LinkVisible', True);
		FListToolBarVisible := ini.ReadBool('ToolBar', 'ListVisible', True);
		FListNameBarVisible := ini.ReadBool('ToolBar', 'ListNameVisible', True);
		FBrowserToolBarVisible := ini.ReadBool('ToolBar', 'BrowserVisible', True);
		FBrowserNameBarVisible := ini.ReadBool('ToolBar', 'BrowserNameVisible', True);
		//ツールバーWrapable
		FListToolBarWrapable := ini.ReadBool('ToolBar', 'ListWrapable', False);
		FBrowserToolBarWrapable := ini.ReadBool('ToolBar', 'BrowserWrapable', False);

		FBrowserTabVisible := ini.ReadBool('Tab', 'BrowserTabVisible', True);
		FBrowserTabPosition := TGikoTabPosition(ini.ReadInteger('Tab', 'BrowserTabPosition', Ord(gtpTop)));
		FBrowserTabAppend := TGikoTabAppend(ini.ReadInteger('Tab', 'BrowserTabAppend', Ord(gtaFirst)));
		FBrowserTabStyle := TGikoTabStyle(ini.ReadInteger('Tab', 'BrowserTabStyle', Ord(gtsFlat)));

		FMessageBarVisible := ini.ReadBool('MessageBar', 'Visible', True);
		FMessegeBarHeight := ini.ReadInteger('MessageBar', 'Height', 30);

		FStatusBarVisible := ini.ReadBool('StatusBar', 'Visible', True);

		FCabinetVisible := ini.ReadBool('Cabinet', 'Visible', True);
		FCabinetWidth := ini.ReadInteger('Cabinet', 'Width', 200);
		FCabinetIndex := ini.ReadInteger('Cabinet', 'Index', 0);

		FListOrientation := TGikoListOrientation(ini.ReadInteger('List', 'Orientation', Ord(gloHorizontal)));
		FListHeight := ini.ReadInteger('List', 'Height', 180);
		FListHeightState := TGikoListState(ini.ReadInteger('List', 'HeightState', Ord(glsNormal)));
		FListWidth := ini.ReadInteger('List', 'Width', 180);
		FListWidthState := TGikoListState(ini.ReadInteger('List', 'WidthState', Ord(glsNormal)));
//		FListHeightMax := ini.ReadBool('List', 'HeightMax', False);
//		FListWidthMax := ini.ReadBool('List', 'WidthMax', False);

        // 入力項目の履歴を読み込む
        ReadInputHisotrys( ini );

		// リストカラム幅
        ReadListColumnWidth( ini );

		// カテゴリリストカラム順序
        ReadOrdColumn( ini );

		//リスト番号
		FListViewNo := ini.ReadBool('Function', 'ListViewNo', True);
		//CSS
		UseCSS := ini.ReadBool('CSS', 'UseCSS', True);
		//CSSファイル名
		CSSFileName := ini.ReadString('CSS', 'FileName', 'default.css');
		//かしゅ～しゃのスキンを使うか
		FUseKatjushaType := ini.ReadBool('CSS', 'UseKatjushaType', false);

		//Mail欄表示
		FShowMail := ini.ReadBool('Thread', 'ShowMail', True);
		// レス表示範囲
		if ini.ReadBool('Thread', 'OnlyAHundredRes',false) then
			FResRange := 100	// 古い設定の互換用
		else
			FResRange := ini.ReadInteger( 'Thread', 'ResRange', Ord( grrAll ) );
		FResRangeHold := ini.ReadBool( 'Thread', 'ResRangeHold', False );
        FHeadResCount := ini.ReadInteger('Thread', 'HeadResCount', 1);
        FResRangeExCount:= ini.ReadInteger('Thread','ResRangeExCount', 100);
		// スレッド一覧表示範囲
		FThreadRange := TGikoThreadRange( ini.ReadInteger('ThreadList', 'ThreadRange', Ord( gtrAll )) );
		//非アクティブ時レスポップアップ表示
		FUnActivePopup := ini.ReadBool('Thread', 'UnActivePopup', False);
		//レスポップアップヘッダーボールド
		FResPopupHeaderBold := ini.ReadBool('Thread', 'ResPopupHeaderBold', True);
        // BEアイコン・Emoticon画像表示
        FIconImageDisplay := ini.ReadBool('Thread', 'IconImageDisplay', True);
        // スレタイ特定文字列除去
        FThreadTitleTrim := ini.ReadBool('Thread', 'ThreadTitleTrim', False);
		//削除確認
		FDeleteMsg := ini.ReadBool('Function', 'LogDeleteMessage', True);
		//終了確認
		FShowDialogForEnd := ini.ReadBool('Function','ShowDialogForEnd',false);
		//AllTabClose
		FShowDialogForAllTabClose := ini.ReadBool('Function','ShowDialogForAllTabClose',false);
                //Samba
		FUseSamba := ini.ReadBool('Function','UseSamba', True);
		//ResAnchorjamp
		ResAnchorJamp := ini.ReadBool('Function', 'ResAnchoJamp', True);
		//ログフォルダ
		LogFolder := ini.ReadString('Folder', 'LogFolder', GetAppDir + 'Log');
		NewLogFolder := '';

		//板URL
		//複数登録できるようにしてFBoardURLsにした　2003/10/05
		//FBoardURL2ch := ini.ReadString('BoardURL', '2ch', DEFAULT_2CH_BOARD_URL);

		//認証用ユーザID・パスワード
		FUserID := ini.ReadString('Attestation', 'UserID', '');
		FPassword := Decrypt(ini.ReadString('Attestation', 'Password', ''));
		FAutoLogin := ini.ReadBool('Attestation', 'AutoLogin', False);
		FForcedLogin := ini.ReadBool('Attestation', 'FForcedLogin', False);
//		FDolibURL	:= ini.ReadString('Attestation', 'FDolibURL', DOLIB_LOGIN_URL);
  	// User-Agentバージョン番号固定
    FUAVersion := ini.ReadInteger('HTTP', 'UAVersion', 0);

		//URLクリック時起動アプリ
		FURLApp := ini.ReadBool('URLApp', 'Select', False);
		FURLAppFile := ini.ReadString('URLApp', 'File', '');

		//mailtoクリック時動作
		FOpenMailer := ini.ReadBool('Mailto', 'Open', True);

		//ポップアップ位置
		FPopupPosition := TGikoPopupPosition(ini.ReadInteger('Browser', 'PopupPosition', Ord(gppRightTop)));
        // バタ56以前からのアップデート対策
        if (FPopupPosition = gppCenter) then begin
            FPopupPosition := gppTop;
        end;
        FRespopupDeltaX := ini.ReadInteger('Browser', 'RespopupDelteX', 5);
        FRespopupDeltaY := ini.ReadInteger('Browser', 'RespopupDelteY', 5);
        FRespopupWait   := ini.ReadInteger('Browser', 'RespopupWait', 1000);
        FRespopupMailTo := ini.ReadBool('Browser', 'RespopupMailTo', true);

		//アドレスバー
		FURLDisplay := ini.ReadBool('AddressBar', 'URLDisplay', False);
		FAddressBarTabStop := ini.ReadBool('AddressBar', 'TabStop', True);
		FLinkAddAddressBar := ini.ReadBool('AddressBar', 'LinkAdd', False);
		FAddressHistoryCount := ini.ReadInteger('AddressBar', 'HistoryCount', 100);

		//画像プレビュー
		FPreviewVisible := ini.ReadBool('Browser', 'PreviewVisible', True);
		FPreviewSize := TGikoPreviewSize(ini.ReadInteger('Browser', 'PreviewSize', Ord(gpsMedium)));
		FPreviewWait := ini.ReadInteger('Browser', 'PreviewWait', 500);

		// ブラウザ
		FBrowserAutoMaximize := TGikoBrowserAutoMaximize(
			ini.ReadInteger('Window', 'BrowserAutoMaximize', Ord(gbmDoubleClick)) );

		//スレッド一覧更新アイコン
		FListIconVisible := ini.ReadBool('ThreadList', 'StateIconVisible', True);
		FCreationTimeLogs := ini.ReadBool('ThreadList', 'CreationTimeLogs', True);
		FFutureThread := ini.ReadBool('ThreadList', 'FutureThread', True);
		FSelectInterval := ini.ReadInteger('ThreadList', 'SelectInterval', 110);
		//ソート順
		FBBSSortIndex := ini.ReadInteger('ThreadList', 'BBSSortIndex', 0);
		FBBSSortOrder := ini.ReadBool('ThreadList', 'BBSSortOrder', True);
		FCategorySortIndex := ini.ReadInteger('ThreadList', 'CategorySortIndex', 0);
		FCategorySortOrder := ini.ReadBool('ThreadList', 'CategorySortOrder', True);
		FBoardSortIndex := ini.ReadInteger('ThreadList', 'BoardSortIndex', 0);
		FBoardSortOrder := ini.ReadBool('ThreadList', 'BoardSortOrder', True);
		// DL後の自動ソート
		FAutoSortThreadList := ini.ReadBool('ThreadList', 'AutoSort', False);
		//Dat落ちスレソート順
		FDatOchiSortIndex := ini.ReadInteger('ThreadList', 'DatOchiSortIndex', -1);
		FDatOchiSortOrder := ini.ReadBool('ThreadList', 'DatOchiSortOrder', False);

		//書き込み時マシン時刻使用設定
		FUseMachineTime := ini.ReadBool('PostTime', 'UseMachineTime', False);
		FTimeAdjustSec := ini.ReadInteger('PostTime', 'TimeAdjustSec', 0);
		FTimeAdjust := ini.ReadBool('PostTime', 'TimeAdjust', True);

		//サウンド
		if Exists then begin
            SetCurrentDir(ExtractFilePath(Application.ExeName));
			for i := 0 to GetSoundCount - 1 do begin
				SoundFileName[i] := ini.ReadString('Sound', SoundName[i], '');
                // 相対参照対策
                // ファイルの存在チェック
                if not FileExists(ExpandFileName(SoundFileName[i])) then begin
                    SoundFileName[i] := '';
                end;
			end;
		end else begin
			s := 'Sound\';
			SoundFileName[0] := s + '取得成功.wav';
			SoundFileName[1] := s + '取得成功(差分).wav';
			SoundFileName[2] := s + '未更新.wav';
			SoundFileName[3] := '';
			SoundFileName[4] := s + 'エラー.wav';
		end;

		//クールバー
		for i := 0 to MAIN_COOLBAND_COUNT - 1 do begin
			CoolSet.FCoolID := ini.ReadInteger('MainCoolBar', 'ID' + IntToStr(i), -1);
			CoolSet.FCoolWidth := ini.ReadInteger('MainCoolBar', 'Width' + IntToStr(i), -1);
			CoolSet.FCoolBreak := ini.ReadBool('MainCoolBar', 'Break' + IntToStr(i), False);
    	if CoolSet.FCoolID = 3 then		// Shift-JI版お気に入りツールバー（リンクバー）
      	CoolSet.FCoolID := 4;				// Unicode版に差し替え
			MainCoolSet[i] := CoolSet;
		end;
		FSelectComboBoxWidth := ini.ReadInteger( 'ListCoolBar', 'SelectWidth', 127 );
		for i := 0 to LIST_COOLBAND_COUNT - 1 do begin
			CoolSet.FCoolID := ini.ReadInteger('ListCoolBar', 'ID' + IntToStr(i), -1);
			CoolSet.FCoolWidth := ini.ReadInteger('ListCoolBar', 'Width' + IntToStr(i), -1);
			CoolSet.FCoolBreak := ini.ReadBool('ListCoolBar', 'Break' + IntToStr(i), False);
			ListCoolSet[i] := CoolSet;
		end;
		for i := 0 to BROWSER_COOLBAND_COUNT - 1 do begin
			CoolSet.FCoolID := ini.ReadInteger('BrowserCoolBar', 'ID' + IntToStr(i), -1);
			CoolSet.FCoolWidth := ini.ReadInteger('BrowserCoolBar', 'Width' + IntToStr(i), -1);
			CoolSet.FCoolBreak := ini.ReadBool('BrowserCoolBar', 'Break' + IntToStr(i), False);
			BrowserCoolSet[i] := CoolSet;
		end;

		//あぼ～ん
		FAbonDeleterlo := ini.ReadBool('Abon','Deleterlo',false);
		FAbonReplaceul := ini.ReadBool('Abon','Replaceul',false);
		FPopUpAbon		 := ini.ReadBool('Abon','Popup',false);
		FShowNGLinesNum := ini.ReadBool('Abon','ShowNGLines',false);
		FAddResAnchor := ini.ReadBool('Abon','AddResAnchor',false);
		FDeleteSyria :=  ini.ReadBool('Abon','DeleteSyria',false);
		FIgnoreKana  :=  ini.ReadBool('Abon','IgnoreKana',false);
    FKeepNgFile  :=  ini.ReadBool('Abon','KeepNgFile',false);

        //NGワード編集
        FNGTextEditor   := ini.ReadBool('NGWordEditor', 'NGTextEditor', False);
		FNGWindowTop    := ini.ReadInteger('NGWordEditor', 'NGWindowTop', 100);
		FNGWindowLeft   := ini.ReadInteger('NGWordEditor', 'NGWindowLeft', 100);
		FNGWindowHeight := ini.ReadInteger('NGWordEditor', 'NGWindowHeight', 478);
		FNGWindowWidth  := ini.ReadInteger('NGWordEditor', 'NGWindowWidth', 845);
		FNGWindowMax    := ini.ReadBool('NGWordEditor', 'NGWindowMax', False);

		// エディタ
		FSpaceToNBSP	:= ini.ReadBool( 'Editor', 'SpaceToNBSP', False );
		FAmpToCharRef	:= ini.ReadBool( 'Editor', 'AmpToCharRef', False );
		FUseGobakuCheck := ini.ReadBool( 'Editor', 'UseGobakuCheck', True );
		FUseUnicode     := True;//ini.ReadBool( 'Editor', 'UseUnicode', False );
    FPreviewStyle   := ini.ReadBool( 'Editor', 'PreviewStyle', False );
    FOekaki         := ini.ReadBool( 'Editor', 'Oekaki', True );

		//Tab自動保存、読み込み
		FTabAutoLoadSave    := ini.ReadBool('TabAuto', 'TabAutoLoadSave', False);
        FLastCloseTabURL    := ini.ReadString('Thread', 'LastCloseTabURL', '');
		FKuroutSettingTabIndex := ini.ReadInteger('OptionDialog', 'KuroutTabIndex' , 0);

		// マウスジェスチャー
		FGestureEnabled := ini.ReadBool( 'Guesture', 'Enabled', False );
        FGestureIgnoreContext := ini.ReadBool( 'Guesture', 'IgnoreContext', False );
		//2ch言語サポ
		F2chSupport := ini.ReadBool('2chSupport', 'Support', False);

		//FusianaTrap
		FLocalTrapAtt := ini.ReadBool('Trap', 'LocalTrap', False);
		FRemoteTrapAtt := ini.ReadBool('Trap', 'RemoteTrap', False);
		FReadTimeOut := ini.ReadInteger('HTTP', 'ReadTimeOut', 10000);

		// 使用するスパムフィルタ
		FSpamFilterAlgorithm := TGikoSpamFilterAlgorithm(
			ini.ReadInteger( 'Abon', 'SpamFilterAlgorithm', Ord( gsfaNone ) ) );
		FMute := ini.ReadBool('Function', 'Mute', false);
		FUseUndecided := ini.ReadBool('ThreadList', 'UseUndecided', False);

        //Be2ch
		//認証用ユーザID・認証コード
		FBeUserID := ini.ReadString('Be', 'UserID', '');
		FBePassword := Decrypt(ini.ReadString('Be', 'Password', ''));
		FBeAutoLogin := ini.ReadBool('Be', 'AutoLogin', False);
		//履歴の最大保存件数
		FMaxRecordCount := Max(ini.ReadInteger('Recode', 'Max', 100), 1);

        //! 削除要請板を特別扱い
        FSakuBoard := ini.ReadBool('NewBoard', 'SakuSpecial', True);

		// 入力アシスト
		FInputAssistFormTop := ini.ReadInteger('IAtWindowsSize', 'Top', 0);
		FInputAssistFormLeft := ini.ReadInteger('IAtWindowsSize', 'Left', 0);
		FInputAssistFormWidth := ini.ReadInteger('IAtWindowsSize', 'Width', 400);
		FInputAssistFormHeight := ini.ReadInteger('IAtWindowsSize', 'Height', 460);

		//! スレタイ検索ウィンドウ
		FThrdSrchTop    := ini.ReadInteger('ThreadSearch', 'Top',    0);
		FThrdSrchLeft   := ini.ReadInteger('ThreadSearch', 'Left',   0);
		FThrdSrchWidth  := ini.ReadInteger('ThreadSearch', 'Width',  526);
		FThrdSrchHeight := ini.ReadInteger('ThreadSearch', 'Height', 550);
		FThrdSrchMax    := ini.ReadBool(   'ThreadSearch', 'Max',    False);
        FThrdSrchStay   := ini.ReadBool(   'ThreadSearch', 'Stay',   False);
        FThrdSrchCol1W  := ini.ReadInteger('ThreadSearch', 'Col1W',  80);
        FThrdSrchCol2W  := ini.ReadInteger('ThreadSearch', 'Col2W',  350);
        FThrdSrchCol3W  := ini.ReadInteger('ThreadSearch', 'Col3W',  40);
        FThrdSrchCol4W  := ini.ReadInteger('ThreadSearch', 'Col4W',  500);
        Cnt := ini.ReadInteger('ThreadSearch', 'HistoryCount',  0);
        if (Cnt > 0) then begin
            for i := 1 to Cnt do begin
                s := ini.ReadString('ThreadSearch', 'History' + IntToStr(i), '');
                if (s <> '') then
                    FThrdSrchHistory.Add(s);
            end;
        end;

		//! スレタイ検索ウィンドウ
		FDonguriTop    := ini.ReadInteger('DonguriSystem', 'Top',    0);
		FDonguriLeft   := ini.ReadInteger('DonguriSystem', 'Left',   0);
		FDonguriWidth  := ini.ReadInteger('DonguriSystem', 'Width',  296);
		FDonguriHeight := ini.ReadInteger('DonguriSystem', 'Height', 610);
		FDonguriStay   := ini.ReadBool(   'DonguriSystem', 'Stay',   False);
    FDonguriTheme  := ini.ReadInteger('DonguriSystem', 'Theme',  0);
    FDonguriTaskBar:= ini.ReadBool(   'DonguriSystem', 'TaskBar',False);
		//! どんぐり関連
    FDonguriMenuTop:= ini.ReadBool(   'Donguri',      'MenuTop', False);

		// Cookieに付加する固定コード
		FFixedCookie := ini.ReadString('Cookie', 'fixedString', FIXED_COOKIE);

        // リンク移動履歴の最大保持数
        FMoveHistorySize := ini.ReadInteger('MoveHisotry', 'Max', 20);

        FStoredTaskTray := ini.ReadBool('Function', 'StroedTaskTray', false);
        FLoopBrowserTabs := ini.ReadBool('Function', 'LoopBrowserTabs', false);
        FAddKeywordLink := ini.ReadBool('Thread', 'AddKeywordLink', false);
        if not (ini.ValueExists('Thread', 'ReplaceDat')) then begin
            msg := 'セキュリティソフトの誤反応対策をしますか？'+ #13#10 +
                 '（推奨:はい）'+ #13#10+'詳細設定から変更できます。';
 		    if MsgBox(Application.Handle,
                 msg, 'ギコナビ', MB_YESNO or MB_ICONQUESTION) = IDYES	then begin
                 FReplaceDat := True;
            end;
        end else begin
            FReplaceDat := ini.ReadBool('Thread', 'ReplaceDat', False);
        end;

        FSentIniFileSize := ini.ReadInteger('Function', 'SentIniFileSize', 3);
        FExtList := ini.ReadString('Function', 'ExtList', '*.gif;*.jpg;*.jpeg;*.png;*.zip;*.rar');

        FCheckDatFile := ini.ReadBool('ThreadList', 'CheckDatFile', True);
        FLimitResCountMessage := ini.ReadBool('Thread', 'LimitResCountMessage', True);

        // 冒険の書Cookie読み込み
        hostList := TStringList.Create;
        ini.ReadSection('Bouken', hostList);
        for i := 0 to hostList.Count - 1 do begin
            FBoukenCookieList.Add( hostList[i] + '=' +
                ini.ReadString('Bouken', hostList[i], '') );
        end;
        hostList.Free;

        // ギコナビ更新で利用したインストーラの削除
        s := ini.ReadString('Update', 'Remove0', '');
        if (FileExists(s)) then begin
            SysUtils.DeleteFile(s);
            // 削除に失敗しても無視する
            ini.DeleteKey('Update', 'Remove0');
        end;

		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;
//板更新用URL読み込み
procedure TSetting.ReadBoardURLsFile();
var
	ini: TMemIniFile;
	urlNum: Integer;
	i : Integer;
begin
	if not FileExists(GetBoardURLFileName()) then
	MakeURLIniFile();
	ini := TMemIniFile.Create(GetBoardURLFileName());
	try
		urlNum := ini.ReadInteger('URL','count',0);
		BoardURLSelected := ini.ReadInteger('URL','selected',0);
		for i := 0 to urlNum - 1 do begin
			FBoardURLs.Append(ini.ReadString('URL',IntToStr(i+1),''));
		end;
	finally
		ini.Free;
	end;

end;
//設定ファイル保存(system)
procedure TSetting.WriteSystemSettingFile();
var
	ini: TMemIniFile;
  i: Integer;
  key: String;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		//受信バッファサイズ
		//ini.WriteInteger('HTTP', 'RecvBufferSize', FRecvBufferSize);
		//HTTP1.1使用
		ini.WriteBool('HTTP', 'Protocol', FProtocol);
		//プロキシ接続HTTP1.1使用
		ini.WriteBool('HTTP', 'ProxyProtocol', FProxyProtocol);
  	// IPv
    ini.WriteBool('HTTP', 'IPv6', IPv6);
    ini.WriteInteger('HTTP', 'IPv4DomainCount', FIpv4List.Count);
    for i := 1 to FIpv4List.Count do begin
    	key := Format('IPv4Domain%d', [i]);
    	if i <= FIpv4List.Count then
      	ini.WriteString('HTTP', key, FIPv4List[i-1])
    end;

		ini.WriteBool('ReadProxy', 'Proxy', FReadProxy);
		ini.WriteString('ReadProxy', 'Address', FReadProxyAddress);
		ini.WriteInteger('ReadProxy', 'Port', FReadProxyPort);
		ini.WriteString('ReadProxy', 'UserID', FReadProxyUserID);
		ini.WriteString('ReadProxy', 'Password', FReadProxyPassword);

		ini.WriteBool('WriteProxy', 'Proxy', FWriteProxy);
		ini.WriteString('WriteProxy', 'Address', FWriteProxyAddress);
		ini.WriteInteger('WriteProxy', 'Port', FWriteProxyPort);
		ini.WriteString('WriteProxy', 'UserID', FWriteProxyUserID);
		ini.WriteString('WriteProxy', 'Password', FWriteProxyPassword);

		ini.WriteString('Window', 'BrowserFontName', FBrowserFontName);
		ini.WriteInteger('Window', 'BrowserFontSize', FBrowserFontSize);
		ini.WriteInteger('Window', 'BrowserFontSize', FBrowserFontSize);
		ini.WriteInteger('Window', 'BrowserFontBold', FBrowserFontBold);
		ini.WriteInteger('Window', 'BrowserFontItalic', FBrowserFontItalic);
		ini.WriteInteger('Window', 'BrowserFontColor', FBrowserFontColor);
		ini.WriteInteger('Window', 'BrowserBackColor', FBrowserBackColor);

		ini.WriteString('Window', 'CabinetFontName', FCabinetFontName);
		ini.WriteInteger('Window', 'CabinetFontSize', FCabinetFontSize);
		ini.WriteString('Window', 'CabinetFontColor', ColorToString(FCabinetFontColor));
		ini.WriteBool('Window', 'CabinetFontBold', FCabinetFontBold);
		ini.WriteBool('Window', 'CabinetFontItalic', FCabinetFontItalic);
		ini.WriteString('Window', 'CabinetBackColor', ColorToString(FCabinetBackColor));

		ini.WriteString('Window', 'ListFontName', FListFontName);
		ini.WriteInteger('Window', 'ListFontSize', FListFontSize);
		ini.WriteString('Window', 'ListFontColor', ColorToString(FListFontColor));
		ini.WriteString('Window', 'ListBackColor', ColorToString(FListBackColor));
		ini.WriteBool('Window', 'ListFontBold', FListFontBold);
		ini.WriteBool('Window', 'ListFontItalic', FListFontItalic);
		ini.WriteBool('Window','UseOddColor',FUseOddColorOddResNum);
		ini.WriteString('Window', 'OddColor',ColorToString(FOddColor));
		ini.WriteBool('Window','UnFocusedBold', FUnFocusedBold);
		ini.WriteBool('Window','SetBoardInfoStyle', FSetBoardInfoStyle);

		ini.WriteString('Window', 'MessageFontName', FMessageFontName);
		ini.WriteInteger('Window', 'MessageFontSize', FMessageFontSize);
		ini.WriteString('Window', 'MessageFontColor', ColorToString(FMessageFontColor));
		ini.WriteString('Window', 'MessageBackColor', ColorToString(FMessageBackColor));
		ini.WriteBool('Window', 'MessageFontBold', FMessageFontBold);
		ini.WriteBool('Window', 'MessageFontItalic', FMessageFontItalic);

		ini.WriteString('Window', 'EditorFontName', FEditorFontName);
		ini.WriteInteger('Window', 'EditorFontSize', FEditorFontSize);
		ini.WriteString('Window', 'EditorFontColor', ColorToString(FEditorFontColor));
		ini.WriteString('Window', 'EditorBackColor', ColorToString(FEditorBackColor));

		ini.WriteString('Window', 'BrowserTabFontName', FBrowserTabFontName);
		ini.WriteInteger('Window', 'BrowserTabFontSize', FBrowserTabFontSize);
		ini.WriteBool('Window', 'BrowserTabFontBold', FBrowserTabFontBold);
		ini.WriteBool('Window', 'BrowserTabFontItalic', FBrowserTabFontItalic);

		ini.WriteString('Window', 'HintFontName', FHintFontName);
		ini.WriteInteger('Window', 'HintFontSize', FHintFontSize);
		ini.WriteString('Window', 'HintFontColor', ColorToString(FHintFontColor));
		ini.WriteString('Window', 'HintBackColor', ColorToString(FHintBackColor));

		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

//設定ファイル保存(window)
procedure TSetting.WriteWindowSettingFile();
var
	i: Integer;
	ini: TMemIniFile;
	CoolSet: TCoolSet;
	wkList	: TStringList;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		ini.WriteInteger('WindowSize', 'Top', WindowTop);
		ini.WriteInteger('WindowSize', 'Left', WindowLeft);
		ini.WriteInteger('WindowSize', 'Height', WindowHeight);
		ini.WriteInteger('WindowSize', 'Width', WindowWidth);
		ini.WriteBool('WindowSize', 'Max', WindowMax);

		ini.WriteInteger('ViewStyle', 'ListView', Ord(ListStyle));

		ini.WriteInteger('EditorWindowSize', 'Top', EditWindowTop);
		ini.WriteInteger('EditorWindowSize', 'Left', EditWindowLeft);
		ini.WriteInteger('EditorWindowSize', 'Height', EditWindowHeight);
		ini.WriteInteger('EditorWindowSize', 'Width', EditWindowWidth);
		ini.WriteBool('EditorWindowSize', 'Max', EditWindowMax);
		ini.WriteBool('EditorWindowSize', 'Stay', EditWindowStay);
		ini.WriteBool('EditorWindowSize', 'Translucent', EditWindowTranslucent);

		ini.WriteInteger('OptionDialog', 'TabIndex', FOptionDialogTabIndex);

		// 入力アシスト
		ini.WriteInteger('IAtWindowsSize', 'Top', FInputAssistFormTop);
		ini.WriteInteger('IAtWindowsSize', 'Left', FInputAssistFormLeft);
		ini.WriteInteger('IAtWindowsSize', 'Width', FInputAssistFormWidth);
		ini.WriteInteger('IAtWindowsSize', 'Height', FInputAssistFormHeight);

		//ツールバー
		ini.WriteBool('ToolBar', 'StdVisible', FStdToolBarVisible);
		ini.WriteBool('ToolBar', 'AddressVisible', FAddressBarVisible);
		ini.WriteBool('ToolBar', 'LinkVisible', FLinkBarVisible);
		ini.WriteBool('ToolBar', 'ListVisible', FListToolBarVisible);
		ini.WriteBool('ToolBar', 'ListNameVisible', FListNameBarVisible);
		ini.WriteBool('ToolBar', 'BrowserVisible', FBrowserToolBarVisible);
		ini.WriteBool('ToolBar', 'BrowserNameVisible', FBrowserNameBarVisible);
		//ツールバーWrapable
		ini.WriteBool('ToolBar', 'ListWrapable', FListToolBarWrapable);
		ini.WriteBool('ToolBar', 'BrowserWrapable', FBrowserToolBarWrapable);

		//タブ
		ini.WriteBool('Tab', 'BrowserTabVisible', FBrowserTabVisible);
		ini.WriteInteger('Tab', 'BrowserTabPosition', Ord(FBrowserTabPosition));
		ini.WriteInteger('Tab', 'BrowserTabAppend', Ord(FBrowserTabAppend));
		ini.WriteInteger('Tab', 'BrowserTabStyle', Ord(FBrowserTabStyle));

		//メッセージバー
		ini.WriteBool('MessageBar', 'Visible', FMessageBarVisible);
		ini.WriteInteger('MessageBar', 'Height', FMessegeBarHeight);

		//ステータスバー
		ini.WriteBool('StatusBar', 'Visible', FStatusBarVisible);

		//キャビネット
		ini.WriteBool('Cabinet', 'Visible', FCabinetVisible);
		ini.WriteInteger('Cabinet', 'Width', FCabinetWidth);
		ini.WriteInteger('Cabinet', 'Index', FCabinetIndex);

		//リストのサイズと垂直水平
		ini.WriteInteger('List', 'Orientation', Ord(FListOrientation));
		ini.WriteInteger('List', 'Height', FListHeight);
		ini.WriteInteger('List', 'HeightState', Ord(FListHeightState));
		ini.WriteInteger('List', 'Width', FListWidth);
		ini.WriteInteger('List', 'WidthState', Ord(FListWidthState));
//		ini.WriteBool('List', 'HeightMax', FListHeightMax);
//		ini.WriteBool('List', 'WidthMax', FListWidthMax);


//		ini.WriteInteger('Window', 'BrowserFontSize', BrowserFontSize);

		//リスト番号表示
		ini.WriteBool('Function', 'ListViewNo', FListViewNo);
		//CSS使用
		ini.WriteBool('CSS', 'UseCSS', FUseCSS);
		//かしゅ～しゃのスキンを使うか
		ini.WriteBool('CSS', 'UseKatjushaType', FUseKatjushaType);
		//CSSファイル名
		ini.WriteString('CSS', 'FileName', FSkinFiles.FileName);
		//Mail欄表示
		ini.WriteBool('Thread', 'ShowMail', FShowMail);
		// レス表示範囲
		ini.DeleteKey( 'Thread', 'OnlyAHundredRes' );   // 古い設定の削除
		ini.WriteInteger('Thread', 'ResRange', FResRange);
		ini.WriteBool('Thread', 'ResRangeHold', FResRangeHold);
        ini.WriteInteger('Thread', 'HeadResCount', FHeadResCount);
        ini.WriteInteger('Thread','ResRangeExCount', FResRangeExCount);
		// スレッド一覧表示範囲
		ini.WriteInteger('ThreadList', 'ThreadRange', Ord( FThreadRange ));
		//ログ削除確認
		ini.WriteBool('Function', 'LogDeleteMessage', FDeleteMsg);
		//終了確認
		ini.WriteBool('Function','ShowDialogForEnd',FShowDialogForEnd);
		//AllTabClose
		ini.WriteBool('Function','ShowDialogForAllTabClose', FShowDialogForAllTabClose);
		//Samba
		ini.WriteBool('Function','UseSamba', FUseSamba);
		//ResAnchorjamp
		ini.WriteBool('Function', 'ResAnchoJamp', ResAnchorJamp);

		//非アクティブ時ポップアップ表示
		ini.WriteBool('Thread', 'UnActivePopup', FUnActivePopup);
		//レスポップアップヘッダーボールド
		ini.WriteBool('Thread', 'ResPopupHeaderBold', FResPopupHeaderBold);
        // BEアイコン・Emoticon画像表示
        ini.WriteBool('Thread', 'IconImageDisplay', FIconImageDisplay);
        // スレタイ特定文字列除去
        ini.WriteBool('Thread', 'ThreadTitleTrim', FThreadTitleTrim);
		//ini.WriteString('BoardURL', '2ch', FBoardURL2ch);

		//認証用ユーザID・パスワード
		ini.WriteString('Attestation', 'UserID', FUserID);
		ini.WriteString('Attestation', 'Password', Encrypt(FPassword));
		ini.WriteBool('Attestation', 'AutoLogin', FAutoLogin);
		ini.WriteBool('Attestation', 'FForcedLogin', FForcedLogin);
//		ini.WriteString('Attestation', 'FDolibURL', FDolibURL);
  	// User-Agentバージョン番号固定
    ini.WriteInteger('HTTP', 'UAVersion', FUAVersion);

		//URLクリック時起動アプリ
		ini.WriteBool('URLApp', 'Select', FURLApp);
		ini.WriteString('URLApp', 'File', FURLAppFile);

		//mailtoクリック時動作
		ini.WriteBool('Mailto', 'Open', FOpenMailer);

		//ポップアップ位置
		ini.WriteInteger('Browser', 'PopupPosition', Ord(FPopupPosition));
        ini.WriteInteger('Browser', 'RespopupDelteX', FRespopupDeltaX);
        ini.WriteInteger('Browser', 'RespopupDelteY', FRespopupDeltaY);
        ini.WriteInteger('Browser', 'RespopupWait', FRespopupWait);
        ini.WriteBool('Browser', 'RespopupMailTo', FRespopupMailTo);
        
		//アドレスバー
		ini.WriteBool('AddressBar', 'URLDisplay', FURLDisplay);
		ini.WriteBool('AddressBar', 'TabStop', FAddressBarTabStop);
		ini.WriteBool('AddressBar', 'LinkAdd', FLinkAddAddressBar);
		ini.WriteInteger('AddressBar', 'HistoryCount', FAddressHistoryCount);

		//画像プレビュー
		ini.WriteBool('Browser', 'PreviewVisible', FPreviewVisible);
		ini.WriteInteger('Browser', 'PreviewSize', Ord(FPreviewSize));
		ini.WriteInteger('Browser', 'PreviewWait', FPreviewWait);

		ini.WriteInteger('Window', 'BrowserAutoMaximize', Ord( BrowserAutoMaximize ) );

		//スレッド一覧更新アイコン
		ini.WriteBool('ThreadList', 'StateIconVisible', FListIconVisible);
		ini.WriteBool('ThreadList', 'CreationTimeLogs',FCreationTimeLogs);
		ini.WriteBool('ThreadList', 'FutureThread', FFutureThread);
		ini.WriteInteger('ThreadList', 'SelectInterval', FSelectInterval);
		//ソート順
		ini.WriteInteger('ThreadList', 'BBSSortIndex', FBBSSortIndex);
		ini.WriteBool('ThreadList', 'BBSSortOrder', FBBSSortOrder);
		ini.WriteInteger('ThreadList', 'CategorySortIndex', FCategorySortIndex);
		ini.WriteBool('ThreadList', 'CategorySortOrder', FCategorySortOrder);
		ini.WriteInteger('ThreadList', 'BoardSortIndex', FBoardSortIndex);
		ini.WriteBool('ThreadList', 'BoardSortOrder', FBoardSortOrder);
		ini.WriteInteger('ThreadList', 'DatOchiSortIndex', FDatOchiSortIndex);
		ini.WriteBool('ThreadList', 'DatOchiSortOrder', FDatOchiSortOrder);
		// DL後の自動ソート
		ini.WriteBool('ThreadList', 'AutoSort', FAutoSortThreadList);

		//書き込み時マシン時刻使用設定
		ini.WriteBool('PostTime', 'UseMachineTime', FUseMachineTime);
		ini.WriteInteger('PostTime', 'TimeAdjustSec', FTimeAdjustSec);
		ini.WriteBool('PostTime', 'TimeAdjust', FTimeAdjust);

		// リストカラム幅
		for i := 0 to Length(FBBSColumnWidth) - 1 do begin
			ini.WriteInteger('BBSColumnWidth', 'ID' + IntToStr(i), FBBSColumnWidth[i]);
		end;
		for i := 0 to Length(FCategoryColumnWidth) - 1 do begin
			ini.WriteInteger('CategoryColumnWidth', 'ID' + IntToStr(i), FCategoryColumnWidth[i]);
		end;
		for i := 0 to Length(FBoardColumnWidth) - 1 do begin
			ini.WriteInteger('BoardColumnWidth', 'ID' + IntToStr(i), FBoardColumnWidth[i]);
		end;

		wkList := TStringList.Create;
		try
			// カテゴリリスト順序
			ini.ReadSection( 'BBSColumnOrder', wkList );
			for i := wkList.Count - 1 downto 0 do
				ini.DeleteKey( 'BBSColumnOrder', wkList[ i ] );
			for i := 0 to FBBSColumnOrder.Count - 1 do
				ini.WriteInteger( 'BBSColumnOrder', 'ID' + IntToStr( i ), Ord( FBBSColumnOrder[ i ] ) );

			// 板リスト順序
			ini.ReadSection( 'CategoryColumnOrder', wkList );
			for i := wkList.Count - 1 downto 0 do
				ini.DeleteKey( 'CategoryColumnOrder', wkList[ i ] );
			for i := 0 to FCategoryColumnOrder.Count - 1 do
				ini.WriteInteger( 'CategoryColumnOrder', 'ID' + IntToStr( i ), Ord( FCategoryColumnOrder[ i ] ) );

			// スレリスト順序
			ini.ReadSection( 'BoardColumnOrder', wkList );
			for i := wkList.Count - 1 downto 0 do
				ini.DeleteKey( 'BoardColumnOrder', wkList[ i ] );
			for i := 0 to FBoardColumnOrder.Count - 1 do
				ini.WriteInteger( 'BoardColumnOrder', 'ID' + IntToStr( i ), Ord( FBoardColumnOrder[ i ] ) );
		finally
			wkList.Free;
		end;

		//サウンド
		for i := 0 to GetSoundCount - 1 do begin
			if not FileExists(SoundFileName[i]) then
				SoundFileName[i] := '';
			ini.WriteString('Sound', SoundName[i], SoundFileName[i]);
		end;

		//CoolBar
		ini.EraseSection('MainCoolBar');
		for i := 0 to MAIN_COOLBAND_COUNT - 1 do begin
			CoolSet := MainCoolSet[i];
			ini.WriteInteger('MainCoolBar', 'ID' + IntToStr(i), CoolSet.FCoolID);
			ini.WriteInteger('MainCoolBar', 'Width' + IntToStr(i), CoolSet.FCoolWidth);
			ini.WriteBool('MainCoolBar', 'Break' + IntToStr(i), CoolSet.FCoolBreak);
		end;
		ini.EraseSection('ListCoolBar');
		ini.WriteInteger( 'ListCoolBar', 'SelectWidth', FSelectComboBoxWidth );
		for i := 0 to LIST_COOLBAND_COUNT - 1 do begin
			CoolSet := ListCoolSet[i];
			ini.WriteInteger('ListCoolBar', 'ID' + IntToStr(i), CoolSet.FCoolID);
			ini.WriteInteger('ListCoolBar', 'Width' + IntToStr(i), CoolSet.FCoolWidth);
			ini.WriteBool('ListCoolBar', 'Break' + IntToStr(i), CoolSet.FCoolBreak);
		end;
		ini.EraseSection('BrowserCoolBar');
		for i := 0 to BROWSER_COOLBAND_COUNT - 1 do begin
			CoolSet := BrowserCoolSet[i];
			ini.WriteInteger('BrowserCoolBar', 'ID' + IntToStr(i), CoolSet.FCoolID);
			ini.WriteInteger('BrowserCoolBar', 'Width' + IntToStr(i), CoolSet.FCoolWidth);
			ini.WriteBool('BrowserCoolBar', 'Break' + IntToStr(i), CoolSet.FCoolBreak);
		end;

		//あぼ～ん
		ini.WriteBool('Abon','Deleterlo',FAbonDeleterlo);
		ini.WriteBool('Abon','Replaceul',FAbonReplaceul);
		ini.WriteBool('Abon','Popup',FPopUpAbon);
		ini.WriteBool('Abon','ShowNGLines',FShowNGLinesNum);
		ini.WriteBool('Abon','AddResAnchor',FAddResAnchor);
		ini.WriteBool('Abon','DeleteSyria',FDeleteSyria);
		ini.WriteBool('Abon','IgnoreKana', FIgnoreKana);
    ini.WriteBool('Abon','KeepNgFile', FKeepNgFile);

		//NGワード編集
		ini.WriteBool('NGWordEditor', 'NGTextEditor', FNGTextEditor);
		ini.WriteInteger('NGWordEditor', 'NGWindowTop', FNGWindowTop);
		ini.WriteInteger('NGWordEditor', 'NGWindowLeft', FNGWindowLeft);
		ini.WriteInteger('NGWordEditor', 'NGWindowHeight', FNGWindowHeight);
		ini.WriteInteger('NGWordEditor', 'NGWindowWidth', FNGWindowWidth);
		ini.WriteBool('NGWordEditor', 'NGWindowMax', FNGWindowMax);

		// エディタ
		ini.WriteBool( 'Editor', 'SpaceToNBSP',    FSpaceToNBSP );
		ini.WriteBool( 'Editor', 'AmpToCharRef',   FAmpToCharRef );
		ini.WriteBool( 'Editor', 'UseGobakuCheck', FUseGobakuCheck );
		//ini.WriteBool( 'Editor', 'UseUnicode',     FUseUnicode );
    ini.WriteBool( 'Editor', 'PreviewStyle',   FPreviewStyle );
    ini.WriteBool( 'Editor', 'Oekaki',         FOekaki );

    //! 削除要請板を特別扱い
    ini.WriteBool('NewBoard', 'SakuSpecial', FSakuBoard);

		//タブ自動保存
		ini.WriteBool('TabAuto', 'TabAutoLoadSave', FTabAutoLoadSave);
		ini.WriteString('Thread', 'LastCloseTabURL', FLastCloseTabURL);
                //詳細設定
		ini.WriteInteger('OptionDialog', 'KuroutTabIndex', FKuroutSettingTabIndex);

		//にちゃん語案内機能
		ini.WriteBool('2chSupport', 'Support', F2chSupport);

		// マウスジェスチャーを使用するかどうか
		ini.WriteBool( 'Guesture', 'Enabled', FGestureEnabled );
		ini.WriteBool( 'Guesture', 'IgnoreContext', FGestureIgnoreContext );
		//FusianaTrap
		ini.WriteBool('Trap', 'LocalTrap', FLocalTrapAtt);
		ini.WriteBool('Trap', 'RemoteTrap', FRemoteTrapAtt);
		ini.WriteInteger('HTTP', 'ReadTimeOut', FReadTimeOut);

		// 使用するスパムフィルタ
		ini.WriteInteger( 'Abon', 'SpamFilterAlgorithm', Ord( FSpamFilterAlgorithm ) );
		ini.WriteBool('Function', 'Mute', FMute);
		ini.WriteBool('ThreadList', 'UseUndecided', FUseUndecided);

		//認証用ユーザID・パスワード
		ini.WriteString('Be', 'UserID', FBeUserID);
		ini.WriteString('Be', 'Password', Encrypt(FBePassword));
		ini.WriteBool('Be', 'AutoLogin', FBeAutoLogin);

		//履歴の最大保存件数
		ini.WriteInteger('Recode', 'Max', FMaxRecordCount);
		// 固定のCookie文字列
    ini.WriteString('Cookie', 'fixedString', FFixedCookie);

    // リンク移動履歴の最大保持数
    ini.WriteInteger('MoveHisotry', 'Max', FMoveHistorySize);

    ini.WriteBool('Function', 'StroedTaskTray', FStoredTaskTray);
    ini.WriteBool('Function', 'LoopBrowserTabs', FLoopBrowserTabs);
    ini.WriteBool('Thread', 'AddKeywordLink', FAddKeywordLink);
    ini.WriteBool('Thread', 'ReplaceDat', FReplaceDat);
    ini.WriteInteger('Function', 'SentIniFileSize', FSentIniFileSize);
    ini.WriteString('Function', 'ExtList', FExtList);
    ini.WriteBool('ThreadList', 'CheckDatFile', FCheckDatFile);
    ini.WriteBool('Thread', 'LimitResCountMessage', FLimitResCountMessage);

		//! スレタイ検索ウィンドウ
		ini.WriteInteger('ThreadSearch', 'Top',    FThrdSrchTop);
		ini.WriteInteger('ThreadSearch', 'Left',   FThrdSrchLeft);
		ini.WriteInteger('ThreadSearch', 'Width',  FThrdSrchWidth);
		ini.WriteInteger('ThreadSearch', 'Height', FThrdSrchHeight);
		ini.WriteBool(   'ThreadSearch', 'Max',    FThrdSrchMax);
    ini.WriteBool(   'ThreadSearch', 'Stay',   FThrdSrchStay);
    ini.WriteInteger('ThreadSearch', 'Col1W',  FThrdSrchCol1W);
    ini.WriteInteger('ThreadSearch', 'Col2W',  FThrdSrchCol2W);
    ini.WriteInteger('ThreadSearch', 'Col3W',  FThrdSrchCol3W);
    ini.WriteInteger('ThreadSearch', 'Col4W',  FThrdSrchCol4W);
    ini.WriteInteger('ThreadSearch', 'HistoryCount', FThrdSrchHistory.Count);
    if (FThrdSrchHistory.Count > 0) then begin
			for i := 1 to FThrdSrchHistory.Count do begin
				ini.WriteString('ThreadSearch', 'History' + IntToStr(i), FThrdSrchHistory.Strings[i-1]);
			end;
    end;

		//! スどんぐりシステムウィンドウ
		ini.WriteInteger('DonguriSystem', 'Top',    FDonguriTop);
		ini.WriteInteger('DonguriSystem', 'Left',   FDonguriLeft);
		ini.WriteInteger('DonguriSystem', 'Width',  FDonguriWidth);
		ini.WriteInteger('DonguriSystem', 'Height', FDonguriHeight);
		ini.WriteBool(   'DonguriSystem', 'Stay',   FDonguriStay);
    ini.WriteInteger('DonguriSystem', 'Theme',  FDonguriTheme);
    ini.WriteBool(   'DonguriSystem', 'TaskBar',FDonguriTaskBar);
		//! どんぐり関連
    ini.WriteBool(   'Donguri',      'MenuTop', FDonguriMenuTop);


		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;
//設定ファイル保存(冒険の書)
procedure TSetting.WriteBoukenSettingFile;
var
	i: Integer;
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		ini.EraseSection('Bouken');
        // 冒険の書Cookie書き込み
        for i := 0 to FBoukenCookieList.Count - 1 do begin
            ini.WriteString('Bouken', FBoukenCookieList.Names[i], FBoukenCookieList.Values[FBoukenCookieList.Names[i]]);
        end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

//設定ファイル保存(name & mail)
procedure TSetting.WriteNameMailSettingFile();
var
	i: Integer;
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		ini.EraseSection('Name');
		ini.EraseSection('Mail');
		ini.EraseSection('SelectText');
		for i := 0 to FNameList.Count - 1 do begin
			ini.WriteString('Name', Format('%.2d', [i + 1]), FNameList[i]);
			if i >= 39 then
				Break;
		end;
		for i := 0 to FMailList.Count - 1 do begin
			ini.WriteString('Mail', Format('%.2d', [i + 1]), FMailList[i]);
			if i >= 39 then
				Break;
		end;
		for i := 0 to FSelectTextList.Count - 1 do begin
			ini.WriteString('SelectText', Format('%.2d', [i + 1]), FSelectTextList[i]);
			if i >= 39 then
				Break;
		end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

procedure TSetting.WriteFolderSettingFile();
var
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		if GetAppDir + 'Log' = NewLogFolder then
			ini.DeleteKey('Folder', 'LogFolder')
		else
			ini.WriteString('Folder', 'LogFolder', NewLogFolder);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;
//板更新用BoardURLを保存
procedure TSetting.WriteBoardURLSettingFile();
var
	ini: TMemIniFile;
		i : Integer;
		oldcount : Integer;
begin
	ini := TMemIniFile.Create(GetBoardURLFileName());
	try
		oldcount := ini.ReadInteger('URL','count',FBoardURLs.Count);
		ini.WriteInteger('URL','count',FBoardURLs.Count);
		ini.WriteInteger('URL','selected',BoardURLSelected);
		for i := 0 to FBoardURLs.Count -1 do begin
					ini.WriteString('URL',IntToStr(i+1),FBoardURLs.Strings[i]);
		end;
		if oldcount > FBoardURLs.Count then begin
			for i := FBoardURLs.Count to oldcount do begin
				ini.DeleteKey('URL',IntToStr(i+1));
			end;
		end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

{$R-}
//リストカラムヘッダー
function TSetting.GetBBSColumnWidth(index: Integer): Integer;
begin
	Result := IfThen(index in [0..Length(FBBSColumnWidth) - 1], FBBSColumnWidth[index], 0);
end;

function TSetting.GetCategoryColumnWidth(index: Integer): Integer;
begin
	Result := IfThen(index in [0..Length(FCategoryColumnWidth) - 1], FCategoryColumnWidth[index], 0);
end;

function TSetting.GetBoardColumnWidth(index: Integer): Integer;
begin
	Result := IfThen(index in [0..Length(FBoardColumnWidth) - 1], FBoardColumnWidth[index], 0);
end;
{$IFDEF DEBUG}
{$R+}
{$ENDIF}

procedure TSetting.SetBBSColumnWidth(index: Integer; value: Integer);
begin
	if index in [0..Length(FBBSColumnWidth) - 1] then
		FBBSColumnWidth[index] := value;
end;

procedure TSetting.SetCategoryColumnWidth(index: Integer; value: Integer);
begin
	if index in [0..Length(FCategoryColumnWidth) - 1] then
		FCategoryColumnWidth[index] := value;
end;

procedure TSetting.SetBoardColumnWidth(index: Integer; value: Integer);
begin
	if index in [0..Length(FBoardColumnWidth) - 1] then
		FBoardColumnWidth[index] := value;
end;

function TSetting.GetSoundCount: Integer;
begin
	Result := Length(SOUND_NAME);
end;

function TSetting.GetSoundName(Index: Integer): string;
begin
	if (Index < GetSoundCount) and (Index >= 0) then
		Result := SOUND_NAME[Index].Name
	else
		Result := '';
end;

function TSetting.GetSoundViewName(Index: Integer): string;
begin
	if (Index < GetSoundCount) and (Index >= 0) then
		Result := SOUND_NAME[Index].ViewName
	else
		Result := '';
end;

function TSetting.GetSoundFileName(Index: Integer): string;
begin
	if (Index < GetSoundCount) and (Index >= 0) then
		Result := SOUND_NAME[Index].FileName
	else
		Result := '';
end;

procedure TSetting.SetSoundFileName(Index: Integer; value: string);
begin
	if (Index < GetSoundCount) and (Index >= 0) then
		SOUND_NAME[Index].FileName := value;
end;

function TSetting.FindSoundFileName(Name: string): string;
var
	i: Integer;
begin
	for i := 0 to GetSoundCount - 1 do begin
		if SoundName[i] = Name then begin
            SysUtils.SetCurrentDir(GetAppDir);
			Result := ExpandFileName(SoundFileName[i]);
			Exit;
		end;
	end;
	Result := '';
end;

function TSetting.Encrypt(s: string): string;
var
	cryptObj: THogeCryptAuto;
	inputStream, outputStream: TStringStream;
begin
	inputStream := TStringStream.Create(s);
	outputStream := TStringStream.Create('');
	cryptObj := THogeCryptAuto.Create;
	try
		// 暗号化
		cryptObj.Encrypt(inputStream, GIKO_ENCRYPT_TEXT, outputStream);

		// バイナリなので必要に応じてテキストに変換
		Result := HogeBase64Encode(outputStream.DataString);
	finally
		cryptObj.Free;
		outputStream.Free;
		inputStream.Free;
	end;
end;

function TSetting.Decrypt(s: string): string;
var
	cryptObj: THogeCryptAuto;
	inputStream, outputStream: TStringStream;
begin
	try
		inputStream := TStringStream.Create(HogeBase64Decode(s));
	except
		Result := '';
		Exit;
	end;
	outputStream := TStringStream.Create('');
	cryptObj := THogeCryptAuto.Create;
	try
		// 復号
		cryptObj.Decrypt(inputStream, GIKO_ENCRYPT_TEXT, outputStream);
		Result := outputStream.DataString;
	finally
		cryptObj.Free;
		outputStream.Free;
		inputStream.Free;
	end;
end;

function TSetting.GetMainCoolSet(Index: Integer): TCoolSet;
begin
	if Index in [0..MAIN_COOLBAND_COUNT - 1] then
		Result := FMainCoolBar[Index]
	else begin
		Result.FCoolID := -1;
		Result.FCoolWidth := -1;
		Result.FCoolBreak := False;
	end;
end;

function TSetting.GetBoardCoolSet(Index: Integer): TCoolSet;
begin
	if Index in [0..LIST_COOLBAND_COUNT - 1] then
		Result := FListCoolBar[Index]
	else begin
		Result.FCoolID := -1;
		Result.FCoolWidth := -1;
		Result.FCoolBreak := False;
	end;
end;

function TSetting.GetBrowserCoolSet(Index: Integer): TCoolSet;
begin
	if Index in [0..BROWSER_COOLBAND_COUNT - 1] then
		Result := FBrowserCoolBar[Index]
	else begin
		Result.FCoolID := -1;
		Result.FCoolWidth := -1;
		Result.FCoolBreak := False;
	end;
end;

procedure TSetting.SetMainCoolSet(Index: Integer; CoolSet: TCoolSet);
begin
	if Index in [0..MAIN_COOLBAND_COUNT - 1] then
		FMainCoolBar[Index] := CoolSet;
end;

procedure TSetting.SetBoardCoolSet(Index: Integer; CoolSet: TCoolSet);
begin
	if Index in [0..LIST_COOLBAND_COUNT - 1] then
		FListCoolBar[Index] := CoolSet;
end;

procedure TSetting.SetBrowserCoolSet(Index: Integer; CoolSet: TCoolSet);
begin
	if Index in [0..BROWSER_COOLBAND_COUNT - 1] then
		FBrowserCoolBar[Index] := CoolSet;
end;

//url.iniがないときに生成する
procedure TSetting.MakeURLIniFile();
var
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetBoardURLFileName());
	try
		//更新URLの数
		ini.WriteInteger('URL','count',1);
		//デフォルトで使用するＵＲＬのインデックス
		ini.WriteInteger('URL','selected',1);
		//以下必要な数だけ、更新ＵＲＬを追加
		ini.WriteString('URL','1',DEFAULT_2CH_BOARD_URL1);
		//ini.WriteString('URL','2',DEFAULT_2CH_BOARD_URL2);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

(*************************************************************************
 *ボードファイル名取得（パス＋ファイル名）
 *************************************************************************)
function TSetting.GetBoardFileName: string;
begin
	Result := GetConfigDir + BOARD_FILE_NAME;
end;

(*************************************************************************
 *ボードファイル名取得（パス＋ファイル名）
 *************************************************************************)
function TSetting.GetCustomBoardFileName: string;
begin
	Result := GetConfigDir + CUSTOMBOARD_FILE_NAME;
end;

(*************************************************************************
 *ボードディレクトリ取得(\で終わる)
 *************************************************************************)
function TSetting.GetBoardDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + BOARD_DIR_NAME);
end;

(*************************************************************************
 *テンポラリフォルダー名取得
 *************************************************************************)
function TSetting.GetHtmlTempFileName: string;
begin
	Result := TEMP_FOLDER;
end;


(*************************************************************************
 *実行ファイルフォルダ取得(最後に\がある)
 *************************************************************************)
function TSetting.GetAppDir: string;
begin
	Result := ExtractFilePath(Application.ExeName);
end;

(*************************************************************************
 *TempHtmlファイル名取得（パス＋ファイル名）
 *************************************************************************)
function TSetting.GetTempFolder: string;
begin
	Result := GetAppDir + TEMP_FOLDER;
end;

(*************************************************************************
 *sent.iniファイル名取得（パス＋ファイル名）
 *************************************************************************)
function TSetting.GetSentFileName: string;
begin
	Result := GetAppDir + SENT_FILE_NAME;
end;

(*************************************************************************
 *outbox.iniファイル名取得（パス＋ファイル名）
 *************************************************************************)
function TSetting.GetOutBoxFileName: string;
begin
	Result := GetAppDir + OUTBOX_FILE_NAME;
end;

(*************************************************************************
 *defaultFiles.iniファイル名取得（パス＋ファイル名）
 *************************************************************************)
function TSetting.GetDefaultFilesFileName: string;
begin
	Result := GetAppDir + DEFFILES_FILE_NAME;
end;

(*************************************************************************
 *Configフォルダ取得(\で終わる)
 *************************************************************************)
function TSetting.GetConfigDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetAppDir + CONFIG_DIR_NAME);
end;
(*************************************************************************
 *CSSフォルダ取得(\で終わる)
 *************************************************************************)
function TSetting.GetStyleSheetDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + CSS_DIR_NAME);
end;
(*************************************************************************
 *skinフォルダ取得(\で終わる)
 *************************************************************************)
function TSetting.GetSkinDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + SKIN_DIR_NAME);
end;
(*************************************************************************
 *NGワードディレクトリ取得(\で終わる)
 *************************************************************************)
function TSetting.GetNGWordsDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + NGWORDs_DIR_NAME);
end;
(*************************************************************************
 *Boardプラグインディレクトリ取得(\で終わる)
 *************************************************************************)
function TSetting.GetBoardPlugInDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + BOARD_PLUGIN_DIR_NAME);
end;

procedure TSetting.SetUseCSS( value: Boolean );
begin

	FUseCSS := value;
	// Windows的にファイルパスの大文字小文字の違いは無視されるので、
	// ココでの判定でも大文字小文字の違いは無視する。
	FUseSkin :=
		UseCSS and
		(Pos( AnsiLowerCase(GetSkinDir), AnsiLowerCase(FSkinFiles.FileName) ) > 0) and
		FileExists( FSkinFiles.GetSkinHeaderFileName );

end;

procedure TSetting.SetCSSFileName( fileName: string );
begin
    FSkinFiles.FileName := fileName;
	// Windows的にファイルパスの大文字小文字の違いは無視されるので、
	// ココでの判定でも大文字小文字の違いは無視する。
	FUseSkin :=
		UseCSS and
		(Pos( AnsiLowerCase(GetSkinDir), AnsiLowerCase(FSkinFiles.FileName) ) > 0) and
		FileExists( FSkinFiles.GetSkinHeaderFileName );

end;
(*************************************************************************
 *samba設定ファイル名取得
 *************************************************************************)
function TSetting.GetSambaFileName: string;
begin
	Result := GetAppDir + SAMBATIME_FILE_NAME;
end;
//板更新除外カテゴリリスト保存ファイル
function TSetting.GetIgnoreFileName: string;
begin
	Result := GetConfigDir + IGNORE_FILE_NAME;
end;

//! マウスジェスチャーファイルパス
function TSetting.GetGestureFileName: string;
begin
	Result := GetConfigDir + GESTURE_FILE_NAME;
end;

//! スパムフィルタ学習履歴ファイルパス
function TSetting.GetSpamFilterFileName: string;
begin
	Result := GetConfigDir + SPAMFILTER_FILE_NAME;
end;

function TSetting.GetLanguageFileName: string;
begin
    Result := GetConfigDir + LANGUAGE_FILE_NAME;
end;
procedure TSetting.WriteLogFolder(AVal : String);
begin
	FLogFolder := AVal;
	FLogFolderP := IncludeTrailingPathDelimiter(LogFolder);
end;
function TSetting.GetMainKeyFileName: String;
begin
	Result := GetConfigDir + KEY_SETTING_FILE_NAME;
end;
function TSetting.GetEditorKeyFileName: String;
begin
	Result := GetConfigDir + EKEY_SETTING_FILE_NAME;
end;
function TSetting.GetInputAssistFileName : String;
begin
	Result := GetConfigDir + INPUTASSIST_FILE_NAME;
end;
function TSetting.GetReplaceFileName: String;
begin
    Result := GetConfigDir + REPLACE_FILE_NAME;
end;
function TSetting.GetExtprevieFileName: String;
begin
    Result := GetConfigDir + EXT_PREVIEW_FILE_NAME;
end;
procedure TSetting.SetMoveHistorySize(AVal : Integer);
begin
    if (AVal > 0) then begin
        FMoveHistorySize := AVal;
    end;
end;
{
\brief プロキシ設定読み込み
\param  memIni  iniファイル
}
procedure TSetting.ReadProxySettings(memIni: TMemIniFile);
const
    READ_SECTION = 'ReadProxy';
    WRITE_SECTION= 'WriteProxy';
    PROXY_KEY = 'Proxy';
    ADDRE_KEY = 'Address';
    PORT_KEY = 'Port';
    UID_KEY  = 'UserID';
    PASS_KEY = 'Password';
begin
    if (memIni <> nil) then begin
		FReadProxy := memIni.ReadBool(READ_SECTION, PROXY_KEY, false);
		FReadProxyAddress := memIni.ReadString(READ_SECTION, ADDRE_KEY, '');
		FReadProxyPort := memIni.ReadInteger(READ_SECTION, PORT_KEY, 0);
		FReadProxyUserID := memIni.ReadString(READ_SECTION, UID_KEY, '');
		FReadProxyPassword := memIni.ReadString(READ_SECTION, PASS_KEY, '');

		FWriteProxy := memIni.ReadBool(WRITE_SECTION, PROXY_KEY, false);
		FWriteProxyAddress := memIni.ReadString(WRITE_SECTION, ADDRE_KEY, '');
		FWriteProxyPort := memIni.ReadInteger(WRITE_SECTION, PORT_KEY, 0);
		FWriteProxyUserID := memIni.ReadString(WRITE_SECTION, UID_KEY, '');
		FWriteProxyPassword := memIni.ReadString(WRITE_SECTION, PASS_KEY, '');
    end;
end;
{
\brief  各種ウィンドウ設定読み込み
\param  menIni  iniファイル
}
procedure TSetting.ReadWindowSettings(memIni: TMemIniFile);
const
    WINDOW_SECTION = 'Window';
begin
    if (memIni <> nil) then begin
		FBrowserFontName := memIni.ReadString(WINDOW_SECTION, 'BrowserFontName', '');
		FBrowserFontSize := memIni.ReadInteger(WINDOW_SECTION, 'BrowserFontSize', 0);
		FBrowserFontBold := memIni.ReadInteger(WINDOW_SECTION, 'BrowserFontBold', 0);
		FBrowserFontItalic := memIni.ReadInteger(WINDOW_SECTION, 'BrowserFontItalic', 0);
		FBrowserFontColor := memIni.ReadInteger(WINDOW_SECTION, 'BrowserFontColor', -1);
		FBrowserBackColor := memIni.ReadInteger(WINDOW_SECTION, 'BrowserBackColor', -1);

		FCabinetFontName := memIni.ReadString(WINDOW_SECTION, 'CabinetFontName', DEFAULT_FONT_NAME);
		FCabinetFontSize := memIni.ReadInteger(WINDOW_SECTION, 'CabinetFontSize', DEFAULT_FONT_SIZE);
		FCabinetFontBold := memIni.ReadBool(WINDOW_SECTION, 'CabinetFontBold', False);
		FCabinetFontItalic := memIni.ReadBool(WINDOW_SECTION, 'CabinetFontItalic', False);
		FCabinetFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'CabinetFontColor', DEFAULT_FONT_COLOR));
		FCabinetBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'CabinetBackColor', DEFAULT_WINDOW_COLOR));

		FListFontName := memIni.ReadString(WINDOW_SECTION, 'ListFontName', DEFAULT_FONT_NAME);
		FListFontSize := memIni.ReadInteger(WINDOW_SECTION, 'ListFontSize', DEFAULT_FONT_SIZE);
		FListFontBold := memIni.ReadBool(WINDOW_SECTION, 'ListFontBold', False);
		FListFontItalic := memIni.ReadBool(WINDOW_SECTION, 'ListFontItalic', False);
		FListFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'ListFontColor', DEFAULT_FONT_COLOR));
		FListBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'ListBackColor', DEFAULT_WINDOW_COLOR));
		FUseOddColorOddResNum := memIni.ReadBool(WINDOW_SECTION,'UseOddColor', False);
		FOddColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'OddColor', DEFAULT_WINDOW_COLOR));
		FUnFocusedBold := memIni.ReadBool(WINDOW_SECTION,'UnFocusedBold', False);
		FSetBoardInfoStyle := memIni.ReadBool(WINDOW_SECTION,'SetBoardInfoStyle', False);

		FMessageFontName := memIni.ReadString(WINDOW_SECTION, 'MessageFontName', DEFAULT_FONT_NAME);
		FMessageFontSize := memIni.ReadInteger(WINDOW_SECTION, 'MessageFontSize', DEFAULT_FONT_SIZE);
		FMessageFontBold := memIni.ReadBool(WINDOW_SECTION, 'MessageFontBold', False);
		FMessageFontItalic := memIni.ReadBool(WINDOW_SECTION, 'MessageFontItalic', False);
		FMessageFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'MessageFontColor', DEFAULT_FONT_COLOR));
		FMessageBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'MessageBackColor', DEFAULT_WINDOW_COLOR));

		FEditorFontName := memIni.ReadString(WINDOW_SECTION, 'EditorFontName', DEFAULT_FONT_NAME);
		FEditorFontSize := memIni.ReadInteger(WINDOW_SECTION, 'EditorFontSize', DEFAULT_FONT_SIZE);
		FEditorFontBold := memIni.ReadBool(WINDOW_SECTION, 'EditorFontBold', False);
		FEditorFontItalic := memIni.ReadBool(WINDOW_SECTION, 'EditorFontItalic', False);
		FEditorFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'EditorFontColor', DEFAULT_FONT_COLOR));
		FEditorBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'EditorBackColor', DEFAULT_WINDOW_COLOR));

		FBrowserTabFontName := memIni.ReadString(WINDOW_SECTION, 'BrowserTabFontName', DEFAULT_TAB_FONT_NAME);
		FBrowserTabFontSize := memIni.ReadInteger(WINDOW_SECTION, 'BrowserTabFontSize', DEFAULT_TAB_FONT_SIZE);
		FBrowserTabFontBold := memIni.ReadBool(WINDOW_SECTION, 'BrowserTabFontBold', False);
		FBrowserTabFontItalic := memIni.ReadBool(WINDOW_SECTION, 'BrowserTabFontItalic', False);

		FHintFontName := memIni.ReadString(WINDOW_SECTION, 'HintFontName', Screen.HintFont.Name);
		FHintFontSize := memIni.ReadInteger(WINDOW_SECTION, 'HintFontSize', Screen.HintFont.Size);
		//FHintFontBold := memIni.ReadBool(WINDOW_SECTION, 'HintFontBold', False);
		//FHintFontItalic := memIni.ReadBool(WINDOW_SECTION, 'HintFontItalic', False);
		FHintFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'HintFontColor', DEFAULT_FONT_COLOR));
		FHintBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'HintBackColor', 'clInfoBk'));
    end;
end;
{
\brief  入力履歴読み込み（検索＋メール欄＋名前）
\param  memIni  iniファイル
}
procedure TSetting.ReadInputHisotrys(memIni: TMemIniFile);
const
    SECTIONS : array[0..2] of string = ('Name', 'Mail', 'SelectText');
var
	wkList : TStringList;
    wkStr : string;
    i, j : Integer;
    listArray : array[0..2] of TStringList;
begin
    if (memIni <> nil) then begin
        listArray[0] := FNameList;
        listArray[1] := FMailList;
        listArray[2] := FSelectTextList;
        wkList := TStringList.Create;
        try
            for i := 0 to High(listArray) do begin
                memIni.ReadSection(SECTIONS[i], wkList);
                for j := 0 to wkList.Count -1 do begin
                    wkStr := memIni.ReadString(SECTIONS[i], wkList[j], '');
                    if (wkStr <> '') and
                        (listArray[i].IndexOf(wkStr) = -1) then begin
                        listArray[i].Add(wkStr);
                    end;
                end;
            end;
        finally
            wkList.Free;
        end;
    end;
end;
{
\breif  リストカラム幅読み込み
\param  memIni  iniファイル
}
procedure TSetting.ReadListColumnWidth(memIni: TMemIniFile);
const
    SECTIONS : array[0..2] of string =
        ('BBSColumnWidth', 'CategoryColumnWidth', 'BoardColumnWidth');
	DEFAULT_BBS_WIDTH: array[0..0] of Integer = (140);
	DEFAULT_CATEGORY_WIDTH: array[0..2] of Integer = (150, 80, 130);
	DEFAULT_BOARD_WIDTH: array[0..10] of Integer = (350, 60, 60, 60, 60, 60, 80, 130, 130, 130, 60);
	MAX_WIDTH: Integer = 2000;
var
	wkList : TStringList;
    i : Integer;
begin
    if (memIni <> nil) then begin
		// リストカラム幅
		wkList := TStringList.Create;
		try
			memIni.ReadSection(SECTIONS[0], wkList);
			if Length(FBBSColumnWidth) <> wkList.Count then begin
				memIni.EraseSection(SECTIONS[0]);
			end;
			for i := 0 to High(FBBSColumnWidth) do begin
				BBSColumnWidth[i] := memIni.ReadInteger(SECTIONS[0],
                     'ID' + IntToStr(i), DEFAULT_BBS_WIDTH[i]);
				if BBSColumnWidth[i] > MAX_WIDTH then
					BBSColumnWidth[i] := DEFAULT_BBS_WIDTH[i];
			end;
			memIni.ReadSection(SECTIONS[1], wkList);
			if Length(FCategoryColumnWidth) <> wkList.Count then begin
				memIni.EraseSection(SECTIONS[1]);
			end;
			for i := 0 to High(FCategoryColumnWidth) do begin
				CategoryColumnWidth[i] := memIni.ReadInteger(SECTIONS[1],
                     'ID' + IntToStr(i), DEFAULT_CATEGORY_WIDTH[i]);
				if CategoryColumnWidth[i] > MAX_WIDTH then
					CategoryColumnWidth[i] := DEFAULT_CATEGORY_WIDTH[i];
			end;
			memIni.ReadSection(SECTIONS[2], wkList);
			if Length(FBoardColumnWidth) <> wkList.Count then begin
				memIni.EraseSection(SECTIONS[2]);
			end;
			for i := 0 to High(FBoardColumnWidth) do begin
				BoardColumnWidth[i] := memIni.ReadInteger(SECTIONS[2],
                     'ID' + IntToStr(i), DEFAULT_BOARD_WIDTH[i]);
				if BoardColumnWidth[i] > MAX_WIDTH then
					BoardColumnWidth[i] := DEFAULT_BOARD_WIDTH[i];
			end;
		finally
			wkList.Free;
		end;
    end;
end;
//! カテゴリリストカラム順序読み込み
procedure TSetting.ReadOrdColumn(memIni: TMemIniFile);
var
	wkList : TStringList;
    wkStr : string;
    i, id, code : Integer;
begin
    if (memIni <> nil) then begin
		wkList := TStringList.Create;
		try
			memIni.ReadSection( 'BBSColumnOrder', wkList );
			for i := 0 to wkList.Count - 1 do begin
				wkStr := memIni.ReadString( 'BBSColumnOrder', 'ID' + IntToStr( i ), '' );
				Val( wkStr, id, code );
				if code = 0 then
					FBBSColumnOrder.Add( TGikoBBSColumnID( id ) );
			end;
			if FBBSColumnOrder.Count = 0 then begin
				// 設定が無いので作成
				for i := 0 to Integer( High( TGikoBBSColumnID ) ) do
					FBBSColumnOrder.Add( TGikoBBSColumnID( i ) );
			end;

			memIni.ReadSection( 'CategoryColumnOrder', wkList );
			for i := 0 to wkList.Count - 1 do begin
				wkStr := memIni.ReadString( 'CategoryColumnOrder', 'ID' + IntToStr( i ), '' );
				Val( wkStr, id, code );
				if code = 0 then
					FCategoryColumnOrder.Add( TGikoCategoryColumnID( id ) );
			end;
			if FCategoryColumnOrder.Count = 0 then begin
				// 設定が無いので作成
				for i := 0 to Integer( High( TGikoCategoryColumnID ) ) do
					FCategoryColumnOrder.Add( TGikoCategoryColumnID( i ) );
			end;

			memIni.ReadSection( 'BoardColumnOrder', wkList );
			for i := 0 to wkList.Count - 1 do begin
				wkStr := memIni.ReadString( 'BoardColumnOrder', 'ID' + IntToStr( i ), '' );
				Val( wkStr, id, code );
				if code = 0 then
					FBoardColumnOrder.Add( TGikoBoardColumnID( id ) );
			end;
			if FBoardColumnOrder.Count = 0 then begin
				// 設定が無いので作成
				for i := 0 to Integer( High( TGikoBoardColumnID ) ) do begin
					// 勢いのカラムはデフォルトで非表示にする
					if ( i <> Ord(gbcVigor) ) then begin
						FBoardColumnOrder.Add( TGikoBoardColumnID( i ) );
					end;
				end;
			end;
		finally
			wkList.Free;
		end;
    end;
end;

function TSetting.GetCSSFileName: string;
begin
    Result := FSkinFiles.FileName;
end;
function TSetting.GetBoukenCookie(AHostName: String): String;
var
    i : Integer;
begin
    for i := 0 to FBoukenCookieList.Count - 1 do begin
        if ( AnsiPos(FBoukenCookieList.Names[i], AHostName) > 0 ) then begin
            Result := FBoukenCookieList.Values[FBoukenCookieList.Names[i]];
            Break;
        end;
    end;
end;
procedure TSetting.SetBoukenCookie(ACookieValue, AHostName: String);
var
    i : Integer;
begin
    for i := 0 to FBoukenCookieList.Count - 1 do begin
        if ( FBoukenCookieList.Names[i] = AHostName ) then begin
            FBoukenCookieList[i] := AHostName + '=' + ACookieValue;
            Break;
        end;
    end;
    if ( i = FBoukenCookieList.Count ) then begin
        FBoukenCookieList.Add(AHostName + '=' + ACookieValue);
    end;
end;
procedure TSetting.GetBouken(AHostName: String; var Domain:String; var Cookie:String);
var
    i : Integer;
begin
    Cookie := '';
    for i := 0 to FBoukenCookieList.Count - 1 do begin
        if ( AnsiPos(FBoukenCookieList.Names[i], AHostName) > 0 ) then begin
            Domain := FBoukenCookieList.Names[i];
            Cookie := FBoukenCookieList.Values[FBoukenCookieList.Names[i]];
            Break;
        end;
    end;
end;

procedure TSetting.GetDefaultIPv4Domain(dest: TStrings);
var
	i: Integer;
begin
  dest.Clear;
	for i := Low(DEFAULT_IPV4_DOMAIN) to High(DEFAULT_IPV4_DOMAIN) do
		dest.Add(DEFAULT_IPV4_DOMAIN[i]);
end;

end.

