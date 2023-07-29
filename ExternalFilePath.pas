unit ExternalFilePath;

interface

uses
	Windows, Classes, SysUtils,
	ExternalBoardPlugInMain;

implementation

uses GikoSystem;

// *************************************************************************
// �u���E�U�{�̂��u���Ă���t�H���_
// *************************************************************************
function ApplicationFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetAppDir );

end;

// *************************************************************************
// �����ݒ�t�H���_
// *************************************************************************
function PreferencesFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetConfigDir );

end;

// *************************************************************************
// �����ݒ�t�@�C��
// *************************************************************************
function PreferencesFile : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetAppDir + 'gikoNavi.ini' );

end;

// *************************************************************************
// ���O�t�H���_
// *************************************************************************
function LogFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.Setting.LogFolderP );

end;

// *************************************************************************
// CSS �t�H���_
// *************************************************************************
function CSSFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetStyleSheetDir );

end;

// *************************************************************************
// �X�L�������Ă����t�H���_
// *************************************************************************
function SkinFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.GetSkinDir );

end;

// *************************************************************************
// �g�p���Ă��� CSS / �X�L��
// *************************************************************************
function SkinFile : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.Setting.CSSFileName );

end;

// *************************************************************************
// ���ځ[��K�����u���Ă���f�B���N�g��
// *************************************************************************
function AbonFolder : PChar; stdcall;
begin

	Result := CreateResultString( GikoSys.Setting.GetNGWordsDir );

end;

// *************************************************************************
// �g�p���Ă��邠�ځ[��K��
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
 