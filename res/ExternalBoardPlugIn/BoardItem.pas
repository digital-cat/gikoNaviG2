unit BoardItem;

{
	ExternalBoardPlugIn BoardItem
	板情報を保持する TBoardItem クラス
}

interface

uses
	Windows, SysUtils,
	PlugInMain, ThreadItem;

type
	// TBoardItem のプロパティ設定／取得 ID
	TBoardItemProperty = (
		bipContext,							// : DWORD				// 自由に設定していい値
		bipItems,								// : TThreadItem	// 板に繋がれているスレッド
		bipNo,									// : Integer			// 番号
		bipTitle,								// : string				// 板タイトル
		bipRoundDate,						// : TDateTime		// 板を取得した日時（巡回日時）
		bipLastModified,				// : TDateTime		// 板が更新されている日時（サーバ側日時）
		bipLastGetTime,					// : TDateTime		// スレッドまたはスレッド一覧を最後に更新した日時（サーバ側日時・書き込み時に使用する）
		bipRound,								// : Boolean			// 巡回予約
		bipRoundName,						// : string				// 巡回名
		bipIsLogFile,						// : Boolean			// ログ存在フラグ
		bipUnRead,							// : Integer			// スレッド未読数
		bipURL,									// : string				// 板をブラウザで表示する際の URL
		bipFilePath,							// : string				// この板が保存されているパス
		bipIs2ch							// : Boolean		//ホストが2chかどうか
	);

	// *************************************************************************
	// 各スレの情報を返却
	// *************************************************************************
	TBoardItemEnumThreadCallBack = function(
		inInstance	: DWORD;	// TBoardItem のインスタンス
		inURL				: PChar;	// スレッドの URL
		inTitle			: PChar;	// スレタイ
		inCount			: DWORD		// レスの数
	) : Boolean; stdcall;		// 列挙を続けるなら True



	// =========================================================================
	// TBoardItem クラスに関する API
	// =========================================================================

	// *************************************************************************
	// BoardItemGetItems
	// TBoardItem クラスに繋がれている TThreadItem クラスを取得する
	// *************************************************************************
	TBoardItemGetItems = function(
		inInstance	: DWORD;	// TBoardItem のインスタンス
		inIndex			: Integer	// 取得する TThreadItem のインデックス
	) : DWORD; stdcall;			// TThreadItem のインスタンス

	// *************************************************************************
	// BoardItemGetLong
	// TBoardItem クラスのプロパティを取得する
	// *************************************************************************
	TBoardItemGetLong = function(
		inInstance		: DWORD;							// TBoardItem のインスタンス
		inPropertyID	: TBoardItemProperty	// 取得するプロパティの種類
	) : DWORD; stdcall;										// 戻り値(意味は inPropertyID によって異なる)

	// *************************************************************************
	// BoardItemSetLong
	// TBoardItem クラスのプロパティを設定する
	// *************************************************************************
	TBoardItemSetLong = procedure(
		inInstance		: DWORD;							// TBoardItem のインスタンス
		inPropertyID	: TBoardItemProperty;	// 設定するプロパティの種類
		inParam : DWORD											// 設定する値(意味は inPropertyID によって異なる)
	); stdcall;

	// *************************************************************************
	// BoardItemGetDouble
	// TBoardItem クラスのプロパティを取得する
	// *************************************************************************
	TBoardItemGetDouble = function(
		inInstance		: DWORD;							// TBoardItem のインスタンス
	inPropertyID	: TBoardItemProperty	// 取得するプロパティの種類
	) : Double; stdcall;									// 戻り値(意味は inPropertyID によって異なる)

	// *************************************************************************
	// BoardItemSetDouble
	// TBoardItem クラスのプロパティを設定する
	// *************************************************************************
	TBoardItemSetDouble = procedure(
		inInstance		: DWORD;							// TBoardItem のインスタンス
		inPropertyID	: TBoardItemProperty;	// 設定するプロパティの種類
		inParam				: Double							// 設定する値(意味は inPropertyID によって異なる)
	); stdcall;

	// *************************************************************************
	// 板が保有するスレ一覧の列挙処理をプログラム本体に任せる
	// *************************************************************************
	TBoardItemEnumThread = procedure(
		inInstance		: DWORD;							// TBoardItem のインスタンス
		inCallBack		: TBoardItemEnumThreadCallBack;	// スレの情報を返却するルーチン
		inSubjectText	: PChar								// ファイル名,スレタイ(レス数) で構成される改行区切りテキスト
	); stdcall;

	// *************************************************************************
	// BoardItemWork
	// ダウンロードの進歩状況をプログラム本体に伝える
	// *************************************************************************
	TBoardItemWork = procedure(
		inInstance	: DWORD;			// TBoardItem のインスタンス
		inWorkCount	: DWORD				// 現在の進歩状況(カウント)
	); stdcall;

	// *************************************************************************
	// BoardItemWorkBegin
	// ダウンロードが始まったことをプログラム本体に伝える
	// *************************************************************************
	TBoardItemWorkBegin = procedure(
		inInstance			: DWORD;	// TBoardItem のインスタンス
		inWorkCountMax	: DWORD		// 通信の終わりを示すカウント
	); stdcall;

	// *************************************************************************
	// BoardItemWorkEnd
	// ダウンロードが終わったことをプログラム本体に伝える
	// *************************************************************************
	TBoardItemWorkEnd = procedure(
		inInstance	: DWORD				// TBoardItem のインスタンス
	); stdcall;



	// =========================================================================
	// TBoardItem クラスに関するイベント
	// =========================================================================

	// *************************************************************************
	// TBoardItem が生成された
	// *************************************************************************
	TBoardItemOnCreateEvent = procedure(
		instance : DWORD
	);

	// *************************************************************************
	// TBoardItem が破棄された
	// *************************************************************************
	TBoardItemOnDisposeEvent = procedure(
		instance : DWORD
	);

	// *************************************************************************
	// ダウンロードを指示された
	// *************************************************************************
	TBoardItemOnDownloadEvent = function : TDownloadState of object;

	// *************************************************************************
	// スレ立てを指示された
	// *************************************************************************
	TBoardItemOnCreateThreadEvent = function(
		inSubject	: string;					// スレタイ
		inName		: string;					// 名前(ハンドル)
		inMail		: string;					// メールアドレス
		inMessage	: string					// 本文
	) : TDownloadState of object;	// 書き込みが成功したかどうか

	// *************************************************************************
	// この板にいくつのスレがあるか要求された
	// *************************************************************************
	TBoardItemOnEnumThreadEvent = procedure(
		inCallBack : TBoardItemEnumThreadCallBack
	) of object;

	// *************************************************************************
	// ファイル名からスレッドの URL を要求された
	// *************************************************************************
	TBoardItemOnFileName2ThreadURLEvent = function(
		inFileName : string
	) : string of object;


	// =========================================================================
	// TBoardItem クラス
	// =========================================================================
	TBoardItem = class(TObject)
	private
		// クラスのインスタンス
		FInstance							: DWORD;

		// ダウンロードを指示された
		FOnDownload						: TBoardItemOnDownloadEvent;
		// スレ立てを指示された
		FOnCreateThread				: TBoardItemOnCreateThreadEvent;
		// この板にいくつのスレがあるか要求された
		FOnEnumThread					: TBoardItemOnEnumThreadEvent;
		// ファイル名からスレッドの URL を要求された
		FOnFileName2ThreadURL	: TBoardItemOnFileName2ThreadURLEvent;

	public
		// コンストラクタ
		constructor Create( inInstance : DWORD );

		// 板が保有するスレ一覧の列挙処理をプログラム本体に任せる
		procedure	EnumThread( inCallBack : TBoardItemEnumThreadCallBack; inSubjectText : string );
		// ダウンロードの進歩状況をプログラム本体に伝える
		procedure	Work( inWorkCount : Integer );
		// ダウンロードが始まったことをプログラム本体に伝える
		procedure	WorkBegin( inWorkCountMax : Integer );
		// ダウンロードが終わったことをプログラム本体に伝える
		procedure	WorkEnd;

	private
		// ===== プロパティの管理を統括するラッパ
		function	GetLong( propertyID : TBoardItemProperty ) : DWORD;
		procedure	SetLong( propertyID : TBoardItemProperty; param : DWORD );
		function	GetDouble( propertyID : TBoardItemProperty ) : Double;
		procedure	SetDouble( propertyID : TBoardItemProperty; param : Double );

		// ===== プロパティの取得／設定を末端に提供するラッパ
		function	GetItems( index : Integer ) : TThreadItem;
		function	GetNo : Integer;
		procedure	SetNo( param : Integer );
		function	GetTitle : string;
		procedure	SetTitle( param : string );
		function	GetRoundDate : TDateTime;
		procedure	SetRoundDate( param : TDateTime );
		function	GetLastModified : TDateTime;
		procedure	SetLastModified( param : TDateTime );
		function	GetLastGetTime : TDateTime;
		procedure	SetLastGetTime( param : TDateTime );
		function	GetRound : Boolean;
		procedure	SetRound( param : Boolean );
		function	GetRoundName : string;
		procedure	SetRoundName( param : string );
		function	GetIsLogFile : Boolean;
		procedure	SetIsLogFile( param : Boolean );
		function	GetUnRead : Integer;
		procedure	SetUnRead( param : Integer );
		function	GetURL : string;
		procedure	SetURL( param : string );
		function	GetFilePath : string;
		procedure	SetFilePath( param : string );
		function	GetIs2ch	: Boolean;
		procedure	SetIs2ch( param : Boolean );

	protected
		property	Instance			: DWORD						read FInstance;

	public
		// ===== イベント
		property	OnDownload			: TBoardItemOnDownloadEvent			read FOnDownload write FOnDownload;
		property	OnCreateThread	: TBoardItemOnCreateThreadEvent	read FOnCreateThread write FOnCreateThread;
		property	OnEnumThread		: TBoardItemOnEnumThreadEvent		read FOnEnumThread write FOnEnumThread;
		property	OnFileName2ThreadURL	: TBoardItemOnFileName2ThreadURLEvent	read FOnFileName2ThreadURL write FOnFileName2ThreadURL;

		// ===== ThreadItem に取得／設定可能なプロパティ
		// 板に繋がれているスレッド
		property	Items[index : Integer] : TThreadItem	read GetItems;
		// 番号
		property	No						: Integer					read GetNo write SetNo;
		// 板タイトル
		property	Title					: string					read GetTitle write SetTitle;
		// 板を取得した日時（巡回日時）
		property	RoundDate			: TDateTime				read GetRoundDate write SetRoundDate;
		// 板が更新されている日時（サーバ側日時）
		property	LastModified	: TDateTime				read GetLastModified write SetLastModified;
		// スレッドまたはスレッド一覧を最後に更新した日時（サーバ側日時・書き込み時に使用する）
		property	LastGetTime		: TDateTime				read GetLastGetTime write SetLastGetTime;
		// 巡回フラグ
		property	Round					: Boolean					read GetRound write SetRound;
		// 巡回名
		property	RoundName			: string					read GetRoundName write SetRoundName;
		// ログ存在フラグ
		property	IsLogFile			: Boolean					read GetIsLogFile write SetIsLogFile;
		// スレッド未読数
		property	UnRead				: Integer					read GetUnRead write SetUnRead;
		// 板をブラウザで表示する際の URL
		property	URL						: string					read GetURL write SetURL;
		// この板が保存されているパス
		property	FilePath			: string					read GetFilePath write SetFilePath;
		//ホストが2chかどうか
		property	Is2ch				: Boolean		read GetIs2ch write SetIs2ch;
	end;

var
	// ===== API のアドレス
	BoardItemGetItems	 	: TBoardItemGetItems;
	BoardItemGetLong	 	: TBoardItemGetLong;
	BoardItemSetLong	 	: TBoardItemSetLong;
	BoardItemGetDouble 	: TBoardItemGetDouble;
	BoardItemSetDouble	: TBoardItemSetDouble;
	BoardItemEnumThread	: TBoardItemEnumThread;
	BoardItemWork			 	: TBoardItemWork;
	BoardItemWorkBegin 	: TBoardItemWorkBegin;
	BoardItemWorkEnd	 	: TBoardItemWorkEnd;
	// ===== イベントハンドラ
	BoardItemOnCreate	 	: TBoardItemOnCreateEvent;
	BoardItemOnDispose 	: TBoardItemOnDisposeEvent;

// ===== TBoardItem クラスを管理する関数
procedure LoadInternalBoardItemAPI(
	inModule : HMODULE
);
procedure BoardItemOnCreateOfTBoardItem(
	inInstance : DWORD
);
procedure BoardItemOnDisposeOfTBoardItem(
	inInstance : DWORD
);

implementation

// *************************************************************************
// TBoardItem のコンストラクタ
// *************************************************************************
constructor TBoardItem.Create(
	inInstance : DWORD											// インスタンス
);
begin

	inherited Create;
	FInstance 						:= inInstance;
	OnDownload						:= nil;
	OnCreateThread				:= nil;
	OnEnumThread					:= nil;
	OnFileName2ThreadURL	:= nil;

end;

// *************************************************************************
// 板が保有するスレ一覧の列挙処理をプログラム本体に任せる
// *************************************************************************
procedure	TBoardItem.EnumThread(
	inCallBack		: TBoardItemEnumThreadCallBack;
	inSubjectText	: string	// ファイル名<>スレタイ で構成された改行区切りテキスト
);
begin

	BoardItemEnumThread( FInstance, inCallBack, PChar( inSubjectText ) );

end;

// *************************************************************************
// ダウンロードの進歩状況をプログラム本体に伝える
// *************************************************************************
procedure	TBoardItem.Work(
	inWorkCount : Integer			// 現在の進歩状況(カウント)
);
begin

	BoardItemWork( FInstance, inWorkCount );

end;

// *************************************************************************
// ダウンロードが始まったことをプログラム本体に伝える
// *************************************************************************
procedure	TBoardItem.WorkBegin(
	inWorkCountMax : Integer	// 通信の終わりを示すカウント
);
begin

	BoardItemWorkBegin( FInstance, inWorkCountMax );

end;

// *************************************************************************
// ダウンロードが終わったことをプログラム本体に伝える
// *************************************************************************
procedure	TBoardItem.WorkEnd;
begin

	BoardItemWorkEnd( FInstance );

end;



// =========================================================================
// TBoardItem のプロパティの管理を統括するラッパ
// =========================================================================
function	TBoardItem.GetLong( propertyID : TBoardItemProperty ) : DWORD;
begin
	Result := BoardItemGetLong( FInstance, propertyID );
end;

procedure	TBoardItem.SetLong( propertyID : TBoardItemProperty; param : DWORD );
begin
	BoardItemSetLong( FInstance, propertyID, param );
end;

function	TBoardItem.GetDouble( propertyID : TBoardItemProperty ) : Double;
begin
	Result := BoardItemGetDouble( FInstance, propertyID );
end;

procedure	TBoardItem.SetDouble( propertyID : TBoardItemProperty; param : Double );
begin
	BoardItemSetDouble( FInstance, propertyID, param );
end;



// =========================================================================
// ↓ここから↓
// TBoardItem のプロパティの取得／設定を末端に提供するラッパ
// =========================================================================
function	TBoardItem.GetItems(
	index : Integer
) : TThreadItem;
var
	tmp : DWORD;
begin
	tmp			:= BoardItemGetItems( FInstance, index );
	Result	:= TThreadItem( ThreadItemGetLong( tmp, tipContext ) );
end;

function	TBoardItem.GetNo : Integer;
begin
	Result := GetLong( bipNo );
end;

procedure	TBoardItem.SetNo( param : Integer );
begin
	SetLong( bipNo, param );
end;

function	TBoardItem.GetTitle : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( bipTitle ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TBoardItem.SetTitle( param : string );
begin
	SetLong( bipTitle, DWORD( PChar( param ) ) );
end;

function	TBoardItem.GetRoundDate : TDateTime;
begin
	Result := GetDouble( bipRoundDate );
end;

procedure	TBoardItem.SetRoundDate( param : TDateTime );
begin
	SetDouble( bipRoundDate, param );
end;

function	TBoardItem.GetLastModified : TDateTime;
begin
	Result := GetDouble( bipLastModified );
end;

procedure	TBoardItem.SetLastModified( param : TDateTime );
begin
	SetDouble( bipLastModified, param );
end;

function	TBoardItem.GetLastGetTime : TDateTime;
begin
	Result := GetDouble( bipLastGetTime );
end;

procedure	TBoardItem.SetLastGetTime( param : TDateTime );
begin
	SetDouble( bipLastGetTime, param );
end;

function	TBoardItem.GetRound : Boolean;
begin
	Result := Boolean( GetLong( bipRound ) );
end;

procedure	TBoardItem.SetRound( param : Boolean );
begin
	SetLong( bipRound, DWORD( param ) );
end;

function	TBoardItem.GetRoundName : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( bipRoundName ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TBoardItem.SetRoundName( param : string );
begin
	SetLong( bipRoundName, DWORD( PChar( param ) ) );
end;

function	TBoardItem.GetIsLogFile : Boolean;
begin
	Result := Boolean( GetLong( bipIsLogFile ) );
end;

procedure	TBoardItem.SetIsLogFile( param : Boolean );
begin
	SetLong( bipIsLogFile, DWORD( param ) );
end;

function	TBoardItem.GetUnRead : Integer;
begin
	Result := GetLong( bipUnRead );
end;

procedure	TBoardItem.SetUnRead( param : Integer );
begin
	SetLong( bipUnRead, param );
end;

function	TBoardItem.GetURL : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( bipURL ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TBoardItem.SetURL( param : string );
begin
	SetLong( bipURL, DWORD( PChar( param ) ) );
end;

function	TBoardItem.GetFilePath : string;
var
	tmp : PChar;
begin
	tmp			:= PChar( GetLong( bipFilePath ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );
end;

procedure	TBoardItem.SetFilePath( param : string );
begin
	SetLong( bipFilePath, DWORD( PChar( param ) ) );
end;

function	TBoardItem.GetIs2ch : Boolean;
begin
	Result := Boolean( GetLong( bipIs2ch ) );
end;

procedure	TBoardItem.SetIs2ch( param : Boolean );
begin
	SetLong( bipIs2ch, DWORD( param ) );
end;

// =========================================================================
// TBoardItem のプロパティの取得／設定を末端に提供するラッパ
// ↑ここまで↑
// =========================================================================




// =========================================================================
// TBoardItem クラスを管理する関数
// =========================================================================

// *************************************************************************
// TBoardItem が生成された場合のデフォルトの処置(TBoardItem を生成する)
// *************************************************************************
procedure BoardItemOnCreateOfTBoardItem(
	inInstance : DWORD
);
var
	boardItem : TBoardItem;
begin

	boardItem := TBoardItem.Create( inInstance );
	boardItemSetLong( inInstance, bipContext, DWORD( BoardItem ) );

end;

// *************************************************************************
// TBoardItem が破棄された場合のデフォルトの処置(TBoardItem を破棄する)
// *************************************************************************
procedure BoardItemOnDisposeOfTBoardItem(
	inInstance : DWORD
);
var
	boardItem : TBoardItem;
begin

	boardItem := TBoardItem( BoardItemGetLong( inInstance, bipContext ) );
	boardItem.Free;

end;

// *************************************************************************
// PlugInSDK の TBoardItem に関する API を初期化
// *************************************************************************
procedure LoadInternalBoardItemAPI(
	inModule : HMODULE
);
begin

	// ===== インスタンスのデフォルトの取り扱いを TBoardItem にする
	BoardItemOnCreate	:= BoardItemOnCreateOfTBoardItem;
	BoardItemOnDispose	:= BoardItemOnDisposeOfTBoardItem;

	// ===== TBoardItem プロパティ取得設定関数
	BoardItemGetItems := GetProcAddress( inModule, 'BoardItemGetItems' );
	if not Assigned( BoardItemGetItems ) then
		System.ExitCode := 1;
	BoardItemGetLong := GetProcAddress( inModule, 'BoardItemGetLong' );
	if not Assigned( BoardItemGetLong ) then
		System.ExitCode := 1;
	BoardItemSetLong := GetProcAddress( inModule, 'BoardItemSetLong' );
	if not Assigned( BoardItemSetLong ) then
		System.ExitCode := 1;
	BoardItemGetDouble := GetProcAddress( inModule, 'BoardItemGetDouble' );
	if not Assigned( BoardItemGetDouble ) then
		System.ExitCode := 1;
	BoardItemSetDouble := GetProcAddress( inModule, 'BoardItemSetDouble' );
	if not Assigned( BoardItemSetDouble ) then
		System.ExitCode := 1;
	BoardItemEnumThread := GetProcAddress( inModule, 'BoardItemEnumThread' );
	if not Assigned( BoardItemEnumThread ) then
		System.ExitCode := 1;
	BoardItemWork := GetProcAddress( inModule, 'BoardItemWork' );
	if not Assigned( BoardItemWork ) then
		System.ExitCode := 1;
	BoardItemWorkBegin := GetProcAddress( inModule, 'BoardItemWorkBegin' );
	if not Assigned( BoardItemWorkBegin ) then
		System.ExitCode := 1;
	BoardItemWorkEnd := GetProcAddress( inModule, 'BoardItemWorkEnd' );
	if not Assigned( BoardItemWorkEnd ) then
		System.ExitCode := 1;

end;



// =========================================================================
// TBoardItem クラスに関するイベント
// =========================================================================

// *************************************************************************
// TBoardItem が生成された
// *************************************************************************
procedure BoardItemCreate(
	inInstance : DWORD
); stdcall;
begin

	try
		BoardItemOnCreate( inInstance );
	except end;

end;

// *************************************************************************
// TBoardItem が破棄された
// *************************************************************************
procedure BoardItemDispose(
	inInstance : DWORD
); stdcall;
begin

	try
		BoardItemOnDispose( inInstance );
	except end;

end;

// *************************************************************************
// ダウンロードを指示された
// *************************************************************************
function BoardItemOnDownload(
	inInstance	: DWORD					// インスタンス
) : TDownloadState; stdcall;	// ダウンロードが成功したかどうか
var
	context			: Pointer;
	boardItem	: TBoardItem;
begin

	try
		repeat
			context := Pointer( BoardItemGetLong( inInstance, bipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TBoardItem) then
				Break;

			boardItem := TBoardItem( context );
			if not Assigned( boardItem.OnDownload ) then
				Break;

			Result := boardItem.OnDownload;
			Exit;
		until True;
	except end;

	Result := dsError;

end;

// *************************************************************************
// スレ立てを指示された
// *************************************************************************
function	BoardItemOnCreateThread(
	inInstance	: DWORD;				// BoardItem のインスタンス
	inSubject		: PChar;				// スレタイ
	inName			: PChar;				// 名前(ハンドル)
	inMail			: PChar;				// メールアドレス
	inMessage		: PChar					// 本文
) : TDownloadState; stdcall;	// 書き込みが成功したかどうか
var
	context			: Pointer;
	boardItem		: TBoardItem;
begin

	try
		repeat
			context := Pointer( BoardItemGetLong( inInstance, bipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TBoardItem) then
				Break;

			boardItem := TBoardItem( context );
			if not Assigned( boardItem.OnCreateThread ) then
				Break;

			Result := boardItem.OnCreateThread( string( inSubject ), string( inName ), string( inMail ), string( inMessage ) );
			Exit;
		until True;
	except end;

	Result := dsError;

end;

// *************************************************************************
// この板にいくつのスレがあるか要求された
// *************************************************************************
procedure BoardItemOnEnumThread(
	inInstance	: DWORD;												// インスタンス
	inCallBack	: TBoardItemEnumThreadCallBack	// 返却すべきコールバック
); stdcall;
var
	context			: Pointer;
	boardItem	: TBoardItem;
begin

	try
		repeat
			context := Pointer( BoardItemGetLong( inInstance, bipContext ) );
			if not Assigned( context ) then
				Break;

			if not Assigned( inCallBack ) then
				Break;

			if not (TObject( context ) is TBoardItem) then
				Break;

			boardItem := TBoardItem( context );
			if not Assigned( boardItem.OnEnumThread ) then
				Break;

			boardItem.OnEnumThread( inCallBack );
			Exit;
		until True;
	except end;

end;

// *************************************************************************
// ファイル名からスレッドの URL を要求された
// *************************************************************************
function BoardItemOnFileName2ThreadURL(
	inInstance	: DWORD;												// インスタンス
	inFileName	: PChar													// 元になるファイル名
) : PChar; stdcall;
var
	context			: Pointer;
	boardItem		: TBoardItem;
begin

	try
		repeat
			context := Pointer( BoardItemGetLong( inInstance, bipContext ) );
			if not Assigned( context ) then
				Break;

			if not (TObject( context ) is TBoardItem) then
				Break;

			boardItem := TBoardItem( context );
			if not Assigned( boardItem.OnFileName2ThreadURL ) then
				Break;

			Result := CreateResultString( boardItem.OnFileName2ThreadURL( string( inFileName ) ) );
			Exit;
		until True;
	except end;

	Result := nil;

end;

exports
	BoardItemCreate,
	BoardItemDispose,
	BoardItemOnDownload,
	BoardItemOnCreateThread,
	BoardItemOnEnumThread,
	BoardItemOnFileName2ThreadURL;

end.
