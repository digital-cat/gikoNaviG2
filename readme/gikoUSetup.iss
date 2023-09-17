; 更新用インストーラです。
; 通常との違い
; ・アンインストール情報を作成/更新しません
; ・ショートカットを作成しません
; ・デスクトップにある更新ショートカットを削除します。
[Setup]
AppName=ギコナビ
AppVerName=ギコナビ
AppId=gikoNavi
AppMutex=gikoNaviInstance
AppPublisherURL=https://github.com/digital-cat/gikoNaviG2
AppendDefaultDirName = no
;DefaultDirName={pf}\gikonavi
;DefaultDirName={code:GetBase}\gikonavi
DefaultDirName=C:\gikonavi
VersionInfoDescription=ギコナビ(避難所版II)セットアッププログラム
DefaultGroupName=ギコナビ
; 自分の環境に合わせてください
SourceDir=D:\giko\Setup\Release73-867
OutputDir=D:\giko\Setup\Output
SetupIconFile=D:\giko\Setup\GikoSetup.ico
; ギコナビのバージョンにあわせてください
VersionInfoVersion=1.73.0.867
OutputBaseFilename=gikoNavi_b73_up_setup
CreateUninstallRegKey=no

[Tasks]
Name: "startmenuicon"; Description: "スタートメニューに登録する"; GroupDescription: "ショートカット"; Flags:
Name: "desktopicon"; Description: "デスクトップにショートカットを作成"; GroupDescription: "ショートカット"; Flags:

[Dirs]
Name: "{app}\Log"
Name: "{app}\Sound"
Name: "{app}\config\Board"
Name: "{app}\config\BoardPlugin"
Name: "{app}\config\NGwords"


[Files]
Source: * ; Destdir: {app} ;Excludes: "gikoNavi.*,*.dll" ; Flags: ignoreversion ;
Source: "gikoNavi.bmp" ; Destdir: {app} ;Permissions: everyone-full; Flags: onlyifdoesntexist
Source: "gikoNavi.avi" ; Destdir: {app} ;Permissions: everyone-full; Flags: onlyifdoesntexist
Source: "gikoNavi.exe" ; Destdir: {app} ;Permissions: everyone-full; Flags: ignoreversion
Source: "*.dll" ; Destdir: {app} ;Permissions: everyone-full; Flags: ignoreversion
Source: "Sound\*" ; Destdir: {app}\Sound ;Flags: createallsubdirs recursesubdirs ;
Source: "config\*" ; Destdir: {app}\config ;Excludes: "*.dll";Flags: createallsubdirs recursesubdirs ;
Source: "config\BoardPlugin\*.dll" ; Destdir: {app}\config\BoardPlugin ;Flags: ignoreversion;

[Icons]
;Name: "{group}\Readme"; Filename: "{app}\readme.txt"; Tasks: startmenuicon
Name: "{group}\Readme_Goeson"; Filename: "{app}\readme_goeson.txt"; Tasks: startmenuicon
Name: "{group}\Readme_G2"; Filename: "{app}\readme_g2.txt"; Tasks: startmenuicon
;Name: "{group}\ギコナビ"; Filename: "{app}\gikoNavi.exe"; Tasks: startmenuicon
;Name: "{commondesktop}\ギコナビ"; Filename: "{app}\gikoNavi.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\readme_g2.txt"; Description: "READMEを表示する"; Flags: postinstall shellexec skipifsilent unchecked
Filename: "{app}\gikoNavi.exe"; Description: "アプリケーションを起動する"; Flags: postinstall shellexec

[InstallDelete]
Type: files; Name: "{userdesktop}\ギコナビ更新.lnk"

[UninstallDelete]
Type: files; Name: "{app}\sent.ini"
Type: files; Name: "{app}\url.ini"
Type: files; Name: "{app}\Samba.ini"
Type: files; Name: "{app}\gikoNavi.ini"

[Languages]
Name: japanese; MessagesFile: compiler:Languages\Japanese.isl

[Code]
function InitializeSetup(): Boolean;
var
  timeout : Integer;
begin
  Result := true;
  // タイムアウト時間1分
  timeout := 60 * 1000;
  // ギコナビの起動時ミューテックスをチェック
  while CheckForMutexes('gikoNaviInstance') do begin
    // 起動中なのでスリープ
    // まずは、タイムアウトチェック
    if (timeout < 0) then begin
      // タイムアウト
      Result := False;
      break;
    end;
    timeout := timeout - 500;
    // スリープ
    Sleep(500);
  end;
  // タイムアウト時は、手動でギコナビシャットダウンを要求
  if not Result Then begin
    if MsgBox('ギコナビが起動しているか。完全に終了していません。ギコナビの終了を確認してください。'
              + #10#13 + '更新を続行するには,「はい」ボタンを押してください。',
               mbConfirmation, MB_YESNO) = IDYES then begin
      Result := not CheckForMutexes('gikoNaviInstance');
      if not Result Then begin
        MsgBox('ギコナビが起動しています。ギコナビ更新をキャンセルします。'
          + #10#13 + 'ギコナビ更新は、デスクトップの「ギコナビ更新」ショートカットから再起動できます。'
        , mbError, MB_OK);
      end;
    end else begin
      MsgBox('ギコナビ更新をキャンセルします。'
          + #10#13 + 'ギコナビ更新は、デスクトップの「ギコナビ更新」ショートカットから再起動できます。'
        , mbError, MB_OK);
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  path :String;
  srcpath: String;
begin
  case CurStep of
    ssInstall:
      begin
        if (RegKeyExists(HKEY_LOCAL_MACHINE,
            'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\gikoNavi')) then
          begin
            if MsgBox('以前のバージョンのアンインストール情報を削除してよろしいでしょうか？'
              + #10#13 + '(バタ56以前からのアップデートの場合「はい」推奨)',
               mbConfirmation, MB_YESNO) = IDYES then
              begin
                  if not RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE,
                    'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\gikoNavi') then
                    begin
                      MsgBox('アンインストール情報の削除に失敗しました。', mbError, MB_OK);
                    end;
              end;
          end;
      end;
      ssPostInstall:
      begin
        path := ExpandConstant('{app}') + '\gikoNavi.ini';
        srcpath := ExpandConstant('{srcexe}');
        if (FileExists(path)) then
        begin
          SetIniString('Update', 'Remove0', srcpath, path);
        end;
      end;
  end;

end;
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  path :String;
begin
  case CurUninstallStep of
    usUninstall:
      begin
        path := ExpandConstant('{app}') + '\Log';
        if MsgBox(path + 'フォルダ以下を完全に消去してよろしいでしょうか？', mbConfirmation, MB_YESNO) = IDYES then
        begin
          DelTree(path, True, True, True);
        end;

        path := ExpandConstant('{app}') + '\config';
        if MsgBox(path + 'フォルダ以下を完全に消去してよろしいでしょうか？', mbConfirmation, MB_YESNO) = IDYES then
        begin
          DelTree(path, True, True, True);
        end;

      end;
    usPostUninstall:
      begin
        path := ExpandConstant('{app}');

        MsgBox(path + 'フォルダ以下に、削除しきれないファイルが残っている場合があります。' #10#13 '確認のうえ手動で削除してください。',
          mbInformation, MB_OK);
      end;
  end;
end;
function GetBase(Param: String) : String;
begin
  if (GetWindowsVersion shr 24) < 6 then
    Result := ExpandConstant('{pf}')
  else
    Result := ExpandConstant('{sd}');
end;
