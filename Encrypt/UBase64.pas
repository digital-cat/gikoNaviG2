unit UBase64;
(* 2002 Twiddle *)
(* かなりインチキ＆効率悪い＆真面目に検証してない *)

interface
uses
  Classes,
  SysUtils;

procedure HogeBase64Encode(inputStream, outputStream: TStream); overload;
procedure HogeBase64Decode(inputStream, outputStream: TStream); overload;

function HogeBase64Encode(const inputStr: string): string; overload;
function HogeBase64Decode(const inputStr: string): string; overload;
function HogeBase64Encode(inputArray: array of Byte): string; overload;

implementation

const
  Enc64Tbl: array[0..63] of Char =
             ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
              'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
              'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
              'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/');

  (* デコードテーブル メンドイ *)

procedure HogeBase64Encode(inputStream, outputStream: TStream);
var
  inBuf: array [0..2] of byte;
  outBuf: array[0..3] of Char;
  size: integer;
begin
  repeat
    size := inputStream.Read(inBuf, sizeof(inBuf));
    case size of
    0: break;
    1:
      begin
        outBuf[0] := Enc64Tbl[inBuf[0] shr 2];
        outBuf[1] := Enc64Tbl[(inBuf[0] shl 4) and $3F];
        outBuf[2] := '=';
        outBuf[3] := '=';
      end;
    2:
      begin
        outBuf[0] := Enc64Tbl[inBuf[0] shr 2];
        outBuf[1] := Enc64Tbl[((inBuf[0] shl 4) or (inBuf[1] shr 4)) and $3F];
        outBuf[2] := Enc64Tbl[((inBuf[1] shl 2)                     ) and $3F];
        outBuf[3] := '=';
      end;
    3:
      begin
        outBuf[0] := Enc64Tbl[inBuf[0] shr 2];
        outBuf[1] := Enc64Tbl[((inBuf[0] shl 4) or (inBuf[1] shr 4)) and $3F];
        outBuf[2] := Enc64Tbl[((inBuf[1] shl 2) or (inBuf[2] shr 6)) and $3F];
        outBuf[3] := Enc64Tbl[inBuf[2] and $3F];
      end;
    end;
    outputStream.WriteBuffer(outBuf, sizeof(outBuf));
  until size < sizeof(inBuf);
end;

procedure HogeBase64Decode(inputStream, outputStream: TStream);
var
  inBuf: array [0..3] of Char;
  outBuf: array[0..2] of byte;
  code: byte;
  size: integer;
  i, endPos: integer;
begin
  code := 0;
  repeat
    size := inputStream.Read(inBuf, sizeof(inBuf));
    if size = 0 then
      break;
    if size <> 4 then
      raise EConvertError.Create('unexpected size');
    for i := 0 to sizeof(outBuf) -1 do
      outBuf[i] := 0;
    endPos := -1;
    for i := 0 to sizeof(inBuf) - 1 do
    begin
      case inBuf[i] of
      'A'..'Z': code := Ord(inBuf[i]) - Ord('A');
      'a'..'z': code := Ord(inBuf[i]) - Ord('a') + 26;
      '0'..'9': code := Ord(inBuf[i]) - Ord('0') + 26 + 26;
      '+':      code := 62;
      '/':      code := 63;
      '=':
        begin
          if i = 0 then
            raise EConvertError.Create('unexpected "="');
          endPos := i -1;
          break;
        end;
      else
        raise EConvertError.Create(Format('unexpected code($%2.2X)', [Ord(inBuf[i])]));
      end;
      case i of
      0:
        begin
          outBuf[0] := code shl 2;
        end;
      1:
        begin
          outBuf[0] := outBuf[0] or (code shr 4);
          outBuf[1] := byte( code shl 4 );
        end;
      2:
        begin
          outBuf[1] := outBuf[1] or (code shr 2);
          outBuf[2] := byte( code shl 6 );
        end;
      3:
        begin
          outBuf[2] := outBuf[2] or code;
        end;
      end;
    end;
    if endPos < 0 then
      endPos := sizeof(outBuf);
    outputStream.WriteBuffer(outBuf, endPos);
  until size < sizeof(inBuf);
end;


function HogeBase64Encode(const inputStr: string): string; overload;
var
  inputStream, outputStream: TStringStream;
begin
  inputStream := TStringStream.Create(inputStr);
  outputStream:= TStringStream.Create('');
  HogeBase64Encode(inputStream, outputStream);
  result := outputStream.DataString;
  outputStream.Free;
  inputStream.Free;
end;

function HogeBase64Decode(const inputStr: string): string; overload;
var
  inputStream, outputStream: TStringStream;
begin
  inputStream := TStringStream.Create(inputStr);
  outputStream:= TStringStream.Create('');
  HogeBase64Decode(inputStream, outputStream);
  result := outputStream.DataString;
  outputStream.Free;
  inputStream.Free;
end;

function HogeBase64Encode(inputArray: array of Byte): string; overload;
var
  inputStream: TMemoryStream;
  outputStream: TStringStream;
begin
  inputStream := TMemoryStream.Create;
  inputStream.WriteBuffer(inputArray, Length(inputArray));
  inputStream.Position := 0;
  outputStream:= TStringStream.Create('');
  HogeBase64Encode(inputStream, outputStream);
  result := outputStream.DataString;
  outputStream.Free;
  inputStream.Free;
end;

end.
