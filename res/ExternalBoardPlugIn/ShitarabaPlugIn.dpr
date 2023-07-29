library ShitarabaPlugIn;

{
	ShitarabaPlugIn
	������Ώ������j�b�g
	$Id: ShitarabaPlugIn.dpr,v 1.46 2005/06/25 11:27:56 h677 Exp $
}

uses
	Windows, SysUtils, Classes, Math, DateUtils,
	IdURI,
	PlugInMain in 'PlugInMain.pas',
	ThreadItem in 'ThreadItem.pas',
	BoardItem in 'BoardItem.pas',
	FilePath in 'FilePath.pas',
	Y_TextConverter in 'Y_TextConverter.pas',
    MojuUtils in '..\..\MojuUtils.pas';

{$R *.res}

type
	// =========================================================================
	// TShitarabaThreadItem
	// =========================================================================
	TShitarabaThreadItem = class(TThreadItem)
	private
		FIsTemporary	: Boolean;
		FDat					: TStringList;

	public
		constructor	Create( inInstance : DWORD );
		destructor	Destroy; override;

	private
		function	Download : TDownloadState;
		function	Write( inName : string; inMail : string; inMessage : string ) : TDownloadState;
		function	GetRes( inNo : Integer ) : string;
        function	GetDat( inNo : Integer ) : string;
		function	GetHeader( inOptionalHeader : string ) : string;
		function	GetFooter( inOptionalFooter : string ) : string;
		function	GetBoardURL : string;

		procedure	LoadDat;
		procedure	FreeDat;
		function	ReadURL : string;
	end;

	// =========================================================================
	// TShitarabaBoardItem
	// =========================================================================
	TShitarabaBoardItem = class(TBoardItem)
	private
		FIsTemporary	: Boolean;
		FDat					: TStringList;

	public
		constructor	Create( inInstance : DWORD );
		destructor	Destroy; override;

	private
		function	Download : TDownloadState;
		function	CreateThread( inSubject : string; inName : string; inMail : string; inMessage : string ) : TDownloadState;
		function	ToThreadURL( inFileName : string ) : string;
		procedure	EnumThread( inCallBack : TBoardItemEnumThreadCallBack );

		function	SubjectURL : string;
	end;

const
	LOG_DIR						= 'Shitaraba\';
	SUBJECT_NAME			= 'subject.txt';

	PLUGIN_NAME				= 'Shitaraba';
	MAJOR_VERSION			= 1;
	MINOR_VERSION			= 0;
	RELEASE_VERSION		= 'final';
	REVISION_VERSION	= 1;

// =========================================================================
// �G�p�֐�
// =========================================================================

// *************************************************************************
// �e���|�����ȃp�X�̎擾
// *************************************************************************
function TemporaryFile : string;
var
	tempPath : array [0..MAX_PATH] of	char;
begin

	GetTempPath( SizeOf(tempPath), tempPath );
	repeat
		Result := tempPath + IntToStr( Random( $7fffffff ) );
	until not FileExists( Result );

end;

// *************************************************************************
// ������Ηp���O�t�H���_�擾
// *************************************************************************
function MyLogFolder : string;
var
	folder : PChar;
begin

	folder := LogFolder;
	if Length( folder ) = 0 then
		Result := ''
	else
		Result := folder + LOG_DIR;
    DisposeResultString(folder);
end;

(*************************************************************************
 *�f�B���N�g�������݂��邩�`�F�b�N
 *************************************************************************)
function DirectoryExistsEx(const Name: string): Boolean;
var
	Code: Integer;
begin
	Code := GetFileAttributes(PChar(Name));
	Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

(*************************************************************************
 *�f�B���N�g���쐬�i�����K�w�Ή��j
 *************************************************************************)
function ForceDirectoriesEx(Dir: string): Boolean;
begin
	Result := True;
	if Length(Dir) = 0 then
		raise Exception.Create('�t�H���_���쐬�o���܂���');
	Dir := ExcludeTrailingPathDelimiter(Dir);
	if (Length(Dir) < 3) or DirectoryExistsEx(Dir)
		or (ExtractFilePath(Dir) = Dir) then Exit; // avoid 'xyz:\' problem.
	Result := ForceDirectoriesEx(ExtractFilePath(Dir)) and CreateDir(Dir);
end;

// �Ƃ肠�����̑�p�i�Ȃ̂� chrWhite ���l�����Ă��Ȃ����Ƃɒ��ӁI�I�I
procedure ExtractHttpFields(
	const chrSep : TSysCharSet;
	const chrWhite : TSysCharSet;
	const strValue : string;
	var strResult : TStringList;
	unknownFlag : boolean = false
);
var
	last, p, strLen : Integer;
begin

	strLen := Length( strValue );
	p := 1;
	last := 1;

	while p <= strLen do
	begin

		if strValue[ p ] in chrSep then
		begin
			strResult.Add( Copy( strValue, last, p - last ) );
			last := p + 1;
		end;

		p := p + 1;

	end;

	if last <> p then
		strResult.Add( Copy( strValue, last, strLen - last + 1 ) );

end;

function HttpEncode(
	const strValue : string
) : string;
var
	i : Integer;
	strLen : Integer;
	strResult : string;
	b : Integer;
const
	kHexCode : array [0..15] of char = (
				'0', '1', '2', '3', '4', '5', '6', '7',
				'8', '9', 'A', 'B', 'C', 'D', 'E', 'F' );
begin

	strLen := Length( strValue );
	i := 1;

	while i <= strLen do
	begin

		case strValue[ i ] of
		'0' .. '9', 'a' .. 'z', 'A' .. 'Z', '*', '-', '.', '@', '_':
			begin
				strResult := strResult + strValue[ i ];
			end;
		else
			begin
				b := Integer( strValue[ i ] );
				strResult := strResult + '%'
								+ kHexCode[ b div $10 ]
								+ kHexCode[ b mod $10 ];
			end;
		end;

		i := i + 1;

	end;

	Result := strResult;

end;



// =========================================================================
// PlugIn
// =========================================================================

// *************************************************************************
// �v���O�C���̃o�[�W������v�����ꂽ
// *************************************************************************
procedure OnVersionInfo(
	var outAgent		: PChar;	// �o�[�W��������؊܂܂Ȃ������Ȗ���
	var outMajor		: DWORD;	// ���W���[�o�[�W����
	var outMinor		: DWORD;	// �}�C�i�[�o�[�W����
	var outRelease	: PChar;	// �����[�X�i�K��
	var outRevision	: DWORD		// ���r�W�����i���o�[
); stdcall;
begin

	try
		outAgent		:= CreateResultString( PChar( PLUGIN_NAME ) );
		outMajor		:= MAJOR_VERSION;
		outMinor		:= MINOR_VERSION;
		outRelease	:= CreateResultString( PChar( RELEASE_VERSION ) );
		outRevision	:= REVISION_VERSION;
	except
		outAgent		:= nil;
		outMajor		:= 0;
		outMinor		:= 0;
		outRelease	:= nil;
		outRevision	:= 0;
	end;

end;

// *************************************************************************
// �w�肵�� URL �����̃v���O�C���Ŏ󂯕t���邩�ǂ���
// *************************************************************************
function OnAcceptURL(
	inURL			: PChar				// ���f�����ł��� URL
): TAcceptType; stdcall;	// URL �̎��
var
	uri				: TIdURI;
	uriList		: TStringList;
	foundPos	: Integer;
const
	BBS_HOST		= 'www.shitaraba.com';
	THREAD_MARK	= '/cgi-bin/read.cgi?';
begin

	try
		// �z�X�g���� www.shitaraba.com �ŏI���ꍇ�͎󂯕t����悤�ɂ��Ă���
		uri			:= TIdURI.Create( inURL );
		uriList	:= TStringList.Create;
		try
	 		ExtractHttpFields( ['/'], [], uri.Path, uriList );
			foundPos := AnsiPos( BBS_HOST, uri.Host );
			if (foundPos > 0) and (Length( uri.Host ) - foundPos + 1 = Length( BBS_HOST )) then begin
				foundPos := AnsiPos( THREAD_MARK, inURL );
				if foundPos > 0 then
					Result := atThread
				else if (uriList.Count > 1) and (uri.Path <> '/') then	// �Ōオ '/' �ŕ߂��Ă�Ȃ� 3
					Result := atBoard
				else
					Result := atBBS;
			end else begin
				Result := atNoAccept;
			end;
		finally
			uri.Free;
			uriList.Free;
		end;
	except
		Result := atNoAccept;
	end;

end;



// =========================================================================
// TShitarabaThreadItem
// =========================================================================

// *************************************************************************
// �R���X�g���N�^
// *************************************************************************
constructor TShitarabaThreadItem.Create(
	inInstance	: DWORD
);
var
	uri					: TIdURI;
	uriList			: TStringList;
begin

	inherited;

	OnDownload		:= Download;
	OnWrite				:= Write;
	OnGetRes			:= GetRes;
    OnGetDat			:= GetDat;
	OnGetHeader		:= GetHeader;
	OnGetFooter		:= GetFooter;
	OnGetBoardURL	:= GetBoardURL;

	FilePath			:= '';
	FIsTemporary	:= False;
	FDat					:= nil;
	URL						:= ReadURL + '&ls=100';

	uri			:= TIdURI.Create( URL );
	uriList := TStringList.Create;
	try
		// http://www.shitaraba.com/cgi-bin/read.cgi?key=1032678843_1&bbs=jbbs
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );
		FileName	:= uriList.Values[ 'key' ] + '.dat';
		FilePath	:= MyLogFolder + uriList.Values[ 'bbs' ] + '\' + uriList.Values[ 'key' ] + '.dat';
		IsLogFile	:= FileExists( FilePath );
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// �f�X�g���N�^
// *************************************************************************
destructor TShitarabaThreadItem.Destroy;
begin

	FreeDat;

	// �ꎞ�t�@�C���̏ꍇ�͍폜����
	if FIsTemporary then
		DeleteFile( FilePath );

	inherited;

end;

// *************************************************************************
// �w�肵�� URL �̃X���b�h�̃_�E�����[�h���w�����ꂽ
// *************************************************************************
function TShitarabaThreadItem.Download : TDownloadState;
var
	modified			: Double;
	tmp, tmp2			: PChar;
	tmpLen				: Integer;
	responseCode	: Longint;
	logStream			: TFileStream;
	uri						: TIdURI;
	uriList				: TStringList;
	datURL				: string;
	downResult		: TStringList;
    tmpText : String;
const
	LF						= #10;
begin

	Result := dsError;

	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
		// http://www.shitaraba.com/cgi-bin/read.cgi?key=1032678843_1&bbs=jbbs
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );
		FileName := uriList.Values[ 'key' ] + '.dat';
		if MyLogFolder = '' then begin
			// �ǂ��ɕۑ����Ă����̂�������Ȃ��̂ňꎞ�t�@�C���ɕۑ�
			FilePath 			:= TemporaryFile;
			FIsTemporary	:= True;
		end else begin
			FilePath	:= MyLogFolder + uriList.Values[ 'bbs' ] + '\' + uriList.Values[ 'key' ] + '.dat';
			FIsTemporary	:= False;
		end;

		// �ۑ��p�̃f�B���N�g�����@��
		ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

		if FileExists( FilePath ) then
			logStream := TFileStream.Create( FilePath, fmOpenReadWrite or fmShareDenyWrite )
		else
			logStream := TFileStream.Create( FilePath, fmCreate or fmShareDenyWrite );
		try
			// �Ǝ��Ƀ_�E�����[�h��t�B���^�����O���s��Ȃ��ꍇ��
			// InternalDownload �ɔC���邱�Ƃ��o����
			modified	:= LastModified;
			// http://www.shitaraba.com/cgi-bin/read.cgi?key=1032678843_1&bbs=jbbs
			// http://www.shitaraba.com/bbs/jbbs/dat/1032678843_1.dat
			datURL		:=
				uri.Protocol + '://' + uri.Host + '/bbs/' +
				uriList.Values[ 'bbs' ] + '/dat/' + uriList.Values[ 'key' ] + '.dat';
			// ���ځ[��`�F�b�N�̂��� 1 �o�C�g�O����擾����
			// �����O�ƎI�� dat �͉��s�R�[�h���Ⴄ���߃t�@�C���T�C�Y���ς���Ă��邱�Ƃɒ���
			responseCode := InternalDownload( PChar( datURL ), modified, tmp, Max( 0, Size - 1 ) );

			try
				if (responseCode = 200) or (responseCode = 206) then begin
					downResult := TStringList.Create;
					try
						tmpLen					:= StrLen( tmp );

						if Count = 0 then begin
							Result := dsComplete;
                            tmpText := CustomStringReplace( string( tmp ), '����', ',');
							downResult.Text			:= EUCtoSJIS( string( tmpText ) );
							logStream.Position	:= logStream.Size;
							logStream.Write( PChar( downResult.Text )^, Length( downResult.Text ) );

							NewReceive		:= Count + 1;
							Count					:= Count + downResult.Count;
							NewResCount		:= downResult.Count;
							Size					:= tmpLen;
						end else if LF = tmp^ then begin
							// �V�K�A�܂��͒ǋL
							Result := dsDiffComplete;
                            tmpText := CustomStringReplace( string( tmp + 1 ), '����', ',');
							downResult.Text			:= EUCtoSJIS( string( tmpText ) );
							logStream.Position	:= logStream.Size;
							logStream.Write( PChar( downResult.Text )^, Length( downResult.Text ) );

							NewReceive		:= Count + 1;
							Count					:= Count + downResult.Count;
							NewResCount		:= downResult.Count;
							Size					:= Size + tmpLen - 1;
						end else begin
							// ���ځ[��
							Result := dsDiffComplete;
							// �Ď擾
							modified			:= LastModified;
							responseCode	:= InternalDownload(
								PChar( datURL ), modified, tmp2, 0, Size );
                            tmpText := CustomStringReplace( string( tmp2 ) + string( tmp ), '����', ',');
							downResult.Text	:= EUCtoSJIS( tmpText );
							logStream.Position := 0;
							logStream.Write( PChar( downResult.Text )^, Length( downResult.Text ) );

							LastModified	:= modified;
							if downResult.Count > Count then
								NewReceive := Count + 1
							else
								NewReceive := 1;
							Count					:= downResult.Count;
							NewResCount		:= Count - NewReceive + 1;
							Size					:= StrLen( tmp2 ) + tmpLen;
						end;

						LastModified	:= modified;
					finally
						downResult.Free;
					end;
				end else if responseCode = 304 then begin
					Result := dsNotModify;
				end;
			finally
				DisposeResultString( tmp );
			end;
		finally
			logStream.Free;
		end;
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// �������݂��w�����ꂽ
// *************************************************************************
function	TShitarabaThreadItem.Write(
	inName				: string;	// ���O(�n���h��)
	inMail				: string;	// ���[���A�h���X
	inMessage			: string	// �{��
) : TDownloadState;				// �������݂������������ǂ���
var
	postData			: string;
	postResult		: PChar;
	uri						: TIdURI;
	uriList				: TStringList;
begin

	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );

		// http://cgi.shitaraba.com/cgi-bin/bbs.cgi
		postData	:=
			'FROM='			+ HttpEncode( SJIStoEUC( inName ) ) +
			'&mail='		+ HttpEncode( SJIStoEUC( inMail ) ) +
			'&MESSAGE='	+ HttpEncode( SJIStoEUC( inMessage ) ) +
			'&BBS='			+ uriList.Values[ 'bbs' ] +
			'&KEY='			+ uriList.Values[ 'key' ] +
			'&submit='	+ HttpEncode( SJIStoEUC( '��������' ) );

		// �Ǝ��ɒʐM���Ȃ��ꍇ�� InternalPost �ɔC���邱�Ƃ��o����
		InternalPost( PChar( 'http://cgi.shitaraba.com/cgi-bin/bbs.cgi' ), PChar( postData ), PChar(URL), postResult );
		DisposeResultString( postResult );

		Result := dsComplete
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// ���X�ԍ� inNo �ɑ΂��� html ��v�����ꂽ
// *************************************************************************
function TShitarabaThreadItem.GetRes(
	inNo		: Integer		// �v�����ꂽ���X�ԍ�
) : string;						// �Ή����� HTML
var
	res		 	: string;
	tmp			: PChar;
begin

	// �Ǝ��Ƀt�B���^�����O���s��Ȃ��ꍇ��
	// InternalAbon ����� Dat2HTML �ɔC���邱�Ƃ��o����
	LoadDat;
	if FDat = nil then begin
		// ���O�ɑ��݂��Ȃ��̂ł��̂܂܏I��
		Result := '';
		Exit;
	end;

    res := FDat[ inNo - 1 ];
    tmp := InternalAbonForOne( PChar( res ), PChar( FilePath ),inNo );
    try
		Result := Dat2HTML( string( tmp ), inNo );
	finally
		DisposeResultString( tmp );
	end;

end;

// *************************************************************************
// ���X�ԍ� inNo �ɑ΂��� Dat ��v�����ꂽ
// *************************************************************************
function TShitarabaThreadItem.GetDat(
	inNo		: Integer		// �v�����ꂽ���X�ԍ�
) : string;                     // �Q�����˂��Dat�`��
var
	tmp: PChar;
begin
	tmp := nil;
	LoadDat;
	if FDat = nil then begin
		// ���O�ɑ��݂��Ȃ��̂ł��̂܂܏I��
		tmp := CreateResultString('');
		Result := string(tmp);
		DisposeResultString(tmp);
		Exit;
	end;
	try
		tmp := CreateResultString( FDat[ inNo - 1 ] );
		Result := string(tmp);
	finally
		DisposeResultString(tmp);
	end;

end;

// *************************************************************************
// �X���b�h�̃w�b�_ html ��v�����ꂽ
// *************************************************************************
function TShitarabaThreadItem.GetHeader(
	inOptionalHeader	: string
) : string;
begin

	// �Ǝ��Ƀt�B���^�����O���s��Ȃ��ꍇ��
	// InternalHeader �ɔC���邱�Ƃ��o����
	Result := InternalHeader(
		'<meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">' +
		inOptionalHeader );


	// GetRes ���Ă΂�邱�Ƃ��\�z�����̂� FDat �𐶐����Ă���
	try
		FreeDat;
		LoadDat;
	except
	end;

end;

// *************************************************************************
// �X���b�h�̃t�b�^ html ��v�����ꂽ
// *************************************************************************
function TShitarabaThreadItem.GetFooter(
	inOptionalFooter : string
) : string;
begin

	// �Ǝ��Ƀt�B���^�����O���s��Ȃ��ꍇ��
	// InternalFooter �ɔC���邱�Ƃ��o����
	Result := InternalFooter( inOptionalFooter );

	// ���� GetRes �͌Ă΂�Ȃ��Ǝv���̂� FDat ���J�����Ă���
	try
		FreeDat;
	except
	end;

end;

// *************************************************************************
// ���� ThreadItem ��������� URL ��v�����ꂽ
// *************************************************************************
function	TShitarabaThreadItem.GetBoardURL : string;
var
	uri						: TIdURI;
	uriList				: TStringList;
	tmp :	PChar;
begin

	uri			:= TIdURI.Create( URL );
	uriList := TStringList.Create;
	try
		// http://www.shitaraba.com/cgi-bin/read.cgi?key=1032678843_1&bbs=jbbs
		// http://www.shitaraba.com/bbs/jbbs/
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );
		FileName := uriList.Values[ 'key' ] + '.dat';
		tmp		:= CreateResultString(
			uri.Protocol + '://' + uri.Host + '/bbs/' + uriList.Values[ 'bbs' ] + '/' );
		Result := string(tmp);
        DisposeResultString(tmp);
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// FDat �̐���
// *************************************************************************
procedure	TShitarabaThreadItem.LoadDat;
begin

	if FDat = nil then begin
		if IsLogFile then begin
			// dat �̓ǂݍ���
			FDat := TStringList.Create;
			FDat.LoadFromFile( FilePath );
		end;
	end;

end;

// *************************************************************************
// FDat �̊J��
// *************************************************************************
procedure	TShitarabaThreadItem.FreeDat;
begin

	if FDat <> nil then begin
		FDat.Free;
		FDat := nil;
	end;

end;

// *************************************************************************
// ���S��( '/' �ŏI��� )�ǂݍ��݂� URL
// *************************************************************************
function	TShitarabaThreadItem.ReadURL : string;
var
	uri				: TIdURI;
	uriList		: TStringList;
	foundPos	: Integer;
begin

	foundPos := AnsiPos( '?', URL );
	if foundPos > 0 then begin
		uri := TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['&'], [], Copy( URL, foundPos + 1, MaxInt ), uriList );
			// http://www.shitaraba.com/cgi-bin/read.cgi?key=1032678843_1&bbs=jbbs
			Result :=
				uri.Protocol + '://' + uri.Host + '/cgi-bin/read.cgi?' +
				'bbs=' + uriList.Values[ 'BBS' ] + '&key=' + uriList.Values[ 'KEY' ];
		finally
			uri.Free;
			uriList.Free;
		end;
	end;

end;

// *************************************************************************
// TThreadItem ���������ꂽ�ꍇ�̏��u(TShitarabaThreadItem �𐶐�����)
// *************************************************************************
procedure ThreadItemOnCreateOfTShitarabaThreadItem(
	inInstance : DWORD
);
var
	threadItem : TShitarabaThreadItem;
begin

	threadItem := TShitarabaThreadItem.Create( inInstance );
	ThreadItemSetLong( inInstance, tipContext, DWORD( threadItem ) );

end;

// *************************************************************************
// TThreadItem ���j�����ꂽ�ꍇ�̏��u(TShitarabaThreadItem ��j������)
// *************************************************************************
procedure ThreadItemOnDisposeOfTShitarabaThreadItem(
	inInstance : DWORD
);
var
	threadItem : TShitarabaThreadItem;
begin

	threadItem := TShitarabaThreadItem( ThreadItemGetLong( inInstance, tipContext ) );
	threadItem.Free;

end;

// =========================================================================
// TShitarabaBoardItem
// =========================================================================

// *************************************************************************
// �R���X�g���N�^
// *************************************************************************
constructor TShitarabaBoardItem.Create(
	inInstance	: DWORD
);
var
	uri					: TIdURI;
	uriList			: TStringList;
begin

	inherited;

	OnDownload						:= Download;
	OnCreateThread				:= CreateThread;
	OnEnumThread					:= EnumThread;
	OnFileName2ThreadURL	:= ToThreadURL;

	FilePath			:= '';
	FIsTemporary	:= False;
	FDat					:= nil;

	uri			:= TIdURI.Create( SubjectURL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		// http://www.shitaraba.com/bbs/jbbs/
		FilePath	:= MyLogFolder + uriList[ 2 ] + '\' + uri.Document;
		IsLogFile	:= FileExists( FilePath );
	finally
		uri.Free;
		uriList.Free;
	end;

end;
 
// *************************************************************************
// �f�X�g���N�^
// *************************************************************************
destructor TShitarabaBoardItem.Destroy;
begin

	if FDat <> nil then begin
		try
			FDat.Free;
			FDat := nil;
		except
		end;
	end;

	// �ꎞ�t�@�C���̏ꍇ�͍폜����
	if FIsTemporary then
		DeleteFile( FilePath );

	inherited;

end;

// *************************************************************************
// �w�肵���X���ꗗ�̃_�E�����[�h��v�����ꂽ
// *************************************************************************
function TShitarabaBoardItem.Download : TDownloadState;
var
	modified			: Double;
	downResult		: PChar;
	responseCode	: Longint;
	uri						: TIdURI;
	uriList				: TStringList;
    tmpText : String;
begin

	Result := dsError;

	if FDat <> nil then begin
		try
			FDat.Free;
			FDat := nil;
		except
		end;
	end;
	FDat	 	:= TStringList.Create;
	uri		 	:= TIdURI.Create( SubjectURL );
	uriList	:= TStringList.Create;
	// �Ǝ��Ƀ_�E�����[�h��t�B���^�����O���s��Ȃ��ꍇ��
	// InternalDownload �ɔC���邱�Ƃ��o����
	modified			:= LastModified;
	responseCode	:= InternalDownload( PChar( uri.URI ), modified, downResult );
	try
		if responseCode = 200 then begin
			try
				// �p�X���Z�o
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				if MyLogFolder = '' then begin
					// �ǂ��ɕۑ����Ă����̂�������Ȃ��̂ňꎞ�t�@�C���ɕۑ�
					FilePath 			:= TemporaryFile;
					FIsTemporary	:= True;
				end else begin
					FilePath			:= MyLogFolder + uriList[ 2 ] + '\' + uri.Document;
					FIsTemporary	:= False
				end;

				// �ۑ��p�̃f�B���N�g�����@��
				ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

				// EUC �� Shift_JIS ��
                tmpText := CustomStringReplace( string( downResult ), '����', ',');
				FDat.Text := EUCtoSJIS( tmpText );
				// �ۑ�
				FDat.SaveToFile( FilePath );

				IsLogFile			:= True;
				RoundDate			:= Now;
				LastModified	:= modified;
				LastGetTime		:= Now;
			finally
				uri.Free;
				uriList.Free;
			end;
			Result := dsComplete;
		end;
	finally
		DisposeResultString( downResult );
	end;

end;

// *************************************************************************
// �X�����Ă��w�����ꂽ
// *************************************************************************
function	TShitarabaBoardItem.CreateThread(
	inSubject			: string;	// �X���^�C
	inName				: string;	// ���O(�n���h��)
	inMail				: string;	// ���[���A�h���X
	inMessage			: string	// �{��
) : TDownloadState;				// �������݂������������ǂ���
var
	postURL				: string;
	postData			: string;
	postResult		: PChar;
	uri						: TIdURI;
	uriList				: TStringList;
begin

	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

		postURL		:= 'http://cgi.shitaraba.com/cgi-bin/bbs.cgi';
		postData	:=
			'subject='	+ HttpEncode( SJIStoEUC( inSubject ) ) +
			'&FROM='		+ HttpEncode( SJIStoEUC( inName ) ) +
			'&mail='		+ HttpEncode( SJIStoEUC( inMail ) ) +
			'&MESSAGE='	+ HttpEncode( SJIStoEUC( inMessage ) ) +
			'&bbs='			+ uriList[ 2 ] +
			'&submit='	+ HttpEncode( SJIStoEUC( '�V�K�X���b�h�쐬' ) );

		// �Ǝ��ɒʐM���Ȃ��ꍇ�� InternalPost �ɔC���邱�Ƃ��o����
		InternalPost( PChar( postURL ), PChar( postData ), PChar(URL), postResult );
		DisposeResultString( postResult );

		Result := dsComplete
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// �X���ꗗ�� URL ����X���b�h�� URL �𓱂��o��
// *************************************************************************
function TShitarabaBoardItem.ToThreadURL(
	inFileName	: string	// �X���b�h�t�@�C����
) : string;							// �X���b�h�� URL
var
	threadURL		: string;
	uri					: TIdURI;
	uriList			: TStringList;
	found				: Integer;
begin

	found := AnsiPos( '.', inFileName );
	if found > 0 then
		inFileName := Copy( inFileName, 1, found - 1 );

	uri			:= TIdURI.Create( SubjectURL );
	uriList	:= TStringList.Create;
	try
		try
			// http://www.shitaraba.com/cgi-bin/read.cgi?key=1032678843_1&bbs=jbbs
			// http://www.shitaraba.com/bbs/jbbs/
			ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
			threadURL	:= uri.Protocol + '://' + uri.Host + '/cgi-bin/read.cgi?' +
				'bbs=' + uriList[ 2 ] + '&key=' + inFileName + '&ls=100';
			Result		:= threadURL;
		finally
			uri.Free;
			uriList.Free;
		end;
	except
		Result := '';
	end;

end;

// *************************************************************************
// ���̔ɂ����̃X�������邩�v�����ꂽ
// *************************************************************************
procedure	TShitarabaBoardItem.EnumThread(
	inCallBack	: TBoardItemEnumThreadCallBack
);
var
	uri		 			: TIdURI;
	uriList			: TStringList;
	i, bound		: Integer;
	lineRec			: TStringList;
begin

	try
		if FDat = nil then begin
			FDat		:= TStringList.Create;
			uri			:= TIdURI.Create( SubjectURL );
			uriList	:= TStringList.Create;
			try
				// �p�X���Z�o
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				FilePath	:= MyLogFolder + uriList[ 2 ] + '\' + uri.Document;
				if FileExists( FilePath ) then
					// �ǂݍ���
					FDat.LoadFromFile( FilePath );
			finally
				uri.Free;
				uriList.Free;
			end;
		end;

		lineRec := TStringList.Create;
		try
			bound := FDat.Count - 1;
			for i := 0 to bound do begin
				lineRec.Text := CustomStringReplace( FDat[ i ], '<>', #10 );
								//StringReplace( FDat[ i ], '<>', #10, [ rfReplaceAll ] );
				if not inCallBack(
					Instance,
					PChar( ToThreadURL( lineRec[ 0 ] ) ),
					PChar( lineRec[ 1 ] ),
					StrToInt( lineRec[ 2 ] ) ) then
					Break;
			end;
		finally
			lineRec.Free;
		end;
	except
	end;

end;

// *************************************************************************
// �X���ꗗ�� URL �����߂�
// *************************************************************************
function	TShitarabaBoardItem.SubjectURL : string;
var
	uri		 	: TIdURI;
	uriList	: TStringList;
begin

	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
		if uri.Document <> SUBJECT_NAME then begin
			if Copy( URL, Length( URL ), 1 ) = '/' then
				Result := URL + SUBJECT_NAME
			else
				Result := URL + '/' + SUBJECT_NAME;
		end else begin
			// �����ɂ͗��Ȃ��Ǝv������
			Result := URL;
		end;
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// TBoardItem ���������ꂽ�ꍇ�̏��u(TShitarabaBoardItem �𐶐�����)
// *************************************************************************
procedure BoardItemOnCreateOfTShitarabaBoardItem(
	inInstance : DWORD
);
var
	boardItem : TShitarabaBoardItem;
begin

	boardItem := TShitarabaBoardItem.Create( inInstance );
	BoardItemSetLong( inInstance, bipContext, DWORD( boardItem ) );

end;

// *************************************************************************
// TBoardItem ���j�����ꂽ�ꍇ�̏��u(TShitarabaBoardItem ��j������)
// *************************************************************************
procedure BoardItemOnDisposeOfTShitarabaBoardItem(
	inInstance : DWORD
);
var
	boardItem : TShitarabaBoardItem;
begin

	boardItem := TShitarabaBoardItem( BoardItemGetLong( inInstance, bipContext ) );
	boardItem.Free;

end;



// =========================================================================
// �G���g���|�C���g
// =========================================================================
procedure DLLEntry(
	ul_reason_for_call : DWORD
);
var
	module : HMODULE;
begin

	case ul_reason_for_call of
		DLL_PROCESS_ATTACH:
		begin
			Randomize;

			module := GetModuleHandle( nil );

			LoadInternalAPI( module );
			LoadInternalFilePathAPI( module );
			LoadInternalThreadItemAPI( module );
			LoadInternalBoardItemAPI( module );

			// ===== �C���X�^���X�̎�舵���� TThreadItem ���� TShitarabaThreadItem �ɕύX����
			ThreadItemOnCreate	:= ThreadItemOnCreateOfTShitarabaThreadItem;
			ThreadItemOnDispose	:= ThreadItemOnDisposeOfTShitarabaThreadItem;
			// ===== �C���X�^���X�̎�舵���� TBoardItem ���� TShitarabaBoardItem �ɕύX����
			BoardItemOnCreate		:= BoardItemOnCreateOfTShitarabaBoardItem;
			BoardItemOnDispose	:= BoardItemOnDisposeOfTShitarabaBoardItem;
		end;
		DLL_PROCESS_DETACH:
			;
		DLL_THREAD_ATTACH:
			;
		DLL_THREAD_DETACH:
			;
	end;

end;

exports
	OnVersionInfo,
	OnAcceptURL;

begin

	try
		DllProc := @DLLEntry;
		DLLEntry( DLL_PROCESS_ATTACH );
	except end;

end.
