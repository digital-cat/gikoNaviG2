unit ThreadItem;

{
	ExternalBoardPlugIn ThreadItem
	�X���b�h����ێ����� TThreadItem �N���X
}

interface

uses
	Windows, SysUtils,
	PlugInMain;

type
	// �X���ꗗ�̏グ�����t���O
	TThreadAgeSage = (tasNone, tasAge, tasSage, tasNew, tasArch, tasNull);

	// TThreadItem �̃v���p�e�B�ݒ�^�擾 ID
	TThreadItemProperty = (
		tipContext,							// : DWORD			// ���R�ɐݒ肵�Ă����l
		tipNo,									// : Integer		// �ԍ�
		tipFileName,						// : string			// �X���b�h�t�@�C����
		tipTitle,								// : string			// �X���b�h�^�C�g��
		tipRoundDate,						// : TDateTime	// �X���b�h���擾���������i��������j
		tipLastModified,				// : TDateTime	// �X���b�h���X�V����Ă�������i�T�[�o�������j
		tipCount,								// : Integer		// �X���b�h�J�E���g�i���[�J���j
		tipAllResCount,					// : Integer		// �X���b�h�J�E���g�i�T�[�o�j
		tipNewResCount,					// : Integer		// �X���b�h�V����
		tipSize,								// : Integer		// �X���b�h�T�C�Y
		tipRound,								// : Boolean		// ����t���O
		tipRoundName,						// : string			// ����
		tipIsLogFile,						// : Boolean		// ���O���݃t���O
		tipKokomade,						// : Integer		// �R�R�܂œǂ񂾔ԍ�
		tipNewReceive,					// : Integer		// �R�R����V�K��M
		tipNewArrival,					// : Boolean		// �V��
		tipUnRead,							// : Boolean		// ���ǃt���O
		tipScrollTop,						// : Integer		// �X�N���[���ʒu
		tipDownloadHost,				// : string			// ���̃z�X�g�ƈႤ�ꍇ�̃z�X�g
		tipAgeSage,							// : TThreadAgeSage	// �A�C�e���̏グ����
		tipURL,									// : string			// �X���b�h���u���E�U�ŕ\������ۂ� URL
		tipFilePath,							// : string			// ���̃X�����ۑ�����Ă���p�X
		tipJumpAddress							// : Integer		// JUMP�惌�X�ԍ�
	);



	// =========================================================================
	// TThreadItem �N���X�Ɋւ��� API
	// =========================================================================

	// *************************************************************************
	// ThreadItemGetLong
	// TThreadItem �N���X�̃v���p�e�B���擾����
	// *************************************************************************
	TThreadItemGetLong = function(
		instance		: DWORD;
		propertyID	: TThreadItemProperty
	) : DWORD; stdcall;

	// *************************************************************************
	// ThreadItemSetLong
	// TThreadItem �N���X�̃v���p�e�B��ݒ肷��
	// *************************************************************************
	TThreadItemSetLong = procedure(
		instanc			: DWORD;
		propertyID	: TThreadItemProperty;
		param : DWORD
	); stdcall;

	// *************************************************************************
	// ThreadItemGetDouble
	// TThreadItem �N���X�̃v���p�e�B���擾����
	// *************************************************************************
	TThreadItemGetDouble = function(
		instance		: DWORD;
		propertyID	: TThreadItemProperty
	) : Double; stdcall;

	// *************************************************************************
	// ThreadItemSetDouble
	// TThreadItem �N���X�̃v���p�e�B��ݒ肷��
	// *************************************************************************
	TThreadItemSetDouble = procedure(
		instance		: DWORD;
		propertyID	: TThreadItemProperty;
		param				: Double
	); stdcall;

	// *************************************************************************
	// ThreadItemDat2HTML
	// TThreadItem �N���X�����ɂQ�����˂�� dat �`�� 1 �s�� HTML �ɕϊ�����
	// *************************************************************************
	TThreadItemDat2HTML = function(
		inInstance	: DWORD;		// ThreadItem �̃C���X�^���X
		inDatRes		: PChar;		// ���O<>���[��<>���tID<>�{��<> �ō\�����ꂽ�e�L�X�g
		inResNo			: DWORD;		// ���X�ԍ�
		inIsNew			: Boolean		// �V�����X�Ȃ� True
	) : PChar; stdcall;				// ���`���ꂽ HTML

	// *************************************************************************
	// ThreadItemGetHeader
	// TThreadItem �N���X�����ɃX���b�h�̃w�b�_���擾����
	// *************************************************************************
	TThreadItemGetHeader = function(
		inInstance				: DWORD;			// ThreadItem �̃C���X�^���X
		inOptionalHeader	: PChar = nil	// �ǉ��̃w�b�_
	) : PChar; stdcall;								// ���`���ꂽ HTML

	// *************************************************************************
	// ThreadItemGetFooter
	// TThreadItem �N���X�����ɃX���b�h�̃t�b�^���擾����
	// *************************************************************************
	TThreadItemGetFooter = function(
		inInstance				: DWORD;			// ThreadItem �̃C���X�^���X
		inOptionalFooter	: PChar = nil	// �ǉ��̃t�b�^
	) : PChar; stdcall;								// ���`���ꂽ HTML

	// *************************************************************************
	// ThreadItemWork
	// �_�E�����[�h�̐i���󋵂��v���O�����{�̂ɓ`����
	// *************************************************************************
	TThreadItemWork = procedure(
		inInstance	: DWORD;			// ThreadItem �̃C���X�^���X
		inWorkCount	: Integer			// ���݂̐i����(�J�E���g)
	); stdcall;

	// *************************************************************************
	// ThreadItemWorkBegin
	// �_�E�����[�h���n�܂������Ƃ��v���O�����{�̂ɓ`����
	// *************************************************************************
	TThreadItemWorkBegin = procedure(
		inInstance			: DWORD;	// ThreadItem �̃C���X�^���X
		inWorkCountMax	: Integer	// �ʐM�̏I���������J�E���g
	); stdcall;

	// *************************************************************************
	// ThreadItemWorkEnd
	// �_�E�����[�h���I��������Ƃ��v���O�����{�̂ɓ`����
	// *************************************************************************
	TThreadItemWorkEnd = procedure(
		inInstance	: DWORD				// ThreadItem �̃C���X�^���X
	); stdcall;



	// =========================================================================
	// TThreadItem �N���X�Ɋւ���C�x���g
	// =========================================================================

	// *************************************************************************
	// TThreadItem ���������ꂽ
	// *************************************************************************
	TThreadItemOnCreateEvent = procedure(
		instance : DWORD
	);

	// *************************************************************************
	// TThreadItem ���j�����ꂽ
	// *************************************************************************
	TThreadItemOnDisposeEvent = procedure(
		instance : DWORD
	);

	// *************************************************************************
	// �_�E�����[�h���w�����ꂽ
	// *************************************************************************
	TThreadItemOnDownloadEvent = function : TDownloadState of object;

	// *************************************************************************
	// �������݂��w�����ꂽ
	// *************************************************************************
	TThreadItemOnWriteEvent = function(
		inName		: string;					// ���O(�n���h��)
		inMail		: string;					// ���[���A�h���X
		inMessage	: string					// �{��
	) : TDownloadState of object;	// �������݂������������ǂ���

	// *************************************************************************
	// ���X�ԍ� inNo �ɑ΂��� html ��v�����ꂽ
	// *************************************************************************
	TThreadItemOnGetResEvent = function(
		inNo				: Integer
	) : string of object;

	// *************************************************************************
	// ���X�ԍ� inNo �ɑ΂��� dat ��v�����ꂽ
	// *************************************************************************
	TThreadItemOnGetDatEvent = function(
		inNo				: Integer
	) : string of object;

	// *************************************************************************
	// �X���b�h�̃w�b�_ html ��v�����ꂽ
	// *************************************************************************
	TThreadItemOnGetHeaderEvent = function(
		inOptionalHeader	: string	// �ǉ��̃w�b�_
	) : string of object;					// ���`���ꂽ HTML

	// *************************************************************************
	// �X���b�h�̃t�b�^ html ��v�����ꂽ
	// *************************************************************************
	TThreadItemOnGetFooterEvent = function(
		inOptionalFooter	: string	// �ǉ��̃t�b�^
	) : string of object;					// ���`���ꂽ HTML

	// *************************************************************************
	// ���� ThreadItem ��������� URL ��v�����ꂽ
	// *************************************************************************
	TThreadItemOnGetBoardURLEvent = function : string of object;	// �� URL




	// =========================================================================
	// TThreadItem �N���X
	// =========================================================================
	TThreadItem = class(TObject)
	private
		// ThreadItem �̃C���X�^���X
		FInstance				: DWORD;

 		// �_�E�����[�h���w�����ꂽ
 		FOnDownload			: TThreadItemOnDownloadEvent;
		// �������݂��w�����ꂽ
		FOnWrite				: TThreadItemOnWriteEvent;
		// ���X�ԍ� n �ɑ΂��� html ��v�����ꂽ
		FOnGetRes				: TThreadItemOnGetResEvent;
		// ���X�ԍ� n �ɑ΂��� dat ��v�����ꂽ
		FOnGetDat				: TThreadItemOnGetDatEvent;
		// �X���b�h�̃w�b�_ html ��v�����ꂽ
		FOnGetHeader		: TThreadItemOnGetHeaderEvent;
		// �X���b�h�̃t�b�^ html ��v�����ꂽ
		FOnGetFooter		: TThreadItemOnGetFooterEvent;
		// ���� ThreadItem ��������� URL ��v�����ꂽ
		FOnGetBoardURL	: TThreadItemOnGetBoardURLEvent;

	public
		// �R���X�g���N�^
		constructor Create( inInstance : DWORD );
		// ���X�� HTML ���`���v���O�����{�̂ɔC����
		function	Dat2HTML( inDatRes : string; inNo : Integer; inIsNew : Boolean ) : string; overload;
		// ���X�� HTML ���`���v���O�����{�̂ɔC����(�ȗ��`)
		function	Dat2HTML( inDatRes : string; inNo : Integer ) : string; overload;
		// �w�b�_�� HTML ���`���v���O�����{�̂ɔC����
		function	InternalHeader( inOptionalHeader : string = '' ) : string;
		// �t�b�^�� HTML ���`���v���O�����{�̂ɔC����
		function	InternalFooter( inOptionalFooter : string = '' ) : string;
		// �_�E�����[�h�̐i���󋵂��v���O�����{�̂ɓ`����
		procedure	Work( inWorkCount : Integer );
		// �_�E�����[�h���n�܂������Ƃ��v���O�����{�̂ɓ`����
		procedure	WorkBegin( inWorkCountMax : Integer );
		// �_�E�����[�h���I��������Ƃ��v���O�����{�̂ɓ`����
		procedure	WorkEnd;

	private
		// ===== �v���p�e�B�̊Ǘ��𓝊����郉�b�p
		function	GetLong( propertyID : TThreadItemProperty ) : DWORD;
		procedure	SetLong( propertyID : TThreadItemProperty; param : DWORD );
		function	GetDouble( propertyID : TThreadItemProperty ) : Double;
		procedure	SetDouble( propertyID : TThreadItemProperty; param : Double );

		// ===== �v���p�e�B�̎擾�^�ݒ�𖖒[�ɒ񋟂��郉�b�p
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
		// ===== �C�x���g
		property	OnDownload		: TThreadItemOnDownloadEvent		read FOnDownload write FOnDownload;
		property	OnWrite				: TThreadItemOnWriteEvent				read FOnWrite write FOnWrite;
		property	OnGetRes			: TThreadItemOnGetResEvent			read FOnGetRes write FOnGetRes;
        property	OnGetDat			: TThreadItemOnGetDatEvent			read FOnGetDat write FOnGetDat;
		property	OnGetHeader		: TThreadItemOnGetHeaderEvent		read FOnGetHeader write FOnGetHeader;
		property	OnGetFooter		: TThreadItemOnGetFooterEvent		read FOnGetFooter write FOnGetFooter;
		property	OnGetBoardURL	: TThreadItemOnGetBoardURLEvent	read FOnGetBoardURL write FOnGetBoardURL;

		// ===== ThreadItem �Ɏ擾�^�ݒ�\�ȃv���p�e�B
		// �ԍ�
		property	No						: Integer					read GetNo write SetNo;
		// �X���b�h�t�@�C����
		property	FileName			: string					read GetFileName write SetFileName;
		// �X���b�h�^�C�g��
		property	Title					: string					read GetTitle write SetTitle;
		// �X���b�h���擾���������i��������j
		property	RoundDate			: TDateTime				read GetRoundDate write SetRoundDate;
		// �X���b�h���X�V����Ă�������i�T�[�o�������j
		property	LastModified	: TDateTime				read GetLastModified write SetLastModified;
		// �X���b�h�J�E���g�i���[�J���j
		property	Count					: Integer					read GetCount write SetCount;
		// �X���b�h�J�E���g�i�T�[�o�j
		property	AllResCount		: Integer					read GetAllResCount write SetAllResCount;
		// �X���b�h�V����
		property	NewResCount		: Integer					read GetNewResCount write SetNewResCount;
		// �X���b�h�T�C�Y
		property	Size					: Integer					read GetSize write SetSize;
		// ����t���O
		property	Round					: Boolean					read GetRound write SetRound;
		// ����
		property	RoundName			: string					read GetRoundName write SetRoundName;
		// ���O���݃t���O
		property	IsLogFile			: Boolean					read GetIsLogFile write SetIsLogFile;
		// �R�R�܂œǂ񂾔ԍ�
		property	Kokomade			: Integer					read GetKokomade write SetKokomade;
		// �R�R����V�K��M
		property	NewReceive		: Integer					read GetNewReceive write SetNewReceive;
		// �V��
		property	NewArrival		: Boolean					read GetNewArrival write SetNewArrival;
		// ���ǃt���O
		property	UnRead				: Boolean					read GetUnRead write SetUnRead;
		// �X�N���[���ʒu
		property	ScrollTop			: Integer					read GetScrollTop write SetScrollTop;
		// ���̃z�X�g�ƈႤ�ꍇ�̃z�X�g
		property	DownloadHost	: string					read GetDownloadHost write SetDownloadHost;
		// �A�C�e���̏グ����
		property	AgeSage				: TThreadAgeSage	read GetAgeSage write SetAgeSage;
		// �X���b�h���u���E�U�ŕ\������ۂ� URL
		property	URL						: string					read GetURL write SetURL;
		// ���̃X�����ۑ�����Ă���p�X
		property	FilePath			: string					read GetFilePath {write SetFilePath};
		// JUMP�惌�X�ԍ�
		property	JumpAddress		: Integer	read GetJumpAddress write SetJumpAddress;
	end;

var
	// ===== API �̃A�h���X
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
	// ===== �C�x���g�n���h��
	ThreadItemOnCreate	: TThreadItemOnCreateEvent;
	ThreadItemOnDispose	: TThreadItemOnDisposeEvent;

// ===== TThreadItem �N���X���Ǘ�����֐�
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
// TThreadItem �̃R���X�g���N�^
// *************************************************************************
constructor TThreadItem.Create(
	inInstance : DWORD											// �C���X�^���X
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
// ���X�� HTML ���`���v���O�����{�̂ɔC����
// *************************************************************************
function	TThreadItem.Dat2HTML(
	inDatRes	: string;											// ���O<>���[��<>���tID<>�{��<> �ō\�����ꂽ�e�L�X�g
	inNo			: Integer;										// ���X�ԍ�
	inIsNew		: Boolean											// �V�����X�Ȃ� True
) : string;																// ���`���ꂽ HTML
var
	tmp				: PChar;
begin

	tmp			:= ThreadItemDat2HTML( FInstance, PChar( inDatRes ), inNo, inIsNew );
	Result	:= string( tmp );
	DisposeResultString( tmp );

end;

// *************************************************************************
// ���X�� HTML ���`���v���O�����{�̂ɔC����(�ȗ��`)
// *************************************************************************
function	TThreadItem.Dat2HTML(
	inDatRes	: string;											// ���O<>���[��<>���tID<>�{��<> �ō\�����ꂽ�e�L�X�g
	inNo			: Integer											// ���X�ԍ�
) : string;																// ���`���ꂽ HTML
begin

	Result := Dat2HTML( inDatRes, inNo, inNo >= NewReceive );

end;

// *************************************************************************
// �w�b�_�� HTML ���`���v���O�����{�̂ɔC����
// *************************************************************************
function	TThreadItem.InternalHeader(
	inOptionalHeader	: string = ''					// �ǉ��̃w�b�_
) : string;																// ���`���ꂽ HTML
var
	tmp								: PChar;
begin

	tmp			:= ThreadItemGetHeader( FInstance, PChar( inOptionalHeader ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );

end;

// *************************************************************************
// �t�b�^�� HTML ���`���v���O�����{�̂ɔC����
// *************************************************************************
function	TThreadItem.InternalFooter(
	inOptionalFooter	: string = ''					// �ǉ��̃t�b�^
) : string;																// ���`���ꂽ HTML
var
	tmp								: PChar;
begin

	tmp			:= ThreadItemGetFooter( FInstance, PChar( inOptionalFooter ) );
	Result	:= string( tmp );
	DisposeResultString( tmp );

end;

// *************************************************************************
// �_�E�����[�h�̐i���󋵂��v���O�����{�̂ɓ`����
// *************************************************************************
procedure	TThreadItem.Work(
	inWorkCount : Integer			// ���݂̐i����(�J�E���g)
);
begin

	ThreadItemWork( FInstance, inWorkCount );

end;

// *************************************************************************
// �_�E�����[�h���n�܂������Ƃ��v���O�����{�̂ɓ`����
// *************************************************************************
procedure	TThreadItem.WorkBegin(
	inWorkCountMax : Integer	// �ʐM�̏I���������J�E���g
);
begin

	ThreadItemWorkBegin( FInstance, inWorkCountMax );

end;

// *************************************************************************
// �_�E�����[�h���I��������Ƃ��v���O�����{�̂ɓ`����
// *************************************************************************
procedure	TThreadItem.WorkEnd;
begin

	ThreadItemWorkEnd( FInstance );

end;



// =========================================================================
// TThreadItem �̃v���p�e�B�̊Ǘ��𓝊����郉�b�p
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
// ���������火
// TThreadItem �̃v���p�e�B�̎擾�^�ݒ�𖖒[�ɒ񋟂��郉�b�p
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
// TThreadItem �̃v���p�e�B�̎擾�^�ݒ�𖖒[�ɒ񋟂��郉�b�p
// �������܂Ł�
// =========================================================================



// =========================================================================
// TThreadItem �N���X���Ǘ�����֐�
// =========================================================================

// *************************************************************************
// TThreadItem ���������ꂽ�ꍇ�̃f�t�H���g�̏��u(TThreadItem �𐶐�����)
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
// TThreadItem ���j�����ꂽ�ꍇ�̃f�t�H���g�̏��u(TThreadItem ��j������)
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
// PlugInSDK �� TThreadItem �Ɋւ��� API ��������
// *************************************************************************
procedure LoadInternalThreadItemAPI(
	inModule : HMODULE
);
begin

	// ===== �C���X�^���X�̃f�t�H���g�̎�舵���� TThreadItem �ɂ���
	ThreadItemOnCreate	:= ThreadItemOnCreateOfTThreadItem;
	ThreadItemOnDispose	:= ThreadItemOnDisposeOfTThreadItem;

	// ===== TThreadItem �v���p�e�B�擾�ݒ�֐�
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
// TThreadItem �N���X�Ɋւ���C�x���g
// =========================================================================

// *************************************************************************
// TThreadItem ���������ꂽ
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
// TThreadItem ���j�����ꂽ
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
// �_�E�����[�h���w�����ꂽ
// *************************************************************************
function ThreadItemOnDownload(
	inInstance	: DWORD					// ThreadItem �̃C���X�^���X
) : TDownloadState; stdcall;	// �_�E�����[�h�������������ǂ���
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
// �������݂��w�����ꂽ
// *************************************************************************
function	ThreadItemOnWrite(
	inInstance	: DWORD;				// ThreadItem �̃C���X�^���X
	inName			: PChar;				// ���O(�n���h��)
	inMail			: PChar;				// ���[���A�h���X
	inMessage		: PChar					// �{��
) : TDownloadState; stdcall;	// �������݂������������ǂ���
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
// ���X�ԍ� n �ɑ΂��� html ��v�����ꂽ
// *************************************************************************
function ThreadItemOnGetRes(
	inInstance	: DWORD;		// ThreadItem �̃C���X�^���X
	inNo				: DWORD			// �\�����郌�X�ԍ�
) : PChar; stdcall;				// �\������ HTML
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
// ���X�ԍ� n �ɑ΂��� Dat ��v�����ꂽ
// *************************************************************************
function ThreadItemOnGetDat(
	inInstance	: DWORD;		// ThreadItem �̃C���X�^���X
	inNo				: DWORD			// �\�����郌�X�ԍ�
) : PChar; stdcall;				// �Q�����˂��Dat�`��
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
// �X���b�h�̃w�b�_ html ��v�����ꂽ
// *************************************************************************
function ThreadItemOnGetHeader(
	inInstance				: DWORD;	// ThreadItem �̃C���X�^���X
	inOptionalHeader	: PChar		// �ǉ��̃w�b�_
) : PChar; stdcall;						// ���`���ꂽ HTML
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
// �X���b�h�̃t�b�^ html ��v�����ꂽ
// *************************************************************************
function ThreadItemOnGetFooter(
	inInstance				: DWORD;	// ThreadItem �̃C���X�^���X
	inOptionalFooter	: PChar		// �ǉ��̃t�b�^
) : PChar; stdcall;						// ���`���ꂽ HTML
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
// ���� ThreadItem ��������� URL ��v�����ꂽ
// *************************************************************************
function ThreadItemOnGetBoardURL(
	inInstance	: DWORD	// ThreadItem �̃C���X�^���X
) : PChar; stdcall;	 	// �� URL
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
