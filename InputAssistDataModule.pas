unit InputAssistDataModule;

interface

uses
  SysUtils, Classes, Windows;

type
  TResistWord = class;

  TInputAssistDM = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
	{ Private �錾 }
	FInit : Boolean;
	FDictionary : TStringList;	///< �o�^�P��ƒ�^���̎���
	FSorted : Boolean;
	function GetSorted: Boolean;	///< �\�[�g�̏�Ԃ̎擾
	procedure SetSorted(Value: Boolean);	///< �\�[�g��Ԃ̐ݒ�

  public
	{ Public �錾 }
	property Sorted : Boolean read GetSorted write SetSorted;
	procedure Init(FilePath: String);
	procedure SaveToFile(FilePath: String);
	function ResistWordCount : Integer;	///<�o�^�P�ꐔ�擾
	function GetResistWord(Index: Integer): TResistWord;	///< �o�^�P��擾
	procedure DeleteResistWord(ResistWord: TResistWord);  ///< �o�^�P��̍폜
	function Add(Key: String): TResistWord;	///< �o�^�P��ǉ�
	procedure ChangeKey(ResistWord: TResistWord);  ///< �o�^�P��̃L�[�ύX
	//! Key���L�[�Ɏ��o�^����Ă���P����擾
	function GetStartWithKeyResistWords(Key: String; var list: TStringList): Integer;
	//! Key���J�e�S���Ɏ��o�^����Ă���P����擾
	function GetStartWithCategoryResistWords(Key: String; var list: TStringList): Integer;
	//! Key�̃J�e�S���ɓo�^����Ă���P����擾
	function GetCategoryResistWords(Key: String; var list: TStringList): Integer;
	//! �o�^�ς݃L�[�̑S�ẴJ�e�S�����X�g�擾
	procedure GetCategoryList(var list: TStringList);
	//! ���ɓo�^�ς݂̃L�[�ƃJ�e�S���̃Z�b�g���ǂ����`�F�b�N
	function IsDupulicate(Key: String; Category: String): Boolean;

  end;

  TResistWord = class(TObject)
  private
	FKey : String;		///< �ϊ����̃L�[�ɂȂ�
	FCategory : String;	///< ����
	FText : String;		///< ��^��
  public
	function GetKey: String;
	procedure SetKey(Value: String);
	function GetCategory: String;
	procedure SetCategory(Value: String);
	function GetText: String;
	procedure SetText(Value: String);
	property Key: String read FKey write FKey;
	property Category: String read FCategory write FCategory;
	property Text: String read GetText write SetText;
  end;

  function CategorySort(List: TStringList; Index1, Index2: Integer): Integer;
  function KeySort(List: TStringList; Index1, Index2: Integer): Integer;
var
  InputAssistDM: TInputAssistDM;

implementation

uses
  MojuUtils, IniFiles;

{$R *.dfm}
//! FKey�ɐݒ肳��Ă���l���擾����
function TResistWord.GetKey: String;
begin
	//�G�X�P�[�v���Ă���=�𕜌�����
	Result := MojuUtils.CustomStringReplace(FKey, '&#61;', '=');
end;
//! FKey�ɒl��ݒ肷��
procedure TResistWord.SetKey(Value: String);
begin
	//=�͕ۑ����Ɏg���̂ŃG�X�P�[�v����
	FKey := MojuUtils.CustomStringReplace(Value, '=', '&#61;');
end;
//! FCategory�ɐݒ肳��Ă���l���擾����
function TResistWord.GetCategory: String;
begin
	//�G�X�P�[�v���Ă���=�𕜌�����
	Result := MojuUtils.CustomStringReplace(FCategory, '&#61;', '=');
end;
//! FCategory�ɒl��ݒ肷��
procedure TResistWord.SetCategory(Value: String);
begin
	//=�͕ۑ����Ɏg���̂ŃG�X�P�[�v����
	FCategory := MojuUtils.CustomStringReplace(Value, '=', '&#61;');
end;
//! FText�ɐݒ肳��Ă���l���擾����
function TResistWord.GetText: String;
begin
	//�G�X�P�[�v���Ă���=�𕜌�����
	Result := MojuUtils.CustomStringReplace(FText, '&#61;', '=');
	// #1�ɂ������s�R�[�h��#13#10�ɕ�������
	Result := MojuUtils.CustomStringReplace(Result, #1, #13#10);
end;
procedure TResistWord.SetText(Value: String);
begin
	//=�͕ۑ����Ɏg���̂ŃG�X�P�[�v����
	FText := MojuUtils.CustomStringReplace(Value, '=', '&#61;');
	//���s�R�[�h��#1�ɂ���i1�s�ɂ��邽��)
	FText := MojuUtils.CustomStringReplace(FText, #13#10, #1);
end;
//! �t�@�C����ǂݍ���ŏ���������
procedure TInputAssistDM.Init(FilePath: String);
var
	ini : TMemIniFile;
	sections: TStringList;
	keys: TStringList;
	i, j : Integer;
	resWord : TResistWord;
begin
	FInit := True;
	try
		// �t�@�C���̑��݂��m�F
		if FileExists(FilePath) then begin
            ini := TMemIniFile.Create(FilePath);
			sections := TStringList.Create;
			keys := TStringList.Create;
			try
				ini.ReadSections(sections);

				for i :=0 to sections.Count - 1 do begin
					keys.Clear;
					ini.ReadSection(sections[i], keys);
					for j := 0 to keys.Count - 1 do begin
						resWord := TResistWord.Create;
						resWord.SetCategory(sections[i]);
						resWord.SetKey(keys[j]);
						resWord.SetText(ini.ReadString(sections[i], keys[j], ''));
						FDictionary.AddObject(resWord.GetKey, resWord);
					end;
				end;
			finally
				keys.Free;
				sections.Free;
				ini.Free;
			end;
			if FSorted Then begin
				FDictionary.CustomSort(KeySort);
			end;
		end;

	except
		FInit := False;
	end;
end;
//! �w�肳�ꂽ�p�X�̃t�@�C���ɕۑ�����
procedure TInputAssistDM.SaveToFile(FilePath: String);
var
	ini : TMemIniFile;
	i : Integer;
	resWord : TResistWord;
begin
	if FileExists(FilePath) then begin
		try
			SysUtils.DeleteFile(FilePath);
		except
		end;
	end;

	ini := TMemIniFile.Create(FilePath);
	try
		for i :=0 to FDictionary.Count - 1 do begin
			resWord := TResistWord(FDictionary.Objects[i]);
			ini.WriteString(resWord.FCategory, resWord.FKey, resWord.FText);
		end;
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;
//! �f�X�g���N�^
procedure TInputAssistDM.DataModuleDestroy(Sender: TObject);
var
	i : Integer;
begin
	if (FDictionary <> nil) then begin
		for i := FDictionary.Count - 1 downto 0 do begin
			TResistWord(FDictionary.Objects[i]).Free;
		end;
		FDictionary.Clear;
		FDictionary.Capacity := 0;
		FDictionary.Free;
	end;
end;
//! �R���X�g���N�^
procedure TInputAssistDM.DataModuleCreate(Sender: TObject);
begin
	FDictionary := TStringList.Create;
	FDictionary.Sorted := False;
	FSorted := True;
end;
//! �o�^�P�ꐔ�擾
function TInputAssistDM.ResistWordCount : Integer;
begin
	Result := 0;
	if (FDictionary <> nil) then begin
		Result := FDictionary.Count;
	end;
end;
//! �o�^�P��擾
function TInputAssistDM.GetResistWord(Index: Integer): TResistWord;
begin
	Result := nil;
	if (FDictionary <> nil) then begin
		if (Index >= 0) and (Index < FDictionary.Count) then begin
			Result := TResistWord(FDictionary.Objects[index]);
		end;
	end;
end;
//! �o�^�P��̍폜
procedure TInputAssistDM.DeleteResistWord(ResistWord: TResistWord);
var
	i : Integer;
begin
	if (FDictionary <> nil) then begin
		for i := 0 to FDictionary.Count - 1 do begin
			if (ResistWord = FDictionary.Objects[i]) then begin
				TResistWord(FDictionary.Objects[i]).Free;
				FDictionary.Delete(i);
				break;
			end;
		end;
		if FSorted Then begin
			FDictionary.CustomSort(KeySort);
		end;
	end;
end;
//! �o�^�P��ǉ�
function TInputAssistDM.Add(Key: String): TResistWord;
var
	resWord : TResistWord;
begin
	Result := nil;
	if (FDictionary <> nil) then begin
		resWord := TResistWord.Create;
		resWord.SetKey(Key);
		resWord.SetCategory('�J�e�S��');
		resWord.SetText('��^��');
		FDictionary.AddObject(Key, resWord);
		Result := resWord;
		if FSorted Then begin
			FDictionary.CustomSort(KeySort);
		end;
	end;
end;
//! �o�^�P��̃L�[�ύX
procedure TInputAssistDM.ChangeKey(ResistWord: TResistWord);
var
	i : Integer;
begin
	if (FDictionary <> nil) then begin
		for i := 0 to FDictionary.Count - 1 do begin
			if (ResistWord = FDictionary.Objects[i]) then begin
				FDictionary.Strings[i] := ResistWord.GetKey;
				break;
			end;
		end;
		if FSorted Then begin
			FDictionary.CustomSort(KeySort);
		end;

	end;
end;
//! Key�����o�^����Ă���P����擾
function TInputAssistDM.GetStartWithKeyResistWords(Key: String; var list: TStringList): Integer;
var
	i : Integer;
	resWord : TResistWord;

begin
	Result := 0;
	if (FDictionary <> nil) and (list <> nil) then begin
		Key := ZenToHan(Key);
		for i := 0 to FDictionary.Count - 1 do begin
			if (AnsiPos(Key, ZenToHan(FDictionary.Strings[i])) = 1) then begin
				Inc(Result);
				resWord := TResistWord(FDictionary.Objects[i]);
				list.AddObject(resWord.GetKey + '(' +
								resWord.GetCategory + ')', resWord);
			end else if (Result > 0) then begin
				//�\�[�g����Ă��邩��A�q�b�g����ΘA������͂�
				break;
			end;
		end;
	end;
end;
//! Key���J�e�S���Ɏ��o�^����Ă���P����擾
function TInputAssistDM.GetStartWithCategoryResistWords(Key: String; var list: TStringList): Integer;
var
	i : Integer;
	resWord : TResistWord;
begin
	Result := 0;
	if (FDictionary <> nil) and (list <> nil) then begin
		Key := ZenToHan(Key);
		for i := 0 to FDictionary.Count - 1 do begin
			resWord := TResistWord(FDictionary.Objects[i]);
			if (AnsiPos(Key, ZenToHan(resWord.GetCategory)) = 1) then begin
				Inc(Result);
				list.AddObject(resWord.GetKey + '(' +
								resWord.GetCategory + ')', resWord);
			end;
		end;
		list.CustomSort(CategorySort);
	end;
end;

//! �\�[�g�̏�Ԃ̎擾
function TInputAssistDM.GetSorted: Boolean;
begin
	Result := FSorted;
end;
//! �\�[�g��Ԃ̐ݒ�
procedure TInputAssistDM.SetSorted(Value: Boolean);
begin
	if (not FSorted) and (Value) then begin
		FDictionary.CustomSort(KeySort);
	end;
	FSorted := Value;
end;
//! Key�̃J�e�S���ɓo�^����Ă���P����擾
function TInputAssistDM.GetCategoryResistWords(Key: String; var list: TStringList): Integer;
var
	i : Integer;
	resWord : TResistWord;
begin
	Result := 0;
	if (FDictionary <> nil) and (list <> nil) then begin
		for i := 0 to FDictionary.Count - 1 do begin
			resWord := TResistWord(FDictionary.Objects[i]);
			if (Key = resWord.GetCategory) then begin
				Inc(Result);
				list.AddObject(resWord.GetKey + '(' +
								resWord.GetCategory + ')', resWord);
			end;
		end;
		list.CustomSort(CategorySort);
	end;
end;

//! �o�^�ς݃L�[�̑S�ẴJ�e�S�����X�g�擾
procedure TInputAssistDM.GetCategoryList(var list: TStringList);
var
	i : Integer;
begin
	if (FDictionary <> nil) and (list <> nil) then begin
		// �d���`�F�b�N��TStringList�̋@�\�ōs��
		list.Clear;
		list.Duplicates := dupIgnore;
		list.Sorted := true;
		list.BeginUpdate;
		for i := 0 to FDictionary.Count - 1 do begin
			list.Add(TResistWord(FDictionary.Objects[i]).GetCategory);
		end;
		list.EndUpdate;
	end;
end;

//! Key���J�e�S���Ɏ��o�^�P���Ԃ����̃\�[�g�p��r���\�b�h
function CategorySort(List: TStringList; Index1, Index2: Integer): Integer;
var
	resWord1 : TResistWord;
	resWord2 : TResistWord;
begin
	Result := 0;
	try
		resWord1 := TResistWord(List.Objects[Index1]);
		resWord2 := TResistWord(List.Objects[Index2]);
		Result := CompareStr(ZenToHan(resWord1.GetCategory),
								 ZenToHan(resWord2.GetCategory));
		if (Result = 0) then begin
			Result := CompareStr(ZenToHan(resWord1.GetKey),
									 ZenToHan(resWord2.GetKey));
		end;
	except
	end;
end;
//! Key��S���p�����̌`�Ń\�[�g����ۂ̔�r���\�b�h
function KeySort(List: TStringList; Index1, Index2: Integer): Integer;
var
	resWord1 : TResistWord;
	resWord2 : TResistWord;
begin
	Result := 0;
	try
		resWord1 := TResistWord(List.Objects[Index1]);
		resWord2 := TResistWord(List.Objects[Index2]);
		Result := CompareStr(ZenToHan(resWord1.FKey),
								 ZenToHan(resWord2.FKey));
		if (Result = 0) then begin
			Result := CompareStr(ZenToHan(resWord1.GetCategory),
									 ZenToHan(resWord2.GetCategory));
		end;
	except
	end;
end;
//! ���ɓo�^�ς݂̃L�[�ƃJ�e�S���̃Z�b�g���ǂ����`�F�b�N
function TInputAssistDM.IsDupulicate(Key: String; Category: String): Boolean;
var
	i : Integer;
begin
	// ���̃��\�b�h�ł́A�\�[�g�ς݂Ƃ͌���Ȃ��̂ŁA�S�ẴL�[��T�����Ă���
	Result := False;
	if (FDictionary <> nil) then begin
		for i := 0 to FDictionary.Count - 1 do begin
			if (Key = FDictionary.Strings[i]) and
				(Category = TResistWord(FDictionary.Objects[i]).GetCategory)
			then begin
				Result := True;
				Break;
			end;
		end;
	end;
end;

end.
