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
    FMaxNo:    Integer;   // レス番号最大値（取得済みレス数）
    FFromNo:   Integer;   // 範囲開始レス番号
    FToNo:     Integer;   // 範囲終了レス番号
    FAbonType: Integer;   // あぼーん種別

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
  ABON_NORMAL    = 1;   // 通常あぼーん
  ABON_INVISIBLE = 0;   // 透明あぼーん

var
  RangeAbonForm: TRangeAbonForm;

implementation

{$R *.dfm}

{ コンストラクタ }
constructor TRangeAbonForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMaxNo    := 0;
  FFromNo   := 0;
  FToNo     := 0;
  FAbonType := ABON_NORMAL;
end;

{ デストラクタ }
destructor TRangeAbonForm.Destroy;
begin
  inherited;
end;

{ フォーム表示 }
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

{ レス番号整数変換 }
function TRangeAbonForm.ToInt(val: String; var num: Integer): Boolean;
var
  tempNum: Integer;
  msg: String;
const
  ERR_MSG = 'レス番号が正しくありません。';
begin
  try
    tempNum := StrToInt(val);
    if (tempNum >= 1) and (tempNum <= FMaxNo) then begin
      num := tempNum;
      Result := True;
    end else begin
      msg := ERR_MSG + #10#13;
      if tempNum < 1 then
        msg := msg + '1以上の数値を指定してください。'
      else
        msg := msg + Format('%d以下の数値を指定してください。', [FMaxNo]);
      MessageBox(Handle, PChar(msg), PChar(Caption), MB_OK or MB_ICONERROR);
      Result := False;
    end;
  except
    MessageBox(Handle, ERR_MSG, PChar(Caption), MB_OK or MB_ICONERROR);
    Result := False;
  end;
end;

{ 入力レス番号取得 }
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

{ あぼーんボタンクリック }
procedure TRangeAbonForm.ButtonAbonClick(Sender: TObject);
begin
  if GetInputNo = False then
    Exit;

	FAbonType := ABON_NORMAL;   // 通常あぼーん

  ModalResult := mrOk;
end;

{ 透明あぼーんボタンクリック }
procedure TRangeAbonForm.ButtonInvisClick(Sender: TObject);
begin
  if GetInputNo = False then
    Exit;

	FAbonType := ABON_INVISIBLE; // 透明あぼーん

  ModalResult := mrOk;
end;

end.
