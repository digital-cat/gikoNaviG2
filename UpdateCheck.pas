unit UpdateCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IndyModule,   // for Indy10
  IdTCPConnection, IdTCPClient, IdHTTP, StdCtrls, ExtCtrls, Buttons,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TUpdateCheckForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ResultMemo: TMemo;
    UpdateButton: TButton;
    IdHTTP: TIdHTTP;
    NightBuildCheckButton: TButton;
    CancelBitBtn: TBitBtn;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    procedure UpdateButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NightBuildCheckButtonClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
  private
    { Private 宣言 }
    FExecPath : string;
    FExecArgs : string;
    FAllowshutdown : Boolean;
    FCanceled : Boolean;
    function  GetDesktopDir:string;
    function  GetDownloadFilePath(FileName: String): String;
    function  CreateShortCut(FileName, Argment, SavePath :string):boolean;
    procedure DonwloadUpdate(url: String);
    function CheckUpdate(nightbuild :Boolean): Boolean;
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
//! 正規版
procedure TUpdateCheckForm.UpdateButtonClick(Sender: TObject);
begin
    if CheckUpdate(false) then begin
        if GikoUtil.MsgBox(Handle, '更新があるためギコナビを再起動しますか？', '終了確認',
            MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) = ID_YES then begin
            FAllowshutdown := True;
            close;
        end;
    end;
end;
//! 人柱版
procedure TUpdateCheckForm.NightBuildCheckButtonClick(Sender: TObject);
begin
    if GikoUtil.MsgBox(Handle, '正式リリース版ではありませんがよろしいですか？', '更新確認',
        MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) = ID_YES then begin
        if CheckUpdate(true) then begin
            if GikoUtil.MsgBox(Handle, '更新があるためギコナビを再起動しますか？', '終了確認',
                MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) = ID_YES then begin
                FAllowshutdown := True;
                close;
            end;
        end;
    end;
end;

//! アップデート対象確認
function TUpdateCheckForm.CheckUpdate(nightbuild :Boolean): Boolean;
const
{$IFDEF DEBUG}
//	CHECK_URL = 'http://gikonavi.sourceforge.jp/updater/debug.txt';
	CHECK_URL = 'https://gikonavigoeson.osdn.jp/updater/debug.txt';
{$ELSE}
//	CHECK_URL = 'http://gikonavi.sourceforge.jp/updater/latest.txt';
	CHECK_URL = 'https://gikonavigoeson.osdn.jp/updater/latest.txt';
{$ENDIF}
var
    value, url : string;
   	ResStream: TMemoryStream;
    downResult, current, newest: TStringList;
    newgiko: Boolean;
begin
    Result := false;
    FExecPath := '';
    FExecArgs := '';
    FAllowshutdown := False;
    ResultMemo.Lines.Clear;
    Screen.Cursor := crHourGlass;
    UpdateButton.Enabled := False;
    NightBuildCheckButton.Enabled := False;

    try
        ResStream := TMemoryStream.Create;
        try
            TNewBoardDialog.InitHTTPClient(IdHTTP);
            IdHTTP.Request.Referer := '';
            IdHTTP.Request.AcceptEncoding := 'gzip';

            IdHTTP.Request.CacheControl := 'no-cache';
            IdHTTP.Request.CustomHeaders.Add('Pragma: no-cache');
            IdHTTP.ReadTimeout := 0;
            IdHTTP.HandleRedirects := true;
            downResult := TStringList.Create;
            newest     := TStringList.Create;
            current    := TStringList.Create;
            //IdAntiFreeze.Active := true;
            IndyMdl.StartAntiFreeze(250);   // for Indy10
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
                    value := GikoSys.GzipDecompress(ResStream,
                            IdHTTP.Response.ContentEncoding);
                    downResult.Text := value;
                    if (nightbuild) then  begin
                        ResultMemo.Lines.Add('最新のnight buildは、' + downResult.Values[ 'n_version' ]);
                        newest.Text := MojuUtils.CustomStringReplace(downResult.Values[ 'n_version' ],
                                        '.', #10, false);
                    end else begin
                        ResultMemo.Lines.Add('最新のギコナビは、' +  downResult.Values[ 'version' ]);
                        newest.Text := MojuUtils.CustomStringReplace(downResult.Values[ 'version' ],
                                        '.', #10, false);
                    end;
                    current.Text := MojuUtils.CustomStringReplace(GikoSys.Version,
                                        '.', #10, false);
                    if newest.Count >= 2 then begin
                        newgiko := false;
                        // night buildは、ビルド番号だけで判定する
                        if (nightbuild) then begin
                            url := downResult.Values[ 'n_url' ];
                            newgiko := StrToInt(current[3]) < StrToInt(newest[3]);
                        end else begin
                            url := downResult.Values[ 'url' ];
                            newgiko := ( StrToInt(current[1]) < StrToInt(newest[1]) ) or
                                        ( (StrToInt(current[1]) = StrToInt(newest[1]))) and
                                            ((StrToInt(current[2]) < StrToInt(newest[2])) );
                        end;
                        if (newgiko) then begin
                            if GikoUtil.MsgBox(Handle, '新しいギコナビがあります。ダウンロードしますか？', '更新確認',
                                MB_YESNO or MB_ICONWARNING or MB_DEFBUTTON2) = ID_YES then begin
                                ResultMemo.Lines.Add('新しいギコナビがあります。ダウンロードを開始します。' + url);
                                DonwloadUpdate(Trim(url));
                                Result := True;
                            end;
                        end else begin
                            ResultMemo.Lines.Add('今のギコナビが最新です。');
                        end;
                    end else begin
                        ResultMemo.Lines.Add('今のギコナビが最新です。');
                    end;
                except
                    on E: Exception do begin
                        ResultMemo.Lines.Add(E.Message);
                        {$IFDEF DEBUG}
                        Writeln(IdHTTP.ResponseText);
                        {$ENDIF}
                    end;
                end;
            finally
                current.free;
                newest.free;
                downResult.Free;
                //IdAntiFreeze.Active := false;
                IndyMdl.EndAntiFreeze;        // for Indy10
            end;
        finally
            ResStream.Clear;
            ResStream.Free;
        end;
    finally
        NightBuildCheckButton.Enabled := True;
        UpdateButton.Enabled := True;
        Screen.Cursor := crDefault;
    end;

end;

//! アップデートダウンロード
procedure TUpdateCheckForm.DonwloadUpdate(url: String);
var
    filename : String;
    fileStrem: TFileStream;
begin
    filename := GetDownloadFilePath(Copy(url, LastDelimiter('/', url) + 1,  Length(url)));
    fileStrem := TFileStream.Create(filename, fmCreate);
    try
        CancelBitBtn.Enabled := True;
        IdHTTP.Get(url, fileStrem);
        CancelBitBtn.Enabled := False;
        if (FCanceled) then begin
            raise Exception.Create('ダウンロードがキャンセルされました。');
        end;
        ResultMemo.Lines.Add(
            IdHttp.ResponseText + '(' + IntToStr(IdHttp.ResponseCode) + ')');
        FExecPath := filename;
        FExecArgs := '/SP- /silent /noicons "/dir=' + GikoSys.GetAppDir + '"';
        if CreateShortCut(
            execPath, execArgs, GetDesktopDir) then begin
            ResultMemo.Lines.Add('デスクトップに"ギコナビ更新"ショートカットを作成しました。');
            // ResultMemo.Lines.Add('ギコナビを終了して、"ギコナビ更新"ショートカットをダブルクリックしてください。');
        end else begin
            ResultMemo.Lines.Add('デスクトップにショートカットを作成できませんでした。');
        end;

    finally
        fileStrem.Free;
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

    ResultMemo.Lines.Clear;
    FExecPath := '';
    FExecArgs := '';
    FAllowshutdown := False;
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

end.
