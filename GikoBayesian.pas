unit GikoBayesian;

{!
\file		GikoBayesian.pas
\brief	ベイジアンフィルタ


$Id: GikoBayesian.pas,v 1.22 2009/01/31 15:47:15 h677 Exp $
}

//! 平仮名を辞書に含めない
{$DEFINE GIKO_BAYESIAN_NO_HIRAGANA_DIC}

interface

//==================================================
uses
//==================================================
	Classes;

//==================================================
type
//==================================================

	{!***********************************************************
	\brief 単語プロパティ
	************************************************************}
	TWordInfo	= class( TObject )
	private
		FNormalWord			:	Integer;	//!< 通常の単語として登場した回数
		FImportantWord	: Integer;	//!< 注目単語として登場した回数
		FNormalText			: Integer;	//!< 通常の単語として含まれていた文章の数
		FImportantText	: Integer;	//!< 注目単語として含まれていた文章の数

	public
		property NormalWord			: Integer	read FNormalWord write FNormalWord;
		property ImportantWord	: Integer	read FImportantWord write FImportantWord;
		property NormalText			: Integer	read FNormalText write FNormalText;
		property ImportantText	: Integer	read FImportantText write FImportantText;
	end;

	{!***********************************************************
	\brief 解析済み単語プロパティ
	************************************************************}
	TWordCountInfo	= class( TObject )
	private
		FWordCount	:	Integer;	//!< 単語数

	public
		property WordCount	: Integer	read FWordCount write FWordCount;
	end;

	{!***********************************************************
	\brief 解析済み単語リスト
	************************************************************}
//	TWordCount	= class( THashedStringList )	// 激遅
	TWordCount	= class( TStringList )
	public
		constructor Create;
		destructor Destroy; override;
	end;

	{!***********************************************************
	\brief フィルタアルゴリズム
	************************************************************}
	TGikoBayesianAlgorithm =
		(gbaPaulGraham, gbaGaryRobinson, gbaGaryRobinsonFisher);

	{!***********************************************************
	\brief ベイジアンフィルタ
	************************************************************}
//	TGikoBayesian = class( THashedStringList )	// 激遅
	TGikoBayesian = class( TStringList )
	private
		FFilePath	: string;	//!< 読み込んだファイルパス
		function GetObject( const name : string ) : TWordInfo;
		procedure SetObject( const name : string; value : TWordInfo );

	public
		constructor Create;
		destructor Destroy; override;

		//! ファイルから学習履歴を読み出します
		procedure LoadFromFile( const filePath : string );

		//! ファイルに学習履歴を保存します
		procedure SaveToFile( const filePath : string );

		//! ファイルに学習履歴を保存します
		procedure Save;

		//! 単語に対する情報を取得します
		property Objects[ const name : string ] : TWordInfo
			read GetObject write SetObject; default;

		//! 文章に含まれる単語をカウントします
		procedure CountWord(
			const text	: string;
			wordCount		: TWordCount );

		{!
		\brief	Paul Graham 法に基づいて文章の注目度を決定します
		\return	文章の注目度 (注目に値しない 0.0～1.0 注目すべき)
		}
		function CalcPaulGraham( wordCount : TWordCount ) : Extended;

		{!
		\brief	GaryRobinson 法に基づいて文章の注目度を決定します
		\return	文章の注目度 (注目に値しない 0.0～1.0 注目すべき)
		}
		function CalcGaryRobinson( wordCount : TWordCount ) : Extended;

		{!
		\brief	GaryRobinson-Fisher 法に基づいて文章の注目度を決定します
		\return	文章の注目度 (注目に値しない 0.0～1.0 注目すべき)
		}
		function CalcGaryRobinsonFisher( wordCount : TWordCount ) : Extended;

		{!
		\brief	文章を解析
		\param	text					解析する文章
		\param	wordCount			解析された単語リストが返る
		\param	algorithm			注目度の決定に用いるアルゴリズムを指定します
		\return	文章の注目度 (注目に値しない 0.0～1.0 注目すべき)

		CountWord と Calcxxxxx をまとめて実行するだけです。
		}
		function Parse(
			const text				: string;
			wordCount					: TWordCount;
			algorithm					: TGikoBayesianAlgorithm = gbaGaryRobinsonFisher
		) : Extended;

		{!
		\brief	学習する
		\param	wordCount	 	Parse で解析された単語リスト
		\param	isImportant 注目すべき文章として覚えるなら True
		}
		procedure Learn(
			wordCount		 : TWordCount;
			isImportant	 : Boolean );

		{!
		\brief		学習結果を忘れる
		\param		wordCount		Parse で解析された単語リスト
		\param		isImportant	注目すべき文章として覚えられていたなら True
		\warning	学習済みの文章かどうかは確認出来ません。<br>
							Learn していない文章や isImportant が間違っている文章を
							Forget するとデータベースが破損します。<br>
							学習済みかどうかは独自に管理してください。

		全ての学習結果をクリアするわけではありません。<br>
		wordCount を得た文章 (Parse の text 引数) の学習結果のみクリアします。<br><br>

		主に注目文章と非注目文章を切り替えるために Forget -> Learn の順で使用します。
		}
		procedure	Forget(
			wordCount		: TWordCount;
			isImportant	: Boolean );
	end;

//==================================================
implementation
//==================================================

uses
	SysUtils, Math, Windows,
	MojuUtils;

const
	GIKO_BAYESIAN_FILE_VERSION	= '1.0';
{
	Modes				= (ModeWhite, ModeGraph, ModeAlpha, ModeHanKana, ModeNum,
								ModeWGraph, ModeWAlpha, ModeWNum,
								ModeWHira, ModeWKata, ModeWKanji);
}
	CharMode1 : array [ 0..255 ] of Byte =
	(
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1,
		1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
		3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1,
		1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
		3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 0,

		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 1, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
		4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
		4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
		4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	);

//************************************************************
// misc
//************************************************************

//==============================
// RemoveToken
//==============================
function RemoveToken(var s: string;const delimiter: string): string;
var
	p: Integer;
begin
	p := AnsiPos(delimiter, s);
	if p = 0 then
		Result := s
	else
		Result := Copy(s, 1, p - 1);
	s := Copy(s, Length(Result) + Length(delimiter) + 1, Length(s));
end;

//==============================
// AbsSort
//==============================
function AbsSort( p1, p2 : Pointer ) : Integer;
var
	v1, v2 : Single;
begin

	v1 := Abs( Single( p1 ) - 0.5 );
	v2 := Abs( Single( p2 ) - 0.5 );
	if v1 > v2 then
		Result := -1
	else if v1 = v2 then
		Result := 0
	else
		Result := 1;

end;

//************************************************************
// TWordCount class
//************************************************************
constructor TWordCount.Create;
begin

		Duplicates		:= dupIgnore;
		CaseSensitive	:= True;
		Sorted				:= True;

end;

destructor TWordCount.Destroy;
var
	i : Integer;
begin

	for i := Count - 1 downto 0 do
		if Objects[ i ] <> nil then
			Objects[ i ].Free;

	inherited;

end;

//************************************************************
// TGikoBayesian class
//************************************************************

//==============================
// Create
//==============================
constructor TGikoBayesian.Create;
begin

	Duplicates		:= dupIgnore;
	CaseSensitive	:= True;
	Sorted				:= True;

end;

//==============================
// Destroy
//==============================
destructor TGikoBayesian.Destroy;
var
	i : Integer;
begin

	for i := Count - 1 downto 0 do
		if inherited Objects[ i ] <> nil then
			inherited Objects[ i ].Free;

	inherited;

end;

procedure TGikoBayesian.LoadFromFile( const filePath : string );
var
	i			: Integer;
	sl		: TStringList;
	s			: string;
	name	: string;
	info	: TWordInfo;
begin

	FFilePath := filePath;

	if not FileExists( filePath ) then
		Exit;

	sl := TStringList.Create;
	try
		sl.LoadFromFile( filePath );

		for i := 1 to sl.Count - 1 do begin
			s := sl[ i ];
			name := GikoBayesian.RemoveToken( s, #1 );
			info := TWordInfo.Create;
			info.NormalWord			:= StrToIntDef( '$' + GikoBayesian.RemoveToken( s, #1 ), 0 );
			info.ImportantWord	:= StrToIntDef( '$' + GikoBayesian.RemoveToken( s, #1 ), 0 );
			info.NormalText 		:= StrToIntDef( '$' + GikoBayesian.RemoveToken( s, #1 ), 0 );
			info.ImportantText	:= StrToIntDef( '$' + GikoBayesian.RemoveToken( s, #1 ), 0 );

			AddObject( name, info );
		end;
	finally
		sl.Free;
	end;

end;

procedure TGikoBayesian.SaveToFile( const filePath : string );
var
	i			: Integer;
	sl		: TStringList;
	s			: string;
	info	: TWordInfo;
begin

	FFilePath := filePath;

	sl := TStringList.Create;
	try
		sl.BeginUpdate;
		sl.Add( GIKO_BAYESIAN_FILE_VERSION );

		for i := 0 to Count - 1 do begin
			info := TWordInfo( inherited Objects[ i ] );
			s := Strings[ i ] + #1
				 + Format('%x', [info.NormalWord]) + #1
				 + Format('%x', [info.ImportantWord]) + #1
				 + Format('%x', [info.NormalText]) + #1
				 + Format('%x', [info.ImportantText]);

			sl.Add(s);
		end;
		sl.EndUpdate;
		sl.SaveToFile( filePath );
	finally
		sl.Free;
	end;

end;

procedure TGikoBayesian.Save;
begin

	if FFilePath <> '' then
		SaveToFile( FFilePath );

end;

//==============================
// GetObject
//==============================
function TGikoBayesian.GetObject( const name : string ) : TWordInfo;
var
	idx : Integer;
begin

	if Find( name, idx ) then
		Result := TWordInfo( inherited Objects[ idx ] )
	else
		Result := nil;

end;

//==============================
// SetObject
//==============================
procedure TGikoBayesian.SetObject( const name : string; value : TWordInfo );
var
	idx : Integer;
begin

	if Find( name, idx ) then
		inherited Objects[ idx ] := value
	else
		AddObject( name, value );

end;


//==============================
// CountWord
//==============================
procedure TGikoBayesian.CountWord(
	const text	: string;
	wordCount		: TWordCount );
type
	Modes				= (ModeWhite, ModeGraph, ModeAlpha, ModeNum, ModeHanKana,
								ModeWGraph, ModeWAlpha, ModeWNum,
								ModeWHira, ModeWKata, ModeWKanji);
var
	p, tail, last			: PChar;
	mode, newMode			: Modes;
	ch								: Longword;
	chSize						: Integer;
	wHiraDelimiter		: TStringList;
	wHiraFinalDelimiter	: TStringList;
	wKanjiDelimiter		: TStringList;
	words							: TStringList;
	aWord							: string;
//	countInfo					: TWordCountInfo;

	function cutBoth( _aWord : string; _delim : TStringList ) : string;
	var
		_i			: Integer;
	begin
		for _i := 0 to _delim.Count - 1 do begin
			_aWord := CustomStringReplace(
				_aWord,
				_delim[ _i ],
				#10 + _delim[ _i ] + #10, False );
		end;
		Result := _aWord;
	end;

	function cutFirst( _aWord : string; _delim : TStringList ) : string;
	var
		_i			: Integer;
	begin
		for _i := 0 to _delim.Count - 1 do begin
			_aWord := CustomStringReplace(
				_aWord,
				_delim[ _i ],
				#10 + _delim[ _i ], False );
		end;
		Result := _aWord;
	end;

	function cutFinal( _aWord : string; _delim : TStringList ) : string;
	var
		_i			: Integer;
	begin
		for _i := 0 to _delim.Count - 1 do begin
			_aWord := CustomStringReplace(
				_aWord,
				_delim[ _i ],
				_delim[ _i ] + #10, False );
		end;
		Result := _aWord;
	end;

	procedure addWord( _dst : TWordCount; _words : TStringList );
	var
		_aWord			: string;
		_i, _idx		: Integer;
		_countInfo	: TWordCountInfo;
	begin
		for _i := 0 to _words.Count - 1 do begin
			_aWord := _words[ _i ];
			if Length( _aWord ) > 0 then begin
				if _dst.Find( _aWord, _idx ) then begin
					_countInfo := TWordCountInfo( _dst.Objects[ _idx ] );
				end else begin
					_countInfo := TWordCountInfo.Create;
					_dst.AddObject( _aWord, _countInfo );
				end;
				_countInfo.WordCount := _countInfo.WordCount + 1;
			end;
		end;
	end;

	function changeMode( _aWord : string; _mode : Modes ) : string;
	var
		_i									: Integer;
		_aWord2							: string;
		_pWord, _pWord2			: PChar;
		_pWordTail, _pFound	: PChar;
	const
		_delim : string = #10;
	begin
{$IFDEF GIKO_BAYESIAN_NO_HIRAGANA_DIC}
		if mode = ModeWHira then begin
			Result := '';
			Exit;
		end;
{$ENDIF}
		if Ord( _mode ) >= Ord( ModeWGraph ) then begin
			// 日本語
			// スペースを詰める
			_aWord := CustomStringReplace( _aWord, ' ', '', False );
			_aWord := CustomStringReplace( _aWord, '　', '', False );

			// デリミタで単語分け
			case mode of
			ModeWHira:
				begin
					_aWord := cutFinal( _aWord, wHiraFinalDelimiter );
					Result := cutBoth( _aWord, wHiraDelimiter );
				end;

			ModeWKanji:
				begin
					// デリミタで単語分け
					_aWord := cutBoth( _aWord, wKanjiDelimiter );
					// 4 byte (2 字) ずつで単語分け
					_pWord := PChar( _aWord );
					_i := Length( _aWord );
					_pWordTail := _pWord + _i;
					SetLength( _aWord2, _i + (_i shr 2) );
					_pWord2 := PChar( _aWord2 );

					while _pWord < _pWordTail do begin
						_pFound := AnsiStrPos( _pWord, PChar( _delim ) );
						if _pFound = nil then
							_pFound := _pWordTail;
						_pFound := _pFound - 3;

						while _pWord <= _pFound do begin
							CopyMemory( _pWord2, _pWord, 4 ); _pWord2[ 4 ] := #10;
							_pWord2 := _pWord2 + 5; _pWord := _pWord + 4;
						end;
						_i := _pFound + 4 - _pWord; // 4 = 3 + #10
						CopyMemory( _pWord2, _pWord, _i );
						_pWord2 := _pWord2 + _i; _pWord := _pWord + _i;
					end;
					if _pWord < _pWordTail then begin
						_i := _pWordTail - _pWord;
						CopyMemory( _pWord2, _pWord, _i );
						_pWord2 := _pWord2 + _i;
					end;
					SetLength( _aWord2, _pWord2 - PChar( _aWord2 ) );

					Result := _aWord2;
				end;

			else
				Result := _aWord;
			end;
		end else begin
			Result := _aWord;
		end;
	end;
const
	WHIRA_DELIMITER = 'を' + #10 + 'に' + #10 + 'が' + #10 + 'と' + #10 + 'から'
		+ #10 + 'へ' + #10 + 'より' + #10 + 'まで'+ #10 + 'で'
		+ #10 + 'ここ' + #10 + 'そこ' + #10 + 'どこ'
		+ #10 + 'これ' + #10 + 'それ' + #10 + 'あれ' + #10 + 'どれ'
		+ #10 + 'この' + #10 + 'その' + #10 + 'あの' + #10 + 'どの'
		+ #10 + 'こう' + #10 + 'そう' + #10 + 'ああ' + #10 + 'どう'
		+ #10 + 'こんな' + #10 + 'そんな' + #10 + 'あんな' + #10 + 'どんな'
		+ #10 + 'れた' + #10 + 'れて' + #10 + 'れれ' + #10 + 'れろ'
		+ #10 + 'れる' + #10 + 'られる'
		+ #10 + 'です' + #10 + 'ます' + #10 + 'ません'
		+ #10 + 'でした' + #10 + 'ました'
		+ #10 + 'する' + #10 + 'しない' + #10 + 'される' + #10 + 'されない'
		;
	WKANJI_DELIMITER = '的' + #10 + '性' + #10 + '式' + #10 + '化' + #10 + '法'
		+ #10 + '不' + #10 + '無' + #10 + '非' + #10 + '反'
		;
	WHIRA_FINAL_DELIMITER = 'った' + #10 + 'って'
		;{
		+ #10 + 'よって' + #10 + 'したがって' + #10 + 'なので'
		+ #10 + 'だから' + #10 + 'ですから'
		+ #10 + 'また'
		+ #10 + 'しかし' + #10 + 'だが' + #10 + 'けど' + #10 + 'けれど'
		+ #10 + 'やはり' + #10 + 'やっぱり'
		+ #10 + 'でし' + #10 + 'だろ'
		+ #10 + 'する' + #10 + 'しない' + #10 + 'した' + #10 + 'しない'
		;}
	// 'ー' を 'ぁぃぅぇぉ' に。
	HA_LINE = 'あかさたなはまやらわがざだばぱぁゎ';
	HI_LINE = 'いきしちにひみりゐぎじびぴぃ';
	HU_LINE = 'うくすつぬふむゆるぐぶぷぅ';
	HE_LINE = 'えけせてねへめれゑげべぺぇ';
	HO_LINE = 'おこそとのほもよろをごぼぽぉ';
	KA_LINE = 'アカサタナハマヤラワガザダバパァヵヮ';
	KI_LINE = 'イキシチニヒミリヰギジビピィ';
	KU_LINE = 'ウクスツヌフムユルグブプゥヴ';
	KE_LINE = 'エケセテネヘメレヱゲベペェヶ';
	KO_LINE = 'オコソトノホモヨロヲゴボポォ';
	kKanji = [$80..$A0, $E0..$ff];
begin

	wHiraDelimiter	:= TStringList.Create;
	wHiraFinalDelimiter := TStringList.Create;
	wKanjiDelimiter	:= TStringList.Create;
	words := TStringList.Create;
	try
		mode := ModeWhite;
{$IFNDEF GIKO_BAYESIAN_NO_HIRAGANA_DIC}
		wHiraDelimiter.Text := WHIRA_DELIMITER;
		wHiraFinalDelimiter.Text := WHIRA_FINAL_DELIMITER;
{$ENDIF}
		wKanjiDelimiter.Text := WKANJI_DELIMITER;
		p			:= PChar( text );
		tail	:= p + Length( text );
		last	:= p;

		while p < tail do begin
			// 文字のタイプを判別
			// ※句読点は ModeGraph になるので個別に対応しなくてもいい
//			if Byte(Byte( p^ ) - $a1) < $5e then begin
			if Byte( p^ ) in kKanji then begin
				if p + 1 < tail then begin
					ch := (PByte( p )^ shl 8) or PByte( p + 1 )^;
					case ch of
					// スペースで単語分けせずに詰める
					//$8140:							newMode := ModeWhite;
					$8141..$824e:				newMode := ModeWGraph;
					$824f..$8258:				newMode := ModeWNum;
					$8260..$829a:				newMode := ModeWAlpha;
					$829f..$82f1:				newMode := ModeWHira;
					$8340..$8396:				newMode := ModeWKata;
					else								newMode	:= ModeWKanji;
					end;
					// '゛゜ー' は平仮名、またはカタカナに含まれる
					if (mode = ModeWHira) or (mode = ModeWKata) then
						if (ch = $814a) or (ch = $814b) or (ch = $815b) then
							newMode := mode;
				end else begin
					newMode := ModeWhite;
				end;

				chSize := 2;
			end else begin
				newMode := Modes( CharMode1[ Byte( p^ ) ] );
				if (p^ = ' ') and (Ord( mode ) >= Ord( ModeWGraph )) then begin
					// 今まで日本語で今スペース
					// 単語を繋げて後でスペースを詰める
					// ※半角カナは通常スペースで区切るだろうから詰めない
					newMode := mode;
				end;

				chSize := 1;
			end;

			if mode <> newMode then begin

				// 文字のタイプが変更された
				if mode <> ModeWhite then begin
					SetLength( aWord, p - last );
					CopyMemory( PChar( aWord ), last, p - last );

					words.Text := changeMode( aWord, mode );

					// 単語登録
					addWord( wordCount, words );
				end;

				last := p;
				mode := newMode;

			end;

			p := p + chSize;
		end;	// while

		if mode <> ModeWhite then begin
			SetLength( aWord, p - last );
			CopyMemory( PChar( aWord ), last, p - last );

			words.Text := changeMode( aWord, mode );

			// 単語登録
			addWord( wordCount, words );
		end;
	finally
		words.Free;
		wKanjiDelimiter.Free;
		wHiraFinalDelimiter.Free;
		wHiraDelimiter.Free;
	end;

end;

//==============================
// CalcPaulGraham
//==============================
function TGikoBayesian.CalcPaulGraham( wordCount : TWordCount ) : Extended;

	function p( const aWord : string ) : Single;
	var
		info : TWordInfo;
	begin
		info := Objects[ aWord ];
		if info = nil then
			Result := 0.415
		else if info.NormalWord = 0 then
			Result := 0.99
		else if info.ImportantWord = 0 then
			Result := 0.01
		else if info.ImportantWord + info.NormalWord * 2 < 5 then
			Result := 0.5
		else begin
			try
				Result := ( info.ImportantWord / info.ImportantText ) /
					((info.NormalWord * 2 / info.NormalText ) +
					 (info.ImportantWord / info.ImportantText));
			except
            	on EZeroDivide do Result := 0.99;
			end;
		end;
	end;

var
	s, q				: Extended;
	i						: Integer;
	narray			: TList;
const
	SAMPLE_COUNT	= 15;
begin

	Result := 1;
	if wordCount.Count = 0 then
		Exit;

	narray := TList.Create;
	try
		for i := 0 to wordCount.Count - 1 do begin
			narray.Add( Pointer( p( wordCount[ i ] ) ) );
		end;

		narray.Sort( AbsSort );

		s := 1;
		q := 1;
		i := min( SAMPLE_COUNT, narray.Count );
		while i > 0 do begin
			Dec( i );

			s := s * Single( narray[ i ] );
			q := q * (1 - Single( narray[ i ] ));
		end;
		try
			Result := s / (s + q);
		except
            Result := 0.5;
		end;
	finally
		narray.Free;
	end;

end;

//==============================
// CalcGaryRobinson
//==============================
function TGikoBayesian.CalcGaryRobinson( wordCount : TWordCount ) : Extended;

	function p( const aWord : string ) : Single;
	var
		info : TWordInfo;
	begin
		info := Objects[ aWord ];
		if info = nil then
			Result := 0.415
		else if info.ImportantWord = 0 then
			Result := 0.01
		else if info.NormalWord = 0 then
			Result := 0.99
		else
		{
			Result := ( info.ImportantWord / info.ImportantText ) /
				((info.NormalWord / info.NormalText ) +
				 (info.ImportantWord / info.ImportantText));
		}
			try
				Result := (info.ImportantWord * info.NormalText) /
					(info.NormalWord * info.ImportantText +
					info.ImportantWord * info.NormalText);
			except
				Result := 0.5;
			end;
	end;

	function f( cnt : Integer; n, mean : Single ) : Extended;
	const
		k = 0.001;
	begin
		Result := ( (k * mean) + (cnt * n) ) / (k + cnt);
	end;

var
	n						: Extended;
	narray			: array of Single;
	mean				: Extended;
	countInfo		: TWordCountInfo;
	i						: Integer;
	P1, Q1{, R1}	: Extended;
	cnt					: Extended;
begin

	if wordCount.Count = 0 then begin
		Result := 1;
		Exit;
	end;

	SetLength( narray, wordCount.Count );
	mean := 0;
	for i := 0 to wordCount.Count - 1 do begin
		n						:= p( wordCount[ i ] );
		narray[ i ]	:= n;
		mean				:= mean + n;
	end;
	mean := mean / wordCount.Count;

	P1 := 1;
	Q1 := 1;
	for i := 0 to wordCount.Count - 1 do begin
		countInfo 	:= TWordCountInfo( wordCount.Objects[ i ] );
		n						:= f( countInfo.WordCount, narray[ i ], mean );
		P1 := P1 * ( 1 - n );
		Q1 := Q1 * n;
	end;
	cnt := wordCount.Count;
	if cnt = 0 then
		cnt := 1;
	try
		P1 := 1 - Power( P1, 1 / cnt );
	except
	end;
	try
		Q1 := 1 - Power( Q1, 1 / cnt );
	except
	end;

	if P1 + Q1 = 0 then begin
		Result := 0.5
	end else begin
		n := (P1 - Q1) / (P1 + Q1);
		Result := (1 + n) / 2;
	end;

end;

//==============================
// CalcGaryRobinsonFisher
//==============================
function TGikoBayesian.CalcGaryRobinsonFisher(
	wordCount : TWordCount
) : Extended;

	function p( const aWord : string ) : Single;
	var
		info				: TWordInfo;
	begin
		info := Objects[ aWord ];
		if info = nil then
			Result := 0.415
		else if info.ImportantWord = 0 then
			Result := 0.01
		else if info.NormalWord = 0 then
			Result := 0.99
		else
		{
			Result := ( info.ImportantWord / info.ImportantText ) /
				((info.NormalWord / info.NormalText ) +
				 (info.ImportantWord / info.ImportantText));
		}
			Result := (info.ImportantWord * info.NormalText) /
				(info.NormalWord * info.ImportantText +
				info.ImportantWord * info.NormalText);
	end;

	function f( cnt : Integer; n, mean : Single ) : Extended;
	const
		k = 0.001;
	begin
		Result := ( (k * mean) + (cnt * n) ) / (k + cnt);
	end;

	function prbx( x2, degree : Extended ) : Extended;
	begin

		Result := 0.5;

	end;

var
	n						: Extended;
	narray			: array of Single;
	mean				: Extended;
	countInfo		: TWordCountInfo;
	i						: Integer;
//	normal			: Extended;
//	important		: Extended;
	P1, Q1			: Extended;
	cnt					: Extended;
begin

	if wordCount.Count = 0 then begin
		Result := 1;
		Exit;
	end;

	SetLength( narray, wordCount.Count );
	mean := 0;
	for i := 0 to wordCount.Count - 1 do begin
		n						:= p( wordCount[ i ] );
		narray[ i ]	:= n;
		mean				:= mean + n;
	end;
	mean := mean / wordCount.Count;

	P1 := 1;
	Q1 := 1;
	for i := 0 to wordCount.Count - 1 do begin
		countInfo 	:= TWordCountInfo( wordCount.Objects[ i ] );
		n						:= f( countInfo.WordCount, narray[ i ], mean );
		P1 := P1 * ( 1 - n );
		Q1 := Q1 * n;
	end;
	cnt := wordCount.Count;
	if cnt = 0 then
		cnt := 1;
	try
		P1 := Power( P1, 1 / cnt );
	except
	end;
	try
		Q1 := Power( Q1, 1 / cnt );
	except
	end;

	P1 := 1 - prbx( -2 * Ln( P1 ), 2 * cnt );
	Q1 := 1 - prbx( -2 * Ln( Q1 ), 2 * cnt );

	Result := (1 + P1 - Q1) / 2;

end;

//==============================
// Parse
//==============================
function TGikoBayesian.Parse(
	const text				: string;
	wordCount					: TWordCount;
	algorithm					: TGikoBayesianAlgorithm
) : Extended;
begin

	CountWord( text, wordCount );
	case algorithm of
	gbaPaulGraham:		Result := CalcPaulGraham( wordCount );
	gbaGaryRobinson:	Result := CalcGaryRobinson( wordCount );
	gbaGaryRobinsonFisher:
										Result := CalcGaryRobinsonFisher( wordCount );
	else							Result := 0;
	end;

end;

//==============================
// Learn
//==============================
procedure TGikoBayesian.Learn(
	wordCount		 : TWordCount;
	isImportant	 : Boolean );
var
	aWord			: string;
	wordinfo	: TWordInfo;
	countinfo	: TWordCountInfo;
	i					: Integer;
begin

	for i := 0 to wordCount.Count - 1 do begin
		aWord := wordCount[ i ];
		wordinfo := Objects[ aWord ];
		countinfo := TWordCountInfo( wordCount.Objects[ i ] );
		if wordinfo = nil then begin
			wordinfo := TWordInfo.Create;
			Objects[ aWord ] := wordinfo;
		end;

		if isImportant then begin
			wordinfo.ImportantWord := wordinfo.ImportantWord + countinfo.WordCount;
			wordinfo.ImportantText := wordinfo.ImportantText + 1;
		end else begin
			wordinfo.NormalWord := wordinfo.NormalWord + countinfo.WordCount;
			wordinfo.NormalText := wordinfo.NormalText + 1;
		end;
	end;

end;

//==============================
// Forget
//==============================
procedure	TGikoBayesian.Forget(
	wordCount		: TWordCount;
	isImportant	: Boolean );
var
	aWord			: string;
	wordinfo	: TWordInfo;
	countinfo	: TWordCountInfo;
	i			: Integer;
begin

	for i := 0 to wordCount.Count - 1 do begin
		aWord := wordCount[ i ];
		wordinfo := Objects[ aWord ];
		if wordinfo = nil then
			Continue;

		countinfo := TWordCountInfo( wordCount.Objects[ i ] );
		if isImportant then begin
			if wordInfo.ImportantText > 0 then begin
				wordinfo.ImportantText := wordinfo.ImportantText - 1;
				wordinfo.ImportantWord := wordinfo.ImportantWord - countinfo.WordCount;
			end;
		end else begin
			if wordinfo.NormalText > 0 then begin
				wordinfo.NormalText := wordinfo.NormalText - 1;
				wordinfo.NormalWord := wordinfo.NormalWord - countinfo.WordCount;
			end;
		end;
	end;

end;

end.
