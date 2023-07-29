unit Y_TextConverter;

{
	Yoffy's Text Converter
	from http://www6.tok2.com/home2/Yoffy/index.shtml
}

interface

uses
  Windows;

// EUC‚©‚çSJIS‚Ö•ÏŠ·
function EUCtoSJIS(src : string) : string;

// SJIS‚©‚çEUC‚Ö•ÏŠ·
function SJIStoEUC(src : string) : string;

type
	//HRESULT ConvertINetString(LPDWORD lpdwMode, DWORD dwSrcEncoding, DWORD dwDstEncoding,
	//							LPCSTR  lpSrcStr, LPINT    lpnSrcSize, LPBYTE lpDstStr,
	//						  	LPINT   lpnDstSize);
	TConvertINetString = function(lpdwMode      : LPDWORD;
                      			  dwSrcEncoding : DWORD;
                                  dwDstEncoding : DWORD;
								  lpSrcStr      : LPCSTR;
    							  lpnSrcSize    : PINT;
                                  lpDstStr      : PBYTE;
							  	  lpnDstSize    : PINT) : HRESULT; stdcall;

implementation

function CharSetConv(src : string; dwSrcEncoding : DWORD; dwDstEncoding : DWORD) : string;
var
	dst    : PChar;
	SrcLen : Integer;
    DstLen : Integer;
    ConvertINetString : TConvertINetString;
    FMlangDLL		  : HMODULE;	// Mlang.DLL‚Ìƒnƒ“ƒhƒ‹
begin

	FMlangDLL := LoadLibrary(PChar('Mlang.DLL'));
    @ConvertINetString := GetProcAddress(FMlangDLL, PAnsiChar(AnsiString('ConvertINetString')));

	SrcLen := Length(src);
    DstLen := SrcLen * 2 + 1;
	GetMem( dst, DstLen );
	ConvertINetString(nil, dwSrcEncoding, dwDstEncoding, PChar(src), @SrcLen, PByte(dst), @DstLen);
	dst[DstLen] := Char($0);
	Result := string(dst);
	FreeMem(dst);
	FreeLibrary(FMlangDLL);

end;

// EUC‚©‚çSJIS‚Ö•ÏŠ·
function EUCtoSJIS(src : string) : string;
begin

	Result := CharSetConv(src, 51932, 932);

end;

// SJIS‚©‚çEUC‚Ö•ÏŠ·
function SJIStoEUC(src : string) : string;
begin

	Result := CharSetConv(src, 932, 51932);

end;

end.

