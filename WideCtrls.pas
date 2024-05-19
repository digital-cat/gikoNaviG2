unit WideCtrls;

(*
  Unicode対応コントロール
*)

interface

uses
  Messages, Windows, Controls, StdCtrls, Classes, SysUtils, StrUtils, CommCtrl,
  TntStdCtrls, TntMenus, TntComCtrls, GikoListView, WideStrings;

{ TWideMemo }
type
  TWideMemo = class;

  TWideMemo = class(TTntMemo)
private
  function GetEncodeText: AnsiString;
public
  constructor Create(AOwner: TComponent); override;
  procedure Free;
  procedure InsertText(InsText: WideString);
  procedure QuotePaste(QuoteStr: AnsiString);
  property EncodeText: AnsiString read GetEncodeText;
end;


{ TWideComboBox }
type
  TWideComboBox = class;

  TWideComboBox = class(TTntComboBox)
private
  function GetEncodeText: AnsiString;
  procedure SetEncodeText(AText: AnsiString);
public
  constructor Create(AOwner: TComponent); override;
  procedure Free;
  procedure Items_Assign(ASrc: TStringList);
  function EncItems(AIdx: Integer): AnsiString;
  property EncodeText: AnsiString read GetEncodeText write SetEncodeText;
end;


{ TWideEdit }
type
  TWideEdit = class;

  TWideEdit = class(TTntEdit)
private
  function GetEncodeText: AnsiString;
  procedure SetEncodeText(AText: AnsiString);
public
  constructor Create(AOwner: TComponent); override;
  procedure Free;
  property EncodeText: AnsiString read GetEncodeText write SetEncodeText;
end;


{ TWideLabel }
type
  TWideLabel = class;

  TWideLabel = class(TTntLabel)
private
  function GetEncodeCaption: AnsiString;
  procedure SetEncodeCaption(ACaption: AnsiString);
public
  constructor Create(AOwner: TComponent); override;
  procedure Free;

  property EncodeCaption: AnsiString read GetEncodeCaption write SetEncodeCaption;
end;


{ TWideMenuItem }
type
	TWideMenuItem = class;

  TWideMenuItem = class(TTntMenuItem)
private
  FAccessKey: Boolean;
  procedure SetEncodeCaption(ACaption: AnsiString);
public
  constructor Create(AOwner: TComponent); override;
  procedure Free;

  property EncodeCaption: AnsiString write SetEncodeCaption;
  property AccessKey: Boolean read FAccessKey write FAccessKey;
end;


{ TWideToolButton }
type
  TWideToolButton = class;

  TWideToolButton = class(TTntToolButton)
private
  FAccessKey: Boolean;
  procedure SetEncodeCaption(ACaption: AnsiString);
public
  constructor Create(AOwner: TComponent); override;
  procedure Free;

  property EncodeCaption: AnsiString write SetEncodeCaption;
  property AccessKey: Boolean read FAccessKey write FAccessKey;
end;


{ TWideGikoListView }
type
  TWideGikoListView = class;

  TWideGikoListView = class(TTntListView)
private
  FColumnInfoEvent: TColumnInfoEvent;
  procedure LVMSetColumn(var Message: TMessage); message LVM_SETCOLUMN;
  procedure LVMInsertColumn(var Message: TMessage); message LVM_INSERTCOLUMN;
public
  constructor Create(AOwner: TComponent); override;
  procedure Free;
published
  property OnColumnInfo: TColumnInfoEvent read FColumnInfoEvent write FColumnInfoEvent;
end;




{ UTF-16文字列をShift-JIS文字列へ変換 Shift-JISに存在しない文字は数値文字参照 }
function WideToEncAnsiString(ASrc: WideString): AnsiString;

{ Shift-JIS文字列(数値文字参照を含む)をUTF-16文字列へ変換 }
function EncAnsiToWideString(ASrc: AnsiString): WideString;

{ サロゲートペア文字かどうか確認 }
function IsSurrogatePair(AStr: PWideChar; AIdx: Integer; AMax: Integer): Boolean;

{ UTF-16文字列半角1文字・全角2文字として長さを切り詰める }
function WideTrimLength(ASrc: WideString; ALen: Integer): WideString;

{ '&'を'&&'に置換する }
function ReplaceAmp(ASrc: WideString): WideString;

{ クリップボードからUTF-16文字列をコピー }
function GetClipboard: WideString;

{ クリップボードにUTF-16文字列をコピー }
function SetClipboard(SrcText: WideString): Boolean;

{ クリップボードにShift-JIS文字列(数値文字参照を含む)をUTF-16文字列としてコピー }
function SetClipboardFromEncAnsi(SrcText: AnsiString): Boolean;

implementation


{ TWideMemo }

{ コンストラクタ }
constructor TWideMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ デストラクタ }
procedure TWideMemo.Free;
begin
  inherited Free;
end;

{ 入力テキスト取得 }
function TWideMemo.GetEncodeText: AnsiString;
begin
  try
    Result := WideToEncAnsiString(Text);
  except
  end;
end;

{ テキストへ文字列挿入 }
procedure TWideMemo.InsertText(InsText: WideString);
var
  SelS: LongWord;
  SelE: LongWord;
  FullText: WideString;
  AftCurPos: LongInt;
begin
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
end;

{ テキストへ引用文字列貼り付け }
procedure TWideMemo.QuotePaste(QuoteStr: AnsiString);
const
  RET1_CHAR: WideString = #13#10;
  RET2_CHAR: WideString = #10;
var
  TextDst: WideString;
  TextSrc: WideString;
  QuoteUC: WideString;
  Ret: Integer;
  Ret1: Integer;
  Ret2: Integer;
  DelLen: Integer;
begin
  TextSrc := GetClipboard;
  if Length(TextSrc) < 1 then
  	Exit;

  QuoteUC := QuoteStr;

  while (Length(TextSrc) > 0) do begin
    Ret1 := Pos(RET1_CHAR, TextSrc);
    Ret2 := Pos(RET2_CHAR, TextSrc);
    if (Ret1 < 1) and (Ret2 < 1) then begin // 改行なし
      TextDst := TextDst + QuoteUC + TextSrc;
      Break;
    end;

    // 改行までの1行
  	if (Ret1 > 0) and ((Ret1 <= Ret2) or (Ret2 < 1)) then begin
	    Ret := Ret1;
      DelLen := Ret1 + 1;
    end else begin
	    Ret := Ret2;
      DelLen := Ret2;
    end;
		TextDst := TextDst + QuoteUC + Copy(TextSrc, 1, Ret - 1) + RET1_CHAR;

    Delete(TextSrc, 1, DelLen);
  end;

  if (Length(TextDst) > 0) then
    InsertText(TextDst);
end;


{ TWideComboBox }

{ コンストラクタ }
constructor TWideComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ デストラクタ }
procedure TWideComboBox.Free;
begin
  inherited Free;
end;

{ 入力テキスト取得 }
function TWideComboBox.GetEncodeText: AnsiString;
begin
  try
    Result := WideToEncAnsiString(Text);
  except
  end;
end;

{ テキスト設定 }
procedure TWideComboBox.SetEncodeText(AText: AnsiString);
begin
  try
    Text := EncAnsiToWideString(AText);
  except
  end;
end;

{ リスト文字列設定 }
procedure TWideComboBox.Items_Assign(ASrc: TStringList);
var
  i: Integer;
begin
  try
    Items.Clear;
    for i := 0 to ASrc.Count - 1 do begin
      Items.Add(EncAnsiToWideString(ASrc[i]));
    end;
  except
  end;
end;

{ リスト項目文字列取得 }
function TWideComboBox.EncItems(AIdx: Integer): AnsiString;
begin
  try
    Result := WideToEncAnsiString(Items[AIdx]);
  except
  end;
end;



{ TWideEdit }

{ コンストラクタ }
constructor TWideEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ デストラクタ }
procedure TWideEdit.Free;
begin
  inherited Free;
end;

{ 入力テキスト取得 }
function TWideEdit.GetEncodeText: AnsiString;
begin
  try
    Result := WideToEncAnsiString(Text);
  except
  end;
end;

{ テキスト設定 }
procedure TWideEdit.SetEncodeText(AText: AnsiString);
begin
  try
    Text := EncAnsiToWideString(AText);
  except
  end;
end;



{ TWideLabel }

{ コンストラクタ }
constructor TWideLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;


{ デストラクタ }
procedure TWideLabel.Free;
begin

  inherited Free;
end;

{ 表示キャプション取得 }
function TWideLabel.GetEncodeCaption: AnsiString;
begin
  try
    Result := WideToEncAnsiString(Caption);
  except
  end;
end;

{ 表示キャプション設定 }
procedure TWideLabel.SetEncodeCaption(ACaption: AnsiString);
begin
  try
    Caption := EncAnsiToWideString(ACaption);
  except
  end;
end;



{ TWideMenuItem }

{ コンストラクタ }
constructor TWideMenuItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAccessKey := True;
end;


{ デストラクタ }
procedure TWideMenuItem.Free;
begin

  inherited Free;
end;

{ 表示キャプション設定 }
procedure TWideMenuItem.SetEncodeCaption(ACaption: AnsiString);
var
	wideCaption: WideString;
begin
  try
  	wideCaption := EncAnsiToWideString(ACaption);

    if not FAccessKey then
    	wideCaption := ReplaceAmp(wideCaption);

    Caption := wideCaption;
  except
  end;
end;



{ TWideToolButton }

{ コンストラクタ }
constructor TWideToolButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAccessKey := True;
end;


{ デストラクタ }
procedure TWideToolButton.Free;
begin

  inherited Free;
end;

{ 表示キャプション設定 }
procedure TWideToolButton.SetEncodeCaption(ACaption: AnsiString);
var
	wideCaption: WideString;
begin
  try
  	wideCaption := EncAnsiToWideString(ACaption);

    if not FAccessKey then
    	wideCaption := ReplaceAmp(wideCaption);

    Caption := wideCaption;
  except
  end;
end;



{ TWideGikoListView }

{ コンストラクタ }
constructor TWideGikoListView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ デストラクタ }
procedure TWideGikoListView.Free;
begin
  inherited Free;
end;

{  }
procedure TWideGikoListView.LVMSetColumn(var Message: TMessage);
begin
	if Assigned(FColumnInfoEvent) then
		FColumnInfoEvent(Self, PLVColumn(Message.LParam));
	inherited;
end;

{  }
procedure TWideGikoListView.LVMInsertColumn(var Message: TMessage);
begin
	if Assigned(FColumnInfoEvent) then
		FColumnInfoEvent(Self, PLVColumn(Message.LParam));
	inherited;
end;






{ UTF-16サロゲートペア文字の数値文字参照変換用定義 }
const
  SG_HIGH_START  = $D800;   // サロゲート前半開始コード
  SG_HIGH_END    = $DBFF;   // サロゲート前半終了コード
  SG_LOW_START   = $DC00;   // サロゲート後半開始コード
  SG_LOW_END     = $DFFF;   // サロゲート後半終了コード
  SG_HIGH_MASK   = $1FFC00; // サロゲート前半用コードポイントマスク(11bit)
  SG_LOW_MASK    = $03FF;   // サロゲート後半用コードポイントマスク(10bit)
  SG_CP_MIN      = $010000; // サロゲートペアコードポイント最小値
  SG_CP_MAX      = $10FFFF; // サロゲートペアコードポイント最大値
  SG_CP_LOW_SIZE = 10;      // サロゲート後半コードポイントサイズ(10bit)

  ERR_ALT_CHAR: WideString = '□';   // 数値文字参照変換エラー代替文字


{ UTF-16文字列をShift-JIS文字列へ変換 Shift-JISに存在しない文字は数値文字参照 }
function WideToEncAnsiString(ASrc: WideString): AnsiString;
const
  _WC_NO_BEST_FIT_CHARS = $400;
var
  Len:        Integer;
  LenUC:      Integer;
  BufUC:      PWideChar;
  BufSJ:      Array[0..16] of AnsiChar;
  UseDefChar: LongBool;
  Cnt:        Integer;
  TextSJ:     AnsiString;
  TextUC:     WideString;
  Code:       Integer;
  CodeH:      Integer;
  CodeL:      Integer;
  Skip:       Boolean;
begin
  TextUC := ASrc;
  BufUC := PWideChar(TextUC);
  Len := Length(TextUC);
  LenUC := Len + 1;

  WideCharToMultiByte(CP_ACP, _WC_NO_BEST_FIT_CHARS, BufUC, LenUC, nil, 0, nil, @UseDefChar);
  if (UseDefChar = False) then begin
    Result := AnsiString(BufUC);
    Exit;
  end;

  Skip := False;
  for Cnt := 0 to Len - 1 do
  begin
    if Skip then
      Skip := False
    else begin
      ZeroMemory(@BufSJ, 16);
      WideCharToMultiByte(CP_ACP, _WC_NO_BEST_FIT_CHARS, @BufUC[Cnt], 1, BufSJ, 16, nil, @UseDefChar);

      // Shift-JISにもある文字
      if (UseDefChar = False) then begin
        TextSJ := TextSJ + AnsiString(BufSJ);

      // Shift-JISにはない文字
      end else begin
        // サロゲートペア文字
        if IsSurrogatePair(BufUC, Cnt, Len - 1) then begin
          CodeH := Ord(BufUC[Cnt]);
          CodeL := Ord(BufUC[Cnt + 1]);
          Code := ((CodeH - SG_HIGH_START) shl SG_CP_LOW_SIZE) or (CodeL - SG_LOW_START) + SG_CP_MIN;
          Skip := True;

        // 非サロゲートペア文字
        end else
          Code := Ord(BufUC[Cnt]);

        TextSJ := TextSJ + Format('&#%d;', [Code]);
      end;
    end;
  end;

  Result := TextSJ;
end;

{ Shift-JIS文字列(数値文字参照を含む)をUTF-16文字列へ変換 }
function EncAnsiToWideString(ASrc: AnsiString): WideString;
var
  TextSJ:  AnsiString;
  TextUC:  WideString;
  Idx1:    Integer;
  Idx11:   Integer;
  Idx2:    Integer;
  Start:   Integer;
  Len:     Integer;
  Num:     AnsiString;
  Code:    Integer;
  SrgChar: Array[0..1] of WideChar;
begin
  TextSJ := ASrc;
  Len := Length(TextSJ);
  Start := 1;

  while Start <= Len do begin

    Idx1 := PosEx('&#', TextSJ, Start);
    if Idx1 >= Start then
      Idx2  := PosEx(';',  TextSJ, Idx1)
    else
      Idx2  := 0;

    // 以降に数値文字参照なし
    if Idx2 < Start then begin
      TextUC := TextUC + WideString(Copy(TextSJ, Start, Len - Start + 1));
      Break;
    end;

    // ゴミの'&#'ではないかチェック
    while True do begin
      Idx11 := PosEx('&#', TextSJ, Idx1 + 1);
      if (Idx11 < 1) or (Idx11 > Idx2) then
        Break;
      Idx1 := Idx11;  // Idx2とペアになる'&#'の候補
    end;

    // 数値文字参照を含まない部分のみそのままUFT-16へ
    TextUC := TextUC + WideString(Copy(TextSJ, Start, Idx1 - Start));

    // 数値文字参照の数値部分を取り出して整数化
    Start := Idx1 + 2;
    Num := Copy(TextSJ, Start, Idx2 - Start);
    if (Num[1] = 'x') or (Num[1] = 'X') then
      Num[1] := '$';  // 16進数の場合はDelphi形式へ
    Code := StrToIntDef(Num, 0);

    // サロゲートペア
    if (Code >= SG_CP_MIN) and (Code <= SG_CP_MAX) then begin
      Code := Code - SG_CP_MIN;
      SrgChar[0] := WideChar(((Code and SG_HIGH_MASK) shr SG_CP_LOW_SIZE) + SG_HIGH_START);
      SrgChar[1] := WideChar( (Code and SG_LOW_MASK)                      + SG_LOW_START);

      if IsSurrogatePair(SrgChar, 0, 1) then   // チェック
        TextUC := TextUC + WideString(SrgChar)
      else
        TextUC := TextUC + ERR_ALT_CHAR;

    // 非サロゲートペア
    end else if (Code > 0) and (Code < SG_CP_MIN) then
      TextUC := TextUC + WideString(WideChar(Code))

    // エラー
    else
      TextUC := TextUC + ERR_ALT_CHAR;

    Start := Idx2 + 1;
  end;

  Result := TextUC;
end;

{ サロゲートペア文字かどうか確認 }
function IsSurrogatePair(AStr: PWideChar; AIdx: Integer; AMax: Integer): Boolean;
var
  CodeH: Integer;
  CodeL: Integer;
begin
  if AIdx < AMax then begin
    CodeH := Ord(AStr[AIdx]);       // 前半(High)
    CodeL := Ord(AStr[AIdx + 1]);   // 後半(Low)
    Result := (CodeH >= SG_HIGH_START) and (CodeH <= SG_HIGH_END) and
              (CodeL >= SG_LOW_START)  and (CodeL <= SG_LOW_END);
  end else
    Result := False;
end;



{ UTF-16文字列半角1文字・全角2文字として長さを切り詰める }
function WideTrimLength(ASrc: WideString; ALen: Integer): WideString;
var
  Len:        Integer;
  BufUC:      PWideChar;
  Cnt:        Integer;
  Code:       Integer;
  CopyLen:		Integer;
  DestLen:		Integer;
  Skip:       Boolean;
begin
  DestLen := 0;		// 半角全角で計算した長さ
	CopyLen := 0;		// 実際にコピーする文字数
  Skip := False;
  BufUC := PWideChar(ASrc);
  Len := Length(ASrc);

  for Cnt := 0 to Len - 1 do begin
  	if DestLen >= ALen then
    	Break;

    if Skip then
    	Skip := False
    else begin
      Code := Ord(BufUC[Cnt]);
      if Code < $100 then begin
        Inc(CopyLen);
        Inc(DestLen);
      end else if DestLen + 2 <= ALen then begin
        Inc(DestLen, 2);
        if IsSurrogatePair(BufUC, Cnt, Len - 1) then begin
          Inc(CopyLen, 2);
          Skip := True;
        end else
          Inc(CopyLen);
      end;
    end;
  end;

	Result := Copy(ASrc, 1, CopyLen);
end;


{ '&'を'&&'に置換する }
function ReplaceAmp(ASrc: WideString): WideString;
var
  Idx: Integer;
  Start: Integer;
	Dest: WideString;
begin
	Dest := ASrc;
  Start := 1;

  while True do begin
    Idx := PosEx('&', Dest, Start);
    if Idx < Start then
	    Break;
    System.Insert('&', Dest, Idx);
    Start := Idx + 2;
  end;

	Result := Dest;
end;

{ クリップボードからUTF-16文字列をコピー }
function GetClipboard: WideString;
var
  MemHandle: HGLOBAL;
begin
  if OpenClipboard(0) then begin
  	MemHandle := 0;
  	try
      MemHandle := GetClipboardData(CF_UNICODETEXT);
      if MemHandle <> 0 then
        Result := PWideChar(GlobalLock(MemHandle));
    finally
    	if MemHandle <> 0 then
        GlobalUnlock(MemHandle);
			CloseClipboard;
    end;
  end;
end;

{ クリップボードにUTF-16文字列をコピー }
function SetClipboard(SrcText: WideString): Boolean;
var
  LenUC: Integer;
  BufUC: PWideChar;
  BufUCSize: Integer;
  MemHandle: HGLOBAL;
  CopySize: Integer;
begin
  LenUC := Length(SrcText);
  CopySize := LenUC * SizeOf(WideChar);
  BufUCSize := (LenUC + 1) * SizeOf(WideChar);
  MemHandle := GlobalAlloc(GMEM_DDESHARE or GMEM_MOVEABLE, BufUCSize);
  BufUC := GlobalLock(MemHandle);
  ZeroMemory(BufUC, BufUCSize);
  CopyMemory(BufUC, PWideChar(SrcText), CopySize);
  GlobalUnlock(MemHandle);

  if OpenClipboard(0) then begin
    EmptyClipboard;
    SetClipboardData(CF_UNICODETEXT, MemHandle);
    CloseClipboard;
    Result := True;
  end else begin
    GlobalFree(MemHandle);
    Result := False;
  end;
end;

{ クリップボードにShift-JIS文字列(数値文字参照を含む)をUTF-16文字列としてコピー }
function SetClipboardFromEncAnsi(SrcText: AnsiString): Boolean;
begin
	Result := SetClipboard(EncAnsiToWideString(SrcText));
end;

end.
