unit GikoSystem;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	ComCtrls, {IniFiles,} ShellAPI, ActnList, Math,
{$IF Defined(DELPRO) }
	SHDocVw,
	MSHTML,
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB,
{$IFEND}
	StrUtils,			//  for D2007
	{HttpApp,} URLMon, IdGlobal, IdURI, {Masks,}
	Setting, BoardGroup, gzip, {Dolib,} bmRegExp, AbonUnit,
	ExternalBoardManager, ExternalBoardPlugInMain,
	GikoBayesian, GikoMessage, Belib;

type
	TVerResourceKey = (
			vrComments,         //!< コメント
			vrCompanyName,      //!< 会社名
			vrFileDescription,  //!< 説明
			vrFileVersion,      //!< ファイルバージョン
			vrInternalName,     //!< 内部名
			vrLegalCopyright,   //!< 著作権
			vrLegalTrademarks,  //!< 商標
			vrOriginalFilename, //!< 正式ファイル名
			vrPrivateBuild,     //!< プライベートビルド情報
			vrProductName,      //!< 製品名
			vrProductVersion,   //!< 製品バージョン
			vrSpecialBuild);    //!< スペシャルビルド情報

	//! BBSタイプ
	TGikoBBSType = (gbt2ch);
	//! ログタイプ
	TGikoLogType = (glt2chNew, glt2chOld);
	//! メッセージアイコン
	TGikoMessageIcon = (gmiOK, gmiSAD, gmiNG, gmiWhat, gmiNone);
	//! URLオープンブラウザタイプ
	TGikoBrowserType = (gbtIE, gbtUserApp, gbtAuto);


	TStrTokSeparator = set of Char;
	TStrTokRec = record
		Str: string;
		Pos: Integer;
	end;

	//! インデックスファイルレコード
	TIndexRec = record
		FNo: Integer;
		FFileName: string;
		FTitle: string;
		FCount: Integer;
		FSize: Integer;
//		FRoundNo: Integer;
		FRoundDate: TDateTime;
		FLastModified: TDateTime;
		FKokomade: Integer;
		FNewReceive: Integer;
		FMishiyou: Boolean;	//!< 未使用
		FUnRead: Boolean;
		FScrollTop: Integer;
		//Index Ver 1.01
		FAllResCount: Integer;
		FNewResCount: Integer;
		FAgeSage: TGikoAgeSage;
	end;

	//! サブジェクトレコード
	TSubjectRec = record
		FFileName: string;
		FTitle: string;
		FCount: Integer;
	end;

	//! レスレコードへのポインタ
	PResRec = ^TResRec;

	//! レスレコード
	TResRec = record
		FTitle: string;
		FMailTo: string;
		FName: string;
		FDateTime: string;
		FBody: string;
		FType: TGikoLogType;
	end;

	//! URLPathレコード
	TPathRec = record
		FBBS: string;				//!< BBSID
		FKey: string;				//!< ThreadID
		FSt: Int64;				  //!< 開始レス番
		FTo: Int64;				  //!< 終了レス番
		FFirst: Boolean;		//!< >>1の表示
		FStBegin: Boolean;	//!< 1～表示
		FToEnd: Boolean;		//!< ～最後まで表示
		FDone: Boolean;			//!< 成功
		FNoParam: Boolean;  //!< レス番パラメータなし
	end;

	TGikoSys = class(TObject)
	private
		{ Private 宣言 }
		FSetting: TSetting;
//		FDolib: TDolib;
		FAWKStr: TAWKStr;
		FResRange : Longint;
		FBayesian	: TGikoBayesian;	//!< ベイジアンフィルタ
		FVersion : String;		      //!< ファイルバージョン
		FGikoMessage: TGikoMessage;
        FBelib: TBelib;
		//! あるセパレータで区切られた文字列からｎ番目の文字列を取り出す
		function ChooseString(const Text, Separator: string; Index: integer): string;
        //! 一時ファイルからの復旧
        procedure RestoreThreadData(Board: TBoard);
	public
		{ Public 宣言 }
		FAbon : TAbon;
		FSelectResFilter : TAbon;
		//FBoardURLList: TStringList;
		constructor Create;

		destructor Destroy; override;
		property ResRange : Longint read FResRange write FResRange;
		//! バージョン情報
		property Version : String read FVersion;
		function IsNumeric(s: string): boolean;
		function IsFloat(s: string): boolean;
		function DirectoryExistsEx(const Name: string): Boolean;
		function ForceDirectoriesEx(Dir: string): Boolean;

		function GetBoardFileName: string;
		function GetCustomBoardFileName: string;
		function GetHtmlTempFileName: string;
		function GetAppDir: string;
		function GetTempFolder: string;
		function GetSentFileName: string;
		function GetConfigDir: string;
        function GetNGWordsDir: string;
		function GetSkinDir: string;
		function GetSkinHeaderFileName: string;
		function GetSkinFooterFileName: string;
		function GetSkinResFileName: string;
		function GetSkinNewResFileName: string;
		function GetSkinBookmarkFileName: string;
		function GetSkinNewmarkFileName: string;
		function GetStyleSheetDir: string;
		function GetOutBoxFileName: string;
		function GetUserAgent: string;
				function GetSambaFileName : string;

		function GetMainKeyFileName : String;
		function GetEditorKeyFileName: String;
		function GetInputAssistFileName: String;
		procedure ReadSubjectFile(Board: TBoard);
		procedure CreateThreadDat(Board: TBoard);
		procedure WriteThreadDat(Board: TBoard);
		function ParseIndexLine(Line: string): TIndexRec;
		procedure GetFileList(Path: string; Mask: string; var List: TStringList; SubDir: Boolean; IsPathAdd: Boolean); overload;
		procedure GetFileList(Path: string; Mask: string; var List: TStringList; IsPathAdd: Boolean); overload;//サブフォルダは検索しない
		procedure GetDirectoryList(Path: string; Mask: string; List: TStringList; SubDir: Boolean);

		function DivideSubject(Line: string): TSubjectRec;
		property Setting: TSetting read FSetting write FSetting;
//		property Dolib: TDolib read FDolib write FDolib;
		property Belib: TBelib read FBelib write FBelib;

		function UrlToID(url: string): string;
		function UrlToServer(url: string): string;

		function StrTokFirst(const s:string; const sep:TStrTokSeparator; var Rec:TStrTokRec):string;
		function StrTokNext(const sep:TStrTokSeparator; var Rec:TStrTokRec): string;

		function GetFileSize(FileName : string) : longint;
		function GetFileLineCount(FileName : string): longint;
		function IntToDateTime(val: Int64): TDateTime;
		function DateTimeToInt(ADate: TDateTime): Int64;

		function ReadThreadFile(FileName: string; Line: Integer): string;

		procedure MenuFont(Font: TFont);

//		function RemoveToken(var s:string; const delimiter:string):string;
		function GetTokenIndex(s: string; delimiter: string; index: Integer): string;

		function GetShortName(const LongName: string; ALength: integer): string;
		function TrimThreadTitle(const SrcTitle: string): string;
		function BoolToInt(b: Boolean): Integer;
		function IntToBool(i: Integer): Boolean;
		function GzipDecompress(ResStream: TStream; ContentEncoding: string): string;
		procedure LoadKeySetting(ActionList: TActionList; FileName: String);
		procedure SaveKeySetting(ActionList: TActionList; FileName: String);
		procedure CreateProcess(const AppPath: string; const Param: string);
		procedure OpenBrowser(URL: string; BrowserType: TGikoBrowserType);
		function HTMLDecode(const AStr: String): String;
		function GetHRefText(s: string): string;
		function Is2chHost(Host: string): Boolean;
		function Parse2chURL(const url: string; const path: string; const document: string; var BBSID: string; var BBSKey: string): Boolean;
		function Parse2chURL2(URL: string): TPathRec;
		procedure ParseURI(const URL : string; var Protocol, Host, Path, Document, Port, Bookmark: string);
		function GetVersionBuild: Integer;
		function	GetBrowsableThreadURL( inURL : string ) : string;
		function	GetThreadURL2BoardURL( inURL : string ) : string;
		function	Get2chThreadURL2BoardURL( inURL : string ) : string;
		function	Get2chBrowsableThreadURL( inURL : string ) : string;
		function	Get2chBoard2ThreadURL( inBoard : TBoard; inKey : string ) : string;
		procedure ListBoardFile;
		procedure ReadBoardFile( bbs : TBBS );

		function	GetUnknownCategory : TCategory;
		function	GetUnknownBoard( inPlugIn : TBoardPlugIn; inURL : string ) : TBoard;

		procedure GetPopupResNumber(URL : string; var stRes, endRes : Int64);

		property Bayesian : TGikoBayesian read FBayesian write FBayesian;
        function CreateResAnchor(var Numbers: TStringList; ThreadItem: TThreadItem; limited: Integer):string;
		procedure GetSameIDRes(const AID : string; ThreadItem: TThreadItem;var body: TStringList); overload;
		procedure GetSameIDRes(AIDNum : Integer; ThreadItem: TThreadItem;var body: TStringList); overload;
        function GetResID(AIDNum: Integer; ThreadItem: TThreadItem): String;
        function ExtructResID(ADateStr: String): String;
		//! 単語解析
		procedure SpamCountWord( const text : string; wordCount : TWordCount );
		//! 学習クリア
		procedure SpamForget( wordCount : TWordCount; isSpam : Boolean );
		//! スパム学習
		procedure SpamLearn( wordCount : TWordCount; isSpam : Boolean );
		//! スパム度数
		function SpamParse( const text : string; wordCount : TWordCount ) : Extended;

		//! 引数に送られてきた日付/ID部にBEの文字列があったら、プロファイルへのリンクを追加
		function AddBeProfileLink(AID : string; ANum: Integer): string;
		//! バージョン情報の取得
		function GetVersionInfo(KeyWord: TVerResourceKey): string;
		//! Pluginの情報の取得
		function GetPluginsInfo(): string;
		//! IEのバージョン情報の取得
		function GetIEVersion: string;
		function SetUserOptionalStyle(): string;
		//! ギコナビのメッセージを設定する
		procedure SetGikoMessage;
		//! ギコナビのメッセージを取得する
		function GetGikoMessage(MesType: TGikoMessageListType): String;
		//! GMTの時刻をTDateTimeに変換する
		function  DateStrToDateTime(const DateStr: string): TDateTime;
        //! User32.dllが利用できるか
        function CanUser32DLL: Boolean;
        //! OE引用符取得
        function GetOEIndentChar : string;
        //! 置換設定ファイル取得
        function GetReplaceFileName: String;
        //! インデックスにないdat（はぐれdat）の追加
        procedure AddOutofIndexDat(Board: TBoard; DatList: TStringList; AllCreate: boolean = True);
        //! ファイル名からのスレッド作成日の取得
        function GetCreateDateFromName(FileName: String): TDateTime;
        function GetExtpreviewFileName: String;

        procedure ShowRefCount(msg: String; unk: IUnknown);
        //! 冒険の書Cookie取得
        function GetBoukenCookie(AURL: String): String;
        //! 冒険の書Cookie設定
        procedure SetBoukenCookie(ACookieValue, ADomain: String);
        //! 冒険の書Cookie削除
        procedure DelBoukenCookie(ADomain: String);
        //! 冒険の書Domain一覧取得
        procedure GetBoukenDomain(var ADomain: TStringList);
        //! 冒険の書ドメイン名Cookie取得
        function GetBouken(AURL: String; var Domain: String): String;
    //! 指定文字列削除
    procedure DelString(del: String; var str: String);
    //! 2ch/5chのURLを実際に呼べる形にする
    procedure Regulate2chURL(var url: String);
    //! 2ch/5chのURLかどうか
    function Is2chURL(url: String): Boolean;
    //! したらばのURLかどうか
    function IsShitarabaURL(url: String): Boolean;
	end;

var
	GikoSys: TGikoSys;
const
	//LENGTH_RESTITLE			= 40;
	ZERO_DATE: Integer	= 25569;
	BETA_VERSION_NAME_E = 'beta';
	BETA_VERSION_NAME_J = 'ﾊﾞﾀ';
	BETA_VERSION				= 73;
	BETA_VERSION_BUILD	= '';				//!< debug版など
	APP_NAME						= 'gikoNavi';
	BE_PHP_URL = 'https://be.5ch.net/test/p.php?i=';


implementation

uses
	Giko, RoundData, Favorite, Registry, HTMLCreate, MojuUtils, Sort, YofUtils,
	IniFiles, DateUtils, SkinFiles;

const
	FOLDER_INDEX_VERSION					= '1.01';
	USER_AGENT										= 'Monazilla';
	USER_AGENT_VERSION            = '1.00';
	DEFAULT_NGWORD_FILE_NAME : String = 'NGword.txt';
	NGWORDs_DIR_NAME : String 		= 'NGwords';

	READ_PATH: string = 			'/test/read.cgi/';
    HTML_READ_PATH: string =        '/test/read.html/';
	OLD_READ_PATH: string =		'/test/read.cgi?';
	KAKO_PATH: string = 			'/kako/';

	KeyWordStr: array [TVerResourceKey] of String = (
		  'Comments',
		  'CompanyName',
		  'FileDescription',
		  'FileVersion',
		  'InternalName',
		  'LegalCopyright',
		  'LegalTrademarks',
		  'OriginalFilename',
		  'PrivateBuild',
		  'ProductName',
		  'ProductVersion',
		  'SpecialBuild');

// *************************************************************************
//! GikoSysコンストラクタ
// *************************************************************************
constructor TGikoSys.Create;
begin
    Inherited;
	FSetting := TSetting.Create;
//	FDolib := TDolib.Create;
    FBelib := TBelib.Create;
	FAWKStr := TAWKStr.Create(nil);
	if DirectoryExists(GetConfigDir) = false then begin
		CreateDir(GetConfigDir);
	end;
	FAbon := TAbon.Create;
    FAbon.IgnoreKana := FSetting.IgnoreKana;
	FAbon.Setroot(GetConfigDir+NGWORDs_DIR_NAME);
	FAbon.GoHome;
	FAbon.ReturnNGwordLineNum := FSetting.ShowNGLinesNum;
	FAbon.SetNGResAnchor := FSetting.AddResAnchor;
	FAbon.DeleteSyria := FSetting.DeleteSyria;
	FAbon.Deleterlo := FSetting.AbonDeleterlo;
	FAbon.Replaceul := FSetting.AbonReplaceul;
	FAbon.AbonPopupRes := FSetting.PopUpAbon;

	FSelectResFilter := TAbon.Create;
    FSelectResFilter.IgnoreKana := True;
	// 絞り込むときは極力一覧が見られるほうがいいので他は完全に削除
	FSelectResFilter.AbonString := '';
    ///
	ResRange := FSetting.ResRange;
	FVersion := Trim(GetVersionInfo(vrFileVersion));
	FBayesian := TGikoBayesian.Create;
	//FBoardURLList := TStringList.Create;
	//メッセージの作成
	FGikoMessage := TGikoMessage.Create;
end;

// *************************************************************************
//! GikoSysデストラクタ
// *************************************************************************
destructor TGikoSys.Destroy;
var
	i: Integer;
	FileList: TStringList;
begin
	//テンポラリHTMLを削除
	FileList := TStringList.Create;
	try
        FileList.BeginUpdate;
		GetFileList(GetTempFolder, '*.html', FileList, False, True);
        FileList.EndUpdate;
		for i := 0 to FileList.Count - 1 do begin
			DeleteFile(FileList[i]);
		end;
	finally
		FileList.Free;
	end;
    FreeAndNil(FGikoMessage);
	FreeAndNil(FBayesian);
	FreeAndNil(FSelectResFilter);
	FreeAndNil(FAbon);
	FreeAndNil(FAWKStr);
    FreeAndNil(FBelib);
//	FreeAndNil(FDolib);
	FreeAndNil(FSetting);
	inherited;
end;

{!
\brief 文字列数字チェック
\param s チェックする文字列
\return s が符号付き整数として認識可能なら True
}
{$HINTS OFF}
function TGikoSys.IsNumeric(s: string): boolean;
var
	e: integer;
	v: integer;
begin
	Val(s, v, e);
	Result := e = 0;
end;
{$HINTS ON}

{!
\brief 文字列浮動小数点数字チェック
\param s チェックする文字列
\return s が符号付き浮動小数として認識可能なら True
}
function TGikoSys.IsFloat(s: string): boolean;
var
	v: Extended;
begin
	Result := TextToFloat(PChar(s), v, fvExtended);
end;

// *************************************************************************
//! ボードファイル名取得（パス＋ファイル名）
// *************************************************************************
function TGikoSys.GetBoardFileName: string;
begin
	Result := Setting.GetBoardFileName;
end;

// *************************************************************************
//! ボードファイル名取得（パス＋ファイル名）
// *************************************************************************
function TGikoSys.GetCustomBoardFileName: string;
begin
	Result := Setting.GetCustomBoardFileName;
end;

// *************************************************************************
//! テンポラリフォルダー名取得
// *************************************************************************
function TGikoSys.GetHtmlTempFileName: string;
begin
	Result := Setting.GetHtmlTempFileName;
end;


// *************************************************************************
//! 実行ファイルフォルダ取得
// *************************************************************************
function TGikoSys.GetAppDir: string;
begin
	Result := Setting.GetAppDir;
end;

// *************************************************************************
//! TempHtmlファイル名取得（パス＋ファイル名）
// *************************************************************************
function TGikoSys.GetTempFolder: string;
begin
	Result := Setting.GetTempFolder;
end;

// *************************************************************************
//! sent.iniファイル名取得（パス＋ファイル名）
// *************************************************************************)
function TGikoSys.GetSentFileName: string;
begin
	Result := Setting.GetSentFileName;
end;

// *************************************************************************
//! outbox.iniファイル名取得（パス＋ファイル名）
// *************************************************************************
function TGikoSys.GetOutBoxFileName: string;
begin
	Result := Setting.GetOutBoxFileName;
end;

// *************************************************************************
//! Configフォルダ取得
// *************************************************************************
function TGikoSys.GetConfigDir: string;
begin
	Result := Setting.GetConfigDir;
end;

function TGikoSys.GetNGWordsDir: string;
begin
	Result := Setting.GetConfigDir + NGWORDs_DIR_NAME;
end;


//! スタイルシートフォルダ
function TGikoSys.GetStyleSheetDir: string;
begin
	Result := Setting.GetStyleSheetDir;
end;

//! スキンフォルダ
function TGikoSys.GetSkinDir: string;
begin
	Result := Setting.GetSkinDir;
end;

//! Skin:ヘッダのファイル名
function TGikoSys.GetSkinHeaderFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinHeaderFileName;
end;

//! Skin:フッタのファイル名
function TGikoSys.GetSkinFooterFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinFooterFileName;
end;

//! Skin:新着レスのファイル名
function TGikoSys.GetSkinNewResFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinNewResFileName;
end;

//! Skin:非新着レスのファイル名
function TGikoSys.GetSkinResFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinResFileName;
end;

//! Skin:しおり(ここまで読んだ)のファイル名
function TGikoSys.GetSkinBookmarkFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinBookmarkFileName;
end;

//! Skin:しおり(新着レス)のファイル名
function TGikoSys.GetSkinNewmarkFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinNewmarkFileName;
end;

//! UserAgent取得
function TGikoSys.GetUserAgent: string;
begin
//	if Dolib.Connected then begin
//		Result := Format('%s %s/%s%d/%s', [
//								Dolib.UserAgent,
//								APP_NAME,
//								BETA_VERSION_NAME_E,
//								BETA_VERSION,
//								Version]);
//	end else begin
		Result := Format('%s/%s %s/%s%d/%s', [
								USER_AGENT,
								USER_AGENT_VERSION,
								APP_NAME,
								BETA_VERSION_NAME_E,
								BETA_VERSION,
								Version]);
//	end;
end;

{!
\brief 経過秒を TDateTime に変換
\param val 1970/1/1/ 00:00:00 からの経過秒
\return val を示す TDateTime
}
function TGikoSys.IntToDateTime(val: Int64): TDateTime;
begin
	Result := ZERO_DATE + val / 86400.0;
end;

{!
\brief TDateTime を経過秒に変換
\param ADate 変換する時刻
\return 1970/1/1/ 00:00:00 からの経過秒
}
function TGikoSys.DateTimeToInt(ADate: TDateTime): Int64;
begin
	Result := Trunc((ADate - ZERO_DATE) * 86400);
end;


{!
\brief SubjectファイルRead
\param Board スレ一覧を取得する板
}
procedure TGikoSys.ReadSubjectFile(Board: TBoard);
var
	ThreadItem: TThreadItem;
	FileName: string;
	FileList: TStringList;
	Index: Integer;
	sl: TStringList;
	i: Integer;
	Rec: TIndexRec;
	UnRead: Integer;
	usePlugIn : Boolean;
	islog : Boolean;
    urlHead: String;
    datFileCheck: Boolean;
	{*
	FavoThreadItem : TFavoriteThreadItem;
	Node: TTreeNode;
	*}
{$IFDEF DEBUG}
    st, rt: Cardinal;
{$ENDIF}
begin
{$IFDEF DEBUG}
	st := GetTickCount;
{$ENDIF}
	if Board.IsThreadDatRead then
		Exit;
	Board.Clear;
	UnRead := 0;
	usePlugIn := Board.IsBoardPlugInAvailable;
	//server :=  UrlToServer( Board.URL );
    // スレッドで共通のURL部
    if Board.is2ch then begin
        urlHead := UrlToServer( Board.URL ) + 'test/read.cgi/' + Board.BBSID + '/';
    end else begin
        urlHead := UrlToServer( Board.URL ) + 'test/read.cgi?bbs=' + Board.BBSID + '&key=';
    end;

	FileName := Board.GetFolderIndexFileName;

    ///
    datFileCheck := (Setting.CheckDatFile) or (not FileExists(FileName));
    if (datFileCheck) then begin
        FileList := TStringList.Create;
        FileList.Sorted := True;
        FileList.BeginUpdate;
        //IsLogFile用DATファイルリスト
        GetFileList(ExtractFileDir(Board.GetFolderIndexFileName), '*.dat', FileList, False);
        FileList.EndUpdate;
    end;

	// 重複を防ぐ
	Board.BeginUpdate;
	Board.Sorted := True;
	sl := TStringList.Create;
	try
		if FileExists(FileName) then begin
			sl.LoadFromFile(FileName);
			//２行目から（１行目はバージョン）
			for i := sl.Count - 1 downto 1 do begin
				Rec := ParseIndexLine(sl[i]);
                if (datFileCheck) then begin
    				islog := FileList.Find( Rec.FFileName, Index );
                end else begin
                    islog := (Rec.FSize <> 0) and (Rec.FCount <> 0);
                end;
				if usePlugIn then
					ThreadItem := TThreadItem.Create(
							Board.BoardPlugIn,
							Board,
							Board.BoardPlugIn.FileName2ThreadURL( DWORD( Board ), Rec.FFileName ) )
				else begin
					if Board.is2ch then begin
						ThreadItem := TThreadItem.Create(
							nil,
							Board,
							urlHead + ChangeFileExt( Rec.FFileName, '' ) + '/l50',
							islog,
							Rec.FFileName
							);
					end else begin
						ThreadItem := TThreadItem.Create(
							nil,
							Board,
							urlHead + ChangeFileExt( Rec.FFileName, '' ) + '&ls=50',
							islog,
							Rec.FFileName
							);
					end;
				end;

				//ThreadItem.BeginUpdate;
				if (datFileCheck) and (islog) then
					FileList.Delete( Index );

				ThreadItem.No := Rec.FNo;
				ThreadItem.FileName := Rec.FFileName;
				ThreadItem.Title := MojuUtils.UnSanitize(Rec.FTitle);
				ThreadItem.Count := Rec.FCount;
				ThreadItem.Size := Rec.FSize;
				ThreadItem.RoundDate := Rec.FRoundDate;
				ThreadItem.LastModified := Rec.FLastModified;
				ThreadItem.Kokomade := Rec.FKokomade;
				ThreadItem.NewReceive := Rec.FNewReceive;
				ThreadItem.UnRead := Rec.FUnRead;
				ThreadItem.ScrollTop := Rec.FScrollTop;
				ThreadItem.AllResCount := Rec.FAllResCount;
				ThreadItem.NewResCount := Rec.FNewResCount;
				ThreadItem.AgeSage := Rec.FAgeSage;
				ThreadItem.ParentBoard := Board;
				{* お気に入り大量生成コード *}
				{*
				FavoThreadItem := TFavoriteThreadItem.Create( ThreadItem.URL, ThreadItem.Title, ThreadItem );
				Node := FavoriteDM.TreeView.Items.AddChildObject( FavoriteDM.TreeView.Items.Item[0], ThreadItem.Title, FavoThreadItem);
				*}

				//ThreadItem.EndUpdate;
				Board.Add(ThreadItem);

				if (ThreadItem.UnRead) and (ThreadItem.IsLogFile) then
					Inc(UnRead);
			end;
		end;

		if UnRead <> Board.UnRead then
			Board.UnRead := UnRead;

        if (datFileCheck) then begin
		    //インデックスに無かったログを追加（腐れインデックス対応）
            AddOutofIndexDat(Board, FileList);
        end;
		Board.EndUpdate;

        //前回異常終了時チェック
        RestoreThreadData( Board );
	finally
		sl.Free;
        if (datFileCheck) then begin
    		FileList.Free;
        end;
		Board.Sorted := False;
	end;
	Board.IsThreadDatRead := True;
{$IFDEF DEBUG}
	rt := GetTickCount - st;
	Writeln('Read Done.' + Board.Title + ':' + IntToStr(rt) + ' ms');
{$ENDIF}
end;
{!
\brief インデックスにないdat（はぐれdat）の追加
\param Board 追加する板
\param DatList  datファイル名
}
procedure TGikoSys.AddOutofIndexDat(Board: TBoard; DatList: TStringList; AllCreate: Boolean = True);
var
    i : Integer;
    Boardpath,FileName : String;
    ResRec: TResRec;
    ThreadItem: TThreadItem;
    create: Boolean;
begin
    create := False;
    Boardpath := ExtractFilePath(Board.GetFolderIndexFileName);
    //インデックスに無かったログを追加（腐れインデックス対応）
    for i := 0 to DatList.Count - 1 do begin
        FileName := Boardpath + DatList[i];
        ThreadItem := nil;
        if (not AllCreate) then begin
            create := False;
            ThreadItem := Board.FindThreadFromFileName(DatList[i]);
            if (ThreadItem = nil) then begin
                create := True;
            end else begin
                if Board.IsBoardPlugInAvailable then begin
                    THTMLCreate.DivideStrLine(Board.BoardPlugIn.GetDat( DWORD( ThreadItem ), 1 ), @ResRec);
                end else begin
                    THTMLCreate.DivideStrLine(ReadThreadFile(FileName, 1), @ResRec);
                end;
            end;
        end;
        if (ThreadItem = nil) then begin
            if Board.IsBoardPlugInAvailable then begin
                ThreadItem := TThreadItem.Create(
                    Board.BoardPlugIn,
                    Board,
                    Board.BoardPlugIn.FileName2ThreadURL( DWORD( Board ), DatList[i] ) );
                THTMLCreate.DivideStrLine(Board.BoardPlugIn.GetDat( DWORD( ThreadItem ), 1 ), @ResRec);
            end else begin
                ThreadItem := TThreadItem.Create(
                    nil,
                    Board,
                    Get2chBoard2ThreadURL( Board, ChangeFileExt( DatList[i], '' ) ) );
                THTMLCreate.DivideStrLine(ReadThreadFile(FileName, 1), @ResRec);
            end;
        end;
        

        ThreadItem.BeginUpdate;
        ThreadItem.FileName := DatList[i];
        //ThreadItem.FilePath := FileName;
        ThreadItem.No := Board.Count + 1;
        ThreadItem.Title := ResRec.FTitle;
        ThreadItem.Count := GetFileLineCount(FileName);
        ThreadItem.AllResCount := ThreadItem.Count;
        ThreadItem.NewResCount := ThreadItem.Count;
        ThreadItem.Size := GetFileSize(FileName) - ThreadItem.Count;//1byteずれるときがあるけどそれはあきらめる
        ThreadItem.RoundDate := FileDateToDateTime( FileAge( FileName ) );
        ThreadItem.LastModified := ThreadItem.RoundDate;
        ThreadItem.Kokomade := -1;
        ThreadItem.NewReceive := 0;
        ThreadItem.ParentBoard := Board;
        ThreadItem.IsLogFile := True;
        ThreadItem.Round := False;
        ThreadItem.UnRead := False;
        ThreadItem.ScrollTop := 0;
        ThreadItem.AgeSage := gasNone;
        ThreadItem.EndUpdate;
        if (AllCreate) or (create) then begin
            Board.Add(ThreadItem);
        end;
    end;
end;
{!
\brief スレッドインデックスファイル(Folder.idx)作成
\param Board Folder.idx を作成する板
}
procedure TGikoSys.CreateThreadDat(Board: TBoard);
var
	i: integer;
	s: string;
	SubjectList: TStringList;
	sl: TStringList;
	Rec: TSubjectRec;
	FileName: string;
	cnt: Integer;
begin
	if not FileExists(Board.GetSubjectFileName) then Exit;
	FileName := Board.GetFolderIndexFileName;

	SubjectList := TStringList.Create;
	try
		SubjectList.LoadFromFile(Board.GetSubjectFileName);
		sl := TStringList.Create;
		try
			cnt := 1;
			sl.BeginUpdate;
			sl.Add(FOLDER_INDEX_VERSION);
			for i := 0 to SubjectList.Count - 1 do begin
				Rec := DivideSubject(SubjectList[i]);

				if (Trim(Rec.FFileName) = '') or (Trim(Rec.FTitle) = '') then
					Continue;

				{s := Format('%x', [cnt]) + #1					//番号
					 + Rec.FFileName + #1								//ファイル名
					 + Rec.FTitle + #1									//タイトル
					 + Format('%x', [Rec.FCount]) + #1	//カウント
					 + Format('%x', [0]) + #1						//size
					 + Format('%x', [0]) + #1						//RoundDate
					 + Format('%x', [0]) + #1						//LastModified
					 + Format('%x', [0]) + #1						//Kokomade
					 + Format('%x', [0]) + #1						//NewReceive
					 + '0' + #1					 							//未使用
					 + Format('%x', [0]) + #1						//UnRead
					 + Format('%x', [0]) + #1						//ScrollTop
					 + Format('%x', [Rec.FCount]) + #1	//AllResCount
					 + Format('%x', [0]) + #1						//NewResCount
					 + Format('%x', [0]);								//AgeSage
				}
				s := Format('%x'#1'%s'#1'%s'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x'#1 + 
							'%s'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x',
					[cnt,			//番号
					 Rec.FFileName, //ファイル名
					 MojuUtils.Sanitize(Rec.FTitle),    //タイトル
					 Rec.FCount,     //カウント
					 0,             //size
					 0,             //RoundDate
					 0,				//LastModified
					 0,				//Kokomade
					 0,				//NewReceive
					 '0',			//未使用
					 0,				//UnRead
					 0,				//ScrollTop
					 Rec.FCount,	//AllResCount
					 0,				//NewResCount
					 0]             //AgeSage
					);

				sl.Add(s);
				inc(cnt);
			end;
			sl.EndUpdate;
			sl.SaveToFile(FileName);
		finally
			sl.Free;
		end;
	finally
		SubjectList.Free;
	end;
end;

{!
\brief スレッドインデックス(Thread.dat)書き込み
\param Thread.dat を作成する板
}
procedure TGikoSys.WriteThreadDat(Board: TBoard);
//const
//	Values: array[Boolean] of string = ('0', '1');
var
	i: integer;
	FileName: string;
	sl: TStringList;
	s: string;
	TmpFileList: TStringList;
begin
	if not Board.IsThreadDatRead then
		Exit;
	FileName := Board.GetFolderIndexFileName;
	ForceDirectoriesEx( ExtractFilePath( FileName ) );

	sl := TStringList.Create;
	TmpFileList := TStringList.Create;
	TmpFileList.Sorted := true;
	try
        TmpFileList.BeginUpdate;
		GetFileList(ExtractFileDir(Board.GetFolderIndexFileName), '*.tmp', TmpFileList, false);
        TmpFileList.EndUpdate;
		sl.BeginUpdate;
		sl.Add(FOLDER_INDEX_VERSION);

		// スレ番号保存のためソート
		Sort.SetSortNoFlag(true);
		Sort.SetSortOrder(true);
		Sort.SetSortIndex(0);
		//Sort.SortNonAcquiredCountFlag := GikoSys.Setting.NonAcquiredCount;
		Board.CustomSort(ThreadItemSortProc);

		for i := 0 to Board.Count - 1 do begin
			Board.Items[i].No := i + 1;
			s := Format('%x'#1'%s'#1'%s'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x'#1 +
							'%s'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x',
					[Board.Items[i].No,			//番号
					 Board.Items[i].FileName, //ファイル名
                     MojuUtils.Sanitize(Board.Items[i].Title),    //タイトル
					 Board.Items[i].Count,     //カウント
					 Board.Items[i].Size,             //size
					 DateTimeToInt(Board.Items[i].RoundDate),             //RoundDate
					 DateTimeToInt(Board.Items[i].LastModified),				//LastModified
					 Board.Items[i].Kokomade,				//Kokomade
					 Board.Items[i].NewReceive,				//NewReceive
					 '0',			//未使用
					 BoolToInt(Board.Items[i].UnRead),				//UnRead
					 Board.Items[i].ScrollTop,				//ScrollTop
					 Board.Items[i].AllResCount,	//AllResCount
					 Board.Items[i].NewResCount,				//NewResCount
					 Ord(Board.Items[i].AgeSage)]             //AgeSage
					);

			sl.Add(s);
		end;
		sl.EndUpdate;
		sl.SaveToFile(FileName);

		for i := 0 to TmpFileList.Count - 1 do begin
			DeleteFile(ExtractFilePath(Board.GetFolderIndexFileName) + TmpFileList[i]);
		end;

	finally
		TmpFileList.Free;
		sl.Free;
	end;
end;

{!
\brief Folder.idx を 1 行解釈
\param Line Folder.idx を構成する 1 行
\return スレッド情報
}
function TGikoSys.ParseIndexLine(Line: string): TIndexRec;
begin
	Result.FNo := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FFileName := MojuUtils.RemoveToken(Line, #1);
	Result.FTitle := MojuUtils.UnSanitize(MojuUtils.RemoveToken(Line, #1));
	Result.FCount := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FSize := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FRoundDate := IntToDateTime(StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), ZERO_DATE));
	Result.FLastModified := IntToDateTime(StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), ZERO_DATE));
	Result.FKokomade := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), -1);
	Result.FNewReceive := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	MojuUtils.RemoveToken(Line, #1);//9: ;	//未使用
	Result.FUnRead := IntToBool(StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0));
	Result.FScrollTop := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FAllResCount := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FNewResCount := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FAgeSage := TGikoAgeSage(StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0));

end;

{!
\brief 指定フォルダ内の指定ファイル一覧を取得する
\param Path      起点となるフォルダパス
\param Mask      ファイル名のマスク
\param List      OUT:取得されたファイル名一覧が返る
\param SubDir    中のフォルダまで再帰的にリストする場合は True
\param IsPathAdd パス付きでリストアップする場合は True

Mask を '*.txt' のように指定することで、
特定のファイル名や特定の拡張子に絞ったリストアップが可能です。

\par 例:
\code
GetFileList('c:\', '*.txt', list, True, True);
\endcode
}
procedure TGikoSys.GetFileList(Path: string; Mask: string; var List: TStringList; SubDir: Boolean; IsPathAdd: Boolean);
var
	rc: Integer;
	SearchRec : TSearchRec;
	s: string;
begin
	Path := IncludeTrailingPathDelimiter(Path);
	rc := FindFirst(Path + '*.*', faAnyfile, SearchRec);
	try
		while rc = 0 do begin
			if (SearchRec.Name <> '..') and (SearchRec.Name <> '.') then begin
				s := Path + SearchRec.Name;

				if (SearchRec.Attr and faDirectory = 0) and (MatchesMask(s, Mask)) then
						if IsPathAdd then
							List.Add(s)
						else
							List.Add(SearchRec.Name);
				if SubDir and (SearchRec.Attr and faDirectory > 0) then
					GetFileList(s, Mask, List, True, IsPathAdd);
			end;
			rc := FindNext(SearchRec);
		end;
	finally
		SysUtils.FindClose(SearchRec);
	end;
	List.Sort;
end;

{!
\breif 指定フォルダ内の指定ファイル一覧を取得する。
			 サブフォルダは検索しない
\param Path      起点となるフォルダパス
\param Mask      ファイル名のマスク
\param List      OUT:取得されたファイル名一覧が返る
\param IsPathAdd パス付きでリストアップする場合は True
\note 再起指定可能な GetFileList() があるのでこの関数は不要?
\par 例
\code
GetFileList('c:\', '*.txt', list, True);
\endcode
}
procedure TGikoSys.GetFileList(Path: string; Mask: string; var List: TStringList; IsPathAdd: Boolean);
var
	rc: Integer;
	SearchRec : TSearchRec;
begin
	Path := IncludeTrailingPathDelimiter(Path);
	rc := FindFirst(Path + Mask, faAnyfile, SearchRec);
	try
		while rc = 0 do begin
			if (SearchRec.Name <> '..') and (SearchRec.Name <> '.') then begin
				if (SearchRec.Attr and faDirectory = 0) then begin
                    if IsPathAdd then begin
                        List.Add(Path + SearchRec.Name)
                    end else begin
                        List.Add(SearchRec.Name);
                    end;
                end;
			end;
			rc := FindNext(SearchRec);
		end;
	finally
		SysUtils.FindClose(SearchRec);
	end;
	List.Sort;
end;

{!
\brief 指定フォルダ内のディレクトリ一覧を取得する
\param Path      起点となるフォルダパス
\param Mask      フォルダ名のマスク
\param List      OUT:取得されたフォルダ名一覧が返る
\param SubDir    中のフォルダまで再帰的にリストする場合は True

Mask を '*.txt' のように指定することで、
特定のファイル名や特定の拡張子に絞ったリストアップが可能です。

\par 例:
\code
GetDirectoryList('c:\', '*.txt', list, True);
\endcode
}
procedure TGikoSys.GetDirectoryList(Path: string; Mask: string; List: TStringList; SubDir: Boolean);
var
	rc: Integer;
	SearchRec : TSearchRec;
	s: string;
begin
	Path := IncludeTrailingPathDelimiter(Path);
	rc := FindFirst(Path + '*.*', faDirectory, SearchRec);
	try
		while rc = 0 do begin
			if (SearchRec.Name <> '..') and (SearchRec.Name <> '.') then begin
				s := Path + SearchRec.Name;
				//if (SearchRec.Attr and faDirectory > 0) then
				//	s := IncludeTrailingPathDelimiter(s)

				if (SearchRec.Attr and faDirectory > 0) and (MatchesMask(s, Mask)) then
					List.Add( IncludeTrailingPathDelimiter( s ) );
				if SubDir and (SearchRec.Attr and faDirectory > 0) then
					GetDirectoryList(s, Mask, List, True);
			end;
			rc := FindNext(SearchRec);
		end;
	finally
		SysUtils.FindClose(SearchRec);
	end;
end;


{!
\brief Subject.txt 一行を解釈
\param Line Subject.txt を構成する 1 行
\return     スレッド情報
}
function TGikoSys.DivideSubject(Line: string): TSubjectRec;
var
	i: integer;
	ws: WideString;
	Delim: string;
	LeftK: string;
	RightK: string;
begin
	Result.FCount := 0;

	if AnsiPos('<>', Line) = 0 then
		Delim := ','
	else
		Delim := '<>';
	Result.FFileName := MojuUtils.RemoveToken(Line, Delim);
	Result.FTitle := Trim(MojuUtils.RemoveToken(Line, Delim));

	ws := Result.FTitle;
	if Copy(ws, Length(ws), 1) = ')' then begin
		LeftK := '(';
		RightK := ')';
	end else if Copy(ws, Length(ws)-1, 2) = '）' then begin
		LeftK := '（';
		RightK := '）';
	end else if Copy(ws, Length(ws), 1) = '>' then begin
		LeftK := '<';
		RightK := '>';
	end;
	for i := Length(ws) - 1 downto 1 do begin
		if Copy(ws, i, Length(LeftK)) = LeftK then begin
			Result.FTitle := TrimRight(Copy(ws, 1, i - 1));
			ws := Copy(ws, i + Length(LeftK), Length(ws) - i - Length(RightK));
			if IsNumeric(ws) then
				Result.FCount := StrToInt(ws);
			//Delete(Result.FTitle, i, Length(LeftK) + Length(ws) + Length(RightK));
			break;
		end;
	end;
end;

{!
\brief URLからBBSIDを取得
\param url BBSID を取得する URL
\return    BBSID
}
function TGikoSys.UrlToID(url: string): string;
var
	i: integer;
begin
	Result := '';
	url := Trim(url);

	if url = '' then Exit;
	try
		url := Copy(url, 0, Length(url) - 1);
		for i := Length(url) downto 0 do begin
			if url[i] = '/' then begin
				Result := Copy(url, i + 1, Length(url));
				Break;
			end;
		end;
	except
		Result := '';
	end;
end;

{!
\brief URLから最後の要素を削除
\param url 解釈する URL
\return    切り取られた後の URL

URL から BBSID以外の部分を取得するのに使用します。
}
function TGikoSys.UrlToServer(url: string): string;
var
	i: integer;
	wsURL: WideString;
begin
	Result := '';
	wsURL := url;
	wsURL := Trim(wsURL);

	if wsURL = '' then exit;

	if Copy(wsURL, Length(wsURL), 1) = '/' then
		wsURL := Copy(wsURL, 0, Length(wsURL) - 1);

	for i := Length(wsURL) downto 0 do begin
		if wsURL[i] = '/' then begin
			Result := Copy(wsURL, 0, i);
			break;
		end;
	end;
end;

{!
\brief ディレクトリが存在するかチェック
\param Name 存在を確認するフォルダパス
\return     フォルダが存在するなら True
}
function TGikoSys.DirectoryExistsEx(const Name: string): Boolean;
var
	Code: Cardinal;
begin
	Code := GetFileAttributes(PChar(Name));
	Result := (Code <> Cardinal(-1)) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

{!
\brief ディレクトリ作成（複数階層対応）
\param Dir 作成するパス
\return    作成に成功した場合は True
}
function TGikoSys.ForceDirectoriesEx(Dir: string): Boolean;
begin
	Result := True;
	if Length(Dir) = 0 then
		raise Exception.Create('フォルダが作成出来ません');
	Dir := ExcludeTrailingPathDelimiter(Dir);
	if (Length(Dir) < 3) or DirectoryExistsEx(Dir)
		or (ExtractFilePath(Dir) = Dir) then Exit; // avoid 'xyz:\' problem.
	Result := ForceDirectoriesEx(ExtractFilePath(Dir)) and CreateDir(Dir);
end;

{!
\brief 文字列からトークンの切り出し（初期処理）
			 FDelphiからのパクリ
\param s   元になるキャラクタ
\param sep 区切りになる文字列
\param Rec OUT:文字列走査情報が返る
\return    切り出したトークン
\todo Split, RemoveToken, GetTokenIndex, NthField 行き
}
function TGikoSys.StrTokFirst(const s:string; const sep: TStrTokSeparator; var Rec: TStrTokRec): string;
begin
	Rec.Str := s;
	Rec.Pos := 1;
	Result := StrTokNext(sep, Rec);
end;

{!
\brief 文字列からトークンの切り出し
			 FDelphiからのパクリ
\param sep 区切りになるキャラクタ
\param Rec IN/OUT:StrTokFirstで作成された文字列走査情報
\return    切り出したトークン
\todo Split, RemoveToken, GetTokenIndex, NthField 行き
}
function TGikoSys.StrTokNext(const sep: TStrTokSeparator; var Rec: TStrTokRec): string;
var
	Len, I: Integer;
begin
	with Rec do	begin
		Len := Length(Str);
		Result := '';
		if Len >= Pos then begin
			while (Pos <= Len) and (Str[Pos] in sep) do begin
			 Inc(Pos);
			end;
			I := Pos;
			while (Pos<= Len) and not (Str[Pos] in sep) do begin
				if IsDBCSLeadByte(Byte(Str[Pos])) then begin
					Inc(Pos);
				end;
				Inc(Pos);
			end;
			Result := Copy(Str, I, Pos - I);
			while (Pos <= Len) and (Str[Pos] in sep) do begin// これはお好み
				Inc(Pos);
			end;
		end;
	end;
end;

{!
\brief ファイルサイズ取得
\param FileName ファイルサイズを取得するファイルパス
\return         ファイルサイズ(bytes)
}
function TGikoSys.GetFileSize(FileName : string): longint;
var
	F : File;
begin
	try
		if not FileExists(FileName) then begin
			Result := 0;
			Exit;
		end;
		Assign(F, FileName);
		Reset(F, 1);
		Result := FileSize(F);
		CloseFile(F);
	except
		Result := 0;
	end;
end;

{!
\brief テキストファイルの行数を取得
\param FileName 行数を取得するファイルパス
\return         行数
\todo メモリマップドファイル行き
}
function TGikoSys.GetFileLineCount(FileName : string): longint;
var
	sl: TStringList;
begin
	sl := TStringList.Create;
	try
		try
			sl.LoadFromFile(FileName);
			Result := sl.Count;
		except
			Result := 0;
		end;
	finally
		sl.Free;
	end;

end;

{!
\brief ファイルから指定行を取得
\param FileName ファイルのパス
\param Line     指定行
\return         指定された 1 行
\todo メモリマップドファイル行き
}
function TGikoSys.ReadThreadFile(FileName: string; Line: Integer): string;
var
	fileTmp : TStringList;
begin
	Result := '';
	if FileExists(FileName) then begin
		fileTmp := TStringList.Create;
		try
			try
				fileTmp.LoadFromFile( FileName );
				if ( Line	>= 1 ) and ( Line	< fileTmp.Count + 1 ) then begin
					Result := fileTmp.Strings[ Line-1 ];
				end;
			except
				//on EFOpenError do Result := '';
			end;
		finally
			fileTmp.Free;
		end;
	end;
end;

{!
\brief システムメニューフォントの属性を取得
\param Font OUT:取得したフォント属性が返る
}
procedure TGikoSys.MenuFont(Font: TFont);
var
	lf: LOGFONT;
	nm: NONCLIENTMETRICS;
begin
	nm.cbSize := sizeof(NONCLIENTMETRICS);
    SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @nm, 0);
    lf := nm.lfMenuFont;
    Font.Name := lf.lfFaceName;
    Font.Height := lf.lfHeight;
    Font.Style := [];
    if lf.lfWeight >= 700 then
        Font.Style := Font.Style + [fsBold];
    if lf.lfItalic = 1 then
        Font.Style := Font.Style + [fsItalic];
end;

{!
\brief 先頭のトークンを切り出し
\param s         IN/OUT:元になる文字列、切り出した後の残りの文字列
\param delimiter 区切りになる文字列
\return          切り出した文字列

どこかのサイトからのパクリ
}
{function TGikoSys.RemoveToken(var s: string;const delimiter: string): string;
var
	p: Integer;
begin
	p := AnsiPos(delimiter, s);
	if p = 0 then
		Result := s
	else
		Result := Copy(s, 1, p - 1);
	Delete(s, 1, Length(Result) + Length(delimiter));
end;
}

{!
\brief n 個目のトークンを切り出し
\param s     元になる文字列
\param index 0 から始まるインデックス(n 個目の n)
\return 切り出したトークン

どこかのサイトからのパクリ
}
function TGikoSys.GetTokenIndex(s: string; delimiter: string; index: Integer): string;
var
	i: Integer;
begin
	Result := '';
	for i := 0 to index do
		Result := MojuUtils.RemoveToken(s, delimiter);
end;


//インデックス未更新バッファをフラッシュ！
{procedure TGikoSys.FlashExitWrite;
var
	i: Integer;
begin
	//スレッドデータファイルを更新
	for i := 0 to FExitWrite.Count - 1 do
		WriteThreadDat(FExitWrite[i]);
	FExitWrite.Clear;
end;}

{!
\brief スレ名などを短い名前に変換する
\param LongName 元になる文字列
\param ALength  収める文字列長(bytes)
\return         変換された文字列

from HotZonu
}
function TGikoSys.GetShortName(const LongName: string; ALength: integer): string;
const
	ERASECHAR : array [1..39] of string =
		('☆','★','■','□','◆','◇','＿','＃','▲','▼',
		 '△','▽','●','○','◎','【','】','♪','《','》',
		 '“','”','〔','〕','‘','’','＜','＞','≪','≫',
		 '｛','｝','〈','〉','『','』','〓','…', '　');
var
	Chr : array [0..255]	of	char;
	S : string;
	i : integer;
begin
    s := TrimThreadTitle(Trim(LongName));
	if (Length(s) <= ALength) then begin
		Result := s;
	end else begin
		S := s;
		for i := Low(ERASECHAR)	to	High(ERASECHAR) do	begin
			S := CustomStringReplace(S, ERASECHAR[i], '');
		end;
		if (Length(S) <= ALength) then begin
			Result := S;
		end else begin
			Windows.LCMapString(
					GetUserDefaultLCID(),
					LCMAP_HALFWIDTH,
					PChar(S),
					Length(S) + 1,
					chr,
					Sizeof(chr)
					);
			S := Chr;
			S := Copy(S,1,ALength);
			while true do begin
				if (ByteType(S, Length(S)) = mbLeadByte ) then begin
					S := Copy(S, 1, Length(S) - 1);
				end else begin
					Break;
				end;
			end;
			Result := S;
		end;
	end;
end;

function TGikoSys.TrimThreadTitle(const SrcTitle: string): string;
const
    TRIM_STRING: array [1..5] of String =
        ('[転載禁止]', '&copy;5ch.net', '&copy;2ch.net', '&copy;bbspink.com', #9);
var
    i: Integer;
    Idx: Integer;
    Len: Integer;
    DstTitle: String;
begin
    if (Setting.ThreadTitleTrim = True) then begin
        DstTitle := SrcTitle;
		for i := Low(TRIM_STRING) to High(TRIM_STRING) do begin
            Len := Length(TRIM_STRING[i]);
            while (True) do begin
                Idx := Pos(TRIM_STRING[i], DstTitle);
                if (Idx < 1) then
                    Break;
                Delete(DstTitle, Idx, Len);
            end;
        end;
        Result := Trim(DstTitle);
    end else begin
        Result := SrcTitle;
    end;
end;

{!
\brief Boolean を Integer に変換
\return False..0, True..1
}
function TGikoSys.BoolToInt(b: Boolean): Integer;
begin
	Result := IfThen(b, 1, 0);
end;

{!
\brief Integer を Boolean に変換
\return 1..True, other..False
\todo 0..False, other..True の方がいいのでは?
			(この仕様に依存しているかもしれないので未修正)
}
function TGikoSys.IntToBool(i: Integer): Boolean;
begin
	Result := i = 1;
end;

{!
\brief gzipで圧縮されたのを戻す
\param ResStream       読み込むストリーム
\param ContentEncoding エンコーディング
\return                展開された文字列
}
function TGikoSys.GzipDecompress(ResStream: TStream; ContentEncoding: string): string;
const
	BUF_SIZE = 4096;
var
	GZipStream: TGzipDecompressStream;
	TextStream: TStringStream;
	buf: array[0..BUF_SIZE - 1] of Byte;
	cnt: Integer;
	s: string;
	i, ln: Integer;
begin
	Result := '';
	TextStream := TStringStream.Create('');
	try
//ノートンウンチウィルス2003対策(x-gzipとかになるみたい)
//		if LowerCase(Trim(ContentEncoding)) = 'gzip' then begin
		if AnsiPos('gzip', LowerCase(Trim(ContentEncoding))) > 0 then begin
			ResStream.Position := 0;
			GZipStream := TGzipDecompressStream.Create(TextStream);
			try
				repeat
					FillChar(buf, BUF_SIZE, 0);
					cnt := ResStream.Read(buf, BUF_SIZE);
					if cnt > 0 then
						GZipStream.Write(buf, BUF_SIZE);
				until cnt <= 0;
			finally
				GZipStream.Free;
			end;
		end else begin
			ResStream.Position := 0;
			repeat
				FillChar(buf, BUF_SIZE, 0);
				cnt := ResStream.Read(buf, BUF_SIZE);
				if cnt > 0 then
					TextStream.Write(buf, BUF_SIZE);
			until cnt <= 0;
		end;

		//NULL文字を"*"にする
		s := TextStream.DataString;
		i := Length(s);
        if (i > 0) then begin
            ln := i;
            while (i > 0) and (s[i] = #0) do
                Dec(i);
            if (ln > i) then
                Delete(s, i + 1, ln - i);
        end;

		i := Pos(#0, s);
		while i > 0 do begin
			s[i] := '*';
			i := Pos(#0, s);
		end;

		Result := s;
	finally
		TextStream.Free;
	end;
end;

{!
\brief アクションにショートカットキーを設定
\param ActionList 設定するアクション一覧
\param FileName Iniファイルの名前
}
procedure TGikoSys.LoadKeySetting(ActionList: TActionList; FileName: String);
const
	STD_SEC = 'KeySetting';
var
	i: Integer;
	ini: TMemIniFile;
	ActionName: string;
	ActionKey: Integer;
	SecList: TStringList;
	Component: TComponent;
begin
	if not FileExists(fileName) then
		Exit;
	SecList := TStringList.Create;
	ini := TMemIniFile.Create(fileName);
	try
		ini.ReadSection(STD_SEC, SecList);
		for i := 0 to SecList.Count - 1 do begin
			ActionName := SecList[i];
			ActionKey := ini.ReadInteger(STD_SEC, ActionName, -1);
			if ActionKey <> -1 then begin
				Component := ActionList.Owner.FindComponent(ActionName);
				if TObject(Component) is TAction then begin
					TAction(Component).ShortCut := ActionKey;
				end;
			end;
		end;
	finally
		ini.Free;
		SecList.Free;
	end;
end;

{!
\brief アクションに設定されているショートカットキーをファイルに保存
\param ActionList 保存するアクション一覧
\param FileName Iniファイル名

ActionList に設定されているショートカットキーを FileName に保存します。
}
procedure TGikoSys.SaveKeySetting(ActionList: TActionList; FileName: String);
const
	STD_SEC = 'KeySetting';
var
	i: Integer;
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetConfigDir + FileName);
	try
		for i := 0 to ActionList.ActionCount - 1 do begin
			if ActionList.Actions[i].Tag = -1 then
				Continue;
			ini.WriteInteger(STD_SEC, ActionList.Actions[i].Name, TAction(ActionList.Actions[i]).ShortCut);
		end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;


{!
\brief プロセスの生成
\param AppPath 起動するプロセスのファイルパス
\param Param   AppPath に渡す引数
}
procedure TGikoSys.CreateProcess(const AppPath: string; const Param: string);
var
	PI: TProcessInformation;
	SI: TStartupInfo;
	Path: string;
begin
	Path := '"' + AppPath + '"';
	if Param <> '' then
		Path := Path + ' ' + Param;

	SI.Cb := SizeOf(Si);
	SI.lpReserved	:= nil;
	SI.lpDesktop	 := nil;
	SI.lpTitle		 := nil;
	SI.dwFlags		 := 0;
	SI.cbReserved2 := 0;
	SI.lpReserved2 := nil;
	SI.dwysize		 := 0;
    if Windows.CreateProcess(nil,
								PChar(Path),
								nil,
								nil,
								False,
								0,
								nil,
								nil,
								SI,
								PI) then
    begin
        CloseHandle(PI.hProcess);
    end;

end;

{!
\brief Web ブラウザを起動
\param URL         Web ブラウザで表示する URL
\param BrowserType ブラウザのタイプ(IE かどうか)
}
procedure TGikoSys.OpenBrowser(URL: string; BrowserType: TGikoBrowserType);
var
    i, j : Integer;
    path, arg : String;
    params : TStringList;
begin
	case BrowserType of
		gbtIE:
			HlinkNavigateString(nil, PWideChar(WideString(URL)));
		gbtUserApp, gbtAuto:
			if (Setting.URLApp) then begin
                if (FileExists(Setting.URLAppFile)) then begin
    				GikoSys.CreateProcess(Setting.URLAppFile, URL)
                end else begin
                    // 起動パラメータ付き対策
                    path := '';
                    params := TStringList.Create;
                    try
                        params.Delimiter := ' ';
                        params.DelimitedText := Setting.URLAppFile;
                        for i := 0 to params.Count - 1 do begin
                            path := TrimLeft(path + ' ' + params[i]);
                            if (FileExists(path)) then begin
                                arg := '';
                                for j := i + 1 to params.Count - 1 do begin
                                    arg := arg + ' ' + params[j];
                                end;
                                break;
                            end;
                        end;
                        if i < params.Count then begin
                            GikoSys.CreateProcess(path, arg + ' ' + URL);
                        end else begin
                            HlinkNavigateString(nil, PWideChar(WideString(URL)));
                        end;
                    finally
                        params.Free;
                    end;
                end;
			end else
				HlinkNavigateString(nil, PWideChar(WideString(URL)));
	end;
end;

{!
\brief 文字実体参照をデコード
\param AStr デコードする文字列
\return     デコードされた文字列
}
function TGikoSys.HTMLDecode(const AStr: String): String;
var
	Sp, Rp, Cp, Tp: PChar;
	S: String;
	I, Code: Integer;
	Num: Boolean;
begin
	SetLength(Result, Length(AStr));
	Sp := PChar(AStr);
	Rp := PChar(Result);
	//Cp := Sp;
	try
		while Sp^ <> #0 do begin
			case Sp^ of
				'&': begin
							 //Cp := Sp;
							 Inc(Sp);
							 case Sp^ of
								 'a': if AnsiStrPos(Sp, 'amp;') = Sp then
											begin
												Inc(Sp, 3);
												Rp^ := '&';
											end;
								 'l',
								 'g': if (AnsiStrPos(Sp, 'lt;') = Sp) or (AnsiStrPos(Sp, 'gt;') = Sp) then
											begin
												Cp := Sp;
												Inc(Sp, 2);
												while (Sp^ <> ';') and (Sp^ <> #0) do
													Inc(Sp);
												if Cp^ = 'l' then
													Rp^ := '<'
												else
													Rp^ := '>';
											end;
								 'q': if AnsiStrPos(Sp, 'quot;') = Sp then
											begin
												Inc(Sp,4);
												Rp^ := '"';
											end;
								 '#': begin
												Tp := Sp;
												Inc(Tp);
												Num := IsNumeric(Copy(Tp, 1, 1));
												while (Sp^ <> ';') and (Sp^ <> #0) do begin
													if (Num) and (not IsNumeric(Copy(Sp, 1, 1))) then
														Break;
													Inc(Sp);
												end;
												SetString(S, Tp, Sp - Tp);
												Val(S, I, Code);
												Rp^ := Chr((I));
											end;
							 //	 else
									 //raise EConvertError.CreateFmt(sInvalidHTMLEncodedChar,
										 //[Cp^ + Sp^, Cp - PChar(AStr)])
							 end;
					 end
			else
				Rp^ := Sp^;
			end;
			Inc(Rp);
			Inc(Sp);
		end;
	except
//		on E:EConvertError do
//			raise EConvertError.CreateFmt(sInvalidHTMLEncodedChar,
//				[Cp^ + Sp^, Cp - PChar(AStr)])
	end;
	SetLength(Result, Rp - PChar(Result));
end;

{!
\brief HTML のアンカータグから URL を取得
\param s URL を取得する HTML
\return  取得した URL
}
function TGikoSys.GetHRefText(s: string): string;
var
	Index: Integer;
	Index2: Integer;
begin
	Result := '';
	s := Trim(s);
	if s = '' then
		Exit;

	Index := AnsiPos('href', LowerCase(s));
	if Index = 0 then
		Exit;
	s := Trim(Copy(s, Index + 4, Length(s)));
	s := Trim(Copy(s, 2, Length(s)));

	//始めの文字が'"'なら取り除く
	//if Copy(s, 1, 1) = '"' then begin
    if s[1]  = '"' then begin
		s := Trim(Copy(s, 2, Length(s)));
	end;

	Index := AnsiPos('"', s);
	if Index <> 0 then begin
		//'"'までURLとする
		s := Copy(s, 1, Index - 1);
	end else begin
		//'"'が無ければスペースか">"の早い方までをURLとする
		Index := AnsiPos(' ', s);
		Index2 := AnsiPos('>', s);
		if Index = 0 then
			Index := Index2;
		if Index > Index2 then
			Index := Index2;
		if Index <> 0 then
			s := Copy(s, 1, Index - 1)
		else
			//これ以上もう知らんぬ
			;
	end;
	Result := Trim(s);
end;

{!
\brief ホスト名が２ｃｈかどうかチェックする
\param Host チェックするホスト名
\return     2ちゃんねるのホスト名なら True
}
function TGikoSys.Is2chHost(Host: string): Boolean;
const
	HOST_NAME: array[0..2] of string = ('.5ch.net', '.2ch.net', '.bbspink.com');
var
	i: Integer;
//	Len: Integer;
begin
	Result := False;
	if RightStr( Host, 1 ) = '/' then
		Host := Copy( Host, 1, Length( Host ) - 1 );
	OutputDebugString(pchar(HOST_NAME[0]));
	for i := 0 to Length(HOST_NAME) - 1 do begin
//		Len := Length(HOST_NAME[i]);
		if (AnsiPos(HOST_NAME[i], Host) > 0) and
			(AnsiPos(HOST_NAME[i], Host) = (Length(Host) - Length(HOST_NAME[i]) + 1)) then begin
			Result := True;
			Exit;
		end;
	end;
end;

{!
\brief 2ちゃんねる形式の URL を分解
\param url      2ちゃんねる形式の URL
\param path     test/read.cgi などの中間パス(ParseURI から得る)
\param document index.html などのドキュメント名(ParseURI から得る)
\param BBSID    OUT:BBSID が返る(ex. giko)
\param BBSKey   OUT:スレッドキーが返る(ex. 10000000000)
\return 2ちゃんねるの URL として分解できたなら True
}
function TGikoSys.Parse2chURL(const url: string; const path: string; const document: string; var BBSID: string; var BBSKey: string): Boolean;
var
	Index: Integer;
	s: string;
	SList: TStringList;
begin
	BBSID := '';
	BBSKey := '';
	Result := False;

	Index := AnsiPos(READ_PATH, path);
	if Index <> 0 then begin
		s := Copy(path, Index + Length(READ_PATH), Length(path));
    end else begin
        Index := AnsiPos(HTML_READ_PATH, path);
        if Index <> 0 then begin
            s := Copy(path, Index + Length(HTML_READ_PATH), Length(path));
        end;
    end;
    if Index <> 0 then begin
		if (Length(s) > 0) and (s[1] = '/') then
			Delete(s, 1, 1);
		BBSID := GetTokenIndex(s, '/', 0);
		BBSKey := GetTokenIndex(s, '/', 1);
		if BBSKey = '' then
			BBSKey := Document;
		Result := (BBSID <> '') or (BBSKey <> '');
		Exit;
	end;
	Index := AnsiPos(KAKO_PATH, path);
	if Index <> 0 then begin
		s := Copy(path, 2, Length(path));
		BBSID := GetTokenIndex(s, '/', 0);
		if (BBSID = 'log') and (GetTokenIndex(s, '/', 2) = 'kako') then
			BBSID := GetTokenIndex(s, '/', 1);
		BBSKey := ChangeFileExt(Document, '');
		Result := (BBSID <> '') or (BBSKey <> '');
		Exit;
	end;
	Index := AnsiPos('read.cgi?', URL);
	if Index <> 0 then begin
		SList := TStringList.Create;
		try
			try
//				s := HTMLDecode(Document);
				ExtractHTTPFields(['?', '&'], [], PChar(URL), SList, False);
				BBSID := SList.Values['bbs'];
				BBSKey := SList.Values['key'];
				Result := (BBSID <> '') or (BBSKey <> '');
				Exit;
			except
				Exit;
			end;
		finally
			SList.Free;
		end;
	end;
end;

{!
\brief 2ch 形式の URL からレス番を取得
\param URL    2ちゃんねる形式の URL
\param stRes  OUT:開始レス番が返る
\param endRes OUT:終了レス番が返る

http://2ch.net/中略/32-50 \n
の場合 stRef = 32, endRes = 50 になる
}
procedure TGikoSys.GetPopupResNumber(URL : string; var stRes, endRes : Int64);
const
    START_NAME : array[0..1] of String = ('st=', 'start=');
    END_NAME : array[0..1] of String = ('to=', 'end=');
    RES_NAME : array[0..0] of String = ('res=');
var
	buf : String;
	convBuf : String;
	ps : Int64;
	pch : PChar;
    bufList : TStringList;
    i, j, idx : Integer;
begin
	URL := Trim(LowerCase(URL));
    for i := 0 to Length(START_NAME) -1 do begin
        idx := AnsiPos(START_NAME[i], URL);
        if (idx <> 0) then begin
            break;
        end;
        idx := AnsiPos(END_NAME[i], URL);
        if (idx <> 0) then begin
            break;
        end;

    end;

    if (idx <> 0) then begin
        idx := AnsiPos('?', URL);
        if (idx = 0) then begin
            idx := LastDelimiter('/', URL);
        end;
        stRes := 0;
        endRes := 0;
        bufList := TStringList.Create();
        try
            bufList.Delimiter := '&';
            bufList.DelimitedText := Copy(URL, idx + 1, Length(URL));
            for  i := 0 to bufList.Count - 1 do begin
                convBuf := '';
                // 開始レス番の検索
                if (stRes = 0) then begin
                    for j := 0 to Length(START_NAME) - 1 do begin
                        idx := AnsiPos(START_NAME[j], bufList[i]);
                        if (idx = 1) then begin
                            convBuf := Copy(bufList[i], idx + Length(START_NAME[j]), Length(bufList[i]));
                            stRes := StrToInt64Def( convBuf, 0 );
                            break;
                        end;
                    end;
                end;
                // 終了レス番の検索
                if (convBuf = '') and (endRes = 0) then begin
                    for j := 0 to Length(END_NAME) - 1 do begin
                        idx := AnsiPos(END_NAME[j], bufList[i]);
                        if (idx = 1) then begin
                            convBuf := Copy(bufList[i], idx + Length(END_NAME[j]), Length(bufList[i]));
                            endRes := StrToInt64Def( convBuf, 0 );
                            break;
                        end;
                    end;
                end;
                // レス番の検索
                if ((stRes = 0) and (endRes = 0) and (convBuf = '')) then begin
                  for j := 0 to Length(RES_NAME) - 1 do begin
                      idx := AnsiPos(RES_NAME[j], bufList[i]);
                      if (idx = 1) then begin
                          convBuf := Copy(bufList[i], idx + Length(RES_NAME[j]), Length(bufList[i]));
                          stRes := StrToInt64Def( convBuf, 0 );
                          endRes := stRes;
                          break;
                      end;
                  end;
                end;
            end;

            if (stRes <> 0) and (endRes = 0) then begin
    			endRes := stRes + MAX_POPUP_RES;
    		end else if (stRes = 0) and (endRes <> 0) then begin
                stRes := endRes - MAX_POPUP_RES;
    			if stRes < 1 then begin
	    			stRes := 1;
                end;
            end;
        finally
            bufList.clear;
            bufList.free;
        end;
    end else if ( AnsiPos('.html',URL) <> Length(URL) -4 ) and ( AnsiPos('.htm',URL) <> Length(URL) -3 ) then begin
		buf := Copy(URL, LastDelimiter('/',URL)+1,Length(URL)-LastDelimiter('/',URL)+1);
		if  Length(buf) > 0 then begin
			if AnsiPos('-', buf) = 1 then begin
				stRes := 0;
				Delete(buf,1,1);
				ps := 0;
				pch := PChar(buf);
				while  ( ps < Length(buf) )and ( pch[ps] >= '0' ) and ( pch[ps] <= '9' ) do Inc(ps);
                convBuf := Copy( buf, 1, ps );
                if convBuf <> '' then begin
                    endRes := StrToInt64Def(convBuf, 0);
                end;
				if endRes <> 0 then begin
					stRes := endRes - MAX_POPUP_RES;
					if stRes < 1 then
						stRes := 1;
				end;
			end else begin
				ps := 0;
				pch := PChar(buf);
				while  ( ps < Length(buf) )and ( pch[ps] >= '0' ) and ( pch[ps] <= '9' ) do Inc(ps);
				try
					convBuf := Copy( buf, 1, ps );
					if convBuf <> '' then begin
						stRes := StrToInt64(convBuf);
						Delete(buf,1,ps+1);
						ps := 0;
						pch := PChar(buf);
						while  ( ps < Length(buf) )and ( pch[ps] >= '0' ) and ( pch[ps] <= '9' ) do Inc(ps);
                        convBuf := Copy( buf, 1, ps );
                        if convBuf <> '' then begin
                            endRes := StrToInt64Def(convBuf, 0);
                        end;
					end else begin
						stRes := 0;
					end;
				except
					stRes := 0;
					endRes := 0;
				end;
			end;
		end;
	end;
end;

{!
\brief 2ちゃんねる形式の URL を分解
\param URL 2ちゃんねる形式の URL
\return    分解された要素
}
function TGikoSys.Parse2chURL2(URL: string): TPathRec;
var
	i: Integer;
	s: string;
//	buf : String;
//	convBuf : String;
	wk: string;
	wkMin: Integer;
	wkMax: Integer;
	wkInt: Integer;
	RStart: Integer;
	RLength: Integer;
//	ps : Integer;
//	pch : PChar;
	SList: TStringList;
begin
	URL := Trim(LowerCase(URL));
	Result.FBBS := '';
	Result.FKey := '';
	Result.FSt := 0;
	Result.FTo := 0;
	Result.FFirst := False;
	Result.FStBegin := False;
	Result.FToEnd := False;
	Result.FDone := False;
	Result.FNoParam := False;

	wkMin := 0;
	wkMax := 1;
	if URL[length(URL)] = '\' then
		URL := URL + 'n';
	//FAWKStr.RegExp := 'http://.+\.(2ch\.net|bbspink\.com)/';
	FAWKStr.RegExp := '(http|https)://.+\.(2ch\.net|5ch\.net|bbspink\.com)/';   // for 5ch
	if FAWKStr.Match(FAWKStr.ProcessEscSeq(URL), RStart, RLength) <> 0 then begin
		s := Copy(URL, RStart + RLength - 1, Length(URL));

		//標準書式
		//最後はl50, 10, 10-20, 10n, 10-20n, -10, 10-, 10n- など
		//http://xxx.2ch.net/test/read.cgi/bbsid/1000000000/
		FAWKStr.RegExp := '/test/read.(cgi|html)/.+/[0-9]+/?.*';
		if FAWKStr.Match(FAWKStr.ProcessEscSeq(s), RStart, RLength) > 0 then begin
			s := Copy(s, 15, Length(s));

			SList := TStringList.Create;
			try
				SList.Clear;
				FAWKStr.RegExp := '/';
				if FAWKStr.Split(FAWKStr.ProcessEscSeq(s), SList) >= 3 then begin
					Result.FBBS := SList[1];
					Result.FKey := SList[2];
					if SList.Count >= 4 then
						s := SList[3]
					else begin
						s := '';
						Result.FNoParam := true;
					end;
				end else
					Exit;

				SList.Clear;
				FAWKStr.LineSeparator := mcls_CRLF;
				FAWKStr.RegExp := '-';
				if FAWKStr.Split(FAWKStr.ProcessEscSeq(s), SList) = 0 then begin
					Result.FFirst := True;
				end else begin
					FAWKStr.RegExp := 'l[0-9]+';
					if FAWKStr.Match(FAWKStr.ProcessEscSeq(s), RStart, RLength) > 0 then begin
						Result.FFirst := True;
					end else begin
						for i := 0 to SList.Count - 1 do begin
							if Trim(SList[i]) = '' then begin
								if i = 0 then
									Result.FStBegin := True;
								if i = (SList.Count - 1) then
									Result.FToEnd := True;
							end else if IsNumeric(SList[i]) then begin
								wkInt := StrToInt(SList[i]);
								wkMax := Max(wkMax, wkInt);
								if wkMin = 0 then
									wkMin := wkInt
								else
									wkMin := Min(wkMin, wkInt);
							end else if Trim(SList[i]) = 'n' then begin
								Result.FFirst := True;
							end else begin
								FAWKStr.RegExp := '^n[0-9]+$|^[0-9]+n$';
								if FAWKStr.Match(FAWKStr.ProcessEscSeq(SList[i]), RStart, RLength) > 0 then begin
									if Copy(SList[i], 1, 1) = 'n' then
										wkInt := StrToInt(Copy(SList[i], 2, Length(SList[i])))
									else
										wkInt := StrToInt(Copy(SList[i], 1, Length(SList[i]) - 1));
									Result.FFirst := True;
									wkMax := Max(wkMax, wkInt);
									if wkMin = 1 then
										wkMin := wkInt
									else
										wkMin := Min(wkMin, wkInt);
								end;
							end;
						end;
						if Result.FStBegin and (not Result.FToEnd) then
							Result.FSt := wkMin
						else if (not Result.FStBegin) and Result.FToEnd then
							Result.FTo := wkMax
						else if (not Result.FStBegin) and (not Result.FToEnd) then begin
							Result.FSt := wkMin;
							Result.FTo := wkMax;
						end;
						//Result.FSt := wkMin;
						//Result.FTo := wkMax;
					end;
				end;
			finally
				SList.Free;
			end;
			Result.FDone := True;
			Exit;
		end;

		//新kako書式
		//http://server.2ch.net/ITA_NAME/kako/1000/10000/1000000000.html
		FAWKStr.RegExp := '/.+/kako/[0-9]+/[0-9]+/[0-9]+\.html';
		if FAWKStr.Match(FAWKStr.ProcessEscSeq(s), RStart, RLength) > 0 then begin
			SList := TStringList.Create;
			try
				SList.Clear;
				FAWKStr.RegExp := '/';
				if FAWKStr.Split(FAWKStr.ProcessEscSeq(s), SList) >= 6 then begin
					Result.FBBS := SList[1];
					Result.FKey := ChangeFileExt(SList[5], '');
					Result.FFirst := True;
				end else
					Exit;
			finally
				SList.Free;
			end;
			Result.FDone := True;
			Exit;
		end;

		//旧kako書式
		//http://server.2ch.net/ITA_NAME/kako/999/999999999.html
		FAWKStr.RegExp := '/.+/kako/[0-9]+/[0-9]+\.html';
		if FAWKStr.Match(FAWKStr.ProcessEscSeq(s), RStart, RLength) > 0 then begin
			SList := TStringList.Create;
			try
				SList.Clear;
				FAWKStr.RegExp := '/';
				if FAWKStr.Split(FAWKStr.ProcessEscSeq(s), SList) >= 5 then begin
					Result.FBBS := SList[1];
					Result.FKey := ChangeFileExt(SList[4], '');
					Result.FFirst := True;
				end else
					Exit;
			finally
				SList.Free;
			end;
			Result.FDone := True;
			Exit;
		end;

		//log及びlog2書式
		//http://server.2ch.net/log/ITA_NAME/kako/999/999999999.html
		//http://server.2ch.net/log2/ITA_NAME/kako/999/999999999.html
		FAWKStr.RegExp := '/log2?/.+/kako/[0-9]+/[0-9]+\.html';
		if FAWKStr.Match(FAWKStr.ProcessEscSeq(s), RStart, RLength) > 0 then begin
			SList := TStringList.Create;
			try
				SList.Clear;
				FAWKStr.RegExp := '/';
				if FAWKStr.Split(FAWKStr.ProcessEscSeq(s), SList) >= 6 then begin
					Result.FBBS := SList[2];
					Result.FKey := ChangeFileExt(SList[5], '');
					Result.FFirst := True;
				end else
					Exit;
			finally
				SList.Free;
			end;
			Result.FDone := True;
			Exit;
		end;


		//旧URL書式
		//http://server.2ch.net/test/read.cgi?bbs=ITA_NAME&key=1000000000&st=1&to=5&nofirst=true
		FAWKStr.RegExp := '/test/read\.cgi\?';
		if FAWKStr.Match(FAWKStr.ProcessEscSeq(s), RStart, RLength) > 0 then begin
			s := Copy(s, 16, Length(s));
			SList := TStringList.Create;
			try
				SList.Clear;
				FAWKStr.RegExp := '&';
				if FAWKStr.Split(FAWKStr.ProcessEscSeq(s), SList) >= 2 then begin
					Result.FFirst := True;
					for i := 0 to SList.Count - 1 do begin
						if Pos('bbs=', SList[i]) = 1 then begin
							Result.FBBS := Copy(SList[i], 5, Length(SList[i]));
						end else if Pos('key=', SList[i]) = 1 then begin
							Result.FKey := Copy(SList[i], 5, Length(SList[i]));
						end else if Pos('st=', SList[i]) = 1 then begin
							wk := Copy(SList[i], 4, Length(SList[i]));
							if IsNumeric(wk) then
								Result.FSt := StrToInt(wk)
							else if wk = '' then
								Result.FStBegin := True;
						end else if Pos('to=', SList[i]) = 1 then begin
							wk := Copy(SList[i], 4, Length(SList[i]));
							if IsNumeric(wk) then
								Result.FTo := StrToInt(wk)
							else if wk = '' then
								Result.FToEnd := True;
						end else if Pos('nofirst=', SList[i]) = 1 then begin
							Result.FFirst := False;
						end;
					end;
				end else
					Exit;
			finally
				SList.Free;
			end;

			if (Result.FBBS <> '') and (Result.FKey <> '') then begin
				Result.FDone := True;
			end;
			Exit;
		end;
	end;
end;

{!
\brief URI を分解
\param URL      分解する URI
\param Protocol OUT:プロトコルが返る(ex. http)
\param Host     OUT:ホストが返る(ex. hoge.com)
\param Path     OUT:中間パスが返る(ex. test/read.cgi)
\param Document OUT:ドキュメント名が返る(ex. index.html)
\param Port     OUT:ポートが返る(ex. 8080)
\param Bookmark OUT:ブックマーク(?)が返る
}
procedure TGikoSys.ParseURI(const URL : string; var Protocol, Host, Path, Document, Port, Bookmark: string);
var
	URI: TIdURI;
begin
	Protocol := '';
	Host := '';
	Path := '';
	Document := '';
	Port := '';
	Bookmark := '';
	URI := TIdURI.Create(URL);
	try
		Protocol := URI.Protocol;
		Host := URI.Host;
		Path := URI.Path;
		Document := URI.Document;
		Port := URI.Port;
		Bookmark := URI.Bookmark;
	finally
		URI.Free;
	end;
end;

{!
\brief ギコナビのバージョンを取得
\return バージョンの下 2 桁(dwFileVersionLS)
}
function TGikoSys.GetVersionBuild: Integer;
var
	FixedFileInfo: PVSFixedFileInfo;
	VersionHandle, VersionSize: DWORD;
	pVersionInfo: Pointer;
	ItemLen : UInt;
	AppFile: string;
begin
	Result := 0;
	AppFile := Application.ExeName;
	VersionSize := GetFileVersionInfoSize(pChar(AppFile), VersionHandle);
	if VersionSize = 0 then
		Exit;
	GetMem(pVersionInfo, VersionSize);
	try
		if GetFileVersionInfo(PChar(AppFile),VersionHandle,VersionSize, pVersionInfo) then
			if VerQueryValue(pVersionInfo, '\', Pointer(FixedFileInfo), ItemLen) then
				Result := LOWORD(FixedFileInfo^.dwFileVersionLS);
	finally
		FreeMem(pVersionInfo, VersionSize);
	end;
end;

{!
\brief スレッド URL の正規化
\param inURL 正規化するスレッド URL
\return      正規化されたスレッド URL

スレッド URL をギコナビの中で一意なものに正規化します。
一意な URL にする事で、URL からスレッドを導き出す作業を最適化します。\n
正規化の方針として、サイトが推奨するデフォルトの URL になるように心がけます。
(1-1000 のような負荷をかけるものにはしないこと)

例(正規化前):\n
http://中略/ \n
http://中略/20-100

(正規化後):\n
http://中略/l50
}
function	TGikoSys.GetBrowsableThreadURL(
	inURL : string
) : string;
var
	threadItem	: TThreadItem;
	boardPlugIn	: TBoardPlugIn;
    board		: TBoard;
	i						: Integer;
begin

	//===== プラグイン
	try
		for i := Length( BoardGroups ) - 1 downto 1 do begin
			if Assigned( Pointer( BoardGroups[i].BoardPlugIn.Module ) ) then begin
				if BoardGroups[i].BoardPlugIn.AcceptURL( inURL ) = atThread then begin
                    board := BBSsFindBoardFromURL( BoardGroups[i].BoardPlugIn.ExtractBoardURL(inURL) );
					if board <> nil then begin
						boardPlugIn := BoardGroups[i].BoardPlugIn;
						threadItem	:= TThreadItem.Create( boardPlugIn, board, inURL );
						Result			:= threadItem.URL;
						threadItem.Free;

					end;
					Exit;
				end;
			end;
		end;
	except
		// exception が発生した場合は内部処理に任せたいのでここでは何もしない
	end;

	if Length( Result ) = 0 then
		Result := GikoSys.Get2chBrowsableThreadURL( inURL );

end;

{!
\brief スレッド URL を板 URL に変換
\param inURL スレッド URL
\return      板 URL
}
function	TGikoSys.GetThreadURL2BoardURL(
	inURL : string
) : string;
var
	threadItem	: TThreadItem;
	boardPlugIn	: TBoardPlugIn;
    board		: TBoard;
	i						: Integer;
begin

	//===== プラグイン
	try
		for i := Length( BoardGroups ) - 1 downto 1 do begin
			if Assigned( Pointer( BoardGroups[i].BoardPlugIn.Module ) ) then begin
				if BoardGroups[i].BoardPlugIn.AcceptURL( inURL ) = atThread then begin
                    board		:= BBSsFindBoardFromURL(BoardGroups[i].BoardPlugIn.ExtractBoardURL(inURL));
					boardPlugIn := BoardGroups[i].BoardPlugIn;
					threadItem	:= TThreadItem.Create( boardPlugIn, board, inURL );
					Result			:= BoardGroups[i].BoardPlugIn.GetBoardURL( Longword( threadItem ) );
					threadItem.Free;

					Break;
				end;
			end;
		end;
	except
		// exception が発生した場合は内部処理に任せたいのでここでは何もしない
	end;

	if Length( Result ) = 0 then
		Result := GikoSys.Get2chThreadURL2BoardURL( inURL );

end;

{!
\brief 2ch用:スレッド URL を板 URL に変換
\param inURL スレッド URL
\return      板 URL
\see TGikoSys.GetThreadURL2BoardURL
}
function	TGikoSys.Get2chThreadURL2BoardURL(
	inURL : string
) : string;
var
	Protocol, Host, Path, Document, Port, Bookmark : string;
	BBSID, BBSKey : string;
	foundPos			: Integer;
begin

	ParseURI( inURL, Protocol, Host, Path, Document, Port, Bookmark );
	Parse2chURL( inURL, Path, Document, BBSID, BBSKey );

	foundPos := Pos( '/test/read.cgi', inURL );
	if {(Is2chHost(Host)) and} (foundPos > 0) then
		Result := Copy( inURL, 1, foundPos ) + BBSID + '/'
	else
		Result := Protocol + '://' + Host + '/' + BBSID + '/';

end;

{!
\brief 2ch用:スレッド URL の正規化
\param inURL 正規化するスレッド URL
\return      正規化されたスレッド URL
\see TGikoSys.GetBrowsableThreadURL
}
function	TGikoSys.Get2chBrowsableThreadURL(
	inURL			: string
) : string;
var
	Protocol, Host, Path, Document, Port, Bookmark : string;
	BBSID, BBSKey : string;
	foundPos	: Integer;
begin

//	if Pos( KAKO_PATH, inURL ) > 0 then begin
//		Result := inURL;
//	end else begin
		ParseURI( inURL, Protocol, Host, Path, Document, Port, Bookmark );
		Parse2chURL( inURL, Path, Document, BBSID, BBSKey );
		foundPos := Pos( '/test/read.cgi', inURL ) - 1;

		if Is2chHost( Host ) then begin
			Result := Protocol + '://' + Host +
				READ_PATH + BBSID + '/' + BBSKey + '/l50';
		end else begin
			if foundPos > 0 then
				Result := Copy( inURL, 1, foundPos ) +
					OLD_READ_PATH + 'bbs=' + BBSID + '&key=' + BBSKey + '&ls=50'
			else
				Result := Protocol + '://' + Host +
					OLD_READ_PATH + 'bbs=' + BBSID + '&key=' + BBSKey + '&ls=50';
		end;
//	end;

end;

{!
\brief 2ch用:板 URL からスレッド URL を作成
\param inBoard 板 URL
\param inKey   スレッドキー(ex. 1000000000)
\return        スレッド URL
}
function	TGikoSys.Get2chBoard2ThreadURL(
	inBoard	: TBoard;
	inKey	 	: string
) : string;
var
	server	: string;
begin

	server := UrlToServer( inBoard.URL );
	//if Is2chHost( server ) then
	if inBoard.Is2ch then
		Result := server + 'test/read.cgi/' + inBoard.BBSID + '/' + inKey + '/l50'
	else
		Result := server + 'test/read.cgi?bbs=' + inBoard.BBSID + '&key=' + inKey + '&ls=50';

end;

{!
\brief ボードファイル列挙

列挙された BBS(ボード) は BBSs に入ります。
}
procedure TGikoSys.ListBoardFile;
var
	boardFileList	: TStringList;
	i, l			: Integer;
    sCategory       : TCategory;
begin
	// BBS の開放
	try
	  for i := 0 to Length( BBSs ) - 1 do
		BBSs[ i ].Free;
	except
	end;
	SetLength( BBSs, 0 );

	l := 0;
	// 板リストの列挙
	if FileExists( GikoSys.GetBoardFileName ) then begin
	  SetLength( BBSs, l + 1 );
	  BBSs[ l ]				:= TBBS.Create( GikoSys.GetBoardFileName );
	  BBSs[ l ].Title	:= '２ちゃんねる';
		  Inc( l );
	end;

	if FileExists( GikoSys.GetCustomBoardFileName ) then begin
	  SetLength( BBSs, l + 1 );
	  BBSs[ l ]				:= TBBS.Create( GikoSys.GetCustomBoardFileName );
	  BBSs[ l ].Title	:= 'その他';
		  Inc( l );
	end;

	// Board フォルダ
	if DirectoryExists( GikoSys.Setting.GetBoardDir ) then begin
	  BoardFileList := TStringList.Create;
	  try
        BoardFileList.BeginUpdate;
		GikoSys.GetFileList( GikoSys.Setting.GetBoardDir, '*.txt', BoardFileList, True, True );
        BoardFileList.EndUpdate;
        SetLength( BBSs, l + BoardFileList.Count );
		for i := BoardFileList.Count - 1 downto 0 do begin
		  BBSs[ l ]				:= TBBS.Create( BoardFileList[ i ] );
		  BBSs[ l ].Title	:= ChangeFileExt( ExtractFileName( BoardFileList[ i ] ), '' );
		  Inc( l );
		end;
	  finally
		BoardFileList.Free;
	  end;
	end;

    // 特殊用途BBS生成
    // 既に存在する場合は削除する
    DestorySpecialBBS(BoardGroup.SpecialBBS);
    SpecialBBS := TBBS.Create('');
    SpecialBBS.Title := '特殊用途(非表示)';
    sCategory := TCategory.Create;
    sCategory.No := 1;
    sCategory.Title := '特殊用途(非表示)';
    SpecialBBS.Add(sCategory);
    BoardGroup.SpecialBoard := TSpecialBoard.Create(nil, 'http://localhost/gikonavi/special/index.html');
    BoardGroup.SpecialBoard.Title := 'タブ一覧';
    BoardGroup.SpecialBoard.IsThreadDatRead := True;
    sCategory.Add(BoardGroup.SpecialBoard);
end;

{!
\brief ボードファイル読み込み
\param bbs ボードファイルを読み込む BBS
}
procedure TGikoSys.ReadBoardFile( bbs : TBBS );
var
//	idx						: Integer;
	ini						: TMemIniFile;
	p : Integer;
	boardFile			: TStringList;
	CategoryList	: TStringList;
	BoardList			: TStringList;
	Category			: TCategory;
	Board					: TBoard;
	inistr				: string;
	tmpstring			: string;
//	RoundItem			: TRoundItem;

	i, iBound			: Integer;
	j, jBound			: Integer;
	k, kBound			: Integer;
begin

	if not FileExists( bbs.FilePath ) then
		Exit;

	bbs.Clear;
	ini := TMemIniFile.Create('');
	boardFile := TStringList.Create;

	try
		boardFile.LoadFromFile( bbs.FilePath );

		ini.SetStrings( boardFile );
		CategoryList	:= TStringList.Create;
		BoardList			:= TStringList.Create;
		try
			ini.ReadSections( CategoryList );

			iBound := CategoryList.Count - 1;
			for i := 0 to iBound do begin
				ini.ReadSection( CategoryList[i], BoardList );
				Category				:= TCategory.Create;
				Category.No			:= i + 1;
				Category.Title	:= CategoryList[i];

				jBound := BoardList.Count - 1;
				for j := 0 to jBound do begin
					Board := nil;
					inistr := ini.ReadString(CategoryList[i], BoardList[j], '');
					//'http://'を含まない文字列の時は無視する
					//if (AnsiPos('http://', AnsiLowerCase(inistr)) = 0) then Continue;
					if ((AnsiPos('http://', AnsiLowerCase(inistr)) = 0) and
              (AnsiPos('https://', AnsiLowerCase(inistr)) = 0)) then Continue;  // for https
					//===== プラグイン
					try
						kBound := Length(BoardGroups) - 1;
						for k := 1 to kBound do begin  //0は、2ちゃん
							if Assigned( Pointer( BoardGroups[k].BoardPlugIn.Module ) ) then begin
								if BoardGroups[k].BoardPlugIn.AcceptURL( inistr ) = atBoard then begin
									if not BoardGroups[k].Find(inistr, p) then begin
										tmpstring := BoardGroups[k].BoardPlugIn.ExtractBoardURL( inistr );
										if AnsiCompareStr(tmpString, inistr) <> 0 then begin
											if not BoardGroups[k].Find(tmpstring, p) then begin
												try
													Board := TBoard.Create( BoardGroups[k].BoardPlugIn, tmpstring );
													BoardGroups[k].AddObject(tmpstring, Board);
													Category.Add(Board);
												except
													//ここに来るとしたらBoardの作成に失敗したときだからBoardをnilにする
													Board := nil;
												end;
											end else begin
												Board := TBoard(BoardGroups[k].Objects[p]);
												if Board.ParentCategory <> Category then
													Category.Add(Board);
											end;
										end else begin
											try
												Board := TBoard.Create( BoardGroups[k].BoardPlugIn, tmpstring );
												BoardGroups[k].AddObject(tmpstring, Board);
												Category.Add(Board);
											except
												//ここに来るとしたらBoardの作成に失敗したときだからBoardをnilにする
												Board := nil;
											end;
										end;
									end else begin
										Board := TBoard(BoardGroups[k].Objects[p]);
										if Board.ParentCategory <> Category then
											Category.Add(Board);
									end;
									Break;
								end;
							end;
						end;
					except
						// exception が発生した場合は内部処理に任せたいのでここでは何もしない
					end;
					try
						if (Board = nil) then begin
							if not BoardGroups[0].Find(inistr,p) then begin
								Board := TBoard.Create( nil, inistr );
								BoardGroups[0].AddObject(inistr, Board);
								Category.Add(Board);
							end else begin
								Board := TBoard(BoardGroups[0].Objects[p]);
								if Board.ParentCategory <> Category then
									Category.Add(Board);
							end;
						end;

						if (Board.Multiplicity = 0) then begin
							Board.BeginUpdate;
							Board.No := j + 1;
                            Board.Multiplicity := 1;
							Board.Title := BoardList[j];
							Board.RoundDate := ZERO_DATE;
							Board.LoadSettings;
							Board.EndUpdate;
						end else begin
							Board.No := j + 1;
							Board.Multiplicity := Board.Multiplicity + 1;
						end;
					except
					end;
				end;
				bbs.Add( Category );
			end;


		  //end;
		  bbs.IsBoardFileRead := True;
	  finally
		BoardList.Free;
		CategoryList.Free;
	  end;
  finally
	boardFile.Free;
	ini.Free;
  end;

end;

{!
\brief 名称が不明なカテゴリの生成
\return 生成されたカテゴリ
}
function	TGikoSys.GetUnknownCategory : TCategory;
const
	UNKNOWN_CATEGORY = '(名称不明)';
begin

	if Length( BBSs ) < 2 then begin
		Result := nil;
		Exit;
	end;

	Result := BBSs[ 1 ].FindCategoryFromTitle( UNKNOWN_CATEGORY );
	if Result = nil then begin
		Result				:= TCategory.Create;
		Result.Title	:= UNKNOWN_CATEGORY;
		BBSs[ 1 ].Add( Result );
	end;

end;

{!
\brief 名称が不明な BBS の生成
\return 生成された BBS
}
function	TGikoSys.GetUnknownBoard( inPlugIn : TBoardPlugIn; inURL : string ) : TBoard;
var
	category : TCategory;
const
	UNKNOWN_BOARD = '(名称不明)';
begin

	category := GetUnknownCategory;
	if category = nil then begin
		Result := nil;
	end else begin
		Result := category.FindBoardFromTitle( UNKNOWN_BOARD );
		if Result = nil then begin
			Result				:= TBoard.Create( inPlugIn, inURL );
			Result.Title	:= UNKNOWN_BOARD;
			category.Add( Result );
		end;
	end;

end;

//! Samba.ini
function TGikoSys.GetSambaFileName : string;
begin
	Result := Setting.GetSambaFileName;
end;
{!
\brief 列挙されたレス番号へのアンカー用HTML作成
\param Numbers    列挙されたレス番号
\param ThreadItem 列挙するスレッド
\param limited    列挙する数を制限するなら1以上
\return           列挙されたレスアンカー
}
function TGikoSys.CreateResAnchor(
    var Numbers: TStringList; ThreadItem: TThreadItem;
    limited: Integer):string;
var
	i: integer;
    Res: TResRec;
    ResLink : TResLinkRec;
begin
    // body以外は使用しないので初期化しない
    Res.FBody := '';
    Res.FType := glt2chNew;

	Result := '';
	if (Numbers <> nil) and (Numbers.Count > 0) then begin
        if (limited > 0) and (Numbers.Count > limited) then begin
            for i := Numbers.Count - limited to Numbers.Count - 1 do begin
                Res.FBody := Res.FBody + '&gt;' + Numbers[i] + ' ';
            end;
        end else begin
            for i := 0 to Numbers.Count - 1 do begin
                Res.FBody := Res.FBody + '&gt;' + Numbers[i] + ' ';
            end;
        end;
        ResLink.FBbs := ThreadItem.ParentBoard.BBSID;
        ResLink.FKey := ChangeFileExt(ThreadItem.FileName, '');
        HTMLCreater.ConvRes(@Res, @ResLink, false);
        Result := Res.FBody;
    end;
end;

{!
\brief 同じ投稿 ID を持つレスを列挙
\param AID        個人を特定する投稿 ID
\param ThreadItem 列挙するスレッド
\param body       OUT:列挙されたレス番号が返る
}
procedure TGikoSys.GetSameIDRes(const AID : string; ThreadItem: TThreadItem;var body: TStringList);
var
	i: integer;
	ReadList: TStringList;
	Res: TResRec;
	boardPlugIn : TBoardPlugIn;

    procedure CheckSameID(const AID:String; const Target: String; no: Integer);
    var
        pos: Integer;
    begin
        pos := AnsiPos('id:', LowerCase(Target));
        if (pos > 0) then begin
            if(AnsiPos(AID, Copy(Target, pos-1, Length(Target))) > 0) then begin
                body.Add(IntToStr(no));
            end;
        end else begin
            if(AnsiPos(AID, Target) > 0) then begin
                body.Add(IntToStr(no));
            end;
        end;
    end;
begin
	if (not IsNoValidID(AID)) and
    	(ThreadItem <> nil) and (ThreadItem.IsLogFile) then begin
		//if ThreadItem.IsBoardPlugInAvailable then begin
        if ThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
			//===== プラグインによる表示
			//boardPlugIn		:= ThreadItem.BoardPlugIn;
            boardPlugIn		:= ThreadItem.ParentBoard.BoardPlugIn;

			for i := 0 to threadItem.Count - 1 do begin
				// レス
				THTMLCreate.DivideStrLine(boardPlugIn.GetDat(DWORD( threadItem ), i + 1), @Res);
                CheckSameID(AID, Res.FDateTime, i+1);
			end;
		end else begin
			ReadList := TStringList.Create;
			try
				ReadList.LoadFromFile(ThreadItem.GetThreadFileName);
				for i := 0 to ReadList.Count - 1 do begin
					THTMLCreate.DivideStrLine(ReadList[i], @Res);
                    CheckSameID(AID, Res.FDateTime, i+1);
				end;
			finally
				ReadList.Free;
			end;
		end;
	end;
end;

{!
\brief 同じ投稿 ID を持つレスを列挙
\param AIDNum     個人を特定する投稿 ID
\param ThreadItem 列挙するスレッド
\param body       OUT:列挙されたレス番号が返る
}
procedure TGikoSys.GetSameIDRes(AIDNum : Integer; ThreadItem: TThreadItem;var body: TStringList);
var
	AID : String;
begin
    AID := GetResID(AIDNum, ThreadItem);
    if not IsNoValidID(AID) then begin
	    GetSameIDRes(AID, ThreadItem, body);
	end;
end;
{!
\brief 投稿 ID 取得
\param AIDNum     投稿 レス番号
\param ThreadItem 投稿スレッド
\param body       OUT:投稿ID
}
function TGikoSys.GetResID(AIDNum: Integer; ThreadItem: TThreadItem): String;
var
	Res: TResRec;
	boardPlugIn : TBoardPlugIn;
begin
    Result := '';
	if (ThreadItem <> nil) and (ThreadItem.IsLogFile)
		and (AIDNum > 0) and (AIDNum <= ThreadItem.Count) then begin
		//if ThreadItem.IsBoardPlugInAvailable then begin
        if ThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
			//===== プラグインによる表示
			//boardPlugIn		:= ThreadItem.BoardPlugIn;
            boardPlugIn		:= ThreadItem.ParentBoard.BoardPlugIn;
			THTMLCreate.DivideStrLine(boardPlugIn.GetDat(DWORD( threadItem ), AIDNum), @Res);
		end else begin
			THTMLCreate.DivideStrLine( ReadThreadFile(ThreadItem.GetThreadFileName, AIDNum), @Res);
		end;
		Result := ExtructResID(Res.FDateTime);
	end;
end;
{!
\brief レスの時刻部からIDを抽出する
\param ADateStr 時刻部の文字列
\return     ID(IDとみなせる部分がないときは空文字列)
}
function TGikoSys.ExtructResID(ADateStr: String): String;
var
    stlist : TStringList;
begin
    Result := '';
    if AnsiPos('id', AnsiLowerCase(ADateStr)) > 0 then begin
        Result := Copy(ADateStr, AnsiPos('id', AnsiLowerCase(ADateStr)), Length(ADateStr));
        if AnsiPos(' ', Result) > 0 then begin
            Result := Copy(Result, 1, AnsiPos(' ', Result) - 1);
        end;
        Result := ' ' + Result;
    end else begin
        stlist := TStringList.Create;
        try
            stList.Delimiter := ' ';
            stList.DelimitedText := ADateStr;
            // 日付 時刻 ID 他　と固定で考える
            if (stList.Count >= 3) then begin
                if Length(stList[3 - 1]) >= 7 then begin
                    Result := stList[3 - 1];
                end;
            end;
        finally
            stList.Free;
        end;
    end;
end;

{!
\brief スパム:語数をカウント
\param text      元になる文章
\param wordCount OUT:カウントされた単語の一覧が返る
}
procedure TGikoSys.SpamCountWord( const text : string; wordCount : TWordCount );
begin

	if Setting.SpamFilterAlgorithm = gsfaNone then Exit;
	Bayesian.CountWord( text, wordCount );

end;

{!
\brief スパム:学習結果を放棄
\param wordCount 放棄する単語の一覧
\param isSpam    wordCount がスパムとして学習されていたなら True
\warning	学習済みの文章かどうかは確認出来ません。\n
					Learn していない文章や isSpam を間違えて指定すると
					データベースが破損します。\n
					学習済みかどうかは独自に管理してください。

全ての学習結果をクリアするわけではありません。\n
wordCount を得た文章の学習結果のみクリアします。

主にスパムとハムを切り替えるために Forget -> Learn の順で使用します。
}
procedure TGikoSys.SpamForget( wordCount : TWordCount; isSpam : Boolean );
begin

	if Setting.SpamFilterAlgorithm = gsfaNone then Exit;
	Bayesian.Forget( wordCount, isSpam );

end;

{!
\brief スパム:学習
\param wordCount 学習する単語の一覧
\param isSpam    スパムとして学習するなら True
}
procedure TGikoSys.SpamLearn( wordCount : TWordCount; isSpam : Boolean );
begin

	if Setting.SpamFilterAlgorithm = gsfaNone then Exit;
	Bayesian.Learn( wordCount, isSpam );

end;

{!
\brief スパム:文章を解析し、スパム度数を得る
\param text      元になる文章
\param wordCount OUT:カウントされた単語の一覧が返る(SpamCountWord と同等)
\return          0～1 のスパム度数
}
function TGikoSys.SpamParse( const text : string; wordCount : TWordCount ) : Extended;
begin

	case Setting.SpamFilterAlgorithm of
	gsfaNone:								Result := 0;
	gsfaPaulGraham:					Result := Bayesian.Parse( text, wordCount, gbaPaulGraham );
	gsfaGaryRobinson:				Result := Bayesian.Parse( text, wordCount, gbaGaryRobinson );
	gsfaGaryRobinsonFisher:	Result := Bayesian.Parse( text, wordCount, gbaGaryRobinsonFisher );
	else										Result := 0;
	end;

end;

{!
\brief ユーザ設定の CSS を生成
\return 生成された CSS

[ツール]メニュー-[オプション]-[CSS とスキン]タブの
[フォントを指定], [背景色を指定] に沿った CSS を生成します。
}
function TGikoSys.SetUserOptionalStyle(): string;
begin
		Result := '';
	if Length( GikoSys.Setting.BrowserFontName ) > 0 then
		Result := 'font-family:"' + GikoSys.Setting.BrowserFontName + '";';
	if GikoSys.Setting.BrowserFontSize <> 0 then
		Result := Result + 'font-size:' + IntToStr( GikoSys.Setting.BrowserFontSize ) + 'pt;';
	if GikoSys.Setting.BrowserFontColor <> -1 then
		Result := Result + 'color:#' + IntToHex( GikoSys.Setting.BrowserFontColor, 6 ) + ';';
	if GikoSys.Setting.BrowserBackColor <> -1 then
		Result := Result + 'background-color:#' + IntToHex( GikoSys.Setting.BrowserBackColor, 6 ) + ';';
	case GikoSys.Setting.BrowserFontBold of
		-1: Result := Result + 'font-weight:normal;';
		1:  Result := Result + 'font-weight:bold;';
	end;
	case GikoSys.Setting.BrowserFontItalic of
		-1: Result := Result + 'font-style:normal;';
		1:  Result := Result + 'font-style:italic;';
	end;
end;

{!
\brief Be プロファイルへのアンカータグを生成
\param AID  対象となる日付ID文字列
\param ANum レス番
\param AURL そのスレッドのURL
\return     生成されたアンカータグ
}
function TGikoSys.AddBeProfileLink(AID : string; ANum: Integer):string ;
var
	p : integer;
	BNum, BMark : string;
begin
	p := AnsiPos('BE:', AnsiUpperCase(AID));
	if p > 0 then begin
		BNum := Copy(AID, p, Length(AID));
		AID := Copy(AID, 1, p - 1);
		p := AnsiPos('-', BNum);
		if p > 0 then begin
			BMark := '?' + Trim(Copy(BNum, p + 1, Length(BNum)));
			BNum := Copy(BNum, 1, p - 1);
		end;
		BNum := Trim(BNum);
		Result := AID + ' <a href="'  + BNum + '/' + IntToStr(ANum)
			+ '" target=_blank>' + BMark + '</a>';
	end else
		Result := AID;
end;

{!
\brief バージョン情報を取得
\param KeyWord 取得する項目
\return        バージョン文字列
}
function TGikoSys.GetVersionInfo(KeyWord: TVerResourceKey): string;
const
	Translation = '\VarFileInfo\Translation';
	FileInfo = '\StringFileInfo\%0.4s%0.4s\';
var
	BufSize, HWnd: DWORD;
	VerInfoBuf: Pointer;
	VerData: Pointer;
	VerDataLen: Longword;
	PathLocale: String;
begin
	// 必要なバッファのサイズを取得
	BufSize := GetFileVersionInfoSize(PChar(Application.ExeName), HWnd);
	if BufSize <> 0 then begin
		// メモリを確保
		GetMem(VerInfoBuf, BufSize);
		try
			GetFileVersionInfo(PChar(Application.ExeName), 0, BufSize, VerInfoBuf);
			// 変数情報ブロック内の変換テーブルを指定
			VerQueryValue(VerInfoBuf, PChar(Translation), VerData, VerDataLen);

			if not (VerDataLen > 0) then
				raise Exception.Create('情報の取得に失敗しました');

			// 8桁の１６進数に変換
			// →'\StringFileInfo\027382\FileDescription'
			PathLocale := Format(FileInfo + KeyWordStr[KeyWord],
			[IntToHex(Integer(VerData^) and $FFFF, 4),
			IntToHex((Integer(VerData^) shr 16) and $FFFF, 4)]);
			VerQueryValue(VerInfoBuf, PChar(PathLocale), VerData, VerDataLen);

			if VerDataLen > 0 then begin
				// VerDataはゼロで終わる文字列ではないことに注意
				result := '';
				SetLength(result, VerDataLen);
				StrLCopy(PChar(result), VerData, VerDataLen);
			end;
		finally
			// 解放
			FreeMem(VerInfoBuf);
		end;
	end;
end;

{!
\brief Load されているプラグインのバージョンを列挙
\return 1行1plugin
}
function TGikoSys.GetPluginsInfo(): String;
var
	i : Integer;
	major, minor, revision : Cardinal;
	agent, release : String;
begin
	//結果をクリアしておく
	Result := '';

	//BoardGroups経由でPluginにアクセスする
	for  i := 0 to Length(BoardGroups) - 1 do begin
		//BoardGroupsの中には、Pluginを持っていないの（2ちゃん）が
		//いるのでそれを除く
		if BoardGroups[i].BoardPlugIn <> nil then begin
			BoardGroups[i].BoardPlugIn.VersionInfo(agent, major, minor, release, revision);


			//"Pluginの名前(major.minor.revision)"
			Result := Result +
				Format('%s(%d.%d.%d)', [agent, major, minor, revision]) + #13#10;
		end;
	end;
end;


//! IEのバージョンを取得する
function TGikoSys.GetIEVersion: string;
var
	R: TRegistry;
begin
	R := TRegistry.Create;
	try
		//読み取り専用にしないと、制限USERとかの場合、開けないみたい
		R.Access := KEY_EXECUTE;
		R.RootKey := HKEY_LOCAL_MACHINE;
		R.OpenKey('Software\Microsoft\Internet Explorer', False);
		try
			Result := R.ReadString('version');
		except
			Result := 'バージョンの取得に失敗しました。';
		end;
		R.CloseKey;
	finally
		R.Free;
	end;
end;
//! mainフォームのショートカットキーのIniファイル名
function TGikoSys.GetMainKeyFileName : String;
begin
	Result := Setting.GetMainKeyFileName;
end;
//! EditorフォームのショートカットキーのIniファイル名
function TGikoSys.GetEditorKeyFileName: String;
begin
	Result := Setting.GetEditorKeyFileName;
end;
//! 入力アシストの設定ファイル名
function TGikoSys.GetInputAssistFileName: String;
begin
	Result := Setting.GetInputAssistFileName;
end;
//! ギコナビのメッセージを設定する
procedure TGikoSys.SetGikoMessage;
begin
	if FGikoMessage = nil then begin
		FGikoMessage := TGikoMessage.Create;
	end else begin
		FGikoMessage.Clear;
	end;

	if (Setting.GengoSupport) then begin
		try
			if (FileExists(Setting.GetLanguageFileName)) then begin
				FGikoMessage.LoadFromFile(Setting.GetLanguageFileName);
			end;
		except
			FGikoMessage.Clear;
		end;
	end;
end;
//! ギコナビのメッセージを取得する
function TGikoSys.GetGikoMessage(MesType: TGikoMessageListType): String;
begin
    Result := '';
	if FGikoMessage <> nil then begin
		Result := FGikoMessage.GetMessage(MesType);
	end;
end;

//Tue, 17 Dec 2002 12:18:07 GMT → TDateTimeへ
//MonaUtilsから移動
function  TGikoSys.DateStrToDateTime(const DateStr: string): TDateTime;
	function  StrMonthToMonth(const s: string): integer;
	const
		m: array[1..12] of string = ('Jan','Feb','Mar','Apr','May','Jun', 'Jul','Aug','Sep','Oct','Nov','Dec');
	var
		i: integer;
	begin
		Result  :=  -1;
		for i :=  Low(m)  to  High(m) do  begin
			if  (SameText(s, m[i]))  then  begin
				Result  :=  i;
				Break;
			end;
		end;
	end;
var
	wDay, wMonth, wYear: word;
	wHour, wMinute, wSecond: word;
	sTime: string;
	d: TDateTime;
begin
	wDay    :=  StrToIntDef(ChooseString(DateStr, ' ', 1), 0);
	wMonth  :=  StrMonthToMonth(ChooseString(DateStr, ' ', 2));
	wYear   :=  StrToIntDef(ChooseString(DateStr, ' ', 3), 0);
	sTime   :=  ChooseString(DateStr, ' ', 4);
	wHour   :=  StrToIntDef(ChooseString(sTime, ':', 0), 0);
	wMinute :=  StrToIntDef(ChooseString(sTime, ':', 1), 0);
	wSecond :=  StrToIntDef(ChooseString(sTime, ':', 2), 0);
	d :=  EncodeDateTime(wYear, wMonth, wDay, wHour, wMinute, wSecond, 0);
	Result  :=  d;
end;
//MonaUtilsから移動
//! あるセパレータで区切られた文字列からｎ番目の文字列を取り出す
function TGikoSys.ChooseString(const Text, Separator: string; Index: integer): string;
var
	S : string;
	i, p : integer;
begin
	S :=  Text;
	for i :=  0 to  Index - 1 do  begin
		if  (AnsiPos(Separator, S) = 0) then  S :=  ''
		else  S :=  Copy(S, AnsiPos(Separator, S) + Length(Separator), Length(S));
	end;
	p :=  AnsiPos(Separator, S);
	if  (p > 0) then  Result  :=  Copy(S, 1, p - 1) else Result :=  S;
end;
//! 一時ファイルからの復旧
procedure TGikoSys.RestoreThreadData(Board : TBoard);
const
    SECTION = 'Setting';
var
    TmpFileList : TStringList;
    i : Integer;
    ini : TMemIniFile;
    ThreadItem : TThreadItem;
    Boardpath, tmpStr : string;
begin
    Boardpath := ExtractFilePath(Board.GetFolderIndexFileName);

	TmpFileList := TStringList.Create;
	TmpFileList.Sorted := True;
	TmpFileList.BeginUpdate;
    try
    	//前回異常終了時用Tmpファイルリスト
	    GetFileList(Boardpath, '*.tmp', TmpFileList, False);
	    TmpFileList.EndUpdate;
		//前回異常終了時チェック
		for i := TmpFileList.Count - 1 downto 0 do begin
			ThreadItem := Board.FindThreadFromFileName(ChangeFileExt(TmpFileList[i], '.dat'));
			if ThreadItem <> nil then begin
				ini := TMemIniFile.Create(Boardpath + TmpFileList[i]);
				try
					tmpStr := ini.ReadString(SECTION, 'RoundDate', DateTimeToStr(ZERO_DATE));
					ThreadItem.RoundDate := ConvertDateTimeString(tmpStr);

					tmpStr := ini.ReadString(SECTION, 'LastModified', DateTimeToStr(ZERO_DATE));
					ThreadItem.LastModified := ConvertDateTimeString(tmpStr);
					ThreadItem.Count := ini.ReadInteger(SECTION, 'Count', 0);
					ThreadItem.NewReceive := ini.ReadInteger(SECTION, 'NewReceive', 0);

					ThreadItem.Size := ini.ReadInteger(SECTION, 'Size', 0);
                    ThreadItem.IsLogFile := FileExists(ThreadItem.GetThreadFileName);
					if(ThreadItem.Size = 0) and (ThreadItem.IsLogFile) then begin
						try
							ThreadItem.Size := GetFileSize(ThreadItem.GetThreadFileName) - ThreadItem.Count;
						except
						end;
					end;

                    //巡回の設定はRoundDataの方がやるから勝手に設定してはダメ！　by もじゅ
					//ThreadItem.Round := ini.ReadBool('Setting', 'Round', False);
					//ThreadItem.RoundName := ini.ReadString('Setting', 'RoundName', ThreadItem.RoundName);
					ThreadItem.UnRead := False;//ini.ReadBool('Setting', 'UnRead', False);
					ThreadItem.ScrollTop := ini.ReadInteger(SECTION, 'ScrollTop', 0);
					ThreadItem.AllResCount := ini.ReadInteger(SECTION, 'AllResCount', ThreadItem.Count);
					ThreadItem.NewResCount := ini.ReadInteger(SECTION, 'NewResCount', 0);
					ThreadItem.AgeSage := TGikoAgeSage(ini.ReadInteger(SECTION, 'AgeSage', Ord(gasNone)));
				finally
					ini.Free;
				end;
				DeleteFile(Boardpath + TmpFileList[i]);
			end;
		end;
    finally
        TmpFileList.Clear;
        TmpFileList.Free;
    end;
end;
{
\brief User32.dllが利用できるか
\return Boolean 利用できる場合はTrue
}
function TGikoSys.CanUser32DLL: Boolean;
var
    hUser32 : HINST;
begin
    Result := False;
	hUser32 := 0;
	try
		try
			hUser32 := LoadLibrary('User32.dll');
			if hUser32 <> 0 then begin
				Result := True;
            end;
		except
        	Result := false;
		end;
	finally
		FreeLibrary(hUser32);
	end;
end;
{
\brief  OE引用符取得
\return OEの引用符（設定されていない場合は'>')
}
function TGikoSys.GetOEIndentChar : string;
var
	regKey			: TRegistry;
	Identities	: string;
	IndentChar	: DWORD;
const
	DEFAULT_CHAR	= '> ';
	OE_MAIL_PATH	= '\Software\Microsoft\Outlook Express\5.0\Mail';
	INDENT_CHAR		= 'Indent Char';
begin

	Result	:= DEFAULT_CHAR;
	regKey	:= TRegistry.Create;
	try
		try
			regKey.RootKey	:= HKEY_CURRENT_USER;
			if not regKey.OpenKey( 'Identities', False ) then
				Exit;
			Identities			:= regKey.ReadString( 'Default User ID' );
			if Identities = '' then
				Exit;
			if not regKey.OpenKey( Identities + OE_MAIL_PATH, False ) then
				Exit;
			IndentChar := regKey.ReadInteger( INDENT_CHAR );
			Result := Char( IndentChar ) + ' ';
		except
		end;
	finally
		regKey.Free;
	end;

end;
//! 置換設定ファイル取得
function TGikoSys.GetReplaceFileName: String;
begin
    Result := Setting.GetReplaceFileName;
end;
//! プレビュー拡張の設定ファイル取得
function TGikoSys.GetExtpreviewFileName: String;
begin
    Result := Setting.GetExtprevieFileName;
end;

//! ファイル名からのスレッド作成日の取得
function TGikoSys.GetCreateDateFromName(FileName: String): TDateTime;
var
    tmp : String;
    unixtime: Int64;  
begin
    // ログファイルの拡張子をはずしたものがスレ作成日時
    tmp := ChangeFileExt(FileName, '');
    if AnsiPos('_', tmp) <> 0 then
        if AnsiPos('_', tmp) > 9 then
            tmp := Copy(tmp, 1, AnsiPos('_', tmp)-1)
        else
            Delete(tmp, AnsiPos('_', tmp), 1);

    if ( Length(tmp) = 9) and ( tmp[1] = '0' ) then
        Insert('1', tmp, 1);

    unixtime := StrToInt64Def(tmp, ZERO_DATE);
    Result := UnixToDateTime(unixtime) + OffsetFromUTC;
end;

procedure TGikoSys.ShowRefCount(msg: String; unk: IUnknown);
{$IFDEF DEBUG}
var
    count : integer;
{$ENDIF}
begin
    if not Assigned(unk) then
        Exit;

{$IFDEF DEBUG}
    try
        unk._AddRef;
        count := unk._Release;

		Writeln(msg + ' RefCount=' + IntToStr(count));
    except
		Writeln(msg + ' RefCount=exception!!');
	end;
{$ENDIF}
end;
function TGikoSys.GetBoukenCookie(AURL: String): String;
var
	Protocol, Host, Path, Document, Port,Bookmark : String;
begin
    Result := '';
    GikoSys.ParseURI(AURL, Protocol, Host, Path, Document, Port,Bookmark);
    if ( Length(Host) > 0 ) then begin
        Result := Setting.GetBoukenCookie(Host);
    end;
end;
procedure TGikoSys.SetBoukenCookie(ACookieValue, ADomain: String);
begin
    if ( Length(ADomain) > 0 ) then begin
        Setting.SetBoukenCookie(ACookieValue, ADomain);
    end;
end;
//! 冒険の書Domain一覧取得
procedure TGikoSys.GetBoukenDomain(var ADomain: TStringList);
var
    i : Integer;
begin
    ADomain.Clear;
    for i := 0 to Setting.BoukenCookieList.Count - 1 do begin
        ADomain.Add( Setting.BoukenCookieList.Names[i] );
    end;
end;
//! 冒険の書Cookie削除
procedure TGikoSys.DelBoukenCookie(ADomain: String);
var
    i : Integer;
begin
    for i := 0 to Setting.BoukenCookieList.Count - 1 do begin
        if ( Setting.BoukenCookieList.Names[i] = ADomain ) then begin
            Setting.BoukenCookieList.Delete(i);
            Break;
        end;
    end;
end;
function TGikoSys.GetBouken(AURL: String; var Domain: String): String;
var
	Protocol, Host, Path, Document, Port,Bookmark : String;
    Cookie : String;
begin
    Domain := '';
    Cookie := '';
    GikoSys.ParseURI(AURL, Protocol, Host, Path, Document, Port,Bookmark);
    if ( Length(Host) > 0 ) then begin
        Setting.GetBouken(Host, Domain, Cookie);
        Result := Cookie;
    end;
end;

//! 指定文字列削除
procedure TGikoSys.DelString(del: String; var str: String);
var
  idx: Integer;
begin
  while True do begin
    idx := AnsiPos(del, str);
    if idx < 1 then
      Break;
    Delete(str, idx, Length(del));
  end;
end;

//! 2ch/5chのURLを実際に呼べる形にする
procedure TGikoSys.Regulate2chURL(var url: String);
var
  idx: Integer;
  is2ch: Boolean;
begin
  idx := AnsiPos('.2ch.net/', url);
  if idx > 0 then begin
    url[idx + 1] := '5';  // 2ch.net -> 5ch.net
    is2ch := True;
  end else begin
    is2ch := (AnsiPos('.5ch.net/', url) > 0) or
             (AnsiPos('.bbspink.com/', url) > 0);
  end;

  if is2ch and (AnsiPos('http://', url) = 1) then
    Insert('s', url, 5);  // http:// -> https://
end;

//! 2ch/5chのURLかどうか
function TGikoSys.Is2chURL(url: String): Boolean;
begin
  Result := (AnsiPos('.5ch.net/', url) > 0) or
            (AnsiPos('.2ch.net/', url) > 0) or
            (AnsiPos('.bbspink.com/', url) > 0);
end;

//! したらばのURLかどうか
function TGikoSys.IsShitarabaURL(url: String): Boolean;
begin
  Result := (AnsiPos('http://jbbs.shitaraba.net/',  url) = 1) or
            (AnsiPos('https://jbbs.shitaraba.net/', url) = 1);
end;


initialization
	GikoSys := TGikoSys.Create;

finalization
	if GikoSys <> nil then begin
		FreeAndNil(GikoSys);
	end;
end.
