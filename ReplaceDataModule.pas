unit ReplaceDataModule;

interface

uses
  SysUtils, Classes;

type
  TReplaceDM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private �錾 }
    //! �u�����X�g
    FReplaceList: TList;
  public
    { Public �錾 }
    procedure LoadFromFile(const filePath: String);
    function Replace(const source: String): String;
  end;
  TReplace = class(TObject)
  private
    FTarget: String;
    FReplace: String;
  public
    constructor Create(const line: String);
    property Target: String read FTarget write FTarget;
    property Replace: String read FReplace write FReplace;
  end;

var
  ReplaceDM: TReplaceDM;

implementation

uses
    MojuUtils, Dialogs, StrUtils;


{$R *.dfm}

//! �G�X�P�[�v������������
function UnEscape(const source: String): String;
begin
    // �ݒ�t�@�C���ɂ��̂܂܏����Ɛݒ�t�@�C�����̂��폜�����̂�
    // �h�����߂ɉ��L�̕������G�X�P�[�v�ł���悤�ɂ���
    // \. \( \) \{ \} \/ \" \\
    Result := MojuUtils.CustomStringReplace(source, '\.', '.');
    Result := MojuUtils.CustomStringReplace(Result, '\(', '(');
    Result := MojuUtils.CustomStringReplace(Result, '\)', ')');
    Result := MojuUtils.CustomStringReplace(Result, '\{', '{');
    Result := MojuUtils.CustomStringReplace(Result, '\}', '}');
    Result := MojuUtils.CustomStringReplace(Result, '\"', '"');
    Result := MojuUtils.CustomStringReplace(Result, '\/', '/');
    Result := MojuUtils.CustomStringReplace(Result, '\\', '\');
end;

//! �R���X�g���N�^
procedure TReplaceDM.DataModuleCreate(Sender: TObject);
begin
    // �u���Ώە�����ێ����X�g�̐���
    FReplaceList := TList.Create;
end;
//! �f�X�g���N�^
procedure TReplaceDM.DataModuleDestroy(Sender: TObject);
var
    i: Integer;
begin
    if (FReplaceList <> nil) then begin
        // ���X�g�̒��g��free���Ăяo��
        for i := FReplaceList.Count - 1 downto 0 do begin
            TObject(FReplaceList.Items[i]).Free;
        end;
        // ���X�g���폜����
        FReplaceList.Clear;
        FReplaceList.Capacity := 0;
        FreeAndNil(FReplaceList);
    end;
end;
//! �t�@�C���ǂݍ��ݏ���
procedure TReplaceDM.LoadFromFile(const filePath: String);
var
    fileStrings: TStringList;
    i: Integer;
    rep: TReplace;
    ignored: Boolean;
begin
    // �t�@�C���̑��݃`�F�b�N
    if (FileExists(filePath)) then begin
        ignored := False;
        fileStrings := TStringList.Create;
        fileStrings.LoadFromFile(filePath);
        try
            // ���ׂĂ̍s�̂܂킷
            for i := 0 to fileStrings.Count - 1 do begin
                rep := TReplace.Create(fileStrings[i]);
                // <> ���܂܂�Ă��邩�`�F�b�N
                if (AnsiPos('<>', rep.Target) > 0) or
                    (AnsiPos('<>', rep.Replace) > 0) then begin
                    ignored := True;
                end else begin
                    FReplaceList.Add(rep);
                end;
            end;
        finally
            fileStrings.Free;
        end;
        if (ignored) then begin
            ShowMessage('<>���܂ޕ������/�ɒu�����邱�Ƃ͂ł��܂���B'#13#10'�ݒ�t�@�C�����m�F���Ă��������B');
        end;
    end;
end;

//! �u������
function TReplaceDM.Replace(const source: String): String;
var
    i: Integer;
    rep: TReplace;
begin
    Result := source;
    // nil�ł��邱�Ƃ͖������O�̂���
    if (FReplaceList <> nil) then begin
        for i := FReplaceList.Count - 1 downto 0 do begin
            rep := TReplace(FReplaceList.Items[i]);
            Result := MojuUtils.CustomStringReplace(Result, rep.Target, rep.Replace);
        end;
    end;
end;
//! �R���X�g���N�^
constructor TReplace.Create(const line: String);
begin
    Replace := '';
    // 1�s���^�u�ŋ�؂�
    if (AnsiPos(#9, line) > 0) then begin
        Target  := Copy(line, 0, AnsiPos(#9, line) - 1);
        Replace := Copy(line, AnsiPos(#9, line) + 1, Length(line));
    end else begin
        Target := line;
    end;
    // Target�̃G�X�P�[�v�����̕����ɖ߂�
    Target := UnEscape(Target);
    // replace��''�̎��́A�����������̃X�y�[�X�ɐݒ�
    if (Replace = '') then begin
        Replace := StrUtils.DupeString(' ', Length(Target));
    end;
end;

end.
