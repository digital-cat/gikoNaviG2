unit YofUtils;

{!
\file		YofUtils.pas
\brief	HttpApp �̃N���[���₻�̑��G�p�֐�

$Id: YofUtils.pas,v 1.10 2004/10/09 15:06:19 yoffy Exp $
}
interface

//==================================================
uses
//==================================================

	Classes, SysUtils,
	Windows;

{!
\brief		ExtractHttpFields �̃N���[��
\warning	�Ƃ肠�����̑�p�i�Ȃ̂� chrWhite ���l�����Ă��Ȃ����Ƃɒ��ӁI�I�I
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
\brief		MachiesMask �̃N���[��
\warning	�Ƃ肠�����̑�p�i�Ȃ̂� [] ���g�������K�\�����l�����Ă��Ȃ����Ƃɒ��ӁI�I�I
}
function MatchesMask(
	const filename, mask : string
) : boolean;

//! ���^�L�����N�^�𐳋K�\�������ɂȂ�Ȃ��悤�ɒu��
function RegExpEncode(
	const text : string
) : string;

{!
\brief		�\�����b�Z�[�W�̐��`
\param		msg				�\�����郁�b�Z�[�W
\param		elements	�u���P��

msg �̒��̒u�������P��� '^�ԍ�' �ŕ\����A
elements �͉��s�ɂ���ĒP�ꕪ������܂��B<br>

<pre><code>
elements := IntToStr( 10 ) + #10 + 'hoge';
m := MessageStyle(
	'^0 �́g^1�h��u�����܂����B',
	elements );
</code></pre>

�ŏo�͂���� m �́u10 �́ghoge�h��u�����܂����B�v�ƂȂ�܂��B
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
\brief	�E��]�V�t�g
\param	v		��]����l
\param	n		��]�r�b�g��
\return	Longword( (v shl (32 - n)) or (v shr n) ) �̒l
}
function ror( v, n : Longword ) : Longword; register;

{!
\brief		������̃n�b�V���l���v�Z
\param		s		������
\return		�n�b�V���l ( 4 byte )
\warning  ���o�C�g�� 4 byte �ɏk�߂Ă��邽�߁A
					�����l���o�͂��镶����͖����ɑ��݂��܂��B
					�R���t���N�g���N����Ȃ�����O��ɂ����L�q�͔����Ă��������B

���̊֐��͑��o�C�g���̕������ 4 byte �ɏk�߂܂��B<br>
���̉ߒ��ŁA'abcdefgh' �� 'efghabcd' �������l�ɂȂ�Ȃ��悤�ɂ��铙�A
�����΂���Ȃ��悤�ɍl������܂��B
}
function GetStringHash( const s : string ) : Longword;

type
	//! Mode �l����������
	EMappedFileModeError = class( Exception );
	//! �}�b�s���O�Ɏ��s
	EMappedFileMappingError = class( Exception );

	//! �������}�b�v�h�E�t�@�C�� �N���X
	TMappedFile = class( TObject )
	private
		FFileHandle			: THandle;
		FMappingHandle	: THandle;
		FSize						: Int64;
		FViewAddress		: Pointer;
	public
		{!
		\brief	�������}�b�v�h�t�@�C���̍쐬
		\param	filePath		�J���t�@�C���̃p�X
		\param	mode				fmOpenRead (�f�t�H���g) �܂��� fmOpenReadWrite
		\param  maximumSize	�y�[�W�T�C�Y�̏�� (0 �Ȃ猻�݂̃t�@�C���T�C�Y)
		}
		constructor Create(
			const filePath	: string;
			mode						: Longword = fmOpenRead;
			maximumSize			: Int64 = 0 );
		destructor	Destroy; override;

		//! �T�C�Y�̎擾
		property		Size		: Int64			read FSize;
		//! �A�h���X�̎擾
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
	cmp	ecx, 26			// edx = ecx < 26 (�������Ȃ�t���r�b�g)
	sbb	edx, edx
	and	edx, $20		// edx &= 0x20 (�������Ȃ� 0x20)
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
				// ���� 1 ���͉������Ȃ�
			end;
		'*':
			begin
				pMask := pMask + 1;
				// mask �𑖍����؂�����I��
				if pMask >= maskLen then
				begin
					Result := true;
					exit;
				end;

				// * �̎��̕���������܂Ŕ�΂�
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

				// * �̎��̕�����������Ȃ�������I��
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
				// ���� 1 �������������I��
				if UpCase( ptrMask[ pMask ] ) <> UpCase( ptrName[ pName ] ) then
				begin
					Result := false;
					exit;
				end;

			end;
		end;

		// ���̕�����
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
		raise EMappedFileModeError.Create( '�t�@�C���I�[�v���̃��[�h���s���ł��B' );
	end;

	FFileHandle := CreateFile(
		PChar( filePath ), dwFileDesiredAccess, 0, nil, OPEN_ALWAYS,
		FILE_ATTRIBUTE_NORMAL, 0 );
	if FFileHandle = INVALID_HANDLE_VALUE then
// for Delphi 7
//		raise EFOpenError.Create( '�t�@�C���̃I�[�v���Ɏ��s���܂����B' );
		raise EMappedFileMappingError.Create( '�t�@�C���̃I�[�v���Ɏ��s���܂����B' );
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
		raise EMappedFileMappingError.Create( '�t�@�C���̃}�b�s���O�Ɏ��s���܂����B' );

	FViewAddress := MapViewOfFile( FMappingHandle, dwViewDesiredAccess, 0, 0, 0 );
	if FViewAddress = nil then
		raise EMappedFileMappingError.Create( '�t�@�C���̃}�b�s���O�Ɏ��s���܂����B' );

end;

destructor	TMappedFile.Destroy;
begin

	UnmapViewOfFile( FViewAddress );
	CloseHandle( FMappingHandle );
	CloseHandle( FFileHandle );

end;

end.
