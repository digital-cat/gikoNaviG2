unit Option;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	ComCtrls, StdCtrls, ExtCtrls, Dialogs, FileCtrl, MMSystem,
	GikoSystem, GikoUtil, Buttons, UrlMon, Menus, ImgList, OleCtrls,
{$IF Defined(DELPRO) }
	//SHDocVw,
	MSHTML,
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB,
{$IFEND}
	BoardGroup, BrowserRecord, SHDocVw;

type
	TOptionDialog = class(TForm)
		CancelBotton: TButton;
		ApplyButton: TButton;
		FontDialog: TFontDialog;
		ColorDialog: TColorDialog;
		OpenDialog: TOpenDialog;
                Label26: TLabel;
                CroutOption: TButton;
                OptionTab: TPageControl;
                ConnectSheet: TTabSheet;
                ReadProxyGroupBox: TGroupBox;
                ReadAddressLabel: TLabel;
                ReadPortLabel: TLabel;
                ReadUserIDLabel: TLabel;
                ReadPasswordLabel: TLabel;
                ReadProxyCheck: TCheckBox;
                ReadProxyAddressEdit: TEdit;
                ReadPortEdit: TEdit;
                ReadProxyUserIDEdit: TEdit;
                ReadProxyPasswordEdit: TEdit;
                WriteProxyGroupBox: TGroupBox;
                WriteAddressLabel: TLabel;
                WritePortLabel: TLabel;
                WriteUserIDLabel: TLabel;
                WritePasswordLabel: TLabel;
                WriteProxyCheck: TCheckBox;
                WriteProxyAddressEdit: TEdit;
                WritePortEdit: TEdit;
				WriteProxyUserIDEdit: TEdit;
				WriteProxyPasswordEdit: TEdit;
                Font1Sheet: TTabSheet;
                Bevel1: TBevel;
                Bevel2: TBevel;
                Label19: TLabel;
				Bevel5: TBevel;
                Label20: TLabel;
                Label21: TLabel;
                Label22: TLabel;
                Label23: TLabel;
                lblSFont: TLabel;
                CabinetFontBotton: TButton;
                CabinetColorBotton: TButton;
                CabinetDefaultButton: TButton;
                CabinetMemo: TMemo;
                ListMemo: TMemo;
                ListFontBotton: TButton;
                ListColorBotton: TButton;
                ListDefaultBotton: TButton;
                HintFontButton: TButton;
                HintBackButton: TButton;
                HintDefaultButton: TButton;
                HintMemo: TMemo;
                EditorMemo: TMemo;
                EditorFontBotton: TButton;
                EditorColorBotton: TButton;
                EditorDefaultBotton: TButton;
                BrowserTabMemo: TMemo;
                BruwserTabFontButton: TButton;
                BrowserTabDefaultButton: TButton;
                OddResNumCheckBox: TCheckBox;
                OddResNumColorBox: TColorBox;
                CSSTabSheet: TTabSheet;
                GroupBox12: TGroupBox;
                CSSListLabel: TLabel;
                CSSCheckBox: TCheckBox;
                CSSListView: TListView;
                CSSBrowser: TWebBrowser;
                CSSFontCheckBox: TCheckBox;
                CSSBackColorCheckBox: TCheckBox;
                CSSFontButton: TButton;
                CSSBackColorButton: TButton;
                TabSheet3: TTabSheet;
                GroupBox9: TGroupBox;
                ThreadListIconCheckBox: TCheckBox;
                GroupBox16: TGroupBox;
                CreationTimeLogsCheckBox: TCheckBox;
                FutureThreadCheckBox: TCheckBox;
                GroupBox5: TGroupBox;
                BrowserMaxLabel: TLabel;
                BrowserMaxCombo: TComboBox;
                GroupBox17: TGroupBox;
                SelectIntervalLabel: TLabel;
                Label4: TLabel;
                Label6: TLabel;
                SelectIntervalEdit: TEdit;
                GroupBox18: TGroupBox;
                DatOchiSortCombo: TComboBox;
                ThreadSheet: TTabSheet;
                GroupBox1: TGroupBox;
                ShowMailCheckBox: TCheckBox;
                ResRangeHoldCheckBox: TCheckBox;
                ResRangeHoldComboBox: TComboBox;
                GroupBox2: TGroupBox;
                AppFolderLabel: TLabel;
                URLAppCheckBox: TCheckBox;
                AppFolderEdit: TEdit;
                AppFolderButton: TButton;
                OpenMailerCheckBox: TCheckBox;
                GroupBox6: TGroupBox;
                LogDeleteMessageCheckBox: TCheckBox;
                TabSheet1: TTabSheet;
	        TabAddRadioGroup: TRadioGroup;
                GroupBox8: TGroupBox;
                Label14: TLabel;
                Label15: TLabel;
                Label16: TLabel;
                PreviewVisibleCheckBox: TCheckBox;
                PreviewSizeComboBox: TComboBox;
                PreviewWaitEdit: TEdit;
                GroupBox10: TGroupBox;
                UnActivePopupCheckBox: TCheckBox;
                ResPopupBoldCheckBox: TCheckBox;
                TabSheet2: TTabSheet;
                GroupBox7: TGroupBox;
                Label3: TLabel;
                Label11: TLabel;
                URLDisplayCheckBox: TCheckBox;
                AddressHistoryCountEdit: TEdit;
                TabStopAddressBarCheckBox: TCheckBox;
                LinkAddCheckBox: TCheckBox;
                GroupBox15: TGroupBox;
                ShowDialogForEndCheckBox: TCheckBox;
                AllTabCloseCheckBox: TCheckBox;
                SambaGroupBox: TGroupBox;
                UseSambaCheckBox: TCheckBox;
                TabAutoSaveLoad: TGroupBox;
                TabLoadSave: TCheckBox;
                SoundSheet: TTabSheet;
                SoundEventGroupBox: TGroupBox;
                SoundListView: TListView;
                SoundReferButton: TButton;
                SoundFileEdit: TEdit;
                SoundPlayButton: TBitBtn;
                FolderSheet: TTabSheet;
                FolderGroupBox: TGroupBox;
                Label1: TLabel;
                Label2: TLabel;
                Label5: TLabel;
                LogFolderEdit: TEdit;
                LogFolderButton: TButton;
                NGwordSheet: TTabSheet;
                GroupBox14: TGroupBox;
                RloCheckBox: TCheckBox;
                ReplaceulCheckBox: TCheckBox;
                PopUpAbonCheckBox: TCheckBox;
                ShowNGLineCheckBox: TCheckBox;
                AddResAnchorCheckBox: TCheckBox;
                DeleteSyriaCheckBox: TCheckBox;
                UserIDSheet: TTabSheet;
                GroupBox3: TGroupBox;
                Label9: TLabel;
                Label10: TLabel;
                ForcedLoginLabel: TLabel;
                UserIDEdit: TEdit;
                PasswordEdit: TEdit;
                AutoLoginCheckBox: TCheckBox;
                ForcedLoginCheckBox: TCheckBox;
                GroupBox4: TGroupBox;
                Label13: TLabel;
                BoardURLComboBox: TComboBox;
                AddURLButton: TButton;
                RemoveURLButton: TButton;
                OkBotton: TButton;
                SpamFilterGroupBox: TGroupBox;
                SpamFilterAlgorithmComboBox: TComboBox;
                TabSheet4: TTabSheet;
                GroupBox13: TGroupBox;
                UseUndecidedCheckBox: TCheckBox;
                Tora3URLLabel: TLabel;
                Label12: TLabel;
                GroupBox11: TGroupBox;
                Label7: TLabel;
                BeUserIDEdit: TEdit;
                Label8: TLabel;
    BeCodeEdit: TEdit;
                BeAutoLoginCheckBox: TCheckBox;
    GroupBox19: TGroupBox;
    Label17: TLabel;
    MaxRecordCountEdit: TEdit;
    Label18: TLabel;
    UnFocusedBoldCheckBox: TCheckBox;
    IgnoreKanaCheckBox: TCheckBox;
    UseKatjuTypeSkinCheckBox: TCheckBox;
    GroupBox20: TGroupBox;
    AutoSortCheckBox: TCheckBox;
    Label24: TLabel;
    GroupBox21: TGroupBox;
    StoredTaskTrayCB: TCheckBox;
    GroupBox22: TGroupBox;
    LoopBrowserTabsCB: TCheckBox;
    GroupBox23: TGroupBox;
    IgnoreContextCheckBox: TCheckBox;
    GroupBox24: TGroupBox;
    gppRightTopRB: TRadioButton;
    gppTopRB: TRadioButton;
    gppLeftTopRB: TRadioButton;
    gppLeftRB: TRadioButton;
    gppRightRB: TRadioButton;
    gppLeftBottomRB: TRadioButton;
    gppBottomRB: TRadioButton;
    gppRighBottomRB: TRadioButton;
    ResAnchorCheckBox: TCheckBox;
    IgnoreLimitResCountCheckBox: TCheckBox;
    GroupBox25: TGroupBox;
    Label25: TLabel;
    BoukenComboBox: TComboBox;
    BoukenModButton: TButton;
    BoukenDelButton: TButton;
    BoukenEdit: TEdit;
    GroupBox26: TGroupBox;
    UseUnicodeCB: TCheckBox;
    Label27: TLabel;
    DispImageCheckBox: TCheckBox;
    GroupBox27: TGroupBox;
    ThreadTitleTrimCheckBox: TCheckBox;
    GroupBox28: TGroupBox;
    NGTextEditCheckBox: TCheckBox;
		procedure FormCreate(Sender: TObject);
		procedure FormDestroy(Sender: TObject);
		procedure ApplyButtonClick(Sender: TObject);
		procedure CabinetFontBottonClick(Sender: TObject);
		procedure CabinetColorBottonClick(Sender: TObject);
		procedure EditorFontBottonClick(Sender: TObject);
		procedure OkBottonClick(Sender: TObject);
		procedure ReadProxyCheckClick(Sender: TObject);
		procedure ListFontBottonClick(Sender: TObject);
		procedure ListColorBottonClick(Sender: TObject);
		procedure EditorColorBottonClick(Sender: TObject);
		procedure CabinetDefaultButtonClick(Sender: TObject);
		procedure ReadPortEditExit(Sender: TObject);
		procedure ListDefaultBottonClick(Sender: TObject);
		procedure EditorDefaultBottonClick(Sender: TObject);
		procedure HintFontButtonClick(Sender: TObject);
		procedure HintBackButtonClick(Sender: TObject);
		procedure HintDefaultButtonClick(Sender: TObject);
		procedure LogFolderButtonClick(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure SoundReferButtonClick(Sender: TObject);
		procedure SoundPlayButtonClick(Sender: TObject);
		procedure SoundListViewChanging(Sender: TObject; Item: TListItem;
			Change: TItemChange; var AllowChange: Boolean);
		procedure SoundFileEditChange(Sender: TObject);
		procedure OptionTabChange(Sender: TObject);
		procedure AppFolderButtonClick(Sender: TObject);
		procedure WriteProxyCheckClick(Sender: TObject);
		procedure WritePortEditExit(Sender: TObject);
		procedure Tora3URLLabelClick(Sender: TObject);
		procedure HotKeyEnter(Sender: TObject);
		procedure HotKeyExit(Sender: TObject);
		procedure URLAppCheckBoxClick(Sender: TObject);
		procedure BruwserTabFontButtonClick(Sender: TObject);
		procedure BrowserTabDefaultButtonClick(Sender: TObject);
		procedure AddressHistoryCountEditExit(Sender: TObject);
		procedure PreviewWaitEditExit(Sender: TObject);
		procedure CSSCheckBoxClick(Sender: TObject);		procedure CSSFontButtonClick(Sender: TObject);
		procedure CSSBackColorButtonClick(Sender: TObject);
		procedure CSSFontCheckBoxClick(Sender: TObject);
		procedure CSSBackColorCheckBoxClick(Sender: TObject);
		procedure CSSListViewChange(Sender: TObject; Item: TListItem;
			Change: TItemChange);
		procedure AddURLButtonClick(Sender: TObject);
		procedure RemoveURLButtonClick(Sender: TObject);
                procedure OddResNumCheckBoxClick(Sender: TObject);
                procedure ResRangeHoldCheckBoxClick(Sender: TObject);
                procedure CroutOptionClick(Sender: TObject);
    procedure MaxRecordCountEditExit(Sender: TObject);
    procedure BoukenDelButtonClick(Sender: TObject);
    procedure BoukenComboBoxChange(Sender: TObject);
    procedure BoukenModButtonClick(Sender: TObject);
	private
		{ Private 宣言 }
		FClose: Boolean;
		FRepaintList: Boolean;
		FRepaintThread: Boolean;
		FCSSFont: TFont;
		FCSSBackColor: TColor;
		FCSSStrings: TStringList;
		function GetMemoText(font: TFont; text: string): string;
//		function GetFontText(Font: TFont; Text: string): string;
		procedure SetValue;
		procedure SaveSetting;
		procedure SettingApply;
		function CheckFolder: Boolean;
		procedure SetAbonpropertys;
		procedure CSSSetContent(Content: string);
		procedure CSSPreview;
		//! CSSプレビュー用HTMLBody生成
		function CreatePreviewBody(Res: array of TResRec): string;
		//! CSS/SKINプレビュー用Style文字列取得
		function GetPreviewUserStyle(): string;
	public
		{ Public 宣言 }
	end;

var
	OptionDialog: TOptionDialog;

implementation

uses
	Giko, Editor, Setting, ActnList, KuroutSetting, Math, HTMLCreate;

const
	FONT_TEXT: string = '%s %d pt';
	MEMO_CABINET: string = 'キャビネット';
	MEMO_THREAD: string = 'スレッドリスト';
	MEMO_BROWSERPOPUP: string = 'ブラウザポップアップ';
	MEMO_BROWSERTAB: string = 'ブラウザタブ';
	MEMO_EDITOR: string = 'エディタテキスト';
	DEFAULT_FONT_NAME: string = 'ＭＳ Ｐゴシック';
	DEFAULT_FONT_SIZE: Integer = 9;
	DEFAULT_TABFONT_NAME: string = 'ＭＳ Ｐゴシック';
	DEFAULT_TABFONT_SIZE: Integer = 9;
//	URL_TORA3: WideString = 'http://2ch.tora3.net/';
//	URL_TORA3: WideString = 'https://ronin.bbspink.com/';
	URL_TORA3: WideString = 'https://uplift.5ch.net/';
	DEFAULT_CSS_FILENAME = 'default.css';

{$R *.DFM}

procedure TOptionDialog.FormCreate(Sender: TObject);
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

	CSSBrowser.Navigate('about:blank');
	FClose := True;

	OptionTab.ActivePage := ConnectSheet;
	SetValue;

	CabinetMemo.Text := GetMemoText(CabinetMemo.Font, MEMO_CABINET);
	ListMemo.Text := GetMemoText(ListMemo.Font, MEMO_THREAD);
	HintMemo.Text := GetMemoText(HintMemo.Font, MEMO_BROWSERPOPUP);
	BrowserTabMemo.Text := GetMemoText(BrowserTabMemo.Font, MEMO_BROWSERTAB);
	EditorMemo.Text := GetMemoText(EditorMemo.Font, MEMO_EDITOR);

	Tora3URLLabel.Cursor := 5;
	lblSFont.Caption := '★重要★'#13#10#13#10
										+ 'スレッド表示エリアのフォント変更は、'#13#10
										+ '「CSS とスキン」タブで設定出来ます';

        ForcedLoginLabel.Caption := '- チェックを入れるのはセキュリティ上好ましくありません。' + #13#10
    								        + '　やむを得ない時だけにしてください。';
        CSSCheckBoxClick(Sender);
	BrowserMaxLabel.Caption :=
		'ブラウザが最小化されているときに以下の操作でブラウザを最大化します。'#13#10 +
		'また、ホイールクリックにより最大化をキャンセルすることが出来ます。';

	if OptionTab.PageCount > GikoSys.Setting.OptionDialogTabIndex then begin
		OptionTab.ActivePageIndex := GikoSys.Setting.OptionDialogTabIndex;
		OptionTabChange( nil );
	end;
	
end;

procedure TOptionDialog.FormDestroy(Sender: TObject);
begin
	CSSListView.OnChange := nil;
	if FCSSStrings <> nil then
		FCSSStrings.Free;
	if FCSSFont <> nil then
		FCSSFont.Free;
	sndPlaySound(nil, SND_ASYNC);

end;

procedure TOptionDialog.OkBottonClick(Sender: TObject);
begin
	FClose := True;
	ReadPortEditExit(Sender);
	WritePortEditExit(Sender);
	AddressHistoryCountEditExit(Sender);
    MaxRecordCountEditExit(Sender);
	PreviewWaitEditExit(Sender);

	if not CheckFolder then begin
		FClose := False;
		Exit;
	end;
		SetAbonpropertys;
	SaveSetting;
	SettingApply;

end;

procedure TOptionDialog.ApplyButtonClick(Sender: TObject);
begin
	ReadPortEditExit(Sender);
	WritePortEditExit(Sender);
	AddressHistoryCountEditExit(Sender);
	MaxRecordCountEditExit(Sender);
	PreviewWaitEditExit(Sender);

	if not CheckFolder then begin
		FClose := False;
		Exit;
	end;
        SetAbonpropertys;
	SaveSetting;
	SettingApply;
	FClose := False;
end;

//function TOptionDialog.GetFontText(Font: TFont; Text: string): string;
//begin
//	result := Format(Text, [Font.Name, Font.Size]);
//end;

function TOptionDialog.GetMemoText(font: TFont; text: string): string;
var
	s: string;
begin
	s := '';
	if font <> nil then
		s := Format(FONT_TEXT, [Font.Name, Font.Size]) + #13#10;
	Result := s + text;
end;

//キャビネットフォントボタン
procedure TOptionDialog.CabinetFontBottonClick(Sender: TObject);
begin
	FontDialog.Options := [fdAnsiOnly, fdEffects];
	FontDialog.Font.Assign(CabinetMemo.Font);
	if FontDialog.Execute then begin
		FontDialog.Font.Style := FontDialog.Font.Style - [fsUnderline] - [fsStrikeout];
		CabinetMemo.Font.Assign(FontDialog.Font);
		CabinetMemo.Text := GetMemoText(CabinetMemo.Font, MEMO_CABINET);
		CabinetMemo.Font.Charset := SHIFTJIS_CHARSET;
	end;
end;

//キャビネット背景色ボタン
procedure TOptionDialog.CabinetColorBottonClick(Sender: TObject);
begin
	ColorDialog.Color := CabinetMemo.Color;
	if ColorDialog.Execute then begin
		CabinetMemo.Color := ColorDialog.Color;
	end;
end;

//キャビネットデフォルトボタン
procedure TOptionDialog.CabinetDefaultButtonClick(Sender: TObject);
begin
	CabinetMemo.Font.Name := DEFAULT_FONT_NAME;
	CabinetMemo.Font.Size := DEFAULT_FONT_SIZE;
	CabinetMemo.Font.Color := clWindowText;
	CabinetMemo.Font.Style := [];
	CabinetMemo.Color := clWindow;
	CabinetMemo.Text := GetMemoText(CabinetMemo.Font, MEMO_CABINET);
end;

//スレッドリストフォントボタン
procedure TOptionDialog.ListFontBottonClick(Sender: TObject);
begin
	FontDialog.Options := [fdAnsiOnly, fdEffects];
	FontDialog.Font.Assign(ListMemo.Font);
	if FontDialog.Execute then begin
		ListMemo.Font.Assign(FontDialog.Font);
		ListMemo.Text := GetMemoText(ListMemo.Font, MEMO_THREAD);
		ListMemo.Font.Charset := SHIFTJIS_CHARSET;
	end;
end;

//スレッドリスト背景色ボタン
procedure TOptionDialog.ListColorBottonClick(Sender: TObject);
begin
	ColorDialog.Color := ListMemo.Color;
	if ColorDialog.Execute then begin
		ListMemo.Color := ColorDialog.Color;
	end;
end;

//スレッドリストデフォルトボタン
procedure TOptionDialog.ListDefaultBottonClick(Sender: TObject);
begin
	ListMemo.Font.Name := DEFAULT_FONT_NAME;
	ListMemo.Font.Size := DEFAULT_FONT_SIZE;
	ListMemo.Font.Color := clWindowText;
	ListMemo.Font.Style := [];
	ListMemo.Color := clWindow;
	ListMemo.Text := GetMemoText(ListMemo.Font, MEMO_THREAD);
end;

//ブラウザポップアップフォントボタン
procedure TOptionDialog.HintFontButtonClick(Sender: TObject);
begin
	FontDialog.Options := [fdAnsiOnly, fdEffects];
	FontDialog.Font.Assign(HintMemo.Font);
	if FontDialog.Execute then begin
		HintMemo.Font.Assign(FontDialog.Font);
		HintMemo.Text := GetMemoText(HintMemo.Font, MEMO_BROWSERPOPUP);
		HintMemo.Font.Charset := SHIFTJIS_CHARSET;
	end;
end;

//ブラウザポップアップ背景色ボタン
procedure TOptionDialog.HintBackButtonClick(Sender: TObject);
begin
	ColorDialog.Color := HintMemo.Color;
	if ColorDialog.Execute then begin
		HintMemo.Color := ColorDialog.Color;
	end;
end;

//ブラウザポップアップデフォルトボタン
procedure TOptionDialog.HintDefaultButtonClick(Sender: TObject);
begin
	HintMemo.Font.Name := DEFAULT_FONT_NAME;
	HintMemo.Font.Size := DEFAULT_FONT_SIZE;
	HintMemo.Font.Color := clWindowText;
	HintMemo.Font.Style := [];
	HintMemo.Color := clInfoBk;
	HintMemo.Text := GetMemoText(HintMemo.Font, MEMO_BROWSERPOPUP);
end;

//ブラウザタブフォントボタン
procedure TOptionDialog.BruwserTabFontButtonClick(Sender: TObject);
begin
	FontDialog.Options := [fdAnsiOnly];
	FontDialog.Font.Assign(BrowserTabMemo.Font);
	if FontDialog.Execute then begin
		BrowserTabMemo.Font.Assign(FontDialog.Font);
		BrowserTabMemo.Text := GetMemoText(FontDialog.Font, MEMO_BROWSERTAB);
		BrowserTabMemo.Font.Charset := SHIFTJIS_CHARSET;
	end;
end;

//ブラウザタブデフォルトボタン
procedure TOptionDialog.BrowserTabDefaultButtonClick(Sender: TObject);
begin
	BrowserTabMemo.Font.Name := DEFAULT_TABFONT_NAME;
	BrowserTabMemo.Font.Size := DEFAULT_TABFONT_SIZE;
	BrowserTabMemo.Font.Color := clWindowText;
	BrowserTabMemo.Font.Style := [];
	BrowserTabMemo.Color := clBtnFace;
	BrowserTabMemo.Text := GetMemoText(BrowserTabMemo.Font, MEMO_BROWSERTAB);
end;

//エディタフォントボタン
procedure TOptionDialog.EditorFontBottonClick(Sender: TObject);
begin
	FontDialog.Options := [fdAnsiOnly, fdEffects];
	FontDialog.Font.Assign(EditorMemo.Font);
	if FontDialog.Execute then begin
		EditorMemo.Font.Assign(FontDialog.Font);
		EditorMemo.Text := GetMemoText(EditorMemo.Font, MEMO_EDITOR);
		EditorMemo.Font.Charset := SHIFTJIS_CHARSET;
	end;
end;

//エディタ背景色ボタン
procedure TOptionDialog.EditorColorBottonClick(Sender: TObject);
begin
	ColorDialog.Color := EditorMemo.Font.Color;
	if ColorDialog.Execute then begin
		EditorMemo.Color := ColorDialog.Color;
	end;
end;

//エディタデフォルトボタン
procedure TOptionDialog.EditorDefaultBottonClick(Sender: TObject);
begin
	EditorMemo.Font.Name := DEFAULT_FONT_NAME;
	EditorMemo.Font.Size := DEFAULT_FONT_SIZE;
	EditorMemo.Font.Color := clWindowText;
	EditorMemo.Font.Style := [];
	EditorMemo.Color := clWindow;
	EditorMemo.Text := GetMemoText(EditorMemo.Font, MEMO_EDITOR);
end;

procedure TOptionDialog.SetValue;
var
	i: Integer;
	Item: TListItem;
//	s: string;
	idx: Integer;
	FileList : TStringList;
    DomainList : TStringList;
begin

	//読み込み用プロキシ
	ReadProxyCheck.Checked := GikoSys.Setting.ReadProxy;
	ReadProxyCheckClick(nil);
	ReadProxyAddressEdit.Text := GikoSys.Setting.ReadProxyAddress;
	ReadPortEdit.Text := IntToStr(GikoSys.Setting.ReadProxyPort);
	ReadProxyUserIDEdit.Text := GikoSys.Setting.ReadProxyUserID;
	ReadProxyPasswordEdit.Text := GikoSys.Setting.ReadProxyPassword;
	//書き込み用プロキシ
	WriteProxyCheck.Checked := GikoSys.Setting.WriteProxy;
	WriteProxyCheckClick(nil);
	WriteProxyAddressEdit.Text := GikoSys.Setting.WriteProxyAddress;
	WritePortEdit.Text := IntToStr(GikoSys.Setting.WriteProxyPort);
	WriteProxyUserIDEdit.Text := GikoSys.Setting.WriteProxyUserID;
	WriteProxyPasswordEdit.Text := GikoSys.Setting.WriteProxyPassword;
	//キャビネットフォント
	CabinetMemo.Font.Name := GikoSys.Setting.CabinetFontName;
	CabinetMemo.Font.Size := GikoSys.Setting.CabinetFontSize;
	CabinetMemo.Font.Color := GikoSys.Setting.CabinetFontColor;
	CabinetMemo.Font.Style := [];
	if GikoSys.Setting.CabinetFontBold then
		CabinetMemo.Font.Style := [fsBold];
	if GikoSys.Setting.CabinetFontItalic then
		CabinetMemo.Font.Style := CabinetMemo.Font.Style + [fsItalic];
	CabinetMemo.Color := GikoSys.Setting.CabinetBackColor;

	//スレッドリストフォント
	ListMemo.Font.Name := GikoSys.Setting.ListFontName;
	ListMemo.Font.Size := GikoSys.Setting.ListFontSize;
	ListMemo.Font.Color := GikoSys.Setting.ListFontColor;
	ListMemo.Font.Style := [];
	if GikoSys.Setting.ListFontBold then
		ListMemo.Font.Style := ListMemo.Font.Style + [fsBold];
	if GikoSys.Setting.ListFontItalic then
		ListMemo.Font.Style := ListMemo.Font.Style + [fsItalic];

	ListMemo.Color := GikoSys.Setting.ListBackColor;
	//レス数増減スレ強調表示チェックボックス＆カラーダイアログ
	OddResNumCheckBox.Checked := GikoSys.Setting.UseOddColorOddResNum;
	OddResNumColorBox.Selected := GikoSys.Setting.OddColor;
	OddResNumColorBox.Enabled := OddResNumCheckBox.Checked;
	UnFocusedBoldCheckBox.Checked := GikoSys.Setting.UnFocusedBold;
	UnFocusedBoldCheckBox.Enabled := OddResNumCheckBox.Checked;

	//ブラウザポップアップフォント
	HintMemo.Font.Name := GikoSys.Setting.HintFontName;
	HintMemo.Font.Size := GikoSys.Setting.HintFontSize;
	HintMemo.Font.Color := GikoSys.Setting.HintFontColor;
	HintMemo.Color := GikoSys.Setting.HintBackColor;
	//ブラウザタブフォント
	BrowserTabMemo.Font.Name := GikoSys.Setting.BrowserTabFontName;
	BrowserTabMemo.Font.Size := GikoSys.Setting.BrowserTabFontSize;
	BrowserTabMemo.Font.Style := [];
	if GikoSys.Setting.BrowserTabFontBold then
		BrowserTabMemo.Font.Style := BrowserTabMemo.Font.Style + [fsBold];
	if GikoSys.Setting.BrowserTabFontItalic then
		BrowserTabMemo.Font.Style := BrowserTabMemo.Font.Style + [fsItalic];
	//エディタメモフォント
	EditorMemo.Font.Name := GikoSys.Setting.EditorFontName;
	EditorMemo.Font.Size := GikoSys.Setting.EditorFontSize;
	EditorMemo.Font.Color := GikoSys.Setting.EditorFontColor;
	EditorMemo.Color := GikoSys.Setting.EditorBackColor;
	//CSS表示
	CSSCheckBox.Checked := GikoSys.Setting.UseCSS;
	//かちゅスキン使用
	UseKatjuTypeSkinCheckBox.Checked := GikoSys.Setting.UseKatjushaType;
	if FCSSFont <> nil then
		FCSSFont.Free;
	FCSSFont := TFont.Create;
	if (GikoSys.Setting.BrowserFontName <> '') or
		 (GikoSys.Setting.BrowserFontSize <> 0) or
		 (GikoSys.Setting.BrowserFontBold <> 0) or
		 (GikoSys.Setting.BrowserFontItalic <> 0) or
		 (GikoSys.Setting.BrowserFontColor <> -1 ) then begin
		CSSFontCheckBox.Checked := True;
		FCSSFont.Name := GikoSys.Setting.BrowserFontName;
		FCSSFont.Size := GikoSys.Setting.BrowserFontSize;
		FCSSFont.Style := [];
		if GikoSys.Setting.BrowserFontBold = 1 then
			FCSSFont.Style := FCSSFont.Style + [fsBold];
		if GikoSys.Setting.BrowserFontItalic = 1 then
			FCSSFont.Style := FCSSFont.Style + [fsItalic];
		i := GikoSys.Setting.BrowserFontColor;
		i := (i shr 16) or (i and $ff00) or ((i and $ff) shl 16);
		FCSSFont.Color := i;
	end;
	if GikoSys.Setting.BrowserBackColor <> -1 then begin
		CSSBackColorCheckBox.Checked := True;

		i := GikoSys.Setting.BrowserBackColor;
		i := (i shr 16) or (i and $ff00) or ((i and $ff) shl 16);
		FCSSBackColor := i;
	end;
	//
	//スタイルシートファイル名一覧
	FileList := TStringList.Create;
	try
        FileList.BeginUpdate;
		GikoSys.GetFileList(GikoSys.GetStyleSheetDir, '*.css', FileList, True, True);
        FileList.EndUpdate;
		Idx := Length(GikoSys.GetStyleSheetDir);
		for i := 0 to FileList.Count - 1 do
			FileList[i] := Copy(FileList[i], Idx + 1, Length(FileList[i]));
		FileList.Sort;
		for i := 0 to FileList.Count - 1 do begin
			//s := ExtractFileName(FileList[i]);
			if LowerCase(FileList[i]) = DEFAULT_CSS_FILENAME then
				Item := CSSListView.Items.Insert(0)
			else
				Item := CSSListView.Items.Add;
			Item.Caption := ChangeFileExt(FileList[i], '');
			if LowerCase(FileList[i]) = LowerCase(GikoSys.Setting.CSSFileName) then
				Item.Selected := True;
		end;
	finally
		FileList.Free;
	end;
	//スキンファイル名一覧
	//FileList := TStringList.Create;
	if FCSSStrings <> nil then
		FCSSStrings.Clear;
	FCSSStrings := TStringList.Create;
	try
		GikoSys.GetDirectoryList(GikoSys.GetSkinDir, '*', FCSSStrings, False);

		Idx := Length(GikoSys.GetSkinDir);
		FCSSStrings.Sort;
		for i := 0 to FCSSStrings.Count - 1 do begin
			Item := CSSListView.Items.Add;
			Item.Data := PChar( FCSSStrings[i] );
			Item.Caption := Copy( FCSSStrings[i], Idx + 1, Length(FCSSStrings[i]) );
			if LowerCase(FCSSStrings[i]) = LowerCase(GikoSys.Setting.CSSFileName) then
				Item.Selected := True;
		end;
	finally
	end;

	if (CSSListView.ItemIndex = -1) and (CSSListView.Items.Count > 0) then
		CSSListView.Items[0].Selected := True;

	//Mail欄表示
	ShowMailCheckBox.Checked := GikoSys.Setting.ShowMail;
    //BE2.0アイコン・Emoticonsを画像表示する
    DispImageCheckBox.Checked := GikoSys.Setting.IconImageDisplay;

	// 起動時レス表示範囲の固定
	ResRangeHoldCheckBox.Checked := GikoSys.Setting.ResRangeHold;
	case GikoSys.Setting.ResRange of
	Ord( grrAll ): 	ResRangeHoldComboBox.ItemIndex := 0;
	Ord( grrKoko ):	ResRangeHoldComboBox.ItemIndex := 2;
	Ord( grrNew ): 	ResRangeHoldComboBox.ItemIndex := 3;
	10..65535:						ResRangeHoldComboBox.ItemIndex := 1;
	end;
	ResRangeHoldComboBox.Enabled := GikoSys.Setting.ResRangeHold;
	//タブ追加位置
	TabAddRadioGroup.ItemIndex := Ord(GikoSys.Setting.BrowserTabAppend);
	//板更新URL
	//BoardURL2chEdit.Text := GikoSys.Setting.BoardURL2ch;
		BoardURLComboBox.Clear;
		BoardURLComboBox.Items.AddStrings(GikoSys.Setting.BoardURLs);
		try
			BoardURLComboBox.ItemIndex := GikoSys.Setting.BoardURLSelected - 1;
		except
			BoardURLComboBox.ItemIndex := 0;
		end;
	//認証
	UserIDEdit.Text := GikoSys.Setting.UserID;
	PasswordEdit.Text := GikoSys.Setting.Password;
	AutoLoginCheckBox.Checked := GikoSys.Setting.AutoLogin;
//	ForcedLoginCheckBox.Checked := GikoSys.Setting.ForcedLogin;
	//ログフォルダ
	if GikoSys.Setting.NewLogFolder = '' then
		LogFolderEdit.Text := GikoSys.Setting.LogFolder
	else
		LogFolderEdit.Text := GikoSys.Setting.NewLogFolder;
	//サウンド
	for i := 0 to GikoSys.Setting.GetSoundCount - 1 do begin
		Item := SoundListView.Items.Add;
		Item.Caption := GikoSys.Setting.SoundViewName[i];
		if FileExists(GikoSys.Setting.SoundFileName[i]) then
			Item.SubItems.Add(GikoSys.Setting.SoundFileName[i])
		else
			Item.SubItems.Add('');
	end;
	//URLクリック時動作
	URLAppCheckBox.Checked := GikoSys.Setting.URLApp;
	URLAppCheckBoxClick(nil);
	AppFolderEdit.Text := GikoSys.Setting.URLAppFile;

	//mailtoクリック時動作
	OpenMailerCheckBox.Checked := GikoSys.Setting.OpenMailer;

	//ログ削除時メッセージ
	LogDeleteMessageCheckBox.Checked := GikoSys.Setting.DeleteMsg;
    //同IDレスアンカー表示の制限数越えメッセージ
    IgnoreLimitResCountCheckBox.Checked := GikoSys.Setting.LimitResCountMessage;

	//終了時確認ダイアログ
	ShowDialogForEndCheckBox.Checked := GikoSys.Setting.ShowDialogForEnd;
	//AllTabClose
	AllTabCloseCheckBox.Checked := GikoSys.Setting.ShowDialogForAllTabClose;
	//Samba
	UseSambaCheckBox.Checked := GikoSys.Setting.UseSamba;
	ResAnchorCheckBox.Checked := GikoSys.Setting.ResAnchorJamp;
	// ブラウザ最大化
	BrowserMaxCombo.ItemIndex := Ord( GikoSys.Setting.BrowserAutoMaximize );
	//ポップアップ位置
	case GikoSys.Setting.PopupPosition of
		gppRightTop: 		gppRightTopRB.Checked := True;
		gppRight: 			gppRightRB.Checked := True;
		gppRightBottom:     gppRighBottomRB.Checked := True;
		gppTop: 			gppTopRB.Checked := True;
		gppCenter: 			gppTopRB.Checked := True; // 読み込みで変換してるはず
		gppBottom: 			gppBottomRB.Checked := True;
		gppLeftTop: 		gppLeftTopRB.Checked := True;
		gppLeft: 			gppLeftRB.Checked := True;
		gppLeftBottom:      gppLeftBottomRB.Checked := True;
	end;

	//非アクティブ時ポップアップ表示
	UnActivePopupCheckBox.Checked := GikoSys.Setting.UnActivePopup;
	//レスポップアップボールド表示
	ResPopupBoldCheckBox.Checked := GikoSys.Setting.ResPopupHeaderBold;

	//アドレスバー
	URLDisplayCheckBox.Checked := GikoSys.Setting.URLDisplay;
	TabStopAddressBarCheckBox.Checked := GikoSys.Setting.AddressBarTabStop;
	LinkAddCheckBox.Checked := GikoSys.Setting.LinkAddAddressBar;
	AddressHistoryCountEdit.Text := IntToStr(GikoSys.Setting.AddressHistoryCount);

	//HTMLプレビュー
	PreviewVisibleCheckBox.Checked := GikoSys.Setting.PreviewVisible;
	PreviewWaitEdit.Text := IntToStr(GikoSys.Setting.PreviewWait);
	PreviewSizeComboBox.ItemIndex := 2;
	case GikoSys.Setting.PreviewSize of
		gpsXLarge: PreviewSizeComboBox.ItemIndex := 4;
		gpsLarge: PreviewSizeComboBox.ItemIndex := 3;
		gpsMedium: PreviewSizeComboBox.ItemIndex := 2;
		gpsSmall: PreviewSizeComboBox.ItemIndex := 1;
		gpsXSmall: PreviewSizeComboBox.ItemIndex := 0;
	end;

	//スレッド一覧更新アイコン
	ThreadListIconCheckBox.Checked := GikoSys.Setting.ListIconVisible;
	CreationTimeLogsCheckBox.Checked := GikoSys.Setting.CreationTimeLogs;
	FutureThreadCheckBox.Checked := GikoSys.Setting.FutureThread;
	SelectIntervalEdit.Text := IntToStr(GikoSys.Setting.SelectInterval);

	//dat落ちスレソート順
	case TGikoBoardColumnID( GikoSys.Setting.DatOchiSortIndex ) of
		gbcTitle:
			if GikoSys.Setting.DatOchiSortOrder then
				DatOchiSortCombo.ItemIndex := 1
			else
				DatOchiSortCombo.ItemIndex := 2;
		gbcRoundDate://gbcLastModified:
			if GikoSys.Setting.DatOchiSortOrder then
				DatOchiSortCombo.ItemIndex := 3
			else
				DatOchiSortCombo.ItemIndex := 4;
		gbcCreated:
			if GikoSys.Setting.DatOchiSortOrder then
				DatOchiSortCombo.ItemIndex := 5
			else
				DatOchiSortCombo.ItemIndex := 6;
		gbcLastModified:
			if GikoSys.Setting.DatOchiSortOrder then
				DatOchiSortCombo.ItemIndex := 7
			else
				DatOchiSortCombo.ItemIndex := 8;
	else
		DatOchiSortCombo.ItemIndex := 0;
	end;
	AutoSortCheckBox.Checked := GikoSys.Setting.AutoSortThreadList;
	
	//あぼ～ん
	RloCheckBox.Checked := GikoSys.Setting.AbonDeleterlo;
	ReplaceulCheckBox.Checked := GikoSys.Setting.AbonReplaceul;
	PopUpAbonCheckBox.Checked := GikoSys.Setting.PopUpAbon;
	ShowNGLineCheckBox.Checked := GikoSys.Setting.ShowNGLinesNum;
	AddResAnchorCheckBox.Checked := GikoSys.Setting.AddResAnchor;
	DeleteSyriaCheckBox.Checked := GikoSys.Setting.DeleteSyria;
	IgnoreKanaCheckBox.Checked := GikoSys.Setting.IgnoreKana;
    //NGワード編集
    NGTextEditCheckBox.Checked := GikoSys.Setting.NGTextEditor;
{$IFDEF SPAM_FILTER_ENABLED}
	// スパムフィルタの設定を表示する
	SpamFilterGroupBox.Visible := True;
{$ENDIF}
	// 使用するスパムフィルタ
{$IFDEF DEBUG}
	SpamFilterAlgorithmComboBox.Clear;
	SpamFilterAlgorithmComboBox.AddItem( '使用しない', nil );
	SpamFilterAlgorithmComboBox.AddItem( 'Paul Graham 法', nil );
	SpamFilterAlgorithmComboBox.AddItem( 'Gary Robinson 法', nil );
	SpamFilterAlgorithmComboBox.AddItem( 'Gary Robinson-Fisher 法', nil );
{$ENDIF}
	SpamFilterAlgorithmComboBox.ItemIndex :=
		Ord( GikoSys.Setting.SpamFilterAlgorithm );

	//TabAutoLoad
	TabLoadSave.Checked := Gikosys.Setting.TabAutoLoadSave;
	UseUndecidedCheckBox.Checked := GikoSys.Setting.UseUndecided;

    // レスエディタUnicode入力
    UseUnicodeCB.Checked := Gikosys.Setting.UseUnicode;
    // スレタイ特定文字列除去
    ThreadTitleTrimCheckBox.Checked := GikoSys.Setting.ThreadTitleTrim;

	//Be2ch認証
	BeUserIDEdit.Text := GikoSys.Setting.BeUserID;
	BeCodeEdit.Text := GikoSys.Setting.BePassword;
	BeAutoLoginCheckBox.Checked := GikoSys.Setting.BeAutoLogin;
	//履歴の最大保存数
	MaxRecordCountEdit.Text := IntToStr(GikoSys.Setting.MaxRecordCount);
    // 最小化時にタスクトレイに格納するか
    StoredTaskTrayCB.Checked := GikoSys.Setting.StoredTaskTray;
    // ブラウザタブの移動でループを許可するか
    LoopBrowserTabsCB.Checked := GikoSys.Setting.LoopBrowserTabs;
    //
    IgnoreContextCheckBox.Checked := GikoSys.Setting.GestureIgnoreContext;

    // 冒険の書ドメイン一覧取得
    BoukenComboBox.Text := '';
    BoukenComboBox.Items.Clear;
    DomainList := TStringList.Create;
    GikoSys.GetBoukenDomain(DomainList);
    for i := 0 to DomainList.Count - 1 do begin
        BoukenComboBox.Items.Add( DomainList[i] ) ;
    end;
    DomainList.Free;
    BoukenComboBox.ItemIndex := 0;
    BoukenComboBox.OnChange(nil);
end;

procedure TOptionDialog.SaveSetting;
var
	i: Integer;
	tmp: string;
//	Item: TListItem;
begin
	GikoSys.Setting.OptionDialogTabIndex := OptionTab.TabIndex;

	GikoSys.Setting.ReadProxy := ReadProxyCheck.Checked;
	GikoSys.Setting.ReadProxyAddress := ReadProxyAddressEdit.Text;
	GikoSys.Setting.ReadProxyPort := StrToInt(ReadPortEdit.Text);
	GikoSys.Setting.ReadProxyUserID := ReadProxyUserIDEdit.Text;
	GikoSys.Setting.ReadProxyPassword := ReadProxyPasswordEdit.Text;

	GikoSys.Setting.WriteProxy := WriteProxyCheck.Checked;
	GikoSys.Setting.WriteProxyAddress := WriteProxyAddressEdit.Text;
	GikoSys.Setting.WriteProxyPort := StrToInt(WritePortEdit.Text);
	GikoSys.Setting.WriteProxyUserID := WriteProxyUserIDEdit.Text;
	GikoSys.Setting.WriteProxyPassword := WriteProxyPasswordEdit.Text;

	GikoSys.Setting.CabinetFontName := CabinetMemo.Font.Name;
	GikoSys.Setting.CabinetFontSize := CabinetMemo.Font.Size;
	GikoSys.Setting.CabinetFontColor := CabinetMemo.Font.Color;
	GikoSys.Setting.CabinetFontBold	 := fsBold in CabinetMemo.Font.Style;
	GikoSys.Setting.CabinetFontItalic:= fsItalic in CabinetMemo.Font.Style;
	GikoSys.Setting.CabinetBackColor := CabinetMemo.Color;

	GikoSys.Setting.ListFontName	:= ListMemo.Font.Name;
	GikoSys.Setting.ListFontSize	:= ListMemo.Font.Size;
	GikoSys.Setting.ListFontColor	:= ListMemo.Font.Color;
	GikoSys.Setting.ListFontBold	:= fsBold in ListMemo.Font.Style;
	GikoSys.Setting.ListFontItalic	:= fsItalic in ListMemo.Font.Style;
	GikoSys.Setting.ListBackColor := ListMemo.Color;
	GikoSys.Setting.UseOddColorOddResNum := OddResNumCheckBox.Checked;
	GikoSys.Setting.OddColor := OddResNumColorBox.Selected;
	GikoSys.Setting.UnFocusedBold := (UnFocusedBoldCheckBox.Enabled) and
										(UnFocusedBoldCheckBox.Checked);

	GikoSys.Setting.HintFontName := HintMemo.Font.Name;
	GikoSys.Setting.HintFontSize := HintMemo.Font.Size;
	GikoSys.Setting.HintFontColor := HintMemo.Font.Color;
	GikoSys.Setting.HintBackColor := HintMemo.Color;

	GikoSys.Setting.BrowserTabFontName := BrowserTabMemo.Font.Name;
	GikoSys.Setting.BrowserTabFontSize := BrowserTabMemo.Font.Size;
	GikoSys.Setting.BrowserTabFontBold := fsBold in BrowserTabMemo.Font.Style;
	GikoSys.Setting.BrowserTabFontItalic := fsItalic in BrowserTabMemo.Font.Style;
	GikoSys.Setting.EditorFontName := EditorMemo.Font.Name;
	GikoSys.Setting.EditorFontSize := EditorMemo.Font.Size;
	GikoSys.Setting.EditorFontColor := EditorMemo.Font.Color;
	GikoSys.Setting.EditorBackColor := EditorMemo.Color;
	{FRepaintThread : 表示済みスレッドの再描画が必要かどうか
	設定が変わっていた場合、trueにして既に表示している全ての
	スレッドのRepaintをtrueにする
	}
	//CSS表示
	if GikoSys.Setting.UseCSS <> CSSCheckBox.Checked then FRepaintThread := true;
	GikoSys.Setting.UseCSS := CSSCheckBox.Checked;
	GikoSys.Setting.UseKatjushaType := UseKatjuTypeSkinCheckBox.Checked;
	//CSSファイル名
	tmp := GikoSys.Setting.CSSFileName;
	GikoSys.Setting.CSSFileName := DEFAULT_CSS_FILENAME;
	if CSSListView.Items.Count > 0 then begin
		try
			if CSSListView.Items[CSSListView.ItemIndex].Data <> nil then
				GikoSys.Setting.CSSFileName := string( CSSListView.Items[CSSListView.ItemIndex].data )
			else
				GikoSys.Setting.CSSFileName := CSSListView.Items[CSSListView.ItemIndex].Caption + '.css';
		except
		end;
	end;
	if tmp <> GikoSys.Setting.CSSFileName then FRepaintThread := true;
	// CSS のフォント指定
	if CSSFontCheckBox.Checked then begin
		if GikoSys.Setting.BrowserFontName <> FCSSFont.Name then FRepaintThread := true;
		GikoSys.Setting.BrowserFontName := FCSSFont.Name;
		if GikoSys.Setting.BrowserFontSize <> FCSSFont.Size then FRepaintThread := true;
		GikoSys.Setting.BrowserFontSize := FCSSFont.Size;
		if fsBold in FCSSFont.Style then begin
			if GikoSys.Setting.BrowserFontBold <> 1 then FRepaintThread := true;
			GikoSys.Setting.BrowserFontBold := 1;
		end else begin
			if GikoSys.Setting.BrowserFontBold <> -1 then FRepaintThread := true;
			GikoSys.Setting.BrowserFontBold := -1;
		end;
		if fsItalic in FCSSFont.Style then begin
			if GikoSys.Setting.BrowserFontItalic <> 1 then FRepaintThread := true;
			GikoSys.Setting.BrowserFontItalic := 1;
		end else begin
			if GikoSys.Setting.BrowserFontItalic <> -1 then FRepaintThread := true;
			GikoSys.Setting.BrowserFontItalic := -1;
		end;
		i := ColorToRGB( FCSSFont.Color );
		if (GikoSys.Setting.BrowserFontColor <> (i shr 16) or (i and $ff00) or ((i and $ff) shl 16)) then
			FRepaintThread := true;
		GikoSys.Setting.BrowserFontColor := (i shr 16) or (i and $ff00) or ((i and $ff) shl 16);
	end else begin
		if GikoSys.Setting.BrowserFontName <> '' then FRepaintThread := true;
		GikoSys.Setting.BrowserFontName := '';
		if GikoSys.Setting.BrowserFontSize <> 0 then FRepaintThread := true;
		GikoSys.Setting.BrowserFontSize := 0;
		if GikoSys.Setting.BrowserFontBold <> 0 then FRepaintThread := true;
		GikoSys.Setting.BrowserFontBold := 0;
		if GikoSys.Setting.BrowserFontItalic <> 0 then FRepaintThread := true;
		GikoSys.Setting.BrowserFontItalic := 0;
		if GikoSys.Setting.BrowserFontColor <> -1 then FRepaintThread := true;
		GikoSys.Setting.BrowserFontColor := -1;
	end;
	if CSSBackColorCheckBox.Checked then begin
		i := ColorToRGB( FCSSBackColor );
		if(GikoSys.Setting.BrowserBackColor <> (i shr 16) or (i and $ff00) or ((i and $ff) shl 16)) then
			FRepaintThread := true;
		GikoSys.Setting.BrowserBackColor := (i shr 16) or (i and $ff00) or ((i and $ff) shl 16);
	end else begin
		if GikoSys.Setting.BrowserBackColor <> -1 then FRepaintThread := true;
		GikoSys.Setting.BrowserBackColor := -1;
	end;

	//Mail欄表示
	if GikoSys.Setting.ShowMail <> ShowMailCheckBox.Checked then FRepaintThread := true;
	GikoSys.Setting.ShowMail := ShowMailCheckBox.Checked;
    //BE2.0アイコン・Emoticonsを画像表示する
    GikoSys.Setting.IconImageDisplay := DispImageCheckBox.Checked;
	// 起動時レス表示範囲の固定
	GikoSys.Setting.ResRangeHold := ResRangeHoldCheckBox.Checked;
	case ResRangeHoldComboBox.ItemIndex of
	        0: GikoSys.Setting.ResRange := Ord( grrAll );
	        1: GikoSys.Setting.ResRange := GikoSys.Setting.ResRangeExCount;
	        2: GikoSys.Setting.ResRange := Ord( grrKoko );
	        3: GikoSys.Setting.ResRange := Ord( grrNew );
	end;

	GikoSys.Setting.BrowserTabAppend := TGikoTabAppend(TabAddRadioGroup.ItemIndex);

//	GikoSys.Setting.BoardURL2ch := BoardURL2chEdit.Text;
	GikoSys.Setting.BoardURLs.Clear;
	GikoSys.Setting.BoardURLs.AddStrings(BoardURLComboBox.Items);
	GikoSys.Setting.BoardURLSelected := BoardURLComboBox.ItemIndex + 1;
	GikoSys.Setting.UserID := UserIDEdit.Text;
	GikoSys.Setting.Password := PasswordEdit.Text;
	GikoSys.Setting.AutoLogin := AutoLoginCheckBox.Checked;
//	GikoSys.Setting.ForcedLogin := ForcedLoginCheckBox.Checked;
	GikoSys.Setting.URLApp := URLAppCheckBox.Checked;
	GikoSys.Setting.URLAppFile := AppFolderEdit.Text;

	GikoSys.Setting.OpenMailer := OpenMailerCheckBox.Checked;
	GikoSys.Setting.DeleteMsg := LogDeleteMessageCheckBox.Checked;
    GikoSys.Setting.LimitResCountMessage := IgnoreLimitResCountCheckBox.Checked;

	//終了時確認ダイアログ
	GikoSys.Setting.ShowDialogForEnd := ShowDialogForEndCheckBox.Checked;
	//AllTabClose
	GikoSys.Setting.ShowDialogForAllTabClose := AllTabCloseCheckBox.Checked;
        //Samba
	GikoSys.Setting.UseSamba := UseSambaCheckBox.Checked;
	GikoSys.Setting.ResAnchorJamp := ResAnchorCheckBox.Checked;
	// ブラウザ最大化
	GikoSys.Setting.BrowserAutoMaximize := TGikoBrowserAutoMaximize( BrowserMaxCombo.ItemIndex );
	//ポップアップ位置
    if (gppRightTopRB.Checked) then GikoSys.Setting.PopupPosition := gppRightTop;
    if (gppRightRB.Checked) then GikoSys.Setting.PopupPosition := gppRight;
    if (gppRighBottomRB.Checked) then GikoSys.Setting.PopupPosition := gppRightBottom;
    if (gppTopRB.Checked) then GikoSys.Setting.PopupPosition := gppTop;
    if (gppBottomRB.Checked) then GikoSys.Setting.PopupPosition := gppBottom;
    if (gppLeftTopRB.Checked) then GikoSys.Setting.PopupPosition := gppLeftTop;
    if (gppLeftRB.Checked) then GikoSys.Setting.PopupPosition := gppLeft;
    if (gppLeftBottomRB.Checked) then GikoSys.Setting.PopupPosition := gppLeftBottom;
	//非アクティブ時ポップアップ表示
	GikoSys.Setting.UnActivePopup := UnActivePopupCheckBox.Checked;
	//レスポップアップボールド表示
	GikoSys.Setting.ResPopupHeaderBold := ResPopupBoldCheckBox.Checked;

	//アドレスバー
	GikoSys.Setting.URLDisplay := URLDisplayCheckBox.Checked;
	GikoSys.Setting.AddressBarTabStop := TabStopAddressBarCheckBox.Checked;
	GikoSys.Setting.LinkAddAddressBar := LinkAddCheckBox.Checked;
	if GikoSys.IsNumeric(AddressHistoryCountEdit.Text) then
		GikoSys.Setting.AddressHistoryCount := StrToInt(AddressHistoryCountEdit.Text)
	else
		GikoSys.Setting.AddressHistoryCount := 100;

	//HTMLプレビュー
	GikoSys.Setting.PreviewVisible := PreviewVisibleCheckBox.Checked;
	if GikoSys.IsNumeric(PreviewWaitEdit.Text) then
		GikoSys.Setting.PreviewWait := StrToInt(PreviewWaitEdit.Text)
	else
		GikoSys.Setting.PreviewWait := 500;
	case PreviewSizeComboBox.ItemIndex of
		0: GikoSys.Setting.PreviewSize := gpsXSmall;
		1: GikoSys.Setting.PreviewSize := gpsSmall;
		2: GikoSys.Setting.PreviewSize := gpsMedium;
		3: GikoSys.Setting.PreviewSize := gpsLarge;
		4: GikoSys.Setting.PreviewSize := gpsXLarge;
	end;

	//スレッド一覧更新アイコン
	GikoSys.Setting.ListIconVisible := ThreadListIconCheckBox.Checked;

	GikoSys.Setting.CreationTimeLogs := CreationTimeLogsCheckBox.Checked;
	GikoSys.Setting.FutureThread := FutureThreadCheckBox.Checked;
	if StrToIntDef(SelectIntervalEdit.Text, 110) > 55 then
		GikoSys.Setting.SelectInterval := StrToIntDef(SelectIntervalEdit.Text, 110)
	else
		GikoSys.Setting.SelectInterval := 55;

	//dat落ちスレソート順
	case DatOchiSortCombo.ItemIndex of
		0: GikoSys.Setting.DatOchiSortIndex := -1;	//並び替えしない
		1: begin	//スレ番号(昇順)
			GikoSys.Setting.DatOchiSortOrder := true;
			GikoSys.Setting.DatOchiSortIndex := Ord( gbcTitle );
		   end;
		2: begin	//スレ番号(降順)
			GikoSys.Setting.DatOchiSortOrder := false;
			GikoSys.Setting.DatOchiSortIndex := Ord( gbcTitle );
		   end;
		3: begin	//取得日時(昇順)
			GikoSys.Setting.DatOchiSortOrder := true;
			GikoSys.Setting.DatOchiSortIndex := Ord( gbcRoundDate );{gbcLastModified}
		   end;
		4: begin	//取得日時(降順)
			GikoSys.Setting.DatOchiSortOrder := false;
			GikoSys.Setting.DatOchiSortIndex := Ord( gbcRoundDate );{gbcLastModified}
		   end;
		5: begin	//スレ作成日時(昇順)
			GikoSys.Setting.DatOchiSortOrder := true;
			GikoSys.Setting.DatOchiSortIndex := Ord( gbcCreated );
		   end;
		6: begin	//スレ作成日時(降順)
			GikoSys.Setting.DatOchiSortOrder := false;
			GikoSys.Setting.DatOchiSortIndex := Ord( gbcCreated );
		   end;
		7:	begin  //スレ最終更新日時（昇順）
			GikoSys.Setting.DatOchiSortOrder := true;
			GikoSys.Setting.DatOchiSortIndex := Ord( gbcLastModified );{gbcLastModified}
			end;
		8:	begin  //スレ最終更新日時（降順）
			GikoSys.Setting.DatOchiSortOrder := false;
			GikoSys.Setting.DatOchiSortIndex := Ord( gbcLastModified );{gbcLastModified}
			end;
	end;
	GikoSys.Setting.AutoSortThreadList := AutoSortCheckBox.Checked;

	GikoSys.Setting.WriteSystemSettingFile;
	GikoSys.Setting.WriteBoardURLSettingFile;
//	GikoForm.SetBrowserTabState;

	if LogFolderEdit.Text <> '' then begin
		GikoSys.Setting.NewLogFolder := LogFolderEdit.Text;
		GikoSys.Setting.WriteFolderSettingFile;
	end;

	for i := 0 to SoundListView.Items.Count - 1 do begin
		if FileExists(SoundListView.Items[i].SubItems[0]) then
			GikoSys.Setting.SoundFileName[i] := SoundListView.Items[i].SubItems[0]
		else
			GikoSys.Setting.SoundFileName[i] := '';
	end;

	//あぼ～ん
	GikoSys.Setting.AbonDeleterlo := RloCheckBox.Checked;
	GikoSys.Setting.AbonReplaceul := ReplaceulCheckBox.Checked;
	GikoSys.Setting.PopUpAbon := PopUpAbonCheckBox.Checked;
	GikoSys.Setting.ShowNGLinesNum := ShowNGLineCheckBox.Checked;
	GikoSys.Setting.AddResAnchor := AddResAnchorCheckBox.Checked;
	GikoSys.Setting.DeleteSyria := DeleteSyriaCheckBox.Checked;
	GikoSys.Setting.IgnoreKana := IgnoreKanaCheckBox.Checked;
	GikoSys.FAbon.IgnoreKana := GikoSys.Setting.IgnoreKana;
    //NGワード編集
    GikoSys.Setting.NGTextEditor := NGTextEditCheckBox.Checked;
	// 使用するスパムフィルタ
	if GikoSys.Setting.SpamFilterAlgorithm <> TGikoSpamFilterAlgorithm(
		SpamFilterAlgorithmComboBox.ItemIndex ) then begin
		GikoSys.Setting.SpamFilterAlgorithm := TGikoSpamFilterAlgorithm(
			SpamFilterAlgorithmComboBox.ItemIndex );
		FRepaintThread := True;
	end;

	//Tab自動保存
	GikoSys.Setting.TabAutoLoadSave := TabLoadSave.Checked;
	GikoSys.Setting.UseUndecided := UseUndecidedCheckBox.Checked;
        //Be2ch
        GikoSys.Setting.BeUserID := BeUserIDEdit.Text;
        GikoSys.Setting.BePassword := BeCodeEdit.Text;
		GikoSys.Setting.BeAutoLogin := BeAutoLoginCheckBox.Checked;
	//履歴の最大保存数
	GikoSys.Setting.MaxRecordCount := Max(StrToInt64Def(MaxRecordCountEdit.Text,100),1);
    GikoSys.Setting.StoredTaskTray := StoredTaskTrayCB.Checked;
    GikoSys.Setting.LoopBrowserTabs := LoopBrowserTabsCB.Checked;

    GikoSys.Setting.GestureIgnoreContext := IgnoreContextCheckBox.Checked;

    // レスエディタUnicode入力
    Gikosys.Setting.UseUnicode := UseUnicodeCB.Checked;
    // スレタイ特定文字列除去
    GikoSys.Setting.ThreadTitleTrim := ThreadTitleTrimCheckBox.Checked;

end;

procedure TOptionDialog.SettingApply;
var
	i: Integer;
begin
	GikoForm.TreeViewUC.Items.BeginUpdate;
	GikoForm.FavoriteTreeViewUC.Items.BeginUpdate;
	GikoForm.ListView.Items.BeginUpdate;
	try
		GikoForm.TreeViewUC.Font.Name := GikoSys.Setting.CabinetFontName;
		GikoForm.TreeViewUC.Font.Size := GikoSys.Setting.CabinetFontSize;
		GikoForm.TreeViewUC.Font.Color := GikoSys.Setting.CabinetFontColor;
		GikoForm.TreeViewUC.Color := GikoSys.Setting.CabinetBackColor;

		GikoForm.FavoriteTreeViewUC.Font.Assign(GikoForm.TreeViewUC.Font);
		GikoForm.FavoriteTreeViewUC.Color := GikoSys.Setting.CabinetBackColor;

		GikoForm.ListView.Font.Name := GikoSys.Setting.ListFontName;
		GikoForm.ListView.Font.Size := GikoSys.Setting.ListFontSize;
		GikoForm.ListView.Font.Color := GikoSys.Setting.ListFontColor;
		GikoForm.ListView.Font.Style := [];
		if GikoSys.Setting.ListFontBold then
			GikoForm.ListView.Font.Style := [fsbold];
		if GikoSys.Setting.ListFontItalic then
			GikoForm.ListView.Font.Style := GikoForm.ListView.Font.Style + [fsitalic];

		//GikoForm.ListView.Color := GikoSys.Setting.ListBackColor;
		GikoForm.ListViewBackGroundColor := GikoSys.Setting.ListBackColor;
		GikoForm.UseOddResOddColor := GikoSys.Setting.UseOddColorOddResNum;
		GikoForm.OddColor := GikoSys.Setting.OddColor;
		GikoSys.Setting.UnFocusedBold := (UnFocusedBoldCheckBox.Enabled) and
											(UnFocusedBoldCheckBox.Checked);

		GikoForm.BrowserTabUC.Font.Name := GikoSys.Setting.BrowserTabFontName;
		GikoForm.BrowserTabUC.Font.Size := GikoSys.Setting.BrowserTabFontSize;
		GikoForm.BrowserTabUC.Font.Style := [];
		if GikoSys.Setting.BrowserTabFontBold then
			GikoForm.BrowserTabUC.Font.Style := [fsBold];
		if GikoSys.Setting.BrowserTabFontItalic then
			GikoForm.BrowserTabUC.Font.Style := GikoForm.BrowserTabUC.Font.Style + [fsItalic];
//		GikoForm.BrowserTabUC.Height := (GikoSys.Setting.BrowserTabFontSize * 2) + 1;
//		GikoForm.BrowserBottomPanel.Height := GikoForm.BrowserTabUC.Height;

		for i := 0 to Screen.CustomFormCount - 1 do begin
			if TObject(Screen.CustomForms[i]) is TEditorForm then begin
				TEditorForm(Screen.CustomForms[i]).SetFont;
			end;
		end;

	finally
		GikoForm.TreeViewUC.Items.EndUpdate;
		GikoForm.FavoriteTreeViewUC.Items.EndUpdate;
		GikoForm.ListView.Items.EndUpdate;
	end;

	//アドレスバー
	for i := GikoForm.AddressComboBox.Items.Count - 1 downto 0 do begin
		if GikoSys.Setting.AddressHistoryCount >= GikoForm.AddressComboBox.Items.Count then
			Break;
		GikoForm.AddressComboBox.Items.Delete(i);
	end;
	GikoForm.AddressComboBox.TabStop := GikoSys.Setting.AddressBarTabStop;

	//スレ一覧のリフレッシュ
	if FRepaintList then begin
		// SetActiveListを実行
		GikoForm.ActiveList := GikoForm.ActiveList;
	end;

	// スレッドのリフレッシュ
	if FRepaintThread then begin
		for i := GikoForm.BrowserTabUC.Tabs.Count - 1 downto 0 do begin
			TBrowserRecord(GikoForm.BrowserTabUC.Tabs.Objects[i]).Repaint := true;
		end;
		GikoForm.BrowserTabUC.OnChange(nil);
	end;

    // タブのスレタイ更新
    GikoForm.UpdateThreadTitle;
end;

procedure TOptionDialog.ReadProxyCheckClick(Sender: TObject);
begin
	ReadProxyAddressEdit.Enabled := ReadProxyCheck.Checked;
	ReadPortEdit.Enabled := ReadProxyCheck.Checked;
	ReadProxyUserIDEdit.Enabled := ReadProxyCheck.Checked;
	ReadProxyPasswordEdit.Enabled := ReadProxyCheck.Checked;

	ReadAddressLabel.Enabled := ReadProxyCheck.Checked;
	ReadPortLabel.Enabled := ReadProxyCheck.Checked;
	ReadUserIDLabel.Enabled := ReadProxyCheck.Checked;
	ReadPasswordLabel.Enabled := ReadProxyCheck.Checked;
end;

procedure TOptionDialog.ReadPortEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(ReadPortEdit.Text) then
		ReadPortEdit.Text := '0';
end;

procedure TOptionDialog.LogFolderButtonClick(Sender: TObject);
var
	Root: WideString;
	Dir: string;
begin
	Root := '';
	if SelectDirectory('ログフォルダ選択', Root, Dir) then begin
		LogFolderEdit.Text := Dir;
	end;
end;

function TOptionDialog.CheckFolder: Boolean;
begin
	if Trim(LogFolderEdit.Text) = '' then
		LogFolderEdit.Text := GikoSys.GetAppDir + 'Log';

	if DirectoryExists(LogFolderEdit.Text) then begin
		Result := True;
	end else begin
		if MsgBox(Handle, 'ログフォルダが存在しません。作成しますか？', 'ギコナビ', MB_YESNO or MB_ICONQUESTION) = IDYES	then begin
			//フォルダを作成
			try
				GikoSys.ForceDirectoriesEx(LogFolderEdit.Text);
				Result := True
			except
				MsgBox(Handle, 'ログフォルダの指定が不正です。', 'エラー', MB_OK or MB_ICONSTOP);
				OptionTab.ActivePage := FolderSheet;
				LogFolderEdit.SetFocus;
				Result := False;
			end;
		end else
			Result := False;
	end;
end;

procedure TOptionDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	if not FClose then
		Action := caNone;
	FClose := True;
end;

procedure TOptionDialog.SoundReferButtonClick(Sender: TObject);
begin
	OpenDialog.Filter := 'サウンド (*.wav)|*.wav|すべてのファイル (*.*)|*.*';
	sndPlaySound(nil, SND_ASYNC);
	if OpenDialog.Execute then begin
		SoundFileEdit.Text := OpenDialog.FileName;
        // アプリ配下のファイルの場合相対パスに変換する。
        if (AnsiPos(GikoSys.Setting.GetAppDir,SoundFileEdit.Text) = 1) then begin
            // .\ がつかないので、.\を追加
            SoundFileEdit.Text := '.\' + ExtractRelativePath(
                                      GikoSys.Setting.GetAppDir,
                                      SoundFileEdit.Text);

        end;
	end;
end;

procedure TOptionDialog.SoundPlayButtonClick(Sender: TObject);
var
    s : String;
begin
    SetCurrentDir(GikoSys.Setting.GetAppDir);
    s := ExpandFileName(SoundFileEdit.Text);
	if not FileExists(s) then begin
		MsgBox(Handle, '存在しないファイルです', 'エラー', MB_ICONSTOP or MB_OK);
		SoundFileEdit.Text := '';
		Exit;
	end;
	if not sndPlaySound(PChar(s), SND_ASYNC or SND_NOSTOP) then begin
		sndPlaySound(nil, SND_ASYNC);
	end;
end;

procedure TOptionDialog.SoundListViewChanging(Sender: TObject;
	Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
begin
	if Item.SubItems.Count > 0 then
		SoundFileEdit.Text := Item.SubItems[0];
end;

procedure TOptionDialog.SoundFileEditChange(Sender: TObject);
var
	Item: TListItem;
begin
	sndPlaySound(nil, SND_ASYNC);
	Item := SoundListView.Selected;
	if Item = nil then Exit;

    SetCurrentDir(GikoSys.Setting.GetAppDir);
	if FileExists(ExpandFileName(SoundFileEdit.Text)) then
		Item.SubItems[0] := SoundFileEdit.Text;
	if Trim(SoundFileEdit.Text) = '' then
		Item.SubItems[0] := '';
end;

procedure TOptionDialog.OptionTabChange(Sender: TObject);
begin
	sndPlaySound(nil, SND_ASYNC);

	if OptionTab.ActivePage = CSSTabSheet then
		CSSPreview;
end;

procedure TOptionDialog.AppFolderButtonClick(Sender: TObject);
begin
	OpenDialog.Filter := '実行ファイル (*.exe)|*.exe|すべてのファイル (*.*)|*.*';
	if OpenDialog.Execute then
		AppFolderEdit.Text := OpenDialog.FileName;
end;

procedure TOptionDialog.WriteProxyCheckClick(Sender: TObject);
begin
	WriteProxyAddressEdit.Enabled := WriteProxyCheck.Checked;
	WritePortEdit.Enabled := WriteProxyCheck.Checked;
	WriteProxyUserIDEdit.Enabled := WriteProxyCheck.Checked;
	WriteProxyPasswordEdit.Enabled := WriteProxyCheck.Checked;

	WriteAddressLabel.Enabled := WriteProxyCheck.Checked;
	WritePortLabel.Enabled := WriteProxyCheck.Checked;
	WriteUserIDLabel.Enabled := WriteProxyCheck.Checked;
	WritePasswordLabel.Enabled := WriteProxyCheck.Checked;
end;

procedure TOptionDialog.WritePortEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(WritePortEdit.Text) then
		WritePortEdit.Text := '0';
end;

procedure TOptionDialog.Tora3URLLabelClick(Sender: TObject);
begin
	GikoSys.OpenBrowser(URL_TORA3, gbtAuto);
end;

procedure TOptionDialog.HotKeyEnter(Sender: TObject);
begin
	OkBotton.Default := False;
	CancelBotton.Cancel := False;
end;

procedure TOptionDialog.HotKeyExit(Sender: TObject);
begin
	OkBotton.Default := True;
	CancelBotton.Cancel := True;
end;

procedure TOptionDialog.URLAppCheckBoxClick(Sender: TObject);
begin
	AppFolderLabel.Enabled := URLAppCheckBox.Checked;
	AppFolderEdit.Enabled := URLAppCheckBox.Checked;
	AppFolderButton.Enabled := URLAppCheckBox.Checked;
end;

procedure TOptionDialog.AddressHistoryCountEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(AddressHistoryCountEdit.Text) then
		AddressHistoryCountEdit.Text := '100';
end;

procedure TOptionDialog.PreviewWaitEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(PreviewWaitEdit.Text) then
		PreviewWaitEdit.Text := '500';
	if StrToInt(PreviewWaitEdit.Text) < 500 then
		PreviewWaitEdit.Text := '500';
	if StrToInt(PreviewWaitEdit.Text) > 9999 then
		PreviewWaitEdit.Text := '9999';
end;

procedure TOptionDialog.CSSCheckBoxClick(Sender: TObject);
begin
	CSSListLabel.Enabled := CSSCheckBox.Checked;
	CSSListView.Enabled := CSSCheckBox.Checked;
end;

procedure TOptionDialog.SetAbonpropertys;
begin
        //あぼ～ん
        GikoSys.FAbon.Deleterlo := RloCheckBox.Checked;
        GikoSys.FAbon.Replaceul := ReplaceulCheckBox.Checked;
        GikoSys.FAbon.AbonPopupRes := PopUpAbonCheckBox.Checked;
	GikoSys.FAbon.ReturnNGwordLineNum := ShowNGLineCheckBox.Checked;
	GikoSys.FAbon.SetNGResAnchor := AddResAnchorCheckBox.Checked;
		GikoSys.FAbon.DeleteSyria := DeleteSyriaCheckBox.Checked;
end;
procedure TOptionDialog.CSSFontButtonClick(Sender: TObject);
begin

	FontDialog.Options := [fdAnsiOnly, fdEffects];
	FontDialog.Font.Assign(FCSSFont);
	if FontDialog.Execute then begin
		FontDialog.Font.Style := FontDialog.Font.Style - [fsUnderline] - [fsStrikeout];
		FCSSFont.Assign(FontDialog.Font);
		//FCSSFont := FontDialog.Font;
	end;

	CSSPreview;

end;

procedure TOptionDialog.CSSBackColorButtonClick(Sender: TObject);
begin

	ColorDialog.Color := FCSSBackColor;
	if ColorDialog.Execute then begin
		FCSSBackColor := ColorDialog.Color;
	end;

	CSSPreview;

end;

procedure TOptionDialog.CSSFontCheckBoxClick(Sender: TObject);
begin

	CSSFontButton.Enabled := CSSFontCheckBox.Checked;
	CSSPreview;

end;

procedure TOptionDialog.CSSBackColorCheckBoxClick(Sender: TObject);
begin

	CSSBackColorButton.Enabled := CSSBackColorCheckBox.Checked;
	CSSPreview;

end;

procedure TOptionDialog.CSSSetContent(Content: string);
var
	doc : OleVariant;
begin
	if CSSBrowser.Document <> nil then begin
		doc := CSSBrowser.OleObject.Document;
		doc.open;
        doc.Clear;
		doc.charset := 'Shift_JIS';
		doc.Write(Content);
		doc.Close;
  end;
end;

procedure TOptionDialog.CSSPreview;
var
	Board: TBoard;
	ThreadItem: TThreadItem;
	html: string;
	Res: array [0..1] of TResRec;
	fileName: string;
begin

	fileName := GikoSys.Setting.CSSFileName;

	GikoSys.Setting.CSSFileName := DEFAULT_CSS_FILENAME;
	if CSSListView.Items.Count > 0 then begin
		try
			if CSSListView.ItemIndex >= 0 then begin
				if CSSListView.Items[CSSListView.ItemIndex].Data <> nil then
					GikoSys.Setting.CSSFileName := string( CSSListView.Items[CSSListView.ItemIndex].data )
				else
					GikoSys.Setting.CSSFileName := CSSListView.Items[CSSListView.ItemIndex].Caption + '.css';
						end;
		except
		end;
	end;

	Board := TBoard.Create( nil, 'about://sample/' );
	ThreadItem := TThreadItem.Create( nil, Board, 'about://sample/test/read.cgi/sample/' );

	try
		Board.Title := 'サンプル板';
		ThreadItem.ParentBoard := Board;
		ThreadItem.AllResCount := High( Res );
		ThreadItem.NewResCount := 1;
		ThreadItem.NewReceive := 2;
		ThreadItem.Title := 'サンプルプレビュー';

		Res[0].FName := '名無しさん';
		Res[0].FMailTo := 'sage';
		Res[0].FDateTime := 'ID:Sample';
		Res[0].FBody := 'CSS とスキンのサンプル';
		Res[1].FName := '名無しさん';
		Res[1].FMailTo := 'age';
		Res[1].FDateTime := 'ID:Sample';
		Res[1].FBody := 'オマエモナー';


		if FileExists( GikoSys.GetSkinHeaderFileName ) then begin
			html :=
				HTMLCreater.LoadFromSkin( GikoSys.GetSkinHeaderFileName, ThreadItem, 0 ) +
				'<a name="top"></a>' +
				HTMLCreater.SkinedRes( HTMLCreater.LoadFromSkin( GikoSys.GetSkinResFileName, ThreadItem, 0 ), @Res[0], '1' ) +
				HTMLCreater.SkinedRes( HTMLCreater.LoadFromSkin( GikoSys.GetSkinNewResFileName, ThreadItem, 0 ), @Res[1], '2' ) +
				'<a name="bottom"></a>' +
				HTMLCreater.LoadFromSkin( GikoSys.GetSkinFooterFileName, ThreadItem, 0 );

			html := StringReplace( html, '</head>',
				'<style type="text/css">body {' + GetPreviewUserStyle + '}</style></head>', [rfReplaceAll] );
		end else begin
			html :=
				'<html><head><meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">' +
				'<title>' + ThreadItem.Title + '</title>' +
				'<link rel="stylesheet" href="' + GikoSys.GetStyleSheetDir + GikoSys.Setting.CSSFileName + '" type="text/css">' +
				'<style type="text/css">body {' + GetPreviewUserStyle + '}</style>' +
				'</head><body><div class="title">' + ThreadItem.Title + '</div>';

			html := html + CreatePreviewBody(Res) + '</body></html>';
		end;

		try
			CSSSetContent( html );
		except
		end;

	finally
		ThreadItem.Free;
		Board.Free;
		GikoSys.Setting.CSSFileName := fileName;
	end;

end;
function TOptionDialog.CreatePreviewBody(Res: array of TResRec): string;
var
	i : Integer;
begin
	Result := '';
	for i := 0 to High( Res ) do
	begin
		Result := Result +
			'<div class="header"><span class="no">' + IntToStr( i + 1 ) + '</span>' +
			'<span class="name_label"> 名前： </span>' +
			'<a class="name_mail" href="mailto:' + Res[i].FMailTo + '">' +
			'<b>' + Res[i].FName + '</b></a><span class="mail"> [' + Res[i].FMailTo + ']</span>' +
			'<span class="date_label"> 投稿日：</span>' +
			'<span class="date"> ' + Res[i].FDateTime+ '</span></div>' +
			'<div class="mes">' + Res[i].FBody + ' </div>';
	end;
end;

function TOptionDialog.GetPreviewUserStyle(): string;
var
	i : Integer;

begin
	Result := '';
	// フォントやサイズの設定
	if CSSFontCheckBox.Checked then begin
		i := ColorToRGB( FCSSFont.Color );
		i := (i shr 16) or (i and $ff00) or ((i and $ff) shl 16);

		Result := Result +
			'font-family:"' + FCSSFont.Name + '";' +
			'font-size:' + IntToStr( FCSSFont.Size ) + 'pt;' +
			'color:#' + IntToHex( i, 6 ) + ';';
		if fsBold in FCSSFont.Style then
			Result := Result + 'font-weight:bold;'
		else
			Result := Result + 'font-weight:normal;';
		if fsItalic in FCSSFont.Style then
			Result := Result + 'font-style:italic;'
		else
			Result := Result + 'font-style:normal;';
	end;
	if CSSBackColorCheckBox.Checked then begin
		i := ColorToRGB( FCSSBackColor );
		i := (i shr 16) or (i and $ff00) or ((i and $ff) shl 16);

		Result := Result +
			'background-color:#' + IntToHex( i, 6 ) + ';';
	end;

end;
procedure TOptionDialog.CSSListViewChange(Sender: TObject; Item: TListItem;
	Change: TItemChange);
begin

	if OptionTab.ActivePage = CSSTabSheet then
		CSSPreview;

end;

procedure TOptionDialog.AddURLButtonClick(Sender: TObject);
begin
	BoardURLComboBox.Items.Append(BoardURLComboBox.Text);
  BoardURLComboBox.ItemIndex := BoardURLComboBox.Items.Count - 1;
end;

procedure TOptionDialog.RemoveURLButtonClick(Sender: TObject);
begin
	BoardURLComboBox.DeleteSelected;
end;

procedure TOptionDialog.OddResNumCheckBoxClick(Sender: TObject);
begin
	OddResNumColorBox.Enabled := OddResNumCheckBox.Checked;
	UnFocusedBoldCheckBox.Enabled := OddResNumCheckBox.Checked;
end;

procedure TOptionDialog.ResRangeHoldCheckBoxClick(Sender: TObject);
begin
	ResRangeHoldComboBox.Enabled := ResRangeHoldCheckBox.Checked;
end;

procedure TOptionDialog.CroutOptionClick(Sender: TObject);
var
	KuroutOption: TKuroutOption;
begin
	KuroutOption := TKuroutOption.Create(Self);
	try
		KuroutOption.ShowModal;
	finally
		KuroutOption.Release;
	end;
end;

procedure TOptionDialog.MaxRecordCountEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(MaxRecordCountEdit.Text) then
		MaxRecordCountEdit.Text := '100'
	else if StrToIntDef(MaxRecordCountEdit.Text, 100) <= 0 then
        MaxRecordCountEdit.Text := '1';
end;

procedure TOptionDialog.BoukenDelButtonClick(Sender: TObject);
begin
    if ( BoukenComboBox.Items.IndexOf( BoukenComboBox.Text ) <> -1 ) then begin
        if MsgBox(Self.Handle, BoukenComboBox.Text + ' を削除します。'#13#10 +
            '削除すると復元できません。よろしいですか？', '忍法帖　ドメイン削除', MB_YESNO or MB_ICONQUESTION) = IDYES	then begin
            GikoSys.DelBoukenCookie(BoukenComboBox.Text);
            GikoSys.Setting.WriteBoukenSettingFile;
            BoukenComboBox.Items.Delete(BoukenComboBox.ItemIndex);
            if ( BoukenComboBox.Items.Count = 0 ) then begin
                 BoukenComboBox.Text := '';
            end;
            BoukenComboBox.OnChange(nil);
        end
    end else begin
        BoukenComboBox.Text := '';
    end;
end;

procedure TOptionDialog.BoukenComboBoxChange(Sender: TObject);
begin
    BoukenEdit.Text := GikoSys.GetBoukenCookie('http://*' +BoukenComboBox.Text);
end;

procedure TOptionDialog.BoukenModButtonClick(Sender: TObject);
var
    DomainList : TStringList;
    i : Integer;
    s : String;
begin
    if ( Length(BoukenComboBox.Text) > 0 ) then begin
        s := BoukenComboBox.Text;
        GikoSys.SetBoukenCookie(BoukenEdit.Text, s);
        GikoSys.Setting.WriteBoukenSettingFile;
        // 冒険の書ドメイン一覧取得
        BoukenComboBox.Text := '';
        BoukenComboBox.Items.Clear;
        DomainList := TStringList.Create;
        GikoSys.GetBoukenDomain(DomainList);
        for i := 0 to DomainList.Count - 1 do begin
            BoukenComboBox.Items.Add( DomainList[i] ) ;
        end;
        DomainList.Free;
        BoukenComboBox.ItemIndex := 0;
        for i := 0 to BoukenComboBox.Items.Count - 1 do begin
            if ( BoukenComboBox.Items[i] = s) then begin
                BoukenComboBox.ItemIndex := i;
                Break;
            end;
        end;
        BoukenComboBox.OnChange(nil);
    end;
end;

end.

