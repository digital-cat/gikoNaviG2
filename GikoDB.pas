unit GikoDB;

(*!
\file		GikoDB.pas
\brief	�ȈՃf�[�^�x�[�X

$Id: GikoDB.pas,v 1.1 2004/10/09 15:08:43 yoffy Exp $


<h2>�f�[�^�x�[�X�t�H�[�}�b�g 0.0d1</h2>
<p>
�@2 �����̃X�v���b�h�V�[�g�ō\������A
���E�� 1 ���R�[�h�A�J���������R�[�h�̃v���p�e�B�Ƃ��Ĉ�����B<br>
�@�v���C�}���J���� (�� 1 �J����) �͕K�����j�[�N�Ȓl�ɂȂ�Ȃ���΂Ȃ�Ȃ��B
</p>

<hr>
<h3>�t�@�C���C���[�W</h3>
<table border="1" style="text-align:center">
<tr><td><a href="#header">�w�b�_</a></td></tr>
<tr><td><a href="#info">�C���t�H���[�V�����Z�N�V����</a></td></tr>
<tr><td><a href="#cols">�J�������X�g�Z�N�V����</a></td></tr>
<tr><td><a href="#atlb">�A���P�[�V�����e�[�u���Z�N�V����</a></td></tr>
<tr><td><a href="#idex">�C���f�b�N�X�Z�N�V����</a></td></tr>
<tr><td><a href="#sect">�Z�N�^�Z�N�V����</a></td></tr>
<tr><td>�c</td></tr>
<tr><td><a href="#idex">�C���f�b�N�X�Z�N�V����</a></td></tr>
<tr><td><a href="#sect">�Z�N�^�Z�N�V����</a></td></tr>
</table>
<p>
<b>�T�v</b><br>
�@FAT �t�@�C���V�X�e����͂����\���ɂȂ��Ă���B
</p>

<hr>
<a name="header"></a>
<h3>�w�b�_</h3>
<table border="1" style="text-align:center">
<tr><td>�V�O�l�`��</td><td>4 byte</td></tr>
<tr><td>���W���[�o�[�W����</td><td>1 byte</td></tr>
<tr><td>�}�C�i�[�o�[�W����</td><td>1 byte</td></tr>
<tr><td>�����[�X�i�K��</td><td>1 byte</td></tr>
<tr><td>���r�W�����i���o�[</td><td>1 byte</td></tr>
</table>
<p>
<b>�V�O�l�`��</b><br>
�@'gkdb' �������n�ɓK�����G���f�B�A���Ŋi�[����B<br>
�@���̃G���f�B�A���ŁA���R�[�h�Ɋi�[����Ă���l�̃G���f�B�A�������܂�B
</p>
<p>
<b>���W���[�o�[�W����</b><br>
�@�t�@�C���t�H�[�}�b�g�̃��W���[�o�[�W�����B
</p>
<p>
<b>�}�C�i�[�o�[�W����</b><br>
�@�t�@�C���t�H�[�}�b�g�̃}�C�i�[�o�[�W�����B
</p>
<p>
<b>�����[�X�i�K��</b><br>
�@�����[�X�̒i�K�B�l�͎��R�����A
�K���o�C�g�l�̑召���o�[�W�����̑召�Ƃ��Ĕ�r�ł��鎖�B<br />
�@�ȉ��͎Q�l�l�B
</p>
<table border="1">
<tr><td>�f�x���b�p�����[�X</td><td>0</td></tr>
<tr><td>�A���t�@�����[�X</td><td>1</td></tr>
<tr><td>�x�[�^�����[�X</td><td>2</td></tr>
<tr><td>Release Candidate</td><td>3</td></tr>
<tr><td>�v���r���[�����[�X</td><td>4</td></tr>
<tr><td>�t�@�C�i��(�}�X�^)�����[�X</td><td>5</td></tr>
</table>
<p>
<b>���r�W�����i���o�[</b><br>
�@�����[�X�ԍ��ȂǁB
</p>
<p>

<hr>
<a name="section"></a>
<h3>�Z�N�V����</h3>
<table border="1" style="text-align:center">
<tr><td>�Z�N�V�����T�C�Y</td><td>4 byte</td></tr>
<tr><td>�Z�N�V�����^�C�v</td><td>4 chars</td></tr>
<tr><td>�Z�N�V�������e</td><td>��</td></tr>
</table>
<p>
<b>�Z�N�V�����T�C�Y</b><br>
�@�Z�N�V�����S�̂̃T�C�Y�B
���݂̃A�h���X�ɃZ�N�V�����T�C�Y�����Z���鎖�Ŏ��̃Z�N�V�������w���B
�܂�u�Z�N�V�����T�C�Y�v���g�̗̈���T�C�Y�Ɋ܂܂��B<br>
�@�㑱�ɃZ�N�V�������Ȃ��ꍇ�� 0 �ɂ���B
</p>
<p>
<b>�Z�N�V�����^�C�v</b><br>
�@�Z�N�V�����̎�ނ�\�� 4 byte �̕�����B<br>
�@�g���Ȃ��Ȃ����󂫃Z�N�V������ 0 �N���A�����B
</p>

<hr>
<a name="info"></a>
<h3>�C���t�H���[�V�����Z�N�V����</h3>
<table border="1" style="text-align:center">
<tr><td>�Z�N�V�����T�C�Y</td><td>4 byte</td></tr>
<tr><td>'info'</td><td>4 chars</td></tr>
<tr><td>�Z�N�^�T�C�Y</td><td>4 byte</td></tr>
<tr><td>���R�[�h��</td><td>4 byte</td></tr>
</table>
<p>
<b>�Z�N�^�T�C�Y</b><br>
�@<a href="#sect">�Z�N�^�Z�N�V����</a>�� 1 �Z�N�^������� byte ���B�@
</p>
<p>
<b>���R�[�h��</b><br>
�@�f�[�^�x�[�X�S�̂̃��R�[�h���B�@
</p>

<hr>
<a name="cols"></a>
<h3>�J�������X�g�Z�N�V����</h3>
<table border="1" style="text-align:center">
<tr><td>�Z�N�V�����T�C�Y</td><td>4 byte</td></tr>
<tr><td>'cols'</td><td>4 chars</td></tr>
<tr><td>�J������</td><td>4 byte</td></tr>
<tr><td>�J������0</td><td>pascal string</td></tr>
<tr><td>�f�[�^�^�C�v0</td><td>4 chars</td></tr>
<tr><td>�c</td><td></td></tr>
<tr><td>�J������n</td><td>pascal string</td></tr>
<tr><td>�f�[�^�^�C�vn</td><td>4 chars</td></tr>
</table>
<p>
<b>����</b><br>
�@�����̃Z�N�V�����ɂ܂������ċL�q���鎖�͏o���܂���B
</p>
<p>
<b>�J������</b><br>
�@�㑱����J�����̌��B
</p>
<p>
<b>�J������</b><br>
�@���ۂɃA�N�Z�X����ۂɗp����J�����̖��́B<br>
�@�I�[�܂��͍폜���ꂽ�܂܍č\�z����Ă��Ȃ��J�����͋󕶎���ɂȂ��Ă���B
</p>
<p>
<b>�f�[�^�^�C�v</b><br>
�@�i�[����Ă���f�[�^�̃^�C�v�B<br>
�@�Z�N�V�����T�C�Y�ɖ����Ȃ��܂܏I������ꍇ�A
�@�ڍׂ͈ȉ��̒ʂ�B
</p>
<p>
�@�_���l�� 1 byte �����B<br>
�@���l�������f�[�^�^�C�v�ɂ��� 2 ���̐����� byte ����\���Ă���B<br>
�@pascal string �� 1 byte �̕����񒷂Ƃ���ɑ���������A
data �� 4 byte �̃f�[�^���Ƃ���ɑ����f�[�^�B<br>
�@���Ⴂ���Ă͂����Ȃ��̂��A�Z�N�V�����T�C�Y�ƈႢ�A
�f�[�^���������l�͒����Ɋ܂܂�Ă��Ȃ��B
�܂�A���̃f�[�^���w���ɂ́u�f�[�^�� + 4 byte�v�̉��Z���K�v�ɂȂ�B<br>
�@unix time �͒ʎZ�b��\���� 8 byte integer �ŁAUTC �����������B
</p>
<table border="1">
<tr><td>�_���l</td><td>'bool'</td></tr>
<tr><td rowspan="4">�����t������</td><td>'si01'</td></tr>
<tr><td>'si02'</td></tr>
<tr><td>'si04'</td></tr>
<tr><td>'si08'</td></tr>
<tr><td rowspan="4">������������</td><td>'ui01'</td></tr>
<tr><td>'ui02'</td></tr>
<tr><td>'ui04'</td></tr>
<tr><td>'ui08'</td></tr>
<tr><td rowspan="2">��������</td><td>'fp04'</td></tr>
<tr><td>'fp08'</td></tr>
<tr><td>pascal string</td><td>'pstr'</td></tr>
<tr><td>data (long string)</td><td>'data'</td></tr>
<tr><td>unix time</td><td>'time'</td></tr>
</table>

<hr>
<a name="atlb"></a>
<h3>�A���P�[�V�����e�[�u���Z�N�V����</h3>
<table border="1" style="text-align:center">
<tr><td>�Z�N�V�����T�C�Y</td><td>4 byte</td></tr>
<tr><td>'atlb'</td><td>4 chars</td></tr>
<tr><td>�p���e�[�u��</td><td>4 byte</td></tr>
<tr><td>�c</td><td></td></tr>
<tr><td>�p���e�[�u��</td><td>4 byte</td></tr>
</table>
<p>
<b>�T�v</b><br>
�@���̃e�[�u���̃C���f�b�N�X��
<a href="#sect">�Z�N�^</a>�̃C���f�b�N�X���΂ɂȂ��Ă���B
</p>
<p>
<b>����</b><br>
�@�����̃Z�N�V�����ɂ܂������ċL�q���鎖�͏o���܂���B
</p>
<p>
<b>�p���e�[�u��</b><br>
�@0 ����n�܂�A�p������A���P�[�V�����e�[�u���C���f�b�N�X�B
�p�����Ȃ��ꍇ�� 0xffffffff�B
</p>

<hr>
<a name="idex"></a>
<h3>�\�[�g�ς݃C���f�b�N�X�Z�N�V����</h3>
<table border="1" style="text-align:center">
<tr><td>�Z�N�V�����T�C�Y</td><td>4 byte</td></tr>
<tr><td>'idex'</td><td>4 chars</td></tr>
<tr><td>�J�����ԍ�</td><td>2 byte</td></tr>
<tr><td>�v���p�e�B</td><td>2 byte</td></tr>
<tr><td>�e�[�u���ԍ�</td><td>4 byte</td></tr>
<tr><td>�l</td><td>4 byte</td></tr>
<tr><td>�c</td><td></td></tr>
<tr><td>�e�[�u���ԍ�</td><td>4 byte</td></tr>
<tr><td>�l</td><td>4 byte</td></tr>
</table>
<p>
<b>�T�v</b><br>
�@���R�[�h�����̃J�����Ń\�[�g�����C���f�b�N�X�B<br>
�@���Ȃ��Ƃ��v���C�}���J�����͕K���C���f�b�N�X�������Ȃ��Ă͂Ȃ�Ȃ��B
</p>
<p>
<b>����</b><br>
�@�����̃Z�N�V�����ɂ܂������ċL�q���鎖�͏o���܂���B
</p>
<p>
<b>�J�����ԍ�</b><br>
�@0 ���琔�����J�����̃C���f�b�N�X�B�ǂ̃J�����ɑ΂���C���f�b�N�X����\���B
</p>
<p>
<b>�v���p�e�B</b><br>
�@�e bit ���ƂɃC���f�b�N�X�Ɋւ���v���p�e�B��ێ�����B<br>
�@�v���p�e�B�̈ꗗ�͈ȉ��̒ʂ�B
</p>
<table border="1">
<tr><td>0bit</td><td>�\�[�g�I�[�_�[�B0...����, 1...�~��</td></tr>
</table>
<p>
<b>�e�[�u���ԍ�</b><br>
�@0 ����n�܂�<a href="#atlb">�A���P�[�V�����e�[�u��</a>�̃C���f�b�N�X�B<br>
</p>
<p>
<b>�l</b><br>
�@���R�[�h�Ɋi�[����Ă���l�B<br>
�@���R�[�h�ɂ��l���i�[����Ă��邽�߁A
�C���f�b�N�X�����J�����͏d�����Ēl���i�[���Ă��鎖�ɂȂ�B
�l��ύX����ɂ͂����S�Ă�ύX���Ȃ��Ă͂Ȃ�Ȃ��B<br>
�@4 byte �𒴂���f�[�^�^�C�v�̃J�����́A�n�b�V���l���i�[����B
</p>

<hr>
<a name="sect"></a>
<h3>�Z�N�^�Z�N�V����</h3>
<table border="1" style="text-align:center">
<tr><td>�Z�N�V�����T�C�Y</td><td>4 byte</td></tr>
<tr><td>'sect'</td><td>4 chars</td></tr>
<tr><td>�Z�N�V�����ԍ�</td><td>4 byte</td></tr>
<tr><td>�Z�N�^0</td><td></td></tr>
<tr><td>�c</td><td></td></tr>
<tr><td>�Z�N�^n</td><td></td></tr>
</table>
<p>
<b>�Z�N�V�����ԍ�</b><br>
�@�Z�N�V�����̕��т����ʂ��邽�߂̔ԍ��ł��B<br>
�@�Z�N�^�Z�N�V��������������ꍇ�A�Z�N�V�����ԍ��̏���������
�Z�N�^�ԍ������蓖�Ă��܂��B
</p>
<p>
<b>�Z�N�^</b><br>
�@�e�J�����̒l�����Ɋi�[�����B
</p>
*)
interface

//==================================================
uses
//==================================================

	Classes, SysUtils, IniFiles,
	Windows,
	YofUtils;


//==================================================
type
//==================================================

	TGikoDB	= class;

	{!***********************************************************
	\brief �Z�N�V����
	************************************************************}
	TSection = class( TObject )
	private
		FMemory	: Pointer;			//!< �Z�N�V�����A�h���X
		FParent	: TGikoDB;

		function GetSize : Longword;
		procedure SetSize( newSize : Longword );
		function GetType : Longword;
		procedure SetType( newType : Longword );
		function GetNext : Pointer;
		function GetContents : Pointer;

	public
		constructor Create( parent : TGikoDB; const address : Pointer );

		property Memory					: Pointer		read FMemory;
		property Size						: Longword	read GetSize;
		property SectionType		: Longword	read GetType;
		property Next	 					: Pointer		read GetNext;
	end;

	{!***********************************************************
	\brief �Z�N�^�Z�N�V����
	************************************************************}
	TSector = class( TSection )
	private
		FSectionNo	: Longword;	//!< �Z�N�V�����ԍ�
		FCount			: Integer;	//!< �Z�N�^��

		function GetContents : Pointer;
		function GetSector( index : Integer ) : Pointer;

	public
		constructor Create( parent : TGikoDB; const address : Pointer );

		property Count : Integer											read FCount;
		property Sector[ index : Integer ] : Pointer	read GetSector; default;
	end;

	{!***********************************************************
	\brief �\�[�g�ς݃C���f�b�N�X�\����
	************************************************************}
	RSortIndex = record
		FATIndex	: Word;			//!< �A���P�[�V�����e�[�u���C���f�b�N�X
		FValue		: Longword;	//!< �l
	end;

	PSortIndex = ^RSortIndex;

	{!***********************************************************
	\brief �\�[�g�ς݃C���f�b�N�X
	************************************************************}
	TSortIndex = class( TSection )
	private
		FColumnIndex	 	: Word;	//!< �J�����C���f�b�N�X
		FColumnProperty	: Word;	//!< �C���f�b�N�X�v���p�e�B

		function GetContents : Pointer;
		function GetCount : Integer;
		function GetItem( index : Integer ) : PSortIndex;

	public
		constructor Create( parent : TGikoDB; const address : Pointer );

		property Count										: Integer			read GetCount;
		property Items[ index : Integer ]	: PSortIndex	read GetItem; default;
		property ColumnIndex							: Word 				read FColumnIndex;
		property ColumnProperty						: Word	 			read FColumnProperty;
	end;

	{!***********************************************************
	\brief �A���P�[�V�����e�[�u��
	************************************************************}
	TAllocationTable = class( TSection )
	private
		function GetTable( index : Integer ) : Longword;

	public
		constructor Create( parent : TGikoDB; const address : Pointer );

		property Table[ index : Integer ] : Longword read GetTable; default;
	end;

	{!***********************************************************
	\brief �J����
	************************************************************}
	TColumn = class( TObject )
	private
		FIndex	: Word;			//!< �J�����C���f�b�N�X
		FType		: Longword;	//!< �f�[�^�^�C�v

	public
		constructor Create( colIndex : Word; colType : Longword );

		property ColumnIndex	: Word			read FIndex;
		property ColumnType		: Longword	read FType;
	end;

	{!***********************************************************
	\brief �J�������X�g
	************************************************************}
	TColumnList = class( TSection )
	private
		FList				: THashedStringList;	//!< �J�������X�g�{��
		FColumnEnd	: PChar;							//!< ���̃J�����ǉ��ʒu

		function GetContents : Pointer;
		function GetColumnCount : Longword;
		procedure SetColumnCount( n : Longword );

		function GetItemFromIndex( index : Integer )					: TColumn;
		function GetItemFromColumnIndex( index : Integer )		: TColumn;
		function GetItemFromName( const columnName : string )	: TColumn;
		procedure WriteBack;

	public
		//! \todo		�폜���ꂽ�J�����ȍ~�� index ����������
		constructor Create( parent : TGikoDB; const address : Pointer );
		destructor Destroy; override;

		{!
		\warning	�����͕s��ł��B�������d�v�ȏꍇ��
							ObjectsFromColumnIndex ���g�p���ĉ������B
		}
		property Objects[ index : Integer ]					: TColumn	read GetItemFromIndex;
		{!
		\warning	�œK���ׂ̈ɁA�\�ł���� Objects ���g�p����悤�ɂ��Ă��������B
		}
		property ObjectsFromColumnIndex[ index : Integer ]	: TColumn
			read GetItemFromColumnIndex;
		property Items[ const columnName : string ]	: TColumn	read GetItemFromName; default;

		{!
		\brief	�J�����̍폜
		\param	columnName	�폜����J������
		\todo		�폜���ꂽ�J�����ȍ~�� index ����������

		columnName �����݂��Ȃ��ꍇ�A�����͖�������鎖���ۏ؂���Ă��܂��B
		}
		procedure Delete( const columnName : string );

		{!
		\brief	�J�����̒ǉ�
		\param	columnName	�ǉ�����J������
		\param	columnType	�ǉ�����J�����̃f�[�^�^�C�v

		columnName �����ɑ��݂���ꍇ�A�����͖�������鎖���ۏ؂���Ă��܂��B
		}
		procedure Add( const columnName : string; columnType : Longword );
	end;

	{!***********************************************************
	\brief �C���t�H���[�V�����Z�N�V����
	************************************************************}
	TInfomation = class( TSection )
	private
		function GetSectorSize : Longword;
		function GetRecordCount : Longword;

	public
		constructor Create( parent : TGikoDB; const address : Pointer );

		property SectorSize		: Longword	read GetSectorSize;
		property RecordCount	: Longword	read GetRecordCount;
	end;

	{!***********************************************************
	\brief ���R�[�h
	************************************************************}
	TRecord = class( TObject )
	private
		FParent		: TGikoDB;
		FSectorNo	: Longword;	//!< �Z�N�^�ԍ�

		//! \todo		�쐬��
		function GetStringByName( const columnName : string ) : string;
		//! \todo		�쐬��
		procedure SetStringByName(
			const columnName	: string;
			const value				: string );
		//! \todo		�쐬��
		function GetStringByIndex( index : Longword ) : string;
		//! \todo		�쐬��
		function GetIntegerByName( const columnName : string ) : Integer;
		//! \todo		�쐬��
		procedure SetIntegerByName(
			const columnName	: string;
			const value				: Integer );
		//! \todo		�쐬��
		function GetIntegerByIndex( index : Longword ) : Integer;

	public
		constructor Create( parent : TGikoDB; sectorNo : Longword );

		//! \brief	�l�𕶎���Ŏ擾�^�ݒ�
		property StringValue[ const columnName : string ]		: string
			read GetStringByName	write SetStringByName;

		//! \brief	�l�𐔒l�Ŏ擾�^�ݒ�
		property IntegerValue[ const columnName : string ]	: Integer
			read GetIntegerByName	write SetIntegerByName;
	end;

	{!***********************************************************
	\brief �T�|�[�g����Ă��Ȃ��f�[�^�x�[�X�t�H�[�}�b�g
	************************************************************}
	EGikoDBUnssuportedFormatError = class( Exception );

	{!***********************************************************
	\brief		�ȈՃf�[�^�x�[�X
	************************************************************}
	TGikoDB = class( TObject )
	private
		FFilePath		: string;				//!< �J�����t�@�C���̃p�X
		FFile				: TMappedFile;	//!< �f�[�^�x�[�X��ێ�����t�@�C��
		FPageSize		: Longword;			//!< �y�[�W�T�C�Y
		FSectorSize	: Integer;			//!< �Z�N�^�T�C�Y
		FSections		: TList;				//!< �Z�N�V�������X�g
		FChanged		: Boolean;			//!< FSections �̍č\�z���K�v�B

		FInfomation				: TInfomation;
		FColumnList				:	TColumnList;
		FSectors					: TList;
		FIndexes					: TList;
		FAllocationTable	: TAllocationTable;

		procedure CreateInitialSections;
		procedure ReadSections;
		procedure ReadSection0_0d1( const address : PChar );

		{!
		\brief		�Z�N�V�����̍쐬
		\warning	��ŕK�� Changed �����s���Ă��������B
		\warning	sectionSize �����]���Ɋm�ۂ���鎖������܂��B
		}
		function CreateSection(
			sectionSize : Longword;
			sectionType : Longword
		) : Pointer;

		{!
		\brief		�Z�N�V�����̊g���E�k��
		\warning	��ŕK�� Changed �����s���Ă��������B
		\warning	�����̏ꍇ�A�Z�N�V�����̃A�h���X���ς��܂��B
		\warning	section �ɋ󂫃Z�N�V�������w�肷�鎖�͏o���܂���B
							�󂫃Z�N�V�������m�ۂ���ɂ� CreateSection ���g�p���Ă��������B
		}
		procedure ReallocateSection(
			section			: TSection;
			sectionSize : Longword );

		{!
		\brief		�Z�N�V��������ǂݒ����ATGikoDB �N���X���č\�z����
		\param		force		�ǂݒ������s�K�v�Ɣ��f���ꂽ�ꍇ�������I�ɓǂݒ����܂��B
		\warning	�Z�N�V�����������ς�����ŕK�����s���Ă��������B
		\warning	�S�ẴZ�N�V�����N���X�͉������܂��B
		}
		procedure Changed( force : Boolean = False );

		{!
		\brief		�S�Z�N�^�������̃J�����̒l��T���o��
		\param		founds			���������l���񋓂����
		\param		value				�T���o���l
		\param		columnIndex	�J�����C���f�b�N�X
		\return		1 �ȏ㌩�������ꍇ�� True
		\warning	�ϒ��̒l�A�܂��� 4 byte �𒴂���l�̓n�b�V���l��n���Ă��������B
		\warning	���ۂ̒l������Ă��n�b�V���l�������ꍇ�A�����S�Ă��񋓂���܂��B
		}
		function SelectValue(
			founds			: TList;
			value				: Longword;
			columnIndex : Word = 0
		) : Boolean;

		{!
		\brief		���R�[�h���擾
		\param		primalyValue	���R�[�h�l
		\return		���R�[�h�l�Ɉ�v�������R�[�h
		\warning	�v���C�}���J���������l�ł͂Ȃ�������̏ꍇ�A���̊֐��͎��s���܂��B
		}
		function GetRecordByInteger( primalyValue : Integer ) : TRecord;

		{!
		\brief		���R�[�h���擾
		\param		primalyValue	���R�[�h��
		\return		���R�[�h���Ɉ�v�������R�[�h
		\warning	�v���C�}���J������������ł͂Ȃ����l�̏ꍇ�A���̊֐��͎��s���܂��B
		}
		function GetRecordByString( const primalyValue : string ) : TRecord;

		{!
		\brief		�Z�N�^�̃|�C���^���擾
		\param		sectorNo	�Z�N�^�ԍ�
		\return		�Z�N�^�̈ʒu���w���|�C���^
		\todo			�쐬��
		}
		function GetSector( sectorNo : Integer ) : Pointer;

	public
		{!
		\brief		�f�[�^�x�[�X�̃I�[�v��
		\param		filePath		�J���t�@�C���̃p�X
		\param		mode				fmOpenRead (�f�t�H���g) �܂��� fmOpenReadWrite
		\warning	���݂̃o�[�W�����͂��悻 2GB �܂ł��������܂���B
							���ۂ͋󂫃A�h���X��Ԃɂ��X�ɏ������Ȃ�܂��B
							�T�C�Y�Ɋւ���`�F�b�N�͍s���Ȃ��̂Œ��ӂ��Ă��������B
		\todo			MapViewOfFile �� 64bit ��Ԃ��A�N�Z�X�ł���悤�Ɋg������B

		filePath �����݂����Amode �� fmOpenReadWrite ���w�肳�ꂽ�ꍇ��
		�V�K�Ƀf�[�^�x�[�X���쐬����܂��B
		}
		constructor Create(
			const filePath	: string;
			mode						: Longword = fmOpenRead );
		destructor Destroy; override;

		{!
		\brief	���e���e�L�X�g�t�@�C���Ƀ_���v
		\param	filePath		�ۑ�����t�@�C���̃p�X
		\todo		�쐬��
		}
		procedure Dump(
			const filePath	: string );

		{!
		\brief		���R�[�h���擾
		\param		primalyValue	���R�[�h�l
		\return		���R�[�h�l�Ɉ�v�������R�[�h
		\warning	�v���C�}���J���������l�ł͂Ȃ�������̏ꍇ�A���̊֐��͎��s���܂��B
		}
		property RecordByInteger[ primalyValue : Integer ]			: TRecord
			read GetRecordByInteger;

		{!
		\brief		���R�[�h���擾
		\param		primalyValue	���R�[�h��
		\return		���R�[�h���Ɉ�v�������R�[�h
		\warning	�v���C�}���J������������ł͂Ȃ����l�̏ꍇ�A���̊֐��͎��s���܂��B
		}
		property RecordByString[ const primalyValue : string ] 	: TRecord
			read GetRecordByString;
	end;

//==================================================
implementation
//==================================================

uses
	Math;

const
	MINIMUM_PAGE_SIZE		= $10000;			//!< �ŏ��̃y�[�W�T�C�Y ( 64KB )
	SECTOR_SIZE					= $40;				//!< �Z�N�^�T�C�Y ( 64Byte )
	SIGNATURE_LITTLE_ENDIAN
											= $676b6462;	//!< 'bdkg' �f�[�^�x�[�X�V�O�l�`��
	DATABASE_VERSION		= $01000000;	//!< �o�[�W�����i���o�[ ( 0.0d1 )

	NULL_SECTION				= $00000000;	//!< ���g�p�Z�N�V����
	INFOMATION_SECTION	= $6f666e69;	//!< 'info' �C���t�H���[�V�����Z�N�V����
	COLUMN_LIST_SECTION	= $736c6f63;	//!< 'cols' �J�������X�g�Z�N�V����
	ALLOCATION_TABLE_SECTION
											= $626c7461;	//!< 'atlb' �A���P�[�V�����e�[�u���Z�N�V����
	INDEX_SECTION				= $78656469;	//!< 'idex' �C���f�b�N�X�Z�N�V����
	SECTOR_SECTION			= $74636573;	//!< 'sect' �Z�N�^�Z�N�V����
	NULL_SECTOR_NO			= $ffffffff;	//!< �I�[��\���Z�N�^�ԍ�

	TYPE_BOOL						= $6c6f6f62;	//!< 'bool' �_���l
	TYPE_INT8						= $31306973;	//!< 'si01' signed int 1 byte
	TYPE_INT16					= $32306973;	//!< 'si02'
	TYPE_INT32					= $34306973;	//!< 'si04'
	TYPE_INT64					= $38306973;	//!< 'si08'
	TYPE_UINT8					= $31306975;	//!< 'ui01' unsigned int 1 byte
	TYPE_UINT16					= $32306975;	//!< 'ui02'
	TYPE_UINT32					= $34306975;	//!< 'ui04'
	TYPE_UINT64					= $38306975;	//!< 'ui08'
	TYPE_FLOAT32				= $34306c66;	//!< 'fp04' floating point 4 byte
	TYPE_FLOAT64				= $38306c66;	//!< 'fp08'
	TYPE_PSTR						= $72747370;	//!< 'pstr' pascal string
	TYPE_DATA						= $61746164;	//!< 'data' data (long string)

	COLUMN_DELETED			= '_.-*+/DELETED+*./_-';	//!< �폜���ꂽ�J������



//************************************************************
// misc
//************************************************************

//==============================
// SortSectionsByPtr
//==============================
function SortSectionsByPtr( Item1, Item2 : Pointer ) : Integer;
begin

	Result := PChar( TSection( Item1 ).Memory ) -
		PChar( TSection( Item2 ).Memory );

end;

//==============================
// SortSectorSections
//==============================
function SortSectorSections( Item1, Item2 : Pointer ) : Integer;
begin

	Result := PChar( TSector( Item1 ).FSectionNo ) -
		PChar( TSector( Item2 ).FSectionNo );

end;



//************************************************************
// TSection class
//************************************************************

//==============================
// Create
//==============================
constructor TSection.Create( parent : TGikoDB; const address : Pointer );
begin

	FParent	:= parent;
	FMemory	:= address;

end;

//==============================
// GetSize
//==============================
function TSection.GetSize : Longword;
begin

	Result := PDword( FMemory )^;

end;

//==============================
// SetSize
//==============================
procedure TSection.SetSize( newSize : Longword );
begin

	PDword( FMemory )^ := newSize;

end;

//==============================
// GetType
//==============================
function TSection.GetType : Longword;
begin

	Result := PDword( PChar( FMemory ) + 4 )^;

end;

//==============================
// SetType
//==============================
procedure TSection.SetType( newType : Longword );
begin

	PDword( PChar( FMemory ) + 4 )^ := newType;

end;

//==============================
// GetNext
//==============================
function TSection.GetNext : Pointer;
begin

	Result := PChar( FMemory ) + Size;

end;

//==============================
// GetContents
//==============================
function TSection.GetContents : Pointer;
begin

	Result := PChar( FMemory ) + 8;

end;



//************************************************************
// TSector class
//************************************************************

//==============================
// Create
//==============================
constructor TSector.Create( parent : TGikoDB; const address : Pointer );
begin

	inherited;
	FSectionNo	:= PDWord( PChar( Memory ) + 8 )^;
	FCount			:= Size - Longword( 12 ) div SECTOR_SIZE;

end;

//==============================
// GetContents
//==============================
function TSector.GetContents : Pointer;
begin

	Result := PChar( FMemory ) + 12;

end;

//==============================
// GetSector
//==============================
function TSector.GetSector( index : Integer ) : Pointer;
begin

	Assert( (index > 0) and (index <= FCount) );
	// 8 = sizeof(section size) + sizeof(section type) + sizeof(section no) -
	//     1 base * sizeof(Longword)
	Result := PChar( GetContents ) + Longword( index ) * SECTOR_SIZE;

end;



//************************************************************
// TSortIndex class
//************************************************************

//==============================
// Create
//==============================
constructor TSortIndex.Create( parent : TGikoDB; const address : Pointer );
begin

	inherited;
	FColumnIndex		:= PWORD( PChar( Memory ) + 4 )^;
	FColumnProperty	:= PWORD( PChar( Memory ) + 6 )^;

end;

//==============================
// GetContents
//==============================
function TSortIndex.GetContents : Pointer;
begin

	Result := PChar( FMemory ) + 12;

end;

//==============================
// GetCount
//==============================
function TSortIndex.GetCount : Integer;
begin

	Result := FParent.FInfomation.RecordCount;

end;

//==============================
// GetItem
//==============================
function TSortIndex.GetItem( index : Integer ) : PSortIndex;
begin

	Result := PSortIndex( PChar( GetContents ) + index * SizeOf( RSortIndex ) );

end;



//************************************************************
// TAllocationTable class
//************************************************************

//==============================
// Create
//==============================
constructor TAllocationTable.Create( parent : TGikoDB; const address : Pointer );
begin

	inherited;

end;

function TAllocationTable.GetTable( index : Integer ) : Longword;
begin

	Result := PDword( PChar( GetContents ) + index * SizeOf( DWORD ) )^

end;



//************************************************************
// TColumn class
//************************************************************

//==============================
// Create
//==============================
constructor TColumn.Create( colIndex : Word; colType : Longword );
begin

	FIndex	:= colIndex;
	FType		:= colType;

end;



//************************************************************
// TColumnList class
//************************************************************

//==============================
// Create
//==============================
constructor TColumnList.Create( parent : TGikoDB; const address : Pointer );
var
	i, j				: Word;
	p, p2, tail	: PChar;
	l						: Integer;
	columnCount	: Longword;
	col					: TColumn;
	colType			: Longword;
	colName			: string;
begin

	inherited;
	FList							:= THashedStringList.Create;
	FList.Sorted			:= True;
	FList.Duplicates	:= dupError;
	columnCount				:= GetColumnCount;
	p									:= PChar( GetContents );
	tail							:= Next;

	j := Random( MaxInt );
	for i := 0 to columnCount - 1 do begin
		p2 := p;	// Break ���� FColumnEnd �ɉe�������Ȃ�����

		if p2 >= tail then Break;
		l				:= PByte( p2 )^;			Inc( p2 );
		if p2 + l + SizeOf( Dword ) >= tail then Break;
		colName := Copy( p2, 0, l );	p2 := p2 + l;
		colType := PDword( p2 )^;			p2 := p2 + SizeOf( colType );

		p := p2;

		if l = 0 then begin
			// �폜����Ă���J�����Ȃ̂œK���ɏd�����Ȃ����O��t����
			while true do begin
				Inc( j );
				colName := COLUMN_DELETED + IntToStr( j );
				if FList.IndexOf( colName ) < 0 then
					Break;
			end;
		end;
		col := TColumn.Create( i, colType );
		FList.AddObject( colName, col );
	end;

	FColumnEnd := p;

end;

//==============================
// Destroy
//==============================
destructor TColumnList.Destroy;
var
	i	: Integer;
begin

	for i := FList.Count - 1 downto 0 do
		FList.Objects[ i ].Free;
	FList.Free;

end;

//==============================
// GetContents
//==============================
function TColumnList.GetContents : Pointer;
begin

	Result := PChar( FMemory ) + 12;

end;

//==============================
// GetColumnCount
//==============================
function TColumnList.GetColumnCount : Longword;
begin

	Result := PDword( PChar( Memory ) + 8 )^;

end;

//==============================
// SetColumnCount
//==============================
procedure TColumnList.SetColumnCount( n : Longword );
begin

	PDword( PChar( Memory ) + 8 )^ := n;

end;

//==============================
// GetItemFromIndex
//==============================
function TColumnList.GetItemFromIndex( index : Integer )		: TColumn;
begin

	Result := TColumn( FList.Objects[ index ] );

end;

//==============================
// GetItemFromColumnIndex
//==============================
function TColumnList.GetItemFromColumnIndex( index : Integer )	: TColumn;
var
	i		: Integer;
	col	: TColumn;
begin

	Result := nil;
	for i := 0 to FList.Count - 1 do begin
		col := Objects[ i ];
		if col.ColumnIndex = index then begin
			Result := col;
			Break;
		end;
	end;

end;

//==============================
// GetItemFromName
//==============================
function TColumnList.GetItemFromName( const columnName : string )	: TColumn;
var
	i	: Integer;
begin

	i := FList.IndexOf( columnName );
	if i >= 0 then
		Result := Objects[ i ]
	else
		Result := nil;

end;

//==============================
// Delete
//==============================
procedure TColumnList.Delete( const columnName : string );
var
	i, j	: Integer;
	s			: string;
begin

	i := FList.IndexOf( columnName );
	if i >= 0 then begin
		j := Random( MaxInt );
		while true do begin
			Inc( j );
			s := COLUMN_DELETED + IntToStr( j );
			if FList.IndexOf( s ) < 0 then begin
				FList[ i ] := s;
				Break;
			end;
		end;

		WriteBack;
	end;

end;

//==============================
// Add
//==============================
procedure TColumnList.Add( const columnName : string; columnType : Longword );
var
	i, l	: Integer;
	col		: TColumn;
	p			: PChar;
begin

	i := FList.IndexOf( columnName );
	if i >= 0 then begin
		col := TColumn.Create( FList.Count, columnType );
		FList.AddObject( columnName, col );
		p := FColumnEnd;
		l := Length( columnName );
		Assert( l <= 255 );
		if 255 < l then
			Exit;
		if p + l + 5 <= Next then begin
			// �Z�N�V�����ɋ󂫂�����̂ŒǋL����
			PByte( p )^		:= l;										Inc( p );
			Move( PChar( columnName )^, p^, l );	p := p + l;
			PDword( p )^	:= columnType;					p := p + SizeOf( columnType );

			FColumnEnd		:= p;
			SetColumnCount( FList.Count );
		end else begin
			// �Z�N�V�����ɓ��肫��Ȃ��̂� WriteBack �ɔC����
			WriteBack;
		end;
	end;

end;

//==============================
// WriteBack
//==============================
procedure TColumnList.WriteBack;
var
	p, tail	: PChar;
	i, j		: Integer;
	idx, l	: Integer;
	col			: TColumn;
begin

	// �K�v�ȃZ�N�V�����T�C�Y���v�Z����
	p := PChar( GetContents );
	for i := 0 to FList.Count - 1 do begin
		p := p + 5;
		if AnsiPos( COLUMN_DELETED, FList[ i ] ) <> 1 then
			p := p + Length( FList[ i ] );
	end;

	if p > Next then
		// �Z�N�V�����T�C�Y������Ȃ��̂Ŋg��
		FParent.ReallocateSection( Self, p - Memory );

	p := PChar( GetContents );
	for i := 0 to FList.Count - 1 do begin
		// FList �̓J�������Ń\�[�g����Ă���̂�
		// ColumnIndex �ŕ��ׂ�ɂ͌������Ȃ��Ă͂Ȃ�Ȃ�
		idx := -1;
		col	:= nil;
		for j := 0 to FList.Count - 1 do begin
			col := TColumn( FList.Objects[ j ] );
			if col.ColumnIndex = i then begin
				idx := j;
				Break;
			end;
		end;
		Assert( idx <> -1 );

		if AnsiPos( COLUMN_DELETED, FList[ idx ] ) = 1 then
			l := 0
		else
			l := Length( FList[ idx ] );
		PByte( p )^		:= l;											Inc( p );
		Move( PChar( FList[ idx ] )^, p^, l );	p := p + l;
		PDWord( p )^	:= col.ColumnType;				p := p + SizeOf( DWORD );
		Assert( p <= Next );
	end;

	FColumnEnd := p;
	SetColumnCount( FList.Count );

	FParent.Changed;

end;



//************************************************************
// TInfomation class
//************************************************************

//==============================
// Create
//==============================
constructor TInfomation.Create( parent : TGikoDB; const address : Pointer );
begin

	inherited;

end;

//==============================
// GetSectorSize
//==============================
function TInfomation.GetSectorSize : Longword;
begin

	Result := PDword( PChar( GetContents ) )^;

end;

//==============================
// GetRecordCount
//==============================
function TInfomation.GetRecordCount : Longword;
begin

	Result := PDword( PChar( GetContents ) + 4 )^;
end;



//************************************************************
// TRecord class
//************************************************************

//==============================
// Create
//==============================
constructor TRecord.Create( parent : TGikoDB; sectorNo : Longword );
begin

	inherited Create;
	FParent		:= parent;
	FSectorNo	:= sectorNo;

end;

//==============================
// GetStringByName
//==============================
function TRecord.GetStringByName( const columnName : string ) : string;
begin
	//!!!!! �쐬�� !!!!!
end;

//==============================
// SetStringByName
//==============================
procedure TRecord.SetStringByName(
	const columnName	: string;
	const value				: string );
begin
	//!!!!! �쐬�� !!!!!
end;

//==============================
// GetStringByIndex
//==============================
function TRecord.GetStringByIndex( index : Longword ) : string;
begin
	//!!!!! �쐬�� !!!!!
end;

//==============================
// GetIntegerByName
//==============================
function TRecord.GetIntegerByName( const columnName : string ) : Integer;
begin
	//!!!!! �쐬�� !!!!!
end;

//==============================
// SetIntegerByName
//==============================
procedure TRecord.SetIntegerByName(
	const columnName	: string;
	const value				: Integer );
var
	col, c		: TColumn;
	sectorNo	: Integer;
	offset		: Longword;
	i					: Integer;
begin

	col				:= FParent.FColumnList[ columnName ];
	if col = nil then
		Exit;
	sectorNo	:= FSectorNo;
	offset		:= 0;

	for i := 0 to col.ColumnIndex - 1 do begin
		c := FParent.FColumnList.GetItemFromColumnIndex( i );
		case c.ColumnType of
		TYPE_BOOL, TYPE_INT8, TYPE_UINT8:				Inc( offset );
		TYPE_INT16, TYPE_UINT16:								offset := offset + 2;
		TYPE_INT32, TYPE_UINT32, TYPE_FLOAT32:	offset := offset + 4;
		TYPE_INT64, TYPE_UINT64, TYPE_FLOAT64:	offset := offset + 8;

		TYPE_PSTR:
			begin
				//!!!!! �쐬�� !!!!!
				offset := PByte( PChar( FParent.GetSector( sectorNo ) ) + offset )^;
				while offset >= FParent.FSectorSize do begin
					sectorNo := FParent.FAllocationTable[ sectorNo ];
					if sectorNo = NULL_SECTOR_NO then
						Exit;
					offset := offset - FParent.FSectorSize;
				end;
			end;

		TYPE_DATA:
			begin
				//!!!!! �쐬�� !!!!!
			end;
		end;
	end;

	//!!!!! �쐬�� !!!!!

end;

//==============================
// GetIntegerByIndex
//==============================
function TRecord.GetIntegerByIndex( index : Longword ) : Integer;
begin
	//!!!!! �쐬�� !!!!!
end;



//************************************************************
// TGikoDB class
//************************************************************

//==============================
// Create
//==============================
constructor TGikoDB.Create(
	const filePath	: string;
	mode						: Longword = fmOpenRead );
var
	info						: _SYSTEM_INFO;
	maximumSize			: Integer;
begin

	Randomize;
	FFilePath	:= ExpandUNCFileName( filePath );
	FChanged	:= False;

	GetSystemInfo( info );
	FPageSize := Max( info.dwPageSize, MINIMUM_PAGE_SIZE );
	if FileExists( filePath ) then begin
		maximumSize := 0;
		FFile := TMappedFile.Create( FFilePath, mode, maximumSize );
		ReadSections;
	end else begin
		maximumSize	:= FPageSize;
		FFile := TMappedFile.Create( FFilePath, mode, maximumSize );
		CreateInitialSections;
		ReadSections;
	end;

end;

//==============================
// Destroy
//==============================
destructor TGikoDB.Destroy;
var
	i	: Integer;
begin

	FFile.Free;
	for i := FSections.Count - 1 downto 0 do
		TObject( FSections[ i ] ).Free;
	FSections.Free;

end;

//==============================
// CreateInitialSections
//==============================
procedure TGikoDB.CreateInitialSections;
var
	i							: Integer;
	p, p2					: PChar;
	emptySize			: Longword;
	sectionCount	: Longword;
begin

	FSections	:= TList.Create;
	p					:= PChar( FFile.Memory );

	//===== �w�b�_
	// �V�O�l�`��
	PDword( p )^ := SIGNATURE_LITTLE_ENDIAN;	p := p + SizeOf( DWORD );
	// �o�[�W����
	PDword( p )^ := DATABASE_VERSION;					p := p + SizeOf( DWORD );

	//===== �C���t�H���[�V�����Z�N�V����
	p2 := p;
	// �Z�N�V�����T�C�Y
	PDword( p2 )^ := 16;											p2 := p2 + SizeOf( DWORD );
	// �Z�N�V�����^�C�v
	PDword( p2 )^ := INFOMATION_SECTION;			p2 := p2 + SizeOf( DWORD );
	// �Z�N�^�T�C�Y
	PDword( p2 )^ := SECTOR_SIZE;							p2 := p2 + SizeOf( DWORD );
	// ���R�[�h��
	PDword( p2 )^ := 0;												p2 := p2 + SizeOf( DWORD );
	p := p + PDword( p )^;

	//===== �J�������X�g�Z�N�V����
	// 1 �Z�N�^�� SECTOR_SIZE / SizeOf( DWORD ) �̃J����������ƍl���A
	// 1 �J������ 12 byte(11 ����) + 4 byte �f�[�^�^�C�v = 16 byte �����Ɖ���
	p2 := p;
	// �Z�N�V�����T�C�Y
	PDword( p2 )^	:= 8 + (SECTOR_SIZE div SizeOf( DWORD )) * 16;
																						p2 := p2 + SizeOf( DWORD );
	// �Z�N�V�����^�C�v
	PDword( p2 )^	:= COLUMN_LIST_SECTION;			p2 := p2 + SizeOf( DWORD );
	// �J������
	PDword( p2 )^	:= 0;												p2 := p2 + SizeOf( DWORD );
	p := p + PDword( p )^;

	//===== �A���P�[�V�����e�[�u���Z�N�V����
	// - 8 = allocation table section
	// -12 = index section + column no + property
	// -12 = sector section + section no
	p2 := p;
	emptySize					:= p2 - PChar( FFile.Memory ) - 8 - 12 - 12;
	// emptySize = sectionCount *
	//		(SECTOR_SIZE + allocation table + table no + value)
	// sectionCount = emptySize / (SECTOR_SIZE + 12)
	sectionCount			:= emptySize div (SECTOR_SIZE + 12);
	// �Z�N�V�����T�C�Y
	PDword( p2 )^			:= 8 + sectionCount * SizeOf( DWORD );
																						p2 := p2 + SizeOf( DWORD );
	// �Z�N�V�����^�C�v
	PDword( p2 )^			:= ALLOCATION_TABLE_SECTION;
																						p2 := p2 + SizeOf( DWORD );
	// �e�[�u��
	for i := 1 to sectionCount do begin
		PDword( p2 )^		:= 0;										p2 := p2 + SizeOf( DWORD );
	end;
	p := p + PDword( p )^;

	//===== �C���f�b�N�X�Z�N�V����
	p2 := p;
	// �Z�N�V�����T�C�Y
	PDword( p2 )^			:= 12 + sectionCount * SizeOf( DWORD ) * 2;
																						p2 := p2 + SizeOf( DWORD );
	// �Z�N�V�����^�C�v
	PDword( p2 )^			:= INDEX_SECTION;				p2 := p2 + SizeOf( DWORD );
	// �J�����ԍ� ( 2 byte ) + �v���p�e�B ( 2 byte )
	PDword( p2 )^			:= 0;										p2 := p2 + SizeOf( DWORD );
	// �e�[�u���ԍ� + �l
	for i := 1 to sectionCount * 2 do begin
		PDword( p2 )^		:= 0;										p2 := p2 + SizeOf( DWORD );
	end;
	p := p + PDword( p )^;

	//===== �Z�N�^�Z�N�V����
	p2 := p;
	// �Z�N�V�����T�C�Y
	PDword( p2 )^	:= 8 + sectionCount * SECTOR_SIZE;
																						p2 := p2 + SizeOf( DWORD );
	// �Z�N�V�����^�C�v
	PDword( p2 )^	:= SECTOR_SECTION;					p2 := p2 + SizeOf( DWORD );
	// �Z�N�V�����ԍ�
	PDword( p2 )^	:= 0;												p2 := p2 + SizeOf( DWORD );
	p := p + PDword( p )^;

	if p + 8 <= PChar( FFile.Memory ) + FFile.Size then begin
		// �I�[�L��
		PDWord( p )^			:= 0;
		PDWord( p + 4 )^	:= NULL_SECTION;
	end;

end;

//==============================
// ReadSections
//==============================
procedure TGikoDB.ReadSections;
var
	p					: PChar;
	dbVersion	: Longword;
begin

	FSections	:= TList.Create;
	p					:= FFile.Memory;
	// �V�O�l�`���̃`�F�b�N (���݂̓��g���G���f�B�A���̂�)
	if PDword( p )^ <> SIGNATURE_LITTLE_ENDIAN then
		raise EGikoDBUnssuportedFormatError.Create(
			'�f�[�^�x�[�X�̃t�H�[�}�b�g���s���ł��B' );
	p := p + SizeOf( DWORD );

	dbVersion := PDword( p )^;	p := p + SizeOf( DWORD );
	case dbVersion of
	DATABASE_VERSION:
		ReadSection0_0d1( p );
	else
		raise EGikoDBUnssuportedFormatError.Create(
			'�T�|�[�g����Ă��Ȃ��t�H�[�}�b�g�ł��B' );
	end;

end;

//==============================
// ReadSection0_0d1
//==============================
procedure TGikoDB.ReadSection0_0d1( const address : PChar );
var
	p, tail			: PChar;
	sectionSize	: Longword;
	sectionType	: Longword;
	section			: TSection;
begin

	p			:= address;
	tail	:= PChar( FFile.Memory ) + FFile.Size - 8;
	while p < tail do begin
		sectionSize := PDword( p )^;
		sectionType := PDword( p + 4 )^;
		if sectionSize = 0 then
			Break;
			
		case sectionType of
		NULL_SECTION:
			FSections.Add( TSection.Create( Self, p ) );

		INFOMATION_SECTION:
			begin
				FInfomation := TInfomation.Create( Self, p );
				FSections.Add( FInfomation );
			end;

		COLUMN_LIST_SECTION:
			begin
				FColumnList := TColumnList.Create( Self, p );
				FSections.Add( FColumnList );
			end;

		ALLOCATION_TABLE_SECTION:
			begin
				FAllocationTable := TAllocationTable.Create( Self, p );
				FSections.Add( FAllocationTable );
			end;

		INDEX_SECTION:
			begin
				section := TSortIndex.Create( Self, p );
				FIndexes.Add( section );
				FSections.Add( section );
			end;

		SECTOR_SECTION:
			begin
				section := TSector.Create( Self, p );
				FSectors.Add( section );
				FSections.Add( section );
			end;

		else
			FSections.Add( TSection.Create( Self, p ) )
		end;
		p := p + sectionSize;
	end;

end;

//==============================
// CreateSection
//==============================
function TGikoDB.CreateSection(
	sectionSize : Longword;
	sectionType : Longword
) : Pointer;
var
	i, j					: Integer;
	section				: TSection;
	emptySection	: TSection;
	emptySize			: Longword;
	emptyIndex		: Integer;
	fileSize			: Longword;
	oldBegin			: PChar;
	p							: PChar;
begin

	// �܂��͋󂫃Z�N�V������T��
	emptySection	:= nil;
	section				:= nil;
	emptyIndex		:= 0;
	// �A�������󂫗̈悪 FSection �̓Y�����ł�
	// �A�����Ă��Ȃ���΂Ȃ�Ȃ��̂Ń\�[�g
	FSections.Sort( SortSectionsByPtr );

	for i := 0 to FSections.Count - 1 do begin
		section := TSection( FSections[ i ] );
		if (section.SectionType = NULL_SECTION) then begin
			// emptySection �͘A�������󂫗̈�̐擪���w��
			if emptySection = nil then begin
				emptySection	:= section;
				emptyIndex		:= i;
			end;

			emptySize := PChar( section.Memory ) + section.Size -
				PChar( emptySection.Memory );
			if sectionSize <= emptySize then begin
				// �󂫃Z�N�V��������
				Result := emptySection.Memory;
				PDword( Result )^								:= emptySize;
				PDword( PChar( Result ) + 4 )^	:= sectionType;
				// �󂫃Z�N�V�����̍폜
				for j := i downto emptyIndex do begin
					TSection( FSections[ j ] ).Free;
					FSections.Delete( j );
				end;
				Exit; // ���󂫃Z�N�V�������폜����Ă���̂� for i �͑��s�s�\
			end;
		end else begin
			emptySection := nil;
		end;
	end;

	// �t�@�C���̖����ɂɋ󂫗̈悪���邩
	oldBegin := FFile.Memory;
	if PChar( section.Next ) + sectionSize <= oldBegin + FFile.Size then begin
		// �󂫗̈攭��
		Result := section.Next;
		PDword( Result )^								:= sectionSize;
		PDword( PChar( Result ) + 4 )^	:= sectionType;
		Exit;
	end;

	// sectionSize �𖞂����̈悪�Ȃ��̂Ńt�@�C�����g��
	FChanged	:= True;

	// �g������T�C�Y�̌v�Z
	fileSize	:= (sectionSize div FPageSize + 1) * FPageSize;

	// �g�����ăt�@�C�����J���Ȃ���
	FFile.Free;
	FFile			:= TMappedFile.Create( FFilePath, fmOpenReadWrite, fileSize );

	// �����ɒǉ�
	Result	:= PChar( FFile.Memory ) + (PChar( section.Next ) - oldBegin);
	PDword( Result )^								:= sectionSize;
	PDword( PChar( Result ) + 4 )^	:= sectionType;

	p := PChar( Result ) + sectionSize;
	if p + 8 <= PChar( FFile.Memory ) + FFile.Size then begin
		// �I�[�L��
		PDword( p )^	:= 0;					 		p := p + SizeOf( DWORD );
		PDword( p )^	:= NULL_SECTION;
	end;

end;

//==============================
// ReallocateSection
//==============================
procedure TGikoDB.ReallocateSection(
	section			: TSection;
	sectionSize : Longword );
var
	nextSection		: PChar;
	fileEnd				: PChar;
	p							: PChar;
	size					: Longword;
	sectionType		: Longword;
begin

	FChanged := True;
	fileEnd		:= PChar( FFile.Memory ) + FFile.Size;

	if sectionSize <= section.Size then begin

		// �k��
		nextSection		:= PChar( section.Next );
		section.SetSize( sectionSize );
		if 8 >= fileEnd - PChar( nextSection ) then
			// �������Ō�̃Z�N�V����
			nextSection := fileEnd;

		if 16 >= nextSection - PChar( section.Next ) then begin
			// �㑱����󂫂��������̂� section �ɘA������
			section.SetSize( nextSection - PChar( section.Memory ) );
		end else begin
			// �㑱����󂫂��傫���̂ŋ�Z�N�V�����ɂ���
			p := section.Next;
			if PDword( nextSection )^ = 0 then
				// �󂫃Z�N�V�����͍ŏI�Z�N�V����
				PDword( p )^	:= 0
			else
				// �f�Љ������󂫃Z�N�V����
				PDword( p )^	:= nextSection - p;
			PDword( p + 4 )^	:= NULL_SECTION;
		end;

	end else begin

		// �g��
		size	:= section.Size;
		p			:= PChar( section.Next );

		// section �̂�����ɘA�������󂫂�T��
		while (8 < fileEnd - p) and (size < sectionSize) do begin
			if PDword( p )^ = 0 then begin
				size := size + Longword( fileEnd - p );
				Break;
			end else if PDword( p + 4 )^ = 0 then begin
				size	:= size + PDword( p )^;
				p			:= p + PDword( p )^;
			end else begin
				Break;
			end;
		end;

		if size >= sectionSize then begin
			// �A�������󂫃Z�N�V�����Řd����
			section.SetSize( size );
		end else begin
			// �A�������󂫃Z�N�V�����Řd���Ȃ��̂ŐV�K�쐬
			size						 := section.Size;
			sectionType			 := section.SectionType;
			section.SetType( NULL_SECTION );

			p := CreateSection( sectionSize, sectionType );
			Move( PChar( section.FMemory )^, p^, size );

			section.FMemory	 := p;
		end;

	end;

end;

//==============================
// Dump
//==============================
procedure TGikoDB.Dump(
	const filePath	: string );
begin
	//!!!!! �쐬�� !!!!!
end;

//==============================
// Changed
//==============================
procedure TGikoDB.Changed( force : Boolean = False );
var
	i	: Integer;
begin

	if FChanged or force then begin
		// FSections �̊J��
		for i := FSections.Count - 1 downto 0 do
			TObject( FSections[ i ] ).Free;
		FSections.Free;

		// FSections ���č\�z
		ReadSections;
	end;

end;

//==============================
// SelectValue
//==============================
function TGikoDB.SelectValue(
	founds			: TList;
	value				: Longword;
	columnIndex : Word = 0
) : Boolean;
var
	foundIdx	: Integer;
	l, h, m 	: Integer;
	index			: TSortIndex;
begin

	Result		:= False;
	index			:= nil;
	foundIdx	:= -1;
	for l := 0 to FIndexes.Count - 1 do begin
		index := TSortIndex( FIndexes[ l ] );
		if index.ColumnIndex = columnIndex then
			Break;
	end;
	if index = nil then
		Exit;

	// �P���ȓ񕪒T��
	l := 0;
	h := index.Count;
	m := 0;
	while l < h do begin
		m := (l + h) shr 1;
		if index[ m ].FValue = value then begin
			foundIdx := m;
			founds.Add( Pointer( index[ m ].FATIndex ) );
			Break;
		end else if index[ m ].FValue < value then begin
			h := m;
		end else begin
			l := m;
		end;
	end;
	if foundIdx < 0 then
		Exit;

	for l := m - 1 downto 0 do begin
		if index[ l ].FValue <> value then
			Break;
		founds.Add( Pointer( l ) );
	end;
	for l := m + 1 downto index.Count - 1 do begin
		if index[ l ].FValue <> value then
			Break;
		founds.Add( Pointer( index[ m ].FATIndex ) );
	end;

	Result := True;

end;

//==============================
// GetRecordByInteger
//==============================
function TGikoDB.GetRecordByInteger( primalyValue : Integer ) : TRecord;
var
	founds	: TList;
	sector	: Integer;
begin

	Result	:= nil;
	founds	:= TList.Create;
	try
		if not SelectValue( founds, primalyValue ) then
			Exit;

		sector := Integer( founds[ 0 ] );
		Result := TRecord.Create( Self, FAllocationTable[ sector ] );
	finally
		founds.Free;
	end;

end;

//==============================
// GetRecordByString
//==============================
function TGikoDB.GetRecordByString( const primalyValue : string ) : TRecord;
var
	hash		: Longword;
begin

	hash 		:= GetStringHash( primalyValue );
	Result	:= GetRecordByInteger( hash );

end;

//==============================
// GetSector
//==============================
function TGikoDB.GetSector( sectorNo : Integer ) : Pointer;
begin
	//!!!!! �쐬�� !!!!!
end;

end.
