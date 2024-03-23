unit NewBoardURL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, StdCtrls,
  IndyModule,     // for Indy10
  BoardGroup, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL;

type
  TNewBoardURLForm = class(TForm)
    CategoryComboBox: TComboBox;
    CategoryLabel: TLabel;
    IdHTTP: TIdHTTP;
    SearchButton: TButton;
    ResultMemo: TMemo;
    CloseButton: TButton;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    procedure FormCreate(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure IdHTTPRedirect(Sender: TObject; var dest: string;
      var NumRedirect: Integer; var Handled: Boolean; var VMethod: string);
  private
    { Private 宣言 }
    function GetRedirectURL(const html: string): string;
    procedure GetBoardURLs(urls : TStringList);
    procedure ReplaceURLs(oldurls, newurls: TStringList);
  public
    { Public 宣言 }
  end;

var
  NewBoardURLForm: TNewBoardURLForm;

implementation

uses
    GikoSystem, NewBoard, Giko, IniFiles, MojuUtils, GikoDataModule;
{$R *.dfm}
//! コンストラクタ
procedure TNewBoardURLForm.FormCreate(Sender: TObject);
var
    i : Integer;
    ini : TMemIniFile;
    sec : TStringList;
begin
    sec := TStringList.Create;
    try
        ini := TMemIniFile.Create(GikoSys.GetBoardFileName);
        try
            ini.ReadSections(sec);

            CategoryComboBox.Clear;
            CategoryComboBox.Items.BeginUpdate;
            for i := 0 to sec.Count - 1 do begin
                CategoryComboBox.Items.Add(sec[i]);
            end;
            CategoryComboBox.Items.EndUpdate;
            CategoryComboBox.ItemIndex := 0;

            ResultMemo.Lines.Clear;
        finally
            if ini <> nil then begin
                ini.Free;
            end;
        end;
    finally
        if sec <> nil then begin
            sec.Free;
        end;
    end;
end;
//! 検索ボタンイベント
procedure TNewBoardURLForm.SearchButtonClick(Sender: TObject);
var
    i : Integer;
    value : string;
   	ResStream: TMemoryStream;
    URLs : TStringList;
    oldURLs : TStringList;
    newURLs : TStringList;
    oldURL, newURL : string;
    TabURLs : TStringList;
    tmpURL: String;
begin
    ResultMemo.Lines.Clear;
    URLs := TStringList.Create;
    Screen.Cursor := crHourGlass;
    SearchButton.Enabled := False;
    try
        GetBoardURLs( URLs );
        if URLs.Count > 0 then begin
            ResStream := TMemoryStream.Create;
            oldURLs := TStringList.Create;
            newURLs := TStringList.Create;

            try
                TIndyMdl.InitHTTP(IdHTTP);
                IdHTTP.Request.Referer := '';
                IdHTTP.Request.AcceptEncoding := 'gzip';

                IdHTTP.Request.CacheControl := 'no-cache';
                IdHTTP.Request.CustomHeaders.Add('Pragma: no-cache');
                IdHTTP.HandleRedirects := false;
                //IdAntiFreeze.Active := true;
                IndyMdl.StartAntiFreeze(250);     // for Indy10
                for i := 0 to URLs.Count - 1 do begin
                    try
                        ResStream.Clear;
                        // for 5ch
                        //IdHTTP.Get(URLs[i], ResStream);
                        tmpURL := URLs[i];
                        GikoSys.Regulate2chURL(tmpURL);
                        tmpURL := GikoSys.GetActualURL(tmpURL);
                        IdHTTP.Get(tmpURL, ResStream);
                        // for 5ch
                        value := GikoSys.GzipDecompress(ResStream,
                                IdHTTP.Response.ContentEncoding);
                        newURL := GetRedirectURL(value);
                        if (newURL = '') then begin
                            newURL := IdHTTP.Response.Location;
                        end;
                        if (newURL <> '') then begin
                            // リダイレクトすれば必ず移転とは限らない
                            // テレビ番組板などの対策最後の'/'までをURLとする
                            if (Length(newURL) <> LastDelimiter('/', newURL)) then begin
                                newURL := Copy(newURL, 1, LastDelimiter('/', newURL));
                            end;
                            oldURL := URLs[i];
                            if (oldURL <> newURL) then begin
                                ResultMemo.Lines.Add('URL:' + oldURL + ' -> ' + newURL);
                                oldURLs.Add( oldURL );
                                newURLs.Add( newURL );
                            end;
                        end;
                    except
                        on E: Exception do begin
                            {$IFDEF DEBUG}
                            Writeln(IdHTTP.ResponseText);
                            {$ENDIF}
                        end;
                    end;
                end;
                //IdAntiFreeze.Active := false;
                IndyMdl.EndAntiFreeze;        // for Indy10
                if (newURLs.Count > 0) and (oldURLs.Count > 0) then begin
                    ReplaceURLs(oldURLs, newURLs);
                    GikoForm.FavoritesURLReplace(oldURLs, newURLs);
                    GikoForm.RoundListURLReplace(oldURLs, newURLs);
                    GikoForm.TabFileURLReplace(oldURLs, newURLs);
                    ResultMemo.Lines.Add('板移転先検索が完了しました');

                    TabURLs := TStringList.Create;
                    try
                        GikoDM.GetTabURLs(TabURLs);
                        GikoForm.ReloadBBS;
                        GikoDM.OpenURLs(TabURLs);
                    finally
                        TabURLs.Free;
                    end;

                end else begin
                    ResultMemo.Lines.Add('移転している板は ありませんでした');
                end;
            finally
                ResStream.Clear;
                ResStream.Free;
                newURLs.Free;
                oldURLs.Free;
            end;
        end;
    finally
        URLs.Free;
        SearchButton.Enabled := True;
        Screen.Cursor := crDefault;
    end;
end;
function TNewBoardURLForm.GetRedirectURL(const html: string): string;
const
    HEADS = '<head>';
    HEADE = '</head>';
    SCRIPT = 'window.location.href="';
begin
    Result := Copy(html, 1,
        AnsiPos(HEADE, AnsiLowerCase(html)));
    Result := Copy(Result,
        AnsiPos(HEADS, AnsiLowerCase(Result)),
        Length(Result));
    if AnsiPos(SCRIPT, Result) > 0 then begin
        Result := Copy(Result, AnsiPos(SCRIPT, Result) + Length(SCRIPT),
            Length(Result));
        Result := Copy(Result, 1, AnsiPos('"', Result) - 1);
    end else begin
        Result := '';
    end;

end;

procedure TNewBoardURLForm.GetBoardURLs(urls : TStringList);
var
    ini : TMemIniFile;
    sec : string;
    keys : TStringList;
    i : Integer;
begin
    urls.Clear;
    urls.BeginUpdate;
    if CategoryComboBox.ItemIndex <> -1 then begin
        sec := CategoryComboBox.Items[CategoryComboBox.itemIndex];
        keys := TStringList.Create;
        try
            ini := TMemIniFile.Create(GikoSys.GetBoardFileName);
            try
                ini.ReadSection(sec, keys);
                for i := 0 to keys.Count - 1 do begin
                    urls.Add(ini.ReadString(sec, keys[i], ''));
                end;
            finally
                ini.Free;
            end;
        finally
            keys.Free;
        end;
    end;
end;
procedure TNewBoardURLForm.ReplaceURLs(oldurls, newurls: TStringList);
var
    txt : TStringList;
    i : Integer;
begin
    if oldurls.Count > 0 then begin
        txt := TStringList.Create;
        txt.LoadFromFile( GikoSys.GetBoardFileName );
        try
            for i := 0 to oldurls.Count - 1 do begin
                MojuUtils.CustomStringReplace(txt, oldurls[i], newurls[i]);
            end;
            txt.SaveToFile( GikoSys.GetBoardFileName );
        finally
            txt.Free;
        end;
    end;
end;

procedure TNewBoardURLForm.IdHTTPRedirect(Sender: TObject; var dest: string;
  var NumRedirect: Integer; var Handled: Boolean; var VMethod: string);   // for Indy10
begin
    {$IFDEF DEBUG}
    ShowMessage(dest);
    {$ENDIF}
end;

end.
