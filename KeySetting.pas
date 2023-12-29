unit KeySetting;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, StdCtrls, ExtCtrls, ActnList, Menus,
	Editor;

type
	TKeySettingItem = class(TObject)
	private
		FAction: TAction;
		FShortCut: TShortCut;
		FGesture	: string;
	public
		property Action: TAction read FAction write FAction;
		property ShortCut: TShortCut read FShortCut write FShortCut;
		property Gesture : string read FGesture write FGesture;
	end;

	TKeySettingForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    OkBotton: TButton;
    CancelBotton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    HotKey: THotKey;
    SetButton: TButton;
    StatusBar: TStatusBar;
    Panel4: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListView: TListView;
    ListView1: TListView;
    GestureLabel: TLabel;
    GestureEdit: TEdit;
    GestureSetButton: TButton;
    GestureCheckBox: TCheckBox;
		procedure FormCreate(Sender: TObject);
		procedure FormDestroy(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure HotKeyEnter(Sender: TObject);
    procedure HotKeyExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetButtonClick(Sender: TObject);
    procedure OkBottonClick(Sender: TObject);
    procedure ListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure GestureSetButtonClick(Sender: TObject);
		procedure OnGestureStart(Sender: TObject);
		procedure OnGestureMove(Sender: TObject);
		procedure OnGestureEnd(Sender: TObject);
    procedure GestureCheckBoxClick(Sender: TObject);
    procedure GestureEditChange(Sender: TObject);
    procedure GestureEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
	private
		{ Private 宣言 }
    function IsExtKey(ShortCut: TShortCut): Boolean;
	public
		{ Public 宣言 }
		EditorForm: TEditorForm;
	end;

//var
//	KeySettingForm: TKeySettingForm;

implementation

uses
	Giko, GikoUtil, Gesture, GikoDataModule, GikoSystem;

const
	GUESTURE_NOTHING	= 'なし';

{$R *.dfm}

procedure TKeySettingForm.FormCreate(Sender: TObject);
var
	i: Integer;
	ListItem: TListItem;
	KeyItem: TKeySettingItem;
	CenterForm: TCustomForm;

begin
	//for i := 0 to GikoForm.ActionList.ActionCount - 1 do begin
	for i := 0 to GikoDM.GikoFormActionList.ActionCount - 1 do begin
		//if GikoForm.ActionList.Actions[i] is TAction then begin
		if GikoDM.GikoFormActionList.Actions[i] is TAction then begin
			if GikoDM.GikoFormActionList.Actions[i].Tag <> 0 then
				Continue;
			ListItem := ListView.Items.Add;
			ListItem.Caption := TAction(GikoDM.GikoFormActionList.Actions[i]).Hint;
			ListItem.SubItems.Add(TAction(GikoDM.GikoFormActionList.Actions[i]).Category);
			ListItem.SubItems.Add(ShortCutToText(TAction(GikoDM.GikoFormActionList.Actions[i]).ShortCut));
			ListItem.SubItems.Add( GikoSys.Setting.Gestures.GetActionGesture(
				TAction( GikoDM.GikoFormActionList.Actions[i] ) ) );
			ListItem.ImageIndex := TAction(GikoDM.GikoFormActionList.Actions[i]).ImageIndex;
			KeyItem := TKeySettingItem.Create;
			KeyItem.Action := TAction(GikoDM.GikoFormActionList.Actions[i]);
			KeyItem.ShortCut := TAction(GikoDM.GikoFormActionList.Actions[i]).ShortCut;
			KeyItem.Gesture	:= GikoSys.Setting.Gestures.GetActionGesture(
				TAction( GikoDM.GikoFormActionList.Actions[i] ) );
			ListItem.Data := KeyItem;
		end;
	end;
	if ListView.Items.Count > 0 then
		ListView.Selected := ListView.Items[0];
	EditorForm := TEditorForm.Create(Self);
	try
		for i := 0 to EditorForm.ActionList.ActionCount - 1 do begin
			if EditorForm.ActionList.Actions[i] is TAction then begin
				if EditorForm.ActionList.Actions[i].Tag <> 0 then
					Continue;
				ListItem := ListView1.Items.Add;
				ListItem.Caption := TAction(EditorForm.ActionList.Actions[i]).Hint;
				ListItem.SubItems.Add(TAction(EditorForm.ActionList.Actions[i]).Category);
				ListItem.SubItems.Add(ShortCutToText(TAction(EditorForm.ActionList.Actions[i]).ShortCut));
				ListItem.ImageIndex := TAction(EditorForm.ActionList.Actions[i]).ImageIndex;
				ListItem.SubItems.Add( GikoSys.Setting.Gestures.GetActionGesture(
					TAction( EditorForm.ActionList.Actions[i] ) ) );
				KeyItem := TKeySettingItem.Create;
				KeyItem.Action := TAction(EditorForm.ActionList.Actions[i]);
				KeyItem.ShortCut := TAction(EditorForm.ActionList.Actions[i]).ShortCut;
				KeyItem.Gesture	:= GikoSys.Setting.Gestures.GetActionGesture(
					TAction( EditorForm.ActionList.Actions[i] ) );
				ListItem.Data := KeyItem;
			end;
		end;
		ListView1.SmallImages := EditorForm.HotToobarImageList;
	finally

	end;
//	ActionListView.SortType := stText;
	StatusBar.Height := 21;
	StatusBar.Width := 21;
	PageControl1.ActivePageIndex := 0;
	GestureCheckBox.Checked := GikoSys.Setting.GestureEnabled;
	GestureCheckBoxClick( Sender );

	MouseGesture.UnHook;
	MouseGesture.OnGestureStart := OnGestureStart;
	MouseGesture.OnGestureMove := OnGestureMove;
	MouseGesture.OnGestureEnd := OnGestureEnd;
	MouseGesture.SetHook( Handle );

    CenterForm := TCustomForm(Owner);
    if Assigned(CenterForm) then begin
        Left := ((CenterForm.Width - Width) div 2) + CenterForm.Left;
        Top := ((CenterForm.Height - Height) div 2) + CenterForm.Top;
    end else begin
        Left := (Screen.Width - Width) div 2;
        Top := (Screen.Height - Height) div 2;
    end;
end;

procedure TKeySettingForm.FormDestroy(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to ListView.Items.Count - 1 do begin
		if TObject(ListView.Items[i].Data) is TKeySettingItem then
			TKeySettingItem(ListView.Items[i].Data).Free;
	end;
	for i := 0 to ListView1.Items.Count - 1 do begin
		if TObject(ListView1.Items[i].Data) is TKeySettingItem then
			TKeySettingItem(ListView1.Items[i].Data).Free;
	end;
	 EditorForm.Release;
end;

procedure TKeySettingForm.ListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
	KeyItem: TKeySettingItem;
begin
	if not Selected then Exit;

	if TObject(Item.Data) is TKeySettingItem then begin
		KeyItem := TKeySettingItem(Item.Data);
		HotKey.HotKey := KeyItem.ShortCut;
    if IsExtKey(KeyItem.ShortCut) then
			HotKey.Modifiers := HotKey.Modifiers + [hkExt]
    else
      HotKey.Modifiers := HotKey.Modifiers - [hkExt];
		GestureEdit.Text := KeyItem.Gesture;
	end;
end;

function TKeySettingForm.IsExtKey(ShortCut: TShortCut): Boolean;
begin
  case WordRec(ShortCut).Lo of
    VK_TAB, VK_RETURN, VK_SPACE, VK_PRIOR, VK_NEXT, VK_END, VK_HOME,
    VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN, VK_INSERT, VK_DELETE:
    	Result := True;
  else
    Result := False;
  end;
end;

procedure TKeySettingForm.HotKeyEnter(Sender: TObject);
begin
	OkBotton.Default := False;
	CancelBotton.Cancel := False;
end;

procedure TKeySettingForm.HotKeyExit(Sender: TObject);
begin
	OkBotton.Default := True;
	CancelBotton.Cancel := True;
end;

procedure TKeySettingForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key in [8, 27, 32, 46] then begin
		HotKey.HotKey := ShortCut(Key, Shift);
		Key := 0;
	end;
end;

procedure TKeySettingForm.SetButtonClick(Sender: TObject);
const
	ERR_ENT = 'Enterキーはショートカットとして使用できません';
	ERR_MSG = '入力したショートカットは既に使用されています';
	ERR_TITLE = 'エラー';
var
	i: Integer;
	Item: TListItem;
	KeyItem: TKeySettingItem;
	ActiveListView: TListView;
begin
	if PageControl1.ActivePage.TabIndex <> 0 then
		ActiveListView := ListView1
	else
		ActiveListView := ListView;

	if ActiveListView.Selected = nil then Exit;
	if HotKey.HotKey = 13 then begin
		MsgBox(Handle, ERR_ENT, ERR_TITLE, MB_OK or MB_ICONSTOP);
		HotKey.SetFocus;
		Exit;
	end;

  if (HotKey.HotKey <> 0) then begin
    //現在選択されているAction以外で同じショートカットがあればエラーとする
    for i := 0 to ActiveListView.Items.Count - 1 do begin
      if ActiveListView.Selected = ActiveListView.Items[i] then
        Continue;
      Item := ActiveListView.Items[i];
      if TObject(Item.Data) is TKeySettingItem then begin
        KeyItem := TKeySettingItem(Item.Data);
        if KeyItem.ShortCut = HotKey.HotKey then begin
          MsgBox(Handle, ERR_MSG, ERR_TITLE, MB_OK or MB_ICONSTOP);
          HotKey.SetFocus;
          Exit;
        end;
      end;
    end;
  end;

	//ショートカット設定
	if TObject(ActiveListView.Selected.Data) is TKeySettingItem then begin
		KeyItem := TKeySettingItem(ActiveListView.Selected.Data);
		KeyItem.ShortCut := HotKey.HotKey;
		ActiveListView.Selected.SubItems[1] := ShortCutToText(HotKey.HotKey);
	end;
end;

procedure TKeySettingForm.OkBottonClick(Sender: TObject);
var
	i: Integer;
	Item: TListItem;
	KeyItem: TKeySettingItem;
begin

	GikoSys.Setting.GestureEnabled := GestureCheckBox.Checked;
	GikoSys.Setting.Gestures.ClearGesture;
	for i := 0 to ListView.Items.Count - 1 do begin
		Item := ListView.Items[i];
		if TObject(Item.Data) is TKeySettingItem then begin
			KeyItem := TKeySettingItem(Item.Data);
			KeyItem.Action.ShortCut := KeyItem.ShortCut;
			GikoSys.Setting.Gestures.AddGesture( KeyItem.Gesture, KeyItem.Action );
		end;
	end;
	for i := 0 to ListView1.Items.Count - 1 do begin
		Item := ListView1.Items[i];
		if TObject(Item.Data) is TKeySettingItem then begin
			KeyItem := TKeySettingItem(Item.Data);
			KeyItem.Action.ShortCut := KeyItem.ShortCut;
			GikoSys.Setting.Gestures.AddGesture( KeyItem.Gesture, KeyItem.Action );
		end;
	end;

end;

procedure TKeySettingForm.ListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
	if Item1.SubItems[0] > Item2.SubItems[0] then
 		Compare := 1
 	else if Item1.SubItems[0] < Item2.SubItems[0] then
 		Compare := -1
 	else
 		Compare := 0;
end;

procedure TKeySettingForm.GestureSetButtonClick(Sender: TObject);
const
	ERR_MSG = '入力したジェスチャーは既に使用されています';
	ERR_TITLE = 'エラー';
var
	i, j: Integer;
	Item: TListItem;
	KeyItem: TKeySettingItem;
	ActiveListView: TListView;
	chechList : TListView;
begin
	if PageControl1.ActivePage.TabIndex <> 0 then
		ActiveListView := ListView1
	else
		ActiveListView := ListView;

	if ActiveListView.Selected = nil then Exit;
	if (GetKeyState( VK_SHIFT ) and $80000000) <> 0 then begin
		GestureEdit.Text := '';
		Item := ActiveListView.Selected;
		Item.SubItems[2] := '';
		if TObject(Item.Data) is TKeySettingItem then begin
			KeyItem := TKeySettingItem(Item.Data);
			KeyItem.Gesture := '';
		end;
		Exit;
	end;

	// 現在選択されているAction以外で同じジェスチャーがあればエラーとする
	chechList := ListView;
	for j := 0 to 1 do begin
		if j <> 0 then begin
			chechList := ListView1;
		end;

		for i := 0 to chechList.Items.Count - 1 do begin
			if ActiveListView.Selected = chechList.Items[i] then
				Continue;
			Item := chechList.Items[i];
			if TObject(Item.Data) is TKeySettingItem then begin
				KeyItem := TKeySettingItem(Item.Data);
				if (GestureEdit.Text <> GUESTURE_NOTHING)
				and (KeyItem.Gesture = GestureEdit.Text) then begin
					MsgBox(Handle, ERR_MSG, ERR_TITLE, MB_OK or MB_ICONSTOP);
					HotKey.SetFocus;
					Exit;
				end;
			end;
		end;
	end;

	// ジェスチャー設定
	if TObject(ActiveListView.Selected.Data) is TKeySettingItem then begin
		KeyItem := TKeySettingItem(ActiveListView.Selected.Data);
		KeyItem.Gesture := GestureEdit.Text;
		if GestureEdit.Text = GUESTURE_NOTHING then
			ActiveListView.Selected.SubItems[2] := ''
		else
			ActiveListView.Selected.SubItems[2] := GestureEdit.Text;
	end;
end;

procedure TKeySettingForm.OnGestureStart(Sender: TObject);
begin
	GestureEdit.Text := '';
end;

procedure TKeySettingForm.OnGestureMove(Sender: TObject);
begin
	GestureEdit.Text := MouseGesture.GetGestureStr;
end;

procedure TKeySettingForm.OnGestureEnd(Sender: TObject);
begin
	GestureEdit.Text := MouseGesture.GetGestureStr;
    MouseGesture.Clear;
end;

procedure TKeySettingForm.GestureCheckBoxClick(Sender: TObject);
begin
	GestureEdit.Enabled := GestureCheckBox.Checked;
	GestureSetButton.Enabled := GestureCheckBox.Checked;
end;

procedure TKeySettingForm.GestureEditChange(Sender: TObject);
begin

	if GestureEdit.Text = '' then
		GestureEdit.Text := GUESTURE_NOTHING;

end;

procedure TKeySettingForm.GestureEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
	if (ssShift in Shift) and (MouseGesture.GetGestureStr = '') then
    	GestureEdit.Text := '';
end;

end.
