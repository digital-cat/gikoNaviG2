unit Kotehan;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, ComCtrls, ExtCtrls,
	GikoSystem, BoardGroup;

type
	TGikoKotehanView = (gkvAll, gkvEntry, gkvBlank);

	TKotehanDialog = class(TForm)
		Panel1: TPanel;
		Panel2: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
		Panel3: TPanel;
		KotehanListView: TListView;
		Panel4: TPanel;
		ViewComboBox: TComboBox;
		Label1: TLabel;
		Label2: TLabel;
    HandleEdit: TEdit;
    HandleLabel: TLabel;
    MailLabel: TLabel;
    MailEdit: TEdit;
    ApplyButton: TButton;
    StatusBar1: TStatusBar;
		procedure FormCreate(Sender: TObject);
    procedure ViewComboBoxChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure KotehanListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
	private
		{ Private êÈåæ }
		FList: TList;
		procedure SetKotehanList(View: TGikoKotehanView);
	public
		{ Public êÈåæ }
	end;

	TKotehanData = class
	private
		FBoard: TBoard;
		FKotehanName: string;
		FKotehanMail: string;
	end;

var
	KotehanDialog: TKotehanDialog;

implementation

{$R *.dfm}

procedure TKotehanDialog.FormCreate(Sender: TObject);
var
	i, j, k: Integer;
	Category: TCategory;
	Board: TBoard;
	KoteData: TKotehanData;
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

	FList := TList.Create;

  for k := 0 to Length( BBSs ) - 1 do begin
    for i := 0 to BBSs[ k ].Count - 1 do begin
      Category := BBSs[ k ].Items[i];
      for j := 0 to Category.Count - 1 do begin
        Board := Category.Items[j];
        KoteData := TKotehanData.Create;
        KoteData.FBoard := Board;
        KoteData.FKotehanName := Board.KotehanName;
        KoteData.FKotehanMail := Board.KotehanMail;
        FList.Add(KoteData);
      end;
    end;
	end;
	ViewComboBox.Items.Add('Ç∑Ç◊Çƒï\é¶');
	ViewComboBox.Items.Add('ê›íËçœÇÃÇ›ï\é¶');
	ViewComboBox.Items.Add('ñ¢ê›íËÇÃÇ›ï\é¶');
	ViewComboBox.ItemIndex := 0;
	SetKotehanList(gkvAll);
end;

procedure TKotehanDialog.ViewComboBoxChange(Sender: TObject);
var
	View: TGikoKotehanView;
begin
	View := gkvAll;
	if ViewComboBox.ItemIndex = 1 then
		View := gkvEntry
	else if ViewComboBox.ItemIndex = 2 then
		View := gkvBlank;
	SetKotehanList(View);
end;

procedure TKotehanDialog.SetKotehanList(View: TGikoKotehanView);
var
	i: Integer;
	Item: TListItem;
	KoteData: TKotehanData;
begin
	KotehanListView.Items.BeginUpdate;
	try
		KotehanListView.Items.Clear;
		for i := 0 to FList.Count - 1 do begin
			if TObject(FList[i]) is TKotehanData then begin
				KoteData := TKotehanData(FList[i]);
				case View of
					gkvEntry:
						if (KoteData.FKotehanName = '') and (KoteData.FKotehanMail = '') then
							Continue;
					gkvBlank:
						if (KoteData.FKotehanName <> '') or (KoteData.FKotehanMail <> '') then
							Continue;
				end;
				Item := KotehanListView.Items.Add;
				Item.Caption := KoteData.FBoard.Title;
				Item.SubItems.Add(KoteData.FKotehanName);
				Item.SubItems.Add(KoteData.FKotehanMail);
				Item.Data := KoteData;
			end;
		end;
	finally
		KotehanListView.Items.EndUpdate;
	end;
end;

procedure TKotehanDialog.FormDestroy(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to FList.Count - 1 do
		TObject(FList[i]).Free;
	FList.Free;
end;

procedure TKotehanDialog.KotehanListViewChange(Sender: TObject;
	Item: TListItem; Change: TItemChange);
begin
	HandleLabel.Enabled := KotehanListView.SelCount <> 0;
	HandleEdit.Enabled := KotehanListView.SelCount <> 0;
	MailEdit.Enabled := KotehanListView.SelCount <> 0;
	MailLabel.Enabled := KotehanListView.SelCount <> 0;
	ApplyButton.Enabled := KotehanListView.SelCount <> 0;
	if KotehanListView.SelCount = 1 then begin
		HandleEdit.Text := Item.SubItems[0];
		MailEdit.Text := Item.SubItems[1];
	end else begin
		HandleEdit.Text := '';
		MailEdit.Text := '';
	end;
end;

procedure TKotehanDialog.ApplyButtonClick(Sender: TObject);
var
	Item: TListItem;
	KoteData: TKotehanData;
begin
	if KotehanListView.SelCount = 0 then
		Exit;

	Item := KotehanListView.Selected;
	while Item <> nil do begin
		if TObject(Item.Data) is TKotehanData then begin
			KoteData := TKotehanData(Item.Data);
			KoteData.FKotehanName := HandleEdit.Text;
			KoteData.FKotehanMail := MailEdit.Text;
			Item.SubItems[0] := HandleEdit.Text;
			Item.SubItems[1] := MailEdit.Text;
		end;
		Item := KotehanListView.GetNextItem(Item, sdAll, [isSelected]);
	end;

end;

procedure TKotehanDialog.OKButtonClick(Sender: TObject);
var
	i: Integer;
	KoteData: TKotehanData;
begin
	for i := 0 to FList.Count - 1 do begin
		if TObject(FList[i]) is TKotehanData then begin
			KoteData := TKotehanData(FList[i]);
			KoteData.FBoard.KotehanName := KoteData.FKotehanName;
			KoteData.FBoard.KotehanMail := KoteData.FKotehanMail;
		end;
	end;
end;

end.
