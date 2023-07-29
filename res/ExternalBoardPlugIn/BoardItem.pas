unit BoardItem;

{
	ExternalBoardPlugIn BoardItem
	����ێ����� TBoardItem �N���X
}

interface

uses
	Windows, SysUtils,
	PlugInMain, ThreadItem;

type
	// TBoardItem �̃v���p�e�B�ݒ�^�擾 ID
	TBoardItemProperty = (
		bipContext,							// : DWORD				// ���R�ɐݒ肵�Ă����l
		bipItems,								// : TThreadItem	// �Ɍq����Ă���X���b�h
		bipNo,									// : Integer			// �ԍ�
		bipTitle,								// : string				// �^�C�g��
		bipRoundDate,						// : TDateTime		// ���擾���������i��������j
		bipLastModified,				// : TDateTime		// ���X�V����Ă�������i�T�[�o�������j
		bipLastGetTime,					// : TDateTime		// �X���b�h�܂��̓X���b�h�ꗗ���Ō�ɍX�V���������i�T�[�o�������E�������ݎ��Ɏg�p����j
		bipRound,								// : Boolean			// ����\��
		bipRoundName,						// : string				// ����
		bipIsLogFile,						// : Boolean			// ���O���݃t���O
		bipUnRead,							// : Integer			// �X���b�h���ǐ�
		bipURL,									// : string				// ���u���E�U�ŕ\������ۂ� URL
		bipFilePath,							// : string				// ���̔��ۑ�����Ă���p�X
		bipIs2ch							// : Boolean		//�z�X�g��2ch���ǂ���
	);

	// *************************************************************************
	// �e�X���̏���ԋp
	// *************************************************************************
	TBoardItemEnumThreadCallBack = function(
		inInstance	: DWORD;	// TBoardItem �̃C���X�^���X
		inURL				: PChar;	// �X���b�h�� URL
		inTitle			: PChar;	// �X���^�C
		inCount			: DWORD		// ���X�̐�
	) : Boolean; stdcall;		// �񋓂𑱂���Ȃ� True



	// =========================================================================
	// TBoardItem �N���X�Ɋւ��� API
	// =========================================================================

	// *************************************************************************
	// BoardItemGetItems
	// TBoardItem �N���X�Ɍq����Ă��� TThreadItem �N���X���擾����
	// *************************************************************************
	TBoardItemGetItems = function(
		inInstance	: DWORD;	// TBoardItem �̃C���X�^���X
		inIndex			: Integer	// �擾���� TThreadItem �̃C���f�b�N�X
	) : DWORD; stdcall;			// TThreadItem �̃C���X�^���X

	// *************************************************************************
	// BoardItemGetLong
	// TBoardItem �N���X�̃v���p�e�B���擾����
	// *************************************************************************
	TBoardItemGetLong = function(
		inInstance		: DWORD;							// TBoardItem �̃C���X�^���X
		inPropertyID	: TBoardItemProperty	// �擾����v���p�e�B�̎��
	) : DWORD; stdcall;										// �߂�l(�Ӗ��� inPropertyID �ɂ���ĈقȂ�)

	// *************************************************************************
	// BoardItemSetLong
	// TBoardItem �N���X�̃v���p�e�B��ݒ肷��
	// *************************************************************************
	TBoardItemSetLong = procedure(
		inInstance		: DWORD;							// TBoardItem �̃C���X�^���X
		inPropertyID	: TBoardItemProperty;	// �ݒ肷��v���p�e�B�̎��
		inParam : DWORD											// �ݒ肷��l(�Ӗ��� inPropertyID �ɂ���ĈقȂ�)
	); stdcall;

	// *************************************************************************
	// BoardItemGetDouble
	// TBoardItem �N���X�̃v���p�e�B���擾����
	// *************************************************************************
	TBoardItemGetDouble = function(
		inInstance		: DWORD;							// TBoardItem �̃C���X�^���X
	inPropertyID	: TBoardItemProperty	// �擾����v���p�e�B�̎��
	) : Double; stdcall;									// �߂�l(�Ӗ��� inPropertyID �ɂ���ĈقȂ�)

	// *************************************************************************
	// BoardItemSetDouble
	// TBoardItem �N���X�̃v���p�e�B��ݒ肷��
	// *************************************************************************
	TBoardItemSetDouble = procedure(
		inInstance		: DWORD;							// TBoardItem �̃C���X�^���X
		inPropertyID	: TBoardItemProperty;	// �ݒ肷��v���p�e�B�̎��
		inParam				: Double							// �ݒ肷��l(�Ӗ��� inPropertyID �ɂ���ĈقȂ�)
	); stdcall;

	// *************************************************************************
	// ���ۗL����X���ꗗ�̗񋓏������v���O�����{�̂ɔC����
	// *************************************************************************
	TBoardItemEnumThread = procedure(
		inInstance		: DWORD;							// TBoardItem �̃C���X�^���X
		inCallBack		: TBoardItemEnumThreadCallBack;	// �X���̏���ԋp���郋�[�`��
		inSubjectText	: PChar								// �t�@�C����,�X���^�C(���X��) �ō\���������s��؂�e�L�X�g
	); stdcall;

	// *************************************************************************
	// BoardItemWork
	// �_�E�����[�h�̐i���󋵂��v���O�����{�̂ɓ`����
	// *************************************************************************
	TBoardItemWork = procedure(
		inInstance	: DWORD;			// TBoardItem �̃C���X�^���X
		inWorkCount	: DWORD				// ���݂̐i����(�J�E���g)
	); stdcall;

	// *************************************************************************
	// BoardItemWorkBegin
	// �_�E�����[�h���n�܂������Ƃ��v���O�����{�̂ɓ`����
	// *************************************************************************
	TBoardItemWorkBegin = procedure(
		inInstance			: DWORD;	// TBoardItem �̃C���X�^���X
		inWorkCountMax	: DWORD		// �ʐM�̏I���������J�E���g
	); stdcall;

	// *************************************************************************
	// BoardItemWorkEnd
	// �_�E�����[�h���I��������Ƃ��v���O�����{�̂ɓ`����
	// *************************************************************************
	TBoardItemWorkEnd = procedure(
		inInstance	: DWORD				// TBoardItem �̃C���X�^���X
	); stdcall;



	// =========================================================================
	// TBoardItem �N���X�Ɋւ���C�x���g
	// =========================================================================

	// *************************************************************************
	// TBoardItem ���������ꂽ
	// *************************************************************************
	TBoardItemOnCreateEvent = procedure(
		instance : DWORD
	);

	// *************************************************************************
	// TBoardItem ���j�����ꂽ
	// *************************************************************************
	TBoardItemOnDisposeEvent = procedure(
		instance : DWORD
	);

	// *************************************************************************
	// �_�E�����[�h���w�����ꂽ
	// *************************************************************************
	TBoardItemOnDownloadEvent = function : TDownloadState of object;

	// *************************************************************************
	// �X�����Ă��w�����ꂽ
	// *************************************************************************
	TBoardItemOnCreateThreadEvent = function(
		inSubject	: string;					// �X���^�C
		inName		: string;					// ���O(�n���h��)
		inMail		: string;					// ���[���A�h���X
		inMessage	: string					// �{��
	) : TDownloadState of object;	// �������݂������������ǂ���

	// *************************************************************************
	// ���̔ɂ����̃X�������邩�v�����ꂽ
	// *************************************************************************
	TBoardItemOnEnumThreadEvent = procedure(
		inCallBack : TBoardItemEnumThreadCallBack
	) of object;

	// *************************************************************************
	// �t�@�C��������X���b�h�� URL ��v�����ꂽ
	// *************************************************************************
	TBoardItemOnFileName2ThreadURLEvent = function(
		inFileName : string
	) : string of object;


	// =========================================================================
	// TBoardItem �N���X
	// =========================================================================
	TBoardItem = class(TObject)
	private
		// �N���X�̃C���X�^���X
		FInstance							: DWORD;

		// �_�E�����[�h���w�����ꂽ
		FOnDownload						: TBoardItemOnDownloadEvent;
		// �X�����Ă��w�����ꂽ
		FOnCreateThread				: TBoardItemOnCreateThreadEvent;
		// ���̔ɂ����̃X�������邩�v�����ꂽ
		FOnEnumThread					: TBoardItemOnEnumThreadEvent;
		// �t�@�C��������X���b�h�� URL ��v�����ꂽ
		FOnFileName2ThreadURL	: TBoardItemOnFileName2ThreadURLEvent;

	public
		// �R���X�g���N�^
		constructor Create( inInstance : DWORD );

		// ���ۗL����X���ꗗ�̗񋓏������v���O�����{�̂ɔC����
		procedure	EnumThread( inCallBack : TBoardItemEnumThreadCallBack; inSubjectText : string );
		// �_�E�����[�h�̐i���󋵂��v���O�����{�̂ɓ`����
		procedure	Work( inWorkCount : Integer );
		// �_�E�����[�h���n�܂������Ƃ��v���O�����{�̂ɓ`����
		procedure	WorkBegin( inWorkCountMax : Integer );
		// �_�E�����[�h���I��������Ƃ��v���O�����{�̂ɓ`����
		procedure	WorkEnd;

	private
		// ===== �v���p�e�B�̊Ǘ��𓝊����郉�b�p
		function	GetLong( propertyID : TBoardItemProperty ) : DWORD;
		procedure	SetLong( propertyID : TBoardItemProperty; param : DWORD );
		function	GetDouble( propertyID : TBoardItemProperty ) : Double;
		procedure	SetDouble( propertyID : TBoardItemProperty; param : Double );

		// ===== �v���p�e�B�̎擾�^�ݒ�𖖒[�ɒ񋟂��郉�b�p
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
		// ===== �C�x���g
		property	OnDownload			: TBoardItemOnDownloadEvent			read FOnDownload write FOnDownload;
		property	OnCreateThread	: TBoardItemOnCreateThreadEvent	read FOnCreateThread write FOnCreateThread;
		property	OnEnumThread		: TBoardItemOnEnumThreadEvent		read FOnEnumThread write FOnEnumThread;
		property	OnFileName2ThreadURL	: TBoardItemOnFileName2ThreadURLEvent	read FOnFileName2ThreadURL write FOnFileName2ThreadURL;

		// ===== ThreadItem �Ɏ擾�^�ݒ�\�ȃv���p�e�B
		// �Ɍq����Ă���X���b�h
		property	Items[index : Integer] : TThreadItem	read GetItems;
		// �ԍ�
		property	No						: Integer					read GetNo write SetNo;
		// �^�C�g��
		property	Title					: string					read GetTitle write SetTitle;
		// ���擾���������i��������j
		property	RoundDate			: TDateTime				read GetRoundDate write SetRoundDate;
		// ���X�V����Ă�������i�T�[�o�������j
		property	LastModified	: TDateTime				read GetLastModified write SetLastModified;
		// �X���b�h�܂��̓X���b�h�ꗗ���Ō�ɍX�V���������i�T�[�o�������E�������ݎ��Ɏg�p����j
		property	LastGetTime		: TDateTime				read GetLastGetTime write SetLastGetTime;
		// ����t���O
		property	Round					: Boolean					read GetRound write SetRound;
		// ����
		property	RoundName			: string					read GetRoundName write SetRoundName;
		// ���O���݃t���O
		property	IsLogFile			: Boolean					read GetIsLogFile write SetIsLogFile;
		// �X���b�h���ǐ�
		property	UnRead				: Integer					read GetUnRead write SetUnRead;
		// ���u���E�U�ŕ\������ۂ� URL
		property	URL						: string					read GetURL write SetURL;
		// ���̔��ۑ�����Ă���p�X
		property	FilePath			: string					read GetFilePath write SetFilePath;
		//�z�X�g��2ch���ǂ���
		property	Is2ch				: Boolean		read GetIs2ch write SetIs2ch;
	end;

var
	// ===== API �̃A�h���X
	BoardItemGetItems	 	: TBoardItemGetItems;
	BoardItemGetLong	 	: TBoardItemGetLong;
	BoardItemSetLong	 	: TBoardItemSetLong;
	BoardItemGetDouble 	: TBoardItemGetDouble;
	BoardItemSetDouble	: TBoardItemSetDouble;
	BoardItemEnumThread	: TBoardItemEnumThread;
	BoardItemWork			 	: TBoardItemWork;
	BoardItemWorkBegin 	: TBoardItemWorkBegin;
	BoardItemWorkEnd	 	: TBoardItemWorkEnd;
	// ===== �C�x���g�n���h��
	BoardItemOnCreate	 	: TBoardItemOnCreateEvent;
	BoardItemOnDispose 	: TBoardItemOnDisposeEvent;

// ===== TBoardItem �N���X���Ǘ�����֐�
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
// TBoardItem �̃R���X�g���N�^
// *************************************************************************
constructor TBoardItem.Create(
	inInstance : DWORD											// �C���X�^���X
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
// ���ۗL����X���ꗗ�̗񋓏������v���O�����{�̂ɔC����
// *************************************************************************
procedure	TBoardItem.EnumThread(
	inCallBack		: TBoardItemEnumThreadCallBack;
	inSubjectText	: string	// �t�@�C����<>�X���^�C �ō\�����ꂽ���s��؂�e�L�X�g
);
begin

	BoardItemEnumThread( FInstance, inCallBack, PChar( inSubjectText ) );

end;

// *************************************************************************
// �_�E�����[�h�̐i���󋵂��v���O�����{�̂ɓ`����
// *************************************************************************
procedure	TBoardItem.Work(
	inWorkCount : Integer			// ���݂̐i����(�J�E���g)
);
begin

	BoardItemWork( FInstance, inWorkCount );

end;

// *************************************************************************
// �_�E�����[�h���n�܂������Ƃ��v���O�����{�̂ɓ`����
// *************************************************************************
procedure	TBoardItem.WorkBegin(
	inWorkCountMax : Integer	// �ʐM�̏I���������J�E���g
);
begin

	BoardItemWorkBegin( FInstance, inWorkCountMax );

end;

// *************************************************************************
// �_�E�����[�h���I��������Ƃ��v���O�����{�̂ɓ`����
// *************************************************************************
procedure	TBoardItem.WorkEnd;
begin

	BoardItemWorkEnd( FInstance );

end;



// =========================================================================
// TBoardItem �̃v���p�e�B�̊Ǘ��𓝊����郉�b�p
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
// ���������火
// TBoardItem �̃v���p�e�B�̎擾�^�ݒ�𖖒[�ɒ񋟂��郉�b�p
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
// TBoardItem �̃v���p�e�B�̎擾�^�ݒ�𖖒[�ɒ񋟂��郉�b�p
// �������܂Ł�
// =========================================================================




// =========================================================================
// TBoardItem �N���X���Ǘ�����֐�
// =========================================================================

// *************************************************************************
// TBoardItem ���������ꂽ�ꍇ�̃f�t�H���g�̏��u(TBoardItem �𐶐�����)
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
// TBoardItem ���j�����ꂽ�ꍇ�̃f�t�H���g�̏��u(TBoardItem ��j������)
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
// PlugInSDK �� TBoardItem �Ɋւ��� API ��������
// *************************************************************************
procedure LoadInternalBoardItemAPI(
	inModule : HMODULE
);
begin

	// ===== �C���X�^���X�̃f�t�H���g�̎�舵���� TBoardItem �ɂ���
	BoardItemOnCreate	:= BoardItemOnCreateOfTBoardItem;
	BoardItemOnDispose	:= BoardItemOnDisposeOfTBoardItem;

	// ===== TBoardItem �v���p�e�B�擾�ݒ�֐�
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
// TBoardItem �N���X�Ɋւ���C�x���g
// =========================================================================

// *************************************************************************
// TBoardItem ���������ꂽ
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
// TBoardItem ���j�����ꂽ
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
// �_�E�����[�h���w�����ꂽ
// *************************************************************************
function BoardItemOnDownload(
	inInstance	: DWORD					// �C���X�^���X
) : TDownloadState; stdcall;	// �_�E�����[�h�������������ǂ���
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
// �X�����Ă��w�����ꂽ
// *************************************************************************
function	BoardItemOnCreateThread(
	inInstance	: DWORD;				// BoardItem �̃C���X�^���X
	inSubject		: PChar;				// �X���^�C
	inName			: PChar;				// ���O(�n���h��)
	inMail			: PChar;				// ���[���A�h���X
	inMessage		: PChar					// �{��
) : TDownloadState; stdcall;	// �������݂������������ǂ���
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
// ���̔ɂ����̃X�������邩�v�����ꂽ
// *************************************************************************
procedure BoardItemOnEnumThread(
	inInstance	: DWORD;												// �C���X�^���X
	inCallBack	: TBoardItemEnumThreadCallBack	// �ԋp���ׂ��R�[���o�b�N
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
// �t�@�C��������X���b�h�� URL ��v�����ꂽ
// *************************************************************************
function BoardItemOnFileName2ThreadURL(
	inInstance	: DWORD;												// �C���X�^���X
	inFileName	: PChar													// ���ɂȂ�t�@�C����
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
