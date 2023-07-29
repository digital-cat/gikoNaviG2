unit RoundName;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls,
	GikoSystem, GikoUtil;

type
	TRoundNameDialog = class(TForm)
		TitleLabel: TLabel;
		OkButton: TButton;
		CancelButton: TButton;
    RoundNameEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
	private
		{ Private êÈåæ }
		FCloseFlag: Boolean;
	public
		{ Public êÈåæ }
	end;

//var
//  RoundNameDialog: TRoundNameDialog;

implementation

{$R *.dfm}

procedure TRoundNameDialog.FormCreate(Sender: TObject);
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

	FCloseFlag := False;
end;

procedure TRoundNameDialog.OkButtonClick(Sender: TObject);
const
	s = 'èÑâÒñºÇéwíËÇµÇƒÇ≠ÇæÇ≥Ç¢';
begin
	if Trim(RoundNameEdit.Text) = '' then begin
		MsgBox(Handle, s, 'ÉGÉâÅ[', MB_OK or MB_ICONSTOP);
		RoundNameEdit.SetFocus;
		FCloseFlag := False;
		Exit;
	end;
	FCloseFlag := True;
end;

procedure TRoundNameDialog.CancelButtonClick(Sender: TObject);
begin
	FCloseFlag := True;
end;

procedure TRoundNameDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
	CanClose := FCloseFlag;
end;

end.
