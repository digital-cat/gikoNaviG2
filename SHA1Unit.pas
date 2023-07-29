unit SHA1Unit;

interface

uses
	Windows, SysUtils;

const
    SHA1_A = DWORD( $67452301 );
    SHA1_B = DWORD( $EFCDAB89 );
    SHA1_C = DWORD( $98BADCFE );
    SHA1_D = DWORD( $10325476 );
    SHA1_E = DWORD( $C3D2E1F0 );
    SHA1_K1 = DWORD( $5A827999 );
    SHA1_K2 = DWORD( $6ED9EBA1 );
    SHA1_K3 = DWORD( $8F1BBCDC );
    SHA1_K4 = DWORD( $CA62C1D6 );
    LBMASK_HI = DWORD( $FF0000 );
    LBMASK_LO = DWORD( $FF00 );

type
    TSHA1Digest = array [0..19] of Byte;
    TSHA1Context = record
        sdHi    : DWord;
        sdLo    : DWord;
        sdIndex : DWord;
        sdHash  : array [0..4] of DWord;
        sdBuf   : array [0..63] of Byte;
    end;

    function SHA1SwapByteOrder( n : DWORD ) : DWORD;
    procedure HashSHA1( var Digest : TSHA1Digest; const Buf; BufSize : Longint );
    procedure StringHashSHA1(var Digest : TSHA1Digest; const Str : string);
    procedure SHA1Hash( var Context : TSHA1Context );

implementation
//! 文字列用SHA1ハッシュ取得
procedure StringHashSHA1(var Digest : TSHA1Digest; const Str : string);
begin
    HashSHA1(Digest, Str[1], Length(Str));
end;
//! SHA1ハッシュ取得
procedure HashSHA1( var Digest : TSHA1Digest; const Buf; BufSize : Longint );
var
    Context : TSHA1Context;
    PBuf: ^Byte;
    procedure UpdateLen( var Context : TSHA1Context; Len : DWord );
    begin
        Inc( Context.sdLo,( Len shl 3 ));
        if Context.sdLo < ( Len shl 3 ) then
            Inc( Context.sdHi );
        Inc( Context.sdHi, Len shr 29 );
    end;
begin
    //0埋め
    fillchar( Context, SizeOf( Context ), 0 );
    // マジックナンバーで初期化する
    Context.sdHash[ 0 ] := SHA1_A;
    Context.sdHash[ 1 ] := SHA1_B;
    Context.sdHash[ 2 ] := SHA1_C;
    Context.sdHash[ 3 ] := SHA1_D;
    Context.sdHash[ 4 ] := SHA1_E;

    UpdateLen( Context, BufSize );
    PBuf := @Buf;
    while BufSize > 0 do begin
        if ( Sizeof( Context.sdBuf ) - Context.sdIndex ) <= DWord( BufSize ) then begin
            Move( PBuf^, Context.sdBuf[ Context.sdIndex ], Sizeof( Context.sdBuf ) - Context.sdIndex );
            Dec( BufSize, Sizeof( Context.sdBuf ) - Context.sdIndex );
            Inc( PBuf, Sizeof( Context.sdBuf ) - Context.sdIndex );
            SHA1Hash( Context );
        end else begin
            Move( PBuf^, Context.sdBuf[ Context.sdIndex ], BufSize );
            Inc( Context.sdIndex, BufSize );
            BufSize := 0;
        end;
    end;

    Context.sdBuf[ Context.sdIndex ] := $80;

    if Context.sdIndex >= 56 then
        SHA1Hash( Context );

    PDWord( @Context.sdBuf[ 56 ])^ := SHA1SwapByteOrder( Context.sdHi );
    PDWord( @Context.sdBuf[ 60 ])^ := SHA1SwapByteOrder( Context.sdLo );

    SHA1Hash( Context );

    Context.sdHash[ 0 ] := SHA1SwapByteOrder( Context.sdHash[ 0 ]);
    Context.sdHash[ 1 ] := SHA1SwapByteOrder( Context.sdHash[ 1 ]);
    Context.sdHash[ 2 ] := SHA1SwapByteOrder( Context.sdHash[ 2 ]);
    Context.sdHash[ 3 ] := SHA1SwapByteOrder( Context.sdHash[ 3 ]);
    Context.sdHash[ 4 ] := SHA1SwapByteOrder( Context.sdHash[ 4 ]);

    Move( Context.sdHash, Digest, Sizeof( Digest ));
end;
//! ハッシュ処理
procedure SHA1Hash( var Context : TSHA1Context );
var
    A : DWord;
    B : DWord;
    C : DWord;
    D : DWord;
    E : DWord;

    temp : DWord;
    W : array[ 0..79 ] of DWord;

    i : Longint;
    function SHA1CircularShift(I, C : DWord) : DWord; register;
    asm
        mov  ecx, edx
        rol  eax, cl
    end;
begin
    with Context do begin
        sdIndex:= 0;
        Move( sdBuf, W, Sizeof( W ));

        // Initialize the first 16 words in the array W
        for i := 0 to 15 do begin
            W[ i ]:= SHA1SwapByteOrder( W[ i ] );
        end;

        // Transform Message block from 16 32 bit words to 80 32 bit words
        // Wt, = ( Wt-3 xor Wt-8 xor Wt-13 xor Wt-16 ) rolL 1 : Wt is W sub t
        for i:= 16 to 79 do begin
            W[i]:= SHA1CircularShift( W[ i - 3 ] xor W[ i - 8 ] xor W[ i - 14 ] xor W[ i - 16 ], 1 );
        end;

        A := sdHash[ 0 ];
        B := sdHash[ 1 ];
        C := sdHash[ 2 ];
        D := sdHash[ 3 ];
        E := sdHash[ 4 ];

        // the four rounds
        for i:= 0 to 19 do begin
            temp    := SHA1CircularShift( A, 5 ) + ( D xor ( B and ( C xor D ))) + E + W[ i ] + SHA1_K1;
            E       := D;
            D       := C;
            C       := SHA1CircularShift( B, 30 );
            B       := A;
            A       := temp;
        end;

        for i:= 20 to 39 do begin
            temp    := SHA1CircularShift( A, 5 ) + ( B xor C xor D ) + E + W[ i ] + SHA1_K2;
            E       := D;
            D       := C;
            C       := SHA1CircularShift( B, 30 );
            B       := A;
            A       := temp;
        end;

        for i:= 40 to 59 do begin
            temp    := SHA1CircularShift( A, 5 ) + (( B and C ) or ( D and ( B or C ))) + E + W[ i ] + SHA1_K3;
            E       := D;
            D       := C;
            C       := SHA1CircularShift( B, 30 );
            B       := A;
            A       := temp;
        end;

        for i:= 60 to 79 do
        begin
            temp    := SHA1CircularShift( A, 5 ) + ( B xor C xor D ) + E + W[ i ] + SHA1_K4;
            E       := D;
            D       := C;
            C       := SHA1CircularShift( B, 30 );
            B       := A;
            A       := temp;
        end;

        sdHash[ 0 ]:= sdHash[ 0 ] + A;
        sdHash[ 1 ]:= sdHash[ 1 ] + B;
        sdHash[ 2 ]:= sdHash[ 2 ] + C;
        sdHash[ 3 ]:= sdHash[ 3 ] + D;
        sdHash[ 4 ]:= sdHash[ 4 ] + E;

        FillChar( W, Sizeof( W ), 0 );
        FillChar( sdBuf, Sizeof( sdBuf ), 0 );
    end;
end;

//! 上位バイトと下位バイトの入れ替え
function SHA1SwapByteOrder( n : DWORD ) : DWORD;
begin
    n := ( n shr 24 ) or (( n shr 8 ) and LBMASK_LO )
       or (( n shl 8 ) and LBMASK_HI ) or ( n shl 24 );
    Result := n;
end;

end.
