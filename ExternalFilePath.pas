unit ExternalFilePath;

interface

uses
	Windows, Classes, SysUtils,
	ExternalBoardPlugInMain;

implementation

uses GikoSystem;

// *************************************************************************
// ブラウザ本体が置いてあるフォルダ
// *************************************************************************
function ApplicationFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetAppDir );

end;

// *************************************************************************
// 初期設定フォルダ
// *************************************************************************
function PreferencesFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetConfigDir );

end;

// *************************************************************************
// 初期設定ファイル
// *************************************************************************
function PreferencesFile : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetAppDir + 'gikoNavi.ini' );

end;

// *************************************************************************
// ログフォルダ
// *************************************************************************
function LogFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.Setting.LogFolderP );

end;

// *************************************************************************
// CSS フォルダ
// *************************************************************************
function CSSFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetStyleSheetDir );

end;

// *************************************************************************
// スキンを入れておくフォルダ
// *************************************************************************
function SkinFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetSkinDir );

end;

// *************************************************************************
// 使用している CSS / スキン
// *************************************************************************
function SkinFile : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.Setting.CSSFileName );

end;

// *************************************************************************
// あぼーん規則が置いてあるディレクトリ
// *************************************************************************
function AbonFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.Setting.GetNGWordsDir );

end;

// *************************************************************************
// 使用しているあぼーん規則
// *************************************************************************
function AbonFile : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.FAbon.GetNGwordpath );

end;

exports
	ApplicationFolder,
	PreferencesFolder,
	PreferencesFile,
	LogFolder,
	CSSFolder,
	SkinFolder,
	SkinFile,
	AbonFolder,
	AbonFile;

end.
 