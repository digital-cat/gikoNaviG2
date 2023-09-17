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
			vrComments,         //!< �R�����g
			vrCompanyName,      //!< ��Ж�
			vrFileDescription,  //!< ����
			vrFileVersion,      //!< �t�@�C���o�[�W����
			vrInternalName,     //!< ������
			vrLegalCopyright,   //!< ���쌠
			vrLegalTrademarks,  //!< ���W
			vrOriginalFilename, //!< �����t�@�C����
			vrPrivateBuild,     //!< �v���C�x�[�g�r���h���
			vrProductName,      //!< ���i��
			vrProductVersion,   //!< ���i�o�[�W����
			vrSpecialBuild);    //!< �X�y�V�����r���h���

	//! BBS�^�C�v
	TGikoBBSType = (gbt2ch);
	//! ���O�^�C�v
	TGikoLogType = (glt2chNew, glt2chOld);
	//! ���b�Z�[�W�A�C�R��
	TGikoMessageIcon = (gmiOK, gmiSAD, gmiNG, gmiWhat, gmiNone);
	//! URL�I�[�v���u���E�U�^�C�v
	TGikoBrowserType = (gbtIE, gbtUserApp, gbtAuto);


	TStrTokSeparator = set of Char;
	TStrTokRec = record
		Str: string;
		Pos: Integer;
	end;

	//! �C���f�b�N�X�t�@�C�����R�[�h
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
		FMishiyou: Boolean;	//!< ���g�p
		FUnRead: Boolean;
		FScrollTop: Integer;
		//Index Ver 1.01
		FAllResCount: Integer;
		FNewResCount: Integer;
		FAgeSage: TGikoAgeSage;
	end;

	//! �T�u�W�F�N�g���R�[�h
	TSubjectRec = record
		FFileName: string;
		FTitle: string;
		FCount: Integer;
	end;

	//! ���X���R�[�h�ւ̃|�C���^
	PResRec = ^TResRec;

	//! ���X���R�[�h
	TResRec = record
		FTitle: string;
		FMailTo: string;
		FName: string;
		FDateTime: string;
		FBody: string;
		FType: TGikoLogType;
	end;

	//! URLPath���R�[�h
	TPathRec = record
		FBBS: string;				//!< BBSID
		FKey: string;				//!< ThreadID
		FSt: Int64;				  //!< �J�n���X��
		FTo: Int64;				  //!< �I�����X��
		FFirst: Boolean;		//!< >>1�̕\��
		FStBegin: Boolean;	//!< 1�`�\��
		FToEnd: Boolean;		//!< �`�Ō�܂ŕ\��
		FDone: Boolean;			//!< ����
		FNoParam: Boolean;  //!< ���X�ԃp�����[�^�Ȃ�
	end;

	TGikoSys = class(TObject)
	private
		{ Private �錾 }
		FSetting: TSetting;
//		FDolib: TDolib;
		FAWKStr: TAWKStr;
		FResRange : Longint;
		FBayesian	: TGikoBayesian;	//!< �x�C�W�A���t�B���^
		FVersion : String;		      //!< �t�@�C���o�[�W����
		FGikoMessage: TGikoMessage;
        FBelib: TBelib;
		//! ����Z�p���[�^�ŋ�؂�ꂽ�����񂩂炎�Ԗڂ̕���������o��
		function ChooseString(const Text, Separator: string; Index: integer): string;
        //! �ꎞ�t�@�C������̕���
        procedure RestoreThreadData(Board: TBoard);
	public
		{ Public �錾 }
		FAbon : TAbon;
		FSelectResFilter : TAbon;
		//FBoardURLList: TStringList;
		constructor Create;

		destructor Destroy; override;
		property ResRange : Longint read FResRange write FResRange;
		//! �o�[�W�������
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
		procedure GetFileList(Path: string; Mask: string; var List: TStringList; IsPathAdd: Boolean); overload;//�T�u�t�H���_�͌������Ȃ�
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
		//! �P����
		procedure SpamCountWord( const text : string; wordCount : TWordCount );
		//! �w�K�N���A
		procedure SpamForget( wordCount : TWordCount; isSpam : Boolean );
		//! �X�p���w�K
		procedure SpamLearn( wordCount : TWordCount; isSpam : Boolean );
		//! �X�p���x��
		function SpamParse( const text : string; wordCount : TWordCount ) : Extended;

		//! �����ɑ����Ă������t/ID����BE�̕����񂪂�������A�v���t�@�C���ւ̃����N��ǉ�
		function AddBeProfileLink(AID : string; ANum: Integer): string;
		//! �o�[�W�������̎擾
		function GetVersionInfo(KeyWord: TVerResourceKey): string;
		//! Plugin�̏��̎擾
		function GetPluginsInfo(): string;
		//! IE�̃o�[�W�������̎擾
		function GetIEVersion: string;
		function SetUserOptionalStyle(): string;
		//! �M�R�i�r�̃��b�Z�[�W��ݒ肷��
		procedure SetGikoMessage;
		//! �M�R�i�r�̃��b�Z�[�W���擾����
		function GetGikoMessage(MesType: TGikoMessageListType): String;
		//! GMT�̎�����TDateTime�ɕϊ�����
		function  DateStrToDateTime(const DateStr: string): TDateTime;
        //! User32.dll�����p�ł��邩
        function CanUser32DLL: Boolean;
        //! OE���p���擾
        function GetOEIndentChar : string;
        //! �u���ݒ�t�@�C���擾
        function GetReplaceFileName: String;
        //! �C���f�b�N�X�ɂȂ�dat�i�͂���dat�j�̒ǉ�
        procedure AddOutofIndexDat(Board: TBoard; DatList: TStringList; AllCreate: boolean = True);
        //! �t�@�C��������̃X���b�h�쐬���̎擾
        function GetCreateDateFromName(FileName: String): TDateTime;
        function GetExtpreviewFileName: String;

        procedure ShowRefCount(msg: String; unk: IUnknown);
        //! �`���̏�Cookie�擾
        function GetBoukenCookie(AURL: String): String;
        //! �`���̏�Cookie�ݒ�
        procedure SetBoukenCookie(ACookieValue, ADomain: String);
        //! �`���̏�Cookie�폜
        procedure DelBoukenCookie(ADomain: String);
        //! �`���̏�Domain�ꗗ�擾
        procedure GetBoukenDomain(var ADomain: TStringList);
        //! �`���̏��h���C����Cookie�擾
        function GetBouken(AURL: String; var Domain: String): String;
    //! �w�蕶����폜
    procedure DelString(del: String; var str: String);
    //! 2ch/5ch��URL�����ۂɌĂׂ�`�ɂ���
    procedure Regulate2chURL(var url: String);
    //! 2ch/5ch��URL���ǂ���
    function Is2chURL(url: String): Boolean;
    //! ������΂�URL���ǂ���
    function IsShitarabaURL(url: String): Boolean;
	end;

var
	GikoSys: TGikoSys;
const
	//LENGTH_RESTITLE			= 40;
	ZERO_DATE: Integer	= 25569;
	BETA_VERSION_NAME_E = 'beta';
	BETA_VERSION_NAME_J = '���';
	BETA_VERSION				= 73;
	BETA_VERSION_BUILD	= '';				//!< debug�łȂ�
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
//! GikoSys�R���X�g���N�^
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
	// �i�荞�ނƂ��͋ɗ͈ꗗ��������ق��������̂ő��͊��S�ɍ폜
	FSelectResFilter.AbonString := '';
    ///
	ResRange := FSetting.ResRange;
	FVersion := Trim(GetVersionInfo(vrFileVersion));
	FBayesian := TGikoBayesian.Create;
	//FBoardURLList := TStringList.Create;
	//���b�Z�[�W�̍쐬
	FGikoMessage := TGikoMessage.Create;
end;

// *************************************************************************
//! GikoSys�f�X�g���N�^
// *************************************************************************
destructor TGikoSys.Destroy;
var
	i: Integer;
	FileList: TStringList;
begin
	//�e���|����HTML���폜
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
\brief �����񐔎��`�F�b�N
\param s �`�F�b�N���镶����
\return s �������t�������Ƃ��ĔF���\�Ȃ� True
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
\brief �����񕂓������_�����`�F�b�N
\param s �`�F�b�N���镶����
\return s �������t�����������Ƃ��ĔF���\�Ȃ� True
}
function TGikoSys.IsFloat(s: string): boolean;
var
	v: Extended;
begin
	Result := TextToFloat(PChar(s), v, fvExtended);
end;

// *************************************************************************
//! �{�[�h�t�@�C�����擾�i�p�X�{�t�@�C�����j
// *************************************************************************
function TGikoSys.GetBoardFileName: string;
begin
	Result := Setting.GetBoardFileName;
end;

// *************************************************************************
//! �{�[�h�t�@�C�����擾�i�p�X�{�t�@�C�����j
// *************************************************************************
function TGikoSys.GetCustomBoardFileName: string;
begin
	Result := Setting.GetCustomBoardFileName;
end;

// *************************************************************************
//! �e���|�����t�H���_�[���擾
// *************************************************************************
function TGikoSys.GetHtmlTempFileName: string;
begin
	Result := Setting.GetHtmlTempFileName;
end;


// *************************************************************************
//! ���s�t�@�C���t�H���_�擾
// *************************************************************************
function TGikoSys.GetAppDir: string;
begin
	Result := Setting.GetAppDir;
end;

// *************************************************************************
//! TempHtml�t�@�C�����擾�i�p�X�{�t�@�C�����j
// *************************************************************************
function TGikoSys.GetTempFolder: string;
begin
	Result := Setting.GetTempFolder;
end;

// *************************************************************************
//! sent.ini�t�@�C�����擾�i�p�X�{�t�@�C�����j
// *************************************************************************)
function TGikoSys.GetSentFileName: string;
begin
	Result := Setting.GetSentFileName;
end;

// *************************************************************************
//! outbox.ini�t�@�C�����擾�i�p�X�{�t�@�C�����j
// *************************************************************************
function TGikoSys.GetOutBoxFileName: string;
begin
	Result := Setting.GetOutBoxFileName;
end;

// *************************************************************************
//! Config�t�H���_�擾
// *************************************************************************
function TGikoSys.GetConfigDir: string;
begin
	Result := Setting.GetConfigDir;
end;

function TGikoSys.GetNGWordsDir: string;
begin
	Result := Setting.GetConfigDir + NGWORDs_DIR_NAME;
end;


//! �X�^�C���V�[�g�t�H���_
function TGikoSys.GetStyleSheetDir: string;
begin
	Result := Setting.GetStyleSheetDir;
end;

//! �X�L���t�H���_
function TGikoSys.GetSkinDir: string;
begin
	Result := Setting.GetSkinDir;
end;

//! Skin:�w�b�_�̃t�@�C����
function TGikoSys.GetSkinHeaderFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinHeaderFileName;
end;

//! Skin:�t�b�^�̃t�@�C����
function TGikoSys.GetSkinFooterFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinFooterFileName;
end;

//! Skin:�V�����X�̃t�@�C����
function TGikoSys.GetSkinNewResFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinNewResFileName;
end;

//! Skin:��V�����X�̃t�@�C����
function TGikoSys.GetSkinResFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinResFileName;
end;

//! Skin:������(�����܂œǂ�)�̃t�@�C����
function TGikoSys.GetSkinBookmarkFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinBookmarkFileName;
end;

//! Skin:������(�V�����X)�̃t�@�C����
function TGikoSys.GetSkinNewmarkFileName: string;
begin
	Result := Setting.SkinFiles.GetSkinNewmarkFileName;
end;

//! UserAgent�擾
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
\brief �o�ߕb�� TDateTime �ɕϊ�
\param val 1970/1/1/ 00:00:00 ����̌o�ߕb
\return val ������ TDateTime
}
function TGikoSys.IntToDateTime(val: Int64): TDateTime;
begin
	Result := ZERO_DATE + val / 86400.0;
end;

{!
\brief TDateTime ���o�ߕb�ɕϊ�
\param ADate �ϊ����鎞��
\return 1970/1/1/ 00:00:00 ����̌o�ߕb
}
function TGikoSys.DateTimeToInt(ADate: TDateTime): Int64;
begin
	Result := Trunc((ADate - ZERO_DATE) * 86400);
end;


{!
\brief Subject�t�@�C��Read
\param Board �X���ꗗ���擾�����
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
    // �X���b�h�ŋ��ʂ�URL��
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
        //IsLogFile�pDAT�t�@�C�����X�g
        GetFileList(ExtractFileDir(Board.GetFolderIndexFileName), '*.dat', FileList, False);
        FileList.EndUpdate;
    end;

	// �d����h��
	Board.BeginUpdate;
	Board.Sorted := True;
	sl := TStringList.Create;
	try
		if FileExists(FileName) then begin
			sl.LoadFromFile(FileName);
			//�Q�s�ڂ���i�P�s�ڂ̓o�[�W�����j
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
				{* ���C�ɓ����ʐ����R�[�h *}
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
		    //�C���f�b�N�X�ɖ����������O��ǉ��i����C���f�b�N�X�Ή��j
            AddOutofIndexDat(Board, FileList);
        end;
		Board.EndUpdate;

        //�O��ُ�I�����`�F�b�N
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
\brief �C���f�b�N�X�ɂȂ�dat�i�͂���dat�j�̒ǉ�
\param Board �ǉ������
\param DatList  dat�t�@�C����
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
    //�C���f�b�N�X�ɖ����������O��ǉ��i����C���f�b�N�X�Ή��j
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
        ThreadItem.Size := GetFileSize(FileName) - ThreadItem.Count;//1byte�����Ƃ������邯�ǂ���͂�����߂�
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
\brief �X���b�h�C���f�b�N�X�t�@�C��(Folder.idx)�쐬
\param Board Folder.idx ���쐬�����
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

				{s := Format('%x', [cnt]) + #1					//�ԍ�
					 + Rec.FFileName + #1								//�t�@�C����
					 + Rec.FTitle + #1									//�^�C�g��
					 + Format('%x', [Rec.FCount]) + #1	//�J�E���g
					 + Format('%x', [0]) + #1						//size
					 + Format('%x', [0]) + #1						//RoundDate
					 + Format('%x', [0]) + #1						//LastModified
					 + Format('%x', [0]) + #1						//Kokomade
					 + Format('%x', [0]) + #1						//NewReceive
					 + '0' + #1					 							//���g�p
					 + Format('%x', [0]) + #1						//UnRead
					 + Format('%x', [0]) + #1						//ScrollTop
					 + Format('%x', [Rec.FCount]) + #1	//AllResCount
					 + Format('%x', [0]) + #1						//NewResCount
					 + Format('%x', [0]);								//AgeSage
				}
				s := Format('%x'#1'%s'#1'%s'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x'#1 + 
							'%s'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x',
					[cnt,			//�ԍ�
					 Rec.FFileName, //�t�@�C����
					 MojuUtils.Sanitize(Rec.FTitle),    //�^�C�g��
					 Rec.FCount,     //�J�E���g
					 0,             //size
					 0,             //RoundDate
					 0,				//LastModified
					 0,				//Kokomade
					 0,				//NewReceive
					 '0',			//���g�p
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
\brief �X���b�h�C���f�b�N�X(Thread.dat)��������
\param Thread.dat ���쐬�����
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

		// �X���ԍ��ۑ��̂��߃\�[�g
		Sort.SetSortNoFlag(true);
		Sort.SetSortOrder(true);
		Sort.SetSortIndex(0);
		//Sort.SortNonAcquiredCountFlag := GikoSys.Setting.NonAcquiredCount;
		Board.CustomSort(ThreadItemSortProc);

		for i := 0 to Board.Count - 1 do begin
			Board.Items[i].No := i + 1;
			s := Format('%x'#1'%s'#1'%s'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x'#1 +
							'%s'#1'%x'#1'%x'#1'%x'#1'%x'#1'%x',
					[Board.Items[i].No,			//�ԍ�
					 Board.Items[i].FileName, //�t�@�C����
                     MojuUtils.Sanitize(Board.Items[i].Title),    //�^�C�g��
					 Board.Items[i].Count,     //�J�E���g
					 Board.Items[i].Size,             //size
					 DateTimeToInt(Board.Items[i].RoundDate),             //RoundDate
					 DateTimeToInt(Board.Items[i].LastModified),				//LastModified
					 Board.Items[i].Kokomade,				//Kokomade
					 Board.Items[i].NewReceive,				//NewReceive
					 '0',			//���g�p
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
\brief Folder.idx �� 1 �s����
\param Line Folder.idx ���\������ 1 �s
\return �X���b�h���
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
	MojuUtils.RemoveToken(Line, #1);//9: ;	//���g�p
	Result.FUnRead := IntToBool(StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0));
	Result.FScrollTop := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FAllResCount := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FNewResCount := StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0);
	Result.FAgeSage := TGikoAgeSage(StrToIntDef('$' + MojuUtils.RemoveToken(Line, #1), 0));

end;

{!
\brief �w��t�H���_���̎w��t�@�C���ꗗ���擾����
\param Path      �N�_�ƂȂ�t�H���_�p�X
\param Mask      �t�@�C�����̃}�X�N
\param List      OUT:�擾���ꂽ�t�@�C�����ꗗ���Ԃ�
\param SubDir    ���̃t�H���_�܂ōċA�I�Ƀ��X�g����ꍇ�� True
\param IsPathAdd �p�X�t���Ń��X�g�A�b�v����ꍇ�� True

Mask �� '*.txt' �̂悤�Ɏw�肷�邱�ƂŁA
����̃t�@�C���������̊g���q�ɍi�������X�g�A�b�v���\�ł��B

\par ��:
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
\breif �w��t�H���_���̎w��t�@�C���ꗗ���擾����B
			 �T�u�t�H���_�͌������Ȃ�
\param Path      �N�_�ƂȂ�t�H���_�p�X
\param Mask      �t�@�C�����̃}�X�N
\param List      OUT:�擾���ꂽ�t�@�C�����ꗗ���Ԃ�
\param IsPathAdd �p�X�t���Ń��X�g�A�b�v����ꍇ�� True
\note �ċN�w��\�� GetFileList() ������̂ł��̊֐��͕s�v?
\par ��
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
\brief �w��t�H���_���̃f�B���N�g���ꗗ���擾����
\param Path      �N�_�ƂȂ�t�H���_�p�X
\param Mask      �t�H���_���̃}�X�N
\param List      OUT:�擾���ꂽ�t�H���_���ꗗ���Ԃ�
\param SubDir    ���̃t�H���_�܂ōċA�I�Ƀ��X�g����ꍇ�� True

Mask �� '*.txt' �̂悤�Ɏw�肷�邱�ƂŁA
����̃t�@�C���������̊g���q�ɍi�������X�g�A�b�v���\�ł��B

\par ��:
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
\brief Subject.txt ��s������
\param Line Subject.txt ���\������ 1 �s
\return     �X���b�h���
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
	end else if Copy(ws, Length(ws)-1, 2) = '�j' then begin
		LeftK := '�i';
		RightK := '�j';
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
\brief URL����BBSID���擾
\param url BBSID ���擾���� URL
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
\brief URL����Ō�̗v�f���폜
\param url ���߂��� URL
\return    �؂���ꂽ��� URL

URL ���� BBSID�ȊO�̕������擾����̂Ɏg�p���܂��B
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
\brief �f�B���N�g�������݂��邩�`�F�b�N
\param Name ���݂��m�F����t�H���_�p�X
\return     �t�H���_�����݂���Ȃ� True
}
function TGikoSys.DirectoryExistsEx(const Name: string): Boolean;
var
	Code: Cardinal;
begin
	Code := GetFileAttributes(PChar(Name));
	Result := (Code <> Cardinal(-1)) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

{!
\brief �f�B���N�g���쐬�i�����K�w�Ή��j
\param Dir �쐬����p�X
\return    �쐬�ɐ��������ꍇ�� True
}
function TGikoSys.ForceDirectoriesEx(Dir: string): Boolean;
begin
	Result := True;
	if Length(Dir) = 0 then
		raise Exception.Create('�t�H���_���쐬�o���܂���');
	Dir := ExcludeTrailingPathDelimiter(Dir);
	if (Length(Dir) < 3) or DirectoryExistsEx(Dir)
		or (ExtractFilePath(Dir) = Dir) then Exit; // avoid 'xyz:\' problem.
	Result := ForceDirectoriesEx(ExtractFilePath(Dir)) and CreateDir(Dir);
end;

{!
\brief �����񂩂�g�[�N���̐؂�o���i���������j
			 FDelphi����̃p�N��
\param s   ���ɂȂ�L�����N�^
\param sep ��؂�ɂȂ镶����
\param Rec OUT:�����񑖍���񂪕Ԃ�
\return    �؂�o�����g�[�N��
\todo Split, RemoveToken, GetTokenIndex, NthField �s��
}
function TGikoSys.StrTokFirst(const s:string; const sep: TStrTokSeparator; var Rec: TStrTokRec): string;
begin
	Rec.Str := s;
	Rec.Pos := 1;
	Result := StrTokNext(sep, Rec);
end;

{!
\brief �����񂩂�g�[�N���̐؂�o��
			 FDelphi����̃p�N��
\param sep ��؂�ɂȂ�L�����N�^
\param Rec IN/OUT:StrTokFirst�ō쐬���ꂽ�����񑖍����
\return    �؂�o�����g�[�N��
\todo Split, RemoveToken, GetTokenIndex, NthField �s��
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
			while (Pos <= Len) and (Str[Pos] in sep) do begin// ����͂��D��
				Inc(Pos);
			end;
		end;
	end;
end;

{!
\brief �t�@�C���T�C�Y�擾
\param FileName �t�@�C���T�C�Y���擾����t�@�C���p�X
\return         �t�@�C���T�C�Y(bytes)
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
\brief �e�L�X�g�t�@�C���̍s�����擾
\param FileName �s�����擾����t�@�C���p�X
\return         �s��
\todo �������}�b�v�h�t�@�C���s��
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
\brief �t�@�C������w��s���擾
\param FileName �t�@�C���̃p�X
\param Line     �w��s
\return         �w�肳�ꂽ 1 �s
\todo �������}�b�v�h�t�@�C���s��
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
\brief �V�X�e�����j���[�t�H���g�̑������擾
\param Font OUT:�擾�����t�H���g�������Ԃ�
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
\brief �擪�̃g�[�N����؂�o��
\param s         IN/OUT:���ɂȂ镶����A�؂�o������̎c��̕�����
\param delimiter ��؂�ɂȂ镶����
\return          �؂�o����������

�ǂ����̃T�C�g����̃p�N��
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
\brief n �ڂ̃g�[�N����؂�o��
\param s     ���ɂȂ镶����
\param index 0 ����n�܂�C���f�b�N�X(n �ڂ� n)
\return �؂�o�����g�[�N��

�ǂ����̃T�C�g����̃p�N��
}
function TGikoSys.GetTokenIndex(s: string; delimiter: string; index: Integer): string;
var
	i: Integer;
begin
	Result := '';
	for i := 0 to index do
		Result := MojuUtils.RemoveToken(s, delimiter);
end;


//�C���f�b�N�X���X�V�o�b�t�@���t���b�V���I
{procedure TGikoSys.FlashExitWrite;
var
	i: Integer;
begin
	//�X���b�h�f�[�^�t�@�C�����X�V
	for i := 0 to FExitWrite.Count - 1 do
		WriteThreadDat(FExitWrite[i]);
	FExitWrite.Clear;
end;}

{!
\brief �X�����Ȃǂ�Z�����O�ɕϊ�����
\param LongName ���ɂȂ镶����
\param ALength  ���߂镶����(bytes)
\return         �ϊ����ꂽ������

from HotZonu
}
function TGikoSys.GetShortName(const LongName: string; ALength: integer): string;
const
	ERASECHAR : array [1..39] of string =
		('��','��','��','��','��','��','�Q','��','��','��',
		 '��','��','��','��','��','�y','�z','��','�s','�t',
		 '�g','�h','�k','�l','�e','�f','��','��','��','��',
		 '�o','�p','�q','�r','�w','�x','��','�c', '�@');
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
        ('[�]�ڋ֎~]', '&copy;5ch.net', '&copy;2ch.net', '&copy;bbspink.com', #9);
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
\brief Boolean �� Integer �ɕϊ�
\return False..0, True..1
}
function TGikoSys.BoolToInt(b: Boolean): Integer;
begin
	Result := IfThen(b, 1, 0);
end;

{!
\brief Integer �� Boolean �ɕϊ�
\return 1..True, other..False
\todo 0..False, other..True �̕��������̂ł�?
			(���̎d�l�Ɉˑ����Ă��邩������Ȃ��̂Ŗ��C��)
}
function TGikoSys.IntToBool(i: Integer): Boolean;
begin
	Result := i = 1;
end;

{!
\brief gzip�ň��k���ꂽ�̂�߂�
\param ResStream       �ǂݍ��ރX�g���[��
\param ContentEncoding �G���R�[�f�B���O
\return                �W�J���ꂽ������
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
//�m�[�g���E���`�E�B���X2003�΍�(x-gzip�Ƃ��ɂȂ�݂���)
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

		//NULL������"*"�ɂ���
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
\brief �A�N�V�����ɃV���[�g�J�b�g�L�[��ݒ�
\param ActionList �ݒ肷��A�N�V�����ꗗ
\param FileName Ini�t�@�C���̖��O
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
\brief �A�N�V�����ɐݒ肳��Ă���V���[�g�J�b�g�L�[���t�@�C���ɕۑ�
\param ActionList �ۑ�����A�N�V�����ꗗ
\param FileName Ini�t�@�C����

ActionList �ɐݒ肳��Ă���V���[�g�J�b�g�L�[�� FileName �ɕۑ����܂��B
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
\brief �v���Z�X�̐���
\param AppPath �N������v���Z�X�̃t�@�C���p�X
\param Param   AppPath �ɓn������
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
\brief Web �u���E�U���N��
\param URL         Web �u���E�U�ŕ\������ URL
\param BrowserType �u���E�U�̃^�C�v(IE ���ǂ���)
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
                    // �N���p�����[�^�t���΍�
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
\brief �������̎Q�Ƃ��f�R�[�h
\param AStr �f�R�[�h���镶����
\return     �f�R�[�h���ꂽ������
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
\brief HTML �̃A���J�[�^�O���� URL ���擾
\param s URL ���擾���� HTML
\return  �擾���� URL
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

	//�n�߂̕�����'"'�Ȃ��菜��
	//if Copy(s, 1, 1) = '"' then begin
    if s[1]  = '"' then begin
		s := Trim(Copy(s, 2, Length(s)));
	end;

	Index := AnsiPos('"', s);
	if Index <> 0 then begin
		//'"'�܂�URL�Ƃ���
		s := Copy(s, 1, Index - 1);
	end else begin
		//'"'��������΃X�y�[�X��">"�̑������܂ł�URL�Ƃ���
		Index := AnsiPos(' ', s);
		Index2 := AnsiPos('>', s);
		if Index = 0 then
			Index := Index2;
		if Index > Index2 then
			Index := Index2;
		if Index <> 0 then
			s := Copy(s, 1, Index - 1)
		else
			//����ȏ�����m����
			;
	end;
	Result := Trim(s);
end;

{!
\brief �z�X�g�����Q�������ǂ����`�F�b�N����
\param Host �`�F�b�N����z�X�g��
\return     2�����˂�̃z�X�g���Ȃ� True
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
\brief 2�����˂�`���� URL �𕪉�
\param url      2�����˂�`���� URL
\param path     test/read.cgi �Ȃǂ̒��ԃp�X(ParseURI ���瓾��)
\param document index.html �Ȃǂ̃h�L�������g��(ParseURI ���瓾��)
\param BBSID    OUT:BBSID ���Ԃ�(ex. giko)
\param BBSKey   OUT:�X���b�h�L�[���Ԃ�(ex. 10000000000)
\return 2�����˂�� URL �Ƃ��ĕ����ł����Ȃ� True
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
\brief 2ch �`���� URL ���烌�X�Ԃ��擾
\param URL    2�����˂�`���� URL
\param stRes  OUT:�J�n���X�Ԃ��Ԃ�
\param endRes OUT:�I�����X�Ԃ��Ԃ�

http://2ch.net/����/32-50 \n
�̏ꍇ stRef = 32, endRes = 50 �ɂȂ�
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
                // �J�n���X�Ԃ̌���
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
                // �I�����X�Ԃ̌���
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
                // ���X�Ԃ̌���
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
\brief 2�����˂�`���� URL �𕪉�
\param URL 2�����˂�`���� URL
\return    �������ꂽ�v�f
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

		//�W������
		//�Ō��l50, 10, 10-20, 10n, 10-20n, -10, 10-, 10n- �Ȃ�
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

		//�Vkako����
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

		//��kako����
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

		//log�y��log2����
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


		//��URL����
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
\brief URI �𕪉�
\param URL      �������� URI
\param Protocol OUT:�v���g�R�����Ԃ�(ex. http)
\param Host     OUT:�z�X�g���Ԃ�(ex. hoge.com)
\param Path     OUT:���ԃp�X���Ԃ�(ex. test/read.cgi)
\param Document OUT:�h�L�������g�����Ԃ�(ex. index.html)
\param Port     OUT:�|�[�g���Ԃ�(ex. 8080)
\param Bookmark OUT:�u�b�N�}�[�N(?)���Ԃ�
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
\brief �M�R�i�r�̃o�[�W�������擾
\return �o�[�W�����̉� 2 ��(dwFileVersionLS)
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
\brief �X���b�h URL �̐��K��
\param inURL ���K������X���b�h URL
\return      ���K�����ꂽ�X���b�h URL

�X���b�h URL ���M�R�i�r�̒��ň�ӂȂ��̂ɐ��K�����܂��B
��ӂ� URL �ɂ��鎖�ŁAURL ����X���b�h�𓱂��o����Ƃ��œK�����܂��B\n
���K���̕��j�Ƃ��āA�T�C�g����������f�t�H���g�� URL �ɂȂ�悤�ɐS�����܂��B
(1-1000 �̂悤�ȕ��ׂ���������̂ɂ͂��Ȃ�����)

��(���K���O):\n
http://����/ \n
http://����/20-100

(���K����):\n
http://����/l50
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

	//===== �v���O�C��
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
		// exception �����������ꍇ�͓��������ɔC�������̂ł����ł͉������Ȃ�
	end;

	if Length( Result ) = 0 then
		Result := GikoSys.Get2chBrowsableThreadURL( inURL );

end;

{!
\brief �X���b�h URL ��� URL �ɕϊ�
\param inURL �X���b�h URL
\return      �� URL
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

	//===== �v���O�C��
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
		// exception �����������ꍇ�͓��������ɔC�������̂ł����ł͉������Ȃ�
	end;

	if Length( Result ) = 0 then
		Result := GikoSys.Get2chThreadURL2BoardURL( inURL );

end;

{!
\brief 2ch�p:�X���b�h URL ��� URL �ɕϊ�
\param inURL �X���b�h URL
\return      �� URL
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
\brief 2ch�p:�X���b�h URL �̐��K��
\param inURL ���K������X���b�h URL
\return      ���K�����ꂽ�X���b�h URL
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
\brief 2ch�p:�� URL ����X���b�h URL ���쐬
\param inBoard �� URL
\param inKey   �X���b�h�L�[(ex. 1000000000)
\return        �X���b�h URL
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
\brief �{�[�h�t�@�C����

�񋓂��ꂽ BBS(�{�[�h) �� BBSs �ɓ���܂��B
}
procedure TGikoSys.ListBoardFile;
var
	boardFileList	: TStringList;
	i, l			: Integer;
    sCategory       : TCategory;
begin
	// BBS �̊J��
	try
	  for i := 0 to Length( BBSs ) - 1 do
		BBSs[ i ].Free;
	except
	end;
	SetLength( BBSs, 0 );

	l := 0;
	// ���X�g�̗�
	if FileExists( GikoSys.GetBoardFileName ) then begin
	  SetLength( BBSs, l + 1 );
	  BBSs[ l ]				:= TBBS.Create( GikoSys.GetBoardFileName );
	  BBSs[ l ].Title	:= '�Q�����˂�';
		  Inc( l );
	end;

	if FileExists( GikoSys.GetCustomBoardFileName ) then begin
	  SetLength( BBSs, l + 1 );
	  BBSs[ l ]				:= TBBS.Create( GikoSys.GetCustomBoardFileName );
	  BBSs[ l ].Title	:= '���̑�';
		  Inc( l );
	end;

	// Board �t�H���_
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

    // ����p�rBBS����
    // ���ɑ��݂���ꍇ�͍폜����
    DestorySpecialBBS(BoardGroup.SpecialBBS);
    SpecialBBS := TBBS.Create('');
    SpecialBBS.Title := '����p�r(��\��)';
    sCategory := TCategory.Create;
    sCategory.No := 1;
    sCategory.Title := '����p�r(��\��)';
    SpecialBBS.Add(sCategory);
    BoardGroup.SpecialBoard := TSpecialBoard.Create(nil, 'http://localhost/gikonavi/special/index.html');
    BoardGroup.SpecialBoard.Title := '�^�u�ꗗ';
    BoardGroup.SpecialBoard.IsThreadDatRead := True;
    sCategory.Add(BoardGroup.SpecialBoard);
end;

{!
\brief �{�[�h�t�@�C���ǂݍ���
\param bbs �{�[�h�t�@�C����ǂݍ��� BBS
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
					//'http://'���܂܂Ȃ�������̎��͖�������
					//if (AnsiPos('http://', AnsiLowerCase(inistr)) = 0) then Continue;
					if ((AnsiPos('http://', AnsiLowerCase(inistr)) = 0) and
              (AnsiPos('https://', AnsiLowerCase(inistr)) = 0)) then Continue;  // for https
					//===== �v���O�C��
					try
						kBound := Length(BoardGroups) - 1;
						for k := 1 to kBound do begin  //0�́A2�����
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
													//�����ɗ���Ƃ�����Board�̍쐬�Ɏ��s�����Ƃ�������Board��nil�ɂ���
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
												//�����ɗ���Ƃ�����Board�̍쐬�Ɏ��s�����Ƃ�������Board��nil�ɂ���
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
						// exception �����������ꍇ�͓��������ɔC�������̂ł����ł͉������Ȃ�
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
\brief ���̂��s���ȃJ�e�S���̐���
\return �������ꂽ�J�e�S��
}
function	TGikoSys.GetUnknownCategory : TCategory;
const
	UNKNOWN_CATEGORY = '(���̕s��)';
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
\brief ���̂��s���� BBS �̐���
\return �������ꂽ BBS
}
function	TGikoSys.GetUnknownBoard( inPlugIn : TBoardPlugIn; inURL : string ) : TBoard;
var
	category : TCategory;
const
	UNKNOWN_BOARD = '(���̕s��)';
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
\brief �񋓂��ꂽ���X�ԍ��ւ̃A���J�[�pHTML�쐬
\param Numbers    �񋓂��ꂽ���X�ԍ�
\param ThreadItem �񋓂���X���b�h
\param limited    �񋓂��鐔�𐧌�����Ȃ�1�ȏ�
\return           �񋓂��ꂽ���X�A���J�[
}
function TGikoSys.CreateResAnchor(
    var Numbers: TStringList; ThreadItem: TThreadItem;
    limited: Integer):string;
var
	i: integer;
    Res: TResRec;
    ResLink : TResLinkRec;
begin
    // body�ȊO�͎g�p���Ȃ��̂ŏ��������Ȃ�
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
\brief �������e ID �������X���
\param AID        �l����肷�铊�e ID
\param ThreadItem �񋓂���X���b�h
\param body       OUT:�񋓂��ꂽ���X�ԍ����Ԃ�
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
			//===== �v���O�C���ɂ��\��
			//boardPlugIn		:= ThreadItem.BoardPlugIn;
            boardPlugIn		:= ThreadItem.ParentBoard.BoardPlugIn;

			for i := 0 to threadItem.Count - 1 do begin
				// ���X
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
\brief �������e ID �������X���
\param AIDNum     �l����肷�铊�e ID
\param ThreadItem �񋓂���X���b�h
\param body       OUT:�񋓂��ꂽ���X�ԍ����Ԃ�
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
\brief ���e ID �擾
\param AIDNum     ���e ���X�ԍ�
\param ThreadItem ���e�X���b�h
\param body       OUT:���eID
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
			//===== �v���O�C���ɂ��\��
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
\brief ���X�̎���������ID�𒊏o����
\param ADateStr �������̕�����
\return     ID(ID�Ƃ݂Ȃ��镔�����Ȃ��Ƃ��͋󕶎���)
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
            // ���t ���� ID ���@�ƌŒ�ōl����
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
\brief �X�p��:�ꐔ���J�E���g
\param text      ���ɂȂ镶��
\param wordCount OUT:�J�E���g���ꂽ�P��̈ꗗ���Ԃ�
}
procedure TGikoSys.SpamCountWord( const text : string; wordCount : TWordCount );
begin

	if Setting.SpamFilterAlgorithm = gsfaNone then Exit;
	Bayesian.CountWord( text, wordCount );

end;

{!
\brief �X�p��:�w�K���ʂ����
\param wordCount ��������P��̈ꗗ
\param isSpam    wordCount ���X�p���Ƃ��Ċw�K����Ă����Ȃ� True
\warning	�w�K�ς݂̕��͂��ǂ����͊m�F�o���܂���B\n
					Learn ���Ă��Ȃ����͂� isSpam ���ԈႦ�Ďw�肷���
					�f�[�^�x�[�X���j�����܂��B\n
					�w�K�ς݂��ǂ����͓Ǝ��ɊǗ����Ă��������B

�S�Ă̊w�K���ʂ��N���A����킯�ł͂���܂���B\n
wordCount �𓾂����͂̊w�K���ʂ̂݃N���A���܂��B

��ɃX�p���ƃn����؂�ւ��邽�߂� Forget -> Learn �̏��Ŏg�p���܂��B
}
procedure TGikoSys.SpamForget( wordCount : TWordCount; isSpam : Boolean );
begin

	if Setting.SpamFilterAlgorithm = gsfaNone then Exit;
	Bayesian.Forget( wordCount, isSpam );

end;

{!
\brief �X�p��:�w�K
\param wordCount �w�K����P��̈ꗗ
\param isSpam    �X�p���Ƃ��Ċw�K����Ȃ� True
}
procedure TGikoSys.SpamLearn( wordCount : TWordCount; isSpam : Boolean );
begin

	if Setting.SpamFilterAlgorithm = gsfaNone then Exit;
	Bayesian.Learn( wordCount, isSpam );

end;

{!
\brief �X�p��:���͂���͂��A�X�p���x���𓾂�
\param text      ���ɂȂ镶��
\param wordCount OUT:�J�E���g���ꂽ�P��̈ꗗ���Ԃ�(SpamCountWord �Ɠ���)
\return          0�`1 �̃X�p���x��
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
\brief ���[�U�ݒ�� CSS �𐶐�
\return �������ꂽ CSS

[�c�[��]���j���[-[�I�v�V����]-[CSS �ƃX�L��]�^�u��
[�t�H���g���w��], [�w�i�F���w��] �ɉ����� CSS �𐶐����܂��B
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
\brief Be �v���t�@�C���ւ̃A���J�[�^�O�𐶐�
\param AID  �ΏۂƂȂ���tID������
\param ANum ���X��
\param AURL ���̃X���b�h��URL
\return     �������ꂽ�A���J�[�^�O
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
\brief �o�[�W���������擾
\param KeyWord �擾���鍀��
\return        �o�[�W����������
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
	// �K�v�ȃo�b�t�@�̃T�C�Y���擾
	BufSize := GetFileVersionInfoSize(PChar(Application.ExeName), HWnd);
	if BufSize <> 0 then begin
		// ���������m��
		GetMem(VerInfoBuf, BufSize);
		try
			GetFileVersionInfo(PChar(Application.ExeName), 0, BufSize, VerInfoBuf);
			// �ϐ����u���b�N���̕ϊ��e�[�u�����w��
			VerQueryValue(VerInfoBuf, PChar(Translation), VerData, VerDataLen);

			if not (VerDataLen > 0) then
				raise Exception.Create('���̎擾�Ɏ��s���܂���');

			// 8���̂P�U�i���ɕϊ�
			// ��'\StringFileInfo\027382\FileDescription'
			PathLocale := Format(FileInfo + KeyWordStr[KeyWord],
			[IntToHex(Integer(VerData^) and $FFFF, 4),
			IntToHex((Integer(VerData^) shr 16) and $FFFF, 4)]);
			VerQueryValue(VerInfoBuf, PChar(PathLocale), VerData, VerDataLen);

			if VerDataLen > 0 then begin
				// VerData�̓[���ŏI��镶����ł͂Ȃ����Ƃɒ���
				result := '';
				SetLength(result, VerDataLen);
				StrLCopy(PChar(result), VerData, VerDataLen);
			end;
		finally
			// ���
			FreeMem(VerInfoBuf);
		end;
	end;
end;

{!
\brief Load ����Ă���v���O�C���̃o�[�W�������
\return 1�s1plugin
}
function TGikoSys.GetPluginsInfo(): String;
var
	i : Integer;
	major, minor, revision : Cardinal;
	agent, release : String;
begin
	//���ʂ��N���A���Ă���
	Result := '';

	//BoardGroups�o�R��Plugin�ɃA�N�Z�X����
	for  i := 0 to Length(BoardGroups) - 1 do begin
		//BoardGroups�̒��ɂ́APlugin�������Ă��Ȃ��́i2�����j��
		//����̂ł��������
		if BoardGroups[i].BoardPlugIn <> nil then begin
			BoardGroups[i].BoardPlugIn.VersionInfo(agent, major, minor, release, revision);


			//"Plugin�̖��O(major.minor.revision)"
			Result := Result +
				Format('%s(%d.%d.%d)', [agent, major, minor, revision]) + #13#10;
		end;
	end;
end;


//! IE�̃o�[�W�������擾����
function TGikoSys.GetIEVersion: string;
var
	R: TRegistry;
begin
	R := TRegistry.Create;
	try
		//�ǂݎ���p�ɂ��Ȃ��ƁA����USER�Ƃ��̏ꍇ�A�J���Ȃ��݂���
		R.Access := KEY_EXECUTE;
		R.RootKey := HKEY_LOCAL_MACHINE;
		R.OpenKey('Software\Microsoft\Internet Explorer', False);
		try
			Result := R.ReadString('version');
		except
			Result := '�o�[�W�����̎擾�Ɏ��s���܂����B';
		end;
		R.CloseKey;
	finally
		R.Free;
	end;
end;
//! main�t�H�[���̃V���[�g�J�b�g�L�[��Ini�t�@�C����
function TGikoSys.GetMainKeyFileName : String;
begin
	Result := Setting.GetMainKeyFileName;
end;
//! Editor�t�H�[���̃V���[�g�J�b�g�L�[��Ini�t�@�C����
function TGikoSys.GetEditorKeyFileName: String;
begin
	Result := Setting.GetEditorKeyFileName;
end;
//! ���̓A�V�X�g�̐ݒ�t�@�C����
function TGikoSys.GetInputAssistFileName: String;
begin
	Result := Setting.GetInputAssistFileName;
end;
//! �M�R�i�r�̃��b�Z�[�W��ݒ肷��
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
//! �M�R�i�r�̃��b�Z�[�W���擾����
function TGikoSys.GetGikoMessage(MesType: TGikoMessageListType): String;
begin
    Result := '';
	if FGikoMessage <> nil then begin
		Result := FGikoMessage.GetMessage(MesType);
	end;
end;

//Tue, 17 Dec 2002 12:18:07 GMT �� TDateTime��
//MonaUtils����ړ�
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
//MonaUtils����ړ�
//! ����Z�p���[�^�ŋ�؂�ꂽ�����񂩂炎�Ԗڂ̕���������o��
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
//! �ꎞ�t�@�C������̕���
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
    	//�O��ُ�I�����pTmp�t�@�C�����X�g
	    GetFileList(Boardpath, '*.tmp', TmpFileList, False);
	    TmpFileList.EndUpdate;
		//�O��ُ�I�����`�F�b�N
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

                    //����̐ݒ��RoundData�̕�����邩�珟��ɐݒ肵�Ă̓_���I�@by ������
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
\brief User32.dll�����p�ł��邩
\return Boolean ���p�ł���ꍇ��True
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
\brief  OE���p���擾
\return OE�̈��p���i�ݒ肳��Ă��Ȃ��ꍇ��'>')
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
//! �u���ݒ�t�@�C���擾
function TGikoSys.GetReplaceFileName: String;
begin
    Result := Setting.GetReplaceFileName;
end;
//! �v���r���[�g���̐ݒ�t�@�C���擾
function TGikoSys.GetExtpreviewFileName: String;
begin
    Result := Setting.GetExtprevieFileName;
end;

//! �t�@�C��������̃X���b�h�쐬���̎擾
function TGikoSys.GetCreateDateFromName(FileName: String): TDateTime;
var
    tmp : String;
    unixtime: Int64;  
begin
    // ���O�t�@�C���̊g���q���͂��������̂��X���쐬����
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
//! �`���̏�Domain�ꗗ�擾
procedure TGikoSys.GetBoukenDomain(var ADomain: TStringList);
var
    i : Integer;
begin
    ADomain.Clear;
    for i := 0 to Setting.BoukenCookieList.Count - 1 do begin
        ADomain.Add( Setting.BoukenCookieList.Names[i] );
    end;
end;
//! �`���̏�Cookie�폜
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

//! �w�蕶����폜
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

//! 2ch/5ch��URL�����ۂɌĂׂ�`�ɂ���
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

//! 2ch/5ch��URL���ǂ���
function TGikoSys.Is2chURL(url: String): Boolean;
begin
  Result := (AnsiPos('.5ch.net/', url) > 0) or
            (AnsiPos('.2ch.net/', url) > 0) or
            (AnsiPos('.bbspink.com/', url) > 0);
end;

//! ������΂�URL���ǂ���
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
