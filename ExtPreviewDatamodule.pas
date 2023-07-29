unit ExtPreviewDatamodule;

interface

uses
  SysUtils, Classes, bmRegExp, ExtCtrls, GikoSystem;

type
  TCommand = class(TObject)
  private
    FCommand: String;
    FConfirm: Boolean;
    FContinue: Boolean;
    FToURL: String;
  public
    constructor Create(const comm: String);
    property Command: String read FCommand;
    property Confirm: Boolean read FConfirm write FConfirm;
    property Continue: Boolean read FContinue write FContinue;
    property ToURL: String read FToURL write FToURL;
  end;

  TExtPreviewDM = class(TDataModule)
    ExecuteTimer: TTimer;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ExecuteTimerTimer(Sender: TObject);
  private
    { Private 宣言 }
	FAWKStr: TAWKStr;
    FRegs: TStringList;
    FExecCommand: TCommand;
    function ReadCommand(const Line: String): TCommand;
  public
    { Public 宣言 }
    function PreviewURL(const URL: String): Boolean;
  end;

var
  ExtPreviewDM: TExtPreviewDM;

implementation

uses
  IniFiles, GikoUtil, Windows;

constructor TCommand.Create(const comm: String);
begin
    FCommand := comm;
    FConfirm := False;
    FContinue := False;
    FToURL := '';
end;
{$R *.dfm}
{
\brief コンストラクタ
}
procedure TExtPreviewDM.DataModuleCreate(Sender: TObject);
var
    values: TStringList;
    i, pos: Integer;
begin
    FAWKStr := TAWKStr.Create(Self);
    FRegs := TStringList.Create;
    if (FileExists(GikoSys.GetExtpreviewFileName)) then begin
        values := TStringList.Create;
        try
            values.LoadFromFile(GikoSys.GetExtpreviewFileName);
            for i := 0 to values.Count - 1 do begin
                if ( AnsiPos('#',values[i]) = 1 ) then begin
                    // 先頭#で始まるはコメント行
                end else begin
                    pos := AnsiPos(#9,values[i]);
                    if (pos > 0) then begin
                        FRegs.AddObject(
                            Copy(values[i], 1, pos - 1),
                            ReadCommand(
                                Copy(values[i], pos + 1, Length(values[i])))
                                );
                    end;
                end;
            end;
        finally
            values.Free;
        end;
    end;
end;
{
\brief デストラクタ
}
procedure TExtPreviewDM.DataModuleDestroy(Sender: TObject);
begin
    FRegs.Clear;
    FRegs.Free;
    FAWKStr.Free;
end;
{
\brief コマンド行解釈
}
function TExtPreviewDM.ReadCommand(const Line: String): TCommand;
var
    pos: Integer;
    sub: String;
begin

    // FCommand , FConfirm , FContinue の順
    pos := AnsiPos(#9, Line);
    if (pos > 0) then begin
        Result := TCommand.Create( Copy(Line, 1, pos - 1) );
        sub := Copy(Line, pos + 1, Length(Line));
    end else begin
        Result := TCommand.Create( '' );
        sub := '';
    end;
    pos := AnsiPos(#9, sub);
    if (pos > 0) then begin
        if (AnsiLowerCase(Copy(sub, 1, pos - 1)) = 'true' ) then begin
            Result.Confirm := True;
        end;
        sub := Copy(Line, pos + 1, Length(Line));
    end;
    sub := Trim(sub);
    if (AnsiLowerCase(sub) = 'true' ) then begin
        Result.Continue := True;
    end;
end;
{
\brief 登録されたURLを処理するコマンドを返す
}
function TExtPreviewDM.PreviewURL(const URL: String): Boolean;
var
    i: Integer;
    RStart: Integer;
    RLength: Integer;
    EsqURL: String;
begin
    Result := False;
    ExecuteTimer.Interval := 0;
    ExecuteTimer.Enabled := False;
    FExecCommand := nil;
    if (Length(URL) > 0) and (FRegs.Count > 0) then begin
        EsqURL := FAWKStr.ProcessEscSeq(URL);
        for i := 0 to FRegs.Count - 1 do begin
            FAWKStr.RegExp := FRegs[i];
            if ( FAWKStr.Match(EsqURL, RStart, RLength ) <> 0 ) then begin
                FExecCommand := TCommand(FRegs.Objects[i]);
                FExecCommand.ToURL := Copy(EsqURL, RStart, RLength);
                ExecuteTimer.Interval := GikoSys.Setting.PreviewWait;
                ExecuteTimer.Enabled := True;
                Result := not FExecCommand.FContinue;
                break;
            end;
        end;
    end;
end;

procedure TExtPreviewDM.ExecuteTimerTimer(Sender: TObject);
var
    rc: Integer;
begin
    // タイマー停止
    ExecuteTimer.Interval := 0;
    ExecuteTimer.Enabled := False;

    if (FExecCommand <> nil) then begin
        rc := ID_YES;
        if (FExecCommand.Confirm) then begin
            // Msg
            rc := GikoUtil.MsgBox(0, FExecCommand.Command + 'に'#13#10 +
                FExecCommand.ToURL + ' を渡しますか？',
                '確認', MB_ICONQUESTION or MB_YESNO);
        end;

        if (rc = ID_YES) then begin
            // 特殊コマンド
            // nop 何もしない
            if (AnsiLowerCase(FExecCommand.Command) <> 'nop') then begin
                GikoSys.CreateProcess(
                    FExecCommand.Command, '"' + FExecCommand.ToURL + '"');
            end;
        end;
    end;
end;

end.
