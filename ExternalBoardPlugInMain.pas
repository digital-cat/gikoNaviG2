unit ExternalBoardPlugInMain;

interface

uses
	Windows, Classes, SysUtils, Menus,
	IdHTTP, IdComponent, IdGlobal, IdException,
  IdStack, IdExceptionCore, IndyModule,   // for Indy10
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,  // for https
	AbonUnit, IdAntiFreezeBase, Forms;

type

	// �_�E�����[�h�������������ǂ���
	TDownloadState = (dsWait, dsWork, dsComplete, dsDiffComplete, dsNotModify, dsAbort, dsError);

	// �w�肵�� URL �����̃v���O�C���Ŏ󂯕t���邩�ǂ���
	TAcceptType = (atNoAccept, atBBS, atBoard, atThread);

	// ���j���[�n���h��
	TMenuHandler	= procedure(
		inHandle : HMENU					// ���j���[�n���h��
	); stdcall;

	// *************************************************************************
	// �v���O�C����(������)���[�h���ꂽ
	// *************************************************************************
	TOnLoad = procedure (
		inInstance : DWORD				// �v���O�C���̃C���X�^���X
	); stdcall;

	// *************************************************************************
	// �v���O�C���̃o�[�W����
	// *************************************************************************
	TOnVersionInfo = procedure(
		var outAgent		: PChar;	// �o�[�W��������؊܂܂Ȃ������Ȗ���
		var outMajor		: DWORD;	// ���W���[�o�[�W����
		var outMinor		: DWORD;	// �}�C�i�[�o�[�W����
		var outRelease	: PChar;	// �����[�X�i�K��
		var outRevision	: DWORD		// ���r�W�����i���o�[
	); stdcall;

	// *************************************************************************
	// �w�肵�� URL �����̃v���O�C���Ŏ󂯕t���邩�ǂ���
	// *************************************************************************
	TOnAcceptURL = function(
		inURL : PChar						// ���f�����ł��� URL
	): TAcceptType; stdcall;	// URL �̎��

	// *************************************************************************
	// �w�肵��URL�����݂�URL�ɕϊ�����
	// *************************************************************************
	TOnExtractBoardURL = procedure(
		inURL : PChar;						// �ϊ�����URL;
        var outURL: PChar						// �ϊ����ꂽURL
	); stdcall;	// �ϊ����ꂽURL

	// *************************************************************************
	// ���j���[�n���h��
	// *************************************************************************
	TOnPlugInMenu = procedure(
		inInstance : DWORD		// ���j���[�n���h��
	); stdcall;

	// *************************************************************************
	// �X���ꗗ�� URL ����X���b�h�� URL �𓱂��o��
	// *************************************************************************
	TOnListURL2ThreadURL = function(
		inListURL		: PChar;	// �X���ꗗ�������� URL
		inFileName	: PChar		// �X���b�h�t�@�C����
	) : PChar; stdcall;			// �X���b�h�� URL


function CreateResultString(
	resultStr : string
) : PChar; stdcall;

procedure DisposeResultString(
	resultStr : PChar
); stdcall;

var
	socket : TIdHTTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;  // for https

implementation

uses ExternalBoardManager, ExternalThreadItem, GikoSystem, BoardGroup, Giko,
    ReplaceDataModule, AbonInfo;

// *************************************************************************
// �߂�l�� PChar �ł��� API �̃��������m�ۂ���
// *************************************************************************
function CreateResultString(
	resultStr : string
) : PChar; stdcall;
var
	tmp : PChar;
begin

	tmp := PChar( resultStr );
	GetMem( Result, Length( tmp ) + 1 );
	Move( tmp^, Result^, Length( tmp ) + 1 );

end;

// *************************************************************************
// �߂�l�� PChar �ł��� API �̃��������J������
// *************************************************************************
procedure DisposeResultString(
	resultStr : PChar
); stdcall;
begin

	FreeMem( resultStr );

end;

// *************************************************************************
// �v���O�����{�̂̃o�[�W�������擾����
// *************************************************************************
procedure VersionInfo(
	var outAgent		: PChar;	// �o�[�W��������؊܂܂Ȃ������Ȗ���
	var outMajor		: DWORD;	// ���W���[�o�[�W����
	var outMinor		: DWORD;	// �}�C�i�[�o�[�W����
	var outRelease	: PChar;	// �����[�X�i�K��
	var outRevision	: DWORD		// ���r�W�����i���o�[
); stdcall;
begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.VersionInfo');
	{$ENDIF}
	outAgent		:= CreateResultString( PChar( APP_NAME ) );
	outMajor		:= 1;
	outMinor		:= 0;
	outRelease	:= CreateResultString( PChar( BETA_VERSION_NAME_E ) );
	outRevision	:= BETA_VERSION;

end;

// *************************************************************************
// ���b�Z�[�W��\������
// *************************************************************************
procedure InternalPrint(
	inMessage	: PChar	// ���b�Z�[�W
); stdcall;
begin

	GikoForm.AddMessageList( inMessage, nil, gmiWhat );

end;

// *************************************************************************
// �f�o�b�O���b�Z�[�W��\������
// *************************************************************************
procedure InternalDebugPrint(
	inMessage	: PChar	// ���b�Z�[�W
); stdcall;
begin

	{$IFDEF DEBUG}
	Writeln( inMessage );
	{$ENDIF}

end;

// *************************************************************************
// �\�P�b�g������������(�G�p�֐�)
// *************************************************************************
procedure	InitializeSocket(
	inSocket : TIdHTTP;
  inSSL : TIdSSLIOHandlerSocketOpenSSL;    // for https
  writeMethod: Boolean = False
);
begin

	if inSocket <> nil then begin
    // for https
    if inSSL <> nil then begin
      inSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
      inSSL.SSLOptions.Method := sslvTLSv1_2;
      inSocket.IOHandler := inSSL;
    end;
    // for https

		// �C�x���g�̐ݒ�
		if Assigned( OnWork ) then
			inSocket.OnWork				:= OnWork;
		if Assigned( OnWorkBegin ) then
			inSocket.OnWorkBegin	:= OnWorkBegin;
		if Assigned( OnWorkEnd ) then
			inSocket.OnWorkEnd		:= OnWorkEnd;

    TIndyMdl.InitHTTP(inSocket, writeMethod);

	end;

end;

// *************************************************************************
// �w�肵�� URL ���_�E�����[�h���ĕԂ�
// *************************************************************************
function InternalDownload(
	inURL							: PChar;	// �_�E�����[�h���� URL
	var ioModified		: Double;	// �Ō�Ɏ擾��������
	var outResultData	: PChar;	// �_�E�����[�h���ꂽ������
	inRangeStart			: DWORD;	// �J�n�ʒu
	inRangeEnd				: DWORD		// �I���ʒu
) : Longint; stdcall;					// ���X�|���X�R�[�h
var
//	httpSocket				: TIdHTTP;
	resStream					: TMemoryStream;
	content						: string;
//const
//	LIVEDOOR_URL = 'http://jbbs.shitaraba.net/';
begin


	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.InternalDownload');
	{$ENDIF}
//	Result := -1;

	socket := TIdHTTP.Create( nil );
  ssl := TIdSSLIOHandlerSocketOpenSSL.Create( nil );  // for https
	try
		InitializeSocket( socket, ssl );                  // for https
		//socket.Request.ContentRangeStart	:= inRangeStart;
		//socket.Request.ContentRangeEnd		:= inRangeEnd;
    socket.Request.Ranges.Text := IndyMdl.MakeRangeHeader(inRangeStart, inRangeEnd);  // for Indy10
		if (ioModified <> 0) and (ioModified <> ZERO_DATE) then
			socket.Request.LastModified := ioModified - OffsetFromUTC;
		if inRangeStart = 0 then
			socket.Request.AcceptEncoding := 'gzip'
		else
			socket.Request.AcceptEncoding := '';
		socket.Request.Accept := 'text/html';

		resStream := TMemoryStream.Create;
		try
			try
				resStream.Clear;
				{$IFDEF DEBUG}
				Writeln('URL: ' + inURL);
				{$ENDIF}
                //AntiFreeze��DL���̂ݗL���ɂ��邱�ƂŁA�R�R�ł̃`�F�b�N�s�v
				socket.Get( inURL, resStream );
				{$IFDEF DEBUG}
				Writeln('�擾�ŗ�O�Ȃ�');
				{$ENDIF}
				content			:= GikoSys.GzipDecompress( resStream, socket.Response.ContentEncoding );
                // �u������
                if GikoSys.Setting.ReplaceDat then begin
                    content := ReplaceDM.Replace(content);
                end;

				ioModified	:= socket.Response.LastModified;

				Result := socket.ResponseCode;
				if (Length( content ) = 0) and (Result = 206) then
					Result := 304;
				//�������JBBS�̓w�b�_�ɃG���[��񂪍ڂ�炵���̂ŁA�����Ń`�F�b�N
				//if ( AnsiPos(LIVEDOOR_URL, inURL) > 0 ) and (Result = 200) then begin
				if GikoSys.IsShitarabaURL(inURL) and (Result = 200) then begin
					if( AnsiPos('STORAGE IN', socket.Response.RawHeaders.Text) > 0 ) then begin
						Result := 302;
					end;
				end;
				outResultData := CreateResultString( content );
			except
				on E: EIdSocketError do begin
					ioModified		:= ZERO_DATE;
					outResultData	:= nil;
					Result				:= socket.ResponseCode;
				end;
				on E: EIdConnectException do begin
					ioModified		:= ZERO_DATE;
					outResultData	:= nil;
					Result				:= socket.ResponseCode;
					//Item.ErrText	:= E.Message;
				end;
				//���f���ꂽ�Ƃ��R�R�ɓ���
				on E: EIdClosedSocket do begin
					ioModified		:= ZERO_DATE;
					outResultData	:= nil;
					Result				:= 408; //���ɈꕔDL�������Ă���ƃ��X�|���X�R�[�h��200�̂܂܂�
												//�Ȃ��Ă��܂��̂ŁA�����I�ɃG���[�R�[�h��Ԃ�
				end;
				on E: Exception do begin
					{$IFDEF DEBUG}
					Writeln('�擾�ŗ�O����');
					Writeln('E.Message: ' + E.Message);
					{$ENDIF}
					ioModified		:= ZERO_DATE;
					outResultData	:= nil;
					Result				:= socket.ResponseCode;
					//Item.ErrText	:= E.Message;
				end;
			end;
		finally
			resStream.Free;
		end;

	finally
		socket.Free;
		socket := nil;
    ssl.Free;       // for https
    ssl := nil;     // for https
	end;

end;

// *************************************************************************
// �w�肵�� URL �փf�[�^�𑗐M����
// *************************************************************************
function	InternalPost(
	inURL							: PChar;			// ���M���� URL
	inSource					: PChar;			// ���M������e
	inReferer			: PChar;				// Referer
	var outResultData	: PChar				// �Ԃ��Ă���������
) : Longint; stdcall;							// ���X�|���X�R�[�h
var
	httpSocket				: TIdHTTP;
  ssl               : TIdSSLIOHandlerSocketOpenSSL;   // for https
	content						: string;
	resStream					: TStringStream;
	sourceStream			: TStringStream;

begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.InternalPost');
	{$ENDIF}
	Result := -1;

	httpSocket := TIdHTTP.Create( nil );
  ssl := TIdSSLIOHandlerSocketOpenSSL.Create( nil );    // for https
	try
		InitializeSocket( httpSocket, ssl, True );          // for https
		httpSocket.Request.CustomHeaders.Add('Pragma: no-cache');
		httpSocket.Request.AcceptLanguage	:= 'ja';
		httpSocket.Request.Accept					:= 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*';
		httpSocket.Request.ContentType		:= 'application/x-www-form-urlencoded';
		httpSocket.Request.Referer			:= string(inReferer);
		resStream			:= TStringStream.Create( content );
		sourceStream	:= TStringStream.Create( string( inSource ) );
		try
			try
				{$IFDEF DEBUG}
				Writeln('URL: ' + inURL);
				Writeln('Source: ' + inSource);
				{$ENDIF}
				httpSocket.Post( string( inURL ), sourceStream, resStream );
				{$IFDEF DEBUG}
				Writeln('�擾�ŗ�O�Ȃ�');
				{$ENDIF}

				Result := httpSocket.ResponseCode;

				outResultData := CreateResultString( resStream.DataString );
			except
				on E: EIdSocketError do begin
					outResultData	:= nil;
				end;
				on E: EIdConnectException do begin
					outResultData	:= nil;
				end;
				on E: Exception do begin
					{$IFDEF DEBUG}
					Writeln('�擾�ŗ�O����');
					Writeln('E.Message: ' + E.Message);
					{$ENDIF}
					outResultData := CreateResultString( resStream.DataString );
					Result				:= httpSocket.ResponseCode;
				end;
			end;
		finally
			resStream.Free;
			sourceStream.Free;
		end;
	finally
		httpSocket.Free;
    ssl.Free;         // for https
	end;

end;

// *************************************************************************
// �Q�����˂�� dat �`�������[�J�����ځ`��ɒʂ�
// *************************************************************************

function InternalAbon(
	inDatText : PChar;			// ���O<>���[��<>���tID<>�{��<>[���s] �ō\�����ꂽ�e�L�X�g
	inDatPath	: PChar				// dat �t�@�C���̃t���p�X

) : PChar; stdcall;				// ���ځ`��ς݂� dat �`���e�L�X�g
var
	datList : TStringList;
		FileName : String;
    ThreadInfo: TAbonThread;
begin

    ThreadInfo := TAbonThread.Create;
	datList := TStringList.Create;
    try
        datList.Text := string( inDatText );
        FileName := string( inDatPath );
        GikoSys.FAbon.IndividualAbon( datList, ChangeFileExt(FileName,'.NG'));
        GikoSys.FAbon.Execute( datList, ThreadInfo );
        GikoSys.FSelectResFilter.Execute( datList, ThreadInfo );
    finally
        ThreadInfo.Free;
    end;

    Result := CreateResultString( datList.Text );
    datList.Free;
end;
// *************************************************************************
// �Q�����˂�� dat �`�������[�J�����ځ`��ɒʂ�
// �������A�P���X����
// *************************************************************************

function InternalAbonForOne(
	inDatText : PChar;		// ���O<>���[��<>���tID<>�{��<>[���s] �ō\�����ꂽ�e�L�X�g
	inDatPath	: PChar;		// dat �t�@�C���̃t���p�X
	inNo : Integer				// �v�����ꂽ���X�ԍ�
) : PChar; stdcall;			// ���ځ`��ς݂� dat �`���e�L�X�g
var
	datString : String;
		FileName : String;
    ThreadInfo: TAbonThread;
begin

    ThreadInfo := TAbonThread.Create;
    try
        datString := string( inDatText );
        FileName := string( inDatPath );
        GikoSys.FAbon.IndividualAbon( datString, ChangeFileExt(FileName,'.NG'), inNo);
        GikoSys.FAbon.Execute( datString , inNo, ThreadInfo );
        GikoSys.FSelectResFilter.Execute( datString , inNo, ThreadInfo );
    finally
        ThreadInfo.Free;
    end;

	Result := CreateResultString( datString );
end;

// *************************************************************************
// �Q�����˂�� dat �`�� 1 �s�� HTML �ɕϊ�����
// *************************************************************************
function InternalDat2HTML(
	inDatRes		: PChar; 		// ���O<>���[��<>���tID<>�{��<> �ō\�����ꂽ�e�L�X�g
	inResNo			: DWORD; 		// ���X�ԍ�
	inIsNew			: Boolean		// �V�����X�Ȃ� True
) : PChar; stdcall;				// ���`���ꂽ HTML
var
	board				: TBoard;
	threadItem	: TThreadItem;
begin

	// �_�~�[�̃N���X
	board				:= TBoard.Create( nil, 'about://dummy/' );
	threadItem	:= TThreadItem.Create( nil, board, 'about://dummy/test/read.cgi/dummy/' );
	try
		try
			board.Add( threadItem );

			Result := ThreadItemDat2HTML( DWORD( threadItem ), inDatRes, inResNo, inIsNew );
		except
			Result := nil;
		end;
	finally
		board.Free;
	end;

end;

// *************************************************************************
// �v���O�C�����j���[�ɍ��ڂ�ǉ�
// *************************************************************************
function AddPlugInMenu(
	inInstance	: DWORD;		// �v���O�C���̃C���X�^���X
	inCaption	: PChar 			// ���j���[�ɕ\�����镶����
) : HMENU; stdcall;				// ���j���[�n���h���A�ǉ��Ɏ��s�����ꍇ�� NULL
var
	newItem		: TMenuItem;
begin

	try
		newItem					:= TMenuItem.Create( nil );
		newItem.Caption	:= inCaption;
		newItem.Tag			:= inInstance;
		newItem.OnClick	:= GikoForm.OnPlugInMenuItem;
		GikoForm.PlugInMenu.Add( newItem );

		Result := newItem.Handle;
	except
   		Result := 0;
	end;

end;

// *************************************************************************
// �v���O�C�����j���[���獀�ڂ��폜
// *************************************************************************
procedure RemovePlugInMenu(
	inHandle	: HMENU 			// ���j���[�n���h��
); stdcall;
var
	i					: Integer;
begin
    // DLL�f�^�b�`���̓t�H�[���I�u�W�F�N�g�͑��݂��Ȃ���Ƀt�H�[�����Ō�n���͍ς�ł���
    if (g_AppTerminated = True) then
        Exit;

	for i := GikoForm.PlugInMenu.Count - 1 downto 0 do begin
		if GikoForm.PlugInMenu.Items[ i ].Handle = inHandle then begin
//            GikoForm.PlugInMenu.items[i].Free;
            GikoForm.PlugInMenu.items[i].Visible := False;  // Giko.pas �� TGikoForm.FormDestroy() �ŊJ�����邽�߂����ł͔�\���ɂ���̂�
			//GikoForm.PlugInMenu.Delete( i );
			Break;
		end;
	end;

end;

exports
	CreateResultString,
	DisposeResultString,
	VersionInfo,
	InternalPrint,
	InternalDebugPrint,
	InternalDownload,
	InternalPost,
	InternalAbon,
	InternalAbonForOne,
	InternalDat2HTML,
	AddPlugInMenu,
	RemovePlugInMenu;

end.
