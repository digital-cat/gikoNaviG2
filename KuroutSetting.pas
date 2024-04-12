unit KuroutSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, GikoSystem, GikoUtil, ExtCtrls, StrUtils;

type
  TKuroutOption = class(TForm)
	PageControl1: TPageControl;
	TabSheet1: TTabSheet;
	GroupBox11: TGroupBox;
	Label17: TLabel;
	Label18: TLabel;
	RecvBufferSize: TEdit;
	ProxyProtocolCheckBox: TCheckBox;
	ProtocolCheckBox: TCheckBox;
	GroupBox13: TGroupBox;
	Label24: TLabel;
	Label25: TLabel;
	PostTimeLabel: TLabel;
	Label27: TLabel;
	PostTimeCheckBox: TCheckBox;
	PostTimeEdit: TEdit;
	PutPostTimeRadioButton: TRadioButton;
	BackPostTimeRadioButton: TRadioButton;
	OkBotton: TButton;
	CancelBotton: TButton;
	ApplyButton: TButton;
	ColumnTabSheet: TTabSheet;
	CategoryColumnGroupBox: TGroupBox;
	CUnVisibledListBox: TListBox;
	CVisibledListBox: TListBox;
	CAddButton: TButton;
	CDeleteButton: TButton;
	BoardColumnGroupBox: TGroupBox;
	BUnVisibledListBox: TListBox;
	BVisibledListBox: TListBox;
	BAddButton: TButton;
	BDeleteButton: TButton;
	Label1: TLabel;
	Label2: TLabel;
	Label3: TLabel;
	Label4: TLabel;
	CUpButton: TButton;
	CDownButton: TButton;
	BUpButton: TButton;
	BDownButton: TButton;
    GroupBox1: TGroupBox;
    GengoSupport: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    ReadTimeOut: TEdit;
    Label7: TLabel;
    KakikomiTabSheet: TTabSheet;
    CookieGroupBox: TGroupBox;
    Label8: TLabel;
    FixedCookieEdit: TEdit;
    Label9: TLabel;
    GroupBox3: TGroupBox;
    Label10: TLabel;
    MoveHistoryMaxEdit: TEdit;
    Label11: TLabel;
    AHandredGroupBox: TGroupBox;
    AHandredLabeledEdit: TLabeledEdit;
    AHandredUpDown: TUpDown;
    ThreadGroupBox: TGroupBox;
    AddKeywordCheckBox: TCheckBox;
    TabSheet2: TTabSheet;
    SecurityGroupBox: TGroupBox;
    GroupBox2: TGroupBox;
    LocalTrapAtt: TCheckBox;
    RemoteTrapAtt: TCheckBox;
    ReplaceDatCheckBox: TCheckBox;
    Label12: TLabel;
    GroupBox4: TGroupBox;
    SentIniFileSizeEdit: TEdit;
    SentIniFileSizeUpDown: TUpDown;
    Label13: TLabel;
    Label14: TLabel;
    ExtListLabeledEdit: TLabeledEdit;
    Label15: TLabel;
    LogGroupBox: TGroupBox;
    CheckDatFileCheckBox: TCheckBox;
    RespopupTabSheet: TTabSheet;
    RespopuGroupBox: TGroupBox;
    DeltaXLabeledEdit: TLabeledEdit;
    DeltaYLabeledEdit: TLabeledEdit;
    DeltaXUpDown: TUpDown;
    DeltaYUpDown: TUpDown;
    Label16: TLabel;
    RespopupWaitLabeledEdit: TLabeledEdit;
    RespopupWaitUpDown: TUpDown;
    Label19: TLabel;
    RespopupMailToCheckBox: TCheckBox;
    ResRangeLabeledEdit: TLabeledEdit;
    ResRangeCountUpDown: TUpDown;
    UseGobakuCheckBox: TCheckBox;
    GroupBox5: TGroupBox;
    IPv6CheckBox: TCheckBox;
    IPv4Label: TLabel;
    IPv4ListBox: TListBox;
    IPv4AddButton: TButton;
    IPv4EdtButton: TButton;
    IPv4DelButton: TButton;
    IPv6Label: TLabel;
    IPv4ResetButton: TButton;
	procedure OkBottonClick(Sender: TObject);
	procedure FormCreate(Sender: TObject);
	procedure CDeleteButtonClick(Sender: TObject);
	procedure CAddButtonClick(Sender: TObject);
	procedure BAddButtonClick(Sender: TObject);
	procedure BDeleteButtonClick(Sender: TObject);
    procedure CUpButtonClick(Sender: TObject);
    procedure CDownButtonClick(Sender: TObject);
    procedure BUpButtonClick(Sender: TObject);
    procedure BDownButtonClick(Sender: TObject);
    procedure MoveHistoryMaxEditExit(Sender: TObject);
    procedure AHandredLabeledEditExit(Sender: TObject);
    procedure ExtListLabeledEditExit(Sender: TObject);
    procedure DeltaXLabeledEditExit(Sender: TObject);
    procedure DeltaYLabeledEditExit(Sender: TObject);
    procedure RespopupWaitLabeledEditExit(Sender: TObject);
    procedure ResRangeLabeledEditExit(Sender: TObject);
    procedure IPv4AddButtonClick(Sender: TObject);
    procedure IPv4EdtButtonClick(Sender: TObject);
    procedure IPv4DelButtonClick(Sender: TObject);
    procedure IPv6CheckBoxClick(Sender: TObject);
    procedure IPv4ResetButtonClick(Sender: TObject);
  private
	{ Private 宣言 }
	procedure SetValue;
	procedure SaveSetting;
	procedure RecvBufferSizeExit(Sender: TObject);
	procedure PostTimeEditExit(Sender: TObject);
	procedure PostTimeCheckBoxClick(Sender: TObject);
	procedure SetColumnData();
	procedure PostColumnData();
  public
	{ Public 宣言 }
  end;

var
  KuroutOption: TKuroutOption;

implementation

uses
	Giko, Setting, GikoInputBoxForm;

{$R *.dfm}

procedure TKuroutOption.SetValue;
var
	i: Integer;
begin
	//受信バッファサイズ
	//RecvBufferSize.Text := IntToStr(Gikosys.Setting.RecvBufferSize);
	//HTTP1.1使用
	ProtocolCheckBox.Checked := GikoSys.Setting.Protocol;
	//プロキシ接続HTTP1.1使用
	ProxyProtocolCheckBox.Checked := Gikosys.Setting.ProxyProtocol;
	ReadTimeOut.Text := IntToStr(GikoSys.Setting.ReadTimeOut);

		//書き込み時マシン時間使用設定
	PostTimeCheckBox.Checked := GikoSys.Setting.UseMachineTime;
	PostTimeEdit.Text := IntToStr(GikoSys.Setting.TimeAdjustSec);
	if GikoSys.Setting.TimeAdjust then
		PutPostTimeRadioButton.Checked := True
	else
		BackPostTimeRadioButton.Checked := True;

	SetColumnData();

	PageControl1.ActivePageIndex := GikoSys.Setting.KuroutSettingTabIndex;

	//2chAnnai
	GengoSupport.Checked := GikoSys.Setting.GengoSupport;
	//FusianaSet
	LocalTrapAtt.Checked := GikoSys.Setting.LocalTrapAtt;
	RemoteTrapAtt.Checked := GikoSys.Setting.RemoteTrapAtt;
	// Cookie
  FixedCookieEdit.Text := GikoSys.Setting.FixedCookie;
  // リンク移動履歴
  MoveHistoryMaxEdit.Text := IntToStr( GikoSys.Setting.MoveHistorySize );
  //　先頭表示レス数
  AHandredUpDown.Position := GikoSys.Setting.HeadResCount;
  // 表示レス数
  ResRangeCountUpDown.Position := GikoSys.Setting.ResRangeExCount;
  // 関連キーワード追加フラグ
  AddKeywordCheckBox.Checked := GikoSys.Setting.AddKeywordLink;
  // 誤反応対策
  ReplaceDatCheckBox.Checked := GikoSys.Setting.ReplaceDat;
  SentIniFileSizeUpDown.Position := GikoSys.Setting.SentIniFileSize;
  ExtListLabeledEdit.Text := GikoSys.Setting.ExtList;
  // Folder.idx読み込み時datチェック
  CheckDatFileCheckBox.Checked := GikoSys.Setting.CheckDatFile;
  DeltaXUpDown.Position := GikoSys.Setting.RespopupDeltaX;
  DeltaYUpDown.Position := GikoSys.Setting.RespopupDeltaY;
  RespopupWaitUpDown.Position := GikoSys.Setting.RespopupWait;
  RespopupMailToCheckBox.Checked := GikoSys.Setting.RespopupMailTo;
  // 誤爆チェック
  UseGobakuCheckBox.Checked := GikoSys.Setting.UseGobakuCheck;
	//IPv6使用
  IPv6CheckBox.Checked := GikoSys.Setting.IPv6;
  IPv4ListBox.Items.Clear;
  for i := 0 to GikoSys.Setting.IPv4List.Count - 1 do
  	IPv4ListBox.Items.Add(GikoSys.Setting.IPv4List[i]);
  IPv6CheckBoxClick(IPv6CheckBox);

end;

procedure TKuroutOption.SaveSetting;
var
  i: Integer;
begin
	//受信バッファサイズ
	//Gikosys.Setting.RecvBufferSize := StrToIntDef(RecvBufferSize.Text, Gikosys.Setting.RecvBufferSize);
	GikoSys.Setting.ReadTimeOut := StrToIntDef(ReadTimeOut.Text, GikoSys.Setting.ReadTimeOut);
	//HTTP1.1使用
	GikoSys.Setting.Protocol := ProtocolCheckBox.Checked;
	//プロキシ接続HTTP1.1使用
	Gikosys.Setting.ProxyProtocol := ProxyProtocolCheckBox.Checked;
	//書き込み時マシン時間使用設定
	GikoSys.Setting.UseMachineTime := PostTimeCheckBox.Checked;
	if GikoSys.IsNumeric(PostTimeEdit.Text) then
		GikoSys.Setting.TimeAdjustSec := StrToIntDef(PostTimeEdit.Text, GikoSys.Setting.TimeAdjustSec)
	else
		GikoSys.Setting.TimeAdjustSec := 0;
	GikoSys.Setting.TimeAdjust := PutPostTimeRadioButton.Checked;
	//2ch言語サポート
	GikoSys.Setting.GengoSupport := GengoSupport.Checked;
	GikoSys.SetGikoMessage;
	//ローカル・リモートﾌｼｱﾅ警告
	GikoSys.Setting.LocalTrapAtt := LocalTrapAtt.Checked;
	GikoSys.Setting.RemoteTrapAtt := RemoteTrapAtt.Checked;
	// Cookie
	GikoSys.Setting.FixedCookie := FixedCookieEdit.Text;

  // リンク移動履歴
  GikoSys.Setting.MoveHistorySize :=
      StrToIntDef( MoveHistoryMaxEdit.Text, 20 );

  //　先頭表示レス数
  GikoSys.Setting.HeadResCount :=
      StrToIntDef( AHandredLabeledEdit.Text , 1);
  GikoSys.Setting.ResRangeExCount :=
      StrToIntDef( ResRangeLabeledEdit.Text , 100 );
	GikoSys.Setting.KuroutSettingTabIndex := PageControl1.ActivePageIndex;
  // 関連キーワード追加フラグ
  GikoSys.Setting.AddKeywordLink := AddKeywordCheckBox.Checked;
  // 誤反応対策
  GikoSys.Setting.ReplaceDat := ReplaceDatCheckBox.Checked;
  GikoSys.Setting.SentIniFileSize := SentIniFileSizeUpDown.Position;
  GikoSys.Setting.ExtList := ExtListLabeledEdit.Text;
  // Folder.idx読み込み時datチェック
  GikoSys.Setting.CheckDatFile := CheckDatFileCheckBox.Checked;

  GikoSys.Setting.RespopupDeltaX := StrToInt(DeltaXLabeledEdit.Text);
  GikoSys.Setting.RespopupDeltaY := StrToInt(DeltaYLabeledEdit.Text);
  GikoSys.Setting.RespopupWait := StrToInt(RespopupWaitLabeledEdit.Text);
  GikoForm.ResPopupClearTimer.Interval := GikoSys.Setting.RespopupWait;
  GikoSys.Setting.RespopupMailTo := RespopupMailToCheckBox.Checked;
  // 誤爆チェック
  GikoSys.Setting.UseGobakuCheck := UseGobakuCheckBox.Checked;
	//IPv6使用
  GikoSys.Setting.IPv6 := IPv6CheckBox.Checked;
  GikoSys.Setting.IPv4List.Clear;
  for i := 0 to IPv4ListBox.Items.Count - 1 do
  	GikoSys.Setting.IPv4List.Add(IPv4ListBox.Items.Strings[i]);

end;

procedure TKuroutOption.RecvBufferSizeExit(Sender: TObject);
begin
//	if not GikoSys.IsNumeric(RecvBufferSize.Text) then
//		RecvBufferSize.Text := '4096';
//	if StrToInt(RecvBufferSize.Text) < 256 then
//		RecvBufferSize.Text := '4096';
end;

procedure TKuroutOption.PostTimeEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(PostTimeEdit.Text) then
		PostTimeEdit.Text := '0';
end;

procedure TKuroutOption.PostTimeCheckBoxClick(Sender: TObject);
begin
	PostTimeLabel.Enabled := PostTimeCheckBox.Checked;
	PostTimeEdit.Enabled := PostTimeCheckBox.Checked;
	PutPostTimeRadioButton.Enabled := PostTimeCheckBox.Checked;
	BackPostTimeRadioButton.Enabled := PostTimeCheckBox.Checked;
end;

procedure TKuroutOption.OkBottonClick(Sender: TObject);
begin
	//RecvBufferSizeExit(Sender);
	PostTimeEditExit(Sender);
    MoveHistoryMaxEditExit(Sender);
    AHandredLabeledEditExit(Sender);
    ExtListLabeledEditExit(Sender);
    DeltaXLabeledEditExit(Sender);
    DeltaYLabeledEditExit(Sender);
    RespopupWaitLabeledEditExit(Sender);
    PostColumnData();
	SaveSetting;
end;

procedure TKuroutOption.FormCreate(Sender: TObject);
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

	SetValue;
	PostTimeCheckBoxClick(Sender);

end;

procedure TKuroutOption.IPv6CheckBoxClick(Sender: TObject);
var
  enb: Boolean;
begin
  enb := IPv6CheckBox.Checked;

  IPv6Label.Enabled := enb;
  IPv4Label.Enabled := enb;
  IPv4AddButton.Enabled := enb;
  IPv4EdtButton.Enabled := enb;
  IPv4DelButton.Enabled := enb;
  IPv4ListBox.Enabled := enb;
end;

procedure TKuroutOption.IPv4AddButtonClick(Sender: TObject);
var
	inputBox: TGikoInputBox;
begin
	inputBox := TGikoInputBox.Create(Self);
	try
  	inputBox.DlgCaption := '除外ドメイン追加';
  	inputBox.Prompt := 'IPv6接続しないドメイン名を入力してください';
    inputBox.FormStyle := fsStayOnTop;	// 裏に回ってしまうので
  	if inputBox.ShowModal = mrOk then begin
    	if inputBox.Value <> '' then begin
        if IPv4ListBox.Items.IndexOf(inputBox.Value) >= 0 then
          MessageBox(Handle, 'このドメインは登録済みです。', '除外ドメイン追加', MB_OK)
        else
          IPv4ListBox.Items.Add(inputBox.Value);
	    end;
    end;
  finally
    inputBox.Free;
  end;
end;

procedure TKuroutOption.IPv4EdtButtonClick(Sender: TObject);
var
	idx: Integer;
  domain: String;
	inputBox: TGikoInputBox;
begin
	idx := IPv4ListBox.ItemIndex;
  if idx >= 0 then begin
  	domain := IPv4ListBox.Items.Strings[idx];
    inputBox := TGikoInputBox.Create(Self);
    try
      inputBox.DlgCaption := '除外ドメイン編集';
      inputBox.Prompt := 'IPv6接続しないドメイン名を入力してください';
      inputBox.Value := domain;
	    inputBox.FormStyle := fsStayOnTop;	// 裏に回ってしまうので
      if inputBox.ShowModal = mrOk then begin
        if (inputBox.Value <> '') and (inputBox.Value <> domain) then begin
          if IPv4ListBox.Items.IndexOf(inputBox.Value) >= 0 then
            MessageBox(Handle, 'このドメインは登録済みです。', '除外ドメイン編集', MB_OK)
          else
            IPv4ListBox.Items.Strings[idx] := inputBox.Value;
        end;
			end;
    finally
	    inputBox.Free;
    end;
  end;
end;

procedure TKuroutOption.IPv4DelButtonClick(Sender: TObject);
var
	idx: Integer;
  msg: String;
begin
	idx := IPv4ListBox.ItemIndex;
  if idx >= 0 then begin
  	msg := Format('除外ドメインから［%s］を削除します。よろしいですか？', [IPv4ListBox.Items.Strings[idx]]);
  	if MessageBox(Handle, PChar(msg), '除外ドメイン', MB_YESNO) = IDYES then
    	IPv4ListBox.Items.Delete(idx);
  end;
end;

procedure TKuroutOption.IPv4ResetButtonClick(Sender: TObject);
begin
	if MessageBox(Handle, '除外ドメインのリストを初期設定に戻します。' + #10 +
  											'よろしいですか？', '除外ドメイン', MB_YESNO or MB_ICONWARNING) = IDYES then
    GikoSys.Setting.GetDefaultIPv4Domain(IPv4ListBox.Items);
end;

procedure TKuroutOption.SetColumnData();
var
	i, j : Integer;
	flag : Boolean;
begin

	//===== 板リスト =====
	for i := 0 to GikoSys.Setting.CategoryColumnOrder.Count - 1 do begin
		for j := 1 to Length( GikoCategoryColumnCaption ) - 1 do begin
			if GikoSys.Setting.CategoryColumnOrder[ i ] = TGikoCategoryColumnID( j ) then begin
				CVisibledListBox.AddItem(GikoCategoryColumnCaption[ j ], nil);
				break;
			end;
		end;
	end;

	for i := 1 to Length( GikoCategoryColumnCaption ) - 1 do begin
		flag := false;
		for j := 0 to GikoSys.Setting.CategoryColumnOrder.Count - 1 do begin
			if GikoSys.Setting.CategoryColumnOrder[ j ] = TGikoCategoryColumnID( i ) then begin
				flag := true;
				break;
			end;
		end;
		if not flag then
			CUnVisibledListBox.AddItem(GikoCategoryColumnCaption[ i ], nil);
	end;

	//===== スレリスト =====
	for i := 0 to GikoSys.Setting.BoardColumnOrder.Count - 1 do begin
		for j := 1 to Length( GikoBoardColumnCaption ) - 1 do begin
			if GikoSys.Setting.BoardColumnOrder[ i ] = TGikoBoardColumnID( j ) then begin
				BVisibledListBox.AddItem(GikoBoardColumnCaption[ j ], nil);
				Break;
			end;
		end;
	end;

	for i := 1 to Length( GikoBoardColumnCaption ) - 1 do begin
		flag := false;
		for j := GikoSys.Setting.BoardColumnOrder.Count - 1 downto 0 do begin
			if GikoSys.Setting.BoardColumnOrder[ j ] = TGikoBoardColumnID( i ) then begin
				flag := true;
				Break;
			end;
		end;
		if not flag then
			BUnVisibledListBox.AddItem(GikoBoardColumnCaption[ i ], nil);

	end;
end;
procedure TKuroutOption.CDeleteButtonClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to CVisibledListBox.Count - 1 do begin
		if CVisibledListBox.Selected[i] then begin
			CUnVisibledListBox.AddItem(	CVisibledListBox.Items.Strings[ i ], nil);
			CVisibledListBox.DeleteSelected;
			break;
		end;
	end;
end;

procedure TKuroutOption.CAddButtonClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to CUnVisibledListBox.Count - 1 do begin
		if CUnVisibledListBox.Selected[i] then begin
			CVisibledListBox.AddItem(	CUnVisibledListBox.Items.Strings[ i ], nil);
			CUnVisibledListBox.DeleteSelected;
			break;
		end;
	end;
end;

procedure TKuroutOption.BAddButtonClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to BUnVisibledListBox.Count - 1 do begin
		if BUnVisibledListBox.Selected[i] then begin
			BVisibledListBox.AddItem(	BUnVisibledListBox.Items.Strings[ i ], nil);
			BUnVisibledListBox.DeleteSelected;
			break;
		end;
	end;
end;

procedure TKuroutOption.BDeleteButtonClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to BVisibledListBox.Count - 1 do begin
		if BVisibledListBox.Selected[i] then begin
			BUnVisibledListBox.AddItem(	BVisibledListBox.Items.Strings[ i ], nil);
			BVisibledListBox.DeleteSelected;
			break;
		end;
	end;
end;

procedure TKuroutOption.CUpButtonClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 1 to CVisibledListBox.Count - 1 do begin
		if CVisibledListBox.Selected[i] then begin
			CVisibledListBox.Items.Exchange(i, i -1);
			break;
		end;
	end;
end;

procedure TKuroutOption.CDownButtonClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to CVisibledListBox.Count - 2 do begin
		if CVisibledListBox.Selected[i] then begin
			CVisibledListBox.Items.Exchange(i, i + 1);
			break;
		end;
	end;
end;

procedure TKuroutOption.BUpButtonClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 1 to BVisibledListBox.Count - 1 do begin
		if BVisibledListBox.Selected[i] then begin
			BVisibledListBox.Items.Exchange(i, i -1);
			break;
		end;
	end;
end;

procedure TKuroutOption.BDownButtonClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to BVisibledListBox.Count - 2 do begin
		if BVisibledListBox.Selected[i] then begin
			BVisibledListBox.Items.Exchange(i, i + 1);
			break;
		end;
	end;
end;


procedure TKuroutOption.PostColumnData();
var
	i, j : Integer;
begin
	GikoForm.ActiveListColumnSave;

	//===== 板リスト =====
	for i := GikoSys.Setting.CategoryColumnOrder.Count -1 downto 1 do
		GikoSys.Setting.CategoryColumnOrder.Delete(i);

	for i := 0 to CVisibledListBox.Count - 1 do begin
		for j := 1 to Length( GikoCategoryColumnCaption ) - 1 do begin
			if CVisibledListBox.Items.Strings[ i ] = GikoCategoryColumnCaption[ j ] then begin
				GikoSys.Setting.CategoryColumnOrder.Add(  TGikoCategoryColumnID(j) );
				break;
			end;
		end;
	end;

	//===== スレリスト =====
	for i := GikoSys.Setting.BoardColumnOrder.Count - 1 downto 1 do
		GikoSys.Setting.BoardColumnOrder.Delete(i);

	for i := 0 to BVisibledListBox.Count - 1 do begin
		for j := 1 to Length( GikoBoardColumnCaption ) - 1 do begin
			if BVisibledListBox.Items.Strings[ i ] = GikoBoardColumnCaption[ j ] then begin
				GikoSys.Setting.BoardColumnOrder.Add( TGikoBoardColumnID(j) );
				Break;
			end;
		end;
	end;
	//スレ一覧の描画の更新
	GikoForm.SetActiveList(GikoForm.ActiveList);
end;
// リンク移動履歴の編集後の設定文字列チェック
procedure TKuroutOption.MoveHistoryMaxEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(MoveHistoryMaxEdit.Text) then
		MoveHistoryMaxEdit.Text := '20';
    if StrToInt(MoveHistoryMaxEdit.Text) < 1 then
        MoveHistoryMaxEdit.Text := '1';
end;
// 先頭表示レス数の編集後の設定文字列チェック
procedure TKuroutOption.AHandredLabeledEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(AHandredLabeledEdit.Text) then
		AHandredLabeledEdit.Text := '1';
    if StrToInt(AHandredLabeledEdit.Text) < 1 then
        AHandredLabeledEdit.Text := '1';

end;

procedure TKuroutOption.ExtListLabeledEditExit(Sender: TObject);
begin
    if AnsiEndsStr(';', ExtListLabeledEdit.Text) then begin
        ExtListLabeledEdit.Text :=
            Copy(ExtListLabeledEdit.Text, 0,
                Length(ExtListLabeledEdit.Text) - 1);
    end;
end;
// レスポップアップ位置X
procedure TKuroutOption.DeltaXLabeledEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(DeltaXLabeledEdit.Text) then
		DeltaXLabeledEdit.Text := IntToStr(GikoSys.Setting.RespopupDeltaX);
    if StrToInt(DeltaXLabeledEdit.Text) < DeltaXUpDown.Min then
        DeltaXLabeledEdit.Text := IntToStr(DeltaXUpDown.Min);
    if StrToInt(DeltaXLabeledEdit.Text) > DeltaXUpDown.Max then
        DeltaXLabeledEdit.Text:= IntToStr(DeltaXUpDown.Max);
end;
// レスポップアップ位置Y
procedure TKuroutOption.DeltaYLabeledEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(DeltaYLabeledEdit.Text) then
        DeltaYLabeledEdit.Text := IntToStr(GikoSys.Setting.RespopupDeltaY);
    if StrToInt(DeltaYLabeledEdit.Text) < DeltaYUpDown.Min then
        DeltaYLabeledEdit.Text := IntToStr(DeltaYUpDown.Min);
    if StrToInt(DeltaYLabeledEdit.Text) > DeltaYUpDown.Max then
        DeltaYLabeledEdit.Text := IntToStr(DeltaYUpDown.Max);
end;

procedure TKuroutOption.RespopupWaitLabeledEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(RespopupWaitLabeledEdit.Text) then
		RespopupWaitLabeledEdit.Text := IntToStr(GikoSys.Setting.RespopupWait);
    if StrToInt(RespopupWaitLabeledEdit.Text) < RespopupWaitUpDown.Min then
		RespopupWaitLabeledEdit.Text := IntToStr(RespopupWaitUpDown.Min);
    if StrToInt(RespopupWaitLabeledEdit.Text) > RespopupWaitUpDown.Max then
		RespopupWaitLabeledEdit.Text := IntToStr(RespopupWaitUpDown.Max);
end;

procedure TKuroutOption.ResRangeLabeledEditExit(Sender: TObject);
begin
	if not GikoSys.IsNumeric(ResRangeLabeledEdit.Text) then
		ResRangeLabeledEdit.Text := '100';
    if StrToInt(ResRangeLabeledEdit.Text) < 100 then
        ResRangeLabeledEdit.Text := '100';
    if StrToInt(ResRangeLabeledEdit.Text) > 9999 then
        ResRangeLabeledEdit.Text := '9999';
end;

end.
