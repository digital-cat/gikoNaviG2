unit ExternalBoardManager;

interface

uses
	Windows, Classes, SysUtils,
	IdHTTP, IdComponent, IdGlobal, IdException,
	ExternalBoardPlugInMain, ExternalFilePath, ExternalThreadItem, ExternalBoardItem;

type
	// =========================================================================
	// �v���O�C�����Ǘ����� TBoardPlugin �N���X
	// =========================================================================
	TBoardPlugIn = class( TObject )
	private
		FFilePath						: string;		// �v���O�C���������p�X
		FModule							: HMODULE;	// �v���O�C���̃��W���[���n���h��

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
		// �R���X�g���N�^
		constructor	Create;
		// �v���O�C���̃p�X���w�肵�č쐬
		constructor	CreateFromPath( inPath : string );
		// �v���O�C�������w�肵�č쐬
		constructor	CreateFromName( inName : string );
		// ���W���[���n���h�����w�肵�č쐬
		constructor	CreateFromModule( inModule : HMODULE );
		// �f�X�g���N�^
		destructor	Destroy; override;

		// �v���O�C���̃p�X���w�肵�ă��[�h
		procedure	LoadFromPath( inPath : string );
		// �v���O�C�������w�肵�ă��[�h
		procedure	LoadFromName( inName : string );
		// ���W���[���n���h�����w�肵�ă��[�h
		procedure	LoadFromModule( inModule : HMODULE );

		//===== PlugInMain �֘A
		// �v���O�C����(������)���[�h���ꂽ
		procedure	Loaded;
		// �o�[�W�������
		procedure	VersionInfo(	var outAgent : string;
			var outMajor : DWORD; var outMinor : DWORD;
			var outRelease : string; var outRevision : DWORD );
		// �w�肵�� URL �����̃v���O�C���Ŏ󂯕t���邩�ǂ���
		function	AcceptURL( inURL : string ) : TAcceptType;
        // URL����g����Board��URL�𓱂��o��
        function	ExtractBoardURL( inURL : string ): string;
		// ���j���[�n���h��
		procedure	PlugInMenu( inHandle : HMENU );

		//===== TThreadItem �֘A
		// TThreadItem ���������ꂽ
		procedure	CreateThreadItem( threadItem : DWORD );
		// TThreadItem ���j�����ꂽ
		procedure	DisposeThreadItem( threadItem : DWORD );
		// �_�E�����[�h���w��
		function	DownloadThread( threadItem : DWORD ) : TDownloadState;
		// �������݂��w��
		function	WriteThread( threadItem : DWORD; inName : string; inMail : string; inMessage : string ) : TDownloadState;
		// ���X�ԍ� n �ɑ΂��� html ��v��
		function	GetRes( threadItem : DWORD; inNo : DWORD ) : string;
		// ���X�ԍ� n �ɑ΂��� Dat ��v��
		function	GetDat( threadItem : DWORD; inNo : DWORD ) : string;
		// �X���b�h�̃w�b�_ html ��v��
		function	GetHeader( threadItem : DWORD; inOptionalHeader : string ) : string;
		// �X���b�h�̃t�b�^ html ��v��
		function	GetFooter( threadItem : DWORD; inOptionalFooter : string ) : string;
		// ���� ThreadItem ��������� URL ��v��
		function	GetBoardURL( threadItem : DWORD ) : string;

		//===== TBoardItem �֘A
		// TBoard ���������ꂽ
		procedure	CreateBoardItem( boardItem : DWORD );
		// TBoardItem ���j�����ꂽ
		procedure	DisposeBoardItem( boardItem : DWORD );
		// �_�E�����[�h���w��
		function	DownloadBoard( boardItem : DWORD ) : TDownloadState;
		// �X�����Ă��w��
		function	CreateThread( boardItem : DWORD; inSubject : string; inName : string; inMail : string; inMessage : string ) : TDownloadState;
		// ���̔ɕۗL���Ă���X�����
		procedure EnumThread( boardItem : DWORD; inCallBack : TBoardItemEnumThreadCallBack );
		// �t�@�C��������X���b�h�� URL ��v��
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
// BoardPlugin �t�H���_�ɂ���v���O�C����S�ă��[�h
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
// �v���O�C�����Ǘ����� TBoardPlugin �N���X
// =========================================================================

// *************************************************************************
// �R���X�g���N�^
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
// �v���O�C���̃p�X���w�肵�č쐬
// *************************************************************************
constructor	TBoardPlugIn.CreateFromPath(
	inPath : string
);
begin

	Create;

	LoadFromPath( inPath );

end;

// *************************************************************************
// �v���O�C�������w�肵�č쐬
// *************************************************************************
constructor	TBoardPlugIn.CreateFromName(
	inName : string
);
begin

	Create;

	LoadFromName( inName );

end;

// *************************************************************************
// ���W���[���n���h�����w�肵�č쐬
// *************************************************************************
constructor	TBoardPlugIn.CreateFromModule(
	inModule : HMODULE
);
begin

	inherited Create;

	LoadFromModule( inModule );

end;

// *************************************************************************
// �f�X�g���N�^
// *************************************************************************
destructor	TBoardPlugIn.Destroy;
begin

	FreeLibrary( FModule );

	inherited;

end;

// *************************************************************************
// �v���O�C���̃p�X���w�肵�ă��[�h
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
// �v���O�C�������w�肵�ă��[�h
// *************************************************************************
procedure TBoardPlugIn.LoadFromName(
	inName : string
);
begin

	LoadFromPath( GikoSys.Setting.GetBoardPlugInDir + inName );

end;

// *************************************************************************
// ���W���[���n���h�����w�肵�ă��[�h
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
// �v���O�C����(������)���[�h���ꂽ
// *************************************************************************
procedure TBoardPlugIn.Loaded;
begin

	if Assigned( FLoad ) then
		FLoad( DWORD( Self ) );

end;

// *************************************************************************
// �o�[�W�������
// *************************************************************************
procedure TBoardPlugIn.VersionInfo(
	var outAgent		: string;		// �o�[�W��������؊܂܂Ȃ������Ȗ���
	var outMajor		: DWORD;		// ���W���[�o�[�W����
	var outMinor		: DWORD;		// �}�C�i�[�o�[�W����
	var outRelease	: string;		// �����[�X�i�K��
	var outRevision	: DWORD			// ���r�W�����i���o�[
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
// �w�肵�� URL �����̃v���O�C���Ŏ󂯕t���邩�ǂ���
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
// �w�肵�� URL ����g����Board��URL�𓱂��o��
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
// ���j���[�n���h��
// *************************************************************************
procedure TBoardPlugIn.PlugInMenu(
	inHandle : HMENU					// ���j���[�n���h��
);
begin

	if Assigned( FPlugInMenu ) then
		FPlugInMenu( inHandle );

end;

// *************************************************************************
// TThreadItem ���������ꂽ
// *************************************************************************
procedure	TBoardPlugIn.CreateThreadItem(
	threadItem : DWORD	// ThreadItem �̃C���X�^���X
);
begin

	if Assigned( FCreateThreadItem ) then
		FCreateThreadItem( threadItem );

end;

// *************************************************************************
// TThreadItem ���j�����ꂽ
// *************************************************************************
procedure	TBoardPlugIn.DisposeThreadItem(
	threadItem : DWORD	// ThreadItem �̃C���X�^���X
);
begin

	if Assigned( FDisposeThreadItem ) then
		FDisposeThreadItem( threadItem );

end;

// *************************************************************************
// �_�E�����[�h���w��
// *************************************************************************
function	TBoardPlugIn.DownloadThread(
	threadItem : DWORD	// ThreadItem �̃C���X�^���X
) : TDownloadState;
begin

	if Assigned( FDownloadThread ) then
		Result := FDownloadThread( threadItem )
	else
		Result := dsError;

end;

// *************************************************************************
// �������݂��w��
// *************************************************************************
function	TBoardPlugIn.WriteThread(
	threadItem	: DWORD;	// ThreadItem �̃C���X�^���X
	inName			: string;	// ���O(�n���h��)
	inMail			: string;	// ���[���A�h���X
	inMessage		: string	// �{��
) : TDownloadState;			// �������݂������������ǂ���
begin

	if Assigned( FWriteThread ) then
		Result := FWriteThread( threadItem, PChar( inName ), PChar( inMail ), PChar( inMessage ) )
	else
		Result := dsError;

end;

// *************************************************************************
// ���X�ԍ� n �ɑ΂��� html ��v��
// *************************************************************************
function TBoardPlugIn.GetRes(
	threadItem	: DWORD;		// ThreadItem �̃C���X�^���X
	inNo				: DWORD			// �\�����郌�X�ԍ�
) : string; 							// �\������ HTML
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
// ���X�ԍ� n �ɑ΂��� Dat ��v��
// *************************************************************************
function TBoardPlugIn.GetDat(
	threadItem	: DWORD;		// ThreadItem �̃C���X�^���X
	inNo				: DWORD			// �\�����郌�X�ԍ�
) : string; // �Q�����˂��dat�`��
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
// �X���b�h�̃w�b�_ html ��v��
// *************************************************************************
function TBoardPlugIn.GetHeader(
	threadItem				: DWORD;	// ThreadItem �̃C���X�^���X
	inOptionalHeader	: string	// �ǉ��̃w�b�_
) : string;										// ���`���ꂽ HTML
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
// �X���b�h�̃t�b�^ html ��v��
// *************************************************************************
function TBoardPlugIn.GetFooter(
	threadItem				: DWORD;	// ThreadItem �̃C���X�^���X
	inOptionalFooter	: string	// �ǉ��̃t�b�^
) : string;										// ���`���ꂽ HTML
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
// ���� ThreadItem ��������� URL ��v��
// *************************************************************************
function	TBoardPlugIn.GetBoardURL(
	threadItem	: DWORD	// ThreadItem �̃C���X�^���X
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
// TBoardItem ���������ꂽ
// *************************************************************************
procedure	TBoardPlugIn.CreateBoardItem(
	boardItem : DWORD	// BoardItem �̃C���X�^���X
);
begin

	if Assigned( FCreateBoardItem ) then
		FCreateBoardItem( boardItem );

end;

// *************************************************************************
// TBoardItem ���j�����ꂽ
// *************************************************************************
procedure	TBoardPlugIn.DisposeBoardItem(
	boardItem : DWORD	// BoardItem �̃C���X�^���X
);
begin

	if Assigned( FDisposeBoardItem ) then
		FDisposeBoardItem( boardItem );

end;

// *************************************************************************
// �_�E�����[�h���w��
// *************************************************************************
function	TBoardPlugIn.DownloadBoard(
	boardItem : DWORD	// BoardItem �̃C���X�^���X
) : TDownloadState;
begin

	if Assigned( FDownloadBoard ) then
		Result := FDownloadBoard( boardItem )
	else
		Result := dsError;

end;

// *************************************************************************
// �X�����Ă��w��
// *************************************************************************
function	TBoardPlugIn.CreateThread(
	boardItem		: DWORD;	// BoardItem �̃C���X�^���X
	inSubject		: string;	// �X���^�C
	inName			: string;	// ���O(�n���h��)
	inMail			: string;	// ���[���A�h���X
	inMessage		: string	// �{��
) : TDownloadState;			// �������݂������������ǂ���
begin

	if Assigned( FCreateThread ) then
		Result := FCreateThread( boardItem, PChar( inSubject ), PChar( inName ), PChar( inMail ), PChar( inMessage ) )
	else
		Result := dsError;

end;

// *************************************************************************
// ���̔ɕۗL���Ă���X�����
// *************************************************************************
procedure TBoardPlugIn.EnumThread(
	boardItem		: DWORD;	// BoardItem �̃C���X�^���X
	inCallBack	: TBoardItemEnumThreadCallBack
);
begin

	if Assigned( FEnumThread ) then
		FEnumThread( boardItem, inCallBack );

end;

// *************************************************************************
// �t�@�C��������X���b�h�� URL ��v��
// *************************************************************************
function	TBoardPlugIn.FileName2ThreadURL(
	boardItem		: DWORD;	// BoardItem �̃C���X�^���X
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
// �v���O�C���� API ���擾
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

