unit NewFavoriteFolder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TNewFavoriteFolderDialog = class(TForm)
		Label1: TLabel;
		Label2: TLabel;
		FolderEdit: TEdit;
		OKButton: TButton;
		CancelButton: TButton;
		ErrLabel: TLabel;
		procedure FolderEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
	private
		{ Private 宣言 }
	public
		{ Public 宣言 }
	end;

var
	NewFavoriteFolderDialog: TNewFavoriteFolderDialog;

implementation

uses
	Favorite;

{$R *.dfm}

procedure TNewFavoriteFolderDialog.FolderEditChange(Sender: TObject);
begin
	OKButton.Enabled := Length(FolderEdit.Text) <> 0;
	if Trim(FolderEdit.Text) = Favorite.FAVORITE_LINK_NAME then begin
		ErrLabel.Caption := 'フォルダ名に「リンク」は使用出来ません';
		OKButton.Enabled := False;
	end else
		ErrLabel.Caption := '';
end;

procedure TNewFavoriteFolderDialog.FormCreate(Sender: TObject);
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

	ErrLabel.Caption := '';
end;

end.
