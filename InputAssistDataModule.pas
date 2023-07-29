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
	{ Private 宣言 }
	FInit : Boolean;
	FDictionary : TStringList;	///< 登録単語と定型文の辞書
	FSorted : Boolean;
	function GetSorted: Boolean;	///< ソートの状態の取得
	procedure SetSorted(Value: Boolean);	///< ソート状態の設定

  public
	{ Public 宣言 }
	property Sorted : Boolean read GetSorted write SetSorted;
	procedure Init(FilePath: String);
	procedure SaveToFile(FilePath: String);
	function ResistWordCount : Integer;	///<登録単語数取得
	function GetResistWord(Index: Integer): TResistWord;	///< 登録単語取得
	procedure DeleteResistWord(ResistWord: TResistWord);  ///< 登録単語の削除
	function Add(Key: String): TResistWord;	///< 登録単語追加
	procedure ChangeKey(ResistWord: TResistWord);  ///< 登録単語のキー変更
	//! Keyをキーに持つ登録されている単語を取得
	function GetStartWithKeyResistWords(Key: String; var list: TStringList): Integer;
	//! Keyをカテゴリに持つ登録されている単語を取得
	function GetStartWithCategoryResistWords(Key: String; var list: TStringList): Integer;
	//! Keyのカテゴリに登録されている単語を取得
	function GetCategoryResistWords(Key: String; var list: TStringList): Integer;
	//! 登録済みキーの全てのカテゴリリスト取得
	procedure GetCategoryList(var list: TStringList);
	//! 既に登録済みのキーとカテゴリのセットかどうかチェック
	function IsDupulicate(Key: String; Category: String): Boolean;

  end;

  TResistWord = class(TObject)
  private
	FKey : String;		///< 変換時のキーになる
	FCategory : String;	///< 分類
	FText : String;		///< 定型文
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
//! FKeyに設定されている値を取得する
function TResistWord.GetKey: String;
begin
	//エスケープしている=を復元する
	Result := MojuUtils.CustomStringReplace(FKey, '&#61;', '=');
end;
//! FKeyに値を設定する
procedure TResistWord.SetKey(Value: String);
begin
	//=は保存時に使うのでエスケープする
	FKey := MojuUtils.CustomStringReplace(Value, '=', '&#61;');
end;
//! FCategoryに設定されている値を取得する
function TResistWord.GetCategory: String;
begin
	//エスケープしている=を復元する
	Result := MojuUtils.CustomStringReplace(FCategory, '&#61;', '=');
end;
//! FCategoryに値を設定する
procedure TResistWord.SetCategory(Value: String);
begin
	//=は保存時に使うのでエスケープする
	FCategory := MojuUtils.CustomStringReplace(Value, '=', '&#61;');
end;
//! FTextに設定されている値を取得する
function TResistWord.GetText: String;
begin
	//エスケープしている=を復元する
	Result := MojuUtils.CustomStringReplace(FText, '&#61;', '=');
	// #1にした改行コードを#13#10に復元する
	Result := MojuUtils.CustomStringReplace(Result, #1, #13#10);
end;
procedure TResistWord.SetText(Value: String);
begin
	//=は保存時に使うのでエスケープする
	FText := MojuUtils.CustomStringReplace(Value, '=', '&#61;');
	//改行コードを#1にする（1行にするため)
	FText := MojuUtils.CustomStringReplace(FText, #13#10, #1);
end;
//! ファイルを読み込んで初期化する
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
		// ファイルの存在を確認
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
//! 指定されたパスのファイルに保存する
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
//! デストラクタ
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
//! コンストラクタ
procedure TInputAssistDM.DataModuleCreate(Sender: TObject);
begin
	FDictionary := TStringList.Create;
	FDictionary.Sorted := False;
	FSorted := True;
end;
//! 登録単語数取得
function TInputAssistDM.ResistWordCount : Integer;
begin
	Result := 0;
	if (FDictionary <> nil) then begin
		Result := FDictionary.Count;
	end;
end;
//! 登録単語取得
function TInputAssistDM.GetResistWord(Index: Integer): TResistWord;
begin
	Result := nil;
	if (FDictionary <> nil) then begin
		if (Index >= 0) and (Index < FDictionary.Count) then begin
			Result := TResistWord(FDictionary.Objects[index]);
		end;
	end;
end;
//! 登録単語の削除
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
//! 登録単語追加
function TInputAssistDM.Add(Key: String): TResistWord;
var
	resWord : TResistWord;
begin
	Result := nil;
	if (FDictionary <> nil) then begin
		resWord := TResistWord.Create;
		resWord.SetKey(Key);
		resWord.SetCategory('カテゴリ');
		resWord.SetText('定型文');
		FDictionary.AddObject(Key, resWord);
		Result := resWord;
		if FSorted Then begin
			FDictionary.CustomSort(KeySort);
		end;
	end;
end;
//! 登録単語のキー変更
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
//! Keyを持つ登録されている単語を取得
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
				//ソートされているから、ヒットすれば連続するはず
				break;
			end;
		end;
	end;
end;
//! Keyをカテゴリに持つ登録されている単語を取得
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

//! ソートの状態の取得
function TInputAssistDM.GetSorted: Boolean;
begin
	Result := FSorted;
end;
//! ソート状態の設定
procedure TInputAssistDM.SetSorted(Value: Boolean);
begin
	if (not FSorted) and (Value) then begin
		FDictionary.CustomSort(KeySort);
	end;
	FSorted := Value;
end;
//! Keyのカテゴリに登録されている単語を取得
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

//! 登録済みキーの全てのカテゴリリスト取得
procedure TInputAssistDM.GetCategoryList(var list: TStringList);
var
	i : Integer;
begin
	if (FDictionary <> nil) and (list <> nil) then begin
		// 重複チェックをTStringListの機能で行う
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

//! Keyをカテゴリに持つ登録単語を返す時のソート用比較メソッド
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
//! Keyを全半角無視の形でソートする際の比較メソッド
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
//! 既に登録済みのキーとカテゴリのセットかどうかチェック
function TInputAssistDM.IsDupulicate(Key: String; Category: String): Boolean;
var
	i : Integer;
begin
	// このメソッドでは、ソート済みとは限らないので、全てのキーを探索している
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
