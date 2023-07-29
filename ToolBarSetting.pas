unit ToolBarSetting;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, ExtCtrls, ComCtrls, ActnList, IniFiles,
	GikoSystem, ToolBarUtil;

type
	TGikoToolType = (gttStandard, gttList, gttBrowser);

	TToolBarItem = class
	private
		FToolBar: TToolBar;
		FButtonActionList: TList;
		FToolType: TGikoToolType;
	public
		constructor Create;
		destructor Destroy; override;
		property ToolBar: TToolBar read FToolBar write FToolBar;
		property ButtonActionList: TList read FButtonActionList write FButtonActionList;
		property ToolType: TGikoToolType read FToolType write FToolType;
	end;

	TToolBarSettingDialog = class(TForm)
		Label1: TLabel;
		AllListView: TListView;
		AddButton: TButton;
		RemoveButton: TButton;
		CurrentListView: TListView;
		Label2: TLabel;
		UpButton: TButton;
		DownButton: TButton;
		OKButton: TButton;
		CancelButton: TButton;
		Bevel1: TBevel;
		Label3: TLabel;
		ToolBarComboBox: TComboBox;
		SeparatorAddButton: TButton;
		ResetButton: TButton;
		procedure FormCreate(Sender: TObject);
		procedure FormDestroy(Sender: TObject);
		procedure ToolBarComboBoxChange(Sender: TObject);
		procedure OKButtonClick(Sender: TObject);
		procedure CurrentListViewData(Sender: TObject; Item: TListItem);
		procedure AllListViewData(Sender: TObject; Item: TListItem);
		procedure UpButtonClick(Sender: TObject);
		procedure DownButtonClick(Sender: TObject);
		procedure ResetButtonClick(Sender: TObject);
		procedure CurrentListViewChange(Sender: TObject; Item: TListItem;
			Change: TItemChange);
		procedure AllListViewChange(Sender: TObject; Item: TListItem;
			Change: TItemChange);
		procedure AddButtonClick(Sender: TObject);
		procedure RemoveButtonClick(Sender: TObject);
		procedure SeparatorAddButtonClick(Sender: TObject);
		procedure FormShow(Sender: TObject);
	private
		{ Private 宣言 }
		FActionList: TActionList;
		FAllList: TList;
		FToolBarIndex : Integer;	// 初期表示するツールバー
		procedure CreateListData(ToolBarItem: TToolBarItem);
		procedure MoveItem(Offset: Integer);
		procedure Sort;
		function SetDefaultItem(deflist: array of string; ToolBarItem: TToolBarItem): Integer;
	public
		{ Public 宣言 }
		constructor Create(AOwner: TComponent; ActionList: TActionList); reintroduce; overload; virtual;
		procedure AddToolBar(ToolBar: TToolBar; ToolType: TGikoToolType);
		property	ToolBarIndex : Integer read FToolBarIndex write FToolBarIndex;
	end;

var
	ToolBarSettingDialog: TToolBarSettingDialog;

function CompareCategory(Item1, Item2: Pointer): Integer;

implementation

//const
//	//区切り文字
//	SEPARATOR_TEXT = '- 区切り -';

{$R *.dfm}

//
// TToolBarItem
//
constructor TToolBarItem.Create;
begin
	inherited Create;
	FButtonActionList := TList.Create;
end;

destructor TToolBarItem.Destroy;
begin
	FButtonActionList.Free;
	inherited Destroy;
end;

//
// TToolBarSettingDialog
//
constructor TToolBarSettingDialog.Create(AOwner: TComponent; ActionList: TActionList);
begin
	inherited Create(AOwner);
	FActionList := ActionList;
end;

//フォーム作成
procedure TToolBarSettingDialog.FormCreate(Sender: TObject);
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

	FAllList := TList.Create;
end;

//フォーム破棄
procedure TToolBarSettingDialog.FormDestroy(Sender: TObject);
var
	i: Integer;
begin
	FAllList.Free;
	for i := 0 to ToolBarComboBox.Items.Count - 1 do
		ToolBarComboBox.Items.Objects[i].Free;
end;

//表示したとき
procedure TToolBarSettingDialog.FormShow(Sender: TObject);
begin
	ToolBarComboBox.ItemIndex := FToolBarIndex;
	ToolBarComboBoxChange(Self);
	AllListViewChange(Sender, nil, ctState);
	CurrentListViewChange(Sender, nil, ctState);
end;

//このダイアログでカスタマイズするツールバーを登録する
procedure TToolBarSettingDialog.AddToolBar(ToolBar: TToolBar; ToolType: TGikoToolType);
var
	ToolBarItem: TToolBarItem;
	i: Integer;
begin
	ToolBarItem := TToolBarItem.Create;
	ToolBarItem.ToolBar := ToolBar;
	ToolBarItem.ToolType := ToolType;
	for i := 0 to ToolBar.ControlCount - 1 do
		if ToolBar.Controls[ i ] is TToolButton Then
			if not (ToolBar.Controls[ i ].Name = 'SelectComboBoxDummy') Then
		        ToolBarITem.ButtonActionList.Add(ToolBar.Controls[i].Action);
	ToolBarComboBox.Items.AddObject(ToolBar.Caption, ToolBarItem);
end;


//コンボボックス変更時
procedure TToolBarSettingDialog.ToolBarComboBoxChange(Sender: TObject);
var
	ToolBarItem: TToolBarItem;
begin
	ToolBarItem := TToolBarItem(ToolBarComboBox.Items.Objects[ToolBarComboBox.ItemIndex]);
	CreateListData(ToolBarItem);
	AllListView.Items.Count := FAllList.Count;
	CurrentListView.Items.Count := ToolBarItem.ButtonActionList.Count;
	Sort;
	AllListView.Refresh;
	CurrentListView.Refresh;
end;

//OKボタン押したとき
procedure TToolBarSettingDialog.OKButtonClick(Sender: TObject);
var
	i: Integer;
	j: Integer;
	ToolButton: TToolButton;
	ToolBarItem: TToolBarItem;
begin
	for i := 0 to ToolBarComboBox.Items.Count - 1 do begin
		ToolBarItem := TToolBarItem(ToolBarComboBox.Items.Objects[i]);

		for j := ToolBarItem.ToolBar.ButtonCount - 1 downto 0 do
			ToolBarItem.ToolBar.Buttons[j].HostDockSite := nil;

		for j := 0 to ToolBarItem.ButtonActionList.Count - 1 do begin
			if ToolBarItem.ButtonActionList[j] = nil then begin
				ToolButton := TToolButton.Create(ToolBarItem.ToolBar);
				ToolButton.Style := tbsSeparator;
				ToolButton.Width := 8;
				ToolButton.Left := 10000;
				ToolBarItem.ToolBar.InsertControl(ToolButton);
			end else if TObject(ToolBarItem.ButtonActionList[j]) is TCustomAction then begin
				ToolButton := TToolButton.Create(ToolBarItem.ToolBar);
				ToolButton.Action := TCustomAction(ToolBarItem.ButtonActionList[j]);
				if ToolButton.ImageIndex = -1 then
					ToolButton.ImageIndex := 51;

				ToolButton.Left := 10000;
				SetButtonStyle(ToolBarItem.ButtonActionList[j], ToolButton);
				ToolBarItem.ToolBar.InsertControl(ToolButton);
			end;
		end;
	end;
end;

//全ツールボタンリストビューのデータ要求時
procedure TToolBarSettingDialog.AllListViewData(Sender: TObject; Item: TListItem);
var
	Action: TCustomAction;
begin
	if (FAllList.Count <= 0) or (FAllList.Count <= Item.Index) then
		Exit;
	if FAllList[Item.Index] = nil then begin
		Item.Caption := SEPARATOR_TEXT;
		Item.ImageIndex := -1;
		Item.Data := nil;
	end else if TObject(FAllList[Item.Index]) is TCustomAction then begin
		Action := TCustomAction(FAllList[Item.Index]);
		Item.Caption := Action.Hint;
		Item.ImageIndex := Action.ImageIndex;
		Item.Data := Action;
	end;
end;

//現在ツールボタンリストビューのデータ要求時
procedure TToolBarSettingDialog.CurrentListViewData(Sender: TObject; Item: TListItem);
var
	Action: TCustomAction;
	ToolBarItem: TToolBarItem;
begin
	ToolBarItem := TToolBarItem(ToolBarComboBox.Items.Objects[ToolBarComboBox.ItemIndex]);

	if (ToolBarItem.ButtonActionList.Count <= 0) or (ToolBarItem.ButtonActionList.Count <= Item.Index) then
		Exit;
	if ToolBarItem.ButtonActionList[Item.Index] = nil then begin
		Item.Caption := SEPARATOR_TEXT;
		Item.ImageIndex := -1;
		Item.Data := nil;
	end else if TObject(ToolBarItem.ButtonActionList[Item.Index]) is TCustomAction then begin
		Action := TCustomAction(ToolBarItem.ButtonActionList[Item.Index]);
		Item.Caption := Action.Hint;
		Item.ImageIndex := Action.ImageIndex;
		Item.Data := Action;
	end;
end;

//使用できるツールボタンリストビューに表示するデータを作成
procedure TToolBarSettingDialog.CreateListData(ToolBarItem: TToolBarItem);
var
	i: Integer;
	Category: string;
begin
	FAllList.Clear;
	for i := 0 to FActionList.ActionCount - 1 do begin
		if FActionList.Actions[i].Tag = -1 then
			Continue;
		Category := FActionList.Actions[i].Category;
		//標準ツールバーは「板」「スレッド」以外のみ対象
		if (ToolBarItem.ToolType = gttStandard) and ((Category = '板') or (Category = 'スレッド')) then
			Continue;
		//リストツールバーは「板」のみ対象
		if (ToolBarItem.ToolType = gttList) and (Category <> '板') then
			Continue;
		//ブラウザツールバーは「スレッド」のみ対象
		if (ToolBarItem.ToolType = gttBrowser) and (Category <> 'スレッド') then
			Continue;

		if ToolBarItem.ButtonActionList.IndexOf(FActionList.Actions[i]) = -1 then
			FAllList.Add(FActionList.Actions[i]);
	end;
end;

//上へボタン押したとき
procedure TToolBarSettingDialog.UpButtonClick(Sender: TObject);
begin
	MoveItem(-1);
end;

//下へボタン押したとき
procedure TToolBarSettingDialog.DownButtonClick(Sender: TObject);
begin
	MoveItem(1);
end;

//リセットボタン押したとき
procedure TToolBarSettingDialog.ResetButtonClick(Sender: TObject);
var
	ToolBarItem: TToolBarItem;
	cnt: Integer;
begin
	cnt := 0;
	ToolBarItem := TToolBarItem(ToolBarComboBox.Items.Objects[ToolBarComboBox.ItemIndex]);
	AllListView.Items.Count := 0;
	CurrentListView.Items.Count := 0;
	ToolBarItem.ButtonActionList.Clear;
	case ToolBarComboBox.ItemIndex of
		0: cnt := SetDefaultItem(DEF_STANDARD, ToolBarItem);
		1: cnt := SetDefaultItem(DEF_LIST, ToolBarItem);
		2: cnt := SetDefaultItem(DEF_BROWSER, ToolBarItem);
	end;
	CreateListData(ToolBarItem);
	AllListView.Items.Count := FAllList.Count;
	CurrentListView.Items.Count := cnt;
	Sort;
	AllListView.Refresh;
	CurrentListView.Refresh;
end;

function TToolBarSettingDialog.SetDefaultItem(deflist: array of string; ToolBarItem: TToolBarItem): Integer;
var
	i: Integer;
	Action: TCustomAction;
begin
	Result := 0;
	for i := 0 to Length(deflist) - 1 do begin
		if deflist[i] = '' then begin
			ToolBarItem.ButtonActionList.Add(nil);
			Inc(Result);
		end else begin
			Action := GetActionItem(FActionList, deflist[i]);
			if Action <> nil then begin
				ToolBarItem.ButtonActionList.Add(Action);
				Inc(Result);
			end;
		end;
	end;
end;

//リストビューのアイテムを移動する
procedure TToolBarSettingDialog.MoveItem(Offset: Integer);
var
	Item: TListItem;
	ToolBarItem: TToolBarItem;
begin
	Item := CurrentListView.Selected;
	if (Item = nil) or (Item.Index + Offset < 0) then
		Exit;

	ToolBarItem := TToolBarItem(ToolBarComboBox.Items.Objects[ToolBarComboBox.ItemIndex]);
	if Item.Index + Offset >= ToolBarItem.ButtonActionList.Count then
		Exit;

	ToolBarItem.ButtonActionList.Move(Item.Index, Item.Index + Offset);
	CurrentListView.ItemIndex := Item.Index + Offset;
	CurrentListView.Refresh;
end;

//全ツールボタンリストビューの選択変更時
procedure TToolBarSettingDialog.AllListViewChange(Sender: TObject;
	Item: TListItem; Change: TItemChange);
begin
	AddButton.Enabled := not (Item = nil);
end;

//現在ツールボタンリストビューの選択変更時
procedure TToolBarSettingDialog.CurrentListViewChange(Sender: TObject;
	Item: TListItem; Change: TItemChange);
begin
	UpButton.Enabled := not (Item = nil);
	DownButton.Enabled := not (Item = nil);
	RemoveButton.Enabled := not (Item = nil);
	if Item = nil then
		Exit;
	UpButton.Enabled := Item.Index > 0;
	DownButton.Enabled := Item.Index < CurrentListView.Items.Count - 1;
end;

//追加ボタン押したとき
procedure TToolBarSettingDialog.AddButtonClick(Sender: TObject);
var
//	List: TList;
	ToolBarItem: TToolBarItem;
	Item: TListItem;
	Action: TCustomAction;
begin
	Item := AllListView.Selected;
	if Item = nil then
		Exit;

	ToolBarItem := TToolBarItem(ToolBarComboBox.Items.Objects[ToolBarComboBox.ItemIndex]);
	Action := Item.Data;
	FAllList.Delete(Item.Index);
	if Action <> nil then begin
		Item := CurrentListView.Selected;
		if Item = nil then
			ToolBarItem.ButtonActionList.Add(Action)
		else
			ToolBarItem.ButtonActionList.Insert(Item.Index + 1, Action);
		AllListView.Items.Count := AllListView.Items.Count - 1;
		AllListView.Refresh;
		CurrentListView.Items.Count := CurrentListView.Items.Count + 1;
		CurrentListView.Refresh;
	end;
end;

//削除ボタン押したとき
procedure TToolBarSettingDialog.RemoveButtonClick(Sender: TObject);
var
	ToolBarItem: TToolBarItem;
	Item: TListItem;
	Action: TCustomAction;
begin
	Item := CurrentListView.Selected;
	if Item = nil then
		Exit;

	ToolBarItem := TToolBarItem(ToolBarComboBox.Items.Objects[ToolBarComboBox.ItemIndex]);
	Action := Item.Data;
	ToolBarItem.ButtonActionList.Delete(Item.Index);
	if Action <> nil then begin
		FAllList.Add(Action);
		AllListView.Items.Count := AllListView.Items.Count + 1;
		Sort;
		AllListView.Refresh;
	end;
	CurrentListView.Items.Count := CurrentListView.Items.Count - 1;
	CurrentListView.Refresh;
end;

//区切り追加ボタン押したとき
procedure TToolBarSettingDialog.SeparatorAddButtonClick(Sender: TObject);
var
	idx: Integer;
	ToolBarItem: TToolBarItem;
begin
	ToolBarItem := TToolBarItem(ToolBarComboBox.Items.Objects[ToolBarComboBox.ItemIndex]);
	if CurrentListView.Selected = nil then
		idx := CurrentListView.Items.Count - 1
	else
		idx := CurrentListView.Selected.Index;
	ToolBarItem.ButtonActionList.Insert(idx + 1, nil);
	CurrentListView.Items.Count := CurrentListView.Items.Count + 1;
	CurrentListView.Refresh;
end;

//全ツールボタンリストビューのソート
procedure TToolBarSettingDialog.Sort;
begin
	FAllList.Sort(@CompareCategory);
end;

//ソートするときの比較
function CompareCategory(Item1, Item2: Pointer): Integer;
var
	Action1: TCustomAction;
	Action2: TCustomAction;
begin
	if (Item1 = nil) and (Item2 = nil) then
		Result := 0
	else if (Item1 = nil) and (Item2 <> nil) then
		Result := -1
	else if (Item1 <> nil) and (Item2 = nil) then
		Result := 1
	else begin
		if (TObject(Item1) is TCustomAction) and (TObject(Item1) is TCustomAction) then begin
			Action1 := TCustomAction(Item1);
			Action2 := TCustomAction(Item2);
			Result := AnsiCompareStr(Action1.Category + Action1.Caption, Action2.Category + Action2.Caption);
		end else
			Result := 0;
	end;
end;

end.
