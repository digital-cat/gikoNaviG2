unit ExternalBoardManager;

interface

uses
	Windows, Classes, SysUtils,
	IdHTTP, IdComponent, IdGlobal, IdException,
	ExternalBoardPlugInMain, ExternalFilePath, ExternalThreadItem, ExternalBoardItem;

type
	// =========================================================================
	// プラグインを管理する TBoardPlugin クラス
	// =========================================================================
	TBoardPlugIn = class( TObject )
	private
		FFilePath						: string;		// プラグインを示すパス
		FModule							: HMODULE;	// プラグインのモジュールハンドル

		FLoad								: TOnLoad;
		FVersionInfo				: TOnVersionInfo;
		FAcceptURL					: TOnAcceptURL;
        FExtractBoardURL				: TOnExtractBoardURL;
		FPlugInMenu					: TOnPlugInMenu;

		FCreateThreadItem		: TThreadItemCreate;
		FDisposeThreadItem	: TThreadItemDispose;
		FDownloadThread			: TThreadItemOnDownload;
		FWriteThread				: TThreadItemOnWrite;
		FGetRes							: TThreadItemOnGetRes;
		FGetDat							: TThreadItemOnGetDat;
		FGetHeader					: TThreadItemOnGetHeader;
		FGetFooter					: TThreadItemOnGetFooter;
		FGetBoardURL				: TThreadItemOnGetBoardURL;

 		FCreateBoardItem		: TBoardItemCreate;
		FDisposeBoardItem		: TBoardItemDispose;
		FDownloadBoard			: TBoardItemOnDownload;
		FCreateThread				: TBoardItemOnCreateThread;
		FEnumThread					: TBoardItemOnEnumThread;
		FFileName2ThreadURL	: TBoardItemOnFileName2ThreadURL;

	public
		// コンストラクタ
		constructor	Create;
		// プラグインのパスを指定して作成
		constructor	CreateFromPath( inPath : string );
		// プラグイン名を指定して作成
		constructor	CreateFromName( inName : string );
		// モジュールハンドルを指定して作成
		constructor	CreateFromModule( inModule : HMODULE );
		// デストラクタ
		destructor	Destroy; override;

		// プラグインのパスを指定してロード
		procedure	LoadFromPath( inPath : string );
		// プラグイン名を指定してロード
		procedure	LoadFromName( inName : string );
		// モジュールハンドルを指定してロード
		procedure	LoadFromModule( inModule : HMODULE );

		//===== PlugInMain 関連
		// プラグインが(正しく)ロードされた
		procedure	Loaded;
		// バージョン情報
		procedure	VersionInfo(	var outAgent : string;
			var outMajor : DWORD; var outMinor : DWORD;
			var outRelease : string; var outRevision : DWORD );
		// 指定した URL をこのプラグインで受け付けるかどうか
		function	AcceptURL( inURL : string ) : TAcceptType;
        // URLから使えるBoardのURLを導き出す
        function	ExtractBoardURL( inURL : string ): string;
		// メニューハンドラ
		procedure	PlugInMenu( inHandle : HMENU );

		//===== TThreadItem 関連
		// TThreadItem が生成された
		procedure	CreateThreadItem( threadItem : DWORD );
		// TThreadItem が破棄された
		procedure	DisposeThreadItem( threadItem : DWORD );
		// ダウンロードを指示
		function	DownloadThread( threadItem : DWORD ) : TDownloadState;
		// 書き込みを指示
		function	WriteThread( threadItem : DWORD; inName : string; inMail : string; inMessage : string ) : TDownloadState;
		// レス番号 n に対する html を要求
		function	GetRes( threadItem : DWORD; inNo : DWORD ) : string;
		// レス番号 n に対する Dat を要求
		function	GetDat( threadItem : DWORD; inNo : DWORD ) : string;
		// スレッドのヘッダ html を要求
		function	GetHeader( threadItem : DWORD; inOptionalHeader : string ) : string;
		// スレッドのフッタ html を要求
		function	GetFooter( threadItem : DWORD; inOptionalFooter : string ) : string;
		// この ThreadItem が属する板の URL を要求
		function	GetBoardURL( threadItem : DWORD ) : string;

		//===== TBoardItem 関連
		// TBoard が生成された
		procedure	CreateBoardItem( boardItem : DWORD );
		// TBoardItem が破棄された
		procedure	DisposeBoardItem( boardItem : DWORD );
		// ダウンロードを指示
		function	DownloadBoard( boardItem : DWORD ) : TDownloadState;
		// スレ立てを指示
		function	CreateThread( boardItem : DWORD; inSubject : string; inName : string; inMail : string; inMessage : string ) : TDownloadState;
		// この板に保有しているスレを列挙
		procedure EnumThread( boardItem : DWORD; inCallBack : TBoardItemEnumThreadCallBack );
		// ファイル名からスレッドの URL を要求
		function	FileName2ThreadURL( boardItem : DWORD; inFileName : string ) : string;

	private
		procedure	LoadPlugInAPI;

	public
		property	FilePath	: string	read FFilePath;
		property	Module		: HMODULE	read FModule;
	end;

var
	OnWork				: TWorkEvent;
	OnWorkBegin		: TWorkBeginEvent;
	OnWorkEnd			: TWorkEndEvent;

	BoardPlugIns	: array of TBoardPlugIn;

procedure InitializeBoardPlugIns;

implementation

uses GikoSystem, BoardGroup;

// *************************************************************************
// BoardPlugin フォルダにあるプラグインを全てロード
// *************************************************************************
procedure InitializeBoardPlugIns;
var
	i, bound		: Integer;
	pluginNames	: TStringList;
begin

	pluginNames := TStringList.Create;
	try
		//GikoSys.GetFileList( GikoSys.Setting.GetBoardPlugInDir, '*', pluginNames, False, False );
        pluginNames.BeginUpdate;
		GikoSys.GetFileList( GikoSys.Setting.GetBoardPlugInDir, '*.dll', pluginNames, False );
        pluginNames.EndUpdate;
		SetLength( BoardPlugIns, pluginNames.Count );
        //
        SetLength( BoardGroups, pluginNames.Count + 1 );
		BoardGroups[0] := TBoardGroup.Create;
		BoardGroups[0].Sorted := true;
		BoardGroups[0].BoardPlugIn := nil;
		//
		bound := pluginNames.Count - 1;
		for i := 0 to bound do begin
			try
				BoardPlugIns[ i ] := TBoardPlugIn.CreateFromName( pluginNames.Strings[ i ] );
				BoardPlugIns[ i ].Loaded;
				BoardGroups[ i + 1 ] := TBoardGroup.Create;
                BoardGroups[ i + 1 ].Sorted := True;
				BoardGroups[ i + 1 ].BoardPlugIn := BoardPlugIns[ i ];
			except end;
		end;
	finally
		pluginNames.Free;
	end;

end;



// =========================================================================
// プラグインを管理する TBoardPlugin クラス
// =========================================================================

// *************************************************************************
// コンストラクタ
// *************************************************************************
constructor	TBoardPlugIn.Create;
begin

	inherited;

	FLoad								:= nil;
	FVersionInfo				:= nil;
	FAcceptURL					:= nil;
    FExtractBoardURL			:= nil;
	FPlugInMenu					:= nil;

	FCreateThreadItem		:= nil;
	FDisposeThreadItem	:= nil;
	FDownloadThread			:= nil;
	FWriteThread				:= nil;
	FGetRes							:= nil;
	FGetDat							:= nil;
	FGetHeader					:= nil;
	FGetFooter					:= nil;

	FCreateBoardItem		:= nil;
	FDisposeBoardItem		:= nil;
	FDownloadBoard			:= nil;
	FCreateThread				:= nil;
	FEnumThread					:= nil;
	FFileName2ThreadURL	:= nil;

end;

// *************************************************************************
// プラグインのパスを指定して作成
// *************************************************************************
constructor	TBoardPlugIn.CreateFromPath(
	inPath : string
);
begin

	Create;

	LoadFromPath( inPath );

end;

// *************************************************************************
// プラグイン名を指定して作成
// *************************************************************************
constructor	TBoardPlugIn.CreateFromName(
	inName : string
);
begin

	Create;

	LoadFromName( inName );

end;

// *************************************************************************
// モジュールハンドルを指定して作成
// *************************************************************************
constructor	TBoardPlugIn.CreateFromModule(
	inModule : HMODULE
);
begin

	inherited Create;

	LoadFromModule( inModule );

end;

// *************************************************************************
// デストラクタ
// *************************************************************************
destructor	TBoardPlugIn.Destroy;
begin

	FreeLibrary( FModule );

	inherited;

end;

// *************************************************************************
// プラグインのパスを指定してロード
// *************************************************************************
procedure TBoardPlugIn.LoadFromPath(
	inPath : string
);
begin

	FFilePath := inPath;
	if FileExists( inPath ) then
		FModule := LoadLibrary( PChar( inPath ) )
	else if FileExists( inPath + '.dll' ) then
		FModule := LoadLibrary( PChar( inPath + '.dll' ) );

	LoadPlugInAPI;

end;

// *************************************************************************
// プラグイン名を指定してロード
// *************************************************************************
procedure TBoardPlugIn.LoadFromName(
	inName : string
);
begin

	LoadFromPath( GikoSys.Setting.GetBoardPlugInDir + inName );

end;

// *************************************************************************
// モジュールハンドルを指定してロード
// *************************************************************************
procedure TBoardPlugIn.LoadFromModule(
	inModule	: HMODULE
);
var
	tmp				: array [0..MAX_PATH] of Char;
begin

	GetModuleFileName( inModule, tmp, SizeOf( tmp ) );
	FFilePath	:= tmp;
	FModule		:= inModule;

	LoadPlugInAPI;

end;

// *************************************************************************
// プラグインが(正しく)ロードされた
// *************************************************************************
procedure TBoardPlugIn.Loaded;
begin

	if Assigned( FLoad ) then
		FLoad( DWORD( Self ) );

end;

// *************************************************************************
// バージョン情報
// *************************************************************************
procedure TBoardPlugIn.VersionInfo(
	var outAgent		: string;		// バージョンを一切含まない純粋な名称
	var outMajor		: DWORD;		// メジャーバージョン
	var outMinor		: DWORD;		// マイナーバージョン
	var outRelease	: string;		// リリース段階名
	var outRevision	: DWORD			// リビジョンナンバー
);
var
	agent						: PChar;
	release					: PChar;
begin

	if Assigned( FVersionInfo ) then begin
		FVersionInfo( agent, outMajor, outMinor, release, outRevision );
		outAgent		:= string( agent );
		outRelease	:= string( release );
		DisposeResultString( agent );
		DisposeResultString( release );
	end;

end;

// *************************************************************************
// 指定した URL をこのプラグインで受け付けるかどうか
// *************************************************************************
function	TBoardPlugIn.AcceptURL(
	inURL : string
) : TAcceptType;
begin

	if Assigned( FAcceptURL ) then
		Result := FAcceptURL( PChar( inURL ) )
	else
		Result := atNoAccept;

end;
// *************************************************************************
// 指定した URL から使えるBoardのURLを導き出す
// *************************************************************************
function	TBoardPlugIn.ExtractBoardURL(
	inURL : string
) : string;
var
	URL : PChar;
//    tmp : string;
begin
    Result := inURL;
	if Assigned( FExtractBoardURL ) then begin
    	FExtractBoardURL( PChar(inURL), URL);
        Result := string(URL);
        DisposeResultString(URL);
    end;
end;
// *************************************************************************
// メニューハンドラ
// *************************************************************************
procedure TBoardPlugIn.PlugInMenu(
	inHandle : HMENU					// メニューハンドル
);
begin

	if Assigned( FPlugInMenu ) then
		FPlugInMenu( inHandle );

end;

// *************************************************************************
// TThreadItem が生成された
// *************************************************************************
procedure	TBoardPlugIn.CreateThreadItem(
	threadItem : DWORD	// ThreadItem のインスタンス
);
begin

	if Assigned( FCreateThreadItem ) then
		FCreateThreadItem( threadItem );

end;

// *************************************************************************
// TThreadItem が破棄された
// *************************************************************************
procedure	TBoardPlugIn.DisposeThreadItem(
	threadItem : DWORD	// ThreadItem のインスタンス
);
begin

	if Assigned( FDisposeThreadItem ) then
		FDisposeThreadItem( threadItem );

end;

// *************************************************************************
// ダウンロードを指示
// *************************************************************************
function	TBoardPlugIn.DownloadThread(
	threadItem : DWORD	// ThreadItem のインスタンス
) : TDownloadState;
begin

	if Assigned( FDownloadThread ) then
		Result := FDownloadThread( threadItem )
	else
		Result := dsError;

end;

// *************************************************************************
// 書き込みを指示
// *************************************************************************
function	TBoardPlugIn.WriteThread(
	threadItem	: DWORD;	// ThreadItem のインスタンス
	inName			: string;	// 名前(ハンドル)
	inMail			: string;	// メールアドレス
	inMessage		: string	// 本文
) : TDownloadState;			// 書き込みが成功したかどうか
begin

	if Assigned( FWriteThread ) then
		Result := FWriteThread( threadItem, PChar( inName ), PChar( inMail ), PChar( inMessage ) )
	else
		Result := dsError;

end;

// *************************************************************************
// レス番号 n に対する html を要求
// *************************************************************************
function TBoardPlugIn.GetRes(
	threadItem	: DWORD;		// ThreadItem のインスタンス
	inNo				: DWORD			// 表示するレス番号
) : string; 							// 表示する HTML
var
	tmp					: PChar;
begin

	if Assigned( FGetRes ) then begin
		tmp			:= FGetRes( threadItem, inNo );
		try
			Result	:= string( tmp );
		finally
			DisposeResultString( tmp );
		end;
	end;

end;

// *************************************************************************
// レス番号 n に対する Dat を要求
// *************************************************************************
function TBoardPlugIn.GetDat(
	threadItem	: DWORD;		// ThreadItem のインスタンス
	inNo				: DWORD			// 表示するレス番号
) : string; // ２ちゃんねるのdat形式
var
	tmp :	PChar;
begin

	if Assigned( FGetDat ) then begin
		tmp := FGetDat( threadItem, inNo );
		try
			Result := string( tmp );
		finally
			DisposeResultString(tmp);  end;
	end;

end;

// *************************************************************************
// スレッドのヘッダ html を要求
// *************************************************************************
function TBoardPlugIn.GetHeader(
	threadItem				: DWORD;	// ThreadItem のインスタンス
	inOptionalHeader	: string	// 追加のヘッダ
) : string;										// 整形された HTML
var
	tmp								: PChar;
begin

	if Assigned( FGetHeader ) then begin
		tmp			:= FGetHeader( threadItem, PChar( inOptionalHeader ) );
		try
			Result	:= string( tmp );
		finally
			DisposeResultString( tmp );
		end;
	end;

end;

// *************************************************************************
// スレッドのフッタ html を要求
// *************************************************************************
function TBoardPlugIn.GetFooter(
	threadItem				: DWORD;	// ThreadItem のインスタンス
	inOptionalFooter	: string	// 追加のフッタ
) : string;										// 整形された HTML
var
	tmp								: PChar;
begin

	if Assigned( FGetFooter ) then begin
		tmp			:= FGetFooter( threadItem, PChar( inOptionalFooter ) );
		Result	:= string( tmp );
		DisposeResultString( tmp );
	end;

end;

// *************************************************************************
// この ThreadItem が属する板の URL を要求
// *************************************************************************
function	TBoardPlugIn.GetBoardURL(
	threadItem	: DWORD	// ThreadItem のインスタンス
) : string;
var
	tmp					: PChar;
begin

	if Assigned( FGetBoardURL ) then begin
		tmp			:= FGetBoardURL( threadItem );
		Result	:= string( tmp );
		DisposeResultString( tmp );
	end;

end;

// *************************************************************************
// TBoardItem が生成された
// *************************************************************************
procedure	TBoardPlugIn.CreateBoardItem(
	boardItem : DWORD	// BoardItem のインスタンス
);
begin

	if Assigned( FCreateBoardItem ) then
		FCreateBoardItem( boardItem );

end;

// *************************************************************************
// TBoardItem が破棄された
// *************************************************************************
procedure	TBoardPlugIn.DisposeBoardItem(
	boardItem : DWORD	// BoardItem のインスタンス
);
begin

	if Assigned( FDisposeBoardItem ) then
		FDisposeBoardItem( boardItem );

end;

// *************************************************************************
// ダウンロードを指示
// *************************************************************************
function	TBoardPlugIn.DownloadBoard(
	boardItem : DWORD	// BoardItem のインスタンス
) : TDownloadState;
begin

	if Assigned( FDownloadBoard ) then
		Result := FDownloadBoard( boardItem )
	else
		Result := dsError;

end;

// *************************************************************************
// スレ立てを指示
// *************************************************************************
function	TBoardPlugIn.CreateThread(
	boardItem		: DWORD;	// BoardItem のインスタンス
	inSubject		: string;	// スレタイ
	inName			: string;	// 名前(ハンドル)
	inMail			: string;	// メールアドレス
	inMessage		: string	// 本文
) : TDownloadState;			// 書き込みが成功したかどうか
begin

	if Assigned( FCreateThread ) then
		Result := FCreateThread( boardItem, PChar( inSubject ), PChar( inName ), PChar( inMail ), PChar( inMessage ) )
	else
		Result := dsError;

end;

// *************************************************************************
// この板に保有しているスレを列挙
// *************************************************************************
procedure TBoardPlugIn.EnumThread(
	boardItem		: DWORD;	// BoardItem のインスタンス
	inCallBack	: TBoardItemEnumThreadCallBack
);
begin

	if Assigned( FEnumThread ) then
		FEnumThread( boardItem, inCallBack );

end;

// *************************************************************************
// ファイル名からスレッドの URL を要求
// *************************************************************************
function	TBoardPlugIn.FileName2ThreadURL(
	boardItem		: DWORD;	// BoardItem のインスタンス
	inFileName	: string
) : string;
var
	tmp								: PChar;
begin

	if Assigned( FFileName2ThreadURL ) then begin
		tmp			:= FFileName2ThreadURL( boardItem, PChar( inFileName ) );
		Result	:= string( tmp );
		DisposeResultString( tmp );
	end;

end;

// *************************************************************************
// プラグインの API を取得
// *************************************************************************
procedure TBoardPlugIn.LoadPlugInAPI;
begin

	try
		if Assigned( Pointer( FModule ) ) then begin
			FLoad								:= GetProcAddress( FModule, 'OnLoad' );
			FVersionInfo				:= GetProcAddress( FModule, 'OnVersionInfo' );
			FAcceptURL					:= GetProcAddress( FModule, 'OnAcceptURL' );
            FExtractBoardURL				:= GetProcAddress( FModule, 'OnExtractBoardURL' );
			FPlugInMenu					:= GetProcAddress( FModule, 'OnPlugInMenu' );

			FCreateThreadItem		:= GetProcAddress( FModule, 'ThreadItemCreate' );
			FDisposeThreadItem	:= GetProcAddress( FModule, 'ThreadItemDispose' );
			FDownloadThread			:= GetProcAddress( FModule, 'ThreadItemOnDownload' );
			FWriteThread				:= GetProcAddress( FModule, 'ThreadItemOnWrite' );
			FGetRes							:= GetProcAddress( FModule, 'ThreadItemOnGetRes' );
			FGetDat							:= GetProcAddress( FModule, 'ThreadItemOnGetDat' );
			FGetHeader					:= GetProcAddress( FModule, 'ThreadItemOnGetHeader' );
			FGetFooter					:= GetProcAddress( FModule, 'ThreadItemOnGetFooter' );
			FGetBoardURL				:= GetProcAddress( FModule, 'ThreadItemOnGetBoardURL' );

			FCreateBoardItem		:= GetProcAddress( FModule, 'BoardItemCreate' );
			FDisposeBoardItem		:= GetProcAddress( FModule, 'BoardItemDispose' );
			FDownloadBoard			:= GetProcAddress( FModule, 'BoardItemOnDownload' );
			FCreateThread				:= GetProcAddress( FModule, 'BoardItemOnCreateThread' );
			FEnumThread					:= GetProcAddress( FModule, 'BoardItemOnEnumThread' );
			FFileName2ThreadURL	:= GetProcAddress( FModule, 'BoardItemOnFileName2ThreadURL' );
		end;
	except
	end;

end;

end.

