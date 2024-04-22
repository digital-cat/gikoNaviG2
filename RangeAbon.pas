unit RangeAbon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TRangeAbonForm = class(TForm)
    Label1: TLabel;
    EditFrom: TEdit;
    Label2: TLabel;
    EditTo: TEdit;
    ButtonAbon: TButton;
    ButtonCancel: TButton;
    ButtonInvis: TButton;
    procedure FormShow(Sender: TObject);
    procedure ButtonAbonClick(Sender: TObject);
    procedure ButtonInvisClick(Sender: TObject);
  private
    FMaxNo:    Integer;   // ���X�ԍ��ő�l�i�擾�ς݃��X���j
    FFromNo:   Integer;   // �͈͊J�n���X�ԍ�
    FToNo:     Integer;   // �͈͏I�����X�ԍ�
    FAbonType: Integer;   // ���ځ[����

    function ToInt(val: String; var num: Integer): Boolean;
    function GetInputNo: Boolean;
  public
    property MaxNo:    Integer read FMaxNo  write FMaxNo;
    property FromNo:   Integer read FFromNo write FFromNo;
    property ToNo:     Integer read FToNo   write FToNo;
    property AbonType: Integer read FAbonType;

    constructor Create(AOwner: TComponent); reintroduce; virtual;
    destructor  Destroy; override;
  end;
const
  ABON_NORMAL    = 1;   // �ʏ킠�ځ[��
  ABON_INVISIBLE = 0;   // �������ځ[��

var
  RangeAbonForm: TRangeAbonForm;

implementation

{$R *.dfm}

{ �R���X�g���N�^ }
constructor TRangeAbonForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMaxNo    := 0;
  FFromNo   := 0;
  FToNo     := 0;
  FAbonType := ABON_NORMAL;
end;

{ �f�X�g���N�^ }
destructor TRangeAbonForm.Destroy;
begin
  inherited;
end;

{ �t�H�[���\�� }
procedure TRangeAbonForm.FormShow(Sender: TObject);
var
  initFrom: Integer;
  initTo: Integer;
begin
  if (FFromNo >= 1) and (FFromNo <= FMaxNo) then
    initFrom := FFromNo
  else
    initFrom := 1;

  if (FToNo >= 1) and (FToNo <= FMaxNo) then
    initTo := FToNo
  else
    initTo := FMaxNo;

  EditFrom.Text := IntToStr(initFrom);
  EditTo.Text   := IntToStr(initTo);
end;

{ ���X�ԍ������ϊ� }
function TRangeAbonForm.ToInt(val: String; var num: Integer): Boolean;
var
  tempNum: Integer;
  msg: String;
const
  ERR_MSG = '���X�ԍ�������������܂���B';
begin
  try
    tempNum := StrToInt(val);
    if (tempNum >= 1) and (tempNum <= FMaxNo) then begin
      num := tempNum;
      Result := True;
    end else begin
      msg := ERR_MSG + #10#13;
      if tempNum < 1 then
        msg := msg + '1�ȏ�̐��l���w�肵�Ă��������B'
      else
        msg := msg + Format('%d�ȉ��̐��l���w�肵�Ă��������B', [FMaxNo]);
      MessageBox(Handle, PChar(msg), PChar(Caption), MB_OK or MB_ICONERROR);
      Result := False;
    end;
  except
    MessageBox(Handle, ERR_MSG, PChar(Caption), MB_OK or MB_ICONERROR);
    Result := False;
  end;
end;

{ ���̓��X�ԍ��擾 }
function TRangeAbonForm.GetInputNo: Boolean;
var
  valFrom: Integer;
  valTo: Integer;
begin
	Result := False;

  if ToInt(EditFrom.Text, valFrom) = False then
    Exit;

  if ToInt(EditTo.Text, valTo) = False then
    Exit;

  if valFrom <= valTo then begin
    FFromNo := valFrom;
    FToNo   := valTo;
  end else begin
    FFromNo := valTo;
    FToNo   := valFrom;
  end;

	Result := True;
end;

{ ���ځ[��{�^���N���b�N }
procedure TRangeAbonForm.ButtonAbonClick(Sender: TObject);
begin
  if GetInputNo = False then
    Exit;

	FAbonType := ABON_NORMAL;   // �ʏ킠�ځ[��

  ModalResult := mrOk;
end;

{ �������ځ[��{�^���N���b�N }
procedure TRangeAbonForm.ButtonInvisClick(Sender: TObject);
begin
  if GetInputNo = False then
    Exit;

	FAbonType := ABON_INVISIBLE; // �������ځ[��

  ModalResult := mrOk;
end;

end.
