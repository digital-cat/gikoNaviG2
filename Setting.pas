unit Setting;


interface

uses
	SysUtils, Classes, Graphics, Forms, {Math, IniFiles, UCryptAuto, UBase64,}
	ComCtrls, GestureModel, IniFiles, SkinFiles, Belib;

const
	MAIN_COOLBAND_COUNT = 4;		//���C��CoolBand�̐�
	LIST_COOLBAND_COUNT = 2;		//��CoolBand�̐�
	BROWSER_COOLBAND_COUNT = 3;	//�u���E�UCoolBand�̐�


type
	TGikoTabPosition = (gtpTop, gtpBottom);								// �^�u�ʒu
	TGikoTabAppend = (gtaFirst, gtaLast, gtaRight, gtaLeft);									// �^�u�ǉ��ʒu
	TGikoTabStyle = (gtsTab, gtsButton, gtsFlat);					// �^�u�X�^�C��
	TGikoListOrientation = (gloHorizontal, gloVertical);	// ���X�g�����E����
	TGikoListState = (glsMax, glsNormal, glsMin);					// ���X�g�T�C�Y���
																												// �|�b�v�A�b�v�\���ʒu
	TGikoPopupPosition = (gppLeftTop = 0, gppTop, gppRightTop,
												gppLeft, gppCenter, gppRight,
												gppLeftBottom, gppBottom, gppRightBottom);
																												//�v���r���[�T�C�Y
	TGikoPreviewSize = (gpsXLarge, gpsLarge, gpsMedium, gpsSmall, gpsXSmall);
	TGikoBrowserAutoMaximize	= (gbmNone, gbmClick, gbmDoubleClick);
																												// �u���E�U�������I�ɍő剻�������
	/// ���X�\���͈́B10 �` 65535 �͍ŐV n ���X�����B
	/// ���� 201-300 �̂悤�Ȕ͈͂���������\�����l���ď�� 2 byte �͗\��B
	TGikoResRange = (grrAll, grrSelect, grrKoko, grrNew);

	/// �X���b�h�ꗗ�\���͈�
	TGikoThreadRange = (gtrAll, gtrSelect, gtrLog, gtrNew, gtrLive, gtrArch);

	//! �X�p���t�B���^�[�A���S���Y��
	TGikoSpamFilterAlgorithm = (
		gsfaNone, gsfaPaulGraham, gsfaGaryRobinson, gsfaGaryRobinsonFisher);


	/// �J�e�S�����X�g�̃J���� ID
	type	TGikoBBSColumnID = (gbbscTitle);
	/// �J�e�S�����X�g�̃J������
	const	GikoBBSColumnCaption : array[0..0] of string =
		( '�J�e�S����' );
	/// �J�e�S�����X�g�J�����z��
	type	TGikoBBSColumnList = class( TList )
	private
		function GetItem( index : integer ) : TGikoBBSColumnID;
		procedure SetItem( index : integer; value : TGikoBBSColumnID);
	public
		constructor Create;
		destructor Destroy;	override;
		function Add( value : TGikoBBSColumnID ) : Integer;
		property Items[index : integer]: TGikoBBSColumnID read GetItem write SetItem; default;
	end;
	/// ���X�g�̃J���� ID
	type	TGikoCategoryColumnID = (gccTitle, gccRoundName, gccLastModified);
	/// ���X�g�̃J������
	const GikoCategoryColumnCaption : array[0..2] of string =
		( '��', '����\��', '�擾����' );
	/// ���X�g�J�����z��
	type	TGikoCategoryColumnList = class( TList )
	private
		function GetItem( index : integer ) : TGikoCategoryColumnID;
		procedure SetItem( index : integer; value : TGikoCategoryColumnID);
	public
		constructor Create;
		destructor Destroy;	override;
		function Add( value : TGikoCategoryColumnID ) : Integer;
		property Items[index : integer]: TGikoCategoryColumnID read GetItem write SetItem; default;
	end;
	/// �X�����X�g�̃J���� ID
	type	TGikoBoardColumnID = (gbcTitle, gbcAllCount, gbcLocalCount, gbcNonAcqCount,
		gbcNewCount, gbcUnReadCount, gbcRoundName, gbcRoundDate, gbcCreated, gbcLastModified, gbcVigor );{gbcLastModified,}
	/// �X�����X�g�̃J������
	const	GikoBoardColumnCaption : array[0..10] of string =
		( '�X���b�h��', '�J�E���g', '�擾', '���擾', '�V��',
		'����', '����\��', '�擾����', '�X���쐬����', '�ŏI�X�V����', '����' );
	const GikoBoardColumnAlignment : array[0..10] of TAlignment = (
		taLeftJustify, taRightJustify, taRightJustify, taRightJustify,
		taRightJustify, taRightJustify, taLeftJustify, taLeftJustify,
		taLeftJustify, taLeftJustify, taRightJustify);
	/// �X�����X�g�J�����z��
	type	TGikoBoardColumnList = class( TList )
	private
		function GetItem( index : integer ) : TGikoBoardColumnID;
		procedure SetItem( index : integer; value : TGikoBoardColumnID);
	public
		constructor Create;
		destructor Destroy;	override;
		function Add( value : TGikoBoardColumnID ) : Integer;
		property Items[index : integer]: TGikoBoardColumnID read GetItem write SetItem; default;
	end;

type
	//CoolBar�ݒ背�R�[�h
	TCoolSet = record
		FCoolID: Integer;
		FCoolWidth: Integer;
		FCoolBreak: Boolean;
	end;

	TSetting = class(TObject)
	private
		//��M�o�b�t�@�T�C�Y
		//FRecvBufferSize: Integer;
		//HTTP1.1�g�p
		FProtocol: Boolean;
		//�v���L�V�ڑ�HTTP1.1�g�p
		FProxyProtocol: Boolean;
  	//IPv6�g�p
    FIPv6: Boolean;
    FIPv4List: TStringList;

		//�v���L�V�i�Ǎ��p�j
		FReadProxy: Boolean;
		FReadProxyAddress: string;
		FReadProxyPort: Integer;
		FReadProxyUserID: string;
		FReadProxyPassword: string;

		//�v���L�V�i�����p�j
		FWriteProxy: Boolean;
		FWriteProxyAddress: string;
		FWriteProxyPort: Integer;
		FWriteProxyUserID: string;
		FWriteProxyPassword: string;

		//�L���r�l�b�g
		FCabinetFontName: string;
		FCabinetFontSize: Integer;
		FCabinetFontBold: Boolean;
		FCabinetFontItalic: Boolean;
		FCabinetFontColor: TColor;
		FCabinetBackColor: TColor;

		//���X�g
		FListFontName: string;
		FListFontSize: Integer;
		FListFontBold: Boolean;
		FListFontItalic: Boolean;
		FListFontColor: TColor;
		FListBackColor: TColor;

		//���b�Z�[�W���X�g
		FMessageFontName: string;
		FMessageFontSize: Integer;
		FMessageFontBold: Boolean;
		FMessageFontItalic: Boolean;
		FMessageFontColor: TColor;
		FMessageBackColor: TColor;

		//�u���E�U
		FBrowserFontName: string;			// ''...default
		FBrowserFontSize: Integer;		// 0...default
		FBrowserFontBold: Integer;		// 0...default, -1...False, 1...True
		FBrowserFontItalic: Integer;	// ��ɓ���
		FBrowserFontColor: Integer;		// -1...default
		FBrowserBackColor: Integer;		// ��ɓ���

		//�G�f�B�^
		FEditorFontName: string;
		FEditorFontSize: Integer;
		FEditorFontBold: Boolean;
		FEditorFontItalic: Boolean;
		FEditorFontColor: TColor;
		FEditorBackColor: TColor;

		//�^�u�t�H���g
		FBrowserTabFontName: string;
		FBrowserTabFontSize: Integer;
		FBrowserTabFontBold: Boolean;
		FBrowserTabFontItalic: Boolean;

		//�q���g�E�B���h�E
		FHintFontName: string;
		FHintFontSize: Integer;
		//FHintFontBold: Boolean;
		//FHintFontItalic: Boolean;
		FHintFontColor: TColor;
		FHintBackColor: TColor;

		//�E�B���h�E�T�C�Y
		FWindowTop: Integer;
		FWindowLeft: Integer;
		FWindowHeight: Integer;
		FWindowWidth: Integer;
		FWindowMax: Boolean;
		//���X�g�r���[�X�^�C��
		FListStyle: TViewStyle;

		//�c�[���o�[�\��
		FStdToolBarVisible: Boolean;
		FAddressBarVisible: Boolean;
		FLinkBarVisible: Boolean;
		FListToolBarVisible: Boolean;
		FListNameBarVisible: Boolean;
		FBrowserToolBarVisible: Boolean;
		FBrowserNameBarVisible: Boolean;

		//�u���E�U�^�u
		FBrowserTabVisible: Boolean;
		FBrowserTabPosition: TGikoTabPosition;
		FBrowserTabAppend: TGikoTabAppend;
		FBrowserTabStyle: TGikoTabStyle;

		//���b�Z�[�W�o�[
		FMessageBarVisible: Boolean;
		FMessegeBarHeight: Integer;

		//�X�e�[�^�X�o�[
		FStatusBarVisible: Boolean;

		//�L���r�l�b�g���E�T�C�Y
		FCabinetVisible: Boolean;
		FCabinetWidth: Integer;

		//���X�g�E�u���E�U�T�C�Y
		FListOrientation: TGikoListOrientation;
		FListHeight: Integer;
		FListHeightState: TGikoListState;
		FListWidth: Integer;
		FListWidthState: TGikoListState;
//		FListHeightMax: Boolean;
//		FListWidthMax: Boolean;

		//���M�p���O�E���[��
		FNameList: TStringList;
		FMailList: TStringList;

		//�G�f�B�^�[�E�B���h�E�T�C�Y
		FEditWindowTop: Integer;
		FEditWindowLeft: Integer;
		FEditWindowHeight: Integer;
		FEditWindowWidth: Integer;
		FEditWindowMax: Boolean;
    FEditWindowStay: Boolean;
    FEditWindowTranslucent: Boolean;

		//���X�g�ԍ��\��
		FListViewNo: Boolean;
		//CSS�\��
		FUseCSS: Boolean;
		// �X�L���\��(�ꎞ�I�Ȃ��̂� ini �ɕۑ��͂���Ȃ�)
		FUseSkin: Boolean;
		//������`����p��Skin�𗘗p���邩
		FUseKatjushaType : Boolean;
		//mail���\��
		FShowMail: Boolean;
		/// ���X�\���͈�
		FResRange			: Longint;
		/// �N�������X�\���͈͂̌Œ�
		FResRangeHold	: Boolean;
		/// �X���b�h�ꗗ�\���͈�
		FThreadRange	: TGikoThreadRange;
		//��A�N�e�B�u�����X�|�b�v�A�b�v�\��
		FUnActivePopup: Boolean;
		//���X�|�b�v�A�b�v�w�b�_�[�{�[���h
		FResPopupHeaderBold: Boolean;
    // BE�A�C�R���EEmoticon�摜�\��
    FIconImageDisplay: Boolean;
    // �X���^�C���蕶���񏜋�
    FThreadTitleTrim: Boolean;

		//���O�t�H���_
		FLogFolder: string;
        FLogFolderP: string; //�p�X�����p�X��؂�L���ŏI����Ă���B
		FNewLogFolder: string;

		//���X�g�J�����w�b�_�[�T�C�Y
		FBBSColumnWidth: array[0..0] of Integer;
		FCategoryColumnWidth: array[0..2] of Integer;
		FBoardColumnWidth: array[0..10] of Integer;

		/// �J�e�S�����X�g�J��������
		FBBSColumnOrder : TGikoBBSColumnList;
		/// ���X�g�J��������
		FCategoryColumnOrder : TGikoCategoryColumnList;
		/// �X�����X�g�J��������
		FBoardColumnOrder : TGikoBoardColumnList;

		//�\�[�g��
		FBBSSortIndex: Integer;
		FBBSSortOrder: Boolean;
		FCategorySortIndex: Integer;
		FCategorySortOrder: Boolean;
		FBoardSortIndex: Integer;
		FBoardSortOrder: Boolean;

		//Dat�����X���\�[�g��
		FDatOchiSortIndex: Integer;
		FDatOchiSortOrder: Boolean;

		//�i���ݕ�����
		FSelectTextList: TStringList;

		//�ꗗURL
		//FBoardURL2ch: string;
		FBoardURLs: TStringList;
		FBoardURLSelected: Integer;

		//���[�UID�E�p�X���[�h
		FUserID: string;
		FPassword: string;
		FAutoLogin: Boolean;
		FForcedLogin: Boolean;
//		FDolibURL: string;

  	// User-Agent�o�[�W�����ԍ��Œ�
    FUAVersion: Integer;

		//URL�N���b�N���N���A�v��
		FURLApp: Boolean;
		FURLAppFile: string;

		//mailto�N���b�N������
		FOpenMailer: Boolean;

		//�폜�m�F
		FDeleteMsg: Boolean;

		//CoolBar�i���C���E�E�u���E�U�j
		FMainCoolBar: array[0..MAIN_COOLBAND_COUNT - 1] of TCoolSet;
		FListCoolBar: array[0..LIST_COOLBAND_COUNT - 1] of TCoolSet;
		FBrowserCoolBar: array[0..BROWSER_COOLBAND_COUNT - 1] of TCoolSet;

		//ToolBar Wrapable
		FListToolBarWrapable: Boolean;
		FBrowserToolBarWrapable: Boolean;

		//�|�b�v�A�b�v�ʒu
		FPopupPosition: TGikoPopupPosition;

		//�A�h���X�o�[
		FURLDisplay: Boolean;
		FAddressBarTabStop: Boolean;
		FLinkAddAddressBar: Boolean;
		FAddressHistoryCount: Integer;

		//�摜�v���r���[
		FPreviewVisible: Boolean;
		FPreviewSize: TGikoPreviewSize;
		FPreviewWait: Integer;

		// �u���E�U
		FBrowserAutoMaximize: TGikoBrowserAutoMaximize;

		//�X���b�h�ꗗ�X�V�A�C�R���\��
		FListIconVisible: Boolean;

		//�X���b�h�ꗗ��Log�̂���X���b�h�̂݃X���쐬����\�����邩
		FCreationTimeLogs: Boolean;
		//�X���b�h�ꗗ�̃X���������Ŗ����̃X���̐�������\�����Ȃ�
		FFutureThread: Boolean;

		//�������ݎ��}�V�����Ԏg�p�ݒ�
		FUseMachineTime: Boolean;
		FTimeAdjustSec: Integer;
		FTimeAdjust: Boolean;

		//���ځ`��
		FAbonDeleterlo : Boolean; //&rlo;����邩
		FAbonReplaceul : Boolean; //<ul>�^�O��<br>�^�O�ɒu�����邩
		FPopUpAbon		 : Boolean; //���X�|�b�v�A�b�v���̂��ځ`��L��
		FShowNGLinesNum : Boolean; //�Y�������m�f���[�h�t�@�C���̍s����\��
		FAddResAnchor : Boolean; //NG���X�ւ̃��X�A���J�[��ǉ�����
		FDeleteSyria : Boolean;	//�V���A��u���N���΍�
		FIgnoreKana	: Boolean;	//�S���p�Ђ�J�i�̈Ⴂ�𖳎����邩
    FKeepNgFile : Boolean;	//�X���S�̍Ď擾���Ɏ蓮���ځ`������N���A���Ȃ�

		//NG���[�h�ҏW
		FNGTextEditor: Boolean; //�ҏW�Ƀe�L�X�g�G�f�B�^���g�p���邩
		FNGWindowTop: Integer;
		FNGWindowLeft: Integer;
		FNGWindowHeight: Integer;
		FNGWindowWidth: Integer;
		FNGWindowMax: Boolean;

		// �X���b�h�i���t�B�[���h�̕�
		FSelectComboBoxWidth : Integer;

		// �Ō�ɑI�����ꂽ�I�v�V�����_�C�A���O�̃^�u
		FOptionDialogTabIndex: Integer;

		// �Ō�ɑI�����ꂽ�L���r�l�b�g
		FCabinetIndex: Integer;

		//�I�����Ɋm�F�_�C�A���O��\�����邩
		FShowDialogForEnd : Boolean;
		//�S�Ẵ^�u����̂Ƃ��Ɋm�F�_�C�A���O��\������
		FShowDialogForAllTabClose: Boolean;
		//�擾���X���ƃX���b�h�̃��X�����قȂ����Ƃ��ɒʏ�w�i�F�ƈ�����F�̔w�i�F���g�p���邩
		FUseOddColorOddResNum: Boolean;
		FOddColor: TColor;
		//���X�������������ɁA�I���A�C�e���Ƀt�H�[�J�X�������Ƃ��ɑ����ɂ��邩
		FUnFocusedBold : Boolean;
		//�G�f�B�^�e�L�X�g�̃t�H���g�ݒ����\���ɂ��g�p���邩
		FSetBoardInfoStyle: Boolean;

		//Samba24�΍�@�\���g����
		FUseSamba: Boolean;

		//���X�A���J�[���N���b�N���ăW�����v���邩
		FResAnchorJamp: Boolean;

    //Tab�����ۑ�
    FTabAutoLoadSave : Boolean;
    //�Ō�ɊJ���Ă����X���b�h��URL
    FLastCloseTabURL: String;
    //�ɂ�����ē��T�|�[�g�@�\
    F2chSupport : Boolean;

		// �G�f�B�^
		FSpaceToNBSP	: Boolean;	///< ���p�X�y�[�X�ATab �� &nbsp; �ɒu��
		FAmpToCharRef	: Boolean;	///< '&' �� &amp; �ɒu��

		//�u���E�U�^�u��\���̎��̃X���ꗗ�ł̃J�[�\���L�[�ړ��̖���������
		FSelectInterval	: Integer;

		//KuroutSettingTab �ڍאݒ�^�u��ActiveTab
		FKuroutSettingTabIndex: Integer;

		//! �}�E�X�W�F�X�`���[
		FGestures	: TGestureModel;
		//! �}�E�X�W�F�X�`���[���g�p���邩�ǂ���
		FGestureEnabled : Boolean;
		//! �}�E�X�W�F�X�`���[���R���e�L�X�g���̏�Ŗ���
		FGestureIgnoreContext : Boolean;
		//�t�V�A�i�g���b�v�ݒ�
		FLocalTrapAtt : Boolean;
		FRemoteTrapAtt : Boolean;
		FReadTimeOut: Integer;

		//! �g�p����X�p���t�B���^�[
		FSpamFilterAlgorithm : TGikoSpamFilterAlgorithm;
		//�~���[�g���Ă邩
		FMute: Boolean;
		//�X���i���݂Ŗ��m�蕶�����L���ɂ��邩
		FUseUndecided: Boolean;

				//Be2ch
                //�F�ؗp���[�UID�E�p�X���[�h
		FBeUserID: String;
		FBePassword: String;
		FBeAutoLogin: Boolean;
		FBeLogin: Boolean;
		//�����̍ő�ۑ�����
		FMaxRecordCount : Integer;

		//�X���b�h�ꗗ���_�E�����[�h��Ƀ\�[�g���邩
		FAutoSortThreadList : Boolean;

		//InputAssist�t�H�[���̈ʒu
		FInputAssistFormLeft :Integer;
		FInputAssistFormTop :Integer;
		//InputAssist�t�H�[���̃T�C�Y
		FInputAssistFormWidth: Integer;
		FInputAssistFormHeight: Integer;

		//! Cookie�ɕt������Œ�R�[�h
		FFixedCookie: String;
    //! �����N�ړ������̕ێ���
    FMoveHistorySize : Integer;
    //! �ŏ��������Ƃ��Ƀ^�X�N�g���C�Ɋi�[���邩
    FStoredTaskTray : Boolean;
    //! �^�u�̈ړ��Ń��[�v��������
    FLoopBrowserTabs : Boolean;
    //! 100���X�\���̐擪�\�����X��
    FHeadResCount : Integer;
    //! 100���X�\�����i�g���p�j
    FResRangeExCount: Integer;
    //! �֘A�L�[���[�h�ǉ��t���O
    FAddKeywordLink: Boolean;
    //! dat�u����L���ɂ���
    FReplaceDat: Boolean;
    //! sent.ini�t�@�C���̃T�C�Y�i�P��MB�j
    FSentIniFileSize: Integer;
    //! �����NURL�擾�̑Ώۊg���q
    FExtList: String;
    //! Skin�֘A
    FSkinFiles: TSkinFiles;
    //! index�t�@�C����ǂݎ���dat����������
    FCheckDatFile: Boolean;
    //! ��ID���X�A���J�[�\��
    FLimitResCountMessage: Boolean;
    //! ���X�|�b�v�A�b�v�\���ʒudeltaX
    FRespopupDeltaX: Integer;
    //! ���X�|�b�v�A�b�v�\���ʒudeltaY
    FRespopupDeltaY: Integer;
    //! ���X�|�b�v�A�b�v�^�C�}�[
    FRespopupWait: Integer;
    //! ���[�������X�|�b�v�A�b�v
    FRespopupMailTo: Boolean;
    //! �딚�`�F�b�N
    FUseGobakuCheck: Boolean;
    //! Unicode�ŃG�f�B�^
    FUseUnicode: Boolean;
    //! �v���r���[�\����CSS�܂��̓X�L����K�p����
    FPreviewStyle: Boolean;
    //! ���G�`���i�摜�Y�t�j��L���ɂ���
    FOekaki: Boolean;
    //! �폜�v������ʈ���
    FSakuBoard: Boolean;

		//! �X���^�C�����E�B���h�E
		FThrdSrchTop: Integer;
		FThrdSrchLeft: Integer;
		FThrdSrchWidth: Integer;
		FThrdSrchHeight: Integer;
		FThrdSrchMax: Boolean;
    FThrdSrchStay: Boolean;
    FThrdSrchCol1W: Integer;
    FThrdSrchCol2W: Integer;
    FThrdSrchCol3W: Integer;
    FThrdSrchCol4W: Integer;
    FThrdSrchHistory: TStringList;

    //! �`���̏��pCookie
    FBoukenCookieList: TStringList;

		//! �ǂ񂮂�V�X�e���E�B���h�E
		FDonguriTop: Integer;
		FDonguriLeft: Integer;
		FDonguriWidth: Integer;
		FDonguriHeight: Integer;
		FDonguriStay: Boolean;
    FDonguriTheme: Integer;
    FDonguriTaskBar: Boolean;
		//! �ǂ񂮂�֘A
    FDonguriMenuTop: Boolean;


		function GetMainCoolSet(Index: Integer): TCoolSet;
		function GetBoardCoolSet(Index: Integer): TCoolSet;
		function GetBrowserCoolSet(Index: Integer): TCoolSet;
		procedure SetMainCoolSet(Index: Integer; CoolSet: TCoolSet);
		procedure SetBoardCoolSet(Index: Integer; CoolSet: TCoolSet);
		procedure SetBrowserCoolSet(Index: Integer; CoolSet: TCoolSet);

		function GetBBSColumnWidth(index: Integer): Integer;
		function GetCategoryColumnWidth(index: Integer): Integer;
		function GetBoardColumnWidth(index: Integer): Integer;
		procedure SetBBSColumnWidth(index: Integer; value: Integer);
		procedure SetCategoryColumnWidth(index: Integer; value: Integer);
		procedure SetBoardColumnWidth(index: Integer; value: Integer);

		function GetSoundName(Index: Integer): string;
		function GetSoundViewName(Index: Integer): string;
		function GetSoundFileName(Index: Integer): string;
		procedure SetSoundFileName(Index: Integer; value: string);
		function Encrypt(s: string): string;
		function Decrypt(s: string): string;

		procedure MakeURLIniFile();

		procedure SetUseCSS( value: Boolean );
		procedure SetCSSFileName( fileName: string );
    function GetCSSFileName: string;
    //! �v���L�V�ݒ�ǂݍ���
    procedure ReadProxySettings(memIni: TMemIniFile);
    //! �e��E�B���h�E�ݒ�ǂݍ���
    procedure ReadWindowSettings(memIni: TMemIniFile);
    //! ���͗���ǂݍ��݁i�����{���[�����{���O�j
    procedure ReadInputHisotrys(memIni: TMemIniFile);
    //! ���X�g�J�������ǂݍ���
    procedure ReadListColumnWidth(memIni: TMemIniFile);
    //! �J�e�S�����X�g�J���������ǂݍ���
    procedure ReadOrdColumn(memIni: TMemIniFile);
	protected

	public
		constructor Create;
		destructor Destroy; override;
		function GetFileName: string;
		function GetBoardURLFileName: string;
		procedure ReadSettingFile;
		procedure ReadBoardURLsFile;
		procedure WriteSystemSettingFile;
		procedure WriteWindowSettingFile;
		procedure WriteNameMailSettingFile;
		procedure WriteFolderSettingFile();
		procedure WriteBoardURLSettingFile;
		procedure WriteBoukenSettingFile;
		function GetSoundCount: Integer;
		function FindSoundFileName(Name: string): string;

		function GetBoardFileName: string;
		function GetCustomBoardFileName: string;
		function GetBoardDir: string;
		function GetHtmlTempFileName: string;
		function GetAppDir: string;
		function GetTempFolder: string;
		function GetSentFileName: string;
		function GetConfigDir: string;
		function GetSkinDir: string;
		function GetStyleSheetDir: string;
		function GetOutBoxFileName: string;
		function GetDefaultFilesFileName: string;
		function GetNGWordsDir: string;
		function GetBoardPlugInDir: string;
		function GetSambaFileName: string;
		function GetIgnoreFileName: string;
		function GetGestureFileName : string;
		function GetSpamFilterFileName : string;
		function GetLanguageFileName: string;
		function GetMainKeyFileName: String;
		function GetEditorKeyFileName: String;
		procedure WriteLogFolder(AVal : String);
		function GetInputAssistFileName : String;
    function GetReplaceFileName: String;
    function GetExtprevieFileName: String;
    function GetBoukenCookie(AHostName: String): String;
    procedure SetBoukenCookie(ACookieValue, AHostName: String);
    procedure GetBouken(AHostName: String; var Domain:String; var Cookie:String);
    procedure GetDefaultIPv4Domain(dest: TStrings);
    {
    \brief  �����N�����̕ێ��T�C�Y��setter
    \param  AVal    �ݒ肷��T�C�Y( >0)
    }
    procedure SetMoveHistorySize(AVal : Integer);
		//��M�o�b�t�@�T�C�Y   ��Indy10�Ŏg��Ȃ��Ȃ���
		//property RecvBufferSize: Integer read FRecvBufferSize write FRecvBufferSize;
		//HTTP1.1�g�p
		property Protocol: Boolean read FProtocol write FProtocol;
		//�v���L�V�ڑ�HTTP1.1�g�p
		property ProxyProtocol: Boolean read FProxyProtocol write FProxyProtocol;
  	// IPv6�g�p
  	property IPv6: Boolean read FIPv6 write FIPv6;
    property IPv4List: TStringList read FIPv4List write FIPv4List;

		property ReadProxy: Boolean read FReadProxy write FReadProxy;
		property ReadProxyAddress: string read FReadProxyAddress write FReadProxyAddress;
		property ReadProxyPort: Integer read FReadProxyPort write FReadProxyPort;
		property ReadProxyUserID: string read FReadProxyUserID write FReadProxyUserID;
		property ReadProxyPassword: string read FReadProxyPassword write FReadProxyPassword;

		property WriteProxy: Boolean read FWriteProxy write FWriteProxy;
		property WriteProxyAddress: string read FWriteProxyAddress write FWriteProxyAddress;
		property WriteProxyPort: Integer read FWriteProxyPort write FWriteProxyPort;
		property WriteProxyUserID: string read FWriteProxyUserID write FWriteProxyUserID;
		property WriteProxyPassword: string read FWriteProxyPassword write FWriteProxyPassword;

		property CabinetFontName: string read FCabinetFontName write FCabinetFontName;
		property CabinetFontSize: Integer read FCabinetFontSize write FCabinetFontSize;
		property CabinetFontBold: Boolean read FCabinetFontBold write FCabinetFontBold;
		property CabinetFontItalic: Boolean read FCabinetFontItalic write FCabinetFontItalic;
		property CabinetFontColor: TColor read FCabinetFontColor write FCabinetFontColor;
		property CabinetBackColor: TColor read FCabinetBackColor write FCabinetBackColor;

		property ListFontName: string read FListFontName write FListFontName;
		property ListFontSize: Integer read FListFontSize write FListFontSize;
		property ListFontBold: Boolean read FListFontBold write FListFontBold;
		property ListFontItalic: Boolean read FListFontItalic write FListFontItalic;
		property ListFontColor: TColor read FListFontColor write FListFontColor;
		property ListBackColor: TColor read FListBackColor write FListBackColor;

		property MessageFontName: string read FMessageFontName write FMessageFontName;
		property MessageFontSize: Integer read FMessageFontSize write FMessageFontSize;
		property MessageFontBold: Boolean read FMessageFontBold write FMessageFontBold;
		property MessageFontItalic: Boolean read FMessageFontItalic write FMessageFontItalic;
		property MessageFontColor: TColor read FMessageFontColor write FMessageFontColor;
		property MessageBackColor: TColor read FMessageBackColor write FMessageBackColor;

		property BrowserFontName: string read FBrowserFontName write FBrowserFontName;
		property BrowserFontSize: Integer read FBrowserFontSize write FBrowserFontSize;
		property BrowserFontBold: Integer read FBrowserFontBold write FBrowserFontBold;
		property BrowserFontItalic: Integer read FBrowserFontItalic write FBrowserFontItalic;
		property BrowserFontColor: Integer read FBrowserFontColor write FBrowserFontColor;
		property BrowserBackColor: Integer read FBrowserBackColor write FBrowserBackColor;

		property EditorFontName: string read FEditorFontName write FEditorFontName;
		property EditorFontSize: Integer read FEditorFontSize write FEditorFontSize;
		property EditorFontBold: Boolean read FEditorFontBold write FEditorFontBold;
		property EditorFontItalic: Boolean read FEditorFontItalic write FEditorFontItalic;
		property EditorFontColor: TColor read FEditorFontColor write FEditorFontColor;
		property EditorBackColor: TColor read FEditorBackColor write FEditorBackColor;

		property BrowserTabFontName: string read FBrowserTabFontName write FBrowserTabFontName;
		property BrowserTabFontSize: Integer read FBrowserTabFontSize write FBrowserTabFontSize;
		property BrowserTabFontBold: Boolean read FBrowserTabFontBold write FBrowserTabFontBold;
		property BrowserTabFontItalic: Boolean read FBrowserTabFontItalic write FBrowserTabFontItalic;

		property HintFontName: string read FHintFontName write FHintFontName;
		property HintFontSize: Integer read FHintFontSize write FHintFontSize;
		//property HintFontBold: Boolean read FHintFontBold write FHintFontBold;
		//property HintFontItalic: Boolean read FHintFontItalic write FHintFontItalic;
		property HintFontColor: TColor read FHintFontColor write FHintFontColor;
		property HintBackColor: TColor read FHintBackColor write FHintBackColor;

		property WindowTop: Integer read FWindowTop write FWindowTop;
		property WindowLeft: Integer read FWindowLeft write FWindowLeft;
		property WindowHeight: Integer read FWindowHeight write FWindowHeight;
		property WindowWidth: Integer read FWindowWidth write FWindowWidth;
		property WindowMax: Boolean read FWindowMax write FWindowMax;
		property ListStyle: TViewStyle read FListStyle write FListStyle;

		property StdToolBarVisible: Boolean read FStdToolBarVisible write FStdToolBarVisible;
		property AddressBarVisible: Boolean read FAddressBarVisible write FAddressBarVisible;
		property LinkBarVisible: Boolean read FLinkBarVisible write FLinkBarVisible;
		property ListToolBarVisible: Boolean read FListToolBarVisible write FListToolBarVisible;
		property ListNameBarVisible: Boolean read FListNameBarVisible write FListNameBarVisible;
		property BrowserToolBarVisible: Boolean read FBrowserToolBarVisible write FBrowserToolBarVisible;
		property BrowserNameBarVisible: Boolean read FBrowserNameBarVisible write FBrowserNameBarVisible;

		property BrowserTabVisible: Boolean read FBrowserTabVisible write FBrowserTabVisible;
		property BrowserTabPosition: TGikoTabPosition read FBrowserTabPosition write FBrowserTabPosition;
		property BrowserTabAppend: TGikoTabAppend read FBrowserTabAppend write FBrowserTabAppend;
		property BrowserTabStyle: TGikoTabStyle read FBrowserTabStyle write FBrowserTabStyle;

		property MessageBarVisible: Boolean read FMessageBarVisible write FMessageBarVisible;
		property MessegeBarHeight: Integer read FMessegeBarHeight write FMessegeBarHeight;

		property StatusBarVisible: Boolean read FStatusBarVisible write FStatusBarVisible;

		property CabinetVisible: Boolean read FCabinetVisible write FCabinetVisible;
		property CabinetWidth: Integer read FCabinetWidth write FCabinetWidth;

		property ListOrientation: TGikoListOrientation read FListOrientation write FListOrientation;
		property ListHeight: Integer read FListHeight write FListHeight;
		property ListHeightState: TGikoListState read FListHeightState write FListHeightState;
		property ListWidth: Integer read FListWidth write FListWidth;
		property ListWidthState: TGikoListState read FListWidthState write FListWidthState;
//		property ListHeightMax: Boolean read FListHeightMax write FListHeightMax;
//		property ListWidthMax: Boolean read FListWidthMax write FListWidthMax;

		property NameList: TStringList read FNameList write FNameList;
		property MailList: TStringList read FMailList write FMailList;
		property SelectTextList: TStringList read FSelectTextList write FSelectTextList;

		property EditWindowTop: Integer read FEditWindowTop write FEditWindowTop;
		property EditWindowLeft: Integer read FEditWindowLeft write FEditWindowLeft;
		property EditWindowHeight: Integer read FEditWindowHeight write FEditWindowHeight;
		property EditWindowWidth: Integer read FEditWindowWidth write FEditWindowWidth;
		property EditWindowMax: Boolean read FEditWindowMax write FEditWindowMax;
		property EditWindowStay: Boolean read FEditWindowStay write FEditWindowStay;
		property EditWindowTranslucent: Boolean read FEditWindowTranslucent write FEditWindowTranslucent;

		property ListViewNo: Boolean read FListViewNo write FListViewNo;
		property UseCSS: Boolean read FUseCSS write SetUseCSS;
		property CSSFileName: string read GetCSSFileName write SetCSSFileName;
		property UseKatjushaType : Boolean read FUseKatjushaType write FUseKatjushaType;
		property UseSkin: Boolean read FUseSkin;

		property ShowMail: Boolean read FShowMail write FShowMail;
		property ResRange : Longint read FResRange write FResRange;
		property ResRangeHold : Boolean read FResRangeHold write FResRangeHold;
		property ThreadRange	: TGikoThreadRange read FThreadRange write FThreadRange;
		property UnActivePopup: Boolean read FUnActivePopup write FUnActivePopup;
		property ResPopupHeaderBold: Boolean read FResPopupHeaderBold write FResPopupHeaderBold;
		property IconImageDisplay: Boolean read FIconImageDisplay write FIconImageDisplay;
		property ThreadTitleTrim: Boolean read FThreadTitleTrim write FThreadTitleTrim;

		property LogFolder: string read FLogFolder write WriteLogFolder;
		property LogFolderP: string read FLogFolderP;
		property NewLogFolder: string read FNewLogFolder write FNewLogFolder;

		property BBSColumnWidth[index: Integer]: Integer read GetBBSColumnWidth write SetBBSColumnWidth;
		property CategoryColumnWidth[index: Integer]: Integer read GetCategoryColumnWidth write SetCategoryColumnWidth;
		property BoardColumnWidth[index: Integer]: Integer read GetBoardColumnWidth write SetBoardColumnWidth;

		property BBSColumnOrder : TGikoBBSColumnList read FBBSColumnOrder write FBBSColumnOrder;
		property CategoryColumnOrder : TGikoCategoryColumnList read FCategoryColumnOrder write FCategoryColumnOrder;
		property BoardColumnOrder : TGikoBoardColumnList read FBoardColumnOrder write FBoardColumnOrder;

		property SoundName[index: Integer]: string read GetSoundName;
		property SoundViewName[index: Integer]: string read GetSoundViewName;
		property SoundFileName[index: Integer]: string read GetSoundFileName write SetSoundFileName;

		property BBSSortIndex: Integer read FBBSSortIndex write FBBSSortIndex;
		property BBSSortOrder: Boolean read FBBSSortOrder write FBBSSortOrder;
		property CategorySortIndex: Integer read FCategorySortIndex write FCategorySortIndex;
		property CategorySortOrder: Boolean read FCategorySortOrder write FCategorySortOrder;
		property BoardSortIndex: Integer read FBoardSortIndex write FBoardSortIndex;
		property BoardSortOrder: Boolean read FBoardSortOrder write FBoardSortOrder;

		property DatOchiSortIndex: Integer read FDatOchiSortIndex write FDatOchiSortIndex;
		property DatOchiSortOrder: Boolean read FDatOchiSortOrder write FDatOchiSortOrder;

		//property BoardURL2ch: string read FBoardURL2ch write FBoardURL2ch;
		property BoardURLs: TStringList read FBoardURLs write FBoardURLs;
		property BoardURLSelected: Integer read FBoardURLSelected write FBoardURLSelected;
		property UserID: string read FUserID write FUserID;
		property Password: string read FPassword write FPassword;
		property AutoLogin: Boolean read FAutoLogin write FAutoLogin;
		property ForcedLogin: Boolean read FForcedLogin write FForcedLogin;
//		property DolibURL: string read FDolibURL write FDolibURL;
    property UAVersion: Integer read FUAVersion write FUAVersion;

		property URLApp: Boolean read FURLApp write FURLApp;
		property URLAppFile: string read FURLAppFile write FURLAppFile;

		property OpenMailer: Boolean read FOpenMailer write FOpenMailer;

		property DeleteMsg: Boolean read FDeleteMsg write FDeleteMsg;

		property MainCoolSet[Index: Integer]: TCoolSet read GetMainCoolSet write SetMainCoolSet;
		property ListCoolSet[Index: Integer]: TCoolSet read GetBoardCoolSet write SetBoardCoolSet;
		property BrowserCoolSet[Index: Integer]: TCoolSet read GetBrowserCoolSet write SetBrowserCoolSet;

		property ListToolBarWrapable: Boolean read FListToolBarWrapable write FListToolBarWrapable;
		property BrowserToolBarWrapable: Boolean read FBrowserToolBarWrapable write FBrowserToolBarWrapable;

		property PopupPosition: TGikoPopupPosition read FPopupPosition write FPopupPosition;

		property URLDisplay: Boolean read FURLDisplay write FURLDisplay;
		property AddressBarTabStop: Boolean read FAddressBarTabStop write FAddressBarTabStop;
		property LinkAddAddressBar: Boolean read FLinkAddAddressBar write FLinkAddAddressBar;
		property AddressHistoryCount: Integer read FAddressHistoryCount write FAddressHistoryCount;

		property PreviewVisible: Boolean read FPreviewVisible write FPreviewVisible;
		property PreviewSize: TGikoPreviewSize read FPreviewSize write FPreviewSize;
		property PreviewWait: Integer read FPreviewWait write FPreviewWait;
		property BrowserAutoMaximize: TGikoBrowserAutoMaximize read FBrowserAutoMaximize write FBrowserAutoMaximize;

		property ListIconVisible: Boolean read FListIconVisible write FListIconVisible;
		property CreationTimeLogs: Boolean read FCreationTimeLogs write FCreationTimeLogs;
		property FutureThread: Boolean read FFutureThread write FFutureThread;

		property UseMachineTime: Boolean read FUseMachineTime write FUseMachineTime;
		property TimeAdjustSec: Integer read FTimeAdjustSec write FTimeAdjustSec;
		property TimeAdjust: Boolean read FTimeAdjust write FTimeAdjust;

		//���ځ`��
		property AbonDeleterlo : Boolean read FAbonDeleterlo write FAbonDeleterlo;
		property AbonReplaceul : Boolean read FAbonReplaceul write FAbonReplaceul;
		property PopUpAbon		 : Boolean read FPopUpAbon write FPopUpAbon;
		property ShowNGLinesNum : Boolean read FShowNGLinesNum write FShowNGLinesNum;
		property AddResAnchor : Boolean read FAddResAnchor write FAddResAnchor;
		property DeleteSyria : Boolean read FDeleteSyria write FDeleteSyria;
		property IgnoreKana : Boolean read FIgnoreKana write FIgnoreKana;
    property KeepNgFile : Boolean read FKeepNgFile write FKeepNgFile;

		//NG���[�h�ҏW
		property NGTextEditor: Boolean read FNGTextEditor write FNGTextEditor;
		property NGWindowTop: Integer read FNGWindowTop write FNGWindowTop;
		property NGWindowLeft: Integer read FNGWindowLeft write FNGWindowLeft;
		property NGWindowHeight: Integer read FNGWindowHeight write FNGWindowHeight;
		property NGWindowWidth: Integer read FNGWindowWidth write FNGWindowWidth;
		property NGWindowMax: Boolean read FNGWindowMax write FNGWindowMax;

		// �X���b�h�i���t�B�[���h�̕�
		property SelectComboBoxWidth : Integer read FSelectComboBoxWidth write FSelectComboBoxWidth;

		// �Ō�ɑI�����ꂽ�I�v�V�����_�C�A���O�̃^�u
		property OptionDialogTabIndex : Integer read FOptionDialogTabIndex write FOptionDialogTabIndex;

		// �Ō�ɑI�����ꂽ�L���r�l�b�g
		property CabinetIndex : Integer read FCabinetIndex write FCabinetIndex;

		//�I�����Ɋm�F�_�C�A���O��\�����邩
		property ShowDialogForEnd : Boolean read FShowDialogForEnd write FShowDialogForEnd;
		property ShowDialogForAllTabClose: Boolean read FShowDialogForAllTabClose write FShowDialogForAllTabClose;
		//�擾���X���ƃX���b�h�̃��X�����قȂ����Ƃ��ɒʏ�w�i�F�ƈ�����F�̔w�i�F���g�p���邩
		property UseOddColorOddResNum: Boolean read FUseOddColorOddResNum write FUseOddColorOddResNum;
		property OddColor: TColor read FOddColor write FOddColor;
		property UnFocusedBold : Boolean read FUnFocusedBold write FUnFocusedBold;
		//�G�f�B�^�e�L�X�g�̃t�H���g�ݒ����\���ɂ��g�p���邩
		property SetBoardInfoStyle: Boolean read FSetBoardInfoStyle write FSetBoardInfoStyle;
		property UseSamba: Boolean read FUseSamba write FUseSamba;
		property ResAnchorJamp: Boolean read FResAnchorJamp write FResAnchorJamp;

		// �G�f�B�^
		property SpaceToNBSP	: Boolean	read FSpaceToNBSP		write FSpaceToNBSP;
		property AmpToCharRef	: Boolean	read FAmpToCharRef	write FAmpToCharRef;

		property SelectInterval	: Integer	read FSelectInterval	write FSelectInterval;
		//Tab�ۑ�
		property TabAutoLoadSave: Boolean           read FTabAutoLoadSave      write FTabAutoLoadSave;
    //�^�u�̕����Ƃ��p
    property LastCloseTabURL: String read FLastCloseTabURL write FLastCloseTabURL;
    //property Gengo: TStringList read F2chLanguage write F2chLanguage;
    property GengoSupport : Boolean read F2chSupport write F2chSupport;
		property KuroutSettingTabIndex: Integer read FKuroutSettingTabIndex write FKuroutSettingTabIndex;
		//! �}�E�X�W�F�X�`���[
		property Gestures : TGestureModel read FGestures write FGestures;
		//! �}�E�X�W�F�X�`���[���g�p���邩�ǂ���
		property GestureEnabled : Boolean read FGestureEnabled write FGestureEnabled;
        property GestureIgnoreContext : Boolean read FGestureIgnoreContext write FGestureIgnoreContext;
		//�t�V�A�i�g���b�v�ݒ�
		property LocalTrapAtt : Boolean read FLocalTrapAtt write FLocalTrapAtt;
		property RemoteTrapAtt : Boolean read FRemoteTrapAtt write FRemoteTrapAtt;
		property ReadTimeOut: Integer read FReadTimeOut write FReadTimeOut;
		//! �g�p����X�p���t�B���^
		property SpamFilterAlgorithm : TGikoSpamFilterAlgorithm
			read FSpamFilterAlgorithm write FSpamFilterAlgorithm;
		property Mute: Boolean read FMute write FMute;
		property UseUndecided: Boolean read FUseUndecided write FUseUndecided;

		property BeUserID: string read FBeUserID write FBeUserID;
		property BePassword: string read FBePassword write FBePassword;
		property BeAutoLogin: Boolean read FBeAutoLogin write FBeAutoLogin;
		property BeLogin: Boolean read FBeLogin write FBeLogin;
		property MaxRecordCount : Integer read FMaxRecordCount write FMaxRecordCount;
		//! �X���b�h�ꗗ�_�E�����[�h��ɃX���b�h���ŏ����\�[�g���邩
		property AutoSortThreadList : Boolean read FAutoSortThreadList write FAutoSortThreadList;
		//! InputAssist�t�H�[���̈ʒu
		property InputAssistFormLeft :Integer read FInputAssistFormLeft write FInputAssistFormLeft;
		property InputAssistFormTop :Integer read FInputAssistFormTop write FInputAssistFormTop;
		//! InputAssist�t�H�[���̃T�C�Y
		property InputAssistFormWidth: Integer read FInputAssistFormWidth write FInputAssistFormWidth;
		property InputAssistFormHeight: Integer read FInputAssistFormHeight write FInputAssistFormHeight;
		//! Cookie�ɕt������Œ�R�[�h
		property FixedCookie: String read FFixedCookie write FFixedCookie;
    //! �����N�ړ������̕ێ���
    property MoveHistorySize : Integer read FMoveHistorySize write SetMoveHistorySize;
    //! �ŏ������Ƀ^�X�N�g���C�Ɋi�[���邩
    property StoredTaskTray : Boolean read FStoredTaskTray write FStoredTaskTray;
    //! �u���E�U�^�u�̃��[�v��������
    property LoopBrowserTabs : Boolean read FLoopBrowserTabs write FLoopBrowserTabs;
    //! 100���X�\���̐擪�\�����X��
    property HeadResCount : Integer read FHeadResCount write FHeadResCount;
    //! 100���X�\�����i�g���p�j
    property ResRangeExCount: Integer read FResRangeExCount write FResRangeExCount;
    //! �֘A�L�[���[�h�ǉ��t���O
    property AddKeywordLink: Boolean read FAddKeywordLink write FAddKeywordLink;
    //! dat�̒u����L���ɂ��邩
    property ReplaceDat: Boolean read FReplaceDat write FReplaceDat;
    //! sent.ini�t�@�C���̃T�C�Y�i�P��MB�j
    property SentIniFileSize: Integer read FSentIniFileSize write FSentIniFileSize;
    //! �����NURL�擾�̑Ώۊg���q
    property ExtList: String read FExtList write FExtList;
    //! Skin�t�@�C���Ǘ�
    property SkinFiles: TSkinFiles read FSkinFiles;
    //! �C���f�b�N�X�ǂݍ��ݎ�dat�t�@�C���`�F�b�N
    property CheckDatFile: Boolean read FCheckDatFile write FCheckDatFile;
    property LimitResCountMessage: Boolean read FLimitResCountMessage write FLimitResCountMessage;
    //! ���X�|�b�v�A�b�v�\���ʒudeltaX
    property  RespopupDeltaX: Integer read FRespopupDeltaX write FRespopupDeltaX;
    //! ���X�|�b�v�A�b�v�\���ʒudeltaY
    property RespopupDeltaY: Integer read FRespopupDeltaY write FRespopupDeltaY;
    //! ���X�|�b�v�A�b�v�^�C�}�[
    property RespopupWait: Integer read FRespopupWait write FRespopupWait;
    property RespopupMailTo: Boolean read FRespopupMailTo write FRespopupMailTo;
    //! �딚�`�F�b�N
    property UseGobakuCheck: Boolean read FUseGobakuCheck write FUseGobakuCheck;
    //! Unicode�ŃG�f�B�^
    property UseUnicode: Boolean read FUseUnicode write FUseUnicode;
    //! �v���r���[�\����CSS�܂��̓X�L����K�p����
    property PreviewStyle: Boolean read FPreviewStyle write FPreviewStyle;
    //! ���G�`���i�摜�Y�t�j��L���ɂ���
    property Oekaki: Boolean read FOekaki write FOekaki;
    //! �폜�v������ʈ���
    property SakuBoard: Boolean read FSakuBoard write FSakuBoard;
		//! �X���^�C�����E�B���h�E
		//! �X���^�C�����E�B���h�E
		property ThrdSrchTop: Integer read FThrdSrchTop write FThrdSrchTop;
		property ThrdSrchLeft: Integer read FThrdSrchLeft write FThrdSrchLeft;
		property ThrdSrchWidth: Integer read FThrdSrchWidth write FThrdSrchWidth;
		property ThrdSrchHeight: Integer read FThrdSrchHeight write FThrdSrchHeight;
		property ThrdSrchMax: Boolean read FThrdSrchMax write FThrdSrchMax;
    property ThrdSrchStay: Boolean read FThrdSrchStay write FThrdSrchStay;
    property ThrdSrchCol1W: Integer read FThrdSrchCol1W write FThrdSrchCol1W;
    property ThrdSrchCol2W: Integer read FThrdSrchCol2W write FThrdSrchCol2W;
    property ThrdSrchCol3W: Integer read FThrdSrchCol3W write FThrdSrchCol3W;
    property ThrdSrchCol4W: Integer read FThrdSrchCol4W write FThrdSrchCol4W;
    property ThrdSrchHistory: TStringList read FThrdSrchHistory write FThrdSrchHistory;
    //! �`���̏�
    property BoukenCookieList: TStringList read FBoukenCookieList write FBoukenCookieList;
		//! �ǂ񂮂�V�X�e���E�B���h�E
		property DonguriTop: Integer read FDonguriTop write FDonguriTop;
		property DonguriLeft: Integer read FDonguriLeft write FDonguriLeft;
		property DonguriWidth: Integer read FDonguriWidth write FDonguriWidth;
		property DonguriHeight: Integer read FDonguriHeight write FDonguriHeight;
		property DonguriStay: Boolean read FDonguriStay write FDonguriStay;
    property DonguriTheme: Integer read FDonguriTheme write FDonguriTheme;
    property DonguriTaskBar: Boolean read FDonguriTaskBar write FDonguriTaskBar;
		//! �ǂ񂮂�֘A
    property DonguriMenuTop: Boolean read FDonguriMenuTop write FDonguriMenuTop;
	end;


const
//	MAIN_COOLBAND_COUNT = 4;		//���C��CoolBand�̐�
//	LIST_COOLBAND_COUNT = 2;		//��CoolBand�̐�
//	BROWSER_COOLBAND_COUNT = 3;	//�u���E�UCoolBand�̐�

	BOARD_FILE_NAME							 	= 'board.2ch';
	CUSTOMBOARD_FILE_NAME				 	= 'custom.2ch';
	BOARD_DIR_NAME								= 'Board';
	KEY_SETTING_FILE_NAME				 	= 'key.ini';
	EKEY_SETTING_FILE_NAME			 	= 'Ekey.ini';
	TEMP_FOLDER									 	= 'Temp';
	OUTBOX_FILE_NAME							= 'outbox.ini';
	SENT_FILE_NAME								= 'sent.ini';
	DEFFILES_FILE_NAME						= 'defaultFiles.ini';
	CONFIG_DIR_NAME							 	= 'config';
	CSS_DIR_NAME									= 'css';
	SKIN_DIR_NAME							 		= 'skin';
	NGWORDs_DIR_NAME:      String = 'NGwords';
	BOARD_PLUGIN_DIR_NAME					= 'BoardPlugin';
	SAMBATIME_FILE_NAME:   String = 'Samba.ini';
	IGNORE_FILE_NAME:      String = 'Ignore.txt';
//	DOLIB_LOGIN_URL     = '/~tora3n2c/futen.cgi';
	MAX_POPUP_RES:        Integer = 10;
	GESTURE_FILE_NAME							= 'Gestures.ini';
	SPAMFILTER_FILE_NAME					= 'SpamFilter.ini';
	LANGUAGE_FILE_NAME            = 'language.ini';
	INPUTASSIST_FILE_NAME         = 'InputAssist.ini';
  FIXED_COOKIE                  = '';
  REPLACE_FILE_NAME             = 'replace.ini';
  EXT_PREVIEW_FILE_NAME         = 'extpreview.ini';

implementation

uses
	Math, UCryptAuto, UBase64, Windows,GikoUtil;

type
	TSoundName = record
		Name: string;
		ViewName: string;
		FileName: string;
	end;

const
	INI_FILE_NAME:           string = 'gikoNavi.ini';
	BOARD_URL_INI_FILE_NAME: string = 'url.ini';
	DEFAULT_FONT_NAME:       string = '�l�r �o�S�V�b�N';
	DEFAULT_FONT_SIZE:      Integer = 9;
	DEFAULT_FONT_COLOR:      string = 'clWindowText';
	DEFAULT_WINDOW_COLOR:    string = 'clWindow';
	DEFAULT_TAB_FONT_NAME:   string = '�l�r �o�S�V�b�N';
	DEFAULT_TAB_FONT_SIZE:  Integer = 9;
	DEFAULT_2CH_BOARD_URL1:  string = 'https://menu.5ch.net/bbsmenu.html';
	GIKO_ENCRYPT_TEXT:       string = 'gikoNaviEncryptText';

  // IPv6�Őڑ����Ȃ��h���C��
  DEFAULT_IPV4_DOMAIN: array [0..4] of string = (
  	'flounder.s27.xrea.com',	// ������M�R�i�r��
    'be.5ch.net',							// be���O�C���z�X�g
    'shitaraba.com',					// �������JBBS
    'shitaraba.net',					// �������JBBS
    'machi.to'                // �܂�BBS
  );

var
	SOUND_NAME: array[0..4] of TSoundName = (
		(Name: 'New';				ViewName: '�擾����';					 FileName: ''),
		(Name: 'NewDiff';		ViewName: '�擾����(����)';		 FileName: ''),
		(Name: 'NoChange';	 ViewName: '���X�V';						 FileName: ''),
//		(Name: 'RoundEnd';	 ViewName: '����I��(�擾����)'; FileName: ''),
//		(Name: 'RoundNone';	ViewName: '����I��(�擾�Ȃ�)'; FileName: ''),
		(Name: 'ResEnd';		 ViewName: '���X���M����';			 FileName: ''),
		(Name: 'Error';			ViewName: '�G���[';						 FileName: ''));

constructor TGikoBBSColumnList.Create;
begin
	inherited;
end;

destructor TGikoBBSColumnList.Destroy;
begin
	inherited;
end;

function TGikoBBSColumnList.GetItem( index : integer ) : TGikoBBSColumnID;
begin
	Result := TGikoBBSColumnID( inherited Items[ index ] );
end;

procedure TGikoBBSColumnList.SetItem( index : integer; value : TGikoBBSColumnID);
begin
	inherited Items[ index ] := Pointer( value );
end;

function TGikoBBSColumnList.Add( value : TGikoBBSColumnID ) : Integer;
begin
	Result := inherited Add( Pointer( value ) );
end;

constructor TGikoCategoryColumnList.Create;
begin
	inherited;
end;

destructor TGikoCategoryColumnList.Destroy;
begin
	inherited;
end;

function TGikoCategoryColumnList.GetItem( index : integer ) : TGikoCategoryColumnID;
begin
	Result := TGikoCategoryColumnID( inherited Items[ index ] );
end;

procedure TGikoCategoryColumnList.SetItem( index : integer; value : TGikoCategoryColumnID);
begin
	inherited Items[ index ] := Pointer( value );
end;

function TGikoCategoryColumnList.Add( value : TGikoCategoryColumnID ) : Integer;
begin
	Result := inherited Add( Pointer( value ) );
end;

constructor TGikoBoardColumnList.Create;
begin
	inherited;
end;

destructor TGikoBoardColumnList.Destroy;
begin
	inherited;
end;

function TGikoBoardColumnList.GetItem( index : integer ) : TGikoBoardColumnID;
begin
	Result := TGikoBoardColumnID( inherited Items[ index ] );
end;

procedure TGikoBoardColumnList.SetItem( index : integer; value : TGikoBoardColumnID);
begin
	inherited Items[ index ] := Pointer( value );
end;

function TGikoBoardColumnList.Add( value : TGikoBoardColumnID ) : Integer;
begin
	Result := inherited Add( Pointer( value ) );
end;

//�R���X�g���N�^
constructor TSetting.Create();
begin
	FNameList := TStringList.Create;
	FMailList := TStringList.Create;
	FSelectTextList := TStringList.Create;
	FBoardURLs := TStringList.Create;
	FBBSColumnOrder := TGikoBBSColumnList.Create;
	FCategoryColumnOrder := TGikoCategoryColumnList.Create;
	FBoardColumnOrder := TGikoBoardColumnList.Create;
	FGestures := TGestureModel.Create;
	FSkinFiles := TSkinFiles.Create;
	FNameList.Duplicates := dupIgnore;
	FMailList.Duplicates := dupIgnore;
	FBoardURLs.Duplicates := dupIgnore;
	FSelectTextList.Duplicates := dupIgnore;
  FThrdSrchHistory := TStringList.Create;
  FBoukenCookieList := TStringList.Create;
	FIPv4List := TStringList.Create;
	ReadSettingFile();
	ReadBoardURLsFile();
end;

//�f�X�g���N�^
destructor TSetting.Destroy();
begin
  FThrdSrchHistory.Free;
  FBoukenCookieList.Free;
 	FBoardColumnOrder.Free;
 	FCategoryColumnOrder.Free;
 	FBBSColumnOrder.Free;
 	FSelectTextList.Free;
 	FBoardURLs.Free;
 	FMailList.Free;
 	FNameList.Free;
 	FGestures.Free;
	FSkinFiles.Free;
	FIPv4List.Free;
	inherited;
end;

//�������t�@�C�����擾�i�p�X�{�t�@�C�����j
function TSetting.GetFileName(): string;
begin
	Result := GetAppDir + INI_FILE_NAME;
end;

//�X�V�pURL�ݒ�t�@�C�����i�p�X�{�t�@�C�����j
function TSetting.GetBoardURLFileName(): string;
begin
	Result := GetAppDir + BOARD_URL_INI_FILE_NAME;
end;

//�ݒ�t�@�C���Ǎ�
procedure TSetting.ReadSettingFile();
var
	ini: TMemIniFile;
	i: Integer;
	Exists: Boolean;
	s: string;
	CoolSet: TCoolSet;
  msg: String;
  hostList: TStringList;
  Cnt: Integer;
  key: String;
begin
	Exists := FileExists(GetFileName);
	ini := TMemIniFile.Create(GetFileName);
	try
		//��M�o�b�t�@�T�C�Y
		//FRecvBufferSize := ini.ReadInteger('HTTP', 'RecvBufferSize', 4096);
		//HTTP1.1�g�p
		FProtocol := ini.ReadBool('HTTP', 'Protocol', True);
		//�v���L�V�ڑ�HTTP1.1�g�p
		FProxyProtocol := ini.ReadBool('HTTP', 'ProxyProtocol', False);
  	// IPv6
    FIPv6 := ini.ReadBool('HTTP', 'IPv6', False);
    Cnt := ini.ReadInteger('HTTP', 'IPv4DomainCount', -9999);
    if Cnt = -9999 then begin
    	for i := Low(DEFAULT_IPV4_DOMAIN) to High(DEFAULT_IPV4_DOMAIN) do
	    	FIpv4List.Add(DEFAULT_IPV4_DOMAIN[i]);
    end else begin
      for i := 1 to Cnt do begin
        key := Format('IPv4Domain%d', [i]);
        s := Trim(ini.ReadString('HTTP', key, ''));
        if s <> '' then
          FIpv4List.Add(s);
      end;
    end;


    // �v���L�V�ݒ�ǂݍ���
    ReadProxySettings( ini );

    // �e��E�B���h�E�̐ݒ�ǂݍ���
    ReadWindowSettings( ini );

		FWindowTop := ini.ReadInteger('WindowSize', 'Top', -1);
		FWindowLeft := ini.ReadInteger('WindowSize', 'Left', -1);
		FWindowHeight := ini.ReadInteger('WindowSize', 'Height', -1);
		FWindowWidth := ini.ReadInteger('WindowSize', 'Width', -1);
		FWindowMax := ini.ReadBool('WindowSize', 'Max', false);

		if FWindowHeight <= 0 then	FWindowHeight := 400;
		if FWindowWidth <= 0 then FWindowWidth := 600;

		FListStyle := TViewStyle(ini.ReadInteger('ViewStyle', 'ListView', Ord(vsReport)));

		FEditWindowTop := ini.ReadInteger('EditorWindowSize', 'Top', -1);
		FEditWindowLeft := ini.ReadInteger('EditorWindowSize', 'Left', -1);
		FEditWindowHeight := ini.ReadInteger('EditorWindowSize', 'Height', -1);
		FEditWindowWidth := ini.ReadInteger('EditorWindowSize', 'Width', -1);
		FEditWindowMax := ini.ReadBool('EditorWindowSize', 'Max', False);
		FEditWindowStay := ini.ReadBool('EditorWindowSize', 'Stay', False);
                FEditWindowTranslucent := ini.ReadBool('EditorWindowSize', 'Translucent', False);

		FOptionDialogTabIndex := ini.ReadInteger('OptionDialog', 'TabIndex', 0);

		//�c�[���o�[
		FStdToolBarVisible := ini.ReadBool('ToolBar', 'StdVisible', True);
		FAddressBarVisible := ini.ReadBool('ToolBar', 'AddressVisible', True);
		FLinkBarVisible := ini.ReadBool('ToolBar', 'LinkVisible', True);
		FListToolBarVisible := ini.ReadBool('ToolBar', 'ListVisible', True);
		FListNameBarVisible := ini.ReadBool('ToolBar', 'ListNameVisible', True);
		FBrowserToolBarVisible := ini.ReadBool('ToolBar', 'BrowserVisible', True);
		FBrowserNameBarVisible := ini.ReadBool('ToolBar', 'BrowserNameVisible', True);
		//�c�[���o�[Wrapable
		FListToolBarWrapable := ini.ReadBool('ToolBar', 'ListWrapable', False);
		FBrowserToolBarWrapable := ini.ReadBool('ToolBar', 'BrowserWrapable', False);

		FBrowserTabVisible := ini.ReadBool('Tab', 'BrowserTabVisible', True);
		FBrowserTabPosition := TGikoTabPosition(ini.ReadInteger('Tab', 'BrowserTabPosition', Ord(gtpTop)));
		FBrowserTabAppend := TGikoTabAppend(ini.ReadInteger('Tab', 'BrowserTabAppend', Ord(gtaFirst)));
		FBrowserTabStyle := TGikoTabStyle(ini.ReadInteger('Tab', 'BrowserTabStyle', Ord(gtsFlat)));

		FMessageBarVisible := ini.ReadBool('MessageBar', 'Visible', True);
		FMessegeBarHeight := ini.ReadInteger('MessageBar', 'Height', 30);

		FStatusBarVisible := ini.ReadBool('StatusBar', 'Visible', True);

		FCabinetVisible := ini.ReadBool('Cabinet', 'Visible', True);
		FCabinetWidth := ini.ReadInteger('Cabinet', 'Width', 200);
		FCabinetIndex := ini.ReadInteger('Cabinet', 'Index', 0);

		FListOrientation := TGikoListOrientation(ini.ReadInteger('List', 'Orientation', Ord(gloHorizontal)));
		FListHeight := ini.ReadInteger('List', 'Height', 180);
		FListHeightState := TGikoListState(ini.ReadInteger('List', 'HeightState', Ord(glsNormal)));
		FListWidth := ini.ReadInteger('List', 'Width', 180);
		FListWidthState := TGikoListState(ini.ReadInteger('List', 'WidthState', Ord(glsNormal)));
//		FListHeightMax := ini.ReadBool('List', 'HeightMax', False);
//		FListWidthMax := ini.ReadBool('List', 'WidthMax', False);

        // ���͍��ڂ̗�����ǂݍ���
        ReadInputHisotrys( ini );

		// ���X�g�J������
        ReadListColumnWidth( ini );

		// �J�e�S�����X�g�J��������
        ReadOrdColumn( ini );

		//���X�g�ԍ�
		FListViewNo := ini.ReadBool('Function', 'ListViewNo', True);
		//CSS
		UseCSS := ini.ReadBool('CSS', 'UseCSS', True);
		//CSS�t�@�C����
		CSSFileName := ini.ReadString('CSS', 'FileName', 'default.css');
		//������`����̃X�L�����g����
		FUseKatjushaType := ini.ReadBool('CSS', 'UseKatjushaType', false);

		//Mail���\��
		FShowMail := ini.ReadBool('Thread', 'ShowMail', True);
		// ���X�\���͈�
		if ini.ReadBool('Thread', 'OnlyAHundredRes',false) then
			FResRange := 100	// �Â��ݒ�̌݊��p
		else
			FResRange := ini.ReadInteger( 'Thread', 'ResRange', Ord( grrAll ) );
		FResRangeHold := ini.ReadBool( 'Thread', 'ResRangeHold', False );
        FHeadResCount := ini.ReadInteger('Thread', 'HeadResCount', 1);
        FResRangeExCount:= ini.ReadInteger('Thread','ResRangeExCount', 100);
		// �X���b�h�ꗗ�\���͈�
		FThreadRange := TGikoThreadRange( ini.ReadInteger('ThreadList', 'ThreadRange', Ord( gtrAll )) );
		//��A�N�e�B�u�����X�|�b�v�A�b�v�\��
		FUnActivePopup := ini.ReadBool('Thread', 'UnActivePopup', False);
		//���X�|�b�v�A�b�v�w�b�_�[�{�[���h
		FResPopupHeaderBold := ini.ReadBool('Thread', 'ResPopupHeaderBold', True);
        // BE�A�C�R���EEmoticon�摜�\��
        FIconImageDisplay := ini.ReadBool('Thread', 'IconImageDisplay', True);
        // �X���^�C���蕶���񏜋�
        FThreadTitleTrim := ini.ReadBool('Thread', 'ThreadTitleTrim', False);
		//�폜�m�F
		FDeleteMsg := ini.ReadBool('Function', 'LogDeleteMessage', True);
		//�I���m�F
		FShowDialogForEnd := ini.ReadBool('Function','ShowDialogForEnd',false);
		//AllTabClose
		FShowDialogForAllTabClose := ini.ReadBool('Function','ShowDialogForAllTabClose',false);
                //Samba
		FUseSamba := ini.ReadBool('Function','UseSamba', True);
		//ResAnchorjamp
		ResAnchorJamp := ini.ReadBool('Function', 'ResAnchoJamp', True);
		//���O�t�H���_
		LogFolder := ini.ReadString('Folder', 'LogFolder', GetAppDir + 'Log');
		NewLogFolder := '';

		//��URL
		//�����o�^�ł���悤�ɂ���FBoardURLs�ɂ����@2003/10/05
		//FBoardURL2ch := ini.ReadString('BoardURL', '2ch', DEFAULT_2CH_BOARD_URL);

		//�F�ؗp���[�UID�E�p�X���[�h
		FUserID := ini.ReadString('Attestation', 'UserID', '');
		FPassword := Decrypt(ini.ReadString('Attestation', 'Password', ''));
		FAutoLogin := ini.ReadBool('Attestation', 'AutoLogin', False);
		FForcedLogin := ini.ReadBool('Attestation', 'FForcedLogin', False);
//		FDolibURL	:= ini.ReadString('Attestation', 'FDolibURL', DOLIB_LOGIN_URL);
  	// User-Agent�o�[�W�����ԍ��Œ�
    FUAVersion := ini.ReadInteger('HTTP', 'UAVersion', 0);

		//URL�N���b�N���N���A�v��
		FURLApp := ini.ReadBool('URLApp', 'Select', False);
		FURLAppFile := ini.ReadString('URLApp', 'File', '');

		//mailto�N���b�N������
		FOpenMailer := ini.ReadBool('Mailto', 'Open', True);

		//�|�b�v�A�b�v�ʒu
		FPopupPosition := TGikoPopupPosition(ini.ReadInteger('Browser', 'PopupPosition', Ord(gppRightTop)));
        // �o�^56�ȑO����̃A�b�v�f�[�g�΍�
        if (FPopupPosition = gppCenter) then begin
            FPopupPosition := gppTop;
        end;
        FRespopupDeltaX := ini.ReadInteger('Browser', 'RespopupDelteX', 5);
        FRespopupDeltaY := ini.ReadInteger('Browser', 'RespopupDelteY', 5);
        FRespopupWait   := ini.ReadInteger('Browser', 'RespopupWait', 1000);
        FRespopupMailTo := ini.ReadBool('Browser', 'RespopupMailTo', true);

		//�A�h���X�o�[
		FURLDisplay := ini.ReadBool('AddressBar', 'URLDisplay', False);
		FAddressBarTabStop := ini.ReadBool('AddressBar', 'TabStop', True);
		FLinkAddAddressBar := ini.ReadBool('AddressBar', 'LinkAdd', False);
		FAddressHistoryCount := ini.ReadInteger('AddressBar', 'HistoryCount', 100);

		//�摜�v���r���[
		FPreviewVisible := ini.ReadBool('Browser', 'PreviewVisible', True);
		FPreviewSize := TGikoPreviewSize(ini.ReadInteger('Browser', 'PreviewSize', Ord(gpsMedium)));
		FPreviewWait := ini.ReadInteger('Browser', 'PreviewWait', 500);

		// �u���E�U
		FBrowserAutoMaximize := TGikoBrowserAutoMaximize(
			ini.ReadInteger('Window', 'BrowserAutoMaximize', Ord(gbmDoubleClick)) );

		//�X���b�h�ꗗ�X�V�A�C�R��
		FListIconVisible := ini.ReadBool('ThreadList', 'StateIconVisible', True);
		FCreationTimeLogs := ini.ReadBool('ThreadList', 'CreationTimeLogs', True);
		FFutureThread := ini.ReadBool('ThreadList', 'FutureThread', True);
		FSelectInterval := ini.ReadInteger('ThreadList', 'SelectInterval', 110);
		//�\�[�g��
		FBBSSortIndex := ini.ReadInteger('ThreadList', 'BBSSortIndex', 0);
		FBBSSortOrder := ini.ReadBool('ThreadList', 'BBSSortOrder', True);
		FCategorySortIndex := ini.ReadInteger('ThreadList', 'CategorySortIndex', 0);
		FCategorySortOrder := ini.ReadBool('ThreadList', 'CategorySortOrder', True);
		FBoardSortIndex := ini.ReadInteger('ThreadList', 'BoardSortIndex', 0);
		FBoardSortOrder := ini.ReadBool('ThreadList', 'BoardSortOrder', True);
		// DL��̎����\�[�g
		FAutoSortThreadList := ini.ReadBool('ThreadList', 'AutoSort', False);
		//Dat�����X���\�[�g��
		FDatOchiSortIndex := ini.ReadInteger('ThreadList', 'DatOchiSortIndex', -1);
		FDatOchiSortOrder := ini.ReadBool('ThreadList', 'DatOchiSortOrder', False);

		//�������ݎ��}�V�������g�p�ݒ�
		FUseMachineTime := ini.ReadBool('PostTime', 'UseMachineTime', False);
		FTimeAdjustSec := ini.ReadInteger('PostTime', 'TimeAdjustSec', 0);
		FTimeAdjust := ini.ReadBool('PostTime', 'TimeAdjust', True);

		//�T�E���h
		if Exists then begin
            SetCurrentDir(ExtractFilePath(Application.ExeName));
			for i := 0 to GetSoundCount - 1 do begin
				SoundFileName[i] := ini.ReadString('Sound', SoundName[i], '');
                // ���ΎQ�Ƒ΍�
                // �t�@�C���̑��݃`�F�b�N
                if not FileExists(ExpandFileName(SoundFileName[i])) then begin
                    SoundFileName[i] := '';
                end;
			end;
		end else begin
			s := 'Sound\';
			SoundFileName[0] := s + '�擾����.wav';
			SoundFileName[1] := s + '�擾����(����).wav';
			SoundFileName[2] := s + '���X�V.wav';
			SoundFileName[3] := '';
			SoundFileName[4] := s + '�G���[.wav';
		end;

		//�N�[���o�[
		for i := 0 to MAIN_COOLBAND_COUNT - 1 do begin
			CoolSet.FCoolID := ini.ReadInteger('MainCoolBar', 'ID' + IntToStr(i), -1);
			CoolSet.FCoolWidth := ini.ReadInteger('MainCoolBar', 'Width' + IntToStr(i), -1);
			CoolSet.FCoolBreak := ini.ReadBool('MainCoolBar', 'Break' + IntToStr(i), False);
    	if CoolSet.FCoolID = 3 then		// Shift-JI�ł��C�ɓ���c�[���o�[�i�����N�o�[�j
      	CoolSet.FCoolID := 4;				// Unicode�łɍ����ւ�
			MainCoolSet[i] := CoolSet;
		end;
		FSelectComboBoxWidth := ini.ReadInteger( 'ListCoolBar', 'SelectWidth', 127 );
		for i := 0 to LIST_COOLBAND_COUNT - 1 do begin
			CoolSet.FCoolID := ini.ReadInteger('ListCoolBar', 'ID' + IntToStr(i), -1);
			CoolSet.FCoolWidth := ini.ReadInteger('ListCoolBar', 'Width' + IntToStr(i), -1);
			CoolSet.FCoolBreak := ini.ReadBool('ListCoolBar', 'Break' + IntToStr(i), False);
			ListCoolSet[i] := CoolSet;
		end;
		for i := 0 to BROWSER_COOLBAND_COUNT - 1 do begin
			CoolSet.FCoolID := ini.ReadInteger('BrowserCoolBar', 'ID' + IntToStr(i), -1);
			CoolSet.FCoolWidth := ini.ReadInteger('BrowserCoolBar', 'Width' + IntToStr(i), -1);
			CoolSet.FCoolBreak := ini.ReadBool('BrowserCoolBar', 'Break' + IntToStr(i), False);
			BrowserCoolSet[i] := CoolSet;
		end;

		//���ځ`��
		FAbonDeleterlo := ini.ReadBool('Abon','Deleterlo',false);
		FAbonReplaceul := ini.ReadBool('Abon','Replaceul',false);
		FPopUpAbon		 := ini.ReadBool('Abon','Popup',false);
		FShowNGLinesNum := ini.ReadBool('Abon','ShowNGLines',false);
		FAddResAnchor := ini.ReadBool('Abon','AddResAnchor',false);
		FDeleteSyria :=  ini.ReadBool('Abon','DeleteSyria',false);
		FIgnoreKana  :=  ini.ReadBool('Abon','IgnoreKana',false);
    FKeepNgFile  :=  ini.ReadBool('Abon','KeepNgFile',false);

        //NG���[�h�ҏW
        FNGTextEditor   := ini.ReadBool('NGWordEditor', 'NGTextEditor', False);
		FNGWindowTop    := ini.ReadInteger('NGWordEditor', 'NGWindowTop', 100);
		FNGWindowLeft   := ini.ReadInteger('NGWordEditor', 'NGWindowLeft', 100);
		FNGWindowHeight := ini.ReadInteger('NGWordEditor', 'NGWindowHeight', 478);
		FNGWindowWidth  := ini.ReadInteger('NGWordEditor', 'NGWindowWidth', 845);
		FNGWindowMax    := ini.ReadBool('NGWordEditor', 'NGWindowMax', False);

		// �G�f�B�^
		FSpaceToNBSP	:= ini.ReadBool( 'Editor', 'SpaceToNBSP', False );
		FAmpToCharRef	:= ini.ReadBool( 'Editor', 'AmpToCharRef', False );
		FUseGobakuCheck := ini.ReadBool( 'Editor', 'UseGobakuCheck', True );
		FUseUnicode     := True;//ini.ReadBool( 'Editor', 'UseUnicode', False );
    FPreviewStyle   := ini.ReadBool( 'Editor', 'PreviewStyle', False );
    FOekaki         := ini.ReadBool( 'Editor', 'Oekaki', True );

		//Tab�����ۑ��A�ǂݍ���
		FTabAutoLoadSave    := ini.ReadBool('TabAuto', 'TabAutoLoadSave', False);
        FLastCloseTabURL    := ini.ReadString('Thread', 'LastCloseTabURL', '');
		FKuroutSettingTabIndex := ini.ReadInteger('OptionDialog', 'KuroutTabIndex' , 0);

		// �}�E�X�W�F�X�`���[
		FGestureEnabled := ini.ReadBool( 'Guesture', 'Enabled', False );
        FGestureIgnoreContext := ini.ReadBool( 'Guesture', 'IgnoreContext', False );
		//2ch����T�|
		F2chSupport := ini.ReadBool('2chSupport', 'Support', False);

		//FusianaTrap
		FLocalTrapAtt := ini.ReadBool('Trap', 'LocalTrap', False);
		FRemoteTrapAtt := ini.ReadBool('Trap', 'RemoteTrap', False);
		FReadTimeOut := ini.ReadInteger('HTTP', 'ReadTimeOut', 10000);

		// �g�p����X�p���t�B���^
		FSpamFilterAlgorithm := TGikoSpamFilterAlgorithm(
			ini.ReadInteger( 'Abon', 'SpamFilterAlgorithm', Ord( gsfaNone ) ) );
		FMute := ini.ReadBool('Function', 'Mute', false);
		FUseUndecided := ini.ReadBool('ThreadList', 'UseUndecided', False);

        //Be2ch
		//�F�ؗp���[�UID�E�F�؃R�[�h
		FBeUserID := ini.ReadString('Be', 'UserID', '');
		FBePassword := Decrypt(ini.ReadString('Be', 'Password', ''));
		FBeAutoLogin := ini.ReadBool('Be', 'AutoLogin', False);
		//�����̍ő�ۑ�����
		FMaxRecordCount := Max(ini.ReadInteger('Recode', 'Max', 100), 1);

        //! �폜�v������ʈ���
        FSakuBoard := ini.ReadBool('NewBoard', 'SakuSpecial', True);

		// ���̓A�V�X�g
		FInputAssistFormTop := ini.ReadInteger('IAtWindowsSize', 'Top', 0);
		FInputAssistFormLeft := ini.ReadInteger('IAtWindowsSize', 'Left', 0);
		FInputAssistFormWidth := ini.ReadInteger('IAtWindowsSize', 'Width', 400);
		FInputAssistFormHeight := ini.ReadInteger('IAtWindowsSize', 'Height', 460);

		//! �X���^�C�����E�B���h�E
		FThrdSrchTop    := ini.ReadInteger('ThreadSearch', 'Top',    0);
		FThrdSrchLeft   := ini.ReadInteger('ThreadSearch', 'Left',   0);
		FThrdSrchWidth  := ini.ReadInteger('ThreadSearch', 'Width',  526);
		FThrdSrchHeight := ini.ReadInteger('ThreadSearch', 'Height', 550);
		FThrdSrchMax    := ini.ReadBool(   'ThreadSearch', 'Max',    False);
        FThrdSrchStay   := ini.ReadBool(   'ThreadSearch', 'Stay',   False);
        FThrdSrchCol1W  := ini.ReadInteger('ThreadSearch', 'Col1W',  80);
        FThrdSrchCol2W  := ini.ReadInteger('ThreadSearch', 'Col2W',  350);
        FThrdSrchCol3W  := ini.ReadInteger('ThreadSearch', 'Col3W',  40);
        FThrdSrchCol4W  := ini.ReadInteger('ThreadSearch', 'Col4W',  500);
        Cnt := ini.ReadInteger('ThreadSearch', 'HistoryCount',  0);
        if (Cnt > 0) then begin
            for i := 1 to Cnt do begin
                s := ini.ReadString('ThreadSearch', 'History' + IntToStr(i), '');
                if (s <> '') then
                    FThrdSrchHistory.Add(s);
            end;
        end;

		//! �X���^�C�����E�B���h�E
		FDonguriTop    := ini.ReadInteger('DonguriSystem', 'Top',    0);
		FDonguriLeft   := ini.ReadInteger('DonguriSystem', 'Left',   0);
		FDonguriWidth  := ini.ReadInteger('DonguriSystem', 'Width',  296);
		FDonguriHeight := ini.ReadInteger('DonguriSystem', 'Height', 610);
		FDonguriStay   := ini.ReadBool(   'DonguriSystem', 'Stay',   False);
    FDonguriTheme  := ini.ReadInteger('DonguriSystem', 'Theme',  0);
    FDonguriTaskBar:= ini.ReadBool(   'DonguriSystem', 'TaskBar',False);
		//! �ǂ񂮂�֘A
    FDonguriMenuTop:= ini.ReadBool(   'Donguri',      'MenuTop', False);

		// Cookie�ɕt������Œ�R�[�h
		FFixedCookie := ini.ReadString('Cookie', 'fixedString', FIXED_COOKIE);

        // �����N�ړ������̍ő�ێ���
        FMoveHistorySize := ini.ReadInteger('MoveHisotry', 'Max', 20);

        FStoredTaskTray := ini.ReadBool('Function', 'StroedTaskTray', false);
        FLoopBrowserTabs := ini.ReadBool('Function', 'LoopBrowserTabs', false);
        FAddKeywordLink := ini.ReadBool('Thread', 'AddKeywordLink', false);
        if not (ini.ValueExists('Thread', 'ReplaceDat')) then begin
            msg := '�Z�L�����e�B�\�t�g�̌딽���΍�����܂����H'+ #13#10 +
                 '�i����:�͂��j'+ #13#10+'�ڍאݒ肩��ύX�ł��܂��B';
 		    if MsgBox(Application.Handle,
                 msg, '�M�R�i�r', MB_YESNO or MB_ICONQUESTION) = IDYES	then begin
                 FReplaceDat := True;
            end;
        end else begin
            FReplaceDat := ini.ReadBool('Thread', 'ReplaceDat', False);
        end;

        FSentIniFileSize := ini.ReadInteger('Function', 'SentIniFileSize', 3);
        FExtList := ini.ReadString('Function', 'ExtList', '*.gif;*.jpg;*.jpeg;*.png;*.zip;*.rar');

        FCheckDatFile := ini.ReadBool('ThreadList', 'CheckDatFile', True);
        FLimitResCountMessage := ini.ReadBool('Thread', 'LimitResCountMessage', True);

        // �`���̏�Cookie�ǂݍ���
        hostList := TStringList.Create;
        ini.ReadSection('Bouken', hostList);
        for i := 0 to hostList.Count - 1 do begin
            FBoukenCookieList.Add( hostList[i] + '=' +
                ini.ReadString('Bouken', hostList[i], '') );
        end;
        hostList.Free;

        // �M�R�i�r�X�V�ŗ��p�����C���X�g�[���̍폜
        s := ini.ReadString('Update', 'Remove0', '');
        if (FileExists(s)) then begin
            SysUtils.DeleteFile(s);
            // �폜�Ɏ��s���Ă���������
            ini.DeleteKey('Update', 'Remove0');
        end;

		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;
//�X�V�pURL�ǂݍ���
procedure TSetting.ReadBoardURLsFile();
var
	ini: TMemIniFile;
	urlNum: Integer;
	i : Integer;
begin
	if not FileExists(GetBoardURLFileName()) then
	MakeURLIniFile();
	ini := TMemIniFile.Create(GetBoardURLFileName());
	try
		urlNum := ini.ReadInteger('URL','count',0);
		BoardURLSelected := ini.ReadInteger('URL','selected',0);
		for i := 0 to urlNum - 1 do begin
			FBoardURLs.Append(ini.ReadString('URL',IntToStr(i+1),''));
		end;
	finally
		ini.Free;
	end;

end;
//�ݒ�t�@�C���ۑ�(system)
procedure TSetting.WriteSystemSettingFile();
var
	ini: TMemIniFile;
  i: Integer;
  key: String;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		//��M�o�b�t�@�T�C�Y
		//ini.WriteInteger('HTTP', 'RecvBufferSize', FRecvBufferSize);
		//HTTP1.1�g�p
		ini.WriteBool('HTTP', 'Protocol', FProtocol);
		//�v���L�V�ڑ�HTTP1.1�g�p
		ini.WriteBool('HTTP', 'ProxyProtocol', FProxyProtocol);
  	// IPv
    ini.WriteBool('HTTP', 'IPv6', IPv6);
    ini.WriteInteger('HTTP', 'IPv4DomainCount', FIpv4List.Count);
    for i := 1 to FIpv4List.Count do begin
    	key := Format('IPv4Domain%d', [i]);
    	if i <= FIpv4List.Count then
      	ini.WriteString('HTTP', key, FIPv4List[i-1])
    end;

		ini.WriteBool('ReadProxy', 'Proxy', FReadProxy);
		ini.WriteString('ReadProxy', 'Address', FReadProxyAddress);
		ini.WriteInteger('ReadProxy', 'Port', FReadProxyPort);
		ini.WriteString('ReadProxy', 'UserID', FReadProxyUserID);
		ini.WriteString('ReadProxy', 'Password', FReadProxyPassword);

		ini.WriteBool('WriteProxy', 'Proxy', FWriteProxy);
		ini.WriteString('WriteProxy', 'Address', FWriteProxyAddress);
		ini.WriteInteger('WriteProxy', 'Port', FWriteProxyPort);
		ini.WriteString('WriteProxy', 'UserID', FWriteProxyUserID);
		ini.WriteString('WriteProxy', 'Password', FWriteProxyPassword);

		ini.WriteString('Window', 'BrowserFontName', FBrowserFontName);
		ini.WriteInteger('Window', 'BrowserFontSize', FBrowserFontSize);
		ini.WriteInteger('Window', 'BrowserFontSize', FBrowserFontSize);
		ini.WriteInteger('Window', 'BrowserFontBold', FBrowserFontBold);
		ini.WriteInteger('Window', 'BrowserFontItalic', FBrowserFontItalic);
		ini.WriteInteger('Window', 'BrowserFontColor', FBrowserFontColor);
		ini.WriteInteger('Window', 'BrowserBackColor', FBrowserBackColor);

		ini.WriteString('Window', 'CabinetFontName', FCabinetFontName);
		ini.WriteInteger('Window', 'CabinetFontSize', FCabinetFontSize);
		ini.WriteString('Window', 'CabinetFontColor', ColorToString(FCabinetFontColor));
		ini.WriteBool('Window', 'CabinetFontBold', FCabinetFontBold);
		ini.WriteBool('Window', 'CabinetFontItalic', FCabinetFontItalic);
		ini.WriteString('Window', 'CabinetBackColor', ColorToString(FCabinetBackColor));

		ini.WriteString('Window', 'ListFontName', FListFontName);
		ini.WriteInteger('Window', 'ListFontSize', FListFontSize);
		ini.WriteString('Window', 'ListFontColor', ColorToString(FListFontColor));
		ini.WriteString('Window', 'ListBackColor', ColorToString(FListBackColor));
		ini.WriteBool('Window', 'ListFontBold', FListFontBold);
		ini.WriteBool('Window', 'ListFontItalic', FListFontItalic);
		ini.WriteBool('Window','UseOddColor',FUseOddColorOddResNum);
		ini.WriteString('Window', 'OddColor',ColorToString(FOddColor));
		ini.WriteBool('Window','UnFocusedBold', FUnFocusedBold);
		ini.WriteBool('Window','SetBoardInfoStyle', FSetBoardInfoStyle);

		ini.WriteString('Window', 'MessageFontName', FMessageFontName);
		ini.WriteInteger('Window', 'MessageFontSize', FMessageFontSize);
		ini.WriteString('Window', 'MessageFontColor', ColorToString(FMessageFontColor));
		ini.WriteString('Window', 'MessageBackColor', ColorToString(FMessageBackColor));
		ini.WriteBool('Window', 'MessageFontBold', FMessageFontBold);
		ini.WriteBool('Window', 'MessageFontItalic', FMessageFontItalic);

		ini.WriteString('Window', 'EditorFontName', FEditorFontName);
		ini.WriteInteger('Window', 'EditorFontSize', FEditorFontSize);
		ini.WriteString('Window', 'EditorFontColor', ColorToString(FEditorFontColor));
		ini.WriteString('Window', 'EditorBackColor', ColorToString(FEditorBackColor));

		ini.WriteString('Window', 'BrowserTabFontName', FBrowserTabFontName);
		ini.WriteInteger('Window', 'BrowserTabFontSize', FBrowserTabFontSize);
		ini.WriteBool('Window', 'BrowserTabFontBold', FBrowserTabFontBold);
		ini.WriteBool('Window', 'BrowserTabFontItalic', FBrowserTabFontItalic);

		ini.WriteString('Window', 'HintFontName', FHintFontName);
		ini.WriteInteger('Window', 'HintFontSize', FHintFontSize);
		ini.WriteString('Window', 'HintFontColor', ColorToString(FHintFontColor));
		ini.WriteString('Window', 'HintBackColor', ColorToString(FHintBackColor));

		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

//�ݒ�t�@�C���ۑ�(window)
procedure TSetting.WriteWindowSettingFile();
var
	i: Integer;
	ini: TMemIniFile;
	CoolSet: TCoolSet;
	wkList	: TStringList;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		ini.WriteInteger('WindowSize', 'Top', WindowTop);
		ini.WriteInteger('WindowSize', 'Left', WindowLeft);
		ini.WriteInteger('WindowSize', 'Height', WindowHeight);
		ini.WriteInteger('WindowSize', 'Width', WindowWidth);
		ini.WriteBool('WindowSize', 'Max', WindowMax);

		ini.WriteInteger('ViewStyle', 'ListView', Ord(ListStyle));

		ini.WriteInteger('EditorWindowSize', 'Top', EditWindowTop);
		ini.WriteInteger('EditorWindowSize', 'Left', EditWindowLeft);
		ini.WriteInteger('EditorWindowSize', 'Height', EditWindowHeight);
		ini.WriteInteger('EditorWindowSize', 'Width', EditWindowWidth);
		ini.WriteBool('EditorWindowSize', 'Max', EditWindowMax);
		ini.WriteBool('EditorWindowSize', 'Stay', EditWindowStay);
		ini.WriteBool('EditorWindowSize', 'Translucent', EditWindowTranslucent);

		ini.WriteInteger('OptionDialog', 'TabIndex', FOptionDialogTabIndex);

		// ���̓A�V�X�g
		ini.WriteInteger('IAtWindowsSize', 'Top', FInputAssistFormTop);
		ini.WriteInteger('IAtWindowsSize', 'Left', FInputAssistFormLeft);
		ini.WriteInteger('IAtWindowsSize', 'Width', FInputAssistFormWidth);
		ini.WriteInteger('IAtWindowsSize', 'Height', FInputAssistFormHeight);

		//�c�[���o�[
		ini.WriteBool('ToolBar', 'StdVisible', FStdToolBarVisible);
		ini.WriteBool('ToolBar', 'AddressVisible', FAddressBarVisible);
		ini.WriteBool('ToolBar', 'LinkVisible', FLinkBarVisible);
		ini.WriteBool('ToolBar', 'ListVisible', FListToolBarVisible);
		ini.WriteBool('ToolBar', 'ListNameVisible', FListNameBarVisible);
		ini.WriteBool('ToolBar', 'BrowserVisible', FBrowserToolBarVisible);
		ini.WriteBool('ToolBar', 'BrowserNameVisible', FBrowserNameBarVisible);
		//�c�[���o�[Wrapable
		ini.WriteBool('ToolBar', 'ListWrapable', FListToolBarWrapable);
		ini.WriteBool('ToolBar', 'BrowserWrapable', FBrowserToolBarWrapable);

		//�^�u
		ini.WriteBool('Tab', 'BrowserTabVisible', FBrowserTabVisible);
		ini.WriteInteger('Tab', 'BrowserTabPosition', Ord(FBrowserTabPosition));
		ini.WriteInteger('Tab', 'BrowserTabAppend', Ord(FBrowserTabAppend));
		ini.WriteInteger('Tab', 'BrowserTabStyle', Ord(FBrowserTabStyle));

		//���b�Z�[�W�o�[
		ini.WriteBool('MessageBar', 'Visible', FMessageBarVisible);
		ini.WriteInteger('MessageBar', 'Height', FMessegeBarHeight);

		//�X�e�[�^�X�o�[
		ini.WriteBool('StatusBar', 'Visible', FStatusBarVisible);

		//�L���r�l�b�g
		ini.WriteBool('Cabinet', 'Visible', FCabinetVisible);
		ini.WriteInteger('Cabinet', 'Width', FCabinetWidth);
		ini.WriteInteger('Cabinet', 'Index', FCabinetIndex);

		//���X�g�̃T�C�Y�Ɛ�������
		ini.WriteInteger('List', 'Orientation', Ord(FListOrientation));
		ini.WriteInteger('List', 'Height', FListHeight);
		ini.WriteInteger('List', 'HeightState', Ord(FListHeightState));
		ini.WriteInteger('List', 'Width', FListWidth);
		ini.WriteInteger('List', 'WidthState', Ord(FListWidthState));
//		ini.WriteBool('List', 'HeightMax', FListHeightMax);
//		ini.WriteBool('List', 'WidthMax', FListWidthMax);


//		ini.WriteInteger('Window', 'BrowserFontSize', BrowserFontSize);

		//���X�g�ԍ��\��
		ini.WriteBool('Function', 'ListViewNo', FListViewNo);
		//CSS�g�p
		ini.WriteBool('CSS', 'UseCSS', FUseCSS);
		//������`����̃X�L�����g����
		ini.WriteBool('CSS', 'UseKatjushaType', FUseKatjushaType);
		//CSS�t�@�C����
		ini.WriteString('CSS', 'FileName', FSkinFiles.FileName);
		//Mail���\��
		ini.WriteBool('Thread', 'ShowMail', FShowMail);
		// ���X�\���͈�
		ini.DeleteKey( 'Thread', 'OnlyAHundredRes' );   // �Â��ݒ�̍폜
		ini.WriteInteger('Thread', 'ResRange', FResRange);
		ini.WriteBool('Thread', 'ResRangeHold', FResRangeHold);
        ini.WriteInteger('Thread', 'HeadResCount', FHeadResCount);
        ini.WriteInteger('Thread','ResRangeExCount', FResRangeExCount);
		// �X���b�h�ꗗ�\���͈�
		ini.WriteInteger('ThreadList', 'ThreadRange', Ord( FThreadRange ));
		//���O�폜�m�F
		ini.WriteBool('Function', 'LogDeleteMessage', FDeleteMsg);
		//�I���m�F
		ini.WriteBool('Function','ShowDialogForEnd',FShowDialogForEnd);
		//AllTabClose
		ini.WriteBool('Function','ShowDialogForAllTabClose', FShowDialogForAllTabClose);
		//Samba
		ini.WriteBool('Function','UseSamba', FUseSamba);
		//ResAnchorjamp
		ini.WriteBool('Function', 'ResAnchoJamp', ResAnchorJamp);

		//��A�N�e�B�u���|�b�v�A�b�v�\��
		ini.WriteBool('Thread', 'UnActivePopup', FUnActivePopup);
		//���X�|�b�v�A�b�v�w�b�_�[�{�[���h
		ini.WriteBool('Thread', 'ResPopupHeaderBold', FResPopupHeaderBold);
        // BE�A�C�R���EEmoticon�摜�\��
        ini.WriteBool('Thread', 'IconImageDisplay', FIconImageDisplay);
        // �X���^�C���蕶���񏜋�
        ini.WriteBool('Thread', 'ThreadTitleTrim', FThreadTitleTrim);
		//ini.WriteString('BoardURL', '2ch', FBoardURL2ch);

		//�F�ؗp���[�UID�E�p�X���[�h
		ini.WriteString('Attestation', 'UserID', FUserID);
		ini.WriteString('Attestation', 'Password', Encrypt(FPassword));
		ini.WriteBool('Attestation', 'AutoLogin', FAutoLogin);
		ini.WriteBool('Attestation', 'FForcedLogin', FForcedLogin);
//		ini.WriteString('Attestation', 'FDolibURL', FDolibURL);
  	// User-Agent�o�[�W�����ԍ��Œ�
    ini.WriteInteger('HTTP', 'UAVersion', FUAVersion);

		//URL�N���b�N���N���A�v��
		ini.WriteBool('URLApp', 'Select', FURLApp);
		ini.WriteString('URLApp', 'File', FURLAppFile);

		//mailto�N���b�N������
		ini.WriteBool('Mailto', 'Open', FOpenMailer);

		//�|�b�v�A�b�v�ʒu
		ini.WriteInteger('Browser', 'PopupPosition', Ord(FPopupPosition));
        ini.WriteInteger('Browser', 'RespopupDelteX', FRespopupDeltaX);
        ini.WriteInteger('Browser', 'RespopupDelteY', FRespopupDeltaY);
        ini.WriteInteger('Browser', 'RespopupWait', FRespopupWait);
        ini.WriteBool('Browser', 'RespopupMailTo', FRespopupMailTo);
        
		//�A�h���X�o�[
		ini.WriteBool('AddressBar', 'URLDisplay', FURLDisplay);
		ini.WriteBool('AddressBar', 'TabStop', FAddressBarTabStop);
		ini.WriteBool('AddressBar', 'LinkAdd', FLinkAddAddressBar);
		ini.WriteInteger('AddressBar', 'HistoryCount', FAddressHistoryCount);

		//�摜�v���r���[
		ini.WriteBool('Browser', 'PreviewVisible', FPreviewVisible);
		ini.WriteInteger('Browser', 'PreviewSize', Ord(FPreviewSize));
		ini.WriteInteger('Browser', 'PreviewWait', FPreviewWait);

		ini.WriteInteger('Window', 'BrowserAutoMaximize', Ord( BrowserAutoMaximize ) );

		//�X���b�h�ꗗ�X�V�A�C�R��
		ini.WriteBool('ThreadList', 'StateIconVisible', FListIconVisible);
		ini.WriteBool('ThreadList', 'CreationTimeLogs',FCreationTimeLogs);
		ini.WriteBool('ThreadList', 'FutureThread', FFutureThread);
		ini.WriteInteger('ThreadList', 'SelectInterval', FSelectInterval);
		//�\�[�g��
		ini.WriteInteger('ThreadList', 'BBSSortIndex', FBBSSortIndex);
		ini.WriteBool('ThreadList', 'BBSSortOrder', FBBSSortOrder);
		ini.WriteInteger('ThreadList', 'CategorySortIndex', FCategorySortIndex);
		ini.WriteBool('ThreadList', 'CategorySortOrder', FCategorySortOrder);
		ini.WriteInteger('ThreadList', 'BoardSortIndex', FBoardSortIndex);
		ini.WriteBool('ThreadList', 'BoardSortOrder', FBoardSortOrder);
		ini.WriteInteger('ThreadList', 'DatOchiSortIndex', FDatOchiSortIndex);
		ini.WriteBool('ThreadList', 'DatOchiSortOrder', FDatOchiSortOrder);
		// DL��̎����\�[�g
		ini.WriteBool('ThreadList', 'AutoSort', FAutoSortThreadList);

		//�������ݎ��}�V�������g�p�ݒ�
		ini.WriteBool('PostTime', 'UseMachineTime', FUseMachineTime);
		ini.WriteInteger('PostTime', 'TimeAdjustSec', FTimeAdjustSec);
		ini.WriteBool('PostTime', 'TimeAdjust', FTimeAdjust);

		// ���X�g�J������
		for i := 0 to Length(FBBSColumnWidth) - 1 do begin
			ini.WriteInteger('BBSColumnWidth', 'ID' + IntToStr(i), FBBSColumnWidth[i]);
		end;
		for i := 0 to Length(FCategoryColumnWidth) - 1 do begin
			ini.WriteInteger('CategoryColumnWidth', 'ID' + IntToStr(i), FCategoryColumnWidth[i]);
		end;
		for i := 0 to Length(FBoardColumnWidth) - 1 do begin
			ini.WriteInteger('BoardColumnWidth', 'ID' + IntToStr(i), FBoardColumnWidth[i]);
		end;

		wkList := TStringList.Create;
		try
			// �J�e�S�����X�g����
			ini.ReadSection( 'BBSColumnOrder', wkList );
			for i := wkList.Count - 1 downto 0 do
				ini.DeleteKey( 'BBSColumnOrder', wkList[ i ] );
			for i := 0 to FBBSColumnOrder.Count - 1 do
				ini.WriteInteger( 'BBSColumnOrder', 'ID' + IntToStr( i ), Ord( FBBSColumnOrder[ i ] ) );

			// ���X�g����
			ini.ReadSection( 'CategoryColumnOrder', wkList );
			for i := wkList.Count - 1 downto 0 do
				ini.DeleteKey( 'CategoryColumnOrder', wkList[ i ] );
			for i := 0 to FCategoryColumnOrder.Count - 1 do
				ini.WriteInteger( 'CategoryColumnOrder', 'ID' + IntToStr( i ), Ord( FCategoryColumnOrder[ i ] ) );

			// �X�����X�g����
			ini.ReadSection( 'BoardColumnOrder', wkList );
			for i := wkList.Count - 1 downto 0 do
				ini.DeleteKey( 'BoardColumnOrder', wkList[ i ] );
			for i := 0 to FBoardColumnOrder.Count - 1 do
				ini.WriteInteger( 'BoardColumnOrder', 'ID' + IntToStr( i ), Ord( FBoardColumnOrder[ i ] ) );
		finally
			wkList.Free;
		end;

		//�T�E���h
		for i := 0 to GetSoundCount - 1 do begin
			if not FileExists(SoundFileName[i]) then
				SoundFileName[i] := '';
			ini.WriteString('Sound', SoundName[i], SoundFileName[i]);
		end;

		//CoolBar
		ini.EraseSection('MainCoolBar');
		for i := 0 to MAIN_COOLBAND_COUNT - 1 do begin
			CoolSet := MainCoolSet[i];
			ini.WriteInteger('MainCoolBar', 'ID' + IntToStr(i), CoolSet.FCoolID);
			ini.WriteInteger('MainCoolBar', 'Width' + IntToStr(i), CoolSet.FCoolWidth);
			ini.WriteBool('MainCoolBar', 'Break' + IntToStr(i), CoolSet.FCoolBreak);
		end;
		ini.EraseSection('ListCoolBar');
		ini.WriteInteger( 'ListCoolBar', 'SelectWidth', FSelectComboBoxWidth );
		for i := 0 to LIST_COOLBAND_COUNT - 1 do begin
			CoolSet := ListCoolSet[i];
			ini.WriteInteger('ListCoolBar', 'ID' + IntToStr(i), CoolSet.FCoolID);
			ini.WriteInteger('ListCoolBar', 'Width' + IntToStr(i), CoolSet.FCoolWidth);
			ini.WriteBool('ListCoolBar', 'Break' + IntToStr(i), CoolSet.FCoolBreak);
		end;
		ini.EraseSection('BrowserCoolBar');
		for i := 0 to BROWSER_COOLBAND_COUNT - 1 do begin
			CoolSet := BrowserCoolSet[i];
			ini.WriteInteger('BrowserCoolBar', 'ID' + IntToStr(i), CoolSet.FCoolID);
			ini.WriteInteger('BrowserCoolBar', 'Width' + IntToStr(i), CoolSet.FCoolWidth);
			ini.WriteBool('BrowserCoolBar', 'Break' + IntToStr(i), CoolSet.FCoolBreak);
		end;

		//���ځ`��
		ini.WriteBool('Abon','Deleterlo',FAbonDeleterlo);
		ini.WriteBool('Abon','Replaceul',FAbonReplaceul);
		ini.WriteBool('Abon','Popup',FPopUpAbon);
		ini.WriteBool('Abon','ShowNGLines',FShowNGLinesNum);
		ini.WriteBool('Abon','AddResAnchor',FAddResAnchor);
		ini.WriteBool('Abon','DeleteSyria',FDeleteSyria);
		ini.WriteBool('Abon','IgnoreKana', FIgnoreKana);
    ini.WriteBool('Abon','KeepNgFile', FKeepNgFile);

		//NG���[�h�ҏW
		ini.WriteBool('NGWordEditor', 'NGTextEditor', FNGTextEditor);
		ini.WriteInteger('NGWordEditor', 'NGWindowTop', FNGWindowTop);
		ini.WriteInteger('NGWordEditor', 'NGWindowLeft', FNGWindowLeft);
		ini.WriteInteger('NGWordEditor', 'NGWindowHeight', FNGWindowHeight);
		ini.WriteInteger('NGWordEditor', 'NGWindowWidth', FNGWindowWidth);
		ini.WriteBool('NGWordEditor', 'NGWindowMax', FNGWindowMax);

		// �G�f�B�^
		ini.WriteBool( 'Editor', 'SpaceToNBSP',    FSpaceToNBSP );
		ini.WriteBool( 'Editor', 'AmpToCharRef',   FAmpToCharRef );
		ini.WriteBool( 'Editor', 'UseGobakuCheck', FUseGobakuCheck );
		//ini.WriteBool( 'Editor', 'UseUnicode',     FUseUnicode );
    ini.WriteBool( 'Editor', 'PreviewStyle',   FPreviewStyle );
    ini.WriteBool( 'Editor', 'Oekaki',         FOekaki );

    //! �폜�v������ʈ���
    ini.WriteBool('NewBoard', 'SakuSpecial', FSakuBoard);

		//�^�u�����ۑ�
		ini.WriteBool('TabAuto', 'TabAutoLoadSave', FTabAutoLoadSave);
		ini.WriteString('Thread', 'LastCloseTabURL', FLastCloseTabURL);
                //�ڍאݒ�
		ini.WriteInteger('OptionDialog', 'KuroutTabIndex', FKuroutSettingTabIndex);

		//�ɂ�����ē��@�\
		ini.WriteBool('2chSupport', 'Support', F2chSupport);

		// �}�E�X�W�F�X�`���[���g�p���邩�ǂ���
		ini.WriteBool( 'Guesture', 'Enabled', FGestureEnabled );
		ini.WriteBool( 'Guesture', 'IgnoreContext', FGestureIgnoreContext );
		//FusianaTrap
		ini.WriteBool('Trap', 'LocalTrap', FLocalTrapAtt);
		ini.WriteBool('Trap', 'RemoteTrap', FRemoteTrapAtt);
		ini.WriteInteger('HTTP', 'ReadTimeOut', FReadTimeOut);

		// �g�p����X�p���t�B���^
		ini.WriteInteger( 'Abon', 'SpamFilterAlgorithm', Ord( FSpamFilterAlgorithm ) );
		ini.WriteBool('Function', 'Mute', FMute);
		ini.WriteBool('ThreadList', 'UseUndecided', FUseUndecided);

		//�F�ؗp���[�UID�E�p�X���[�h
		ini.WriteString('Be', 'UserID', FBeUserID);
		ini.WriteString('Be', 'Password', Encrypt(FBePassword));
		ini.WriteBool('Be', 'AutoLogin', FBeAutoLogin);

		//�����̍ő�ۑ�����
		ini.WriteInteger('Recode', 'Max', FMaxRecordCount);
		// �Œ��Cookie������
    ini.WriteString('Cookie', 'fixedString', FFixedCookie);

    // �����N�ړ������̍ő�ێ���
    ini.WriteInteger('MoveHisotry', 'Max', FMoveHistorySize);

    ini.WriteBool('Function', 'StroedTaskTray', FStoredTaskTray);
    ini.WriteBool('Function', 'LoopBrowserTabs', FLoopBrowserTabs);
    ini.WriteBool('Thread', 'AddKeywordLink', FAddKeywordLink);
    ini.WriteBool('Thread', 'ReplaceDat', FReplaceDat);
    ini.WriteInteger('Function', 'SentIniFileSize', FSentIniFileSize);
    ini.WriteString('Function', 'ExtList', FExtList);
    ini.WriteBool('ThreadList', 'CheckDatFile', FCheckDatFile);
    ini.WriteBool('Thread', 'LimitResCountMessage', FLimitResCountMessage);

		//! �X���^�C�����E�B���h�E
		ini.WriteInteger('ThreadSearch', 'Top',    FThrdSrchTop);
		ini.WriteInteger('ThreadSearch', 'Left',   FThrdSrchLeft);
		ini.WriteInteger('ThreadSearch', 'Width',  FThrdSrchWidth);
		ini.WriteInteger('ThreadSearch', 'Height', FThrdSrchHeight);
		ini.WriteBool(   'ThreadSearch', 'Max',    FThrdSrchMax);
    ini.WriteBool(   'ThreadSearch', 'Stay',   FThrdSrchStay);
    ini.WriteInteger('ThreadSearch', 'Col1W',  FThrdSrchCol1W);
    ini.WriteInteger('ThreadSearch', 'Col2W',  FThrdSrchCol2W);
    ini.WriteInteger('ThreadSearch', 'Col3W',  FThrdSrchCol3W);
    ini.WriteInteger('ThreadSearch', 'Col4W',  FThrdSrchCol4W);
    ini.WriteInteger('ThreadSearch', 'HistoryCount', FThrdSrchHistory.Count);
    if (FThrdSrchHistory.Count > 0) then begin
			for i := 1 to FThrdSrchHistory.Count do begin
				ini.WriteString('ThreadSearch', 'History' + IntToStr(i), FThrdSrchHistory.Strings[i-1]);
			end;
    end;

		//! �X�ǂ񂮂�V�X�e���E�B���h�E
		ini.WriteInteger('DonguriSystem', 'Top',    FDonguriTop);
		ini.WriteInteger('DonguriSystem', 'Left',   FDonguriLeft);
		ini.WriteInteger('DonguriSystem', 'Width',  FDonguriWidth);
		ini.WriteInteger('DonguriSystem', 'Height', FDonguriHeight);
		ini.WriteBool(   'DonguriSystem', 'Stay',   FDonguriStay);
    ini.WriteInteger('DonguriSystem', 'Theme',  FDonguriTheme);
    ini.WriteBool(   'DonguriSystem', 'TaskBar',FDonguriTaskBar);
		//! �ǂ񂮂�֘A
    ini.WriteBool(   'Donguri',      'MenuTop', FDonguriMenuTop);


		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;
//�ݒ�t�@�C���ۑ�(�`���̏�)
procedure TSetting.WriteBoukenSettingFile;
var
	i: Integer;
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		ini.EraseSection('Bouken');
        // �`���̏�Cookie��������
        for i := 0 to FBoukenCookieList.Count - 1 do begin
            ini.WriteString('Bouken', FBoukenCookieList.Names[i], FBoukenCookieList.Values[FBoukenCookieList.Names[i]]);
        end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

//�ݒ�t�@�C���ۑ�(name & mail)
procedure TSetting.WriteNameMailSettingFile();
var
	i: Integer;
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		ini.EraseSection('Name');
		ini.EraseSection('Mail');
		ini.EraseSection('SelectText');
		for i := 0 to FNameList.Count - 1 do begin
			ini.WriteString('Name', Format('%.2d', [i + 1]), FNameList[i]);
			if i >= 39 then
				Break;
		end;
		for i := 0 to FMailList.Count - 1 do begin
			ini.WriteString('Mail', Format('%.2d', [i + 1]), FMailList[i]);
			if i >= 39 then
				Break;
		end;
		for i := 0 to FSelectTextList.Count - 1 do begin
			ini.WriteString('SelectText', Format('%.2d', [i + 1]), FSelectTextList[i]);
			if i >= 39 then
				Break;
		end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

procedure TSetting.WriteFolderSettingFile();
var
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetFileName());
	try
		if GetAppDir + 'Log' = NewLogFolder then
			ini.DeleteKey('Folder', 'LogFolder')
		else
			ini.WriteString('Folder', 'LogFolder', NewLogFolder);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;
//�X�V�pBoardURL��ۑ�
procedure TSetting.WriteBoardURLSettingFile();
var
	ini: TMemIniFile;
		i : Integer;
		oldcount : Integer;
begin
	ini := TMemIniFile.Create(GetBoardURLFileName());
	try
		oldcount := ini.ReadInteger('URL','count',FBoardURLs.Count);
		ini.WriteInteger('URL','count',FBoardURLs.Count);
		ini.WriteInteger('URL','selected',BoardURLSelected);
		for i := 0 to FBoardURLs.Count -1 do begin
					ini.WriteString('URL',IntToStr(i+1),FBoardURLs.Strings[i]);
		end;
		if oldcount > FBoardURLs.Count then begin
			for i := FBoardURLs.Count to oldcount do begin
				ini.DeleteKey('URL',IntToStr(i+1));
			end;
		end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

{$R-}
//���X�g�J�����w�b�_�[
function TSetting.GetBBSColumnWidth(index: Integer): Integer;
begin
	Result := IfThen(index in [0..Length(FBBSColumnWidth) - 1], FBBSColumnWidth[index], 0);
end;

function TSetting.GetCategoryColumnWidth(index: Integer): Integer;
begin
	Result := IfThen(index in [0..Length(FCategoryColumnWidth) - 1], FCategoryColumnWidth[index], 0);
end;

function TSetting.GetBoardColumnWidth(index: Integer): Integer;
begin
	Result := IfThen(index in [0..Length(FBoardColumnWidth) - 1], FBoardColumnWidth[index], 0);
end;
{$IFDEF DEBUG}
{$R+}
{$ENDIF}

procedure TSetting.SetBBSColumnWidth(index: Integer; value: Integer);
begin
	if index in [0..Length(FBBSColumnWidth) - 1] then
		FBBSColumnWidth[index] := value;
end;

procedure TSetting.SetCategoryColumnWidth(index: Integer; value: Integer);
begin
	if index in [0..Length(FCategoryColumnWidth) - 1] then
		FCategoryColumnWidth[index] := value;
end;

procedure TSetting.SetBoardColumnWidth(index: Integer; value: Integer);
begin
	if index in [0..Length(FBoardColumnWidth) - 1] then
		FBoardColumnWidth[index] := value;
end;

function TSetting.GetSoundCount: Integer;
begin
	Result := Length(SOUND_NAME);
end;

function TSetting.GetSoundName(Index: Integer): string;
begin
	if (Index < GetSoundCount) and (Index >= 0) then
		Result := SOUND_NAME[Index].Name
	else
		Result := '';
end;

function TSetting.GetSoundViewName(Index: Integer): string;
begin
	if (Index < GetSoundCount) and (Index >= 0) then
		Result := SOUND_NAME[Index].ViewName
	else
		Result := '';
end;

function TSetting.GetSoundFileName(Index: Integer): string;
begin
	if (Index < GetSoundCount) and (Index >= 0) then
		Result := SOUND_NAME[Index].FileName
	else
		Result := '';
end;

procedure TSetting.SetSoundFileName(Index: Integer; value: string);
begin
	if (Index < GetSoundCount) and (Index >= 0) then
		SOUND_NAME[Index].FileName := value;
end;

function TSetting.FindSoundFileName(Name: string): string;
var
	i: Integer;
begin
	for i := 0 to GetSoundCount - 1 do begin
		if SoundName[i] = Name then begin
            SysUtils.SetCurrentDir(GetAppDir);
			Result := ExpandFileName(SoundFileName[i]);
			Exit;
		end;
	end;
	Result := '';
end;

function TSetting.Encrypt(s: string): string;
var
	cryptObj: THogeCryptAuto;
	inputStream, outputStream: TStringStream;
begin
	inputStream := TStringStream.Create(s);
	outputStream := TStringStream.Create('');
	cryptObj := THogeCryptAuto.Create;
	try
		// �Í���
		cryptObj.Encrypt(inputStream, GIKO_ENCRYPT_TEXT, outputStream);

		// �o�C�i���Ȃ̂ŕK�v�ɉ����ăe�L�X�g�ɕϊ�
		Result := HogeBase64Encode(outputStream.DataString);
	finally
		cryptObj.Free;
		outputStream.Free;
		inputStream.Free;
	end;
end;

function TSetting.Decrypt(s: string): string;
var
	cryptObj: THogeCryptAuto;
	inputStream, outputStream: TStringStream;
begin
	try
		inputStream := TStringStream.Create(HogeBase64Decode(s));
	except
		Result := '';
		Exit;
	end;
	outputStream := TStringStream.Create('');
	cryptObj := THogeCryptAuto.Create;
	try
		// ����
		cryptObj.Decrypt(inputStream, GIKO_ENCRYPT_TEXT, outputStream);
		Result := outputStream.DataString;
	finally
		cryptObj.Free;
		outputStream.Free;
		inputStream.Free;
	end;
end;

function TSetting.GetMainCoolSet(Index: Integer): TCoolSet;
begin
	if Index in [0..MAIN_COOLBAND_COUNT - 1] then
		Result := FMainCoolBar[Index]
	else begin
		Result.FCoolID := -1;
		Result.FCoolWidth := -1;
		Result.FCoolBreak := False;
	end;
end;

function TSetting.GetBoardCoolSet(Index: Integer): TCoolSet;
begin
	if Index in [0..LIST_COOLBAND_COUNT - 1] then
		Result := FListCoolBar[Index]
	else begin
		Result.FCoolID := -1;
		Result.FCoolWidth := -1;
		Result.FCoolBreak := False;
	end;
end;

function TSetting.GetBrowserCoolSet(Index: Integer): TCoolSet;
begin
	if Index in [0..BROWSER_COOLBAND_COUNT - 1] then
		Result := FBrowserCoolBar[Index]
	else begin
		Result.FCoolID := -1;
		Result.FCoolWidth := -1;
		Result.FCoolBreak := False;
	end;
end;

procedure TSetting.SetMainCoolSet(Index: Integer; CoolSet: TCoolSet);
begin
	if Index in [0..MAIN_COOLBAND_COUNT - 1] then
		FMainCoolBar[Index] := CoolSet;
end;

procedure TSetting.SetBoardCoolSet(Index: Integer; CoolSet: TCoolSet);
begin
	if Index in [0..LIST_COOLBAND_COUNT - 1] then
		FListCoolBar[Index] := CoolSet;
end;

procedure TSetting.SetBrowserCoolSet(Index: Integer; CoolSet: TCoolSet);
begin
	if Index in [0..BROWSER_COOLBAND_COUNT - 1] then
		FBrowserCoolBar[Index] := CoolSet;
end;

//url.ini���Ȃ��Ƃ��ɐ�������
procedure TSetting.MakeURLIniFile();
var
	ini: TMemIniFile;
begin
	ini := TMemIniFile.Create(GetBoardURLFileName());
	try
		//�X�VURL�̐�
		ini.WriteInteger('URL','count',1);
		//�f�t�H���g�Ŏg�p����t�q�k�̃C���f�b�N�X
		ini.WriteInteger('URL','selected',1);
		//�ȉ��K�v�Ȑ������A�X�V�t�q�k��ǉ�
		ini.WriteString('URL','1',DEFAULT_2CH_BOARD_URL1);
		//ini.WriteString('URL','2',DEFAULT_2CH_BOARD_URL2);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

(*************************************************************************
 *�{�[�h�t�@�C�����擾�i�p�X�{�t�@�C�����j
 *************************************************************************)
function TSetting.GetBoardFileName: string;
begin
	Result := GetConfigDir + BOARD_FILE_NAME;
end;

(*************************************************************************
 *�{�[�h�t�@�C�����擾�i�p�X�{�t�@�C�����j
 *************************************************************************)
function TSetting.GetCustomBoardFileName: string;
begin
	Result := GetConfigDir + CUSTOMBOARD_FILE_NAME;
end;

(*************************************************************************
 *�{�[�h�f�B���N�g���擾(\�ŏI���)
 *************************************************************************)
function TSetting.GetBoardDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + BOARD_DIR_NAME);
end;

(*************************************************************************
 *�e���|�����t�H���_�[���擾
 *************************************************************************)
function TSetting.GetHtmlTempFileName: string;
begin
	Result := TEMP_FOLDER;
end;


(*************************************************************************
 *���s�t�@�C���t�H���_�擾(�Ō��\������)
 *************************************************************************)
function TSetting.GetAppDir: string;
begin
	Result := ExtractFilePath(Application.ExeName);
end;

(*************************************************************************
 *TempHtml�t�@�C�����擾�i�p�X�{�t�@�C�����j
 *************************************************************************)
function TSetting.GetTempFolder: string;
begin
	Result := GetAppDir + TEMP_FOLDER;
end;

(*************************************************************************
 *sent.ini�t�@�C�����擾�i�p�X�{�t�@�C�����j
 *************************************************************************)
function TSetting.GetSentFileName: string;
begin
	Result := GetAppDir + SENT_FILE_NAME;
end;

(*************************************************************************
 *outbox.ini�t�@�C�����擾�i�p�X�{�t�@�C�����j
 *************************************************************************)
function TSetting.GetOutBoxFileName: string;
begin
	Result := GetAppDir + OUTBOX_FILE_NAME;
end;

(*************************************************************************
 *defaultFiles.ini�t�@�C�����擾�i�p�X�{�t�@�C�����j
 *************************************************************************)
function TSetting.GetDefaultFilesFileName: string;
begin
	Result := GetAppDir + DEFFILES_FILE_NAME;
end;

(*************************************************************************
 *Config�t�H���_�擾(\�ŏI���)
 *************************************************************************)
function TSetting.GetConfigDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetAppDir + CONFIG_DIR_NAME);
end;
(*************************************************************************
 *CSS�t�H���_�擾(\�ŏI���)
 *************************************************************************)
function TSetting.GetStyleSheetDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + CSS_DIR_NAME);
end;
(*************************************************************************
 *skin�t�H���_�擾(\�ŏI���)
 *************************************************************************)
function TSetting.GetSkinDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + SKIN_DIR_NAME);
end;
(*************************************************************************
 *NG���[�h�f�B���N�g���擾(\�ŏI���)
 *************************************************************************)
function TSetting.GetNGWordsDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + NGWORDs_DIR_NAME);
end;
(*************************************************************************
 *Board�v���O�C���f�B���N�g���擾(\�ŏI���)
 *************************************************************************)
function TSetting.GetBoardPlugInDir: string;
begin
	Result := IncludeTrailingPathDelimiter(GetConfigDir + BOARD_PLUGIN_DIR_NAME);
end;

procedure TSetting.SetUseCSS( value: Boolean );
begin

	FUseCSS := value;
	// Windows�I�Ƀt�@�C���p�X�̑啶���������̈Ⴂ�͖��������̂ŁA
	// �R�R�ł̔���ł��啶���������̈Ⴂ�͖�������B
	FUseSkin :=
		UseCSS and
		(Pos( AnsiLowerCase(GetSkinDir), AnsiLowerCase(FSkinFiles.FileName) ) > 0) and
		FileExists( FSkinFiles.GetSkinHeaderFileName );

end;

procedure TSetting.SetCSSFileName( fileName: string );
begin
    FSkinFiles.FileName := fileName;
	// Windows�I�Ƀt�@�C���p�X�̑啶���������̈Ⴂ�͖��������̂ŁA
	// �R�R�ł̔���ł��啶���������̈Ⴂ�͖�������B
	FUseSkin :=
		UseCSS and
		(Pos( AnsiLowerCase(GetSkinDir), AnsiLowerCase(FSkinFiles.FileName) ) > 0) and
		FileExists( FSkinFiles.GetSkinHeaderFileName );

end;
(*************************************************************************
 *samba�ݒ�t�@�C�����擾
 *************************************************************************)
function TSetting.GetSambaFileName: string;
begin
	Result := GetAppDir + SAMBATIME_FILE_NAME;
end;
//�X�V���O�J�e�S�����X�g�ۑ��t�@�C��
function TSetting.GetIgnoreFileName: string;
begin
	Result := GetConfigDir + IGNORE_FILE_NAME;
end;

//! �}�E�X�W�F�X�`���[�t�@�C���p�X
function TSetting.GetGestureFileName: string;
begin
	Result := GetConfigDir + GESTURE_FILE_NAME;
end;

//! �X�p���t�B���^�w�K�����t�@�C���p�X
function TSetting.GetSpamFilterFileName: string;
begin
	Result := GetConfigDir + SPAMFILTER_FILE_NAME;
end;

function TSetting.GetLanguageFileName: string;
begin
    Result := GetConfigDir + LANGUAGE_FILE_NAME;
end;
procedure TSetting.WriteLogFolder(AVal : String);
begin
	FLogFolder := AVal;
	FLogFolderP := IncludeTrailingPathDelimiter(LogFolder);
end;
function TSetting.GetMainKeyFileName: String;
begin
	Result := GetConfigDir + KEY_SETTING_FILE_NAME;
end;
function TSetting.GetEditorKeyFileName: String;
begin
	Result := GetConfigDir + EKEY_SETTING_FILE_NAME;
end;
function TSetting.GetInputAssistFileName : String;
begin
	Result := GetConfigDir + INPUTASSIST_FILE_NAME;
end;
function TSetting.GetReplaceFileName: String;
begin
    Result := GetConfigDir + REPLACE_FILE_NAME;
end;
function TSetting.GetExtprevieFileName: String;
begin
    Result := GetConfigDir + EXT_PREVIEW_FILE_NAME;
end;
procedure TSetting.SetMoveHistorySize(AVal : Integer);
begin
    if (AVal > 0) then begin
        FMoveHistorySize := AVal;
    end;
end;
{
\brief �v���L�V�ݒ�ǂݍ���
\param  memIni  ini�t�@�C��
}
procedure TSetting.ReadProxySettings(memIni: TMemIniFile);
const
    READ_SECTION = 'ReadProxy';
    WRITE_SECTION= 'WriteProxy';
    PROXY_KEY = 'Proxy';
    ADDRE_KEY = 'Address';
    PORT_KEY = 'Port';
    UID_KEY  = 'UserID';
    PASS_KEY = 'Password';
begin
    if (memIni <> nil) then begin
		FReadProxy := memIni.ReadBool(READ_SECTION, PROXY_KEY, false);
		FReadProxyAddress := memIni.ReadString(READ_SECTION, ADDRE_KEY, '');
		FReadProxyPort := memIni.ReadInteger(READ_SECTION, PORT_KEY, 0);
		FReadProxyUserID := memIni.ReadString(READ_SECTION, UID_KEY, '');
		FReadProxyPassword := memIni.ReadString(READ_SECTION, PASS_KEY, '');

		FWriteProxy := memIni.ReadBool(WRITE_SECTION, PROXY_KEY, false);
		FWriteProxyAddress := memIni.ReadString(WRITE_SECTION, ADDRE_KEY, '');
		FWriteProxyPort := memIni.ReadInteger(WRITE_SECTION, PORT_KEY, 0);
		FWriteProxyUserID := memIni.ReadString(WRITE_SECTION, UID_KEY, '');
		FWriteProxyPassword := memIni.ReadString(WRITE_SECTION, PASS_KEY, '');
    end;
end;
{
\brief  �e��E�B���h�E�ݒ�ǂݍ���
\param  menIni  ini�t�@�C��
}
procedure TSetting.ReadWindowSettings(memIni: TMemIniFile);
const
    WINDOW_SECTION = 'Window';
begin
    if (memIni <> nil) then begin
		FBrowserFontName := memIni.ReadString(WINDOW_SECTION, 'BrowserFontName', '');
		FBrowserFontSize := memIni.ReadInteger(WINDOW_SECTION, 'BrowserFontSize', 0);
		FBrowserFontBold := memIni.ReadInteger(WINDOW_SECTION, 'BrowserFontBold', 0);
		FBrowserFontItalic := memIni.ReadInteger(WINDOW_SECTION, 'BrowserFontItalic', 0);
		FBrowserFontColor := memIni.ReadInteger(WINDOW_SECTION, 'BrowserFontColor', -1);
		FBrowserBackColor := memIni.ReadInteger(WINDOW_SECTION, 'BrowserBackColor', -1);

		FCabinetFontName := memIni.ReadString(WINDOW_SECTION, 'CabinetFontName', DEFAULT_FONT_NAME);
		FCabinetFontSize := memIni.ReadInteger(WINDOW_SECTION, 'CabinetFontSize', DEFAULT_FONT_SIZE);
		FCabinetFontBold := memIni.ReadBool(WINDOW_SECTION, 'CabinetFontBold', False);
		FCabinetFontItalic := memIni.ReadBool(WINDOW_SECTION, 'CabinetFontItalic', False);
		FCabinetFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'CabinetFontColor', DEFAULT_FONT_COLOR));
		FCabinetBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'CabinetBackColor', DEFAULT_WINDOW_COLOR));

		FListFontName := memIni.ReadString(WINDOW_SECTION, 'ListFontName', DEFAULT_FONT_NAME);
		FListFontSize := memIni.ReadInteger(WINDOW_SECTION, 'ListFontSize', DEFAULT_FONT_SIZE);
		FListFontBold := memIni.ReadBool(WINDOW_SECTION, 'ListFontBold', False);
		FListFontItalic := memIni.ReadBool(WINDOW_SECTION, 'ListFontItalic', False);
		FListFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'ListFontColor', DEFAULT_FONT_COLOR));
		FListBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'ListBackColor', DEFAULT_WINDOW_COLOR));
		FUseOddColorOddResNum := memIni.ReadBool(WINDOW_SECTION,'UseOddColor', False);
		FOddColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'OddColor', DEFAULT_WINDOW_COLOR));
		FUnFocusedBold := memIni.ReadBool(WINDOW_SECTION,'UnFocusedBold', False);
		FSetBoardInfoStyle := memIni.ReadBool(WINDOW_SECTION,'SetBoardInfoStyle', False);

		FMessageFontName := memIni.ReadString(WINDOW_SECTION, 'MessageFontName', DEFAULT_FONT_NAME);
		FMessageFontSize := memIni.ReadInteger(WINDOW_SECTION, 'MessageFontSize', DEFAULT_FONT_SIZE);
		FMessageFontBold := memIni.ReadBool(WINDOW_SECTION, 'MessageFontBold', False);
		FMessageFontItalic := memIni.ReadBool(WINDOW_SECTION, 'MessageFontItalic', False);
		FMessageFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'MessageFontColor', DEFAULT_FONT_COLOR));
		FMessageBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'MessageBackColor', DEFAULT_WINDOW_COLOR));

		FEditorFontName := memIni.ReadString(WINDOW_SECTION, 'EditorFontName', DEFAULT_FONT_NAME);
		FEditorFontSize := memIni.ReadInteger(WINDOW_SECTION, 'EditorFontSize', DEFAULT_FONT_SIZE);
		FEditorFontBold := memIni.ReadBool(WINDOW_SECTION, 'EditorFontBold', False);
		FEditorFontItalic := memIni.ReadBool(WINDOW_SECTION, 'EditorFontItalic', False);
		FEditorFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'EditorFontColor', DEFAULT_FONT_COLOR));
		FEditorBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'EditorBackColor', DEFAULT_WINDOW_COLOR));

		FBrowserTabFontName := memIni.ReadString(WINDOW_SECTION, 'BrowserTabFontName', DEFAULT_TAB_FONT_NAME);
		FBrowserTabFontSize := memIni.ReadInteger(WINDOW_SECTION, 'BrowserTabFontSize', DEFAULT_TAB_FONT_SIZE);
		FBrowserTabFontBold := memIni.ReadBool(WINDOW_SECTION, 'BrowserTabFontBold', False);
		FBrowserTabFontItalic := memIni.ReadBool(WINDOW_SECTION, 'BrowserTabFontItalic', False);

		FHintFontName := memIni.ReadString(WINDOW_SECTION, 'HintFontName', Screen.HintFont.Name);
		FHintFontSize := memIni.ReadInteger(WINDOW_SECTION, 'HintFontSize', Screen.HintFont.Size);
		//FHintFontBold := memIni.ReadBool(WINDOW_SECTION, 'HintFontBold', False);
		//FHintFontItalic := memIni.ReadBool(WINDOW_SECTION, 'HintFontItalic', False);
		FHintFontColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'HintFontColor', DEFAULT_FONT_COLOR));
		FHintBackColor := StringToColor(memIni.ReadString(WINDOW_SECTION, 'HintBackColor', 'clInfoBk'));
    end;
end;
{
\brief  ���͗���ǂݍ��݁i�����{���[�����{���O�j
\param  memIni  ini�t�@�C��
}
procedure TSetting.ReadInputHisotrys(memIni: TMemIniFile);
const
    SECTIONS : array[0..2] of string = ('Name', 'Mail', 'SelectText');
var
	wkList : TStringList;
    wkStr : string;
    i, j : Integer;
    listArray : array[0..2] of TStringList;
begin
    if (memIni <> nil) then begin
        listArray[0] := FNameList;
        listArray[1] := FMailList;
        listArray[2] := FSelectTextList;
        wkList := TStringList.Create;
        try
            for i := 0 to High(listArray) do begin
                memIni.ReadSection(SECTIONS[i], wkList);
                for j := 0 to wkList.Count -1 do begin
                    wkStr := memIni.ReadString(SECTIONS[i], wkList[j], '');
                    if (wkStr <> '') and
                        (listArray[i].IndexOf(wkStr) = -1) then begin
                        listArray[i].Add(wkStr);
                    end;
                end;
            end;
        finally
            wkList.Free;
        end;
    end;
end;
{
\breif  ���X�g�J�������ǂݍ���
\param  memIni  ini�t�@�C��
}
procedure TSetting.ReadListColumnWidth(memIni: TMemIniFile);
const
    SECTIONS : array[0..2] of string =
        ('BBSColumnWidth', 'CategoryColumnWidth', 'BoardColumnWidth');
	DEFAULT_BBS_WIDTH: array[0..0] of Integer = (140);
	DEFAULT_CATEGORY_WIDTH: array[0..2] of Integer = (150, 80, 130);
	DEFAULT_BOARD_WIDTH: array[0..10] of Integer = (350, 60, 60, 60, 60, 60, 80, 130, 130, 130, 60);
	MAX_WIDTH: Integer = 2000;
var
	wkList : TStringList;
    i : Integer;
begin
    if (memIni <> nil) then begin
		// ���X�g�J������
		wkList := TStringList.Create;
		try
			memIni.ReadSection(SECTIONS[0], wkList);
			if Length(FBBSColumnWidth) <> wkList.Count then begin
				memIni.EraseSection(SECTIONS[0]);
			end;
			for i := 0 to High(FBBSColumnWidth) do begin
				BBSColumnWidth[i] := memIni.ReadInteger(SECTIONS[0],
                     'ID' + IntToStr(i), DEFAULT_BBS_WIDTH[i]);
				if BBSColumnWidth[i] > MAX_WIDTH then
					BBSColumnWidth[i] := DEFAULT_BBS_WIDTH[i];
			end;
			memIni.ReadSection(SECTIONS[1], wkList);
			if Length(FCategoryColumnWidth) <> wkList.Count then begin
				memIni.EraseSection(SECTIONS[1]);
			end;
			for i := 0 to High(FCategoryColumnWidth) do begin
				CategoryColumnWidth[i] := memIni.ReadInteger(SECTIONS[1],
                     'ID' + IntToStr(i), DEFAULT_CATEGORY_WIDTH[i]);
				if CategoryColumnWidth[i] > MAX_WIDTH then
					CategoryColumnWidth[i] := DEFAULT_CATEGORY_WIDTH[i];
			end;
			memIni.ReadSection(SECTIONS[2], wkList);
			if Length(FBoardColumnWidth) <> wkList.Count then begin
				memIni.EraseSection(SECTIONS[2]);
			end;
			for i := 0 to High(FBoardColumnWidth) do begin
				BoardColumnWidth[i] := memIni.ReadInteger(SECTIONS[2],
                     'ID' + IntToStr(i), DEFAULT_BOARD_WIDTH[i]);
				if BoardColumnWidth[i] > MAX_WIDTH then
					BoardColumnWidth[i] := DEFAULT_BOARD_WIDTH[i];
			end;
		finally
			wkList.Free;
		end;
    end;
end;
//! �J�e�S�����X�g�J���������ǂݍ���
procedure TSetting.ReadOrdColumn(memIni: TMemIniFile);
var
	wkList : TStringList;
    wkStr : string;
    i, id, code : Integer;
begin
    if (memIni <> nil) then begin
		wkList := TStringList.Create;
		try
			memIni.ReadSection( 'BBSColumnOrder', wkList );
			for i := 0 to wkList.Count - 1 do begin
				wkStr := memIni.ReadString( 'BBSColumnOrder', 'ID' + IntToStr( i ), '' );
				Val( wkStr, id, code );
				if code = 0 then
					FBBSColumnOrder.Add( TGikoBBSColumnID( id ) );
			end;
			if FBBSColumnOrder.Count = 0 then begin
				// �ݒ肪�����̂ō쐬
				for i := 0 to Integer( High( TGikoBBSColumnID ) ) do
					FBBSColumnOrder.Add( TGikoBBSColumnID( i ) );
			end;

			memIni.ReadSection( 'CategoryColumnOrder', wkList );
			for i := 0 to wkList.Count - 1 do begin
				wkStr := memIni.ReadString( 'CategoryColumnOrder', 'ID' + IntToStr( i ), '' );
				Val( wkStr, id, code );
				if code = 0 then
					FCategoryColumnOrder.Add( TGikoCategoryColumnID( id ) );
			end;
			if FCategoryColumnOrder.Count = 0 then begin
				// �ݒ肪�����̂ō쐬
				for i := 0 to Integer( High( TGikoCategoryColumnID ) ) do
					FCategoryColumnOrder.Add( TGikoCategoryColumnID( i ) );
			end;

			memIni.ReadSection( 'BoardColumnOrder', wkList );
			for i := 0 to wkList.Count - 1 do begin
				wkStr := memIni.ReadString( 'BoardColumnOrder', 'ID' + IntToStr( i ), '' );
				Val( wkStr, id, code );
				if code = 0 then
					FBoardColumnOrder.Add( TGikoBoardColumnID( id ) );
			end;
			if FBoardColumnOrder.Count = 0 then begin
				// �ݒ肪�����̂ō쐬
				for i := 0 to Integer( High( TGikoBoardColumnID ) ) do begin
					// �����̃J�����̓f�t�H���g�Ŕ�\���ɂ���
					if ( i <> Ord(gbcVigor) ) then begin
						FBoardColumnOrder.Add( TGikoBoardColumnID( i ) );
					end;
				end;
			end;
		finally
			wkList.Free;
		end;
    end;
end;

function TSetting.GetCSSFileName: string;
begin
    Result := FSkinFiles.FileName;
end;
function TSetting.GetBoukenCookie(AHostName: String): String;
var
    i : Integer;
begin
    for i := 0 to FBoukenCookieList.Count - 1 do begin
        if ( AnsiPos(FBoukenCookieList.Names[i], AHostName) > 0 ) then begin
            Result := FBoukenCookieList.Values[FBoukenCookieList.Names[i]];
            Break;
        end;
    end;
end;
procedure TSetting.SetBoukenCookie(ACookieValue, AHostName: String);
var
    i : Integer;
begin
    for i := 0 to FBoukenCookieList.Count - 1 do begin
        if ( FBoukenCookieList.Names[i] = AHostName ) then begin
            FBoukenCookieList[i] := AHostName + '=' + ACookieValue;
            Break;
        end;
    end;
    if ( i = FBoukenCookieList.Count ) then begin
        FBoukenCookieList.Add(AHostName + '=' + ACookieValue);
    end;
end;
procedure TSetting.GetBouken(AHostName: String; var Domain:String; var Cookie:String);
var
    i : Integer;
begin
    Cookie := '';
    for i := 0 to FBoukenCookieList.Count - 1 do begin
        if ( AnsiPos(FBoukenCookieList.Names[i], AHostName) > 0 ) then begin
            Domain := FBoukenCookieList.Names[i];
            Cookie := FBoukenCookieList.Values[FBoukenCookieList.Names[i]];
            Break;
        end;
    end;
end;

procedure TSetting.GetDefaultIPv4Domain(dest: TStrings);
var
	i: Integer;
begin
  dest.Clear;
	for i := Low(DEFAULT_IPV4_DOMAIN) to High(DEFAULT_IPV4_DOMAIN) do
		dest.Add(DEFAULT_IPV4_DOMAIN[i]);
end;

end.

