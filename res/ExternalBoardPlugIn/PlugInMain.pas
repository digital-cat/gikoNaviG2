unit PlugInMain;

{
	ExternalBoardPlugIn PlugInMain
	ExternalBoardPlugIn 用の SDK ライブラリ
}

interface

uses
	Windows, SysUtils;

// ===== PlugInSDK API の宣言
type
	// ダウンロードが成功したかどうか
	TDownloadState = (dsWait, dsWork, dsComplete, dsDiffComplete, dsNotModify, dsAbort, dsError);

	// 指定した URL をこのプラグインで受け付けるかどうか
	TAcceptType = (atNoAccept, atBBS, atBoard, atThread);

	// *************************************************************************
	// CreateResultString
	// 戻り値が PChar である API のメモリを確保する
	// *************************************************************************
	TCreateResultString = function(
		resultStr : string
	) : PChar; stdcall;

	// *************************************************************************
	// DisposeResultString
	// 戻り値が PChar である API のメモリを開放する
	// *************************************************************************
	TDisposeResultString = procedure(
		resultStr : PChar
	); stdcall;

	// *************************************************************************
	// プログラム本体のバージョンを取得する
	// *************************************************************************
	TVersionInfo = procedure(
		var outAgent		: PChar;	// バージョンを一切含まない純粋な名称
		var outMajor		: DWORD;	// メジャーバージョン
		var outMinor		: DWORD;	// マイナーバージョン
		var outRelease	: PChar;	// リリース段階名
		var outRevision	: DWORD		// リビジョンナンバー
	); stdcall;

	// *************************************************************************
	// メッセージを表示する
	// *************************************************************************
	TInternalPrint = procedure(
		inMessage	: PChar	// メッセージ
	); stdcall;

	// *************************************************************************
	// デバッグメッセージを表示する
	// *************************************************************************
	TInternalDebugPrint = procedure(
		inMessage	: PChar	// メッセージ
	); stdcall;

	// *************************************************************************
	// InternalDownload
	// 指定した URL をダウンロードして返す
	// *************************************************************************
	TInternalDownload = function(
		inURL							: PChar;			// ダウンロードする URL
		var ioModified		: Double;			// 最後に取得した日時
		var outResultData	: PChar;			// ダウンロードされた文字列
		inRangeStart			: DWORD = 0;	// 開始位置
		inRangeEnd				: DWORD = 0		// 終了位置
	) : Longint; stdcall;							// レスポンスコード

	// *************************************************************************
	// InternalPost
	// 指定した URL へデータを送信する
	// *************************************************************************
	TInternalPost = function(
		inURL							: PChar;			// 送信する URL
		inSource					: PChar;			// 送信する内容
		inReferer			: PChar;			// Referer
		var outResultData	: PChar				// 返ってきた文字列
	) : Longint; stdcall;							// レスポンスコード

	// *************************************************************************
	// InternalAbon
	// ２ちゃんねるの dat 形式をローカルあぼ～んに通す
	// *************************************************************************
	TInternalAbon = function(
		inDatText : PChar;			// 名前<>メール<>日付ID<>本文<> で構成された改行区切りテキスト
		inDatPath	: PChar = nil	// dat ファイルのフルパス
	) : PChar; stdcall;				// あぼ～ん済みの dat 形式テキスト

  // *************************************************************************
  // ２ちゃんねるの dat 形式をローカルあぼ～んに通す
  // ただし、１レスずつ
  // *************************************************************************
  TInternalAbonForOne = function(
      inDatText : PChar;		// 名前<>メール<>日付ID<>本文<>[改行] で構成されたテキスト
      inDatPath	: PChar;		// dat ファイルのフルパス
      inNo : Integer				//要求されたレス番号
  ) : PChar; stdcall;				// あぼ～ん済みの dat 形式テキスト

	// *************************************************************************
	// InternalDat2HTML
	// ２ちゃんねるの dat 形式 1 行を HTML に変換する
	// *************************************************************************
	TInternalDat2HTML = function(
		inDatRes	: PChar; 			// 名前<>メール<>日付ID<>本文<> で構成されたテキスト
		inResNo		: DWORD; 			// レス番号
		inIsNew		: Boolean			// 新着レスなら True
	) : PChar; stdcall;				// 整形された HTML

	// *************************************************************************
	// AddPlugInMenu
	// プラグインメニューに項目を追加
	// ※動的にプラグインが放棄される可能性があるため、
	// 　プラグインのデタッチ時に必ず RemovePlugInMenu を呼び出してください。
	// *************************************************************************
	TAddPlugInMenu = function(
		inInstance	: DWORD;		// プラグインのハンドル
		inCaption		: PChar		 	// メニューに表示する文字列
	) : HMENU; stdcall;			 	// メニューハンドル、追加に失敗した場合は NULL

	// *************************************************************************
	// RemovePlugInMenu
	// プラグインメニューから項目を削除
	// *************************************************************************
	TRemovePlugInMenu = procedure(
		inHandle	: HMENU 			// メニューハンドル
	); stdcall;

var
	CreateResultString	: TCreateResultString;
	DisposeResultString	: TDisposeResultString;
	VersionInfo					: TVersionInfo;
	InternalDownload		: TInternalDownload;
	InternalPrint				: TInternalPrint;
	InternalDebugPrint	: TInternalDebugPrint;
	InternalPost				: TInternalPost;
	InternalAbon				: TInternalAbon;
	InternalAbonForOne	: TInternalAbonForOne;
	InternalDat2HTML		: TInternalDat2HTML;
  AddPlugInMenu				: TAddPlugInMenu;
  RemovePlugInMenu		: TRemovePlugInMenu;


procedure LoadInternalAPI(
	inModule : HMODULE
);

implementation

// *************************************************************************
// PlugInSDK の API を初期化
// *************************************************************************
procedure LoadInternalAPI(
	inModule : HMODULE
);
begin

	// 戻り値確保開放関数
	// 呼び出し側でメモリを確保するとバッファオーバーを気にしなくてはならないので
	// SDK は確保されたメモリを返す設計
	CreateResultString := GetProcAddress( inModule, 'CreateResultString' );
	if not Assigned( CreateResultString ) then
		System.ExitCode := 1;
	DisposeResultString := GetProcAddress( inModule, 'DisposeResultString' );
	if not Assigned( DisposeResultString ) then
		System.ExitCode := 1;
	// バージョン情報
	VersionInfo := GetProcAddress( inModule, 'VersionInfo' );
	if not Assigned( VersionInfo ) then
		System.ExitCode := 1;
	// ===== その他補助関数
	InternalDownload := GetProcAddress( inModule, 'InternalDownload' );
	if not Assigned( InternalDownload ) then
		System.ExitCode := 1;
	InternalPrint := GetProcAddress( inModule, 'InternalPrint' );						// 無くても OK
	InternalDebugPrint := GetProcAddress( inModule, 'InternalDebugPrint' );	// 無くても OK
	InternalPost := GetProcAddress( inModule, 'InternalPost' );
	if not Assigned( InternalDownload ) then
		System.ExitCode := 1;
	InternalAbon := GetProcAddress( inModule, 'InternalAbon' );
	if not Assigned( InternalAbon ) then
		System.ExitCode := 1;
	InternalAbonForOne := GetProcAddress( inModule, 'InternalAbonForOne' );
	if not Assigned( InternalAbonForOne ) then
		System.ExitCode := 1;
	InternalDat2HTML := GetProcAddress( inModule, 'InternalDat2HTML' );
	if not Assigned( InternalDat2HTML ) then
		System.ExitCode := 1;
	AddPlugInMenu := GetProcAddress( inModule, 'AddPlugInMenu' );
	if not Assigned( AddPlugInMenu ) then
		System.ExitCode := 1;
	RemovePlugInMenu := GetProcAddress( inModule, 'RemovePlugInMenu' );
	if not Assigned( RemovePlugInMenu ) then
		System.ExitCode := 1;

end;

end.
