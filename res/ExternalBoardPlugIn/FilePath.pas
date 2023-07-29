unit FilePath;

{
	ExternalBoardPlugIn FilePath
	�u���E�U�Ɋւ���p�X���擾���� API
}

interface

uses
	Windows, SysUtils,
	PlugInMain;

type
	// �p�X���擾���� API ���ʂ̌^
	TPathFunction = function : PChar; stdcall;

var
	// *************************************************************************
	// �u���E�U�{�̂��u���Ă���t�H���_
	// *************************************************************************
	ApplicationFolder		: TPathFunction;

	// *************************************************************************
	// �����ݒ�t�H���_
	// *************************************************************************
	PreferencesFolder		: TPathFunction;

	// *************************************************************************
	// �����ݒ�t�@�C��
	// *************************************************************************
	PreferencesFile			: TPathFunction;

	// *************************************************************************
	// ���O�t�H���_
	// *************************************************************************
	LogFolder						: TPathFunction;

	// *************************************************************************
	// CSS �t�H���_
	// *************************************************************************
	CSSFolder						: TPathFunction;

	// *************************************************************************
	// �X�L�������Ă����t�H���_
	// *************************************************************************
	SkinFolder					: TPathFunction;

	// *************************************************************************
	// �g�p���Ă��� CSS / �X�L��
	// *************************************************************************
	SkinFile						: TPathFunction;

	// *************************************************************************
	// ���ځ[��K�����u���Ă���f�B���N�g��
	// *************************************************************************
	AbonFolder					: TPathFunction;

	// *************************************************************************
	// �g�p���Ă��邠�ځ[��K��
	// *************************************************************************
	AbonFile						: TPathFunction;

// �_�~�[�̃p�X��Ԃ�
function DummyPath : PChar;

// *************************************************************************
// PlugInSDK �̃t�@�C���p�X�Ɋւ��� API ��������
// *************************************************************************
procedure LoadInternalFilePathAPI(
	inModule : HMODULE
);

implementation

// *************************************************************************
// �_�~�[�̃p�X��Ԃ�
// *************************************************************************
function DummyPath : PChar;
begin

	Result := CreateResultString( '' );

end;

// *************************************************************************
// PlugInSDK �̃t�@�C���p�X�Ɋւ��� API ��������
// *************************************************************************
procedure LoadInternalFilePathAPI(
	inModule : HMODULE
);
begin

	// ===== �p�X�擾�֐�
	//			 �Ή����Ă��Ȃ��p�X�͋󕶎���Ԃ��_�~�[�ɒu��������
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
 