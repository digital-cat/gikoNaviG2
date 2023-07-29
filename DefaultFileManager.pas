unit DefaultFileManager;

{!
\file       DefaultFileManager.pas
\brief      �����ݒ�t�@�C���Ǘ��N���X
}
interface

uses
    Windows, Classes, Controls,	ComCtrls, SysUtils;

type

    TDefaultFileManager = class(TObject)
    private
        {!
        \brief      ��΃p�X�ŕԂ��i�C���X�g�[���t�H���_��)
        \param      Path    �C���X�g�[���t�H���_����̑��΃p�X
        }
        class function GetFilePath(const Path: String) : String;
        {!
        \brief		FromFile�����݂��CToFile�����݂��Ȃ��ꍇ�ɃR�s�[����
        \param		FromFile    �����ݒ�t�@�C���z�u��
        \param      ToFile      �z�u��
        }
        class procedure CopyFile(const FromFile: String; const ToFile : String);
    public
        {!
        \brief		�����ݒ�t�@�C�����w��ʒu�ɃR�s�[����
        \param		FileName    �����ݒ�t�@�C���̔z�u�w��t�@�C��
        }
        class procedure CopyDefaultFiles(const FileName: String);
    end;

implementation

uses
    IniFiles,ShellAPI, GikoSystem, MojuUtils;

class procedure TDefaultFileManager.CopyDefaultFiles(const FileName: String);
const
    FROM_KEY    = 'FROM';
    TO_KEY      = 'TO';
var
    ini : TMemIniFile;
    sections : TStringList;
    i: Integer;
begin
    if ( FileExists(FileName) ) then begin
        ini := TMemIniFile.Create( FileName );
        sections := TStringList.Create;
        try
            // ���ׂẴZ�N�V������ǂݍ���
            ini.ReadSections(sections);
            for i := 0 to sections.Count - 1 do begin
                // FROM ���� TO�Ƀt�@�C�����R�s�[����
                CopyFile( ini.ReadString(sections[i], FROM_KEY, ''),
                             ini.ReadString(sections[i], TO_KEY, '') );
            end;
        finally
            sections.Clear;
            sections.Free;
            ini.Free;
        end;
    end;

end;
class procedure TDefaultFileManager.CopyFile(
    const FromFile: String; const ToFile : String);
var
    fromPath, toPath : String;
begin
    // �z�u���C�z�u��̂ǂ��炩������̏ꍇ�͉������Ȃ�
    if ( (FromFile <> '') and (ToFile <> '') ) then begin
        // ../ �Ƃ��ŃC���X�g�[���t�H���_����̗̈�ɃA�N�Z�X������
        // ����̂Œu�����Ă��܂�
        fromPath := GetFilePath( FromFile );
        toPath := GetFilePath( ToFile );
        if ( FileExists(fromPath) ) then begin
            // �z�u��ɂ������牽�����Ȃ�
            if (not FileExists(toPath)) then begin
                // �z�u��̃t�H���_�𐶐�����
                GikoSys.ForceDirectoriesEx(
                    ExtractFilePath(toPath));
                Windows.CopyFile( PChar(fromPath), PChar(toPath), False);
            end;
        end;
    end;

end;
class function TDefaultFileManager.GetFilePath(const Path: String): String;
begin
    Result := GikoSys.GetAppDir +
        CustomStringReplace(
            CustomStringReplace(Path, '/', '\' ), '..\', '');
end;
end.
