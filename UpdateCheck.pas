unit UpdateCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IndyModule,   // for Indy10
  IdTCPConnection, IdTCPClient, IdHTTP, StdCtrls, ExtCtrls, Buttons,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
	/// バージョン情報クラス
  VersionNumber = class
  private
    FValue1:  Integer;	// バージョン番号1要素目
    FValue2:  Integer;	// バージョン番号2要素目
    FValue3:  Integer;	// バージョン番号3要素目
    FValue4:  Integer;	// バージョン番号4要素目
    FVersion: String;		// バージョン番号文字列（n.n.n.n）
    FURL:     String;		// インストーラーURL
  public
  	constructor Create; overload;
  	constructor Create(ASrc: String; AURL: String); overload;

    procedure Clear;
    function SetValue(AVer: String; AURL: String): Boolean;

    function IsGood: Boolean;
    function IsFormal: Boolean;
    function IsSelfNew(const AOther: VersionNumber; ANightly: Boolean): Boolean;

    property Version: String  read FVersion;
    property Value1:  Integer read FValue1;
    property Value2:  Integer read FValue2;
    property Value3:  Integer read FValue3;
    property Value4:  Integer read FValue4;
    property URL:     String  read FURL;
  end;



  TUpdateCheckForm = class(TForm)
    IdHTTP: TIdHTTP;
    CancelBitBtn: TBitBtn;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    CurNameLabel: TLabel;
    CurVerLabel: TLabel;
    CurTypLabel: TLabel;
    CheckButton: TButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    NewVerLabel: TLabel;
    NewMsgLabel: TLabel;
    UpdateNewButton: TButton;
    NlyNameLabel: TLabel;
    Label9: TLabel;
    NlyVerLabel: TLabel;
    NlyMsgLabel: TLabel;
    UpdateNlyButton: TButton;
    GroupBox2: TGroupBox;
    CloseButton: TButton;
    NewNameLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    NewDateLabel: TLabel;
    Label3: TLabel;
    NlyDateLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure CheckButtonClick(Sender: TObject);
    procedure UpdateNewButtonClick(Sender: TObject);
    procedure UpdateNlyButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private 宣言 }
    FExecPath : string;
    FExecArgs : string;
    FAllowshutdown : Boolean;
    FCanceled : Boolean;
    FCurVer: VersionNumber;		// 現在のバージョン
    FFmlVer: VersionNumber;		// 最新正式版バージョン
    FNlyVer: VersionNumber;		// 最新人柱版バージョン
    function GetDesktopDir:string;
    function GetDownloadFilePath(FileName: String): String;
    function CreateShortCut(FileName, Argment, SavePath :string):boolean;
    function DonwloadUpdate(url: String): Boolean;
    procedure UpdateProc(newVer: VersionNumber);
    function QueryYesNo(msg: PChar; title: PChar): Integer;
  public
    { Public 宣言 }
    property ExecPath :String read FExecPath;
    property ExecArgs :String read FExecArgs;
    property Allowshutdown :Boolean read FAllowshutdown;
  end;

var
  UpdateCheckForm: TUpdateCheckForm;

implementation
uses
    GikoSystem, NewBoard, Giko, IniFiles, MojuUtils, GikoDataModule,
    ActiveX, ComObj, ShlObj, GikoUtil;

{$R *.dfm}

//! Formコンストラクタ
procedure TUpdateCheckForm.FormCreate(Sender: TObject);
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

  FExecPath := '';
  FExecArgs := '';
  FAllowshutdown := False;

  FCurVer := VersionNumber.Create(GikoSys.Version, '');
  FFmlVer := VersionNumber.Create;
  FNlyVer := VersionNumber.Create;

  CurNameLabel.Caption := BETA_VERSION_NAME_J + IntToStr(BETA_VERSION);
  CurVerLabel.Caption  := FCurVer.Version;
  if not FCurVer.IsGood then begin
    CurTypLabel.Caption := 'エラー発生';
    CheckButton.Enabled := False;
  end else if FCurVer.IsFormal then
    CurTypLabel.Caption := ''
  else
    CurTypLabel.Caption := '人柱版です。';
	NewNameLabel.Caption := '正式版';
  NewDateLabel.Caption := '_';
  NewVerLabel.Caption  := '_';
  NewMsgLabel.Caption  := '未確認です。';
  NlyNameLabel.Caption := '人柱版';
  NlyDateLabel.Caption := '_';
  NlyVerLabel.Caption  := '_';
  NlyMsgLabel.Caption  := '未確認です。';
  UpdateNewButton.Enabled := False;
  UpdateNlyButton.Enabled := False;
end;

//! 最新版の確認ボタンクリック
procedure TUpdateCheckForm.CheckButtonClick(Sender: TObject);
const
{$IFDEF DEBUG}
	CHECK_URL = 'https://digital-cat.github.io/gikog2/updater/debug.txt';
{$ELSE}
	CHECK_URL = 'https://digital-cat.github.io/gikog2/updater/latest.txt';
{$ENDIF}
var
  value: string;
  ResStream: TMemoryStream;
  downResult: TStringList;
begin
  FExecPath := '';
  FExecArgs := '';
  FAllowshutdown := False;
  Screen.Cursor := crHourGlass;

  CheckButton.Enabled := False;
  CloseButton.Enabled := False;

  FFmlVer.Clear;
  FNlyVer.Clear;
	NewVerLabel.Caption := '_';
	NlyVerLabel.Caption := '_';
  NewMsgLabel.Caption := ' ';
  NlyMsgLabel.Caption := ' ';
  UpdateNewButton.Enabled := False;
  UpdateNlyButton.Enabled := False;

  try
    ResStream := TMemoryStream.Create;
    try
      TIndyMdl.InitHTTP(IdHTTP);
      IdHTTP.Request.Referer := '';
      IdHTTP.Request.AcceptEncoding := 'gzip';

      IdHTTP.Request.CacheControl := 'no-cache';
      IdHTTP.Request.CustomHeaders.Add('Pragma: no-cache');
      IdHTTP.ReadTimeout := 0;
      IdHTTP.HandleRedirects := true;
      downResult := TStringList.Create;
      IndyMdl.StartAntiFreeze(250);
      try
        try
          ResStream.Clear;
          FCanceled := False;
          CancelBitBtn.Enabled := True;
          IdHTTP.Get(CHECK_URL, ResStream);
          CancelBitBtn.Enabled := False;
          if (FCanceled) then begin
            raise Exception.Create('ダウンロードがキャンセルされました。');
          end;
          value := GikoSys.GzipDecompress(ResStream, IdHTTP.Response.ContentEncoding);
          downResult.Text := value;

          // バージョン番号解析
          FFmlVer.SetValue(downResult.Values[ 'version' ],   downResult.Values[ 'url' ]);
          FNlyVer.SetValue(downResult.Values[ 'n_version' ], downResult.Values[ 'n_url' ]);

          NewVerLabel.Caption  := FFmlVer.Version;
          NlyVerLabel.Caption  := FNlyVer.Version;
          NewNameLabel.Caption := downResult.Values[ 'name' ];
          NlyNameLabel.Caption := downResult.Values[ 'n_name' ];
          NewDateLabel.Caption := downResult.Values[ 'date' ];
          NlyDateLabel.Caption := downResult.Values[ 'n_date' ];

          // 正式版バージョン確認
          if (not FFmlVer.IsGood) or (FFmlVer.URL = '') then
            NewMsgLabel.Caption := 'エラー発生'
          else if not FFmlVer.IsSelfNew(FCurVer, False) then
            NewMsgLabel.Caption := '更新不要です。'
          else begin
            NewMsgLabel.Caption := '更新可能です。';
            UpdateNewButton.Enabled := True;
          end;

          // 人柱版バージョン確認
          if (not FNlyVer.IsGood) or (FNlyVer.URL = '') then
            NlyMsgLabel.Caption := 'エラー発生'
          else if not FNlyVer.IsSelfNew(FCurVer, True) then
            NlyMsgLabel.Caption := '更新不要です。'
          else begin
            NlyMsgLabel.Caption := '更新可能です。';
            UpdateNlyButton.Enabled := True;
          end;

        except
          on E: Exception do begin
            GikoUtil.MsgBox(Handle, PChar(E.Message), '最新版の確認', MB_OK or MB_ICONERROR);
            {$IFDEF DEBUG}
            Writeln(IdHTTP.ResponseText);
            {$ENDIF}
          end;
        end;
      finally
        downResult.Free;
        IndyMdl.EndAntiFreeze;
      end;
    finally
      ResStream.Clear;
      ResStream.Free;
    end;
  finally
	  CheckButton.Enabled := True;
	  CloseButton.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;


//! 最新版に更新ボタンクリック
procedure TUpdateCheckForm.UpdateNewButtonClick(Sender: TObject);
begin
  UpdateProc(FFmlVer);
end;

//! 人柱版に更新ボタンクリック
procedure TUpdateCheckForm.UpdateNlyButtonClick(Sender: TObject);
begin
	if QueryYesNo('正式リリース版ではありませんがよろしいですか？', '更新確認') = ID_YES then
		UpdateProc(FNlyVer);
end;

//! YES/NO問い合わせメッセージボックス表示
function TUpdateCheckForm.QueryYesNo(msg: PChar; title: PChar): Integer;
begin
	Result := GikoUtil.MsgBox(Handle, msg, title, MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2);
end;

//! 更新実行処理
procedure TUpdateCheckForm.UpdateProc(newVer: VersionNumber);
begin
  if (not newVer.IsGood) or (newVer.URL = '') then begin
  	GikoUtil.MsgBox(Handle, '更新情報が確認できませんでした。', '更新確認', MB_OK or MB_ICONERROR);
    Exit;
  end;

	if QueryYesNo('新しいギコナビをダウンロードしますか？', '更新確認') <> ID_YES then
  	Exit;

	if not DonwloadUpdate(newVer.URL) then
  	Exit;

  if QueryYesNo('更新のためギコナビを再起動します。よろしいですか？', '終了確認') = ID_YES then begin
    FAllowshutdown := True;
    Close;
  end;
end;

//! アップデートダウンロード
function TUpdateCheckForm.DonwloadUpdate(url: String): Boolean;
var
  filename : String;
  fileStrem: TFileStream;
  msg: String;
  ok: Boolean;
begin
  CheckButton.Enabled := False;
	CloseButton.Enabled := False;
  FCanceled := False;

  filename := GetDownloadFilePath(Copy(url, LastDelimiter('/', url) + 1,  Length(url)));
  fileStrem := TFileStream.Create(filename, fmCreate);
  try
  	ok := False;
    CancelBitBtn.Enabled := True;
		IndyMdl.StartAntiFreeze(250);
    try
	    IdHTTP.Get(url, fileStrem);
      ok := True;
    except
			on e: Exception do begin
      	msg := 'ダウンロードに失敗しました。' + #13#10 + e.Message;
    		GikoUtil.MsgBox(Handle, PChar(msg), '更新エラー', MB_OK or MB_ICONERROR);
	    end;
    end;
		IndyMdl.EndAntiFreeze;
    CancelBitBtn.Enabled := False;
    if (not ok) or FCanceled then begin
	    if FCanceled then
				GikoUtil.MsgBox(Handle, 'ダウンロードがキャンセルされました。', 'ギコナビ更新', MB_OK or MB_ICONWARNING);
    	Result := False;
      Exit;
    end;
    //ResultMemo.Lines.Add(
		//			IdHttp.ResponseText + '(' + IntToStr(IdHttp.ResponseCode) + ')');

    try
      FExecPath := filename;
      FExecArgs := '/SP- /silent /noicons "/dir=' + GikoSys.GetAppDir + '"';
      if CreateShortCut(execPath, execArgs, GetDesktopDir) then begin
        //ResultMemo.Lines.Add('デスクトップに"ギコナビ更新"ショートカットを作成しました。');
        // ResultMemo.Lines.Add('ギコナビを終了して、"ギコナビ更新"ショートカットをダブルクリックしてください。');
      end else begin
        //ResultMemo.Lines.Add('デスクトップにショートカットを作成できませんでした。');
      end;
      Result := True;
    except
			on e: Exception do begin
      	msg := 'ギコナビ更新ショートカットの作成に失敗しました。' + #13#10 + e.Message;
    		GikoUtil.MsgBox(Handle, PChar(msg), '更新エラー', MB_OK or MB_ICONERROR);
	    	Result := False;
	    end;
    end;

  finally
		fileStrem.Free;
    CheckButton.Enabled := True;
    CloseButton.Enabled := True;
  end;
end;

//! ダウンロードしたファイルの保存パス
function  TUpdateCheckForm.GetDownloadFilePath(FileName: String): String;
var
    TempPath: array[0..MAX_PATH] of Char;
begin
    GetTempPath(MAX_PATH, TempPath);
    Result := IncludeTrailingPathDelimiter(TempPath) + FileName;
end;


//! デスクトップのパスを取得する関数
function  TUpdateCheckForm.GetDesktopDir:string;
var
    DeskTopPath: array[0..MAX_PATH] of Char;
    pidl: PItemIDList;
begin
    SHGetSpecialFolderLocation(Application.Handle, CSIDL_DESKTOP, pidl);
    SHGetPathFromIDList(pidl, DesktopPath);
    Result := DesktopPath;
end;

//! ショートカットを作成する関数
function  TUpdateCheckForm.CreateShortCut(FileName, Argment, SavePath :string):boolean;
//FileName…ショートカットを作成するファイル名
//SavePath….lnkファイルを作成するディレクトリ
var
    SL :IShelllink;
    PF :IPersistFile;
    wFileName :WideString;
begin
    Result :=false;
    //IUnKnownオブジェクトを作成して、IShellLinkにキャスト
    SL :=CreateComObject(CLSID_ShellLink) as IShellLink;
    //IPersistFile にキャスト
    PF :=SL as IPersistFile;

    if (SL.SetPath(PChar(FileName)) <> NOERROR) then begin
        Exit;
    end;
    if (SL.SetWorkingDirectory(PChar(ExtractFilePath(FileName)))
                                   <> NOERROR ) then begin
        Exit;
    end;
    if (SL.SetArguments(PChar(Argment)) <> NOERROR) then begin
        Exit;
    end;
    if (SL.SetDescription(PChar('ギコナビ更新')) <> NOERROR) then begin
        Exit;
    end;

    //IPersistFileのSaveメソッドにはPWChar型のパラメータが必要
    wFileName :=SavePath +'\ギコナビ更新.lnk';
    //ショートカットを作成
    if (PF.Save(PWChar(wFileName),True) <> NOERROR) then begin
        Exit;
    end;
    Result :=true;
end;

//! キャンセルボタン押下
procedure TUpdateCheckForm.CancelBitBtnClick(Sender: TObject);
begin
  CancelBitBtn.Enabled := False;
  FCanceled := True;
  if IdHTTP.Connected then begin
		IdHTTP.Disconnect;
  end;
end;

//! 閉じるボタンクリック
procedure TUpdateCheckForm.CloseButtonClick(Sender: TObject);
begin
	Close;
end;

//! フォームクローズ確認
procedure TUpdateCheckForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
	CanClose := CloseButton.Enabled or FAllowshutdown;
end;




////////////////////////////////////////////////////////////////////////////////

//! バージョン情報クラスコンストラクタ
constructor VersionNumber.Create;
begin
  Clear;
end;

//! バージョン情報クラスコンストラクタ
constructor VersionNumber.Create(ASrc: String; AURL: String);
begin
	SetValue(ASrc, AURL);
end;

//! クリア
procedure VersionNumber.Clear;
begin
  FValue1  := 0;
  FValue2  := 0;
  FValue3  := 0;
  FValue4  := 0;
  FVersion := '';
  FURL     := '';
end;

//! バージョン情報セット
function VersionNumber.SetValue(AVer: String; AURL: String): Boolean;
var
	split: TStringList;
begin
  FValue1  := 0;
  FValue2  := 0;
  FValue3  := 0;
  FValue4  := 0;
  FVersion := Trim(AVer);
  FURL     := Trim(AURL);

  split := TStringList.Create;
  try
		split.Text := MojuUtils.CustomStringReplace(AVer, '.', #10, false);
    if split.Count > 0 then
		  FValue1 := StrToIntDef(split[0], 0);
    if split.Count > 1 then
		  FValue2 := StrToIntDef(split[1], 0);
    if split.Count > 2 then
		  FValue3 := StrToIntDef(split[2], 0);
    if split.Count > 3 then
		  FValue4 := StrToIntDef(split[3], 0);
  finally
  	split.Free;
  end;

	Result := IsGood;
end;

//! 正常値確認
function VersionNumber.IsGood: Boolean;
begin
  Result := (FValue1 > 0) and (FValue2 > 0) and (FValue3 >= 0) and (FValue4 > 0);
end;

//! 正式版かどうか
function VersionNumber.IsFormal: Boolean;
begin
  Result := (FValue1 > 0) and (FValue2 > 0) and (FValue3 = 1) and (FValue4 > 0);
end;

//! 自身の方が新しいバージョンか確認
function VersionNumber.IsSelfNew(const AOther: VersionNumber; ANightly: Boolean): Boolean;
begin
  if ANightly then
  	Result := FValue4 > AOther.FValue4
  else
    Result := (FValue1 > AOther.FValue1) or
            	((FValue1 = AOther.FValue1) and (FValue2 > AOther.FValue2)) or
            	((FValue1 = AOther.FValue1) and (FValue2 = AOther.FValue2)) and (FValue3 > AOther.FValue3);
end;

end.
