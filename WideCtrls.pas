unit WideCtrls;

(*
  Unicode�Ή��R���g���[��
*)

interface

uses
  Messages, Windows, Controls, StdCtrls, Classes, SysUtils, StrUtils, TntStdCtrls;

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
public
  constructor Create(AOwner: TComponent); override;
  procedure Free;
  property EncodeText: AnsiString read GetEncodeText;
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




{ UTF-16�������Shift-JIS������֕ϊ� Shift-JIS�ɑ��݂��Ȃ������͐��l�����Q�� }
function WideToEncAnsiString(ASrc: WideString): AnsiString;

{ Shift-JIS������(���l�����Q�Ƃ��܂�)��UTF-16������֕ϊ� }
function EncAnsiToWideString(ASrc: AnsiString): WideString;

{ �T���Q�[�g�y�A�������ǂ����m�F }
function IsSurrogatePair(AStr: PWideChar; AIdx: Integer; AMax: Integer): Boolean;

implementation


{ TWideMemo }

{ �R���X�g���N�^ }
constructor TWideMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ �f�X�g���N�^ }
procedure TWideMemo.Free;
begin
  inherited Free;
end;

{ ���̓e�L�X�g�擾 }
function TWideMemo.GetEncodeText: AnsiString;
begin
  try
    Result := WideToEncAnsiString(Text);
  except
  end;
end;

{ �e�L�X�g�֕�����}�� }
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

{ �e�L�X�g�ֈ��p������\��t�� }
procedure TWideMemo.QuotePaste(QuoteStr: AnsiString);
const
  RET_CHAR: WideString = #13#10;
var
  TextDst: WideString;
  TextSrc: WideString;
  QuoteUC: WideString;
  Ret: Integer;
begin
  TextSrc := Text;
  QuoteUC := QuoteStr;

  while (Length(TextSrc) > 0) do begin
    Ret := Pos(RET_CHAR, TextSrc);
    if (Ret < 1) then begin // ���s�Ȃ�
      TextDst := TextDst + QuoteUC + TextSrc;
      Break;
    end;

    // ���s�܂ł�1�s
    TextDst := TextDst + QuoteUC + Copy(TextSrc, 1, Ret + 1);
    Delete(TextSrc, 1, Ret + 1);
  end;

  if (Length(TextDst) > 0) then
    InsertText(TextDst);
end;


{ TWideComboBox }

{ �R���X�g���N�^ }
constructor TWideComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ �f�X�g���N�^ }
procedure TWideComboBox.Free;
begin
  inherited Free;
end;

{ ���̓e�L�X�g�擾 }
function TWideComboBox.GetEncodeText: AnsiString;
begin
  try
    Result := WideToEncAnsiString(Text);
  except
  end;
end;

{ �e�L�X�g�ݒ� }
procedure TWideComboBox.SetEncodeText(AText: AnsiString);
begin
  try
    Text := EncAnsiToWideString(AText);
  except
  end;
end;

{ ���X�g������ݒ� }
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

{ ���X�g���ڕ�����擾 }
function TWideComboBox.EncItems(AIdx: Integer): AnsiString;
begin
  try
    Result := WideToEncAnsiString(Items[AIdx]);
  except
  end;
end;



{ TWideEdit }

{ �R���X�g���N�^ }
constructor TWideEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ �f�X�g���N�^ }
procedure TWideEdit.Free;
begin
  inherited Free;
end;

{ ���̓e�L�X�g�擾 }
function TWideEdit.GetEncodeText: AnsiString;
begin
  try
    Result := WideToEncAnsiString(Text);
  except
  end;
end;



{ TWideLabel }

{ �R���X�g���N�^ }
constructor TWideLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;


{ �f�X�g���N�^ }

procedure TWideLabel.Free;

begin

  inherited Free;
end;

{ �\���L���v�V�����擾 }
function TWideLabel.GetEncodeCaption: AnsiString;
begin
  try
    Result := WideToEncAnsiString(Caption);
  except
  end;
end;

{ �\���L���v�V�����ݒ� }
procedure TWideLabel.SetEncodeCaption(ACaption: AnsiString);
begin
  try
    Caption := EncAnsiToWideString(ACaption);
  except
  end;
end;




{ UTF-16�T���Q�[�g�y�A�����̐��l�����Q�ƕϊ��p��` }
const
  SG_HIGH_START  = $D800;   // �T���Q�[�g�O���J�n�R�[�h
  SG_HIGH_END    = $DBFF;   // �T���Q�[�g�O���I���R�[�h
  SG_LOW_START   = $DC00;   // �T���Q�[�g�㔼�J�n�R�[�h
  SG_LOW_END     = $DFFF;   // �T���Q�[�g�㔼�I���R�[�h
  SG_HIGH_MASK   = $1FFC00; // �T���Q�[�g�O���p�R�[�h�|�C���g�}�X�N(11bit)
  SG_LOW_MASK    = $03FF;   // �T���Q�[�g�㔼�p�R�[�h�|�C���g�}�X�N(10bit)
  SG_CP_MIN      = $010000; // �T���Q�[�g�y�A�R�[�h�|�C���g�ŏ��l
  SG_CP_MAX      = $10FFFF; // �T���Q�[�g�y�A�R�[�h�|�C���g�ő�l
  SG_CP_LOW_SIZE = 10;      // �T���Q�[�g�㔼�R�[�h�|�C���g�T�C�Y(10bit)

  ERR_ALT_CHAR: WideString = '��';   // ���l�����Q�ƕϊ��G���[��֕���


{ UTF-16�������Shift-JIS������֕ϊ� Shift-JIS�ɑ��݂��Ȃ������͐��l�����Q�� }
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

      // Shift-JIS�ɂ����镶��
      if (UseDefChar = False) then begin
        TextSJ := TextSJ + AnsiString(BufSJ);

      // Shift-JIS�ɂ͂Ȃ�����
      end else begin
        // �T���Q�[�g�y�A����
        if IsSurrogatePair(BufUC, Cnt, Len - 1) then begin
          CodeH := Ord(BufUC[Cnt]);
          CodeL := Ord(BufUC[Cnt + 1]);
          Code := ((CodeH - SG_HIGH_START) shl SG_CP_LOW_SIZE) or (CodeL - SG_LOW_START) + SG_CP_MIN;
          Skip := True;

        // ��T���Q�[�g�y�A����
        end else
          Code := Ord(BufUC[Cnt]);

        TextSJ := TextSJ + Format('&#%d;', [Code]);
      end;
    end;
  end;

  Result := TextSJ;
end;

{ Shift-JIS������(���l�����Q�Ƃ��܂�)��UTF-16������֕ϊ� }
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

    // �ȍ~�ɐ��l�����Q�ƂȂ�
    if Idx2 < Start then begin
      TextUC := TextUC + WideString(Copy(TextSJ, Start, Len - Start + 1));
      Break;
    end;

    // �S�~��'&#'�ł͂Ȃ����`�F�b�N
    while True do begin
      Idx11 := PosEx('&#', TextSJ, Idx1 + 1);
      if (Idx11 < 1) or (Idx11 > Idx2) then
        Break;
      Idx1 := Idx11;  // Idx2�ƃy�A�ɂȂ�'&#'�̌��
    end;

    // ���l�����Q�Ƃ��܂܂Ȃ������݂̂��̂܂�UFT-16��
    TextUC := TextUC + WideString(Copy(TextSJ, Start, Idx1 - Start));

    // ���l�����Q�Ƃ̐��l���������o���Đ�����
    Start := Idx1 + 2;
    Num := Copy(TextSJ, Start, Idx2 - Start);
    if (Num[1] = 'x') or (Num[1] = 'X') then
      Num[1] := '$';  // 16�i���̏ꍇ��Delphi�`����
    Code := StrToIntDef(Num, 0);

    // �T���Q�[�g�y�A
    if (Code >= SG_CP_MIN) and (Code <= SG_CP_MAX) then begin
      Code := Code - SG_CP_MIN;
      SrgChar[0] := WideChar(((Code and SG_HIGH_MASK) shr SG_CP_LOW_SIZE) + SG_HIGH_START);
      SrgChar[1] := WideChar( (Code and SG_LOW_MASK)                      + SG_LOW_START);

      if IsSurrogatePair(SrgChar, 0, 1) then   // �`�F�b�N
        TextUC := TextUC + WideString(SrgChar)
      else
        TextUC := TextUC + ERR_ALT_CHAR;

    // ��T���Q�[�g�y�A
    end else if (Code > 0) and (Code < SG_CP_MIN) then
      TextUC := TextUC + WideString(WideChar(Code))

    // �G���[
    else
      TextUC := TextUC + ERR_ALT_CHAR;

    Start := Idx2 + 1;
  end;

  Result := TextUC;
end;

{ �T���Q�[�g�y�A�������ǂ����m�F }
function IsSurrogatePair(AStr: PWideChar; AIdx: Integer; AMax: Integer): Boolean;
var
  CodeH: Integer;
  CodeL: Integer;
begin
  if AIdx < AMax then begin
    CodeH := Ord(AStr[AIdx]);       // �O��(High)
    CodeL := Ord(AStr[AIdx + 1]);   // �㔼(Low)
    Result := (CodeH >= SG_HIGH_START) and (CodeH <= SG_HIGH_END) and
              (CodeL >= SG_LOW_START)  and (CodeL <= SG_LOW_END);
  end else
    Result := False;
end;

end.
