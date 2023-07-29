unit ShitarabaJBBSAcquireBoard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdURI, IdGlobal, StrUtils;

type
  TShitarabaJBBSAcquireBoardDialog = class(TForm)
	CategoryLabel: TLabel;
	CategoryComboBox: TComboBox;
	BoardNameLabel: TLabel;
	BoardNameEdit: TEdit;
	AcquireButton: TButton;
	SaveButton: TButton;
	LogEdit: TMemo;
	SaveCategoryLabel: TLabel;
	SaveCategoryComboBox: TComboBox;
	procedure SaveButtonClick(Sender: TObject);
	procedure AcquireButtonClick(Sender: TObject);
	private
		{ Private 宣言 }
		FBoardList		: TStringList;	//!< 取得済みの板リスト
    FURI: TIdURI;
    //! UTF8でURLEncode
    function URLEncodeUTF8(const src: String) : String;
    //! UTF8からShift-JISへ変換
    function UTF8toSJIS(pUtf8: PChar): String;
    //! 文字列抽出
    function Extract(const kws: String; const kwe: String; var src: String; var dst: String): Boolean;
	public
		{ Public 宣言 }
		constructor Create( AOwner : TComponent ); override;
		destructor Destroy; override;
	end;

var
  ShitarabaJBBSAcquireBoardDialog: TShitarabaJBBSAcquireBoardDialog;

implementation

uses Math, IniFiles,
	PlugInMain, FilePath, Y_TextConverter, MojuUtils;

const
	SYNCRONIZE_MENU_CAPTION	= 'したらばJBBS板更新';
	CATEGORYNAMES : array[0..17] of string = (
    '音楽/芸能', 'ゲーム', 'ネットゲーム', 'コンピュータ', 'インターネット',
    'スポーツ', '同人', '旅行', '学校', '映画', 'アニメ', 'マンガ',
    'ビジネス', '自動車', '学問', 'ニュース', 'ショッピング', 'ラジオ' );
	CATEGORIES : array[0..17]	of string = (
		'music', 'game', 'netgame', 'computer', 'internet', 'sports', 'otaku',
		'travel', 'school', 'movie', 'anime', 'comic', 'business', 'auto',
		'study', 'news', 'shop', 'radio' );

{$R *.dfm}

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

function BoardFileName : string;
var
	savepath			: string;
	success				: Boolean;
	initdir				: string;
	filter				: string;

	agent					: PChar;
	major					: DWORD;
	minor					: DWORD;
	release				: PChar;
	revision			: DWORD;
const
	SAVEPATH_SELECT	= '保存するファイル名を入力してください';
	BOARD_FILE_NAME = 'したらばJBBS';
begin

	VersionInfo( agent, major, minor, release, revision );
	try
		initdir	:= PreferencesFolder;
		if agent = 'gikoNavi' then begin
			savepath := initdir + 'Board\' + BOARD_FILE_NAME + '.txt';
		end else begin
			filter	:= 'すてべのファイル (*.*)|*.*';
			savepath := BOARD_FILE_NAME;
			success	:= PromptForFileName(
				savepath, filter, 'txt', SYNCRONIZE_MENU_CAPTION, initdir, True );
		end;
	finally
		DisposeResultString( agent );
		DisposeResultString( release );
	end;

	Result := savepath;

end;

constructor TShitarabaJBBSAcquireBoardDialog.Create( AOwner : TComponent );
var
	ini							: TMemIniFile;
	saveCategories	: TStringList;
	i								: Integer;
begin

	inherited;

	FBoardList := TStringList.Create;
	FBoardList.Duplicates := dupIgnore;


	ini := TMemIniFile.Create( BoardFileName );
	saveCategories := TStringList.Create;
	try
		ini.ReadSections( saveCategories );
		for i := 0 to saveCategories.Count - 1 do
			SaveCategoryComboBox.AddItem( saveCategories[ i ], nil );
		SaveCategoryComboBox.ItemIndex := 0;
	finally
		saveCategories.Free;
		ini.Free;
	end;

  CategoryComboBox.Items.Clear;
  for i := 0 to Length(CATEGORYNAMES) - 1 do
    CategoryComboBox.Items.Add(CATEGORYNAMES[i]);

  FURI := TIdURI.Create;

end;

destructor TShitarabaJBBSAcquireBoardDialog.Destroy;
begin

	FBoardList.Free;
  FURI.Free;

	inherited;

end;

procedure TShitarabaJBBSAcquireBoardDialog.SaveButtonClick(
  Sender: TObject);
var
	ini						: TMemIniFile;
	i							: Integer;
	name					: string;
	saveCategory	: string;
begin

	saveCategory := SaveCategoryComboBox.Text;
	if saveCategory = '' then
		saveCategory := CategoryComboBox.Text;
	ini := TMemIniFile.Create( BoardFileName );
	try
		ini.CaseSensitive := False;
		for i := 0 to FBoardList.Count - 1 do begin
			name := FBoardList.Names[ i ];
			ini.WriteString( saveCategory, name, FBoardList.Values[ name ] );
		end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;

	Close;

end;

procedure TShitarabaJBBSAcquireBoardDialog.AcquireButtonClick(
  Sender: TObject);
var
	boardName				: string;
	category				: string;
	url							: string;
	modified	 			: Double;
	tmp							: PChar;
	downResult			: string;
	responseCode		: Longint;
	board						: string;
	key							: string;
	//htmlList				: TStringList;
	//i							  : Integer;
  //resultArea      : Boolean;
  //pos             : Integer;
  idx             : Integer;
  resultList      : String;
const
    //http://rentalbbs.livedoor.com/jbbs/search/?word=%C2%E7%B3%D8&category=auto
    BBS_HOST	 			= 'https://rentalbbs.shitaraba.com/';
    //BOARD_HOST              = 'https://jbbs.shitaraba.net/';
    //MSG_CONTENTAREA  = '<!--contents_area-->';
    TAG_RESULT_S  = '<ul class="list-search">';
    TAG_RESULT_E  = '</ul>';
    TAG_BOARD_S   = '<a href="';
    TAG_BOARD_E   = '</a>';
label
	NextBoard;
begin
    responseCode := 0;
	category := CATEGORIES[ CategoryComboBox.ItemIndex ];
	boardname := BoardNameEdit.Text;

	LogEdit.SelLength := 0;
	LogEdit.SelStart := Length( LogEdit.Text );
	LogEdit.SelText :=
		'板情報を取得中です( "' + category + '", "' + boardname + '" )' + #13#10;
	try
		url :=
			BBS_HOST + 'jbbs/search/?category=' + category +
			//'&WORD=' + HttpEncode( SJIStoEUC( boardname ) );
			'&word=' + URLEncodeUTF8( boardname );

		responseCode := InternalDownload( PChar( url ), modified, tmp );
		try
			if (responseCode = 200) or (responseCode = 206) then begin
				//downResult := EUCtoSJIS( tmp );
        downResult := UTF8toSJIS( tmp );
        if Extract(TAG_RESULT_S, TAG_RESULT_E, downResult, resultList) then begin
          try
            while True do
            begin
              if Extract(TAG_BOARD_S, TAG_BOARD_E, resultList, key) = False then
                Break;

              idx := AnsiPos('">', key);
              if idx > 0 then begin
                board := Copy(key, 1, idx - 1);   // URL
                Delete(key, 1, idx + 1);          // 板名
                idx := Length(board);
                if (idx > 0) and (Length(key) > 0) then begin
                  if board[idx] <> '/' then
                    board := board + '/';
                  board := key + '=' + board;

                  LogEdit.SelText := board + #13#10;
                  FBoardList.Add( board );
                end;
              end;
            end;
          finally
          end;
        end;
			end else begin
				LogEdit.SelText :=
					'板情報の取得に失敗しました(' +
					IntToStr( responseCode ) + ')' + #13#10;
			end;
		finally
			DisposeResultString( tmp );
		end;
		LogEdit.SelText := '板情報を取得完了' + #13#10;
		SaveButton.Enabled := True;
	except
		LogEdit.SelText :=
			'板情報の取得に失敗しました(' + IntToStr( responseCode ) + ')' + #13#10;
	end;

end;

function TShitarabaJBBSAcquireBoardDialog.URLEncodeUTF8(const src: String) : String;
const
  DUMMY_URL = 'https://dummy.com/';
var
  url: String;
  urlEnc: String;
  dummy: Boolean;
  dummyLen: Integer;
begin
  dummyLen := Length(DUMMY_URL);
  dummy := ((AnsiPos('https://', src) < 1) and (AnsiPos('http://', src) < 1));

  if dummy then
    url := DUMMY_URL + src
  else
    url := src;

  urlEnc := FURI.URLEncode(url, IndyUTF8Encoding());

  if dummy then
    Result := Copy(urlEnc, dummyLen + 1, Length(urlEnc) - dummyLen)
  else
    Result := urlEnc;
end;

function TShitarabaJBBSAcquireBoardDialog.UTF8toSJIS(pUtf8: PChar): String;
const
  CP_UTF8 = 65001;
  CP_SJIS = 932;
var
  lenU16: Integer;
  utf16: WideString;
  lenSjis: Integer;
  sjis: AnsiString;
begin
  lenU16 := MultiByteToWideChar(CP_UTF8, 0, pUtf8, -1, nil, 0);
  if lenU16 > 0 then begin
    SetLength(utf16, lenU16);
    MultiByteToWideChar(CP_UTF8, 0, pUtf8, -1, PWideChar(utf16), lenU16);

    lenSjis := WideCharToMultiByte(CP_SJIS, 0, PWideChar(utf16), -1, nil, 0, nil, nil);
    if lenSjis > 0 then begin
      SetLength(sjis, lenSjis);
      WideCharToMultiByte(CP_SJIS, 0, PWideChar(utf16), -1, PChar(sjis), lenSjis, nil, nil);
    end;
  end;
  Result := sjis;
end;

//! 文字列抽出
function TShitarabaJBBSAcquireBoardDialog.Extract(const kws: String; const kwe: String; var src: String; var dst: String): Boolean;
var
  idx1: Integer;
  idx2: Integer;
  len1: Integer;
  len2: Integer;
begin
  Result := False;

  idx1 := AnsiPos(kws, src);
  if idx1 < 1 then
    Exit;
  len1 := idx1 + Length(kws);

  idx2 := PosEx(kwe, src, len1);
  if idx2 < 1 then
    Exit;
  len2 := idx2 + Length(kwe);

  dst := Copy(src, len1, idx2 - len1);
  Delete(src, 1, len2 - 1);

  Result := True;
end;

end.
