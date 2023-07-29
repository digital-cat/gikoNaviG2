unit ExternalThreadItem;

interface

uses
	Windows, Classes, SysUtils,
	IdComponent,
	ExternalBoardPlugInMain;

type
	// TThreadItem のプロパティ設定／取得 ID
	TThreadItemProperty = (
		tipContext,							// : DWORD			// 自由に設定していい値
		tipNo,									// : Integer		// 番号
		tipFileName,						// : string			// スレッドファイル名
		tipTitle,								// : string			// スレッドタイトル
		tipRoundDate,						// : TDateTime	// スレッドを取得した日時（巡回日時）
		tipLastModified,				// : TDateTime	// スレッドが更新されている日時（サーバ側日時）
		tipCount,								// : Integer		// スレッドカウント（ローカル）
		tipAllResCount,					// : Integer		// スレッドカウント（サーバ）
		tipNewResCount,					// : Integer		// スレッド新着数
		tipSize,								// : Integer		// スレッドサイズ
		tipRound,								// : Boolean		// 巡回フラグ
		tipRoundName,						// : string			// 巡回名
		tipIsLogFile,						// : Boolean		// ログ存在フラグ
		tipKokomade,						// : Integer		// ココまで読んだ番号
		tipNewReceive,					// : Integer		// ココから新規受信
		tipNewArrival,					// : Boolean		// 新着
		tipUnRead,							// : Boolean		// 未読フラグ
		tipScrollTop,						// : Integer		// スクロール位置
		tipDownloadHost,				// : string			// 今のホストと違う場合のホスト
		tipAgeSage,							// : TThreadAgeSage	// アイテムの上げ下げ
		tipURL,									// : string			// スレッドをブラウザで表示する際の URL
		tipFilePath,							// : string			// このスレが保存されているパス
		tipJumpAddress							// : Integer		// JUMP先レス番号
	);

	// *************************************************************************
	// TThreadItem が生成された
	// *************************************************************************
	TThreadItemCreate = procedure(
		inInstance : DWORD
	); stdcall;

	// *************************************************************************
	// TThreadItem が破棄された
	// *************************************************************************
	TThreadItemDispose = procedure(
		inInstance : DWORD
	); stdcall;

	// *************************************************************************
	// ダウンロードを指示
	// *************************************************************************
	TThreadItemOnDownload = function(
		inInstance	: DWORD					// インスタンス
	) : TDownloadState; stdcall;	// ダウンロードが成功したかどうか

	// *************************************************************************
	// 書き込みを指示
	// *************************************************************************
	TThreadItemOnWrite = function(
		inInstance	: DWORD;				// ThreadItem のインスタンス
		inName			: PChar;				// 名前(ハンドル)
		inMail			: PChar;				// メールアドレス
		inMessage		: PChar					// 本文
	) : TDownloadState; stdcall;	// 書き込みが成功したかどうか

	// *************************************************************************
	// レス番号 n に対する html を要求
	// *************************************************************************
	TThreadItemOnGetRes = function(
		inInstance	: DWORD;		// インスタンス
		inNo				: DWORD			// 表示するレス番号
	) : PChar; stdcall;				// 表示する HTML

	// *************************************************************************
	// レス番号 n に対する Dat を要求
	// *************************************************************************
	TThreadItemOnGetDat = function(
		inInstance	: DWORD;		// インスタンス
		inNo				: DWORD			// 表示するレス番号
	) : PChar; stdcall;				// ２ちゃんねる形式のDat

	// *************************************************************************
	// スレッドのヘッダ html を要求
	// *************************************************************************
	TThreadItemOnGetHeader = function(
		inInstance				: DWORD;	// ThreadItem のインスタンス
		inOptionalHeader	: PChar		// 追加のヘッダ
	) : PChar; stdcall;						// 整形された HTML

	// *************************************************************************
	// スレッドのフッタ html を要求
	// *************************************************************************
	TThreadItemOnGetFooter = function(
		inInstance				: DWORD;	// ThreadItem のインスタンス
		inOptionalFooter	: PChar		// 追加のフッタ
	) : PChar; stdcall;						// 整形された HTML

	// *************************************************************************
	// この ThreadItem が属する板の URL を要求
	// *************************************************************************
	TThreadItemOnGetBoardURL = function(
		inInstance	: DWORD					// ThreadItem のインスタンス
	) : PChar; stdcall;	 					// 板の URL

function ThreadItemDat2HTML(
	inInstance	: DWORD;		// ThreadItem のインスタンス
	inDatRes		: PChar;		// 名前<>メール<>日付ID<>本文<> で構成されたテキスト
	inResNo			: DWORD;		// レス番号
	inIsNew			: Boolean		// 新着レスなら True
) : PChar; stdcall;				// 整形された HTML

implementation

uses ExternalBoardManager, GikoSystem, BoardGroup, HTMLCreate, MojuUtils;

// *************************************************************************
// TThreadItem クラスのプロパティを取得する
// *************************************************************************
function ThreadItemGetLong(
	instance		: DWORD;
	propertyID	: TThreadItemProperty
) : DWORD; stdcall;
var
	threadItem : TThreadItem;
begin

	threadItem := TThreadItem( instance );
	case propertyID of
		tipContext:							// : DWORD			// 自由に設定していい値
			Result := threadItem.Context;
		tipNo:									// : Integer		// 番号
			Result := threadItem.No;
		tipFileName:						// : string			// スレッドファイル名
			Result := DWORD( CreateResultString( threadItem.FileName ) );
		tipTitle:								// : string			// スレッドタイトル
			Result := DWORD( CreateResultString( threadItem.Title ) );
		tipCount:								// : Integer		// スレッドカウント（ローカル）
			Result := threadItem.Count;
		tipAllResCount:					// : Integer		// スレッドカウント（サーバ）
			Result := threadItem.AllResCount;
		tipNewResCount:					// : Integer		// スレッド新着数
			Result := threadItem.NewResCount;
		tipSize:								// : Integer		// スレッドサイズ
			Result := threadItem.Size;
		tipRound:								// : Boolean		// 巡回フラグ
			Result := DWORD( threadItem.Round );
		tipRoundName:						// : string			// 巡回名
			Result := DWORD( CreateResultString( threadItem.RoundName ) );
		tipIsLogFile:						// : Boolean		// ログ存在フラグ
			Result := DWORD( threadItem.IsLogFile );
		tipKokomade:						// : Integer		// ココまで読んだ番号
			Result := threadItem.Kokomade;
		tipNewReceive:					// : Integer		// ココから新規受信
			Result := threadItem.NewReceive;
		tipNewArrival:					// : Boolean		// 新着
			Result := DWORD( threadItem.NewArrival );
		tipUnRead:							// : Boolean		// 未読フラグ
			Result := DWORD( threadItem.UnRead );
		tipScrollTop:						// : Integer		// スクロール位置
			Result := threadItem.ScrollTop;
		tipDownloadHost:				// : string			// 今のホストと違う場合のホスト
			Result := DWORD( CreateResultString( threadItem.DownloadHost ) );
		tipAgeSage:							// : TThreadAgeSage	// アイテムの上げ下げ
			Result := DWORD( threadItem.AgeSage );
		tipURL:									// : string			// スレッドをブラウザで表示する際の URL
			Result := DWORD( CreateResultString( threadItem.URL ) );
		tipFilePath:														// このスレが保存されているパス
			Result := DWORD( CreateResultString( threadItem.FilePath ) );
		tipJumpAddress:
			Result := threadItem.JumpAddress;
	else
		Result := 0;
	end;
end;

// *************************************************************************
// TThreadItem クラスのプロパティを設定する
// *************************************************************************
procedure ThreadItemSetLong(
	instance		: DWORD;
	propertyID	: TThreadItemProperty;
	param : DWORD
); stdcall;
var
	threadItem	: TThreadItem;
begin

	threadItem := TThreadItem( instance );
	case propertyID of
		tipContext:							// : DWORD			// 自由に設定していい値
			threadItem.Context			:= param;
		tipNo:									// : Integer		// 番号
			threadItem.No						:= param;
		tipFileName:						// : string			// スレッドファイル名
			threadItem.FileName			:= string( PChar( param ) );
		tipTitle:								// : string			// スレッドタイトル
			threadItem.Title				:= string( PChar( param ) );
		tipCount:								// : Integer		// スレッドカウント（ローカル）
			threadItem.Count				:= param;
		tipAllResCount:					// : Integer		// スレッドカウント（サーバ）
			threadItem.AllResCount	:= param;
		tipNewResCount:					// : Integer		// スレッド新着数
			threadItem.NewResCount	:= param;
		tipSize:								// : Integer		// スレッドサイズ
			threadItem.Size					:= param;
		tipRound:								// : Boolean		// 巡回フラグ
			threadItem.Round				:= Boolean( param );
		tipRoundName:						// : string			// 巡回名
			//threadItem.RoundName		:= string( PChar( param ) );
			threadItem.RoundName		:= PChar( param );
		tipIsLogFile:						// : Boolean		// ログ存在フラグ
			threadItem.IsLogFile		:= Boolean( param );
		tipKokomade:						// : Integer		// ココまで読んだ番号
			threadItem.Kokomade			:= param;
		tipNewReceive:					// : Integer		// ココから新規受信
			threadItem.NewReceive		:= param;
		tipNewArrival:					// : Boolean		// 新着
			threadItem.NewArrival		:= Boolean( param );
		tipUnRead:							// : Boolean		// 未読フラグ
			threadItem.UnRead				:= Boolean( param );
		tipScrollTop:						// : Integer		// スクロール位置
			threadItem.ScrollTop		 := param;
		tipDownloadHost:				// : string			// 今のホストと違う場合のホスト
			threadItem.DownloadHost	:= string( PChar( param ) );
		tipAgeSage:							// : TThreadAgeSage	// アイテムの上げ下げ
			threadItem.AgeSage			:= TGikoAgeSage( param );
		tipURL:									// : string			// スレッドをブラウザで表示する際の URL
			threadItem.URL					:= string( PChar( param ) );
		//tipFilePath:						// : string			// このスレが保存されているパス
		//	threadItem.FilePath			:= string( PChar( param ) );
		tipJumpAddress:
			threadItem.JumpAddress		:= param;
	end;

end;

// *************************************************************************
// TThreadItem クラスのプロパティを取得する
// *************************************************************************
function ThreadItemGetDouble(
	instance		: DWORD;
	propertyID	: TThreadItemProperty
) : Double; stdcall;
var
	threadItem : TThreadItem;
begin

	threadItem := TThreadItem( instance );
	case propertyID of
		tipRoundDate:						// : TDateTime	// スレッドを取得した日時（巡回日時）
			Result := threadItem.RoundDate;
		tipLastModified:				// : TDateTime	// スレッドが更新されている日時（サーバ側日時）
			Result := threadItem.LastModified;
	else
		Result := 0;
	end;

end;

// *************************************************************************
// TThreadItem クラスのプロパティを設定する
// *************************************************************************
procedure ThreadItemSetDouble(
	instance		: DWORD;
	propertyID	: TThreadItemProperty;
	param				: Double
); stdcall;
var
	threadItem : TThreadItem;
begin

	threadItem := TThreadItem( instance );
	case propertyID of
		tipRoundDate:						// : TDateTime	// スレッドを取得した日時（巡回日時）
			threadItem.RoundDate		:= param;
		tipLastModified:				// : TDateTime	// スレッドが更新されている日時（サーバ側日時）
			threadItem.LastModified	:= param;
	end;

end;

// *************************************************************************
// TThreadItem クラスを元に２ちゃんねるの dat 形式 1 行を HTML に変換する
// *************************************************************************
function ThreadItemDat2HTML(
	inInstance	: DWORD;		// ThreadItem のインスタンス
	inDatRes		: PChar;		// 名前<>メール<>日付ID<>本文<> で構成されたテキスト
	inResNo			: DWORD;		// レス番号
	inIsNew			: Boolean		// 新着レスなら True
) : PChar; stdcall;				// 整形された HTML
var
	threadItem : TThreadItem;
	res : TResRec;
	no : string;
	resLink : TResLinkRec;
begin

	threadItem	:= TThreadItem( inInstance );
	// 引数を分解
	THTMLCreate.DivideStrLine( string( inDatRes ) , @res);
	if AnsiCompareStr( string( inDatRes ) , '' ) <> 0 then begin
		res.FBody		:= THTMLCreate.DeleteLink(res.FBody);
		resLink.FBbs	:= threadItem.ParentBoard.BBSID;
		resLink.FKey	:= ChangeFileExt( threadItem.FileName, '' );
		HTMLCreater.AddAnchorTag( @res );
		HTMLCreater.ConvRes( @res, @resLink );

		no					:= IntToStr( inResNo );

		try
			if GikoSys.Setting.UseSkin then begin
				// スキン
				if inIsNew then
					Result := CreateResultString( HTMLCreater.SkinedRes(
						HTMLCreater.LoadFromSkin(
                            GikoSys.GetSkinNewResFileName, threadItem, threadItem.Size
						), @res, no
                    ) )
                else
					Result := CreateResultString( HTMLCreater.SkinedRes(
						HTMLCreater.LoadFromSkin(
                            GikoSys.GetSkinResFileName, threadItem, threadItem.Size
                        ), @res, no
                    ) );
            end else if GikoSys.Setting.UseCSS then begin
                // CSS
                if res.FName = '' then
                    res.FName := '&nbsp;';
                if res.FMailTo = '' then
                    Result := CreateResultString( '<a name="' + no + '"></a>'
                                    + '<div class="header"><span class="no"><a href="menu:' + No + '">' + no + '</a></span> '
                                    + '<span class="name_label">名前：</span> '
                                    + '<span class="name"><b>' + res.FName + '</b></span> '
                                    + '<span class="date_label">投稿日：</span> '
                                    + '<span class="date">' + res.FDateTime+ '</span></div>'
                                    + '<div class="mes">' + res.FBody + ' </div>' )
                else if GikoSys.Setting.ShowMail then
                    Result := CreateResultString( '<a name="' + no + '"></a>'
                                    + '<div class="header"><span class="no"><a href="menu:' + no + '">' + no + '</a></span>'
                                    + '<span class="name_label"> 名前： </span>'
                                    + '<a class="name_mail" href="mailto:' + res.FMailTo + '">'
                                    + '<b>' + res.FName + '</b></a><span class="mail"> [' + res.FMailTo + ']</span>'
                                    + '<span class="date_label"> 投稿日：</span>'
                                    + '<span class="date"> ' + res.FDateTime+ '</span></div>'
                                    + '<div class="mes">' + res.FBody + ' </div>' )
                else
                    Result := CreateResultString( '<a name="' + no + '"></a>'
                                    + '<div class="header"><span class="no"><a href="menu:' + no + '">' + no + '</a></span>'
                                    + '<span class="name_label"> 名前： </span>'
                                    + '<a class="name_mail" href="mailto:' + res.FMailTo + '">'
                                    + '<b>' + res.FName + '</b></a>'
                                    + '<span class="date_label"> 投稿日：</span>'
                                    + '<span class="date"> ' + res.FDateTime+ '</span></div>'
                                    + '<div class="mes">' + res.FBody + ' </div>' );
            end else begin
                // デフォルト
                if res.FMailTo = '' then
                    Result := CreateResultString( '<a name="' + no + '"></a><dt><a href="menu:' + no + '">' + no + '</a> 名前：<font color="forestgreen"><b> ' + res.FName + ' </b></font> 投稿日： ' + res.FDateTime+ '<br><dd>' + res.Fbody + ' <br><br><br>' )
                else if GikoSys.Setting.ShowMail then
                    Result := CreateResultString( '<a name="' + no + '"></a><dt><a href="menu:' + no + '">' + no + '</a> 名前：<a href="mailto:' + res.FMailTo + '"><b> ' + res.FName + ' </B></a> [' + res.FMailTo + '] 投稿日： ' + res.FDateTime+ '<br><dd>' + res.Fbody + ' <br><br><br>' )
                else
                    Result := CreateResultString( '<a name="' + no + '"></a><dt><a href="menu:' + no + '">' + no + '</a> 名前：<a href="mailto:' + res.FMailTo + '"><b> ' + res.FName + ' </B></a> 投稿日： ' + res.FDateTime+ '<br><dd>' + res.Fbody + ' <br><br><br>' );
            end;
        except
            Result := nil;
        end;
    end else begin
    	Result := nil;
    end;

end;

// *************************************************************************
// TThreadItem クラスを元にスレッドのヘッダを取得する
// *************************************************************************
function ThreadItemGetHeader(
	inInstance				: DWORD;	// ThreadItem のインスタンス
	inOptionalHeader	: PChar		// 追加のヘッダ
) : PChar; stdcall;						// 整形された HTML
var
	threadItem				: TThreadItem;
	skinHeader				: string;
	optionalHeader		: string;
begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.ThreadItemGetHeader');
	{$ENDIF}
	threadItem			:= TThreadItem( inInstance );
	optionalHeader	:= string( inOptionalHeader );

	try
		if GikoSys.Setting.UseSkin then begin
			// スキン
			skinHeader := HTMLCreater.LoadFromSkin( GikoSys.GetSkinHeaderFileName, threadItem, threadItem.Size );
			if Length( optionalHeader ) > 0 then
				skinHeader :=
					StringReplace( skinHeader, '</head>', optionalHeader + '</head><a name="top"></a>', [] );
		end else if GikoSys.Setting.UseCSS then begin
			// CSS
			skinHeader :=
				'<html><head>' +
				'<title>' + threadItem.Title + '</title>' +
				'<link rel="stylesheet" href="'+ GikoSys.Setting.GetStyleSheetDir + GikoSys.Setting.CSSFileName +'" type="text/css">' +
				optionalHeader +
				'</head>' +
				'<body>' +
				'<a name="top"></a>' +
				'<div class="title">' + threadItem.Title + '</div>';
		end else begin
			// デフォルト
			skinHeader :=
				'<html><head>' +
				'<title>' + threadItem.Title + '</title>' +
				optionalHeader +
				'</head>' +
				'<body TEXT="#000000" BGCOLOR="#EFEFEF" link="#0000FF" alink="#FF0000" vlink="#660099">' +
				'<a name="top"></a>' +
				'<font size=+1 color="#FF0000">' + threadItem.Title + '</font>' +
				'<dl>';
		end;
	except
	end;

	Result := CreateResultString( skinHeader );

end;

// *************************************************************************
// TThreadItem クラスを元にスレッドのフッタを取得する
// *************************************************************************
function ThreadItemGetFooter(
	inInstance				: DWORD;	// ThreadItem のインスタンス
	inOptionalFooter	: PChar		// 追加のフッタ
) : PChar; stdcall;						// 整形された HTML
var
	threadItem				: TThreadItem;
	skinFooter				: string;
	optionalFooter		: string;
begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.ThreadItemGetFooter');
	{$ENDIF}
	threadItem			:= TThreadItem( inInstance );
	optionalFooter	:= string( inOptionalFooter );

	try
		if GikoSys.Setting.UseSkin then begin
			// スキン
			skinFooter := HTMLCreater.LoadFromSkin( GikoSys.GetSkinFooterFileName, threadItem, threadItem.Size );
			if Length( optionalFooter ) > 0 then
				skinFooter :=
					StringReplace( skinFooter, '</body>', optionalFooter + '</body>', [] );
		end else if GikoSys.Setting.UseCSS then begin
			// CSS
			skinFooter :=
				optionalFooter +
				'</body></html>' +
				'<a name="last"></a>' +
				'</body></html>';
		end else begin
			// デフォルト
			skinFooter :=
				'</dl>' +
				optionalFooter +
				'</body></html>' +
				'<a name="last"></a>' +
				'</body></html>';
		end;
	except
	end;

	Result := CreateResultString( skinFooter );

end;

// *************************************************************************
// スレッドのダウンロードが進行した
// *************************************************************************
procedure ThreadItemWork(
	inInstance	: DWORD;			// ThreadItem のインスタンス
	inWorkCount	: Integer			// 現在の進歩状況(カウント)
); stdcall;
begin

	if Assigned( OnWork ) then
		OnWork( TObject( inInstance ), wmRead, inWorkCount );

end;

// *************************************************************************
// スレッドのダウンロードが始まった
// *************************************************************************
procedure ThreadItemWorkBegin(
	inInstance			: DWORD;	// ThreadItem のインスタンス
	inWorkCountMax	: Integer	// 通信の終わりを示すカウント
); stdcall;
begin

	if Assigned( OnWorkBegin ) then
		OnWorkBegin( TObject( inInstance ), wmRead, inWorkCountMax );

end;

// *************************************************************************
// スレッドのダウンロードが終わった
// *************************************************************************
procedure ThreadItemWorkEnd(
	inInstance	: DWORD				// ThreadItem のインスタンス
); stdcall;
begin

	if Assigned( OnWorkEnd ) then
		OnWorkEnd( TObject( inInstance ), wmRead );

end;

exports
	ThreadItemGetLong,
	ThreadItemSetLong,
	ThreadItemGetDouble,
	ThreadItemSetDouble,
	ThreadItemDat2HTML,
	ThreadItemGetHeader,
	ThreadItemGetFooter,
	ThreadItemWork,
	ThreadItemWorkBegin,
	ThreadItemWorkEnd;

end.
 