unit GikoInputBoxForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TGikoInputBox = class(TForm)
    PromptLabel: TLabel;
    InputEdit: TEdit;
    OkButton: TButton;
    CancelButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    DlgCaption: String;
    Prompt: String;
    Value: String;
  end;

var
  GikoInputBox: TGikoInputBox;

implementation

{$R *.dfm}

procedure TGikoInputBox.FormShow(Sender: TObject);
begin
	Caption := DlgCaption;
	PromptLabel.Caption := Prompt;
	InputEdit.Text := Value;
end;

procedure TGikoInputBox.OkButtonClick(Sender: TObject);
begin
	Value := InputEdit.Text;
  ModalResult := mrOk;
end;

end.
