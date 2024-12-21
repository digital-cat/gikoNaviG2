unit NgEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Menus, ActnList, AbonInfo;

type
  TNgEdit = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    NgWordGrid: TStringGrid;
    ButtonOk: TButton;
    ButtonReload: TButton;
    ButtonCancel: TButton;
    GridMenu: TPopupMenu;
    MnStdAbn: TMenuItem;
    MnTrnAbn: TMenuItem;
    N1: TMenuItem;
    MnStdCmp: TMenuItem;
    MnRegexp: TMenuItem;
    N2: TMenuItem;
    MnAllThr: TMenuItem;
    MnSpcThr: TMenuItem;
    MnSpcBrd: TMenuItem;
    N3: TMenuItem;
    MnInsRow: TMenuItem;
    MnAddRow: TMenuItem;
    MnDelRow: TMenuItem;
    SetInfButton: TButton;
    InsRowButton: TButton;
    AddRowButton: TButton;
    DelRowButton: TButton;
    AddColButton: TButton;
    DelColButton: TButton;
    RegExpButton: TButton;
    ActionList: TActionList;
    AddRowAction: TAction;
    AddColAction: TAction;
    InsRowAction: TAction;
    DelColAction: TAction;
    DelRowAction: TAction;
    RegExpAction: TAction;
    SetInfAction: TAction;
    N4: TMenuItem;
    MnAddCol: TMenuItem;
    MnDelCol: TMenuItem;
    N5: TMenuItem;
    MnRegExpTest: TMenuItem;
    MnRegexp2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure NgWordGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonReloadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddRowActionExecute(Sender: TObject);
    procedure AddColActionExecute(Sender: TObject);
    procedure InsRowActionExecute(Sender: TObject);
    procedure DelColActionExecute(Sender: TObject);
    procedure DelRowActionExecute(Sender: TObject);
    procedure RegExpActionExecute(Sender: TObject);
    procedure SetInfActionExecute(Sender: TObject);
    procedure MnStdAbnClick(Sender: TObject);
    procedure MnTrnAbnClick(Sender: TObject);
    procedure MnStdCmpClick(Sender: TObject);
    procedure MnRegexpClick(Sender: TObject);
    procedure MnAllThrClick(Sender: TObject);
    procedure MnSpcThrClick(Sender: TObject);
    procedure MnSpcBrdClick(Sender: TObject);
    procedure MnRegexp2Click(Sender: TObject);
  private
    { Private 宣言 }
    FInfoList: TList;
    FFilePath: String;
    FReload: Boolean;

    procedure Load;
    procedure Save;
    procedure ClearInfo;
    procedure DeleteInfo(Index: Integer);
    function ParseLine(const Line: String; var NgList: TStringList): TLineInfo;
    procedure DspLineNo(Row: Integer);
  public
    { Public 宣言 }
    procedure SetFilePath(FilePath: String);
    function GetReload: Boolean;
  end;

var
  NgEdit: TNgEdit;

implementation

uses RegExpTester, AbonInfoSet, GikoSystem, MojuUtils, SkRegExpW;

{$R *.dfm}


procedure TNgEdit.FormCreate(Sender: TObject);
begin
    FInfoList := TList.Create;
    FReload := False;

    Left   := GikoSys.Setting.NGWindowLeft;
    Top    := GikoSys.Setting.NGWindowTop;
    Width  := GikoSys.Setting.NGWindowWidth;
    Height := GikoSys.Setting.NGWindowHeight;
    if (GikoSys.Setting.NGWindowMax = False) then
        WindowState := wsNormal
    else
        WindowState := wsMaximized;
end;

procedure TNgEdit.FormDestroy(Sender: TObject);
begin
    ClearInfo;
    FInfoList.Free;

    GikoSys.Setting.NGWindowLeft   := Left;
    GikoSys.Setting.NGWindowTop    := Top;
    GikoSys.Setting.NGWindowWidth  := Width;
    GikoSys.Setting.NGWindowHeight := Height;
    if (WindowState = wsMaximized) then
        GikoSys.Setting.NGWindowMax := True
    else
        GikoSys.Setting.NGWindowMax := False;
end;

procedure TNgEdit.SetFilePath(FilePath: String);
begin
    FFilePath := FilePath;
end;

procedure TNgEdit.FormShow(Sender: TObject);
var
    inf: TLineInfo;
    Col: Integer;
begin
    FReload := False;

    NgWordGrid.RowCount := 2;
    NgWordGrid.ColCount := 3;
    NgWordGrid.ColWidths[0] := 27;
    NgWordGrid.ColWidths[1] := 200;
    NgWordGrid.Cells[0, 0] := 'No.';
    NgWordGrid.Cells[1, 0] := '設定';
    NgWordGrid.Cells[0, 1] := '   1';
    NgWordGrid.Cells[1, 1] := '';
    NgWordGrid.Cells[2, 1] := '';

    Load;

    for Col := 2 to NgWordGrid.ColCount - 1 do
        NgWordGrid.Cells[Col, 0] := 'NGワード' + IntToStr(Col - 1);

    if (FInfoList.Count = 0) then begin
        inf := TLineInfo.Create;
        FInfoList.Add(inf);
        NgWordGrid.Cells[1, 1] := inf.ToString;
    end;
end;

function TNgEdit.GetReload: Boolean;
begin
    Result := FReload;
end;

procedure TNgEdit.Load;
var
    text: TStringList;
    line: TStringList;
    msg: String;
    idx: Integer;
    max_line: Integer;
    inf: TLineInfo;
    Row: Integer;
    Col: Integer;
    ColCnt: Integer;
begin
    if (FFilePath = '') or (FileExists(FFilePath) = False) then
        Exit;

    text := TStringList.Create;
    line := TStringList.Create;

    ClearInfo;

    try
        text.LoadFromFile(FFilePath);

        max_line := text.Count - 1;
        Row := 1;

        for idx := 0 to max_line do begin
            inf := ParseLine(text.Strings[idx], line);
            if (inf <> nil) then begin
                FInfoList.Add(inf);

                ColCnt := line.Count + 2;
                if (NgWordGrid.ColCount < ColCnt) then
                    NgWordGrid.ColCount := ColCnt;

                if (NgWordGrid.RowCount <= Row) then
                    NgWordGrid.RowCount := Row + 1;

                DspLineNo(Row);
                NgWordGrid.Cells[1, Row] := inf.ToString;
                for Col := 2 to (ColCnt - 1) do begin
                    NgWordGrid.Cells[Col, Row] := line.Strings[Col - 2];
                end;

                Row := Row + 1;
            end;
        end;

    except
        on e: Exception do begin
            msg := 'NGワードファイルの読み込みでエラーが発生しました。' + #10 + e.Message;
            Application.MessageBox(PChar(msg), 'NGワード編集', MB_OK or MB_ICONERROR);
        end;
    end;

    text.Free;
    line.Free;
end;

procedure TNgEdit.DspLineNo(Row: Integer);
var
    CellStr: String;
begin
    CellStr := '   ' + IntToStr(Row);
    NgWordGrid.Cells[0, Row] := Copy(CellStr, Length(CellStr) - 3, 4);
end;

procedure TNgEdit.Save;
var
    Row: Integer;
    Col: Integer;
    RowMax: Integer;
    ColMax: Integer;
    Line: String;
    text: TStringList;
    inf: TLineInfo;
    msg: String;
begin
    if (FFilePath = '') then
        Exit;

    text := TStringList.Create;
    RowMax := NgWordGrid.RowCount - 1;
    ColMax := NgWordGrid.ColCount - 1;

    for Row := 1 to RowMax do begin
        Line := '';
        for Col := 2 to ColMax do begin
            if (NgWordGrid.Cells[Col, Row] <> '') then begin
                if (Line <> '') then
                    Line := Line + #9;
                Line := Line + CustomStringReplace(NgWordGrid.Cells[Col, Row], #13#10, '');
            end;
        end;
        if (Line <> '') then begin
            if (FInfoList.Count >= Row) then begin
                inf := TLineInfo(FInfoList.Items[Row - 1]);

                case inf.CompType of
                  ctRegexp:  Line := DEF_REGEXP + #9 + Line;
                  ctRegexp2: Line := DEF_REGEX2 + #9 + Line;
                end;

                case inf.TargetType of
                    ttThread: Line := DEF_THREAD + inf.TargetThread + DEF_END + #9 + Line;
                    ttBoard:  Line := DEF_BOARD  + inf.TargetBoard  + DEF_END + #9 + Line;
                end;

                if (inf.AbonType = stTransparent) then
                    Line := #9 + Line;
            end;

            text.Add(Line);
        end;
    end;

    try
        text.SaveToFile(FFilePath);
    except
        on e: Exception do begin
            msg := 'NGワードファイルへの保存でエラーが発生しました。' + #10 + e.Message;
            Application.MessageBox(PChar(msg), 'NGワード編集', MB_OK or MB_ICONERROR);
        end;
    end;

    text.Free;
end;

function TNgEdit.ParseLine(const Line: String; var NgList: TStringList): TLineInfo;
var
    src: String;
    inf: TLineInfo;
    idx: Integer;
    len: Integer;
    NgWd: String;
begin
    NgList.Clear;

    src := Line;
    if (src = '') then begin
        Result := nil;
        Exit;
    end;

    inf := TLineInfo.Create;

    if (src[1] = #9) then begin
        inf.AbonType := stTransparent;
        Delete(src, 1, 1);
    end;

    while (src <> '') do begin
        idx := Pos(#9, src);
        if (idx > 0) then begin
            NgWd := Copy(src, 1, idx - 1);
            Delete(src, 1, idx);
        end else begin
            NgWd := src;
            src := '';
        end;

        if (NgWd = DEF_REGEXP) then
            inf.CompType := ctRegexp
        else if (NgWd = DEF_REGEX2) then
            inf.CompType := ctRegexp2
        else if (Pos(DEF_THREAD, NgWd) = 1) then begin
            idx := Pos(DEF_END, NgWd);
            if (idx > 1) then begin
                len := idx - Length(DEF_THREAD) - 1;
                inf.TargetThread := Copy(NgWd, Length(DEF_THREAD) + 1, len);
                inf.TargetType := ttThread;
            end else begin
                NgList.Add(NgWd);
            end;
        end else if (Pos(DEF_BOARD, NgWd) = 1) then begin
            idx := Pos(DEF_END, NgWd);
            if (idx > 1) then begin
                len := idx - Length(DEF_BOARD) - 1;
                inf.TargetBoard := Copy(NgWd, Length(DEF_BOARD) + 1, len);
                inf.TargetType := ttBoard;
            end else begin
                NgList.Add(NgWd);
            end;
        end else if (NgWd <> '') then begin
            NgList.Add(NgWd);
        end;
    end;

    Result := inf;
end;

procedure TNgEdit.ClearInfo;
begin
    while (FInfoList.Count > 0) do begin
        TLineInfo(FInfoList.Items[0]).Free;
        FInfoList.Delete(0);
    end;
end;

procedure TNgEdit.DeleteInfo(Index: Integer);
begin
    if (Index >= 0) and (Index < FInfoList.Count) then begin
        TLineInfo(FInfoList.Items[Index]).Free;
        FInfoList.Delete(Index);
    end;
end;

procedure TNgEdit.ButtonOkClick(Sender: TObject);
begin
    FReload := False;
    Save;
    ModalResult := mrOk;
end;

procedure TNgEdit.ButtonReloadClick(Sender: TObject);
begin
    FReload := True;
    Save;
    ModalResult := mrOk;
end;

procedure TNgEdit.AddRowActionExecute(Sender: TObject);
var
    Row: Integer;
    Col: Integer;
    inf: TLineInfo;
begin
    Row := NgWordGrid.RowCount;
    NgWordGrid.RowCount := NgWordGrid.RowCount + 1;

    DspLineNo(Row);

    inf := TLineInfo.Create;
    FInfoList.Add(inf);
    NgWordGrid.Cells[1, Row] := inf.ToString;

    for Col := 2 to NgWordGrid.ColCount - 1 do begin
        NgWordGrid.Cells[Col, Row] := '';
    end;

    NgWordGrid.Row := Row;
end;

procedure TNgEdit.AddColActionExecute(Sender: TObject);
var
    Row: Integer;
    Col: Integer;
begin
    Col := NgWordGrid.ColCount;
    NgWordGrid.ColCount := NgWordGrid.ColCount + 1;

    NgWordGrid.Cells[Col, 0] := 'NGワード' + IntToStr(Col - 1);
    for Row := 1 to NgWordGrid.RowCount - 1 do begin
        NgWordGrid.Cells[Col, Row] := '';
    end;

    NgWordGrid.Col := Col;
end;

procedure TNgEdit.InsRowActionExecute(Sender: TObject);
var
    RowMax: Integer;
    RowMin: Integer;
    RowIns: Integer;
    Row: Integer;
    Col: Integer;
    inf: TLineInfo;
begin
    if (NgWordGrid.Row <= 0) or (NgWordGrid.Row >= NgWordGrid.RowCount) then
        Exit;

    RowIns := NgWordGrid.Row;
    RowMin := NgWordGrid.Row + 1;
    RowMax := NgWordGrid.RowCount;
    NgWordGrid.RowCount := NgWordGrid.RowCount + 1;
    DspLineNo(NgWordGrid.RowCount - 1);

    for Row := RowMax downto RowMin do begin
        for Col := 1 to NgWordGrid.ColCount - 1 do begin
            NgWordGrid.Cells[Col, Row] := NgWordGrid.Cells[Col, (Row - 1)];
        end;
    end;

    inf := TLineInfo.Create;
    FInfoList.Insert(RowIns - 1, inf);
    NgWordGrid.Cells[1, RowIns] := inf.ToString;

    for Col := 2 to NgWordGrid.ColCount - 1 do begin
        NgWordGrid.Cells[Col, RowIns] := '';
    end;

end;

procedure TNgEdit.DelColActionExecute(Sender: TObject);
var
    ColDel: Integer;
    ColMax: Integer;
    ColMin: Integer;
    Row: Integer;
    Col: Integer;
begin
    if (NgWordGrid.ColCount <= 3) then
        Exit;
    if (NgWordGrid.Col <= 1) or (NgWordGrid.Col >= NgWordGrid.ColCount) then
        Exit;

    ColDel := NgWordGrid.Col;
    for Row := 1 to NgWordGrid.RowCount - 1 do begin
        if (NgWordGrid.Cells[ColDel, Row] <> '') then begin
            if (Application.MessageBox('選択された列にはNGワードが設定されていますが削除してもよろしいですか？',
                                        '選択列削除', MB_YESNO or MB_ICONQUESTION) = IDYES) then
                Break
            else
                Exit;
        end;
    end;

    ColMin := ColDel;
    ColMax := NgWordGrid.ColCount - 2;

    for Row := 1 to NgWordGrid.RowCount - 1 do begin
        for Col := ColMin to ColMax do begin
            NgWordGrid.Cells[Col, Row] := NgWordGrid.Cells[Col + 1, Row];
        end;
    end;

    NgWordGrid.ColCount := NgWordGrid.ColCount - 1;

end;

procedure TNgEdit.DelRowActionExecute(Sender: TObject);
var
    RowDel: Integer;
    RowMin: Integer;
    RowMax: Integer;
    Row: Integer;
    Col: Integer;
    inf: TLineInfo;
begin
    if (NgWordGrid.Row <= 0) or (NgWordGrid.Row >= NgWordGrid.RowCount) then
        Exit;

    RowDel := NgWordGrid.Row;

    for Col := 2 to NgWordGrid.ColCount - 1 do begin
        if (NgWordGrid.Cells[Col, RowDel] <> '') then begin
            if (Application.MessageBox('選択された行にはNGワードが設定されていますが削除してもよろしいですか？',
                                        '選択行削除', MB_YESNO or MB_ICONQUESTION) = IDYES) then
                Break
            else
                Exit;
        end;
    end;

    if (FInfoList.Count = 1) then begin
        for Col := 1 to NgWordGrid.ColCount - 1 do begin
            NgWordGrid.Cells[Col, 1] := '';
        end;
        DeleteInfo(RowDel - 1);
        inf := TLineInfo.Create;
        FInfoList.Add(inf);
        NgWordGrid.Cells[1, 1] := inf.ToString;
    end else begin
        RowMin := RowDel;
        RowMax := NgWordGrid.RowCount - 2;

        for Row := RowMin to RowMax do begin
            for Col := 1 to NgWordGrid.ColCount - 1 do begin
                NgWordGrid.Cells[Col, Row] := NgWordGrid.Cells[Col, Row + 1];
            end;
        end;

        NgWordGrid.RowCount := NgWordGrid.RowCount - 1;
        DeleteInfo(RowDel - 1);
    end;
end;

procedure TNgEdit.RegExpActionExecute(Sender: TObject);
var
    Dlg: TRegExpTest;
    inf: TLineInfo;
begin
    Dlg := TRegExpTest.Create(Self);

    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) and
       (NgWordGrid.Col > 1) and (NgWordGrid.Col < NgWordGrid.ColCount) then begin
        if (NgWordGrid.Cells[NgWordGrid.Col, NgWordGrid.Row] <> '') then begin
            inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
            if (inf.CompType = ctRegexp) or (inf.CompType = ctRegexp2) then
                Dlg.SetRegExp(NgWordGrid.Cells[NgWordGrid.Col, NgWordGrid.Row]);
        end;
    end;

    Dlg.ShowModal;

    Dlg.Free;
end;

procedure TNgEdit.SetInfActionExecute(Sender: TObject);
var
    inf: TLineInfo;
    Dlg: TAbonInfoEdit;
begin
    if (NgWordGrid.Row <= 0) or (NgWordGrid.Row >= NgWordGrid.RowCount) then
        Exit;

    inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);

    Dlg := TAbonInfoEdit.Create(Self);
    Dlg.SetInfo(inf);

    if (Dlg.ShowModal = mrOk) then begin
        Dlg.GetInfo(inf);
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
    end;

    Dlg.Free;
end;

procedure TNgEdit.NgWordGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    Col: Integer;
    Row: Integer;
    MousePos: TPoint;
    MenuPos: TPoint;
    inf: TLineInfo;
    regexp: Boolean;
begin
    if (Button = mbRight) then begin
        NgWordGrid.MouseToCell(X, Y, Col, Row);
        if (Col >= 0) and (Row > 0) then begin
            inf := TLineInfo(FInfoList.Items[Row - 1]);
            if (inf.AbonType = stTransparent) then begin
                MnStdAbn.Checked := False;
                MnTrnAbn.Checked := True;
            end else begin
                MnStdAbn.Checked := True;
                MnTrnAbn.Checked := False;
            end;
            case inf.TargetType of
                ttThread: begin
                    MnAllThr.Checked := False;
                    MnSpcThr.Checked := True;
                    MnSpcBrd.Checked := False;
                end;
                ttBoard: begin
                    MnAllThr.Checked := False;
                    MnSpcThr.Checked := False;
                    MnSpcBrd.Checked := True;
                end;
                else begin
                    MnAllThr.Checked := True;
                    MnSpcThr.Checked := False;
                    MnSpcBrd.Checked := False;
                end;
            end;
            regexp := True;
            case inf.CompType of
              ctRegexp: begin
                MnStdCmp.Checked := False;
                MnRegexp.Checked := True;
                MnRegexp2.Checked:= False;
              end;
              ctRegexp2: begin
                MnStdCmp.Checked := False;
                MnRegexp.Checked := False;
                MnRegexp2.Checked:= True;
              end;
              else begin
                MnStdCmp.Checked := True;
                MnRegexp.Checked := False;
                MnRegexp2.Checked:= False;
                regexp := False;
              end;
            end;
            if regexp and (Col > 1) then
                MnRegExpTest.Enabled := True
            else
                MnRegExpTest.Enabled := False;
            if (Col > 1) then
                MnDelCol.Enabled := True
            else
                MnDelCol.Enabled := False;

            NgWordGrid.Row := Row;
            if (Col > 1) then
                NgWordGrid.Col := Col;
            MousePos.X := X + NgWordGrid.Left;
            MousePos.Y := Y + NgWordGrid.Top;
            MenuPos := Self.ClientToScreen(MousePos);
            GridMenu.Popup(MenuPos.X, MenuPos.Y);
        end;
    end;
end;

procedure TNgEdit.MnStdAbnClick(Sender: TObject);
var
    inf: TLineInfo;
begin
    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) then begin
        inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
        inf.AbonType := atStandard;
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
    end;
end;

procedure TNgEdit.MnTrnAbnClick(Sender: TObject);
var
    inf: TLineInfo;
begin
    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) then begin
        inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
        inf.AbonType := stTransparent;
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
    end;
end;

procedure TNgEdit.MnStdCmpClick(Sender: TObject);
var
    inf: TLineInfo;
begin
    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) then begin
        inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
        inf.CompType := ctStandard;
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
    end;
end;

procedure TNgEdit.MnRegexpClick(Sender: TObject);
var
    inf: TLineInfo;
begin
    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) then begin
        inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
        inf.CompType := ctRegexp;
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
    end;
end;

procedure TNgEdit.MnRegexp2Click(Sender: TObject);
var
    inf: TLineInfo;
begin
    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) then begin
        inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
        inf.CompType := ctRegexp2;
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
    end;
end;

procedure TNgEdit.MnAllThrClick(Sender: TObject);
var
    inf: TLineInfo;
begin
    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) then begin
        inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
        inf.TargetType := ttAll;
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
    end;
end;

procedure TNgEdit.MnSpcThrClick(Sender: TObject);
var
    inf: TLineInfo;
begin
    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) then begin
        inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
        inf.TargetType := ttThread;
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
        SetInfActionExecute(nil);
    end;
end;

procedure TNgEdit.MnSpcBrdClick(Sender: TObject);
var
    inf: TLineInfo;
begin
    if (NgWordGrid.Row > 0) and (NgWordGrid.Row < NgWordGrid.RowCount) then begin
        inf := TLineInfo(FInfoList.Items[NgWordGrid.Row - 1]);
        inf.TargetType := ttBoard;
        NgWordGrid.Cells[1, NgWordGrid.Row] := inf.ToString;
        SetInfActionExecute(nil);
    end;
end;

end.
