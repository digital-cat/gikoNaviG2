unit BoardGroup;

interface

uses
	Windows, SysUtils, Classes, ComCtrls, {HTTPApp,} YofUtils, IdGlobal,
	ExternalBoardManager, ExternalBoardPlugInMain, StrUtils;

type
	//リストの表示アイテム選択
	TGikoViewType = (gvtAll, gvtLog, gvtNew, gvtLive, gvtArch, gvtUser);
	//リストの上げ下げ
	TGikoAgeSage = (gasNone, gasAge, gasSage, gasNew, gasArch, gasNull);

	TCategory = class;
	TBoard = class;
	TThreadItem = class;


	// BBS のルート
	TBBS = class(TList)
	private
		FTitle: string;
		FFilePath : string;						// 板リストのパス
		FExpand: Boolean;
		FKubetsuChk: Boolean;					//絞込み時大文字小文字区別
		FSelectText: string;					//絞込み文字列
		FShortSelectText: string;
		FIsBoardFileRead : Boolean;		// 板リストは読み込まれているか？

		function GetCategory(index: integer): TCategory;
		procedure SetCategory(index: integer; value: TCategory);
		procedure SetSelectText(s: string);
	public
		constructor Create( boardFilePath : string );
		destructor Destroy; override;

		function Add(item: TCategory): integer;
		procedure Delete(index: integer);
		procedure Clear; override;
		function Find(key: string): TCategory;
		function FindBBSID(const BBSID: string): TBoard;
		function FindBoardFromTitle(const Title: string): TBoard;
		function FindBoardFromTitleAndCategory(const CategoryTitle: string; const BoardTitle: string): TBoard;
        function FindBoardFromURLAndCategory(const CategoryTitle: string; const BoardURL: string): TBoard;
		function FindBoardFromURL(const inURL: string): TBoard;
		function FindThreadFromURL(const inURL : string ) : TThreadItem;
		function FindThreadItem(const BBSID, FileName: string): TThreadItem;
		function FindCategoryFromTitle(const inTitle : string ) : TCategory;
		property FilePath : string read FFilePath write FFilePath;

		property Items[index: integer]: TCategory read GetCategory write SetCategory;
		property Title: string read FTitle write FTitle;
		property NodeExpand: Boolean read FExpand write FExpand;

		property KubetsuChk: Boolean read FKubetsuChk write FKubetsuChk;
		property SelectText: string read FSelectText write SetSelectText;
		property ShortSelectText: string read FShortSelectText write FShortSelectText;

		property	IsBoardFileRead : Boolean read FIsBoardFileRead write FIsBoardFileRead;
	end;

	// カテゴリ(板 URL のリスト)
	TCategory = class(TStringList)
	private
		FNo: Integer;
		FTitle: string;
		FParenTBBS: TBBS;
		FExpand: Boolean;

		function GetBoard(index: integer): TBoard;
		procedure SetBoard(index: integer; value: TBoard);
	public
		constructor Create;
		destructor Destroy; override;

		property No: Integer read FNo write FNo;
		property Title: string read FTitle write FTitle;
		property Items[index: integer]: TBoard read GetBoard write SetBoard;
		property ParenTBBS: TBBS read FParenTBBS write FParenTBBS;

		function Add(item: TBoard): integer;
		procedure Delete(index: integer);
		procedure Clear; override;
		function FindName(const key: string): TBoard;
		function FindBBSID(const BBSID: string): TBoard;
		function FindBoardFromTitle(const Title: string): TBoard;
		function FindBoardFromURL(const inURL: string): TBoard;
        function FindBoardFromURL2(const inURL: string): TBoard;
		function FindThreadFromURL(const inURL : string ) : TThreadItem;
		function IsMidoku: Boolean;

		property NodeExpand: Boolean read FExpand write FExpand;
	end;

 	//! スレッド数カウント条件文
	TThreadCount = function(Item : TThreadItem): Boolean;

	// 板(スレッド URL のリスト)
	TBoard = class(TStringList)
	private
		FContext: DWORD;							// プラグインが自由に設定していい値(主にインスタンスが入る)

		FNo: Integer;									//番号
		FTitle: string;								//ボードタイトル
		FBBSID: string;								//BBSID
		FURL: string;									//ボードURL
		FRound: Boolean;							//スレッド一覧巡回予約
		FRoundName: string;						//巡回名
		FRoundDate: TDateTime;				//スレッド一覧を取得した日時（巡回日時）
		FLastModified: TDateTime;			//スレッド一覧が更新されている日時（サーバ側日時）
		FLastGetTime: TDateTime;			//スレッドまたはスレッド一覧を最後に更新した日時（サーバ側日時・書き込み時に使用する）
		FIsThreadDatRead: Boolean;		//スレッドリストは読み込まれているか？
		FUnRead: Integer;							//スレッド未読数
		FParentCategory: TCategory;		//親カテゴリ
		FModified: Boolean;						//修正フラグ
		FBoolData: Boolean;						//いろんな用途に使うyo
		FSPID: string;								//書き込み用SPID
		FPON: string;									//書き込み用PON
		FCookie: string;						//書き込み用Cookie文字列
		FExpires: TDateTime;					//Cookieの有効期限
		FKotehanName: string;					//コテハン名前
		FKotehanMail: string;					//コテハンメール

		FUpdate: Boolean;
		FExpand: Boolean;

		FBoardPlugIn	: TBoardPlugIn;	// この板をサポートするプラグイン
		FFilePath			: string;				// このスレ一覧が保存されているパス
		FIsLogFile		: Boolean;			// ログ存在フラグ
		FIntData			: Integer;			// 好きにいじってよし。いろんな用途に使うyo
		FListData			: TList;				// 好きにいじってよし。いろんな用途に使うyo

		FSETTINGTXTTime : TDateTime;	//SETTING.TXTを取得した日時
		FIsSETTINGTXT	: boolean;	//SETTING.TXTを取得しているか
		FHEADTXTTime	: TDateTime;		//HEAD.TXTを取得した日時
		FIsHEADTXT		: boolean;	//HEAD.TXTを取得しているか
		FTitlePictureURL: string;	//top絵のURL
		FMultiplicity	: Integer; //重複しているかどうか？
		FIs2ch			: Boolean; //hostが2chかどうか
		FNewThreadCount: Integer;	//新着スレッドの数
		FLogThreadCount: Integer;	//ログ有りスレッドの数
		FUserThreadCount: Integer;	//？
		FLiveThreadCount: Integer;	//生存スレッド数
		FArchiveThreadCount: Integer;	//DAT落ちスレッド数
		function GetThreadItem(index: integer): TThreadItem;
		procedure SetThreadItem(index: integer; value: TThreadItem);
		procedure SetRound(b: Boolean);
		procedure SetRoundName(s: string);
		//procedure SetRoundName(s: PChar);
		procedure SetLastModified(d: TDateTime);
		procedure SetLastGetTime(d: TDateTime);
		procedure SetUnRead(i: Integer);
		procedure SetKotehanName(s: string);
		procedure SetKotehanMail(s: string);
		procedure Init;
	public
		constructor Create( inPlugIn : TBoardPlugIn; inURL : string );
		destructor Destroy; override;

		property Context: DWORD read FContext write FContext;

		property Items[index: integer]: TThreadItem read GetThreadItem write SetThreadItem;
		property No: Integer read FNo write FNo;
		property Title: string read FTitle write FTitle;
		property BBSID: string read FBBSID write FBBSID;
		property URL: string read FURL write FURL;
		property Round: Boolean read FRound write SetRound;
		//property RoundName: PChar read FRoundName write SetRoundName;
		property RoundName: string read FRoundName write SetRoundName;
		property RoundDate: TDateTime read FRoundDate write FRoundDate;
		property LastModified: TDateTime read FLastModified write SetLastModified;
		property LastGetTime: TDateTime read FLastGetTime write SetLastGetTime;
		property UnRead: Integer read FUnRead write SetUnRead;
		property Modified: Boolean read FModified write FModified;
		property IsThreadDatRead: Boolean read FIsThreadDatRead write FIsThreadDatRead;
		property ParentCategory: TCategory read FParentCategory write FParentCategory;

		property	BoardPlugIn	: TBoardPlugIn	read FBoardPlugIn;
		property	FilePath		: string				read FFilePath write FFilePath;
		property	IsLogFile		: Boolean				read FIsLogFile write FIsLogFile;
		property	IntData			: Integer				read FIntData write FIntData;
		property	ListData		: TList					read FListData write FListData;
		function	IsBoardPlugInAvailable : Boolean;

		function Add(item: TThreadItem): integer;
		procedure Insert(Index: Integer; Item: TThreadItem);
		procedure Delete(index: integer);
		procedure DeleteList(index: integer);
		procedure Clear; override;
		function FindThreadFromFileName(const ItemFileName: string): TThreadItem;
		function FindThreadFromURL(const inURL : string ) : TThreadItem;
		function GetIndexFromFileName(const ItemFileName: string): Integer;
		function GetIndexFromURL(const URL: string; reverse : Boolean = False): Integer;
		procedure LoadSettings;
		procedure SaveSettings;
		function GetReadCgiURL: string;
		function GetSubjectFileName: string;
		function GetFolderIndexFileName: string;
		function GetSETTINGTXTFileName: string;
		function GETHEADTXTFileName: string;
		function GetTitlePictureFileName: string;
		function GetSendURL: string;

		function GetNewThreadCount: Integer;
		function GetLogThreadCount: Integer;
		function GetArchiveThreadCount: Integer;
		function GetLiveThreadCount: Integer;
		function GetUserThreadCount: Integer;
		function GetNewThread(Index: Integer): TThreadItem;
		function GetLogThread(Index: Integer): TThreadItem; overload;
		function GetArchiveThread(Index: Integer): TThreadItem;
		function GetLiveThread(Index: Integer): TThreadItem;
		function GetUserThread(Index: Integer): TThreadItem;
		function GetThreadCount(func :TThreadCount ): Integer;
		function GetThread(func :TThreadCount;const Index :Integer ): TThreadItem;
		procedure BeginUpdate;
		procedure EndUpdate;
		property NodeExpand: Boolean read FExpand write FExpand;
		property BoolData: Boolean read FBoolData write FBoolData;
		property SPID: string read FSPID write FSPID;
		property PON: string read FPON write FPON;
		property KotehanName: string read FKotehanName write SetKotehanName;
		property KotehanMail: string read FKotehanMail write SetKotehanMail;

		property SETTINGTXTTime: TDateTime read FSETTINGTXTTime write FSETTINGTXTTime;
		property IsSETTINGTXT:	boolean read FIsSETTINGTXT write FIsSETTINGTXT;
		property HEADTXTTime: TDateTime read FHEADTXTTime write FHEADTXTTime;
		property IsHEADTXT:	boolean read FIsHEADTXT write FIsHEADTXT;
		property TitlePictureURL: string read FTitlePictureURL write FTitlePictureURL;
		property Multiplicity: Integer read FMultiplicity write FMultiplicity;
		property Is2ch	: boolean	read FIs2ch	write FIs2ch;
		property NewThreadCount: Integer	read FNewThreadCount write FNewThreadCount;	//新着スレッドの数
		property LogThreadCount: Integer	read FLogThreadCount write FLogThreadCount;		//ログ有りスレッドの数
		property UserThreadCount: Integer	read FUserThreadCount write FUserThreadCount;	//？
		property LiveThreadCount: Integer	read FLiveThreadCount write	FLiveThreadCount;
		property ArchiveThreadCount: Integer read FArchiveThreadCount write FArchiveThreadCount;

		property Cookie: string 			read FCookie write FCookie;
		property Expires: TDateTime 			read FExpires write FExpires;
	end;

	//スレ
	TThreadItem = class(TObject)
	private
		FContext: DWORD;					// プラグインが自由に設定していい値(主にインスタンスが入る)
		FNo: Integer;							//番号
		FFileName: string;				//スレッドファイル名
		FTitle: string;						//スレッドタイトル
		FShortTitle: string;			//短いスレッドタイトル（検索用）
		FRoundDate: TDateTime;		//スレッドを取得した日時（巡回日時）
		FLastModified: TDateTime; //スレッドが更新されている日時（サーバ側日時）
		FCount: Integer;					//スレッドカウント（ローカル）
		FAllResCount: Integer;		//スレッドカウント（サーバ）
		FNewResCount: Integer;		//スレッド新着数
		FSize: Integer;						//スレッドサイズ
		FRound: Boolean;					//巡回フラグ
		FRoundName: string;				//巡回名
		FIsLogFile: Boolean;			//ログ存在フラグ
		FParentBoard: TBoard;			//親ボード
		FKokomade: Integer;				//ココまで読んだ番号
		FNewReceive: Integer; 		//ココから新規受信
		FNewArrival: Boolean;			//新着
		FUnRead: Boolean;					//未読フラグ
		FScrollTop: Integer;			//スクロール位置
		FDownloadHost: string;		//今のホストと違う場合のホスト
		FAgeSage: TGikoAgeSage;		//アイテムの上げ下げ
		FUpdate: Boolean;
		FExpand: Boolean;
		FURL					: string;				// このスレをブラウザで表示する際の URL
		FJumpAddress : Integer; 	//レス番号指定URLを踏んだときに指定されるレスの番号が入る
		procedure SetLastModified(d: TDateTime);
		procedure SetRound(b: Boolean);
		procedure SetRoundName(const s: string);
		//procedure SetRoundName(const s: PChar);
		procedure SetKokomade(i: Integer);
		procedure SetUnRead(b: Boolean);
		procedure SetScrollTop(i: Integer);
		procedure Init;
		function GetCreateDate: TDateTime;
        function GetFilePath: String;
	public
		constructor Create(const inPlugIn : TBoardPlugIn; const inBoard : TBoard; inURL : string ); overload;
		constructor Create(const inPlugIn : TBoardPlugIn; const inBoard : TBoard;
					 const inURL : string; inExist: Boolean; const inFilename: string ); overload;

		destructor Destroy; override;

		function GetDatURL: string;
		function GetDatgzURL: string;
//		function GetOldDatgzURL: string;
		function GetOfflawCgiURL(const SessionID: string): string;
//////////////// 2013/10/13 ShiroKuma対応 zako Start ///////////////////////////
        function GetOfflaw2SoURL: string;
//////////////// 2013/10/13 ShiroKuma対応 zako End /////////////////////////////
        function GetRokkaURL(const SessionID: string): string;  // Rokka対応  
		function GetExternalBoardKakoDatURL: string; // 外部板過去ログURL取得
		function GetSendURL: string;
		procedure DeleteLogFile;
		function GetThreadFileName: string;
		procedure BeginUpdate;
		procedure EndUpdate;

		property Context: DWORD read FContext write FContext;

		property No: Integer read FNo write FNo;
		property FileName: string read FFileName write FFileName;
		property Title: string read FTitle write FTitle;
		property ShortTitle: string read FShortTitle write FShortTitle;
		property RoundDate: TDateTime read FRoundDate write FRoundDate;
		property LastModified: TDateTime read FLastModified write SetLastModified;
		property Count: Integer read FCount write FCount;
		property AllResCount: Integer read FAllResCount write FAllResCount;
		property NewResCount: Integer read FNewResCount write FNewResCount;
		property Size: Integer read FSize write FSize;
		property Round: Boolean read FRound write SetRound;
		property RoundName: string read FRoundName write SetRoundName;
		//property RoundName: PChar read FRoundName write SetRoundName;

		property IsLogFile: Boolean read FIsLogFile write FIsLogFile;
		property ParentBoard: TBoard read FParentBoard write FParentBoard;
		property Kokomade: Integer read FKokomade write SetKokomade;
		property NewReceive: Integer read FNewReceive write FNewReceive;
		property NewArrival: Boolean read FNewArrival write FNewArrival;
		property UnRead: Boolean read FUnRead write SetUnRead;
		property ScrollTop: Integer read FScrollTop write SetScrollTop;
		property Expand: Boolean read FExpand write FExpand;
		property DownloadHost: string read FDownloadHost write FDownloadHost;
		property AgeSage: TGikoAgeSage read FAgeSage write FAgeSage;
		property CreateDate: TDateTime read GetCreateDate;
		property	URL					: string				read FURL write FURL;
		property	FilePath		: string	read GetFilePath;
		property JumpAddress : Integer read FJumpAddress write FJumpAddress;
	end;

	TBoardGroup = class(TStringList)
    private
    	FBoardPlugIn	: TBoardPlugIn;	// この板をサポートするプラグイン
    public
		destructor Destroy; override;
		procedure	Clear	; override;
        property	BoardPlugIn	: TBoardPlugIn	read FBoardPlugIn write FBoardPlugIn;
    end;

    // 特殊用途用TBoard
    TSpecialBoard = class(TBoard)
    public
        function Add(item: TThreadItem): integer; overload;
        procedure Clear; overload;
    end;

    // スレッド名NGワードリスト
	TThreadNgList = class(TStringList)
    private
        FFilePath: String;
    public
		constructor Create;
        procedure Load;
        procedure Save;
        function IsNG(const Title: String): Boolean;
    end;

	function	BBSsFindBoardFromBBSID( inBBSID : string ) : TBoard;
	function	BBSsFindBoardFromURL( inURL : string ) : TBoard;
	function	BBSsFindBoardFromTitle( inTitle : string ) : TBoard;
	function	BBSsFindThreadFromURL(const inURL : string ) : TThreadItem;
	function	ConvertDateTimeString( inDateTimeString : string) : TDateTime;

    procedure    DestorySpecialBBS( inBBS : TBBS );

var
	BBSs 		: array of TBBS;
    BoardGroups : array of TBoardGroup;
    SpecialBBS  : TBBS;
    SpecialBoard: TSpecialBoard;
    ThreadNgList: TThreadNgList;

implementation

uses
	GikoSystem, RoundData, MojuUtils, DateUtils, IniFiles;

const
	BBS2CH_NAME:					 string	= '２ちゃんねる';
	BBS2CH_LOG_FOLDER:		 string	= '2ch';
	EXTERNAL_LOG_FOLDER:		string	= 'exboard';

	FOLDER_INI_FILENAME:	 string	= 'Folder.ini';
	FOLDER_INDEX_FILENAME: string	= 'Folder.idx';
	SUBJECT_FILENAME:			string	= 'subject.txt';
	PATH_DELIM:						string	= '\';
	SETTINGTXT_FILENAME:		string = 'SETTING.TXT';
    HEADTXT_FILENAME:		string = 'head.html';
	//DEFAULT_LIST_COUNT:		Integer = 100;
	THREAD_NG_FILE: String = 'ThreadNg.txt';
    

//! ログを持っているなら真を返す
function CountLog(Item: TThreadItem): Boolean;
begin
	Result := Item.IsLogFile;
end;
//! 新着なら真を返す
function CountNew(Item: TThreadItem): Boolean;
begin
	Result := Item.NewArrival;
end;
//! DAT落ちなら真を返す
function CountDat(Item: TThreadItem): Boolean;
begin
	Result := (Item.AgeSage = gasArch);
end;
//! 生存スレなら真を返す
function CountLive(Item: TThreadItem): Boolean;
begin
	Result := (Item.AgeSage <> gasArch);
end;

//! 常に真
function CountAll(Item: TThreadItem): Boolean;
begin
    Result := True;
end;



// BBSID を用いる 2 ちゃんねるのみ探し出します
// BBSID の使用は極力避けてください。
// 可能な場合は URL を使用してください。
function	BBSsFindBoardFromBBSID(
	inBBSID	: string
) : TBoard;
var
	i : Integer;
	tmpBoard : TBoard;
begin

//	Result := BBSs[ 0 ].FindBBSID( inBBSID );
	Result := nil;
	if Length(BoardGroups) > 0 then begin
		for i := BoardGroups[0].Count - 1 downto 0 do begin
			tmpBoard := TBoard(BoardGroups[0].Objects[i]);
			if tmpBoard.Is2ch then begin
				if AnsiCompareStr(tmpBoard.BBSID, inBBSID) = 0 then begin
					Result := tmpBoard;
					EXIT;
				end;
			end;
		end;
	end;

end;
{**********************************************
この関数は必ず板のURLの形式で渡してください。
pluginを使用するならば、ExtractBoardURL( inURL )
2chならば、GikoSys.Get2chThreadURL2BoardURL( inURL );
で変換してから呼び出してください。
**********************************************}
function	BBSsFindBoardFromURL(
	inURL	: string
) : TBoard;
var
	i,p			: Integer;
	accept		: TAcceptType;
	protocol, host, path, document, port, bookmark : string;
begin
	Result := nil;
	for i := Length(BoardGroups) - 1 downto 1 do begin
		accept := BoardGroups[i].BoardPlugIn.AcceptURL(inURL);
		if (accept = atBoard) or (accept = atThread) then begin
			if BoardGroups[i].Find(inURL, p) then begin
				Result := TBoard(BoardGroups[i].Objects[p]);
				Exit;
			end else begin
				inURL := BoardGroups[i].BoardPlugIn.ExtractBoardURL(inURL);
				if BoardGroups[i].Find(inURL, p) then begin
					Result := TBoard(BoardGroups[i].Objects[p]);
					Exit;
				end;
			end;
		end;
	end;
	//ここにきたら、pluginを使わないやつらを調べる
	if BoardGroups[0].Find(inURL, p) then
		Result := TBoard(BoardGroups[0].Objects[p]);
		
	if (Result = nil) then begin
		GikoSys.ParseURI( inURL, protocol, host, path, document, port, bookmark );
		//ホストが2chならBBSIDで調べる
		if GikoSys.Is2chHost(host) then begin
			Result := BBSsFindBoardFromBBSID(GikoSys.URLToID( inURL ));
		end;
	end;

end;

function	BBSsFindBoardFromTitle(
	inTitle	: string
) : TBoard;
var
	i,j				: Integer;
	tmpBoard		: TBoard;
begin
    Result := nil;
	for i := Length( BBSs ) - 1 downto 0 do begin
		for j := BoardGroups[i].Count - 1 downto 0 do begin
			tmpBoard := TBoard(BoardGroups[i].Objects[j]);
			if ( AnsiCompareStr(tmpBoard.Title, inTitle) = 0) then begin
				Result := tmpBoard;
				Exit;
			end;
		end;
	end;

end;

function	BBSsFindThreadFromURL(
	const inURL			: string
) : TThreadItem;
var
	board			: TBoard;
	tmpThread		: TThreadItem;
	boardURL	: string;
	protocol, host, path, document, port, bookmark : string;
	BBSID, BBSKey : string;
	i, bi : Integer;
  chkURL : String;  // for 5ch
begin
  // for 5ch
  chkURL := inURL;
  GikoSys.Regulate2chURL(chkURL);
  // for 5ch
	boardURL	:= GikoSys.GetThreadURL2BoardURL( chkURL );
	board			:= BBSsFindBoardFromURL( boardURL );
	if board = nil then
		Result := nil
	else begin
		Result := board.FindThreadFromURL( chkURL );
		//もしも2chの板なら
		if (Result = nil) and (board.Is2ch) then begin
			GikoSys.ParseURI( chkURL, protocol, host, path, document, port, bookmark );
			GikoSys.Parse2chURL( chkURL, path, document, BBSID, BBSKey );
			Result := board.FindThreadFromFileName(BBSKey + '.dat');
		end else if (Result = nil) and not (board.Is2ch) then begin
		//プラグイン系の探索（主にURLが途中で変更になった類)
			try
				bi := Length(BoardGroups) - 1;
				for i := 1 to bi do begin
					if (BoardGroups[i].BoardPlugIn <> nil) and (Assigned(Pointer(BoardGroups[i].BoardPlugIn.Module))) then begin
						if BoardGroups[i].BoardPlugIn.AcceptURL( chkURL ) = atThread then begin
							tmpThread		:= TThreadItem.Create( BoardGroups[i].BoardPlugIn, Board, chkURL );
							if not board.IsThreadDatRead then begin
								GikoSys.ReadSubjectFile( board );
							end;
							Result := Board.FindThreadFromFileName( tmpThread.FileName );
							tmpThread.Free;
							Break;
						end;
					end;
				end;
			except
            	Result := nil;
			end;
		end;
	end;

end;
{!
\brief 特殊用途BBS削除
\param bbs 削除する特殊用途BBS
}
procedure DestorySpecialBBS( inBBS : TBBS );
var
    sCategory : TCategory;
    sBoard    : TSpecialBoard;
begin
    if inBBS <> nil then begin
        sCategory := inBBS.Items[0];
        if sCategory <> nil then begin
            sBoard := TSpecialBoard(sCategory.Items[0]);
            if sBoard <> nil then begin
                sBoard.Modified := False;
                sBoard.Clear;
                FreeAndNil(sBoard);
            end;
        end;
        FreeAndNil(inBBS);
    end;
end;

(*************************************************************************
 *機能名：TBBSコンストラクタ
 *Public
 *************************************************************************)
constructor TBBS.Create( boardFilePath : string );
begin
	inherited Create;
	Title := BBS2CH_NAME;
	FFilePath := boardFilePath;
end;

(*************************************************************************
 *機能名：TBBSデストラクタ
 *Public
 *************************************************************************)
destructor TBBS.Destroy;
begin
	Clear;
	inherited;
end;

(*************************************************************************
 *機能名：
 *Public
 *************************************************************************)
function TBBS.GetCategory(index: integer): TCategory;
begin
	Result := TCategory(inherited Items[index]);
end;

procedure TBBS.SetCategory(index: integer; value: TCategory);
begin
	inherited Items[index] := value;
end;

function TBBS.Add(item: TCategory): integer;
begin
	Item.ParenTBBS := self;
	Result := inherited Add(item);
end;

procedure TBBS.Delete(index: integer);
begin
	if Items[index] <> nil then
		TCategory(Items[index]).Free;
	Items[index] := nil;
	inherited Delete(index);
end;

procedure TBBS.Clear;
var
	i: integer;
begin
	for i := Count - 1 downto 0 do
		Delete(i);
    Capacity := Count;
end;

function TBBS.Find(key: string): TCategory;
begin
	Result := nil;
end;

function TBBS.FindBBSID(const BBSID: string): TBoard;
var
	i	: Integer;
begin
	if not IsBoardFileRead then
  	GikoSys.ReadBoardFile( Self );
	for i := Count - 1 downto 0 do begin
		Result := Items[ i ].FindBBSID(BBSID);
		if Result <> nil then
			Exit;
	end;
	Result := nil;
end;

//*************************************************************************
// タイトルの一致する板を探す
//*************************************************************************)
function TBBS.FindBoardFromTitle(const Title: string): TBoard;
var
	i: Integer;
begin
	if not IsBoardFileRead then
	GikoSys.ReadBoardFile( Self );
	for i := Count - 1 downto 0 do begin
		Result := Items[ i ].FindBoardFromTitle(Title);
		if Result <> nil then
			Exit;
	end;
	Result := nil;
end;

//*************************************************************************
// カテゴリ名と板名の一致する板を探す
//*************************************************************************)
function TBBS.FindBoardFromTitleAndCategory(const CategoryTitle: string; const BoardTitle: string): TBoard;
var
	i: Integer;
begin
	if not IsBoardFileRead then
    	GikoSys.ReadBoardFile( Self );
	for i := Count - 1 downto 0 do begin
        if AnsiCompareStr(Items[ i ].Title, CategoryTitle) = 0 then begin
            Result := Items[ i ].FindBoardFromTitle(BoardTitle);
            if Result <> nil then
                Exit;
    	end;
	end;
	Result := nil;
end;

//*************************************************************************
// カテゴリ名と板URLの一致する板を探す
//*************************************************************************)
function TBBS.FindBoardFromURLAndCategory(const CategoryTitle: string; const BoardURL: string): TBoard;
var
	i: Integer;
begin
	if not IsBoardFileRead then
    	GikoSys.ReadBoardFile( Self );
	for i := Count - 1 downto 0 do begin
        if AnsiCompareStr(Items[ i ].Title, CategoryTitle) = 0 then begin
            Result := Items[ i ].FindBoardFromURL2(BoardURL);
            if Result <> nil then
                Exit;
    	end;
	end;
	Result := nil;
end;

//*************************************************************************
// URL を受け付ける板を探す
//*************************************************************************)
function TBBS.FindBoardFromURL(const inURL: string): TBoard;
var
	i					: Integer;
begin
	if not IsBoardFileRead then
	GikoSys.ReadBoardFile( Self );
	for i := Count - 1 downto 0 do begin
		Result := Items[ i ].FindBoardFromURL( inURL );
		if Result <> nil then
			Exit;
	end;
	Result := nil;
end;

//*************************************************************************
// URL を受け付けるスレッドを探す
//*************************************************************************)
function TBBS.FindThreadFromURL(const inURL: string): TThreadItem;
var
	board			: TBoard;
	boardURL	: string;
begin

	boardURL	:= GikoSys.GetThreadURL2BoardURL( inURL );
	board			:= FindBoardFromURL( boardURL );
	if board = nil then
		Result := nil
	else
		Result := board.FindThreadFromURL( inURL );

end;

function TBBS.FindThreadItem(const BBSID, FileName: string): TThreadItem;
var
	Board: TBoard;
begin
	Result := nil;
	Board := FindBBSID(BBSID);
	if Board = nil then
		Exit;
	Result := Board.FindThreadFromFileName(FileName);
end;

function TBBS.FindCategoryFromTitle(const inTitle : string ) : TCategory;
var
	i : Integer;
begin

	for i := Count - 1 downto 0 do begin
		if AnsiCompareStr(Items[ i ].Title, inTitle) = 0 then begin
			Result := Items[ i ];
			Exit;
		end;
	end;

	Result := nil;

end;

procedure TBBS.SetSelectText(s: string);
begin
	FSelectText := s;
	ShortSelectText := CustomStringReplace(ZenToHan(s), ' ', '');
end;

{class function TBBS.GetColumnName(Index: Integer): string;
begin
	Result := COLUMN_CATEGORY[Index];
end;

class function TBBS.GetColumnCount: Integer;
begin
	Result := Length(COLUMN_CATEGORY);
end;}

//===================
//TCategory
//===================
constructor TCategory.Create;
begin
	inherited;

	Duplicates		:= dupIgnore;
	CaseSensitive	:= False;
	//Sorted				:= True;
end;

destructor TCategory.Destroy;
begin
	Clear;
	inherited;
end;

function TCategory.GetBoard(index: integer): TBoard;
begin
	Result := TBoard( Objects[index] );
end;

procedure TCategory.SetBoard(index: integer; value: TBoard);
begin
	Objects[index] := value;
	Strings[index] := value.URL
end;

function TCategory.Add(item: TBoard): integer;
begin
	Item.ParentCategory := self;
	Result := AddObject( item.URL, item );
end;

procedure TCategory.Delete(index: integer);
begin
    inherited Delete(index);
end;

procedure TCategory.Clear;
var
	i: integer;
begin
	for i := Count - 1 downto 0 do
		Delete(i);
	Capacity := Count;
end;

function TCategory.FindName(const key: string): TBoard;
begin
	Result := nil;
end;

function TCategory.FindBBSID(const BBSID: string): TBoard;
var
	i	: integer;
begin
	for i := Count - 1 downto 0 do begin
		if AnsiCompareStr(Items[i].FBBSID, BBSID) = 0 then begin
			Result := Items[i];
			Exit;
		end;
	end;
	Result := nil;
end;

//*************************************************************************
// タイトルの一致する板を探す
//*************************************************************************)
function TCategory.FindBoardFromTitle(const Title: string): TBoard;
var
	i	: integer;
begin
	for i := Count - 1 downto 0 do begin
		if AnsiCompareStr(Items[i].FTitle, Title) = 0 then begin
			Result := Items[i];
			Exit;
		end;
	end;
	Result := nil;
end;

//*************************************************************************
// URL を受け付ける板を探す
//*************************************************************************)
function TCategory.FindBoardFromURL(const inURL: string): TBoard;
var
	i	: Integer;
begin
	i := IndexOf( inURL );
	if i >= 0 then
		Result := TBoard( Objects[ i ] )
	else
		Result := nil;
end;

//*************************************************************************
// ホスト名を除いたURLで板を探す（5ch.net/2ch.net/bbspink.com限定）
//*************************************************************************)
function TCategory.FindBoardFromURL2(const inURL: string): TBoard;
const
	HOST_NAME: array[0..2] of string = ('.5ch.net', '.2ch.net', '.bbspink.com');
var
	i	: Integer;
    idx: Integer;
    chkURL: String;
    chkLen: Integer;
begin
    Result := nil;
    for i := 0 to Length(HOST_NAME) - 1 do begin
        idx := Pos(HOST_NAME[i], inURL);
        if (idx > 0) then begin
            chkLen := Length(inURL) - idx + 1;
            chkURL := Copy(inURL, idx, chkLen);
            Break;
        end;
    end;
    if (chkLen > 0) then begin
        for i := 0 to Count - 1 do begin
            idx := Pos(ChkURL, Strings[i]);
            if (idx > 0) then begin
                if (Length(Strings[i]) - idx + 1 = chkLen) then begin
                    Result := TBoard( Objects[ i ] );
                    Break;
                end;
            end;
        end;
    end;
end;

//*************************************************************************
// URL を受け付けるスレッドを探す
//*************************************************************************)
function TCategory.FindThreadFromURL(const inURL: string): TThreadItem;
var
	board			: TBoard;
	boardURL	: string;
begin

	boardURL	:= GikoSys.GetThreadURL2BoardURL( inURL );
	board			:= FindBoardFromURL( boardURL );
	if board = nil then
		Result := nil
	else
		Result := board.FindThreadFromURL( inURL );

end;

function TCategory.IsMidoku: Boolean;
var
	i: Integer;
	j: Integer;
begin
	Result := False;
	for i := 0 to Count - 1 do begin
		if Items[i] <> nil then begin
			for j := 0 to Items[i].Count - 1 do begin
				if Items[i].Items[j] <> nil then begin
//					if (Items[i].Items[j].IsLogFile) and (Items[i].Items[j].Count > Items[i].Items[j].Kokomade) then begin
					if (Items[i].Items[j].IsLogFile) and (Items[i].Items[j].UnRead) then begin
						Result := True;
						Exit;
					end;
				end;
			end;
		end;
	end;
end;

{class function TCategory.GetColumnName(Index: Integer): string;
begin
	Result := COLUMN_BOARD[Index];
end;

class function TCategory.GetColumnCount: Integer;
begin
	Result := Length(COLUMN_BOARD);
end;}

//===================
//TBoard
//===================
procedure TBoard.Init;
begin
	Duplicates		:= dupIgnore;
	CaseSensitive	:= False;
	//Sorted				:= True;

	FNo := 0;
	FTitle := '';
	FBBSID := '';
	FURL := '';
	FRound := False;
	FRoundDate := ZERO_DATE;
	FLastModified := ZERO_DATE;
	FLastGetTime := ZERO_DATE;
	FIsThreadDatRead := False;
	FUnRead := 0;
	FMultiplicity := 0;
//	FListStyle := vsReport;
//	FItemNoVisible := True;

	FUpdate := True;
end;

// *************************************************************************
// 外部板プラグインを指定したコンストラクタ
// *************************************************************************
constructor TBoard.Create(
	inPlugIn	: TBoardPlugIn;
	inURL			: string
);
var
	protocol, host, path, document, port, bookmark	: string;
begin

	inherited Create;
	Init;

	FBoardPlugIn	:= inPlugIn;
	URL						:= inURL;
	BBSID					:= GikoSys.UrlToID( inURL );

	if inPlugIn = nil then begin
		// subject.txt の保存パスを設定
		GikoSys.ParseURI( inURL, protocol, host, path, document, port, bookmark );
		if GikoSys.Is2chHost( host ) then begin
			Self.Is2ch := True;
			FilePath :=
				GikoSys.Setting.LogFolderP  +
				BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + SUBJECT_FILENAME
		end else begin
			Self.Is2ch := False;
			FilePath :=
				GikoSys.Setting.LogFolderP +
				EXTERNAL_LOG_FOLDER + PATH_DELIM + host + PATH_DELIM + BBSID + PATH_DELIM + SUBJECT_FILENAME
		end;
	end else begin
		// プラグインに TBoardItem が作成されたことを伝える
		inPlugIn.CreateBoardItem( DWORD( Self ) );
		//Self.Is2ch := False;	//plugin側で設定する
	end;

end;

// *************************************************************************
// デストラクタ
// *************************************************************************
destructor TBoard.Destroy;
begin
	if FModified then begin
		GikoSys.WriteThreadDat(Self);
		SaveSettings;
	end;

	// プラグインに TBoardItem が破棄されたことを伝える
	if IsBoardPlugInAvailable then
		BoardPlugIn.DisposeBoardItem( DWORD( Self ) );

	Clear;
	inherited;
end;

// *************************************************************************
// 外部板プラグインが使用可能か
// *************************************************************************
function	TBoard.IsBoardPlugInAvailable : Boolean;
begin

	repeat
		if BoardPlugIn = nil then
			Break;
			
		if not Assigned( Pointer( BoardPlugIn.Module ) ) then
			Break;

		Result := True;
		Exit;
	until True;

	Result := False;

end;

function TBoard.GetThreadItem(index: integer): TThreadItem;
begin
	Result := TThreadItem( Objects[index] );
end;

procedure TBoard.SetThreadItem(index: integer; value: TThreadItem);
begin
	Objects[index] := value;
	Strings[index] := value.URL;
end;

function TBoard.Add(Item: TThreadItem): Integer;
begin
	Item.ParentBoard := Self;
	Result := inherited AddObject(Item.URL, Item);
end;

procedure TBoard.Insert(Index: Integer; Item: TThreadItem);
begin
	Item.ParentBoard := Self;
	inherited InsertObject(Index, Item.URL, Item);

end;

//Indexで指定されたスレッドオブジェクトを破棄
procedure TBoard.Delete(index: Integer);
begin
	if Items[index] <> nil then
		TThreadItem(Items[index]).Free;
	inherited Delete(index);
end;

//Indexで指定されたスレッドをリストから削除（スレオブジェクトはのこす）
procedure TBoard.DeleteList(index: integer);
begin
	inherited Delete(index);
end;

procedure TBoard.Clear;
var
	i: integer;
begin
//	FUnRead := 0;
	for i := Count - 1 downto 0 do
		Delete(i);
	 Capacity := Count;
end;

function TBoard.FindThreadFromFileName(const ItemFileName: string): TThreadItem;
var
	i: integer;
begin
	Result := nil;
	for i := 0 to Count - 1 do begin
		if AnsiCompareStr(Items[i].FileName, ItemFileName) = 0 then begin
			Result := Items[i];
			Exit;
		end;
	end;
end;

function TBoard.GetIndexFromFileName(const ItemFileName: string): Integer;
var
	i: integer;
begin
	Result := -1;
	for i := 0 to Count - 1 do begin
		if Items[i].FileName = ItemFileName then begin
			Result := i;
			Exit;
		end;
	end;
end;

function TBoard.GetIndexFromURL(const URL: string; reverse : Boolean = False): Integer;
var
	i : Integer;
begin
	if not reverse then
		Result := IndexOf( URL )
	else begin
        Result := -1;
		for i := Self.Count - 1 downto 0 do begin
			if Strings[i] = URL then begin
				Result := i;
				break;
			end;
		end;
	end;
end;

function TBoard.FindThreadFromURL(const inURL : string ) : TThreadItem;
var
	i : Integer;
begin

	if not IsThreadDatRead then
		GikoSys.ReadSubjectFile( Self );

	i := IndexOf( inURL );
	if i >= 0 then
		Result := TThreadItem( Objects[ i ] )
	else
		Result := nil;

end;

{function TBoard.GetMidokuCount: Integer;
var
	i: integer;
begin
	Result := 0;
	for i := 0 to Count- 1 do begin
		if Items[i] <> nil then begin
			if (Items[i].IsLogFile) and (Items[i].Count > Items[i].Kokomade) then
				inc(Result);
		end;
	end;
end;
}

procedure TBoard.LoadSettings;
var
	ini: TMemIniFile;
	FileName: string;
	tmp: string;
begin
	if Length( FilePath ) > 0 then
		FileName := ExtractFilePath( FilePath ) + FOLDER_INI_FILENAME
	else
		FileName := GikoSys.Setting.LogFolderP
							+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + FOLDER_INI_FILENAME;

	if not FileExists(FileName) then
		Exit;
	ini := TMemIniFile.Create(FileName);
	try
//		Round := ini.ReadBool('Status', 'Round', False);
		tmp := ini.ReadString('Status', 'RoundDate', DateTimeToStr(ZERO_DATE));
		FRoundDate := ConvertDateTimeString(tmp);
		tmp := ini.ReadString('Status', 'LastModified', DateTimeToStr(ZERO_DATE));
		FLastModified := ConvertDateTimeString(tmp);
		tmp := ini.ReadString('Status', 'LastGetTime', DateTimeToStr(ZERO_DATE));
		FLastGetTime := ConvertDateTimeString(tmp);

		tmp := ini.ReadString('BoardInformation', 'SETTINGTXTTime', DateTimeToStr(ZERO_DATE));
		FSETTINGTXTTime := ConvertDateTimeString(tmp);
		tmp := ini.ReadString('BoardInformation', 'HEADTXTTime', DateTimeToStr(ZERO_DATE));
		FHEADTXTTime := ConvertDateTimeString(tmp);

		FIsSETTINGTXT := ini.ReadBool('BoardInformation', 'IsSETTINGTXT', false);
		FIsHEADTXT := ini.ReadBool('BoardInformation', 'IsHEADTXT', false);
		FTitlePictureURL := ini.ReadString('BoardInformation', 'TitlePictureURL', '');

		FUnRead := ini.ReadInteger('Status', 'UnRead', 0);
		FSPID := ini.ReadString('Cookie', 'SPID', '');
		FPON := ini.ReadString('Cookie', 'PON', '');
		FCookie  := ini.ReadString('Cookie', 'Cookie', '');
		tmp := ini.ReadString('Cookie', 'Expires', DateTimeToStr(ZERO_DATE));
		FExpires := ConvertDateTimeString(tmp);
		FKotehanName := ini.ReadString('Kotehan', 'Name', '');
		FKotehanMail := ini.ReadString('Kotehan', 'Mail', '');

		if UnRead < 0 then
			UnRead := 0;
	finally
		ini.Free;
	end;
end;

procedure TBoard.SaveSettings;
var
	ini: TMemIniFile;
	FileName: string;
begin
	if Length( FilePath ) > 0 then
		FileName := ExtractFilePath( FilePath )
	else
		FileName := GikoSys.Setting.LogFolderP
							+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM;
	if not GikoSys.DirectoryExistsEx(FileName) then
		GikoSys.ForceDirectoriesEx(FileName);
	FileName := FileName + FOLDER_INI_FILENAME;
	ini := TMemIniFile.Create(FileName);
	try
		if UnRead < 0 then
			UnRead := 0;
//		ini.WriteBool('Status', 'Round', Round);
		ini.WriteDateTime('Status', 'RoundDate', FRoundDate);
		ini.WriteDateTime('Status', 'LastModified', FLastModified);
		ini.WriteDateTime('Status', 'LastGetTime', FLastGetTime);
		ini.WriteInteger('Status', 'UnRead', FUnRead);
		ini.WriteString('Cookie', 'SPID', FSPID);
		ini.WriteString('Cookie', 'PON', FPON);
		ini.WriteString('Cookie', 'Cookie', FCookie);
		ini.WriteDateTime('Cookie', 'Expires', FExpires);
		ini.WriteString('Kotehan', 'Name', FKotehanName);
		ini.WriteString('Kotehan', 'Mail', FKotehanMail);

		ini.WriteDateTime('BoardInformation', 'SETTINGTXTTime', FSETTINGTXTTime);
		ini.WriteDateTime('BoardInformation', 'HEADTXTTime', FHEADTXTTime);

		ini.WriteBool('BoardInformation', 'IsSETTINGTXT', FIsSETTINGTXT);
		ini.WriteBool('BoardInformation', 'IsHEADTXT', FIsHEADTXT);
		ini.WriteString('BoardInformation', 'TitlePictureURL', FTitlePictureURL);
//		ini.WriteInteger('Status', 'ListStyle', Ord(ListStyle));
//		ini.WriteBool('Status', 'ItemNoVisible', ItemNoVisible);
//		ini.WriteInteger('Status', 'ViewType', Ord(ViewType));
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;
//ときたま2003 02 08 0:32:13こんな形式の日付があるのでそれを
//        2003/02/08 0:32:13に変換する
function	ConvertDateTimeString( inDateTimeString : string) : TDateTime;
const
	ZERO_DATE_STRING : string = '1970/01/01 0:00:00';
var
	i : Integer;
    y: Integer;
    m: Integer;
    d: Integer;
    hour: Integer;
    min: Integer;
    sec: Integer;
begin
    if inDateTimeString = '' then
    	inDateTimeString := ZERO_DATE_STRING;

    if ( AnsiPos('/', inDateTimeString ) = 0 ) and
    	( AnsiCompareStr( DateTimeToStr(ZERO_DATE), inDateTimeString) <> 0 ) then begin
		for i := 0 to 1 do begin
    		Insert('/',inDateTimeString, AnsiPos(' ', inDateTimeString) + 1 );
        	Delete(inDateTimeString, AnsiPos(' ', inDateTimeString), 1);
    	end;
    end;
    try
    	Result := StrToDateTime( inDateTimeString );
    except
    	if( inDateTimeString[5] = '/' ) and ( inDateTimeString[8] = '/' ) then begin
            y := StrToIntDef( Copy(inDateTimeString, 1, 4), 1970 );
			m := StrToIntDef( Copy(inDateTimeString, 6, 2), 1 );
            d := StrToIntDef( Copy(inDateTimeString, 9, 2), 1 );
            hour := 0; min  := 0; sec  := 0;

        	if Length(inDateTimeString) > 11 then begin
            	if( inDateTimeString[13] = ':' ) and ( inDateTimeString[16] = ':' ) then begin
                	hour := StrToIntDef( Copy(inDateTimeString, 12, 1), 0 );
                    min  := StrToIntDef( Copy(inDateTimeString, 14, 2), 0 );
                    sec  := StrToIntDef( Copy(inDateTimeString, 17, 2), 0 );
                end else if( inDateTimeString[14] = ':' ) and ( inDateTimeString[17] = ':' ) then begin
                	hour := StrToIntDef( Copy(inDateTimeString, 12, 2), 0 );
                    min  := StrToIntDef( Copy(inDateTimeString, 15, 2), 0 );
                    sec  := StrToIntDef( Copy(inDateTimeString, 18, 2), 0 );
                end;
            end;
            try
            	Result := EncodeDateTime(y ,m, d, hour, min, sec, 0);
            except
                Result := ZERO_DATE;
            end;
        end else
        	Result := ZERO_DATE;
    end;


   // Result := inDateTimeString;
end;
//! サブジェクトURL取得
function TBoard.GetReadCgiURL: string;
begin
	Result := URL + SUBJECT_FILENAME;

end;

//! サブジェクトファイル名取得（パス＋ファイル名）
function TBoard.GetSubjectFileName: string;
begin
	if Length( FilePath ) > 0 then
		Result := FilePath
	else
		Result := GikoSys.Setting.LogFolderP
						+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + SUBJECT_FILENAME;
end;

//! インデックスファイル名(folder.idx)取得（パス＋ファイル名）
function TBoard.GetFolderIndexFileName: string;
begin
	if Length( FilePath ) > 0 then
		Result := ExtractFilePath( FilePath ) + FOLDER_INDEX_FILENAME
	else
		Result := GikoSys.Setting.LogFolderP
						+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + FOLDER_INDEX_FILENAME;
end;
//! SETTING.TXTのファイル名取得
function TBoard.GetSETTINGTXTFileName: string;
begin
	if Length( FilePath ) > 0 then
		Result := ExtractFilePath( FilePath ) + SETTINGTXT_FILENAME
	else
		Result := GikoSys.Setting.LogFolderP
						+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + SETTINGTXT_FILENAME;
end;

function TBoard.GETHEADTXTFileName: string;
begin
	if Length( FilePath ) > 0 then
		Result := ExtractFilePath( FilePath ) + HEADTXT_FILENAME
	else
		Result := GikoSys.Setting.LogFolderP
						+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + HEADTXT_FILENAME;
end;
function TBoard.GetTitlePictureFileName: string;
var
	tmpName: string;
begin
	if FTitlePictureURL = '' then
		Result := ''
	else begin
		tmpName := Copy(FTitlePictureURL, LastDelimiter('/', FTitlePictureURL) + 1, Length(FTitlePictureURL));
		if Length( FilePath ) > 0 then
			Result := ExtractFilePath( FilePath ) + tmpName
		else
			Result := GikoSys.Setting.LogFolderP
							+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + tmpName;
	end;
end;

// スレ立て送信URL
function TBoard.GetSendURL: string;
begin
    Result := GikoSys.UrlToServer(URL);
	if Self.Is2ch then
        Result := Result + 'test/bbs.cgi'
    else
        Result := Result + 'test/subbbs.cgi';

end;

procedure TBoard.SetRound(b: Boolean);
begin
	if b then
		RoundList.Add(Self)
	else
		RoundList.Delete(Self);
	if FRound = b then Exit;
	FRound := b;
	if FUpdate then
		FModified := True;
end;

procedure TBoard.SetRoundName(s: string);
begin
	if FRoundName = s then Exit;
	FRoundName := s;
	if FUpdate then
		FModified := True;
end;

procedure TBoard.SetLastModified(d: TDateTime);
begin
	if FLastModified = d then Exit;
	FLastModified := d;
	if FUpdate then
		FModified := True;
end;

procedure TBoard.SetLastGetTime(d: TDateTime);
begin
	if FLastGetTime = d then Exit;
	FLastGetTime := d;
	if FUpdate then
		FModified := True;
end;

procedure TBoard.SetUnRead(i: Integer);
begin
	if FUnRead = i then Exit;
	if i < 0 then i := 0;
	FUnRead := i;
	if FUpdate then
		FModified := True;
end;

procedure TBoard.SetKotehanName(s: string);
begin
	if FKotehanName = s then Exit;
	FKotehanName := s;
	if FUpdate then
		FModified := True;
end;

procedure TBoard.SetKotehanMail(s: string);
begin
	if FKotehanMail = s then Exit;
	FKotehanMail := s;
	if FUpdate then
		FModified := True;
end;
//! funcの条件に一致するスレッドの数を返す
function TBoard.GetThreadCount(func :TThreadCount ): Integer;
var
	i: Integer;
begin
	Result := 0;
	if Length( ParentCategory.ParenTBBS.ShortSelectText ) = 0 then
	begin
		for i := 0 to Count - 1 do begin
			if func(Items[i]) then
				inc(Result);
		end;
	end else begin
		for i := 0 to Count - 1 do begin
			if func(Items[i]) then
			begin
				if Items[i].ShortTitle = '' then
					Items[i].ShortTitle := CustomStringReplace(ZenToHan(Items[i].Title), ' ', '');
				if AnsiPos(ParentCategory.ParenTBBS.ShortSelectText, Items[i].ShortTitle) <> 0 then
					inc(Result);
			end;
		end;
	end;
end;
//! 新着スレッドの数を取得する
function TBoard.GetNewThreadCount: Integer;
begin
	Result := GetThreadCount(CountNew);
end;
//! ログ有りスレッドの数を取得する
function TBoard.GetLogThreadCount: Integer;
begin
	Result := GetThreadCount(CountLog);
end;
//! 絞込み条件に一致するスレッドの数を取得する
function TBoard.GetUserThreadCount: Integer;
begin
	Result := GetThreadCount(CountAll);
end;
//! DAT落ちスレッドの数を取得する
function TBoard.GetArchiveThreadCount: Integer;
begin
	Result := GetThreadCount(CountDat);
end;
//! 生存スレッドの数を取得する
function TBoard.GetLiveThreadCount: Integer;
begin
	Result := GetThreadCount(CountLive);
end;
//! funcの条件に適合するIndex番目のスレッドを取得する
function TBoard.GetThread(func :TThreadCount;const Index :Integer ): TThreadItem;
var
	i: Integer;
	Cnt: Integer;
begin
	Result := nil;
	Cnt := 0;
	if Length( ParentCategory.ParenTBBS.ShortSelectText ) = 0 then
	begin
		for i := 0 to Count - 1 do begin
			if func(Items[i]) then begin
				if Index = Cnt then begin
					Result := Items[i];
					Exit;
				end;
				inc(Cnt);
			end;
		end;
	end else begin
		for i := 0 to Count - 1 do begin
			if func(Items[i]) then begin
				if Length(Items[i].ShortTitle) = 0 then
					Items[i].ShortTitle := CustomStringReplace(ZenToHan(Items[i].Title), ' ', '');
				if AnsiPos(ParentCategory.ParenTBBS.ShortSelectText, Items[i].ShortTitle) <> 0 then begin
					if Index = Cnt then begin
						Result := Items[i];
						Exit;
					end;
					inc(Cnt);
				end;
			end;
		end;
	end;
end;
//! DAT落ちスレッドでIndex番目のスレッドを取得する
function TBoard.GetArchiveThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountDat, Index);
end;
//! 生存スレッドでIndex番目のスレッドを取得する
function TBoard.GetLiveThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountLive, Index);
end;
//! 新着スレッドでIndex番目のスレッドを取得する
function TBoard.GetNewThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountNew, Index);
end;
//! LogありスレッドのIndex番目のスレッドを取得する
function TBoard.GetLogThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountLog, Index);
end;
//! 絞込みでIndex番目のスレッドを取得する
function TBoard.GetUserThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountAll, Index);
end;

procedure TBoard.BeginUpdate;
begin
	FUpdate := False;
end;

procedure TBoard.EndUpdate;
begin
	FUpdate := True;
end;

//constructor TThreadItem.Create(AOwner: TComponent);
procedure TThreadItem.Init;
begin
	FNo := 0;
	FFileName := '';
	FTitle := '';
	FRoundDate := ZERO_DATE;
	FLastModified := ZERO_DATE;
	FCount := 0;
	FAllResCount := 0;
	FNewResCount := 0;
	FSize := 0;
	FRound := False;
	FIsLogFile := False;
	FParentBoard := nil;
	FKokomade := -1;
	FNewReceive := 0;
	FNewArrival := False;

	FUpdate := True;
	FURL := '';
	FJumpAddress := 0;
end;

// *************************************************************************
// 外部板プラグインを指定したコンストラクタ
// *************************************************************************
constructor TThreadItem.Create(
	const inPlugIn : TBoardPlugIn;
	const inBoard : TBoard;
	inURL : string
);
var
	foundPos			: Integer;
	protocol, host, path, document, port, bookmark	: string;
	BBSID, BBSKey	: string;
const
	READ_PATH							= '/test/read.cgi';
begin

	inherited Create;
	Init;
	FParentBoard	:= inBoard;
	//FBoardPlugIn	:= inPlugIn;
	URL				:= inURL;

	if inPlugIn = nil then begin
		foundPos := Pos( READ_PATH, inURL );
		if foundPos > 0 then begin
			// dat の保存パスを設定
			GikoSys.ParseURI( inURL, protocol, host, path, document, port, bookmark );
			GikoSys.Parse2chURL( inURL, path, document, BBSID, BBSKey );
			FileName	:= BBSKey + '.dat';
			IsLogFile	:= FileExists( FilePath );
			URL				:= GikoSys.Get2chBrowsableThreadURL( inURL );
		end;
	end else begin
		// プラグインに TThreadItem が作成されたことを伝える
		inPlugIn.CreateThreadItem( DWORD( Self ) );
	end;

end;
// *************************************************************************
// 外部板プラグインを指定したコンストラクタ Log有りかどうか判断済み
// FileNameも取得済み　→　ReadSubject用
// *************************************************************************
constructor TThreadItem.Create(
	const inPlugIn : TBoardPlugIn;
	const inBoard : TBoard;
	const inURL : string;
	inExist: Boolean;
	const inFilename: string
);
begin

	inherited Create;
	Init;
	FParentBoard	:= inBoard;
	URL				:= inURL;

	if inPlugIn = nil then begin
		// dat の保存パスを設定
		FileName	:= inFilename;
		IsLogFile	:= inExist;
        URL				:= inURL;
	end else begin
		// プラグインに TThreadItem が作成されたことを伝える
		inPlugIn.CreateThreadItem( DWORD( Self ) );
	end;

end;
// *************************************************************************
// デストラクタ
// *************************************************************************
destructor TThreadItem.Destroy;
begin

	// プラグインに TThreadItem が破棄されたことを伝える
	if Self.ParentBoard.IsBoardPlugInAvailable then
		Self.ParentBoard.BoardPlugIn.DisposeThreadItem( DWORD( Self ) );

	inherited;

end;

function TThreadItem.GetDatURL: string;
var
	Protocol, Host, Path, Document, Port, Bookmark: string;
begin
	Result := ParentBoard.URL
					+ 'dat/'
					+ FileName;
	if FDownloadHost <> '' then begin
		GikoSys.ParseURI(Result, Protocol, Host, Path, Document, Port, Bookmark);
		Result := Format('%s://%s%s%s', [Protocol,
																		 FDownloadHost,
																		 Path,
																		 Document]);
	end;
//	Result := GikoSys.UrlToServer(ParentBoard.URL)
//					+ 'test/read.cgi/' + ParentBoard.BBSID + '/'
//					+ ChangeFileExt(FileName, '') + '/?raw='
//					+ IntToStr(ResNum) + '.' + IntToStr(ResSize);
end;

function TThreadItem.GetDatgzURL: string;
	function isOldKako(s: string): Boolean;
	begin
		Result := False;
		if AnsiPos('piza.', s) <> 0 then
			Result := True
		else if AnsiPos('www.bbspink.', s) <> 0 then
			Result := True
		else if AnsiPos('tako.', s) <> 0 then
			Result := True;
	end;
var
	Protocol, Host, Path, Document, Port, Bookmark: string;
	DatNo: string;
begin
	if FDownloadHost = '' then begin
		DatNo := ChangeFileExt(FileName, '');
		if isOldKako(ParentBoard.URL) then begin
			Result := Format('%s%s/%.3s/%s.dat', [ParentBoard.URL, 'kako', DatNo, DatNo]);
		end else begin
			if Length(DatNo) > 9 then begin
				//http://xxx.2ch.net/xxx/kako/9999/99999/999999999.dat.gz
				Result := Format('%s%s/%.4s/%.5s/%s.dat.gz', [ParentBoard.URL, 'kako', DatNo, DatNo, DatNo]);
			end else begin
				//http://xxx.2ch.net/xxx/kako/999/999999999.dat.gz
				Result := Format('%s%s/%.3s/%s.dat.gz', [ParentBoard.URL, 'kako', DatNo, DatNo]);
			end;
		end;
	end else begin
		Gikosys.ParseURI(Result, Protocol, Host, Path, Document, Port, Bookmark);
		DatNo := ChangeFileExt(Document, '');
		if isOldKako(DownloadHost) then begin
			Result := Format('%s://%s/%s/kako/%.3s/%s.dat', [Protocol, DownloadHost, ParentBoard.FBBSID, DatNo, DatNo]);
		end else begin
			if Length(DatNo) > 9 then begin
				Result := Format('%s://%s/%s/kako/%.4s/%.5s/%s.dat.gz', [Protocol, DownloadHost, ParentBoard.FBBSID, DatNo, DatNo, DatNo]);
			end else begin
				Result := Format('%s://%s/%s/kako/%.3s/%s.dat.gz', [Protocol, DownloadHost, ParentBoard.FBBSID, DatNo, DatNo]);
			end;
		end;
	end;
end;

function TThreadItem.GetOfflawCgiURL(const SessionID: string): string;
begin
	if FDownloadHost = '' then begin
		Result := GikoSys.UrlToServer(ParentBoard.URL)
						+ 'test/offlaw.cgi/' + ParentBoard.BBSID + '/'
						+ ChangeFileExt(FileName, '') + '/?raw=.0&sid=' + HttpEncode(SessionID);
	end else begin
		//http://news.2ch.net/test/offlaw.cgi/newsplus/1014038577/?raw=.196928&sid=
		//GikoSys.ParseURI(Result, Protocol, Host, Path, Document, Port, Bookmark);
		Result := 'http://' + FDownloadHost
						+ '/test/offlaw.cgi/' + ParentBoard.BBSID + '/'
						+ ChangeFileExt(FileName, '') + '/?raw=.0&sid=' + HttpEncode(SessionID);
	end;
end;

function TThreadItem.GetOfflaw2SoURL: string;
begin
    Result := GikoSys.UrlToServer(ParentBoard.URL)
                    + 'test/offlaw2.so?shiro=kuma&bbs=' + ParentBoard.BBSID
                    + '&key=' + ChangeFileExt(FileName, '');
end;

function TThreadItem.GetRokkaURL(const SessionID: string): string;
const
	HOST_NAME: array[0..2] of string = ('5ch.net', '5ch.net', 'bbspink.com');
	HOST_CHECK: array[0..2] of string = ('.5ch.net/', '.2ch.net/', '.bbspink.com/');
var
    Domain: string;
    Host: string;
    Idx: Integer;
    HostPos: Integer;
  	i	: Integer;
begin
	if FDownloadHost = '' then begin
    for i := 0 to Length(HOST_NAME) - 1 do begin
      Idx := AnsiPos(HOST_CHECK[i], ParentBoard.URL);
      if (Idx > 0) then begin
        Domain := HOST_NAME[i];
        HostPos := AnsiPos('://', ParentBoard.URL) + 3;
        Host := Copy(ParentBoard.URL, HostPos, Idx - HostPos);
        Break;
      end;
    end;
  end else begin
    for i := 0 to Length(HOST_NAME) - 1 do begin
      Idx := AnsiPos(HOST_CHECK[i], FDownloadHost);
      if (Idx > 0) then begin
        Domain := HOST_NAME[i];
        Host := Copy(FDownloadHost, 1, Idx - 1);
        Break;
      end;
    end;
  end;

  if ((Domain = '') or (Host = '')) then
    Result := ''
  else
    Result := 'http://rokka.' + Domain + '/' + Host + '/'
            + ParentBoard.BBSID + '/' + ChangeFileExt(FileName, '')
            + '/?sid=' + SessionID;
end;

// 外部板過去ログURL取得
function TThreadItem.GetExternalBoardKakoDatURL: string;
var
	DatNo: string;
begin
	DatNo := ChangeFileExt(FileName, '');
	//http://xxx.vip2ch.com/xxx/kako/1234/12345/1234567890.dat
	Result := Format('%s%s/%.4s/%.5s/%s.dat', [ParentBoard.URL, 'kako', DatNo, DatNo, DatNo]);
end;
// 外部板過去ログURL取得

function TThreadItem.GetSendURL: string;
begin
	Result := GikoSys.UrlToServer(ParentBoard.URL)
					+ 'test/bbs.cgi';
end;

procedure TThreadItem.DeleteLogFile;
var
        tmpFileName: String;
begin
	ParentBoard.BeginUpdate;

	if FUnRead then
		ParentBoard.UnRead := ParentBoard.UnRead - 1;
	DeleteFile(GetThreadFileName);
        //試験的にtmpも削除してみる
        tmpFileName := StringReplace(GetThreadFileName, 'dat', 'tmp', [rfReplaceAll]);
        DeleteFile(tmpFileName);

	if FileExists(ChangeFileExt(GetThreadFileName,'.NG')) = true then
		DeleteFile(ChangeFileExt(GetThreadFileName,'.NG'));
	FRoundDate := ZERO_DATE;
	FLastModified := ZERO_DATE;
	FSize := 0;
	FIsLogFile := False;
	FKokomade := -1;
	FNewReceive := 0;
	FNewArrival := False;
	FUnRead := False;
	FScrollTop := 0;
	FRound := False;
	FDownloadHost := '';
	FAgeSage := gasNone;

	FCount := 0;
	FNewResCount := 0;
	FRoundName := '';

	ParentBoard.EndUpdate;
	ParentBoard.Modified := True;
end;

function TThreadItem.GetThreadFileName: string;
begin
	if Length( FilePath ) > 0 then
		Result := FilePath
	else
		Result := GikoSys.Setting.LogFolderP
						+ BBS2CH_LOG_FOLDER + PATH_DELIM + ParentBoard.BBSID + PATH_DELIM + FileName;
end;

procedure TThreadItem.SetLastModified(d: TDateTime);
begin
	if FLastModified = d then Exit;
	FLastModified := d;
	if FUpdate and (ParentBoard <> nil) then
		ParentBoard.FModified := True;
end;

procedure TThreadItem.SetRound(b: Boolean);
begin
	if b then
		RoundList.Add(Self)
	else
		RoundList.Delete(Self);
	if FRound = b then Exit;
	FRound := b;
	if FUpdate and (ParentBoard <> nil) then
		ParentBoard.FModified := True;
end;

procedure TThreadItem.SetRoundName(const s: string);
begin
	if FRoundName = s then Exit;
	FRoundName := s;
	if FUpdate and (ParentBoard <> nil) then
		ParentBoard.FModified := True;
end;


procedure TThreadItem.SetKokomade(i: Integer);
begin
	if FKokomade = i then Exit;
	FKokomade := i;
	if FUpdate and (ParentBoard <> nil) then
		ParentBoard.FModified := True;
end;

procedure TThreadItem.SetUnRead(b: Boolean);
begin
	if FUnRead = b then Exit;
	FUnRead := b;
	if FUpdate and (ParentBoard <> nil) then begin
		ParentBoard.FModified := True;
		if FUnRead then begin
			ParentBoard.UnRead := ParentBoard.UnRead + 1;
		end else begin
            ParentBoard.UnRead := ParentBoard.UnRead - 1;
		end;
	end;
end;

procedure TThreadItem.SetScrollTop(i: Integer);
begin
	if FScrollTop = i then Exit;
	FScrollTop := i;
	if FUpdate and (ParentBoard <> nil) then
		ParentBoard.FModified := True;
end;

procedure TThreadItem.BeginUpdate;
begin
	FUpdate := False;
end;

procedure TThreadItem.EndUpdate;
begin
	FUpdate := True;
end;

function TThreadItem.GetCreateDate: TDateTime;
begin
	// ファイル名からスレ作成日時を求める
	try
		if ( GikoSys.Setting.CreationTimeLogs ) and not IsLogFile  then
            Result := ZERO_DATE
        else begin
            // ログファイルの拡張子をはずしたものがスレ作成日時
            Result := GikoSys.GetCreateDateFromName(FFileName);
			if GikoSys.Setting.FutureThread then begin
        		if CompareDateTime(Result, Now) = 1 then
            		Result := ZERO_DATE;
        	end;
        end;

	except
		on E: Exception do
			Result := ZERO_DATE;
	end;
end;
function TThreadItem.GetFilePath: String;
var
	path : String;
begin
	path := ExtractFilePath(Self.ParentBoard.FilePath) + Self.FileName;
    Result := path;
end;

destructor TBoardGroup.Destroy;
begin
	Clear;
	inherited;
end;
procedure	TBoardGroup.Clear;
var
	i	: Integer;
begin
	for i := Self.Count - 1 downto 0 do begin
		try
			TBoard(Self.Objects[i]).Free;
		except
		end;
    end;
    inherited Clear;
	Self.Capacity := 0;
	try
		if FBoardPlugIn <> nil then
			FBoardPlugIn.Free;
        FBoardPlugIn := nil;
	except
	end;

end;

function TSpecialBoard.Add(item: TThreadItem): integer;
begin
    Result := inherited AddObject(Item.URL, Item);
end;

procedure TSpecialBoard.Clear;
var
	i: integer;
begin
    for i := Count - 1 downto 0 do
		DeleteList(i);
    Capacity := 0;
end;

///////////////
constructor TThreadNgList.Create;
begin
	inherited Create;

	FFilePath := GikoSys.GetNGWordsDir;
	if not DirectoryExists(FFilePath) then
		ForceDirectories(FFilePath);
	if (FFilePath[Length(FFilePath)] <> '\') then
		FFilePath := FFilePath + '\';
	FFilePath := FFilePath + THREAD_NG_FILE;
	Load;
end;

procedure TThreadNgList.Load;
begin
	if (FileExists(FFilePath)) then begin
		try
			LoadFromFile(FFilePath);
		finally
		end;
	end;
end;

procedure TThreadNgList.Save;
begin
	try
		SaveToFile(FFilePath);
	finally
	end;
end;

function TThreadNgList.IsNG(const Title: String): Boolean;
var
    Cnt: Integer;
    MaxCnt: Integer;
begin
    MaxCnt := Count - 1;
    for Cnt := 0 to MaxCnt do begin
        if (Pos(Strings[Cnt], Title) > 0) then begin
            Result := True;
            Exit;
        end;
    end;
    Result := False;
end;

end.

