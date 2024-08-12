library MachiBBSPlugIn;

{
	MachiBBSBoardPlugIn
	�܂�BBS�������j�b�g
}

uses
	Windows, SysUtils, Classes, Math, DateUtils,
	IdURI,
	PlugInMain in 'PlugInMain.pas',
	ThreadItem in 'ThreadItem.pas',
	BoardItem in 'BoardItem.pas',
	FilePath in 'FilePath.pas',
    MojuUtils in '..\..\MojuUtils.pas';

{$R *.res}

type
	// =========================================================================
	// TMachiBBSThreadItem
	// =========================================================================
	TMachiBBSThreadItem = class(TThreadItem)
	private
		FIsTemporary	: Boolean;
		FDat					: TStringList;
		//FFilePath		: String;
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

//		procedure	To2chDat( ioHTML : TStringList; inStartNo : Integer = 1 );
		procedure	To2chDat2( var ioDat: TStringList );
		procedure	LoadDat;
		procedure	FreeDat;
		function	ReadURL : string;
		//property	FilePath : string read FFilePath;
	end;

	// =========================================================================
	// TMachiBBSBoardItem
	// =========================================================================
	TMachiBBSBoardItem = class(TBoardItem)
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
		function	SubjectURL2 : string;
        procedure   ChangeSubjectFormat(var dat: TStringList);
	end;

	// =========================================================================
	// �T�u�W�F�N�g���R�[�h
	// =========================================================================
	TSubjectRec = record
		FFileName: string;
		FTitle: string;
		FCount: Integer;
	end;

const
	LOG_DIR						= 'MachiBBS\';
	SUBJECT_NAME			= 'subject.txt';

	PLUGIN_NAME				= 'MachiBBSPlugIn';
	MAJOR_VERSION			= 1;
	MINOR_VERSION			= 1;
	RELEASE_VERSION		= 'beta';
	REVISION_VERSION	= 27;

var
	GBoardList : TStringList;		// ���X�g


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
// �܂�BBS�p���O�t�H���_�擾
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
	BBS_HOST		= 'machi.to';
	BBS_HOST2		= 'machibbs.com';
	THREAD_MARK	= '/bbs/read.pl';
    THREAD_MARK2= '/bbs/read.cgi';
begin
	try
		// �z�X�g���� machi.to �ŏI���ꍇ�͎󂯕t����悤�ɂ��Ă���
		uri			:= TIdURI.Create( inURL );
		uriList	:= TStringList.Create;
		try
			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			foundPos := AnsiPos( BBS_HOST, uri.Host );
			if (foundPos > 0) and (Length( uri.Host ) - foundPos + 1 = Length( BBS_HOST )) then begin
				foundPos := Pos( THREAD_MARK, inURL );
                if (foundPos = 0) then begin
                    // �VURL�Ή�
                    foundPos := Pos( THREAD_MARK2, inURL );
                end;
				if foundPos > 0 then
					Result := atThread
				else if (uriList.Count > 1) and (uri.Path <> '/') then	// �Ōオ '/' �ŕ߂��Ă�Ȃ� 3
					Result := atBoard
				else
					Result := atBBS;
			end else begin
                foundPos := AnsiPos( BBS_HOST2, uri.Host );
                if (foundPos > 0) and (Length( uri.Host ) - foundPos + 1 = Length( BBS_HOST2 )) then begin
                    foundPos := Pos( THREAD_MARK, inURL );
                    if (foundPos = 0) then begin
                        // �VURL�Ή�
                        foundPos := Pos( THREAD_MARK2, inURL );
                    end;
                    if foundPos > 0 then
                        Result := atThread
                    else if (uriList.Count > 1) and (uri.Path <> '/') then	// �Ōオ '/' �ŕ߂��Ă�Ȃ� 3
                        Result := atBoard
                    else
                        Result := atBBS;
                end else begin

                    Result := atNoAccept;
                end;
			end;
		finally
			uri.Free;
			uriList.Free;
		end;
	except
		Result := atNoAccept;
	end;

end;

// *************************************************************************
// �I���̂Ȃ���URL�����S�Ȕ�URL�ɂ���
// *************************************************************************
function CompleteBoardURL(urlSub: String): String;
var
  i : Integer;
begin
  if GBoardList = nil then
  	Exit;
  try
    for i := 1 to GBoardList.Count - 1 do begin
      if Pos(urlSub, GBoardList.Strings[i]) > 0 then begin
        Result := GBoardList.ValueFromIndex[i];
        Break;
      end;
    end;
  except
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
	uri     : TIdURI;
	uriList : TStringList;
	URL     : String;
  urlSub  : String;
const
	THREAD_MARK	= '/bbs/read.pl';
	THREAD_MARK2= '/bbs/read.cgi';
  HOST21 = '.machi.to';
  HOST22 = 'machi.to';
begin
	URL := string(inURL);
	if AnsiPos(THREAD_MARK, URL) > 0 then begin
		if Copy( inURL, Length( inURL ), 1 ) = '/' then
			uri := TIdURI.Create( URL )
		else
			uri := TIdURI.Create( URL + '/' );

		uriList := TStringList.Create;
		try
			ExtractHttpFields(
				['&'], [],
				Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ),uriList );
			// http://hokkaido.machi.to/bbs/read.pl?BBS=hokkaidou&KEY=1061764446
			// http://hokkaido.machi.to/hokkaidou/
			URL := uri.Protocol + '://' + uri.Host + '/' + uriList.Values[ 'BBS' ] + '/';
			outURL := CreateResultString(URL);
		finally
			uri.Free;
			uriList.Free;
		end;
    end else if AnsiPos(THREAD_MARK2, URL) > 0 then begin
		if Copy( inURL, Length( inURL ), 1 ) = '/' then
			uri := TIdURI.Create( URL )
		else
			uri := TIdURI.Create( URL + '/' );

		uriList := TStringList.Create;
		try
			// http://kanto.machi.to/bbs/read.cgi/kana/1215253035/l50
			// http://kanto.machi.to/kana/
			uriList.Delimiter := '/';
			uriList.DelimitedText  := uri.Path;
      URL := '';
      if (uri.Host = HOST22) and (uriList.Count >= 4) then begin		// �z�X�g���ȗ��i�h���C�����̂݁j
        // URL�̕����镔��
      	urlSub := HOST21 + '/' + uriList[3] + '/';
        // �z�X�g���̂����URL�ɕϊ�
        URL := CompleteBoardURL(urlSub);
      end;
      if URL = '' then begin
        URL := uri.Protocol + '://' + uri.Host + '/';
        if (uriList.Count >= 4) then begin
          URL := URL + uriList[3] + '/';
        end;
      end;
			outURL := CreateResultString(URL);
		finally
			uri.Free;
			uriList.Free;
		end;
	end else begin
    	outURL := CreateResultString(URL);
	end;

end;


// =========================================================================
// TMachiBBSThreadItem
// =========================================================================

// *************************************************************************
// �R���X�g���N�^
// *************************************************************************
constructor TMachiBBSThreadItem.Create(
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
	URL						:= ReadURL + '&LAST=50';

	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
		// http://hokkaido.machi.to/bbs/read.pl?BBS=hokkaidou&KEY=1061764446&LAST=50
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );
		FileName	:= uriList.Values[ 'KEY' ] + '.dat';
		FilePath	:= MyLogFolder + uriList.Values[ 'BBS' ] + '\' + uriList.Values[ 'KEY' ] + '.dat';
		IsLogFile	:= FileExists( FilePath );
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// �f�X�g���N�^
// *************************************************************************
destructor TMachiBBSThreadItem.Destroy;
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
function TMachiBBSThreadItem.Download : TDownloadState;
const
    RES_ERROR: String = '<ERROR>';
var
	modified			: Double;
	tmp						: PChar;
//	downResult		: TStringList;
	content				: TStringList;
	responseCode	: Longint;
	logStream			: TFileStream;
	uri						: TIdURI;
	uriList				: TStringList;
	datURL				: string;
//	foundPos			: Integer;
	FilePath			: String;
	procedure	downAndParse;
	begin
		responseCode := InternalDownload( PChar( datURL ), modified, tmp, 0 );

		try
			if responseCode = 200 then begin
                // API�ł�dat�`���ŕԂ��Ă���
                content.Text := string( tmp );
                if (content.Count > 0) and (Pos(RES_ERROR, content.Strings[0]) <> 1) then
                    To2chDat2( content );   // �`���ϊ�
(* ���d�l�iHTML�Ŏ�M��dat�ɕϊ�����j
				downResult	:= TStringList.Create;
				try
					downResult.Text	:= string( tmp );

					// �^�C�g���̎擾
 					foundPos				:= AnsiPos( '<title>', downResult.Text ) + Length( '<title>' );
					Title						:= Copy(
						downResult.Text,
						foundPos,
						AnsiPos( '</title>', downResult.Text ) - foundPos );

					// ���X�̊J�n�ʒu
					foundPos				:= AnsiPos( '<dt', downResult.Text );
					downResult.Text	:= Copy( downResult.Text, foundPos, Length( downResult.Text ) );
					if foundPos > 0 then begin
						// ���X�̏I���ʒu
						foundPos := AnsiPos( '<table', downResult.Text ) - 1;
						if foundPos > 0 then
							downResult.Text := Copy( downResult.Text, 1, foundPos );
						// �܂�BBS�� dat ���ǂ݂��o���Ȃ����Acgi �ȊO�ɍ����ǂݍ��݂̕��@������킯�ł������̂�
						// �f�̂܂܂𖳗��ɕۂƂ��Ƃ͂����� 2ch �� dat �`���ɕϊ��������̂�ۑ����Ă��܂�
						To2chDat( downResult, Count + 1 );
						content.Text := content.Text + downResult.Text;
					end;
				finally
					downResult.Free;
				end;
*)
			end else begin
				Result := dsNotModify;
				Exit;
			end;
		finally
			DisposeResultString( tmp );
		end;
	end;
begin

	Result := dsError;

	uri			:= TIdURI.Create( URL );
	uriList := TStringList.Create;
	content	:= TStringList.Create;
	try
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );
		FileName := uriList.Values[ 'KEY' ] + '.dat';
		if MyLogFolder = '' then begin
			// �ǂ��ɕۑ����Ă����̂�������Ȃ��̂ňꎞ�t�@�C���ɕۑ�
			FilePath 			:= TemporaryFile;
			FIsTemporary	:= True;
		end else begin
			FilePath	:= MyLogFolder + uriList.Values[ 'BBS' ] + '\' + uriList.Values[ 'KEY' ] + '.dat';
			FIsTemporary	:= False;
		end;

		// �ۑ��p�̃f�B���N�g�����@��
		ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

		// �Ǝ��Ƀ_�E�����[�h��t�B���^�����O���s��Ȃ��ꍇ��
		// InternalDownload �ɔC���邱�Ƃ��o����
		modified	:= LastModified;
        // API��URL
        datURL := uri.Protocol + '://' + uri.Host + '/bbs/offlaw.cgi/2/' +
                    uriList.Values[ 'BBS' ] + '/' + uriList.Values[ 'KEY' ] + '/';
		if (Count > 0) then
            datURL := datURL + IntToStr( Count + 1 ) + '-';     // �V���̂ݎ擾
(* ���`��
		if Count = 0 then
			// 1�`
			datURL		:=
				uri.Protocol + '://' + uri.Host + '/bbs/read.cgi?' +
				'BBS=' + uriList.Values[ 'BBS' ] + '&KEY=' + uriList.Values[ 'KEY' ] +
				'&START=' + IntToStr( 1 )
		else
			// �V���̂�
			datURL		:=
				uri.Protocol + '://' + uri.Host + '/bbs/read.cgi?' +
				'BBS=' + uriList.Values[ 'BBS' ] + '&KEY=' + uriList.Values[ 'KEY' ] +
				'&START=' + IntToStr( Count + 1 ) + '&NOFIRST=TRUE';
*)
		// �_�E�����[�h
		downAndParse;

		if content.Count > 0 then begin
            if (Pos(RES_ERROR, content.Strings[0]) <> 1) then begin
                if Count <= 0 then begin
                    Result := dsComplete;
                    // �V�K��������
                    content[ 0 ]	:= content[ 0 ] + Title;
                    logStream			:= TFileStream.Create( FilePath, fmCreate or fmShareDenyWrite );
                    try
                        logStream.Position	:= logStream.Size;
                        logStream.Write( PChar( content.Text )^, Length( content.Text ) );
                    finally
                        logStream.Free;
                    end;
                    NewReceive	:= 1;
                    Count				:= content.Count;
                end else begin
                    if (content.Count > 1) or (Trim(content.Text) <> '') then begin
                        Result := dsDiffComplete;
                        // �ǋL
                        logStream := TFileStream.Create( FilePath, fmOpenReadWrite or fmShareDenyWrite );
                        try
                            logStream.Position	:= logStream.Size;
                            logStream.Write( PChar( content.Text )^, Length( content.Text ) );
                        finally
                            logStream.Free;
                        end;
                        NewReceive	:= Count + 1;
                        Count				:= Count + content.Count;
                    end else begin
                        Result := dsNotModify;
                    end;
                end;
                if (Result <> dsNotModify) then begin
                    // CGI ����͐��������t�������Ȃ��̂Ō��݂ɐݒ�
                    LastModified	:= Now;
                    NewResCount		:= content.Count;
                end;
            end;
		end else begin
			Result := dsNotModify;
		end;
	finally
		uri.Free;
		uriList.Free;
		content.Free;
	end;

end;

// *************************************************************************
// �������݂��w�����ꂽ
// *************************************************************************
function	TMachiBBSThreadItem.Write(
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
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );

		postURL		:= uri.Protocol + '://' + uri.Host + '/bbs/write.cgi';
		postData	:=
			'NAME='			+ HttpEncode( inName ) +
			'&MAIL='		+ HttpEncode( inMail ) +
			'&MESSAGE='	+ HttpEncode( inMessage ) +
			'&BBS='			+ uriList.Values[ 'BBS' ] +
			'&KEY='			+ uriList.Values[ 'KEY' ] +
			'&TIME='		+ IntToStr( DateTimeToUnix( Now ) ) +
			'&submit='	+ HttpEncode( '��������' );

		// �Ǝ��ɒʐM���Ȃ��ꍇ�� InternalPost �ɔC���邱�Ƃ��o����
		InternalPost( PChar( postURL ), PChar( postData ),PChar(URL), postResult );
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
function TMachiBBSThreadItem.GetRes(
	inNo		: Integer		// �v�����ꂽ���X�ԍ�
) : string;						// �Ή����� HTML
var
	res		 	: string;
	tmp			: PChar;
begin

	// �Ǝ��Ƀt�B���^�����O���s��Ȃ��ꍇ��
	// InternalAbon ����� Dat2HTML �ɔC���邱�Ƃ��o����
	LoadDat;
	if (FDat = nil) or (inNo - 1 < 0 ) or (inNo - 1 >= FDat.Count) then begin
		// ���O�ɑ��݂��Ȃ��̂ł��̂܂܏I��
		Result := '';
		Exit;
	end;
	res			:= FDat[ inNo - 1 ];
	tmp			:= InternalAbonForOne( PChar( res ), PChar(FilePath), inNo);
    try
		Result	:= Dat2HTML( string( tmp ), inNo );
	finally
		DisposeResultString( tmp );
	end;

end;

// *************************************************************************
// ���X�ԍ� inNo �ɑ΂��� Dat ��v�����ꂽ
// *************************************************************************
function TMachiBBSThreadItem.GetDat(
	inNo		: Integer		// �v�����ꂽ���X�ԍ�
) : string;						// �Q�����˂��Dat�`��
var
	//res: string;
	tmp: PChar;
begin
	//Result	:= '';
	// �Ǝ��Ƀt�B���^�����O���s��Ȃ��ꍇ��
	LoadDat;
	if (FDat = nil) or (inNo - 1 < 0 ) or (inNo - 1 >= FDat.Count)  then begin
		// ���O�ɑ��݂��Ȃ��̂ł��̂܂܏I��
		tmp := CreateResultString('');
		Result := tmp;
		DisposeResultString(tmp);
		Exit;
	end;
	tmp := CreateResultString(FDat[ inNo - 1]);
	try
		Result := string(tmp);
	finally
		DisposeResultString(tmp);
	end;

end;

// *************************************************************************
// �X���b�h�̃w�b�_ html ��v�����ꂽ
// *************************************************************************
function TMachiBBSThreadItem.GetHeader(
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
function TMachiBBSThreadItem.GetFooter(
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
function	TMachiBBSThreadItem.GetBoardURL : string;
const
  HOST21 = '.machi.to';
  HOST22 = 'machi.to';
var
	uri						: TIdURI;
	uriList				: TStringList;
	tmp: PChar;
  urlFull: String;
  urlSub: String;
begin
    tmp := nil;
	if Copy( URL, Length( URL ), 1 ) = '/' then
		uri := TIdURI.Create( URL )
	else
		uri := TIdURI.Create( URL + '/' );
	uriList := TStringList.Create;
	try
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );
		FileName := uriList.Values[ 'KEY' ] + '.dat';
		// http://hokkaido.machi.to/bbs/read.pl?BBS=hokkaidou&KEY=1061764446
		// http://hokkaido.machi.to/hokkaidou/
		urlSub := uri.Host + '/' + uriList.Values[ 'BBS' ] + '/';
    if uri.Host = HOST22 then
			urlFull := CompleteBoardURL(urlSub);
    if urlFull <> '' then
      tmp := CreateResultString(urlFull)
    else
			tmp := CreateResultString(uri.Protocol + '://' + urlSub);
		Result := string(tmp);
	finally
		DisposeResultString(tmp);
		uri.Free;
		uriList.Free;
	end;

end;

(*
// *************************************************************************
// �܂�BBS�� HTML �� 2ch �� dat �`����
// *************************************************************************
procedure	TMachiBBSThreadItem.To2chDat(
	ioHTML				: TStringList;
	inStartNo			: Integer = 1
);
var
	i, bound			: Integer;
	foundPos,foundPos2			: Integer;
	strTmp				: string;
	res						: TStringList;
	no						: Integer;
const
	MAIL_TAG			= '<a href="mailto:';
begin

	//===== 2ch �� dat �`���ɕϊ�
	// �z�X�g���̌�ŉ��s����Ă����肷��̂ŉ��s�����ׂĎ�菜��
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, #13#10, '');
	//StringReplace( ioHTML.Text, #13#10, '', [rfReplaceAll] );
	// ����� <dt> ���s�̋�؂�ɂ���
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<dt>', #10 );
	//StringReplace( ioHTML.Text, '<dt>', #10, [rfReplaceAll] );
	// <dt> ����n�܂��Ă���̂ōŏ��͋�̂͂�
	if Length( ioHTML[ 0 ] ) = 0 then
		ioHTML.Delete( 0 );

	// �y�����ځ[��`�F�b�N
	// ����G�c�����炿���Əo���ĂȂ�����
	try
		i			:= 0;
		while i < ioHTML.Count do begin
			foundPos := AnsiPos( ' ', ioHTML[ i ] );
			if foundPos > 0 then begin
				no := StrToInt( Copy( ioHTML[ i ], 1, foundPos - 1 ) );
				if inStartNo < no then
					ioHTML.Insert( i, '<><><><>' );
			end;
			Inc( i );
			Inc( inStartNo );
		end;
	except
		// ���ځ[��`�F�b�N�Ŗ�肪�������Ă���֐i�߂����̂�
	end;


	// �g���b�v�̌�� '<b> </b>' �����
    if AnsiPos('��</b>', ioHTML.Text) <> 0 then begin
    	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<b> </b></font>', '</b></font>', true );
        ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<b> </B></a>', '</b></a>', true );
    end;
	//ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<b> </b>', '', true );
	//StringReplace( ioHTML.Text, '<b> </b>', '', [rfReplaceAll, rfIgnoreCase] );
	// '<b>' �̓��[���Ɩ��O�̋�؂�
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<b>', '<>', true );
	//StringReplace( ioHTML.Text, '<b>', '<>', [rfReplaceAll, rfIgnoreCase] );
	// ���[���Ɩ��O�ɂ��Ă�����^�O�𓊍e���Ƃ̋�؂��
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '</b></a>', '<>', true );
	//StringReplace( ioHTML.Text, '</b></a>', '<>', [rfReplaceAll, rfIgnoreCase] );
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '</b>', '<>', true );
    ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '��<>', '��</b>', true );
	//StringReplace( ioHTML.Text, '</b>', '<>', [rfReplaceAll, rfIgnoreCase] );
	// '<dd>' ��{���Ƃ̋�؂��
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<dd>', '<>', true );
	//StringReplace( ioHTML.Text, '<dd>', '<>', [rfReplaceAll, rfIgnoreCase] );

	res := TStringList.Create;
	try
		bound := ioHTML.Count - 1;
		for i := 0 to bound do begin
            // �X�N���v�g���܂܂�Ă�����폜����i�L���΍�j
			res.Text := CustomStringReplace( ioHTML[ i ], '<>', #10 );
						//StringReplace( ioHTML[ i ], '<>', #10, [rfReplaceAll] );
			if res.Count >= 3 then begin	// 3 �����͂��肦�Ȃ��Ǝv�����ǈ��S�̂���
				foundPos := AnsiPos( MAIL_TAG, res[ 0 ] );
				if foundPos > 0 then begin
					// ���[���A�h���X�𔲂��o��
					foundPos	:= foundPos + Length( MAIL_TAG );
					res[ 0 ]	:= Copy( res[ 0 ], foundPos, Length( res[ 0 ] ) );
					strTmp		:= Copy( res[ 0 ], 1, AnsiPos( '">', res[ 0 ] ) - 1 );
					// ���[���Ɩ��O���t�Ȃ̂łЂ�����Ԃ��Ė߂�
					res[ 0 ]	:= res[ 1 ];
					res[ 1 ]	:= strTmp;
				end else begin
					// ���[���Ɩ��O���t�Ȃ̂łЂ�����Ԃ�
					res[ 0 ]	:= res[ 1 ];
					res[ 1 ]	:= '';
				end;
				res[ 2 ] := StringReplace( res[ 2 ], '[', 'IP:', [] );
				res[ 2 ] := StringReplace( res[ 2 ], ']', '', [] );

                if AnsiPos('</font> ���e���F', res[ 2 ]) = 1 then begin
                	res[ 2 ] := StringReplace( res[ 2 ], '</font> ���e���F', '', [] );
                end else if AnsiPos(' ���e���F', res[ 2 ]) = 1 then begin
                    res[ 2 ] := StringReplace( res[ 2 ], ' ���e���F', '', [] );
                end;
			end;
			ioHTML[ i ] := CustomStringReplace( res.Text, #13#10, '<>');
            // �L���X�N���v�g�΍�
            foundPos := Pos( '<script', ioHTML[ i ] );
            if foundPos > 0 then begin
                foundPos2 := Pos( '</script>', ioHTML[ i ] );
                if (foundPos2 > foundPos) then begin
                    ioHTML[ i ] := Copy(ioHTML[ i ], 1, foundPos-1) +
                                   Copy(ioHTML[ i ], foundPos2 + 9, Length(ioHTML[ i ]));
                end;
            end;
		end;
	finally
		res.Free;
	end;

end;
*)

// *************************************************************************
// �܂�BBS�� dat �� 2ch �� dat �`����
// *************************************************************************
procedure	TMachiBBSThreadItem.To2chDat2( var ioDat: TStringList );
const
    SEP_TAG: String = '<>';
    ITEM_NUM:  Integer = 7;
    IDX_HOST:  Integer = 6;
    IDX_ID:    Integer = 3;
    IDX_ADDST: Integer = 1;
    IDX_ADDED: Integer = 5;
    IDX_NO:    Integer = 0;
var
    DstTmp: TStringList;
    ResLine: TStringList;
    TmpLine: String;
    i: Integer;
    j: Integer;
    Sep: Integer;
    No: Integer;
    GetNo: Integer;
begin
    DstTmp := TStringList.Create;
    ResLine := TStringList.Create;
    try
        No := Count + 1;    // �s�ԍ��i���X�ԍ��j
        for i := 0 to ioDat.Count - 1 do begin
            // �P�s�����ڕʂɐ؂蕪����
            ResLine.Clear;
            TmpLine := ioDat.Strings[i];
            while (True) do begin
                Sep := Pos(SEP_TAG, TmpLine);
                if (Sep > 0) then begin
                    ResLine.Add(Copy(TmpLine, 1, Sep - 1));
                    Delete(TmpLine, 1, Sep + 1);
                end else begin
                    ResLine.Add(TmpLine);
                    Break;
                end;
            end;
            while (ResLine.Count < ITEM_NUM) do
                ResLine.Add('');    // �s�����ڐ������ǉ�

            // �z�X�g����ID�̌��ɒǉ�
            ResLine.Strings[IDX_ID] := ResLine.Strings[IDX_ID] + ' <font size=1>IP: ' + ResLine.Strings[IDX_HOST] + ' </font>';

            // �K�v���ڂ����Č���
            for j := IDX_ADDST to IDX_ADDED do begin
                if (j = IDX_ADDST) then
                    TmpLine := ResLine.Strings[j]
                else
                    TmpLine := TmpLine + SEP_TAG + ResLine.Strings[j];
            end;

            GetNo := StrToIntDef(ResLine.Strings[IDX_NO], 0);
            while (GetNo > No) do begin
                DstTmp.Add('');
                Inc(No);
            end;

            DstTmp.Add(TmpLine);

            Inc(No);
        end;
        ioDat.Clear;
        ioDat.Assign(DstTmp);
	finally
        ResLine.Free;
        DstTmp.Free;
	end;
end;

// *************************************************************************
// FDat �̐���
// *************************************************************************
procedure	TMachiBBSThreadItem.LoadDat;
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
procedure	TMachiBBSThreadItem.FreeDat;
begin

	if FDat <> nil then begin
		FDat.Free;
		FDat := nil;
	end;

end;

// *************************************************************************
// ���S��( '/' �ŏI��� )�ǂݍ��݂� URL
// *************************************************************************
function	TMachiBBSThreadItem.ReadURL : string;
var
	uri				: TIdURI;
	uriList		: TStringList;
	foundPos	: Integer;
const
    THREAD_MARK2= '/bbs/read.cgi';
begin

	foundPos := AnsiPos( '?', URL );
	if foundPos > 0 then begin
		uri := TIdURI.Create( URL );
		uriList := TStringList.Create;
		try
			ExtractHttpFields( ['&'], [], Copy( URL, foundPos + 1, MaxInt ), uriList );
			Result :=
				uri.Protocol + '://' + uri.Host + '/bbs/read.pl?' +
				'BBS=' + uriList.Values[ 'BBS' ] + '&KEY=' + uriList.Values[ 'KEY' ];
		finally
			uri.Free;
			uriList.Free;
		end;
	end else begin
        // �V�`�� ?
        foundPos := AnsiPos(THREAD_MARK2, URL);
    	if (foundPos > 0) then begin
            uri := TIdURI.Create( URL );
            uriList := TStringList.Create;
            try
                uriList.Delimiter := '/';
                uriList.DelimitedText  := uri.Path;
                if (uriList.Count >= 5) then begin
    			    Result :=
	    			    uri.Protocol + '://' + uri.Host + '/bbs/read.pl?' +
		    		    'BBS=' + uriList[3] + '&KEY=' + uriList[4];
                end;
            finally
    			uri.Free;
	    		uriList.Free;
            end;
        end;
    end;

end;

// *************************************************************************
// TThreadItem ���������ꂽ�ꍇ�̏��u(TMachiBBSThreadItem �𐶐�����)
// *************************************************************************
procedure ThreadItemOnCreateOfTMachiBBSThreadItem(
	inInstance : DWORD
);
var
	threadItem : TMachiBBSThreadItem;
begin

	threadItem := TMachiBBSThreadItem.Create( inInstance );
	ThreadItemSetLong( inInstance, tipContext, DWORD( threadItem ) );

end;

// *************************************************************************
// TThreadItem ���j�����ꂽ�ꍇ�̏��u(TMachiBBSThreadItem ��j������)
// *************************************************************************
procedure ThreadItemOnDisposeOfTMachiBBSThreadItem(
	inInstance : DWORD
);
var
	threadItem : TMachiBBSThreadItem;
begin

	threadItem := TMachiBBSThreadItem( ThreadItemGetLong( inInstance, tipContext ) );
	threadItem.Free;

end;

// =========================================================================
// TMachiBBSBoardItem
// =========================================================================

// *************************************************************************
// �R���X�g���N�^
// *************************************************************************
constructor TMachiBBSBoardItem.Create(
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
    Is2ch			:= False;

	uri			:= TIdURI.Create( SubjectURL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		// http://hokkaido.machi.to/hokkaidou/subject.txt
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
destructor TMachiBBSBoardItem.Destroy;
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
function TMachiBBSBoardItem.Download : TDownloadState;
var
	modified			: Double;
	downResult		: PChar;
	responseCode	: Longint;
	uri						: TIdURI;
	uriList				: TStringList;
    dlURL           : String;
begin

	Result := dsError;

	if FDat <> nil then begin
		try
			FDat.Free;
			FDat := nil;
		except
		end;
	end;
	FDat		:= TStringList.Create;
	uri			:= TIdURI.Create( SubjectURL );
	uriList	:= TStringList.Create;
	// �Ǝ��Ƀ_�E�����[�h��t�B���^�����O���s��Ȃ��ꍇ��
	// InternalDownload �ɔC���邱�Ƃ��o����
	modified			:= LastModified;
    dlURL       := SubjectURL2;
//	responseCode	:= InternalDownload( PChar( uri.URI ), modified, downResult );
	responseCode	:= InternalDownload( PChar( dlURL ), modified, downResult );
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
					FilePath			:= MyLogFolder + uriList[ 1 ] + '\' + uri.Document;
					FIsTemporary	:= False
				end;

				// �ۑ��p�̃f�B���N�g�����@��
				ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

				FDat.Text := string( downResult );
                // �`���ϊ�(Ver.2->Ver.1)
                ChangeSubjectFormat(FDat);
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

procedure TMachiBBSBoardItem.ChangeSubjectFormat(var dat: TStringList);
var
    i: Integer;
    sep: Integer;
    tmp: String;
begin
    for i := 0 to dat.Count - 1 do begin
        tmp := dat.Strings[i];
        sep := Pos('<>', tmp);
        if (sep > 0) then begin
            Delete(tmp, 1, sep + 1);
            sep := Pos('<>', tmp);
            if (sep > 0) then begin
                Delete(tmp, sep, 2);
                Insert('.cgi,', tmp, sep);
                dat.Strings[i] := tmp;
            end;
        end;
    end;
end;


// *************************************************************************
// �X�����Ă��w�����ꂽ
// *************************************************************************
function	TMachiBBSBoardItem.CreateThread(
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
		ExtractHttpFields(
			['&'], [],
			Copy( uri.Params, AnsiPos( '?', uri.Params ) + 1, Length( uri.Params ) ), uriList );

		postURL		:= uri.Protocol + '://' + uri.Host + '/bbs/write.cgi';
		postData	:=
			'SUBJECT='	+ HttpEncode( inSubject ) +
			'&NAME='		+ HttpEncode( inName ) +
			'&MAIL='		+ HttpEncode( inMail ) +
			'&MESSAGE='	+ HttpEncode( inMessage ) +
			'&BBS='			+ uriList[ 1 ] +
			'&TIME='		+ IntToStr( DateTimeToUnix( Now ) ) +
			'&submit='	+ HttpEncode( '�V�K��������' );

		// �Ǝ��ɒʐM���Ȃ��ꍇ�� InternalPost �ɔC���邱�Ƃ��o����
		InternalPost( PChar( postURL ), PChar( postData ),PChar(URL), postResult );
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
function TMachiBBSBoardItem.ToThreadURL(
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
			// http://hokkaido.machi.to/hokkaidou/
			// http://hokkaido.machi.to/bbs/read.pl?BBS=hokkaidou&KEY=1061764446&LAST=50
			ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
			threadURL	:= uri.Protocol + '://' + uri.Host + '/bbs/read.pl?' +
				'BBS=' + uriList[ 1 ] + '&KEY=' + inFileName + '&LAST=50';
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
procedure	TMachiBBSBoardItem.EnumThread(
	inCallBack	: TBoardItemEnumThreadCallBack
);
var
	uri		 			: TIdURI;
	uriList			: TStringList;
begin

	try
		if FDat = nil then begin
			FDat := TStringList.Create;

			uri			:= TIdURI.Create( SubjectURL );
			uriList	:= TStringList.Create;
			try
				// �p�X���Z�o
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				// http://hokkaido.machi.to/hokkaidou/subject.txt
				FilePath	:= MyLogFolder + uriList[ 1 ] + '\' + uri.Document;
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
function	TMachiBBSBoardItem.SubjectURL : string;
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
// �X���ꗗ�� URL �����߂�(Ver2)
// *************************************************************************
function	TMachiBBSBoardItem.SubjectURL2 : string;
var
	uri: TIdURI;
begin

	uri := TIdURI.Create( URL );
	try
        Result := uri.Protocol + '://' + uri.Host + '/bbs/offlaw.cgi/2' + uri.Path;
	finally
		uri.Free;
	end;
end;

// *************************************************************************
// TBoardItem ���������ꂽ�ꍇ�̏��u(TMachiBBSBoardItem �𐶐�����)
// *************************************************************************
procedure BoardItemOnCreateOfTMachiBBSBoardItem(
	inInstance : DWORD
);
var
	boardItem : TMachiBBSBoardItem;
begin

	boardItem := TMachiBBSBoardItem.Create( inInstance );
	BoardItemSetLong( inInstance, bipContext, DWORD( boardItem ) );

end;

// *************************************************************************
// TBoardItem ���j�����ꂽ�ꍇ�̏��u(TMachiBBSBoardItem ��j������)
// *************************************************************************
procedure BoardItemOnDisposeOfTMachiBBSBoardItem(
	inInstance : DWORD
);
var
	boardItem : TMachiBBSBoardItem;
begin

	boardItem := TMachiBBSBoardItem( BoardItemGetLong( inInstance, bipContext ) );
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
  path : String;
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

			// ===== �C���X�^���X�̎�舵���� TThreadItem ���� TMachiBBSThreadItem �ɕύX����
			ThreadItemOnCreate	:= ThreadItemOnCreateOfTMachiBBSThreadItem;
			ThreadItemOnDispose	:= ThreadItemOnDisposeOfTMachiBBSThreadItem;
			// ===== �C���X�^���X�̎�舵���� TBoardItem ���� TMachiBBSBoardItem �ɕύX����
			BoardItemOnCreate		:= BoardItemOnCreateOfTMachiBBSBoardItem;
			BoardItemOnDispose	:= BoardItemOnDisposeOfTMachiBBSBoardItem;

    	// ���X�g�ǂݍ���
      path := PreferencesFolder + '\Board\�܂�BBS.txt';
      if FileExists(path) then begin
				GBoardList := TStringList.Create;
        try
          GBoardList.LoadFromFile(path);
        except
        end;
      end;

		end;
		DLL_PROCESS_DETACH:
    begin
    	if GBoardList <> nil then
      	FreeAndNil(GBoardList);
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
