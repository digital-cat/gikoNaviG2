library ShitarabaPlugIn;

{
	ShitarabaPlugIn
	したらば処理ユニット
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
// したらば用ログフォルダ取得
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
	BBS_HOST		= 'www.shitaraba.com';
	THREAD_MARK	= '/cgi-bin/read.cgi?';
begin

	try
		// ホスト名が www.shitaraba.com で終わる場合は受け付けるようにしている
		uri			:= TIdURI.Create( inURL );
		uriList	:= TStringList.Create;
		try
	 		ExtractHttpFields( ['/'], [], uri.Path, uriList );
			foundPos := AnsiPos( BBS_HOST, uri.Host );
			if (foundPos > 0) and (Length( uri.Host ) - foundPos + 1 = Length( BBS_HOST )) then begin
				foundPos := AnsiPos( THREAD_MARK, inURL );
				if foundPos > 0 then
					Result := atThread
				else if (uriList.Count > 1) and (uri.Path <> '/') then	// 最後が '/' で閉められてるなら 3
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
// コンストラクタ
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
// デストラクタ
// *************************************************************************
destructor TShitarabaThreadItem.Destroy;
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
			// どこに保存していいのか分からないので一時ファイルに保存
			FilePath 			:= TemporaryFile;
			FIsTemporary	:= True;
		end else begin
			FilePath	:= MyLogFolder + uriList.Values[ 'bbs' ] + '\' + uriList.Values[ 'key' ] + '.dat';
			FIsTemporary	:= False;
		end;

		// 保存用のディレクトリを掘る
		ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

		if FileExists( FilePath ) then
			logStream := TFileStream.Create( FilePath, fmOpenReadWrite or fmShareDenyWrite )
		else
			logStream := TFileStream.Create( FilePath, fmCreate or fmShareDenyWrite );
		try
			// 独自にダウンロードやフィルタリングを行わない場合は
			// InternalDownload に任せることが出来る
			modified	:= LastModified;
			// http://www.shitaraba.com/cgi-bin/read.cgi?key=1032678843_1&bbs=jbbs
			// http://www.shitaraba.com/bbs/jbbs/dat/1032678843_1.dat
			datURL		:=
				uri.Protocol + '://' + uri.Host + '/bbs/' +
				uriList.Values[ 'bbs' ] + '/dat/' + uriList.Values[ 'key' ] + '.dat';
			// あぼーんチェックのため 1 バイト前から取得する
			// ※ログと鯖の dat は改行コードが違うためファイルサイズが変わっていることに注意
			responseCode := InternalDownload( PChar( datURL ), modified, tmp, Max( 0, Size - 1 ) );

			try
				if (responseCode = 200) or (responseCode = 206) then begin
					downResult := TStringList.Create;
					try
						tmpLen					:= StrLen( tmp );

						if Count = 0 then begin
							Result := dsComplete;
                            tmpText := CustomStringReplace( string( tmp ), '｡ｮ', ',');
							downResult.Text			:= EUCtoSJIS( string( tmpText ) );
							logStream.Position	:= logStream.Size;
							logStream.Write( PChar( downResult.Text )^, Length( downResult.Text ) );

							NewReceive		:= Count + 1;
							Count					:= Count + downResult.Count;
							NewResCount		:= downResult.Count;
							Size					:= tmpLen;
						end else if LF = tmp^ then begin
							// 新規、または追記
							Result := dsDiffComplete;
                            tmpText := CustomStringReplace( string( tmp + 1 ), '｡ｮ', ',');
							downResult.Text			:= EUCtoSJIS( string( tmpText ) );
							logStream.Position	:= logStream.Size;
							logStream.Write( PChar( downResult.Text )^, Length( downResult.Text ) );

							NewReceive		:= Count + 1;
							Count					:= Count + downResult.Count;
							NewResCount		:= downResult.Count;
							Size					:= Size + tmpLen - 1;
						end else begin
							// あぼーん
							Result := dsDiffComplete;
							// 再取得
							modified			:= LastModified;
							responseCode	:= InternalDownload(
								PChar( datURL ), modified, tmp2, 0, Size );
                            tmpText := CustomStringReplace( string( tmp2 ) + string( tmp ), '｡ｮ', ',');
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
// 書き込みを指示された
// *************************************************************************
function	TShitarabaThreadItem.Write(
	inName				: string;	// 名前(ハンドル)
	inMail				: string;	// メールアドレス
	inMessage			: string	// 本文
) : TDownloadState;				// 書き込みが成功したかどうか
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
			'&submit='	+ HttpEncode( SJIStoEUC( 'かきこむ' ) );

		// 独自に通信しない場合は InternalPost に任せることが出来る
		InternalPost( PChar( 'http://cgi.shitaraba.com/cgi-bin/bbs.cgi' ), PChar( postData ), PChar(URL), postResult );
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
function TShitarabaThreadItem.GetRes(
	inNo		: Integer		// 要求されたレス番号
) : string;						// 対応する HTML
var
	res		 	: string;
	tmp			: PChar;
begin

	// 独自にフィルタリングを行わない場合は
	// InternalAbon および Dat2HTML に任せることが出来る
	LoadDat;
	if FDat = nil then begin
		// ログに存在しないのでこのまま終了
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
// レス番号 inNo に対する Dat を要求された
// *************************************************************************
function TShitarabaThreadItem.GetDat(
	inNo		: Integer		// 要求されたレス番号
) : string;                     // ２ちゃんねるのDat形式
var
	tmp: PChar;
begin
	tmp := nil;
	LoadDat;
	if FDat = nil then begin
		// ログに存在しないのでこのまま終了
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
// スレッドのヘッダ html を要求された
// *************************************************************************
function TShitarabaThreadItem.GetHeader(
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
function TShitarabaThreadItem.GetFooter(
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
// FDat の生成
// *************************************************************************
procedure	TShitarabaThreadItem.LoadDat;
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
procedure	TShitarabaThreadItem.FreeDat;
begin

	if FDat <> nil then begin
		FDat.Free;
		FDat := nil;
	end;

end;

// *************************************************************************
// 安全な( '/' で終わる )読み込みの URL
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
// TThreadItem が生成された場合の処置(TShitarabaThreadItem を生成する)
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
// TThreadItem が破棄された場合の処置(TShitarabaThreadItem を破棄する)
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
// コンストラクタ
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
// デストラクタ
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

	// 一時ファイルの場合は削除する
	if FIsTemporary then
		DeleteFile( FilePath );

	inherited;

end;

// *************************************************************************
// 指定したスレ一覧のダウンロードを要求された
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
	// 独自にダウンロードやフィルタリングを行わない場合は
	// InternalDownload に任せることが出来る
	modified			:= LastModified;
	responseCode	:= InternalDownload( PChar( uri.URI ), modified, downResult );
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
					FilePath			:= MyLogFolder + uriList[ 2 ] + '\' + uri.Document;
					FIsTemporary	:= False
				end;

				// 保存用のディレクトリを掘る
				ForceDirectoriesEx( Copy( FilePath, 1, LastDelimiter( '\', FilePath ) ) );

				// EUC を Shift_JIS に
                tmpText := CustomStringReplace( string( downResult ), '｡ｮ', ',');
				FDat.Text := EUCtoSJIS( tmpText );
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

// *************************************************************************
// スレ立てを指示された
// *************************************************************************
function	TShitarabaBoardItem.CreateThread(
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
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

		postURL		:= 'http://cgi.shitaraba.com/cgi-bin/bbs.cgi';
		postData	:=
			'subject='	+ HttpEncode( SJIStoEUC( inSubject ) ) +
			'&FROM='		+ HttpEncode( SJIStoEUC( inName ) ) +
			'&mail='		+ HttpEncode( SJIStoEUC( inMail ) ) +
			'&MESSAGE='	+ HttpEncode( SJIStoEUC( inMessage ) ) +
			'&bbs='			+ uriList[ 2 ] +
			'&submit='	+ HttpEncode( SJIStoEUC( '新規スレッド作成' ) );

		// 独自に通信しない場合は InternalPost に任せることが出来る
		InternalPost( PChar( postURL ), PChar( postData ), PChar(URL), postResult );
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
function TShitarabaBoardItem.ToThreadURL(
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
// この板にいくつのスレがあるか要求された
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
				// パスを算出
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				FilePath	:= MyLogFolder + uriList[ 2 ] + '\' + uri.Document;
				if FileExists( FilePath ) then
					// 読み込み
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
// スレ一覧の URL を求める
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
			// ここには来ないと思うけど
			Result := URL;
		end;
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// TBoardItem が生成された場合の処置(TShitarabaBoardItem を生成する)
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
// TBoardItem が破棄された場合の処置(TShitarabaBoardItem を破棄する)
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
// エントリポイント
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

			// ===== インスタンスの取り扱いを TThreadItem から TShitarabaThreadItem に変更する
			ThreadItemOnCreate	:= ThreadItemOnCreateOfTShitarabaThreadItem;
			ThreadItemOnDispose	:= ThreadItemOnDisposeOfTShitarabaThreadItem;
			// ===== インスタンスの取り扱いを TBoardItem から TShitarabaBoardItem に変更する
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
