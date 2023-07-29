unit GikoUtil;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms;

function MsgBox(const hWnd: HWND; const Text, Caption: string; Flags: Longint = MB_OK): Integer;
function MsgMoveProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;

implementation
var
	hhk: HHOOK;

function MsgBox(const hWnd: HWND; const Text, Caption: string; Flags: Longint = MB_OK): Integer;
begin
	hhk := SetWindowsHookEx(WH_CBT, @MsgMoveProc, 0, GetCurrentThreadId());
	Result := Windows.MessageBox(hwnd, PChar(Text), PChar(Caption), Flags);
	if hhk <> 0 then
		UnhookWindowsHookEx(hhk);
end;

function MsgMoveProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
	function GetW(ARect: TRect): Integer;
	begin
		Result := ARect.Right - ARect.Left;
	end;
	function GetH(ARect: TRect): Integer;
	begin
		Result := ARect.Bottom - ARect.Top;
	end;
	function MoveRect(ARect: TRect; X, Y: Integer): TRect;
	var
		W, H: Integer;
	begin
		W := GetW(ARect);
		H := GetH(ARect);
		Result := Rect(X, Y, X + W, Y + H);
	end;
var
	hParent: HWND;
	hMsgBox: HWND;
	ParentR: TRect;
	MsgBoxR: TRect;
begin
	if nCode = HCBT_ACTIVATE then begin
		hMsgBox := wParam;
		hParent := GetParent(wParam);
		if (hParent <> 0) and (hMsgBox <> 0) and
			 (GetWindowRect(hParent, ParentR)) and
			 (GetWindowRect(hMsgBox, MsgBoxR)) then begin
			MsgBoxR := MoveRect(MsgBoxR,
													ParentR.Left + ((GetW(ParentR) - GetW(MsgBoxR)) div 2),
													ParentR.Top + ((GetH(ParentR) - GetH(MsgBoxR)) div 2));
//			if MsgBoxR.Left < 0 then
//				MsgBoxR := MoveRect(MsgBoxR, 0, MsgBoxR.Top);
//			if MsgBoxR.Top < 0 then
//				MsgBoxR := MoveRect(MsgBoxR, MsgBoxR.Left, 0);
			if MsgBoxR.Left + GetW(MsgBoxR) > Screen.WorkAreaWidth then
				MsgBoxR := MoveRect(MsgBoxR, Screen.WorkAreaWidth - GetW(MsgBoxR), MsgBoxR.Top);
			if MsgBoxR.Top + GetH(MsgBoxR) > Screen.WorkAreaHeight then
				MsgBoxR := MoveRect(MsgBoxR, MsgBoxR.Left, Screen.WorkAreaHeight - GetH(MsgBoxR));
			MoveWindow(hMsgBox, MsgBoxR.Left, MsgBoxR.Top, GetW(MsgBoxR), GetH(MsgBoxR), False);
		end;
		UnhookWindowsHookEx(hhk);
		hhk := 0;
	end else begin
		CallNextHookEx(hhk, nCode, wParam, lParam);
	end;
	Result := 0;
end;

end.
