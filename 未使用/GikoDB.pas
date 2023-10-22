unit GikoDB;

(*!
\file		GikoDB.pas
\brief	簡易データベース

$Id: GikoDB.pas,v 1.1 2004/10/09 15:08:43 yoffy Exp $


<h2>データベースフォーマット 0.0d1</h2>
<p>
　2 次元のスプレッドシートで構成され、
ロウが 1 レコード、カラムがレコードのプロパティとして扱われる。<br>
　プライマリカラム (第 1 カラム) は必ずユニークな値にならなければならない。
</p>

<hr>
<h3>ファイルイメージ</h3>
<table border="1" style="text-align:center">
<tr><td><a href="#header">ヘッダ</a></td></tr>
<tr><td><a href="#info">インフォメーションセクション</a></td></tr>
<tr><td><a href="#cols">カラムリストセクション</a></td></tr>
<tr><td><a href="#atlb">アロケーションテーブルセクション</a></td></tr>
<tr><td><a href="#idex">インデックスセクション</a></td></tr>
<tr><td><a href="#sect">セクタセクション</a></td></tr>
<tr><td>…</td></tr>
<tr><td><a href="#idex">インデックスセクション</a></td></tr>
<tr><td><a href="#sect">セクタセクション</a></td></tr>
</table>
<p>
<b>概要</b><br>
　FAT ファイルシステムを模した構造になっている。
</p>

<hr>
<a name="header"></a>
<h3>ヘッダ</h3>
<table border="1" style="text-align:center">
<tr><td>シグネチャ</td><td>4 byte</td></tr>
<tr><td>メジャーバージョン</td><td>1 byte</td></tr>
<tr><td>マイナーバージョン</td><td>1 byte</td></tr>
<tr><td>リリース段階名</td><td>1 byte</td></tr>
<tr><td>リビジョンナンバー</td><td>1 byte</td></tr>
</table>
<p>
<b>シグネチャ</b><br>
　'gkdb' を処理系に適したエンディアンで格納する。<br>
　このエンディアンで、レコードに格納されている値のエンディアンが決まる。
</p>
<p>
<b>メジャーバージョン</b><br>
　ファイルフォーマットのメジャーバージョン。
</p>
<p>
<b>マイナーバージョン</b><br>
　ファイルフォーマットのマイナーバージョン。
</p>
<p>
<b>リリース段階名</b><br>
　リリースの段階。値は自由だが、
必ずバイト値の大小がバージョンの大小として比較できる事。<br />
　以下は参考値。
</p>
<table border="1">
<tr><td>デベロッパリリース</td><td>0</td></tr>
<tr><td>アルファリリース</td><td>1</td></tr>
<tr><td>ベータリリース</td><td>2</td></tr>
<tr><td>Release Candidate</td><td>3</td></tr>
<tr><td>プレビューリリース</td><td>4</td></tr>
<tr><td>ファイナル(マスタ)リリース</td><td>5</td></tr>
</table>
<p>
<b>リビジョンナンバー</b><br>
　リリース番号など。
</p>
<p>

<hr>
<a name="section"></a>
<h3>セクション</h3>
<table border="1" style="text-align:center">
<tr><td>セクションサイズ</td><td>4 byte</td></tr>
<tr><td>セクションタイプ</td><td>4 chars</td></tr>
<tr><td>セクション内容</td><td>可変</td></tr>
</table>
<p>
<b>セクションサイズ</b><br>
　セクション全体のサイズ。
現在のアドレスにセクションサイズを加算する事で次のセクションを指す。
つまり「セクションサイズ」自身の領域もサイズに含まれる。<br>
　後続にセクションがない場合は 0 にする。
</p>
<p>
<b>セクションタイプ</b><br>
　セクションの種類を表す 4 byte の文字列。<br>
　使われなくなった空きセクションは 0 クリアされる。
</p>

<hr>
<a name="info"></a>
<h3>インフォメーションセクション</h3>
<table border="1" style="text-align:center">
<tr><td>セクションサイズ</td><td>4 byte</td></tr>
<tr><td>'info'</td><td>4 chars</td></tr>
<tr><td>セクタサイズ</td><td>4 byte</td></tr>
<tr><td>レコード数</td><td>4 byte</td></tr>
</table>
<p>
<b>セクタサイズ</b><br>
　<a href="#sect">セクタセクション</a>の 1 セクタあたりの byte 数。　
</p>
<p>
<b>レコード数</b><br>
　データベース全体のレコード数。　
</p>

<hr>
<a name="cols"></a>
<h3>カラムリストセクション</h3>
<table border="1" style="text-align:center">
<tr><td>セクションサイズ</td><td>4 byte</td></tr>
<tr><td>'cols'</td><td>4 chars</td></tr>
<tr><td>カラム数</td><td>4 byte</td></tr>
<tr><td>カラム名0</td><td>pascal string</td></tr>
<tr><td>データタイプ0</td><td>4 chars</td></tr>
<tr><td>…</td><td></td></tr>
<tr><td>カラム名n</td><td>pascal string</td></tr>
<tr><td>データタイプn</td><td>4 chars</td></tr>
</table>
<p>
<b>制限</b><br>
　複数のセクションにまたがって記述する事は出来ません。
</p>
<p>
<b>カラム数</b><br>
　後続するカラムの個数。
</p>
<p>
<b>カラム名</b><br>
　実際にアクセスする際に用いるカラムの名称。<br>
　終端または削除されたまま再構築されていないカラムは空文字列になっている。
</p>
<p>
<b>データタイプ</b><br>
　格納されているデータのタイプ。<br>
　セクションサイズに満たないまま終了する場合、
　詳細は以下の通り。
</p>
<p>
　論理値は 1 byte 消費する。<br>
　数値を示すデータタイプにある 2 桁の数字は byte 数を表している。<br>
　pascal string は 1 byte の文字列長とそれに続く文字列、
data は 4 byte のデータ長とそれに続くデータ。<br>
　勘違いしてはいけないのが、セクションサイズと違い、
データ長を示す値は長さに含まれていない。
つまり、次のデータを指すには「データ長 + 4 byte」の演算が必要になる。<br>
　unix time は通算秒を表した 8 byte integer で、UTC が推奨される。
</p>
<table border="1">
<tr><td>論理値</td><td>'bool'</td></tr>
<tr><td rowspan="4">符号付き整数</td><td>'si01'</td></tr>
<tr><td>'si02'</td></tr>
<tr><td>'si04'</td></tr>
<tr><td>'si08'</td></tr>
<tr><td rowspan="4">符号無し整数</td><td>'ui01'</td></tr>
<tr><td>'ui02'</td></tr>
<tr><td>'ui04'</td></tr>
<tr><td>'ui08'</td></tr>
<tr><td rowspan="2">浮動小数</td><td>'fp04'</td></tr>
<tr><td>'fp08'</td></tr>
<tr><td>pascal string</td><td>'pstr'</td></tr>
<tr><td>data (long string)</td><td>'data'</td></tr>
<tr><td>unix time</td><td>'time'</td></tr>
</table>

<hr>
<a name="atlb"></a>
<h3>アロケーションテーブルセクション</h3>
<table border="1" style="text-align:center">
<tr><td>セクションサイズ</td><td>4 byte</td></tr>
<tr><td>'atlb'</td><td>4 chars</td></tr>
<tr><td>継続テーブル</td><td>4 byte</td></tr>
<tr><td>…</td><td></td></tr>
<tr><td>継続テーブル</td><td>4 byte</td></tr>
</table>
<p>
<b>概要</b><br>
　このテーブルのインデックスと
<a href="#sect">セクタ</a>のインデックスが対になっている。
</p>
<p>
<b>制限</b><br>
　複数のセクションにまたがって記述する事は出来ません。
</p>
<p>
<b>継続テーブル</b><br>
　0 から始まる、継続するアロケーションテーブルインデックス。
継続しない場合は 0xffffffff。
</p>

<hr>
<a name="idex"></a>
<h3>ソート済みインデックスセクション</h3>
<table border="1" style="text-align:center">
<tr><td>セクションサイズ</td><td>4 byte</td></tr>
<tr><td>'idex'</td><td>4 chars</td></tr>
<tr><td>カラム番号</td><td>2 byte</td></tr>
<tr><td>プロパティ</td><td>2 byte</td></tr>
<tr><td>テーブル番号</td><td>4 byte</td></tr>
<tr><td>値</td><td>4 byte</td></tr>
<tr><td>…</td><td></td></tr>
<tr><td>テーブル番号</td><td>4 byte</td></tr>
<tr><td>値</td><td>4 byte</td></tr>
</table>
<p>
<b>概要</b><br>
　レコードを特定のカラムでソートしたインデックス。<br>
　少なくともプライマリカラムは必ずインデックスを持たなくてはならない。
</p>
<p>
<b>制限</b><br>
　複数のセクションにまたがって記述する事は出来ません。
</p>
<p>
<b>カラム番号</b><br>
　0 から数えたカラムのインデックス。どのカラムに対するインデックスかを表す。
</p>
<p>
<b>プロパティ</b><br>
　各 bit ごとにインデックスに関するプロパティを保持する。<br>
　プロパティの一覧は以下の通り。
</p>
<table border="1">
<tr><td>0bit</td><td>ソートオーダー。0...昇順, 1...降順</td></tr>
</table>
<p>
<b>テーブル番号</b><br>
　0 から始まる<a href="#atlb">アロケーションテーブル</a>のインデックス。<br>
</p>
<p>
<b>値</b><br>
　レコードに格納されている値。<br>
　レコードにも値が格納されているため、
インデックスを持つカラムは重複して値を格納している事になる。
値を変更するにはこれら全てを変更しなくてはならない。<br>
　4 byte を超えるデータタイプのカラムは、ハッシュ値を格納する。
</p>

<hr>
<a name="sect"></a>
<h3>セクタセクション</h3>
<table border="1" style="text-align:center">
<tr><td>セクションサイズ</td><td>4 byte</td></tr>
<tr><td>'sect'</td><td>4 chars</td></tr>
<tr><td>セクション番号</td><td>4 byte</td></tr>
<tr><td>セクタ0</td><td></td></tr>
<tr><td>…</td><td></td></tr>
<tr><td>セクタn</td><td></td></tr>
</table>
<p>
<b>セクション番号</b><br>
　セクションの並びを識別するための番号です。<br>
　セクタセクションが複数ある場合、セクション番号の小さい順に
セクタ番号が割り当てられます。
</p>
<p>
<b>セクタ</b><br>
　各カラムの値が順に格納される。
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
	\brief セクション
	************************************************************}
	TSection = class( TObject )
	private
		FMemory	: Pointer;			//!< セクションアドレス
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
	\brief セクタセクション
	************************************************************}
	TSector = class( TSection )
	private
		FSectionNo	: Longword;	//!< セクション番号
		FCount			: Integer;	//!< セクタ数

		function GetContents : Pointer;
		function GetSector( index : Integer ) : Pointer;

	public
		constructor Create( parent : TGikoDB; const address : Pointer );

		property Count : Integer											read FCount;
		property Sector[ index : Integer ] : Pointer	read GetSector; default;
	end;

	{!***********************************************************
	\brief ソート済みインデックス構造体
	************************************************************}
	RSortIndex = record
		FATIndex	: Word;			//!< アロケーションテーブルインデックス
		FValue		: Longword;	//!< 値
	end;

	PSortIndex = ^RSortIndex;

	{!***********************************************************
	\brief ソート済みインデックス
	************************************************************}
	TSortIndex = class( TSection )
	private
		FColumnIndex	 	: Word;	//!< カラムインデックス
		FColumnProperty	: Word;	//!< インデックスプロパティ

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
	\brief アロケーションテーブル
	************************************************************}
	TAllocationTable = class( TSection )
	private
		function GetTable( index : Integer ) : Longword;

	public
		constructor Create( parent : TGikoDB; const address : Pointer );

		property Table[ index : Integer ] : Longword read GetTable; default;
	end;

	{!***********************************************************
	\brief カラム
	************************************************************}
	TColumn = class( TObject )
	private
		FIndex	: Word;			//!< カラムインデックス
		FType		: Longword;	//!< データタイプ

	public
		constructor Create( colIndex : Word; colType : Longword );

		property ColumnIndex	: Word			read FIndex;
		property ColumnType		: Longword	read FType;
	end;

	{!***********************************************************
	\brief カラムリスト
	************************************************************}
	TColumnList = class( TSection )
	private
		FList				: THashedStringList;	//!< カラムリスト本体
		FColumnEnd	: PChar;							//!< 次のカラム追加位置

		function GetContents : Pointer;
		function GetColumnCount : Longword;
		procedure SetColumnCount( n : Longword );

		function GetItemFromIndex( index : Integer )					: TColumn;
		function GetItemFromColumnIndex( index : Integer )		: TColumn;
		function GetItemFromName( const columnName : string )	: TColumn;
		procedure WriteBack;

	public
		//! \todo		削除されたカラム以降の index をつけかえる
		constructor Create( parent : TGikoDB; const address : Pointer );
		destructor Destroy; override;

		{!
		\warning	順序は不定です。順序が重要な場合は
							ObjectsFromColumnIndex を使用して下さい。
		}
		property Objects[ index : Integer ]					: TColumn	read GetItemFromIndex;
		{!
		\warning	最適化の為に、可能であれば Objects を使用するようにしてください。
		}
		property ObjectsFromColumnIndex[ index : Integer ]	: TColumn
			read GetItemFromColumnIndex;
		property Items[ const columnName : string ]	: TColumn	read GetItemFromName; default;

		{!
		\brief	カラムの削除
		\param	columnName	削除するカラム名
		\todo		削除されたカラム以降の index をつけかえる

		columnName が存在しない場合、処理は無視される事が保証されています。
		}
		procedure Delete( const columnName : string );

		{!
		\brief	カラムの追加
		\param	columnName	追加するカラム名
		\param	columnType	追加するカラムのデータタイプ

		columnName が既に存在する場合、処理は無視される事が保証されています。
		}
		procedure Add( const columnName : string; columnType : Longword );
	end;

	{!***********************************************************
	\brief インフォメーションセクション
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
	\brief レコード
	************************************************************}
	TRecord = class( TObject )
	private
		FParent		: TGikoDB;
		FSectorNo	: Longword;	//!< セクタ番号

		//! \todo		作成中
		function GetStringByName( const columnName : string ) : string;
		//! \todo		作成中
		procedure SetStringByName(
			const columnName	: string;
			const value				: string );
		//! \todo		作成中
		function GetStringByIndex( index : Longword ) : string;
		//! \todo		作成中
		function GetIntegerByName( const columnName : string ) : Integer;
		//! \todo		作成中
		procedure SetIntegerByName(
			const columnName	: string;
			const value				: Integer );
		//! \todo		作成中
		function GetIntegerByIndex( index : Longword ) : Integer;

	public
		constructor Create( parent : TGikoDB; sectorNo : Longword );

		//! \brief	値を文字列で取得／設定
		property StringValue[ const columnName : string ]		: string
			read GetStringByName	write SetStringByName;

		//! \brief	値を数値で取得／設定
		property IntegerValue[ const columnName : string ]	: Integer
			read GetIntegerByName	write SetIntegerByName;
	end;

	{!***********************************************************
	\brief サポートされていないデータベースフォーマット
	************************************************************}
	EGikoDBUnssuportedFormatError = class( Exception );

	{!***********************************************************
	\brief		簡易データベース
	************************************************************}
	TGikoDB = class( TObject )
	private
		FFilePath		: string;				//!< 開いたファイルのパス
		FFile				: TMappedFile;	//!< データベースを保持するファイル
		FPageSize		: Longword;			//!< ページサイズ
		FSectorSize	: Integer;			//!< セクタサイズ
		FSections		: TList;				//!< セクションリスト
		FChanged		: Boolean;			//!< FSections の再構築が必要。

		FInfomation				: TInfomation;
		FColumnList				:	TColumnList;
		FSectors					: TList;
		FIndexes					: TList;
		FAllocationTable	: TAllocationTable;

		procedure CreateInitialSections;
		procedure ReadSections;
		procedure ReadSection0_0d1( const address : PChar );

		{!
		\brief		セクションの作成
		\warning	後で必ず Changed を実行してください。
		\warning	sectionSize よりも余分に確保される事があります。
		}
		function CreateSection(
			sectionSize : Longword;
			sectionType : Longword
		) : Pointer;

		{!
		\brief		セクションの拡張・縮小
		\warning	後で必ず Changed を実行してください。
		\warning	多くの場合、セクションのアドレスが変わります。
		\warning	section に空きセクションを指定する事は出来ません。
							空きセクションを確保するには CreateSection を使用してください。
		}
		procedure ReallocateSection(
			section			: TSection;
			sectionSize : Longword );

		{!
		\brief		セクション情報を読み直し、TGikoDB クラスを再構築する
		\param		force		読み直しが不必要と判断された場合も強制的に読み直します。
		\warning	セクションを書き変えた後で必ず実行してください。
		\warning	全てのセクションクラスは解放されます。
		}
		procedure Changed( force : Boolean = False );

		{!
		\brief		全セクタから特定のカラムの値を探し出す
		\param		founds			見つかった値が列挙される
		\param		value				探し出す値
		\param		columnIndex	カラムインデックス
		\return		1 つ以上見つかった場合は True
		\warning	可変長の値、または 4 byte を超える値はハッシュ値を渡してください。
		\warning	実際の値が違ってもハッシュ値が同じ場合、それら全てが列挙されます。
		}
		function SelectValue(
			founds			: TList;
			value				: Longword;
			columnIndex : Word = 0
		) : Boolean;

		{!
		\brief		レコードを取得
		\param		primalyValue	レコード値
		\return		レコード値に一致したレコード
		\warning	プライマリカラムが数値ではなく文字列の場合、この関数は失敗します。
		}
		function GetRecordByInteger( primalyValue : Integer ) : TRecord;

		{!
		\brief		レコードを取得
		\param		primalyValue	レコード名
		\return		レコード名に一致したレコード
		\warning	プライマリカラムが文字列ではなく数値の場合、この関数は失敗します。
		}
		function GetRecordByString( const primalyValue : string ) : TRecord;

		{!
		\brief		セクタのポインタを取得
		\param		sectorNo	セクタ番号
		\return		セクタの位置を指すポインタ
		\todo			作成中
		}
		function GetSector( sectorNo : Integer ) : Pointer;

	public
		{!
		\brief		データベースのオープン
		\param		filePath		開くファイルのパス
		\param		mode				fmOpenRead (デフォルト) または fmOpenReadWrite
		\warning	現在のバージョンはおよそ 2GB までしか扱えません。
							実際は空きアドレス空間により更に小さくなります。
							サイズに関するチェックは行われないので注意してください。
		\todo			MapViewOfFile で 64bit 空間をアクセスできるように拡張する。

		filePath が存在せず、mode に fmOpenReadWrite が指定された場合は
		新規にデータベースが作成されます。
		}
		constructor Create(
			const filePath	: string;
			mode						: Longword = fmOpenRead );
		destructor Destroy; override;

		{!
		\brief	内容をテキストファイルにダンプ
		\param	filePath		保存するファイルのパス
		\todo		作成中
		}
		procedure Dump(
			const filePath	: string );

		{!
		\brief		レコードを取得
		\param		primalyValue	レコード値
		\return		レコード値に一致したレコード
		\warning	プライマリカラムが数値ではなく文字列の場合、この関数は失敗します。
		}
		property RecordByInteger[ primalyValue : Integer ]			: TRecord
			read GetRecordByInteger;

		{!
		\brief		レコードを取得
		\param		primalyValue	レコード名
		\return		レコード名に一致したレコード
		\warning	プライマリカラムが文字列ではなく数値の場合、この関数は失敗します。
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
	MINIMUM_PAGE_SIZE		= $10000;			//!< 最小のページサイズ ( 64KB )
	SECTOR_SIZE					= $40;				//!< セクタサイズ ( 64Byte )
	SIGNATURE_LITTLE_ENDIAN
											= $676b6462;	//!< 'bdkg' データベースシグネチャ
	DATABASE_VERSION		= $01000000;	//!< バージョンナンバー ( 0.0d1 )

	NULL_SECTION				= $00000000;	//!< 未使用セクション
	INFOMATION_SECTION	= $6f666e69;	//!< 'info' インフォメーションセクション
	COLUMN_LIST_SECTION	= $736c6f63;	//!< 'cols' カラムリストセクション
	ALLOCATION_TABLE_SECTION
											= $626c7461;	//!< 'atlb' アロケーションテーブルセクション
	INDEX_SECTION				= $78656469;	//!< 'idex' インデックスセクション
	SECTOR_SECTION			= $74636573;	//!< 'sect' セクタセクション
	NULL_SECTOR_NO			= $ffffffff;	//!< 終端を表すセクタ番号

	TYPE_BOOL						= $6c6f6f62;	//!< 'bool' 論理値
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

	COLUMN_DELETED			= '_.-*+/DELETED+*./_-';	//!< 削除されたカラム名



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
		p2 := p;	// Break 時に FColumnEnd に影響させないため

		if p2 >= tail then Break;
		l				:= PByte( p2 )^;			Inc( p2 );
		if p2 + l + SizeOf( Dword ) >= tail then Break;
		colName := Copy( p2, 0, l );	p2 := p2 + l;
		colType := PDword( p2 )^;			p2 := p2 + SizeOf( colType );

		p := p2;

		if l = 0 then begin
			// 削除されているカラムなので適当に重複しない名前を付ける
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
			// セクションに空きがあるので追記する
			PByte( p )^		:= l;										Inc( p );
			Move( PChar( columnName )^, p^, l );	p := p + l;
			PDword( p )^	:= columnType;					p := p + SizeOf( columnType );

			FColumnEnd		:= p;
			SetColumnCount( FList.Count );
		end else begin
			// セクションに入りきらないので WriteBack に任せる
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

	// 必要なセクションサイズを計算する
	p := PChar( GetContents );
	for i := 0 to FList.Count - 1 do begin
		p := p + 5;
		if AnsiPos( COLUMN_DELETED, FList[ i ] ) <> 1 then
			p := p + Length( FList[ i ] );
	end;

	if p > Next then
		// セクションサイズが足らないので拡張
		FParent.ReallocateSection( Self, p - Memory );

	p := PChar( GetContents );
	for i := 0 to FList.Count - 1 do begin
		// FList はカラム名でソートされているので
		// ColumnIndex で並べるには検索しなくてはならない
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
	//!!!!! 作成中 !!!!!
end;

//==============================
// SetStringByName
//==============================
procedure TRecord.SetStringByName(
	const columnName	: string;
	const value				: string );
begin
	//!!!!! 作成中 !!!!!
end;

//==============================
// GetStringByIndex
//==============================
function TRecord.GetStringByIndex( index : Longword ) : string;
begin
	//!!!!! 作成中 !!!!!
end;

//==============================
// GetIntegerByName
//==============================
function TRecord.GetIntegerByName( const columnName : string ) : Integer;
begin
	//!!!!! 作成中 !!!!!
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
				//!!!!! 作成中 !!!!!
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
				//!!!!! 作成中 !!!!!
			end;
		end;
	end;

	//!!!!! 作成中 !!!!!

end;

//==============================
// GetIntegerByIndex
//==============================
function TRecord.GetIntegerByIndex( index : Longword ) : Integer;
begin
	//!!!!! 作成中 !!!!!
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

	//===== ヘッダ
	// シグネチャ
	PDword( p )^ := SIGNATURE_LITTLE_ENDIAN;	p := p + SizeOf( DWORD );
	// バージョン
	PDword( p )^ := DATABASE_VERSION;					p := p + SizeOf( DWORD );

	//===== インフォメーションセクション
	p2 := p;
	// セクションサイズ
	PDword( p2 )^ := 16;											p2 := p2 + SizeOf( DWORD );
	// セクションタイプ
	PDword( p2 )^ := INFOMATION_SECTION;			p2 := p2 + SizeOf( DWORD );
	// セクタサイズ
	PDword( p2 )^ := SECTOR_SIZE;							p2 := p2 + SizeOf( DWORD );
	// レコード数
	PDword( p2 )^ := 0;												p2 := p2 + SizeOf( DWORD );
	p := p + PDword( p )^;

	//===== カラムリストセクション
	// 1 セクタに SECTOR_SIZE / SizeOf( DWORD ) 個のカラムが入ると考え、
	// 1 カラムに 12 byte(11 文字) + 4 byte データタイプ = 16 byte 消費すると仮定
	p2 := p;
	// セクションサイズ
	PDword( p2 )^	:= 8 + (SECTOR_SIZE div SizeOf( DWORD )) * 16;
																						p2 := p2 + SizeOf( DWORD );
	// セクションタイプ
	PDword( p2 )^	:= COLUMN_LIST_SECTION;			p2 := p2 + SizeOf( DWORD );
	// カラム数
	PDword( p2 )^	:= 0;												p2 := p2 + SizeOf( DWORD );
	p := p + PDword( p )^;

	//===== アロケーションテーブルセクション
	// - 8 = allocation table section
	// -12 = index section + column no + property
	// -12 = sector section + section no
	p2 := p;
	emptySize					:= p2 - PChar( FFile.Memory ) - 8 - 12 - 12;
	// emptySize = sectionCount *
	//		(SECTOR_SIZE + allocation table + table no + value)
	// sectionCount = emptySize / (SECTOR_SIZE + 12)
	sectionCount			:= emptySize div (SECTOR_SIZE + 12);
	// セクションサイズ
	PDword( p2 )^			:= 8 + sectionCount * SizeOf( DWORD );
																						p2 := p2 + SizeOf( DWORD );
	// セクションタイプ
	PDword( p2 )^			:= ALLOCATION_TABLE_SECTION;
																						p2 := p2 + SizeOf( DWORD );
	// テーブル
	for i := 1 to sectionCount do begin
		PDword( p2 )^		:= 0;										p2 := p2 + SizeOf( DWORD );
	end;
	p := p + PDword( p )^;

	//===== インデックスセクション
	p2 := p;
	// セクションサイズ
	PDword( p2 )^			:= 12 + sectionCount * SizeOf( DWORD ) * 2;
																						p2 := p2 + SizeOf( DWORD );
	// セクションタイプ
	PDword( p2 )^			:= INDEX_SECTION;				p2 := p2 + SizeOf( DWORD );
	// カラム番号 ( 2 byte ) + プロパティ ( 2 byte )
	PDword( p2 )^			:= 0;										p2 := p2 + SizeOf( DWORD );
	// テーブル番号 + 値
	for i := 1 to sectionCount * 2 do begin
		PDword( p2 )^		:= 0;										p2 := p2 + SizeOf( DWORD );
	end;
	p := p + PDword( p )^;

	//===== セクタセクション
	p2 := p;
	// セクションサイズ
	PDword( p2 )^	:= 8 + sectionCount * SECTOR_SIZE;
																						p2 := p2 + SizeOf( DWORD );
	// セクションタイプ
	PDword( p2 )^	:= SECTOR_SECTION;					p2 := p2 + SizeOf( DWORD );
	// セクション番号
	PDword( p2 )^	:= 0;												p2 := p2 + SizeOf( DWORD );
	p := p + PDword( p )^;

	if p + 8 <= PChar( FFile.Memory ) + FFile.Size then begin
		// 終端記号
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
	// シグネチャのチェック (現在はリトルエンディアンのみ)
	if PDword( p )^ <> SIGNATURE_LITTLE_ENDIAN then
		raise EGikoDBUnssuportedFormatError.Create(
			'データベースのフォーマットが不明です。' );
	p := p + SizeOf( DWORD );

	dbVersion := PDword( p )^;	p := p + SizeOf( DWORD );
	case dbVersion of
	DATABASE_VERSION:
		ReadSection0_0d1( p );
	else
		raise EGikoDBUnssuportedFormatError.Create(
			'サポートされていないフォーマットです。' );
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

	// まずは空きセクションを探す
	emptySection	:= nil;
	section				:= nil;
	emptyIndex		:= 0;
	// 連続した空き領域が FSection の添え字でも
	// 連続していなければならないのでソート
	FSections.Sort( SortSectionsByPtr );

	for i := 0 to FSections.Count - 1 do begin
		section := TSection( FSections[ i ] );
		if (section.SectionType = NULL_SECTION) then begin
			// emptySection は連続した空き領域の先頭を指す
			if emptySection = nil then begin
				emptySection	:= section;
				emptyIndex		:= i;
			end;

			emptySize := PChar( section.Memory ) + section.Size -
				PChar( emptySection.Memory );
			if sectionSize <= emptySize then begin
				// 空きセクション発見
				Result := emptySection.Memory;
				PDword( Result )^								:= emptySize;
				PDword( PChar( Result ) + 4 )^	:= sectionType;
				// 空きセクションの削除
				for j := i downto emptyIndex do begin
					TSection( FSections[ j ] ).Free;
					FSections.Delete( j );
				end;
				Exit; // ※空きセクションが削除されているので for i は続行不可能
			end;
		end else begin
			emptySection := nil;
		end;
	end;

	// ファイルの末尾にに空き領域があるか
	oldBegin := FFile.Memory;
	if PChar( section.Next ) + sectionSize <= oldBegin + FFile.Size then begin
		// 空き領域発見
		Result := section.Next;
		PDword( Result )^								:= sectionSize;
		PDword( PChar( Result ) + 4 )^	:= sectionType;
		Exit;
	end;

	// sectionSize を満たす領域がないのでファイルを拡張
	FChanged	:= True;

	// 拡張するサイズの計算
	fileSize	:= (sectionSize div FPageSize + 1) * FPageSize;

	// 拡張してファイルを開きなおし
	FFile.Free;
	FFile			:= TMappedFile.Create( FFilePath, fmOpenReadWrite, fileSize );

	// 末尾に追加
	Result	:= PChar( FFile.Memory ) + (PChar( section.Next ) - oldBegin);
	PDword( Result )^								:= sectionSize;
	PDword( PChar( Result ) + 4 )^	:= sectionType;

	p := PChar( Result ) + sectionSize;
	if p + 8 <= PChar( FFile.Memory ) + FFile.Size then begin
		// 終端記号
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

		// 縮小
		nextSection		:= PChar( section.Next );
		section.SetSize( sectionSize );
		if 8 >= fileEnd - PChar( nextSection ) then
			// ここが最後のセクション
			nextSection := fileEnd;

		if 16 >= nextSection - PChar( section.Next ) then begin
			// 後続する空きが小さいので section に連結する
			section.SetSize( nextSection - PChar( section.Memory ) );
		end else begin
			// 後続する空きが大きいので空セクションにする
			p := section.Next;
			if PDword( nextSection )^ = 0 then
				// 空きセクションは最終セクション
				PDword( p )^	:= 0
			else
				// 断片化した空きセクション
				PDword( p )^	:= nextSection - p;
			PDword( p + 4 )^	:= NULL_SECTION;
		end;

	end else begin

		// 拡張
		size	:= section.Size;
		p			:= PChar( section.Next );

		// section のすぐ後に連続した空きを探す
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
			// 連続した空きセクションで賄える
			section.SetSize( size );
		end else begin
			// 連続した空きセクションで賄えないので新規作成
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
	//!!!!! 作成中 !!!!!
end;

//==============================
// Changed
//==============================
procedure TGikoDB.Changed( force : Boolean = False );
var
	i	: Integer;
begin

	if FChanged or force then begin
		// FSections の開放
		for i := FSections.Count - 1 downto 0 do
			TObject( FSections[ i ] ).Free;
		FSections.Free;

		// FSections を再構築
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

	// 単純な二分探索
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
	//!!!!! 作成中 !!!!!
end;

end.
