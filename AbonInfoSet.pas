unit AbonInfoSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AbonInfo, StdCtrls, ExtCtrls;

type
  TAbonInfoEdit = class(TForm)
    AbonTypeRadio: TRadioGroup;
    CompTypeRadio: TRadioGroup;
    GroupBox1: TGroupBox;
    AllRadio: TRadioButton;
    ThreadRadio: TRadioButton;
    BoardRadio: TRadioButton;
    ThrNameEdit: TEdit;
    ThrIDEdit: TEdit;
    BrdNameEdit: TEdit;
    BrdIDEdit: TEdit;
    OkButton: TButton;
    CancelButton: TButton;
    ThrSelButton: TButton;
    BrdSelButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure TargetRadioClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ThrSelButtonClick(Sender: TObject);
    procedure BrdSelButtonClick(Sender: TObject);
  private
    { Private 宣言 }
    FInf: TLineInfo;
    function GetThreadTitle(SrcID: String): String;
    function GetBoardTitle(BrdID: String): String;
  public
    { Public 宣言 }

    procedure SetInfo(const src: TLineInfo);
    procedure GetInfo(var dst: TLineInfo);
  end;

var
  AbonInfoEdit: TAbonInfoEdit;

implementation

uses BoardGroup, BbsThrSel, GikoSystem;

{$R *.dfm}


procedure TAbonInfoEdit.FormCreate(Sender: TObject);
var
    CenterForm: TCustomForm;
begin
    CenterForm := TCustomForm(Owner);
    if Assigned(CenterForm) then begin
        Left := ((CenterForm.Width - Width) div 2) + CenterForm.Left;
        Top := ((CenterForm.Height - Height) div 2) + CenterForm.Top;
    end else begin
        Left := (Screen.Width - Width) div 2;
        Top := (Screen.Height - Height) div 2;
    end;

    FInf := TLineInfo.Create;
end;

procedure TAbonInfoEdit.FormDestroy(Sender: TObject);
begin
    FInf.Free;
end;

procedure TAbonInfoEdit.SetInfo(const src: TLineInfo);
begin
    FInf.Copy(src);
end;

procedure TAbonInfoEdit.GetInfo(var dst: TLineInfo);
begin
    dst.Copy(FInf);
end;

procedure TAbonInfoEdit.FormShow(Sender: TObject);
begin
    case FInf.AbonType of
        atStandard:    AbonTypeRadio.ItemIndex := 0;
        stTransparent: AbonTypeRadio.ItemIndex := 1;
    end;

    case FInf.CompType of
        ctStandard: CompTypeRadio.ItemIndex := 0;
        ctRegexp:   CompTypeRadio.ItemIndex := 1;
    end;

    case FInf.TargetType of
        ttAll:    begin
            AllRadio.Checked    := True;
        end;
        ttThread: begin
            ThreadRadio.Checked := True;
            ThrNameEdit.Text := GetThreadTitle(FInf.TargetThread);
            ThrIDEdit.Text := FInf.TargetThread;
        end;
        ttBoard:  begin
            BoardRadio.Checked  := True;
            BrdNameEdit.Text := GetBoardTitle(FInf.TargetBoard);
            BrdIDEdit.Text := FInf.TargetBoard;
        end;
    end;

    TargetRadioClick(AllRadio);
end;

function TAbonInfoEdit.GetThreadTitle(SrcID: String): String;
var
    ThrID: String;
    BrdID: String;
    Sep: Integer;
    i: Integer;
    j: Integer;
    Brd: TBoard;
begin
    Result := '';

    if (SrcID = '') then
        Exit;

    Sep := Pos('/', SrcID);
    if (Sep <= 0) then
        Exit;

    BrdID := Copy(SrcID, 1, Sep - 1);
    ThrID := Copy(SrcID, Sep + 1, Length(SrcID) - Sep);

    Brd := nil;
    if (BBSs[0].IsBoardFileRead = False) then
        GikoSys.ReadBoardFile(BBSs[0]);
    for i := 0 to BBSs[0].Count - 1 do begin
        for j := 0 to BBSs[0].Items[i].Count - 1 do begin
            if (BrdID = BBSs[0].Items[i].Items[j].BBSID) then begin
                Brd := BBSs[0].Items[i].Items[j];
                Result := Brd.Title + '／';
                Break;
            end;
        end;
    end;

    if (Brd <> nil) then begin
        if (Brd.IsThreadDatRead = False) then
            GikoSys.ReadSubjectFile(Brd);
        for i := 0 to Brd.Count - 1 do begin
            if (ThrID = ChangeFileExt(Brd.Items[i].FileName, '')) then begin
                Result := Result + Brd.Items[i].Title;
                Break;
            end;
        end;
    end;
end;


function TAbonInfoEdit.GetBoardTitle(BrdID: String): String;
var
    i: Integer;
    j: Integer;
begin
    Result := '';

    if (BrdID = '') then
        Exit;

    if (BBSs[0].IsBoardFileRead = False) then
        GikoSys.ReadBoardFile(BBSs[0]);
    for i := 0 to BBSs[0].Count - 1 do begin
        for j := 0 to BBSs[0].Items[i].Count - 1 do begin
            if (BrdID = BBSs[0].Items[i].Items[j].BBSID) then begin
                Result := BBSs[0].Items[i].Items[j].Title;
                Break;
            end;
        end;
    end;
end;

procedure TAbonInfoEdit.TargetRadioClick(Sender: TObject);
begin
    if (ThreadRadio.Checked = True) then begin
        ThrNameEdit.Enabled := True;
        ThrIDEdit.Enabled := True;
        ThrSelButton.Enabled := True;
        BrdNameEdit.Enabled := False;
        BrdIDEdit.Enabled := False;
        BrdSelButton.Enabled := False;
    end else if (BoardRadio.Checked = True) then begin
        ThrNameEdit.Enabled := False;
        ThrIDEdit.Enabled := False;
        ThrSelButton.Enabled := False;
        BrdNameEdit.Enabled := True;
        BrdIDEdit.Enabled := True;
        BrdSelButton.Enabled := True;
    end else begin
        ThrNameEdit.Enabled := False;
        ThrIDEdit.Enabled := False;
        ThrSelButton.Enabled := False;
        BrdNameEdit.Enabled := False;
        BrdIDEdit.Enabled := False;
        BrdSelButton.Enabled := False;
    end;
end;

procedure TAbonInfoEdit.OkButtonClick(Sender: TObject);
begin
    if (ThreadRadio.Checked = True) then begin
        if (ThrIDEdit.Text = '') then begin
            Application.MessageBox('対象のスレッドを指定したください。', PChar(Caption), MB_OK or MB_ICONERROR);
            Exit;
        end;
    end else if (BoardRadio.Checked = True) then begin
        if (BrdIDEdit.Text = '') then begin
            Application.MessageBox('対象の板を指定したください。', PChar(Caption), MB_OK or MB_ICONERROR);
            Exit;
        end;
    end;

    if (AbonTypeRadio.ItemIndex = 1) then
        FInf.AbonType := stTransparent
    else
        FInf.AbonType := atStandard;

    if (CompTypeRadio.ItemIndex = 1) then
        FInf.CompType := ctRegexp
    else
        FInf.CompType := ctStandard;

    if (ThreadRadio.Checked = True) then
        FInf.TargetType := ttThread
    else if (BoardRadio.Checked = True) then
        FInf.TargetType := ttBoard
    else
        FInf.TargetType := ttAll;

    FInf.TargetThread := ThrIDEdit.Text;
    FInf.TargetBoard  := BrdIDEdit.Text;

    ModalResult := mrOk;
end;

procedure TAbonInfoEdit.ThrSelButtonClick(Sender: TObject);
var
    Dlg: TBbsThreadSel;
    Sep: Integer;
begin
    Dlg := TBbsThreadSel.Create(Self);
    Dlg.ThreadMode := True;
    Sep := Pos('/', ThrIDEdit.Text);
    if (Sep > 0) then begin
        Dlg.BoardID  := Copy(ThrIDEdit.Text, 1, Sep - 1);
        Dlg.ThreadID := Copy(ThrIDEdit.Text, Sep + 1, Length(ThrIDEdit.Text) - Sep);
    end;
    if (Dlg.ShowModal = mrOk) then begin
        ThrNameEdit.Text := Dlg.BoardTitle + '／' + Dlg.ThreadTitle;
        ThrIDEdit.Text := Dlg.BoardID + '/' + Dlg.ThreadID;
    end;
    Dlg.Free;
end;

procedure TAbonInfoEdit.BrdSelButtonClick(Sender: TObject);
var
    Dlg: TBbsThreadSel;
begin
    Dlg := TBbsThreadSel.Create(Self);
    Dlg.ThreadMode := False;
    Dlg.BoardID := BrdIDEdit.Text;
    if (Dlg.ShowModal = mrOk) then begin
        BrdNameEdit.Text := Dlg.BoardTitle;
        BrdIDEdit.Text := Dlg.BoardID;
    end;
    Dlg.Free;
end;

end.
