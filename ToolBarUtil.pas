unit ToolBarUtil;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls,
	StdCtrls, ExtCtrls, ComCtrls, ActnList;

const
	//標準ツールバーデフォルト
	DEF_STANDARD: array[0..11]	of string = ('RoundAction',
																					'',
																					'ArrangeAction',
																					'',
																					'StopAction',
																					'LoginAction',
																					'',
																					'CabinetBBSAction',
																					'CabinetHistoryAction',
																					'CabinetFavoriteAction',
																					'MuteAction',
                                                                                    'BeLogInOutAction');
	//リストツールバーデフォルト
	DEF_LIST:    	array[0..18] of string = ('ListNumberVisibleAction',
																					'IconStyle',
																					'UpFolderAction',
																					'',
																					'AllItemAction',
																					'LogItemAction',
																					'NewItemAction',
																					'LiveItemAction',
																					'ArchiveItemAction',
																					'SelectItemAction',
																					'',
																					'ThreadEditorAction',
																					'',
																					'BoardIEAction',
																					'',
																					'SelectListReloadAction',
																					'SelectThreadReloadAction',
																					'',
																					'SelectReservAction');
	//ブラウザツールバーデフォルト
	DEF_BROWSER:  array[0..16] of string = ('BrowserMaxAction',
																					'BrowserMinAction',
																					'',
																					'ScrollTopAction',
																					'ScrollLastAction',
																					'ScrollNewAction',
																					'ScrollKokoAction',
																					'',
																					'SelectResAction',
																					'ResRangeAction',
																					'',
																					'EditorAction',
																					'',
																					'IEAction',
																					'',
																					'ItemReloadAction',
																					'UpBoardAction'
																					);


	/// ボタンスタイルが"tbsCheck"ボタンのアクション
	CHECK_STYLE:   array[0..37] of string = ('CabinetVisibleAction',
                                                                                    'MuteAction',
																					'ArrangeAction',
																					'AllItemAction',
																					'LogItemAction',
																					'NewItemAction',
																					'LiveItemAction',
																					'ArchiveItemAction',
																					'SelectItemAction',

																					'StdToolBarVisibleAction',
																					'AddressBarVisibleAction',
																					'LinkBarVisibleAction',
																					'ListToolBarVisibleAction',
																					'ListNameBarVisibleAction',
																					'BrowserToolBarVisibleAction',
																					'BrowserNameBarVisibleAction',
																					'MsgBarVisibleAction',
																					'StatusBarVisibleAction',
																					'CabinetHistoryAction',
                                          'CabinetFavoriteAction',
																					'LargeIconAction',
																					'SmallIconAction',
																					'ListIconAction',
																					'DetailIconAction',
																					'BrowserTabVisibleAction',
																					'BrowserTabTopAction',
																					'BrowserTabBottomAction',
																					'BrowserTabTabStyleAction',
																					'BrowserTabButtonStyleAction',
																					'BrowserTabFlatStyleAction',
																					'LoginAction',
																					'ListNumberVisibleAction',
																					'AllResAction',
																					'SelectResAction',
																					'OnlyAHundredResAction',
																					'OnlyKokoResAction',
																					'OnlyNewResAction',
                                                                                    'BeLogInOutAction'
																					);

	/// ボタンのスタイルが"tbsDropDown"ボタンのアクション
	/// Giko.pas : SetToolBarPopup も修正する事
	DROPDOWN_STYLE: array[0..4] of string = ('IconStyle',
																					 'IEAction',
																					 'CabinetBBSAction',
																					 'ResRangeAction',
																					 'ThreadRangeAction');

	INI_FILENAME: string = 'ToolBar.ini';

	//区切り文字
	SEPARATOR_TEXT = '- 区切り -';

	function IsCheckStyle(Action: TCustomAction): Boolean;
	function IsDropDownStyle(Action: TCustomAction): Boolean;
	procedure SetButtonStyle(Action: TCustomAction; Button: TToolButton);
	function GetActionItem(ActionList: TActionList; ActionName: string): TCustomAction;
	procedure ReadToolBarSetting(ActionList: TActionList; ToolBar: TToolBar);
	procedure SaveToolBarSetting(ToolBar: TToolBar);
	procedure MakeDefaultINIFile();

implementation

uses
	IniFiles,	GikoSystem, MojuUtils;

function ConvertToolButton( setting : string ) : string;
begin

	// 旧 [最新100レスのみ表示] を [レスの表示範囲を設定] に置換
	if setting = 'OnlyAHundredRes' then
		Result := 'ResRangeAction'
	else
		Result := setting;

end;

procedure ReadToolBarSetting(ActionList: TActionList; ToolBar: TToolBar);
var
	FileName: string;
	ini: TMemIniFile;
	i: Integer;
	s: string;
	Action: TCustomAction;
	ToolButton: TToolButton;
begin
	FileName := GikoSys.GetConfigDir + INI_FILENAME;
	if FileExists(FileName) then begin
		for i := ToolBar.ButtonCount - 1 downto 0 do begin
			ToolBar.Buttons[i].HostDockSite := nil;
		end;
		ini := TMemIniFile.Create(FileName);
		try
			i := 0;
			while True do begin
				s := ini.ReadString(ToolBar.Name, 'Button' + IntToStr(i), '');
				s := ConvertToolButton( s );
				if s = '-' then begin
					ToolButton := TToolButton.Create(ToolBar);
					ToolButton.Style := tbsSeparator;
					ToolButton.Width := 8;
					ToolButton.Left := 10000;
					ToolBar.InsertControl(ToolButton);
				end else if s <> '' then begin
					Action := GetActionItem(ActionList, s);
					if Action <> nil then begin
						ToolButton := TToolButton.Create(ToolBar);
						ToolButton.Action := Action;
						if ToolButton.ImageIndex = -1 then
							ToolButton.ImageIndex := 51;

						ToolButton.Left := 10000;
						SetButtonStyle(Action, ToolButton);
						ToolBar.InsertControl(ToolButton);
					end;
				end else
					Break;
				inc(i);
			end;
		finally
			ini.Free;
		end;
	end;
end;

procedure SaveToolBarSetting(ToolBar: TToolBar);
var
	ini: TMemIniFile;
	i, j: Integer;
	Action: TBasicAction;
begin
	ini := TMemIniFile.Create(GikoSys.GetConfigDir + INI_FILENAME);
        j := 0;
	try
		ini.EraseSection(ToolBar.Name);
		for i := 0 to ToolBar.ButtonCount - 1 do begin
			if ToolBar.Buttons[i].Style = tbsSeparator then begin
                //SelectComboBox用のダミーは保存しない
				if not (ToolBar.Buttons[i].Name = 'SelectComboBoxDummy') then begin
					ini.WriteString(ToolBar.Name, 'Button' + IntToStr(j), '-');
					Inc( j );
				end;
			end else begin
				Action := ToolBar.Buttons[i].Action;
				if Action <> nil then
								begin
					ini.WriteString(ToolBar.Name, 'Button' + IntToStr(j), Action.Name);
                                        Inc( j );
                                end;
			end;
		end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

//ActionNameのActionを返します
function GetActionItem(ActionList: TActionList; ActionName: string): TCustomAction;
var
	i: Integer;
begin
	for i := 0 to ActionList.ActionCount - 1 do begin
		if ActionList.Actions[i].Name = ActionName then begin
			Result := TCustomAction(ActionList.Actions[i]);
			Exit;
		end;
	end;
	Result := nil;
end;

//ツールボタンのスタイル設定とポップアップ設定
procedure SetButtonStyle(Action: TCustomAction; Button: TToolButton);
begin
	if IsCheckStyle(Action) then
		Button.Style := tbsCheck
	else if IsDropDownStyle(Action) then
		Button.Style := tbsDropDown
	else
		Button.Style := tbsButton;
end;

//Actionがチェックスタイルのアクションかどうかを返します
function IsCheckStyle(Action: TCustomAction): Boolean;
var
	i: Integer;
begin
	for i := 0 to Length(CHECK_STYLE) - 1 do begin
		if Action.Name = CHECK_STYLE[i] then begin
			Result := True;
			Exit;
		end;
	end;
	Result := False;
end;

//Actionがドロップダウンスタイルのアクションかどうかを返します
function IsDropDownStyle(Action: TCustomAction): Boolean;
var
	i: Integer;
begin
	for i := 0 to Length(DROPDOWN_STYLE) - 1 do begin
		if Action.Name = DROPDOWN_STYLE[i] then begin
			Result := True;
			Exit;
		end;
	end;
	Result := False;
end;

procedure MakeDefaultINIFile();
var
	ini: TMemIniFile;
    i: Integer;
begin
	//標準ツールバーデフォルト
	//DEF_STANDARD:
	//リストツールバーデフォルト
	//DEF_LIST:
	//ブラウザツールバーデフォルト
	//DEF_BROWSER:
    if not FileExists(GikoSys.GetConfigDir + INI_FILENAME) then begin
	    ini := TMemIniFile.Create(GikoSys.GetConfigDir + INI_FILENAME);
        try
            for i := 0 to Length(DEF_STANDARD) - 1 do begin
            	if DEF_STANDARD[i] <> '' then
                	ini.WriteString('StdToolBar', 'Button' + IntToStr(i), DEF_STANDARD[i])
                else
                	ini.WriteString('StdToolBar', 'Button' + IntToStr(i), '-');
            end;
            for i := 0 to Length(DEF_LIST) - 1 do begin
                if DEF_LIST[i] <> '' then
	            	ini.WriteString('ListToolBar', 'Button' + IntToStr(i), DEF_LIST[i])
                else
                	ini.WriteString('ListToolBar', 'Button' + IntToStr(i), '-');
            end;
            for i := 0 to Length(DEF_BROWSER) - 1 do begin
                if DEF_BROWSER[i] <> '' then
	            	ini.WriteString('BrowserToolBar', 'Button' + IntToStr(i), DEF_BROWSER[i])
                else
                	ini.WriteString('BrowserToolBar', 'Button' + IntToStr(i), '-');
            end;

        finally
        	ini.UpdateFile;
            ini.Free;
        end;
    end;

end;

end.
