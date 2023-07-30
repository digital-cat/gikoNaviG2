unit BoardGroup;

interface

uses
	Windows, SysUtils, Classes, ComCtrls, {HTTPApp,} YofUtils, IdGlobal,
	ExternalBoardManager, ExternalBoardPlugInMain, StrUtils;

type
	//���X�g�̕\���A�C�e���I��
	TGikoViewType = (gvtAll, gvtLog, gvtNew, gvtLive, gvtArch, gvtUser);
	//���X�g�̏グ����
	TGikoAgeSage = (gasNone, gasAge, gasSage, gasNew, gasArch, gasNull);

	TCategory = class;
	TBoard = class;
	TThreadItem = class;


	// BBS �̃��[�g
	TBBS = class(TList)
	private
		FTitle: string;
		FFilePath : string;						// ���X�g�̃p�X
		FExpand: Boolean;
		FKubetsuChk: Boolean;					//�i���ݎ��啶�����������
		FSelectText: string;					//�i���ݕ�����
		FShortSelectText: string;
		FIsBoardFileRead : Boolean;		// ���X�g�͓ǂݍ��܂�Ă��邩�H

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

	// �J�e�S��(�� URL �̃��X�g)
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

 	//! �X���b�h���J�E���g������
	TThreadCount = function(Item : TThreadItem): Boolean;

	// ��(�X���b�h URL �̃��X�g)
	TBoard = class(TStringList)
	private
		FContext: DWORD;							// �v���O�C�������R�ɐݒ肵�Ă����l(��ɃC���X�^���X������)

		FNo: Integer;									//�ԍ�
		FTitle: string;								//�{�[�h�^�C�g��
		FBBSID: string;								//BBSID
		FURL: string;									//�{�[�hURL
		FRound: Boolean;							//�X���b�h�ꗗ����\��
		FRoundName: string;						//����
		FRoundDate: TDateTime;				//�X���b�h�ꗗ���擾���������i��������j
		FLastModified: TDateTime;			//�X���b�h�ꗗ���X�V����Ă�������i�T�[�o�������j
		FLastGetTime: TDateTime;			//�X���b�h�܂��̓X���b�h�ꗗ���Ō�ɍX�V���������i�T�[�o�������E�������ݎ��Ɏg�p����j
		FIsThreadDatRead: Boolean;		//�X���b�h���X�g�͓ǂݍ��܂�Ă��邩�H
		FUnRead: Integer;							//�X���b�h���ǐ�
		FParentCategory: TCategory;		//�e�J�e�S��
		FModified: Boolean;						//�C���t���O
		FBoolData: Boolean;						//�����ȗp�r�Ɏg��yo
		FSPID: string;								//�������ݗpSPID
		FPON: string;									//�������ݗpPON
		FCookie: string;						//�������ݗpCookie������
		FExpires: TDateTime;					//Cookie�̗L������
		FKotehanName: string;					//�R�e�n�����O
		FKotehanMail: string;					//�R�e�n�����[��

		FUpdate: Boolean;
		FExpand: Boolean;

		FBoardPlugIn	: TBoardPlugIn;	// ���̔��T�|�[�g����v���O�C��
		FFilePath			: string;				// ���̃X���ꗗ���ۑ�����Ă���p�X
		FIsLogFile		: Boolean;			// ���O���݃t���O
		FIntData			: Integer;			// �D���ɂ������Ă悵�B�����ȗp�r�Ɏg��yo
		FListData			: TList;				// �D���ɂ������Ă悵�B�����ȗp�r�Ɏg��yo

		FSETTINGTXTTime : TDateTime;	//SETTING.TXT���擾��������
		FIsSETTINGTXT	: boolean;	//SETTING.TXT���擾���Ă��邩
		FHEADTXTTime	: TDateTime;		//HEAD.TXT���擾��������
		FIsHEADTXT		: boolean;	//HEAD.TXT���擾���Ă��邩
		FTitlePictureURL: string;	//top�G��URL
		FMultiplicity	: Integer; //�d�����Ă��邩�ǂ����H
		FIs2ch			: Boolean; //host��2ch���ǂ���
		FNewThreadCount: Integer;	//�V���X���b�h�̐�
		FLogThreadCount: Integer;	//���O�L��X���b�h�̐�
		FUserThreadCount: Integer;	//�H
		FLiveThreadCount: Integer;	//�����X���b�h��
		FArchiveThreadCount: Integer;	//DAT�����X���b�h��
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
		property NewThreadCount: Integer	read FNewThreadCount write FNewThreadCount;	//�V���X���b�h�̐�
		property LogThreadCount: Integer	read FLogThreadCount write FLogThreadCount;		//���O�L��X���b�h�̐�
		property UserThreadCount: Integer	read FUserThreadCount write FUserThreadCount;	//�H
		property LiveThreadCount: Integer	read FLiveThreadCount write	FLiveThreadCount;
		property ArchiveThreadCount: Integer read FArchiveThreadCount write FArchiveThreadCount;

		property Cookie: string 			read FCookie write FCookie;
		property Expires: TDateTime 			read FExpires write FExpires;
	end;

	//�X��
	TThreadItem = class(TObject)
	private
		FContext: DWORD;					// �v���O�C�������R�ɐݒ肵�Ă����l(��ɃC���X�^���X������)
		FNo: Integer;							//�ԍ�
		FFileName: string;				//�X���b�h�t�@�C����
		FTitle: string;						//�X���b�h�^�C�g��
		FShortTitle: string;			//�Z���X���b�h�^�C�g���i�����p�j
		FRoundDate: TDateTime;		//�X���b�h���擾���������i��������j
		FLastModified: TDateTime; //�X���b�h���X�V����Ă�������i�T�[�o�������j
		FCount: Integer;					//�X���b�h�J�E���g�i���[�J���j
		FAllResCount: Integer;		//�X���b�h�J�E���g�i�T�[�o�j
		FNewResCount: Integer;		//�X���b�h�V����
		FSize: Integer;						//�X���b�h�T�C�Y
		FRound: Boolean;					//����t���O
		FRoundName: string;				//����
		FIsLogFile: Boolean;			//���O���݃t���O
		FParentBoard: TBoard;			//�e�{�[�h
		FKokomade: Integer;				//�R�R�܂œǂ񂾔ԍ�
		FNewReceive: Integer; 		//�R�R����V�K��M
		FNewArrival: Boolean;			//�V��
		FUnRead: Boolean;					//���ǃt���O
		FScrollTop: Integer;			//�X�N���[���ʒu
		FDownloadHost: string;		//���̃z�X�g�ƈႤ�ꍇ�̃z�X�g
		FAgeSage: TGikoAgeSage;		//�A�C�e���̏グ����
		FUpdate: Boolean;
		FExpand: Boolean;
		FURL					: string;				// ���̃X�����u���E�U�ŕ\������ۂ� URL
		FJumpAddress : Integer; 	//���X�ԍ��w��URL�𓥂񂾂Ƃ��Ɏw�肳��郌�X�̔ԍ�������
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
//////////////// 2013/10/13 ShiroKuma�Ή� zako Start ///////////////////////////
        function GetOfflaw2SoURL: string;
//////////////// 2013/10/13 ShiroKuma�Ή� zako End /////////////////////////////
        function GetRokkaURL(const SessionID: string): string;  // Rokka�Ή�  
		function GetExternalBoardKakoDatURL: string; // �O���ߋ����OURL�擾
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
    	FBoardPlugIn	: TBoardPlugIn;	// ���̔��T�|�[�g����v���O�C��
    public
		destructor Destroy; override;
		procedure	Clear	; override;
        property	BoardPlugIn	: TBoardPlugIn	read FBoardPlugIn write FBoardPlugIn;
    end;

    // ����p�r�pTBoard
    TSpecialBoard = class(TBoard)
    public
        function Add(item: TThreadItem): integer; overload;
        procedure Clear; overload;
    end;

    // �X���b�h��NG���[�h���X�g
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
	BBS2CH_NAME:					 string	= '�Q�����˂�';
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
    

//! ���O�������Ă���Ȃ�^��Ԃ�
function CountLog(Item: TThreadItem): Boolean;
begin
	Result := Item.IsLogFile;
end;
//! �V���Ȃ�^��Ԃ�
function CountNew(Item: TThreadItem): Boolean;
begin
	Result := Item.NewArrival;
end;
//! DAT�����Ȃ�^��Ԃ�
function CountDat(Item: TThreadItem): Boolean;
begin
	Result := (Item.AgeSage = gasArch);
end;
//! �����X���Ȃ�^��Ԃ�
function CountLive(Item: TThreadItem): Boolean;
begin
	Result := (Item.AgeSage <> gasArch);
end;

//! ��ɐ^
function CountAll(Item: TThreadItem): Boolean;
begin
    Result := True;
end;



// BBSID ��p���� 2 �����˂�̂ݒT���o���܂�
// BBSID �̎g�p�͋ɗ͔����Ă��������B
// �\�ȏꍇ�� URL ���g�p���Ă��������B
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
���̊֐��͕K����URL�̌`���œn���Ă��������B
plugin���g�p����Ȃ�΁AExtractBoardURL( inURL )
2ch�Ȃ�΁AGikoSys.Get2chThreadURL2BoardURL( inURL );
�ŕϊ����Ă���Ăяo���Ă��������B
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
	//�����ɂ�����Aplugin���g��Ȃ����𒲂ׂ�
	if BoardGroups[0].Find(inURL, p) then
		Result := TBoard(BoardGroups[0].Objects[p]);
		
	if (Result = nil) then begin
		GikoSys.ParseURI( inURL, protocol, host, path, document, port, bookmark );
		//�z�X�g��2ch�Ȃ�BBSID�Œ��ׂ�
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
		//������2ch�̔Ȃ�
		if (Result = nil) and (board.Is2ch) then begin
			GikoSys.ParseURI( chkURL, protocol, host, path, document, port, bookmark );
			GikoSys.Parse2chURL( chkURL, path, document, BBSID, BBSKey );
			Result := board.FindThreadFromFileName(BBSKey + '.dat');
		end else if (Result = nil) and not (board.Is2ch) then begin
		//�v���O�C���n�̒T���i���URL���r���ŕύX�ɂȂ�����)
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
\brief ����p�rBBS�폜
\param bbs �폜�������p�rBBS
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
 *�@�\���FTBBS�R���X�g���N�^
 *Public
 *************************************************************************)
constructor TBBS.Create( boardFilePath : string );
begin
	inherited Create;
	Title := BBS2CH_NAME;
	FFilePath := boardFilePath;
end;

(*************************************************************************
 *�@�\���FTBBS�f�X�g���N�^
 *Public
 *************************************************************************)
destructor TBBS.Destroy;
begin
	Clear;
	inherited;
end;

(*************************************************************************
 *�@�\���F
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
// �^�C�g���̈�v�����T��
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
// �J�e�S�����Ɣ��̈�v�����T��
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
// �J�e�S�����Ɣ�URL�̈�v�����T��
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
// URL ���󂯕t�����T��
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
// URL ���󂯕t����X���b�h��T��
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
// �^�C�g���̈�v�����T��
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
// URL ���󂯕t�����T��
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
// �z�X�g����������URL�Ŕ�T���i5ch.net/2ch.net/bbspink.com����j
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
// URL ���󂯕t����X���b�h��T��
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
// �O���v���O�C�����w�肵���R���X�g���N�^
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
		// subject.txt �̕ۑ��p�X��ݒ�
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
		// �v���O�C���� TBoardItem ���쐬���ꂽ���Ƃ�`����
		inPlugIn.CreateBoardItem( DWORD( Self ) );
		//Self.Is2ch := False;	//plugin���Őݒ肷��
	end;

end;

// *************************************************************************
// �f�X�g���N�^
// *************************************************************************
destructor TBoard.Destroy;
begin
	if FModified then begin
		GikoSys.WriteThreadDat(Self);
		SaveSettings;
	end;

	// �v���O�C���� TBoardItem ���j�����ꂽ���Ƃ�`����
	if IsBoardPlugInAvailable then
		BoardPlugIn.DisposeBoardItem( DWORD( Self ) );

	Clear;
	inherited;
end;

// *************************************************************************
// �O���v���O�C�����g�p�\��
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

//Index�Ŏw�肳�ꂽ�X���b�h�I�u�W�F�N�g��j��
procedure TBoard.Delete(index: Integer);
begin
	if Items[index] <> nil then
		TThreadItem(Items[index]).Free;
	inherited Delete(index);
end;

//Index�Ŏw�肳�ꂽ�X���b�h�����X�g����폜�i�X���I�u�W�F�N�g�͂̂����j
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
//�Ƃ�����2003 02 08 0:32:13����Ȍ`���̓��t������̂ł����
//        2003/02/08 0:32:13�ɕϊ�����
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
//! �T�u�W�F�N�gURL�擾
function TBoard.GetReadCgiURL: string;
begin
	Result := URL + SUBJECT_FILENAME;

end;

//! �T�u�W�F�N�g�t�@�C�����擾�i�p�X�{�t�@�C�����j
function TBoard.GetSubjectFileName: string;
begin
	if Length( FilePath ) > 0 then
		Result := FilePath
	else
		Result := GikoSys.Setting.LogFolderP
						+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + SUBJECT_FILENAME;
end;

//! �C���f�b�N�X�t�@�C����(folder.idx)�擾�i�p�X�{�t�@�C�����j
function TBoard.GetFolderIndexFileName: string;
begin
	if Length( FilePath ) > 0 then
		Result := ExtractFilePath( FilePath ) + FOLDER_INDEX_FILENAME
	else
		Result := GikoSys.Setting.LogFolderP
						+ BBS2CH_LOG_FOLDER + PATH_DELIM + BBSID + PATH_DELIM + FOLDER_INDEX_FILENAME;
end;
//! SETTING.TXT�̃t�@�C�����擾
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

// �X�����đ��MURL
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
//! func�̏����Ɉ�v����X���b�h�̐���Ԃ�
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
//! �V���X���b�h�̐����擾����
function TBoard.GetNewThreadCount: Integer;
begin
	Result := GetThreadCount(CountNew);
end;
//! ���O�L��X���b�h�̐����擾����
function TBoard.GetLogThreadCount: Integer;
begin
	Result := GetThreadCount(CountLog);
end;
//! �i���ݏ����Ɉ�v����X���b�h�̐����擾����
function TBoard.GetUserThreadCount: Integer;
begin
	Result := GetThreadCount(CountAll);
end;
//! DAT�����X���b�h�̐����擾����
function TBoard.GetArchiveThreadCount: Integer;
begin
	Result := GetThreadCount(CountDat);
end;
//! �����X���b�h�̐����擾����
function TBoard.GetLiveThreadCount: Integer;
begin
	Result := GetThreadCount(CountLive);
end;
//! func�̏����ɓK������Index�Ԗڂ̃X���b�h���擾����
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
//! DAT�����X���b�h��Index�Ԗڂ̃X���b�h���擾����
function TBoard.GetArchiveThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountDat, Index);
end;
//! �����X���b�h��Index�Ԗڂ̃X���b�h���擾����
function TBoard.GetLiveThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountLive, Index);
end;
//! �V���X���b�h��Index�Ԗڂ̃X���b�h���擾����
function TBoard.GetNewThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountNew, Index);
end;
//! Log����X���b�h��Index�Ԗڂ̃X���b�h���擾����
function TBoard.GetLogThread(Index: Integer): TThreadItem;
begin
	Result := GetThread(CountLog, Index);
end;
//! �i���݂�Index�Ԗڂ̃X���b�h���擾����
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
// �O���v���O�C�����w�肵���R���X�g���N�^
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
			// dat �̕ۑ��p�X��ݒ�
			GikoSys.ParseURI( inURL, protocol, host, path, document, port, bookmark );
			GikoSys.Parse2chURL( inURL, path, document, BBSID, BBSKey );
			FileName	:= BBSKey + '.dat';
			IsLogFile	:= FileExists( FilePath );
			URL				:= GikoSys.Get2chBrowsableThreadURL( inURL );
		end;
	end else begin
		// �v���O�C���� TThreadItem ���쐬���ꂽ���Ƃ�`����
		inPlugIn.CreateThreadItem( DWORD( Self ) );
	end;

end;
// *************************************************************************
// �O���v���O�C�����w�肵���R���X�g���N�^ Log�L�肩�ǂ������f�ς�
// FileName���擾�ς݁@���@ReadSubject�p
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
		// dat �̕ۑ��p�X��ݒ�
		FileName	:= inFilename;
		IsLogFile	:= inExist;
        URL				:= inURL;
	end else begin
		// �v���O�C���� TThreadItem ���쐬���ꂽ���Ƃ�`����
		inPlugIn.CreateThreadItem( DWORD( Self ) );
	end;

end;
// *************************************************************************
// �f�X�g���N�^
// *************************************************************************
destructor TThreadItem.Destroy;
begin

	// �v���O�C���� TThreadItem ���j�����ꂽ���Ƃ�`����
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

// �O���ߋ����OURL�擾
function TThreadItem.GetExternalBoardKakoDatURL: string;
var
	DatNo: string;
begin
	DatNo := ChangeFileExt(FileName, '');
	//http://xxx.vip2ch.com/xxx/kako/1234/12345/1234567890.dat
	Result := Format('%s%s/%.4s/%.5s/%s.dat', [ParentBoard.URL, 'kako', DatNo, DatNo, DatNo]);
end;
// �O���ߋ����OURL�擾

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
        //�����I��tmp���폜���Ă݂�
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
	// �t�@�C��������X���쐬���������߂�
	try
		if ( GikoSys.Setting.CreationTimeLogs ) and not IsLogFile  then
            Result := ZERO_DATE
        else begin
            // ���O�t�@�C���̊g���q���͂��������̂��X���쐬����
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

