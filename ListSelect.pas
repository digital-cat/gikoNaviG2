unit ListSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
	TListSelectDialog = class(TForm)
		TitleLabel: TLabel;
    SelectComboBox: TComboBox;
		KubetsuCheckBox: TCheckBox;
		OkButton: TButton;
		CancelButton: TButton;
    procedure FormCreate(Sender: TObject);
	private
		{ Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  ListSelectDialog: TListSelectDialog;

implementation

{$R *.dfm}

procedure TListSelectDialog.FormCreate(Sender: TObject);
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

end.
