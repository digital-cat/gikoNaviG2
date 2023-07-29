unit DefaultFileManager;

{!
\file       DefaultFileManager.pas
\brief      初期設定ファイル管理クラス
}
interface

uses
    Windows, Classes, Controls,	ComCtrls, SysUtils;

type

    TDefaultFileManager = class(TObject)
    private
        {!
        \brief      絶対パスで返す（インストールフォルダ下)
        \param      Path    インストールフォルダからの相対パス
        }
        class function GetFilePath(const Path: String) : String;
        {!
        \brief		FromFileが存在し，ToFileが存在しない場合にコピーする
        \param		FromFile    初期設定ファイル配置元
        \param      ToFile      配置先
        }
        class procedure CopyFile(const FromFile: String; const ToFile : String);
    public
        {!
        \brief		初期設定ファイルを指定位置にコピーする
        \param		FileName    初期設定ファイルの配置指定ファイル
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
            // すべてのセクションを読み込む
            ini.ReadSections(sections);
            for i := 0 to sections.Count - 1 do begin
                // FROM から TOにファイルをコピーする
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
    // 配置元，配置先のどちらかが未定の場合は何もしない
    if ( (FromFile <> '') and (ToFile <> '') ) then begin
        // ../ とかでインストールフォルダより上の領域にアクセスされると
        // 困るので置換してしまう
        fromPath := GetFilePath( FromFile );
        toPath := GetFilePath( ToFile );
        if ( FileExists(fromPath) ) then begin
            // 配置先にあったら何もしない
            if (not FileExists(toPath)) then begin
                // 配置先のフォルダを生成する
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
