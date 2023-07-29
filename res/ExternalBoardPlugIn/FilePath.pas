unit FilePath;

{
	ExternalBoardPlugIn FilePath
	ブラウザに関するパスを取得する API
}

interface

uses
	Windows, SysUtils,
	PlugInMain;

type
	// パスを取得する API 共通の型
	TPathFunction = function : PChar; stdcall;

var
	// *************************************************************************
	// ブラウザ本体が置いてあるフォルダ
	// *************************************************************************
	ApplicationFolder		: TPathFunction;

	// *************************************************************************
	// 初期設定フォルダ
	// *************************************************************************
	PreferencesFolder		: TPathFunction;

	// *************************************************************************
	// 初期設定ファイル
	// *************************************************************************
	PreferencesFile			: TPathFunction;

	// *************************************************************************
	// ログフォルダ
	// *************************************************************************
	LogFolder						: TPathFunction;

	// *************************************************************************
	// CSS フォルダ
	// *************************************************************************
	CSSFolder						: TPathFunction;

	// *************************************************************************
	// スキンを入れておくフォルダ
	// *************************************************************************
	SkinFolder					: TPathFunction;

	// *************************************************************************
	// 使用している CSS / スキン
	// *************************************************************************
	SkinFile						: TPathFunction;

	// *************************************************************************
	// あぼーん規則が置いてあるディレクトリ
	// *************************************************************************
	AbonFolder					: TPathFunction;

	// *************************************************************************
	// 使用しているあぼーん規則
	// *************************************************************************
	AbonFile						: TPathFunction;

// ダミーのパスを返す
function DummyPath : PChar;

// *************************************************************************
// PlugInSDK のファイルパスに関する API を初期化
// *************************************************************************
procedure LoadInternalFilePathAPI(
	inModule : HMODULE
);

implementation

// *************************************************************************
// ダミーのパスを返す
// *************************************************************************
function DummyPath : PChar;
begin

	Result := CreateResultString( '' );

end;

// *************************************************************************
// PlugInSDK のファイルパスに関する API を初期化
// *************************************************************************
procedure LoadInternalFilePathAPI(
	inModule : HMODULE
);
begin

	// ===== パス取得関数
	//			 対応していないパスは空文字を返すダミーに置き換える
	ApplicationFolder := GetProcAddress( inModule, 'ApplicationFolder' );
	if not Assigned( ApplicationFolder ) then
		ApplicationFolder := @DummyPath;
	PreferencesFolder := GetProcAddress( inModule, 'PreferencesFolder' );
	if not Assigned( PreferencesFolder ) then
		PreferencesFolder := @DummyPath;
	PreferencesFile := GetProcAddress( inModule, 'PreferencesFile' );
	if not Assigned( PreferencesFile ) then
		PreferencesFile := @DummyPath;
	LogFolder := GetProcAddress( inModule, 'LogFolder' );
	if not Assigned( LogFolder ) then
		LogFolder := @DummyPath;
	CSSFolder := GetProcAddress( inModule, 'CSSFolder' );
	if not Assigned( CSSFolder ) then
		CSSFolder := @DummyPath;
	SkinFolder := GetProcAddress( inModule, 'SkinFolder' );
	if not Assigned( SkinFolder ) then
		SkinFolder := @DummyPath;
	SkinFile := GetProcAddress( inModule, 'SkinFile' );
	if not Assigned( SkinFile ) then
		SkinFile := @DummyPath;
	AbonFolder := GetProcAddress( inModule, 'AbonFolder' );
	if not Assigned( AbonFolder ) then
		AbonFolder := @DummyPath;
	AbonFile := GetProcAddress( inModule, 'AbonFile' );
	if not Assigned( AbonFile ) then
		AbonFile := @DummyPath;

end;

end.
 