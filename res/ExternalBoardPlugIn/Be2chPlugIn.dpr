library Be2chPlugIn;

{
	Be2chPlugIn
	�Q�����˂�Be�������j�b�g
}

uses
  Windows,
  SysUtils,
  Classes,
  Math,
  DateUtils,
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
	// TBe2chThreadItem
	// =========================================================================
	TBe2chThreadItem = class(TThreadItem)
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
		function	BrowsableURL : string;
		function	ReadURL : string;
		function	WriteURL : string;
		function	AddBeProfileLink( AID : string; ANum: Integer) : string;
	end;

	// =========================================================================
	// TBe2chBoardItem
	// =========================================================================
	TBe2chBoardItem = class(TBoardItem)
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
	LOG_DIR						= 'Be2ch\';
	SUBJECT_NAME			= 'subject.txt';

	PLUGIN_NAME				= 'Be2chPlugIn';
	MAJOR_VERSION			= 1;
	MINOR_VERSION			= 0;
	RELEASE_VERSION		= 'alpha';
	REVISION_VERSION	= 3;

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
// Be�p���O�t�H���_�擾
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
//	i			: Integer;
const
	BBS_HOST		= 'be.2ch.net';
	THREAD_MARK	= '/test/read.cgi';
begin

	try
		// �z�X�g���� be.2ch.net�Ȃ�󂯕t����
		uri			:= TIdURI.Create( inURL );
		uriList	:= TStringList.Create;
		try

			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			if (AnsiPos( BBS_HOST, uri.Host ) > 0) and (Length( uri.Host ) - AnsiPos( BBS_HOST, uri.Host ) + 1 = Length( BBS_HOST )) then begin
				foundPos := AnsiPos( THREAD_MARK, inURL );

				if foundPos > 0 then
					Result := atThread
				else if (uriList.Count > 2) and (AnsiPos('.html', uri.Document) > 0) then
					Result := atThread
				else if uriList.Count = 2 then  
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

function BrowsableURL(
	inURL : string
) : string;
var
	uri				: TIdURI;
	uriList		: TStringList;
	foundPos	: Integer;
	dir, tmphost		: string;
const
	THREAD_MARK	= '/test/read.cgi';
	BBS_HOST		= 'be.2ch.net';
begin

	foundPos := AnsiPos( '?', inURL );
	if foundPos > 0 then begin
		// ����
		uri := TIdURI.Create( inURL );
		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			dir := uriList[ 1 ];

			tmphost := uri.Host;

			ExtractHttpFields( ['&'], [], Copy( inURL, foundPos + 1, MaxInt ), uriList );
			Result :=
				uri.Protocol + '://' + tmphost + THREAD_MARK +
				dir + '/' + uriList.Values[ 'BBS' ] + '/' + uriList.Values[ 'KEY' ] + '/l100';
		finally
			uri.Free;
			uriList.Free;
		end;
	end else begin
		if Copy( inURL, Length( inURL ), 1 ) = '/' then
			uri := TIdURI.Create( inURL )
		else
			uri := TIdURI.Create( inURL + '/' );

		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['/'], [], uri.Path, uriList );

			tmphost := uri.Host;

			if( AnsiPos(THREAD_MARK, inURL) > 0) and (uriList.Count > 4) then begin
				Result :=
					uri.Protocol + '://' + tmphost + THREAD_MARK + '/' +
					uriList[ 3 ] + '/' + uriList[ 4 ] + '/l50';

			end else begin
				Result := inURL;
			end;
		finally
			uri.Free;
			uriList.Free;
		end;
	end;

end;
// *************************************************************************
// �w�肵�� URL ��Board��URL�ɕϊ�
// *************************************************************************
procedure OnExtractBoardURL(
	inURL	: PChar;
	var outURL	: PChar
); stdcall;
var
	uri		: TIdURI;
	uriList	: TStringList;
	tmphost	:	String;
	URL		:	String;
const
	THREAD_MARK	= '/test/read.cgi';
	BBS_HOST		= 'be.2ch.net';
begin
	URL := string(inURL);
	if (AnsiPos(THREAD_MARK,URL) > 0) then begin
		URL		:= BrowsableURL(URL);
		uri			:= TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

			tmphost := uri.Host;

			if uriList.Count > 4 then
				URL		:= uri.Protocol + '://' + tmphost + '/' + uriList[ 3 ] + '/';
			outURL	:= CreateResultString(URL);
		finally
			uri.Free;
			uriList.Free;
		end;
	end else begin
		outURL	:= CreateResultString(URL);
	end;

end;

// =========================================================================
// TShitarabaThreadItem
// =========================================================================

// *************************************************************************
// �R���X�g���N�^
// *************************************************************************
constructor TBe2chThreadItem.Create(
	inInstance	: DWORD
);
var
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

	FIsTemporary	:= False;
	FDat					:= nil;
	URL						:= BrowsableURL;

	uriList := TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], URL, uriList );

		FileName	:= uriList[ 6 ] + '.dat';
		//FilePath	:= MyLogFolder + uriList[ 2 ] + '\' + FileName;
		IsLogFile	:= FileExists( FilePath );
	finally
		uriList.Free;
	end;

end;

// *************************************************************************
// �f�X�g���N�^
// *************************************************************************
destructor TBe2chThreadItem.Destroy;
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
function TBe2chThreadItem.Download : TDownloadState;
var
	modified			: Double;
	tmp						: PChar;
	downResult		: TStringList;
	responseCode	: Longint;
	logStream			: TFileStream;
	uri						: TIdURI;
	uriList				: TStringList;
	datURL				: string;
	tmpText: string;
//	rangeEnd			: Integer;
	FilePath : string;
begin

	Result := dsError;

	uri := TIdURI.Create( ReadURL );
	uriList := TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		FileName := uriList[ 4 ] + '.dat';

		if MyLogFolder = '' then begin
			// �ǂ��ɕۑ����Ă����̂�������Ȃ��̂ňꎞ�t�@�C���ɕۑ�
			FilePath 			:= TemporaryFile;
			FIsTemporary	:= True;
		end else begin
			FilePath			:= MyLogFolder + uriList[ 3 ] + '\' + FileName;
			FIsTemporary	:= False;
		end;
		//http://be.2ch.net/be/dat/1109901078.dat
		datURL		:= 'http://' + uri.Host + '/' + uriList[ 3 ] + '/dat/' + FileName;
	finally
		uri.Free;
		uriList.Free;
	end;

	// �ۑ��p�̃f�B���N�g�����@��
	ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

	// �Ǝ��Ƀ_�E�����[�h��t�B���^�����O���s��Ȃ��ꍇ��
	// InternalDownload �ɔC���邱�Ƃ��o����
	modified	:= LastModified;
	responseCode := InternalDownload( PChar( datURL ), modified, tmp, Size );

	try
		if (responseCode = 200) or (responseCode = 206) then begin
			downResult := TStringList.Create;
			try
				Size	:= Size + Length( string( tmp ) );
				
				tmpText := CustomStringReplace( string( tmp ), '����', ',' );
				downResult.Text := EUCtoSJIS( tmpText );

				if downResult.Count > 0 then begin
					if FileExists( FilePath ) then
						logStream := TFileStream.Create( FilePath, fmOpenReadWrite or fmShareDenyWrite )
					else
						logStream := TFileStream.Create( FilePath, fmCreate or fmShareDenyWrite );
					try
						logStream.Position	:= logStream.Size;
						logStream.Write( PChar( downResult.Text )^, Length( downResult.Text ) );
					finally
						logStream.Free;
					end;

					if Count = 0 then
											// �V�K
						Result := dsComplete
					else
						// �ǋL
						Result := dsDiffComplete;


					// CGI ����͐��������t�������Ȃ��̂Ō��݂ɐݒ�
					LastModified	:= Now;



					NewReceive		:= Count + 1;
					Count					:= Count + downResult.Count;
					NewResCount		:= downResult.Count;



				end else begin
					Result := dsNotModify;
				end;
			finally
				downResult.Free;
			end;
		end else if responseCode = 304 then begin
			Result := dsNotModify;
		end;
	finally
		DisposeResultString( tmp );
	end;

end;

// *************************************************************************
// �������݂��w�����ꂽ
// *************************************************************************
function	TBe2chThreadItem.Write(
	inName				: string;	// ���O(�n���h��)
	inMail				: string;	// ���[���A�h���X
	inMessage			: string	// �{��
) : TDownloadState;				// �������݂������������ǂ���
var
	postData			: string;
	postResult		: PChar;
	uri						: TIdURI;
	uriList				: TStringList;
	responseCode	: Integer;
begin

	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
	
		// http://jbbs.livedoor.com/bbs/read.cgi/game/1578/1067968274/l100
		postData	:=
			'NAME='			+ HttpEncode( SJIStoEUC( inName ) ) +
			'&MAIL='		+ HttpEncode( SJIStoEUC( inMail ) ) +
			'&MESSAGE='	+ HttpEncode( SJIStoEUC( inMessage ) ) +
			'&BBS='			+ uriList[ 4 ] +
			'&KEY='			+ uriList[ 5 ] +
			'&DIR='			+ uriList[ 3 ] +
			'&TIME='		+ IntToStr( DateTimeToUnix( Now ) ) +
			'&submit='	+ HttpEncode( SJIStoEUC( '��������' ) );

		// �Ǝ��ɒʐM���Ȃ��ꍇ�� InternalPost �ɔC���邱�Ƃ��o����
		responseCode := InternalPost( PChar( WriteURL ), PChar( postData ), PChar(URL), postResult );
		try
			if (responseCode = 200) or
				((responseCode = 302) and (Length( Trim( postResult ) ) = 0)) then begin
				Result := dsComplete
			end else begin
				Result := dsError;
				if Assigned( InternalPrint ) then
					InternalPrint( postResult );
			end;
		finally
			DisposeResultString( postResult );
		end;
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// ���X�ԍ� inNo �ɑ΂��� html ��v�����ꂽ
// *************************************************************************
function TBe2chThreadItem.GetRes(
	inNo		: Integer		// �v�����ꂽ���X�ԍ�
) : string;						// �Ή����� HTML
var
	res		 	: string;
	tmp			: PChar;
begin

	// �Ǝ��Ƀt�B���^�����O���s��Ȃ��ꍇ��
	// InternalAbon ����� Dat2HTML �ɔC���邱�Ƃ��o����
		{
	LoadDat;
	if FDat = nil then begin
		// ���O�ɑ��݂��Ȃ��̂ł��̂܂܏I��
		Result := '';
		Exit;
	end;
	res := Copy( FDat[ inNo - 1 ], AnsiPos( '<>', FDat[ inNo - 1 ] ) + 2, MaxInt );
		}
	res := GetDat( inNo );
	if res = '' then begin
		Result := '';
		Exit;
	end else begin
		tmp := InternalAbonForOne( PChar( res ), PChar( FilePath ),inNo );
		try
			Result := Dat2HTML( string( tmp ), inNo );
		finally
			DisposeResultString( tmp );
		end;
	end;

end;

// *************************************************************************
// ���X�ԍ� inNo �ɑ΂��� Dat ��v�����ꂽ
// *************************************************************************
function TBe2chThreadItem.GetDat(
	inNo		: Integer		// �v�����ꂽ���X�ԍ�
) : string;						// �Q�����˂��Dat�`��
var
	res, tmp 	: string;
	AID			: string;
//	i			: Integer;
	pTmp		: PChar;
begin
	pTmp := nil;
	// �Ǝ��Ƀt�B���^�����O���s��Ȃ��ꍇ��
	// InternalAbon ����� Dat2HTML �ɔC���邱�Ƃ��o����
	LoadDat;
	if (FDat = nil) or (inNo - 1 < 0 ) or (inNo - 1 >= FDat.Count) then begin
		// ���O�ɑ��݂��Ȃ��̂ł��̂܂܏I��
		Result := '';
		Exit;
	end;
	try
		tmp := FDat[ inNo - 1 ];
		res := Copy(tmp, 1, AnsiPos('<BE:', tmp) - 1);
		Delete(tmp, 1, AnsiPos('<BE:', tmp) - 1);
		AID := Copy(tmp, 1, AnsiPos('>', tmp));
		Delete(tmp, 1, AnsiPos('>', tmp));
		res := res + AddBeProfileLink(AID, inNo) + tmp;
		//<BE:
		pTmp := CreateResultString(res);
		Result := string(pTmp);
	finally
		DisposeResultString(pTmp);
	end;

end;
function TBe2chThreadItem.AddBeProfileLink(
	 AID : string;
	 ANum: Integer
) : string;
var
	p : integer;
	BNum{, BMark} : string;
begin
	//<BE:34600695:4>
	p := AnsiPos('BE:', AnsiUpperCase(AID));
	if p > 0 then begin
		BNum := Copy(AID, p + 3, Length(AID));
		p := AnsiPos(':', BNum);
		if p > 0 then begin
			BNum := Copy(BNum, 1, p - 1);
		end;
		BNum := Trim(BNum);
		Result := ' <a href="BE:'  + BNum + '/' + IntToStr(ANum)
			+ '" target=_blank>' + 'BE' + '</a>';
	end else
		Result := AID;
end;
// *************************************************************************
// �X���b�h�̃w�b�_ html ��v�����ꂽ
// *************************************************************************
function TBe2chThreadItem.GetHeader(
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
function TBe2chThreadItem.GetFooter(
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
function	TBe2chThreadItem.GetBoardURL : string;
var
	uri						: TIdURI;
	uriList				: TStringList;
	tmphost:	String;
const
	BBS_HOST		= 'be.2ch.net';
begin

	uri			:= TIdURI.Create( ReadURL );
	uriList := TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

		tmphost := uri.Host;
		if( uriList.Count > 4 ) then begin
			FileName := uriList[ 4 ] + '.dat';
			Result		:= CreateResultString(
				uri.Protocol + '://' + tmphost + '/' +  uriList[ 3 ] + '/' );
		end;
	finally
		uri.Free;
		uriList.Free;
	end;
{
	URL := string(inURL);
	if (AnsiPos(THREAD_MARK,URL) > 0) then begin
		URL		:= BrowsableURL(URL);
		uri			:= TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

			tmphost := uri.Host;

			if uriList.Count > 4 then
				URL		:= uri.Protocol + '://' + tmphost + '/' + uriList[ 3 ] + '/';
			outURL	:= CreateResultString(URL);
		finally
			uri.Free;
			uriList.Free;
		end;
	end else begin
		outURL	:= CreateResultString(URL);
	end;
}
end;

// *************************************************************************
// FDat �̐���
// *************************************************************************
procedure	TBe2chThreadItem.LoadDat;
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
procedure	TBe2chThreadItem.FreeDat;
begin

	if FDat <> nil then begin
		FDat.Free;
		FDat := nil;
	end;

end;

// *************************************************************************
// ���S�ȃu���E�U�\���p�� URL
// *************************************************************************
function	TBe2chThreadItem.BrowsableURL : string;
var
	uri				: TIdURI;
	uriList		: TStringList;
	foundPos	: Integer;
	dir, tmphost		: string;
const
	THREAD_MARK	= '/test/read.cgi';
	BBS_HOST		= 'be.2ch.net';
begin

	foundPos := AnsiPos( '?', URL );
	if foundPos > 0 then begin
		// ����
		uri := TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			dir := uriList[ 1 ];

			tmphost := uri.Host;

			ExtractHttpFields( ['&'], [], Copy( URL, foundPos + 1, MaxInt ), uriList );
			Result :=
				uri.Protocol + '://' + tmphost + THREAD_MARK +
				dir + '/' + uriList.Values[ 'BBS' ] + '/' + uriList.Values[ 'KEY' ] + '/l100';
		finally
			uri.Free;
			uriList.Free;
		end;
	end else begin
		if Copy( URL, Length( URL ), 1 ) = '/' then
			uri := TIdURI.Create( URL )
		else
			uri := TIdURI.Create( URL + '/' );

		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['/'], [], uri.Path, uriList );

			tmphost := uri.Host;

			if( AnsiPos(THREAD_MARK, URL) > 0) and (uriList.Count > 4) then begin
				Result :=
					uri.Protocol + '://' + tmphost + THREAD_MARK + '/' +
					uriList[ 3 ] + '/' + uriList[ 4 ] + '/l50';

			end else begin
				Result := URL;
			end;
		finally
			uri.Free;
			uriList.Free;
		end;
	end;

end;

// *************************************************************************
// ���S��( '/' �ŏI��� )�ǂݍ��݂� URL
// *************************************************************************
function	TBe2chThreadItem.ReadURL : string;
const
	THREAD_MARK	= '/test/read.cgi';
var
	uri				: TIdURI;
	uriList		: TStringList;
	foundPos	: Integer;
	dir, tmphost			: string;
begin

	foundPos := AnsiPos( '?', URL );
	if foundPos > 0 then begin
		// ����
		uri := TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			dir := uriList[ 1 ];

			tmphost := uri.Host;

			ExtractHttpFields( ['&'], [], Copy( URL, foundPos + 1, MaxInt ), uriList );
			// http://jbbs.livedoor.com/bbs/read.cgi?DIR=game&BBS=1578&KEY=1067968274
			Result :=
				uri.Protocol + '://' + tmphost + '/bbs/rawmode.cgi/' +
				dir + '/' + uriList.Values[ 'BBS' ] + '/' + uriList.Values[ 'KEY' ] + '/';
		finally
			uri.Free;
			uriList.Free;
		end;
	end else begin
		Result := URL;
	end;

end;

// *************************************************************************
// ���S��( '/' �ŏI��� )�������݂� URL
// *************************************************************************
function	TBe2chThreadItem.WriteURL : string;
//var
//	uri			: TIdURI;
//	uriList	: TStringList;
begin
	{
	if Copy( URL, Length( URL ), 1 ) = '/' then
		uri := TIdURI.Create( URL )
	else
		uri := TIdURI.Create( URL + '/' );
	uriList := TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		// http://jbbs.livedoor.com/bbs/read.cgi/game/1578/1067968274/l100
		Result		:=
			uri.Protocol + '://' + uri.Host + '/bbs/write.cgi/' +
			uriList[ 3 ] + '/' + uriList[ 4 ] + '/' + uriList[ 5 ] + '/';

	finally
		uri.Free;
		uriList.Free;
	end;
	}
	Result := URL;
end;

// *************************************************************************
// TThreadItem ���������ꂽ�ꍇ�̏��u(TShitarabaThreadItem �𐶐�����)
// *************************************************************************
procedure ThreadItemOnCreateOfTBe2chThreadItem(
	inInstance : DWORD
);
var
	threadItem : TBe2chThreadItem;
begin

	threadItem := TBe2chThreadItem.Create( inInstance );
	ThreadItemSetLong( inInstance, tipContext, DWORD( threadItem ) );

end;

// *************************************************************************
// TThreadItem ���j�����ꂽ�ꍇ�̏��u(TShitarabaThreadItem ��j������)
// *************************************************************************
procedure ThreadItemOnDisposeOfTBe2chThreadItem(
	inInstance : DWORD
);
var
	threadItem : TBe2chThreadItem;
begin

	threadItem := TBe2chThreadItem( ThreadItemGetLong( inInstance, tipContext ) );
	threadItem.Free;

end;

// =========================================================================
// TShitarabaBoardItem
// =========================================================================

// *************************************************************************
// �R���X�g���N�^
// *************************************************************************
constructor TBe2chBoardItem.Create(
	inInstance	: DWORD
);
var
	uri					: TIdURI;
	uriList			: TStringList;
const
	BBS_HOST		= 'be.2ch.net';
begin

	inherited;

	OnDownload						:= Download;
	OnCreateThread				:= CreateThread;
	OnEnumThread					:= EnumThread;
	OnFileName2ThreadURL	:= ToThreadURL;

	FilePath			:= '';
	FIsTemporary	:= False;
	FDat					:= nil;
	Is2ch := True;
	uri			:= TIdURI.Create( SubjectURL );
	uriList	:= TStringList.Create;
	try
		URL := uri.Protocol + '://' + uri.Host + uri.Path;

		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		// http://jbbs.livedoor.com/game/1000/subject.txt
		FilePath	:= MyLogFolder + uriList[ 1 ] + '\' + uri.Document;
		IsLogFile	:= FileExists( FilePath );
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// �f�X�g���N�^
// *************************************************************************
destructor TBe2chBoardItem.Destroy;
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
function TBe2chBoardItem.Download : TDownloadState;
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
				if MyLogFolder = '' then begin
					// �ǂ��ɕۑ����Ă����̂�������Ȃ��̂ňꎞ�t�@�C���ɕۑ�
					FilePath 			:= TemporaryFile;
					FIsTemporary	:= True;
				end else begin
					FilePath			:= MyLogFolder + CustomStringReplace(uri.Path, '/', '') + '\' + uri.Document;
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
function	TBe2chBoardItem.CreateThread(
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
	responseCode	: Integer;
begin

	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

		// http://jbbs.livedoor.com/bbs/write.cgi/game/1578/new/
		// http://jbbs.livedoor.com/game/1000/subject.txt
		postURL		:=
			uri.Protocol + '://' + uri.Host + '/bbs/write.cgi/' +
			uriList[ 1 ] + '/' + uriList[ 2 ] + '/new/';
		postData	:=
			'SUBJECT='	+ HttpEncode( SJIStoEUC( inSubject ) ) +
			'&NAME='		+ HttpEncode( SJIStoEUC( inName ) ) +
			'&MAIL='		+ HttpEncode( SJIStoEUC( inMail ) ) +
			'&MESSAGE='	+ HttpEncode( SJIStoEUC( inMessage ) ) +
			'&BBS='			+ uriList[ 4 ] +
			'&DIR='			+ uriList[ 3 ] +
			'&TIME='		+ IntToStr( DateTimeToUnix( Now ) ) +
			'&submit='	+ HttpEncode( SJIStoEUC( '�V�K��������' ) );

		// �Ǝ��ɒʐM���Ȃ��ꍇ�� InternalPost �ɔC���邱�Ƃ��o����
		responseCode := InternalPost( PChar( postURL ), PChar( postData ), PChar(URL), postResult );
		try
			if (responseCode = 200) or
				((responseCode = 302) and (Length( Trim( postResult ) ) = 0)) then begin
				Result := dsComplete
			end else begin
				Result := dsError;
				if Assigned( InternalPrint ) then
					InternalPrint( postResult );
			end;
		finally
			DisposeResultString( postResult );
		end;
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// �X���ꗗ�� URL ����X���b�h�� URL �𓱂��o��
// *************************************************************************
function TBe2chBoardItem.ToThreadURL(
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
			ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
			{threadURL	:= uri.Protocol + '://' + uri.Host + '/bbs/read.cgi/' +
				uriList[ 1 ] + '/' + uriList[ 2 ] + '/' + inFileName + '/l100';
			}
			threadURL	:= uri.Protocol + '://' + uri.Host + '/test/read.cgi' +
							uri.Path + inFileName + '/l50';
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
procedure	TBe2chBoardItem.EnumThread(
	inCallBack	: TBoardItemEnumThreadCallBack
);
var
	uri		 			: TIdURI;
	uriList			: TStringList;
begin

	try
		if FDat = nil then begin
			FDat		:= TStringList.Create;
			uri			:= TIdURI.Create( SubjectURL );
			uriList	:= TStringList.Create;
			try
				// �p�X���Z�o
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				// http://jbbs.livedoor.com/game/1000/subject.txt
				FilePath	:= MyLogFolder + uriList[ 1 ] + '\' + uriList[ 2 ] + '\' + uri.Document;
				if FileExists( FilePath ) then
					// �ǂݍ���
					FDat.LoadFromFile( FilePath );
			finally
				uri.Free;
				uriList.Free;
			end;
		end;

		// �Ǝ��Ƀt�B���^�����O���s��Ȃ��ꍇ�� EnumThread �ɔC���邱�Ƃ��o����
		inherited EnumThread( inCallBack, CustomStringReplace( FDat.Text, ',', '<>' ) );
	except
	end;

end;

// *************************************************************************
// �X���ꗗ�� URL �����߂�
// *************************************************************************
function	TBe2chBoardItem.SubjectURL : string;
begin
	if AnsiPos(SUBJECT_NAME, URL) > 0 then
		Result := URL
	else
		Result := URL + SUBJECT_NAME;
end;

// *************************************************************************
// TBoardItem ���������ꂽ�ꍇ�̏��u(TShitarabaBoardItem �𐶐�����)
// *************************************************************************
procedure BoardItemOnCreateOfTBe2chBoardItem(
	inInstance : DWORD
);
var
	boardItem : TBe2chBoardItem;
begin

	boardItem := TBe2chBoardItem.Create( inInstance );
	BoardItemSetLong( inInstance, bipContext, DWORD( boardItem ) );

end;

// *************************************************************************
// TBoardItem ���j�����ꂽ�ꍇ�̏��u(TShitarabaBoardItem ��j������)
// *************************************************************************
procedure BoardItemOnDisposeOfTBe2chBoardItem(
	inInstance : DWORD
);
var
	boardItem : TBe2chBoardItem;
begin

	boardItem := TBe2chBoardItem( BoardItemGetLong( inInstance, bipContext ) );
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
			ThreadItemOnCreate	:= ThreadItemOnCreateOfTBe2chThreadItem;
			ThreadItemOnDispose	:= ThreadItemOnDisposeOfTBe2chThreadItem;
			// ===== �C���X�^���X�̎�舵���� TBoardItem ���� TShitarabaBoardItem �ɕύX����
			BoardItemOnCreate		:= BoardItemOnCreateOfTBe2chBoardItem;
			BoardItemOnDispose	:= BoardItemOnDisposeOfTBe2chBoardItem;
		end;
		DLL_THREAD_ATTACH:
			;
		DLL_THREAD_DETACH:
			;
	end;

end;

exports
	OnVersionInfo,
	OnAcceptURL,
	OnExtractBoardURL;
begin

	try
		DllProc := @DLLEntry;
		DLLEntry( DLL_PROCESS_ATTACH );
	except end;

end.
