; �X�V�p�C���X�g�[���ł��B
; �ʏ�Ƃ̈Ⴂ
; �E�A���C���X�g�[�������쐬/�X�V���܂���
; �E�V���[�g�J�b�g���쐬���܂���
; �E�f�X�N�g�b�v�ɂ���X�V�V���[�g�J�b�g���폜���܂��B
[Setup]
AppName=�M�R�i�r
AppVerName=�M�R�i�r
AppId=gikoNavi
AppMutex=gikoNaviInstance
AppPublisherURL=https://github.com/digital-cat/gikoNaviG2
AppendDefaultDirName = no
;DefaultDirName={pf}\gikonavi
;DefaultDirName={code:GetBase}\gikonavi
DefaultDirName=C:\gikonavi
VersionInfoDescription=�M�R�i�r(����II)�Z�b�g�A�b�v�v���O����
DefaultGroupName=�M�R�i�r
; �����̊��ɍ��킹�Ă�������
SourceDir=D:\giko\Setup\Release73-867
OutputDir=D:\giko\Setup\Output
SetupIconFile=D:\giko\Setup\GikoSetup.ico
; �M�R�i�r�̃o�[�W�����ɂ��킹�Ă�������
VersionInfoVersion=1.73.0.867
OutputBaseFilename=gikoNavi_b73_up_setup
CreateUninstallRegKey=no

[Tasks]
Name: "startmenuicon"; Description: "�X�^�[�g���j���[�ɓo�^����"; GroupDescription: "�V���[�g�J�b�g"; Flags:
Name: "desktopicon"; Description: "�f�X�N�g�b�v�ɃV���[�g�J�b�g���쐬"; GroupDescription: "�V���[�g�J�b�g"; Flags:

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
;Name: "{group}\�M�R�i�r"; Filename: "{app}\gikoNavi.exe"; Tasks: startmenuicon
;Name: "{commondesktop}\�M�R�i�r"; Filename: "{app}\gikoNavi.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\readme_g2.txt"; Description: "README��\������"; Flags: postinstall shellexec skipifsilent unchecked
Filename: "{app}\gikoNavi.exe"; Description: "�A�v���P�[�V�������N������"; Flags: postinstall shellexec

[InstallDelete]
Type: files; Name: "{userdesktop}\�M�R�i�r�X�V.lnk"

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
  // �^�C���A�E�g����1��
  timeout := 60 * 1000;
  // �M�R�i�r�̋N�����~���[�e�b�N�X���`�F�b�N
  while CheckForMutexes('gikoNaviInstance') do begin
    // �N�����Ȃ̂ŃX���[�v
    // �܂��́A�^�C���A�E�g�`�F�b�N
    if (timeout < 0) then begin
      // �^�C���A�E�g
      Result := False;
      break;
    end;
    timeout := timeout - 500;
    // �X���[�v
    Sleep(500);
  end;
  // �^�C���A�E�g���́A�蓮�ŃM�R�i�r�V���b�g�_�E����v��
  if not Result Then begin
    if MsgBox('�M�R�i�r���N�����Ă��邩�B���S�ɏI�����Ă��܂���B�M�R�i�r�̏I�����m�F���Ă��������B'
              + #10#13 + '�X�V�𑱍s����ɂ�,�u�͂��v�{�^���������Ă��������B',
               mbConfirmation, MB_YESNO) = IDYES then begin
      Result := not CheckForMutexes('gikoNaviInstance');
      if not Result Then begin
        MsgBox('�M�R�i�r���N�����Ă��܂��B�M�R�i�r�X�V���L�����Z�����܂��B'
          + #10#13 + '�M�R�i�r�X�V�́A�f�X�N�g�b�v�́u�M�R�i�r�X�V�v�V���[�g�J�b�g����ċN���ł��܂��B'
        , mbError, MB_OK);
      end;
    end else begin
      MsgBox('�M�R�i�r�X�V���L�����Z�����܂��B'
          + #10#13 + '�M�R�i�r�X�V�́A�f�X�N�g�b�v�́u�M�R�i�r�X�V�v�V���[�g�J�b�g����ċN���ł��܂��B'
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
            if MsgBox('�ȑO�̃o�[�W�����̃A���C���X�g�[�������폜���Ă�낵���ł��傤���H'
              + #10#13 + '(�o�^56�ȑO����̃A�b�v�f�[�g�̏ꍇ�u�͂��v����)',
               mbConfirmation, MB_YESNO) = IDYES then
              begin
                  if not RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE,
                    'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\gikoNavi') then
                    begin
                      MsgBox('�A���C���X�g�[�����̍폜�Ɏ��s���܂����B', mbError, MB_OK);
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
        if MsgBox(path + '�t�H���_�ȉ������S�ɏ������Ă�낵���ł��傤���H', mbConfirmation, MB_YESNO) = IDYES then
        begin
          DelTree(path, True, True, True);
        end;

        path := ExpandConstant('{app}') + '\config';
        if MsgBox(path + '�t�H���_�ȉ������S�ɏ������Ă�낵���ł��傤���H', mbConfirmation, MB_YESNO) = IDYES then
        begin
          DelTree(path, True, True, True);
        end;

      end;
    usPostUninstall:
      begin
        path := ExpandConstant('{app}');

        MsgBox(path + '�t�H���_�ȉ��ɁA�폜������Ȃ��t�@�C�����c���Ă���ꍇ������܂��B' #10#13 '�m�F�̂����蓮�ō폜���Ă��������B',
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
