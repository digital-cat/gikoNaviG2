unit PlugInMain;

{
	ExternalBoardPlugIn PlugInMain
	ExternalBoardPlugIn �p�� SDK ���C�u����
}

interface

uses
	Windows, SysUtils;

// ===== PlugInSDK API �̐錾
type
	// �_�E�����[�h�������������ǂ���
	TDownloadState = (dsWait, dsWork, dsComplete, dsDiffComplete, dsNotModify, dsAbort, dsError);

	// �w�肵�� URL �����̃v���O�C���Ŏ󂯕t���邩�ǂ���
	TAcceptType = (atNoAccept, atBBS, atBoard, atThread);

	// *************************************************************************
	// CreateResultString
	// �߂�l�� PChar �ł��� API �̃��������m�ۂ���
	// *************************************************************************
	TCreateResultString = function(
		resultStr : string
	) : PChar; stdcall;

	// *************************************************************************
	// DisposeResultString
	// �߂�l�� PChar �ł��� API �̃��������J������
	// *************************************************************************
	TDisposeResultString = procedure(
		resultStr : PChar
	); stdcall;

	// *************************************************************************
	// �v���O�����{�̂̃o�[�W�������擾����
	// *************************************************************************
	TVersionInfo = procedure(
		var outAgent		: PChar;	// �o�[�W��������؊܂܂Ȃ������Ȗ���
		var outMajor		: DWORD;	// ���W���[�o�[�W����
		var outMinor		: DWORD;	// �}�C�i�[�o�[�W����
		var outRelease	: PChar;	// �����[�X�i�K��
		var outRevision	: DWORD		// ���r�W�����i���o�[
	); stdcall;

	// *************************************************************************
	// ���b�Z�[�W��\������
	// *************************************************************************
	TInternalPrint = procedure(
		inMessage	: PChar	// ���b�Z�[�W
	); stdcall;

	// *************************************************************************
	// �f�o�b�O���b�Z�[�W��\������
	// *************************************************************************
	TInternalDebugPrint = procedure(
		inMessage	: PChar	// ���b�Z�[�W
	); stdcall;

	// *************************************************************************
	// InternalDownload
	// �w�肵�� URL ���_�E�����[�h���ĕԂ�
	// *************************************************************************
	TInternalDownload = function(
		inURL							: PChar;			// �_�E�����[�h���� URL
		var ioModified		: Double;			// �Ō�Ɏ擾��������
		var outResultData	: PChar;			// �_�E�����[�h���ꂽ������
		inRangeStart			: DWORD = 0;	// �J�n�ʒu
		inRangeEnd				: DWORD = 0		// �I���ʒu
	) : Longint; stdcall;							// ���X�|���X�R�[�h

	// *************************************************************************
	// InternalPost
	// �w�肵�� URL �փf�[�^�𑗐M����
	// *************************************************************************
	TInternalPost = function(
		inURL							: PChar;			// ���M���� URL
		inSource					: PChar;			// ���M������e
		inReferer			: PChar;			// Referer
		var outResultData	: PChar				// �Ԃ��Ă���������
	) : Longint; stdcall;							// ���X�|���X�R�[�h

	// *************************************************************************
	// InternalAbon
	// �Q�����˂�� dat �`�������[�J�����ځ`��ɒʂ�
	// *************************************************************************
	TInternalAbon = function(
		inDatText : PChar;			// ���O<>���[��<>���tID<>�{��<> �ō\�����ꂽ���s��؂�e�L�X�g
		inDatPath	: PChar = nil	// dat �t�@�C���̃t���p�X
	) : PChar; stdcall;				// ���ځ`��ς݂� dat �`���e�L�X�g

  // *************************************************************************
  // �Q�����˂�� dat �`�������[�J�����ځ`��ɒʂ�
  // �������A�P���X����
  // *************************************************************************
  TInternalAbonForOne = function(
      inDatText : PChar;		// ���O<>���[��<>���tID<>�{��<>[���s] �ō\�����ꂽ�e�L�X�g
      inDatPath	: PChar;		// dat �t�@�C���̃t���p�X
      inNo : Integer				//�v�����ꂽ���X�ԍ�
  ) : PChar; stdcall;				// ���ځ`��ς݂� dat �`���e�L�X�g

	// *************************************************************************
	// InternalDat2HTML
	// �Q�����˂�� dat �`�� 1 �s�� HTML �ɕϊ�����
	// *************************************************************************
	TInternalDat2HTML = function(
		inDatRes	: PChar; 			// ���O<>���[��<>���tID<>�{��<> �ō\�����ꂽ�e�L�X�g
		inResNo		: DWORD; 			// ���X�ԍ�
		inIsNew		: Boolean			// �V�����X�Ȃ� True
	) : PChar; stdcall;				// ���`���ꂽ HTML

	// *************************************************************************
	// AddPlugInMenu
	// �v���O�C�����j���[�ɍ��ڂ�ǉ�
	// �����I�Ƀv���O�C�������������\�������邽�߁A
	// �@�v���O�C���̃f�^�b�`���ɕK�� RemovePlugInMenu ���Ăяo���Ă��������B
	// *************************************************************************
	TAddPlugInMenu = function(
		inInstance	: DWORD;		// �v���O�C���̃n���h��
		inCaption		: PChar		 	// ���j���[�ɕ\�����镶����
	) : HMENU; stdcall;			 	// ���j���[�n���h���A�ǉ��Ɏ��s�����ꍇ�� NULL

	// *************************************************************************
	// RemovePlugInMenu
	// �v���O�C�����j���[���獀�ڂ��폜
	// *************************************************************************
	TRemovePlugInMenu = procedure(
		inHandle	: HMENU 			// ���j���[�n���h��
	); stdcall;

var
	CreateResultString	: TCreateResultString;
	DisposeResultString	: TDisposeResultString;
	VersionInfo					: TVersionInfo;
	InternalDownload		: TInternalDownload;
	InternalPrint				: TInternalPrint;
	InternalDebugPrint	: TInternalDebugPrint;
	InternalPost				: TInternalPost;
	InternalAbon				: TInternalAbon;
	InternalAbonForOne	: TInternalAbonForOne;
	InternalDat2HTML		: TInternalDat2HTML;
  AddPlugInMenu				: TAddPlugInMenu;
  RemovePlugInMenu		: TRemovePlugInMenu;


procedure LoadInternalAPI(
	inModule : HMODULE
);

implementation

// *************************************************************************
// PlugInSDK �� API ��������
// *************************************************************************
procedure LoadInternalAPI(
	inModule : HMODULE
);
begin

	// �߂�l�m�ۊJ���֐�
	// �Ăяo�����Ń��������m�ۂ���ƃo�b�t�@�I�[�o�[���C�ɂ��Ȃ��Ă͂Ȃ�Ȃ��̂�
	// SDK �͊m�ۂ��ꂽ��������Ԃ��݌v
	CreateResultString := GetProcAddress( inModule, 'CreateResultString' );
	if not Assigned( CreateResultString ) then
		System.ExitCode := 1;
	DisposeResultString := GetProcAddress( inModule, 'DisposeResultString' );
	if not Assigned( DisposeResultString ) then
		System.ExitCode := 1;
	// �o�[�W�������
	VersionInfo := GetProcAddress( inModule, 'VersionInfo' );
	if not Assigned( VersionInfo ) then
		System.ExitCode := 1;
	// ===== ���̑��⏕�֐�
	InternalDownload := GetProcAddress( inModule, 'InternalDownload' );
	if not Assigned( InternalDownload ) then
		System.ExitCode := 1;
	InternalPrint := GetProcAddress( inModule, 'InternalPrint' );						// �����Ă� OK
	InternalDebugPrint := GetProcAddress( inModule, 'InternalDebugPrint' );	// �����Ă� OK
	InternalPost := GetProcAddress( inModule, 'InternalPost' );
	if not Assigned( InternalDownload ) then
		System.ExitCode := 1;
	InternalAbon := GetProcAddress( inModule, 'InternalAbon' );
	if not Assigned( InternalAbon ) then
		System.ExitCode := 1;
	InternalAbonForOne := GetProcAddress( inModule, 'InternalAbonForOne' );
	if not Assigned( InternalAbonForOne ) then
		System.ExitCode := 1;
	InternalDat2HTML := GetProcAddress( inModule, 'InternalDat2HTML' );
	if not Assigned( InternalDat2HTML ) then
		System.ExitCode := 1;
	AddPlugInMenu := GetProcAddress( inModule, 'AddPlugInMenu' );
	if not Assigned( AddPlugInMenu ) then
		System.ExitCode := 1;
	RemovePlugInMenu := GetProcAddress( inModule, 'RemovePlugInMenu' );
	if not Assigned( RemovePlugInMenu ) then
		System.ExitCode := 1;

end;

end.
