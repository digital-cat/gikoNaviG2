unit PopupMenuUtil;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls,
	StdCtrls, ExtCtrls, ComCtrls, ActnList, Menus,
    IniFiles,	GikoSystem, MojuUtils, Giko;

    procedure ReadSetting(ActionList: TActionList; PopupMenu: TPopupMenu);
    function GetActionItem(ActionList: TActionList; ActionName: string): TCustomAction;
    function GetMenuItem(Section: string; PopupMenu: TPopupMenu; ActionList: TActionList; MenuName: string): TMenuItem;
    function checkActionName(Section: string ; ActionName: string): Boolean;
const
    //! �ݒ�t�@�C����
	INI_FILENAME: string = 'popupmenu.ini';
    //! �u���E�U�^�u�Z�N�V������
    BROWSER_TAB: string = 'BrowserTab';
    //! �Z�N�V�����̈ꗗ
    SECTIONS : array[0..0] of string =( 'BrowserTab' ) ;

    //! �u���E�U�^�u�|�b�v�A�b�v�ɐݒ�\�ȃ��j���[��
    ACK_BROWSER: array[0..7]	of string = (
                                            'ItemReloadAction',
                                            'FavoriteAddAction',
                                            'BrowserTabCloseAction',
                                            'NotSelectTabCloseAction',
                                            'LeftTabCloseAction',
                                            'RightTabCloseAction',
                                            'ActiveLogDeleteAction',
                                            'AllTabCloseAction');

implementation
procedure ReadSetting(ActionList: TActionList; PopupMenu: TPopupMenu);
const
    // ����A�N�V������
    // ����A�C�e��
    ROUNDITEM = 'RoundItem';
    // ����X���b�h�ꗗ�p
    SAMPETHREAD='SameBoardThreadItem';
var
    ini : TMemIniFile;
    mkeys, skeys : TStringList;
    i, j, idx: Integer;
    value, subValue : String;
    item, subItem : TMenuItem;
begin
    if (FileExists(GikoSys.Setting.GetConfigDir + INI_FILENAME)) Then begin
        ini := TMemIniFile.Create(GikoSys.Setting.GetConfigDir + INI_FILENAME);
        mkeys := TStringList.Create;
        mkeys.Sorted := true;
        skeys := TStringList.Create;
        skeys.Sorted := true;
        try
            for idx := 0 to Length(SECTIONS) - 1 do begin
                ini.ReadSection(SECTIONS[idx], mkeys);
                // main���K�w sub���K�w�̕���
                for i := mkeys.Count - 1 downto 0 do begin
                    if (Pos('sub', mkeys[i]) = 1) then begin
                        skeys.Add(mkeys[i]);
                        mkeys.Delete(i);
                    end;
                end;
                // ���K�w�̏���
                PopupMenu.Items.Clear;
                for i := 0 to mkeys.Count - 1 do begin
                    value := ini.ReadString(SECTIONS[idx], mkeys[i], '-');
                    item := GetMenuItem(SECTIONS[idx], PopupMenu, ActionList, value);
                    if (item <> nil) then begin
                        PopupMenu.Items.Add(item);
                        // �A�N�V�������ݒ肳��Ă�����̂ɂ͑��w�͂��Ȃ�
                        if (item.Action = nil) then begin
                            // ���K�w�̏���(�����)
                            for j := 0 to skeys.Count - 1 do begin
                                if (Pos('sub.' + mkeys[i], skeys[j]) = 1) then begin
                                    subValue := ini.ReadString(SECTIONS[idx], skeys[j], '-');
                                    subItem := GetMenuItem(SECTIONS[idx], PopupMenu, ActionList, subValue);
                                    if (subItem <> nil) then begin
                                        item.Add(subItem);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                // ���̃Z�N�V�����̏������I������̂ŃN���A
                mkeys.Clear;
                skeys.Clear;
            end;
        finally
            skeys.Free;
            mkeys.Free;
            ini.Free;
        end;
    end;
end;
//! ���j���[��Ԃ�
function GetMenuItem(Section: string; PopupMenu: TPopupMenu; ActionList: TActionList; MenuName: string): TMenuItem;
var
    Action: TCustomAction;
begin
    Result := nil;
    // �_�u���N�H�[�g�Ŏn�܂�Ƃ��̓��x��
    if (Pos('"', MenuName)=1) then begin
        Result := TMenuItem.Create(PopupMenu);
        Result.Caption := Copy(MenuName, 2, Length(MenuName));
    end else if (MenuName = '-' ) then begin
        // ��؂��
        Result := TMenuItem.Create(PopupMenu);
        Result.Caption := '-';
    end else begin
        if (BROWSER_TAB = Section) then begin
            // �u���E�U�^�u�̓���Ή�
            if (MenuName = 'RoundItem' ) then begin
                try
                    // ���񃁃j���[�p�_�~�[
                    Result := TMenuItem.Create(PopupMenu);
                    Result.Name := 'RoundItem';
                    Result.Caption := GikoForm.ItemReservPMenu.Caption;
                    Result.Hint    := GikoForm.ItemReservPMenu.Hint;
                except
                    // ���Ɏg���Ă�Ƃ��̓G���[�ɂȂ�
                    Result.Free;
                    Result := nil;
                end;
            end else if (MenuName = 'BoardThreadItem' ) then begin
                try
                    // ����X���b�h�\���p�_�~�[
                    Result := TMenuItem.Create(PopupMenu);
                    Result.Name := 'BoardThreadItem';
                    Result.Caption := '���ŕ\�����Ă���X���b�h';
                except
                    // ���Ɏg���Ă�Ƃ��̓G���[�ɂȂ�
                    Result.Free;
                    Result := nil;
                end;
            end;
        end;
        // ���j���[�����܂炸�ɁA�����ꂽ�A�N�V�������Ȃ�Action����쐬
        if (Result = nil) and (checkActionName(Section, MenuName)) then begin
            Action := GetActionItem(ActionList, MenuName);
            if Action <> nil then begin
                Result := TMenuItem.Create(PopupMenu);
                Result.Action := Action;
            end;
        end;
    end;
end;
//ActionName��Action��Ԃ��܂�
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

function checkActionName(Section: string ; ActionName: string): Boolean;
var
    i : Integer;
begin
    Result := False;
    if (BROWSER_TAB = Section) then begin
        for i :=0 to  Length(ACK_BROWSER) - 1 do begin
            if (ACK_BROWSER[i] = ActionName) then begin
                Result := True;
                Break;
            end;
        end;
    end;
end;
end.
