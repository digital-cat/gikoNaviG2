unit BbsThrSel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TBbsThreadSel = class(TForm)
    PanelLeft: TPanel;
    PanelCat: TPanel;
    PanelCatHead: TPanel;
    ListCat: TListBox;
    PanelBrd: TPanel;
    PanelBrdHead: TPanel;
    ListBrd: TListBox;
    PanelRight: TPanel;
    PanelThr: TPanel;
    EditFilter: TEdit;
    ButtonFilter: TButton;
    PanelThrHead: TPanel;
    ListThr: TListBox;
    procedure FormShow(Sender: TObject);
    procedure ListCatClick(Sender: TObject);
    procedure ListBrdClick(Sender: TObject);
    procedure ListThrClick(Sender: TObject);
    procedure ButtonFilterClick(Sender: TObject);
    procedure PanelThrResize(Sender: TObject);
    procedure EditFilterKeyPress(Sender: TObject; var Key: Char);
  private
    { Private 宣言 }
    FThreadMode: Boolean;   // True:スレ選択、False:板選択
    FBoardID: String;       // 板ID（例：software）
    FBoardTitle: String;    // 板タイトル（例：ソフトウェア）
    FThreadID: String;      // スレID（例：1410888356）
    FThreadTitle: String;   // スレタイトル（例：2ちゃんねる用ブラウザ「ギコナビ」 Part67）
    FInit: Boolean;
  public
    { Public 宣言 }
    property ThreadMode:  Boolean                  write FThreadMode default False;
    property BoardID:     String read FBoardID     write FBoardID;
    property BoardTitle:  String read FBoardTitle  write FBoardTitle;
    property ThreadID:    String read FThreadID    write FThreadID;
    property ThreadTitle: String read FThreadTitle write FThreadTitle;
  end;

var
  BbsThreadSel: TBbsThreadSel;

implementation

uses BoardGroup, GikoSystem, MojuUtils;

{$R *.dfm}

procedure TBbsThreadSel.FormShow(Sender: TObject);
var
    CenterForm: TCustomForm;
    i: Integer;
    j: Integer;
    Sel: Integer;
begin
    FInit := True;

    if (FThreadMode = False) then begin
        Caption := '板選択';
        Self.Constraints.MinWidth := 330;
        PanelRight.Visible := False;
        Width := 326;
        PanelLeft.Align := alClient;
    end else begin
        Caption := 'スレッド選択';
    end;

    CenterForm := TCustomForm(Owner);
    if Assigned(CenterForm) then begin
        Left := ((CenterForm.Width - Width) div 2) + CenterForm.Left;
        Top := ((CenterForm.Height - Height) div 2) + CenterForm.Top;
    end else begin
        Left := (Screen.Width - Width) div 2;
        Top := (Screen.Height - Height) div 2;
    end;

    Sel := -1;
    if (BBSs[0].IsBoardFileRead = False) then
        GikoSys.ReadBoardFile(BBSs[0]);
    for i := 0 to BBSs[0].Count - 1 do begin
        ListCat.Items.Add(BBSs[0].Items[i].Title);
        if (Sel = -1) and (FBoardID <> '') then begin
            for j := 0 to BBSs[0].Items[i].Count - 1 do begin
                if (FBoardID = BBSs[0].Items[i].Items[j].BBSID) then begin
                    Sel := i;
                    Break;
                end;
            end;
        end;
    end;

    if (Sel >= 0) then begin
        ListCat.ItemIndex := Sel;
        ListCatClick(ListCat);
    end;

    FInit := False;
end;

procedure TBbsThreadSel.ListCatClick(Sender: TObject);
var
    i: Integer;
    Idx: Integer;
    Sel: Integer;
    SelBrd: Boolean;
begin
    Idx := ListCat.ItemIndex;
    if (Idx >= 0) and (Idx < ListCat.Count) then begin
        if (FInit = True) and (FBoardID <> '') then
            SelBrd := True
        else
            SelBrd := False;
        Sel := -1;
        ListBrd.Clear;
        if (FThreadMode = True) then
            ListThr.Clear;
        for i := 0 to BBSs[0].Items[Idx].Count - 1 do begin
            ListBrd.Items.Add(BBSs[0].Items[Idx].Items[i].Title);
            if (SelBrd = True) and (Sel = -1) then begin
                if (FBoardID = BBSs[0].Items[Idx].Items[i].BBSID) then
                    Sel := i;
            end;
        end;
        if (Sel >= 0) then begin
            ListBrd.ItemIndex := Sel;
            ListBrdClick(ListBrd);
        end;
    end;
end;

procedure TBbsThreadSel.ListBrdClick(Sender: TObject);
var
    i: Integer;
    Idx1: Integer;
    Idx2: Integer;
    Brd: TBoard;
    IsFilt: Boolean;
    Filt: String;
    OldThr: TStringList;
begin
    Idx1 := ListCat.ItemIndex;
    Idx2 := ListBrd.ItemIndex;
    if (Idx1 >= 0) and (Idx1 < ListCat.Count) and
       (Idx2 >= 0) and (Idx2 < ListBrd.Count) then begin
        Brd := BBSs[0].Items[Idx1].Items[Idx2];

        if (FThreadMode = False) then begin
            if (FInit = False) then begin
                FBoardID    := Brd.BBSID;
                FBoardTitle := Brd.Title;
                ModalResult := mrOk;
            end;
        end else begin
            ListThr.Clear;
            OldThr := TStringList.Create;
            if (EditFilter.Text = '') then begin
                IsFilt := False;
            end else begin
                IsFilt := True;
                Filt := ZenToHan(EditFilter.Text);
            end;

            if (Brd.IsThreadDatRead = False) then
                GikoSys.ReadSubjectFile(Brd);
            for i := 0 to Brd.Count - 1 do begin
                if (IsFilt = False) or
                  ((IsFilt = True) and (AnsiPos(Filt, ZenToHan(Brd.Items[i].Title)) > 0)) then begin
                    if (Brd.Items[i].AgeSage = gasArch) then    // 過去ログ
                        OldThr.AddObject(Brd.Items[i].Title, TObject(i))
                    else
                        ListThr.Items.AddObject(Brd.Items[i].Title, TObject(i));
                end;
            end;
            for i := OldThr.Count - 1 downto 0 do begin
                ListThr.Items.AddObject(OldThr.Strings[i], OldThr.Objects[i]);
            end;
            OldThr.Free;
            if (FInit = True) and (FThreadMode = True) and (FThreadID <> '') then begin
                for i := 0 to ListThr.Count - 1 do begin
                    if (FThreadID = ChangeFileExt(Brd.Items[Integer(ListThr.Items.Objects[i])].FileName, '')) then begin
                        ListThr.ItemIndex := i;
                        Break;
                    end;
                end;
            end;
        end;
    end;
end;

procedure TBbsThreadSel.ListThrClick(Sender: TObject);
var
    Idx1: Integer;
    Idx2: Integer;
    Idx3: Integer;
    Idx4: Integer;
    Brd: TBoard;
begin
    if (FThreadMode = True) then begin
        Idx1 := ListCat.ItemIndex;
        Idx2 := ListBrd.ItemIndex;
        Idx3 := ListThr.ItemIndex;
        if (Idx1 >= 0) and (Idx1 < ListCat.Count) and
           (Idx2 >= 0) and (Idx2 < ListBrd.Count) and
           (Idx3 >= 0) and (Idx3 < ListThr.Count) then begin
            Brd := BBSs[0].Items[Idx1].Items[Idx2];
            Idx4 := Integer(ListThr.Items.Objects[Idx3]);
            if (Idx4 >= 0) and (Idx4 < Brd.Count) then begin
                FBoardID     := Brd.BBSID;
                FBoardTitle  := Brd.Title;
                FThreadID    := ChangeFileExt(Brd.Items[Idx4].FileName, '');
                FThreadTitle := Brd.Items[Idx4].Title;
                ModalResult := mrOk;
            end;
        end;
    end;
end;

procedure TBbsThreadSel.ButtonFilterClick(Sender: TObject);
begin
    ListBrdClick(ListBrd);
end;

procedure TBbsThreadSel.PanelThrResize(Sender: TObject);
begin
    ButtonFilter.Left := PanelThr.Width - ButtonFilter.Width - 2;
    EditFilter.Width := ButtonFilter.Left - 4;
end;

procedure TBbsThreadSel.EditFilterKeyPress(Sender: TObject; var Key: Char);
begin
    if (Integer(Key) = VK_RETURN) then begin
        Key := #0;
        ListBrdClick(ListBrd);
    end;
end;

end.
