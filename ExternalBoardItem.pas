unit ExternalBoardItem;

interface

uses
	Windows, Classes, SysUtils,
	IdComponent,
	ExternalBoardPlugInMain;

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
	// TBoardItem ���������ꂽ
	// *************************************************************************
	TBoardItemCreate = procedure(
		inInstance : DWORD
	); stdcall;

	// *************************************************************************
	// TBoardItem ���j�����ꂽ
	// *************************************************************************
	TBoardItemDispose = procedure(
		inInstance : DWORD
	); stdcall;

	// *************************************************************************
	// �_�E�����[�h���w�����ꂽ
	// *************************************************************************
	TBoardItemOnDownload = function(
		inInstance	: DWORD					// �C���X�^���X
	) : TDownloadState; stdcall;	// �_�E�����[�h�������������ǂ���

	// *************************************************************************
	// �X�����Ă��w��
	// *************************************************************************
	TBoardItemOnCreateThread = function(
		inInstance	: DWORD;				// ThreadItem �̃C���X�^���X
		inSubject		: PChar;				// �X���^�C
		inName			: PChar;				// ���O(�n���h��)
		inMail			: PChar;				// ���[���A�h���X
		inMessage		: PChar					// �{��
	) : TDownloadState; stdcall;	// �������݂������������ǂ���

	// *************************************************************************
	// �e�X���̏���ԋp
	// *************************************************************************
	TBoardItemEnumThreadCallBack = function(
		inInstance	: DWORD;	// TBoardItem �̃C���X�^���X
		inURL				: PChar;	// �X���b�h�� URL
		inTitle			: PChar;	// �X���^�C
		inCount			: DWORD		// ���X�̐�
	) : Boolean; stdcall;		// �񋓂𑱂���Ȃ� True

	// *************************************************************************
	// ���̔ɕۗL���Ă���X�����
	// *************************************************************************
	TBoardItemOnEnumThread = procedure(
		inInstance	: DWORD;												// �C���X�^���X
		inCallBack	: TBoardItemEnumThreadCallBack	// �ԋp���ׂ��R�[���o�b�N
	); stdcall;

	// *************************************************************************
	// �t�@�C��������X���b�h�� URL ��v�����ꂽ
	// *************************************************************************
	TBoardItemOnFileName2ThreadURL = function(
		inInstance	: DWORD;												// �C���X�^���X
		inFileName	: PChar													// ���ɂȂ�t�@�C����
	) : PChar; stdcall;

implementation

uses ExternalBoardManager, GikoSystem, BoardGroup, MojuUtils;

// *************************************************************************
// TBoardItem �N���X�̃v���p�e�B���擾����
// *************************************************************************
function BoardItemGetLong(
	instance		: DWORD;
	propertyID	: TBoardItemProperty
) : DWORD; stdcall;
var
	boardItem : TBoard;
begin

	boardItem := TBoard( instance );
	case propertyID of
		bipContext:							// : DWORD				// ���R�ɐݒ肵�Ă����l
			Result := boardItem.Context;
		bipNo:									// : Integer			// �ԍ�
			Result := boardItem.No;
		bipTitle:								// : string				// �X���b�h�^�C�g��
			Result := DWORD( CreateResultString( boardItem.Title ) );
		bipRound:								// : Boolean			// ����t���O
			Result := DWORD( boardItem.Round );
		bipRoundName:						// : string				// ����
			Result := DWORD( CreateResultString( boardItem.RoundName ) );
		bipIsLogFile:						// : Boolean			// ���O���݃t���O
			Result := DWORD( boardItem.IsLogFile );
		bipUnRead:							// : Integer			// �X���b�h���ǐ�
			Result := DWORD( boardItem.UnRead );
		bipURL:									// : string				// �X���b�h���u���E�U�ŕ\������ۂ� URL
			Result := DWORD( CreateResultString( boardItem.URL ) );
		bipFilePath:															// ���̃X�����ۑ�����Ă���p�X
			Result := DWORD( CreateResultString( boardItem.FilePath ) );
		bipIs2ch:
			Result := DWORD( boardItem.Is2ch );
	else
		Result := 0;
	end;
end;

// *************************************************************************
// TBoardItem �N���X�̃v���p�e�B��ݒ肷��
// *************************************************************************
procedure BoardItemSetLong(
	instance		: DWORD;
	propertyID	: TBoardItemProperty;
	param : DWORD
); stdcall;
var
	boardItem	: TBoard;
begin

	boardItem := TBoard( instance );
	case propertyID of
		bipContext:							// : DWORD			// ���R�ɐݒ肵�Ă����l
			boardItem.Context			:= param;
		bipNo:									// : Integer		// �ԍ�
			boardItem.No						:= param;
		bipTitle:								// : string			// �X���b�h�^�C�g��
			boardItem.Title				:= string( PChar( param ) );
		bipRound:								// : Boolean		// ����t���O
			boardItem.Round				:= Boolean( param );
		bipRoundName:						// : string			// ����
			//boardItem.RoundName		:= string( PChar( param ) );
			boardItem.RoundName		:= PChar( param );
		bipIsLogFile:						// : Boolean		// ���O���݃t���O
			boardItem.IsLogFile		:= Boolean( param );
		bipUnRead:							// : Integer		// �X���b�h���ǐ�
			boardItem.UnRead				:= Integer( param );
		bipURL:									// : string			// �X���b�h���u���E�U�ŕ\������ۂ� URL
			boardItem.URL					:= string( PChar( param ) );
		bipFilePath:						// : string			// ���̃X�����ۑ�����Ă���p�X
			boardItem.FilePath			:= string( PChar( param ) );
		bipIs2ch:
			boardItem.Is2ch			:= Boolean( param );
	end;

end;

// *************************************************************************
// TBoardItem �N���X�̃v���p�e�B���擾����
// *************************************************************************
function BoardItemGetDouble(
	instance		: DWORD;
	propertyID	: TBoardItemProperty
) : Double; stdcall;
var
	boardItem : TBoard;
begin

	boardItem := TBoard( instance );
	case propertyID of
		bipRoundDate:						// : TDateTime	// �X���b�h���擾���������i��������j
			Result := boardItem.RoundDate;
		bipLastModified:				// : TDateTime	// �X���b�h���X�V����Ă�������i�T�[�o�������j
			Result := boardItem.LastModified;
		bipLastGetTime:					// : TDateTime	// �X���b�h�܂��̓X���b�h�ꗗ���Ō�ɍX�V���������i�T�[�o�������E�������ݎ��Ɏg�p����j
			Result := boardItem.LastGetTime;
	else
		Result := 0;
	end;

end;

// *************************************************************************
// TBoardItem �N���X�̃v���p�e�B��ݒ肷��
// *************************************************************************
procedure BoardItemSetDouble(
	instance		: DWORD;
	propertyID	: TBoardItemProperty;
	param				: Double
); stdcall;
var
	boardItem : TBoard;
begin

	boardItem := TBoard( instance );
	case propertyID of
		bipRoundDate:						// : TDateTime	// �X���b�h���擾���������i��������j
			boardItem.RoundDate		:= param;
		bipLastModified:				// : TDateTime	// �X���b�h���X�V����Ă�������i�T�[�o�������j
			boardItem.LastModified	:= param;
		bipLastGetTime:					// : TDateTime	// �X���b�h�܂��̓X���b�h�ꗗ���Ō�ɍX�V���������i�T�[�o�������E�������ݎ��Ɏg�p����j
			boardItem.LastGetTime	:= param;
	end;

end;

// *************************************************************************
// TBoardItem �N���X�Ɍq����Ă��� TThreadItem �N���X���擾����
// *************************************************************************
function BoardItemGetItems(
	instance	: DWORD;
	index			: Integer
) : DWORD; stdcall;
var
	boardItem : TBoard;
begin

	boardItem	:= TBoard( instance );
	Result		:= DWORD( boardItem.Items[ index ] );

end;

// *************************************************************************
// �̃_�E�����[�h���i�s����
// *************************************************************************
procedure BoardItemWork(
	inInstance	: DWORD;			// �N���X�̃C���X�^���X
	inWorkCount	: Integer			// ���݂̐i����(�J�E���g)
); stdcall;
begin

	if Assigned( OnWork ) then
		OnWork( TObject( inInstance ), wmRead, inWorkCount );

end;

// *************************************************************************
// �̃_�E�����[�h���n�܂���
// *************************************************************************
procedure BoardItemWorkBegin(
	inInstance			: DWORD;	// �N���X�̃C���X�^���X
	inWorkCountMax	: Integer	// �ʐM�̏I���������J�E���g
); stdcall;
begin

	if Assigned( OnWorkBegin ) then
		OnWorkBegin( TObject( inInstance ), wmRead, inWorkCountMax );

end;

// *************************************************************************
// �̃_�E�����[�h���I�����
// *************************************************************************
procedure BoardItemWorkEnd(
	inInstance	: DWORD				// �N���X�̃C���X�^���X
); stdcall;
begin

	if Assigned( OnWorkEnd ) then
		OnWorkEnd( TObject( inInstance ), wmRead );

end;

// *************************************************************************
// ���ۗL����X���ꗗ�̗񋓏������v���O�����{�̂ɔC���ꂽ
// *************************************************************************
procedure BoardItemEnumThread(
	inInstance		: DWORD;
	inCallBack		: TBoardItemEnumThreadCallBack;
	inSubjectText	: PChar
); stdcall;
var
	board					: TBoard;
	subject				: TStringList;
	i							: Integer;
	rec						: TSubjectRec;
	isContinue		: Boolean;
	threadURL		: string;
	template		: string;
begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.BoardItemEnumThread');
	{$ENDIF}
	try
		board		:= TBoard( inInstance );
		subject	:= TStringList.Create;
		try
			//FileName�ɂ���ĕω����镔����'(FILENAME!)'�Ƃ����A����������炤�B
			template := board.BoardPlugIn.FileName2ThreadURL( DWORD( board ), '(FILENAME!)' );
			subject.Text := inSubjectText;

			for i := 0 to subject.Count - 1 do begin
				rec						:= GikoSys.DivideSubject( subject[i] );
				rec.FFileName	:= Trim(rec.FFileName);
				if AnsiPos('.', rec.FFileName) > 0 then
					rec.FFileName := Copy(rec.FFileName, 1, AnsiPos('.', rec.FFileName) - 1);
				if (rec.FTitle = '') and (rec.FCount = 0) then
					Continue;

                //�e���v���[�g��'(FILENAME!)'��FileName�ɒu������
				threadURL := CustomStringReplace(template, '(FILENAME!)', Rec.FFileName);

				isContinue := inCallBack(
					inInstance,
					PChar( threadURL ),
					PChar( rec.FTitle ),
					DWORD( rec.FCount ) );

				if ( not isContinue ) then
					Break;
			end;
		finally
			subject.Free;
		end;
	except
	end;

end;

exports
	BoardItemGetLong,
	BoardItemSetLong,
	BoardItemGetDouble,
	BoardItemSetDouble,
	BoardItemGetItems,
	BoardItemEnumThread,
	BoardItemWork,
	BoardItemWorkBegin,
	BoardItemWorkEnd;

end.
