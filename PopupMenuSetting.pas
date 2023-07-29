unit PopupMenuSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList, Menus, ComCtrls;

type
  TPopupMenuSettingDialog = class(TForm)
    TopPanel: TPanel;
    PopupMenuComboLabel: TLabel;
    PopupMenuComboBox: TComboBox;
    MainPanel: TPanel;
    ActionListBox: TListBox;
    LabelButton: TButton;
    AddMainButton: TButton;
    AddSubButton: TButton;
    AddSepButton: TButton;
    RemoveButton: TButton;
    UpButton: TButton;
    DownButton: TButton;
    MenuTreeView: TTreeView;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    ApplyButton: TButton;
    procedure PopupMenuComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure RemoveButtonClick(Sender: TObject);
    procedure AddSepButtonClick(Sender: TObject);
    procedure MenuTreeViewDblClick(Sender: TObject);
    procedure MenuTreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure MenuTreeViewEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure AddMainButtonClick(Sender: TObject);
    procedure AddSubButtonClick(Sender: TObject);
    procedure LabelButtonClick(Sender: TObject);
    procedure MenuTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure ApplyButtonClick(Sender: TObject);
  private
    { Private 宣言 }
    FActionList: TActionList;
    FSpecialActionLists: array[0..0] of TStringList;
    function GetMenuAction(var Item:TMenuItem; Idx:Integer): TBasicAction;
    procedure AddMainMenu(const Caption: String; Action: TBasicAction);
    procedure DeleteUsedActionList(Action: TBasicAction);
    function GetIniString(Node: TTreeNode; Parent: String; Idx: Integer): String;
    function GetIniValueString(Node: TTreeNode): String;
  public
    { Public 宣言 }
    constructor Create(AOwner: TComponent; ActionList: TActionList); reintroduce; overload; virtual;
  end;

var
  PopupMenuSettingDialog: TPopupMenuSettingDialog;

implementation

uses
    PopupMenuUtil, IniFiles, GikoSystem, ToolBarUtil, GikoUtil;
{$R *.dfm}
//! コンストラクタ（引数追加）
constructor TPopupMenuSettingDialog.Create(AOwner: TComponent; ActionList: TActionList);
    const
    // 特殊アクション名
    // 巡回アイテム
    ROUNDITEM = 'RoundItem';
    // 同一板スレッド一覧用
    SAMPETHREAD='BoardThreadItem';
var
    act : TCustomAction;
begin
	inherited Create(AOwner);
	FActionList := ActionList;
    FSpecialActionLists[0] := TStringList.Create();
    // 各ポップアップの特殊アクションを追加
    act := TCustomAction.Create(Self);
    act.Name := ROUNDITEM;
    act.Caption := 'スレッド巡回予約';
    FSpecialActionLists[0].AddObject(act.Caption, act);
    act := TCustomAction.Create(Self);
    act.Name := SAMPETHREAD;
    act.Caption := '同板で表示しているスレッド';
    FSpecialActionLists[0].AddObject(act.Caption, act);

end;
//! ポップアップメニューコンボボックス変更イベント
procedure TPopupMenuSettingDialog.PopupMenuComboBoxChange(Sender: TObject);
var
    act : TCustomAction;
    bact: TBasicAction;
    ini : TMemIniFile;
    mkeys, skeys : TStringList;
    i, j, idx: Integer;
    value, subValue : String;
    item, subItem : TMenuItem;
    node : TTreeNode;
begin
    ActionListBox.Items.Clear;
    MenuTreeView.Items.Clear;
    AddSubButton.Enabled := False;
    case PopupMenuComboBox.ItemIndex of
    0 : begin
        for idx := 0 to Length(PopupMenuUtil.ACK_BROWSER) -1 do begin
            act := PopupMenuUtil.GetActionItem(FActionList, PopupMenuUtil.ACK_BROWSER[idx]);
            if (act <> nil) then begin
                ActionListBox.AddItem(act.Caption, act);
            end;
        end;
    end
    else
        ;
    end;
    for idx := 0 to FSpecialActionLists[PopupMenuComboBox.ItemIndex].Count - 1 do begin
        // 一旦すべて追加する
        act := TCustomAction(FSpecialActionLists[PopupMenuComboBox.ItemIndex].Objects[idx]);
        if (act <> nil) then begin
            ActionListBox.AddItem(act.Caption, act);
        end;
    end;

    //iniファイルの読み込み
    if (FileExists(GikoSys.Setting.GetConfigDir + PopupMenuUtil.INI_FILENAME)) Then begin
        ini := TMemIniFile.Create(GikoSys.Setting.GetConfigDir + PopupMenuUtil.INI_FILENAME);
        mkeys := TStringList.Create;
        mkeys.Sorted := true;
        skeys := TStringList.Create;
        skeys.Sorted := true;
        try
            node := nil;
            idx := PopupMenuComboBox.ItemIndex;
            ini.ReadSection(PopupMenuUtil.SECTIONS[idx], mkeys);
            // main第一階層 sub第二階層の分離
            for i := mkeys.Count - 1 downto 0 do begin
                if (Pos('sub', mkeys[i]) = 1) then begin
                    skeys.Add(mkeys[i]);
                    mkeys.Delete(i);
                end;
            end;
            // 第一階層の処理
            for i := 0 to mkeys.Count - 1 do begin
                value := ini.ReadString(PopupMenuUtil.SECTIONS[idx], mkeys[i], '-');
                item := PopupMenuUtil.GetMenuItem(
                    PopupMenuUtil.SECTIONS[idx], nil, FActionList, value);
                if (item <> nil) then begin
                    bact := GetMenuAction(item, PopupMenuComboBox.ItemIndex);
                    node := MenuTreeView.Items.AddObject(node, item.Caption, bact);
                    DeleteUsedActionList(bact);
                    // アクションが設定されているものには第二層はつけない
                    if (item.Action = nil) then begin
                        // 第二階層の処理(あれば)
                        for j := 0 to skeys.Count - 1 do begin
                            if (Pos('sub.' + mkeys[i], skeys[j]) = 1) then begin
                                subValue := ini.ReadString(PopupMenuUtil.SECTIONS[idx], skeys[j], '-');
                                subItem := GetMenuItem(PopupMenuUtil.SECTIONS[idx], nil, FActionList, subValue);
                                if (subItem <> nil) then begin
                                    bact := GetMenuAction(item, PopupMenuComboBox.ItemIndex);
                                    MenuTreeView.Items.AddChildObject(
                                            node, subItem.Caption, bact);
                                    DeleteUsedActionList(bact);
                                    subItem.Clear;
                                end;
                            end;
                        end;
                    end;
                    item.Clear;
                end;
            end;
        finally
            skeys.Free;
            mkeys.Free;
            ini.free;
        end;
    end;

end;
//! メニューアクション取得
function TPopupMenuSettingDialog.GetMenuAction(var Item:TMenuItem; Idx:Integer): TBasicAction;
var
    i : Integer;
begin
    Result := nil;
    if (Item.Action <> nil) then begin
        Result := Item.Action;
    end else if (Item.Caption = '-') then begin
        Item.Caption := ToolBarUtil.SEPARATOR_TEXT;
    end else begin
        for i := 0 to FSpecialActionLists[Idx].Count - 1 do begin
            if Item.Name = TCustomAction(FSpecialActionLists[Idx].Objects[i]).Name then begin
                Result := TBasicAction(FSpecialActionLists[Idx].Objects[i]);
                break;
            end;
        end;
    end;
end;
//! フォーム生成
procedure TPopupMenuSettingDialog.FormCreate(Sender: TObject);
begin
    PopupMenuComboBox.OnChange(nil);
end;
//! フォーム削除
procedure TPopupMenuSettingDialog.FormDestroy(Sender: TObject);
var
    idx, i : Integer;
begin
    ActionListBox.Items.Clear;
    // 特殊アクションは削除する
    for i := 0 to Length(FSpecialActionLists) - 1 do begin
        if (FSpecialActionLists[i] <> nil) then begin
            for idx := FSpecialActionLists[i].Count - 1 downto 0 do begin
                TComponent(FSpecialActionLists[i].Objects[idx]).Free;
            end;
            FSpecialActionLists[i].Free;
        end;
    end;
end;
//! Upボタン押下処理
procedure TPopupMenuSettingDialog.UpButtonClick(Sender: TObject);
begin
    if (MenuTreeView.Selected <> nil) then begin
        if (MenuTreeView.Selected.GetPrevSibling <> nil) then begin
            MenuTreeView.Selected.MoveTo(
                MenuTreeView.Selected.GetPrevSibling,
                naInsert );
        end;
    end;
end;
//! Downボタン押下処理
procedure TPopupMenuSettingDialog.DownButtonClick(Sender: TObject);
begin
    if (MenuTreeView.Selected <> nil) then begin
        if (MenuTreeView.Selected.GetNextSibling <> nil) then begin
            MenuTreeView.Selected.GetNextSibling
                .MoveTo(
                    MenuTreeView.Selected,
                naInsert );
        end;
    end;
end;
//! 削除ボタン押下処理
procedure TPopupMenuSettingDialog.RemoveButtonClick(Sender: TObject);
var
    act : TCustomAction;
    idx : Integer;
begin
    if (MenuTreeView.Selected <> nil) then begin
        if (TObject(MenuTreeView.Selected.Data) is TCustomAction) then begin
            act := TCustomAction(MenuTreeView.Selected.Data);
            // 特殊アクションの場合、Actionリストに復活させる
            for idx := 0 to FSpecialActionLists[PopupMenuComboBox.ItemIndex].Count - 1 do begin
                if ( act = TCustomAction(FSpecialActionLists[PopupMenuComboBox.ItemIndex].Objects[idx]) )
                then begin
                    ActionListBox.AddItem(act.Caption, act);
                    break;
                end;
            end;
        end;
        MenuTreeView.Items.Delete(MenuTreeView.Selected);
    end;
end;

//! 区切り追加ボタンイベント
procedure TPopupMenuSettingDialog.AddSepButtonClick(Sender: TObject);
var
    item : TMenuItem;
begin
    item := TMenuItem.Create(nil);
    item.Caption := '-';
    AddMainMenu( item.Caption,
        GetMenuAction(item, PopupMenuComboBox.ItemIndex));
    item.Free;
end;
//! メニューツリーダブルクリック時イベント
procedure TPopupMenuSettingDialog.MenuTreeViewDblClick(Sender: TObject);
begin
    if (MenuTreeView.Selected <> nil) then begin
        // 編集可能なラベルかは、Actionが設定されているかで判定
        if not (TObject(MenuTreeView.Selected.Data) is TBasicAction) then begin
            MenuTreeView.ReadOnly := False;
            MenuTreeView.Selected.EditText;
        end;
    end;
end;
//! メニューツリー編集完了イベント
procedure TPopupMenuSettingDialog.MenuTreeViewEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
begin
    // 読み取り専用に変更
    MenuTreeView.ReadOnly := True;
end;
//! メニューツリー編集イベント
procedure TPopupMenuSettingDialog.MenuTreeViewEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
    if (Node <> nil) then begin
        AllowEdit := not (TObject(Node.Data) is TBasicAction);
    end;
end;
//! メニュー追加ボタン押下処理
procedure TPopupMenuSettingDialog.AddMainButtonClick(Sender: TObject);
var
    idx, idx2 : Integer;
    act : TCustomAction;
begin

    act := nil;
    for idx := 0 to ActionListBox.Count - 1 do begin
        if ( ActionListBox.Selected[idx] ) then begin
            act := TCustomAction(ActionListBox.Items.Objects[idx]);
            // 特殊アクションの場合、Actionリストから削除する
            for idx2 := 0 to FSpecialActionLists[PopupMenuComboBox.ItemIndex].Count - 1 do begin
                if ( act = TCustomAction(FSpecialActionLists[PopupMenuComboBox.ItemIndex].Objects[idx2]) )
                then begin
                    ActionListBox.Items.Delete(idx);
                    break;
                end;
            end;
            break;
        end;

    end;

    if ( act <> nil ) then begin
        AddMainMenu( act.Caption, TBasicAction(act) );
    end;
end;
//! サブメニュー追加ボタン押下処理
procedure TPopupMenuSettingDialog.AddSubButtonClick(Sender: TObject);
var
    idx, idx2 : Integer;
    act : TCustomAction;
    node : TTreeNode;
begin

    node := MenuTreeView.Selected;

    if (node <> nil) then begin
        if not (TObject(node.Data) is TBasicAction) then begin
            act := nil;
            for idx := 0 to ActionListBox.Count - 1 do begin
                if ( ActionListBox.Selected[idx] ) then begin
                    act := TCustomAction(ActionListBox.Items.Objects[idx]);
                    // 特殊アクションの場合、Actionリストから削除する
                    for idx2 := 0 to FSpecialActionLists[PopupMenuComboBox.ItemIndex].Count - 1 do begin
                        if ( act = TCustomAction(FSpecialActionLists[PopupMenuComboBox.ItemIndex].Objects[idx2]) )
                        then begin
                            ActionListBox.Items.Delete(idx);
                            break;
                        end;
                    end;
                    break;
                end;
            end;
            if ( act <> nil ) then begin
                MenuTreeView.Items.AddChildObject(
                    node, act.Caption, act);
            end;
        end;
    end;
end;
//! ラベル追加ボタン押下処理
procedure TPopupMenuSettingDialog.LabelButtonClick(Sender: TObject);
begin
    if (MenuTreeView.Selected <> nil) then begin
        // サブメニューにラベルは追加できない
        if ( MenuTreeView.Selected.Parent <> nil) then begin
            Exit;
        end;
    end;
    AddMainMenu('新規ラベル', TBasicAction(nil));
end;
//! メニューツリーメインメニュー追加
procedure TPopupMenuSettingDialog.AddMainMenu(const Caption: String; Action: TBasicAction);
var
    node : TTreeNode;
begin
    node := nil;

    if (MenuTreeView.Selected <> nil) then begin
        // サブメニュー
        if ( MenuTreeView.Selected.Parent <> nil) then begin
            // 同一階層の次のアイテムを取得
            if (MenuTreeView.Selected.getNextSibling <> nil) then begin
                node := MenuTreeView.Selected.getNextSibling;
            end else begin
                node := MenuTreeView.Selected;
            end;
        end else begin
            node := MenuTreeView.Selected.getNextSibling;
        end;
    end;
    // node がnil なら末尾追加
    if ( node <> nil ) then begin
        MenuTreeView.Items.InsertObject(node,
                Caption, Action);
    end else begin
        MenuTreeView.Items.AddObject(node,
                Caption, Action);
    end;
end;
//! 使用済み特殊アクションをアクションリストから削除する
procedure TPopupMenuSettingDialog.DeleteUsedActionList(Action: TBasicAction);
var
    idx, idx2 : Integer;
    act : TCustomAction;
begin
    if (Action is TCustomAction) then begin
        act := TCustomAction(Action);
        // 特殊アクションの場合、Actionリストから削除する
        for idx2 := 0 to FSpecialActionLists[PopupMenuComboBox.ItemIndex].Count - 1 do begin
            if ( act = TCustomAction(FSpecialActionLists[PopupMenuComboBox.ItemIndex].Objects[idx2]) )
            then begin
                for idx := 0 to ActionListBox.Count - 1 do begin
                    if ( act = TCustomAction(ActionListBox.Items.Objects[idx]) )
                    then begin
                        ActionListBox.Items.Delete(idx);
                        break;
                    end;
                end;
                break;
            end;
        end;
    end;
end;

procedure TPopupMenuSettingDialog.MenuTreeViewChange(Sender: TObject;
  Node: TTreeNode);
begin
    if (Node <> nil) then begin
        if (Node.Data = nil) and (Node.Text <> ToolBarUtil.SEPARATOR_TEXT) then begin
            AddSubButton.Enabled := True;
        end else begin
            AddSubButton.Enabled := False;
        end;
    end else begin
        AddSubButton.Enabled := False;

    end;
end;
function TPopupMenuSettingDialog.GetIniString(Node: TTreeNode; Parent: String; Idx: Integer): String;
begin
    Result := '';
    if ( Node.Parent <> nil ) then begin
        Result := Format('sub.%s.%2.2d', [Parent, idx + 1]);
    end else begin
        Result := Format('main.%2.2d', [idx + 1]);
    end;
end;
function TPopupMenuSettingDialog.GetIniValueString(Node: TTreeNode): String;
begin
    Result := '';
    if (Node.Data = nil) then begin
        if (Node.Text <> ToolBarUtil.SEPARATOR_TEXT) then begin
            Result := '"' + Node.Text;
        end else begin
            Result := '-';
        end;
    end else begin
        Result := TBasicAction(Node.Data).Name;
    end;
end;
//! 適用ボタン押下処理
procedure TPopupMenuSettingDialog.ApplyButtonClick(Sender: TObject);
const
    MSG = '設定を保存しました。再起動後に有効になります。';
var
    ini : TMemIniFile;
    sec, key, subkey : String;
    node : TTreeNode;
    idx, mainIdx, subIdx : Integer;
begin
    ini := TMemIniFile.Create(GikoSys.Setting.GetConfigDir + PopupMenuUtil.INI_FILENAME);
    try
        sec := PopupMenuUtil.SECTIONS[PopupMenuComboBox.ItemIndex];
        // セクションすべてを消す
        ini.EraseSection(sec);
        mainIdx := 0;
        subIdx  := 0;

        node := MenuTreeView.Items.GetFirstNode;
        while node <> nil do begin
            if (node.Parent = nil) then begin
                subIdx  := 0;
                key := GetIniString(node, key, mainIdx);
                ini.WriteString(sec, key, GetIniValueString(node));
                Inc(mainIdx);
            end else begin
                subkey := GetIniString(node, key, subIdx);
                ini.WriteString(sec, subkey, GetIniValueString(node));
                Inc(subIdx);
            end;
            node := node.GetNext;
        end;
        ini.UpdateFile;

		MsgBox(Self.Handle, MSG, 'ギコナビ', MB_OK or MB_ICONINFORMATION);

    finally
        ini.Free;
    end;
end;
end.
