unit About;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	StdCtrls, Menus, Clipbrd, ExtCtrls, UrlMon, ShellAPI, MMSystem,
	GikoSystem, IndyModule;

type
	TAboutDialog = class(TForm)
	Panel1: TPanel;
	Label1: TLabel;
	Image1: TImage;
	Panel2: TPanel;
	Button1: TButton;
	VersionPanel: TPanel;
	VersionMemo: TMemo;
	ButtonPanel: TPanel;
    CopyButton: TButton;
		procedure FormCreate(Sender: TObject);
//		procedure BNGikoNaviImageClick(Sender: TObject);
//		procedure BNMonazillaImageClick(Sender: TObject);
//		procedure BN365ccImageClick(Sender: TObject);
//		procedure Timer2Timer(Sender: TObject);
//		procedure HiLabelClick(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CopyButtonClick(Sender: TObject);
//		procedure Image1Click(Sender: TObject);
//    procedure Timer1Timer(Sender: TObject);
	private
		{ Private 宣言 }
//		FCnt: Integer;
	public
		{ Public 宣言 }
	end;

var
	AboutDialog: TAboutDialog;

implementation

const
	ST: array[0..10] of string =
					('【感謝】毎度ありがとうございます【謝意】',
					 'いつもホットゾヌのソースを参考にさせていただいております',
					 'アイコンなどの素材は牛さん作のアイコンを使っております',
					 'gzipコンポーネントは名無しさん作のを使っております',
					 '暗号化処理はJane作者さんのを使っております',
					 'Dolib関連はDaxさん作のを使っております',
					 'Dolibを改造するときkage作者さんのソースを参考にしております',
					 'いつもDelスレでフサギコさんに助けてもらってます',
					 'いろいろなソースを参考にしております',
					 'ギコナビスレではユーザの方々に禿まされております',
					 'とても おいしゅうございました');

//	MAIL_GIKOANVI: string = 'mailto:gikonavi@ice.dti2.ne.jp';
//	URL_GIKONAVI:  string = 'http://gikonavi.hp.infoseek.co.jp/';
//	URL_MONAZILLA: string = 'http://www.monazilla.org/';
//	URL_365CC:     string = 'http://www.kyoto.zaq.ne.jp/365cc/';
//	TIP_GIKONAVI:  string = 'ギコナビのページ';
//	TIP_MONAZILLA: string = '2ch用ブラウザを作成しているサイト' + #13#10
//												+ 'ギコナビもまぜてもらってます';
//	TIP_365CC:     string = '2chキャラの素材を製作してる牛さんのページ' + #13#10
//												+ 'ギコナビでも利用させてもらってます。';

{$R *.DFM}
//{$R gikoSound.res}

procedure TAboutDialog.FormCreate(Sender: TObject);
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
	VersionMemo.Clear;
	VersionMemo.Lines.Add('Version ' + BETA_VERSION_NAME_J
									+ FloatToStr(BETA_VERSION)
									+ '('
									+ GikoSys.Version
									+ ')');
    VersionMemo.Lines.Add('');
	VersionMemo.Lines.Add('<Plugins>');
	VersionMemo.Lines.Add(Trim(GikoSys.GetPluginsInfo));
	VersionMemo.Lines.Add('');
	VersionMemo.Lines.Add('<IE>');
	VersionMemo.Lines.Add(Trim(GikoSys.GetIEVersion));
{$IFDEF DEBUG}
	VersionMemo.Lines.Add('');
	VersionMemo.Lines.Add('<Indy>');
  VersionMemo.Lines.Add(IndyMdl.GetIndyVersion);
{$ENDIF}
	VersionMemo.Lines.Add('');
	VersionMemo.Lines.Add('<OpenSSL>');
  VersionMemo.Lines.Add(IndyMdl.GetOpenSSLVersion);
end;


{procedure TAboutDialog.BNGikoNaviImageClick(Sender: TObject);
begin
	GikoSys.OpenBrowser(URL_GIKONAVI, gbtAuto);
end;

procedure TAboutDialog.BNMonazillaImageClick(Sender: TObject);
begin
	GikoSys.OpenBrowser(URL_MONAZILLA, gbtAuto);
end;

procedure TAboutDialog.BN365ccImageClick(Sender: TObject);
begin
	GikoSys.OpenBrowser(URL_365CC, gbtAuto);
end;}

{procedure TAboutDialog.Timer2Timer(Sender: TObject);
begin
	Timer2.Interval := 3000;
	Label5.Caption := ST[FCnt];
	inc(FCnt);
	if FCnt > (Length(ST) - 1) then FCnt := 0;
end;}

{procedure TAboutDialog.HiLabelClick(Sender: TObject);
begin
	ShellExecute(Handle, 'Open', PChar(MAIL_GIKOANVI), '', '', SW_SHOW);
end;}

procedure TAboutDialog.FormClose(Sender: TObject;
	var Action: TCloseAction);
begin
//	AnimateWindow(Handle, 200, AW_HIDE or AW_BLEND);
//	sndPlaySound(nil, SND_ASYNC or SND_MEMORY);
end;

{procedure TAboutDialog.Image1Click(Sender: TObject);
var
	hResInfo: HRSRC;
	hglb: HGLOBAL;
	FRes: Pointer;
begin
	Timer2.Enabled := False;
	Timer1.Enabled := True;
	Refresh;
	hResInfo := FindResource(HInstance, '#101', 'WAVE');
	hglb := LoadResource(HInstance, hResInfo);
	FRes := LockResource(hglb);
	sndPlaySound(FRes, SND_ASYNC or SND_MEMORY);

end;}

{procedure TAboutDialog.Timer1Timer(Sender: TObject);
begin
	Canvas.Brush.Style := bsClear;
	Canvas.Font.Color := Random($FFFFFF);
	Canvas.Font.Size := Random(30);
	Canvas.TextOut(Random(Width), Random(Height), 'ネタ切れ');

end;}

procedure TAboutDialog.CopyButtonClick(Sender: TObject);
begin
	//バージョン情報をClipBoardに入れる
	Clipboard.SetTextBuf( PChar(VersionMemo.Text) );
end;

end.
