{
NO_ABON							あぼーん済みのレスも表示する(強調される)
SPAM_FILTER_ENABLED	スパムフィルタを機能させる
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
		FOption: Integer; // 0:透明 1:通常あぼーん
	public
		property Res 		: Integer read FRes			write FRes;
		property Option : Integer	read FOption	write FOption;
	end;

	TIndiviAbonList = class( TList )
	private
		FFilePath	: string;		//!< ファイルパス
		FLearned	: Integer;	//!< スパム学習済みレス No

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
	{ Private 宣言 }
	Froot : String;
	Flistpath : String;
	FNGwordpath : String;
	Ftokens : array of array of string;
	FAbonRes : TIndiviAbonList;
	FAbonString : String;
	FpAbons	: PChar;
	FpAbone : PChar;
	FDeleterlo : Boolean; //&rlo;を削るか //追加&lro;も削る
	FReplaceul :Boolean ; //<ul>タグを<br>タグに置換するか
	FReverse : Boolean ;  //NGワードでのあぼ～んの結果を反転させるか
	FAbonPopupRes : Boolean; //レスポップアップの時にあぼーんするか
	FNGwordFileIndex : Integer; //現在読み込んでるNGワードがlistの何行目か
	FNGwordname : String; //現在読み込んでるNGワードの表示名
	FIndividualFileName : String;	//個別あぼ～んのファイル名
	FReturnNGwordLineNum : Boolean;	//NGワードの行数を返す。
	FSetNGResAnchor : Boolean; //NGに該当したときに本文にそのレスへのレスアンカーをつけるかどうか
	FDeleteSyria: Boolean;	//シリア語ブラクラ対策（&#1792~&#1871）
	FIgnoreKana: Boolean;	//全角半角ひらがなカタカナの違いを無視するか
	procedure SetTokens(index: integer ; argline:String);
	function Getlistpath() : String;
	procedure Setlistpath(const Value : String);
	function LoadListFile(path :String;listStringList : TStringList) : Boolean;
	function ReadNGwordslist(line : Integer) : Boolean;
	function LoadFromSetResNumFile(SetResNumFile : String) : Boolean;
  public
	{ Public 宣言 }
	constructor Create; // コンストラクタ
	destructor Destroy; override; // デストラクタ
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
	function FindNGwords(const line : String; var NGwordsLineNum : Integer; var Invisible : Boolean; ThreadInfo: TAbonThread) : Boolean;//1ラインずつ用。
	//あぼ～ん処理(NGワードでのフィルタリング)
	procedure Execute(var ThreadStrings : TStringList; ThreadInfo: TAbonThread); overload;
	procedure Execute(var ResString : String; ResNumber : Integer; ThreadInfo: TAbonThread); overload;	//主にpluginからのDat To HTML 用

{$IFDEF SPAM_FILTER_ENABLED}
	//! スパムフィルタの学習
	procedure Learn( resList : TStringList );
{$ENDIF}
	//個別あぼ～んしょり
	procedure IndividualAbon(var ThreadStrings : TStringList; SetResNumFile : String); overload;
	procedure IndividualAbon(var ResString : String; SetResNumFile : String; ResNumber : Integer); overload;
	procedure AddIndividualAbon( ResNum : Integer ; option : Integer; SetResNumFile : String);
	function CheckIndividualAbonList(ResNum : Integer) : Boolean;
	procedure AddRangeAbon( ResFrom : Integer ; ResTo : Integer ; option : Integer; SetResNumFile : String);

	function EditNGwords(Owner: TForm): Boolean;  //NGword.txtを開く。
	function ShowAllTokens() : String;  //デバッグ用
	//--
	procedure GoHome();//Listの１行目を読む
	function GoForward() : Boolean; //Listの一つ次のNGワードファイルを読み込む
	function GoBack() : Boolean; //Listの一つ前のNGワードファイルを読み込む
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

		//空行削除
		for i := bufStringList.Count-1 downto 0 do begin
			if bufStringList.Strings[i] = '' then begin
				bufStringList.Delete(i);
			end;
		end;

		//代入
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
	// 初期化
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
//rootはExe\config\NGwordsフォルダ
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
//NGwordpathはNGword.txtのフルパス
procedure TAbon.SetNGwordpath(path :String);
begin
	FNGwordpath := Getfullpath(path);
	LoadFromNGwordFile(FNGwordpath);
end;
function TAbon.GetNGwordpath() : String;
begin
	Result :=  FNGwordpath;
end;
//フルパスでなければフルパスにして返す。
function TAbon.Getfullpath(argpath : String) : String;
begin
	if AnsiPos(':\',argpath) <> 2 then begin  //ドライブからのフルパスが無ければ
		if Getroot() = '' then begin
			Result := '';    //rootパスが設定されてないか空にする
		end else begin
			if (Froot[Length(Froot)] = '\') and (argpath[1] = '\') then begin  //先頭の\を削除
				Delete(argpath,1,1);
			end;
			Insert( Getroot(), argpath , 1);//rootパスを挿入
			Result := argpath;
		end;
	end else begin
		Result := argpath;
	end;

end;
//NGwordファイルの読み込み
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
//NGwordリスト読み込み
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
//NGwordpathが既に設定されているときのリロード用関数
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
//一行の中のトークンを切り分けてセット
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
          // 正規表現
          if (buftoken = DEF_REGEXP) then
              RegExp := 1
          // 正規表現
          else if (buftoken = DEF_REGEX2) then
              RegExp := 2
          // 板・スレ指定
          else if ((AnsiPos(DEF_THREAD, buftoken) = 1) or
                   (AnsiPos(DEF_BOARD,  buftoken) = 1)) and
                   (AnsiPos(DEF_END,    buftoken) > 1) then
              Target := buftoken
          // >> で始まるトークンはコメント扱いで無視する
          else if AnsiPos('>>', buftoken) <> 1 then
              bufstl.Append(buftoken);
				end else if ( bufstl.Count = 0 ) then begin
					bufstl.Append('');
				end;
				pos := AnsiPos(#9,argline);
			end;
			if Length(argline) > 0 then begin
        // >> で始まるトークンはコメント扱いで無視する
        if AnsiPos('>>', argline) <> 1 then
          bufstl.Append(argline);
			end;
      // 各種指定の順位：透明→板・スレ→正規表現
      if (RegExp > 0) then begin
        i := 0;   // 0:正規表現指定は先頭に置く
        if (bufstl.Count > 0) and (bufstl.Strings[0] = '') then
          i := 1; // 1:透明指定の後に正規表現指定を置く
        case RegExp of
          1: bufstl.Insert(i, DEF_REGEXP);
          2: bufstl.Insert(i, DEF_REGEX2);
        end;
      end;
      if (Target <> '') then begin
          if (bufstl.Count > 0) and (bufstl.Strings[0] = '') then
              bufstl.Insert(1, Target)    // 透明指定の後に板・スレ指定を置く
          else
              bufstl.Insert(0, Target);   // 板・スレ指定は先頭に置く
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
//Debug用ちゃんとNGワードを拾えているか
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
//NGワードが含まれていたらtrueを返し、そのNGワードの行数をNGwordsLineNumに入れて返す。
//もしも透明あぼ～んにするならInbisibleをtrueにして返す
function TAbon.FindNGwords(const line : String; var NGwordsLineNum : Integer; var Invisible : Boolean; ThreadInfo: TAbonThread) : Boolean; //1ラインずつ用。
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
		//全半角ひらカナ無視するか
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
              Inc(start);     // 対象の板・スレ
          end else if (Ftokens[lines][Chk] = DEF_REGEXP) then begin
              RegExp := 1; // 正規表現
              Inc(start);
          end else if (Ftokens[lines][Chk] = DEF_REGEX2) then begin
              RegExp := 2; // 正規表現2
              Inc(start);
          end else begin
              Break;
          end;
        end;
        if (CheckTarget = False) then begin     // 対象の板・スレではない
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
                  hit := False;   // マッチしない
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
            Break;      // 1つでもマッチしない場合はあぼーんしない
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
//末尾のブール値はtrueだと、NGワードを含むものだけを返す。
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
					ThreadStrings.Strings[i] := Format('&nbsp;<>&nbsp;<>&nbsp;<><B> %d 行目のNGワードが含まれています。</B><><>',[NGwordsLine]);
				end else begin
					ThreadStrings.Strings[i] := Format('&nbsp;<>&nbsp;<>&nbsp;<><B> %d 行目のNGワードが含まれています。</B>&gt;%d <><>',[NGwordsLine,(i+1)]);
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
				ResString := Format('&nbsp;<>&nbsp;<>&nbsp;<><B> %d 行目のNGワードが含まれています。</B><><>',[NGwordsLine]);
			end else begin
				ResString := Format('&nbsp;<>&nbsp;<>&nbsp;<><B> %d 行目のNGワードが含まれています。</B>&gt;%d <><>',[NGwordsLine,(ResNumber)]);
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
//現在セットされているNGword.txtを開く
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
//ポップアップ用判定関数
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
//複数のNGワードテキストを読み込む==============================================
//Listファイルを読み込む
function TAbon.LoadListFile(path :String; listStringList : TStringList) : Boolean;
begin
    try
        listStringList.LoadFromFile(path);
        Result := true;
    except
        listStringList.Append('一般=NGword.txt');
        listStringList.SaveToFile(path);
        Result := false;
    end;
end;
//Listの一つ次のNGワードファイルを読み込む
function TAbon.GoForward() : Boolean;
begin
    FNGwordFileIndex := FNGwordFileIndex + 1;
    Result := ReadNGwordslist(FNGwordFileIndex);
end;
//Listの一つ前のNGワードファイルを読み込む
function TAbon.GoBack() : Boolean;
begin
    FNGwordFileIndex := FNGwordFileIndex -1;
    Result := ReadNGwordslist(FNGwordFileIndex);
end;
//Listの１行目を読む
procedure TAbon.GoHome();
begin
    FNGwordFileIndex := 0;
    ReadNGwordslist(FNGwordFileIndex);
end;
//Listのline行目を読む
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
			// 初めての学習かつ個別あぼ～んありなので、旧verからの移行につき
			// 個別あぼ～んを使った学習
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
			// 旧verからの移行ではないのでレスを全て推論で学習
			// ※推論が間違っている場合はユーザがあぼ～んを修正する事で学習される
			for j := FAbonRes.FLearned to resList.Count - 1 do begin
				wordCount.Clear;
				spamminess := GikoSys.SpamParse( resList[ j ], wordCount );
				if spamminess >= SPAM_THRESHOLD then begin
					// スパム
					GikoSys.Bayesian.Learn( wordCount, True );
					indiviAbon := TIndiviAbon.Create;
					indiviAbon.Res := j + 1;
					indiviAbon.Option := 1;
					FAbonRes.Add( indiviAbon );
				end else begin
					// ハム
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

//複数のNGワードテキストを読み込む=====ここまで=================================
//個別あぼ～ん実行関数
procedure TAbon.IndividualAbon(var ThreadStrings : TStringList; SetResNumFile : String);
var
	i : Integer;
	f : Boolean;
begin
	f := LoadFromSetResNumFile( SetResNumFile );
	FAbonRes.FFilePath := SetResNumFile;	// Learn はで保存するので
{$IFDEF SPAM_FILTER_ENABLED}
	Learn( ThreadStrings );
{$ENDIF}

	if f then begin
		for i := 0 to FAbonRes.Count - 1 do begin
			if (FAbonRes[i].Res <= ThreadStrings.Count) and (FAbonRes[i].Res > 0) then begin
{$IFDEF NO_ABON}
				ThreadStrings.Strings[FAbonRes[i].Res-1] :=
					'<font color="red">あぼ～ん済み</font>' +
					ThreadStrings.Strings[FAbonRes[i].Res-1];
{$ELSE}
				if FAbonRes[i].option = 0 then begin
					ThreadStrings.Strings[FAbonRes[i].Res-1] := '';
				end else begin
					ThreadStrings.Strings[FAbonRes[i].Res-1] := 'あぼ～ん<>あぼ～ん<>あぼ～ん<>あぼ～ん<>';
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
                        ResString := 'あぼ～ん<>あぼ～ん<>あぼ～ん<>あぼ～ん<>';
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

//個別あぼ～んファイル読み込み関数
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
//個別あぼ～んファイルに追加
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
//範囲指定で個別あぼ～んファイルに追加
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
    count := IndividualFile.Count;  // 既存の行数
    abonType := IntToStr(option);

    for resNo := ResFrom to ResTo do begin
      resNoPfix := IntToStr(ResNo) + '-';
      hit := False;

      // 既存行のみ同じレス番号を探して上書き
      if count > 0 then begin
        for j := 0 to count - 1 do begin
          if AnsiPos(resNoPfix, IndividualFile[j]) = 1 then begin
            IndividualFile[j] := resNoPfix + abonType;
            hit := True;
            Break;
          end;
        end;
      end;
      // 既存でなければ追加
      if hit = False then
        IndividualFile.Add(resNoPfix + abonType);
		end;
		IndividualFile.SaveToFile(SetResNumFile);
	finally
		IndividualFile.Free;
	end;
end;

//ポップアップの判定用
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
//シリア語ブラクラ対策
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
		//&#の手前までコピーする
		Result := Result + Copy(AString, 1, p - PChar(AString));
		//&#の手前まで削除する
		Delete(AString, 1, p - PChar(AString));

		//AStringに3文字以上あれば次の3文字目をチェック
		if Length(AString) > 2 then begin
			ps := PChar(AString) + 2;
			if (ps^ = 'x') or (ps^ = 'X') then begin
				//16進表記
				Inc(ps);
				scode := '0x';
				while ((ps^ >= '0') and (ps^ <= '9')) or
					((ps^ >= 'a') and (ps^ <= 'f')) or
					((ps^ >= 'A') and (ps^ <= 'F')) do begin
					
					scode := scode + String(ps^);
					Inc(ps);
				end;
			end else begin
				//10進表記
				scode := '';
				while ((ps^ >= '0') and (ps^ <= '9')) do begin
					scode := scode + String(ps^);
					Inc(ps);
				end;
			end;
			icode := StrToIntDef(scode, 0);

			//最後が;で閉じていなければ、一文字前までにする
			if not (ps^ = ';') then
				Dec(ps);

			//シリア語ブラクラのでない
            if ( icode < 1758) or
                ((icode > 1871) and (icode < 1958)) or
                (icode > 1968) then begin
                Result := Result + Copy(AString, 1, ps - PChar(AString) + 1);
            end;

			Delete(AString, 1, ps - PChar(AString) + 1);
		end else begin
            //後ろに文字が無いので、そのままResultに突っ込む
			Result := Result + AString;
			AString := '';
		end;
		p := PChar(AString);
		pe := p + Length(AString);
		p := AnsiStrPosEx(p, pe, s, se);
	end;

    //残った文字列を足して結果にする
	Result := Result + AString;
end;

// NGワードファイルに追加 追加された場合、Trueがかえる
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

