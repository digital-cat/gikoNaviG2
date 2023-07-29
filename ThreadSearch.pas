unit ThreadSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Menus, Clipbrd, IniFiles, uLkJSON,
  OleCtrls, SHDocVw, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL;

type
  TThreadSrch = class(TForm)
    Indy: TIdHTTP;
    PopupMenu: TPopupMenu;
    MenuShowThread: TMenuItem;
    N1: TMenuItem;
    MenuCopyURL: TMenuItem;
    MenuCopyThread: TMenuItem;
    MenuCopyThrURL: TMenuItem;
    PopMenuBbs: TPopupMenu;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LblSite: TLabel;
    BtnSearch: TButton;
    CmbType: TComboBox;
    CmbMax: TComboBox;
    CmbLim: TComboBox;
    CmbSort: TComboBox;
    CmbBoard: TComboBox;
    Cmb924: TComboBox;
    ChkTop: TCheckBox;
    CmbKW: TComboBox;
    ChkBbs: TCheckBox;
    PnlBbsName: TPanel;
    PnlBbsId: TPanel;
    BtnBbs: TButton;
    ResultList: TListView;
    Splitter2: TSplitter;
    MessageList: TListBox;
    CmBrowser: TWebBrowser;
    ChkNG: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure ResultListDblClick(Sender: TObject);
    procedure ChkTopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MenuShowThreadClick(Sender: TObject);
    procedure MenuCopyURLClick(Sender: TObject);
    procedure MenuCopyThreadClick(Sender: TObject);
    procedure MenuCopyThrURLClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure ChkBbsClick(Sender: TObject);
    procedure BtnBbsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LblSiteClick(Sender: TObject);
  private
    { Private 宣言 }
    BbsNmList: TStringList;
    BbsIdList: TStringList;
    CmPath: String;
    CmUrl: String;

    procedure AddHistory;
    function KWEncode(const KWSrc: String): String;
    function ParsJson(JsonStream: TMemoryStream): Boolean;
    procedure SetCm(Content: string);
    function HTMLEncode(const HTML: string): String;
    procedure InitHttpClient(client: TIdHttp);
    procedure ClearHttpClient(client: TIdHttp);
    procedure MenuBbsClick(Sender: TObject);
  public
    { Public 宣言 }
    procedure SaveSetting;
  end;

function ConvertINetString(lpdwMode: LPDWORD;
                            dwSrcEncoding: DWORD;
                            dwDstEncoding: DWORD;
                            lpSrcStr: PChar;
                            lpnSrcSize: pointer;
                            lpDstStr: PChar;
                            lpnDstSize: pointer): HRESULT;
                                                stdcall; external 'mlang.dll';

var
  ThreadSrch: TThreadSrch = nil;
const
    HTML_HD: String = '<html><head><meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS"><title></title></head><body>';
    HTML_FT: String = '</body></html>';
    ENC_SJIS: DWORD = 932;
    ENC_UTF8: DWORD = 65001;

implementation

uses GikoSystem, GikoDataModule, MojuUtils, BoardGroup;

{$R *.dfm}

procedure TThreadSrch.FormCreate(Sender: TObject);
var
    PathLen: Integer;
    Sep: Integer;
begin
    BbsNmList := TStringList.Create;
    BbsIdList := TStringList.Create;

    Top    := GikoSys.Setting.ThrdSrchTop;
    Left   := GikoSys.Setting.ThrdSrchLeft;
    Width  := GikoSys.Setting.ThrdSrchWidth;
    Height := GikoSys.Setting.ThrdSrchHeight;
    if (GikoSys.Setting.ThrdSrchMax = True) then
        WindowState := wsMaximized;
    if (GikoSys.Setting.ThrdSrchStay = True) then begin
        ChkTop.Checked := True;
        FormStyle := fsStayOnTop;
    end;
    ResultList.Column[0].Width := GikoSys.Setting.ThrdSrchCol1W;
    ResultList.Column[1].Width := GikoSys.Setting.ThrdSrchCol2W;
    ResultList.Column[2].Width := GikoSys.Setting.ThrdSrchCol3W;
    ResultList.Column[3].Width := GikoSys.Setting.ThrdSrchCol4W;
    CmbKW.Items.AddStrings(GikoSys.Setting.ThrdSrchHistory);

    SetLength(CmPath, 1024);
    PathLen := GetTempPath(1024, PAnsiChar(CmPath));
    if (PathLen > 0) then begin
        SetLength(CmPath, PathLen);
        if (CmPath[PathLen] <> '\') then
            CmPath := CmPath + '\';
        CmPath := CmPath + 'gikonavi';
        ForceDirectories(CmPath);
        CmPath := CmPath + '\cm.html';
        CmUrl := CmPath;
        while (True) do begin
            Sep := Pos('\', CmUrl);
            if (Sep < 1) then
                Break;
            CmUrl[Sep] := '/';
        end;
        while (True) do begin
            Sep := Pos(' ', CmUrl);
            if (Sep < 1) then
                Break;
            Delete(CmUrl, Sep, 1);
            Insert('%20', CmUrl, Sep);
        end;
        CmUrl := 'file://' + CmUrl;
    end else begin
        CmPath := '';
    end;
end;

procedure TThreadSrch.BtnSearchClick(Sender: TObject);
const
    BBS_VALUE: array[0..19] of string = (
                                            'all',				// 全ての板
                                            'newsplus',			// 速＋
                                            'mnewsplus',		// 芸＋
                                            'U_plus',			// ＋全部
                                            'U_live',			// 実況全部
                                            'G_game',			// ゲームG
                                            'G_entame',			// 芸能・テレビG
                                            'G_subcal',			// サブカルG
                                            'G_base',			// 野球G
                                            'G_soccer',			// サッカーG
                                            'G_pc',				// PC関係G
                                            'G_academy',		// 学問・文化G
                                            'G_female',			// 女性向けG
                                            'G_world',			// 国際G
                                            'G_eastasia',		// 国際・東亜G
                                            'G_fareast',		// 極東G
                                            'G_operate',		// 運営G
                                            'S_bbspink',		// bbspink鯖
                                            'morningcoffee',	// 狼。
                                            'poverty'			// 嫌儲
                                        );
var
    URL: String;
    RspStream: TMemoryStream;
    Ok: Boolean;
    Board: String;
begin
    ResultList.Clear;
//    CmBrowser.Navigate('about:blank');

    Screen.Cursor := crHourGlass;

    AddHistory;

    if (ChkBbs.Checked = True) then
        Board := PnlBbsId.Caption
    else
        Board := BBS_VALUE[CmbBoard.ItemIndex];

    URL := 'http://dig.2ch.net/?keywords=' + KWEncode(CmbKW.Text)
            + '&AndOr='      + IntToStr(CmbType.ItemIndex)
            + '&maxResult='  + CmbMax.Text
            + '&atLeast='    + CmbLim.Text
            + '&Sort='       + IntToStr(CmbSort.ItemIndex)
            + '&Link=1&Bbs=' + Board
            + '&924='        + IntToStr(Cmb924.ItemIndex)
            + '&json=1';
//    Application.MessageBox(PChar(URL), 'debug', MB_OK);

    RspStream := TMemoryStream.Create;

    Ok := False;
    InitHttpClient(Indy);
    try
        Indy.Get(URL, RspStream);
        Ok := True;
    except
        on E: Exception do begin
            MessageList.Items.Add('エラー発生：' + E.Message);
        end;
    end;

    if (Ok = True) then begin
        if (RspStream.Size > 0) then
            Ok := ParsJson(RspStream);
        if (Ok = True) then
            MessageList.Items.Add(Format('【%s】検索結果：%d件', [CmbKW.Text, ResultList.Items.Count]));
    end;

    MessageList.TopIndex := MessageList.Count - 1;

    RspStream.Free;

    Screen.Cursor := crDefault;
end;

procedure TThreadSrch.AddHistory;
const
    HISTORY_MAX: Integer = 20;
var
    KW: String;
    Idx: Integer;
begin
    if (CmbKW.Text = '') then
        Exit;
    KW := CmbKW.Text;
    Idx := CmbKW.Items.IndexOf(KW);
    if (Idx <> 0) then begin
        if (Idx > 0) then
            CmbKW.Items.Delete(Idx);
        CmbKW.Items.Insert(0, KW);
        CmbKW.Text := KW;
    end;
    while (CmbKW.Items.Count > HISTORY_MAX) do begin
        CmbKW.Items.Delete(CmbKW.Items.Count - 1);
    end;
end;

function TThreadSrch.KWEncode(const KWSrc: String): String;
const
    BufSize: Integer = 1024;
var
    KWEnc: String;
    CnvSjis: String;
    Utf8: array [0..1023] of Byte;
    Cnt: Integer;
    Cnt2: Integer;
    Len: Integer;
    SrcSize: Integer;
    DstSize: Integer;
    Stat: HRESULT;
    Max: Integer;
begin
    Len := Length(KWSrc);
    if (Len < 1) then begin
        Result := '';
        Exit;
    end;

    Cnt := 1;
    while (Cnt <= Len) do begin
        case ByteType(KWSrc, Cnt) of
            mbSingleByte: begin
                if (KWSrc[Cnt] >= #$80) then begin
                    CnvSjis := CnvSjis + Copy(KWSrc, Cnt, 1);
                end else begin
                    SrcSize := Length(CnvSjis);
                    if (SrcSize > 0) then begin
                        ZeroMemory(@Utf8, BufSize);
                        DstSize := BufSize;
                        Stat := ConvertINetString(nil, ENC_SJIS, ENC_UTF8,
                                    PChar(CnvSjis), @SrcSize, PChar(@Utf8), @DstSize);
                        if (Stat = S_OK) and (DstSize > 0) then begin
                            Max := DstSize - 1;
                            for Cnt2 := 0 to Max do begin
                                KWEnc := KWEnc + '%' + Format('%02X', [Utf8[Cnt2], 0]);
                            end;
                        end;
                        CnvSjis := '';
                    end;

                    if (((KWSrc[Cnt] >= '0') and (KWSrc[Cnt] <= '9')) or
                             ((KWSrc[Cnt] >= 'A') and (KWSrc[Cnt] <= 'Z')) or
                             ((KWSrc[Cnt] >= 'a') and (KWSrc[Cnt] <= 'z')) or
                             (KWSrc[Cnt] = '-') or (KWSrc[Cnt] = '.') or
                             (KWSrc[Cnt] = '_') or (KWSrc[Cnt] = '~')) then begin
                        KWEnc := KWEnc + Copy(KWSrc, Cnt, 1);
                    end else if (KWSrc[Cnt] = ' ') then begin
                        KWEnc := KWEnc + '+';
                    end else begin
                        KWEnc := KWEnc + '%' + Format('%02X', [Ord(KWSrc[Cnt])]);
                    end;
                end;
            end;
            mbLeadByte: begin
                CnvSjis := CnvSjis + Copy(KWSrc, Cnt, 2);
                Cnt := Cnt + 1;
            end;
            mbTrailByte: begin
            end;
        end;
        Cnt := Cnt + 1;
    end;

    SrcSize := Length(CnvSjis);
    if (SrcSize > 0) then begin
        ZeroMemory(@Utf8, BufSize);
        DstSize := BufSize;
        Stat := ConvertINetString(nil, ENC_SJIS, ENC_UTF8,
                                    PChar(CnvSjis), @SrcSize, PChar(@Utf8), @DstSize);
        if (Stat = S_OK) and (DstSize > 0) then begin
            Max := DstSize - 1;
            for Cnt2 := 0 to Max do begin
                KWEnc := KWEnc + '%' + Format('%02X', [Utf8[Cnt2]]);
            end;
        end;
    end;

    Result := KWEnc;
end;

function TThreadSrch.ParsJson(JsonStream: TMemoryStream): Boolean;
var
    vJsonObj: TlkJsonObject;
    vCm: TlkJSONbase;
    vRoot: TlkJSONbase;
    vRec: TlkJSONbase;
    vField: TlkJSONbase;
    RecMax: Integer;
    Cnt: Integer;
    CmHtml: String;
    Title: String;
    Item: TListItem;
begin
    Result := False;
    try
        JsonStream.Position := 0;
        vJsonObj := TlkJSONstreamed.LoadFromStream(JsonStream) as TlkJsonObject;

        try
            for Cnt := 0 to 2 do begin;
                vCm := vJsonObj.Field['cm' + IntToStr(Cnt)];
                if (vCm <> nil) then begin
                    CmHtml := CmHtml + String(vCm.Value);
                end;
            end;
            if (CmHtml <> '') then
                SetCm(HTML_HD + CmHtml + HTML_FT);

            vRoot := vJsonObj.Field['result'];
            if (vRoot <> nil) then begin
                RecMax := vRoot.Count - 1;
                for Cnt := 0 to RecMax do begin;
                    vRec := vRoot.Child[Cnt];

                    vField := vRec.Field['subject'];
                    Title := HTMLEncode(String(vField.Value));
                    if (ChkNG.Checked = True) and (ThreadNgList.IsNG(Title) = True) then
                        Continue;

                    vField := vRec.Field['ita'];
                    Item := ResultList.Items.Add;
                    Item.Caption := String(vField.Value);

                    Item.SubItems.Add(Title);

                    vField := vRec.Field['resno'];
                    Item.SubItems.Add(String(vField.Value));

                    vField := vRec.Field['url'];
                    Item.SubItems.Add(String(vField.Value));
                end;
            end;
            Result := True;
        except
            on E: Exception do begin
                MessageList.Items.Add('JSON解析エラー発生：' + E.Message);
            end;
        end;
        vJsonObj.Free;
    except
        on E: Exception do begin
            MessageList.Items.Add('JSON読込エラー発生：' + E.Message);
        end;
    end;
end;

procedure TThreadSrch.SetCm(Content: string);
var
//	doc: OleVariant;
    Html: TStringList;
begin
(*
	if Assigned(CmBrowser.ControlInterface.Document) then begin
		doc := OleVariant(CmBrowser.Document);
		doc.Clear;
		doc.open;
		doc.charset := 'Shift_JIS';
		doc.Write(Content);
		doc.Close;
    end else begin
        MessageList.Items.Add('CM表示エラー発生');
	end;
*)
    if (CmPath = '') then begin
        MessageList.Items.Add('CM表示エラー発生：一時パス取得失敗');
    end else begin
        Html := TStringList.Create;
        try
            Html.Text := Content;
            Html.SaveToFile(CmPath);
            CmBrowser.Navigate(CmUrl);
        except
            on E: Exception do begin
                MessageList.Items.Add('CM表示エラー発生：' + E.Message);
            end;
        end;
        Html.Free;
	end;
end;

function TThreadSrch.HTMLEncode(const HTML: string): String;
var
    DstStr: String;
begin
	DstStr := CustomStringReplace(HTML,   '&lt;',   '<');
	DstStr := CustomStringReplace(DstStr, '&gt;',   '>');
	DstStr := CustomStringReplace(DstStr, '&quot;', '"');
	Result := CustomStringReplace(DstStr, '&amp;',  '&');
end;

procedure TThreadSrch.InitHttpClient(client: TIdHttp);
begin
	ClearHttpClient(client);
	client.Disconnect;
	client.Request.UserAgent := GikoSys.GetUserAgent;
	//client.RecvBufferSize := Gikosys.Setting.RecvBufferSize;    for Indy10
	client.ProxyParams.BasicAuthentication := False;
	client.ReadTimeout := GikoSys.Setting.ReadTimeOut;
    client.ConnectTimeout := GikoSys.Setting.ReadTimeOut;
	{$IFDEF DEBUG}
	Writeln('------------------------------------------------------------');
	{$ENDIF}
	//FIndy.AllowCookies := False;
	if GikoSys.Setting.ReadProxy then begin
		if GikoSys.Setting.ProxyProtocol then
			client.ProtocolVersion := pv1_1
		else
			client.ProtocolVersion := pv1_0;
		client.ProxyParams.ProxyServer := GikoSys.Setting.ReadProxyAddress;
		client.ProxyParams.ProxyPort := GikoSys.Setting.ReadProxyPort;
		client.ProxyParams.ProxyUsername := GikoSys.Setting.ReadProxyUserID;
		client.ProxyParams.ProxyPassword := GikoSys.Setting.ReadProxyPassword;
		if GikoSys.Setting.ReadProxyUserID <> '' then
			client.ProxyParams.BasicAuthentication := True;
		{$IFDEF DEBUG}
		Writeln('プロキシ設定あり');
		Writeln('ホスト: ' + GikoSys.Setting.ReadProxyAddress);
		Writeln('ポート: ' + IntToStr(GikoSys.Setting.ReadProxyPort));
		{$ENDIF}
	end else begin
		if GikoSys.Setting.Protocol then
			client.ProtocolVersion := pv1_1
		else
			client.ProtocolVersion := pv1_0;
		client.ProxyParams.ProxyServer := '';
		client.ProxyParams.ProxyPort := 80;
		client.ProxyParams.ProxyUsername := '';
		client.ProxyParams.ProxyPassword := '';
		{$IFDEF DEBUG}
		Writeln('プロキシ設定なし');
		{$ENDIF}
	end;
end;

procedure TThreadSrch.ClearHttpClient(client: TIdHttp);
begin
	client.Request.CustomHeaders.Clear;
	client.Request.RawHeaders.Clear;
	client.Request.Clear;
	client.Response.CustomHeaders.Clear;
	client.Response.RawHeaders.Clear;
	client.Response.Clear;

	client.ProxyParams.Clear;
end;

procedure TThreadSrch.ResultListDblClick(Sender: TObject);
begin
    MenuShowThreadClick(MenuShowThread);
end;

procedure TThreadSrch.ChkTopClick(Sender: TObject);
begin
    if (ChkTop.Checked = True) then
        FormStyle := fsStayOnTop
    else
        FormStyle := fsNormal;
end;

procedure TThreadSrch.SaveSetting;
begin
    GikoSys.Setting.ThrdSrchTop := Top;
    GikoSys.Setting.ThrdSrchLeft := Left;
    GikoSys.Setting.ThrdSrchWidth := Width;
    GikoSys.Setting.ThrdSrchHeight := Height;
    if (WindowState = wsMaximized) then
        GikoSys.Setting.ThrdSrchMax := True
    else
        GikoSys.Setting.ThrdSrchMax := False;
    if (ChkTop.Checked = True) then
        GikoSys.Setting.ThrdSrchStay := True
    else
        GikoSys.Setting.ThrdSrchStay := False;
    GikoSys.Setting.ThrdSrchCol1W := ResultList.Column[0].Width;
    GikoSys.Setting.ThrdSrchCol2W := ResultList.Column[1].Width;
    GikoSys.Setting.ThrdSrchCol3W := ResultList.Column[2].Width;
    GikoSys.Setting.ThrdSrchCol4W := ResultList.Column[3].Width;
    GikoSys.Setting.ThrdSrchHistory.Clear;
    GikoSys.Setting.ThrdSrchHistory.AddStrings(CmbKW.Items);
end;

procedure TThreadSrch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    SaveSetting;
end;

procedure TThreadSrch.MenuShowThreadClick(Sender: TObject);
begin
    if (ResultList.Selected <> nil) then
        GikoDM.MoveURLWithHistory(ResultList.Selected.SubItems[2]);
end;

procedure TThreadSrch.MenuCopyURLClick(Sender: TObject);
begin
    if (ResultList.Selected <> nil) then
        Clipboard.AsText := ResultList.Selected.SubItems[2];
end;

procedure TThreadSrch.MenuCopyThreadClick(Sender: TObject);
begin
    if (ResultList.Selected <> nil) then
        Clipboard.AsText := ResultList.Selected.SubItems[0];
end;

procedure TThreadSrch.MenuCopyThrURLClick(Sender: TObject);
begin
    if (ResultList.Selected <> nil) then
        Clipboard.AsText := ResultList.Selected.SubItems[0] + #13#10
                          + ResultList.Selected.SubItems[2];
end;

procedure TThreadSrch.PopupMenuPopup(Sender: TObject);
var
    Enb: Boolean;
begin
    if (ResultList.Selected = nil) then
        Enb := False
    else
        Enb := True;
    MenuShowThread.Enabled := Enb;
    MenuCopyURL.Enabled    := Enb;
    MenuCopyThread.Enabled := Enb;
    MenuCopyThrURL.Enabled := Enb;
end;

procedure TThreadSrch.ChkBbsClick(Sender: TObject);
begin
    if (ChkBbs.Checked = True) then begin
        CmbBoard.Enabled := False;
        PnlBbsName.Font.Color := clWindowText;
        PnlBbsId.Font.Color := clWindowText;
        BtnBbs.Enabled := True;
    end else begin
        CmbBoard.Enabled := True;
        PnlBbsName.Font.Color := clGrayText;
        PnlBbsId.Font.Color := clGrayText;
        BtnBbs.Enabled := False;
    end;
end;

procedure TThreadSrch.BtnBbsClick(Sender: TObject);
var
    CliPos: TPoint;
    ScrPos: TPoint;
begin
    CliPos.X := PnlBbsName.Left;
    CliPos.Y := 0;
    ScrPos := ClientToScreen(CliPos);

    PopMenuBbs.Popup(ScrPos.X, ScrPos.Y);
end;

procedure TThreadSrch.FormShow(Sender: TObject);
const
    HTML_INF = '<font size="-1">検索すると、ここに http://dig.2ch.net/ からの広告が表示されます。<br>広告の内容、収益などについてギコナビ開発者は一切関知しておりません。</font>';
var
    Ini: TIniFile;
    Sec: TStringList;
    Itm: TStringList;
    IdxSec: Integer;
    IdxItm: Integer;
    MaxSec: Integer;
    MaxItm: Integer;
    SecItem: TMenuItem;
    BbsItem: TMenuItem;
    SecName: String;
    BbsName: String;
    BbsId: String;
    SepPos: Integer;
begin
    ResultList.Clear;
    MessageList.Clear;
    CmbKW.Text := '';
    CmbType.ItemIndex := 0;
    CmbMax.ItemIndex := 3;
    CmbLim.ItemIndex := 0;
    CmbSort.ItemIndex := 5;
    CmbBoard.ItemIndex := 0;
    Cmb924.ItemIndex := 1;
    ChkBbs.Checked := False;
    ChkBbsClick(ChkBbs);
    PnlBbsName.Caption := '';
    PnlBbsId.Caption := '';
//    CmBrowser.Navigate('about:blank');
    SetCm(HTML_HD + HTML_INF + HTML_FT);

    PopMenuBbs.Items.Clear;
    BbsNmList.Clear;
    BbsIdList.Clear;

    Sec := TStringList.Create;
    Itm := TStringList.Create;
    Ini := TIniFile.Create(GikoSys.GetBoardFileName);

    Ini.ReadSections(Sec);

    MaxSec := Sec.Count - 1;
    if (MaxSec > 0) then begin
        for IdxSec := 0 to MaxSec do begin
            SecName := Sec.Strings[IdxSec];
            SecItem := TMenuItem.Create(PopMenuBbs);
            PopMenuBbs.Items.Add(SecItem);
            SecItem.Caption := SecName;

            Ini.ReadSection(SecName, Itm);
            MaxItm := Itm.Count - 1;
            if (MaxItm > 0) then begin
                for IdxItm := 0 to MaxItm do begin
                    BbsName := Itm.Strings[IdxItm];
                    BbsId   := Ini.ReadString(SecName, BbsName, '');
                    SepPos := Pos('.2ch.net/', BbsId);
                    if (SepPos > 0) then
                        Delete(BbsId, 1, SepPos + Length('.2ch.net/') - 1);
                    SepPos := Pos('.bbspink.com/', BbsId);
                    if (SepPos > 0) then
                        Delete(BbsId, 1, SepPos + Length('.bbspink.com/') - 1);
                    SepPos := Pos('/', BbsId);
                    if (SepPos > 0) then
                        SetLength(BbsId, SepPos - 1);

                    BbsItem := TMenuItem.Create(PopMenuBbs);
                    SecItem.Add(BbsItem);
                    BbsItem.Caption := BbsName;
                    BbsNmList.Add('【' + SecName + '】【' + BbsName + '】');
                    BbsIdList.Add(BbsId);
                    BbsItem.Tag := BbsIdList.Count - 1;
                    BbsItem.OnClick := MenuBbsClick;
                end;
            end;
        end;
    end;

    Ini.Free;
    Itm.Free;
    Sec.Free;

end;

procedure TThreadSrch.MenuBbsClick(Sender: TObject);
var
    SelItem: TMenuItem;
    BbsName: String;
    BbsId: String;
begin
    if (Sender <> nil) then begin
        SelItem := TMenuItem(Sender);
        if (SelItem.Tag >= 0) and (SelItem.Tag < BbsNmList.Count) then begin
            BbsName := BbsNmList.Strings[SelItem.Tag];
            BbsId   := BbsIdList.Strings[SelItem.Tag];
        end;
    end;
    PnlBbsName.Caption := BbsName;
    PnlBbsId.Caption   := BbsId;
end;

procedure TThreadSrch.FormDestroy(Sender: TObject);
begin
    BbsNmList.Free;
    BbsIdList.Free;
end;

procedure TThreadSrch.LblSiteClick(Sender: TObject);
begin
	GikoSys.OpenBrowser(PChar(LblSite.Caption), gbtAuto);
end;

end.
