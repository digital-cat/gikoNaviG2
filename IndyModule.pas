unit IndyModule;

interface

uses
  SysUtils, Classes, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze;

type
  TIndyMdl = class(TDataModule)
    { TIdAntiFreeze�̓v���Z�X���ɃC���X�^���X1�̂� }
    IdAntiFreeze: TIdAntiFreeze;
  private
    { Private �錾 }
  public
    { Public �錾 }
    function StartAntiFreeze(IdleTimeOut : Integer): Boolean;
    function EndAntiFreeze: Boolean;
    function MakeRangeHeader(RangeStart : Integer; RangeEnd : Integer): String;
  end;

var
  IndyMdl: TIndyMdl;

implementation

{$R *.dfm}

function TIndyMdl.StartAntiFreeze(IdleTimeOut : Integer): Boolean;
begin
  try
    IdAntiFreeze.Active := False;
    IdAntiFreeze.IdleTimeOut := IdleTimeOut;
    IdAntiFreeze.Active := True;
    Result := True;
  except
    Result := False;
  end;
end;

function TIndyMdl.EndAntiFreeze: Boolean;
begin
  try
    IdAntiFreeze.Active := False;
    Result := True;
  except
    Result := False;
  end;
end;

{ HTTP���N�G�X�g�w�b�_ 'Range' �̐ݒ�l�쐬 }
function TIndyMdl.MakeRangeHeader(RangeStart : Integer; RangeEnd : Integer): String;
begin
  if RangeEnd <> 0 then begin
    Result := 'bytes=' + IntToStr(RangeStart) + '-' + IntToStr(RangeEnd);
  end else begin
    Result := 'bytes=' + IntToStr(RangeStart) + '-';
  end;
end;

end.
