unit MojuUtils;
//******************************************************************************
//	文字列置換関数 CustomStringReplace
//  使い方は、
//　CustomStringReplace(
//　	元の文字列（StringもしくはTStringList),
//　	検索文字列（String),
//		置換文字列（String),
//      大文字小文字（Boolean)True:区別しない　false or 省略:区別する
//
// Delphi-MLの記事69334に載っていたコードを丸パクリしました。
//******************************************************************************

interface

uses
	Windows, Classes, SysUtils;

	function StrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd: PChar): PChar;
	function AnsiStrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd: PChar): PChar;
	function ReplaceString(const S: String; const OldPattern: String; const NewPattern: string): String;
	function IgnoCaseReplaceString(const S: String; const OldPattern:String; const NewPattern: string): String;

	function CustomStringReplace(const S: String; const OldPattern: String; const  NewPattern: string; IgnoreCase : Boolean = False): String; overload;
	procedure CustomStringReplace(var S : TStringList;const OldPattern: String;const  NewPattern: string; IgnoreCase : Boolean = False); overload;

	function ZenToHan(const s: string): string;
	function VaguePos(const Substr: String; const S: string): Integer;

	function ReplaseNoValidateChar( inVal : String): String;
	function IsNoValidID( inID :String): Boolean;
	//<font>タグを全て削除する
	function DeleteFontTag( inSource : string) : string;
	function RemoveToken(var s: string;const delimiter: string): string;
	// 無害化(& -> &amp; " -> &auot; に変換する)
	function Sanitize(const s: String): String;
	// 無害化解除(&amp; -> & &auot; -> " に変換する)
	function UnSanitize(const s: String): String;

implementation
// ポインター＆アセンブラによる高速ポス
function StrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd: PChar): PChar;
asm
		PUSH    EBX
		PUSH    ESI
		PUSH    EDI

		MOV    ESI,ECX        { Point ESI to substr                  }
		MOV    EDI,EAX        { Point EDI to s                        }

		MOV    ECX,EDX        { ECX = search length                  }
        SUB    ECX,EAX

        MOV    EDX,SubstrEnd
        SUB    EDX,ESI

        DEC    EDX            { EDX = Length(substr) - 1              }
        JS      @@fail        { < 0 ? return 0                        }
        MOV    AL,[ESI]      { AL = first char of substr            }
        INC    ESI            { Point ESI to 2'nd char of substr      }

        SUB    ECX,EDX        { #positions in s to look at            }
                              { = Length(s) - Length(substr) + 1      }
        JLE    @@fail
@@loop:
        REPNE  SCASB
        JNE    @@fail
        MOV    EBX,ECX        { save outer loop counter              }
        PUSH    ESI            { save outer loop substr pointer        }
        PUSH    EDI            { save outer loop s pointer            }

        MOV    ECX,EDX
        REPE    CMPSB
        POP    EDI            { restore outer loop s pointer          }
        POP    ESI            { restore outer loop substr pointer    }
        JE      @@found
        MOV    ECX,EBX        { restore outer loop counter            }
        JMP    @@loop

@@fail:
        XOR    EAX,EAX
        JMP    @@exit

@@found:
        MOV    EAX,EDI        { EDI points of char after match        }
        DEC    EAX
@@exit:
        POP    EDI
        POP    ESI
        POP    EBX
end;
//　AnsiPosの高速版
function AnsiStrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd: PChar): PChar;
var
    L2: Cardinal;
    ByteType : TMbcsByteType;
begin
    Result := nil;
    if (StrStart = nil) or (StrStart^ = #0) or
    	(SubstrStart = nil) or (SubstrStart^ = #0) then Exit;

    L2 := SubstrEnd - SubstrStart;
    Result := StrPosEx(StrStart, StrEnd, SubstrStart, SubstrEnd);

    while (Result <> nil) and (StrEnd - Result >= L2) do begin
		ByteType := StrByteType(StrStart, Integer(Result-StrStart));
		if (ByteType <> mbTrailByte) and
			(CompareString(LOCALE_USER_DEFAULT, SORT_STRINGSORT, Result, L2, SubstrStart, L2) = 2)
		then Exit;
    	if (ByteType = mbLeadByte) then Inc(Result);
    	Inc(Result);
    	Result := StrPosEx(Result, StrEnd, SubStrStart, SubStrEnd);
    end;
    Result := nil;
end;

//高速文字列置換関数（大文字小文字の違いを無視しない）
function ReplaceString(const S: String; const OldPattern: String; const NewPattern: string): String;
var
	ReplaceCount: Integer;
	DestIndex: Integer;
	i, l: Integer;
	p, e, ps, pe: PChar;
	Count: Integer;
	olen: Integer;
begin
	Result := S;
	olen := Length(OldPattern);
	if olen = 0 then Exit;
	p := PChar(S);
	e := p + Length(S);
	ps := PChar(OldPattern);
	pe := ps + olen;
	ReplaceCount := 0;
	while p < e do begin
		p := AnsiStrPosEx(p, e, ps, pe);
		if p = nil then Break;
		Inc(ReplaceCount);
		Inc(p, olen);
	end;
	if ReplaceCount = 0 then Exit;
	SetString(Result, nil, Length(S) +
	(Length(NewPattern) - olen) * ReplaceCount);
	p := PChar(S);
	DestIndex := 1;
	l := Length( NewPattern );
	for i := 0 to ReplaceCount - 1 do begin
		Count := AnsiStrPosEx(p, e, ps, pe) - p;
		Move(p^, Result[DestIndex], Count);
		Inc(p, Count);//p := pp;
		Inc(DestIndex, Count);
		Move(NewPattern[1], Result[DestIndex], l);
		Inc(p, olen);
		Inc(DestIndex, l);
	end;
	Move(p^, Result[DestIndex], e - p);
end;
//高速文字列置換関数（大文字小文字の違いを無視する）
function IgnoCaseReplaceString(const S: String;const OldPattern:String;const NewPattern: string): String;
var
	ReplaceCount: Integer;
	DestIndex: Integer;
	i, l: Integer;
	p, e{, ps, pe}: PChar;
	p2, e2, ps2, pe2: PChar;
	Count: Integer;
	bufferS : String;
	bufferOldPattern : String;
begin
	Result := S;
	bufferS := AnsiLowerCase(S);
	bufferOldPattern := AnsiLowerCase(OldPattern);

	if OldPattern = '' then Exit;
	p	:= PChar(S);
	p2	:= PChar(bufferS);
	e	:= p + Length(S);
	e2	:= p2 + Length(bufferS);
	//ps	:= PChar(OldPattern);
	ps2	:= PChar(bufferOldPattern);
	//pe	:= ps + Length(OldPattern);
	pe2	:= ps2 + Length(bufferOldPattern);

	ReplaceCount := 0;
	while p2 < e2 do begin
		p2 := AnsiStrPosEx(p2, e2, ps2, pe2);
		if p2 = nil then Break;
		Inc(ReplaceCount);
		Inc(p2, Length(bufferOldPattern));
	end;
	if ReplaceCount = 0 then Exit;
	SetString(Result, nil, Length(bufferS) +
	(Length(NewPattern) - Length(bufferOldPattern)) * ReplaceCount);
	p2 := PChar(bufferS);
	DestIndex := 1;
	l := Length( NewPattern );
	for i := 0 to ReplaceCount - 1 do begin
		Count := AnsiStrPosEx(p2, e2, ps2, pe2) - p2;
		Move(p^, Result[DestIndex], Count);
		Inc(p, Count);//p := pp;
		Inc(p2, Count);//p := pp;
		Inc(DestIndex, Count);
		Move(NewPattern[1], Result[DestIndex], l);
		Inc(p, Length(OldPattern));
		Inc(p2, Length(OldPattern));
		Inc(DestIndex, l);
	end;
	Move(p^, Result[DestIndex], e - p);
end;
//高速文字列置換関数（汎用版１）
function CustomStringReplace(
	const S :String;
	const OldPattern: String;
	const  NewPattern: string;
	IgnoreCase : Boolean
): String;
begin
	if not IgnoreCase then begin
		Result := ReplaceString(S,OldPattern,NewPattern);
	end else begin
		Result := IgnoCaseReplaceString(S,OldPattern,NewPattern);
	end;
end;

//高速文字列置換関数（汎用版２）
procedure CustomStringReplace(
	var S : TStringList;
	const OldPattern: String;
	const  NewPattern: string;
	IgnoreCase : Boolean
);
var
	i : Integer;
begin
	S.BeginUpdate;
	if not IgnoreCase then begin
		for i := 0 to S.Count - 1 do begin
			S.Strings[i] := ReplaceString(S.Strings[i], OldPattern,NewPattern);
		end;
	end else begin
		for i := 0 to S.Count - 1 do begin
			S.Strings[i] := IgnoCaseReplaceString(S.Strings[i], OldPattern,NewPattern);
		end;
	end;
	S.EndUpdate;
end;

(*************************************************************************
 * 全角→半角
 * from HotZonu
 *************************************************************************)
function ZenToHan(const s: string): string;
var
	ChrLen	: Integer;
begin
	SetLength(Result, Length(s));
	ChrLen := Windows.LCMapString(
		 GetUserDefaultLCID(),
//		 LCMAP_HALFWIDTH,
		 LCMAP_HALFWIDTH or LCMAP_KATAKANA or LCMAP_LOWERCASE,
		 PChar(s),
		 Length(s),
		 PChar(Result),
		 Length(Result)
		 );
	SetLength(Result, ChrLen);
end;

(*************************************************************************
 * 全角半角ひらがなかたかなを区別しない凄いPos
 *************************************************************************)
function VaguePos(const Substr:String; const S: string): Integer;
begin
	Result := AnsiPos(ZenToHan(Substr), ZenToHan(S));
end;
(*************************************************************************
 * FAT/NTFSのファイル名に許されない文字（\,/,:,.,;,*,>,<,|）を全角に置換する
 *************************************************************************)
function ReplaseNoValidateChar( inVal : String): String;
begin
	Result := CustomStringReplace(inVal, '\', '￥');
	Result := CustomStringReplace(Result, '/', '／');
	Result := CustomStringReplace(Result, ':', '：');
	Result := CustomStringReplace(Result, '.', '．');
    Result := CustomStringReplace(Result, ';', '；');
	Result := CustomStringReplace(Result, '*', '＊');
	Result := CustomStringReplace(Result, '>', '＞');
	Result := CustomStringReplace(Result, '<', '＜');
	Result := CustomStringReplace(Result, '|', '｜');
	Result := CustomStringReplace(Result, #9,  '');
end;
(*************************************************************************
 * 無効なIDかのチェック（無効例：ID:??? , ID:???X)
 *************************************************************************)
function IsNoValidID( inID :String): Boolean;
var
    bTail : Boolean;
begin
    Result := True;
	inID := Trim(inID);
	if (Length(inID) > 0) then begin
		inID := Copy(inID, AnsiPos(':', inID) + 1, Length(inID) );
        bTail := False;
        // 末尾が?以外か
        if Length(inID) > 0 then begin
            bTail := (inID[Length(inID)] <> '?');
        end;
		inID := CustomStringReplace(inID, '?', '');
		if (Length(inID) > 0) and (not
            ((Length(inID) = 1) and (bTail))) then begin
		    Result := False;
        end;
	end;
end;

// *************************************************************************
// HTML中の<font>タグを削除する
// *************************************************************************
function	DeleteFontTag(
	 inSource : string    //タグを削除する文字列
) : string;		//タグ削除語の文字列
var
	pos : Integer;
begin
	Result := '';

	//</font>を削除
	inSource := CustomStringReplace( inSource, '</font>', '', True);
	//<font を全て小文字に変換する
	inSource := CustomStringReplace( inSource, '<font', '<font', True);
	//<font ～ を削除する
	pos := AnsiPos('<font', inSource);
	while (pos > 0) do begin
		Result := Result + Copy(inSource, 1, pos - 1);
		Delete(inSource, 1, pos);
		//タグを閉じる'>'までを削除
        pos := AnsiPos('>', inSource);
		Delete(inSource, 1, pos);
		pos := AnsiPos('<font', inSource);
	end;

	Result := Result + inSource;


end;
// *************************************************************************


(*************************************************************************
 *
 *どこかのサイトからのパクリ
 *************************************************************************)
function RemoveToken(var s: string;const delimiter: string): string;
var
	p: Integer;
	pos : PChar;
	pds, pde : PChar;
	pss, pse : PChar;
begin
	pss := PChar(s);
	pse := pss + Length(s);
	pds := PChar(delimiter);
	pde := pds + Length(delimiter);

	pos := StrPosEx(pss, pse, pds, pde);
	if pos <> nil then begin
		p := pos - pss;
		SetString(Result, pss, p);
		Delete(s, 1, p + Length(delimiter));
        if (Length(Result) > 0) then begin
    		if (StrByteType(PChar(Result), Length(Result)-1) = mbLeadByte) then begin
	    		SetLength(Result, Length(Result) - 1);
		    end;
        end;
	end else begin
		Result := s;
		s := '';
	end;
end;

//! 無害化(& -> &amp; " -> &quot; に変換する)
function Sanitize(const s: String): String;
begin
    // 余分にサニタイズされないようにいったん元に戻す
    Result := UnSanitize(s);
	Result := CustomStringReplace(Result, '&', '&amp;');
	Result := CustomStringReplace(Result, '"', '&quot;');
end;
//! 無害化解除(&amp; -> & &quot; -> " に変換する)
function UnSanitize(const s: String): String;
begin
	Result := CustomStringReplace(s, '&quot;', '"');
	Result := CustomStringReplace(Result, '&amp;', '&');
end;

end.
