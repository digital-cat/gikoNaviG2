library CheckUpdate;

{
	CheckUpdate
	�M�R�i�r�A�v���P�[�V�������X�V����Ă��邩�`�F�b�N
}

uses
	Windows,
	SysUtils,
	Classes,
	//Dialogs,
	//Math,
	//UrlMon,
	//IdURI,
	PlugInMain in 'PlugInMain.pas',
	FilePath in 'FilePath.pas';

{$R *.res}

const
	PLUGIN_NAME				= 'CheckUpdate';
	MAJOR_VERSION			= 1;
	MINOR_VERSION			= 0;
	RELEASE_VERSION		= 'developer';
	REVISION_VERSION	= 1;


// =========================================================================
// PlugIn
// =========================================================================

// *************************************************************************
// �v���O�C���̃o�[�W������v�����ꂽ
// *************************************************************************
procedure OnVersionInfo(
	var outAgent		: PChar;	// �o�[�W��������؊܂܂Ȃ������Ȗ���
	var outMajor		: DWORD;	// ���W���[�o�[�W����
	var outMinor		: DWORD;	// �}�C�i�[�o�[�W����
	var outRelease	: PChar;	// �����[�X�i�K��
	var outRevision	: DWORD		// ���r�W�����i���o�[
); stdcall;
begin

	outAgent		:= CreateResultString( PChar( PLUGIN_NAME ) );
	outMajor		:= MAJOR_VERSION;
	outMinor		:= MINOR_VERSION;
	outRelease	:= CreateResultString( PChar( RELEASE_VERSION ) );
	outRevision	:= REVISION_VERSION;

end;

procedure DiscoveredNewVersion( const url : string );
const
	MSG = '�M�R�i�r�̐V�����o�[�W�����𔭌����܂����B';//'�������_�E�����[�h���܂����H';
begin

{
	if MessageDlg( MSG, mtConfirmation, [mbYes, mbNo], 0) = Word( mbYes ) then
		HlinkNavigateString( nil, PWideChar( WideString( url ) ) );
}
	InternalPrint( PChar( MSG ) );

end;

procedure DoCheckUpdate;
var
	responseCode	: Longint;
	modified			: Double;
	tmp						: PChar;
	downResult		: TStringList;
	newest				: TStringList;

	agent					: PChar;
	major					: DWORD;
	minor					: DWORD;
	release				: PChar;
	revision			: DWORD;
const
	CHECK_URL = 'http://gikonavi.sourceforge.jp/updater/release.txt';
begin

	modified := 0;
	responseCode := InternalDownload( PChar( CHECK_URL ), modified, tmp, 0 );
	try
		if (responseCode = 200) or (responseCode = 206) then begin
			downResult := TStringList.Create;
			newest := TStringList.Create;
			try
				downResult.Text := string( tmp );
				newest.Text := downResult.Values[ 'version' ];
				newest.Text := StringReplace( newest.Text, '.', #10, [rfReplaceAll] );
				VersionInfo( agent, major, minor, release, revision );
				try
					if newest.Count >= 2 then
						if revision < StrToInt( newest[ 1 ] ) then
							DiscoveredNewVersion( downResult.Values[ 'url' ] );
				finally
					DisposeResultString( agent );
					DisposeResultString( release );
				end;
			finally
				newest.Free;
				downResult.Free;
			end;
		end;
	finally
		DisposeResultString( tmp );
	end;

end;

// =========================================================================
// �G���g���|�C���g
// =========================================================================
procedure DLLEntry(
	ul_reason_for_call : DWORD
);
var
	module : HMODULE;
begin

	case ul_reason_for_call of
		DLL_PROCESS_ATTACH:
		begin
			Randomize;

			module := GetModuleHandle( nil );

			LoadInternalAPI( module );
			LoadInternalFilePathAPI( module );

			DoCheckUpdate;
		end;
		DLL_PROCESS_DETACH:
			;
		DLL_THREAD_ATTACH:
			;
		DLL_THREAD_DETACH:
			;
	end;

end;

exports
	OnVersionInfo;

begin

	DllProc := @DLLEntry;
	DLLEntry( DLL_PROCESS_ATTACH );

end.
