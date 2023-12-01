unit Editor;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Math,
	Dialogs, StdCtrls, ComCtrls, ExtCtrls, ToolWin, Menus, OleCtrls, Registry,
{$IF Defined(DELPRO) }
//	SHDocVw,
	MSHTML,
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB,
{$IFEND}
	ActiveX, {HTTPApp,} YofUtils, IniFiles, StrUtils,
	GikoSystem, GikoUtil, ImgList, Clipbrd, BoardGroup,
	IdAntiFreezeBase,	IdAntiFreeze, IdBaseComponent, IdComponent,
	IdTCPConnection, IdTCPClient, IdHTTP, ActnList, StdActns, IdIntercept,
	IdLogBase, IdLogDebug, IdException, DateUtils,  bmRegExp,
	IdGlobal, IdStack, IdExceptionCore, IdGlobalProtocols, IndyModule,   // for Indy10
	Gesture, AppEvnts, SambaTimer, IdCookieManager, WideCtrls, SHDocVw, IdIOHandler,
	IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdURI, TntForms;

type
//	TSetLayeredWindowAttributes = function(wnd: HWND; crKey: DWORD; bAlpha: BYTE; dwFlag: DWORD): Boolean; stdcall;
	//�������ݖ߂�l�^�C�v
	TGikoResultType = (grtOK, grtCookie, grtCheck, grtError, grtNinpou, grtNinpouErr, grtSuiton);

	TEditorForm = class(TTntForm)
		MainMenu: TMainMenu;
		FileMenu: TMenuItem;
		PostMessage: TMenuItem;
		SaveMessage: TMenuItem;
		CloseMenu: TMenuItem;
		N01: TMenuItem;
		StatusBar: TStatusBar;
		EditorPage: TPageControl;
		EditorTab: TTabSheet;
		PreviewTab: TTabSheet;
		Browser: TWebBrowser;
		EditMenu: TMenuItem;
		UndoMenu: TMenuItem;
		CutMenu: TMenuItem;
		CopyMenu: TMenuItem;
		PasteMenu: TMenuItem;
		N02: TMenuItem;
		ToolBarImageList: TImageList;
		HotToobarImageList: TImageList;
		NameBasePanel: TPanel;
		NameLabel: TLabel;
		MailLabel: TLabel;
		NameComboBox: TComboBox;
		MailComboBox: TComboBox;
		ToolBar: TToolBar;
		SendToolButton: TToolButton;
		OutBoxToolButton: TToolButton;
		ToolButton5: TToolButton;
		UndoToolButton: TToolButton;
		CutToolButton: TToolButton;
		CopyToolButton: TToolButton;
		PasteToolButton: TToolButton;
		ToolButton3: TToolButton;
		TransToolButton: TToolButton;
		TopToolButton: TToolButton;
		Indy: TIdHTTP;
		ToolButton1: TToolButton;
		ToolButton2: TToolButton;
		ActionList: TActionList;
		SendAction: TAction;
		SaveAction: TAction;
		CloseAction: TAction;
		UndoAction: TAction;
		CutAction: TAction;
		CopyAction: TAction;
		PasteAction: TAction;
		AbortAction: TAction;
		TopAction: TAction;
		Show1: TMenuItem;
		T1: TMenuItem;
		N1: TMenuItem;
		S1: TMenuItem;
		SageCheckBox: TCheckBox;
		IdLogDebug: TIdLogDebug;
		TransAction: TAction;
		A1: TMenuItem;
		KotehanCheckBox: TCheckBox;
		TitlePanel: TPanel;
		TitleLabel: TLabel;
		TitleEdit: TEdit;
		SelectAllAction: TAction;
		N2: TMenuItem;
		SelectAll1: TMenuItem;
		QuotePasteAction: TAction;
		QuotePasteMenuItem: TMenuItem;
		C1: TMenuItem;
		SpaceToNBSPAction: TAction;
		AmpToCharRefAction: TAction;
		SpaceTabnbsp1: TMenuItem;
		amp1: TMenuItem;
		BoardInformationTab: TTabSheet;
		BoardtopTab: TTabSheet;
		TitlePictureBrowser: TWebBrowser;
		BoardTop: TMenuItem;
		BoardInformationMemo: TMemo;
		GetSETTINGTXTAction: TAction;
		N3: TMenuItem;
		SETTINGTXT2: TMenuItem;
		GetTitlePictureAction: TAction;
		OP1: TMenuItem;
		GetHeadTXTAction: TAction;
		HeadTXT1: TMenuItem;
		RocalRuleTab: TTabSheet;
		WebBrowser1: TWebBrowser;
		CalcCapacityAction: TAction;
		N4: TMenuItem;
		N5: TMenuItem;
		LocalRule: TMenuItem;
		LocalEdit: TMemo;
		N6: TMenuItem;
		LocalRuleBrowse: TMenuItem;
		ToolButton4: TToolButton;
		ToolButton6: TToolButton;
		SaveNameMailAction: TAction;
		ToolButton7: TToolButton;
		BeLogInOutEAction: TAction;
		UpdateSambaAction: TAction;
		Samba241: TMenuItem;
		N7: TMenuItem;
		InputAssistAction: TAction;
		InputAssistPopupMenu: TPopupMenu;
		ApplicationEvents1: TApplicationEvents;
		ToolButton8: TToolButton;
		ToolButton9: TToolButton;
		ShowInputAssistForm: TAction;
		ReleaseCookieAction: TAction;
		Cookie1: TMenuItem;
		ContinueModeAction: TAction;
		ToolButton10: TToolButton;
		ToolButton11: TToolButton;
		OpenSendTargetAction: TAction;
		ReloadTargetAction: TAction;
		N8: TMenuItem;
		N9: TMenuItem;
		N10: TMenuItem;
		UCInfoPanel: TPanel;
		BodyEdit: TMemo;
		IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;

		procedure EditorPageChange(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure BrowserStatusTextChange(Sender: TObject;
			const Text: WideString);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormDestroy(Sender: TObject);
		procedure SendActionExecute(Sender: TObject);
		procedure SaveActionExecute(Sender: TObject);
		procedure AbortActionExecute(Sender: TObject);
		procedure CloseActionExecute(Sender: TObject);
		procedure UndoActionExecute(Sender: TObject);
		procedure CutActionExecute(Sender: TObject);
		procedure CopyActionExecute(Sender: TObject);
		procedure PasteActionExecute(Sender: TObject);
		procedure SendActionUpdate(Sender: TObject);
		procedure SaveActionUpdate(Sender: TObject);
		procedure CloseActionUpdate(Sender: TObject);
		procedure UndoActionUpdate(Sender: TObject);
		procedure CutActionUpdate(Sender: TObject);
		procedure CopyActionUpdate(Sender: TObject);
		procedure PasteActionUpdate(Sender: TObject);
		procedure TopActionExecute(Sender: TObject);
		procedure TopActionUpdate(Sender: TObject);
		procedure SageCheckBoxClick(Sender: TObject);
		procedure MailComboBoxChange(Sender: TObject);
		procedure TransActionExecute(Sender: TObject);
		procedure TransActionUpdate(Sender: TObject);
		procedure SelectAllActionExecute(Sender: TObject);
		procedure StatusBarResize(Sender: TObject);
		procedure FormActivate(Sender: TObject);
		procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure QuotePasteActionExecute(Sender: TObject);
		procedure SpaceToNBSPActionExecute(Sender: TObject);
		procedure AmpToCharRefActionExecute(Sender: TObject);
		procedure BoardTopClick(Sender: TObject);
		procedure GetSETTINGTXTActionExecute(Sender: TObject);
		procedure GetTitlePictureActionUpdate(Sender: TObject);
		procedure GetTitlePictureActionExecute(Sender: TObject);
		procedure GetHeadTXTActionExecute(Sender: TObject);
		procedure CalcCapacityActionExecute(Sender: TObject);
		procedure LocalRuleClick(Sender: TObject);
		procedure FormDeactivate(Sender: TObject);
		procedure LocalRuleBrowseClick(Sender: TObject);
		procedure SaveNameMailActionExecute(Sender: TObject);
		procedure BeLogInOutEActionExecute(Sender: TObject);
		procedure BeLogInOutEActionUpdate(Sender: TObject);
		procedure UpdateSambaActionUpdate(Sender: TObject);
		procedure UpdateSambaActionExecute(Sender: TObject);
		procedure InputAssistActionExecute(Sender: TObject);
		procedure ApplicationEvents1Message(var Msg: tagMSG;
			var Handled: Boolean);
		procedure ShowInputAssistFormExecute(Sender: TObject);
		procedure ReleaseCookieActionExecute(Sender: TObject);
		procedure GetSETTINGTXTActionUpdate(Sender: TObject);
		procedure GetHeadTXTActionUpdate(Sender: TObject);
		procedure ContinueModeActionExecute(Sender: TObject);
		procedure ContinueModeActionUpdate(Sender: TObject);
		procedure OpenSendTargetActionExecute(Sender: TObject);
		procedure ReloadTargetActionExecute(Sender: TObject);
		procedure IdLogDebugReceive(ASender: TIdConnectionIntercept;
			var ABuffer: TIdBytes);
		procedure IdLogDebugSend(ASender: TIdConnectionIntercept;
			var ABuffer: TIdBytes);
	private
		FThreadItem: TThreadItem;
		FBoard: TBoard;
		FNameComboEdit: THandle;
		FMailComboEdit: THandle;
		FAbort: Boolean;
		FWork: Boolean;
		FStatusCode: Integer;
		FDebugStrReceive: string;
		FDebugStrSend: string;
		FNow: TDateTime;
		FInputAssistKey: String;	///< ���̓A�V�X�g�̃L�[
		FResistWords: TStringList;	///< ���̓A�V�X�g�̎�������̌�������
		FSambaTimer: TSambaTimer;   ///< Samba�΍�̃^�C�}�[
		FCookieDomain: string;        ///< �E�@���h���C��
		FUseUC: Boolean;
		BodyEditUC: TWideMemo;
		TitleEditUC: TWideEdit;
		NameComboBoxUC: TWideComboBox;
		MailComboBoxUC: TWideComboBox;
		FURI: TIdURI;
		procedure Preview;
		procedure Preview2;
    procedure TrimLinkFromHtml(var html: String);
    procedure SetBodyClass(var html: String; attrClass: String);
		function Check: Boolean;
		procedure SetNameList(sName, sMail: string);
		procedure Send(const ACOOKIE: string; const SPID: string; const PON: string; FirstWriting: Boolean);
		function GetActiveControlHandle: THandle;
		procedure GetSendData(Source: TStringStream; EncUTF8: Boolean; AddCRLF: Boolean);
		procedure SaveSendFile;
		procedure SetContent(Content: string; ABrowser: TWebBrowser);
		function GetResultType(ResponseText: string): TGikoResultType;
		/// �{���̎擾
		function GetBody : string;
		function GetBodyUTF8: UTF8String;
		procedure ShowBoardInformation(ABoard: TBoard; AMemo: TMemo);
		function GetTitlePictureURL(body: TStringList; ABoard: TBoard): string;
		procedure ShowTitlePicture();
		function GetFusianaName(body: TStringList; ABoard: TBoard): String;
		//! �}�E�X�W�F�X�`���[�J�n
		procedure OnGestureStart(Sender: TObject);
		//! �}�E�X�W�F�X�`���[��
		procedure OnGestureMove(Sender: TObject);
		//! �}�E�X�W�F�X�`���[�I��
		procedure OnGestureEnd(Sender: TObject);
		//HEAD.TXT�����\��
		procedure ShowBoardHead(ABoard: TBoard; AMemo: TMemo);
		//LocalFusianaTrapAlart
		function LFusianaGet(const s: String): Boolean;
		// Cookie�̎擾
		procedure GetCookie(CookieMng: TIdCookieManager; ABoard: TBoard);
		// hidden�f�[�^�擾
		procedure GetHiddenParameter(Rawtext: String; ABoard: TBoard);
		//! ���̓A�V�X�g�̃|�b�v�A�b�v���j���[�̃N���b�N�C�x���g
		procedure InputAssistMenuClick(Sender: TObject);
		//! TMemo�̃J�[�\���ʒu�ɕ�����}��
		procedure InsertText(Memo: TMemo; Text: String);
		//! ���M���~
		procedure CancelSend(ABoard: TBoard; ASysMenu: HMENU);
		//! Samba�^�C�}�[�C�x���g
		procedure SambaTimer(Sender: TObject);
		//! �E�B���h�E�̈ʒu�ƃT�C�Y�̐ݒ�
		procedure SetWindowRect;
		//! �g���^�u�ݒ�
		procedure SetExtraTab;
		//! �擾
		function GetBoard : TBoard;
		//! URL�̃f�[�^��stream�Ɏ�荞��
		procedure GetWebData(const URL: string; const RefURL: string;
			Modified: TDateTime; stream: TStream);
		//! GikoForm�ɐV�����b�Z�[�W��ǉ�����
		procedure AddFormMessageNew(icon: TGikoMessageIcon);
		//! ���[�J��fusiana�g���b�v
		function isLocalFusianaTrap: Boolean;
		//! ���[�J��fusiana�g���b�v
		function isRemoteFusianaTrap: Boolean;
		//! Header������擾
		function getHeaderStr(const ACOOKIE: string; const SPID : string;
			const PON : string; const HAP : string; Board : TBoard) : string;
		//! fusiana�x���_�C�A���O
		function FusianaMsgBox: Integer;
		//! sent.ini�t�@�C���̐���
		function CreateSentIniFile: TMemIniFile;
		//! �딚�`�F�b�N
		function isGobaku: Boolean;
		//! �{��������擾
		function GetBodyText(): String;
		//! TWideEdit������
		procedure InitWideEdit;
		//! TWideComboBox������
		procedure InitWideComboBox(WideCombo: TWideComboBox; AnsiCombo: TComboBox);
		//! ���O������擾
		function GetNameText: String;
		function GetNameUTF8: UTF8String;
		//! ���O������ݒ�
		procedure SetNameText(Value: String);
		//! ���[��������擾
		function GetMailText: String;
		function GetMailUTF8: UTF8String;
		//! ���[��������ݒ�
		procedure SetMailText(Value: String);
		//! �^�C�g��������擾
		function GetTitleText: String;
		function GetTitleUTF8: UTF8String;
	protected
		procedure CreateParams(var Params: TCreateParams); override;
	public
		FBBSID: String;
		procedure SetFont;
		procedure SetThreadItem(Item: TThreadItem);
		procedure SetBoard(Item: TBoard);
		procedure UpdateSambaStatus;
		procedure SetFocusEdit;
		procedure SetTextEdit(TextSrc: String);
		property BBSID: string read FBBSID write FBBSID;
	end;

//{$IFDEF DEBUG}
//procedure DebugLog(msg: String);
//{$ENDIF}

implementation

uses
	Giko, ItemDownload, MojuUtils, GikoMessage,  Imm,
	InputAssistDataModule, InputAssist, HTMLCreate, IdCookie, GikoDataModule,
	Belib, DmSession5ch;
const
	CAPTION_NAME_NEW: string = '�M�R�i�r �X�����ăG�f�B�^';
	CAPTION_NAME_RES: string = '�M�R�i�r ���X�G�f�B�^';

	// �G�f�B�b�g�E�B���h�E���E���ɂ��炵�ĊJ���ړ���
	WINDOWMOVE_H = 30;
	WINDOWMOVE_V = 30;

	//DAX����ض��!(�L���M)
	READCGI_ERR		 	= '-ERR';
	READCGI_INCR		= '-INCR';
	READCGI_OK			= '+OK';
	READCGI_PARTIAL = '+PARTIAL';
	READCGI_ERR_FOUND_KAKO	= '-ERR �ߋ����O�q�ɂŔ���';
	READCGI_ERR_NOT_HTML		= '-ERR html���҂�';
	READCGI_ERR_NOT_FOUND	 	= '-ERR ����Ȕ�or�X���b�h�Ȃ��ł��B';
	READCGI_ERR_ABONE			 	= '-ERR �ǂ����ł��ځ[�񂪂������݂����ł��B';
	READCGI_ERR_TIMEOUT		 	= '-ERR �w�莞�Ԃ��߂��܂����B';
	READCGI_ERR_CANTUSE		 	= '-ERR �����@�����܂���';
	RES2CH_TRUE			 	= '<!-- 2ch_X:true -->';
	RES2CH_FALSE			= '<!-- 2ch_X:false -->';
	RES2CH_ERROR			= '<!-- 2ch_X:error -->';
	RES2CH_CHECK			= '<!-- 2ch_X:check -->';
	RES2CH_COOKIE		 	= '<!-- 2ch_X:cookie -->';

type
	TSelection = record
		StartPos, EndPos: Integer;
	end;

{$R *.DFM}

{constructor TEditorForm.Create(AOwner: TComponent; Item: TBoard);
begin
	inherited Create(AOwner);
end;}

procedure TEditorForm.CreateParams(var Params: TCreateParams);
begin
	inherited;
	if FormStyle in [fsNormal, fsStayOnTop] then
		if BorderStyle in [bsSingle, bsSizeable] then begin
			Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
			Params.WndParent := 0;
		end;
end;

{procedure TEditorForm.CreateParams(var Params: TCreateParams);
begin
	inherited CreateParams(Params);
	Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;}

procedure TEditorForm.FormCreate(Sender: TObject);
begin
	FURI := TIdURI.Create;
	FUseUC := GikoSys.Setting.UseUnicode;

	BodyEditUC := TWideMemo.Create(Self);
	BodyEditUC.Parent := EditorTab;
	BodyEditUC.Align := alClient;
	BodyEditUC.ScrollBars := ssBoth;

	TitleEditUC := TWideEdit.Create(Self);
	InitWideEdit;
	NameComboBoxUC := TWideComboBox.Create(Self);
	InitWideComboBox(NameComboBoxUC, NameComboBox);
	MailComboBoxUC := TWideComboBox.Create(Self);
	InitWideComboBox(MailComboBoxUC, MailComboBox);
	MailComboBoxUC.OnChange := MailComboBoxChange;

	BodyEditUC.Visible     := FUseUC;
	NameComboBoxUC.Visible := FUseUC;
	MailComboBoxUC.Visible := FUseUC;

	BodyEdit.Visible     := not FUseUC;
	NameComboBox.Visible := not FUseUC;
	MailComboBox.Visible := not FUseUC;

	FWork := False;
	FSambaTimer := TSambaTimer.Create(Self);
	FSambaTimer.Interval := 0;
	Browser.Navigate('about:blank');
	TitlePictureBrowser.Navigate('about:blank');
	WebBrowser1.Navigate('about:blank');
	FBoard := nil;
	FThreadItem := nil;

	if (Owner <> nil) and (Owner.ClassNameIs('TKeySettingForm') = False) then
		//�E�B���h�E�̈ʒu�ݒ�
		SetWindowRect;

	EditorPage.ActivePage := EditorTab;
	if FUseUC then begin
		EditorTab.Caption := EditorTab.Caption + '(Unicode���[�h)';
		FNameComboEdit := GetWindow(NameComboBoxUC.Handle, GW_CHILD);
		FMailComboEdit := GetWindow(MailComboBoxUC.Handle, GW_CHILD);
		NameComboBoxUC.Items_Assign(GikoSys.Setting.NameList);
		MailComboBoxUC.Items_Assign(GikoSys.Setting.MailList);
		TitleLabel.FocusControl := TitleEdit;
		NameLabel.FocusControl  := NameComboBox;
		MailLabel.FocusControl  := MailComboBox;
	end else begin
		EditorTab.Caption := EditorTab.Caption + '(Shift-JIS���[�h)';
		FNameComboEdit := GetWindow(NameComboBox.Handle, GW_CHILD);
		FMailComboEdit := GetWindow(MailComboBox.Handle, GW_CHILD);
		NameComboBox.Items.Assign(GikoSys.Setting.NameList);
		MailComboBox.Items.Assign(GikoSys.Setting.MailList);
	end;
	SetFont;
	// ���������p�\�ݒ�
	TransAction.Enabled := GikoSys.CanUser32DLL;

	// �E�B���h�E�̃X�e�C���
	if GikoSys.Setting.EditWindowStay then begin    // �X�e�C���
		SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
		TopAction.Checked := true;
		TopToolButton.Down := true;
	end else begin                                  // �X�e�C���Ȃ�
		SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
		TopAction.Checked := false;
		TopToolButton.Down := false;
	end;

	// �E�B���h�E�̔��������
	if(GikoSys.Setting.EditWindowTranslucent) and (TransAction.Enabled) then begin // �������i�g�����X���[�Z���g�j���
		AlphaBlend := true;
		TransAction.Checked := true;
		TransToolButton.Down := true;
	end else begin                                      // �s����
		AlphaBlend := false;
		TransAction.Checked := false;
		TransToolButton.Down := false;
	end;
	// ��������Ԃ̕ۑ�
	GikoSys.Setting.EditWindowTranslucent := TransAction.Checked;

	SpaceToNBSPAction.Checked		:= GikoSys.Setting.SpaceToNBSP;
	AmpToCharRefAction.Checked	:= GikoSys.Setting.AmpToCharRef;
	// ���[�J�����[���{�g�b�v�摜�̃^�u�̐ݒ�
	SetExtraTab;

	// �L�[�ݒ�̓ǂݍ���
	GikoSys.LoadKeySetting(ActionList, GikoSys.GetEditorKeyFileName);
	SaveNameMailAction.Checked := True;
end;

procedure TEditorForm.InitWideEdit;
begin
	TitleEditUC.Parent  := TitleEdit.Parent;
	TitleEditUC.Font    := TitleEdit.Font;
	TitleEditUC.Left    := TitleEdit.Left;
	TitleEditUC.Top     := TitleEdit.Top;
	TitleEditUC.Width   := TitleEdit.Width;
	TitleEditUC.Height  := TitleEdit.Height;
end;

procedure TEditorForm.InitWideComboBox(WideCombo: TWideComboBox; AnsiCombo: TComboBox);
begin
	WideCombo.Parent  := AnsiCombo.Parent;
	WideCombo.Style   := AnsiCombo.Style;
	WideCombo.Font    := AnsiCombo.Font;
	WideCombo.Left    := AnsiCombo.Left;
	WideCombo.Top     := AnsiCombo.Top;
	WideCombo.Width   := AnsiCombo.Width;
	WideCombo.Height  := AnsiCombo.Height;
	WideCombo.DropDownCount := AnsiCombo.DropDownCount;
end;

procedure TEditorForm.SetBoard(Item: TBoard);
begin
	FBoard := Item;
	Caption := EncAnsiToWideString(CAPTION_NAME_NEW + ' - [' + Item.Title + ']');
	SetNameText(FBoard.KotehanName);
	SetMailText(FBoard.KotehanMail);
	SageCheckBox.Checked := AnsiPos('sage', GetMailText) <> 0;
	TitlePanel.Visible := True;

	if (FSambaTimer.SetBoard(FBoard) >= 0) then begin
		UpdateSambaStatus;
		FNow := Now();
		FSambaTimer.OnTimer := SambaTimer;
	end;

	ShowBoardInformation(FBoard, BoardInformationMemo);
	ShowTitlePicture();
end;

procedure TEditorForm.SetThreadItem(Item: TThreadItem);
begin
	FThreadItem := Item;
	Caption := EncAnsiToWideString(CAPTION_NAME_RES + ' - [' + FThreadItem.Title + ']');
	SetNameText(FThreadItem.ParentBoard.KotehanName);
	SetMailText(FThreadItem.ParentBoard.KotehanMail);
	SageCheckBox.Checked := AnsiPos('sage', GetMailText) <> 0;
	TitlePanel.Visible := False;

	if (FSambaTimer.SetBoard(FThreadItem.ParentBoard) >= 0) then begin
		UpdateSambaStatus;
		FNow := Now();
		FSambaTimer.OnTimer := SambaTimer;
	end;

	ShowBoardInformation(FThreadItem.ParentBoard, BoardInformationMemo);
	ShowTitlePicture();
end;

function TEditorForm.GetBody : string;
var
	body, tmp		: string;
	p, tail			: PChar;
	len					: Integer;
const
	TAB_LENGTH	= 4;
begin

	body := GetBodyText;

	if AmpToCharRefAction.Checked then
		// & �̒u���͈�ԍŏ��ɂ�邱��
		body := CustomStringReplace( body, '&', '&amp;' );
	if SpaceToNBSPAction.Checked then begin
		p			:= PChar( body );
		tail	:= p + Length( body );
		len		:= 0;
		while p < tail do begin
			case p^ of
			#09:
				begin
					Inc( p );
					repeat
						Inc( len );
						tmp := tmp + '&nbsp;';
					until (len mod TAB_LENGTH) = 0;
				end;

			#10, #13:
				begin
					tmp := tmp + p^;	Inc( p );
					len	:= 0;
				end;

			' ':
				begin
					tmp	:= tmp + '&nbsp;';
					Inc( p );
					Inc( len );
				end;
				
			'&':
				// ���̎Q�Ƃ� 1 ������
				begin
					tmp := tmp + '&';
					Inc( p );
					Inc( len );
					while p < tail do begin
						if p^ in ['a'..'z', 'A'..'Z', '0'..'9', '#'] then begin
							tmp := tmp + p^;
						end else if p^ = ';' then begin
							tmp := tmp + p^;
							Inc( p );
							Break;
						end else begin
							Break;
						end;
						Inc( p );
					end;
				end;

			else
				if p^ in kYofKanji then begin
					tmp := tmp + p^;	Inc( p );
					tmp	:= tmp + p^;	Inc( p );
					len	:= len + 2;
				end else begin
					tmp := tmp + p^;	Inc( p );
					Inc( len );
				end;
			end;
		end;
		body := tmp;
	end;

	Result	:= body;

end;

function TEditorForm.GetBodyUTF8: UTF8String;
begin
	Result := UTF8Encode(GetBodyText);
end;

procedure TEditorForm.SetFont;
begin
	if (FUseUC = True) then begin
		BodyEditUC.Font.Name := GikoSys.Setting.EditorFontName;
		BodyEditUC.Font.Size := GikoSys.Setting.EditorFontSize;
		BodyEditUC.Font.Color := GikoSys.Setting.EditorFontColor;
		BodyEditUC.Color := GikoSys.Setting.EditorBackColor;
	end else begin
		BodyEdit.Font.Name := GikoSys.Setting.EditorFontName;
		BodyEdit.Font.Size := GikoSys.Setting.EditorFontSize;
		BodyEdit.Font.Color := GikoSys.Setting.EditorFontColor;
		BodyEdit.Color := GikoSys.Setting.EditorBackColor;
	end;
  if GikoSys.Setting.SetBoardInfoStyle then begin
		BoardInformationMemo.Font.Name  := GikoSys.Setting.EditorFontName;
		BoardInformationMemo.Font.Size  := GikoSys.Setting.EditorFontSize;
		BoardInformationMemo.Font.Color := GikoSys.Setting.EditorFontColor;
		BoardInformationMemo.Color      := GikoSys.Setting.EditorBackColor;
  end;
end;

procedure TEditorForm.Preview;
var
	Title: string;
	No: string;
	Mail: string;
	Namae: string;
	Body: string;
	s: string;
begin
	if FThreadItem = nil then begin
		No := '1';
		Title := THTMLCreate.RepHtml(GetTitleText);
	end else begin
		No := IntToStr(FThreadItem.Count + 1);
		Title := THTMLCreate.RepHtml(FThreadItem.Title);
	end;

	Body := GetBody;
	Namae := THTMLCreate.RepHtml(GetNameText);
	Mail := THTMLCreate.RepHtml(GetMailText);
	Body := THTMLCreate.RepHtml(Body);
	Body := CustomStringReplace(Body, #13#10, '<br>', False);


	if Trim(Namae) = '' then
		Namae := '����������';

	s := THTMLCreate.CreatePreviewHTML(Title, No, Mail, Namae, Body);

	SetContent(s, Browser);
end;

//�@�X�^�C���V�[�g�^�X�L����K�p�����v���r���[�\��
procedure TEditorForm.Preview2;
const
  TYPE_DEF  = 0;	// �f�t�H���g
  TYPE_SKIN = 1;	// �X�L���g�p
  TYPE_CSS  = 2;	// CSS�g�p
	// CSS�p���X�t�H�[�}�b�g�i���[���Ȃ��j
	FORMAT_NOMAIL  = '<a name="%s"></a><div class="header"><span class="no"><a href="javascript:void(0);">%s</a></span>'
					+ '<span class="name_label"> ���O�F </span> <span class="name"><b>%s</b></span>'
					+ '<span class="date_label"> ���e���F</span> <span class="date">%s</span></div>'
					+ '<div class="mes">%s</div>';
	// CSS�p���X�t�H�[�}�b�g�i���[������E�\���j
	FORMAT_SHOWMAIL = '<a name="%s"></a><div class="header"><span class="no"><a href="javascript:void(0);">%s</a></span>'
					+ '<span class="name_label"> ���O�F </span><a class="name_mail" href="javascript:void(0);">'
					+ '<b>%s</b></a><span class="mail"> [%s]</span><span class="date_label"> ���e���F</span>'
					+ '<span class="date"> %s</span></div><div class="mes">%s</div>';
	// CSS�p���X�t�H�[�}�b�g�i���[������E��\���j
	FORMAT_NOSHOW = '<a name="%s"></a><div class="header"><span class="no"><a href="javascript:void(0);">%s</a></span>'
					+ '<span class="name_label"> ���O�F </span><a class="name_mail" href="javascript:void(0);">'
					+ '<b>%s</b></a><span class="date_label"> ���e���F</span><span class="date"> %s</span></div>'
					+ '<div class="mes">%s</div>';
  // body�^�O�p����
  ATTR_PREVIEW = ' class="preview"';
var
	Title: string;
	No: string;
	Board: TBoard;
	Thread: TThreadItem;
	html: string;
	Res: TResRec;
  ResLink :TResLinkRec;
  pviewType: Integer;
	cssPath: string;
  userStyle: string;
begin

	// "�v���r���[�\����CSS�܂��̓X�L����K�p����"��OFF
  if not Gikosys.Setting.PreviewStyle then begin
    Preview;	// �ȑO�̃v���r���[�\��
    Exit;
  end;

	pviewType := TYPE_DEF;

	if GikoSys.Setting.UseSkin then
  	pviewType := TYPE_SKIN
	else begin
		if GikoSys.Setting.UseCSS and (GikoSys.Setting.CSSFileName <> '') then begin
			cssPath := GikoSys.GetStyleSheetDir + GikoSys.Setting.CSSFileName;
			if FileExists(cssPath) then
      	pviewType := TYPE_CSS;
    end;
  end;
  if pviewType = TYPE_DEF then begin
    Preview;	// �ȑO�̃v���r���[�\��
    Exit;
  end;

	Board := GetBoard;
  Thread := nil;
	ResLink.FBbs := Board.BBSID;

	try
    if FThreadItem = nil then begin
      // �X������
      No := '1';
      Title := THTMLCreate.RepHtml(GetTitleText);
      ResLink.FKey := '9999999999';
      // �_�~�[�̃X���b�h�쐬
      Thread := TThreadItem.Create( nil, Board, 'about://sample/test/read.cgi/sample/' );
      Thread.ParentBoard := Board;
      Thread.AllResCount := 1;
      Thread.NewResCount := 1;
      Thread.NewReceive  := 1;
      Thread.Title := Title;
    end else begin
      // ���X��������
      No := IntToStr(FThreadItem.Count + 1);
      Title := THTMLCreate.RepHtml(FThreadItem.Title);
			ResLink.FKey := ChangeFileExt(FThreadItem.FileName, '');
      Thread := FThreadItem;
    end;

    Res.FBody := GetBody;
    Res.FBody := THTMLCreate.RepHtml(Res.FBody);
    Res.FBody := CustomStringReplace(Res.FBody, #13#10, '<br>', False);
    Res.FDateTime := FormatDateTime('yyyy/mm/dd(aaa) hh:nn:ss', Now());
    Res.FMailTo := THTMLCreate.RepHtml(GetMailText);
    Res.FName := THTMLCreate.RepHtml(GetNameText);
    if Trim(Res.FName) = '' then
      Res.FName := '����������';

		HTMLCreater.AddAnchorTag(@Res);
    HTMLCreater.ConvRes(@Res, @ResLink);

    // CSS/�X�L���̑��Ƀt�H���g��F���ݒ肳��Ă���ꍇ
    userStyle := GikoSys.SetUserOptionalStyle;
    if userStyle <> '' then
      userStyle := '<style type="text/css">body {' + userStyle + '}</style>';

		case pviewType of
	    TYPE_SKIN: begin // skin
        html :=
          HTMLCreater.LoadFromSkin( GikoSys.GetSkinHeaderFileName, Thread, 0 ) +
          '<a name="top"></a>' +
          HTMLCreater.SkinedRes( HTMLCreater.LoadFromSkin( GikoSys.GetSkinResFileName, Thread, 0 ), @Res, No ) +
          '<a name="bottom"></a>' +
          HTMLCreater.LoadFromSkin( GikoSys.GetSkinFooterFileName, Thread, 0 );

        if userStyle <> '' then
          html := StringReplace( html, '</head>', userStyle + '</head>', [rfReplaceAll] );

				SetBodyClass(html, ATTR_PREVIEW);
      end;
			TYPE_CSS: begin	// css
        html := '<html><head>' +
                '<meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">' +
                '<title>' + Title + '</title>' +
                '<link rel="stylesheet" href="' + cssPath + '" type="text/css">' +
                userStyle + '</head>' +
                '<body' + ATTR_PREVIEW + '><div class="title">' + Title + '</div>';

        if Res.FMailTo = '' then
          html := html + Format(FORMAT_NOMAIL, [No, No, Res.FName, Res.FDateTime, Res.FBody])
        else if GikoSys.Setting.ShowMail then
          html := html + Format(FORMAT_SHOWMAIL, [No, No, Res.FName, Res.FMailTo, Res.FDateTime, Res.FBody])
        else
          html := html + Format(FORMAT_NOSHOW, [No, No, Res.FName, Res.FDateTime, Res.FBody]);

        html := html + '</body></html>';
      end;
		end;

		// �N���b�N�őJ�ڂ��Ȃ��悤�Ƀ����N���R����
		TrimLinkFromHtml(html);

		try
			SetContent(html, Browser);
		except
		end;

	finally
		if (FThreadItem = nil) and (Thread <> nil) then
			Thread.Free;
	end;

end;

procedure TEditorForm.TrimLinkFromHtml(var html: String);
const
	// �����N�u���p �J�n�L�[���[�h
  REPL_HDR : array[0..5] of String = ('href="', 'onclick="', 'onClick="', 'onmouseover="', 'onMouseOver="', 'onmouseout="');
	// �����N�u���p �I���L�[���[�h
  REPL_FTR = '"';
	// �����N�u���p �u��������
  REPL_VAL = 'javascript:void(0);';
	// �^�[�Q�b�g�폜�p �J�n�L�[���[�h
  TRGT_HDR = 'target="';
	// �^�[�Q�b�g�폜�p �I���L�[���[�h
  TRGT_FTR = '"';
	// �����N�u���p �L�[���[�h������
  REPL_FTR_LEN = Length(REPL_FTR);
  REPL_VAL_LEN = Length(REPL_VAL);
  TRGT_HDR_LEN = Length(TRGT_HDR);
	// �����͈̖͂ڈ�
  BODY_TOP1 = '</head>';
  BODY_TOP2 = '</HEAD>';
  BODY_BTM1 = '</body>';
  BODY_BTM2 = '</BODY>';
var
	REPL_HDR_LEN: Integer;
  i: Integer;
  idx1: Integer;
  idx2: Integer;
  start: Integer;
  bodyTop: Integer;
  bodyBtm: Integer;
  bodyType: Integer;

	function GetBodyBottom(var html: String; bodyType: Integer): Integer;
  begin
  	case bodyType of
    1:   Result := Pos(BODY_BTM1, html);
    2:   Result := Pos(BODY_BTM2, html);
    else Result := Length(html);
    end;
  end;

begin
  bodyTop := Pos(BODY_TOP1, html);
  if bodyTop < 1 then
    bodyTop := Pos(BODY_TOP2, html);
    if bodyTop < 1 then
      bodyTop := 1;

  if Pos(BODY_BTM1, html) > 0 then
    bodyType := 1
  else if Pos(BODY_BTM2, html) > 0 then
		bodyType := 2
  else
  	bodyType := 0;

  // �����N�N���b�N�őJ�ڂ��Ȃ��悤�Ƀ����N���u��
  for i := Low(REPL_HDR) to High(REPL_HDR) do begin
  	REPL_HDR_LEN := Length(REPL_HDR[i]);
    start := bodyTop;
    bodyBtm := GetBodyBottom(html, bodyType);
    while start < bodyBtm do begin
      idx1 := PosEx(REPL_HDR[i], html, start);
      if (idx1 < 1) or (idx1 >= bodyBtm) then
        Break;
      start := idx1 + REPL_HDR_LEN;
      idx2 := PosEx(REPL_FTR, html, start);
      if (idx2 < 1) or (idx2 >= bodyBtm) then
        Break;
      Delete(html, start, idx2 - start);
      Insert(REPL_VAL, html, start);
      start := start + REPL_VAL_LEN + REPL_FTR_LEN;
	    bodyBtm := GetBodyBottom(html, bodyType);
    end;
  end;
  // �^�[�Q�b�g�����폜
  start := bodyTop;
	bodyBtm := GetBodyBottom(html, bodyType);
  while start < bodyBtm do begin
    idx1 := PosEx(TRGT_HDR, html, start);
		if (idx1 < 1) or (idx1 >= bodyBtm) then
      Break;
    start := idx1 + TRGT_HDR_LEN;
    idx2 := PosEx(TRGT_FTR, html, start);
		if (idx2 < 1) or (idx2 >= bodyBtm) then
      Break;
    Delete(html, idx1, idx2 - idx1 + 1);
    start := idx1;
    bodyBtm := GetBodyBottom(html, bodyType);
  end;
end;

// body�^�O�ɑ����ǉ�
procedure TEditorForm.SetBodyClass(var html: String; attrClass: String);
const
	TAG_S1  = '<body';
	TAG_S2  = '<BODY';
var
	idx1: Integer;
  idx2: Integer;
begin
	idx1 := Pos(TAG_S1, html);
  if idx1 < 1 then
		idx1 := Pos(TAG_S2, html);
  if idx1 < 1 then
  	Exit;

	idx2 := PosEx('>', html, idx1);
  if idx2 > idx1 then
		Insert(attrClass, html, idx2);
end;

procedure TEditorForm.EditorPageChange(Sender: TObject);
var
	tmpBoard: TBoard;
begin

	tmpBoard := GetBoard;

	if tmpBoard = nil then Exit;

	if EditorPage.ActivePage = PreviewTab then begin
		Preview2;
	end else if EditorPage.ActivePage = RocalRuleTab then begin
		if not FileExists(tmpBoard.GETHEADTXTFileName) then begin
			LocalEdit.Text := '���[�J�����[�����擾';
			Exit;
		end;
		ShowBoardHead(tmpBoard, LocalEdit);
	end else begin
		Browser.Navigate('about:blank');
	end;
end;

procedure TEditorForm.BrowserStatusTextChange(Sender: TObject;
	const Text: WideString);
begin
	if EditorPage.ActivePage = PreviewTab then begin
		StatusBar.Panels[0].Text := Text;
	end else begin
		StatusBar.Panels[0].Text := '';
	end;
end;

function TEditorForm.Check: Boolean;
const
	REQUIRED: string = '�����͂���Ă��܂���B';
	ERROR: string = '�G���[';
var
	Msg: string;
	rc: Integer;
	Board: TBoard;
	BodyLen: Integer;
begin
	Result := True;

	Board := GetBoard;

	BodyLen := Length(GetBodyText());

	if (not GikoSys.Setting.UseMachineTime) and
		 ((Board.LastGetTime = 0) or
			(Board.LastGetTime = ZERO_DATE)) then begin
		Msg := '�T�[�o�̎�����������Ȃ����߁A���M�o���܂���'#13#10
				 + '�X���b�h���X�V�i�擾�j��A15�b�҂��Ă��瑗�M���Ă�������';
		MsgBox(Handle, Msg, ERROR, MB_OK or MB_ICONSTOP);
		Result := False;
	end else if BodyLen = 0 then begin
		Msg := '�{��' + REQUIRED;
		MsgBox(Handle, Msg, ERROR, MB_OK or MB_ICONSTOP);
		Result := False;
	end else if (FBoard <> nil) and (Trim(GetTitleText) = '') then begin
		Msg := '�^�C�g��' + REQUIRED;
		MsgBox(Handle, Msg, ERROR, MB_OK or MB_ICONSTOP);
		Result := False;
	end else begin
		if (not Session5ch.Connected) and (AnsiPos('��', GetNameText) <> 0) then begin
			Msg := '���O�C�����Ă��Ȃ��̂Ł��̋@�\�͗��p�o���܂���B'#13#10
					 + '���̂܂ܑ��M���Ă���낵���ł����H';
			rc := MsgBox(Handle, Msg, '�m�F', MB_YESNO or MB_ICONQUESTION);
			Result := (rc = IDYES);
		end;
	end;
end;

procedure TEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TEditorForm.FormDestroy(Sender: TObject);
var
	wp: TWindowPlacement;
begin
	FSambaTimer.Free;

	if (Owner <> nil) and (Owner.ClassNameIs('TKeySettingForm') = False) then begin
		//�ő剻�E�E�B���h�E�ʒu�ۑ�
		wp.length := sizeof(wp);
		GetWindowPlacement(Handle, @wp);

		GikoSys.Setting.EditWindowTop := wp.rcNormalPosition.Top;
		GikoSys.Setting.EditWindowLeft := wp.rcNormalPosition.Left;
		GikoSys.Setting.EditWindowHeight := wp.rcNormalPosition.Bottom - wp.rcNormalPosition.Top;
		GikoSys.Setting.EditWindowWidth := wp.rcNormalPosition.Right - wp.rcNormalPosition.Left;
		GikoSys.Setting.EditWindowMax := WindowState = wsMaximized;
		//GikoSys.Setting.EditWindowStay := FormStyle = fsStayOnTop;      // �X�e�C��Ԃ̕ۑ�
		GikoSys.Setting.EditWindowTranslucent := TransAction.Checked;   // ��������Ԃ̕ۑ�
	end;

	BodyEditUC.Free;
	TitleEditUC.Free;
	NameComboBoxUC.Free;
	MailComboBoxUC.Free;
	FURI.Free;
end;

procedure TEditorForm.SetNameList(sName, sMail: string);
begin
	if SaveNameMailAction.Checked then begin
		if Trim(sName) <> '' then begin
			if GikoSys.Setting.NameList.IndexOf(sName) = -1 then
				GikoSys.Setting.NameList.Insert(0, sName);
		end;
		if Trim(sMail) <> '' then begin
			if GikoSys.Setting.MailList.IndexOf(sMail) = -1 then
				GikoSys.Setting.MailList.Insert(0, sMail);
		end;
	end;
end;

function TEditorForm.GetActiveControlHandle: THandle;
begin
	if EditorPage.ActivePage = EditorTab then begin
		if (ActiveControl = NameComboBox) or (ActiveControl = NameComboBoxUC) then
			Result := FNameComboEdit
		else if (ActiveControl = MailComboBox) or (ActiveControl = MailComboBoxUC) then
			Result := FMailComboEdit
		else if ActiveControl = BodyEditUC then
			Result := BodyEditUC.Handle
		else if ActiveControl = BodyEdit then
			Result := BodyEdit.Handle
		else if ActiveControl = TitleEdit then
			Result := TitleEdit.Handle
		else if ActiveControl = TitleEditUC then
			Result := TitleEditUC.Handle
		else
			Result := 0;
	end else if Editorpage.ActivePage = BoardInformationTab then begin
		if ActiveControl = BoardInformationMemo then
			Result := BoardInformationMemo.Handle
		else
			Result := 0;
	end else if Editorpage.ActivePage = RocalRuleTab then begin
		if ActiveCOntrol = LocalEdit then
			Result := LocalEdit.Handle
		else
			Result := 0;
	end else
		Result := 0;
end;

procedure TEditorForm.SetContent(Content: string; ABrowser: TWebBrowser);
var
	doc: OleVariant;
begin
	if Assigned(ABrowser.ControlInterface.Document) then begin
		doc := OleVariant(ABrowser.Document);
		doc.Clear;
		doc.open;
		doc.charset := 'Shift_JIS';
		doc.Write(Content);
		doc.Close;
	end;
end;

//! ���M���~�̂��߂̃��j���[�̍Đ�
procedure TEditorForm.CancelSend(ABoard: TBoard; ASysMenu: HMENU);
begin
	ABoard.SPID := '';
	ABoard.PON := '';
	FWork := false;
	EnableMenuItem(ASysMenu, SC_CLOSE, MF_BYCOMMAND or MF_ENABLED);
	DrawMenuBar(Handle);
end;

procedure TEditorForm.Send( const ACOOKIE: string; const SPID: string;
 const PON: string; FirstWriting: Boolean);
var
	TextStream: TStringStream;
	Source: TStringStream;
	ResponseText: string;
	URL: string;
	State: TGikoDownloadState;
	ResultType: TGikoResultType;
	MsgResult: Integer;
	Board: TBoard;
	sysMenu	: HMENU;
	ExpMsg: String;
	{Protocol,Host, Path, Document, Port, Bookmark : String;}
	is2ch: Boolean;   // for 5ch
	referer: String;  // for 5ch
	isUTF8: Boolean;
//{$IFDEF DEBUG}
//  debug: String;
//{$ENDIF}
begin
	FAbort := False;
	State := gdsError;
	Board := GetBoard;

	TIndyMdl.InitHTTP(Indy, True);
	Indy.Request.AcceptEncoding := '';
	Indy.AllowCookies := True;
	if FThreadItem = nil then begin
		URL := FBoard.GetSendURL;
		Indy.Request.Referer := GikoSys.UrlToServer(FBoard.URL) + 'test/bbs.cgi';
	end else begin
		URL := FThreadItem.GetSendURL;
		Indy.Request.Referer := FThreadItem.URL;
	end;
	// for 5ch
	is2ch := GikoSys.Is2chURL(URL);
	if is2ch then begin
		GikoSys.Regulate2chURL(URL);
		referer := Indy.Request.Referer;
		GikoSys.Regulate2chURL(referer);
		Indy.Request.Referer := referer;
	end;
	isUTF8 := is2ch and FUseUC;   // 5ch�������݂�Unicode���[�h�Ȃ�UTF-8
	// for 5ch
	sysMenu := GetSystemMenu( Handle, false );
	EnableMenuItem( sysMenu, SC_CLOSE, MF_GRAYED );
{
  EnableMenuItem(SysMenu, SC_CLOSE, MF_BYCOMMAND or MF_ENABLED);
  DrawMenuBar(Handle);
}
	Indy.Request.CustomHeaders.Clear;
//	Indy.Request.CacheControl := 'no-cache';
	Indy.Request.CustomHeaders.Add('Pragma: no-cache');
	Indy.Request.AcceptLanguage := 'ja';
	//Indy.Request.Accept := 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*';
	if isUTF8 then begin
		Indy.Request.ContentType := 'application/x-www-form-urlencoded; charset=UTF-8';
		Indy.Request.AcceptCharSet := 'utf-8';
	end else
		Indy.Request.ContentType := 'application/x-www-form-urlencoded';
	Indy.Request.CustomHeaders.Add(getHeaderStr(ACOOKIE, SPID, PON, GikoSys.GetBouken(URL, FCookieDomain), Board));

	TextStream := TStringStream.Create('');
	Source := TStringStream.Create('');
	try
		try
			FDebugStrReceive := '';
			FDebugStrSend := '';

			if (FirstWriting) then begin
				//�t�V�A�i�g���b�v�x��(LocalMode) by �����
				if (isLocalFusianaTrap) then begin
					CancelSend( Board, SysMenu );
					Exit;
				end;
				//�t�V�A�i�g���b�v�x��(Remote)
				if (isRemoteFusianaTrap) then begin
					CancelSend( Board, SysMenu );
					Exit;
				end;
				// �딚�`�F�b�N
				if (isGobaku) then begin
					CancelSend( Board, SysMenu );
					Exit;
				end;
			end;

			GetSendData(Source, isUTF8, (is2ch = False));

//{$IFDEF DEBUG}
//      debug := 'Send() FirstWriting:';
//      if FirstWriting then debug := debug + 'True' else debug := debug + 'False';
//      debug := debug + ' AcceptCharSet:' + Indy.Request.AcceptCharSet;
//      DebugLog(debug);
//      if MessageBox(Handle, PChar(debug), 'debug', MB_OKCANCEL) = IDCANCEL then
//        Exit;
//{$ENDIF}

			IndyMdl.StartAntiFreeze(100);
			try
				Indy.Post(URL, Source, TextStream);
			finally
				IndyMdl.EndAntiFreeze;
			end;
			ResponseText := TextStream.DataString;

			ResultType := GetResultType(ResponseText);

			if ResultType = grtOK then begin
				if (GikoSys.Setting.UseSamba) and  (FSambaTimer.Enabled) then
				begin
					FSambaTimer.WriteSambaTime(Now());
				end;
				GetCookie(Indy.CookieManager, Board);
				State := gdsComplete;
			end else if ResultType = grtCookie then begin
				//���[�v�h�~
				if not FirstWriting then
					raise Exception.Create('');

				MsgResult := MsgBox( Handle,
								'�E���e���ꂽ���e�̓R�s�[�A�ۑ��A���p�A�]�ړ������ꍇ������܂��B' + #13#10 +
								'�E���e�Ɋւ��Ĕ�������ӔC�͑S�ē��e�҂ɋA���܂��B' + #13#10#13#10 +
								'�S�ӔC�𕉂����Ƃ��������ď������݂܂����H',
								'���',
								MB_YESNO or MB_ICONQUESTION);

				if MsgResult = IDYES then begin
					GetCookie(Indy.CookieManager, Board);
					if (Board.Is2ch) then begin
						GetHiddenParameter(ResponseText, Board);
					end;

					if (Board.SPID = '') and (Board.PON = '') and (Board.Cookie = '') then
						raise Exception.Create('');
					//������񂱂̃��\�b�h
					Send(Board.Cookie, Board.SPID, Board.PON, False);
					Exit;
				end else begin
					CancelSend( Board, SysMenu );
					Exit;
				end;
			end else if ResultType = grtCheck then begin
				//���[�v�h�~
				if not FirstWriting then
					raise Exception.Create('');

				MsgResult := MsgBox( Handle,
						'�������݂Ɋւ��Ă͗l�X�ȃ��O��񂪋L�^����Ă��܂��B' + #13#10 +
						'���e�Ɋւ��Ĕ�������ӔC�͑S�ē��e�҂ɋA���܂��B' + #13#10 +
						'�����Ǒ��ɔ�������A���l�ɖ��f�������鏑�����݂͍T���ĉ������B' + #13#10 +
						'���e���ꂽ���e�̓R�s�[�E�ۑ��E���p�E�]�ړ������ꍇ������܂��B' + #13#10 +
						#13#10 +
						'�S�ӔC�𕉂����Ƃ��������ď������݂܂����H',
						'�m�F',
						MB_YESNO or MB_ICONQUESTION);

				if MsgResult = IDYES then begin
					GetCookie(Indy.CookieManager, Board);
					if (Board.Is2ch) then begin
						GetHiddenParameter(ResponseText, Board);
					end;

					if (Board.SPID = '') and (Board.PON = '') and (Board.Cookie = '') then
						raise Exception.Create('');


					Send(Board.Cookie, Board.SPID, Board.PON, False);
					Exit;
				end else begin
					CancelSend( Board, SysMenu );
					Exit;
				end;
			end else if ResultType = grtNinpou then begin
				MsgBox( Handle,
						'�M���̔E�@�����쐬���ł��B�����Ԃ��Ȃ炢�܂��B(�Q���قǂ�����܂�)' + #13#10
						, '�m�F',
						MB_OK or MB_ICONINFORMATION);
				if (GikoSys.Setting.UseSamba)  and  (FSambaTimer.Enabled) then
				begin
					FSambaTimer.WriteSambaTime(Now());
				end;
				Board.PON  := '';
				Board.SPID := '';
				Board.Cookie := '';
				GetCookie(Indy.CookieManager, Board);
				Exit;
			end else if ResultType = grtSuiton then begin
				MsgBox( Handle,
						'�M���̔E�@���͏Ă���܂����B' + #13#10 +
                        '�E�@�����폜���܂����A�đ��M���Ă��������B'
						, '�m�F',
						MB_OK or MB_ICONINFORMATION);
				// �E�@������������
				GikoSys.DelBoukenCookie(FCookieDomain);
				GikoSys.Setting.WriteBoukenSettingFile;
				Board.PON  := '';
				Board.SPID := '';
				Board.Cookie := '';
				Exit;
			end else begin
				if (GikoSys.Setting.UseSamba)  and  (FSambaTimer.Enabled) then
				begin
					FSambaTimer.WriteSambaTime(Now());
				end;
				// �E�@�������G���[��Cookie���X�V����
				if ResultType = grtNinpouErr then begin
					GetCookie(Indy.CookieManager, Board);
				end;
				State := gdsError;
				raise Exception.Create('');
			end;
		except
			on E: EIdSocketError do begin
				State := gdsError;
				ResponseText := '<html><body>'
											+ '<div>�ڑ������s���܂���<br>'
											+ '����̏�Ԃ𒲂ׂĂ�������<br></div>'
											+ '<br><br><div>' + E.Message + '</div>'
											+ '</body></html>';
			end;
			on E: EIdConnectException do begin
				State := gdsError;
				ResponseText := '<html><body>'
											+ '<div>�ڑ������s���܂���<br>'
											+ '�����v���L�V�̏�Ԃ𒲂ׂĂ�������<br></div>'
											+ '<br><br><div>' + E.Message + '</div>'
											+ '</body></html>';
			end;
			on E: Exception do begin
				State := gdsError;

				FDebugStrReceive := AnsiReplaceText(FDebugStrReceive, '<', '&lt;');
				FDebugStrReceive := AnsiReplaceText(FDebugStrReceive, '>', '&gt;');
				FDebugStrSend := AnsiReplaceText(FDebugStrSend, '<', '&lt;');
				FDebugStrSend := AnsiReplaceText(FDebugStrSend, '>', '&gt;');
				ExpMsg := AnsiReplaceText(E.Message, '<', '&lt;');
				ExpMsg := AnsiReplaceText(ExpMsg,    '>', '&gt;');

				ResponseText := '<html><body>' + TextStream.DataString;
				ResponseText := AnsiReplaceText(ResponseText, '</body>', '');
				ResponseText := AnsiReplaceText(ResponseText, '</html>', '');
				ResponseText := ResponseText + '<hr><div align="left"><pre>';
				ResponseText := ResponseText + '<b>��������M�R�i�r�̏��</b>'#13#10;
				ResponseText := ResponseText + #13#10'����O'#13#10;
				ResponseText := ResponseText + ExpMsg;
				ResponseText := ResponseText + #13#10'�����M'#13#10;
				ResponseText := ResponseText + FDebugStrSend;
				ResponseText := ResponseText + #13#10'����M'#13#10;
				ResponseText := ResponseText + FDebugStrReceive;
				ResponseText := ResponseText + '</pre></div></body></html>';
			end;
		end;
		FStatusCode := Indy.ResponseCode;
		if FAbort then
			State := gdsAbort;
	finally
		Source.Free;
		TextStream.Free;
		if ( Indy.CookieManager <> nil ) then begin
			Indy.CookieManager.CookieCollection.Clear;
		end;
		//sysMenu := GetSystemMenu( Handle, true );
		EnableMenuItem(SysMenu, SC_CLOSE, MF_BYCOMMAND or MF_ENABLED);
		DrawMenuBar(Handle);
	end;
	FWork := false;
	//������M�R�i�r�Ȃǂ�2ch�݊��X�N���v�g�p
	//2ch�ȊO�ł���ResponceCode��302Found�ŏ������݊���
	//if (not Board.Is2ch) and (FStatusCode = 302) then begin
	if FStatusCode = 302 then begin
		GikoForm.PlaySound('ResEnd');
		SaveSendFile;
		AddFormMessageNew( gmiOK );
		if (not ContinueModeAction.Enabled) or (not ContinueModeAction.Checked) then begin
			Close;
			Exit;
		end;
	end;
	if State = gdsComplete then begin
		GikoForm.PlaySound('ResEnd');
		SaveSendFile;
		AddFormMessageNew( gmiOK );
		if (not ContinueModeAction.Enabled) or (not ContinueModeAction.Checked) then begin
			Close;
		end;
	end else if State = gdsError then begin
		AddFormMessageNew( gmiOK );
		EditorPage.ActivePage := PreviewTab;
		SetContent(ResponseText, Browser);
	end else if State = gdsAbort then begin
		GikoForm.AddMessageList(FThreadItem.Title + ' ' + GikoSys.GetGikoMessage(gmAbort), nil, gmiSAD);
	end;
end;

function TEditorForm.GetResultType(ResponseText: string): TGikoResultType;
begin
	if AnsiPos('�������݂��I���܂���', ResponseText) <> 0 then
		Result := grtOK
	else if ( (AnsiPos('<b>�悤�����F�M���̔E�@�����쐬���܂��B�Q����ɍēx�������ނ��A���A�肭������', ResponseText) > 0) or
				(AnsiPos('�d�q�q�n�q�F�M���̖`���̏����쐬���ł�', ResponseText) > 0) )
				and (AnsiPos(RES2CH_COOKIE, ResponseText) > 0) 	then
		Result := grtNinpou
	else if ( (AnsiPos('�d�q�q�n�q�F�C�s������܂���', ResponseText) > 0) or   // �G���[����
				(AnsiPos('�d�q�q�n�q�FLv������Ȃ��ăX���b�h����', ResponseText) > 0) ) // �G���[����
				and (AnsiPos(RES2CH_COOKIE, ResponseText) > 0) 	then
		Result := grtNinpouErr
	else if( AnsiPos('<b>���ꂽ�ł�����FLv=0 <br>���Ď��͂ŕ����ł��邩��?', ResponseText) > 0) 
				and (AnsiPos(RES2CH_COOKIE, ResponseText) > 0) 	then
		Result := grtSuiton
	else if ( AnsiPos('�N�b�L�[���Ȃ��������؂�ł�', ResponseText) > 0) or
					(AnsiPos('<title>�N�b�L�[�m�F�I</title>', ResponseText) > 0)	or
					(AnsiPos('<title>���N�b�L�[�m�F�I��</title>', ResponseText) > 0) or
					(AnsiPos('(cookie��ݒ肷��Ƃ��̉�ʂ͂łȂ��Ȃ�܂��B)', ResponseText) > 0) or
					(AnsiPos(RES2CH_COOKIE, ResponseText) > 0)	then
		Result := grtCookie
	else if (AnsiPos('<font size=+2 color=#FF0000>�������݃`�F�b�N�I </font>', ResponseText) > 0)	or
					(AnsiPos('<title>�� �������݊m�F���܂� ��</title>', ResponseText) > 0)	or
					(AnsiPos('<title>���e�m�F</title>', ResponseText) > 0)	or
					(AnsiPos('<b>�������݊m�F</b>', ResponseText) > 0)	or
					(AnsiPos('="../test/subbbs.cgi">', ResponseText) > 0)	or
					(AnsiPos(RES2CH_FALSE, ResponseText) > 0)	then
		Result := grtCheck
	else if (AnsiPos('�E���e�҂́A�f���^�c�҂ɑ΂��āA����Ґl�i������؍s�g���Ȃ����Ƃ��������܂��B<br>', ResponseText) > 0) or
					(AnsiPos('�i���쌠�@��21���Ȃ�����28���ɋK�肳��錠�����܂ށj���̑��̌����ɂ��A', ResponseText) > 0) then
		Result := grtCookie
	else
		Result := grtError;
end;


procedure TEditorForm.GetSendData(Source: TStringStream; EncUTF8: Boolean; AddCRLF: Boolean);
var
	SessionID: String;
	s:         String;
	SendTime:  Integer;
	Adjust:    Integer;
	Board:     TBoard;
	body:      String;
	submit:    String;
	from:      String;
	mail:      String;
	subject:   String;
begin
	Board := GetBoard;

	if GikoSys.Setting.UseMachineTime then begin
		if GikoSys.Setting.TimeAdjust then
			Adjust := Gikosys.Setting.TimeAdjustSec
		else
			Adjust := GikoSys.Setting.TimeAdjustSec * -1;
		SendTime := GikoSys.DateTimeToInt(Now) - (9 * 60 * 60) + Adjust
	end else begin
		if (Board.LastGetTime = 0) or (Board.LastGetTime = ZERO_DATE) then
			SendTime := GikoSys.DateTimeToInt(Now)
		else
			SendTime := GikoSys.DateTimeToInt(Board.LastGetTime);
	end;

	if FThreadItem = nil then
		submit := '�S�ӔC�𕉂����Ƃ��������ď�������'
	else
		submit := '��������';

	if EncUTF8 then begin
		if FThreadItem = nil then
			subject := HttpEncode(GetTitleUTF8);
		from   := HttpEncode(GetNameUTF8);
		mail   := HttpEncode(GetMailUTF8);
		body   := HttpEncode(GetBodyUTF8);
		submit := HttpEncode(AnsiToUtf8(submit));
	end else begin
		if FThreadItem = nil then
			subject := HttpEncode(GetTitleText);
		from   := HttpEncode(GetNameText);
		mail   := HttpEncode(GetMailText);
		body   := HttpEncode(GetBody);
		submit := HttpEncode(submit);
	end;

	SessionID := Session5ch.SessionID;
	if SessionID <> '' then
		s := 'sid=' + HttpEncode(SessionID) + '&'
	else
		s := '';
	s := s + 'subject=&'
			+ 'FROM=' + from + '&'
			+ 'mail=' + mail + '&'
			+ 'MESSAGE=' + body + '&'
			+ 'bbs=' + Board.BBSID + '&'
			+ 'time=' + IntToStr(SendTime) + '&';

	if FThreadItem = nil then
		s := s + 'subject=' + subject + '&'
	else
		s := s + 'key=' + ChangeFileExt(FThreadItem.FileName, '') + '&';
	s := s + 'submit=' + submit;
	if AddCRLF then s := s + #13#10;

	Source.WriteString(s);
//{$IFDEF DEBUG}
//    DebugLog(s);
//    MessageBox(Handle, PChar(s), 'debug', MB_OK);
//{$ENDIF}
end;

procedure TEditorForm.SaveSendFile;
var
	sDate: String;
	ini:   TMemIniFile;
	Body:  String;
begin
	ini := CreateSentIniFile;
	if (ini <> nil) then begin
		try
			sDate := IntToStr(GikoSys.DateTimeToInt(Now));
			Body := GetBodyText();

			ini.WriteString(sDate, 'Name', GetNameText);
			ini.WriteString(sDate, 'EMail', GetMailText);
			ini.WriteString(sDate, 'Body', HttpEncode(Body));
			ini.WriteInteger(sDate, 'Status', FStatusCode);
			ini.WriteDateTime(sDate, 'Date', Now);
			if FThreadItem = nil then begin
				ini.WriteString(sDate, 'Title', MojuUtils.Sanitize(GetTitleText));
				//ini.WriteString(sDate, 'BBS', FBoard.BBSID);
				ini.WriteString(sDate, 'URL', FBoard.URL);
				ini.WriteInteger(sDate, 'NewThread', 1);
			end else begin
				ini.WriteString(sDate, 'Title', FThreadItem.Title);
				//ini.WriteString(sDate, 'BBS', FThreadItem.ParentBoard.BBSID);
				ini.WriteString(sDate, 'URL', FThreadItem.URL);
				ini.WriteString(sDate, 'Key', ChangeFileExt(FThreadItem.FileName, ''));
			end;

			ini.UpdateFile;
		finally
			ini.Free;
		end;
	end;
end;

function TEditorForm.CreateSentIniFile: TMemIniFile;
var
  maxSize, fileSize, i: Integer;
  newName: String;
begin
  Result := nil;
  // MB -> bytes
  maxSize := GikoSys.Setting.SentIniFileSize * 1024 * 1024;
  // �t�@�C���T�C�Y��0�̏ꍇ�́Asent.ini�ɏ������܂Ȃ��̂�nil��Ԃ�
  if (maxSize > 0) then begin
    fileSize := GikoSys.GetFileSize(GikoSys.Setting.GetSentFileName);
    // �ő�T�C�Y�𒴂��Ă����ꍇ�̓��l�[������
    if (fileSize >= maxSize) then begin
      i := 0;
      // ���̎������t�@�C�����̌��ɂ���
      repeat
        // 10��ȏ㎸�s�����炠����߂�
        if (i > 10) then break;
        DateTimeToString(newName, 'yyhhnnsszzz', Now());
        Inc(i);
      until RenameFile(GikoSys.Setting.GetSentFileName,
        GikoSys.Setting.GetSentFileName + '.' + newName);
    end;
    Result := TMemIniFile.Create(GikoSys.Setting.GetSentFileName);
  end;
end;

procedure TEditorForm.SendActionExecute(Sender: TObject);
const
	TITLE_SAMBA : string = 'Samba24�x��';
var
	Board: TBoard;
	rc:    Integer;
	rc2:   Integer;
	state: TGikoDownloadState;
	body:  string;
begin
	if FWork then
		Exit;
	try
		FWork := True;
		SendAction.Enabled := False;
		Application.ProcessMessages;
		if not Check then Exit;

		Board := GetBoard;

		if FThreadItem = nil then begin
			rc := GikoUtil.MsgBox(Handle,
													'�u' + Board.Title + '�v�ɐV�����X���b�h���Ă܂�'#13#10#13#10
													+ '�E�̃��[����������������݂ł��邱�Ƃ��m�F���܂������H'#13#10
													+ '�E���ɓ����悤�ȃX���b�h�������������Ƃ��m�F���܂������H'#13#10#13#10
													+ '�u�͂��v�������Ƒ��M���܂�',
													'�m�F',
													MB_ICONQUESTION or MB_YESNO);
			if rc <> ID_YES then
				Exit;
		end;

		SetNameList(GetNameText, GetMailText);
		if (KotehanCheckBox.Enabled) and (KotehanCheckBox.Checked) then begin
			Board.KotehanName := GetNameText;
			Board.KotehanMail := GetMailText;
		end;

		if Board.IsBoardPlugInAvailable then begin
			body := GetBody;

			if FThreadItem = nil then begin
				// �X������
				state := TGikoDownloadState( Board.BoardPlugIn.CreateThread(
                                    DWORD( Board ), GetTitleText, GetNameText, GetMailText, body ) );

				if state = gdsComplete then begin
					GikoForm.PlaySound('ResEnd');
					SaveSendFile;
					GikoForm.AddMessageList(FBoard.Title + ' ' + GikoSys.GetGikoMessage(gmNewSure), nil, gmiOK);
					FWork := False;
					if (not ContinueModeAction.Enabled) or (not ContinueModeAction.Checked) then
						Close;
				end else if State = gdsError then begin
					GikoForm.AddMessageList(FBoard.Title + ' ' + GikoSys.GetGikoMessage(gmSureError), nil, gmiNG);
				end else if State = gdsAbort then begin
					GikoForm.AddMessageList(FBoard.Title + ' ' + GikoSys.GetGikoMessage(gmAbort), nil, gmiNG);
				end;
			end else begin
				// ���X
				state := TGikoDownloadState( FThreadItem.ParentBoard.BoardPlugIn.WriteThread(
                                    DWORD( FThreadItem ), GetNameText, GetMailText, body ) );

				if state = gdsComplete then begin
					GikoForm.PlaySound('ResEnd');
					SaveSendFile;
					GikoForm.AddMessageList(FThreadItem.Title + ' ' + GikoSys.GetGikoMessage(gmNewRes), nil, gmiOK);
					FWork := False;
					if (not ContinueModeAction.Enabled) or (not ContinueModeAction.Checked) then
						Close;
				end else if State = gdsError then begin
					GikoForm.AddMessageList(FThreadItem.Title + ' ' + GikoSys.GetGikoMessage(gmResError), nil, gmiOK);
				end else if State = gdsAbort then begin
					GikoForm.AddMessageList(FThreadItem.Title + ' ' + GikoSys.GetGikoMessage(gmAbort), nil, gmiOK);
				end;
			end;
		end else begin
			if not FSambaTimer.Enabled then begin
				if CompareDateTime(Board.Expires ,Now) <= 0 then begin
					Board.Cookie	:= '';
					Board.SPID      := '';
					Board.PON		:= '';
				end;
				// �`���̏����x���߂���Ή�
				if (Board.Is2ch) and (AnsiPos('HAP=', Board.Cookie)>0) then begin
					Board.Cookie := '';
				end;
				Send(Board.Cookie, Board.SPID, Board.PON, True);
			end else begin
				if not FSambaTimer.CheckSambaTime(Now()) then begin
					rc := GikoUtil.MsgBox(Handle,
								'Samba24�̋K��l�����̕b�������o�߂��Ă��܂���B'#13#10
								+ '���M�𒆎~���܂����H' + #13#10
								+ '(�u�������v���Ƒ��M���܂�)', TITLE_SAMBA,
								MB_YESNO or MB_ICONQUESTION);
					if rc = IDYES then begin
						FWork := false;
						Exit;
					end;
					if rc = IDNO then begin
						rc2 := GikoUtil.MsgBox(Handle,
											'�{���ɑ��M���܂����H',
											TITLE_SAMBA,
											MB_YESNO or MB_ICONQUESTION);
						if rc2 = IDNO then begin
							FWork := False;
							Exit;
						end;
					end;
				end;
				if CompareDateTime(Board.Expires ,Now) <= 0 then begin
					Board.Cookie	:= '';
					Board.SPID      := '';
					Board.PON		:= '';
				end;
				// �`���̏����x���߂���Ή�
				if (Board.Is2ch) and (AnsiPos('HAP=', Board.Cookie)>0) then begin
					Board.Cookie := '';
				end;
				Send(Board.Cookie, Board.SPID, Board.PON, True);
			end;
		end;
	finally
		FWork := False;
		if FSambaTimer.Enabled then begin
			FNow := FSambaTimer.Update;
		end;
	end;
end;

procedure TEditorForm.SaveActionExecute(Sender: TObject);
begin
///
end;

procedure TEditorForm.CloseActionExecute(Sender: TObject);
begin
	Close;
end;

procedure TEditorForm.UndoActionExecute(Sender: TObject);
begin
	SendMessage(GetActiveControlHandle, WM_UNDO, 0, 0);
end;

procedure TEditorForm.CutActionExecute(Sender: TObject);
begin
	SendMessage(GetActiveControlHandle, WM_CUT, 0, 0);
end;

procedure TEditorForm.CopyActionExecute(Sender: TObject);
begin
	SendMessage(GetActiveControlHandle, WM_COPY, 0, 0);
end;

procedure TEditorForm.PasteActionExecute(Sender: TObject);
begin
	SendMessage(GetActiveControlHandle, WM_PASTE, 0, 0);
end;

procedure TEditorForm.SelectAllActionExecute(Sender: TObject);
begin
	SendMessage(GetActiveControlHandle, EM_SETSEL, 0, GetWindowTextLength(GetActiveControlHandle));
end;

procedure TEditorForm.TopActionExecute(Sender: TObject);     // �E�B���h�E�őO��(Stay)�{�^���̏���
begin
	if not (fsShowing in Self.FormState) then begin
		if TopAction.Checked then begin // �X�e�C��Ԃɐݒ�
			SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
			GikoSys.Setting.EditWindowStay := true;
		end	else begin   // �X�e�C��ԉ���
			SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
			GikoSys.Setting.EditWindowStay := false;
		end;
		// �X�e�C��Ԃ̕ۑ�
		//GikoSys.Setting.EditWindowStay := FormStyle = fsStayOnTop;
	end;
end;

procedure TEditorForm.AbortActionExecute(Sender: TObject);
begin
	FAbort := True;
end;

procedure TEditorForm.SendActionUpdate(Sender: TObject);
begin
	SendAction.Enabled := not FWork;
end;

procedure TEditorForm.SaveActionUpdate(Sender: TObject);
begin
	SaveAction.Enabled := False;
end;

procedure TEditorForm.CloseActionUpdate(Sender: TObject);
begin
	CloseAction.Enabled := not FWork;
end;

procedure TEditorForm.UndoActionUpdate(Sender: TObject);
begin
	UndoAction.Enabled := (GetActiveControlHandle <> 0)
												and (SendMessage(GetActiveControlHandle, EM_CANUNDO, 0, 0) <> 0)
												and (not FWork);
end;

procedure TEditorForm.CutActionUpdate(Sender: TObject);
var
	Selection: TSelection;
	AHandle: THandle;
begin
	AHandle := GetActiveControlHandle;
	SendMessage(AHandle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
	CutAction.Enabled := (AHandle <> 0)
										and ((Selection.EndPos - Selection.StartPos) <> 0)
										and (not FWork);
end;

procedure TEditorForm.CopyActionUpdate(Sender: TObject);
var
	Selection: TSelection;
	AHandle: THandle;
begin
	AHandle := GetActiveControlHandle;
	SendMessage(AHandle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
	CopyAction.Enabled := (AHandle <> 0)
										and ((Selection.EndPos - Selection.StartPos) <> 0)
										and (not FWork);
end;

procedure TEditorForm.PasteActionUpdate(Sender: TObject);
begin
	PasteAction.Enabled := (GetActiveControlHandle <> 0)
											and (Clipboard.HasFormat(CF_TEXT))
											and (not FWork);
end;

procedure TEditorForm.TopActionUpdate(Sender: TObject);
begin
 	TopAction.Enabled := not FWork;
end;

procedure TEditorForm.SageCheckBoxClick(Sender: TObject);
begin
	if SageCheckBox.Checked then begin
		if AnsiPos('sage', GetMailText) = 0 then
			SetMailText('sage' + GetMailText);
	end else begin
		if AnsiPos('sage', GetMailText) <> 0 then
			SetMailText(StringReplace(GetMailText, 'sage', '', [rfReplaceAll]));
	end;
end;

procedure TEditorForm.MailComboBoxChange(Sender: TObject);
begin
	if AnsiPos('sage', GetMailText) = 0 then
		SageCheckBox.Checked := False
	else
		SageCheckBox.Checked := True;
end;

procedure TEditorForm.IdLogDebugReceive(ASender: TIdConnectionIntercept;
  var ABuffer: TIdBytes); // for Indy10
begin
	try
		FDebugStrReceive := FDebugStrReceive + BytesToString(ABuffer);
//{$IFDEF DEBUG}
//    DebugLog(BytesToString(ABuffer));
//{$ENDIF}
	finally
	end;
end;

procedure TEditorForm.IdLogDebugSend(ASender: TIdConnectionIntercept;
  var ABuffer: TIdBytes); // for Indy10
begin
	try
		FDebugStrSend := FDebugStrSend + BytesToString(ABuffer);
//{$IFDEF DEBUG}
//    DebugLog(BytesToString(ABuffer));
//{$ENDIF}
	finally
	end;
end;

procedure TEditorForm.TransActionExecute(Sender: TObject);
begin
	AlphaBlend := TransAction.Checked;
	// ��������Ԃ̕ۑ�
	GikoSys.Setting.EditWindowTranslucent := TransAction.Checked;
end;

procedure TEditorForm.TransActionUpdate(Sender: TObject);
begin
	TransAction.Enabled := not FWork;
end;
//StatusBar��Panels[0]�̕����ρB�c����Œ�ɂ���
procedure TEditorForm.StatusBarResize(Sender: TObject);
begin
	StatusBar.Panels[0].Width := StatusBar.Width
									- StatusBar.Panels[1].Width - StatusBar.Panels[2].Width;

end;

//Form��Active�ɂȂ�����ŏI�������ݎ��Ԃ�ǂݍ���
procedure TEditorForm.FormActivate(Sender: TObject);
begin
	if ( FSambaTimer.Enabled ) and ( FThreadItem <> nil ) then
    begin
		FNow := FSambaTimer.Update;
    end;
	if GikoSys.Setting.GestureEnabled then begin
		GikoSys.Setting.Gestures.ClearGesture;
		GikoSys.Setting.Gestures.LoadGesture(
			GikoSys.Setting.GetGestureFileName, ActionList );
		MouseGesture.UnHook;
		MouseGesture.OnGestureStart := OnGestureStart;
		MouseGesture.OnGestureMove := OnGestureMove;
		MouseGesture.OnGestureEnd := OnGestureEnd;
		MouseGesture.SetHook( Handle );
	end;
end;
procedure TEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
	CanClose := not FWork;
end;

procedure TEditorForm.QuotePasteActionExecute(Sender: TObject);
var
	s			: TStringList;
	i			: Integer;
	quote	: string;
begin

	quote	:= GikoSys.GetOEIndentChar;

	if (FUseUC = True) then begin
		BodyEditUC.QuotePaste(quote);
	end else begin
		s			:= TStringList.Create;
		try
			s.Text	:= Clipboard.AsText;

			for i := s.Count - 1 downto 0 do
				s[ i ]	:= quote + s[ i ];

			BodyEdit.SelText    := s.Text;
		finally
			s.Free;
		end;
	end;
end;

procedure TEditorForm.SpaceToNBSPActionExecute(Sender: TObject);
begin
	GikoSys.Setting.SpaceToNBSP := SpaceToNBSPAction.Checked;
	if EditorPage.ActivePage = PreviewTab then
		Preview2;
end;

procedure TEditorForm.AmpToCharRefActionExecute(Sender: TObject);
begin
	GikoSys.Setting.AmpToCharRef := AmpToCharRefAction.Checked;
	if EditorPage.ActivePage = PreviewTab then
		Preview2;
end;

procedure TEditorForm.BoardTopClick(Sender: TObject);
var
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GikoSys.Setting.GetFileName);
	try
		BoardtopTab.TabVisible := BoardTop.Checked;
		ini.WriteBool('EditorForm', 'BoardTopTab', BoardtopTab.TabVisible);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;


procedure TEditorForm.GetSETTINGTXTActionExecute(Sender: TObject);
var
	memStream: TMemoryStream;
	URL, RefURL: string;
	settingBody: TStringList;
	tmpBoard: TBoard;
begin
	if not FWork then begin
		FWork := True;

		tmpBoard := GetBoard;
		if tmpBoard <> nil then begin

			RefURL	:= tmpBoard.URL;
			if RefURL[Length(RefURL)] <> '/' then
				URL	:= RefURL + '/' + 'SETTING.TXT'
			else
				URL	:= RefURL + 'SETTING.TXT';
			Screen.Cursor := crHourGlass;
			memStream := TMemoryStream.Create;
			try
				try
					StatusBar.Panels[0].Text := 'SETTING.TXT�_�E�����[�h��';
					GetWebData(URL, RefURL, tmpBoard.SETTINGTXTTime, memStream);
					if( Indy.ResponseCode = 200 ) then begin
						settingBody := TStringList.Create;
						try
							memStream.Seek(0, soFromBeginning);
							settingBody.LoadFromStream(memStream);
							settingBody.SaveToFile(tmpBoard.GetSETTINGTXTFileName);
							tmpBoard.SETTINGTXTTime := Indy.Response.LastModified;
							tmpBoard.IsSETTINGTXT := true;
							tmpBoard.TitlePictureURL := GetTitlePictureURL(settingBody, tmpBoard);
							tmpBoard.Modified := true;
						finally
							settingBody.Free;
						end;
						StatusBar.Panels[0].Text := 'SETTING.TXT�擾����(' + IntToStr(Indy.ResponseCode) + ')';
					end;
				except
					on E: EIdException do begin
						if( AnsiPos('304', E.Message) > 0 ) then
							StatusBar.Panels[0].Text := 'SETTING.TXT�X�V����(' + IntToStr(Indy.ResponseCode) + ')'
						else
							StatusBar.Panels[0].Text := 'SETTING.TXT�擾�G���[(' + IntToStr(Indy.ResponseCode) + ')';
					end;
				end;
			finally
				memStream.Free;
				Screen.Cursor := crDefault;
			end;
			ShowBoardInformation(tmpBoard, BoardInformationMemo);
		end;
		FWork := False;
	end;
end;

procedure TEditorForm.ShowBoardInformation(ABoard: TBoard; AMemo: TMemo);
var
	body: TStringList;
	UCType: Integer;    // 0:�s���A1:�Ή��A-1:��Ή�
begin
	UCType := 0;
	AMemo.Clear;
	AMemo.Lines.Add('[SETTING.TXT]');
	if ABoard.IsSETTINGTXT then begin
		if FileExists(ABoard.GetSETTINGTXTFileName)  then begin
			AMemo.Lines.Add(DateTimeToStr(ABoard.SETTINGTXTTime) + ' �X�V');
			body := TStringList.Create;
			try
				body.LoadFromFile(ABoard.GetSETTINGTXTFileName);
				AMemo.Lines.AddStrings(body);
			finally
				body.Free;
			end;
			if (Pos('BBS_UNICODE=pass', AMemo.Text) > 0) then
				UCType := 1
			else if (Pos('BBS_UNICODE=', AMemo.Text) > 0) then
				UCType := -1;
		end else begin
			ABoard.IsSETTINGTXT := false;
			ABoard.SETTINGTXTTime := ZERO_DATE;
			AMemo.Lines.Add('Local�ɕۑ����ꂽSETTING.TXT��������܂���');
			AMemo.Lines.Add('���j���[���Ď擾���Ă��������B');
		end;
	end else begin
		AMemo.Lines.Add('SETTING.TXT���擾���Ă��܂���B');
		AMemo.Lines.Add('���j���[���擾���Ă��������B');
	end;

	case UCType of
		-1: begin
			UCInfoPanel.Caption := 'Unicode��Ή���';
			UCInfoPanel.Color := clRed;
			UCInfoPanel.Hint := '���̔�Unicode�ł̃��X�ɑΉ����Ă��܂���B';
		end;
		0: begin
			UCInfoPanel.Caption := 'Unicode�Ή��s��';
			UCInfoPanel.Color := clBtnFace;
			UCInfoPanel.Hint := '�����擾���Ă��������B';
		end;
		1: begin
			UCInfoPanel.Caption := 'Unicode�Ή���';
			UCInfoPanel.Color := clLime;
			UCInfoPanel.Hint := '���̔�Unicode�ł̃��X�ɑΉ����Ă��܂��B';
		end;
	end;
end;
function TEditorForm.GetTitlePictureURL(body: TStringList; ABoard: TBoard): string;
//BBS_TITLE_PICTURE=
//BBS_FIGUREHEAD=
var
	i: Integer;
	tmp: string;
begin
	Result := '';
	for i := 0 to body.Count - 1 do begin
		if (AnsiPos('BBS_TITLE_PICTURE=', body[i]) > 0) or
		   (AnsiPos('BBS_FIGUREHEAD=', body[i]) > 0) then begin
			tmp := body[i];
			Delete(tmp, 1, AnsiPos('=', tmp));
			if AnsiPos('../', tmp) > 0 then begin
				tmp := CustomStringReplace(tmp, '../', GikoSys.UrlToServer(ABoard.URL));
			end;
			Result := tmp;
			Exit;
		end;
	end;
end;

procedure TEditorForm.GetTitlePictureActionUpdate(Sender: TObject);
begin
	if FThreadItem = nil then
		GetTitlePictureAction.Enabled :=  FBoard.IsSETTINGTXT
	else
		GetTitlePictureAction.Enabled :=  FThreadItem.ParentBoard.IsSETTINGTXT;

	if GetTitlePictureAction.Enabled Then begin
		// ���s���͎��s�s��
		GetTitlePictureAction.Enabled := not FWork;
	end;
end;

procedure TEditorForm.GetTitlePictureActionExecute(Sender: TObject);
var
	memStream: TMemoryStream;
	tmpBoard: TBoard;
begin
	if FWork then
		Exit;

	FWork := True;
	memStream := TMemoryStream.Create;
	try
        tmpBoard := GetBoard;

		if (tmpBoard <> nil) and (tmpBoard.TitlePictureURL <> '') then begin
			StatusBar.Panels[0].Text := '�g�b�v�摜�_�E�����[�h��';
			Screen.Cursor := crHourGlass;
			try
				// URL���w�肵�ă������ɓǂݍ���
				GetWebData(tmpBoard.TitlePictureURL, tmpBoard.URL,
								ZERO_DATE, memStream);
				if Indy.ResponseCode = 200 then begin
					memStream.SaveToFile(tmpBoard.GetTitlePictureFileName);
					ShowTitlePicture();
					tmpBoard.Modified := true;
				end;
				StatusBar.Panels[0].Text := '�g�b�v�摜 (' + IntToStr(Indy.ResponseCode) + ')';
			except
			end;
		end;
	finally
		memStream.Free;
		FWork := False;
		Screen.Cursor := crDefault;
	end;
end;
{
\brief  URL�̃f�[�^��stream�ɓǂݍ���
\param  URL �ǂݍ��ސ�
\param  RefURL   referer�ɐݒ肷��
\param  Modified    Modified�ɐݒ肷��
\param  stream  �ǂݍ��񂾃f�[�^�̕ۑ���
}
procedure TEditorForm.GetWebData(const URL: string; const RefURL: string;
			Modified: TDateTime; stream: TStream);
begin
	TIndyMdl.InitHTTP(Indy);
	Indy.Request.AcceptEncoding := '';
	Indy.Request.Referer := RefURL;
	Indy.Request.LastModified := Modified;

	//IdAntiFreeze.Active := True;
	IndyMdl.StartAntiFreeze(100); // for Indy10
	try
		Indy.Get(URL, stream);
	finally
		//IdAntiFreeze.Active := False;
		IndyMdl.EndAntiFreeze;    // for Indy10
	end;

end;
procedure TEditorForm.ShowTitlePicture();
var
	tmpBoard: TBoard;
	s: String;
begin
    tmpBoard := GetBoard;

	if FileExists(tmpBoard.GetTitlePictureFileName) then begin
		TitlePictureBrowser.Navigate(tmpBoard.GetTitlePictureFileName);
	end else begin
		s := '�g�b�v�摜���擾�ł��B<br>���j���[���擾���Ă��������B';
		SetContent(s, TitlePictureBrowser);
	end;
end;

function TEditorForm.GetFusianaName(body: TStringList; ABoard: TBoard): String;
var
	i: Integer;
	tmp: string;
begin
	for i := 0 to body.Count - 1 do begin
		if (AnsiPos('BBS_NONAME_NAME=', body[i]) > 0) then begin
			tmp := body[i];
			Delete(tmp, 1, AnsiPos('=', tmp));
			Result := tmp;
			Exit;
		end;
	end;
end;

procedure TEditorForm.GetHeadTXTActionExecute(Sender: TObject);
var
	URL, RefURL: string;
	settingBody: TStringList;
	tmpBoard: TBoard;
	memStream: TMemoryStream;
begin
    if not FWork then begin
        FWork := True;

        tmpBoard := GetBoard;
        if (tmpBoard <> nil) then begin

            RefURL	:= tmpBoard.URL;
            if RefURL[Length(RefURL)] <> '/' then
                URL	:= RefURL + '/' + 'head.txt'
            else
                URL	:= RefURL + 'head.txt';

            Screen.Cursor := crHourGlass;
            memStream := TMemoryStream.Create;
            try
                StatusBar.Panels[0].Text := '���[�J�����[��(head.txt)�_�E�����[�h��';
                try
                    GetWebData(URL, RefURL, tmpBoard.HEADTXTTime, memStream);
                    if( Indy.ResponseCode = 200 ) then begin
                        settingBody := TStringList.Create;
                        try
                            memStream.Seek(0, soFromBeginning);
                            settingBody.LoadFromStream(memStream);
                            settingBody.Insert(0, '<HTML lang="ja"><HEAD>');
                            settingBody.Insert(1, '<META http-equiv="Content-Type" content="text/html; charset=Shift_JIS">');
                            settingBody.Insert(2, '<TITLE>' + tmpBoard.Title + '</TITLE>');
                            settingBody.Insert(3, '<base href="' + RefURL + '"></HEAD><BODY>');
                            settingBody.Add('</BODY></HTML>');
                            settingBody.SaveToFile(tmpBoard.GETHEADTXTFileName);
                            tmpBoard.HEADTXTTime := Indy.Response.LastModified;
                            tmpBoard.IsHEADTXT := true;
                            tmpBoard.Modified := true;
                        finally
                            settingBody.Free;
                        end;
                        StatusBar.Panels[0].Text := '���[�J�����[���擾����(' + IntToStr(Indy.ResponseCode) + ')';
                    end;
                except
                    on E: EIdException do begin
                        if( AnsiPos('304', E.Message) > 0 ) then
                            StatusBar.Panels[0].Text := '���[�J�����[���X�V����(' + IntToStr(Indy.ResponseCode) + ')'
                        else
                            StatusBar.Panels[0].Text := '���[�J�����[���擾�G���[(' + IntToStr(Indy.ResponseCode) + ')';
                    end;
                end;
            finally
                memStream.Free;
                Screen.Cursor := crDefault;
            end;
            if tmpBoard.IsHEADTXT then begin
                ShowBoardHead(tmpboard, LocalEdit);
            end;
        end;
        FWork := False;
    end;

end;

procedure TEditorForm.CalcCapacityActionExecute(Sender: TObject);
var
	Board: TBoard;
	body: String;
begin
	body := GetBody;
	//�ǂ����A���s������Ă����ۂ����ǁA�{�����悭������Ȃ��B
	Board := GetBoard;

	if Board.BoardPlugIn <> nil then
		body := CustomStringReplace(body, #13#10, '<br>')
	else
		body := CustomStringReplace(body, #13#10, ' <br> ');
	StatusBar.Panels[0].Text := '�e��:' + IntToStr(Length(body)) + ' byte';
end;

procedure TEditorForm.LocalRuleClick(Sender: TObject);
var
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GikoSys.Setting.GetFileName);
	try
		RocalRuleTab.TabVisible := LocalRule.Checked;
		ini.WriteBool('EditorForm', 'LocalRuleTab', RocalRuleTab.TabVisible);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

procedure TEditorForm.FormDeactivate(Sender: TObject);
begin
	if GikoSys.Setting.GestureEnabled then begin
		GikoSys.Setting.Gestures.ClearGesture;
		MouseGesture.UnHook;
		MouseGesture.OnGestureStart := nil;
		MouseGesture.OnGestureMove := nil;
		MouseGesture.OnGestureEnd := nil;
    end;
end;

procedure TEditorForm.OnGestureStart(Sender: TObject);
begin
///
end;

procedure TEditorForm.OnGestureMove(Sender: TObject);
var
	s: string;
	Action: TAction;
	ActStr: string;
begin
	s := MouseGesture.GetGestureStr;
	ActStr := '';
	Action := GikoSys.Setting.Gestures.GetGestureAction(s);
	if Action <> nil then
		ActStr := '�i' + Action.Caption + '�j';
	s := '�W�F�X�`���[: ' + s + ActStr;
	StatusBar.Panels[0].Text := s;
end;

procedure TEditorForm.OnGestureEnd(Sender: TObject);
var
	s: string;
	Action: TAction;
begin
	s := MouseGesture.GetGestureStr;
	MouseGesture.Clear;
	Action := GikoSys.Setting.Gestures.GetGestureAction(s);
	if Action <> nil then
		Action.Execute;
	StatusBar.Panels[0].Text := '';
end;

procedure TEditorForm.ShowBoardHead(ABoard: TBoard; AMemo: TMemo);
var
	range: OleVariant;
begin
	//�Q�l��
	//http://www.campus.ne.jp/~ishigami/CREATION/TECHNIC/WEBAP-2.htm
	WebBrowser1.Navigate(ABoard.GETHEADTXTFileName);
	//���^�����O���x������TXT�Ɉڂ��Ȃ��B�ʂ��orz
	//���̂悤�ɂ����Ɠǂݍ��݂��I����Ă��邩�A�`�F�b�N����΂����񂾂�B
	//����ł����܂����B���肪�Ƃ��������܂����B
	while (WebBrowser1.ReadyState <> READYSTATE_COMPLETE) and
			(WebBrowser1.ReadyState <> READYSTATE_INTERACTIVE) do begin
		Application.ProcessMessages;
	end;

	try
	;
		range := OleVariant(WebBrowser1.Document).body.createTextRange;
		LocalEdit.Text := range.text;
	except
	end;
end;

procedure TEditorForm.LocalRuleBrowseClick(Sender: TObject);
var
	URL: String;
	ABoard: TBoard;
begin
	ABoard := GetBoard;

	if ABoard = nil
		then Exit;

	URL := ABoard.GETHEADTXTFileName;
	GikoSys.OpenBrowser(URL, gbtAuto);
end;

procedure TEditorForm.SaveNameMailActionExecute(Sender: TObject);
begin
	SaveNameMailAction.Checked := not SaveNameMailAction.Checked;
	KotehanCheckBox.Enabled := SaveNameMailAction.Checked;
end;

function TEditorForm.LFusianaGet(const s: String): Boolean;
const
	FUSIANA = 'fusianasan';
var
	i: Integer;
begin
	i := AnsiPos(FUSIANA, s);
	Result := (i > 0);
end;

procedure TEditorForm.BeLogInOutEActionExecute(Sender: TObject);
begin
	GikoDM.BeLogInOutAction.Execute;
end;

procedure TEditorForm.BeLogInOutEActionUpdate(Sender: TObject);
begin
	BeLogInOutEAction.Checked := GikoDM.BeLogInOutAction.Checked;
	BeLogInOutEAction.Enabled := GikoDM.BeLogInOutAction.Enabled;
end;
// Cookie�̎擾
procedure TEditorForm.GetCookie(CookieMng: TIdCookieManager; ABoard: TBoard);
const
	VAL_SPID	= 'SPID';
	VAL_PON		= 'PON';
	VAL_HAP     = 'HAP';
var
	i : Integer;
	//Cookie : TIdCookieRFC2109;
	Cookie : TIdCookie;     // for Indy10
	curCookies : TStringList;
begin
	// 2008.12.14 �������N���A���Ă͂����Ȃ� by ������
	curCookies := TStringList.Create;
	curCookies.Delimiter := ';';
	curCookies.DelimitedText := ABoard.Cookie;
	curCookies.Sort;
	curCookies.Duplicates := dupIgnore;
	ABoard.Cookie := '';
	try
		for i := 0 to CookieMng.CookieCollection.Count - 1 do begin
			Cookie := TIdCookie(CookieMng.CookieCollection.Items[i]);
			if ( Cookie.CookieName = VAL_PON ) then begin
				ABoard.PON := Cookie.Value;
				//ABoard.Expires := GMTToLocalDateTime(Cookie.Expires);
				ABoard.Expires := Cookie.Expires;   // for Indy10
			end else if ( Cookie.CookieName = VAL_SPID ) then begin
				ABoard.SPID := Cookie.Value;
				//ABoard.Expires := GMTToLocalDateTime(Cookie.Expires);
				ABoard.Expires := Cookie.Expires;   // for Infy10
			end else if ( Cookie.CookieName = VAL_HAP ) then begin
				// HAP�폜�p��Cookie���z�z�����̂ŁA�L���������`�F�b�N����
				//if CompareDateTime(GMTToLocalDateTime(Cookie.Expires) ,Now) > 0 then begin
				if CompareDateTime(Cookie.Expires ,Now) > 0 then begin  // for Indy10
					GikoSys.SetBoukenCookie(Cookie.Value, Cookie.Domain);
					// �`���̏��̕ۑ�
					GikoSys.Setting.WriteBoukenSettingFile;
				end;
			end else begin
				if Length( curCookies.Values[ Cookie.CookieName ] ) > 0 then begin
					// �����l�̕t���ւ�
					curCookies[curCookies.IndexOfName(Cookie.CookieName)] :=
								Cookie.ClientCookie;
				end else begin
					// �ǉ�
					curCookies.Add(Cookie.ClientCookie);
				end;
			end;
		end;
		for i := 0 to curCookies.Count - 1 do begin
			if (curCookies[i] <> '') then begin
				ABoard.Cookie := ABoard.Cookie + curCookies[i] + '; ';
			end;
		end;
	finally
		CookieMng.CookieCollection.Clear;
		curCookies.Free;
	end;
end;
//! hidden�f�[�^�擾
procedure TEditorForm.GetHiddenParameter(Rawtext: String; ABoard: TBoard);
const
    INPUT_MARK = '<input type=hidden' ; // �啶���������΂�΂�Ȃ��Ƃɒ���
    VALUE_MARK = 'value=' ;              // �啶���������΂�΂�Ȃ��Ƃɒ���
    NAME_MARK  = 'name=' ;               // �啶���������΂�΂�Ȃ��Ƃɒ���
    IGNORE_NAMES : array[0..6] of String =
        ('subject', 'from', 'mail', 'message', 'bbs', 'time', 'key');
var
    tmp, line, name, value, lname : String;
    pos, pose, i : Integer;
begin
    tmp := AnsiLowerCase(Rawtext);
    pos := AnsiPos(INPUT_MARK, tmp);
    while  (pos > 0 ) do begin
        tmp := Copy(Rawtext, pos + Length(INPUT_MARK), Length(tmp));
        Delete(Rawtext, 1, pos+ Length(INPUT_MARK) - 1);
        pose := AnsiPos('>', tmp);
        // name=xxx value=yyy ���؂�o�����
        line := Copy(tmp, 1, pose - 1);
        name := '';
        value := '';
        pos := AnsiPos(NAME_MARK, tmp);
        if (pos > 0) then begin
            name := Copy(Rawtext, pos + Length(NAME_MARK), Length(line));
            //���p"�Ŏn�܂��Ă��邩
            if AnsiPos('"', name) = 1 then begin
                // ���p"�܂ł��R�s�[
                Delete(name, 1, 1);
                pose := AnsiPos('"', name);
                if (pose > 0) then begin
                    Delete(name, pose, Length(name));
                end else begin
                    pose := AnsiPos(' ', name);
                    if (pose > 0) then begin
                        Delete(name, pose, Length(name));
                    end;
                end;
            end else begin
                pose := AnsiPos(' ', name);
                if (pose > 0) then begin
                    Delete(name, pose, Length(name));
                end;
            end;
        end;
        lname := AnsiLowerCase(name);
        for i := 0 to Length(IGNORE_NAMES) do begin
            if lname = IGNORE_NAMES[i] then begin
                name := '';
                break;
            end;
        end;
        pos := AnsiPos(VALUE_MARK, tmp);
        if (name <> '') and (pos > 0) then begin
            value := Copy(Rawtext, pos + Length(VALUE_MARK), Length(line));
            //���p"�Ŏn�܂��Ă��邩
            if AnsiPos('"', value) = 1 then begin
                // ���p"�܂ł��R�s�[
                Delete(value, 1, 1);
                pose := AnsiPos('"', value);
                if (pose > 0) then begin
                    Delete(value, pose, Length(value));
                end else begin
                    pose := AnsiPos(' ', value);
                    if (pose > 0) then begin
                        Delete(value, pose, Length(value));
                    end;
                end;
            end else begin
                pose := AnsiPos(' ', value);
                if (pose > 0) then begin
                    Delete(value, pose, Length(name));
                end;
            end;
        end;
        if (name <> '') then begin
            ABoard.Cookie := ABoard.Cookie + name + '=' + value + '; '; 

        end;
        Delete(tmp, 1, Length(line));
        Delete(Rawtext, 1, Length(line));
        pos := AnsiPos(INPUT_MARK, tmp);
    end;
end;

//! �T���o�X�V�̃A�N�V������Update�C�x���g�@�ȒP�̂��߃^�C�}�[�Ɠ����ɂ��Ă���
procedure TEditorForm.UpdateSambaActionUpdate(Sender: TObject);
begin
	UpdateSambaAction.Enabled := FSambaTimer.Enabled;
end;

//! �T���o�X�V�A�N�V����
procedure TEditorForm.UpdateSambaActionExecute(Sender: TObject);
var
	input : String;
	i : Integer;
begin
	if InputQuery('Samba24�ݒ�l�X�V', '�V�����ݒ�l����͂��Ă�������', input) then begin
		input := ZenToHan(input);
		if GikoSys.IsNumeric(input) then begin
			FSambaTimer.UpdateSambaSetting(StrToInt(input));
			UpdateSambaStatus;
			//�S�Ẵt�H�[������ASamba�^�C�}�[���X�V����
			for i := 0 to Screen.FormCount - 1 do begin
				if Screen.Forms[i] is TEditorForm then begin
					TEditorForm(Screen.Forms[i]).FSambaTimer.Update;
					TEditorForm(Screen.Forms[i]).UpdateSambaStatus;
				end;
			end;
		end else begin
			ShowMessage('���l����͂��Ă�������');
			UpdateSambaActionExecute(Sender);
		end;
	end;
end;

procedure TEditorForm.UpdateSambaStatus;
begin
	if (FSambaTimer.Enabled) then begin
		StatusBar.Panels[2].Text
					:= 'Samba24�K��l' + IntToStr(FSambaTimer.SambaInterval);
	end;
end;

procedure TEditorForm.InputAssistActionExecute(Sender: TObject);
var
	count, i : Integer;
	item : TMenuItem;
	point: TPoint;
	Bitmap : TBitmap;
	TextWidth, ItemWidth, tmpWidth, EditW, EditT: Integer;
begin
	if FInputAssistKey = '' then Exit;

	InputAssistPopupMenu.Items.Clear;

	if (FResistWords = nil) then begin
		FResistWords := TStringList.Create;
	end else begin
		FResistWords.Clear;
	end;

	if (GetKeyState( VK_SHIFT ) < 0) then begin
		// �V�t�g��������Ă���΁A�L�[�Ŏn�܂�J�e�S��
		count :=
			InputAssistDM.GetStartWithCategoryResistWords(
									FInputAssistKey, FResistWords);
	end else begin
		// �V�t�g�������̂ŁA�L�[�Ŏn�܂�L�[
		count :=
			InputAssistDM.GetStartWithKeyResistWords(
									FInputAssistKey, FResistWords);
	end;
	Bitmap := TBitmap.Create;
	try
		if (FUseUC = True) then
			Bitmap.Canvas.Font.Assign(BodyEditUC.Font)
		else
			Bitmap.Canvas.Font.Assign(BodyEdit.Font);
		// �}�[�W��5px
		TextWidth := Bitmap.Canvas.TextWidth(FInputAssistKey) + 5;
		ItemWidth := 0;
		for i := 0 to count - 1 do begin
			item := TMenuItem.Create(nil);
			item.Break := mbNone;
			item.Caption := FResistWords[i];
			item.Tag := i;
			item.OnClick := InputAssistMenuClick;
			InputAssistPopupMenu.Items.Add(item);

			tmpWidth := Bitmap.Canvas.TextWidth(Item.Caption);
			if (tmpWidth > ItemWidth) then begin
				ItemWidth := tmpWidth;
			end;
		end;
	finally
		Bitmap.Free;
	end;

	if (count > 0) then begin
		if (FUseUC = True) then begin
			EditW := BodyEditUC.Width;
			EditT := BodyEditUC.Top;
		end else begin
			EditW := BodyEdit.Width;
			EditT := BodyEdit.Top;
		end;
		GetCaretpos(point);
		point.X := point.X + Self.Left + (Self.Width - EditW) div 2;
		point.Y := point.Y + Self.Top + (Self.Height - Self.ClientHeight);

		if Screen.DesktopWidth >
			(point.X + TextWidth + ItemWidth) then begin
			InputAssistPopupMenu.Popup(
				point.X + TextWidth,
				point.Y + EditorPage.Top + EditorPage.TabHeight + EditT);
		end else begin
			InputAssistPopupMenu.Popup(
				point.X - TextWidth - ItemWidth,
				point.Y + EditorPage.Top + EditorPage.TabHeight + EditT);
		end;
	end;
end;

procedure TEditorForm.InputAssistMenuClick(Sender: TObject);
var
	text : String;
	IMC: HIMC;
	EditHandle: HWND;
begin
	if not (Sender is TMenuItem) then Exit;

	if (FResistWords <> nil) then begin
		if (FUseUC = True) then
			EditHandle := BodyEditUC.Handle
		else
			EditHandle := BodyEdit.Handle;
		try
			text :=
				TResistWord(FResistWords.Objects[TMenuItem(Sender).Tag]).GetText;
		except
			text := '';
		end;
		IMC := ImmGetContext(EditHandle); //�R���e�L�X�g�擾
		try
			ImmNotifyIME(IMC, NI_COMPOSITIONSTR, CPS_CANCEL, 0);
		finally
			ImmReleaseContext(EditHandle, IMC);  //�R���e�L�X�g���
		end;

		FResistWords.Clear;
		FInputAssistKey := '';
	end;
	if (FUseUC = True) then
		BodyEditUC.InsertText(text)
	else
		InsertText(BodyEdit, text);
end;

//! TMemo�̃J�[�\���ʒu�ɕ�����}��
procedure TEditorForm.InsertText(Memo: TMemo; Text: String);
var
	line, sel, pos: Integer;
	left, right : String;
begin
	Memo.Lines.BeginUpdate;
	line := SendMessage(Memo.Handle,EM_LINEFROMCHAR,-1,0);  //�s
	sel := Memo.SelStart;
	pos	:= sel - SendMessage(Memo.Handle, EM_LINEINDEX, -1, 0); //��
	if (pos > 0) then begin
		left := Copy(Memo.Lines[line], 0, pos);
	end else begin
		left := '';
	end;
	right := Copy(Memo.Lines[line], pos + 1, Length(Memo.Lines[line]));
	Memo.Lines.Strings[line] := left + Text + right;
	Memo.Lines.EndUpdate;
	//�@�L�����b�g�̈ʒu���X�V����
	Memo.SelStart := sel + Length(text);
	// �L�����b�g�̈ʒu�܂ŃX�N���[��
	Memo.Perform(EM_SCROLLCARET, 0, 0);

end;

procedure TEditorForm.ApplicationEvents1Message(var Msg: tagMSG;
	var Handled: Boolean);
var
	wmMsg: TWMKey;
	IMC: HIMC;
	Len: integer;
	Str: string;
	EditHandle: HWND;
begin
	if (Self.Active) then begin
		case Msg.message of
			//�L�[�����̂ݎ󂯎��
			WM_KEYDOWN:
			begin
				// �^�u���h�ҏW�h��Ctrl�L�[��������Ă���̂��m�F����
				if (EditorPage.ActivePageIndex = 0)
						and (GetKeyState( VK_CONTROL ) < 0) then begin
					wmMsg.Msg := Msg.message;
					wmMsg.CharCode := Word(Msg.wParam);
					wmMsg.KeyData := Msg.lParam;
					if (wmMsg.CharCode = 229) and (wmMsg.KeyData = 3735553) then begin
						if (FUseUC = True) then
							EditHandle := BodyEditUC.Handle
						else
							EditHandle := BodyEdit.Handle;
						IMC := ImmGetContext(EditHandle); //�R���e�L�X�g�擾
						Len := ImmGetCompositionString(IMC, GCS_COMPSTR, nil, 0); //�܂��������擾
						if (Len > 0) then begin
							SetLength(Str, Len + 1); //Buffer�̃�������ݒ�
							ImmGetCompositionString(IMC, GCS_COMPSTR, PChar(Str), Len + 1); //�܂��������擾
							SetLength(Str, Len);
							FInputAssistKey := Str;
							InputAssistActionExecute(nil);
							Handled := True;
						end;
						ImmReleaseContext(EditHandle, IMC);  //�R���e�L�X�g���
					end;
				end;
			end;
		end;

	end;
end;

procedure TEditorForm.ShowInputAssistFormExecute(Sender: TObject);
var
	form : TInputAssistForm;
begin
	form := TInputAssistForm.Create(nil);
	try
		if TopAction.Checked then begin // �X�e�C��Ԃɐݒ�
			SetWindowPos(form.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
		end;
		form.SetUpFromEditor;
		if (form.ShowModal = mrOk) then begin
			if (FUseUC = True) then
			    BodyEditUC.InsertText(form.GetInsertText)
			else
			    InsertText(BodyEdit, form.GetInsertText);
		end;
	finally
		form.Release;
	end;
end;
//! Cookie���폜
procedure TEditorForm.ReleaseCookieActionExecute(Sender: TObject);
var
	Board : TBoard;
begin
	// �X���b�h�������@�X�����Ă̂Ƃ���FBoard�𒼐ڎg��
	Board := GetBoard;

	// �N�b�L�[�̏����̂Ă�
	Board.Cookie := '';
	Board.SPID := '';
	Board.PON  := '';
	// 0�Ɋ����߂�
	Board.Expires := 0;
end;
//! ���擾Update�C�x���g
procedure TEditorForm.GetSETTINGTXTActionUpdate(Sender: TObject);
begin
	// ���s���͎��s�s��
	GetSETTINGTXTAction.Enabled := not FWork;
end;
//! ���[�J�����[���擾Update�C�x���g
procedure TEditorForm.GetHeadTXTActionUpdate(Sender: TObject);
begin
	// ���s���͎��s�s��
	GetSETTINGTXTAction.Enabled := not FWork;
end;

//! Samba�^�C�}�[�C�x���g
procedure TEditorForm.SambaTimer(Sender: TObject);
begin

	if FSambaTimer.WriteDeta = ZERO_DATE then
		StatusBar.Panels[1].Text := '����'
	else begin
		FNow := IncMilliSecond(FNow, 500);
		StatusBar.Panels[1].Text :=
					Format('%8.0f�b�o��', [SecondSpan(FNow, FSambaTimer.WriteDeta)]);
	end;
end;
{
\brief �E�B���h�E�̈ʒu�ƃT�C�Y�̐ݒ�
}
procedure TEditorForm.SetWindowRect;
var
	wp: TWindowPlacement;
	MonCnt: Integer;
	MonOk: Boolean;
	MonR: Integer;
	MonB: Integer;
	Right: Integer;
	Bottom: Integer;
begin
	//�E�B���h�E�̈ʒu�ݒ�
	wp.length := sizeof(wp);
	wp.rcNormalPosition.Top := GikoSys.Setting.EditWindowTop;
	wp.rcNormalPosition.Left := GikoSys.Setting.EditWindowLeft;

	wp.rcNormalPosition.Bottom := GikoSys.Setting.EditWindowTop + GikoSys.Setting.EditWindowHeight;
	wp.rcNormalPosition.Right := GikoSys.Setting.EditWindowLeft + GikoSys.Setting.EditWindowWidth;
	wp.showCmd := SW_HIDE;
	SetWindowPlacement(Handle, @wp);

	if GikoSys.Setting.EditWindowMax then begin
		WindowState := wsMaximized;
	end;

	//�E�B���h�E����ʊO�Ȃ��ʓ��Ɉړ�����
	Right := Left + Width;
	Bottom := Top + Height;
	MonOk := False;
	MonCnt := 0;
	while (MonCnt < Screen.MonitorCount) do begin
		MonR := Screen.Monitors[MonCnt].Left + Screen.Monitors[MonCnt].Width;
		MonB := Screen.Monitors[MonCnt].Top  + Screen.Monitors[MonCnt].Height;

		if ((Left  >= Screen.Monitors[MonCnt].Left) and (Left   <  MonR) and
			(Top   >= Screen.Monitors[MonCnt].Top)  and (Top    <  MonB) and
			(Right  > Screen.Monitors[MonCnt].Left) and (Right  <= MonR) and
			(Bottom > Screen.Monitors[MonCnt].Top)  and (Bottom <= MonB)) then begin
			MonOk := True;
			Break;
		end;

		MonCnt := MonCnt + 1;
	end;

	if (MonOk = False) then begin
		Left := 0;
		Top := 0;
	end;

	//���݂̃E�B���h�E�̈ʒu��ۑ�
	GikoSys.Setting.EditWindowTop := Top  + WINDOWMOVE_V;   // ���ɊJ���E�B���h�E��
	GikoSys.Setting.EditWindowLeft := Left + WINDOWMOVE_H;  // �@�@�@�E�΂߉��ɂ��炷
	//�E�B���h�E�̕��ƍ�����������������Ό��ɖ߂�
	if GikoSys.Setting.EditWindowHeight < 144 then begin
		Height := 400;
    end;
	if GikoSys.Setting.EditWindowWidth < 144 then begin
		Width := 640;
	end;
end;
{
\brief �g���^�u�ݒ�
}
procedure TEditorForm.SetExtraTab;
const
    SECTION = 'EditorForm';
var
    ini: TMemIniFile;
begin
    ini := TMemIniFile.Create(GikoSys.Setting.GetFileName);
    try
        BoardtopTab.TabVisible := ini.Readbool(SECTION, 'BoardTopTab', False);
        BoardTop.Checked := BoardtopTab.TabVisible;
        RocalRuleTab.TabVisible := ini.ReadBool(SECTION, 'LocalRuleTab', False);
        LocalRule.Checked := RocalRuleTab.TabVisible;
    finally
        ini.Free;
    end;
end;
{
\brief �擾
\return ���X�G�f�B�^�����e���悤�Ƃ��Ă����
}
function TEditorForm.GetBoard : TBoard;
begin
    // �X���b�h�A�C�e����null�̎���FBoard
    if FThreadItem = nil then begin
        Result := FBoard;
    end else  begin
        Result := FThreadItem.ParentBoard;
    end;
end;
{
\brief  GikoForm�Ƀ��b�Z�[�W��ǉ�����
\param  icon    ���b�Z�[�W�ɂ��A�C�R��
}
procedure TEditorForm.AddFormMessageNew(icon: TGikoMessageIcon);
begin
    if FThreadItem = nil then begin
        GikoForm.AddMessageList(FBoard.Title + ' ' + GikoSys.GetGikoMessage(gmNewSure), nil, icon)
    end else begin
        GikoForm.AddMessageList(FThreadItem.Title + ' ' + GikoSys.GetGikoMessage(gmNewRes), nil, icon);
    end;

end;
{
\brief  ���[�J��fusiana�g���b�v
\return true:���M���~ false:���M
}
function TEditorForm.isLocalFusianaTrap: Boolean;
var
    Namae : string;
begin
    Result := False;
    if GikoSys.Setting.LocalTrapAtt then begin
        Namae := THTMLCreate.RepHtml(GetNameText);
        if (LFusianaGet(Namae)) or (Namae = '�R���') then begin
            if FusianaMsgBox = IDNO  then begin
                Result := True;
            end;
        end;
    end;
end;
{
\brief  �����[�gfusiana�g���b�v
\return true:���M���~ false:���M
}
function TEditorForm.isRemoteFusianaTrap: Boolean;
var
    Namae : string;
    Board : TBoard;
    Remote: string;
    body : TStringList;
begin
    Result := False;
    Namae := THTMLCreate.RepHtml(GetNameText);
    if (GikoSys.Setting.RemoteTrapAtt) and (Length(Namae) = 0) then begin
        Board := GetBoard;

        if Board = nil then Exit;

        if not FileExists(Board.GetSETTINGTXTFileName)  then begin
            //Setting.txt���Ȃ�������擾
            //�I�ɕ��ׂ������肻��...
            try
                GetSETTINGTXTAction.Execute;
            except
            end;
        end;

        Remote := '';
        if FileExists(Board.GetSETTINGTXTFileName)  then begin
            body := TStringList.Create;
            try
                body.LoadFromFile(Board.GetSETTINGTXTFileName);
                Remote := GetFusianaName(body, Board);
            finally
                body.Free;
            end;
        end;

        if LFusianaGet(Remote) then begin
            if FusianaMsgBox = IDNO  then begin
                Result := True;
            end;
        end;
    end;
end;
{
\brief  Header������擾
\param  ACOOKIE Cookie
\param  SPID    SPID
\param  PON    PON
\param  HAP     HAP
\param  Board   ��
\return Header������
}
function TEditorForm.getHeaderStr(const ACOOKIE: string; const SPID : string;
				const PON : string; const HAP : string; Board : TBoard) : string;
begin
	Result := ACOOKIE;

	if SPID <> '' then
		Result := Result + 'SPID=' + SPID + '; ';
	if PON <> '' then
		Result := Result + 'PON=' + PON + '; ';

	//�z�X�g��2ch�ŁABe��Login���Ă����BE�̃f�[�^�𑗂�
	//GikoSys.ParseURI( URL, Protocol,Host, Path, Document, Port, Bookmark );
	//if GikoSys.Is2chHost(Host) and GikoSys.Setting.BeLogin then
	if (Board.Is2ch) then begin
		// �Œ�̃N�b�L�[������ΐH�킹��
		if Length(GikoSys.Setting.FixedCookie) > 0 then begin
			// �z�X�g��2ch�̏ꍇ�C�Œ�̃N�b�L�[��H�킹��
			Result := Result + GikoSys.Setting.FixedCookie + '; ';
		end;
		if (GikoSys.Belib.Connected) then begin
			Result := Result + 'MDMD=' + GikoSys.Belib.MDMD + '; '
											+ 'DMDM=' + GikoSys.Belib.DMDM + '; ';
		end;
	end;

	//Result := 'Cookie: ' + Result + 'NAME=' + NameComboBox.Text + '; MAIL=' + MailComboBox.Text;
	Result := 'Cookie: ' + Result;
	if Board.Is2ch = False then   // ���T�����ł͕s�v�ɂȂ����炵��
		Result := Result + 'NAME=' + GetNameText + '; MAIL=' + GetMailText;

	if HAP <> '' then
    	Result := Result + '; HAP=' + HAP + '; ';

end;

{
\brief fusiana�x���_�C�A���O
\return IDYES �������� IDNO ���~
}
function TEditorForm.FusianaMsgBox: Integer;
const
	MSG_FUSIANA : string =	'�����[�g�z�X�g��\������@�\���g���Ă��܂�'#13#10 +
		'�������Ԉ���Ă��̕��@�Ńz�X�g���\�����ꂽ�Ƃ��Ă��A���ȐӔC�Ȃ̂ō폜�˗��ɂ͉����܂���B' +
		#13#10#13#10'�ӔC�𕉂����Ƃ��������ď������݂܂����H';
begin
	Result := MsgBox(Handle, MSG_FUSIANA, '���',
							MB_YESNO or MB_ICONQUESTION);
end;
{
\brief �A�����[�hON/OFF�؂�ւ�
}
procedure TEditorForm.ContinueModeActionExecute(Sender: TObject);
begin
	ContinueModeAction.Checked := not ContinueModeAction.Checked;
end;
{
\brief �A�����[�h�X�V����
}
procedure TEditorForm.ContinueModeActionUpdate(Sender: TObject);
begin
	// �X�����Ă̂Ƃ��͖���
	ContinueModeAction.Enabled := FThreadItem <> nil;
end;
{
\brief �������ޔ�/�X���b�h��\������
}
procedure TEditorForm.OpenSendTargetActionExecute(Sender: TObject);
begin
    if (FThreadItem <> nil) then begin
        // ���C�����X�V���Ă��܂��̂ŉ�ʂ��p�^�p�^�؂�ւ��̂�h�����߂�
        // �O�ʂŌŒ肷��
        if not (fsShowing in Self.FormState) then begin
            // �X�e�C��Ԃɐݒ�
            SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
        end;
        try
            // �X���b�h
            GikoForm.InsertBrowserTab(FThreadItem, True);
        finally
            if not TopAction.Checked then begin // �X�e�C��ԉ���
                SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
            end;
        end;
        Self.SetFocus;
    end else begin
        // ��
        GikoForm.SelectTreeNode(
            GetBoard, True );
    end;
end;
procedure TEditorForm.ReloadTargetActionExecute(Sender: TObject);
begin
    if (FThreadItem <> nil) then begin
        // �X���b�h
        // ���C�����X�V���Ă��܂��̂ŉ�ʂ��p�^�p�^�؂�ւ��̂�h�����߂�
        // �O�ʂŌŒ肷��(�_�E�����[�h����������Ɛ؂�ւ���Ă��܂���������߂�)
        if not (fsShowing in Self.FormState) then begin
            // �X�e�C��Ԃɐݒ�
            SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
        end;
        try
            GikoForm.DownloadContent(FThreadItem);
        finally
            if not TopAction.Checked then begin // �X�e�C��ԉ���
                SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
            end;
        end;
        Self.SetFocus;
    end else begin
        // ��
        GikoForm.DownloadList(GetBoard);
    end;
end;
//! �딚�`�F�b�N
function TEditorForm.isGobaku: Boolean;
const
	MSG_GOBAKU : string =
		'�\�����Ă���%s�Ɠ��e���%s���قȂ�܂��B'#13#10 +
		'���̂܂܏������݂܂����H';
var
	ThreadItem : TThreadItem;
	msg : String;

begin
    Result := False;
    // �I�v�V�����L�������X���M�ł̂ݗL��
    if (GikoSys.Setting.UseGobakuCheck) then begin
        // ���X���M
        if (FThreadItem <> nil) then begin
            ThreadItem := GikoForm.GetActiveContent(False);
            if (ThreadItem <> nil) then begin
                if (FThreadItem <> ThreadItem) then begin
                    msg := Format(MSG_GOBAKU, ['�X���b�h', '�X���b�h']);
                    Result := MsgBox(Handle, msg, '���', MB_YESNO or MB_ICONQUESTION) = IDNO;
                end;
            end else begin
                if GikoForm.ActiveList is TBBS then begin
                    if TBBS(GikoForm.ActiveList) <> FThreadItem.ParentBoard.ParentCategory.ParenTBBS then begin
                        msg := Format(MSG_GOBAKU, ['BBS', '�X���b�h�̏�������BBS']);
                        Result := MsgBox(Handle, msg, '���', MB_YESNO or MB_ICONQUESTION) = IDNO;
                    end;
                end else if GikoForm.ActiveList is TCategory then begin
                    if TCategory(GikoForm.ActiveList).FindThreadFromURL(FThreadItem.URL) = nil then begin
                        msg := Format(MSG_GOBAKU, ['�J�e�S��', '�X���b�h�̏�������J�e�S��']);
                        Result := MsgBox(Handle, msg, '���', MB_YESNO or MB_ICONQUESTION) = IDNO;
                    end;
                end else if GikoForm.ActiveList is TBoard then begin
                    if TBoard(GikoForm.ActiveList) <> FThreadItem.ParentBoard then begin
                        msg := Format(MSG_GOBAKU, ['��', '�X���b�h�̏��������']);
                        Result := MsgBox(Handle, msg, '���', MB_YESNO or MB_ICONQUESTION) = IDNO;
                    end;
                end;
            end;
        end else begin
            // �X������
            if GikoForm.ActiveList is TBBS then begin
                if TBBS(GikoForm.ActiveList) <> FBoard.ParentCategory.ParenTBBS then begin
                    msg := Format(MSG_GOBAKU, ['BBS', '�̏�������BBS']);
                    Result := MsgBox(Handle, msg, '���', MB_YESNO or MB_ICONQUESTION) = IDNO;
                end;
            end else if GikoForm.ActiveList is TCategory then begin
                if TCategory(GikoForm.ActiveList).FindBoardFromURL(FBoard.URL) = nil then begin
                    msg := Format(MSG_GOBAKU, ['�J�e�S��', '�̏�������J�e�S��']);
                    Result := MsgBox(Handle, msg, '���', MB_YESNO or MB_ICONQUESTION) = IDNO;
                end;
            end else if GikoForm.ActiveList is TBoard then begin
                if TBoard(GikoForm.ActiveList) <> FBoard then begin
                    msg := Format(MSG_GOBAKU, ['��', '��']);
                    Result := MsgBox(Handle, msg, '���', MB_YESNO or MB_ICONQUESTION) = IDNO;
                end;
            end;
        end;
    end;
end;

procedure TEditorForm.SetFocusEdit;
begin
	if (FUseUC = True) then
		BodyEditUC.SetFocus
	else
		BodyEdit.SetFocus;
end;

procedure TEditorForm.SetTextEdit(TextSrc: String);
begin
	if (FUseUC = True) then
		BodyEditUC.Text := TextSrc
	else
		BodyEdit.Text := TextSrc;
end;

//! �{��������擾
function TEditorForm.GetBodyText(): String;
var
  idx: Integer;
  max: Integer;
  empty: Boolean;
  line: String;
  encLines: TStringList;
begin
  encLines := TStringList.Create;
  try
    if FUseUC then begin
      encLines.LineBreak := #13#10;
      encLines.Text := BodyEditUC.EncodeText;
    end;

    max := ifThen(FUseUC, encLines.Count, BodyEdit.Lines.Count);
    if max < 1 then
      Exit;

    empty := True;
    for idx := max - 1 downto 0 do begin
      if FUseUC then
        line := encLines[idx]
      else
        line := BodyEdit.Lines[idx];
      if (empty = False) or (line <> '') then begin
        if empty = True then begin
          empty := False;
          Result := line;
        end else
          Result := line + #13#10 + Result;
      end;
    end;
  finally
    encLines.Free;
  end;
end;

//! ���O������擾
function TEditorForm.GetNameText: String;
begin
  if FUseUC then
    Result := NameComboBoxUC.EncodeText
  else
    Result := NameComboBox.Text;
end;

function TEditorForm.GetNameUTF8: UTF8String;
begin
  Result := UTF8Encode(GetNameText);
end;

//! ���O������ݒ�
procedure TEditorForm.SetNameText(Value: String);
begin
  if FUseUC then
    NameComboBoxUC.EncodeText := Value
  else
    NameComboBox.Text := Value;
end;

//! ���[��������擾
function TEditorForm.GetMailText: String;
begin
  if FUseUC then
    Result := MailComboBoxUC.EncodeText
  else
    Result := MailComboBox.Text;
end;

function TEditorForm.GetMailUTF8: UTF8String;
begin
  Result := UTF8Encode(GetMailText);
end;

//! ���[��������ݒ�
procedure TEditorForm.SetMailText(Value: String);
begin
  if FUseUC then
    MailComboBoxUC.EncodeText := Value
  else
    MailComboBox.Text := Value;
end;

//! �^�C�g��������擾
function TEditorForm.GetTitleText: String;
begin
  if FUseUC then
    Result := TitleEditUC.EncodeText
  else
    Result := TitleEdit.Text;
end;

function TEditorForm.GetTitleUTF8: UTF8String;
begin
  Result := UTF8Encode(GetTitleText);
end;




//{$IFDEF DEBUG}
//procedure DebugLog(msg: String);
//const
//  RET_CODE: String = #13#10;
//var
//  path: String;
//  dest: TFileStream;
//  dt: String;
//begin
//  path := ChangeFileExt(Application.ExeName, '.log');
//  if FileExists(path) then begin
//    dest := TFileStream.Create(path, fmOpenReadWrite);
//    dest.Seek(0, soFromEnd);
//  end else
//    dest := TFileStream.Create(path, fmCreate);
//
//  try
//    DateTimeToString(dt, 'yyyy/mm/dd hh:nn:ss.ZZZ ', Now);
//    dest.Write(PChar(dt)^, Length(dt));
//    dest.Write(PChar(msg)^, Length(msg));
//    dest.Write(PChar(RET_CODE)^, Length(RET_CODE));
//  finally
//    dest.Free;
//  end;
//end;
//{$ENDIF}

end.
