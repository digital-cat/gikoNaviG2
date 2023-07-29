unit ThreadNGEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TThreadNGEdit = class(TForm)
    Panel1: TPanel;
    LstNgWord: TListBox;
    Panel2: TPanel;
    EdtNgWord: TEdit;
    BtnAdd: TButton;
    BtnUpd: TButton;
    BtnDel: TButton;
    BtnOk: TButton;
    BtnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnUpdClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure LstNgWordClick(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  ThreadNGEdit: TThreadNGEdit;

implementation

uses BoardGroup;

{$R *.dfm}

procedure TThreadNGEdit.FormCreate(Sender: TObject);
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
end;

procedure TThreadNGEdit.FormShow(Sender: TObject);
begin
    LstNgWord.Items.Assign(ThreadNgList);
end;

procedure TThreadNGEdit.LstNgWordClick(Sender: TObject);
begin
    if (LstNgWord.ItemIndex >= 0) and (LstNgWord.ItemIndex < LstNgWord.Count) then
        EdtNgWord.Text := LstNgWord.Items.Strings[LstNgWord.ItemIndex];
end;

procedure TThreadNGEdit.BtnAddClick(Sender: TObject);
begin
    if (EdtNgWord.Text = '') then
        Application.MessageBox('追加する単語を入力してください。', PChar(Caption), MB_OK or MB_ICONERROR)
    else
        LstNgWord.Items.Add(EdtNgWord.Text);
end;

procedure TThreadNGEdit.BtnUpdClick(Sender: TObject);
begin
    if (EdtNgWord.Text = '') then begin
        Application.MessageBox('更新する単語を入力してください。', PChar(Caption), MB_OK or MB_ICONERROR);
        Exit;
    end;
    if (LstNgWord.ItemIndex < 0) or (LstNgWord.ItemIndex >= LstNgWord.Count) then
        Application.MessageBox('更新する単語を選択してください。', PChar(Caption), MB_OK or MB_ICONERROR)
    else
        LstNgWord.Items.Strings[LstNgWord.ItemIndex] := EdtNgWord.Text;
end;

procedure TThreadNGEdit.BtnDelClick(Sender: TObject);
begin
    if (LstNgWord.ItemIndex < 0) or (LstNgWord.ItemIndex >= LstNgWord.Count) then
        Application.MessageBox('削除する単語を選択してください。', PChar(Caption), MB_OK or MB_ICONERROR)
    else
        LstNgWord.Items.Delete(LstNgWord.ItemIndex);
end;

procedure TThreadNGEdit.BtnOkClick(Sender: TObject);
begin
    ThreadNgList.Assign(LstNgWord.Items);
    ThreadNgList.Save;

    ModalResult := mrOk;
end;

end.
