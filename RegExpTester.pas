unit RegExpTester;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TRegExpTest = class(TForm)
    Label1: TLabel;
    TargetEdit: TEdit;
    Label2: TLabel;
    RegExpEdit: TEdit;
    TestButton: TButton;
    CloseButton: TButton;
    procedure TestButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private 宣言 }
    FRegExp: String;
  public
    { Public 宣言 }
    procedure SetRegExp(const src: String);
  end;

var
  RegExpTest: TRegExpTest;

implementation

uses bmRegExp;

{$R *.dfm}


procedure TRegExpTest.FormCreate(Sender: TObject);
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

procedure TRegExpTest.SetRegExp(const src: String);
begin
    FRegExp := src;
end;

procedure TRegExpTest.FormShow(Sender: TObject);
begin
    RegExpEdit.Text := FRegExp;
end;

procedure TRegExpTest.TestButtonClick(Sender: TObject);
var
    AWKStr: TAWKStr;
	RStart: Integer;
	RLength: Integer;
begin
    if (TargetEdit.Text = '') then begin
        Application.MessageBox('対象文字列を指定してください。', PChar(Caption), MB_OK or MB_ICONERROR);
        Exit;
    end;
    if (RegExpEdit.Text = '') then begin
        Application.MessageBox('正規表現を指定してください。', PChar(Caption), MB_OK or MB_ICONERROR);
        Exit;
    end;

	AWKStr := TAWKStr.Create(nil);
	try
        AWKStr.RegExp := RegExpEdit.Text;
        if (AWKStr.Match(AWKStr.ProcessEscSeq(TargetEdit.Text), RStart, RLength) > 0) then
            Application.MessageBox('マッチしました。', PChar(Caption), MB_OK or MB_ICONINFORMATION)
        else
            Application.MessageBox('マッチしませんでした。', PChar(Caption), MB_OK or MB_ICONWARNING);
	except
		on E: Exception do
            ShowMessage(E.Message);
    end;
	FreeAndNil(AWKStr);
end;

end.
