unit ListSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WideCtrls;

type
	TListSelectDialog = class(TForm)
		TitleLabel: TLabel;
    SelectComboBox: TComboBox;
		KubetsuCheckBox: TCheckBox;
		OkButton: TButton;
		CancelButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
	private
		{ Private 宣言 }
  public
    { Public 宣言 }
    SelectComboBoxUC: TWideComboBox;
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

	// コンボボックスをUnicode対応版に差し替え
	SelectComboBoxUC := TWideComboBox.Create(Self);
	SelectComboBoxUC.Parent           := SelectComboBox.Parent;
	SelectComboBoxUC.Left             := SelectComboBox.Left;
	SelectComboBoxUC.Top              := SelectComboBox.Top;
	SelectComboBoxUC.Width            := SelectComboBox.Width;
	SelectComboBoxUC.Height           := SelectComboBox.Height;
	SelectComboBoxUC.Font             := SelectComboBox.Font;
	SelectComboBoxUC.Style            := SelectComboBox.Style;
	SelectComboBoxUC.DropDownCount    := SelectComboBox.DropDownCount;
	SelectComboBoxUC.ItemHeight       := SelectComboBox.ItemHeight;
	SelectComboBoxUC.TabOrder         := SelectComboBox.TabOrder;
	SelectComboBoxUC.Tag              := SelectComboBox.Tag;
	SelectComboBoxUC.OnChange         := SelectComboBox.OnChange;
	SelectComboBoxUC.OnEnter          := SelectComboBox.OnEnter;
	SelectComboBoxUC.OnExit           := SelectComboBox.OnExit;
	SelectComboBoxUC.OnKeyDown        := SelectComboBox.OnKeyDown;
  SelectComboBox.Visible := False;
	//-------------------

end;

procedure TListSelectDialog.FormDestroy(Sender: TObject);
begin
	try
		SelectComboBoxUC.Free;
  except
  end;
end;

end.
