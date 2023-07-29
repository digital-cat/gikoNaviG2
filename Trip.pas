unit Trip;

{!
\file		Trip.pas
\brief	トリップの生成

	http://ghanyan.monazilla.org/trip.html
	を元にギコナビ用に移植させていただきました。
}
interface

uses
    SHA1Unit, UBase64, SysUtils, MojuUtils;

type
	CryptBlock = record
		b_data : array [0..63] of char;
	end;
	PCryptBlock = ^CryptBlock;

	CryptOrdering = record
		o_data : array [0..63] of char;
	end;

	CryptData = record
		Key : CryptBlock;
		EP : ^CryptOrdering;
	end;

{!
\brief	トリップの生成
\param	pw	元になるパスワード
\return			生成されたトリップ
}
function get_2ch_trip(
	const pw : PChar
) : string;

{!
\brief  トリップの生成に必要なsaltの生成
\parm   pw  saltの元になるパスワード
\param  salt    生成したsaltが格納される (array[0..2] of char)
}
procedure get_salt(
    const pw : PChar;
    salt : PChar
);

const
	kCryptInitialTr : CryptOrdering = ( o_data: (
		#58,#50,#42,#34,#26,#18,#10, #2,#60,#52,#44,#36,#28,#20,#12, #4,
		#62,#54,#46,#38,#30,#22,#14, #6,#64,#56,#48,#40,#32,#24,#16, #8,
		#57,#49,#41,#33,#25,#17, #9, #1,#59,#51,#43,#35,#27,#19,#11, #3,
		#61,#53,#45,#37,#29,#21,#13, #5,#63,#55,#47,#39,#31,#23,#15, #7
	) );

	kCryptFinalTr : CryptOrdering = ( o_data: (
		#40, #8,#48,#16,#56,#24,#64,#32,#39, #7,#47,#15,#55,#23,#63,#31,
		#38, #6,#46,#14,#54,#22,#62,#30,#37, #5,#45,#13,#53,#21,#61,#29,
		#36, #4,#44,#12,#52,#20,#60,#28,#35, #3,#43,#11,#51,#19,#59,#27,
		#34, #2,#42,#10,#50,#18,#58,#26,#33, #1,#41, #9,#49,#17,#57,#25
	) );

	kCryptSwap : CryptOrdering = ( o_data: (
		#33,#34,#35,#36,#37,#38,#39,#40,#41,#42,#43,#44,#45,#46,#47,#48,
		#49,#50,#51,#52,#53,#54,#55,#56,#57,#58,#59,#60,#61,#62,#63,#64,
		 #1, #2, #3, #4, #5, #6, #7, #8, #9,#10,#11,#12,#13,#14,#15,#16,
		#17,#18,#19,#20,#21,#22,#23,#24,#25,#26,#27,#28,#29,#30,#31,#32
	) );

	kCryptKeyTr1 : CryptOrdering = ( o_data: (
		#57, #49, #41, #33, #25, #17, #9,	 #1, #58, #50, #42, #34, #26, #18,
		#10,	#2, #59, #51, #43, #35, #27, #19, #11,	#3, #60, #52, #44, #36,
		#63, #55, #47, #39, #31, #23, #15,	#7, #62, #54, #46, #38, #30, #22,
		#14,	#6, #61, #53, #45, #37, #29, #21, #13,	#5, #28, #20, #12,	#4,
		#0,	#0,	#0,	#0,	#0,	#0,	#0,	#0
	) );

	kCryptKeyTr2 : CryptOrdering = ( o_data: (
		#14,#17,#11,#24, #1, #5, #3,#28,#15, #6,#21,#10,
		#23,#19,#12, #4,#26, #8,#16, #7,#27,#20,#13, #2,
		#41,#52,#31,#37,#47,#55,#30,#40,#51,#45,#33,#48,
		#44,#49,#39,#56,#34,#53,#46,#42,#50,#36,#29,#32,
		 #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0,
		 #0, #0, #0, #0
	) );

	kCryptEtr : CryptOrdering = ( o_data: (
		#32, #1, #2, #3, #4, #5, #4, #5, #6, #7, #8, #9,
		 #8, #9,#10,#11,#12,#13,#12,#13,#14,#15,#16,#17,
		#16,#17,#18,#19,#20,#21,#20,#21,#22,#23,#24,#25,
		#24,#25,#26,#27,#28,#29,#28,#29,#30,#31,#32, #1,
		 #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0,
		 #0, #0, #0, #0
	) );

	kCryptPtr : CryptOrdering = ( o_data: (
		#16, #7,#20,#21,#29,#12,#28,#17, #1,#15,#23,#26, #5,#18,#31,#10,
		 #2, #8,#24,#14,#32,#27, #3, #9,#19,#13,#30, #6,#22,#11, #4,#25,
		 #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0,
		 #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0
	) );

	kCryptS_boxes : array [ 0..7, 0..63 ] of Char = (
	(	#14, #4,#13, #1, #2,#15,#11, #8, #3,#10, #6,#12, #5, #9, #0, #7,
		 #0,#15, #7, #4,#14, #2,#13, #1,#10, #6,#12,#11, #9, #5, #3, #8,
		 #4, #1,#14, #8,#13, #6, #2,#11,#15,#12, #9, #7, #3,#10, #5, #0,
		#15,#12, #8, #2, #4, #9, #1, #7, #5,#11, #3,#14,#10, #0, #6,#13
	),

	(	#15, #1, #8,#14, #6,#11, #3, #4, #9, #7, #2,#13,#12, #0, #5,#10,
		 #3,#13, #4, #7,#15, #2, #8,#14,#12, #0, #1,#10, #6, #9,#11, #5,
		 #0,#14, #7,#11,#10, #4,#13, #1, #5, #8,#12, #6, #9, #3, #2,#15,
		#13, #8,#10, #1, #3,#15, #4, #2,#11, #6, #7,#12, #0, #5,#14, #9
	),

	(	#10, #0, #9,#14, #6, #3,#15, #5, #1,#13,#12, #7,#11, #4, #2, #8,
		#13, #7, #0, #9, #3, #4, #6,#10, #2, #8, #5,#14,#12,#11,#15, #1,
		#13, #6, #4, #9, #8,#15, #3, #0,#11, #1, #2,#12, #5,#10,#14, #7,
		 #1,#10,#13, #0, #6, #9, #8, #7, #4,#15,#14, #3,#11, #5, #2,#12
	),

	(	 #7,#13,#14, #3, #0, #6, #9,#10, #1, #2, #8, #5,#11,#12, #4,#15,
		#13, #8,#11, #5, #6,#15, #0, #3, #4, #7, #2,#12, #1,#10,#14, #9,
		#10, #6, #9, #0,#12,#11, #7,#13,#15, #1, #3,#14, #5, #2, #8, #4,
		 #3,#15, #0, #6,#10, #1,#13, #8, #9, #4, #5,#11,#12, #7, #2,#14
	),

	(	 #2,#12, #4, #1, #7,#10,#11, #6, #8, #5, #3,#15,#13, #0,#14, #9,
		#14,#11, #2,#12, #4, #7,#13, #1, #5, #0,#15,#10, #3, #9, #8, #6,
		 #4, #2, #1,#11,#10,#13, #7, #8,#15, #9,#12, #5, #6, #3, #0,#14,
		#11, #8,#12, #7, #1,#14, #2,#13, #6,#15, #0, #9,#10, #4, #5, #3
	),

	(	#12, #1,#10,#15, #9, #2, #6, #8, #0,#13, #3, #4,#14, #7, #5,#11,
		#10,#15, #4, #2, #7,#12, #9, #5, #6, #1,#13,#14, #0,#11, #3, #8,
		 #9,#14,#15, #5, #2, #8,#12, #3, #7, #0, #4,#10, #1,#13,#11, #6,
		 #4, #3, #2,#12, #9, #5,#15,#10,#11,#14, #1, #7, #6, #0, #8,#13
	),

	(	 #4,#11, #2,#14,#15, #0, #8,#13, #3,#12, #9, #7, #5,#10, #6, #1,
		#13, #0,#11, #7, #4, #9, #1,#10,#14, #3, #5,#12, #2,#15, #8, #6,
		 #1, #4,#11,#13,#12, #3, #7,#14,#10,#15, #6, #8, #0, #5, #9, #2,
		 #6,#11,#13, #8, #1, #4,#10, #7, #9, #5, #0,#15,#14, #2, #3,#12
	),

	(	#13, #2, #8, #4, #6,#15,#11, #1,#10, #9, #3,#14, #5, #0,#12, #7,
		 #1,#15,#13, #8,#10, #3, #7, #4,#12, #5, #6,#11, #0,#14, #9, #2,
		 #7,#11, #4, #1, #9,#12,#14, #2, #0, #6,#10,#13,#15, #3, #5, #8,
		 #2, #1,#14, #7, #4,#10, #8,#13,#15,#12, #9, #0, #3, #5, #6,#11
	)
	);

	kCryptRots : array [ 0..15 ] of Integer = (
		1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1
	);

implementation

procedure transpose(
	var data : CryptBlock;
	var t : CryptOrdering;
	n : Integer
);
var
	x : CryptBlock;
begin
	x := data;

	while n > 0 do
	begin
		Dec( n );
		data.b_data[ n ] := x.b_data[ Integer( t.o_data[ n ] ) - 1 ];
	end;
end;

procedure rotate(
	var key : CryptBlock
);
var
	p : PChar;
	ep : PChar;
	data0, data28 : Char;
begin

	p := key.b_data;
	ep := @(key.b_data[ 55 ]);
	data0 := key.b_data[ 0 ];
	data28 := key.b_data[ 28 ];

	while p < ep do
	begin
		Inc( p );
		p[ -1 ] := p^;
	end;
	key.b_data[ 27 ] := data0;
	key.b_data[ 55 ] := data28;

end;

procedure f(
	i : Integer;
	var key : CryptBlock;
	var a : CryptBlock;
	var x : CryptBlock;
	var data : CryptData
);
var
	e, ikey, y : CryptBlock;
	k : Integer;
	p, q, r : PChar;

	xb, ir : Integer;

	temp : CryptOrdering;
begin

	e := a;
	transpose( e, data.EP^, 48 );
	for k := kCryptRots[ i ] downto 1
		do rotate( key );
	ikey := key;
	temp := kCryptKeyTr2;		transpose( ikey, temp, 48 );
	p := @(y.b_data[ 48 ]);
	q := @(e.b_data[ 48 ]);
	r := @(ikey.b_data[ 48 ]);
	while p > y.b_data do
	begin
		Dec( p );
		Dec( q );
		Dec( r );
		p^ := Char( Integer( q^ ) xor Integer( r^ ) );
	end;
	q := x.b_data;
	for k := 0 to 7 do
	begin
		ir := Integer( p^ ) shl 5; Inc( p );
		ir := ir + Integer( p^ ) shl 3; Inc( p );
		ir := ir + Integer( p^ ) shl 2; Inc( p );
		ir := ir + Integer( p^ ) shl 1; Inc( p );
		ir := ir + Integer( p^ );			 Inc( p );
		ir := ir + Integer( p^ ) shl 4; Inc( p );

		xb := Integer( kCryptS_Boxes[ k, ir ] );

		q^ := Char( (xb shr 3) and 1 ); Inc( q );
		q^ := Char( (xb shr 2) and 1 ); Inc( q );
		q^ := Char( (xb shr 1) and 1 ); Inc( q );
		q^ := Char(	xb				and 1 ); Inc( q );
	end;
	temp := kCryptPtr;			transpose( x, temp, 32 );

end;

procedure setkey_r(
	k : PChar;
	var data : CryptData
);
var
	temp : CryptOrdering;
begin

	Move( Pointer( k )^, data.Key.b_data, SizeOf(CryptBlock) );
	temp := kCryptKeyTr1;	 transpose( data.Key, temp, 56 );

end;

procedure encrypt_r(
	blck : PChar;
	edflag : Integer;
	var data : CryptData
);
var
	key : PCryptBlock;
	p : PCryptBlock;
	i : Integer;

	j : Integer;
	k : Integer;
	b, x : CryptBlock;

	temp : CryptOrdering;
begin

	key := @data.Key;
	p := PCryptBlock( blck );

	temp := kCryptInitialTr;transpose( p^, temp, 64 );
	for i := 15 downto 0 do
	begin
		if edflag <> 0 then
			j := i
		else
			j := 15 - i;

		b := p^;
		for k := 31 downto 0
			do p^.b_data[ k ] := b.b_data[ k + 32 ];
		f( j, key^, p^, x, data );
		for k := 31 downto 0
			do p^.b_data[ k + 32 ] := Char( Integer( b.b_data[ k ] ) xor Integer( x.b_data[ k ] ) );
	end;
	temp := kCryptSwap;		 transpose( p^, temp, 64 );
	temp := kCryptFinalTr;	transpose( p^, temp, 64 );

	end;

function crypt_r(
	pw : PChar;
	salt : PChar;
	var data : CryptData
) : string;
var
	pwb : array [0..65] of char;
	cp : PChar;
	ret : array [0..15] of char;
	p : PChar;
	new_etr : CryptOrdering;
	i : Integer;

	j : Integer;
	c : Char;
	t : Integer;
	temp : Integer;
begin

	p := pwb;
	data.EP := @kCryptEtr;
	while (pw^ <> #0) and (p < pwb + 64) do
	begin
		j := 7;

		while j > 0 do
		begin
			Dec( j );
			p^ := Char( (Integer(pw^) shr j) and 1 );
			Inc( p );
		end;
		//Dec( j );

		Inc( pw );
		p^ := #0;
		Inc( p );
	end;
	while (p < pwb + 64) do
	begin
					p^ := #0;
					Inc( p );
	end;

	p := pwb;
	setKey_r( p, data );

	while (p < pwb + 66) do
	begin
					p^ := #0;
					Inc( p );
	end;

	new_etr := kCryptEtr;
	data.EP := @new_etr;
	if (salt[ 0 ] = #0) and (salt[ 1 ] = #0) then
					salt := '**#0';
	for i := 0 to 1 do
	begin
		c := salt^;
		Inc( salt );

		ret[ i ] := c;
		if c > 'Z' then
			c := Char( Integer(c) - (6 + 7 + Integer('.')) )
		else if c > '9' then
			c := Char( Integer(c) - (7 + Integer('.')) )
		else
			c := Char( (Integer(c) - Integer('.')) and $ff );

		for j := 0 to 5 do
		begin
			if ((Integer(c) shr j) and 1) <> 0 then
			begin
				t := 6 * i + j;
				temp := Integer( new_etr.o_data[ t ] );
				new_etr.o_data[ t ] := new_etr.o_data[ t + 24 ];
				new_etr.o_data[ t + 24 ] := Char( temp );
			end;
		end;
	end;

	if ret[ 1 ] = #0 then
		ret[ 1 ] := ret[ 0 ];

	for i := 0 to 24 do
		encrypt_r( pwb, 0, data );
	data.EP := @kCryptEtr;

	p := pwb;
	cp := ret + 2;
	while p < pwb + 66 do
	begin
		c := #0;
		j := 6;

		while j > 0 do
		begin
			Dec( j );
			c := Char(	(Integer(c) shl 1) or Integer(p^) );
			Inc( p );
		end;
		//Dec( j );
		c := Char( Integer(c) + Integer('.') );
		if c > '9' then
			c := Char( Integer(c) + 7 );
		if c > 'Z' then
			c := Char( Integer(c) + 6 );
		cp^ := c;
		Inc( cp );
	end;
	cp^ := #0;
	Result := ret;

end;

procedure get_pw_salt(
    const pw : PChar;
    var convpw : String;
    const salt : PChar
) ;
var
    i : integer;
begin
    // ^([0-9A-Fa-f]{16})([./0-9A-Za-z]{0,2})$
    if (Length(pw) >= 17) and (Length(pw) <= 19) then begin
        // キー部分
        for  i := 0 to 7 do begin
            if (Pos(pw[2*i + 0 + 1], '0123456789abcdefABCDEF') > 0) and
                (Pos(pw[2*i + 1 + 1], '0123456789abcdefABCDEF') > 0) then begin
                convpw := convpw +
                    Char(StrToInt( 'x' + pw[2*i + 0 + 1] ) shl 4 + StrToInt( 'x'  + pw[2*i + 1 + 1] ));
            end else begin
                convpw := '';
                Break;
            end;
        end;

        if (Length(convpw) = 8) then begin
            if (Length(pw) = 19) then begin
                if (Pos(pw[17], './0123456789abcdefABCDEF') > 0) and
                    (Pos(pw[18], './0123456789abcdefABCDEF') > 0) then begin
                    salt[ 0 ] := pw[17];
                    salt[ 1 ] := pw[18];
                    salt[ 2 ] := #0;
                end else begin
                    convpw := '';
                end;
            end else if (Length(pw) = 18) then begin
                if (Pos(pw[17], './0123456789abcdefABCDEF') > 0) then begin
                    salt[ 0 ] := pw[17];
                    salt[ 1 ] := '.';
                    salt[ 2 ] := #0;
                end else begin
                    convpw := '';
                end;
            end else begin
                salt[ 0 ] := '.';
                salt[ 1 ] := '.';
                salt[ 2 ] := #0;
            end;
        end;
    end;
end;

function get_2ch_trip(
	const pw : PChar
) : string;
var
	s : CryptData;
	salt : array [0..2] of char;
    digest : TSHA1Digest;
    convpw : String;
begin
    Result := '';
	if pw[ 0 ] = #0 then
	begin
		Exit;
	end;
    // 11桁までは旧方式
    if (Length(pw) <= 11) then begin
        get_salt( pw, salt );
    	Result := Copy( crypt_r( pw, salt, s ), 4, 100 );
    end else begin
        // 新方式トリップ
        if pw[ 0 ] = '$' then begin
            // 将来の拡張用
            Result := '???';
        end else begin
            convpw := '';
            if (pw[ 0 ] = '#') and (Length(pw) >= 20) then begin
                // 将来の拡張用
                Result := '???';
            end else if pw[ 0 ] = '#' then begin
                // 生キー方式
                get_pw_salt(pw, convpw, salt);
                if Length(convpw) = 0 then begin
                    // 生キー方式エラー
                    Result := '???';
                end else if Length(convpw) = 8 then begin
                    Result := Copy( crypt_r( PChar(convpw), salt, s ), 4, 100 );
                end
            end else begin
                // 新方式
                StringHashSHA1(digest, pw);
                Result := Copy(HogeBase64Encode(digest), 0, 12);
                Result := MojuUtils.CustomStringReplace(Result, '+', '.');
            end;
        end;
    end;
end;

procedure get_salt(
    const pw : PChar;
    salt : PChar
);
var
    i, len : Integer;
begin
	salt[ 0 ] := #0;

	if pw[ 1 ] <> #0 then
	begin
		if pw[ 2 ] <> #0 then
			len := 2
		else
			len := 1;
		for i := 0 to len - 1 do
		begin
			if ('.' <= pw[ i + 1 ]) and (pw[ i + 1 ] <= 'z' ) then
				salt[ i ] := pw[ i + 1 ]
			else
				salt[ i ] := '.';

            if Pos ( salt[ i ], ':;<=>?@' ) > 0 then begin
                salt[ i ] := Char( Integer( salt[ i ] ) + 7 );
            end else if Pos( salt[ i ], '[\\]^_`' ) > 0 then begin
				salt[ i ] := Char( Integer( salt[ i ] ) + 6 );
            end;
		end;
		if len = 1 then
			salt[ 1 ] := 'H';
		salt[ 2 ] := #0;
	end else begin
		salt[ 0 ] := 'H';
		salt[ 1 ] := '.';
	end;
end;

end.
