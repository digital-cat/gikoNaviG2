unit SkinFiles;

interface

uses
	SysUtils, Classes, ComCtrls;

type
    TSkinFiles = class(TObject)
    private
        FFileName: String;
        procedure SetFileName(AFileName: string);
    public
        //! スキンファイルパス
        property FileName:String read FFileName write SetFileName;
        //! ヘッダのファイル名
        function GetSkinHeaderFileName: string;
        //! フッタのファイル名
        function GetSkinFooterFileName: string;
        //! 新着レスのファイル名
        function GetSkinNewResFileName: string;
        //! 非新着レスのファイル名
        function GetSkinResFileName: string;
        //! しおり(ここまで読んだ)のファイル名
        function GetSkinBookmarkFileName: string;
        //! しおり(新着レス)のファイル名
        function GetSkinNewmarkFileName: string;
    end;

implementation

const
	SKIN_HEADER_FILE_NAME					= 'Header.html';
	SKIN_FOOTER_FILE_NAME					= 'Footer.html';
	SKIN_NEWRES_FILE_NAME	 				= 'NewRes.html';
	SKIN_RES_FILE_NAME						= 'Res.html';
	SKIN_BOOKMARK_FILE_NAME				= 'Bookmark.html';
	SKIN_NEWMARK_FILE_NAME				= 'Newmark.html';

//! スキンファイル名設定
procedure TSkinFiles.SetFileName(AFileName: string);
begin
    // ディレクトリの場合最後に\で終わらす
    if DirectoryExists(AFileName) then begin
        // \ で終わるようにする
        FFileName := IncludeTrailingPathDelimiter(AFileName);
    end else begin
        FFileName := AFileName;
    end;
end;
//! Skin:ヘッダのファイル名
function TSkinFiles.GetSkinHeaderFileName: string;
begin
	Result := FFileName + SKIN_HEADER_FILE_NAME;
end;

//! Skin:フッタのファイル名
function TSkinFiles.GetSkinFooterFileName: string;
begin
	Result := FFileName + SKIN_FOOTER_FILE_NAME;
end;

//! Skin:新着レスのファイル名
function TSkinFiles.GetSkinNewResFileName: string;
begin
	Result := FFileName + SKIN_NEWRES_FILE_NAME;
end;

//! Skin:非新着レスのファイル名
function TSkinFiles.GetSkinResFileName: string;
begin
	Result := FFileName + SKIN_RES_FILE_NAME;
end;

//! Skin:しおり(ここまで読んだ)のファイル名
function TSkinFiles.GetSkinBookmarkFileName: string;
begin
	Result := FFileName + SKIN_BOOKMARK_FILE_NAME;
end;

//! Skin:しおり(新着レス)のファイル名
function TSkinFiles.GetSkinNewmarkFileName: string;
begin
	Result := FFileName + SKIN_NEWMARK_FILE_NAME;
end;
end.
