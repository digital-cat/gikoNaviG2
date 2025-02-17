unit ThreadSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Menus, Clipbrd, IniFiles,
  OleCtrls, SHDocVw, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, StrUtils, TntComCtrls, TntStdCtrls;

type
  TColumnType = (ctString, ctInteger, ctDecimal);

  TThreadSrch = class(TForm)
    Indy: TIdHTTP;
    PopupMenu: TPopupMenu;
    MenuShowThread: TMenuItem;
    N1: TMenuItem;
    MenuCopyURL: TMenuItem;
    MenuCopyThread: TMenuItem;
    MenuCopyThrURL: TMenuItem;
    Panel1: TPanel;
    PanelHead: TPanel;
    Label1: TLabel;
    BtnSearch: TButton;
    ChkTop: TCheckBox;
    ChkNG: TCheckBox;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    RadioGroupDomain: TRadioGroup;
    MemoHelp: TMemo;
    ButtonHelp: TButton;
    ResultList: TTntListView;
    CmbKW: TTntComboBox;
    MessageList: TTntListBox;
    Splitter1: TSplitter;
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
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure ResultListColumnClick(Sender: TObject; Column: TListColumn);
    procedure ResultListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private 宣言 }
    FSortIdx: Integer;
    FSortAsc: Boolean;

    procedure AddHistory;
    function ParsHtml(HtmlStream: TMemoryStream): Boolean;
    function ExtractKW(src: String; kws: String; kwe: String; var dst: String): Boolean;
    function NumComp(text1, text2: String): Integer;
    function DecComp(text1, text2: String): Integer;
    function atoi(str: String; var numLen: Integer): Integer;
    function atof(str: String): Double;
  public
    { Public 宣言 }
    procedure SaveSetting;
  end;

var
  ThreadSrch: TThreadSrch = nil;
const
  ENC_SJIS: DWORD = 932;
  ENC_UTF8: DWORD = 65001;
  IDX_TTL: Integer = 0;
  IDX_URL: Integer = 4;
  H_PNLHD_HIDE: Integer = 113;
  H_PNLHD_SHOW: Integer = 250;
  HELP_FILE_NAME: String = 'ThreadSearch.txt';

  COL_TYPE: array [0..5] of TColumnType = (
  	ctString,
  	ctString,
    ctInteger,
  	ctString,
  	ctDecimal,
  	ctString
  );

implementation

uses GikoSystem, GikoDataModule, MojuUtils, BoardGroup, IndyModule, YofUtils, WideCtrls;

{$R *.dfm}

procedure TThreadSrch.FormCreate(Sender: TObject);
var
  i: Integer;
begin
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
  ResultList.Column[4].Width := GikoSys.Setting.ThrdSrchCol5W;
  ResultList.Column[5].Width := GikoSys.Setting.ThrdSrchCol6W;
  for i := 0 to GikoSys.Setting.ThrdSrchHistory.Count - 1 do
    CmbKW.Items.Add(EncAnsiToWideString(GikoSys.Setting.ThrdSrchHistory.Strings[i]));
  FSortIdx := 0;
  FSortAsc := True;
end;

procedure TThreadSrch.BtnSearchClick(Sender: TObject);
var
  URL: String;
  RspStream: TMemoryStream;
  Ok: Boolean;
  url2: String;
begin
  if CmbKW.Text = '' then begin
    MessageBox(Handle, '検索キーワードを指定してください。', PChar(Text), MB_OK or MB_ICONERROR);
    Exit;
  end;

  Screen.Cursor := crHourGlass;

  try

    ResultList.Clear;
    AddHistory;

    URL := 'https://find.5ch.net/search?q=' + HttpEncode(UTF8Encode(CmbKW.Text));
    if RadioGroupDomain.ItemIndex = 1 then
      URL := URL + '&domain=bbspink.com';

    RspStream := TMemoryStream.Create;

    try
      Ok := False;
      TIndyMdl.InitHTTP(Indy);
      url2 := GikoSys.GetActualURL(url);

      IndyMdl.StartAntiFreeze(100);
      try
        Indy.Get(url2, RspStream);
        Ok := True;
      except
        on E: Exception do begin
          MessageList.Items.Add('エラー発生：' + E.Message);
        end;
      end;
      IndyMdl.EndAntiFreeze;

      if Ok then begin
        if (RspStream.Size > 0) then begin
          RspStream.Position := 0;
          //RspStream.SaveToFile('d:\Log\search.html');
          Ok := ParsHtml(RspStream);
        end;
        if Ok then
          MessageList.Items.Add(WideFormat('【%s】検索結果：%d件', [CmbKW.Text, ResultList.Items.Count]));
      end;

      MessageList.TopIndex := MessageList.Count - 1;

    finally
      RspStream.Free;
    end;

  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TThreadSrch.AddHistory;
const
    HISTORY_MAX: Integer = 20;
var
    KW: WideString;
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


function TThreadSrch.ExtractKW(src: String; kws: String; kwe: String; var dst: String): Boolean;
var
  idx1: Integer;
  idx2: Integer;
begin
  Result := False;
  idx1 := Pos(kws, src);
  if idx1 > 0 then begin
    idx1 := idx1 + Length(kws);
    idx2 := PosEx(kwe, src, idx1);
    if idx2 > 0 then begin
      dst := Copy(src, idx1, idx2 - idx1);
      Result := True;
    end;
  end;
end;

function TThreadSrch.ParsHtml(HtmlStream: TMemoryStream): Boolean;
const
  KW_LINE_S: String = '<div class="list_line">';
  KW_URL_S:  String = '<a class="list_line_link" href="';
  KW_URL_E:  String = '"';
  KW_TTL_S:  String = '<div class="list_line_link_title">';
  KW_TTL_E:  String = '</div>';
  KW_BRD_S:  String = '<div class="list_line_info_container list_line_info_container-board">';
  KW_BRD_E:  String = '</a></div>';
  KW_PDT_S:  String = '<div class="list_line_info_container">';
  KW_PDT_E:  String = '</div>';
  KW_PPD_S:  String = '<div class="list_line_info_container list_line_info_container-danger">';
  KW_PPD_E:  String = '</div>';
var
  Item: TTntListItem;
  html: String;
  line: String;
  url: String;
  title: String;
  titlew: WideString;
  board: String;
  pstdt: String;
  ppday: String;
  rescnt: String;
  idx: Integer;
  idxNxt: Integer;
  len: Integer;
  cnt: Integer;
  eof: Boolean;
begin
  Result := False;
  try
    HtmlStream.Position := 0;
    html := GikoSys.UTF8toSJIS(PChar(HtmlStream.Memory));

    try

      eof := False;
      idx := Pos(KW_LINE_S, html);

      while (not eof) and (idx > 0) do begin
        idx := idx + Length(KW_LINE_S);
        idxNxt := PosEx(KW_LINE_S, html, idx);
        if idxNxt > 0 then
          line := Copy(html, idx, idxNxt - idx)
        else begin
          line := Copy(html, idx, Length(html) - idx);
          eof := True;
        end;

        url  := '';
        title := '';

        if ExtractKW(line, KW_URL_S, KW_URL_E, url) and
           ExtractKW(line, KW_TTL_S, KW_TTL_E, title) and
           ExtractKW(line, KW_BRD_S, KW_BRD_E, board) and
           ExtractKW(line, KW_PDT_S, KW_PDT_E, pstdt) and
           ExtractKW(line, KW_PPD_S, KW_PPD_E, ppday) then begin

          cnt := Pos('>', board);
          if cnt > 0 then
            Delete(board, 1, cnt);

          len := Length(title);
          if (len > 3) and (title[len] = ')') then begin
            cnt := len - 1;
            while cnt > 0 do begin
              if title[cnt] = '(' then begin
                rescnt := Copy(title, cnt + 1, len - 1 - cnt);
                SetLength(title, cnt - 1);
                Break;
              end;
              Dec(cnt);
            end;
          end;

          titlew := EncAnsiToWideString(HtmlDecode(title));

          if (not ChkNG.Checked) or
             (not ThreadNgList.IsNG(title, GikoSys.Setting.NGThreadInvis)) then begin
            Item := ResultList.Items.Add;
            Item.Caption := board;
            Item.SubItems.Add(titlew);
            Item.SubItems.Add(rescnt);
            Item.SubItems.Add(pstdt);
            Item.SubItems.Add(ppday);
            Item.SubItems.Add(url);
          end;
        end;

        idx := idxNxt;
      end;
      Result := True;
    except
      on E: Exception do begin
        MessageList.Items.Add('検索結果解析エラー発生：' + E.Message);
      end;
    end;

  except
    on E: Exception do begin
      MessageList.Items.Add('検索結果変換エラー発生：' + E.Message);
    end;
  end;
end;

function TThreadSrch.atoi(str: String; var numLen: Integer): Integer;
var
  num, code, i: Integer;
begin
	numLen := 0;
	num := 0;
	for i := 1 to Length(str) do begin
  	code := Ord(str[i]);
    if (code and $F0) <> $30 then
    	Break;
    num := (num * 10) + (code and $0F);
    Int(numLen);
  end;
	Result := num;
end;

function TThreadSrch.atof(str: String): Double;
var
  code, i, len: Integer;
begin
	len := 0;
	for i := 1 to Length(str) do begin
  	code := Ord(str[i]);
    if ((code and $F0) <> $30) and (str[i] <> '.') then
    	Break;
    Inc(len);
  end;
	Result := StrToFloatDef(Copy(str, 1, len), 0);
end;

function TThreadSrch.NumComp(text1, text2: String): Integer;
var
	tmp: Integer;
begin
	Result := atoi(text1, tmp) - atoi(text2, tmp);
end;

function TThreadSrch.DecComp(text1, text2: String): Integer;
var
  dec1, dec2: Double;
begin
  dec1 := atof(text1);
  dec2 := atof(text2);

  if dec1 < dec2 then
    Result := -1
  else if dec1 = dec2 then
    Result := 0
  else
    Result := 1;
  //MessageList.Items.Add(Format('DecComp(%s, %s) [%f][%f] : [%d]', [text1, text2, dec1, dec2, Result]));
end;

procedure TThreadSrch.ResultListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if FSortIdx = Column.Index then
    FSortAsc := not FSortAsc
  else begin
    FSortIdx := Column.Index;
    FSortAsc := True;
  end;
  ResultList.SortType := stNone;
  ResultList.SortType := stData;
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
var
  i: Integer;
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
    GikoSys.Setting.ThrdSrchCol5W := ResultList.Column[4].Width;
    GikoSys.Setting.ThrdSrchCol6W := ResultList.Column[5].Width;
    GikoSys.Setting.ThrdSrchHistory.Clear;
    for i := 0 to CmbKW.Items.Count - 1 do
      GikoSys.Setting.ThrdSrchHistory.Add(WideToEncAnsiString(CmbKW.Items.Strings[i]));
end;

procedure TThreadSrch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    SaveSetting;
end;

procedure TThreadSrch.MenuShowThreadClick(Sender: TObject);
begin
    if (ResultList.Selected <> nil) then
        GikoDM.MoveURLWithHistory(ResultList.Selected.SubItems[IDX_URL]);
end;

procedure TThreadSrch.MenuCopyURLClick(Sender: TObject);
begin
    if (ResultList.Selected <> nil) then
        Clipboard.AsText := ResultList.Selected.SubItems[IDX_URL];
end;

procedure TThreadSrch.MenuCopyThreadClick(Sender: TObject);
begin
    if (ResultList.Selected <> nil) then
        Clipboard.AsText := ResultList.Selected.SubItems[IDX_TTL];
end;

procedure TThreadSrch.MenuCopyThrURLClick(Sender: TObject);
begin
    if (ResultList.Selected <> nil) then
        Clipboard.AsText := ResultList.Selected.SubItems[IDX_TTL] + #13#10
                          + ResultList.Selected.SubItems[IDX_URL];
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

procedure TThreadSrch.ResultListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  text1, text2: String;
  typ: TColumnType;
begin
  if (FSortIdx > 0) and (FSortIdx <= Item1.SubItems.Count) then begin
    text1 := Item1.SubItems.Strings[FSortIdx - 1];
    text2 := Item2.SubItems.Strings[FSortIdx - 1];
  end else begin
    text1 := Item1.Caption;
    text2 := Item2.Caption;
  end;

  if (FSortIdx >= Low(COL_TYPE)) and (FSortIdx <= High(COL_TYPE)) then
    typ := COL_TYPE[FSortIdx]
  else
    typ := ctString;

  case typ of
  ctInteger: Compare := NumComp(text1, text2);
  ctDecimal: Compare := DecComp(text1, text2);
  //ctString:
  else       Compare := AnsiCompareStr(text1, text2);
  end;

  if not FSortAsc then
    Compare := Compare * -1;
end;

procedure TThreadSrch.FormShow(Sender: TObject);
var
  path: String;
begin
  MemoHelp.Visible := False;
  PanelHead.Height := H_PNLHD_HIDE;
  ResultList.Clear;
  MessageList.Clear;
  CmbKW.Text := '';

  try
    path := GikoSys.GetConfigDir + HELP_FILE_NAME;
    if FileExists(path) then
      MemoHelp.Lines.LoadFromFile(path);
  except
    on E: Exception do begin
      MessageList.Items.Add('ヘルプファイル読み込みエラー発生：' + E.Message);
    end;
  end;
end;

procedure TThreadSrch.ButtonHelpClick(Sender: TObject);
begin
  if MemoHelp.Visible then begin
    MemoHelp.Visible := False;
    PanelHead.Height := H_PNLHD_HIDE;
  end else begin
    MemoHelp.Visible := True;
    PanelHead.Height := H_PNLHD_SHOW;
  end;
end;

procedure TThreadSrch.FormResize(Sender: TObject);
begin
  BtnSearch.Left := PanelHead.Width - 6 - BtnSearch.Width;
  CmbKW.Width    := BtnSearch.Left  - 6 - CmbKW.Left;
  MemoHelp.Width := PanelHead.Width - 6 - MemoHelp.Left;
end;

end.
