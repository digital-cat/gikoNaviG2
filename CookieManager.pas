unit CookieManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, IdCookie, Buttons, ActnList;

type
  TCookieForm = class(TForm)
    Panel1: TPanel;
    ListView: TListView;
    EditButton: TSpeedButton;
    DelButton: TSpeedButton;
    ActionList: TActionList;
    EditAction: TAction;
    DelAction: TAction;
    procedure FormShow(Sender: TObject);
    procedure EditActionExecute(Sender: TObject);
    procedure DelActionExecute(Sender: TObject);
    procedure EditActionUpdate(Sender: TObject);
    procedure DelActionUpdate(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
  private
    procedure LoadItems;
    procedure EditItem(item: TListItem);
  public
    { Public declarations }
  end;

var
  CookieForm: TCookieForm;

implementation

uses
	IndyModule, GikoUtil, GikoInputBoxForm, DmSession5ch, GikoSystem, GikoDataModule;

{$R *.dfm}

procedure TCookieForm.FormShow(Sender: TObject);
begin
	LoadItems;
end;

{ ��ʂւ�Cookie�ǂݍ��� }
procedure TCookieForm.LoadItems;
var
  i: Integer;
  max: Integer;
	cookie: TIdCookie;
  item: TListItem;
  date: String;
begin
	try
  	ListView.Clear;
    max := IndyMdl.CookieCount - 1;
    for i := 0 to max do begin
      cookie := IndyMdl.GetCookie(i);
      DateTimeToString(date, 'yyyy/mm/dd hh:nn:ss', cookie.Expires);
      item := ListView.Items.Add;
      item.Caption := cookie.CookieName;
      item.SubItems.Add(cookie.Value);
      item.SubItems.Add(cookie.Domain);
      item.SubItems.Add(cookie.Path);
      item.SubItems.Add(date);
      // ���m�̏d�vCookie
      if IndyMdl.IsDonguriCookie(cookie) then
        item.SubItems.Add('�ǂ񂮂�')
      else if IndyMdl.IsUpliftCookie(cookie) then
        item.SubItems.Add('UPLIFT')
      else if IndyMdl.IsBeCookie(cookie) then
        item.SubItems.Add('Be')
      else if IndyMdl.IsTakoCookie(cookie) then
        item.SubItems.Add('�^�R');
    end;

    EditButton.Caption := '';
    DelButton.Caption := '';
  Except
    on e: Exception do begin
      MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TCookieForm.DelActionUpdate(Sender: TObject);
begin
	EditAction.Enabled := (ListView.SelCount > 0);
end;

procedure TCookieForm.EditActionExecute(Sender: TObject);
var
	item: TListItem;
begin
	try
  	item := ListView.Selected;
    if item <> nil then
    	EditItem(item);
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, '�G���[', MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TCookieForm.EditItem(item: TListItem);
var
  inputBox: TGikoInputBox;
  url: String;
begin
	try
		inputBox := TGikoInputBox.Create(Self);
  	try
      inputBox.DlgCaption := 'Cookie�ҏW';
      inputBox.Prompt := '[' + item.Caption + '] Cookie�l:';
      inputBox.Value := item.SubItems.Strings[0];
	    inputBox.FormStyle := fsStayOnTop;
      if inputBox.ShowModal = mrOk then begin
        url := 'https://' + item.SubItems[1] + item.SubItems[2];
        IndyMdl.SetCookieValue(item.Caption, url, inputBox.Value);
				item.SubItems.Strings[0] := inputBox.Value;
			end;
    finally
    	inputBox.Free;
    end;
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, '�G���[', MB_OK or MB_ICONERROR);
    end;
  end;
end;



procedure TCookieForm.EditActionUpdate(Sender: TObject);
begin
	DelAction.Enabled := (ListView.SelCount > 0);
end;

procedure TCookieForm.DelActionExecute(Sender: TObject);
var
	item: TListItem;
  url: String;
begin
	try
  	item := ListView.Selected;
    if item = nil then
    	Exit;

  	if item.SubItems.Count >= 5 then begin
    	if item.SubItems.Strings[4] = 'UPLIFT' then begin
      	if Session5ch.Connected and		// ���O�C����
					(MsgBox(Handle, 'UPLIFT���烍�O�A�E�g���܂��B' + #10 +
           								'��낵���ł����H', Caption, MB_YESNO or MB_ICONQUESTION) = IDYES) then begin
            GikoDM.LoginAction.Execute;
            LoadItems;
            Exit;
				end;
    	end else if item.SubItems.Strings[4] = 'Be' then begin
        if GikoSys.Belib.Connected and	// ���O�C����
					(MsgBox(Handle, 'Be���烍�O�A�E�g���܂��B' + #10 +
           								'��낵���ł����H', Caption, MB_YESNO or MB_ICONQUESTION) = IDYES) then begin
            GikoDM.BeLogInOutAction.Execute;
            LoadItems;
            Exit;
				end;
      end;
    end;

    if MsgBox(Handle, 'Cookie [' + item.Caption + '] ���폜���܂��B' + #10 +
                      '�폜�������ڂ͌��ɖ߂����Ƃ��ł��܂���B' + #10 +
                      '�폜���Ă���낵���ł����H',
                      'Cookie�폜', MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2)
        	<> IDYES then
    	Exit;

    url := 'https://' + item.SubItems[1] + item.SubItems[2];
    IndyMdl.DelCookie(item.Caption, url);
		item.Delete;
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, '�G���[', MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TCookieForm.ListViewDblClick(Sender: TObject);
var
  cursorPos: TPoint;
  item: TListItem;
begin
	try
    if Windows.GetCursorPos(cursorPos) = False then
      Exit;
    cursorPos := ListView.ScreenToClient(cursorPos);
    item := ListView.GetItemAt(cursorPos.X, cursorPos.Y);
    if item <> nil then
    	EditItem(item);
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, '�G���[', MB_OK or MB_ICONERROR);
    end;
  end;
end;


end.
