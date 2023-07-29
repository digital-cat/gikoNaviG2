unit GikoBayesian;

{!
\file		GikoBayesian.pas
\brief	�x�C�W�A���t�B���^


$Id: GikoBayesian.pas,v 1.22 2009/01/31 15:47:15 h677 Exp $
}

//! �������������Ɋ܂߂Ȃ�
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
	\brief �P��v���p�e�B
	************************************************************}
	TWordInfo	= class( TObject )
	private
		FNormalWord			:	Integer;	//!< �ʏ�̒P��Ƃ��ēo�ꂵ����
		FImportantWord	: Integer;	//!< ���ڒP��Ƃ��ēo�ꂵ����
		FNormalText			: Integer;	//!< �ʏ�̒P��Ƃ��Ċ܂܂�Ă������͂̐�
		FImportantText	: Integer;	//!< ���ڒP��Ƃ��Ċ܂܂�Ă������͂̐�

	public
		property NormalWord			: Integer	read FNormalWord write FNormalWord;
		property ImportantWord	: Integer	read FImportantWord write FImportantWord;
		property NormalText			: Integer	read FNormalText write FNormalText;
		property ImportantText	: Integer	read FImportantText write FImportantText;
	end;

	{!***********************************************************
	\brief ��͍ςݒP��v���p�e�B
	************************************************************}
	TWordCountInfo	= class( TObject )
	private
		FWordCount	:	Integer;	//!< �P�ꐔ

	public
		property WordCount	: Integer	read FWordCount write FWordCount;
	end;

	{!***********************************************************
	\brief ��͍ςݒP�ꃊ�X�g
	************************************************************}
//	TWordCount	= class( THashedStringList )	// ���x
	TWordCount	= class( TStringList )
	public
		constructor Create;
		destructor Destroy; override;
	end;

	{!***********************************************************
	\brief �t�B���^�A���S���Y��
	************************************************************}
	TGikoBayesianAlgorithm =
		(gbaPaulGraham, gbaGaryRobinson, gbaGaryRobinsonFisher);

	{!***********************************************************
	\brief �x�C�W�A���t�B���^
	************************************************************}
//	TGikoBayesian = class( THashedStringList )	// ���x
	TGikoBayesian = class( TStringList )
	private
		FFilePath	: string;	//!< �ǂݍ��񂾃t�@�C���p�X
		function GetObject( const name : string ) : TWordInfo;
		procedure SetObject( const name : string; value : TWordInfo );

	public
		constructor Create;
		destructor Destroy; override;

		//! �t�@�C������w�K������ǂݏo���܂�
		procedure LoadFromFile( const filePath : string );

		//! �t�@�C���Ɋw�K������ۑ����܂�
		procedure SaveToFile( const filePath : string );

		//! �t�@�C���Ɋw�K������ۑ����܂�
		procedure Save;

		//! �P��ɑ΂�������擾���܂�
		property Objects[ const name : string ] : TWordInfo
			read GetObject write SetObject; default;

		//! ���͂Ɋ܂܂��P����J�E���g���܂�
		procedure CountWord(
			const text	: string;
			wordCount		: TWordCount );

		{!
		\brief	Paul Graham �@�Ɋ�Â��ĕ��͂̒��ړx�����肵�܂�
		\return	���͂̒��ړx (���ڂɒl���Ȃ� 0.0�`1.0 ���ڂ��ׂ�)
		}
		function CalcPaulGraham( wordCount : TWordCount ) : Extended;

		{!
		\brief	GaryRobinson �@�Ɋ�Â��ĕ��͂̒��ړx�����肵�܂�
		\return	���͂̒��ړx (���ڂɒl���Ȃ� 0.0�`1.0 ���ڂ��ׂ�)
		}
		function CalcGaryRobinson( wordCount : TWordCount ) : Extended;

		{!
		\brief	GaryRobinson-Fisher �@�Ɋ�Â��ĕ��͂̒��ړx�����肵�܂�
		\return	���͂̒��ړx (���ڂɒl���Ȃ� 0.0�`1.0 ���ڂ��ׂ�)
		}
		function CalcGaryRobinsonFisher( wordCount : TWordCount ) : Extended;

		{!
		\brief	���͂����
		\param	text					��͂��镶��
		\param	wordCount			��͂��ꂽ�P�ꃊ�X�g���Ԃ�
		\param	algorithm			���ړx�̌���ɗp����A���S���Y�����w�肵�܂�
		\return	���͂̒��ړx (���ڂɒl���Ȃ� 0.0�`1.0 ���ڂ��ׂ�)

		CountWord �� Calcxxxxx ���܂Ƃ߂Ď��s���邾���ł��B
		}
		function Parse(
			const text				: string;
			wordCount					: TWordCount;
			algorithm					: TGikoBayesianAlgorithm = gbaGaryRobinsonFisher
		) : Extended;

		{!
		\brief	�w�K����
		\param	wordCount	 	Parse �ŉ�͂��ꂽ�P�ꃊ�X�g
		\param	isImportant ���ڂ��ׂ����͂Ƃ��Ċo����Ȃ� True
		}
		procedure Learn(
			wordCount		 : TWordCount;
			isImportant	 : Boolean );

		{!
		\brief		�w�K���ʂ�Y���
		\param		wordCount		Parse �ŉ�͂��ꂽ�P�ꃊ�X�g
		\param		isImportant	���ڂ��ׂ����͂Ƃ��Ċo�����Ă����Ȃ� True
		\warning	�w�K�ς݂̕��͂��ǂ����͊m�F�o���܂���B<br>
							Learn ���Ă��Ȃ����͂� isImportant ���Ԉ���Ă��镶�͂�
							Forget ����ƃf�[�^�x�[�X���j�����܂��B<br>
							�w�K�ς݂��ǂ����͓Ǝ��ɊǗ����Ă��������B

		�S�Ă̊w�K���ʂ��N���A����킯�ł͂���܂���B<br>
		wordCount �𓾂����� (Parse �� text ����) �̊w�K���ʂ̂݃N���A���܂��B<br><br>

		��ɒ��ڕ��͂Ɣ񒍖ڕ��͂�؂�ւ��邽�߂� Forget -> Learn �̏��Ŏg�p���܂��B
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
			// ���{��
			// �X�y�[�X���l�߂�
			_aWord := CustomStringReplace( _aWord, ' ', '', False );
			_aWord := CustomStringReplace( _aWord, '�@', '', False );

			// �f���~�^�ŒP�ꕪ��
			case mode of
			ModeWHira:
				begin
					_aWord := cutFinal( _aWord, wHiraFinalDelimiter );
					Result := cutBoth( _aWord, wHiraDelimiter );
				end;

			ModeWKanji:
				begin
					// �f���~�^�ŒP�ꕪ��
					_aWord := cutBoth( _aWord, wKanjiDelimiter );
					// 4 byte (2 ��) ���ŒP�ꕪ��
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
	WHIRA_DELIMITER = '��' + #10 + '��' + #10 + '��' + #10 + '��' + #10 + '����'
		+ #10 + '��' + #10 + '���' + #10 + '�܂�'+ #10 + '��'
		+ #10 + '����' + #10 + '����' + #10 + '�ǂ�'
		+ #10 + '����' + #10 + '����' + #10 + '����' + #10 + '�ǂ�'
		+ #10 + '����' + #10 + '����' + #10 + '����' + #10 + '�ǂ�'
		+ #10 + '����' + #10 + '����' + #10 + '����' + #10 + '�ǂ�'
		+ #10 + '�����' + #10 + '�����' + #10 + '�����' + #10 + '�ǂ��'
		+ #10 + '�ꂽ' + #10 + '���' + #10 + '���' + #10 + '���'
		+ #10 + '���' + #10 + '����'
		+ #10 + '�ł�' + #10 + '�܂�' + #10 + '�܂���'
		+ #10 + '�ł���' + #10 + '�܂���'
		+ #10 + '����' + #10 + '���Ȃ�' + #10 + '�����' + #10 + '����Ȃ�'
		;
	WKANJI_DELIMITER = '�I' + #10 + '��' + #10 + '��' + #10 + '��' + #10 + '�@'
		+ #10 + '�s' + #10 + '��' + #10 + '��' + #10 + '��'
		;
	WHIRA_FINAL_DELIMITER = '����' + #10 + '����'
		;{
		+ #10 + '�����' + #10 + '����������' + #10 + '�Ȃ̂�'
		+ #10 + '������' + #10 + '�ł�����'
		+ #10 + '�܂�'
		+ #10 + '������' + #10 + '����' + #10 + '����' + #10 + '�����'
		+ #10 + '��͂�' + #10 + '����ς�'
		+ #10 + '�ł�' + #10 + '����'
		+ #10 + '����' + #10 + '���Ȃ�' + #10 + '����' + #10 + '���Ȃ�'
		;}
	// '�[' �� '����������' �ɁB
	HA_LINE = '���������Ȃ͂܂��킪�����΂ς���';
	HI_LINE = '���������ɂЂ݂����т҂�';
	HU_LINE = '�������ʂӂނ�邮�ԂՂ�';
	HE_LINE = '�������Ă˂ւ߂��ׂ؂�';
	HO_LINE = '�������Ƃ̂ق��������ڂۂ�';
	KA_LINE = '�A�J�T�^�i�n�}�������K�U�_�o�p�@����';
	KI_LINE = '�C�L�V�`�j�q�~�����M�W�r�s�B';
	KU_LINE = '�E�N�X�c�k�t�������O�u�v�D��';
	KE_LINE = '�G�P�Z�e�l�w�������Q�x�y�F��';
	KO_LINE = '�I�R�\�g�m�z���������S�{�|�H';
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
			// �����̃^�C�v�𔻕�
			// ����Ǔ_�� ModeGraph �ɂȂ�̂ŌʂɑΉ����Ȃ��Ă�����
//			if Byte(Byte( p^ ) - $a1) < $5e then begin
			if Byte( p^ ) in kKanji then begin
				if p + 1 < tail then begin
					ch := (PByte( p )^ shl 8) or PByte( p + 1 )^;
					case ch of
					// �X�y�[�X�ŒP�ꕪ�������ɋl�߂�
					//$8140:							newMode := ModeWhite;
					$8141..$824e:				newMode := ModeWGraph;
					$824f..$8258:				newMode := ModeWNum;
					$8260..$829a:				newMode := ModeWAlpha;
					$829f..$82f1:				newMode := ModeWHira;
					$8340..$8396:				newMode := ModeWKata;
					else								newMode	:= ModeWKanji;
					end;
					// '�J�K�[' �͕������A�܂��̓J�^�J�i�Ɋ܂܂��
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
					// ���܂œ��{��ō��X�y�[�X
					// �P����q���Č�ŃX�y�[�X���l�߂�
					// �����p�J�i�͒ʏ�X�y�[�X�ŋ�؂邾�낤����l�߂Ȃ�
					newMode := mode;
				end;

				chSize := 1;
			end;

			if mode <> newMode then begin

				// �����̃^�C�v���ύX���ꂽ
				if mode <> ModeWhite then begin
					SetLength( aWord, p - last );
					CopyMemory( PChar( aWord ), last, p - last );

					words.Text := changeMode( aWord, mode );

					// �P��o�^
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

			// �P��o�^
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
