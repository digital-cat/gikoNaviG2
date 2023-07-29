unit Gesture;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, Math, StrUtils;

type
	TMouseGesture = class(TObject)
	private
		FHook: Cardinal;
		FHandle: THandle;
		FGestureItemList: TStringList;
		FBeginGesture: Boolean;
		FCancelMode: Boolean;
		FLastTime: Cardinal;
		FStartPoint: TPoint;
		FLastPoint: TPoint;
		FMargin: Integer;
		FOnGestureStart: TNotifyEvent;
		FOnGestureMove: TNotifyEvent;
		FOnGestureEnd: TNotifyEvent;
		function GetGestureCount: Integer;
		function CheckAction(Message: Integer; x, y: Integer): Boolean;
		procedure AddAction(sx, sy: Integer);
		function AddGesture(Item: string): Integer;
		function Get(Index: integer): string;
		procedure Put(Index: integer; Item: string);
	public
		constructor Create;
		destructor Destroy; override;
		procedure SetHook(hWnd: THandle);
		procedure UnHook;
		property Items[Index: Integer]: string read Get write Put; default;
		property GestureCount: Integer read GetGestureCount;
		property Margin: Integer read FMargin write FMargin;
		function GetGestureStr: string;
		procedure Clear;
		property OnGestureStart: TNotifyEvent read FOnGestureStart write FOnGestureStart;
		property OnGestureMove: TNotifyEvent read FOnGestureMove write FOnGestureMove;
		property OnGestureEnd: TNotifyEvent read FOnGestureEnd write FOnGestureEnd;
	end;

	function GestureProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;

var
	MouseGesture: TMouseGesture;

implementation

uses
	GikoSystem;

constructor TMouseGesture.Create;
begin
	inherited;
	FHook := 0;
	FCancelMode := False;
	FBeginGesture := False;
	FMargin := 15;
	FGestureItemList := TStringList.Create;
end;

destructor TMouseGesture.Destroy;
begin
	UnHook;
	Clear;
	FGestureItemList.Free;
	inherited;
end;

//マウスフック
procedure TMouseGesture.SetHook(hWnd: THandle);
begin
	if FHook <> 0 then
		Exit;
	FHandle := hWnd;
	UnHook;
	FHook := SetWindowsHookEx(WH_MOUSE, @GestureProc, 0{HInstance}, GetCurrentThreadId);
end;

//マウスフック解除
procedure TMouseGesture.UnHook;
begin
	if FHook = 0 then
		Exit;
	UnhookWindowsHookEx(FHook);
	FHook := 0;
end;

//フックプロシジャ
function GestureProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
	mhs: PMouseHookStruct;
begin
	if nCode = HC_ACTION then begin
		mhs := PMouseHookStruct(lParam);
		if MouseGesture.CheckAction(wParam, mhs^.pt.X, mhs^.pt.Y) then begin
			Result := 1;
			Exit;
		end;
	end;
	Result := CallNextHookEx(MouseGesture.FHook, nCode, wParam, lParam);
end;

function TMouseGesture.CheckAction(Message: Integer; x, y: Integer): Boolean;
var
	dp: TPoint;
	sp: TPoint;
	hwnd: THandle;
begin
	Result := False;
	case Message of
		WM_MOUSEMOVE: begin
			if FBeginGesture then begin
				//今マウスをキャプチャーしているのを得る
				hwnd := GetCapture;
				//マウスジェスチャーの対象と違うときは、開放する
				if (hwnd <> 0) and (hwnd <> FHandle) then begin
					ReleaseCapture;
                    SetCapture(FHandle);
				end;
				dp := Point(x - FLastPoint.X, y - FLastPoint.Y);
				sp := Point(Sign(dp.X), Sign(dp.Y));
				if (dp.X * dp.X + dp.Y * dp.Y) > (FMargin * FMargin) then begin
					dp := Point(Abs(dp.X), Abs(dp.Y));
					if dp.X > dp.Y div 3 then
						sp.Y := 0;
					if dp.Y > dp.X div 3 then
						sp.X := 0;
					AddAction(sp.X, sp.Y);
					FLastTime := GetTickCount;
					FLastPoint := Point(x, y);
				end;
                Result := True;
    		end;
		end;
		WM_RBUTTONDOWN: begin
			if (not FCancelMode)  then begin
                if ( GikoSys.Setting.GestureIgnoreContext ) then begin
    				//今マウスをキャプチャーしているのを得る
	    			hwnd := GetCapture;
		    		//マウスジェスチャーの対象と違うときは、開放する
			    	if (hwnd <> 0) and (hwnd <> FHandle) then begin
                        Exit;
                    end;
                end;
				FBeginGesture := True;
				FLastTime := 0;
				FLastPoint := Point(x, y);
				FStartPoint := Point(x, y);
				Result := True;
				SetCapture(FHandle);
			end;
		end;
		WM_RBUTTONUP: begin
			if FCancelMode then
				FCancelMode := False
			else if (FBeginGesture) then begin
				FBeginGesture := False;
				ReleaseCapture;
				if FGestureItemList.Count <> 0 then begin
					if Assigned(FOnGestureEnd) then begin
						FOnGestureEnd(Self);
                    end else begin
                        Clear;
                    end;
				end else begin
					FCancelMode := True;
					//ジェスチャーじゃなかった場合、マウスDOWN,UPをエミュレート
					mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_RIGHTDOWN, FStartPoint.X, FStartPoint.Y, 0, 0);
					mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_RIGHTUP, x, y, 0, 0);
				end;
			end;
		end;
	end;
end;

//動作の追加
procedure TMouseGesture.AddAction(sx, sy: Integer);
var
	Direction: string;
begin
	Direction := '';
	if (sx > 0) and (sy = 0) then
		Direction := '→'
	else if (sx < 0) and (sy = 0) then
		Direction := '←'
	else if sy > 0 then
		Direction := '↓'
	else if sy < 0 then
		Direction := '↑'
	else
		Exit;
	if FGestureItemList.Count > 0 then begin
		if Items[FGestureItemList.Count - 1] = Direction then
			Exit;
	end else begin
		//ジェスチャー開始
		if Assigned(FOnGestureStart) then
			FOnGestureStart(Self);
	end;
	AddGesture(Direction);
	if Assigned(FOnGestureMove) then
		FOnGestureMove(Self);
end;

//現在のジェスチャーに新しい方向を追加
function TMouseGesture.AddGesture(Item: string): Integer;
begin
	Result := FGestureItemList.Add(Item);
end;

//指定されたindexの動きを返す
function TMouseGesture.Get(Index: Integer): string;
begin
	Result := FGestureItemList[Index];
end;

//指定されたindexの動きを設定する
procedure TMouseGesture.Put(Index: Integer; Item: string);
begin
	FGestureItemList[Index] := Item;
end;

//ジェスチャー文字列を返す
function TMouseGesture.GetGestureStr: string;
var
	i: Integer;
begin
	Result := '';
	for i := 0 to FGestureItemList.Count - 1 do
		Result := Result + Items[i];
end;

//ジェスチャーの長さを返す
function TMouseGesture.GetGestureCount: Integer;
begin
	Result := FGestureItemList.Count;
end;

//ジェスチャーをクリアする
procedure TMouseGesture.Clear;
begin
	FGestureItemList.Clear;
end;

end.
