library MachiBBSPlugIn;

{
	MachiBBSBoardPlugIn
	まちBBS処理ユニット
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
	// サブジェクトレコード
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
	GBoardList : TStringList;		// 板リスト


// =========================================================================
// 雑用関数
// =========================================================================

// *************************************************************************
// テンポラリなパスの取得
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
// まちBBS用ログフォルダ取得
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
 *ディレクトリが存在するかチェック
 *************************************************************************)
function DirectoryExistsEx(const Name: string): Boolean;
var
	Code: Integer;
begin
	Code := GetFileAttributes(PChar(Name));
	Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

(*************************************************************************
 *ディレクトリ作成（複数階層対応）
 *************************************************************************)
function ForceDirectoriesEx(Dir: string): Boolean;
begin
	Result := True;
	if Length(Dir) = 0 then
		raise Exception.Create('フォルダが作成出来ません');
	Dir := ExcludeTrailingPathDelimiter(Dir);
	if (Length(Dir) < 3) or DirectoryExistsEx(Dir)
		or (ExtractFilePath(Dir) = Dir) then Exit; // avoid 'xyz:\' problem.
	Result := ForceDirectoriesEx(ExtractFilePath(Dir)) and CreateDir(Dir);
end;

// とりあえずの代用品なので chrWhite を考慮していないことに注意！！！
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
// プラグインのバージョンを要求された
// *************************************************************************
procedure OnVersionInfo(
	var outAgent		: PChar;	// バージョンを一切含まない純粋な名称
	var outMajor		: DWORD;	// メジャーバージョン
	var outMinor		: DWORD;	// マイナーバージョン
	var outRelease	: PChar;	// リリース段階名
	var outRevision	: DWORD		// リビジョンナンバー
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
// 指定した URL をこのプラグインで受け付けるかどうか
// *************************************************************************
function OnAcceptURL(
	inURL			: PChar				// 判断を仰いでいる URL
): TAcceptType; stdcall;	// URL の種類
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
		// ホスト名が machi.to で終わる場合は受け付けるようにしている
		uri			:= TIdURI.Create( inURL );
		uriList	:= TStringList.Create;
		try
			ExtractHttpFields( ['/'], [], uri.Path, uriList );
			foundPos := AnsiPos( BBS_HOST, uri.Host );
			if (foundPos > 0) and (Length( uri.Host ) - foundPos + 1 = Length( BBS_HOST )) then begin
				foundPos := Pos( THREAD_MARK, inURL );
                if (foundPos = 0) then begin
                    // 新URL対応
                    foundPos := Pos( THREAD_MARK2, inURL );
                end;
				if foundPos > 0 then
					Result := atThread
				else if (uriList.Count > 1) and (uri.Path <> '/') then	// 最後が '/' で閉められてるなら 3
					Result := atBoard
				else
					Result := atBBS;
			end else begin
                foundPos := AnsiPos( BBS_HOST2, uri.Host );
                if (foundPos > 0) and (Length( uri.Host ) - foundPos + 1 = Length( BBS_HOST2 )) then begin
                    foundPos := Pos( THREAD_MARK, inURL );
                    if (foundPos = 0) then begin
                        // 新URL対応
                        foundPos := Pos( THREAD_MARK2, inURL );
                    end;
                    if foundPos > 0 then
                        Result := atThread
                    else if (uriList.Count > 1) and (uri.Path <> '/') then	// 最後が '/' で閉められてるなら 3
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
// 鯖名のない板URLを完全な板URLにする
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
// 指定した URL をBoardのURLに変換
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
      if (uri.Host = HOST22) and (uriList.Count >= 4) then begin		// ホスト名省略（ドメイン名のみ）
        // URLの分かる部分
      	urlSub := HOST21 + '/' + uriList[3] + '/';
        // ホスト名のある板URLに変換
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
// コンストラクタ
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
// デストラクタ
// *************************************************************************
destructor TMachiBBSThreadItem.Destroy;
begin

	FreeDat;

	// 一時ファイルの場合は削除する
	if FIsTemporary then
		DeleteFile( FilePath );

	inherited;

end;

// *************************************************************************
// 指定した URL のスレッドのダウンロードを指示された
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
                // APIではdat形式で返ってくる
                content.Text := string( tmp );
                if (content.Count > 0) and (Pos(RES_ERROR, content.Strings[0]) <> 1) then
                    To2chDat2( content );   // 形式変換
(* 旧仕様（HTMLで受信しdatに変換する）
				downResult	:= TStringList.Create;
				try
					downResult.Text	:= string( tmp );

					// タイトルの取得
 					foundPos				:= AnsiPos( '<title>', downResult.Text ) + Length( '<title>' );
					Title						:= Copy(
						downResult.Text,
						foundPos,
						AnsiPos( '</title>', downResult.Text ) - foundPos );

					// レスの開始位置
					foundPos				:= AnsiPos( '<dt', downResult.Text );
					downResult.Text	:= Copy( downResult.Text, foundPos, Length( downResult.Text ) );
					if foundPos > 0 then begin
						// レスの終了位置
						foundPos := AnsiPos( '<table', downResult.Text ) - 1;
						if foundPos > 0 then
							downResult.Text := Copy( downResult.Text, 1, foundPos );
						// まちBBSは dat 直読みが出来ないし、cgi 以外に差分読み込みの方法があるわけでも無いので
						// 素のままを無理に保とうとはせずに 2ch の dat 形式に変換したものを保存してしまう
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
			// どこに保存していいのか分からないので一時ファイルに保存
			FilePath 			:= TemporaryFile;
			FIsTemporary	:= True;
		end else begin
			FilePath	:= MyLogFolder + uriList.Values[ 'BBS' ] + '\' + uriList.Values[ 'KEY' ] + '.dat';
			FIsTemporary	:= False;
		end;

		// 保存用のディレクトリを掘る
		ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

		// 独自にダウンロードやフィルタリングを行わない場合は
		// InternalDownload に任せることが出来る
		modified	:= LastModified;
        // APIのURL
        datURL := uri.Protocol + '://' + uri.Host + '/bbs/offlaw.cgi/2/' +
                    uriList.Values[ 'BBS' ] + '/' + uriList.Values[ 'KEY' ] + '/';
		if (Count > 0) then
            datURL := datURL + IntToStr( Count + 1 ) + '-';     // 新着のみ取得
(* 旧形式
		if Count = 0 then
			// 1～
			datURL		:=
				uri.Protocol + '://' + uri.Host + '/bbs/read.cgi?' +
				'BBS=' + uriList.Values[ 'BBS' ] + '&KEY=' + uriList.Values[ 'KEY' ] +
				'&START=' + IntToStr( 1 )
		else
			// 新着のみ
			datURL		:=
				uri.Protocol + '://' + uri.Host + '/bbs/read.cgi?' +
				'BBS=' + uriList.Values[ 'BBS' ] + '&KEY=' + uriList.Values[ 'KEY' ] +
				'&START=' + IntToStr( Count + 1 ) + '&NOFIRST=TRUE';
*)
		// ダウンロード
		downAndParse;

		if content.Count > 0 then begin
            if (Pos(RES_ERROR, content.Strings[0]) <> 1) then begin
                if Count <= 0 then begin
                    Result := dsComplete;
                    // 新規書き込み
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
                        // 追記
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
                    // CGI からは正しい日付が得られないので現在に設定
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
// 書き込みを指示された
// *************************************************************************
function	TMachiBBSThreadItem.Write(
	inName				: string;	// 名前(ハンドル)
	inMail				: string;	// メールアドレス
	inMessage			: string	// 本文
) : TDownloadState;				// 書き込みが成功したかどうか
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
			'&submit='	+ HttpEncode( '書き込む' );

		// 独自に通信しない場合は InternalPost に任せることが出来る
		InternalPost( PChar( postURL ), PChar( postData ),PChar(URL), postResult );
		DisposeResultString( postResult );

		Result := dsComplete
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// レス番号 inNo に対する html を要求された
// *************************************************************************
function TMachiBBSThreadItem.GetRes(
	inNo		: Integer		// 要求されたレス番号
) : string;						// 対応する HTML
var
	res		 	: string;
	tmp			: PChar;
begin

	// 独自にフィルタリングを行わない場合は
	// InternalAbon および Dat2HTML に任せることが出来る
	LoadDat;
	if (FDat = nil) or (inNo - 1 < 0 ) or (inNo - 1 >= FDat.Count) then begin
		// ログに存在しないのでこのまま終了
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
// レス番号 inNo に対する Dat を要求された
// *************************************************************************
function TMachiBBSThreadItem.GetDat(
	inNo		: Integer		// 要求されたレス番号
) : string;						// ２ちゃんねるのDat形式
var
	//res: string;
	tmp: PChar;
begin
	//Result	:= '';
	// 独自にフィルタリングを行わない場合は
	LoadDat;
	if (FDat = nil) or (inNo - 1 < 0 ) or (inNo - 1 >= FDat.Count)  then begin
		// ログに存在しないのでこのまま終了
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
// スレッドのヘッダ html を要求された
// *************************************************************************
function TMachiBBSThreadItem.GetHeader(
	inOptionalHeader	: string
) : string;
begin

	// 独自にフィルタリングを行わない場合は
	// InternalHeader に任せることが出来る
	Result := InternalHeader(
		'<meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">' +
		inOptionalHeader );


	// GetRes を呼ばれることが予想されるので FDat を生成しておく
	try
		FreeDat;
		LoadDat;
	except
	end;

end;

// *************************************************************************
// スレッドのフッタ html を要求された
// *************************************************************************
function TMachiBBSThreadItem.GetFooter(
	inOptionalFooter : string
) : string;
begin

	// 独自にフィルタリングを行わない場合は
	// InternalFooter に任せることが出来る
	Result := InternalFooter( inOptionalFooter );

	// もう GetRes は呼ばれないと思うので FDat を開放しておく
	try
		FreeDat;
	except
	end;

end;

// *************************************************************************
// この ThreadItem が属する板の URL を要求された
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
// まちBBSの HTML を 2ch の dat 形式に
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

	//===== 2ch の dat 形式に変換
	// ホスト名の後で改行されていたりするので改行をすべて取り除く
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, #13#10, '');
	//StringReplace( ioHTML.Text, #13#10, '', [rfReplaceAll] );
	// 代わりに <dt> を行の区切りにする
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<dt>', #10 );
	//StringReplace( ioHTML.Text, '<dt>', #10, [rfReplaceAll] );
	// <dt> から始まっているので最初は空のはず
	if Length( ioHTML[ 0 ] ) = 0 then
		ioHTML.Delete( 0 );

	// 軽くあぼーんチェック
	// ※大雑把だからちゃんと出来てないかも
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
		// あぼーんチェックで問題が発生しても先へ進めたいので
	end;


	// トリップの後の '<b> </b>' を空に
    if AnsiPos('◆</b>', ioHTML.Text) <> 0 then begin
    	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<b> </b></font>', '</b></font>', true );
        ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<b> </B></a>', '</b></a>', true );
    end;
	//ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<b> </b>', '', true );
	//StringReplace( ioHTML.Text, '<b> </b>', '', [rfReplaceAll, rfIgnoreCase] );
	// '<b>' はメールと名前の区切り
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<b>', '<>', true );
	//StringReplace( ioHTML.Text, '<b>', '<>', [rfReplaceAll, rfIgnoreCase] );
	// メールと名前についてくる閉じタグを投稿日との区切りに
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '</b></a>', '<>', true );
	//StringReplace( ioHTML.Text, '</b></a>', '<>', [rfReplaceAll, rfIgnoreCase] );
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '</b>', '<>', true );
    ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '◆<>', '◆</b>', true );
	//StringReplace( ioHTML.Text, '</b>', '<>', [rfReplaceAll, rfIgnoreCase] );
	// '<dd>' を本文との区切りに
	ioHTML.Text	:= CustomStringReplace( ioHTML.Text, '<dd>', '<>', true );
	//StringReplace( ioHTML.Text, '<dd>', '<>', [rfReplaceAll, rfIgnoreCase] );

	res := TStringList.Create;
	try
		bound := ioHTML.Count - 1;
		for i := 0 to bound do begin
            // スクリプトが含まれていたら削除する（広告対策）
			res.Text := CustomStringReplace( ioHTML[ i ], '<>', #10 );
						//StringReplace( ioHTML[ i ], '<>', #10, [rfReplaceAll] );
			if res.Count >= 3 then begin	// 3 未満はありえないと思うけど安全のため
				foundPos := AnsiPos( MAIL_TAG, res[ 0 ] );
				if foundPos > 0 then begin
					// メールアドレスを抜き出す
					foundPos	:= foundPos + Length( MAIL_TAG );
					res[ 0 ]	:= Copy( res[ 0 ], foundPos, Length( res[ 0 ] ) );
					strTmp		:= Copy( res[ 0 ], 1, AnsiPos( '">', res[ 0 ] ) - 1 );
					// メールと名前が逆なのでひっくり返して戻す
					res[ 0 ]	:= res[ 1 ];
					res[ 1 ]	:= strTmp;
				end else begin
					// メールと名前が逆なのでひっくり返す
					res[ 0 ]	:= res[ 1 ];
					res[ 1 ]	:= '';
				end;
				res[ 2 ] := StringReplace( res[ 2 ], '[', 'IP:', [] );
				res[ 2 ] := StringReplace( res[ 2 ], ']', '', [] );

                if AnsiPos('</font> 投稿日：', res[ 2 ]) = 1 then begin
                	res[ 2 ] := StringReplace( res[ 2 ], '</font> 投稿日：', '', [] );
                end else if AnsiPos(' 投稿日：', res[ 2 ]) = 1 then begin
                    res[ 2 ] := StringReplace( res[ 2 ], ' 投稿日：', '', [] );
                end;
			end;
			ioHTML[ i ] := CustomStringReplace( res.Text, #13#10, '<>');
            // 広告スクリプト対策
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
// まちBBSの dat を 2ch の dat 形式に
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
        No := Count + 1;    // 行番号（レス番号）
        for i := 0 to ioDat.Count - 1 do begin
            // １行を項目別に切り分ける
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
                ResLine.Add('');    // 不足項目数だけ追加

            // ホスト名をIDの後ろに追加
            ResLine.Strings[IDX_ID] := ResLine.Strings[IDX_ID] + ' <font size=1>IP: ' + ResLine.Strings[IDX_HOST] + ' </font>';

            // 必要項目だけ再結合
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
// FDat の生成
// *************************************************************************
procedure	TMachiBBSThreadItem.LoadDat;
begin

	if FDat = nil then begin
		if IsLogFile then begin
			// dat の読み込み
			FDat := TStringList.Create;
			FDat.LoadFromFile( FilePath );
		end;
	end;

end;

// *************************************************************************
// FDat の開放
// *************************************************************************
procedure	TMachiBBSThreadItem.FreeDat;
begin

	if FDat <> nil then begin
		FDat.Free;
		FDat := nil;
	end;

end;

// *************************************************************************
// 安全な( '/' で終わる )読み込みの URL
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
        // 新形式 ?
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
// TThreadItem が生成された場合の処置(TMachiBBSThreadItem を生成する)
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
// TThreadItem が破棄された場合の処置(TMachiBBSThreadItem を破棄する)
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
// コンストラクタ
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
// デストラクタ
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

	// 一時ファイルの場合は削除する
	if FIsTemporary then
		DeleteFile( FilePath );

	inherited;

end;

// *************************************************************************
// 指定したスレ一覧のダウンロードを要求された
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
	// 独自にダウンロードやフィルタリングを行わない場合は
	// InternalDownload に任せることが出来る
	modified			:= LastModified;
    dlURL       := SubjectURL2;
//	responseCode	:= InternalDownload( PChar( uri.URI ), modified, downResult );
	responseCode	:= InternalDownload( PChar( dlURL ), modified, downResult );
	try
		if responseCode = 200 then begin
			try
				// パスを算出
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				if MyLogFolder = '' then begin
					// どこに保存していいのか分からないので一時ファイルに保存
					FilePath 			:= TemporaryFile;
					FIsTemporary	:= True;
				end else begin
					FilePath			:= MyLogFolder + uriList[ 1 ] + '\' + uri.Document;
					FIsTemporary	:= False
				end;

				// 保存用のディレクトリを掘る
				ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

				FDat.Text := string( downResult );
                // 形式変換(Ver.2->Ver.1)
                ChangeSubjectFormat(FDat);
				// 保存
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
// スレ立てを指示された
// *************************************************************************
function	TMachiBBSBoardItem.CreateThread(
	inSubject			: string;	// スレタイ
	inName				: string;	// 名前(ハンドル)
	inMail				: string;	// メールアドレス
	inMessage			: string	// 本文
) : TDownloadState;				// 書き込みが成功したかどうか
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
			'&submit='	+ HttpEncode( '新規書き込み' );

		// 独自に通信しない場合は InternalPost に任せることが出来る
		InternalPost( PChar( postURL ), PChar( postData ),PChar(URL), postResult );
		DisposeResultString( postResult );

		Result := dsComplete
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// スレ一覧の URL からスレッドの URL を導き出す
// *************************************************************************
function TMachiBBSBoardItem.ToThreadURL(
	inFileName	: string	// スレッドファイル名
) : string;							// スレッドの URL
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
// この板にいくつのスレがあるか要求された
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
				// パスを算出
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				// http://hokkaido.machi.to/hokkaidou/subject.txt
				FilePath	:= MyLogFolder + uriList[ 1 ] + '\' + uri.Document;
				if FileExists( FilePath ) then
					// 読み込み
					FDat.LoadFromFile( FilePath );
			finally
				uri.Free;
				uriList.Free;
			end;
		end;

		// 独自にフィルタリングを行わない場合は EnumThread に任せることが出来る
		inherited EnumThread( inCallBack, CustomStringReplace( FDat.Text, ',', '<>' ) );
	except
	end;

end;

// *************************************************************************
// スレ一覧の URL を求める
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
			// ここには来ないと思うけど
			Result := URL;
		end;
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// スレ一覧の URL を求める(Ver2)
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
// TBoardItem が生成された場合の処置(TMachiBBSBoardItem を生成する)
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
// TBoardItem が破棄された場合の処置(TMachiBBSBoardItem を破棄する)
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
// エントリポイント
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

			// ===== インスタンスの取り扱いを TThreadItem から TMachiBBSThreadItem に変更する
			ThreadItemOnCreate	:= ThreadItemOnCreateOfTMachiBBSThreadItem;
			ThreadItemOnDispose	:= ThreadItemOnDisposeOfTMachiBBSThreadItem;
			// ===== インスタンスの取り扱いを TBoardItem から TMachiBBSBoardItem に変更する
			BoardItemOnCreate		:= BoardItemOnCreateOfTMachiBBSBoardItem;
			BoardItemOnDispose	:= BoardItemOnDisposeOfTMachiBBSBoardItem;

    	// 板リスト読み込み
      path := PreferencesFolder + '\Board\まちBBS.txt';
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
