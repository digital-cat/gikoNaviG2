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
        //! �X�L���t�@�C���p�X
        property FileName:String read FFileName write SetFileName;
        //! �w�b�_�̃t�@�C����
        function GetSkinHeaderFileName: string;
        //! �t�b�^�̃t�@�C����
        function GetSkinFooterFileName: string;
        //! �V�����X�̃t�@�C����
        function GetSkinNewResFileName: string;
        //! ��V�����X�̃t�@�C����
        function GetSkinResFileName: string;
        //! ������(�����܂œǂ�)�̃t�@�C����
        function GetSkinBookmarkFileName: string;
        //! ������(�V�����X)�̃t�@�C����
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

//! �X�L���t�@�C�����ݒ�
procedure TSkinFiles.SetFileName(AFileName: string);
begin
    // �f�B���N�g���̏ꍇ�Ō��\�ŏI��炷
    if DirectoryExists(AFileName) then begin
        // \ �ŏI���悤�ɂ���
        FFileName := IncludeTrailingPathDelimiter(AFileName);
    end else begin
        FFileName := AFileName;
    end;
end;
//! Skin:�w�b�_�̃t�@�C����
function TSkinFiles.GetSkinHeaderFileName: string;
begin
	Result := FFileName + SKIN_HEADER_FILE_NAME;
end;

//! Skin:�t�b�^�̃t�@�C����
function TSkinFiles.GetSkinFooterFileName: string;
begin
	Result := FFileName + SKIN_FOOTER_FILE_NAME;
end;

//! Skin:�V�����X�̃t�@�C����
function TSkinFiles.GetSkinNewResFileName: string;
begin
	Result := FFileName + SKIN_NEWRES_FILE_NAME;
end;

//! Skin:��V�����X�̃t�@�C����
function TSkinFiles.GetSkinResFileName: string;
begin
	Result := FFileName + SKIN_RES_FILE_NAME;
end;

//! Skin:������(�����܂œǂ�)�̃t�@�C����
function TSkinFiles.GetSkinBookmarkFileName: string;
begin
	Result := FFileName + SKIN_BOOKMARK_FILE_NAME;
end;

//! Skin:������(�V�����X)�̃t�@�C����
function TSkinFiles.GetSkinNewmarkFileName: string;
begin
	Result := FFileName + SKIN_NEWMARK_FILE_NAME;
end;
end.
