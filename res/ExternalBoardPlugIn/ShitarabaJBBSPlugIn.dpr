library ShitarabaJBBSPlugIn;

{
	ShitarabaJBBSPlugIn
	$Id: ShitarabaJBBSPlugIn.dpr,v 1.47 2009/06/22 14:48:31 h677 Exp $
}

uses
  Windows,
  SysUtils,
  Classes,
  Math,
  DateUtils,
  Dialogs,
  IdURI,
  PlugInMain in 'PlugInMain.pas',
  ThreadItem in 'ThreadItem.pas',
  BoardItem in 'BoardItem.pas',
	FilePath in 'FilePath.pas',
  Y_TextConverter in 'Y_TextConverter.pas',
  MojuUtils in '..\..\MojuUtils.pas',
  ShitarabaJBBSAcquireBoard in 'ShitarabaJBBSAcquireBoard.pas' {ShitarabaJBBSAcquireBoardDialog};

{$R *.res}

type
	// =========================================================================
	// TShitarabaThreadItem
	// =========================================================================
	TShitarabaThreadItem = class(TThreadItem)
	private
		FIsTemporary	: Boolean;
		FDat					: TStringList;
		//FFilePath		: String;
	public
		constructor	Create( inInstance : DWORD );
		destructor	Destroy; override;

	private
		function	Download : TDownloadState;
		function	StorageDownload(AURL : string) : TDownloadState;
		function	Write( inName : string; inMail : string; inMessage : string ) : TDownloadState;
		function	GetRes( inNo : Integer ) : string;
		function	GetDat( inNo : Integer ) : string;
		function	GetHeader( inOptionalHeader : string ) : string;
		function	GetFooter( inOptionalFooter : string ) : string;
		function	GetBoardURL : string;
		procedure	ArrangeDownloadData( start: Integer;var Data: TStringList);
		procedure	LoadDat;
		procedure	FreeDat;
		function	BrowsableURL : string;
		function	ReadURL : string;
		function	WriteURL : string;
//		property	FilePath : string	read FFilePath;
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
	LOG_DIR						= 'ShitarabaJBBS\';
	SUBJECT_NAME			= 'subject.txt';

	PLUGIN_NAME				= 'ShitarabaJBBS';
	MAJOR_VERSION			= 1;
	MINOR_VERSION			= 2;
	RELEASE_VERSION		= 'alpha';
	REVISION_VERSION	= 23;

	SYNCRONIZE_MENU_CAPTION	= '�������JBBS�X�V';

	ARCHIVE_PATH      = '/bbs/read_archive.cgi';

var
	SyncronizeMenu		: HMENU;

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
// �v���O�C����(������)���[�h���ꂽ
// *************************************************************************
procedure OnLoad(
	inInstance : DWORD				// �v���O�C���̃C���X�^���X
); stdcall;
begin

	// �v���O�C�����j���[�ɒǉ�
	SyncronizeMenu := AddPlugInMenu( inInstance, SYNCRONIZE_MENU_CAPTION );

end;

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
	BBS_HOST_OLD 	= 'jbbs.shitaraba.com';
	BBS_HOST_OLD2   = 'jbbs.livedoor.com';
	BBS_HOST_OLD3   = 'jbbs.livedoor.jp';
	BBS_HOST	= 'jbbs.shitaraba.net';
	THREAD_MARK	= '/bbs/read.cgi';
begin

	try
		// �z�X�g���� jbbs.livedoor.com �ŏI���ꍇ�͎󂯕t����悤�ɂ��Ă���
		uri			:= TIdURI.Create( inURL );
		uriList	:= TStringList.Create;
		try
			if (uri.Host = BBS_HOST_OLD) or (uri.Host = BBS_HOST_OLD2) or (uri.Host = BBS_HOST_OLD3) then
				uri.Host := BBS_HOST;

			ExtractHttpFields( ['/'], [], uri.Path, uriList );
		       if (AnsiPos( BBS_HOST, uri.Host ) > 0) and (Length( uri.Host ) - AnsiPos( BBS_HOST, uri.Host ) + 1 = Length( BBS_HOST )) then begin
				foundPos := AnsiPos( THREAD_MARK, inURL );
        if foundPos < 1 then
  				foundPos := AnsiPos( ARCHIVE_PATH, inURL );

				if foundPos > 0 then
					Result := atThread
				else if (uriList.Count > 2) and (AnsiPos('.html', uri.Document) > 0) then
					Result := atThread
				else if uriList.Count > 2 then	// �Ōオ '/' �ŕ߂��Ă�Ȃ� 4
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
    THREAD_MARK	= '/bbs/read.cgi';
	BBS_HOST_OLD 	= 'jbbs.shitaraba.com';
	BBS_HOST_OLD2   = 'jbbs.livedoor.com';
	BBS_HOST_OLD3   = 'jbbs.livedoor.jp';
	BBS_HOST		= 'jbbs.shitaraba.net';
begin

	foundPos := AnsiPos( '?', inURL );
	if foundPos > 0 then begin
		// ����
		uri := TIdURI.Create( inURL );
		uriList := TStringList.Create;
		try
      uri.Protocol := 'https';
			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			dir := uriList[ 1 ];

			tmphost := uri.Host;
			if (tmphost = BBS_HOST_OLD) or (tmphost = BBS_HOST_OLD2) or (tmphost = BBS_HOST_OLD3) then
				tmphost := BBS_HOST;

			ExtractHttpFields( ['&'], [], Copy( inURL, foundPos + 1, MaxInt ), uriList );
			Result :=
				uri.Protocol + '://' + tmphost + '/bbs/read.cgi/' +
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
      uri.Protocol := 'https';
			ExtractHttpFields( ['/'], [], uri.Path, uriList );

			tmphost := uri.Host;
			if (tmphost = BBS_HOST_OLD) or (tmphost = BBS_HOST_OLD2)  or (tmphost = BBS_HOST_OLD3) then
				tmphost := BBS_HOST;

			if( AnsiPos(THREAD_MARK, inURL) > 0) and (uriList.Count > 5) then begin
				Result :=
					uri.Protocol + '://' + tmphost + THREAD_MARK + '/' +
					uriList[ 3 ] + '/' + uriList[ 4 ] + '/' + uriList[ 5 ] + '/l100';

			end else if( AnsiPos(ARCHIVE_PATH, inURL) > 0) and (uriList.Count > 5) then begin
				Result :=
					uri.Protocol + '://' + tmphost + ARCHIVE_PATH + '/' +
					uriList[ 3 ] + '/' + uriList[ 4 ] + '/' + uriList[ 5 ] + '/l100';

			end else if AnsiPos(THREAD_MARK, inURL) = 0 then begin
			//�R�R�ŉߋ����O���ǂ����`�F�b�N�H
				if(AnsiPos('.html/', uri.Path) > 0) then begin
					Result := uri.Protocol + '://' + tmphost + THREAD_MARK +
						CustomStringReplace(CustomStringReplace(uri.Path, '/storage', ''), '.html/', '/') + 'l100';
				end else
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
	BBS_HOST_OLD 	= 'jbbs.shitaraba.com';
	BBS_HOST_OLD2   = 'jbbs.livedoor.com';
	BBS_HOST_OLD3   = 'jbbs.livedoor.jp';
	BBS_HOST	= 'jbbs.shitaraba.net';
	THREAD_MARK	= '/bbs/read.cgi/';
	THREAD_MARK2	= '/bbs/read.cgi?';
	STORAGE_MARK	= '/storage/';
begin
	URL := string(inURL);
	if (AnsiPos(THREAD_MARK,URL) > 0) or (AnsiPos(THREAD_MARK2, URL) > 0) or (AnsiPos(ARCHIVE_PATH, URL) > 0) then begin
		URL		:= BrowsableURL(URL);
		uri			:= TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
      uri.Protocol := 'https';
      
			ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

			tmphost := uri.Host;

			if (tmphost = BBS_HOST_OLD) or (tmphost = BBS_HOST_OLD2)  or (tmphost = BBS_HOST_OLD3) then
				tmphost := BBS_HOST;

			// http://jbbs.livedoor.com/bbs/read.cgi/computer/351/1090404452/l100
			// http://jbbs.livedoor.com/bbs/read.cgi/game/1578/1067968274/l100
			// http://jbbs.livedoor.com/game/1000/subject.txt

			if uriList.Count > 4 then
				URL		:= uri.Protocol + '://' + tmphost + '/' + uriList[ 3 ] + '/' + uriList[ 4 ] + '/';
			outURL	:= CreateResultString(URL);
		finally
			uri.Free;
			uriList.Free;
		end;
	end else if (AnsiPos(STORAGE_MARK,URL) > 0) then begin
		//�R�R�ŉߋ����O���ǂ����`�F�b�N�H
		URL := Copy(URL, 1, AnsiPos(STORAGE_MARK,URL));
		URL := CustomStringReplace(URL, BBS_HOST_OLD, BBS_HOST);
		URL := CustomStringReplace(URL, BBS_HOST_OLD2, BBS_HOST);
		URL := CustomStringReplace(URL, BBS_HOST_OLD3, BBS_HOST);
		outURL	:= CreateResultString(URL);
	end else begin
		URL := CustomStringReplace(URL, BBS_HOST_OLD, BBS_HOST);
		URL := CustomStringReplace(URL, BBS_HOST_OLD2, BBS_HOST);
		URL := CustomStringReplace(URL, BBS_HOST_OLD3, BBS_HOST);
		outURL	:= CreateResultString(URL);
	end;

end;
// *************************************************************************
// �������JBBS�X�V
// *************************************************************************
procedure OnBoardSyncronizeMenu(
	inHandle	: HMENU					// ���j���[�n���h��
); stdcall;
var
	dialog				: TShitarabaJBBSAcquireBoardDialog;
begin

	dialog := TShitarabaJBBSAcquireBoardDialog.Create( nil );
	dialog.ShowModal;

end;

// ���j���[�n���h��
procedure OnPlugInMenu(
	inHandle : HMENU					// ���j���[�n���h��
); stdcall;
begin

	if inHandle = SyncronizeMenu then
		OnBoardSyncronizeMenu( inHandle );

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
	FilePath		: String;
begin

	inherited;

	OnDownload		:= Download;
	OnWrite				:= Write;
	OnGetRes			:= GetRes;
	OnGetDat			:= GetDat;
	OnGetHeader		:= GetHeader;
	OnGetFooter		:= GetFooter;
	OnGetBoardURL	:= GetBoardURL;

	//FFilePath			:= '';
	FIsTemporary	:= False;
	FDat					:= nil;
	URL						:= BrowsableURL;

	uri			:= TIdURI.Create( ReadURL );
	uriList := TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		if uriList[ 5 ] = 'l100' then begin
			FileName	:= uriList[ 4 ] + '.dat';
			FilePath	:= MyLogFolder + uriList[ 2 ] + '\' + uriList[ 3 ] + '\' + uriList[ 4 ] + '.dat';
			IsLogFile	:= FileExists( FilePath );
		end else begin
			FileName	:= uriList[ 5 ] + '.dat';
			FilePath	:= MyLogFolder + uriList[ 3 ] + '\' + uriList[ 4 ] + '\' + uriList[ 5 ] + '.dat';
			IsLogFile	:= FileExists( FilePath );
		end;
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
	tmp						: PChar;
	downResult		: TStringList;
	responseCode	: Longint;
	logStream			: TFileStream;
	uri						: TIdURI;
	uriList				: TStringList;
	datURL, tmpURL				: string;
	tmpText: string;
	FilePath: String;
begin

	Result := dsError;

	uri := TIdURI.Create( ReadURL );
	uriList := TStringList.Create;
	try
    uri.Protocol := 'https';
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		FileName := uriList[ 5 ] + '.dat';
		// http://jbbs.livedoor.com/bbs/rawmode.cgi/game/1578/1067968274/l100
		// protocol://host/1/2/3/4/5/uriList.Count - 1
		if MyLogFolder = '' then begin
			// �ǂ��ɕۑ����Ă����̂�������Ȃ��̂ňꎞ�t�@�C���ɕۑ�
			FilePath 			:= TemporaryFile;
			FIsTemporary	:= True;
		end else begin
			FilePath			:= MyLogFolder + uriList[ 3 ] + '\' + uriList[ 4 ] + '\' + uriList[ 5 ] + '.dat';
			FIsTemporary	:= False;
		end;
	finally
		uri.Free;
		uriList.Free;
	end;

	// �ۑ��p�̃f�B���N�g�����@��
	ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

	// �Ǝ��Ƀ_�E�����[�h��t�B���^�����O���s��Ȃ��ꍇ��
	// InternalDownload �ɔC���邱�Ƃ��o����
	modified	:= LastModified;
	datURL		:= ReadURL + IntToStr( Count + 1 ) + '-'; // �V���̂�
	responseCode := InternalDownload( PChar( datURL ), modified, tmp, 0 );

	try
		if (responseCode = 200) or (responseCode = 206) then begin
			downResult := TStringList.Create;
			try
				tmpText := CustomStringReplace( string( tmp ), '����', ',' );
				downResult.Text := EUCtoSJIS( tmpText );
				ArrangeDownloadData(Count, downResult);
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

										Size					:= Size + Length( downResult.Text );
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
		end else if (responseCode = 301) or (responseCode = 302) or (responseCode = 404) then begin
			//http://jbbs.shitaraba.com/bbs/read.cgi/game/3477/1077473358/
			//http://jbbs.shitaraba.com/game/bbs/read.cgi?BBS=3477&KEY=1077473358
			//http://jbbs.shitaraba.com/game/3477/storage/1077473358.html
			//�ߋ����O
			//tmpURL := URL;
			if Assigned( InternalPrint ) then
				InternalPrint( '�ߋ����O�q�ɓ���' );
			uri := TIdURI.Create( ReadURL );
			uriList := TStringList.Create;
			try
        uri.Protocol := 'https';
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				tmpURL := uri.Protocol + '://' + uri.Host +
//						'/' + uriList[3] + '/' + uriList[4] + '/storage/' + uriList[ 5 ] + '.html';
//						'/' + uriList[1] + '/read_archive.cgi/' + uriList[3] + '/' + uriList[4] + '/' + uriList[ 5 ] + '/';
						ARCHIVE_PATH + '/' + uriList[3] + '/' + uriList[4] + '/' + uriList[ 5 ] + '/';
			finally
				uriList.Free;
				uri.Free;
			end;
			Result := StorageDownload(tmpURL);
		end else if responseCode = 304 then begin
			Result := dsNotModify;
		end;
	finally
		DisposeResultString( tmp );
	end;

end;
// *************************************************************************
// download���Ă���Dat�̂��ځ[�񂳂ꂽ�����[���āA
// ���X���ƈ�v����悤�ɂ���
// *************************************************************************
procedure	TShitarabaThreadItem.ArrangeDownloadData(
	start: Integer;	// �V�K�F�O�@�ǋL�F�O��܂ł̎擾��
		var Data: TStringList	//Dat�̃f�[�^
);
var
	i: Integer;
		n: Integer;
		tmp: string;
begin
	i := start;
		while i < Data.count + start do begin
			try
					tmp := Copy(Data[i - start], 1 , AnsiPos('<>', Data[ i - start ] )-1 );
						try
							n := StrToInt(tmp);
								if n > i + 1 then begin
									Data.Insert(i - start, Format('%d<><><><><><>', [i+1]));
								end;
								Inc(i);
						except
							Inc(i);
			end;
				except

				end;
		end;

end;
// *************************************************************************
// �ߋ����O�pDownload�֐�
// *************************************************************************
function	TShitarabaThreadItem.StorageDownload(
	AURL : string
) : TDownloadState;
var
	modified			: Double;
	tmp						: PChar;
	uri : TIdURI;
	uriList : TStringList;
	downResult		: TStringList;
	responseCode	: Longint;
	logStream			: TFileStream;
	tmpText, tmpLine, tmpTitle: string;
	tmpHTML: TStringList;

	i, j, tS, tE: Integer;
	tmpDatToken : array[0..6] of string;
	FilePath : String;
begin

	Result := dsError;
	uri := TIdURI.Create( ReadURL );
	uriList := TStringList.Create;
	try
    uri.Protocol := 'https';
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		FileName := uriList[ 5 ] + '.dat';
		// http://jbbs.livedoor.com/bbs/rawmode.cgi/game/1578/1067968274/l100
		// protocol://host/1/2/3/4/5/uriList.Count - 1
		if MyLogFolder = '' then begin
			// �ǂ��ɕۑ����Ă����̂�������Ȃ��̂ňꎞ�t�@�C���ɕۑ�
			FilePath 			:= TemporaryFile;
			FIsTemporary	:= True;
		end else begin
			FilePath			:= MyLogFolder + uriList[ 3 ] + '\' + uriList[ 4 ] + '\' + uriList[ 5 ] + '.dat';
			FIsTemporary	:= False;
		end;
	finally
		uri.Free;
		uriList.Free;
	end;

	// �ۑ��p�̃f�B���N�g�����@��
	ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );



	// �Ǝ��Ƀ_�E�����[�h��t�B���^�����O���s��Ȃ��ꍇ��
	// InternalDownload �ɔC���邱�Ƃ��o����
//	modified	:= LastModified;
	modified	:= 0.0;

	responseCode := InternalDownload( PChar( AURL ), modified, tmp, 0 );

	try
		if (responseCode = 200) or (responseCode = 206) then begin
			downResult := TStringList.Create;
			try
				tmpText := CustomStringReplace( string( tmp ), '����', ',' );



				//**������HTML�t�@�C�����������JBBS��dat�`���ɕϊ�����
				tmpHTML := TStringList.Create;

				try
					tmpHTML.Text := EUCtoSJIS( tmpText );
					//Title�̎擾
					for i := 0 to tmpHTML.Count - 1 do begin
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tS := AnsiPos('<title>', tmpLine);
						tE := AnsiPos('</title>', tmpLine);

						if tS > 0 then begin
							if tE - tS  = 1 then begin
								tmpTitle := '';
							end else begin
								tmpTitle := Copy(tmpHTML[i], ts + 7, Length(tmpHTML[i]));
								tmpLine := AnsiLowerCase(tmpTitle);
								tE := AnsiPos('</title>', tmpLine);

								if tE > 0 then begin
									tmpTitle := Copy(tmpTitle, 1, tE - 1);
									break;
								end else begin
									j := i + 1;
									tmpLine := AnsiLowerCase(tmpHTML[j]);
									tE := AnsiPos('</title>', tmpLine);
									tmpTitle := tmpTitle  + tmpHTML[j];
									while( tE = 0 ) do begin
										j := i + 1;
										if j = tmpHTML.Count then break;
										tmpLine := AnsiLowerCase(tmpHTML[j]);
										tE := AnsiPos('</title>', tmpLine);
										tmpTitle := tmpTitle  + tmpHTML[j];
									end;
									if tE = 0 then tmpTitle := ''
									else begin
										tmpLine := AnsiLowerCase(tmpTitle);
										tE := AnsiPos('</title>', tmpLine);
										tmpTitle := Copy(tmpTitle, 1, tE - 1);
										break;
									end;
								end;
							end;
						end;
					end;
				   //�{���̎擾<DT>���܂܂Ȃ��s���폜���A<DT>���擪�ɂ���悤�ɕ␳
					for i := 0 to tmpHTML.Count - 1 do begin
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tS := AnsiPos('<dt>', tmpLine);
						if tS = 1 then begin
							break;
						end else if tS > 1 then begin
							tmpLine := tmpHTML[i];
							Delete(tmpLine, 1, tS - 1);
							tmpHTML[i] := tmpLine;
							break;
						end;
					end;
					for j := i - 1 downto 0 do
						tmpHTML.Delete(j);
					//�Ō��<DT>�����ɂȂ�悤�Ɍ�납��܂킷
					for i := tmpHTML.Count - 1 downto 0 do begin
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tS := AnsiPos('<dt>', tmpLine);
						if tS > 0 then begin
							break;
						end else begin
							tmpHTML.Delete(i);
						end;
					end;

					//<DD><DT>���ꂼ���s�ɕϊ�����
					for i := tmpHTML.Count - 1 downto 1 do begin
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						if (AnsiPos('<dd>', tmpLine) = 0) and (AnsiPos('<dt>', tmpLine) = 0) then begin
							tmpLine := CustomStringReplace(tmpHTML[i-1], #13#10, '') +
											CustomStringReplace(tmpHTML[i], #13#10, '');
							tmpHTML.Insert(i-1, tmpLine);
							tmpHTML.Delete(i + 1);
							tmpHTML.Delete(i);
						end;
					end;
					//��܂ł̏����ňȉ��̂悤�Ȍ`�ɂȂ��Ă�
					//<dt><a name="958">958 </a> ���O�F<b> ���������R�t </b> ���e���F 2004/06/30(��) 15:17 [ r1FsjJhA ]<br><dd>�`�`
					//<dt><a name="951">951 </a> ���O�F<a href="mailto:sage"><b> ���������R�t </B></a> ���e���F 2004/06/30(��) 12:31 [ .oGr0rtc ]<br><dd>�`�`
					//<dt><a name="951">951 </a> ���O�F<a href="mailto:sage"><b> ���������R�t </B></a> ���e���F 2004/06/30(��) 12:31<br><dd>�`�` <-ID�̂Ȃ���
					//��̂悤�Ȃ̂����̂悤��dat�̌`���ɕϊ�����
					//���X�ԍ�<><font color=#FF0000>HN</font><>������<>���t����<>�{��<>�^�C�g���i�P�̂݁j<>ID
					//2<>���������R�t<>sage<>2004/06/22(��) 09:05<>�Q���Ɓ[<><>26bmLAzg
					for i := 0 to tmpHTML.Count - 1 do begin
						tmpDatToken[0] := ''; tmpDatToken[1] := ''; tmpDatToken[2] := '';
						tmpDatToken[3] := ''; tmpDatToken[4] := ''; tmpDatToken[6] := '';
						//==�܂��͖{�����擾==//
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tS := AnsiPos('<dd>', tmpLine);
						if tS > 0 then begin
							tmpDatToken[4] := Copy(tmpHTML[i], tS + 4, Length(tmpHTML[i]));
							tmpHTML[i] := Copy(tmpHTML[i], 1, tS -1);
						end else
							tmpDatToken[4] := '';
						//====================//
						//==���X�ԍ��擾==//
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tS := AnsiPos('">', tmpLine);
						tE := AnsiPos('</a>', tmpLine);
						if tE > tS then begin
							tmpDatToken[0] := Copy(tmpHTML[i], tS + 2, tE - (tS + 2));
							tmpDatToken[0] := Trim(tmpDatToken[0]);
							tmpHTML[i] := Copy(tmpHTML[i], tE + 4, Length(tmpHTML[i]));
						end else
							tmpDatToken[0] := IntToStr(i);
						tS := AnsiPos('<', tmpHTML[i]);
						if tS > 0 then begin
							tmpHTML[i] := Copy(tmpHTML[i], tS, Length(tmpHTML[i]));
						end;
						//====================//
						//==�������擾==//
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tS := AnsiPos('<a href="mailto:', tmpLine);
						if tS > 0 then begin //�������A��
 							tE := AnsiPos('">', tmpLine);
 							tmpDatToken[2] := Copy(tmpHTML[i], tS + 16, tE - (tS + 16));
 							tmpHTML[i] := Copy(tmpHTML[i], tE + 5, Length(tmpHTML[i]));
 							tmpHTML[i] := CustomStringReplace(tmpHTML[i], '</a>', '', true);
                        end else begin	//����������
							tmpDatToken[2] := '';
						end;
						//====================//
						//==HN�擾==//
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tE := AnsiPos('���e���F', tmpLine);
						if tE > 0 then begin
							tmpDatToken[1] := Trim(Copy(tmpHTML[i], 1, tE - 1 ));
							tmpDatToken[1] := CustomStringReplace(tmpDatToken[1], '<b>', '', true);
							tmpDatToken[1] := CustomStringReplace(tmpDatToken[1], '</b>', '', true);
							tmpHTML[i] := Copy(tmpHTML[i], tE + 8, Length(tmpHTML[i]));
						end else begin
                            // ���e���̂Ȃ��p�^�[�����~��
                            tE := AnsiPos('�F', tmpLine);
                            if tE > 0 then begin
							    tmpDatToken[1] := Trim(Copy(tmpHTML[i], 1, tE - 1 ));
    							tmpDatToken[1] := CustomStringReplace(tmpDatToken[1], '<b>', '', true);
	    						tmpDatToken[1] := CustomStringReplace(tmpDatToken[1], '</b>', '', true);
		    					tmpHTML[i] := Copy(tmpHTML[i], tE + 2, Length(tmpHTML[i]));
			    			end else begin
    							tmpDatToken[1] := '';
                            end;
						end;
						//====================//
						//==���t�����̎擾==//
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tE := AnsiPos('[', tmpLine);
						if tE > 0 then begin
							tmpDatToken[3] := Trim(Copy(tmpHTML[i], 1, tE - 1 ));
							tmpHTML[i] := Copy(tmpHTML[i], tE + 1, Length(tmpHTML[i]));
						end else begin
							tmpDatToken[3] := '';
						end;
						//====================//
						//==ID�̎擾==//
						tmpLine := AnsiLowerCase(tmpHTML[i]);
						tS := AnsiPos('<br>', tmpLine);
						tE := AnsiPos(']', tmpLine);
						if (tE > 0) and (tE < tS) then begin
							tmpDatToken[6] := Trim(Copy(tmpHTML[i], 1, tE - 1 ));
						end else if (tS > 0) then begin
							tmpDatToken[6] := Trim(Copy(tmpHTML[i], 1, tS - 1 ));
						end else
							tmpDatToken[6] := Trim(tmpHTML[i]);
						tmpDatToken[6] := tmpDatToken[6];
						//====================//
						tS := StrToIntDef(tmpDatToken[0], -1);
						if  tS = 1	then
							tmpLine := DeleteFontTag(tmpDatToken[2] + '<>' +
										tmpDatToken[3] + '<>' + tmpDatToken[4] +
										 '<>' + tmpTitle + '<>' + tmpDatToken[6])
						else
							tmpLine :=  DeleteFontTag(tmpDatToken[2] + '<>' +
									tmpDatToken[3] + '<>' + tmpDatToken[4] +
									'<><>' + tmpDatToken[6]);

						tmpHTML[i] := tmpDatToken[0] + '<>' + tmpDatToken[1] + '<>' + tmpLine;
					end;




					downResult.Text := tmpHTML.Text;
				finally
					tmpHTML.free;
				end;

//				ArrangeDownloadData(Count, downResult);
				ArrangeDownloadData(0, downResult);

				if downResult.Count > 0 then begin
					if FileExists( FilePath ) then
						DeleteFile(FilePath);

					logStream := TFileStream.Create( FilePath, fmCreate or fmShareDenyWrite );
					try
						logStream.Position	:= 0;
						logStream.Write( PChar( downResult.Text )^, Length( downResult.Text ) );
					finally
						logStream.Free;
					end;

					// �V�K
					Result := dsComplete;

					Size	:= Length( downResult.Text );
					// CGI ����͐��������t�������Ȃ��̂Ō��݂ɐݒ�
					LastModified	:= Now;



					NewReceive		:= 1;
					Count					:= downResult.Count;
					NewResCount		:= downResult.Count;
					//http://jbbs.livedoor.com/bbs/read.cgi/game/1578/1086710948/l100
					//http://jbbs.livedoor.com/game/1578/storage/1086710948.html
					//URL := 'http://jbbs.livedoor.com/bbs/read.cgi' +
					//		CustomStringReplace(Path, '/storage', '')
					//		+ FileName;
					DownloadHost := 'storage';
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
function TShitarabaThreadItem.GetRes(
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
function TShitarabaThreadItem.GetDat(
	inNo		: Integer		// �v�����ꂽ���X�ԍ�
) : string;						// �Q�����˂��Dat�`��
var
	res		 	: string;
	tmp			: array[1..5] of string;
	i			: Integer;
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
		res := Copy( FDat[ inNo - 1 ], AnsiPos( '<>', FDat[ inNo - 1 ] ) + 2, MaxInt );
		//������ID���\������Ă���̂ł���𓊍e���̂Ƃ���ɓ����
		// ���O<>���[��<>���t<>�{��<>�X���^�C<>ID
		for i := 0 to 4 do begin
			tmp[ i + 1 ] := Copy( res, 1, AnsiPos('<>', res) - 1 );
			Delete( res, 1, AnsiPos('<>', res) + 1 );
		end;
		// ���O<>���[��<>���tID<>�{��<>�X���^�C
		pTmp := CreateResultString(tmp[1] + '<>' + tmp[2] + '<>' + tmp[3] + ' ' + res + '<>'+ tmp[4] + '<>' +tmp[5]);
		Result := string(pTmp);
	finally
		DisposeResultString(pTmp);
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
	tmphost:	String;
const
	BBS_HOST_OLD 	= 'jbbs.shitaraba.com';
	BBS_HOST_OLD2   = 'jbbs.livedoor.com';
	BBS_HOST_OLD3   = 'jbbs.livedoor.jp';
	BBS_HOST	= 'jbbs.shitaraba.net';
begin

	uri			:= TIdURI.Create( ReadURL );
	uriList := TStringList.Create;
	try
    uri.Protocol := 'https';
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

		tmphost := uri.Host;

		if (tmphost = BBS_HOST_OLD) or (tmphost = BBS_HOST_OLD2) or (tmphost = BBS_HOST_OLD3) then
			tmphost := BBS_HOST;

		FileName := uriList[ 5 ] + '.dat';
		// http://jbbs.livedoor.com/bbs/read.cgi/computer/351/1090404452/l100
		// http://jbbs.livedoor.com/bbs/read.cgi/game/1578/1067968274/l100
		// http://jbbs.livedoor.com/game/1000/subject.txt
		Result		:= CreateResultString(
    			uri.Protocol + '://' + tmphost + '/' + uriList[ 3 ] + '/' + uriList[ 4 ] + '/' );
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
// ���S�ȃu���E�U�\���p�� URL
// *************************************************************************
function	TShitarabaThreadItem.BrowsableURL : string;
const
	THREAD_MARK	= '/bbs/read.cgi';
var
	uri				: TIdURI;
	uriList		: TStringList;
	foundPos	: Integer;
	dir, tmphost		: string;
const
	BBS_HOST_OLD 	= 'jbbs.shitaraba.com';
	BBS_HOST_OLD2   = 'jbbs.livedoor.com';
	BBS_HOST_OLD3   = 'jbbs.livedoor.jp';
	BBS_HOST	= 'jbbs.shitaraba.net';
begin

	foundPos := AnsiPos( '?', URL );
	if foundPos > 0 then begin
		// ����
		uri := TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
      uri.Protocol := 'https';
			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			dir := uriList[ 1 ];

			tmphost := uri.Host;
			if (tmphost = BBS_HOST_OLD) or (tmphost = BBS_HOST_OLD2) or (tmphost = BBS_HOST_OLD3) then
				tmphost := BBS_HOST;

			ExtractHttpFields( ['&'], [], Copy( URL, foundPos + 1, MaxInt ), uriList );
			Result :=
				uri.Protocol + '://' + tmphost + '/bbs/read.cgi/' +
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
      uri.Protocol := 'https';
			ExtractHttpFields( ['/'], [], uri.Path, uriList );

			tmphost := uri.Host;
			if (tmphost = BBS_HOST_OLD) or (tmphost = BBS_HOST_OLD2) or (tmphost = BBS_HOST_OLD3)  then
				tmphost := BBS_HOST;

			if( AnsiPos(THREAD_MARK, URL) > 0) and (uriList.Count > 5) then begin
				Result :=
					uri.Protocol + '://' + tmphost + THREAD_MARK + '/' +
					uriList[ 3 ] + '/' + uriList[ 4 ] + '/' + uriList[ 5 ] + '/l100';

			end else if( AnsiPos(ARCHIVE_PATH, URL) > 0) and (uriList.Count > 5) then begin
				Result :=
					uri.Protocol + '://' + tmphost + ARCHIVE_PATH + '/' +
					uriList[ 3 ] + '/' + uriList[ 4 ] + '/' + uriList[ 5 ] + '/l100';

			end else if AnsiPos(THREAD_MARK, URL) = 0 then begin
			//�R�R�ŉߋ����O���ǂ����`�F�b�N�H
				if(AnsiPos('.html/', uri.Path) > 0) then begin
					Result := uri.Protocol + '://' + tmphost + THREAD_MARK +
						CustomStringReplace(CustomStringReplace(uri.Path, '/storage', ''), '.html/', '/') + 'l100';
				end else
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
function	TShitarabaThreadItem.ReadURL : string;
const
	THREAD_MARK	= '/bbs/read.cgi';
var
	uri				: TIdURI;
	uriList		: TStringList;
	foundPos	: Integer;
	dir, tmphost			: string;
const
	BBS_HOST_OLD 	= 'jbbs.shitaraba.com';
	BBS_HOST_OLD2   = 'jbbs.livedoor.com';
	BBS_HOST_OLD3   = 'jbbs.livedoor.jp';
	BBS_HOST	= 'jbbs.shitaraba.net';
begin

	foundPos := AnsiPos( '?', URL );
	if foundPos > 0 then begin
		// ����
		uri := TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
      uri.Protocol := 'https';
			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			dir := uriList[ 1 ];

			tmphost := uri.Host;
			if (tmphost = BBS_HOST_OLD) or (tmphost = BBS_HOST_OLD2)  or (tmphost = BBS_HOST_OLD3) then
				tmphost := BBS_HOST;

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
		if Copy( URL, Length( URL ), 1 ) = '/' then
			uri := TIdURI.Create( URL )
		else
			uri := TIdURI.Create( URL + '/' );
		uriList := TStringList.Create;
		try
      uri.Protocol := 'https';
			ExtractHttpFields( ['/'], [], uri.Path, uriList );

			tmphost := uri.Host;
			if (tmphost = BBS_HOST_OLD) or (tmphost = BBS_HOST_OLD2)  or (tmphost = BBS_HOST_OLD3) then
				tmphost := BBS_HOST;
			// http://jbbs.livedoor.com/bbs/read.cgi/game/1578/1067968274/l100
			if( AnsiPos(THREAD_MARK, URL) > 0) and (uriList.Count > 5) then begin
				Result :=
					uri.Protocol + '://' + tmphost + '/bbs/rawmode.cgi/' +
					uriList[ 3 ] + '/' + uriList[ 4 ] + '/' + uriList[ 5 ] + '/';
			end;
		finally
			uri.Free;
			uriList.Free;
		end;
	end;

end;

// *************************************************************************
// ���S��( '/' �ŏI��� )�������݂� URL
// *************************************************************************
function	TShitarabaThreadItem.WriteURL : string;
var
	uri			: TIdURI;
	uriList	: TStringList;
begin

	if Copy( URL, Length( URL ), 1 ) = '/' then
		uri := TIdURI.Create( URL )
	else
		uri := TIdURI.Create( URL + '/' );
	uriList := TStringList.Create;
	try
    uri.Protocol := 'https';
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		// http://jbbs.livedoor.com/bbs/read.cgi/game/1578/1067968274/l100
		Result		:=
			uri.Protocol + '://' + uri.Host + '/bbs/write.cgi/' +
			uriList[ 3 ] + '/' + uriList[ 4 ] + '/' + uriList[ 5 ] + '/';
	finally
		uri.Free;
		uriList.Free;
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
const
	BBS_HOST_OLD 	= 'jbbs.shitaraba.com';
	BBS_HOST_OLD2   = 'jbbs.livedoor.com';
	BBS_HOST_OLD3   = 'jbbs.livedoor.jp';
	BBS_HOST		= 'jbbs.shitaraba.net';
begin

	inherited;

	OnDownload						:= Download;
	OnCreateThread				:= CreateThread;
	OnEnumThread					:= EnumThread;
	OnFileName2ThreadURL	:= ToThreadURL;

	FilePath			:= '';
	FIsTemporary	:= False;
	FDat					:= nil;
    Is2ch 			:= False;
	uri			:= TIdURI.Create( SubjectURL );
	uriList	:= TStringList.Create;
	try
    uri.Protocol := 'https';
		if (uri.Host = BBS_HOST_OLD) or (uri.Host = BBS_HOST_OLD2) or (uri.Host = BBS_HOST_OLD3) then
			uri.Host := BBS_HOST;
		URL := uri.Protocol + '://' + uri.Host + uri.Path;

		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		// http://jbbs.livedoor.com/game/1000/subject.txt
		FilePath	:= MyLogFolder + uriList[ 1 ] + '\' + uriList[ 2 ] + '\' + uri.Document;
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
	i							: Integer;
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
  uri.Protocol := 'https';
	// �Ǝ��Ƀ_�E�����[�h��t�B���^�����O���s��Ȃ��ꍇ��
	// InternalDownload �ɔC���邱�Ƃ��o����
	modified			:= LastModified;
	responseCode	:= InternalDownload( PChar( uri.URI ), modified, downResult );
	try
		if (responseCode = 200) or (responseCode = 206) then begin
			try
				// �p�X���Z�o
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				if MyLogFolder = '' then begin
					// �ǂ��ɕۑ����Ă����̂�������Ȃ��̂ňꎞ�t�@�C���ɕۑ�
					FilePath 			:= TemporaryFile;
					FIsTemporary	:= True;
				end else begin
					FilePath			:= MyLogFolder + uriList[ 1 ] + '\' + uriList[ 2 ] + '\' + uri.Document;
					FIsTemporary	:= False
				end;

				// �ۑ��p�̃f�B���N�g�����@��
				ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

				// EUC �� Shift_JIS ��
								tmpText := CustomStringReplace( string( downResult ), '����', ',');
				FDat.Text := EUCtoSJIS( tmpText );
				// ������� JBBS �̓`�F�b�N�p�ɐ擪�ƍŏI�s������
				i := FDat.Count - 1;
				if i > 0 then	// 1 ��������㉺���������������� 0 �͊܂܂�
					if FDat[ 0 ] = FDat[ i ] then
						FDat.Delete( i );
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
	responseCode	: Integer;
begin

	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
    uri.Protocol := 'https';
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
        // http://jbbs.livedoor.jp/computer/23340/
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
			'&BBS='			+ uriList[ 2 ] +
			'&DIR='			+ uriList[ 1 ] +
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
      uri.Protocol := 'https';
			ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
			threadURL	:= uri.Protocol + '://' + uri.Host + '/bbs/read.cgi/' +
				uriList[ 1 ] + '/' + uriList[ 2 ] + '/' + inFileName + '/l100';
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
		begin
			RemovePlugInMenu( SyncronizeMenu );
		end;
		DLL_THREAD_ATTACH:
			;
		DLL_THREAD_DETACH:
			;
	end;

end;

exports
	OnLoad,
	OnVersionInfo,
	OnAcceptURL,
	OnPlugInMenu,
    OnExtractBoardURL;
begin

	try
		DllProc := @DLLEntry;
		DLLEntry( DLL_PROCESS_ATTACH );
	except end;

end.
