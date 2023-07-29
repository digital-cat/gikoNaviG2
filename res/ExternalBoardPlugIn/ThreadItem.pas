unit ThreadItem;

{
	ExternalBoardPlugIn ThreadItem
	スレッド情報を保持する TThreadItem クラス
}

interface

uses
	Windows, SysUtils,
	PlugInMain;

type
	// スレ一覧の上げ下げフラグ
	TThreadAgeSage = (tasNone, tasAge, tasSage, tasNew, tasArch, tasNull);

	// TThreadItem のプロパティ設定／取得 ID
	TThreadItemProperty = (
		tipContext,							// : DWORD			// 自由に設定していい値
		tipNo,									// : Integer		// 番号
		tipFileName,						// : string			// スレッドファイル名
		tipTitle,								// : string			// スレッドタイトル
		tipRoundDate,						// : TDateTime	// スレッドを取得した日時（巡回日時）
		tipLastModified,				// : TDateTime	// スレッドが更新されている日時（サーバ側日時）
		tipCount,								// : Integer		// スレッドカウント（ローカル）
		tipAllResCount,					// : Integer		// スレッドカウント（サーバ）
		tipNewResCount,					// : Integer		// スレッド新着数
		tipSize,								// : Integer		// スレッドサイズ
		tipRound,								// : Boolean		// 巡回フラグ
		tipRoundName,						// : string			// 巡回名
		tipIsLogFile,						// : Boolean		// ログ存在フラグ
		tipKokomade,						// : Integer		// ココまで読んだ番号
		tipNewReceive,					// : Integer		// ココから新規受信
		tipNewArrival,					// : Boolean		// 新着
		tipUnRead,							// : Boolean		// 未読フラグ
		tipScrollTop,						// : Integer		// スクロール位置
		tipDownloadHost,				// : string			// 今のホストと違う場合のホスト
		tipAgeSage,							// : TThreadAgeSage	// アイテムの上げ下げ
		tipURL,									// : string			// スレッドをブラウザで表示する際の URL
		tipFilePath,							// : string			// このスレが保存されているパス
		tipJumpAddress							// : Integer		// JUMP先レス番号
	);



	// =========================================================================
	// TThreadItem クラスに関する API
	// =========================================================================

	// *************************************************************************
	// ThreadItemGetLong
	// TThreadItem クラスのプロパティを取得する
	// *************************************************************************
	TThreadItemGetLong = function(
		instance		: DWORD;
		propertyID	: TThreadItemProperty
	) : DWORD; stdcall;

	// *************************************************************************
	// ThreadItemSetLong
	// TThreadItem クラスのプロパティを設定する
	// *************************************************************************
	TThreadItemSetLong = procedure(
		instanc			: DWORD;
		propertyID	: TThreadItemProperty;
		param : DWORD
	); stdcall;

	// *************************************************************************
	// ThreadItemGetDouble
	// TThreadItem クラスのプロパティを取得する
	// *************************************************************************
	TThreadItemGetDouble = function(
		instance		: DWORD;
		propertyID	: TThreadItemProperty
	) : Double; stdcall;

	// *************************************************************************
	// ThreadItemSetDouble
	// TThreadItem クラスのプロパティを設定する
	// *************************************************************************
	TThreadItemSetDouble = procedure(
		instance		: DWORD;
		propertyID	: TThreadItemProperty;
		param				: Double
	); stdcall;

	// *************************************************************************
	// ThreadItemDat2HTML
	// TThreadItem クラスを元に２ちゃんねるの dat 形式 1 行を HTML に変換する
	// *************************************************************************
	TThreadItemDat2HTML = function(
		inInstance	: DWORD;		// ThreadItem のインスタンス
		inDatRes		: PChar;		// 名前<>メール<>日付ID<>本文<> で構成されたテキスト
		inResNo			: DWORD;		// レス番号
		inIsNew			: Boolean		// 新着レスなら True
	) : PChar; stdcall;				// 整形された HTML

	// *************************************************************************
	// ThreadItemGetHeader
	// TThreadItem クラスを元にスレッドのヘッダを取得する
	// *************************************************************************
	TThreadItemGetHeader = function(
		inInstance				: DWORD;			// ThreadItem のインスタンス
		inOptionalHeader	: PChar = nil	// 追加のヘッダ
	) : PChar; stdcall;								// 整形された HTML

	// *************************************************************************
	// ThreadItemGetFooter
	// TThreadItem クラスを元にスレッドのフッタを取得する
	// *************************************************************************
	TThreadItemGetFooter = function(
		inInstance				: DWORD;			// ThreadItem のインスタンス
		inOptionalFooter	: PChar = nil	// 追加のフッタ
	) : PChar; stdcall;								// 整形された HTML

	// *************************************************************************
	// ThreadItemWork
	// ダウンロードの進歩状況をプログラム本体に伝える
	// *************************************************************************
	TThreadItemWork = procedure(
		inInstance	: DWORD;			// ThreadItem のインスタンス
		inWorkCount	: Integer			// 現在の進歩状況(カウント)
	); stdcall;

	// *************************************************************************
	// ThreadItemWorkBegin
	// ダウンロードが始まったことをプログラム本体に伝える
	// *************************************************************************
	TThreadItemWorkBegin = procedure(
		inInstance			: DWORD;	// ThreadItem のインスタンス
		inWorkCountMax	: Integer	// 通信の終わりを示すカウント
	); stdcall;

	// *************************************************************************
	// ThreadItemWorkEnd
	// ダウンロードが終わったことをプログラム本体に伝える
	// *************************************************************************
	TThreadItemWorkEnd = procedure(
		inInstance	: DWORD				// ThreadItem のインスタンス
	); stdcall;



	// =========================================================================
	// TThreadItem クラスに関するイベント
	// =========================================================================

	// *************************************************************************
	// TThreadItem が生成された
	// *************************************************************************
	TThreadItemOnCreateEvent = procedure(
		instance : DWORD
	);

	// *************************************************************************
	// TThreadItem が破棄された
	// *************************************************************************
	TThreadItemOnDisposeEvent = procedure(
		instance : DWORD
	);

	// *************************************************************************
	// ダウンロードを指示された
	// *************************************************************************
	TThreadItemOnDownloadEvent = function : TDownloadState of object;

	// *************************************************************************
	// 書き込みを指示された
	// *************************************************************************
	TThreadItemOnWriteEvent = function(
		inName		: string;					// 名前(ハンドル)
		inMail		: string;					// メールアドレス
		inMessage	: string					// 本文
	) : TDownloadState of object;	// 書き込みが成功したかどうか

	// *************************************************************************
	// レス番号 inNo に対する html を要求された
	// *************************************************************************
	TThreadItemOnGetResEvent = function(
		inNo				: Integer
	) : string of object;

	// *************************************************************************
	// レス番号 inNo に対する dat を要求された
	// *************************************************************************
	TThreadItemOnGetDatEvent = function(
		inNo				: Integer
	) : string of object;

	// *************************************************************************
	// スレッドのヘッダ html を要求された
	// *************************************************************************
	TThreadItemOnGetHeaderEvent = function(
		inOptionalHeader	: string	// 追加のヘッダ
	) : string of object;					// 整形された HTML

	// *************************************************************************
	// スレッドのフッタ html を要求された
	// *************************************************************************
	TThreadItemOnGetFooterEvent = function(
		inOptionalFooter	: string	// 追加のフッタ
	) : string of object;					// 整形された HTML

	// *************************************************************************
	// この ThreadItem が属する板の URL を要求された
	// *************************************************************************
	TThreadItemOnGetBoardURLEvent = function : string of object;	// 板の URL




	// =========================================================================
	// TThreadItem クラス
	// =========================================================================
	TThreadItem = class(TObject)
	private
		// ThreadItem のインスタンス
		FInstance				: DWORD;

 		// ダウンロードを指示された
 		FOnDownload			: TThreadItemOnDownloadEvent;
		// 書き込みを指示された
		FOnWrite				: TThreadItemOnWriteEvent;
		// レス番号 n に対する html を要求された
		FOnGetRes				: TThreadItemOnGetResEvent;
		// レス番号 n に対する dat を要求された
		FOnGetDat				: TThreadItemOnGetDatEvent;
		// スレッドのヘッダ html を要求された
		FOnGetHeader		: TThreadItemOnGetHeaderEvent;
		// スレッドのフッタ html を要求された
		FOnGetFooter		: TThreadItemOnGetFooterEvent;
		// この ThreadItem が属する板の URL を要求された
		FOnGetBoardURL	: TThreadItemOnGetBoardURLEvent;

	public
		// コンストラクタ
		constructor Create( inInstance : DWORD );
		// レスの HTML 整形をプログラム本体に任せる
		function	Dat2HTML( inDatRes : string; inNo : Integer; inIsNew : Boolean ) : string; overload;
		// レスの HTML 整形をプログラム本体に任せる(省略形)
		function	Dat2HTML( inDatRes : string; inNo : Integer ) : string; overload;
		// ヘッダの HTML 整形をプログラム本体に任せる
		function	InternalHeader( inOptionalHeader : string = '' ) : string;
		// フッタの HTML 整形をプログラム本体に任せる
		function	InternalFooter( inOptionalFooter : string = '' ) : string;
		// ダウンロードの進歩状況をプログラム本体に伝える
		procedure	Work( inWorkCount : Integer );
		// ダウンロードが始まったことをプログラム本体に伝える
		procedure	WorkBegin( inWorkCountMax : Integer );
		// ダウンロードが終わったことをプログラム本体に伝える
		procedure	WorkEnd;

	private
		// ===== プロパティの管理を統括するラッパ
		function	GetLong( propertyID : TThreadItemProperty ) : DWORD;
		procedure	SetLong( propertyID : TThreadItemProperty; param : DWORD );
		function	GetDouble( propertyID : TThreadItemProperty ) : Double;
		procedure	SetDouble( propertyID : TThreadItemProperty; param : Double );

		// ===== プロパティの取得／設定を末端に提供するラッパ
		function	GetNo : Integer;
		procedure	SetNo( param : Integer );
		function	GetFileName : string;
		procedure	SetFileName( param : string );
		function	GetTitle : string;
		procedure	SetTitle( param : string );
		function	GetRoundDate : TDateTime;
		procedure	SetRoundDate( param : TDateTime );
		function	GetLastModified : TDateTime;
		procedure	SetLastModified( param : TDateTime );
		function	GetCount : Integer;
		procedure	SetCount( param : Integer );
		function	GetAllResCount : Integer;
		procedure	SetAllResCount( param : Integer );
		function	GetNewResCount : Integer;
		procedure	SetNewResCount( param : Integer );
		function	GetSize : Integer;
		procedure	SetSize( param : Integer );
		function	GetRound : Boolean;
		procedure	SetRound( param : Boolean );
		function	GetRoundName : string;
		procedure	SetRoundName( param : string );
		function	GetIsLogFile : Boolean;
		procedure	SetIsLogFile( param : Boolean );
		function	GetKokomade : Integer;
		procedure	SetKokomade( param : Integer );
		function	GetNewReceive : Integer;
		procedure	SetNewReceive( param : Integer );
		function	GetNewArrival : Boolean;
		procedure	SetNewArrival( param : Boolean );
		function	GetUnRead : Boolean;
		procedure	SetUnRead( param : Boolean );
		function	GetScrollTop : Integer;
		procedure	SetScrollTop( param : Integer );
		function	GetDownloadHost : string;
		procedure	SetDownloadHost( param : string );
		function	GetAgeSage : TThreadAgeSage;
		procedure	SetAgeSage( param : TThreadAgeSage );
		function	GetURL : string;
		procedure	SetURL( param : string );
		function	GetFilePath : string;
		{procedure	SetFilePath( param : string );}
		procedure	SetJumpAddress( param : Integer );
		function	GetJumpAddress : Integer;
	protected
		property	Instance			: DWORD						read FInstance;

	public
		// ===== イベント
		property	OnDownload		: TThreadItemOnDownloadEvent		read FOnDownload write FOnDownload;
		property	OnWrite				: TThreadItemOnWriteEvent				read FOnWrite write FOnWrite;
		property	OnGetRes			: TThreadItemOnGetResEvent			read FOnGetRes write FOnGetRes;
        property	OnGetDat			: TThreadItemOnGetDatEvent			read FOnGetDat write FOnGetDat;
		property	OnGetHeader		: TThreadItemOnGetHeaderEvent		read FOnGetHeader write FOnGetHeader;
		property	OnGetFooter		: TThreadItemOnGetFooterEvent		read FOnGetFooter write FOnGetFooter;
		property	OnGetBoardURL	: TThreadItemOnGetBoardURLEvent	read FOnGetBoardURL write FOnGetBoardURL;

		// ===== ThreadItem に取得／設定可能なプロパティ
		// 番号
		property	No						: Integer					read GetNo write SetNo;
		// スレッドファイル名
		property	FileName			: string					read GetFileName write SetFileName;
		// スレッドタイトル
		property	Title					: string					read GetTitle write SetTitle;
		// スレッドを取得した日時（巡回日時）
		property	RoundDate			: TDateTime				read GetRoundDate write SetRoundDate;
		// スレッドが更新されている日時（サーバ側日時）
		property	LastModified	: TDateTime				read GetLastModified write SetLastModified;
		// スレッドカウント（ローカル）
		property	Count					: Integer					read GetCount write SetCount;
		// スレッドカウント（サーバ）
		property	AllResCount		: Integer					read GetAllResCount write SetAllResCount;
		// スレッド新着数
		property	NewResCount		: Integer					read GetNewResCount write SetNewResCount;
		// スレッドサイズ
		property	Size					: Integer					read GetSize write SetSize;
		// 巡回フラグ
		property	Round					: Boolean					read GetRound write SetRound;
		// 巡回名
		property	RoundName			: string					read GetRoundName write SetRoundName;
		// ログ存在フラグ
		property	IsLogFile			: Boolean					read GetIsLogFile write SetIsLogFile;
		// ココまで読んだ番号
		property	Kokomade			: Integer					read GetKokomade write SetKokomade;
		// ココから新規受信
		property	NewReceive		: Integer					read GetNewReceive write SetNewReceive;
		// 新着
		property	NewArrival		: Boolean					read GetNewArrival write SetNewArrival;
		// 未読フラグ
		property	UnRead				: Boolean					read GetUnRead write SetUnRead;
		// スクロール位置
		property	ScrollTop			: Integer					read GetScrollTop write SetScrollTop;
		// 今のホストと違う場合のホスト
		property	DownloadHost	: string					read GetDownloadHost write SetDownloadHost;
		// アイテムの上げ下げ
		property	AgeSage				: TThreadAgeSage	read GetAgeSage write SetAgeSage;
		// スレッドをブラウザで表示する際の URL
		property	URL						: string					read GetURL write SetURL;
		// このスレが保存されているパス
		property	FilePath			: string					read GetFilePath {write SetFilePath};
		// JUMP先レス番号
		property	JumpAddress		: Integer	read GetJumpAddress write SetJumpAddress;
	end;

var
	// ===== API のアドレス
	ThreadItemGetLong		: TThreadItemGetLong;
	ThreadItemSetLong		: TThreadItemSetLong;
	ThreadItemGetDouble	: TThreadItemGetDouble;
	ThreadItemSetDouble	: TThreadItemSetDouble;
	ThreadItemDat2HTML	: TThreadItemDat2HTML;
	ThreadItemGetHeader	: TThreadItemGetHeader;
	ThreadItemGetFooter	: TThreadItemGetFooter;
	ThreadItemWork			: TThreadItemWork;
	ThreadItemWorkBegin	: TThreadItemWorkBegin;
	ThreadItemWorkEnd		: TThreadItemWorkEnd;
	// ===== イベントハンドラ
	ThreadItemOnCreate	: TThreadItemOnCreateEvent;
	ThreadItemOnDispose	: TThreadItemOnDisposeEvent;

// ===== TThreadItem クラスを管理する関数
procedure LoadInternalThreadItemAPI(
	inModule : HMODULE
);
procedure ThreadItemOnCreateOfTThreadItem(
	inInstance : DWORD
);
procedure ThreadItemOnDisposeOfTThreadItem(
	inInstance : DWORD
);

implementation

// *************************************************************************
// TThreadItem のコンストラクタ
// *************************************************************************
constructor TThreadItem.Create(
	inInstance : DWORD											// インスタンス
);
begin

	inherited Create;
	FInstance 		:= inInstance;
	OnDownload		:= nil;
	OnWrite				:= nil;
	OnGetRes			:= nil;
    OnGetDat			:= nil;
	OnGetHeader		:= nil;
	OnGetFooter		:= nil;
	OnGetBoardURL	:= nil;

end;

// *************************************************************************
// レスの HTML 整形をプログラム本体に任せる
// *************************************************************************
function	TThreadItem.Dat2HTML(
	inDatRes	: string;											// 名前<>メール<>日付ID<>本文<> で構成されたテキスト
	inNo			: Integer;										// レス番号
	inIsNew		: Boolean											// 新着レスなら True
) : string;																// 整形された HTML
var
	tmp				: PChar;
begin

	tmp			:= ThreadItemDat2HTML( FInstance, PChar( inDatRes ), inNo, inIsNew );
	Result	:= string( tmp );
	DisposeResultString( tmp );

end;

// *************************************************************************
// レスの HTML 整形をプログラム本体に任せる(省略形)
// *************************************************************************
function	TThreadItem.Dat2HTML(
	inDatRes	: string;											// 名前<>メール<>日付ID<>本文<> で構成されたテキスト
	inNo			: Integer											// レス番号
) : string;																// 整形された HTML
begin

	Result := Dat2HTML( inDatRes, inNo, inNo >= NewReceive );

end;

// *************************************************************************
// ヘッダの HTML 整形をプログラム本体に任せる
// *************************************************************************
function	TThreadItem.InternalHeader(
	inOptionalHeader	: string = ''					// 追加のヘッダ
) : string;																// 整形された HTML
var
	tmp								: PChar;
begin

	tmp			:= ThreadItemGetHeader( FInstance, PChar( inOptionalHeader ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );

end;

// *************************************************************************
// フッタの HTML 整形をプログラム本体に任せる
// *************************************************************************
function	TThreadItem.InternalFooter(
	inOptionalFooter	: string = ''					// 追加のフッタ
) : string;																// 整形された HTML
var
	tmp								: PChar;
begin

	tmp			:= ThreadItemGetFooter( FInstance, PChar( inOptionalFooter ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );

end;

// *************************************************************************
// ダウンロードの進歩状況をプログラム本体に伝える
// *************************************************************************
procedure	TThreadItem.Work(
	inWorkCount : Integer			// 現在の進歩状況(カウント)
);
begin

	ThreadItemWork( FInstance, inWorkCount );

end;

// *************************************************************************
// ダウンロードが始まったことをプログラム本体に伝える
// *************************************************************************
procedure	TThreadItem.WorkBegin(
	inWorkCountMax : Integer	// 通信の終わりを示すカウント
);
begin

	ThreadItemWorkBegin( FInstance, inWorkCountMax );

end;

// *************************************************************************
// ダウンロードが終わったことをプログラム本体に伝える
// *************************************************************************
procedure	TThreadItem.WorkEnd;
begin

	ThreadItemWorkEnd( FInstance );

end;



// =========================================================================
// TThreadItem のプロパティの管理を統括するラッパ
// =========================================================================
function	TThreadItem.GetLong( propertyID : TThreadItemProperty ) : DWORD;
begin
	Result := ThreadItemGetLong( FInstance, propertyID );
end;

procedure	TThreadItem.SetLong( propertyID : TThreadItemProperty; param : DWORD );
begin
	ThreadItemSetLong( FInstance, propertyID, param );
end;

function	TThreadItem.GetDouble( propertyID : TThreadItemProperty ) : Double;
begin
	Result := ThreadItemGetDouble( FInstance, propertyID );
end;

procedure	TThreadItem.SetDouble( propertyID : TThreadItemProperty; param : Double );
begin
	ThreadItemSetDouble( FInstance, propertyID, param );
end;



// =========================================================================
// ↓ここから↓
// TThreadItem のプロパティの取得／設定を末端に提供するラッパ
// =========================================================================
function	TThreadItem.GetNo : Integer;
begin
	Result := GetLong( tipNo );
end;

procedure	TThreadItem.SetNo( param : Integer );
begin
	SetLong( tipNo, param );
end;

function	TThreadItem.GetFileName : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( tipFileName ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TThreadItem.SetFileName( param : string );
begin
	SetLong( tipFileName, DWORD( PChar( param ) ) );
end;

function	TThreadItem.GetTitle : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( tipTitle ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TThreadItem.SetTitle( param : string );
begin
	SetLong( tipTitle, DWORD( PChar( param ) ) );
end;

function	TThreadItem.GetRoundDate : TDateTime;
begin
	Result := GetDouble( tipRoundDate );
end;

procedure	TThreadItem.SetRoundDate( param : TDateTime );
begin
	SetDouble( tipRoundDate, param );
end;

function	TThreadItem.GetLastModified : TDateTime;
begin
	Result := GetDouble( tipLastModified );
end;

procedure	TThreadItem.SetLastModified( param : TDateTime );
begin
	SetDouble( tipLastModified, param );
end;

function	TThreadItem.GetCount : Integer;
begin
	Result := GetLong( tipCount );
end;

procedure	TThreadItem.SetCount( param : Integer );
begin
	SetLong( tipCount, param );
end;

function	TThreadItem.GetAllResCount : Integer;
begin
	Result := GetLong( tipAllResCount );
end;

procedure	TThreadItem.SetAllResCount( param : Integer );
begin
	SetLong( tipAllResCount, param );
end;

function	TThreadItem.GetNewResCount : Integer;
begin
	Result := GetLong( tipNewResCount );
end;

procedure	TThreadItem.SetNewResCount( param : Integer );
begin
	SetLong( tipNewResCount, param );
end;

function	TThreadItem.GetSize : Integer;
begin
	Result := GetLong( tipSize );
end;

procedure	TThreadItem.SetSize( param : Integer );
begin
	SetLong( tipSize, param );
end;

function	TThreadItem.GetRound : Boolean;
begin
	Result := Boolean( GetLong( tipRound ) );
end;

procedure	TThreadItem.SetRound( param : Boolean );
begin
	SetLong( tipRound, DWORD( param ) );
end;

function	TThreadItem.GetRoundName : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( tipRoundName ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TThreadItem.SetRoundName( param : string );
begin
	SetLong( tipRoundName, DWORD( PChar( param ) ) );
end;

function	TThreadItem.GetIsLogFile : Boolean;
begin
	Result := Boolean( GetLong( tipIsLogFile ) );
end;

procedure	TThreadItem.SetIsLogFile( param : Boolean );
begin
	SetLong( tipIsLogFile, DWORD( param ) );
end;

function	TThreadItem.GetKokomade : Integer;
begin
	Result := GetLong( tipKokomade );
end;

procedure	TThreadItem.SetKokomade( param : Integer );
begin
	SetLong( tipKokomade, param );
end;

function	TThreadItem.GetNewReceive : Integer;
begin
	Result := GetLong( tipNewReceive );
end;

procedure	TThreadItem.SetNewReceive( param : Integer );
begin
	SetLong( tipNewReceive, param );
end;

function	TThreadItem.GetNewArrival : Boolean;
begin
	Result := Boolean( GetLong( tipNewArrival ) );
end;

procedure	TThreadItem.SetNewArrival( param : Boolean );
begin
	SetLong( tipNewarrival, DWORD( param ) );
end;

function	TThreadItem.GetUnRead : Boolean;
begin
	Result := Boolean( GetLong( tipUnRead ) );
end;

procedure	TThreadItem.SetUnRead( param : Boolean );
begin
	SetLong( tipUnRead, DWORD( param ) );
end;

function	TThreadItem.GetScrollTop : Integer;
begin
	Result := GetLong( tipScrollTop );
end;

procedure	TThreadItem.SetScrollTop( param : Integer );
begin
	SetLong( tipScrollTop, param );
end;

function	TThreadItem.GetDownloadHost : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( tipDownloadHost ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TThreadItem.SetDownloadHost( param : string );
begin
	SetLong( tipDownloadHost, DWORD( PChar( param ) ) );
end;

function	TThreadItem.GetAgeSage : TThreadAgeSage;
begin
	Result := TThreadAgeSage( GetLong( tipAgeSage ) );
end;

procedure	TThreadItem.SetAgeSage( param : TThreadAgeSage );
begin
	SetLong( tipAgeSage, DWORD( param ) );
end;

function	TThreadItem.GetURL : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( tipURL ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TThreadItem.SetURL( param : string );
begin
	SetLong( tipURL, DWORD( PChar( param ) ) );
end;

function	TThreadItem.GetFilePath : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( tipFilePath ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;
function	TThreadItem.GetJumpAddress : Integer;
begin
	Result := GetLong( tipJumpAddress );
end;

procedure	TThreadItem.SetJumpAddress( param : Integer );
begin
	SetLong( tipJumpAddress, param );
end;
{
procedure	TThreadItem.SetFilePath( param : string );
begin
	SetLong( tipFilePath, DWORD( PChar( param ) ) );
end;
}// =========================================================================
// TThreadItem のプロパティの取得／設定を末端に提供するラッパ
// ↑ここまで↑
// =========================================================================



// =========================================================================
// TThreadItem クラスを管理する関数
// =========================================================================

// *************************************************************************
// TThreadItem が生成された場合のデフォルトの処置(TThreadItem を生成する)
// *************************************************************************
procedure ThreadItemOnCreateOfTThreadItem(
	inInstance : DWORD
);
var
	threadItem : TThreadItem;
begin

	threadItem := TThreadItem.Create( inInstance );
	ThreadItemSetLong( inInstance, tipContext, DWORD( threadItem ) );

end;

// *************************************************************************
// TThreadItem が破棄された場合のデフォルトの処置(TThreadItem を破棄する)
// *************************************************************************
procedure ThreadItemOnDisposeOfTThreadItem(
	inInstance : DWORD
);
var
	threadItem : TThreadItem;
begin

	threadItem := TThreadItem( ThreadItemGetLong( inInstance, tipContext ) );
	threadItem.Free;

end;

// *************************************************************************
// PlugInSDK の TThreadItem に関する API を初期化
// *************************************************************************
procedure LoadInternalThreadItemAPI(
	inModule : HMODULE
);
begin

	// ===== インスタンスのデフォルトの取り扱いを TThreadItem にする
	ThreadItemOnCreate	:= ThreadItemOnCreateOfTThreadItem;
	ThreadItemOnDispose	:= ThreadItemOnDisposeOfTThreadItem;

	// ===== TThreadItem プロパティ取得設定関数
	ThreadItemGetLong := GetProcAddress( inModule, 'ThreadItemGetLong' );
	if not Assigned( ThreadItemGetLong ) then
		System.ExitCode := 1;
	ThreadItemSetLong := GetProcAddress( inModule, 'ThreadItemSetLong' );
	if not Assigned( ThreadItemSetLong ) then
		System.ExitCode := 1;
	ThreadItemGetDouble := GetProcAddress( inModule, 'ThreadItemGetDouble' );
	if not Assigned( ThreadItemGetDouble ) then
		System.ExitCode := 1;
	ThreadItemSetDouble := GetProcAddress( inModule, 'ThreadItemSetDouble' );
	if not Assigned( ThreadItemSetDouble ) then
		System.ExitCode := 1;
	ThreadItemDat2HTML := GetProcAddress( inModule, 'ThreadItemDat2HTML' );
	if not Assigned( ThreadItemDat2HTML ) then
		System.ExitCode := 1;
	ThreadItemGetHeader := GetProcAddress( inModule, 'ThreadItemGetHeader' );
	if not Assigned( ThreadItemGetHeader ) then
		System.ExitCode := 1;
	ThreadItemGetFooter := GetProcAddress( inModule, 'ThreadItemGetFooter' );
	if not Assigned( ThreadItemGetFooter ) then
		System.ExitCode := 1;
	ThreadItemWork := GetProcAddress( inModule, 'ThreadItemWork' );
	if not Assigned( ThreadItemWork ) then
		System.ExitCode := 1;
	ThreadItemWorkBegin := GetProcAddress( inModule, 'ThreadItemWorkBegin' );
	if not Assigned( ThreadItemWorkBegin ) then
		System.ExitCode := 1;
	ThreadItemWorkEnd := GetProcAddress( inModule, 'ThreadItemWorkEnd' );
	if not Assigned( ThreadItemWorkEnd ) then
		System.ExitCode := 1;

end;



// =========================================================================
// TThreadItem クラスに関するイベント
// =========================================================================

// *************************************************************************
// TThreadItem が生成された
// *************************************************************************
procedure ThreadItemCreate(
	inInstance : DWORD
); stdcall;
begin

	try
		ThreadItemOnCreate( inInstance );
	except end;

end;

// *************************************************************************
// TThreadItem が破棄された
// *************************************************************************
procedure ThreadItemDispose(
	inInstance : DWORD
); stdcall;
begin

	try
		ThreadItemOnDispose( inInstance );
	except end;

end;

// *************************************************************************
// ダウンロードを指示された
// *************************************************************************
function ThreadItemOnDownload(
	inInstance	: DWORD					// ThreadItem のインスタンス
) : TDownloadState; stdcall;	// ダウンロードが成功したかどうか
var
	context			: Pointer;
	threadItem	: TThreadItem;
begin

	try
		repeat
			context := Pointer( ThreadItemGetLong( inInstance, tipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TThreadItem) then
				Break;

			threadItem := TThreadItem( context );
			if not Assigned( threadItem.OnDownload ) then
				Break;

			Result := threadItem.OnDownload;
			Exit;
		until True;
	except end;

	Result := dsError;

end;

// *************************************************************************
// 書き込みを指示された
// *************************************************************************
function	ThreadItemOnWrite(
	inInstance	: DWORD;				// ThreadItem のインスタンス
	inName			: PChar;				// 名前(ハンドル)
	inMail			: PChar;				// メールアドレス
	inMessage		: PChar					// 本文
) : TDownloadState; stdcall;	// 書き込みが成功したかどうか
var
	context			: Pointer;
	threadItem	: TThreadItem;
begin

	try
		repeat
			context := Pointer( ThreadItemGetLong( inInstance, tipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TThreadItem) then
				Break;

			threadItem := TThreadItem( context );
			if not Assigned( threadItem.OnWrite ) then
				Break;

			Result := threadItem.OnWrite( string( inName ), string( inMail ), string( inMessage ) );
			Exit;
		until True;
	except end;

	Result := dsError;

end;

// *************************************************************************
// レス番号 n に対する html を要求された
// *************************************************************************
function ThreadItemOnGetRes(
	inInstance	: DWORD;		// ThreadItem のインスタンス
	inNo				: DWORD			// 表示するレス番号
) : PChar; stdcall;				// 表示する HTML
var
	context			: Pointer;
	threadItem	: TThreadItem;
begin

	try
		repeat
			context := Pointer( ThreadItemGetLong( inInstance, tipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TThreadItem) then
				Break;

			threadItem := TThreadItem( context );
			if not Assigned( threadItem.OnGetRes ) then
				Break;

			Result := CreateResultString( threadItem.OnGetRes( inNo ) );
			Exit;
		until True;
	except end;

	Result := nil;

end;

// *************************************************************************
// レス番号 n に対する Dat を要求された
// *************************************************************************
function ThreadItemOnGetDat(
	inInstance	: DWORD;		// ThreadItem のインスタンス
	inNo				: DWORD			// 表示するレス番号
) : PChar; stdcall;				// ２ちゃんねるのDat形式
var
	context			: Pointer;
	threadItem	: TThreadItem;
begin

	try
		repeat
			context := Pointer( ThreadItemGetLong( inInstance, tipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TThreadItem) then
				Break;

			threadItem := TThreadItem( context );
			if not Assigned( threadItem.OnGetDat ) then
				Break;

			Result := CreateResultString( threadItem.OnGetDat( inNo ) );
			Exit;
		until True;
	except end;

	Result := nil;

end;

// *************************************************************************
// スレッドのヘッダ html を要求された
// *************************************************************************
function ThreadItemOnGetHeader(
	inInstance				: DWORD;	// ThreadItem のインスタンス
	inOptionalHeader	: PChar		// 追加のヘッダ
) : PChar; stdcall;						// 整形された HTML
var
	context						: Pointer;
	threadItem				: TThreadItem;
begin

	try
		repeat
			context := Pointer( ThreadItemGetLong( inInstance, tipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TThreadItem) then
				Break;

			threadItem := TThreadItem( context );
			if not Assigned( threadItem.OnGetHeader ) then
				Break;

			Result := CreateResultString( threadItem.OnGetHeader( string( inOptionalHeader ) ) );
			Exit;
		until True;
	except end;

	Result := ThreadItemGetHeader( inInstance, inOptionalHeader );

end;

// *************************************************************************
// スレッドのフッタ html を要求された
// *************************************************************************
function ThreadItemOnGetFooter(
	inInstance				: DWORD;	// ThreadItem のインスタンス
	inOptionalFooter	: PChar		// 追加のフッタ
) : PChar; stdcall;						// 整形された HTML
var
	context						: Pointer;
	threadItem				: TThreadItem;
begin

	try
		repeat
			context := Pointer( ThreadItemGetLong( inInstance, tipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TThreadItem) then
				Break;

			threadItem := TThreadItem( context );
			if not Assigned( threadItem.OnGetFooter ) then
				Break;

			Result := CreateResultString( threadItem.OnGetFooter( string( inOptionalFooter ) ) );
			Exit;
		until True;
	except end;

	Result := ThreadItemGetFooter( inInstance, inOptionalFooter );

end;

// *************************************************************************
// この ThreadItem が属する板の URL を要求された
// *************************************************************************
function ThreadItemOnGetBoardURL(
	inInstance	: DWORD	// ThreadItem のインスタンス
) : PChar; stdcall;	 	// 板の URL
var
	context						: Pointer;
	threadItem				: TThreadItem;
begin

	try
		repeat
			context := Pointer( ThreadItemGetLong( inInstance, tipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TThreadItem) then
				Break;

			threadItem := TThreadItem( context );
			if not Assigned( threadItem.OnGetBoardURL ) then
				Break;

			Result := CreateResultString( threadItem.OnGetBoardURL );
			Exit;
		until True;
	except end;

	Result := nil;

end;

exports
	ThreadItemCreate,
	ThreadItemDispose,
	ThreadItemOnDownload,
	ThreadItemOnWrite,
	ThreadItemOnGetRes,
    ThreadItemOnGetDat,
	ThreadItemOnGetHeader,
	ThreadItemOnGetFooter,
	ThreadItemOnGetBoardURL;

end.
