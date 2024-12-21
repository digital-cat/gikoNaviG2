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
    Test2Button: TButton;
    procedure TestButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Test2ButtonClick(Sender: TObject);
  private
    { Private �錾 }
    FRegExp: String;

    function CheckInput(const title: String): Boolean;
    procedure ShowResult(res: Boolean; const title: String);
  public
    { Public �錾 }
    procedure SetRegExp(const src: String);
  end;

var
  RegExpTest: TRegExpTest;

implementation

uses bmRegExp, SkRegExpW;

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

{ ���̓`�F�b�N }
function TRegExpTest.CheckInput(const title: String): Boolean;
begin
  Result := False;
  if (TargetEdit.Text = '') then
    MessageBox(Handle, '�Ώە�������w�肵�Ă��������B', PChar(title), MB_OK or MB_ICONERROR)
  else if (RegExpEdit.Text = '') then
    MessageBox(Handle, '���K�\�����w�肵�Ă��������B', PChar(title), MB_OK or MB_ICONERROR)
  else
    Result := True;
end;

{ ���ʕ\�� }
procedure TRegExpTest.ShowResult(res: Boolean; const title: String);
begin
  if res then
    MessageBox(Handle, '�}�b�`���܂����B', PChar(title), MB_OK or MB_ICONINFORMATION)
  else
    MessageBox(Handle, '�}�b�`���܂���ł����B', PChar(title), MB_OK or MB_ICONWARNING);
end;

{ bmRegExp�e�X�g }
procedure TRegExpTest.TestButtonClick(Sender: TObject);
var
  AWKStr: TAWKStr;
	RStart: Integer;
	RLength: Integer;
begin
  if not CheckInput(TestButton.Caption) then
    Exit;

	AWKStr := TAWKStr.Create(nil);
	try
    AWKStr.RegExp := RegExpEdit.Text;
    ShowResult(AWKStr.Match(AWKStr.ProcessEscSeq(TargetEdit.Text), RStart, RLength) > 0, TestButton.Caption);
	except
		on E: Exception do
      MessageBox(Handle, PChar(E.Message), PChar(TestButton.Caption), MB_OK or MB_ICONERROR);
  end;
	FreeAndNil(AWKStr);
end;

{ SkRegExp�e�X�g }
procedure TRegExpTest.Test2ButtonClick(Sender: TObject);
var
  SkRegExp: TSkRegExp;
begin
  if not CheckInput(Test2Button.Caption) then
    Exit;

  SkRegExp := TSkRegExp.Create;
  try
//    SkRegExp.FOptions := [];
    SkRegExp.Expression := RegExpEdit.Text;
    SkRegExp.NamedGroupOnly := True;
    ShowResult(SkRegExp.Exec(TargetEdit.Text), Test2Button.Caption);
	except
		on E: Exception do
      MessageBox(Handle, PChar(E.Message), PChar(Test2Button.Caption), MB_OK or MB_ICONERROR);
  end;
  FreeAndNil(SkRegExp);
end;

end.
