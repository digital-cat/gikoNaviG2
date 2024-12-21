{
NO_ABON							���ځ[��ς݂̃��X���\������(���������)
SPAM_FILTER_ENABLED	�X�p���t�B���^���@�\������
}

unit AbonUnit;

interface
uses
    Windows,Messages, ShellAPI, SysUtils, Classes,StdCtrls,StrUtils,
    Forms, Controls, AbonInfo;

type
	TIndiviAbon = class( TObject )
	private
		FRes: Integer;
		FOption: Integer; // 0:���� 1:�ʏ킠�ځ[��
	public
		property Res 		: Integer read FRes			write FRes;
		property Option : Integer	read FOption	write FOption;
	end;

	TIndiviAbonList = class( TList )
	private
		FFilePath	: string;		//!< �t�@�C���p�X
		FLearned	: Integer;	//!< �X�p���w�K�ς݃��X No

		function GetItem( index : Integer ) : TIndiviAbon;
		procedure SetItem( index : Integer; value : TIndiviAbon );

	public
		destructor Destroy; override;

		property Items[ index : Integer ] : TIndiviAbon
			read GetItem write SetItem; default;
		procedure Sort; overload;
		procedure LoadFromFile( const filePath : string );
		procedure Save;
	end;

  TAbon = class(TObject)
  private
	{ Private �錾 }
	Froot : String;
	Flistpath : String;
	FNGwordpath : String;
	Ftokens : array of array of string;
	FAbonRes : TIndiviAbonList;
	FAbonString : String;
	FpAbons	: PChar;
	FpAbone : PChar;
	FDeleterlo : Boolean; //&rlo;����邩 //�ǉ�&lro;�����
	FReplaceul :Boolean ; //<ul>�^�O��<br>�^�O�ɒu�����邩
	FReverse : Boolean ;  //NG���[�h�ł̂��ځ`��̌��ʂ𔽓]�����邩
	FAbonPopupRes : Boolean; //���X�|�b�v�A�b�v�̎��ɂ��ځ[�񂷂邩
	FNGwordFileIndex : Integer; //���ݓǂݍ���ł�NG���[�h��list�̉��s�ڂ�
	FNGwordname : String; //���ݓǂݍ���ł�NG���[�h�̕\����
	FIndividualFileName : String;	//�ʂ��ځ`��̃t�@�C����
	FReturnNGwordLineNum : Boolean;	//NG���[�h�̍s����Ԃ��B
	FSetNGResAnchor : Boolean; //NG�ɊY�������Ƃ��ɖ{���ɂ��̃��X�ւ̃��X�A���J�[�����邩�ǂ���
	FDeleteSyria: Boolean;	//�V���A��u���N���΍�i&#1792~&#1871�j
	FIgnoreKana: Boolean;	//�S�p���p�Ђ炪�ȃJ�^�J�i�̈Ⴂ�𖳎����邩
	procedure SetTokens(index: integer ; argline:String);
	function Getlistpath() : String;
	procedure Setlistpath(const Value : String);
	function LoadListFile(path :String;listStringList : TStringList) : Boolean;
	function ReadNGwordslist(line : Integer) : Boolean;
	function LoadFromSetResNumFile(SetResNumFile : String) : Boolean;
  public
	{ Public �錾 }
	constructor Create; // �R���X�g���N�^
	destructor Destroy; override; // �f�X�g���N�^
	property Deleterlo: Boolean read FDeleterlo write FDeleterlo  default false;
	property Replaceul: Boolean read FReplaceul write FReplaceul  default false;
	property Reverse: Boolean read FReverse write FReverse  default false;
	property AbonString : String read FAbonString write FAbonString;
	property  AbonPopupRes : Boolean read FAbonPopupRes write FAbonPopupRes default false;
	property listpath : String read Getlistpath write Setlistpath;
	property NGwordFileIndex : Integer read FNGwordFileIndex write FNGwordFileIndex default 0;
	property NGwordname : String read FNGwordname write FNGwordname;
	property ReturnNGwordLineNum : Boolean read FReturnNGwordLineNum write FReturnNGwordLineNum default false;
	property SetNGResAnchor : Boolean read FSetNGResAnchor write FSetNGResAnchor default false;
	property DeleteSyria : Boolean read FDeleteSyria write FDeleteSyria default false;
	property IgnoreKana: Boolean read FIgnoreKana write FIgnoreKana default false;
	procedure Setroot(root :String);
	function Getroot() : String;

	function Getfullpath(argpath : String) : String;
	procedure SetNGwordpath(path :String);
	function GetNGwordpath() : String;
	function LoadFromNGwordFile(path :String) : Boolean;
	function ReLoadFromNGwordFile() : Boolean;
	procedure LoadFromStringList( bufstl : TStringList );
	function CheckAbonPopupRes(line : String; ThreadInfo: TAbonThread) :Boolean;
	function FindNGwords(const line : String; var NGwordsLineNum : Integer; var Invisible : Boolean; ThreadInfo: TAbonThread) : Boolean;//1���C�����p�B
	//���ځ`�񏈗�(NG���[�h�ł̃t�B���^�����O)
	procedure Execute(var ThreadStrings : TStringList; ThreadInfo: TAbonThread); overload;
	procedure Execute(var ResString : String; ResNumber : Integer; ThreadInfo: TAbonThread); overload;	//���plugin�����Dat To HTML �p

{$IFDEF SPAM_FILTER_ENABLED}
	//! �X�p���t�B���^�̊w�K
	procedure Learn( resList : TStringList );
{$ENDIF}
	//�ʂ��ځ`�񂵂��
	procedure IndividualAbon(var ThreadStrings : TStringList; SetResNumFile : String); overload;
	procedure IndividualAbon(var ResString : String; SetResNumFile : String; ResNumber : Integer); overload;
	procedure AddIndividualAbon( ResNum : Integer ; option : Integer; SetResNumFile : String);
	function CheckIndividualAbonList(ResNum : Integer) : Boolean;
	procedure AddRangeAbon( ResFrom : Integer ; ResTo : Integer ; option : Integer; SetResNumFile : String);

	function EditNGwords(Owner: TForm): Boolean;  //NGword.txt���J���B
	function ShowAllTokens() : String;  //�f�o�b�O�p
	//--
	procedure GoHome();//List�̂P�s�ڂ�ǂ�
	function GoForward() : Boolean; //List�̈����NG���[�h�t�@�C����ǂݍ���
	function GoBack() : Boolean; //List�̈�O��NG���[�h�t�@�C����ǂݍ���
	//--
	function TreatSyria(AString: string): string;
    //--
    function AddToken(AString: string; Invisible: Boolean): Boolean;
  end;
var
	Abon1 :TAbon;
const
	NGwordListFileName : String = 'NGwords.list';

implementation

uses MojuUtils, GikoSystem, GikoBayesian, Setting,
  NgEditor,
  bmRegExp, SkRegExpW;

function InvidiAbonListSort( item1, item2 : Pointer ) : Integer;
begin

	Result := TIndiviAbon( item1 ).Res - TIndiviAbon( item2 ).Res;

end;

destructor TIndiviAbonList.Destroy;
var
	i : Integer;
begin

	for i := 0 to Count - 1 do
		if inherited Items[ i ] <> nil then
			TObject( inherited Items[ i ] ).Free;

	inherited;

end;

function TIndiviAbonList.GetItem( index : Integer ) : TIndiviAbon;
begin

	Result := TIndiviAbon( inherited Items[ index ] );

end;

procedure TIndiviAbonList.SetItem( index : Integer; value : TIndiviAbon );
begin

	inherited Items[ index ] := Pointer( value );

end;

procedure TIndiviAbonList.Sort;
begin

	inherited Sort( InvidiAbonListSort );

end;

procedure TIndiviAbonList.LoadFromFile( const filePath : string );
var
	bufStringList	: TStringList;
	bufLine				: string;
	i							: Integer;
	item					: TIndiviAbon;
begin

	if not FileExists( filePath ) then begin
		FLearned := 0;
		Exit;
	end;

	FFilePath := filePath;
	bufStringList := TStringList.Create;
	try
		bufStringList.LoadFromFile( filePath );
		if bufStringList.Values[ 'Learned' ] <> '' then begin
			FLearned := StrToInt( bufStringList.Values[ 'Learned' ] );
			bufStringList.Delete( bufStringList.IndexOfName( 'Learned' ) );
		end else begin
			FLearned := 0;
		end;

		//��s�폜
		for i := bufStringList.Count-1 downto 0 do begin
			if bufStringList.Strings[i] = '' then begin
				bufStringList.Delete(i);
			end;
		end;

		//���
		for i := 0 to bufStringList.Count - 1 do begin
			bufLine			:= Trim(bufStringList.Strings[i]);
			item				:= TIndiviAbon.Create;
			item.Res		:= StrToInt(Copy(bufLine,1,AnsiPos('-',bufLine)-1));
			item.option	:= StrToInt(Copy(bufLine,AnsiPos('-',bufLine)+1,1));
			Add( item );
		end;
	finally
		bufStringList.Free;
	end;

end;

procedure TIndiviAbonList.Save;
var
	bufStringList	: TStringList;
	i							: Integer;
begin

	bufStringList := TStringList.Create;
	try
		bufStringList.Values[ 'Learned' ] := IntToStr( FLearned );

		for i := 0 to Count - 1 do begin
			bufStringList.Add(
				IntToStr( Items[ i ].Res ) + '-' + IntToStr( Items[ i ].Option ) );
		end;

		bufStringList.SaveToFile( FFilePath );
	finally
		bufStringList.Free;
	end;

end;

constructor TAbon.Create;
begin
	// ������
	FAbonString := '&nbsp;<>&nbsp;<>&nbsp;<>&nbsp;&nbsp;<><>';
	FAbonRes := TIndiviAbonList.Create;
	FpAbons := PChar(FAbonString);
	FpAbone := FpAbons + Length(FAbonString);

end;

destructor TAbon.Destroy;
begin
	FAbonRes.Free;
	inherited;
end;
//root��Exe\config\NGwords�t�H���_
procedure TAbon.Setroot(root :String);
var
	bufStringList : TStringList;
begin
	bufStringList := TStringList.Create;
	try
		if not DirectoryExists(root) then begin
			CreateDir(root);
		end;
		if root[Length(root)] <> '\' then begin
			root := root + '\';
		end;
		Flistpath := root + NGwordListFileName;
		LoadListFile(Flistpath, bufStringList);
	finally
		bufStringList.Free;
	end;
	Froot := root;
end;
function TAbon.Getroot() : String;
begin
	Result := Froot;
end;
//NGwordpath��NGword.txt�̃t���p�X
procedure TAbon.SetNGwordpath(path :String);
begin
	FNGwordpath := Getfullpath(path);
	LoadFromNGwordFile(FNGwordpath);
end;
function TAbon.GetNGwordpath() : String;
begin
	Result :=  FNGwordpath;
end;
//�t���p�X�łȂ���΃t���p�X�ɂ��ĕԂ��B
function TAbon.Getfullpath(argpath : String) : String;
begin
	if AnsiPos(':\',argpath) <> 2 then begin  //�h���C�u����̃t���p�X���������
		if Getroot() = '' then begin
			Result := '';    //root�p�X���ݒ肳��ĂȂ�����ɂ���
		end else begin
			if (Froot[Length(Froot)] = '\') and (argpath[1] = '\') then begin  //�擪��\���폜
				Delete(argpath,1,1);
			end;
			Insert( Getroot(), argpath , 1);//root�p�X��}��
			Result := argpath;
		end;
	end else begin
		Result := argpath;
	end;

end;
//NGword�t�@�C���̓ǂݍ���
function TAbon.LoadFromNGwordFile(path :String) : boolean;
var
	bufstl : TStringList;
begin
	path := Getfullpath(path);
	if path = '' then begin
		Result := false;
	end else begin

		bufstl := TStringList.Create;
		try
			if not FileExists(path) then begin
				Result := false;
				try
					bufstl.SaveToFile(path);
				except
				end;
			end else begin
				bufstl.LoadFromFile(path);
				LoadFromStringList( bufstl );
				Result := true;
			end;
		finally
			bufstl.Free;
		end;
	end;

end;
//NGword���X�g�ǂݍ���
procedure TAbon.LoadFromStringList( bufstl : TStringList );
var
	i : integer;
begin
	try
		for i := bufstl.Count -1  downto 0 do begin
			if bufstl.Strings[i] = '' then begin
				bufstl.Delete(i);
			end;
		end;
		SetLength(Ftokens,bufstl.Count);
		for i := 0  to bufstl.Count -1 do begin
			SetTokens(i , bufstl.Strings[i]);
		end;

	except
		Exit;
	end;
end;
//NGwordpath�����ɐݒ肳��Ă���Ƃ��̃����[�h�p�֐�
function TAbon.ReLoadFromNGwordFile() : boolean;
begin
	if GetNGwordpath() ='' then begin
		Result := false;
	end else begin
		Result := LoadFromNGwordFile( GetNGwordpath() );
	end;
end;
function TAbon.Getlistpath() : String;
begin
	Result := Flistpath;
end;
procedure TAbon.Setlistpath(const Value : String);
begin
	Flistpath := Getfullpath(Value);
end;
//��s�̒��̃g�[�N����؂蕪���ăZ�b�g
procedure TAbon.SetTokens(index: integer ; argline : String);
var
	ret : Integer;
	bufstl : TStringList;
	i : Integer;
	pos : Integer;
	buftoken : String;
  RegExp: Integer;
  Target: String;
begin
	bufstl := TStringList.Create;
  RegExp := 0;
	try
		if Length(argline) > 0 then begin
			pos := AnsiPos(#9,argline);
			while pos <> 0 DO begin
				buftoken := Copy(argline,1,pos-1);
				Delete(argline,1,pos);
				if Length(buftoken) > 0 then begin
          // ���K�\��
          if (buftoken = DEF_REGEXP) then
              RegExp := 1
          // ���K�\��
          else if (buftoken = DEF_REGEX2) then
              RegExp := 2
          // �E�X���w��
          else if ((AnsiPos(DEF_THREAD, buftoken) = 1) or
                   (AnsiPos(DEF_BOARD,  buftoken) = 1)) and
                   (AnsiPos(DEF_END,    buftoken) > 1) then
              Target := buftoken
          // >> �Ŏn�܂�g�[�N���̓R�����g�����Ŗ�������
          else if AnsiPos('>>', buftoken) <> 1 then
              bufstl.Append(buftoken);
				end else if ( bufstl.Count = 0 ) then begin
					bufstl.Append('');
				end;
				pos := AnsiPos(#9,argline);
			end;
			if Length(argline) > 0 then begin
        // >> �Ŏn�܂�g�[�N���̓R�����g�����Ŗ�������
        if AnsiPos('>>', argline) <> 1 then
          bufstl.Append(argline);
			end;
      // �e��w��̏��ʁF�������E�X�������K�\��
      if (RegExp > 0) then begin
        i := 0;   // 0:���K�\���w��͐擪�ɒu��
        if (bufstl.Count > 0) and (bufstl.Strings[0] = '') then
          i := 1; // 1:�����w��̌�ɐ��K�\���w���u��
        case RegExp of
          1: bufstl.Insert(i, DEF_REGEXP);
          2: bufstl.Insert(i, DEF_REGEX2);
        end;
      end;
      if (Target <> '') then begin
          if (bufstl.Count > 0) and (bufstl.Strings[0] = '') then
              bufstl.Insert(1, Target)    // �����w��̌�ɔE�X���w���u��
          else
              bufstl.Insert(0, Target);   // �E�X���w��͐擪�ɒu��
      end;
			ret := bufstl.Count;
			SetLength(Ftokens[index],ret);
			for i := 0 to ret - 1  do begin
        if IgnoreKana then
            Ftokens[index][i] := ZenToHan(bufstl.Strings[i])
        else
            Ftokens[index][i] := bufstl.Strings[i];
			end;
		end;
	finally
		bufstl.Free;
	end;

end;
//Debug�p������NG���[�h���E���Ă��邩
function TAbon.ShowAllTokens() : String;
var
	i : Integer;
	j : Integer;
	ret : String;
begin
	for i := 0 to High(Ftokens) do begin
		for j := 0 to High(Ftokens[i]) do begin
			ret := ret + Ftokens[i][j];
		end;
	end;
	Result := ret;



end;
//NG���[�h���܂܂�Ă�����true��Ԃ��A����NG���[�h�̍s����NGwordsLineNum�ɓ���ĕԂ��B
//�������������ځ`��ɂ���Ȃ�Inbisible��true�ɂ��ĕԂ�
function TAbon.FindNGwords(const line : String; var NGwordsLineNum : Integer; var Invisible : Boolean; ThreadInfo: TAbonThread) : Boolean; //1���C�����p�B
var
	lines : Integer;
	cells : Integer;
	hit : Boolean;
	bufline : String;
	start : Integer;
	target : String;
	pos : PChar;
	pts, pte : PChar;
	trgLen : Integer;
  RegExp: Integer;
  AWKStr: TAWKStr;
  SkRegExp: TSkRegExp;
	RStart: Integer;
	RLength: Integer;
  TokenCnt: Integer;
  Chk: Integer;
  CheckTarget: Boolean;
begin
	hit := false;
	if AnsiStrPosEx(PChar(line), PChar(line)+Length(line), FpAbons, FpAbone) = nil then begin
		//�S���p�Ђ�J�i�������邩
		if IgnoreKana then
			target := ZenToHan(line)
		else
			target := line;

		trgLen := Length(target);
    AWKStr := nil;
    SkRegExp := nil;

    try
      for lines := 0 to High(Ftokens) do begin
        if Length(Ftokens[lines]) = 0 then begin
          Continue;
        end;
        hit := False;
        bufline := target;
        pts := PChar(bufline);
        pte := pts + trgLen;
        RegExp := 0;
        Invisible := False;
        start := 0;
        CheckTarget := True;

        TokenCnt := Length(Ftokens[lines]);
        for Chk := 0 to 2 do begin
          if (Chk >= TokenCnt) then
            Break;
          if (Chk = 0) and (Ftokens[lines][0] = '') then begin
            Invisible := True;
            start := 1;
          end else if ((AnsiPos(DEF_THREAD, Ftokens[lines][Chk]) = 1) or
                       (AnsiPos(DEF_BOARD,  Ftokens[lines][Chk]) = 1))
                   and (AnsiPos(DEF_END,    Ftokens[lines][Chk]) > 1) then begin
              CheckTarget := ThreadInfo.IsTarget(Ftokens[lines][Chk]);
              if (CheckTarget = False) then
                  Break;
              Inc(start);     // �Ώۂ̔E�X��
          end else if (Ftokens[lines][Chk] = DEF_REGEXP) then begin
              RegExp := 1; // ���K�\��
              Inc(start);
          end else if (Ftokens[lines][Chk] = DEF_REGEX2) then begin
              RegExp := 2; // ���K�\��2
              Inc(start);
          end else begin
              Break;
          end;
        end;
        if (CheckTarget = False) then begin     // �Ώۂ̔E�X���ł͂Ȃ�
            Continue;
        end;

        hit := True;
        if (RegExp = 1) and (AWKStr = nil) then
          AWKStr := TAWKStr.Create(nil)
        else if (RegExp = 2) and (SkRegExp = nil) then
          SkRegExp := TSkRegExp.Create;

        for cells := start to High(Ftokens[lines]) do begin
          case RegExp of
            0: begin
              pos := AnsiStrPosEx(pts, pte,
                      PChar(Ftokens[lines][cells]), PChar(Ftokens[lines][cells]) + Length(Ftokens[lines][cells]));
              if pos = nil then begin
                  hit := false;
              end else begin
                  Delete(bufline, pos - pte + 1, Length(Ftokens[lines][cells]));
                  pts := PChar(bufline);
                  pte := pts + Length(bufline);
              end;
            end;
            1: begin
              try
                AWKStr.RegExp := Ftokens[lines][cells];
                if (AWKStr.Match(AWKStr.ProcessEscSeq(target), RStart, RLength) < 1) then
                  hit := False;   // �}�b�`���Ȃ�
              except
                hit := False;
              end;
            end;
            2: begin
              try
                SkRegExp.Expression := Ftokens[lines][cells];
                SkRegExp.NamedGroupOnly := True;
                hit := SkRegExp.Exec(target);
              except
                hit := False;
              end;
            end;
          end;
          if (hit = False) then
            Break;      // 1�ł��}�b�`���Ȃ��ꍇ�͂��ځ[�񂵂Ȃ�
        end;
        if hit = true then begin
          NGwordsLineNum := lines + 1;
          break;
        end;
      end;
    finally
      if (AWKStr <> nil) then
        FreeAndNil(AWKStr);
      if (SkRegExp <> nil) then
        FreeAndNil(SkRegExp);
    end;
	end;
	Result := hit;
end;
//�����̃u�[���l��true���ƁANG���[�h���܂ނ��̂�����Ԃ��B
procedure TAbon.Execute(var ThreadStrings : TStringList; ThreadInfo: TAbonThread);
var
	i : Integer;
	NGwordsLine : Integer;
	bufline : String;
	invisi : Boolean;
begin
	for i:=0 to ThreadStrings.Count - 1 do begin
		NGwordsLine := 0;
		if FindNGwords(ThreadStrings.Strings[i], NGwordsLine, invisi, ThreadInfo) <> Reverse  then begin
			if invisi = true then begin
				ThreadStrings.Strings[i] := '';
			end else begin
				if not ReturnNGwordLineNum and not SetNGResAnchor then begin
					ThreadStrings.Strings[i] := FAbonString;
				end else if not ReturnNGwordLineNum then begin
					ThreadStrings.Strings[i] := Format('&nbsp;<>&nbsp;<>&nbsp;<>&gt;%d<><>',[(i+1)]);
				end else if not SetNGResAnchor then begin
					ThreadStrings.Strings[i] := Format('&nbsp;<>&nbsp;<>&nbsp;<><B> %d �s�ڂ�NG���[�h���܂܂�Ă��܂��B</B><><>',[NGwordsLine]);
				end else begin
					ThreadStrings.Strings[i] := Format('&nbsp;<>&nbsp;<>&nbsp;<><B> %d �s�ڂ�NG���[�h���܂܂�Ă��܂��B</B>&gt;%d <><>',[NGwordsLine,(i+1)]);
				end;
			end;
		end else begin
			bufline := ThreadStrings.Strings[i];
			if Deleterlo = true then begin
				bufline := CustomStringReplace(bufline,'&rlo;','');
				bufline := CustomStringReplace(bufline,'&lro;','');
			end;
			if Replaceul = true then begin
				bufline := CustomStringReplace( bufline,'<ul>','<br>' );
				bufline := CustomStringReplace( bufline,'</ul>','<br>' );
			end;
			if DeleteSyria = true then
				bufline := TreatSyria(bufline);
			ThreadStrings.Strings[i] := bufline;
		end;
	end;
end;
procedure TAbon.Execute(var ResString : String; ResNumber : Integer; ThreadInfo: TAbonThread);
var
	NGwordsLine : Integer;
	bufline : String;
	invisi : Boolean;
begin
	NGwordsLine := 0;
	if FindNGwords(ResString, NGwordsLine, invisi, ThreadInfo) <> Reverse  then begin
		if invisi = true then begin
			ResString := '';
		end else begin
			if not ReturnNGwordLineNum and not SetNGResAnchor then begin
				ResString := FAbonString;
			end else if not ReturnNGwordLineNum then begin
				ResString := Format('&nbsp;<>&nbsp;<>&nbsp;<>&gt;%d<><>',[(ResNumber)]);
			end else if not SetNGResAnchor then begin
				ResString := Format('&nbsp;<>&nbsp;<>&nbsp;<><B> %d �s�ڂ�NG���[�h���܂܂�Ă��܂��B</B><><>',[NGwordsLine]);
			end else begin
				ResString := Format('&nbsp;<>&nbsp;<>&nbsp;<><B> %d �s�ڂ�NG���[�h���܂܂�Ă��܂��B</B>&gt;%d <><>',[NGwordsLine,(ResNumber)]);
			end;
		end;
	end else begin
		bufline := ResString;
		if Deleterlo = true then begin
			bufline := CustomStringReplace( bufline,'&rlo;','' );
			bufline := CustomStringReplace( bufline,'&lro;','' );
		end;
		if Replaceul = true then begin
			bufline := CustomStringReplace( bufline,'<ul>','<br>' );
			bufline := CustomStringReplace( bufline,'</ul>','<br>' );
		end;
		if DeleteSyria = true then
			bufline := TreatSyria(bufline);
		ResString := bufline;
	end;
end;



//****************************************************************************//
//���݃Z�b�g����Ă���NGword.txt���J��
function TAbon.EditNGwords(Owner: TForm): Boolean;
var
    Dlg: TNgEdit;
    ReLoad: Boolean;
begin
    ReLoad := False;

    if (GikoSys.Setting.NGTextEditor = False) then begin
        Dlg := TNgEdit.Create(Owner);

        Dlg.SetFilePath(FNGwordpath);
        if (Dlg.ShowModal = mrOk) then begin
            if (Dlg.GetReload = True) then
                ReLoad := True;
        end;

        Dlg.Free;
    end else begin
	    ShellExecute(0 ,nil,PChar(FNGwordpath),nil,nil,SW_SHOW);
    end;

    Result := ReLoad;
end;
//�|�b�v�A�b�v�p����֐�
function TAbon.CheckAbonPopupRes(line : String; ThreadInfo: TAbonThread) :Boolean;
var
	i: Integer;
	v: boolean;
begin
	if AbonPopupRes = true then begin
		Result := FindNGwords(line, i, v, ThreadInfo);
	end else begin
		Result := false;
	end;
end;
//������NG���[�h�e�L�X�g��ǂݍ���==============================================
//List�t�@�C����ǂݍ���
function TAbon.LoadListFile(path :String; listStringList : TStringList) : Boolean;
begin
    try
        listStringList.LoadFromFile(path);
        Result := true;
    except
        listStringList.Append('���=NGword.txt');
        listStringList.SaveToFile(path);
        Result := false;
    end;
end;
//List�̈����NG���[�h�t�@�C����ǂݍ���
function TAbon.GoForward() : Boolean;
begin
    FNGwordFileIndex := FNGwordFileIndex + 1;
    Result := ReadNGwordslist(FNGwordFileIndex);
end;
//List�̈�O��NG���[�h�t�@�C����ǂݍ���
function TAbon.GoBack() : Boolean;
begin
    FNGwordFileIndex := FNGwordFileIndex -1;
    Result := ReadNGwordslist(FNGwordFileIndex);
end;
//List�̂P�s�ڂ�ǂ�
procedure TAbon.GoHome();
begin
    FNGwordFileIndex := 0;
    ReadNGwordslist(FNGwordFileIndex);
end;
//List��line�s�ڂ�ǂ�
function TAbon.ReadNGwordslist(line : Integer) : Boolean;
var
    liststl : TStringList;
    linebuf : String;
begin
    liststl := TStringList.Create;
    try
        if LoadListFile(Flistpath,liststl) = true then begin
            if line < 0 then begin
                line := liststl.Count - 1;
                FNGwordFileIndex := liststl.Count - 1;
            end else if line > liststl.Count - 1 then begin
                line := 0;
                FNGwordFileIndex := 0;
            end;
            linebuf := liststl.Strings[line];
            FNGwordname := Copy(linebuf,1,AnsiPos('=',linebuf)-1);
            Delete(linebuf,1,AnsiPos('=',linebuf));
            SetNGwordpath(linebuf);
            Result := true;
        end else begin
            Result := false;
        end
    finally
        liststl.Free;
    end;

end;

{$IFDEF SPAM_FILTER_ENABLED}
procedure TAbon.Learn( resList : TStringList );
var
	i, j 				: Integer;
	wordCount 	: TWordCount;
	spamminess	: Extended;
	indiviAbon	: TIndiviAbon;
const
	SPAM_THRESHOLD = 0.9;
begin

	if GikoSys.Setting.SpamFilterAlgorithm = gsfaNone then Exit;
	j := 0;
	wordCount := TWordCount.Create;
	try
		if (FAbonRes.FLearned = 0) and (FAbonRes.Count = 0) then begin
			// ���߂Ă̊w�K���ʂ��ځ`�񂠂�Ȃ̂ŁA��ver����̈ڍs�ɂ�
			// �ʂ��ځ`����g�����w�K
			FAbonRes.Sort;
			for i := 0 to FAbonRes.Count - 1 do begin
				while (j < resList.Count) and (j + 1 < FAbonRes[ j ].Res) do begin
					wordCount.Clear;
					GikoSys.Bayesian.CountWord( resList[ j ], wordCount );
					GikoSys.Bayesian.Learn( wordCount, False );
					Inc( j );
				end;
				if j < resList.Count then begin
					wordCount.Clear;
					GikoSys.Bayesian.CountWord( resList[ j ], wordCount );
					GikoSys.Bayesian.Learn( wordCount, True );
					Inc( j );
				end;
			end;

			while j < resList.Count do begin
				wordCount.Clear;
				GikoSys.Bayesian.CountWord( resList[ j ], wordCount );
				GikoSys.Bayesian.Learn( wordCount, False );
				Inc( j );
			end;
		end else begin
			// ��ver����̈ڍs�ł͂Ȃ��̂Ń��X��S�Đ��_�Ŋw�K
			// �����_���Ԉ���Ă���ꍇ�̓��[�U�����ځ`����C�����鎖�Ŋw�K�����
			for j := FAbonRes.FLearned to resList.Count - 1 do begin
				wordCount.Clear;
				spamminess := GikoSys.SpamParse( resList[ j ], wordCount );
				if spamminess >= SPAM_THRESHOLD then begin
					// �X�p��
					GikoSys.Bayesian.Learn( wordCount, True );
					indiviAbon := TIndiviAbon.Create;
					indiviAbon.Res := j + 1;
					indiviAbon.Option := 1;
					FAbonRes.Add( indiviAbon );
				end else begin
					// �n��
					GikoSys.Bayesian.Learn( wordCount, False );
				end;
			end;
		end;

		FAbonRes.FLearned := resList.Count;
		FAbonRes.Save;
	finally
		wordCount.Free;
	end;

	FAbonRes.Save;
	GikoSys.Bayesian.Save;

end;
{$ENDIF}

//������NG���[�h�e�L�X�g��ǂݍ���=====�����܂�=================================
//�ʂ��ځ`����s�֐�
procedure TAbon.IndividualAbon(var ThreadStrings : TStringList; SetResNumFile : String);
var
	i : Integer;
	f : Boolean;
begin
	f := LoadFromSetResNumFile( SetResNumFile );
	FAbonRes.FFilePath := SetResNumFile;	// Learn �͂ŕۑ�����̂�
{$IFDEF SPAM_FILTER_ENABLED}
	Learn( ThreadStrings );
{$ENDIF}

	if f then begin
		for i := 0 to FAbonRes.Count - 1 do begin
			if (FAbonRes[i].Res <= ThreadStrings.Count) and (FAbonRes[i].Res > 0) then begin
{$IFDEF NO_ABON}
				ThreadStrings.Strings[FAbonRes[i].Res-1] :=
					'<font color="red">���ځ`��ς�</font>' +
					ThreadStrings.Strings[FAbonRes[i].Res-1];
{$ELSE}
				if FAbonRes[i].option = 0 then begin
					ThreadStrings.Strings[FAbonRes[i].Res-1] := '';
				end else begin
					ThreadStrings.Strings[FAbonRes[i].Res-1] := '���ځ`��<>���ځ`��<>���ځ`��<>���ځ`��<>';
				end;
{$ENDIF}
			end;
		end;
	end;
end;
procedure TAbon.IndividualAbon(var ResString : String; SetResNumFile : String; ResNumber : Integer);
var
	i : Integer;
begin
	if FileExists(SetResNumFile) = true then begin
    	if LoadFromSetResNumFile(SetResNumFile) = true then begin
					for i := 0 to FAbonRes.Count - 1 do begin
                 if FAbonRes[i].Res = ResNumber then begin
                 	if FAbonRes[i].option = 0 then begin
                    	ResString := '';
                    end else begin
                        ResString := '���ځ`��<>���ځ`��<>���ځ`��<>���ځ`��<>';
                    end;
                    Exit;
                 end;
            end;
        end;
    end else begin
				FIndividualFileName := SetResNumFile;
				FAbonRes.Free;
				FAbonRes := TIndiviAbonList.Create;
		end;
end;

//�ʂ��ځ`��t�@�C���ǂݍ��݊֐�
function TAbon.LoadFromSetResNumFile(SetResNumFile : String) : Boolean;
begin

	FIndividualFileName := SetResNumFile;
	FAbonRes.Free;
	FAbonRes := TIndiviAbonList.Create;
	if FileExists( SetResNumFile ) then begin
		FAbonRes.LoadFromFile( SetResNumFile );
		Result := true;
	end else begin
		Result := False;
	end;

end;
//�ʂ��ځ`��t�@�C���ɒǉ�
procedure TAbon.AddIndividualAbon( ResNum : Integer ; option : Integer; SetResNumFile : String);
var
	IndividualFile : TStringList;
	i, j : Integer;
begin
	IndividualFile := TStringList.Create;
	try
		if FileExists(SetResNumFile) then begin
			IndividualFile.LoadFromFile(SetResNumFile);
			i := -1;
			for j := 0 to IndividualFile.Count -1 do begin
				if AnsiPos(IntToStr(ResNum) + '-', IndividualFile[j]) = 1 then begin
					i := j;
					break;
				end;
			end;
			if i = -1 then
				IndividualFile.Add(IntToStr(ResNum) + '-' + IntToStr(option))
			else
				IndividualFile[j] := IntToStr(ResNum) + '-' + IntToStr(option);

		end else begin
			IndividualFile.Add(IntToStr(ResNum) + '-' + IntToStr(option));
		end;
		IndividualFile.SaveToFile(SetResNumFile);
	finally
		IndividualFile.Free;
	end;
end;
//�͈͎w��Ōʂ��ځ`��t�@�C���ɒǉ�
procedure TAbon.AddRangeAbon( ResFrom : Integer ; ResTo : Integer ; option : Integer; SetResNumFile : String);
var
	IndividualFile : TStringList;
	j : Integer;
  hit : Boolean;
  resNo : Integer;
  resNoPfix : String;
  abonType : String;
  count : Integer;
begin
	IndividualFile := TStringList.Create;
	try
		if FileExists(SetResNumFile) then
			IndividualFile.LoadFromFile(SetResNumFile);
    count := IndividualFile.Count;  // �����̍s��
    abonType := IntToStr(option);

    for resNo := ResFrom to ResTo do begin
      resNoPfix := IntToStr(ResNo) + '-';
      hit := False;

      // �����s�̂ݓ������X�ԍ���T���ď㏑��
      if count > 0 then begin
        for j := 0 to count - 1 do begin
          if AnsiPos(resNoPfix, IndividualFile[j]) = 1 then begin
            IndividualFile[j] := resNoPfix + abonType;
            hit := True;
            Break;
          end;
        end;
      end;
      // �����łȂ���Βǉ�
      if hit = False then
        IndividualFile.Add(resNoPfix + abonType);
		end;
		IndividualFile.SaveToFile(SetResNumFile);
	finally
		IndividualFile.Free;
	end;
end;

//�|�b�v�A�b�v�̔���p
function TAbon.CheckIndividualAbonList(ResNum : Integer) : Boolean;
var
	i : Integer;
begin
	if (FAbonRes.Count > 0) and (FAbonRes[0].Res <> 0) then begin
		for i := 0 to FAbonRes.Count - 1 do begin
			if FAbonRes[i].Res = ResNum then begin
				Result := true;
				Exit;
			end;
		end;
	end;
	Result := false;

end;
//�V���A��u���N���΍�
function TAbon.TreatSyria(AString: string): string;
const
	UNI_TAG = '&#';
var
	//count: Integer; //(&#1792~&#1871)
	ps : PChar;
	p, pe, s, se : PChar;
	scode: String;
	icode: Integer;
begin

	Result := '';

	p := PChar(AString);
	pe := p + Length(AString);
	s := PChar(UNI_TAG);
	se := s + Length(UNI_TAG);

	p := AnsiStrPosEx(p, pe, s, se);

	while p <> nil do begin
		//&#�̎�O�܂ŃR�s�[����
		Result := Result + Copy(AString, 1, p - PChar(AString));
		//&#�̎�O�܂ō폜����
		Delete(AString, 1, p - PChar(AString));

		//AString��3�����ȏ゠��Ύ���3�����ڂ��`�F�b�N
		if Length(AString) > 2 then begin
			ps := PChar(AString) + 2;
			if (ps^ = 'x') or (ps^ = 'X') then begin
				//16�i�\�L
				Inc(ps);
				scode := '0x';
				while ((ps^ >= '0') and (ps^ <= '9')) or
					((ps^ >= 'a') and (ps^ <= 'f')) or
					((ps^ >= 'A') and (ps^ <= 'F')) do begin
					
					scode := scode + String(ps^);
					Inc(ps);
				end;
			end else begin
				//10�i�\�L
				scode := '';
				while ((ps^ >= '0') and (ps^ <= '9')) do begin
					scode := scode + String(ps^);
					Inc(ps);
				end;
			end;
			icode := StrToIntDef(scode, 0);

			//�Ōオ;�ŕ��Ă��Ȃ���΁A�ꕶ���O�܂łɂ���
			if not (ps^ = ';') then
				Dec(ps);

			//�V���A��u���N���̂łȂ�
            if ( icode < 1758) or
                ((icode > 1871) and (icode < 1958)) or
                (icode > 1968) then begin
                Result := Result + Copy(AString, 1, ps - PChar(AString) + 1);
            end;

			Delete(AString, 1, ps - PChar(AString) + 1);
		end else begin
            //���ɕ����������̂ŁA���̂܂�Result�ɓ˂�����
			Result := Result + AString;
			AString := '';
		end;
		p := PChar(AString);
		pe := p + Length(AString);
		p := AnsiStrPosEx(p, pe, s, se);
	end;

    //�c����������𑫂��Č��ʂɂ���
	Result := Result + AString;
end;

// NG���[�h�t�@�C���ɒǉ� �ǉ����ꂽ�ꍇ�ATrue��������
function TAbon.AddToken(AString: string; Invisible: Boolean): Boolean;
var
	bufStringList : TStringList;
    ngword: String;
begin
    Result := False;
    if FileExists(GetNGwordpath) then begin
        bufStringList := TStringList.Create;
        try
            bufStringList.LoadFromFile(GetNGwordpath);
            if (Invisible) then begin
                ngword := #9 + AString;
            end else begin
                ngword := AString;
            end;
            if (bufStringList.IndexOf(ngword) = -1) then begin
                bufStringList.Add(ngword);
                bufStringList.SaveToFile(GetNGwordpath);
                Result := True;
            end;
        finally
            bufStringList.Free;
        end;
    end;
end;


end.

