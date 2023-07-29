unit ExternalBoardItem;

interface

uses
	Windows, Classes, SysUtils,
	IdComponent,
	ExternalBoardPlugInMain;

type
	// TBoardItem のプロパティ設定／取得 ID
	TBoardItemProperty = (
		bipContext,							// : DWORD				// 自由に設定していい値
		bipItems,								// : TThreadItem	// 板に繋がれているスレッド
		bipNo,									// : Integer			// 番号
		bipTitle,								// : string				// 板タイトル
		bipRoundDate,						// : TDateTime		// 板を取得した日時（巡回日時）
		bipLastModified,				// : TDateTime		// 板が更新されている日時（サーバ側日時）
		bipLastGetTime,					// : TDateTime		// スレッドまたはスレッド一覧を最後に更新した日時（サーバ側日時・書き込み時に使用する）
		bipRound,								// : Boolean			// 巡回予約
		bipRoundName,						// : string				// 巡回名
		bipIsLogFile,						// : Boolean			// ログ存在フラグ
		bipUnRead,							// : Integer			// スレッド未読数
		bipURL,									// : string				// 板をブラウザで表示する際の URL
		bipFilePath,							// : string				// この板が保存されているパス
		bipIs2ch							// : Boolean		//ホストが2chかどうか
	);

	// *************************************************************************
	// TBoardItem が生成された
	// *************************************************************************
	TBoardItemCreate = procedure(
		inInstance : DWORD
	); stdcall;

	// *************************************************************************
	// TBoardItem が破棄された
	// *************************************************************************
	TBoardItemDispose = procedure(
		inInstance : DWORD
	); stdcall;

	// *************************************************************************
	// ダウンロードを指示された
	// *************************************************************************
	TBoardItemOnDownload = function(
		inInstance	: DWORD					// インスタンス
	) : TDownloadState; stdcall;	// ダウンロードが成功したかどうか

	// *************************************************************************
	// スレ立てを指示
	// *************************************************************************
	TBoardItemOnCreateThread = function(
		inInstance	: DWORD;				// ThreadItem のインスタンス
		inSubject		: PChar;				// スレタイ
		inName			: PChar;				// 名前(ハンドル)
		inMail			: PChar;				// メールアドレス
		inMessage		: PChar					// 本文
	) : TDownloadState; stdcall;	// 書き込みが成功したかどうか

	// *************************************************************************
	// 各スレの情報を返却
	// *************************************************************************
	TBoardItemEnumThreadCallBack = function(
		inInstance	: DWORD;	// TBoardItem のインスタンス
		inURL				: PChar;	// スレッドの URL
		inTitle			: PChar;	// スレタイ
		inCount			: DWORD		// レスの数
	) : Boolean; stdcall;		// 列挙を続けるなら True

	// *************************************************************************
	// この板に保有しているスレを列挙
	// *************************************************************************
	TBoardItemOnEnumThread = procedure(
		inInstance	: DWORD;												// インスタンス
		inCallBack	: TBoardItemEnumThreadCallBack	// 返却すべきコールバック
	); stdcall;

	// *************************************************************************
	// ファイル名からスレッドの URL を要求された
	// *************************************************************************
	TBoardItemOnFileName2ThreadURL = function(
		inInstance	: DWORD;												// インスタンス
		inFileName	: PChar													// 元になるファイル名
	) : PChar; stdcall;

implementation

uses ExternalBoardManager, GikoSystem, BoardGroup, MojuUtils;

// *************************************************************************
// TBoardItem クラスのプロパティを取得する
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
		bipContext:							// : DWORD				// 自由に設定していい値
			Result := boardItem.Context;
		bipNo:									// : Integer			// 番号
			Result := boardItem.No;
		bipTitle:								// : string				// スレッドタイトル
			Result := DWORD( CreateResultString( boardItem.Title ) );
		bipRound:								// : Boolean			// 巡回フラグ
			Result := DWORD( boardItem.Round );
		bipRoundName:						// : string				// 巡回名
			Result := DWORD( CreateResultString( boardItem.RoundName ) );
		bipIsLogFile:						// : Boolean			// ログ存在フラグ
			Result := DWORD( boardItem.IsLogFile );
		bipUnRead:							// : Integer			// スレッド未読数
			Result := DWORD( boardItem.UnRead );
		bipURL:									// : string				// スレッドをブラウザで表示する際の URL
			Result := DWORD( CreateResultString( boardItem.URL ) );
		bipFilePath:															// このスレが保存されているパス
			Result := DWORD( CreateResultString( boardItem.FilePath ) );
		bipIs2ch:
			Result := DWORD( boardItem.Is2ch );
	else
		Result := 0;
	end;
end;

// *************************************************************************
// TBoardItem クラスのプロパティを設定する
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
		bipContext:							// : DWORD			// 自由に設定していい値
			boardItem.Context			:= param;
		bipNo:									// : Integer		// 番号
			boardItem.No						:= param;
		bipTitle:								// : string			// スレッドタイトル
			boardItem.Title				:= string( PChar( param ) );
		bipRound:								// : Boolean		// 巡回フラグ
			boardItem.Round				:= Boolean( param );
		bipRoundName:						// : string			// 巡回名
			//boardItem.RoundName		:= string( PChar( param ) );
			boardItem.RoundName		:= PChar( param );
		bipIsLogFile:						// : Boolean		// ログ存在フラグ
			boardItem.IsLogFile		:= Boolean( param );
		bipUnRead:							// : Integer		// スレッド未読数
			boardItem.UnRead				:= Integer( param );
		bipURL:									// : string			// スレッドをブラウザで表示する際の URL
			boardItem.URL					:= string( PChar( param ) );
		bipFilePath:						// : string			// このスレが保存されているパス
			boardItem.FilePath			:= string( PChar( param ) );
		bipIs2ch:
			boardItem.Is2ch			:= Boolean( param );
	end;

end;

// *************************************************************************
// TBoardItem クラスのプロパティを取得する
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
		bipRoundDate:						// : TDateTime	// スレッドを取得した日時（巡回日時）
			Result := boardItem.RoundDate;
		bipLastModified:				// : TDateTime	// スレッドが更新されている日時（サーバ側日時）
			Result := boardItem.LastModified;
		bipLastGetTime:					// : TDateTime	// スレッドまたはスレッド一覧を最後に更新した日時（サーバ側日時・書き込み時に使用する）
			Result := boardItem.LastGetTime;
	else
		Result := 0;
	end;

end;

// *************************************************************************
// TBoardItem クラスのプロパティを設定する
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
		bipRoundDate:						// : TDateTime	// スレッドを取得した日時（巡回日時）
			boardItem.RoundDate		:= param;
		bipLastModified:				// : TDateTime	// スレッドが更新されている日時（サーバ側日時）
			boardItem.LastModified	:= param;
		bipLastGetTime:					// : TDateTime	// スレッドまたはスレッド一覧を最後に更新した日時（サーバ側日時・書き込み時に使用する）
			boardItem.LastGetTime	:= param;
	end;

end;

// *************************************************************************
// TBoardItem クラスに繋がれている TThreadItem クラスを取得する
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
// 板のダウンロードが進行した
// *************************************************************************
procedure BoardItemWork(
	inInstance	: DWORD;			// クラスのインスタンス
	inWorkCount	: Integer			// 現在の進歩状況(カウント)
); stdcall;
begin

	if Assigned( OnWork ) then
		OnWork( TObject( inInstance ), wmRead, inWorkCount );

end;

// *************************************************************************
// 板のダウンロードが始まった
// *************************************************************************
procedure BoardItemWorkBegin(
	inInstance			: DWORD;	// クラスのインスタンス
	inWorkCountMax	: Integer	// 通信の終わりを示すカウント
); stdcall;
begin

	if Assigned( OnWorkBegin ) then
		OnWorkBegin( TObject( inInstance ), wmRead, inWorkCountMax );

end;

// *************************************************************************
// 板のダウンロードが終わった
// *************************************************************************
procedure BoardItemWorkEnd(
	inInstance	: DWORD				// クラスのインスタンス
); stdcall;
begin

	if Assigned( OnWorkEnd ) then
		OnWorkEnd( TObject( inInstance ), wmRead );

end;

// *************************************************************************
// 板が保有するスレ一覧の列挙処理をプログラム本体に任された
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
			//FileNameによって変化する部分を'(FILENAME!)'とした、文字列をもらう。
			template := board.BoardPlugIn.FileName2ThreadURL( DWORD( board ), '(FILENAME!)' );
			subject.Text := inSubjectText;

			for i := 0 to subject.Count - 1 do begin
				rec						:= GikoSys.DivideSubject( subject[i] );
				rec.FFileName	:= Trim(rec.FFileName);
				if AnsiPos('.', rec.FFileName) > 0 then
					rec.FFileName := Copy(rec.FFileName, 1, AnsiPos('.', rec.FFileName) - 1);
				if (rec.FTitle = '') and (rec.FCount = 0) then
					Continue;

                //テンプレートの'(FILENAME!)'をFileNameに置換する
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
