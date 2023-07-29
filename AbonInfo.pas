unit AbonInfo;

interface

uses
  SysUtils;

type
  TAbonType = (atStandard, stTransparent);
  TCompType = (ctStandard, ctRegexp);
  TTargetType = (ttAll, ttThread, ttBoard);

  TLineInfo = class(TObject)
  public
    AbonType:   TAbonType;
    CompType:   TCompType;
    TargetType: TTargetType;
    TargetBoard: String;
    TargetThread: String;
	constructor Create;
    function ToString: String;
    procedure Clear;
    procedure Copy(const Src: TLineInfo);
  end;

  TAbonThread = class(TObject)
  public
    Is2ch:  Boolean;
    Board:  String;
    Thread: String;
	constructor Create;
    procedure Clear;
    function IsTarget(Chk: String): Boolean;
  end;

const
    DEF_REGEXP:  String = '{{REGEXP}}';
    DEF_THREAD:  String = '{{THREAD:';
    DEF_BOARD:   String = '{{BOARD:';
    DEF_END:     String = '}}';

implementation

constructor TAbonThread.Create;
begin
    Is2ch := False;
end;

procedure TAbonThread.Clear;
begin
    Is2ch  := False;
    Board  := '';
    Thread := '';
end;

function TAbonThread.IsTarget(Chk: String): Boolean;
var
    Target: String;
    EndPos: Integer;
    CopyLen: Integer;
    DefLen: Integer;
begin
    EndPos := AnsiPos(DEF_END, Chk);
    if (EndPos < 1) then begin
        Result := True;     // �w��`���ƈႤ�̂őΏ�
    end
    else if (AnsiPos(DEF_BOARD, Chk) = 1) then begin
        if (Is2ch = False) then begin
            Result := False;     // 2ch�łȂ�
        end else begin
            DefLen := Length(DEF_BOARD);
            CopyLen := EndPos - DefLen - 1;
            Target := Copy(Chk, DefLen + 1, CopyLen);
            if (Target = Board) then
                Result := True      // �Ώۂ̔�
            else
                Result := False;    // �Ώۂ̔ł͂Ȃ�
        end;
    end
    else if (AnsiPos(DEF_THREAD, Chk) = 1) then begin
        if (Is2ch = False) then begin
            Result := False;     // 2ch�łȂ�
        end else begin
            DefLen := Length(DEF_THREAD);
            CopyLen := EndPos - DefLen - 1;
            Target := Copy(Chk, DefLen + 1, CopyLen);
            if (Target = Board + '/' + Thread) then
                Result := True      // �Ώۂ̃X��
            else
                Result := False;    // �Ώۂ̃X���ł͂Ȃ�
        end;
    end
    else begin
        Result := True;     // �w��`���ƈႤ�̂őΏ�
    end;
end;

constructor TLineInfo.Create;
begin
    AbonType := atStandard;
    CompType := ctStandard;
    TargetType := ttAll;
end;

function TLineInfo.ToString: String;
var
    dst: String;
begin
    case AbonType of
        atStandard:    dst := '�ʏ킠�ځ[��E';
        stTransparent: dst := '�������ځ[��E';
        else           dst := '�E';
    end;
    case CompType of
        ctStandard:    dst := dst + '�ʏ��r�E';
        ctRegexp:      dst := dst + '���K�\���E';
        else           dst := dst + '�E';
    end;
    case TargetType of
        ttAll:         dst := dst + '�S�X���Ώ�';
        ttThread:      dst := dst + '�X���w��';
        ttBoard:       dst := dst + '�w��';
    end;
    Result := dst;
end;

procedure TLineInfo.Clear;
begin
    AbonType     := atStandard;
    CompType     := ctStandard;
    TargetType   := ttAll;
    TargetBoard  := '';
    TargetThread := '';
end;

procedure TLineInfo.Copy(const Src: TLineInfo);
begin
    AbonType     := Src.AbonType;
    CompType     := Src.CompType;
    TargetType   := Src.TargetType;
    TargetBoard  := Src.TargetBoard;
    TargetThread := Src.TargetThread;
end;

end.
