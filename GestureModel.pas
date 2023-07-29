unit GestureModel;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls,	StrUtils, IniFiles,
	ActnList;

type
	TGestureModel = class(TObject)
	private
		FGestureList: TStringList;
		FMargin: Integer;
		function CheckGestureStr(Gesture: string): Boolean;
		function GetActionItem(ActionList: TActionList; ActionStr: string): TAction;
		function Get(Index: Integer): string;
		function GetObject(Index: Integer): TObject;
		function GetCount: Integer;
	public
		constructor Create;
		destructor Destroy; override;
		procedure AddGesture(Gesture: string; Action: TAction);
		procedure DeleteGesture(Gesture: string);
		procedure ClearGesture;
		function GetGestureAction(Gesture: string): TAction;
		function GetActionGesture( action : TAction ) : string;
		property Margin: Integer read FMargin write FMargin;
		procedure LoadGesture(FileName: string; ActionList: TActionList);
		procedure SaveGesture(FileName: string);

		property Items[Index: Integer]: string read Get; default;
		property Objects[Index: Integer]: TObject read GetObject;
		property Count: Integer read GetCount;
	end;

implementation

constructor TGestureModel.Create;
begin
	inherited Create;
	FGestureList := TStringList.Create;
end;

destructor TGestureModel.Destroy;
begin
	FreeAndNil(FGestureList);
	inherited Destroy;
end;

//指定されたindexのジェスチャー文字列を返す
function TGestureModel.Get(Index: Integer): string;
begin
	if (Index < 0) or (Index >= FGestureList.Count) then
		raise Exception.Create('ERR');
	Result := FGestureList[Index];
end;

//指定されたindexのオブジェクトを返す
function TGestureModel.GetObject(Index: Integer): TObject;
begin
	if (Index < 0) or (Index >= FGestureList.Count) then
		raise Exception.Create('ERR');
	Result := FGestureList.Objects[Index];
end;

//ジェスチャーの文字列に変な文字が入ってないかチェックを行う
function TGestureModel.CheckGestureStr(Gesture: string): Boolean;
const
	G_STR: array[0..3] of string = ('↑', '←', '↓', '→');
var
	i: Integer;
	j: Integer;
	c: Boolean;
begin
	Result := False;
	if Length(Gesture) = 0 then
		Exit;
	for i := 0 to (Length(Gesture) div 2) - 1 do begin
		c := False;
		for j := 0 to Length(G_STR) - 1 do begin
			if MidStr(Gesture, i + 1, 1) = G_STR[j] then begin
				c := True;
				Break;
			end;
		end;
		if not c then
			Exit;
	end;
	Result := True;
end;

//ジェスチャーリストのサイズを返す
function TGestureModel.GetCount: Integer;
begin
	Result := FGestureList.Count;
end;

//ジェスチャーと、それに結びつくアクションをリストに登録する
procedure TGestureModel.AddGesture(Gesture: string; Action: TAction);
begin
	if (not CheckGestureStr(Gesture)) or (Action = nil) then
		Exit;
	DeleteGesture(Gesture);
	FGestureList.AddObject(Gesture, Action);
end;

//指定されたジェスチャーを削除
procedure TGestureModel.DeleteGesture(Gesture: string);
var
	idx: Integer;
begin
	idx := FGestureList.IndexOf(Gesture);
	if idx <> -1 then
		FGestureList.Delete(idx);
end;

//ジェスチャーリストをクリア
procedure TGestureModel.ClearGesture;
begin
	FGestureList.Clear;
end;

//ジェスチャー文字列から該当するアクションを返す
function TGestureModel.GetGestureAction(Gesture: string): TAction;
var
	idx: Integer;
begin
	Result := nil;
	idx := FGestureList.IndexOf(Gesture);
	if idx <> -1 then
		if FGestureList.Objects[idx] is TAction then
			Result := TAction(FGestureList.Objects[idx]);
end;

// アクションから該当するジェスチャー文字列を返す
function TGestureModel.GetActionGesture( action : TAction ) : string;
var
	i : Integer;
begin
	Result := '';
	for i := 0 to FGestureList.Count - 1 do begin
		if FGestureList.Objects[ i ] = action then begin
			Result := FGestureList[ i ];
			Break;
		end;
	end;
end;

//iniからジェスチャー一覧を読み込む
procedure TGestureModel.LoadGesture(FileName: string; ActionList: TActionList);
var
	ini: TMemIniFile;
	i: Integer;
	key: string;
	GestureStr: string;
	Action: TAction;
	ActionStr: string;
begin
	ini := TMemIniFile.Create(FileName);
	try
		i := 0;
		while (True) do begin
			key := 'Gesture' + IntToStr(i);
			GestureStr := ini.ReadString('MouseGesture', key, '');
			key := 'Action' + IntToStr(i);
			ActionStr := ini.ReadString('MouseGesture', key, '');
			if (GestureStr = '') or (ActionStr = '') then
				Break;
			Action := GetActionItem(ActionList, ActionStr);
			if Action <> nil then begin
				AddGesture(GestureStr, Action);
			end;
			inc(i);
		end;
		FMargin := ini.ReadInteger('MouseGesture', 'Margin', 15);
	finally
		ini.Free;
	end;
end;

//ジェスチャー一覧をiniに書き込む
procedure TGestureModel.SaveGesture(FileName: string);
var
	ini: TMemIniFile;
	i: Integer;
	key: string;
begin
	ini := TMemIniFile.Create(FileName);
	try
		ini.EraseSection('MouseGesture');
		for i := 0 to FGestureList.Count - 1 do begin
			if CheckGestureStr(FGestureList[i]) and (FGestureList.Objects[i] is TAction) then begin
				key := 'Gesture' + IntToStr(i);
				ini.WriteString('MouseGesture', key, FGestureList[i]);
				key := 'Action' + IntToStr(i);
				ini.WriteString('MouseGesture', key, TAction(FGestureList.Objects[i]).Name);
			end;
		end;
		ini.WriteInteger('MouseGesture', 'Margin', FMargin);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

//アクション文字列からアクションを返す
function TGestureModel.GetActionItem(ActionList: TActionList; ActionStr: string): TAction;
var
	i: Integer;
begin
	Result := nil;
	for i := 0 to ActionList.ActionCount - 1 do begin
		if ActionList.Actions[i].Name = ActionStr then begin
			if ActionList.Actions[i] is TAction then begin
				Result := TAction(ActionList.Actions[i]);
				Exit;
			end;
		end;
	end;
end;

end.
