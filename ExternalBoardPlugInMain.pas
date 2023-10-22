unit ExternalBoardPlugInMain;

interface

uses
	Windows, Classes, SysUtils, Menus,
	IdHTTP, IdComponent, IdGlobal, IdException,
  IdStack, IdExceptionCore, IndyModule,   // for Indy10
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,  // for https
	AbonUnit, IdAntiFreezeBase, Forms;

type

	// ダウンロードが成功したかどうか
	TDownloadState = (dsWait, dsWork, dsComplete, dsDiffComplete, dsNotModify, dsAbort, dsError);

	// 指定した URL をこのプラグインで受け付けるかどうか
	TAcceptType = (atNoAccept, atBBS, atBoard, atThread);

	// メニューハンドラ
	TMenuHandler	= procedure(
		inHandle : HMENU					// メニューハンドル
	); stdcall;

	// *************************************************************************
	// プラグインが(正しく)ロードされた
	// *************************************************************************
	TOnLoad = procedure (
		inInstance : DWORD				// プラグインのインスタンス
	); stdcall;

	// *************************************************************************
	// プラグインのバージョン
	// *************************************************************************
	TOnVersionInfo = procedure(
		var outAgent		: PChar;	// バージョンを一切含まない純粋な名称
		var outMajor		: DWORD;	// メジャーバージョン
		var outMinor		: DWORD;	// マイナーバージョン
		var outRelease	: PChar;	// リリース段階名
		var outRevision	: DWORD		// リビジョンナンバー
	); stdcall;

	// *************************************************************************
	// 指定した URL をこのプラグインで受け付けるかどうか
	// *************************************************************************
	TOnAcceptURL = function(
		inURL : PChar						// 判断を仰いでいる URL
	): TAcceptType; stdcall;	// URL の種類

	// *************************************************************************
	// 指定したURLを現在のURLに変換する
	// *************************************************************************
	TOnExtractBoardURL = procedure(
		inURL : PChar;						// 変換するURL;
        var outURL: PChar						// 変換されたURL
	); stdcall;	// 変換されたURL

	// *************************************************************************
	// メニューハンドラ
	// *************************************************************************
	TOnPlugInMenu = procedure(
		inInstance : DWORD		// メニューハンドル
	); stdcall;

	// *************************************************************************
	// スレ一覧の URL からスレッドの URL を導き出す
	// *************************************************************************
	TOnListURL2ThreadURL = function(
		inListURL		: PChar;	// スレ一覧を示した URL
		inFileName	: PChar		// スレッドファイル名
	) : PChar; stdcall;			// スレッドの URL


function CreateResultString(
	resultStr : string
) : PChar; stdcall;

procedure DisposeResultString(
	resultStr : PChar
); stdcall;

var
	socket : TIdHTTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;  // for https

implementation

uses ExternalBoardManager, ExternalThreadItem, GikoSystem, BoardGroup, Giko,
    ReplaceDataModule, AbonInfo;

// *************************************************************************
// 戻り値が PChar である API のメモリを確保する
// *************************************************************************
function CreateResultString(
	resultStr : string
) : PChar; stdcall;
var
	tmp : PChar;
begin

	tmp := PChar( resultStr );
	GetMem( Result, Length( tmp ) + 1 );
	Move( tmp^, Result^, Length( tmp ) + 1 );

end;

// *************************************************************************
// 戻り値が PChar である API のメモリを開放する
// *************************************************************************
procedure DisposeResultString(
	resultStr : PChar
); stdcall;
begin

	FreeMem( resultStr );

end;

// *************************************************************************
// プログラム本体のバージョンを取得する
// *************************************************************************
procedure VersionInfo(
	var outAgent		: PChar;	// バージョンを一切含まない純粋な名称
	var outMajor		: DWORD;	// メジャーバージョン
	var outMinor		: DWORD;	// マイナーバージョン
	var outRelease	: PChar;	// リリース段階名
	var outRevision	: DWORD		// リビジョンナンバー
); stdcall;
begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.VersionInfo');
	{$ENDIF}
	outAgent		:= CreateResultString( PChar( APP_NAME ) );
	outMajor		:= 1;
	outMinor		:= 0;
	outRelease	:= CreateResultString( PChar( BETA_VERSION_NAME_E ) );
	outRevision	:= BETA_VERSION;

end;

// *************************************************************************
// メッセージを表示する
// *************************************************************************
procedure InternalPrint(
	inMessage	: PChar	// メッセージ
); stdcall;
begin

	GikoForm.AddMessageList( inMessage, nil, gmiWhat );

end;

// *************************************************************************
// デバッグメッセージを表示する
// *************************************************************************
procedure InternalDebugPrint(
	inMessage	: PChar	// メッセージ
); stdcall;
begin

	{$IFDEF DEBUG}
	Writeln( inMessage );
	{$ENDIF}

end;

// *************************************************************************
// ソケットを初期化する(雑用関数)
// *************************************************************************
procedure	InitializeSocket(
	inSocket : TIdHTTP;
  inSSL : TIdSSLIOHandlerSocketOpenSSL;    // for https
  writeMethod: Boolean = False
);
begin

	if inSocket <> nil then begin
    // for https
    if inSSL <> nil then begin
      inSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
      inSSL.SSLOptions.Method := sslvTLSv1_2;
      inSocket.IOHandler := inSSL;
    end;
    // for https

		// イベントの設定
		if Assigned( OnWork ) then
			inSocket.OnWork				:= OnWork;
		if Assigned( OnWorkBegin ) then
			inSocket.OnWorkBegin	:= OnWorkBegin;
		if Assigned( OnWorkEnd ) then
			inSocket.OnWorkEnd		:= OnWorkEnd;

    TIndyMdl.InitHTTP(inSocket, writeMethod);

	end;

end;

// *************************************************************************
// 指定した URL をダウンロードして返す
// *************************************************************************
function InternalDownload(
	inURL							: PChar;	// ダウンロードする URL
	var ioModified		: Double;	// 最後に取得した日時
	var outResultData	: PChar;	// ダウンロードされた文字列
	inRangeStart			: DWORD;	// 開始位置
	inRangeEnd				: DWORD		// 終了位置
) : Longint; stdcall;					// レスポンスコード
var
//	httpSocket				: TIdHTTP;
	resStream					: TMemoryStream;
	content						: string;
//const
//	LIVEDOOR_URL = 'http://jbbs.shitaraba.net/';
begin


	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.InternalDownload');
	{$ENDIF}
//	Result := -1;

	socket := TIdHTTP.Create( nil );
  ssl := TIdSSLIOHandlerSocketOpenSSL.Create( nil );  // for https
	try
		InitializeSocket( socket, ssl );                  // for https
		//socket.Request.ContentRangeStart	:= inRangeStart;
		//socket.Request.ContentRangeEnd		:= inRangeEnd;
    socket.Request.Ranges.Text := IndyMdl.MakeRangeHeader(inRangeStart, inRangeEnd);  // for Indy10
		if (ioModified <> 0) and (ioModified <> ZERO_DATE) then
			socket.Request.LastModified := ioModified - OffsetFromUTC;
		if inRangeStart = 0 then
			socket.Request.AcceptEncoding := 'gzip'
		else
			socket.Request.AcceptEncoding := '';
		socket.Request.Accept := 'text/html';

		resStream := TMemoryStream.Create;
		try
			try
				resStream.Clear;
				{$IFDEF DEBUG}
				Writeln('URL: ' + inURL);
				{$ENDIF}
                //AntiFreezeをDL時のみ有効にすることで、ココでのチェック不要
				socket.Get( inURL, resStream );
				{$IFDEF DEBUG}
				Writeln('取得で例外なし');
				{$ENDIF}
				content			:= GikoSys.GzipDecompress( resStream, socket.Response.ContentEncoding );
                // 置換する
                if GikoSys.Setting.ReplaceDat then begin
                    content := ReplaceDM.Replace(content);
                end;

				ioModified	:= socket.Response.LastModified;

				Result := socket.ResponseCode;
				if (Length( content ) = 0) and (Result = 206) then
					Result := 304;
				//したらばJBBSはヘッダにエラー情報が載るらしいので、ここでチェック
				//if ( AnsiPos(LIVEDOOR_URL, inURL) > 0 ) and (Result = 200) then begin
				if GikoSys.IsShitarabaURL(inURL) and (Result = 200) then begin
					if( AnsiPos('STORAGE IN', socket.Response.RawHeaders.Text) > 0 ) then begin
						Result := 302;
					end;
				end;
				outResultData := CreateResultString( content );
			except
				on E: EIdSocketError do begin
					ioModified		:= ZERO_DATE;
					outResultData	:= nil;
					Result				:= socket.ResponseCode;
				end;
				on E: EIdConnectException do begin
					ioModified		:= ZERO_DATE;
					outResultData	:= nil;
					Result				:= socket.ResponseCode;
					//Item.ErrText	:= E.Message;
				end;
				//中断されたときココに入る
				on E: EIdClosedSocket do begin
					ioModified		:= ZERO_DATE;
					outResultData	:= nil;
					Result				:= 408; //既に一部DL成功しているとレスポンスコードが200のままに
												//なってしまうので、明示的にエラーコードを返す
				end;
				on E: Exception do begin
					{$IFDEF DEBUG}
					Writeln('取得で例外あり');
					Writeln('E.Message: ' + E.Message);
					{$ENDIF}
					ioModified		:= ZERO_DATE;
					outResultData	:= nil;
					Result				:= socket.ResponseCode;
					//Item.ErrText	:= E.Message;
				end;
			end;
		finally
			resStream.Free;
		end;

	finally
		socket.Free;
		socket := nil;
    ssl.Free;       // for https
    ssl := nil;     // for https
	end;

end;

// *************************************************************************
// 指定した URL へデータを送信する
// *************************************************************************
function	InternalPost(
	inURL							: PChar;			// 送信する URL
	inSource					: PChar;			// 送信する内容
	inReferer			: PChar;				// Referer
	var outResultData	: PChar				// 返ってきた文字列
) : Longint; stdcall;							// レスポンスコード
var
	httpSocket				: TIdHTTP;
  ssl               : TIdSSLIOHandlerSocketOpenSSL;   // for https
	content						: string;
	resStream					: TStringStream;
	sourceStream			: TStringStream;

begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.InternalPost');
	{$ENDIF}
	Result := -1;

	httpSocket := TIdHTTP.Create( nil );
  ssl := TIdSSLIOHandlerSocketOpenSSL.Create( nil );    // for https
	try
		InitializeSocket( httpSocket, ssl, True );          // for https
		httpSocket.Request.CustomHeaders.Add('Pragma: no-cache');
		httpSocket.Request.AcceptLanguage	:= 'ja';
		httpSocket.Request.Accept					:= 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*';
		httpSocket.Request.ContentType		:= 'application/x-www-form-urlencoded';
		httpSocket.Request.Referer			:= string(inReferer);
		resStream			:= TStringStream.Create( content );
		sourceStream	:= TStringStream.Create( string( inSource ) );
		try
			try
				{$IFDEF DEBUG}
				Writeln('URL: ' + inURL);
				Writeln('Source: ' + inSource);
				{$ENDIF}
				httpSocket.Post( string( inURL ), sourceStream, resStream );
				{$IFDEF DEBUG}
				Writeln('取得で例外なし');
				{$ENDIF}

				Result := httpSocket.ResponseCode;

				outResultData := CreateResultString( resStream.DataString );
			except
				on E: EIdSocketError do begin
					outResultData	:= nil;
				end;
				on E: EIdConnectException do begin
					outResultData	:= nil;
				end;
				on E: Exception do begin
					{$IFDEF DEBUG}
					Writeln('取得で例外あり');
					Writeln('E.Message: ' + E.Message);
					{$ENDIF}
					outResultData := CreateResultString( resStream.DataString );
					Result				:= httpSocket.ResponseCode;
				end;
			end;
		finally
			resStream.Free;
			sourceStream.Free;
		end;
	finally
		httpSocket.Free;
    ssl.Free;         // for https
	end;

end;

// *************************************************************************
// ２ちゃんねるの dat 形式をローカルあぼ～んに通す
// *************************************************************************

function InternalAbon(
	inDatText : PChar;			// 名前<>メール<>日付ID<>本文<>[改行] で構成されたテキスト
	inDatPath	: PChar				// dat ファイルのフルパス

) : PChar; stdcall;				// あぼ～ん済みの dat 形式テキスト
var
	datList : TStringList;
		FileName : String;
    ThreadInfo: TAbonThread;
begin

    ThreadInfo := TAbonThread.Create;
	datList := TStringList.Create;
    try
        datList.Text := string( inDatText );
        FileName := string( inDatPath );
        GikoSys.FAbon.IndividualAbon( datList, ChangeFileExt(FileName,'.NG'));
        GikoSys.FAbon.Execute( datList, ThreadInfo );
        GikoSys.FSelectResFilter.Execute( datList, ThreadInfo );
    finally
        ThreadInfo.Free;
    end;

    Result := CreateResultString( datList.Text );
    datList.Free;
end;
// *************************************************************************
// ２ちゃんねるの dat 形式をローカルあぼ～んに通す
// ただし、１レスずつ
// *************************************************************************

function InternalAbonForOne(
	inDatText : PChar;		// 名前<>メール<>日付ID<>本文<>[改行] で構成されたテキスト
	inDatPath	: PChar;		// dat ファイルのフルパス
	inNo : Integer				// 要求されたレス番号
) : PChar; stdcall;			// あぼ～ん済みの dat 形式テキスト
var
	datString : String;
		FileName : String;
    ThreadInfo: TAbonThread;
begin

    ThreadInfo := TAbonThread.Create;
    try
        datString := string( inDatText );
        FileName := string( inDatPath );
        GikoSys.FAbon.IndividualAbon( datString, ChangeFileExt(FileName,'.NG'), inNo);
        GikoSys.FAbon.Execute( datString , inNo, ThreadInfo );
        GikoSys.FSelectResFilter.Execute( datString , inNo, ThreadInfo );
    finally
        ThreadInfo.Free;
    end;

	Result := CreateResultString( datString );
end;

// *************************************************************************
// ２ちゃんねるの dat 形式 1 行を HTML に変換する
// *************************************************************************
function InternalDat2HTML(
	inDatRes		: PChar; 		// 名前<>メール<>日付ID<>本文<> で構成されたテキスト
	inResNo			: DWORD; 		// レス番号
	inIsNew			: Boolean		// 新着レスなら True
) : PChar; stdcall;				// 整形された HTML
var
	board				: TBoard;
	threadItem	: TThreadItem;
begin

	// ダミーのクラス
	board				:= TBoard.Create( nil, 'about://dummy/' );
	threadItem	:= TThreadItem.Create( nil, board, 'about://dummy/test/read.cgi/dummy/' );
	try
		try
			board.Add( threadItem );

			Result := ThreadItemDat2HTML( DWORD( threadItem ), inDatRes, inResNo, inIsNew );
		except
			Result := nil;
		end;
	finally
		board.Free;
	end;

end;

// *************************************************************************
// プラグインメニューに項目を追加
// *************************************************************************
function AddPlugInMenu(
	inInstance	: DWORD;		// プラグインのインスタンス
	inCaption	: PChar 			// メニューに表示する文字列
) : HMENU; stdcall;				// メニューハンドル、追加に失敗した場合は NULL
var
	newItem		: TMenuItem;
begin

	try
		newItem					:= TMenuItem.Create( nil );
		newItem.Caption	:= inCaption;
		newItem.Tag			:= inInstance;
		newItem.OnClick	:= GikoForm.OnPlugInMenuItem;
		GikoForm.PlugInMenu.Add( newItem );

		Result := newItem.Handle;
	except
   		Result := 0;
	end;

end;

// *************************************************************************
// プラグインメニューから項目を削除
// *************************************************************************
procedure RemovePlugInMenu(
	inHandle	: HMENU 			// メニューハンドル
); stdcall;
var
	i					: Integer;
begin
    // DLLデタッチ時はフォームオブジェクトは存在しない上にフォーム側で後始末は済んでいる
    if (g_AppTerminated = True) then
        Exit;

	for i := GikoForm.PlugInMenu.Count - 1 downto 0 do begin
		if GikoForm.PlugInMenu.Items[ i ].Handle = inHandle then begin
//            GikoForm.PlugInMenu.items[i].Free;
            GikoForm.PlugInMenu.items[i].Visible := False;  // Giko.pas の TGikoForm.FormDestroy() で開放するためここでは非表示にするのみ
			//GikoForm.PlugInMenu.Delete( i );
			Break;
		end;
	end;

end;

exports
	CreateResultString,
	DisposeResultString,
	VersionInfo,
	InternalPrint,
	InternalDebugPrint,
	InternalDownload,
	InternalPost,
	InternalAbon,
	InternalAbonForOne,
	InternalDat2HTML,
	AddPlugInMenu,
	RemovePlugInMenu;

end.
