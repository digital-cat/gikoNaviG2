library CheckUpdate;

{
	CheckUpdate
	ギコナビアプリケーションが更新されているかチェック
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
// プラグインのバージョンを要求された
// *************************************************************************
procedure OnVersionInfo(
	var outAgent		: PChar;	// バージョンを一切含まない純粋な名称
	var outMajor		: DWORD;	// メジャーバージョン
	var outMinor		: DWORD;	// マイナーバージョン
	var outRelease	: PChar;	// リリース段階名
	var outRevision	: DWORD		// リビジョンナンバー
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
	MSG = 'ギコナビの新しいバージョンを発見しました。';//'今すぐダウンロードしますか？';
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
// エントリポイント
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
