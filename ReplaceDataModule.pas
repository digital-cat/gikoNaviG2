unit ReplaceDataModule;

interface

uses
  SysUtils, Classes;

type
  TReplaceDM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private 宣言 }
    //! 置換リスト
    FReplaceList: TList;
  public
    { Public 宣言 }
    procedure LoadFromFile(const filePath: String);
    function Replace(const source: String): String;
  end;
  TReplace = class(TObject)
  private
    FTarget: String;
    FReplace: String;
  public
    constructor Create(const line: String);
    property Target: String read FTarget write FTarget;
    property Replace: String read FReplace write FReplace;
  end;

var
  ReplaceDM: TReplaceDM;

implementation

uses
    MojuUtils, Dialogs, StrUtils;


{$R *.dfm}

//! エスケープ文字復元処理
function UnEscape(const source: String): String;
begin
    // 設定ファイルにそのまま書くと設定ファイル自体が削除されるのを
    // 防ぐために下記の文字をエスケープできるようにする
    // \. \( \) \{ \} \/ \" \\
    Result := MojuUtils.CustomStringReplace(source, '\.', '.');
    Result := MojuUtils.CustomStringReplace(Result, '\(', '(');
    Result := MojuUtils.CustomStringReplace(Result, '\)', ')');
    Result := MojuUtils.CustomStringReplace(Result, '\{', '{');
    Result := MojuUtils.CustomStringReplace(Result, '\}', '}');
    Result := MojuUtils.CustomStringReplace(Result, '\"', '"');
    Result := MojuUtils.CustomStringReplace(Result, '\/', '/');
    Result := MojuUtils.CustomStringReplace(Result, '\\', '\');
end;

//! コンストラクタ
procedure TReplaceDM.DataModuleCreate(Sender: TObject);
begin
    // 置換対象文字列保持リストの生成
    FReplaceList := TList.Create;
end;
//! デストラクタ
procedure TReplaceDM.DataModuleDestroy(Sender: TObject);
var
    i: Integer;
begin
    if (FReplaceList <> nil) then begin
        // リストの中身のfreeを呼び出す
        for i := FReplaceList.Count - 1 downto 0 do begin
            TObject(FReplaceList.Items[i]).Free;
        end;
        // リストを削除する
        FReplaceList.Clear;
        FReplaceList.Capacity := 0;
        FreeAndNil(FReplaceList);
    end;
end;
//! ファイル読み込み処理
procedure TReplaceDM.LoadFromFile(const filePath: String);
var
    fileStrings: TStringList;
    i: Integer;
    rep: TReplace;
    ignored: Boolean;
begin
    // ファイルの存在チェック
    if (FileExists(filePath)) then begin
        ignored := False;
        fileStrings := TStringList.Create;
        fileStrings.LoadFromFile(filePath);
        try
            // すべての行のまわす
            for i := 0 to fileStrings.Count - 1 do begin
                rep := TReplace.Create(fileStrings[i]);
                // <> が含まれているかチェック
                if (AnsiPos('<>', rep.Target) > 0) or
                    (AnsiPos('<>', rep.Replace) > 0) then begin
                    ignored := True;
                end else begin
                    FReplaceList.Add(rep);
                end;
            end;
        finally
            fileStrings.Free;
        end;
        if (ignored) then begin
            ShowMessage('<>を含む文字列を/に置換することはできません。'#13#10'設定ファイルを確認してください。');
        end;
    end;
end;

//! 置換処理
function TReplaceDM.Replace(const source: String): String;
var
    i: Integer;
    rep: TReplace;
begin
    Result := source;
    // nilであることは無いが念のため
    if (FReplaceList <> nil) then begin
        for i := FReplaceList.Count - 1 downto 0 do begin
            rep := TReplace(FReplaceList.Items[i]);
            Result := MojuUtils.CustomStringReplace(Result, rep.Target, rep.Replace);
        end;
    end;
end;
//! コンストラクタ
constructor TReplace.Create(const line: String);
begin
    Replace := '';
    // 1行をタブで区切る
    if (AnsiPos(#9, line) > 0) then begin
        Target  := Copy(line, 0, AnsiPos(#9, line) - 1);
        Replace := Copy(line, AnsiPos(#9, line) + 1, Length(line));
    end else begin
        Target := line;
    end;
    // Targetのエスケープを元の文字に戻す
    Target := UnEscape(Target);
    // replaceが''の時は、同じ文字数のスペースに設定
    if (Replace = '') then begin
        Replace := StrUtils.DupeString(' ', Length(Target));
    end;
end;

end.
