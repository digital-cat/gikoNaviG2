unit WideMemo;

interface

uses
    Messages, Windows, Controls, StdCtrls, SysUtils, Classes, Types, TntStdCtrls;

type
    TWideMemo = class;

    TWideMemo = class(TTntMemo)
private
//    function GetWideText: WideString;
    function GetEncodeText: AnsiString;
    procedure SetEncodeText(SrcText: AnsiString);
//    function SetClipboard(SrcText: WideString): Boolean;
//    function GetClipboard(IsClear: Boolean): WideString;
protected
//    procedure CreateWindowHandle(const Params: TCreateParams); override;
public
    constructor Create(AOwner: TComponent); override;
    procedure Free;
    procedure InsertText(InsText: WideString);
    procedure QuotePaste(QuoteStr: AnsiString);
    property EncodeText: AnsiString read GetEncodeText write SetEncodeText;
end;


implementation

constructor TWideMemo.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
end;

procedure TWideMemo.Free;
begin
    inherited Free;
end;

//procedure TWideMemo.CreateWindowHandle(const Params: TCreateParams);
//var
//    ClassName: WideString;
//begin
//    with Params do
//    begin
//        ClassName := WideString(WinClassName);
//        WindowHandle := CreateWindowExW(ExStyle, PWideChar(ClassName), '', Style,
//                                        X, Y, Width, Height, WndParent, 0,
//                                        HInstance, Param);
//        SendMessage(WindowHandle, WM_SETTEXT, 0, Longint(Caption));
//    end;
//end;

//function TWideMemo.GetWideText: WideString;
//var
////    Len: Integer;
////    LenUC: Integer;
////    BufUC: PWideChar;
////    BufUCSize: Integer;
//    PosS: LongWord;
//    PosE: LongWord;
//begin
////    Len := GetWindowTextLengthW(Handle);
////    Len := Perform(WM_GETTEXTLENGTH, 0, 0);
////    LenUC := Len + 1;
////    BufUCSize := LenUC * SizeOf(WideChar);
////    BufUC := AllocMem(BufUCSize);
////    ZeroMemory(BufUC, BufUCSize);
////    GetWindowTextW(Handle, BufUC, LenUC);
////    SendMessageW(Handle, WM_GETTEXT, WPARAM(LenUC), LPARAM(BufUC));
////    Result := WideString(BufUC);
////    FreeMem(BufUC);
///
//	SendMessage(Handle, EM_GETSEL, WPARAM(@PosS), LPARAM(@PosE));
//	SendMessage(Handle, EM_SETSEL, 0, GetWindowTextLengthW(Handle));
//	SendMessage(Handle, WM_COPY, 0, 0);
//	SendMessage(Handle, EM_SETSEL, WPARAM(PosS), LPARAM(PosE));
///
//    Result := GetClipboard(True);
//end;

function TWideMemo.GetEncodeText: AnsiString;
const
    _WC_NO_BEST_FIT_CHARS = $400;
var
    Len: Integer;
    LenUC: Integer;
    BufUC: PWideChar;
    BufSJ: array[0..16] of AnsiChar;
    UseDefChar: LongBool;
    Cnt: Integer;
    TextSJ: AnsiString;
    TextUC: WideString;
begin
//    TextUC := GetWideText;
    TextUC := Text;
    BufUC := PWideChar(TextUC);
    Len := Length(TextUC);
    LenUC := Len + 1;

    WideCharToMultiByte(CP_ACP, _WC_NO_BEST_FIT_CHARS, BufUC, LenUC, nil, 0, nil, @UseDefChar);
    if (UseDefChar = False) then begin
        Result := AnsiString(BufUC);
    end else begin
        for Cnt := 0 to Len - 1 do
        begin
            ZeroMemory(@BufSJ, 16);
            WideCharToMultiByte(CP_ACP, _WC_NO_BEST_FIT_CHARS, @BufUC[Cnt], 1, BufSJ, 16, nil, @UseDefChar);
            if (UseDefChar = False) then begin
                TextSJ := TextSJ + AnsiString(BufSJ);
            end else begin
                TextSJ := TextSJ + Format('&#%d;', [Ord(BufUC[Cnt])]);
            end;
        end;
        Result := TextSJ;
    end;
end;

procedure TWideMemo.SetEncodeText(SrcText: AnsiString);
var
    CodePos: Integer;
    TextSJ: AnsiString;
    TextUC: WideString;
    CodeSJ: AnsiString;
    CodeVal: Integer;
begin
    TextSJ := SrcText;
    while Length(TextSJ) > 0 do begin
        CodePos := AnsiPos('&#', TextSJ);
        if (CodePos < 1) then begin
            TextUC := TextUC + WideString(TextSJ);
            Break;
        end;
        if (CodePos > 1) then begin
            TextUC := TextUC + WideString(Copy(TextSJ, 1, CodePos - 1));
            Delete(TextSJ, 1, CodePos - 1);
        end;
        CodePos := AnsiPos(';', TextSJ);
        if (CodePos < 1) then begin
            TextUC := TextUC + WideString(TextSJ);
            Break;
        end;
        CodeSJ := Copy(TextSJ, 3, CodePos - 3);
        CodeVal := StrToIntDef(CodeSJ, 0);
        if ((CodeVal < 1) or (CodeVal > $FFFF)) then begin
            TextUC := TextUC + WideString(Copy(TextSJ, 1, CodePos));
        end else begin
            TextUC := TextUC + WideString(WideChar(CodeVal));
        end;
        Delete(TextSJ, 1, CodePos);
    end;

//    SetWindowTextW(Handle, PWideChar(TextUC));
  Text := TextUC;
end;

//function TWideMemo.SetClipboard(SrcText: WideString): Boolean;
//var
//    LenUC: Integer;
//    BufUC: PWideChar;
//    BufUCSize: Integer;
//    MemHandle: HGLOBAL;
//    CopySize: Integer;
//begin
//    LenUC := Length(SrcText);
//    CopySize := LenUC * SizeOf(WideChar);
//    BufUCSize := (LenUC + 1) * SizeOf(WideChar);
//    MemHandle := GlobalAlloc(GMEM_DDESHARE or GMEM_MOVEABLE, BufUCSize);
//    BufUC := GlobalLock(MemHandle);
//    ZeroMemory(BufUC, BufUCSize);
//    CopyMemory(BufUC, PWideChar(SrcText), CopySize);
//    GlobalUnlock(MemHandle);
///
//    if (OpenClipboard(Handle) = True) then begin
//        EmptyClipboard;
//        SetClipboardData(CF_UNICODETEXT, MemHandle);
//        CloseClipboard;
//        Result := True;
//    end else begin
//        GlobalFree(MemHandle);
//        Result := False;
//    end;
//end;

//function TWideMemo.GetClipboard(IsClear: Boolean): WideString;
//var
//    TextGet: WideString;
//    MemHandle: HGLOBAL;
//    TextP: PWideChar;
//begin
//    if (OpenClipboard(Handle) = True) then begin
//        MemHandle := GetClipboardData(CF_UNICODETEXT);
//        if (MemHandle <> 0) then begin
//            TextP := PWideChar(GlobalLock(MemHandle));
//            if not (TextP = nil) then begin
//                TextGet := WideString(TextP);
//                GlobalUnlock(MemHandle);
//            end;
//        end;
//        if (IsClear = True) then
//            EmptyClipboard;
//        CloseClipboard;
//    end;
//    Result := TextGet;
//end;

procedure TWideMemo.InsertText(InsText: WideString);
var
    SelS: LongWord;
    SelE: LongWord;
    FullText: WideString;
    AftCurPos: LongInt;
//    TextOrg: WideString;
begin

//    FullText := GetWideText;
    FullText := Text;

    SelS := 0;
    SelE := 0;
    SendMessageW(Handle, EM_GETSEL, WPARAM(@SelS), LPARAM(@SelE));

    if (SelS <> SelE) then
        Delete(FullText, SelS + 1, SelE - SelS);
    Insert(InsText, FullText, SelS + 1);

    SetWindowTextW(Handle, PWideChar(FullText));

    AftCurPos := LongInt(SelS) + Length(InsText);

    SendMessageW(Handle, EM_SETSEL, AftCurPos, AftCurPos);

(*
    TextOrg := GetClipboard(False);

    if (SetClipboard(InsText) = True) then begin

        SendMessageW(Handle, WM_PASTE, 0, 0);

        SetClipboard(TextOrg);
    end;

    Change; *)
end;

procedure TWideMemo.QuotePaste(QuoteStr: AnsiString);
var
    TextDst: WideString;
    TextSrc: WideString;
    QuoteUC: WideString;
    RetChar: WideString;
    Ret: Integer;
begin
//    TextSrc := GetClipboard(False);
    TextSrc := Text;
    QuoteUC := QuoteStr;
    RetChar := AnsiString(#13#10);

    while (Length(TextSrc) > 0) do begin
        Ret := Pos(RetChar, TextSrc);
        if (Ret < 1) then begin // ‰üs‚È‚µ
            TextDst := TextDst + QuoteUC + TextSrc;
            Break;
        end;

        // ‰üs‚Ü‚Å‚Ì1s
        TextDst := TextDst + QuoteUC + Copy(TextSrc, 1, Ret + 1);
        Delete(TextSrc, 1, Ret + 1);
    end;

    if (Length(TextDst) > 0) then
        InsertText(TextDst);
end;

end.
