unit DonguriRegister;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TDonguriRegForm = class(TForm)
    WizardPageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    MemoInfo: TMemo;
    PanelBottom1: TPanel;
    ButtonOk1: TButton;
    ButtonCancel: TButton;
    PanelReg: TPanel;
    Panel2: TPanel;
    ButtonOk2: TButton;
    ButtonCancel2: TButton;
    ButtonBack2: TButton;
    PanelLink: TPanel;
    Panel4: TPanel;
    ButtonOk3: TButton;
    ButtonCancel3: TButton;
    Label1: TLabel;
    EditMail: TEdit;
    Label2: TLabel;
    EditPassword: TEdit;
    CheckBoxShowPW: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditLink: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOk1Click(Sender: TObject);
    procedure ButtonBack2Click(Sender: TObject);
    procedure CheckBoxShowPWClick(Sender: TObject);
    procedure ButtonOk2Click(Sender: TObject);
    procedure ButtonOk3Click(Sender: TObject);
  private
    FMail: String;
    FPwd:  String;
    FSTep1: Boolean;
    
    procedure ShowHttpError;
  public
    { Public declarations }
  end;

var
  DonguriRegForm: TDonguriRegForm;

implementation

uses
	GikoSystem, GikoUtil, MojuUtils;

{$R *.dfm}

procedure TDonguriRegForm.FormCreate(Sender: TObject);
begin
	try
  	FSTep1 := False;
    
  	WizardPageControl.ActivePageIndex := 0;
//    TabSheet1.TabVisible := True;
//    TabSheet2.TabVisible := False;
//    TabSheet3.TabVisible := False;
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriRegForm.ButtonOk1Click(Sender: TObject);
begin
	try
  	WizardPageControl.ActivePageIndex := 1;
//    TabSheet1.TabVisible := False;
//    TabSheet2.TabVisible := True;
//    TabSheet3.TabVisible := False;
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriRegForm.ButtonBack2Click(Sender: TObject);
begin
	try
  	WizardPageControl.ActivePageIndex := 0;
//    TabSheet1.TabVisible := True;
//    TabSheet2.TabVisible := False;
//    TabSheet3.TabVisible := False;
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriRegForm.CheckBoxShowPWClick(Sender: TObject);
begin
	try
  	if CheckBoxShowPW.Checked then
    	EditPassword.PasswordChar := #0
    else
    	EditPassword.PasswordChar := '*';
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriRegForm.ButtonOk2Click(Sender: TObject);
const
  MAIL_DOMAIN: String = '@gmail.com';
var
  mail: String;
  pwd: String;
  idx: Integer;
  len: Integer;
  lendom: Integer;
  res: String;
begin
	try
  	mail := EditMail.Text;
    if mail = '' then begin
      MsgBox(Handle, 'メールアドレスを指定してください。', Caption, MB_OK or MB_ICONERROR);
      Exit;
    end;

  	idx := Pos(MAIL_DOMAIN, mail);
    if idx < 2 then begin
      MsgBox(Handle, 'gmail.comのメールアドレスを指定してください。', Caption, MB_OK or MB_ICONERROR);
      Exit;
    end;

  	lendom := Length(MAIL_DOMAIN);
    len := Length(mail);
    if idx <> (len - lendom + 1) then begin	// @gmail.comで終わっていない
      MsgBox(Handle, 'gmail.comのメールアドレスを指定してください。', Caption, MB_OK or MB_ICONERROR);
      Exit;
    end;

    pwd := EditPassword.Text;
    if pwd = '' then begin
      MsgBox(Handle, 'パスワードを指定してください。', Caption, MB_OK or MB_ICONERROR);
      Exit;
    end;

    if GikoSys.DonguriSys.RegisterSubmit(mail, pwd, res) then begin
      if Pos('success:', res) = 1 then begin
				MsgBox(Handle, res, Caption, MB_OK or MB_ICONINFORMATION);
      	FMail := mail;
        FPwd  := pwd;
        FSTep1 := True;
        WizardPageControl.ActivePageIndex := 2;
//        TabSheet1.TabVisible := False;
//        TabSheet2.TabVisible := False;
//        TabSheet3.TabVisible := True;
      end else begin
				MsgBox(Handle, res, Caption, MB_OK or MB_ICONWARNING);
      end;
    end else
			ShowHttpError;
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
    end;
  end;
end;


procedure TDonguriRegForm.ButtonOk3Click(Sender: TObject);
const
	URL_HEAD: String = 'https://donguri.5ch.net/code/';
  RES_OK:   String = 'OK: Success';
var
	link: String;
  res: String;
  msg: String;
begin
	try
  	link := EditLink.Text;
    if link = '' then begin
      MsgBox(Handle, '検証コードリンクを指定してください。', Caption, MB_OK or MB_ICONERROR);
      Exit;
    end;

    if Pos(URL_HEAD, link) <> 1 then begin
      MsgBox(Handle, '正しくない検証コードリンクです。', Caption, MB_OK or MB_ICONERROR);
      Exit;
    end;

  	if GikoSys.DonguriSys.RegisterVerify(link, res) then begin
      if res = RES_OK then begin
      	msg := 'アカウントが正常に登録されました。';
        if FSTep1 then begin
        	if MsgBox(Handle, msg + #10 + 'アカウント情報をギコナビに登録しますか？' + #10 +
        										'（オプション画面「２ちゃんねる」タブの警備員アカウントで編集可能です。）',
                            Caption, MB_YESNO or MB_ICONQUESTION) = IDYES then begin
            GikoSys.Setting.DonguriMail := EditMail.Text;
            GikoSys.Setting.DonguriPwd  := EditPassword.Text;
					end;
        end else
          MsgBox(Handle, msg, Caption, MB_YESNO or MB_ICONINFORMATION);
        ModalResult := mrOk;
      end else
				MsgBox(Handle, res, Caption, MB_OK or MB_ICONWARNING);
    end else
			ShowHttpError;
  except
    on e: Exception do begin
      MsgBox(Handle, e.Message, Caption, MB_OK or MB_ICONERROR);
    end;
  end;
end;

procedure TDonguriRegForm.ShowHttpError;
var
  msg: String;
begin
  msg := 'エラーが発生しました。' + #10 +
         GikoSys.DonguriSys.ErroeMessage + #10 +
         'HTTP ' + IntToStr(GikoSys.DonguriSys.ResponseCode) + #10 +
         GikoSys.DonguriSys.ResponseText;
  MsgBox(Handle, PChar(msg), 'どんぐりシステム', MB_OK or MB_ICONERROR);
end;

end.
