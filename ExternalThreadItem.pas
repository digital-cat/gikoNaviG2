unit ExternalThreadItem;

interface

uses
	Windows, Classes, SysUtils,
	IdComponent,
	ExternalBoardPlugInMain;

type
	// TThreadItem �̃v���p�e�B�ݒ�^�擾 ID
	TThreadItemProperty = (
		tipContext,							// : DWORD			// ���R�ɐݒ肵�Ă����l
		tipNo,									// : Integer		// �ԍ�
		tipFileName,						// : string			// �X���b�h�t�@�C����
		tipTitle,								// : string			// �X���b�h�^�C�g��
		tipRoundDate,						// : TDateTime	// �X���b�h���擾���������i��������j
		tipLastModified,				// : TDateTime	// �X���b�h���X�V����Ă�������i�T�[�o�������j
		tipCount,								// : Integer		// �X���b�h�J�E���g�i���[�J���j
		tipAllResCount,					// : Integer		// �X���b�h�J�E���g�i�T�[�o�j
		tipNewResCount,					// : Integer		// �X���b�h�V����
		tipSize,								// : Integer		// �X���b�h�T�C�Y
		tipRound,								// : Boolean		// ����t���O
		tipRoundName,						// : string			// ����
		tipIsLogFile,						// : Boolean		// ���O���݃t���O
		tipKokomade,						// : Integer		// �R�R�܂œǂ񂾔ԍ�
		tipNewReceive,					// : Integer		// �R�R����V�K��M
		tipNewArrival,					// : Boolean		// �V��
		tipUnRead,							// : Boolean		// ���ǃt���O
		tipScrollTop,						// : Integer		// �X�N���[���ʒu
		tipDownloadHost,				// : string			// ���̃z�X�g�ƈႤ�ꍇ�̃z�X�g
		tipAgeSage,							// : TThreadAgeSage	// �A�C�e���̏グ����
		tipURL,									// : string			// �X���b�h���u���E�U�ŕ\������ۂ� URL
		tipFilePath,							// : string			// ���̃X�����ۑ�����Ă���p�X
		tipJumpAddress							// : Integer		// JUMP�惌�X�ԍ�
	);

	// *************************************************************************
	// TThreadItem ���������ꂽ
	// *************************************************************************
	TThreadItemCreate = procedure(
		inInstance : DWORD
	); stdcall;

	// *************************************************************************
	// TThreadItem ���j�����ꂽ
	// *************************************************************************
	TThreadItemDispose = procedure(
		inInstance : DWORD
	); stdcall;

	// *************************************************************************
	// �_�E�����[�h���w��
	// *************************************************************************
	TThreadItemOnDownload = function(
		inInstance	: DWORD					// �C���X�^���X
	) : TDownloadState; stdcall;	// �_�E�����[�h�������������ǂ���

	// *************************************************************************
	// �������݂��w��
	// *************************************************************************
	TThreadItemOnWrite = function(
		inInstance	: DWORD;				// ThreadItem �̃C���X�^���X
		inName			: PChar;				// ���O(�n���h��)
		inMail			: PChar;				// ���[���A�h���X
		inMessage		: PChar					// �{��
	) : TDownloadState; stdcall;	// �������݂������������ǂ���

	// *************************************************************************
	// ���X�ԍ� n �ɑ΂��� html ��v��
	// *************************************************************************
	TThreadItemOnGetRes = function(
		inInstance	: DWORD;		// �C���X�^���X
		inNo				: DWORD			// �\�����郌�X�ԍ�
	) : PChar; stdcall;				// �\������ HTML

	// *************************************************************************
	// ���X�ԍ� n �ɑ΂��� Dat ��v��
	// *************************************************************************
	TThreadItemOnGetDat = function(
		inInstance	: DWORD;		// �C���X�^���X
		inNo				: DWORD			// �\�����郌�X�ԍ�
	) : PChar; stdcall;				// �Q�����˂�`����Dat

	// *************************************************************************
	// �X���b�h�̃w�b�_ html ��v��
	// *************************************************************************
	TThreadItemOnGetHeader = function(
		inInstance				: DWORD;	// ThreadItem �̃C���X�^���X
		inOptionalHeader	: PChar		// �ǉ��̃w�b�_
	) : PChar; stdcall;						// ���`���ꂽ HTML

	// *************************************************************************
	// �X���b�h�̃t�b�^ html ��v��
	// *************************************************************************
	TThreadItemOnGetFooter = function(
		inInstance				: DWORD;	// ThreadItem �̃C���X�^���X
		inOptionalFooter	: PChar		// �ǉ��̃t�b�^
	) : PChar; stdcall;						// ���`���ꂽ HTML

	// *************************************************************************
	// ���� ThreadItem ��������� URL ��v��
	// *************************************************************************
	TThreadItemOnGetBoardURL = function(
		inInstance	: DWORD					// ThreadItem �̃C���X�^���X
	) : PChar; stdcall;	 					// �� URL

function ThreadItemDat2HTML(
	inInstance	: DWORD;		// ThreadItem �̃C���X�^���X
	inDatRes		: PChar;		// ���O<>���[��<>���tID<>�{��<> �ō\�����ꂽ�e�L�X�g
	inResNo			: DWORD;		// ���X�ԍ�
	inIsNew			: Boolean		// �V�����X�Ȃ� True
) : PChar; stdcall;				// ���`���ꂽ HTML

implementation

uses ExternalBoardManager, GikoSystem, BoardGroup, HTMLCreate, MojuUtils;

// *************************************************************************
// TThreadItem �N���X�̃v���p�e�B���擾����
// *************************************************************************
function ThreadItemGetLong(
	instance		: DWORD;
	propertyID	: TThreadItemProperty
) : DWORD; stdcall;
var
	threadItem : TThreadItem;
begin

	threadItem := TThreadItem( instance );
	case propertyID of
		tipContext:							// : DWORD			// ���R�ɐݒ肵�Ă����l
			Result := threadItem.Context;
		tipNo:									// : Integer		// �ԍ�
			Result := threadItem.No;
		tipFileName:						// : string			// �X���b�h�t�@�C����
			Result := DWORD( CreateResultString( threadItem.FileName ) );
		tipTitle:								// : string			// �X���b�h�^�C�g��
			Result := DWORD( CreateResultString( threadItem.Title ) );
		tipCount:								// : Integer		// �X���b�h�J�E���g�i���[�J���j
			Result := threadItem.Count;
		tipAllResCount:					// : Integer		// �X���b�h�J�E���g�i�T�[�o�j
			Result := threadItem.AllResCount;
		tipNewResCount:					// : Integer		// �X���b�h�V����
			Result := threadItem.NewResCount;
		tipSize:								// : Integer		// �X���b�h�T�C�Y
			Result := threadItem.Size;
		tipRound:								// : Boolean		// ����t���O
			Result := DWORD( threadItem.Round );
		tipRoundName:						// : string			// ����
			Result := DWORD( CreateResultString( threadItem.RoundName ) );
		tipIsLogFile:						// : Boolean		// ���O���݃t���O
			Result := DWORD( threadItem.IsLogFile );
		tipKokomade:						// : Integer		// �R�R�܂œǂ񂾔ԍ�
			Result := threadItem.Kokomade;
		tipNewReceive:					// : Integer		// �R�R����V�K��M
			Result := threadItem.NewReceive;
		tipNewArrival:					// : Boolean		// �V��
			Result := DWORD( threadItem.NewArrival );
		tipUnRead:							// : Boolean		// ���ǃt���O
			Result := DWORD( threadItem.UnRead );
		tipScrollTop:						// : Integer		// �X�N���[���ʒu
			Result := threadItem.ScrollTop;
		tipDownloadHost:				// : string			// ���̃z�X�g�ƈႤ�ꍇ�̃z�X�g
			Result := DWORD( CreateResultString( threadItem.DownloadHost ) );
		tipAgeSage:							// : TThreadAgeSage	// �A�C�e���̏グ����
			Result := DWORD( threadItem.AgeSage );
		tipURL:									// : string			// �X���b�h���u���E�U�ŕ\������ۂ� URL
			Result := DWORD( CreateResultString( threadItem.URL ) );
		tipFilePath:														// ���̃X�����ۑ�����Ă���p�X
			Result := DWORD( CreateResultString( threadItem.FilePath ) );
		tipJumpAddress:
			Result := threadItem.JumpAddress;
	else
		Result := 0;
	end;
end;

// *************************************************************************
// TThreadItem �N���X�̃v���p�e�B��ݒ肷��
// *************************************************************************
procedure ThreadItemSetLong(
	instance		: DWORD;
	propertyID	: TThreadItemProperty;
	param : DWORD
); stdcall;
var
	threadItem	: TThreadItem;
begin

	threadItem := TThreadItem( instance );
	case propertyID of
		tipContext:							// : DWORD			// ���R�ɐݒ肵�Ă����l
			threadItem.Context			:= param;
		tipNo:									// : Integer		// �ԍ�
			threadItem.No						:= param;
		tipFileName:						// : string			// �X���b�h�t�@�C����
			threadItem.FileName			:= string( PChar( param ) );
		tipTitle:								// : string			// �X���b�h�^�C�g��
			threadItem.Title				:= string( PChar( param ) );
		tipCount:								// : Integer		// �X���b�h�J�E���g�i���[�J���j
			threadItem.Count				:= param;
		tipAllResCount:					// : Integer		// �X���b�h�J�E���g�i�T�[�o�j
			threadItem.AllResCount	:= param;
		tipNewResCount:					// : Integer		// �X���b�h�V����
			threadItem.NewResCount	:= param;
		tipSize:								// : Integer		// �X���b�h�T�C�Y
			threadItem.Size					:= param;
		tipRound:								// : Boolean		// ����t���O
			threadItem.Round				:= Boolean( param );
		tipRoundName:						// : string			// ����
			//threadItem.RoundName		:= string( PChar( param ) );
			threadItem.RoundName		:= PChar( param );
		tipIsLogFile:						// : Boolean		// ���O���݃t���O
			threadItem.IsLogFile		:= Boolean( param );
		tipKokomade:						// : Integer		// �R�R�܂œǂ񂾔ԍ�
			threadItem.Kokomade			:= param;
		tipNewReceive:					// : Integer		// �R�R����V�K��M
			threadItem.NewReceive		:= param;
		tipNewArrival:					// : Boolean		// �V��
			threadItem.NewArrival		:= Boolean( param );
		tipUnRead:							// : Boolean		// ���ǃt���O
			threadItem.UnRead				:= Boolean( param );
		tipScrollTop:						// : Integer		// �X�N���[���ʒu
			threadItem.ScrollTop		 := param;
		tipDownloadHost:				// : string			// ���̃z�X�g�ƈႤ�ꍇ�̃z�X�g
			threadItem.DownloadHost	:= string( PChar( param ) );
		tipAgeSage:							// : TThreadAgeSage	// �A�C�e���̏グ����
			threadItem.AgeSage			:= TGikoAgeSage( param );
		tipURL:									// : string			// �X���b�h���u���E�U�ŕ\������ۂ� URL
			threadItem.URL					:= string( PChar( param ) );
		//tipFilePath:						// : string			// ���̃X�����ۑ�����Ă���p�X
		//	threadItem.FilePath			:= string( PChar( param ) );
		tipJumpAddress:
			threadItem.JumpAddress		:= param;
	end;

end;

// *************************************************************************
// TThreadItem �N���X�̃v���p�e�B���擾����
// *************************************************************************
function ThreadItemGetDouble(
	instance		: DWORD;
	propertyID	: TThreadItemProperty
) : Double; stdcall;
var
	threadItem : TThreadItem;
begin

	threadItem := TThreadItem( instance );
	case propertyID of
		tipRoundDate:						// : TDateTime	// �X���b�h���擾���������i��������j
			Result := threadItem.RoundDate;
		tipLastModified:				// : TDateTime	// �X���b�h���X�V����Ă�������i�T�[�o�������j
			Result := threadItem.LastModified;
	else
		Result := 0;
	end;

end;

// *************************************************************************
// TThreadItem �N���X�̃v���p�e�B��ݒ肷��
// *************************************************************************
procedure ThreadItemSetDouble(
	instance		: DWORD;
	propertyID	: TThreadItemProperty;
	param				: Double
); stdcall;
var
	threadItem : TThreadItem;
begin

	threadItem := TThreadItem( instance );
	case propertyID of
		tipRoundDate:						// : TDateTime	// �X���b�h���擾���������i��������j
			threadItem.RoundDate		:= param;
		tipLastModified:				// : TDateTime	// �X���b�h���X�V����Ă�������i�T�[�o�������j
			threadItem.LastModified	:= param;
	end;

end;

// *************************************************************************
// TThreadItem �N���X�����ɂQ�����˂�� dat �`�� 1 �s�� HTML �ɕϊ�����
// *************************************************************************
function ThreadItemDat2HTML(
	inInstance	: DWORD;		// ThreadItem �̃C���X�^���X
	inDatRes		: PChar;		// ���O<>���[��<>���tID<>�{��<> �ō\�����ꂽ�e�L�X�g
	inResNo			: DWORD;		// ���X�ԍ�
	inIsNew			: Boolean		// �V�����X�Ȃ� True
) : PChar; stdcall;				// ���`���ꂽ HTML
var
	threadItem : TThreadItem;
	res : TResRec;
	no : string;
	resLink : TResLinkRec;
begin

	threadItem	:= TThreadItem( inInstance );
	// �����𕪉�
	THTMLCreate.DivideStrLine( string( inDatRes ) , @res);
	if AnsiCompareStr( string( inDatRes ) , '' ) <> 0 then begin
		res.FBody		:= THTMLCreate.DeleteLink(res.FBody);
		resLink.FBbs	:= threadItem.ParentBoard.BBSID;
		resLink.FKey	:= ChangeFileExt( threadItem.FileName, '' );
		HTMLCreater.AddAnchorTag( @res );
		HTMLCreater.ConvRes( @res, @resLink );

		no					:= IntToStr( inResNo );

		try
			if GikoSys.Setting.UseSkin then begin
				// �X�L��
				if inIsNew then
					Result := CreateResultString( HTMLCreater.SkinedRes(
						HTMLCreater.LoadFromSkin(
                            GikoSys.GetSkinNewResFileName, threadItem, threadItem.Size
						), @res, no
                    ) )
                else
					Result := CreateResultString( HTMLCreater.SkinedRes(
						HTMLCreater.LoadFromSkin(
                            GikoSys.GetSkinResFileName, threadItem, threadItem.Size
                        ), @res, no
                    ) );
            end else if GikoSys.Setting.UseCSS then begin
                // CSS
                if res.FName = '' then
                    res.FName := '&nbsp;';
                if res.FMailTo = '' then
                    Result := CreateResultString( '<a name="' + no + '"></a>'
                                    + '<div class="header"><span class="no"><a href="menu:' + No + '">' + no + '</a></span> '
                                    + '<span class="name_label">���O�F</span> '
                                    + '<span class="name"><b>' + res.FName + '</b></span> '
                                    + '<span class="date_label">���e���F</span> '
                                    + '<span class="date">' + res.FDateTime+ '</span></div>'
                                    + '<div class="mes">' + res.FBody + ' </div>' )
                else if GikoSys.Setting.ShowMail then
                    Result := CreateResultString( '<a name="' + no + '"></a>'
                                    + '<div class="header"><span class="no"><a href="menu:' + no + '">' + no + '</a></span>'
                                    + '<span class="name_label"> ���O�F </span>'
                                    + '<a class="name_mail" href="mailto:' + res.FMailTo + '">'
                                    + '<b>' + res.FName + '</b></a><span class="mail"> [' + res.FMailTo + ']</span>'
                                    + '<span class="date_label"> ���e���F</span>'
                                    + '<span class="date"> ' + res.FDateTime+ '</span></div>'
                                    + '<div class="mes">' + res.FBody + ' </div>' )
                else
                    Result := CreateResultString( '<a name="' + no + '"></a>'
                                    + '<div class="header"><span class="no"><a href="menu:' + no + '">' + no + '</a></span>'
                                    + '<span class="name_label"> ���O�F </span>'
                                    + '<a class="name_mail" href="mailto:' + res.FMailTo + '">'
                                    + '<b>' + res.FName + '</b></a>'
                                    + '<span class="date_label"> ���e���F</span>'
                                    + '<span class="date"> ' + res.FDateTime+ '</span></div>'
                                    + '<div class="mes">' + res.FBody + ' </div>' );
            end else begin
                // �f�t�H���g
                if res.FMailTo = '' then
                    Result := CreateResultString( '<a name="' + no + '"></a><dt><a href="menu:' + no + '">' + no + '</a> ���O�F<font color="forestgreen"><b> ' + res.FName + ' </b></font> ���e���F ' + res.FDateTime+ '<br><dd>' + res.Fbody + ' <br><br><br>' )
                else if GikoSys.Setting.ShowMail then
                    Result := CreateResultString( '<a name="' + no + '"></a><dt><a href="menu:' + no + '">' + no + '</a> ���O�F<a href="mailto:' + res.FMailTo + '"><b> ' + res.FName + ' </B></a> [' + res.FMailTo + '] ���e���F ' + res.FDateTime+ '<br><dd>' + res.Fbody + ' <br><br><br>' )
                else
                    Result := CreateResultString( '<a name="' + no + '"></a><dt><a href="menu:' + no + '">' + no + '</a> ���O�F<a href="mailto:' + res.FMailTo + '"><b> ' + res.FName + ' </B></a> ���e���F ' + res.FDateTime+ '<br><dd>' + res.Fbody + ' <br><br><br>' );
            end;
        except
            Result := nil;
        end;
    end else begin
    	Result := nil;
    end;

end;

// *************************************************************************
// TThreadItem �N���X�����ɃX���b�h�̃w�b�_���擾����
// *************************************************************************
function ThreadItemGetHeader(
	inInstance				: DWORD;	// ThreadItem �̃C���X�^���X
	inOptionalHeader	: PChar		// �ǉ��̃w�b�_
) : PChar; stdcall;						// ���`���ꂽ HTML
var
	threadItem				: TThreadItem;
	skinHeader				: string;
	optionalHeader		: string;
begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.ThreadItemGetHeader');
	{$ENDIF}
	threadItem			:= TThreadItem( inInstance );
	optionalHeader	:= string( inOptionalHeader );

	try
		if GikoSys.Setting.UseSkin then begin
			// �X�L��
			skinHeader := HTMLCreater.LoadFromSkin( GikoSys.GetSkinHeaderFileName, threadItem, threadItem.Size );
			if Length( optionalHeader ) > 0 then
				skinHeader :=
					StringReplace( skinHeader, '</head>', optionalHeader + '</head><a name="top"></a>', [] );
		end else if GikoSys.Setting.UseCSS then begin
			// CSS
			skinHeader :=
				'<html><head>' +
				'<title>' + threadItem.Title + '</title>' +
				'<link rel="stylesheet" href="'+ GikoSys.Setting.GetStyleSheetDir + GikoSys.Setting.CSSFileName +'" type="text/css">' +
				optionalHeader +
				'</head>' +
				'<body>' +
				'<a name="top"></a>' +
				'<div class="title">' + threadItem.Title + '</div>';
		end else begin
			// �f�t�H���g
			skinHeader :=
				'<html><head>' +
				'<title>' + threadItem.Title + '</title>' +
				optionalHeader +
				'</head>' +
				'<body TEXT="#000000" BGCOLOR="#EFEFEF" link="#0000FF" alink="#FF0000" vlink="#660099">' +
				'<a name="top"></a>' +
				'<font size=+1 color="#FF0000">' + threadItem.Title + '</font>' +
				'<dl>';
		end;
	except
	end;

	Result := CreateResultString( skinHeader );

end;

// *************************************************************************
// TThreadItem �N���X�����ɃX���b�h�̃t�b�^���擾����
// *************************************************************************
function ThreadItemGetFooter(
	inInstance				: DWORD;	// ThreadItem �̃C���X�^���X
	inOptionalFooter	: PChar		// �ǉ��̃t�b�^
) : PChar; stdcall;						// ���`���ꂽ HTML
var
	threadItem				: TThreadItem;
	skinFooter				: string;
	optionalFooter		: string;
begin

	{$IFDEF DEBUG}
	Writeln('ExternalBoardManager.ThreadItemGetFooter');
	{$ENDIF}
	threadItem			:= TThreadItem( inInstance );
	optionalFooter	:= string( inOptionalFooter );

	try
		if GikoSys.Setting.UseSkin then begin
			// �X�L��
			skinFooter := HTMLCreater.LoadFromSkin( GikoSys.GetSkinFooterFileName, threadItem, threadItem.Size );
			if Length( optionalFooter ) > 0 then
				skinFooter :=
					StringReplace( skinFooter, '</body>', optionalFooter + '</body>', [] );
		end else if GikoSys.Setting.UseCSS then begin
			// CSS
			skinFooter :=
				optionalFooter +
				'</body></html>' +
				'<a name="last"></a>' +
				'</body></html>';
		end else begin
			// �f�t�H���g
			skinFooter :=
				'</dl>' +
				optionalFooter +
				'</body></html>' +
				'<a name="last"></a>' +
				'</body></html>';
		end;
	except
	end;

	Result := CreateResultString( skinFooter );

end;

// *************************************************************************
// �X���b�h�̃_�E�����[�h���i�s����
// *************************************************************************
procedure ThreadItemWork(
	inInstance	: DWORD;			// ThreadItem �̃C���X�^���X
	inWorkCount	: Integer			// ���݂̐i����(�J�E���g)
); stdcall;
begin

	if Assigned( OnWork ) then
		OnWork( TObject( inInstance ), wmRead, inWorkCount );

end;

// *************************************************************************
// �X���b�h�̃_�E�����[�h���n�܂���
// *************************************************************************
procedure ThreadItemWorkBegin(
	inInstance			: DWORD;	// ThreadItem �̃C���X�^���X
	inWorkCountMax	: Integer	// �ʐM�̏I���������J�E���g
); stdcall;
begin

	if Assigned( OnWorkBegin ) then
		OnWorkBegin( TObject( inInstance ), wmRead, inWorkCountMax );

end;

// *************************************************************************
// �X���b�h�̃_�E�����[�h���I�����
// *************************************************************************
procedure ThreadItemWorkEnd(
	inInstance	: DWORD				// ThreadItem �̃C���X�^���X
); stdcall;
begin

	if Assigned( OnWorkEnd ) then
		OnWorkEnd( TObject( inInstance ), wmRead );

end;

exports
	ThreadItemGetLong,
	ThreadItemSetLong,
	ThreadItemGetDouble,
	ThreadItemSetDouble,
	ThreadItemDat2HTML,
	ThreadItemGetHeader,
	ThreadItemGetFooter,
	ThreadItemWork,
	ThreadItemWorkBegin,
	ThreadItemWorkEnd;

end.
 