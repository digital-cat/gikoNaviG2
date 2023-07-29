library ExternalBoardPlugIn;

{
	ExternalBoardPlugIn
	外部板の処理ユニット
}

uses
	Windows,
	SysUtils,
	Classes,
	Math,
	IdURI,
	PlugInMain in 'PlugInMain.pas',
	ThreadItem in 'ThreadItem.pas',
	BoardItem in 'BoardItem.pas',
	FilePath in 'FilePath.pas';

{$R *.res}

type
	// =========================================================================
	// T2chThreadItem
	// =========================================================================
	T2chThreadItem = class(TThreadItem)
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
	// T2chBoardItem
	// =========================================================================
	T2chBoardItem = class(TBoardItem)
	private
		FIsTemporary	: Boolean;
		FDat					: TStringList;

	public
		constructor	Create( inInstance : DWORD );
		destructor	Destroy; override;

	private
		function	Download : TDownloadState;
		function	ToThreadURL( inFileName : string ) : string;
		procedure	EnumThread( inCallBack : TBoardItemEnumThreadCallBack );

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
	LOG_DIR						= '2ch\';

	PLUGIN_NAME				= '2chPlugIn';
	MAJOR_VERSION			= 1;
	MINOR_VERSION			= 0;
	RELEASE_VERSION		= 'beta';
	REVISION_VERSION	= 3;

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
	folder : string;
begin

	folder := LogFolder;
	if Length( folder ) = 0 then
		Result := ''
	else
		Result := folder + LOG_DIR;

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

	outAgent		:= CreateResultString( PChar( PLUGIN_NAME ) );
	outMajor		:= MAJOR_VERSION;
	outMinor		:= MINOR_VERSION;
	outRelease	:= CreateResultString( PChar( RELEASE_VERSION ) );
	outRevision	:= REVISION_VERSION;

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
	BBS_HOST		= '2ch.net';
  THREAD_MARK	= '/test/read.cgi/';
begin

	try
		// 例としてホスト名が 2ch.net で終わる場合は受け付けるようにしている
		uri			:= TIdURI.Create( inURL );
		uriList	:= TStringList.Create;
		try
	 		ExtractHttpFields( ['/'], [], uri.Path, uriList );
			foundPos := AnsiPos( BBS_HOST, uri.Host );
			if (foundPos > 0) and (Length( uri.Host ) - foundPos + 1 = Length( BBS_HOST )) then begin
				foundPos := AnsiPos( THREAD_MARK, uri.Path );
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
// T2chThreadItem
// =========================================================================

// *************************************************************************
// コンストラクタ
// *************************************************************************
constructor T2chThreadItem.Create(
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

	FilePath			:= '';
	FIsTemporary	:= False;
	FDat					:= nil;
	URL						:= ReadURL + 'l50';

	uri			:= TIdURI.Create( ReadURL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		FileName	:= uriList[ 4 ] + '.dat';
		FilePath	:= MyLogFolder + uriList[ 3 ] + '\' + uriList[ 4 ] + '.dat';
		IsLogFile	:= FileExists( FilePath );
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// デストラクタ
// *************************************************************************
destructor T2chThreadItem.Destroy;
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
function T2chThreadItem.Download : TDownloadState;
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
const
	LF						= #10;
begin

	Result := dsError;

	uri			:= TIdURI.Create( ReadURL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		FileName := uriList[ 4 ] + '.dat';
		// http://pc2.2ch.net/test/read.cgi/software/1065250336/l50
		// protocol://host/1/2/3/4/uriList.Count - 1
		if MyLogFolder = '' then begin
			// どこに保存していいのか分からないので一時ファイルに保存
			FilePath 			:= TemporaryFile;
			FIsTemporary	:= True;
		end else begin
			FilePath			:= MyLogFolder + uriList[ 3 ] + '\' + uriList[ 4 ] + '.dat';
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
			// http://pc2.2ch.net/software/1000000000.dat
			datURL		:=
				uri.Protocol + '://' + uri.Host + '/' +
				uriList[ 3 ] + '/dat/' + uriList[ 4 ] + '.dat';
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
							downResult.Text			:= string( tmp ); // カウントのためだけ
							logStream.Position	:= logStream.Size;
							logStream.Write( (tmp)^, tmpLen );

							NewReceive		:= Count + 1;
							Count					:= Count + downResult.Count;
							NewResCount		:= downResult.Count;
							Size					:= tmpLen;
						end else if LF = tmp^ then begin
							// 新規、または追記
							Result := dsDiffComplete;
							downResult.Text			:= string( tmp + 1 ); // カウントのためだけ
							logStream.Position	:= logStream.Size;
							logStream.Write( (tmp + 1)^, tmpLen - 1 );

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
							logStream.Position := 0;
							logStream.Write( tmp2, StrLen( tmp2 ) );
							logStream.Write( tmp, tmpLen );

							downResult.Text	:= string( tmp2 ) + string( tmp ); // カウントのためだけ

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
function	T2chThreadItem.Write(
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

	MessageBox( 0, PChar( 'このプラグインはカキコに対応していません。' ), PChar( '' ), MB_OK );
	Result := dsError;
	{
	uri			:= TIdURI.Create( URL );
	uriList	:= TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );

		// http://jbbs.shitaraba.com/bbs/read.cgi/game/1578/1067968274/l100
		postData	:=
			'NAME='			+ HttpEncode( SJIStoEUC( inName ) ) +
			'&MAIL='		+ HttpEncode( SJIStoEUC( inMail ) ) +
			'&MESSAGE='	+ HttpEncode( SJIStoEUC( inMessage ) ) +
			'&BBS='			+ uriList[ 4 ] +
			'&KEY='			+ uriList[ 5 ] +
			'&DIR='			+ uriList[ 3 ] +
			'&TIME='		+ IntToStr( DateTimeToUnix( Now ) ) +
			'&submit='	+ HttpEncode( SJIStoEUC( '書き込む' ) );

		// 独自に通信しない場合は InternalPost に任せることが出来る
		InternalPost( PChar( WriteURL ), PChar( postData ), postResult );
		DisposeResultString( postResult );

		Result := dsComplete
	finally
		uri.Free;
		uriList.Free;
	end;
	}

end;

// *************************************************************************
// レス番号 inNo に対する html を要求された
// *************************************************************************
function T2chThreadItem.GetRes(
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
    tmp := InternalAbonForOne( PChar( res ), PChar( FilePath ), inNo);
	try
		Result	:= Dat2HTML( string( tmp ), inNo );
	finally
		DisposeResultString( tmp );
	end;

end;

// *************************************************************************
// レス番号 inNo に対する Dat を要求された
// *************************************************************************
function T2chThreadItem.GetDat(
	inNo		: Integer		// 要求されたレス番号
) : string;						// ２ちゃんねるのDat形式
begin
	LoadDat;
	if FDat = nil then begin
		// ログに存在しないのでこのまま終了
		Result := '';
		Exit;
	end;
    try
		Result := FDat[ inNo - 1 ];
	except
		Result := '';
	end;

end;

// *************************************************************************
// スレッドのヘッダ html を要求された
// *************************************************************************
function T2chThreadItem.GetHeader(
	inOptionalHeader : string
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
function T2chThreadItem.GetFooter(
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
function	T2chThreadItem.GetBoardURL : string;
var
	uri						: TIdURI;
	uriList				: TStringList;
begin

	uri			:= TIdURI.Create( ReadURL );
	uriList := TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		FileName := uriList[ 4 ] + '.dat';
		// http://book.2ch.net/test/read.cgi/bizplus/1067681920/
		// http://book.2ch.net/bizplus/subject.txt
		Result		:= CreateResultString(
			uri.Protocol + '://' + uri.Host + '/' + uriList[ 3 ] + '/' );
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// FDat の生成
// *************************************************************************
procedure	T2chThreadItem.LoadDat;
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
procedure	T2chThreadItem.FreeDat;
begin

	if FDat <> nil then begin
		FDat.Free;
		FDat := nil;
	end;

end;

// *************************************************************************
// 安全な( '/' で終わる )読み込みの URL
// *************************************************************************
function	T2chThreadItem.ReadURL : string;
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
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		// http://book.2ch.net/test/read.cgi/bizplus/1067681920/
		Result :=
		 	uri.Protocol + '://' + uri.Host + '/test/read.cgi/' +
			uriList[ 3 ] + '/' + uriList[ 4 ] + '/';
	finally
		uri.Free;
		uriList.Free;
	end;

end;

// *************************************************************************
// TThreadItem が生成された場合の処置(T2chThreadItem を生成する)
// *************************************************************************
procedure ThreadItemOnCreateOfT2chThreadItem(
	inInstance : DWORD
);
var
	threadItem : T2chThreadItem;
begin

	threadItem := T2chThreadItem.Create( inInstance );
	ThreadItemSetLong( inInstance, tipContext, DWORD( threadItem ) );

end;

// *************************************************************************
// TThreadItem が破棄された場合の処置(T2chThreadItem を破棄する)
// *************************************************************************
procedure ThreadItemOnDisposeOfT2chThreadItem(
	inInstance : DWORD
);
var
	threadItem : T2chThreadItem;
begin

	threadItem := T2chThreadItem( ThreadItemGetLong( inInstance, tipContext ) );
	threadItem.Free;

end;

// =========================================================================
// T2chBoardItem
// =========================================================================

// *************************************************************************
// コンストラクタ
// *************************************************************************
constructor T2chBoardItem.Create(
	inInstance	: DWORD
);
var
	uri					: TIdURI;
	uriList			: TStringList;
begin

	inherited;

	OnDownload						:= Download;
	OnEnumThread					:= EnumThread;
	OnFileName2ThreadURL	:= ToThreadURL;

	FilePath			:= '';
	FIsTemporary	:= False;
	FDat					:= nil;

	if Copy( URL, Length( URL ), 1 ) = '/' then
		uri := TIdURI.Create( URL )
	else
		uri := TIdURI.Create( URL + '/' );
	uriList := TStringList.Create;
	try
		ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
		// http://2ch.net/hoge/subject.txt
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
destructor T2chBoardItem.Destroy;
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
function T2chBoardItem.Download : TDownloadState;
var
	modified			: Double;
	downResult		: PChar;
	responseCode	: Longint;
	uri						: TIdURI;
	uriList				: TStringList;
const
	SUBJECT_NAME	= 'subject.txt';
begin

	Result := dsError;

	if Copy( URL, Length( URL ), 1 ) = '/' then
		uri := TIdURI.Create( URL + SUBJECT_NAME )
	else
		uri := TIdURI.Create( URL );
	uriList := TStringList.Create;
	if FDat <> nil then begin
		try
			FDat.Free;
			FDat := nil;
		except
		end;
	end;
	FDat := TStringList.Create;
	// 独自にダウンロードやフィルタリングを行わない場合は
	// InternalDownload に任せることが出来る
	modified := LastModified;
	responseCode := InternalDownload( PChar( uri.URI ), modified, downResult );
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
// スレ一覧の URL からスレッドの URL を導き出す
// *************************************************************************
function T2chBoardItem.ToThreadURL(
	inFileName	: string	// スレッドファイル名
) : string;							// スレッドの URL
var
	threadURL		: string;
	uri					: TIdURI;
	uriList			: TStringList;
	found				: Integer;
begin

	found := Pos( '.', inFileName );
	if found > 0 then
		inFileName := Copy( inFileName, 1, found - 1 );
	if Copy( URL, Length( URL ), 1 ) = '/' then
		uri := TIdURI.Create( URL )
	else
		uri := TIdURI.Create( URL + '/' );
	uriList := TStringList.Create;

	try
		try
			// http://book.2ch.net/bizplus/subject.txt
			// http://book.2ch.net/test/read.cgi/bizplus/1068905348/l50
			ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
			threadURL	:= uri.Protocol + '://' + uri.Host + '/test/read.cgi/' +
				uriList[ 1 ] + '/' + inFileName + '/l50';
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
procedure	T2chBoardItem.EnumThread(
	inCallBack	: TBoardItemEnumThreadCallBack
);
var
	uri		 			: TIdURI;
	uriList			: TStringList;
const
	SUBJECT_NAME	= 'subject.txt';
begin

	try
		if FDat = nil then begin
			FDat := TStringList.Create;

			if Copy( URL, Length( URL ), 1 ) = '/' then
				uri := TIdURI.Create( URL + SUBJECT_NAME )
			else
				uri := TIdURI.Create( URL );
			uriList := TStringList.Create;
			try
				// パスを算出
				ExtractHttpFields( ['/', '?'], [], uri.Path, uriList );
				// http://book.2ch.net/bizplus/subject.txt
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
		inherited EnumThread( inCallBack, FDat.Text );
	except
	end;

end;

// *************************************************************************
// TBoardItem が生成された場合の処置(T2chBoardItem を生成する)
// *************************************************************************
procedure BoardItemOnCreateOfT2chBoardItem(
	inInstance : DWORD
);
var
	boardItem : T2chBoardItem;
begin

	boardItem := T2chBoardItem.Create( inInstance );
	BoardItemSetLong( inInstance, bipContext, DWORD( boardItem ) );

end;

// *************************************************************************
// TBoardItem が破棄された場合の処置(T2chBoardItem を破棄する)
// *************************************************************************
procedure BoardItemOnDisposeOfT2chBoardItem(
	inInstance : DWORD
);
var
	boardItem : T2chBoardItem;
begin

	boardItem := T2chBoardItem( BoardItemGetLong( inInstance, bipContext ) );
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

			// ===== インスタンスの取り扱いを TThreadItem から T2chThreadItem に変更する
			ThreadItemOnCreate	:= ThreadItemOnCreateOfT2chThreadItem;
			ThreadItemOnDispose	:= ThreadItemOnDisposeOfT2chThreadItem;
			// ===== インスタンスの取り扱いを TBoardItem から T2chBoardItem に変更する
			BoardItemOnCreate		:= BoardItemOnCreateOfT2chBoardItem;
			BoardItemOnDispose	:= BoardItemOnDisposeOfT2chBoardItem;
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

	DllProc := @DLLEntry;
	DLLEntry( DLL_PROCESS_ATTACH );

end.
