unit HTMLCreate;

interface

uses
	Windows, Messages, SysUtils, Classes, {Graphics,} Controls, {Forms,}
	ComCtrls, IniFiles, ShellAPI, Math, GikoSystem, StrUtils,
{$IF Defined(DELPRO) }
	SHDocVw,
	MSHTML,
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB,
{$IFEND}
	{HttpApp,} YofUtils, {URLMon,} BoardGroup, {gzip,} {Dolib,}
	{bmRegExp,} AbonUnit,	MojuUtils, Setting,
	ExternalBoardManager, ExternalBoardPlugInMain{,}
	{Sort,} ,GikoBayesian, {HintWindow,} ActiveX, ResPopupBrowser;

type

	PResLinkRec = ^TResLinkRec;
	TResLinkRec = record
		FBbs: string;
		FKey : string;
	end;

	TBufferedWebBrowser = class(TStringList)
	private
		//! �������ރu���E�U
		FBrowser: TWebBrowser;
		//! ���s�܂ł��߂邩�̃T�C�Y
		FBuffSize: Integer;
		//! �u���E�U��IHTMLDocument2�C���^�t�F�[�X��ێ����� open����close�̊Ԃ�
		FBrowserDoc: OleVariant;
	public
		constructor Create(Browser: TWebBrowser; BuffSize: Integer);
		destructor Destory;
		procedure Open;
		procedure Close;
		procedure Flush;
		function Add(const S: string): Integer; override;
	end;
	THTMLCreate = class(TObject)
	private
		{ Private �錾 }
		anchorLen			: Integer;
		pURLCHARs,pURLCHARe : PChar;
		pURLC5CHs,pURLC5CHe : PChar;
		pANCHORs, pANCHORe  : PChar;
		pCTAGLs,  pCTAGLe   : PChar;
		pCTAGUs,  pCTAGUe   : PChar;
		pREF_MARKSs : array of PChar;
		pREF_MARKSe : array of PChar;
		constructor Create;

		function AddBeProfileLink(AID : string; ANum: Integer):string ;
		procedure CreateUsePluginHTML(html:TBufferedWebBrowser; ThreadItem: TThreadItem; var sTitle: string);
		procedure CreateUseSKINHTML(html:TBufferedWebBrowser; ThreadItem: TThreadItem; ReadList: TStringList);
		procedure CreateUseCSSHTML(html:TBufferedWebBrowser; ThreadItem: TThreadItem; ReadList: TStringList; sTitle: string );
		procedure CreateDefaultHTML (html:TBufferedWebBrowser; ThreadItem: TThreadItem; ReadList: TStringList; sTitle: string );
		procedure ConvertResAnchor(PRes: PResRec);
		procedure separateNumber(var st: String; var et: String; const Text, Separator: String);
		function checkComma(const s : String; var j : Integer) : boolean;
		function addResAnchor(PAddRes: PResRec; PResLink : PResLinkRec; dat : boolean;
						var s : String; j : Integer; const No: String) : string;
		function appendResAnchor(PAddRes: PResRec; PResLink : PResLinkRec;
             dat : boolean;	var s : String) : string;
		function getNumberString(const str: String;var index :Integer; var dbCharlen: Boolean;
             sLen :Integer): String;
    function isOutsideRange(item: TThreadItem; index: Integer ): Boolean;
    function getKeywordLink(item: TThreadItem): String;
    function GetResString(index: Integer; const Line: String; PResLink : PResLinkRec): String;
    function IsImageExp(const Url: String): Boolean;
	public
		{ Public �錾 }
		procedure AddAnchorTag(PRes: PResRec);
		function LoadFromSkin(fileName: string; ThreadItem: TThreadItem; SizeByte: Integer): string;
		function SkinedRes(const skin: string; PRes: PResRec; const No: string): string;
		procedure ConvRes( PRes : PResRec; PResLink : PResLinkRec; DatToHTML: boolean = false); overload;
		procedure CreateHTML2(Browser: TWebBrowser; ThreadItem: TThreadItem; var sTitle: string);
		procedure CreateHTML3(var html: TStringList; ThreadItem: TThreadItem; var sTitle: string);
		//���X�|�b�v�A�b�v�̍쐬
		procedure SetResPopupText(Hint :TResPopupBrowser; threadItem: TThreadItem; StNum, ToNum: Integer; Title, First: Boolean);
		//�����N�̕����񂩂烌�X�|�b�v�A�b�v�p��URL�ɕϊ�����
		class function GetRespopupURL(AText, AThreadURL : string): string;
		//�w�肵���p�X�ɃX�L����������CSS�̃t�@�C���̃R�s�[�����
		class procedure SkinorCSSFilesCopy(path: string);
		//dat�P�s�����X�ɕ�������
		class procedure DivideStrLine(Line: string; PRes: PResRec);
        //HTML���烊���N�^�O���폜����
		class function DeleteLink(const s: string): string;
		//HTML�̃{�f�B�ɋ�����镶����ɒu������
		class function RepHtml(const s: string): string;
		//���X�G�f�B�^�̃v���r���[�pHTML���쐬����
		class function CreatePreviewHTML(const Title: string; const No: string;
							const Mail: string; const Namae: string; const Body: string ) : string;
	end;

var
	HTMLCreater: THTMLCreate;

implementation

uses
    Trip, AbonInfo;

const
	URL_CHAR: string = '0123456789'
									 + 'abcdefghijklmnopqrstuvwxyz'
									 + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
									 + '#$%&()*+,-./:;=?@[]^_`{|}~!''\';
	URL_CHAR_5CH: string = '0123456789'
									 + 'abcdefghijklmnopqrstuvwxyz'
									 + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
									 + '#$%&*+,-./:;=?@^_';
	ANCHOR_REF	= 'href=';
	CLOSE_TAGAL = '</a>';
	CLOSE_TAGAU = '</A>';
	RES_REF			= '&gt;&gt;';
  REF_MARK: array[0..18] of string = (
    'sssp://',
    'https://',
    'ht&#116;&#112;s://',
    'ttps://',
    'http://',
    'ttp://',
    'ms-help://',
    'ftp://',
    'news://',
    'rtsp://',
    'tps://',
    'ps://',
    's://',
    'tp://',
    'p://',
    '://',
    'www.',
    'i.imgur.com/',
    'x.com/'
    );
  REF_MARK_HEAD: array[0..18] of String = (
    '',					// sssp://
    '',					// https://
    '',					// ht&#116;&#112;s://
    'h',				// ttps://
    '',					// http://
    'h',				// ttp://
    '',					// ms-help://
    '',					// ftp://
    '',					// news://
    '',					// rtsp://
    'ht',				// tps://
    'htt',			// ps://
    'http',			// s://
    'ht',				// tp://
    'htt',			// p://
    'https',		// ://
    'https://',	// www.
    'https://',	// i.imgur.com/
    'https://'	// x.com/
    );
  REF_MARK_LEN: array[0..18] of Integer = (
    7,			// sssp://
    8,			// https://
    18,			// ht&#116;&#112;s://
    7,			// ttps://
    7,			// http://
    6,			// ttp://
    10,			// ms-help://
    6,			// ftp://
    7,			// news://
    7,			// rtsp://
    6,			// tps://
    5,			// ps://
    4,			// s://
    5,			// tp://
    4,			// p://
    3,			// ://
    4,			// www.
    0,			// i.imgur.com/
    0				// x.com/
    );

constructor THTMLCreate.Create;
var
	j : Integer;
begin
	// + 3 �� 'href="' ('"'��)�Ȃǂ̃o���G�[�V�����ɗ]�T���������邽��
	anchorLen := Length( ANCHOR_REF ) + 3;
	pANCHORs  := PChar(ANCHOR_REF);
	pANCHORe  := pANCHORs + Length(ANCHOR_REF);
	pURLCHARs := PChar(URL_CHAR);
	pURLCHARe := pURLCHARs + Length(URL_CHAR);
  pURLC5CHs := PChar(URL_CHAR_5CH);
  pURLC5CHe := pURLC5CHs + Length(URL_CHAR_5CH);
	pCTAGLs	  := PChar(CLOSE_TAGAL);
	pCTAGLe   := pCTAGLs + 4;
	pCTAGUs   := PChar(CLOSE_TAGAU);
	pCTAGUe   := pCTAGUs + 4;
	SetLength(pREF_MARKSs, Length(REF_MARK));
	SetLength(pREF_MARKSe, Length(REF_MARK));
	for j := Low(REF_MARK) to High(REF_MARK) do begin
		pREF_MARKSs[j] := PChar(REF_MARK[j]);
		pREF_MARKSe[j] := pREF_MARKSs[j] + Length(REF_MARK[j]);
	end;
end;
// �X�L����ǂݍ��݁A�l��u������
function THTMLCreate.LoadFromSkin(
	fileName: string;
	ThreadItem: TThreadItem;
	SizeByte: Integer
): string;
var
	Skin: TStringList;
begin

	Skin := TStringList.Create;
	try
		if FileExists( fileName ) then begin
			Skin.LoadFromFile( fileName );

			// ��肩�����ꂵ�����ǁA�I�v�V�����_�C�A���O�̃v���r���[�p try
			try
				if ThreadItem.ParentBoard <> nil then
					if ThreadItem.ParentBoard.ParentCategory <> nil then
						CustomStringReplace( Skin, '<BBSNAME/>', ThreadItem.ParentBoard.ParentCategory.ParenTBBS.Title);
					CustomStringReplace( Skin, '<THREADURL/>', ThreadItem.URL);
			except end;
			CustomStringReplace( Skin, '<BOARDNAME/>', ThreadItem.ParentBoard.Title);
			CustomStringReplace( Skin, '<BOARDURL/>', ThreadItem.ParentBoard.URL);
			CustomStringReplace( Skin, '<THREADNAME/>', ThreadItem.Title);
			CustomStringReplace( Skin, '<SKINPATH/>', GikoSys.Setting.CSSFileName);
			CustomStringReplace( Skin, '<GETRESCOUNT/>', IntToStr( ThreadItem.Count - ThreadItem.NewResCount ));
			CustomStringReplace( Skin, '<NEWRESCOUNT/>', IntToStr( ThreadItem.NewResCount ));
			CustomStringReplace( Skin, '<ALLRESCOUNT/>', IntToStr( ThreadItem.Count ));

			CustomStringReplace( Skin, '<NEWDATE/>',FormatDateTime('yyyy/mm/dd(ddd) hh:mm', ThreadItem.RoundDate));
			CustomStringReplace( Skin, '<SIZEKB/>', IntToStr( Floor( SizeByte / 1024 ) ));
			CustomStringReplace( Skin, '<SIZE/>', IntToStr( SizeByte ));

			//----- �Ƃ肠����������`����݊��p�B�R�����g�A�E�g���Ă��悵
			// ��肩�����ꂵ�����ǁA�I�v�V�����_�C�A���O�̃v���r���[�p try
			if GikoSys.Setting.UseKatjushaType then begin
				try
					if ThreadItem.ParentBoard <> nil then
						if ThreadItem.ParentBoard.ParentCategory <> nil then
							CustomStringReplace( Skin, '&BBSNAME', ThreadItem.ParentBoard.ParentCategory.ParenTBBS.Title);
						CustomStringReplace( Skin, '&THREADURL', ThreadItem.URL);
				except end;
				CustomStringReplace( Skin, '&BOARDNAME', ThreadItem.ParentBoard.Title);
				CustomStringReplace( Skin, '&BOARDURL', ThreadItem.ParentBoard.URL);
				CustomStringReplace( Skin, '&THREADNAME', ThreadItem.Title);
				CustomStringReplace( Skin, '&SKINPATH', GikoSys.Setting.CSSFileName);
				CustomStringReplace( Skin, '&GETRESCOUNT', IntToStr( ThreadItem.NewReceive - 1 ));
				CustomStringReplace( Skin, '&NEWRESCOUNT', IntToStr( ThreadItem.NewResCount ));
				CustomStringReplace( Skin, '&ALLRESCOUNT', IntToStr( ThreadItem.AllResCount ));

				CustomStringReplace( Skin, '&NEWDATE', FormatDateTime('yyyy/mm/dd(ddd) hh:mm', ThreadItem.RoundDate));
				CustomStringReplace( Skin, '&SIZEKB', IntToStr( Floor( SizeByte / 1024 ) ));
				CustomStringReplace( Skin, '&SIZE', IntToStr( SizeByte ));
			end
			//----- �����܂�
		end;
		Result := Skin.Text;
	finally
		Skin.Free;
	end;
end;

// ���X�̒l��u������
function THTMLCreate.SkinedRes(
	const skin: string;
	PRes: PResRec;
	const No: string
): string;
const
	FORMT_NAME = '<b>%s</b>';
	FORMT_NUM  = '<a href="menu:%s" name="%s">%s</a>';
	FORMT_MAILNAME  = '<a href="mailto:%s"><b>%s</b></a>';
var
	spamminess	: Extended;
{$IFDEF SPAM_FILTER_ENABLED}
	wordCount		: TWordCount;
{$ENDIF}
begin
{$IFDEF SPAM_FILTER_ENABLED}
	wordCount := TWordCount.Create;
	try
		spamminess := Floor( GikoSys.SpamParse(
			Res.FName + '<>' + Res.FMailTo + '<>' + Res.FBody, wordCount ) * 100 );
{$ELSE}
	spamminess := 0;
{$ENDIF}
		Result := CustomStringReplace( skin, '<SPAMMINESS/>', FloatToStr( spamminess ) );
		Result := CustomStringReplace( Result, '<NONSPAMMINESS/>', FloatToStr( 100 - spamminess ) );
		Result := CustomStringReplace( Result, '<MAIL/>', PRes.FMailTo);
		Result := CustomStringReplace( Result, '<DATE/>', PRes.FDateTime);
		Result := CustomStringReplace( Result, '<PLAINNUMBER/>', No);
		Result := CustomStringReplace( Result, '<NAME/>',
			Format(FORMT_NAME, [PRes.FName]));
		Result := CustomStringReplace( Result, '<NUMBER/>',
			Format(FORMT_NUM, [No, No, No]));
		Result := CustomStringReplace( Result, '<MAILNAME/>',
			Format(FORMT_MAILNAME,[PRes.FMailTo, PRes.FName]));
		Result := CustomStringReplace( Result, '<MESSAGE/>', PRes.FBody);

		//----- ������`����݊��p�B�R�����g�A�E�g���Ă��悵
		if GikoSys.Setting.UseKatjushaType then begin
			Result := CustomStringReplace( Result, '&NUMBER',
				'<a href="menu:' + No + '" name="' + No + '">' + No + '</a>');
			Result := CustomStringReplace( Result, '&PLAINNUMBER', No);
			Result := CustomStringReplace( Result, '&NAME', '<b>' + PRes.FName + '</b>');
			Result := CustomStringReplace( Result, '&MAILNAME',
				'<a href="mailto:' + PRes.FMailTo + '"><b>' + PRes.FName + '</b></a>');
			Result := CustomStringReplace( Result, '&MAIL', PRes.FMailTo);
			Result := CustomStringReplace( Result, '&DATE', PRes.FDateTime);
			Result := CustomStringReplace( Result, '&MESSAGE', PRes.FBody);
			Result := CustomStringReplace( Result, '&SPAMMINESS', FloatToStr( spamminess ) );
			Result := CustomStringReplace( Result, '&NONSPAMMINESS', FloatToStr( 100 - spamminess ) );
		end;
		//----- �����܂�
{$IFDEF SPAM_FILTER_ENABLED}
	finally
		wordCount.Free;
	end;
{$ENDIF}

end;
(*************************************************************************
 *http://�̕������anchor�^�O�t���ɂ���B
 *************************************************************************)
procedure THTMLCreate.AddAnchorTag(PRes: PResRec);
const
    EMOTICONS: String = 'sssp://img.2ch.net/';
    EMOTICONS5: String = 'sssp://img.5ch.net/';   // for 5ch
var
	url: string;
	href: string;
	i, j, b: Integer;
	tmp: Integer;
	idx, idx2: Integer;
	pos : PChar;
	pp, pe : PChar;
	s : String;
	len : Integer;
  urllen: Integer;
  url5ch, ok: Boolean;
  chk: SmallInt;
begin
	s := PRes.FBody;
	PRes.FBody := '';

	//while True do begin
	repeat
		idx  := MaxInt;
		idx2 := MaxInt;
		pp := PChar(s);
		pe := pp + Length(s);

		for j := Low(REF_MARK) to High(REF_MARK) do begin
			pos := AnsiStrPosEx(pp, pe, pREF_MARKSs[j], pREF_MARKSe[j]);
			if (pos <> nil) and (REF_MARK_LEN[j] > 0) then begin
      	chk := Ord(pos[REF_MARK_LEN[j]]);
				if (not ((chk >= $30) and (chk <= $39))) and
					 (not ((chk >= $41) and (chk <= $5A))) and
					 (not ((chk >= $61) and (chk <= $7A))) and
           (chk <> $26) then		// �����Q�ƂŋK�����������p�^�[�����������珜�O
        	pos := nil;
      end;
			if pos <> nil then begin
				tmp := pos - pp + 1;
				idx := Min(tmp, idx);
				if idx = tmp then idx2 := j;   //�ǂ̃}�[�N�ň���������������ۑ�
			end;
		end;

		if idx = MaxInt then begin
			//�����N��������B
			len := Length(PRes.FBody);
			SetLength(PRes.FBody, Length(s) + len);
			Move(pp^, PRes.FBody[len + 1], Length(s));
		end else begin
			if (idx > anchorLen) and
				(AnsiStrPosEx(pp + idx - 1 - anchorLen, pp + idx, pANCHORs, pANCHORe) <> nil) then begin
				//���Ƀ����N�^�O�����Ă�����ۂ��Ƃ��̓��V
				//</a></A>��T���A�������Ō�����Ȃ���Α啶���Ō���
				pos := AnsiStrPosEx(pp + idx, pe, pCTAGLs, pCTAGLe);
				if pos = nil then
					pos := AnsiStrPosEx(pp + idx, pe, pCTAGUs, pCTAGUe);
				if pos = nil then
					b := Length(REF_MARK[idx2])
				else
					b := pos - (pp  + idx) + 1;

				len := Length(PRes.FBody);
				SetLength(PRes.FBody, len + idx + b );
				Move(pp^, PRes.FBody[len + 1], idx + b);
				Delete(s, 1, idx + b);
			end else begin
				pp      := PChar(s);
				len 	:= Length(PRes.FBody);
				SetLength(PRes.FBody, len + idx - 1);
				Move(pp^, PRes.FBody[len + 1], idx - 1);

				Delete(s, 1, idx - 1);
				b := Length( s ) + 1;
				pp      := PChar(s);
        url5ch := GikoSys.Is2chURL(s, True);  // 5ch��URL���ǂ����i�v���g�R�����̒Z�k���e�j
				for i := 1 to b do begin
					//�P�o�C�g������URL�Ɏg���Ȃ������Ȃ�
          if url5ch then begin
            ok := (AnsiStrPosEx(pURLC5CHs, pURLC5CHe, pp, pp + 1) = nil);
          end else begin
            ok := (AnsiStrPosEx(pURLCHARs, pURLCHARe, pp, pp + 1) = nil);
          end;
					if ok then begin
						url := Copy(s, 1, i - 1);
						Delete(s, 1, i - 1);
            urllen := Length(url);
            if (AnsiPos(REF_MARK[0], url) = 1) then
                href := 'https' + Copy(url, 5, urllen - 4)  // sssp:// -> https://
            else
                href := Format('%s%s', [REF_MARK_HEAD[idx2], url]);
            GikoSys.Regulate2chURL(href);      // for 5ch

            if (GikoSys.Setting.IconImageDisplay = True) and
               ((AnsiPos(EMOTICONS, url) = 1) or (AnsiPos(EMOTICONS5, url) = 1)) and (IsImageExp(url) = True) then
                PRes.FBody := Format('%s<img src="%s" title="%s">', [PRes.FBody, href, url])
            else
                PRes.FBody
                    := Format('%s<a href="%s" target="_blank">%s</a>', [PRes.FBody, href, url]);
						Break;
					end;
					//�ꕶ���i�߂�B
					Inc(pp);
				end;
			end;
		end;
	until idx = MaxInt;
end;

function THTMLCreate.IsImageExp(const Url: String): Boolean;
var
    urllen: Integer;
begin
    urllen := Length(Url);
    if (AnsiPos('.gif', Url) = urllen - 3) then
        Result := True
    else if (AnsiPos('.png', Url) = urllen - 3) then
        Result := True
    else if (AnsiPos('.jpg', Url) = urllen - 3) then
        Result := True
    else if (AnsiPos('.jpeg', Url) = urllen - 4) then
        Result := True
    else if (AnsiPos('.jpg:large', Url) = urllen - 9) then
        Result := True
    else
        Result := False;
end;

//�����AAID�F�ΏۂƂȂ���tID������AANum:���X�� AURL�F���̃X���b�h��URL
function THTMLCreate.AddBeProfileLink(AID : string; ANum: Integer):string ;
const
	BE_MARK : string = 'BE:';
var
	p : integer;
	BNum, BMark : string;
begin
	p := AnsiPos(BE_MARK, AnsiUpperCase(AID));
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
//! ���X�A���J�[�̃��X�ԍ��𕪊�����
// Text = '1-9' -> st =  '1'; et = '9'
// Text = '10'  -> st = '10'; et = '10'
procedure THTMLCreate.separateNumber(var st: String; var et: String; const Text:String; const Separator: String);
var
	p : Integer;
begin
	p := Pos(Separator,Text);
	if (p > 0 ) then begin
		st := Copy(Text, 1, p - 1);
		et := Copy(Text, p + Length(Separator), Length(Text));
	end else begin
		st := Text;
		et := Text;
	end;
end;
//! ���X�A���J�[���w���Ă��郌�X�ԍ��̕�������擾����
function THTMLCreate.getNumberString(
    const str: String;
    var index :Integer; var dbCharlen: Boolean; sLen :Integer)
: String;
const
	SN	= '0123456789';
var
    ch : String;
    sw : Boolean;
begin
    Result := '';
    sw := False;
    while (index <= sLen) do begin
        if (ByteType(str, index) = mbSingleByte) then begin
            //1byte����
            ch := str[index];
            Inc(index);
            dbCharlen := false;
        end else begin
            //2byte����
            ch := ZenToHan(Copy(str, index, 2));
            Inc(index, 2);
            dbCharlen := true;
        end;

        if System.Pos(ch, SN) > 0 then begin
            Result := Result + ch;
        end else if (ch = '-') then begin
            if sw then break;
            if Result = '' then break;
            Result := Result + ch;
            sw := true;
        end else begin
            break;
        end;
    end;
end;

procedure THTMLCreate.ConvRes( PRes : PResRec; PResLink : PResLinkRec; DatToHTML: boolean = false);
const
	GT	= '&gt;';
	//�����Ώۂ̕�����S
	TOKEN : array[0..5] of string = (GT+GT, GT, '����', '��', '<a ', '<A ');
var
	i : integer;
	s : string;
	No: string;
	pos, pmin : integer;
	j : integer;
	db : boolean;
	rink : string;
begin
	//s �ɖ{����S�������
	s	 :=	PRes.FBody;
	//���ʂ��N���A
	PRes.FBody	 :=	'';

	///
	while Length(s) > 2 do begin
		pmin := Length(s) + 1;
		i	:= Length(token);
		for j := 0 to 5 do begin
			pos := AnsiPos(TOKEN[j], s);
			if pos <> 0 then begin
				if pos < pmin then begin
					//�ǂ�Ńq�b�g�������ۑ�
					i := j;
					//�ŏ��l���X�V
					pmin := pos;
				end;
			end;
		end;

		//�q�b�g����������̈��O�܂Ō��ʂɃR�s�[
		PRes.FBody := PRes.FBody + Copy(s, 1, pmin - 1);
		Delete(s, 1, pmin - 1);

		if i = 6 then begin
			//�q�b�g�Ȃ�
		end else if (i = 4) or (i = 5) then begin
			//'<a ' or '<A' �Ńq�b�g '</a>' or '</A>' �܂ŃR�s�[
			pmin := AnsiPos('</a>' , s);
			pos := AnsiPos('</A>' , s);
			if (pmin <> 0) and (pos <> 0) then begin
				if (pmin > pos) then begin
					pmin := pos;
				end;
			end else if (pos <> 0) then begin
				pmin := pos;
			end;
			rink := Copy(s, 1, pmin + 3);
			PRes.FBody := PRes.FBody + rink;
			Delete(s, 1, pmin + 3);

			pmin := Length(rink);
			i	:= Length(TOKEN);
			for j := 0 to 3 do begin
				pos := AnsiPos(TOKEN[j], rink);
				if pos <> 0 then begin
					if pos < pmin then begin
						//�ǂ�Ńq�b�g�������ۑ�
						i := j;
						//�ŏ��l���X�V
						pmin := pos;
					end;
				end;
			end;
			// ���X�A���J�[���܂܂�Ă�����,����������A���J�[�Ƃ��Ĉ���
			if i <= 3 then begin
                appendResAnchor(PRes, PResLink, DatToHTML, s );
			end;
		end else begin
			//�������猩�������p�^�[��
			j := Length(TOKEN[i]) + 1;
			db := false;
        	No := getNumberString(s, j, db, Length(s) );
			//�I�[�܂ōs���Ă̏I�����`�F�b�N
			if j <= Length(s) then begin
				if db then j := j - 2
				else j := j - 1;
			end;
			addResAnchor(PRes, PResLink, DatToHTML, s, j, No);

            // , ���������背�X�A���J�[�Ƃ��ď�������
            appendResAnchor(PRes, PResLink, DatToHTML, s );
		end;
	end;
	if Length(s) > 0 then begin
		PRes.FBody := PRes.FBody + s;
	end;
end;
function THTMLCreate.checkComma(
	const s : String;
	var j : Integer
) : boolean;
var
	bType : TMbcsByteType;
begin
	Result := false;
	if (Length(s) > 0) then begin
		bType := ByteType(s, j);
		if ((bType = mbSingleByte) and (s[j] = ',') or
			((bType = mbLeadByte) and (ZenToHan(Copy(s, j ,2)) = ','))) then begin
			Result := true;
			if (bType = mbSingleByte) then
				Inc(j)
			else
				Inc(j, 2);
		end;
	end;
end;
function THTMLCreate.appendResAnchor(
	PAddRes: PResRec; PResLink : PResLinkRec; dat : boolean;
	var s : String) : string;
var
    No{, ch, oc}: String;
    len, j : Integer;
    cm, {sw,} db : Boolean;

begin
    No := '';
    j := 1;
    cm := checkComma(s, j);
    len := Length(s);
    while cm do begin
        db := false;
        No := getNumberString(s, j, db, len );

        //�I�[�܂ōs���Ă̏I�����`�F�b�N
        if j <= len then begin
            if db then j := j - 2
            else j := j - 1;
        end;
        addResAnchor(PAddRes, PResLink, dat, s, j, No);
        j := 1;
        len := Length(s);
        cm := checkComma(s, j);
    end;
end;

function THTMLCreate.addResAnchor(
	PAddRes: PResRec; PResLink : PResLinkRec; dat : boolean;
	var s : String; j : Integer; const No: String) : string;
const
	FORMAT_LINK = '<a href="../test/read.cgi?bbs=%s&key=%s&st=%s&to=%s&nofirst=true" target="_blank">';
var
	st,et : string;
begin

	//����������������Ȃ��Ƃ�
	if No = '' then begin
		PAddRes.FBody := PAddRes.FBody + Copy(s, 1, j - 1);
	end else begin
		separateNumber(st, et, No, '-');

		if not dat then begin
			PAddRes.FBody := PAddRes.FBody +
				Format(FORMAT_LINK, [PResLink.FBbs, PResLink.FKey, st, et]);
		end else begin
			PAddRes.FBody := PAddRes.FBody + Format('<a href="#%s">', [st]);
		end;
		PAddRes.FBody := PAddRes.FBody + Copy(s, 1, j - 1) + '</a>';
	end;
	Delete(s, 1, j - 1);
end;


procedure THTMLCreate.ConvertResAnchor(PRes: PResRec);
const
	_HEAD : string = '<a href="../';
	_TAIL : string = ' target="_blank">';
	_ST: string = '&st=';
	_TO: string = '&to=';
	_STA: string = '&START=';
	_END: string = '&END=';
var
	i, j, k: Integer;
    hpos, qpos : Integer;
	tmp: string;
	res: string;
begin
	res := PRes.FBody;
	PRes.FBody := '';
	i := AnsiPos(_HEAD, res);
	while i <> 0 do begin
		PRes.FBody := PRes.FBody + Copy(res, 1, i -1);
		Delete(res, 1, i - 1);
		j := AnsiPos(_TAIL, res);
		if j = 0 then begin
			PRes.FBody := PRes.FBody + res;
			Exit;
		end;
		tmp := Copy(res, 1, j - 1);
		Delete(res, 1, j + 16);
		if (AnsiPos(_ST, tmp) <> 0) and (AnsiPos(_TO, tmp) <> 0) then begin
			Delete(tmp, 1, AnsiPos(_ST, tmp) + 3);
			Delete(tmp, AnsiPos(_TO, tmp), Length(tmp));
			PRes.FBody := PRes.FBody + '<a href="#' + tmp + '">';
		end else if (AnsiPos(_STA, tmp) <> 0) and (AnsiPos(_END, tmp) <> 0) then begin
			Delete(tmp, 1, AnsiPos(_STA, tmp) + 6);
			Delete(tmp, AnsiPos(_END, tmp), Length(tmp));
			PRes.FBody := PRes.FBody + '<a href="#' + tmp + '">';
		end else begin
			k := LastDelimiter('/', tmp);
			Delete(tmp, 1, k);
            hpos := AnsiPos('-', tmp);
            qpos := AnsiPos('"', tmp);
            if ( (hpos > 0) and (qpos > 0) ) then begin
                if ( qpos < hpos ) then begin
                    Delete(tmp, qpos, Length(tmp));
                end else begin
                    Delete(tmp, hpos, Length(tmp));
                end;
            end else begin
                if ( qpos > 0 ) then begin
                    Delete(tmp, qpos, Length(tmp));
                end else if ( qpos > 0 ) then begin
                    Delete(tmp, hpos, Length(tmp));
                end;
            end;

			PRes.FBody := PRes.FBody + '<a href="#' + tmp + '">';
		end;
		i := AnsiPos(_HEAD, res);
	end;
	PRes.FBody := PRes.FBody + res;

end;
//Plugin�𗘗p����Board�̃X���b�h��HTML���쐬����doc�ɏ�������
procedure THTMLCreate.CreateUsePluginHTML(html:TBufferedWebBrowser; ThreadItem: TThreadItem; var sTitle: string);
var
	i: integer;
	NewReceiveNo: Integer;
	boardPlugIn : TBoardPlugIn;
	UserOptionalStyle: string;
begin
	//===== �v���O�C���ɂ��\��
	boardPlugIn		:= ThreadItem.ParentBoard.BoardPlugIn;
	NewReceiveNo	:= ThreadItem.NewReceive;
	// �t�H���g��T�C�Y�̐ݒ�
	UserOptionalStyle := GikoSys.SetUserOptionalStyle;
	html.add(boardPlugIn.GetHeader( DWORD( threadItem ),
		'<style type="text/css">body {' + UserOptionalStyle + '}</style>' ));
	html.Add('<p id="idSearch"></p>');
	html.Flush;
	
	for i := 0 to threadItem.Count - 1 do begin
		// 1 �͕K���\��
		if i <> 0 then begin
			// �\���͈͂�����
            if (isOutsideRange(ThreadItem, i)) then begin
                Continue;
            end;
		end;

		// �V���}�[�N
		if (NewReceiveNo = (i + 1)) or ((NewReceiveNo = 0) and (i = 0)) then begin
			try
				if GikoSys.Setting.UseSkin then begin
					if FileExists( GikoSys.GetSkinNewmarkFileName ) then
						html.Add( LoadFromSkin( GikoSys.GetSkinNewmarkFileName, ThreadItem, ThreadItem.Size ))
					else
						html.Add( '<a name="new"></a>');
				end else if GikoSys.Setting.UseCSS then begin
					html.Add('<a name="new"></a><div class="new">�V�����X <span class="newdate">' + FormatDateTime('yyyy/mm/dd(ddd) hh:mm', ThreadItem.RoundDate) + '</span></div>');
				end else begin
					html.Add('</dl>');
					html.Add('<a name="new"></a>');
					html.Add('<table width="100%" bgcolor="#3333CC" cellpadding="0" cellspacing="1"><tr><td align="center" bgcolor="#6666FF" valign="middle"><font size="-1" color="#ffffff"><b>�V�����X ' + FormatDateTime('yyyy/mm/dd(ddd) hh:mm', ThreadItem.RoundDate) + '</b></font></td></tr></table>');
					html.Add('<dl>');
				end;
			except
				html.Add( '<a name="new"></a>');
			end;
		end;

		// ���X
		html.Add( boardPlugIn.GetRes( DWORD( threadItem ), i + 1 ));

		if ThreadItem.Kokomade = (i + 1) then begin
			// �����܂œǂ�
			try
				if GikoSys.Setting.UseSkin then begin
					if FileExists( GikoSys.GetSkinBookmarkFileName ) then
						html.Add( LoadFromSkin( GikoSys.GetSkinBookmarkFileName, ThreadItem, ThreadItem.Size ))
					else
						html.Add( '<a name="koko"></a>');
				end else if GikoSys.Setting.UseCSS then begin
					html.Add('<a name="koko"></a><div class="koko">�R�R�܂œǂ�</div>');
				end else begin
					html.Add('</dl>');
					html.Add('<a name="koko"></a><table width="100%" bgcolor="#55AA55" cellpadding="0" cellspacing="1"><tr><td align="center" bgcolor="#77CC77" valign="middle"><font size="-1" color="#ffffff"><b>�R�R�܂œǂ�</b></font></td></tr></table>');
					html.Add('<dl>');
				end;
			except
				html.Add('<a name="koko"></a>');
			end;
		end;
	end;


	// �X�L��(�t�b�^)
	html.Add( boardPlugIn.GetFooter( DWORD( threadItem ), '<a name="bottom"></a>' ));
end;


procedure THTMLCreate.CreateUseSKINHTML(html:TBufferedWebBrowser; ThreadItem: TThreadItem; ReadList: TStringList);
const
	KOKO_TAG = '<a name="koko"></a>';
	NEW_TAG = '<a name="new"></a>';
var
	i: integer;
	NewReceiveNo: Integer;
	Res: TResRec;
	UserOptionalStyle: string;
	SkinHeader: string;
	SkinNewRes: string;
	SkinRes: string;
	ThreadName : string;
	ResLink :TResLinkRec;
begin
	NewReceiveNo := ThreadItem.NewReceive;
	// �t�H���g��T�C�Y�̐ݒ�
	UserOptionalStyle := GikoSys.SetUserOptionalStyle;
	ThreadName := ChangeFileExt(ThreadItem.FileName, '');
	ResLink.FBbs := ThreadItem.ParentBoard.BBSID;
	ResLink.FKey := ThreadName;
	// �X�L���̐ݒ�
	try
		SkinHeader := LoadFromSkin( GikoSys.GetSkinHeaderFileName, ThreadItem, ThreadItem.Size);
		if Length( UserOptionalStyle ) > 0 then
			SkinHeader := CustomStringReplace( SkinHeader, '</head>',
				'<style type="text/css">body {' + UserOptionalStyle + '}</style></head>');
		html.Add( SkinHeader );
	except
	end;

	SkinNewRes := LoadFromSkin( GikoSys.GetSkinNewResFileName, ThreadItem, ThreadItem.Size);
	SkinRes := LoadFromSkin( GikoSys.GetSkinResFileName, ThreadItem, ThreadItem.Size );

	html.Add('<p id="idSearch"></p>'#13#10'<a name="top"></a>');
	html.Flush;

	for i := 0 to ReadList.Count - 1 do begin
		// 1 �͕K���\��
		if i <> 0 then begin
			// �\���͈͂�����
            if (isOutsideRange(ThreadItem, i)) then begin
                Continue;
            end;
		end;

		// �V���}�[�N
		if (NewReceiveNo = i + 1) or ((NewReceiveNo = 0) and (i = 0)) then begin
			if FileExists( GikoSys.GetSkinNewmarkFileName ) then
				html.Add( LoadFromSkin( GikoSys.GetSkinNewmarkFileName, ThreadItem, ThreadItem.Size ))
			else
				html.Add( NEW_TAG );
		end;

		if (Trim(ReadList[i]) <> '') then begin
			DivideStrLine(ReadList[i], @Res);
            AddAnchorTag(@Res);
            ConvRes(@Res, @ResLink);
            Res.FDateTime := AddBeProfileLink(Res.FDateTime, i + 1);

            if NewReceiveNo <= (i + 1) then
                // �V�����X
                html.Add(SkinedRes(SkinNewRes, @Res, IntToStr(i + 1)))
            else
                // �ʏ�̃��X
                html.Add(SkinedRes(SkinRes, @Res, IntToStr(i + 1)));
		end;

		if ThreadItem.Kokomade = (i + 1) then begin
			// �����܂œǂ�
			if FileExists( GikoSys.GetSkinBookmarkFileName ) then
				html.Add( LoadFromSkin( GikoSys.GetSkinBookmarkFileName, ThreadItem, ThreadItem.Size ))
			else
				html.Add( KOKO_TAG );
		end;
	end;
    html.Add(getKeywordLink(ThreadItem));
	html.Add('<a name="bottom"></a>');
	// �X�L��(�t�b�^)
	html.Add( LoadFromSkin( GikoSys.GetSkinFooterFileName, ThreadItem, ThreadItem.Size ) );
end;

procedure THTMLCreate.CreateUseCSSHTML(html:TBufferedWebBrowser; ThreadItem: TThreadItem; ReadList: TStringList; sTitle: string );
const
	FORMAT_NOMAIL  = '<a name="%s"></a><div class="header"><span class="no"><a href="menu:%s">%s</a></span>'
					+ '<span class="name_label"> ���O�F </span> <span class="name"><b>%s</b></span>'
					+ '<span class="date_label"> ���e���F</span> <span class="date">%s</span></div>'
					+ '<div class="mes">%s</div>';

	FORMAT_SHOWMAIL = '<a name="%s"></a><div class="header"><span class="no"><a href="menu:%s">%s</a></span>'
					+ '<span class="name_label"> ���O�F </span><a class="name_mail" href="mailto:%s">'
					+ '<b>%s</b></a><span class="mail"> [%s]</span><span class="date_label"> ���e���F</span>'
					+ '<span class="date"> %s</span></div><div class="mes">%s</div>';

	FORMAT_NOSHOW = '<a name="%s"></a><div class="header"><span class="no"><a href="menu:%s">%s</a></span>'
					+ '<span class="name_label"> ���O�F </span><a class="name_mail" href="mailto:%s">'
					+ '<b>%s</b></a><span class="date_label"> ���e���F</span><span class="date"> %s</span></div>'
					+ '<div class="mes">%s</div>';
var
	i: integer;
	No: string;
	CSSFileName: string;
	NewReceiveNo: Integer;
	Res: TResRec;
	UserOptionalStyle: string;
	ThreadName :String;
	ResLink :TResLinkRec;
begin
	NewReceiveNo := ThreadItem.NewReceive;
	ThreadName := ChangeFileExt(ThreadItem.FileName, '');
	ResLink.FBbs := ThreadItem.ParentBoard.BBSID;
	ResLink.FKey := ThreadName;
	// �t�H���g��T�C�Y�̐ݒ�
	UserOptionalStyle := GikoSys.SetUserOptionalStyle;
	CSSFileName := GikoSys.GetStyleSheetDir + GikoSys.Setting.CSSFileName;
	if GikoSys.Setting.UseCSS and FileExists(CSSFileName) then begin
		//CSS�g�p
		html.Add('<html><head>');
		html.Add('<meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">');
		html.Add('<title>' + sTitle + '</title>');
		html.Add('<link rel="stylesheet" href="'+CSSFileName+'" type="text/css">');
		if Length( UserOptionalStyle ) > 0 then
			html.Add('<style type="text/css">body {' + UserOptionalStyle + '}</style>');
		html.Add('</head>'#13#10'<body>');
		html.Add('<a name="top"></a>'#13#10'<p id="idSearch"></p>');
		html.Add('<div class="title">' + sTitle + '</div>');
		html.Flush;
		for i := 0 to ReadList.Count - 1 do begin
			// 1 �͕K���\��
			if i <> 0 then begin
    			// �\���͈͂�����
                if (isOutsideRange(ThreadItem, i)) then begin
                    Continue;
                end;
			end;

			if (NewReceiveNo = (i + 1)) or ((NewReceiveNo = 0) and (i = 0)) then begin
				html.Add('<a name="new"></a><div class="new">�V�����X <span class="newdate">' + FormatDateTime('yyyy/mm/dd(ddd) hh:mm', ThreadItem.RoundDate) + '</span></div>');
			end;

			if (Trim(ReadList[i]) <> '') then begin
				No := IntToStr(i + 1);
				DivideStrLine(ReadList[i], @Res);
                AddAnchorTag(@Res);
                ConvRes(@Res, @ResLink);
                Res.FDateTime := AddBeProfileLink(Res.FDateTime, i + 1);
                if Res.FMailTo = '' then
                    html.Add(Format(FORMAT_NOMAIL, [No, No, No, Res.FName, Res.FDateTime, Res.FBody]))
                else if GikoSys.Setting.ShowMail then
                    html.Add(Format(FORMAT_SHOWMAIL, [No, No, No, Res.FMailTo, Res.FName, Res.FMailTo, Res.FDateTime, Res.FBody]))
                else
                    html.Add(Format(FORMAT_NOSHOW, [No, No, No, Res.FMailTo, Res.FName, Res.FDateTime, Res.FBody]));
            end;
			if ThreadItem.Kokomade = (i + 1) then begin
				html.Add('<a name="koko"></a><div class="koko">�R�R�܂œǂ�</div>');
			end;

		end;
        html.Add(getKeywordLink(ThreadItem));
		html.Add('<a name="bottom"></a>');
		html.Add('<a name="last"></a>');
		html.Add('</body></html>');
	end;
end;

procedure THTMLCreate.CreateDefaultHTML (html:TBufferedWebBrowser; ThreadItem: TThreadItem; ReadList: TStringList; sTitle: string );
var
	i: integer;
	NewReceiveNo: Integer;
	ThreadName: String;
	ResLink : TResLinkRec;
begin
	NewReceiveNo := ThreadItem.NewReceive;
	ThreadName := ChangeFileExt(ThreadItem.FileName, '');
	ResLink.FBbs := ThreadItem.ParentBoard.BBSID;
	ResLink.FKey := ThreadName;
	html.Add('<html><head>');
	html.Add('<meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">');
	html.Add('<title>' + sTitle + '</title></head>');
	html.Add('<body TEXT="#000000" BGCOLOR="#EFEFEF" link="#0000FF" alink="#FF0000" vlink="#660099">');
	html.Add('<a name="top"></a>');
	html.Add('<font size=+1 color="#FF0000">' + sTitle + '</font>');
	html.Add('<dl>');
	html.Add('<p id="idSearch"></p>');
	html.Flush;
	for i := 0 to ReadList.Count - 1 do begin
		// 1 �͕K���\��
		if i <> 0 then begin
			// �\���͈͂�����
            if (isOutsideRange(ThreadItem, i)) then begin
                Continue;
            end;
		end;

		if (NewReceiveNo = (i + 1)) or ((NewReceiveNo = 0) and (i = 0)) then begin
			html.Add('</dl>');
			html.Add('<a name="new"></a>');
			html.Add('<table width="100%" bgcolor="#3333CC" cellpadding="0" cellspacing="1"><tr><td align="center" bgcolor="#6666FF" valign="middle"><font size="-1" color="#ffffff"><b>�V�����X ' + FormatDateTime('yyyy/mm/dd(ddd) hh:mm', ThreadItem.RoundDate) + '</b></font></td></tr></table>');
			html.Add('<dl>');
		end;

		if (Trim(ReadList[i]) <> '') then begin
            html.Add(GetResString(i, ReadList[i], @ResLink));
        end;
		if ThreadItem.Kokomade = (i + 1) then begin
			html.Add('</dl>');
			html.Add('<a name="koko"></a><table width="100%" bgcolor="#55AA55" cellpadding="0" cellspacing="1"><tr><td align="center" bgcolor="#77CC77" valign="middle"><font size="-1" color="#ffffff"><b>�R�R�܂œǂ�</b></font></td></tr></table>');
			html.Add('<dl>');
		end;
	end;
    html.Add(getKeywordLink(ThreadItem));
	html.Add('</dl>'#13#10'<a name="bottom"></a>'#13#10'</body></html>');
end;
function THTMLCreate.GetResString(index: Integer; const Line: String; PResLink : PResLinkRec): String;
var
    No : String;
    Res: TResRec;
begin
    No := IntToStr(index + 1);
    DivideStrLine(Line, @Res);
    Res.FBody := DeleteLink(Res.FBody);
    AddAnchorTag(@Res);
    ConvRes(@Res, PResLink);
    Res.FDateTime := AddBeProfileLink(Res.FDateTime, index + 1);
    if Res.FMailTo = '' then
        Result := '<a name="' + No + '"></a><dt><a href="menu:' + No + '">' + No + '</a> ���O�F<font color="forestgreen"><b> ' + Res.FName + ' </b></font> ���e���F <span class="date">' + Res.FDateTime+ '</span><br><dd>' + Res.Fbody + ' <br><br><br>'#13#10
    else if GikoSys.Setting.ShowMail then
        Result := '<a name="' + No + '"></a><dt><a href="menu:' + No + '">' + No + '</a> ���O�F<a href="mailto:' + Res.FMailTo + '"><b> ' + Res.FName + ' </B></a> [' + Res.FMailTo + '] ���e���F <span class="date">' + Res.FDateTime+ '</span><br><dd>' + Res.Fbody + ' <br><br><br>'#13#10
    else
        Result := '<a name="' + No + '"></a><dt><a href="menu:' + No + '">' + No + '</a> ���O�F<a href="mailto:' + Res.FMailTo + '"><b> ' + Res.FName + ' </B></a> ���e���F <span class="date">' + Res.FDateTime+ '</span><br><dd>' + Res.Fbody + ' <br><br><br>'#13#10;
end;
procedure THTMLCreate.CreateHTML2(Browser: TWebBrowser; ThreadItem: TThreadItem; var sTitle: string);
var
	ReadList: TStringList;
	CSSFileName: string;
	FileName: string;
	Res: TResRec;
	body : TBufferedWebBrowser;
    ThreadInfo: TAbonThread;
{$IFDEF DEBUG}
	st, rt: Cardinal;
{$ENDIF}
begin
{$IFDEF DEBUG}
	Writeln('Create HTML');
	st := GetTickCount;
{$ENDIF}
	if ThreadItem <> nil then begin
		body := TBufferedWebBrowser.Create(Browser, 100);
		try
			body.Open;
			if ThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
				CreateUsePluginHTML(body, ThreadItem, sTitle);
			end else begin
				ShortDayNames[1] := '��';		ShortDayNames[2] := '��';
				ShortDayNames[3] := '��';		ShortDayNames[4] := '��';
				ShortDayNames[5] := '��';		ShortDayNames[6] := '��';
				ShortDayNames[7] := '�y';

				ReadList := TStringList.Create;
				try
					if ThreadItem.IsLogFile then begin
                        ThreadInfo := TAbonThread.Create;
                        ThreadInfo.Is2ch  := ThreadItem.ParentBoard.Is2ch;
                        ThreadInfo.Board  := ThreadItem.ParentBoard.BBSID;
                        ThreadInfo.Thread := ChangeFileExt(ThreadItem.FileName, '');
						ReadList.BeginUpdate;
						FileName := ThreadItem.GetThreadFileName;
						ReadList.LoadFromFile(FileName);
						ReadList.EndUpdate;
						GikoSys.FAbon.IndividualAbon(ReadList, ChangeFileExt(FileName,'.NG'));
						GikoSys.FAbon.Execute(ReadList, ThreadInfo);		//	 ���ځ`�񂵂�
						GikoSys.FSelectResFilter.Execute(ReadList, ThreadInfo); //���X�̃t�B���^�����O������
						if ThreadItem.Title = '' then begin
							DivideStrLine(ReadList[0], @Res);
							sTitle := Res.FTitle;
						end else
							sTitle := ThreadItem.Title;
                        ThreadInfo.Free;
					end else begin
						sTitle := CustomStringReplace(ThreadItem.Title, '���M', ',');
					end;
					// �t�H���g��T�C�Y�̐ݒ�
					CSSFileName := GikoSys.GetStyleSheetDir + GikoSys.Setting.CSSFileName;
					if GikoSys.Setting.UseSkin then begin
						CreateUseSKINHTML(body, ThreadItem, ReadList);
					end else if GikoSys.Setting.UseCSS and FileExists(CSSFileName) then begin
						CreateUseCSSHTML(body, ThreadItem, ReadList, sTitle);
					end else begin
						CreateDefaultHTML(body, ThreadItem, ReadList, sTitle);
					end;
				finally
					ReadList.Free;
				end;
			end;
		finally
			body.Close;
			body.Free;
		end;
	end;
{$IFDEF DEBUG}
	rt := GetTickCount - st;
	Writeln('Done.');
	Writeln(IntToStr(rt) + ' ms');
{$ENDIF}
end;

procedure THTMLCreate.CreateHTML3(var html: TStringList; ThreadItem: TThreadItem; var sTitle: string);
var
	i: integer;
	No: string;
	//bufList : TStringList;
	ReadList: TStringList;
//	SaveList: TStringList;
	CSSFileName: string;
	BBSID: string;
	FileName: string;
	Res: TResRec;
	boardPlugIn : TBoardPlugIn;

	UserOptionalStyle: string;
	SkinHeader: string;
	SkinRes: string;
	tmp, tmp1: string;
	ThreadName: String;
	ResLink : TResLinkRec;
    ThreadInfo: TAbonThread;

	function LoadSkin( fileName: string ): string;
	begin
		Result := LoadFromSkin( fileName, ThreadItem, ThreadItem.Size );
	end;
	function ReplaceRes( skin: string ): string;
	begin
		Result := SkinedRes( skin, @Res, No );
	end;

begin
	if ThreadItem <> nil then begin
		CSSFileName := GikoSys.GetStyleSheetDir + GikoSys.Setting.CSSFileName;
		ThreadName := ChangeFileExt(ThreadItem.FileName, '');
		ResLink.FBbs := ThreadItem.ParentBoard.BBSID;
		ResLink.FKey := ThreadName;
		html.Clear;
		html.BeginUpdate;
		//if ThreadItem.IsBoardPlugInAvailable then begin
		if ThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
			//===== �v���O�C���ɂ��\��
			//boardPlugIn		:= ThreadItem.BoardPlugIn;
			boardPlugIn		:= ThreadItem.ParentBoard.BoardPlugIn;
			// �t�H���g��T�C�Y�̐ݒ�
			UserOptionalStyle := GikoSys.SetUserOptionalStyle;
			try
				// �����R�[�h�̓v���O�C���ɔC����
				// �w�b�_
				tmp := boardPlugIn.GetHeader( DWORD( threadItem ),
					'<style type="text/css">body {' + UserOptionalStyle + '}</style>' );
				//��ΎQ�Ƃ��瑊�ΎQ�Ƃ�
				if GikoSys.Setting.UseSkin then begin
					tmp1 := './' + GikoSys.Setting.CSSFileName;
					tmp1 := CustomStringReplace(tmp1, GikoSys.GetConfigDir, '');
					tmp1 := CustomStringReplace(tmp1, '\', '/');
					tmp := CustomStringReplace(tmp, ExtractFilePath(GikoSys.Setting.CSSFileName),  tmp1);
				end else if GikoSys.Setting.UseCSS then begin
					tmp1 := './' + CSSFileName;
					tmp1 := CustomStringReplace(tmp1, GikoSys.GetConfigDir, '');
					tmp1 := CustomStringReplace(tmp1, '\', '/');
					tmp := CustomStringReplace(tmp, CSSFileName,  tmp1);
				end;
				html.Append( tmp );

				for i := 0 to threadItem.Count - 1 do begin

					// ���X
					Res.FBody := boardPlugIn.GetRes( DWORD( threadItem ), i + 1 );
					ConvertResAnchor(@Res);
					html.Append( Res.FBody );

				end;
				// �X�L��(�t�b�^)
				html.Append( boardPlugIn.GetFooter( DWORD( threadItem ), '<a name="bottom"></a>' ) );
			finally
			end;
			html.EndUpdate;
			//Exit;
		end else begin
			ShortDayNames[1] := '��';		ShortDayNames[2] := '��';
			ShortDayNames[3] := '��';		ShortDayNames[4] := '��';
			ShortDayNames[5] := '��';		ShortDayNames[6] := '��';
			ShortDayNames[7] := '�y';
			BBSID := ThreadItem.ParentBoard.BBSID;
			ReadList := TStringList.Create;
			try
				if ThreadItem.IsLogFile then begin
                    ThreadInfo := TAbonThread.Create;
                    ThreadInfo.Is2ch  := ThreadItem.ParentBoard.Is2ch;
                    ThreadInfo.Board  := ThreadItem.ParentBoard.BBSID;
                    ThreadInfo.Thread := ChangeFileExt(ThreadItem.FileName, '');
					FileName := ThreadItem.GetThreadFileName;
					ReadList.LoadFromFile(FileName);
					GikoSys.FAbon.IndividualAbon(ReadList, ChangeFileExt(FileName,'.NG'));
					GikoSys.FAbon.Execute(ReadList, ThreadInfo);		//	 ���ځ`�񂵂�
					GikoSys.FSelectResFilter.Execute(ReadList, ThreadInfo); //���X�̃t�B���^�����O������
					DivideStrLine(ReadList[0], @Res);
					//Res.FTitle := CustomStringReplace(Res.FTitle, '���M', ',');
					sTitle := Res.FTitle;
                    ThreadInfo.Free;
				end else begin
					sTitle := CustomStringReplace(ThreadItem.Title, '���M', ',');
				end;
				try
					// �t�H���g��T�C�Y�̐ݒ�
					UserOptionalStyle := GikoSys.SetUserOptionalStyle;

					if GikoSys.Setting.UseSkin then begin
						// �X�L���g�p
						// �X�L���̐ݒ�
						try
							SkinHeader := LoadSkin( GikoSys.GetSkinHeaderFileName );
							if Length( UserOptionalStyle ) > 0 then
								SkinHeader := CustomStringReplace( SkinHeader, '</head>',
									'<style type="text/css">body {' + UserOptionalStyle + '}</style></head>');
							//��ΎQ�Ƃ��瑊�ΎQ�Ƃ�
							tmp1 := './' + GikoSys.Setting.CSSFileName;
							tmp1 := CustomStringReplace(tmp1, GikoSys.GetConfigDir, '');
							tmp1 := CustomStringReplace(tmp1, '\', '/');
							SkinHeader := CustomStringReplace(SkinHeader, ExtractFilePath(GikoSys.Setting.CSSFileName),  tmp1);
							html.Append( SkinHeader );
						except
						end;
						try
							SkinRes := LoadSkin( GikoSys.GetSkinResFileName );
						except
						end;
						html.Append('<a name="top"></a>');
						for i := 0 to ReadList.Count - 1 do begin
							if (Trim(ReadList[i]) <> '') then begin
								No := IntToStr(i + 1);

								DivideStrLine(ReadList[i], @Res);
								AddAnchorTag(@Res);
								ConvRes(@Res, @ResLink, true);
								ConvertResAnchor(@Res);

								try
									html.Append( ReplaceRes( SkinRes ) );
								except
								end;
							end;

						end;
						html.Append('<a name="bottom"></a>');
						// �X�L��(�t�b�^)
						try
							html.Append( LoadSkin( GikoSys.GetSkinFooterFileName ) );
						except
						end;
					end else if GikoSys.Setting.UseCSS and FileExists(CSSFileName) then begin
						//CSS�g�p
						//CSSFileName := GetAppDir + CSS_FILE_NAME;
						html.Append('<html><head>');
						html.Append('<meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">');
						html.Append('<title>' + sTitle + '</title>');
						//��ΎQ�Ƃ��瑊�ΎQ�Ƃ�
						tmp1 := './' + CSSFileName;
						tmp1 := CustomStringReplace(tmp1, GikoSys.GetConfigDir, '');
						tmp1 := CustomStringReplace(tmp1, '\', '/');

						html.Append('<link rel="stylesheet" href="'+tmp1+'" type="text/css">');
						if Length( UserOptionalStyle ) > 0 then
							html.Append('<style type="text/css">body {' + UserOptionalStyle + '}</style>');
						html.Append('</head>');
						html.Append('<body>');
						html.Append('<a name="top"></a>');
						html.Append('<div class="title">' + sTitle + '</div>');
						for i := 0 to ReadList.Count - 1 do begin
							if (Trim(ReadList[i]) <> '') then begin
								No := IntToStr(i + 1);
								DivideStrLine(ReadList[i], @Res);
								AddAnchorTag(@Res);
								ConvRes(@Res, @ResLink, true);
								ConvertResAnchor(@Res);
								if Res.FMailTo = '' then
									html.Append('<a name="' + No + '"></a>'
													+ '<div class="header"><span class="no"><a href="menu:' + No + '">' + No + '</a></span> '
													+ '<span class="name_label">���O�F</span> '
													+ '<span class="name"><b>' + Res.FName + '</b></span> '
													+ '<span class="date_label">���e���F</span> '
													+ '<span class="date">' + Res.FDateTime+ '</span></div>'
																								+ '<div class="mes">' + Res.FBody + ' </div>')
								else if GikoSys.Setting.ShowMail then
									html.Append('<a name="' + No + '"></a>'
													+ '<div class="header"><span class="no"><a href="menu:' + No + '">' + No + '</a></span>'
																								+ '<span class="name_label"> ���O�F </span>'
													+ '<a class="name_mail" href="mailto:' + Res.FMailTo + '">'
													+ '<b>' + Res.FName + '</b></a><span class="mail"> [' + Res.FMailTo + ']</span>'
													+ '<span class="date_label"> ���e���F</span>'
													+ '<span class="date"> ' + Res.FDateTime+ '</span></div>'
													+ '<div class="mes">' + Res.FBody + ' </div>')
								else
									html.Append('<a name="' + No + '"></a>'
													+ '<div class="header"><span class="no"><a href="menu:' + No + '">' + No + '</a></span>'
													+ '<span class="name_label"> ���O�F </span>'
													+ '<a class="name_mail" href="mailto:' + Res.FMailTo + '">'
													+ '<b>' + Res.FName + '</b></a>'
													+ '<span class="date_label"> ���e���F</span>'
													+ '<span class="date"> ' + Res.FDateTime+ '</span></div>'
																								+ '<div class="mes">' + Res.FBody + ' </div>');
							end;
						end;
						html.Append('<a name="bottom"></a>');
						html.Append('<a name="last"></a>');
						html.Append('</body></html>');
					end else begin
						//CSS��g�p
						html.Append('<html><head>');
						html.Append('<meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">');
						html.Append('<title>' + sTitle + '</title></head>');
						html.Append('<body TEXT="#000000" BGCOLOR="#EFEFEF" link="#0000FF" alink="#FF0000" vlink="#660099">');
						html.Append('<a name="top"></a>');
						html.Append('<font size=+1 color="#FF0000">' + sTitle + '</font>');
						html.Append('<dl>');
						for i := 0 to ReadList.Count - 1 do begin
							if (Trim(ReadList[i]) <> '') then begin
								No := IntToStr(i + 1);
								DivideStrLine(ReadList[i], @Res);
								AddAnchorTag(@Res);
								ConvRes(@Res, @ResLink, true);
								ConvertResAnchor(@Res);
								if Res.FMailTo = '' then
									html.Append('<a name="' + No + '"></a><dt><a href="menu:' + No + '">' + No + '</a> ���O�F<font color="forestgreen"><b> ' + Res.FName + ' </b></font> ���e���F ' + Res.FDateTime+ '<br><dd>' + Res.Fbody + ' <br><br><br>')
								else if GikoSys.Setting.ShowMail then
									html.Append('<a name="' + No + '"></a><dt><a href="menu:' + No + '">' + No + '</a> ���O�F<a href="mailto:' + Res.FMailTo + '"><b> ' + Res.FName + ' </B></a> [' + Res.FMailTo + '] ���e���F ' + Res.FDateTime+ '<br><dd>' + Res.Fbody + ' <br><br><br>')
								else
									html.Append('<a name="' + No + '"></a><dt><a href="menu:' + No + '">' + No + '</a> ���O�F<a href="mailto:' + Res.FMailTo + '"><b> ' + Res.FName + ' </B></a> ���e���F ' + Res.FDateTime+ '<br><dd>' + Res.Fbody + ' <br><br><br>');
							end;
						end;
						html.Append('</dl>');
						html.Append('<a name="bottom"></a>');
						html.Append('</body></html>');
					end;
				finally
					html.EndUpdate;
				end;
			finally
				ReadList.Free;
			end;
		end;
	end;
end;

procedure THTMLCreate.SetResPopupText(Hint : TResPopupBrowser; threadItem: TThreadItem; StNum, ToNum: Integer; Title, First: Boolean);
var
	i: Integer;
	tmp: string;
	FileName: string;
	Line: Integer;

	wkInt: Integer;

    boardPlugIn : TBoardPlugIn;
    Html: TStringList;
	ResLink : TResLinkRec;
    ThreadInfo: TAbonThread;
begin

    Html := TStringList.Create;
	try
		if StNum > ToNum then begin
			wkInt := StNum;
			StNum := ToNum;
			ToNum := wkInt;
		end;

		//�ő�10���X�܂ŕ\��
		if StNum + MAX_POPUP_RES < ToNum then
			ToNum := StNum + MAX_POPUP_RES;

        Hint.Title := '';
        Hint.RawDocument := '';
        Hint.Thread := nil;

		//�^�C�g���\��
		if Title then
				if ThreadItem <> nil then
					Hint.Title := ThreadItem.Title;

        if ThreadItem <> nil then begin
            ThreadInfo := TAbonThread.Create;
            Hint.Thread := ThreadItem;
            ResLink.FBbs := ThreadItem.ParentBoard.BBSID;
            ResLink.FKey := ChangeFileExt(ThreadItem.FileName, '');
            //if ThreadItem.IsBoardPlugInAvailable then begin
            if ThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
                //===== �v���O�C���ɂ��\��
                //boardPlugIn		:= ThreadItem.BoardPlugIn;
                boardPlugIn		:= ThreadItem.ParentBoard.BoardPlugIn;

                // �t�H���g��T�C�Y�̐ݒ�
                // �����R�[�h�̓v���O�C���ɔC����
                for i := StNum to ToNum do begin
                    Line := i;
					//�����łQ�����˂��dat�̌`���łP�s�ǂݍ��߂�Υ���B���ǂ߂�悤�ɂȂ���
					tmp := boardPlugIn.GetDat( DWORD( threadItem ), i );
                    if (tmp <> '') And ( not GikoSys.FAbon.CheckAbonPopupRes(tmp, ThreadInfo) And( not GikoSys.FAbon.CheckIndividualAbonList(line))) then begin
                        Html.Add(GetResString(Line-1, tmp, @ResLink));
					end;
				end;
			end else begin
                ThreadInfo.Is2ch  := ThreadItem.ParentBoard.Is2ch;
                ThreadInfo.Board  := ThreadItem.ParentBoard.BBSID;
                ThreadInfo.Thread := ChangeFileExt(ThreadItem.FileName, '');
				for i := StNum to ToNum do begin
					Line := i;
					FileName := ThreadItem.FilePath;
					tmp := GikoSys.ReadThreadFile(FileName, Line);
					if (tmp <> '') And ( not GikoSys.FAbon.CheckAbonPopupRes(tmp, ThreadInfo) And( not GikoSys.FAbon.CheckIndividualAbonList(line))) then begin
						Html.Add(GetResString(Line-1, tmp, @ResLink));
					end;
				end;
			end;
            if (Html.Count > 0) then begin
                Hint.RawDocument := '<DL>' + Html.Text + '</DL>';
            end;
            ThreadInfo.Free;
		end;
	finally
        Html.Free;
	end;
end;

//�����N�̕����񂩂烌�X�|�b�v�A�b�v�p��URL�ɕϊ�����
class function THTMLCreate.GetRespopupURL(AText, AThreadURL : string): string;
var
	wkInt: Integer;
begin
	Result := '';
	if Pos('about:blank..', AText) = 1 then begin
		wkInt := LastDelimiter( '/', AThreadURL );
		if Pos( '?', Copy( AThreadURL, wkInt, MaxInt ) ) = 0 then begin
			// Thread.URL �� PATH_INFO �n��
			Result := Copy( AThreadURL, 1,  LastDelimiter( '/', AThreadURL ) );
			wkInt := LastDelimiter( '/', AText );
			if Pos( '?', Copy( AText, wkInt, MaxInt ) ) = 0 then
				// Text �� PATH_INFO �n��
				Result := Result + Copy( AText, LastDelimiter( '/', AText ) + 1, MaxInt )
			else
				// Text �� QUERY_STRING �n��
				Result := Result + Copy( AText, LastDelimiter( '?', AText ) + 1, MaxInt );
		end else begin
			// Thread.URL �� QUERY_STRING �n��
			Result := Copy( AThreadURL, 1,  LastDelimiter( '?', AThreadURL ) );
			wkInt := LastDelimiter( '/', AText );
			if Pos( '?', Copy( AText, wkInt, MaxInt ) ) = 0 then begin
				// Text �� PATH_INFO �n��
				// URL �ɔƃL�[������Ȃ��̂� Text ���璸�Ղ���
				wkInt := LastDelimiter( '/', Copy( AText, 1, wkInt - 1 ) );
				wkInt := LastDelimiter( '/', Copy( AText, 1, wkInt - 1 ) );
				Result := Copy( Result, 1, Length( Result ) - 1 ) + Copy( AText, wkInt, MaxInt );
			end else begin
				// Text �� QUERY_STRING �n��
				Result := Result + Copy( AText, LastDelimiter( '?', AText ) + 1, MaxInt )
			end;
		end;
	end else if Pos('about:blank/bbs/', AText) = 1 then begin
		//�������JBBS�̎d�ς̋z��
		AText := CustomStringReplace(AText, 'about:blank/bbs/', 'about:blank../../bbs/');
		Result := GetRespopupURL(AText, AThreadURL);
	end else begin
		Result := AText;
	end;

end;
//�w�肵���p�X�ɃX�L����������CSS�̃t�@�C���̃R�s�[�����
class procedure THTMLCreate.SkinorCSSFilesCopy(path: string);
var
	tmp, tmpD, tmpF: string;
	current: string;
	dirs: TStringList;
	files: TStringList;
	i, j: Integer;
begin
	if GikoSys.Setting.UseSkin then begin
		current := ExtractFilePath(GikoSys.GetSkinDir);
		tmp := GikoSys.Setting.CSSFileName;
	end else if GikoSys.Setting.UseCSS then begin
		current := ExtractFilePath(GikoSys.GetStyleSheetDir);
		tmp := ExtractFilePath(GikoSys.GetStyleSheetDir + GikoSys.Setting.CSSFileName);
	end else begin
        Exit;
    end;
	dirs := TStringList.Create;
	try
		dirs.Add(tmp);
		if tmp <> current then begin
			GikoSys.GetDirectoryList(current, '*.*', dirs, true);
			for i := 0 to dirs.Count - 1 do begin
				files := TStringList.Create;
				try
					files.BeginUpdate;
					gikoSys.GetFileList(dirs[i], '*.*', files, true);
					files.EndUpdate;
					tmpD := CustomStringReplace(dirs[i], GikoSys.GetConfigDir, path);
					if (AnsiPos(dirs[i], tmp) <> 0) and not (DirectoryExists(tmpD)) then
						ForceDirectories(tmpD);

					if(dirs[i] = tmp) and (dirs[i] <> current) then begin
						for j := 0 to files.Count - 1 do begin
							tmpF := CustomStringReplace(files[j], GikoSys.GetConfigDir, path);
							if not FileExists(tmpF) then begin
								CopyFile(PChar(files[j]), PChar(tmpF),True);
							end;
						end;
					end;
				finally
					files.Free;
				end;
			end;
		end else begin
			tmpD := CustomStringReplace(dirs[0], GikoSys.GetConfigDir, path);
			if not DirectoryExists(tmpD) then
				ForceDirectories(tmpD);
			tmpF := CustomStringReplace(GikoSys.GetStyleSheetDir + GikoSys.Setting.CSSFileName
					, GikoSys.GetConfigDir, path);
			if not FileExists(tmpF) then begin
				CopyFile(PChar(GikoSys.GetStyleSheetDir + GikoSys.Setting.CSSFileName)
					, PChar(tmpF), True);
			end;
		end;
	finally
		dirs.Free;
	end;
end;
{!
\brief dat�t�@�C���̈ꃉ�C���𕪉�
\param Line dat�t�@�C�����\������ 1 �s
\return     ���X���
}
class procedure THTMLCreate.DivideStrLine(Line: string; PRes: PResRec);
const
	delimiter = '<>';
var
	pds, pde : PChar;
	pss, pse : PChar;
	ppos : PChar;
begin
	//�Œ�
	PRes.FType := glt2chNew;

	pss := PChar(Line);
	pse := pss + Length(Line);
	pds := PChar(delimiter);
	pde := pds + Length(delimiter);

	ppos := AnsiStrPosEx(pss, pse, pds, pde);
	if (ppos = nil) then begin
		Line := CustomStringReplace(Line, '<>', '&lt;&gt;');
		Line := CustomStringReplace(Line, ',', '<>');
		Line := CustomStringReplace(Line, '���M', ',');
	end;
	// ����&#78840;�̈��� 0:�������Ȃ� 1:���l�Q�Ƃŕ\�� 2:�ގ������ɒu��
  case GikoSys.Setting.ReplChar of
    1: begin
      Line := CustomStringReplace(Line, '&#78840;', '&amp;#78840;');
      Line := CustomStringReplace(Line, '&#x133f8;', '&amp;#x133f8;', True);
    end;
    2: begin
      Line := CustomStringReplace(Line, '&#78840;', '&#77954;');
      Line := CustomStringReplace(Line, '&#x133f8;', '&#77954;', True);
    end;
  end;
	//Trim���Ă͂����Ȃ��C������@by������
	PRes.FName := MojuUtils.RemoveToken(Line, delimiter);
	PRes.FMailTo := MojuUtils.RemoveToken(Line, delimiter);
	PRes.FDateTime := MojuUtils.RemoveToken(Line, delimiter);
	PRes.FBody := MojuUtils.RemoveToken(Line, delimiter);
	//�Q�����˂�Ƃ����ƁA�{���̐擪�ɂP���p�󔒂������Ă���̂ō폜����
	//���̌f���ŁA���X���̂̋󔒂�������Ȃ����ǂ���͒��߂�
	PRes.FBody := TrimLeft(PRes.FBody);
	//�󂾂Ɩ�肪�N���邩��A�󔒂�ݒ肷��
	if PRes.FBody = '' then
		PRes.FBody := '&nbsp;';

	PRes.FTitle := MojuUtils.RemoveToken(Line, delimiter);
end;

{!
\brief HTML ����A���J�[�^�O���폜
\param s ���ɂȂ� HTML
\return  �A���J�[�^�O���폜���ꂽ HTML
}
class function THTMLCreate.DeleteLink(const s: string): string;
var
	s1: string;
    mark: string;
	idx: Integer;
begin
    mark := '<a href="';
    Result := '';
    s1 := s;
    idx := AnsiPos(mark, s1);
    while idx <> 0 do begin
        Result := Result + Copy(s1, 1, idx - 1);
        Delete(s1, 1, idx);
        // �^�O�̃G���h��T��
        idx := AnsiPos('">', s1);
        if idx <> 0 then begin
            Delete(s1, 1, idx + 1);
        end;
        // </a> �܂�
        idx := AnsiPos('</a>', s1);
        if idx <> 0 then begin
            Result := Result + Copy(s1, 1, idx - 1);
            Delete(s1, 1, idx + 3);
        end;
        idx := AnsiPos(mark, s1);
    end;

    Result := Result + s1;
end;
{
\brief  HTML���̂��߂̒u��
\param  s   ���ɂȂ镶����
\return HTML��innerText�Ƃ��Ă�邳��镶����
}
class function THTMLCreate.RepHtml(const s: string): string;
begin
//	s := StringReplace(s, '&', '&amp;', [rfReplaceAll]);
    Result := s;
	Result := CustomStringReplace(Result, '<', '&lt;');
	Result := CustomStringReplace(Result, '>', '&gt;');
//	s := StringReplace(s, ' ', '&nbsp;', [rfReplaceAll]);	//�d�l�ύX�ɂ��&nbsp;�g�p�s��
	Result := CustomStringReplace(Result, '"', '&quot;');
end;
{
\brief  ���X�G�f�B�^�ł̃v���r���[�pHTML�쐬
\param  Title   �X���b�h�^�C�g��
\param  No  ���X�ԍ�
\param  Mail    ���[����
\param  Name    ���O��
\param  Body    �{��
\return �v���r���[�pHTML
}
class function THTMLCreate.CreatePreviewHTML(
	const Title: string;
	const No: string;
	const Mail: string;
	const Namae: string;
	const Body: string
) : string;
var
    posTrip : Integer;
    tripOrigin : string;
    NameWithTrip: string;
    DateTime: string;
    Start: Integer;
    Index: Integer;
    Len: Integer;
begin
	Result := '<html><head>'#13#10
			+ '<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">'#13#10
			+ '<title>' + title + '</title>'#13#10
			+ '</head>'#13#10
			+ '<body text="#000000" bgcolor="#EFEFEF" link="#0000FF" alink="#FF0000" vlink="#660099">'#13#10
			+ '<font color="#FF0000">' + title + '</font>'#13#10
			+ '<dl>'#13#10;

   	DateTime := FormatDateTime('yyyy/mm/dd(aaa) hh:nn', Now());

    NameWithTrip := Namae;
//    posTrip := AnsiPos( '#', Namae );
    // ���l�����Q�Ƃƃg���b�v�̍����������
    posTrip := 0;
    Start := 1;
    Len := Length(Namae);
    while Start < Len do begin
      Index := PosEx('#', Namae, Start);
      if Index < 1 then
        Break;
      if (Index = 1) or (Namae[Index - 1] <> '&') or (PosEx(';', Namae, Index) < 1) then begin
        posTrip := Index;
        Break;
      end;
      Start := Index + 1;
    end;
    //--
    if posTrip > 0 then begin
        tripOrigin := Copy( Namae, posTrip + 1, Length( Namae ) );
        NameWithTrip := Copy( Namae, 1, posTrip - 1 ) + '</b> ��' +
                    get_2ch_trip( PChar( tripOrigin ) ) + '<b>';
    end;
    if Mail = '' then begin
        Result := Result + '<dt>' + No + ' �F <font color="forestgreen"><b>' + NameWithTrip
                 + '</b></font> �F ' + DateTime+ '<br><dd>' + Body + '<br><br><br>' + #13#10
    end else begin
		Result := Result + '<dt>' + No + ' �F <a href="mailto:' + Mail + '"><b>' + NameWithTrip
                 + '</b></a> [' + Mail + ']�F ' + DateTime+ '<br><dd>' + Body + '<br><br><br>' + #13#10;
    end;
	Result := Result + '</body></html>';

end;
{
\brief  �\���͈͊O���X�ԍ����菈��
\param  item    �\���X���b�h
\param  index   ���X�ԍ�
\return ture:�\���͈͊O false:�\���͈͓�
}
function THTMLCreate.isOutsideRange( item: TThreadItem; index: Integer ): Boolean;
begin
    Result := False;
    // �\���͈͂�����
    case GikoSys.ResRange of
    Ord( grrKoko ):
        if item.Kokomade > (index + 1) then
            Result := True;
    Ord( grrNew ):
        if item.NewReceive > (index + 1) then
            Result := True;
    10..65535:
        if (GikoSys.Setting.HeadResCount) < (index + 1)  then begin
            if (item.Count - index) > GikoSys.ResRange then begin
                Result := True;
            end;
        end;
    end;
end;
constructor TBufferedWebBrowser.Create(Browser: TWebBrowser; BuffSize: Integer);
begin
	inherited Create;
	Self.Sorted := False;
	if (Browser = nil) then
		Raise  Exception.Create('Browser is NULL');
	FBrowser := Browser;

	// �o�b�t�@����s����
	if (BuffSize < 0) then begin
		FBuffSize := 100;
	end else begin
		FBuffSize := BuffSize;
	end;
	Self.Capacity := FBuffSize + 10;
end;
procedure TBufferedWebBrowser.Open;
begin
	FBrowserDoc := FBrowser.ControlInterface.Document;
	FBrowserDoc.open;
	FBrowserDoc.charset := 'Shift_JIS';
end;
procedure TBufferedWebBrowser.Close;
begin
	Self.Flush;
	try
		FBrowserDoc.Close;
	except
	end;
	FBrowser := nil;
end;
function TBufferedWebBrowser.Add(const S: string): Integer;
begin
	Result := inherited Add(TrimRight(s));
	if (Self.Count > FBuffSize) then begin
		FBrowserDoc.Write(Self.Text);
		Self.Clear;
	end;
end;
procedure TBufferedWebBrowser.Flush ;
begin
	if (Self.Count > 0) then begin
		FBrowserDoc.Write(Self.Text);
		Self.Clear;
	end;
end;
destructor TBufferedWebBrowser.Destory;
begin
	try
		if (FBrowserDoc <> 0) then begin
			FBrowserDoc.close;
			FBrowserDoc := 0;
		end;
	except
	end;
	inherited;
end;
//! �֘A�L�[���[�h�����N�o��
function THTMLCreate.getKeywordLink(item: TThreadItem): String;
const
    PARA_URL = 'http://p2.2ch.io/getf.cgi?';
begin
    Result := '';
    if (GikoSys.Setting.AddKeywordLink) and (item.ParentBoard.Is2ch) then begin
        Result := '<p><span id="keyword"><a href="' + PARA_URL
            + item.URL + '" target="_blank">�֘A�L�[���[�h</a></span></p>';
    end;
end;
initialization
	 HTMLCreater := THTMLCreate.Create;

finalization
	if HTMLCreater <> nil then begin
		FreeAndNil(HTMLCreater);
	end;

end.
