unit YofUtils;

{!
\file		YofUtils.pas
\brief	HttpApp のクローンやその他雑用関数

$Id: YofUtils.pas,v 1.10 2004/10/09 15:06:19 yoffy Exp $
}
interface

//==================================================
uses
//==================================================

	Classes, SysUtils,
	Windows;

{!
\brief		ExtractHttpFields のクローン
\warning	とりあえずの代用品なので chrWhite を考慮していないことに注意！！！
}
procedure ExtractHttpFields(
	const chrSep : TSysCharSet;
	const chrWhite : TSysCharSet;
	const strValue : string;
	var strResult : TStringList;
	unknownFlag : boolean = false
);

function HtmlEncode(
	const strValue : string
) : string;

function HtmlDecode(
	const strValue : string
) : string;

function HttpEncode(
	const strValue : string
) : string;

function HttpDecode(
	const strValue : string
) : string;

{!
\brief		MachiesMask のクローン
\warning	とりあえずの代用品なので [] を使った正規表現を考慮していないことに注意！！！
}
function MatchesMask(
	const filename, mask : string
) : boolean;

//! メタキャラクタを正規表現扱いにならないように置換
function RegExpEncode(
	const text : string
) : string;

{!
\brief		表示メッセージの整形
\param		msg				表示するメッセージ
\param		elements	置換単語

msg の中の置換される単語は '^番号' で表され、
elements は改行によって単語分けされます。<br>

<pre><code>
elements := IntToStr( 10 ) + #10 + 'hoge';
m := MessageStyle(
	'^0 個の“^1”を置換しました。',
	elements );
</code></pre>

で出力される m は「10 個の“hoge”を置換しました。」となります。
}
function MessageStyle(
	const msg				: string;
	const elements	: string
) : string; overload;

function MessageStyle(
	const msg				: string;
	const elements	: TStringList
) : string; overload;

{!
\brief	右回転シフト
\param	v		回転する値
\param	n		回転ビット数
\return	Longword( (v shl (32 - n)) or (v shr n) ) の値
}
function ror( v, n : Longword ) : Longword; register;

{!
\brief		文字列のハッシュ値を計算
\param		s		文字列
\return		ハッシュ値 ( 4 byte )
\warning  多バイトを 4 byte に縮めているため、
					同じ値を出力する文字列は無限に存在します。
					コンフリクトが起こらない事を前提にした記述は避けてください。

この関数は多バイト長の文字列を 4 byte に縮めます。<br>
その過程で、'abcdefgh' と 'efghabcd' が同じ値にならないようにする等、
多少偏りを省くように考慮されます。
}
function GetStringHash( const s : string ) : Longword;

type
	//! Mode 値がおかしい
	EMappedFileModeError = class( Exception );
	//! マッピングに失敗
	EMappedFileMappingError = class( Exception );

	//! メモリマップド・ファイル クラス
	TMappedFile = class( TObject )
	private
		FFileHandle			: THandle;
		FMappingHandle	: THandle;
		FSize						: Int64;
		FViewAddress		: Pointer;
	public
		{!
		\brief	メモリマップドファイルの作成
		\param	filePath		開くファイルのパス
		\param	mode				fmOpenRead (デフォルト) または fmOpenReadWrite
		\param  maximumSize	ページサイズの上限 (0 なら現在のファイルサイズ)
		}
		constructor Create(
			const filePath	: string;
			mode						: Longword = fmOpenRead;
			maximumSize			: Int64 = 0 );
		destructor	Destroy; override;

		//! サイズの取得
		property		Size		: Int64			read FSize;
		//! アドレスの取得
		property		Memory	: Pointer		read FViewAddress;
	end;

//==================================================
const
//==================================================
	kYofKanji : TSysCharSet = [#$80..#$A0, #$E0..#$ff];

//==================================================
implementation
//==================================================

uses MojuUtils;

procedure ExtractHttpFields(
	const chrSep : TSysCharSet;
	const chrWhite : TSysCharSet;
	const strValue : string;
	var strResult : TStringList;
	unknownFlag : boolean = false
);
var
	last, p, strLen : Integer;
begin

	strLen := Length( strValue );
	p := 1;
	last := 1;

	while p <= strLen do
	begin

		if strValue[ p ] in chrSep then
		begin
			strResult.Add( Copy( strValue, last, p - last ) );
			last := p + 1;
		end;

		p := p + 1;

	end;

	if last <> p then
		strResult.Add( Copy( strValue, last, strLen - last + 1 ) );

end;

function HtmlEncode(
	const strValue : string
) : string;
var
	i : Integer;
	strLen : Integer;
	strResult : string;
begin

	strLen := Length( strValue );
	i := 1;

	while i <= strLen do
	begin

		case strValue[ i ] of
		'&':
			begin
				strResult := strResult + '&amp;';
			end;
		'<':
			begin
				strResult := strResult + '&lt;';
			end;
		'>':
			begin
				strResult := strResult + '&gt;';
			end;
		'"':
			begin
				strResult := strResult + '&quot;';
			end;
		else
			begin
				if strValue[ i ] in kYofKanji then
				begin
					strResult := strResult + strValue[ i ];
					Inc( i );
				end;
				strResult := strResult + strValue[ i ];
			end;
		end;

		i := i + 1;

	end;

	Result := strResult;

end;

function HtmlDecode(
	const strValue : string
) : string;
var
	strResult : string;
begin

	strResult := StringReplace( strValue, '&lt;', '<', [rfReplaceAll] );
	strResult := StringReplace( strResult, '&gt;', '>', [rfReplaceAll] );
	strResult := StringReplace( strResult, '&quot;', '"', [rfReplaceAll] );
	strResult := StringReplace( strResult, '&amp;', '&', [rfReplaceAll] );

	Result := strResult;

end;

function HttpEncode(
	const strValue : string
	) : string;
var
	i : Integer;
	strLen : Integer;
	strResult : string;
	b : Integer;
const
	kHexCode : array [0..15] of char = (
				'0', '1', '2', '3', '4', '5', '6', '7',
				'8', '9', 'A', 'B', 'C', 'D', 'E', 'F' );
begin

	strLen := Length( strValue );
	i := 1;

	while i <= strLen do
	begin

		case strValue[ i ] of
		'0' .. '9', 'a' .. 'z', 'A' .. 'Z', '*', '-', '.', '@', '_':
			begin
				strResult := strResult + strValue[ i ];
			end;
		else
			begin
				b := Integer( strValue[ i ] );
				strResult := strResult + '%'
								+ kHexCode[ b div $10 ]
								+ kHexCode[ b mod $10 ];
			end;
		end;

		i := i + 1;

	end;

	Result := strResult;

end;

function	toupper(
	ch : Longword
) : Byte; Register;
asm
	mov	ecx, eax		// ecx = (ch - 'a')
	sub	cl, 'a'
	cmp	ecx, 26			// edx = ecx < 26 (小文字ならフルビット)
	sbb	edx, edx
	and	edx, $20		// edx &= 0x20 (小文字なら 0x20)
	xor	eax, edx		// eax ^= edx
end;

function HttpDecode(
	const strValue : string
) : string;
var
	i : Integer;
	strLen : Integer;
	strResult : string;
	b : Integer;
begin

	strLen := Length( strValue );
	i := 1;

	while i <= strLen do
	begin

		if '%' = strValue[ i ] then begin
			Inc( i );
			if strValue[ i ] in ['a' .. 'z', 'A' .. 'Z'] then
				b := (toupper( Longword( strValue[ i ] ) ) - 55) shl 4
			else
				b := (Byte( strValue[ i ] ) - Byte( '0' )) shl 4;
			Inc( i );
			if strValue[ i ] in ['a' .. 'z', 'A' .. 'Z'] then
				b := b or (toupper( Longword( strValue[ i ] ) ) - 55)
			else
				b := b or (Byte( strValue[ i ] ) - Byte( '0' ));

			strResult := strResult + Char( Byte( b ) );
		end else begin
			strResult := strResult + strValue[ i ];
		end;

		Inc( i );

	end;

	Result := strResult;

end;

function MatchesMask(
	const filename, mask : string
	) : boolean;
var
	pName, pMask : Integer;
	ptrName, ptrMask : PChar;
	nameLen, maskLen : Integer;
	chrUpMask : char;
	delimiterPos : Integer;
begin

	nameLen := Length( filename );
	maskLen := Length( mask );
	ptrName := PChar( filename );
	ptrMask := PChar( mask );
	pName := 0;
	pMask := 0;
	delimiterPos := Pos( '\', string( ptrName + pName ) );
	while delimiterPos > 0 do
	begin
		pName := pName + delimiterPos;
		delimiterPos := Pos( '\', string( ptrName + pName ) );
	end;

	while (pMask < maskLen) and (pName < nameLen) do
	begin

		case ptrMask[ pMask ] of
		'?':
			begin
				// この 1 字は何もしない
			end;
		'*':
			begin
				pMask := pMask + 1;
				// mask を走査し切ったら終了
				if pMask >= maskLen then
				begin
					Result := true;
					exit;
				end;

				// * の次の文字が来るまで飛ばす
				chrUpMask := upcase( ptrMask[ pMask ] );
				while chrUpMask <> UpCase( ptrName[ pName ] ) do
				begin
					pName := pName + 1;
					if pName >= nameLen then
					begin
						Result := true;
						exit;
					end;
				end;

				// * の次の文字が見つからなかったら終了
				if chrUpMask <> UpCase( ptrName[ pName ] ) then
				begin
					Result := false;
					exit;
				end;

				pName := pName + 1;
				pMask := pMask + 1;
			end;
		else
			begin
				// この 1 文字が違ったら終了
				if UpCase( ptrMask[ pMask ] ) <> UpCase( ptrName[ pName ] ) then
				begin
					Result := false;
					exit;
				end;

			end;
		end;

		// 次の文字へ
		pName := pName + 1;
		pMask := pMask + 1;

	end;

	if (pMask >= maskLen) and (pName >= nameLen) then
		Result := true
	else
		Result := false;

end;

function RegExpEncode(
	const text : string
) : string;
var
	strResult : string;
begin

	strResult := StringReplace( text, '\', '\\', [rfReplaceAll] );
	strResult := StringReplace( strResult, '[', '\[', [rfReplaceAll] );
	strResult := StringReplace( strResult, ']', '\]', [rfReplaceAll] );
	strResult := StringReplace( strResult, '(', '\(', [rfReplaceAll] );
	strResult := StringReplace( strResult, ')', '\)', [rfReplaceAll] );
	strResult := StringReplace( strResult, '[', '\[', [rfReplaceAll] );
	strResult := StringReplace( strResult, ']', '\]', [rfReplaceAll] );
	strResult := StringReplace( strResult, '*', '\*', [rfReplaceAll] );
	strResult := StringReplace( strResult, '?', '\?', [rfReplaceAll] );
	strResult := StringReplace( strResult, '.', '\.', [rfReplaceAll] );
	strResult := StringReplace( strResult, '+', '\+', [rfReplaceAll] );
	strResult := StringReplace( strResult, '|', '\|', [rfReplaceAll] );
	strResult := StringReplace( strResult, '^', '\^', [rfReplaceAll] );
	strResult := StringReplace( strResult, '$', '\$', [rfReplaceAll] );

	Result := strResult;

end;

function MessageStyle(
	const msg				: string;
	const elements	: string
) : string;
var
	list						: TStringList;
begin

	list := TStringList.Create;
	try
		list.Text := elements;
		Result := MessageStyle( msg, list );
	finally
		list.Free;
	end;

end;

function MessageStyle(
	const msg				: string;
	const elements	: TStringList
) : string;
var
	i								: Integer;
begin

	Result := msg;
	for i := elements.Count - 1 downto 0 do
		Result := CustomStringReplace( Result, '^' + IntToStr( i ), elements[ i ], false );

end;

//==============================
// ror
//==============================
function ror( v, n : Longword ) : Longword; register;
asm
	mov		cl, dl
	ror		eax, cl
end;

//==============================
// GetStringHash
//==============================
function GetStringHash( const s : string ) : Longword;
var
	l				: Integer;
	v				: Longword;
	p, tail : PChar;
begin

	l			:= Length( s );
	p			:= PChar( s );
	v			:= $87654321;
	tail	:= p + (l and $fffffffc);
	while p < tail do begin
		v	:= PDword( p )^ + (v shl 2) * ($10000 - v);
		p := p + 4;
	end;
	tail	:= PChar( s ) + l;
	while p < tail do begin
		v := PByte( p )^ + (v shl 2) * ($10000 - v);
		Inc( p );
	end;

	Result := v xor ((v shl 2) * ($10000 - v));

end;

{ TMappedFile }

constructor TMappedFile.Create(
	const filePath	: string;
	mode						: Longword = fmOpenRead;
	maximumSize			: Int64 = 0 );
var
	dwFileDesiredAccess	: DWORD;
	flProtect						: DWORD;
	dwViewDesiredAccess	: DWORD;
begin

	case mode of
	fmOpenRead:
		begin
			dwFileDesiredAccess	:= GENERIC_READ;
			flProtect						:= PAGE_READONLY;
			dwViewDesiredAccess	:= FILE_MAP_READ;
		end;

	fmOpenReadWrite:
		begin
			dwFileDesiredAccess	:= GENERIC_READ or GENERIC_WRITE;
			flProtect						:= PAGE_READWRITE;
			dwViewDesiredAccess	:= FILE_MAP_WRITE;
		end;

	else
		raise EMappedFileModeError.Create( 'ファイルオープンのモードが不正です。' );
	end;

	FFileHandle := CreateFile(
		PChar( filePath ), dwFileDesiredAccess, 0, nil, OPEN_ALWAYS,
		FILE_ATTRIBUTE_NORMAL, 0 );
	if FFileHandle = INVALID_HANDLE_VALUE then
// for Delphi 7
//		raise EFOpenError.Create( 'ファイルのオープンに失敗しました。' );
		raise EMappedFileMappingError.Create( 'ファイルのオープンに失敗しました。' );
/////////////

	FSize := GetFileSize( FFileHandle, nil );
	if FSize < maximumSize then
		FSize := maximumSize;

	FMappingHandle := CreateFileMapping(
		FFileHandle, nil, flProtect,
		DWORD( (maximumSize shr 32) and $ffffffff ),
		DWORD( maximumSize and $ffffffff ),
		nil );
	if FFileHandle = INVALID_HANDLE_VALUE then
		raise EMappedFileMappingError.Create( 'ファイルのマッピングに失敗しました。' );

	FViewAddress := MapViewOfFile( FMappingHandle, dwViewDesiredAccess, 0, 0, 0 );
	if FViewAddress = nil then
		raise EMappedFileMappingError.Create( 'ファイルのマッピングに失敗しました。' );

end;

destructor	TMappedFile.Destroy;
begin

	UnmapViewOfFile( FViewAddress );
	CloseHandle( FMappingHandle );
	CloseHandle( FFileHandle );

end;

end.
