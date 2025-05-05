unit MachiBBSAcquireBoard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdURI, IdGlobal, StrUtils;

type
  TMachiBBSAcquireBoardForm = class(TForm)
    Label1: TLabel;
    EditURL: TEdit;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    MemoLog: TMemo;
    ButtonGet: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonGetClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FBBSList: TStringList;
    FPathBBSList: String;

    procedure ParseHtml(html: String);
    function ExtractKw(src: String; kws: String; kwe: String; var val: String): Boolean;
    function RegulateURL(src: String): String;
  public

  published
    property PathBBSList: String read FPathBBSList write FPathBBSList;

  end;

var
  MachiBBSAcquireBoardForm: TMachiBBSAcquireBoardForm;

const
  /// 板一覧取得URL初期値
  DEFAULT_URL: String = 'https://machi.to/bbsmenu.html';

implementation

uses Math, IniFiles,
	PlugInMain, FilePath, Y_TextConverter, MojuUtils;

{$R *.dfm}

/// フォーム構築
procedure TMachiBBSAcquireBoardForm.FormCreate(Sender: TObject);
begin
  FBBSList := TStringList.Create;

  EditURL.Text := DEFAULT_URL;
  ButtonOk.Enabled := False;
end;

/// フォーム破棄
procedure TMachiBBSAcquireBoardForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FBBSList);
end;

/// 板一覧取得ボタンクリック
procedure TMachiBBSAcquireBoardForm.ButtonGetClick(Sender: TObject);
const
  MSG_CAP: String = '板一覧取得';
var
  url             : String;
	responseCode    : Longint;
	modified	 			: Double;
	tmp							: PChar;
  html: String;
begin
  ButtonOk.Enabled := False;

  url := EditURL.Text;
  if url = '' then begin
    MessageBox(Handle, '板一覧を取得するURLを指定してください。', PChar(MSG_CAP), MB_OK or MB_ICONWARNING);
    Exit;
  end;

  MemoLog.Lines.Add(Format('板一覧を取得します。[%s]', [url]));

  try

		responseCode := InternalDownload( PChar( url ), modified, tmp );

    MemoLog.Lines.Add(Format('HTTPステータスコード[%d]', [responseCode]));

    if responseCode <> 200 then begin
      MemoLog.Lines.Add('板一覧の取得に失敗しました。');
      Exit;
    end;

    if tmp = nil then begin
      MemoLog.Lines.Add('板一覧を取得できませんでした。');
      Exit;
    end;

    MemoLog.Lines.Add('取得したHTMLを解析します。');

    html := tmp;
    ParseHtml(html);

    if FBBSList.Count > 1 then begin
      MemoLog.Lines.Add(Format('取得した板の数[%d]', [FBBSList.Count - 1]));
      MemoLog.Lines.Add('正常に終了しました。');
    end else begin
      MemoLog.Lines.Add('HTMLから板の情報を取得できませんでした。');
    end;

  except
    on e: Exception do begin
      MemoLog.Lines.Add(Format('エラーが発生しました。[%s]', [e.Message]));
    end;
  end;

  MemoLog.Lines.Add('----------');

  ButtonOk.Enabled := (FPathBBSList <> '') and (FBBSList.Count > 1);
  
end;

/// HTML解析処理
procedure TMachiBBSAcquireBoardForm.ParseHtml(html: String);
const
  KW_BR1_S: String = '<a href=';
  KW_BR1_E: String = '</a>';
  KW_BR2_S: String = '<A HREF=';
  KW_BR2_E: String = '</A>';
  SECTION:  String = '[まちBBS]';
var
  board: String;
  url:   String;
  tmp:   String;
  idx:   Integer;
  i:     Integer;
  lines: TStringList;
begin

  FBBSList.Clear;
  lines := TStringList.Create;

  try
    lines.Text := html;

    for i := 0 to lines.Count - 1 do begin

      if ExtractKw(lines[i], KW_BR1_S, KW_BR1_E, tmp) or
         ExtractKw(lines[i], KW_BR2_S, KW_BR2_E, tmp) then begin

        tmp := Trim(tmp);
        idx := Pos('>', tmp);
        if idx > 1 then begin
          url := RegulateURL(Copy(tmp, 1, idx - 1));
          board := Trim(Copy(tmp, idx + 1, Length(tmp) - idx));

          if (url <> '') and (board <> '') then
            FBBSList.Add(board + '=' + url);

        end;
      end;
    end;

    if FBBSList.Count > 0 then
      FBBSList.Insert(0, SECTION);

  finally
    lines.Free;
  end;

end;

/// URL調整
function TMachiBBSAcquireBoardForm.RegulateURL(src: String): String;
var
  tmp: String;
  len: Integer;
begin
  Result := '';

  tmp := Trim(src);
  len := Length(tmp);

  if len < 10 then
    Exit;

  if tmp[1] = '"' then begin
    tmp := Copy(tmp, 2, len - 1);
    Dec(len);
  end;
  if tmp[len] = '"' then begin
    tmp := Copy(tmp, 1, len - 1);
  end;

  tmp := Trim(tmp);

  if (Pos('https://', tmp) = 1) or (Pos('http://', tmp) = 1) then
    Result := tmp;

end;

/// キーワード抽出
function TMachiBBSAcquireBoardForm.ExtractKw(src: String; kws: String; kwe: String; var val: String): Boolean;
var
  i1: Integer;
  i2: Integer;
begin
  Result := False;

  i1 := Pos(kws, src);
  if i1 < 1 then
    Exit;

  i1 := i1 + Length(kws);
  i2 := PosEx(kwe, src, i1);
  if i2 < i1 then
    Exit;

  val := Copy(src, i1, i2 - i1);

  Result := True;
end;

/// OKボタンクリック
procedure TMachiBBSAcquireBoardForm.ButtonOkClick(Sender: TObject);
begin
  // 板一覧を保存
  if FPathBBSList <> '' then begin
    try
      FBBSList.SaveToFile(FPathBBSList);

      MessageBox(Handle, 'まちBBSの板一覧を更新しました。' + #13 +
                          'ギコナビを再起動してください。',
                          PChar(Caption), MB_OK or MB_ICONINFORMATION);
      ModalResult := mrOk;

    except
      on e: Exception do begin
        MessageBox(Handle, PChar('まちBBSの板一覧をファイル保存できませんでした。' + #13 + e.Message),
                           PChar(Caption), MB_OK or MB_ICONERROR);
      end;
    end;

  end else
    ButtonOk.Enabled := False;

end;

end.
