unit HintWindow;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	GikoSystem;

type
	TGikoPopupType = (gptRaw, gptThread);

	TResPopup = class(THintWindow)
	private
		FTitle: string;
		FResList: TList;
		FPopupType: TGikoPopupType;
		FHeaderBold: Boolean;
	protected
		procedure Paint; override;
	public
		constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;
		procedure Add(AHeader: string; ABody: string);
		procedure ClearAllRes;
		function ResCount: Integer;
		function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
		property Title: string read FTitle write FTitle;
		property PopupType: TGikoPopupType read FPopupType write FPopupType;
		property HeaderBold: Boolean read FHeaderBold write FHeaderBold;
	end;

	PResDataRec = ^TResDataRec;
	TResDataRec = record
		FHeader: string;
//		FHeaderHeight: Integer;
		FBody: string;
//		FBodyHeight: Integer;
	end;

implementation

const
	BODY_INDENT = 5;		//Body部分のインデント幅
	TITLE_SPACE = 8;		//タイトルと本文間の高さ
	RES_SPACE = 8;			//レス間空白の高さ
	HEADER_SPACE = 4;		//ヘッダと本文間の高さ

constructor TResPopup.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
	FResList := TList.Create;
	FHeaderBold := True;
end;

destructor TResPopup.Destroy;
begin
	ClearAllRes;
	FResList.Free;
	inherited Destroy;
end;

procedure TResPopup.Paint;
var
	R: TRect;
	i: Integer;
	ResData: PResDataRec;
	H: Integer;
begin
	R := ClientRect;
	Inc(R.Left, 2);
	Inc(R.Top, 2);
	Canvas.Font.Color := Font.Color;
	Canvas.Font.Name := Font.Name;
	Canvas.Font.Size := Font.Size;
	if FPopupType = gptRaw then begin
		Canvas.Font.Style := [];
		DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
	end else begin
		if FTitle <> '' then begin
			Canvas.Font.Style := [fsBold];
			H := DrawText(Canvas.Handle, PChar(FTitle), -1, R,
										DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
			if FResList.Count > 0 then
				R.Top := R.Top + H + TITLE_SPACE
			else
				R.Top := R.Top + H;
		end;
		for i := 0 to FResList.Count - 1 do begin
			if i <> 0 then
				R.Top := R.Top + RES_SPACE;
			ResData := FResList[i];
			//Header
			Canvas.Font.Style := [];
			if FHeaderBold then
				Canvas.Font.Style := [fsBold];
			H := DrawText(Canvas.Handle, PChar(ResData.FHeader), -1, R,
			              							DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
			R.Top := R.Top + H;
			//スペース
			R.Top := R.Top + HEADER_SPACE;
			//Body
			Canvas.Font.Style := [];
			R.Left := R.Left + BODY_INDENT;
			H := DrawText(Canvas.Handle, PChar(ResData.FBody), -1, R,
										DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
			R.Top := R.Top + H;
			R.Left := R.Left - BODY_INDENT;
		end;
	end;
end;

function TResPopup.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
var
	i: Integer;
	ARect: TRect;
	ResData: PResDataRec;
begin
	Result := Rect(0, 0, 0, 0);
	Canvas.Font.Name := Font.Name;
	Canvas.Font.Size := Font.Size;
	if FPopupType = gptRaw then begin
		Canvas.Font.Style := [fsBold];
		Result := Rect(0, 0, MaxWidth, 0);
		DrawText(Canvas.Handle, PChar(AHint), -1, Result,
						 DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
	end else begin
		//Title
		if FTitle <> '' then begin
			Canvas.Font.Style := [fsBold];
			ARect := Rect(0, 0, MaxWidth, 0);
			DrawText(Canvas.Handle, PChar(FTitle), -1, ARect,
							 DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
			if Result.Right < ARect.Right then
				Result.Right := ARect.Right;
			if FResList.Count > 0 then
				Result.Bottom := Result.Bottom + ARect.Bottom + TITLE_SPACE
			else
				Result.Bottom := Result.Bottom + ARect.Bottom;
		end;
		for i := 0 to FResList.Count - 1 do begin
			if i <> 0 then
				Result.Bottom := Result.Bottom + RES_SPACE;
			ResData := FResList[i];
			//Header
			Canvas.Font.Style := [];
			if FHeaderBold then
				Canvas.Font.Style := [fsBold];
			ARect := Rect(0, 0, MaxWidth, 0);
			DrawText(Canvas.Handle, PChar(ResData.FHeader), -1, ARect,
							 DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
			if Result.Right < ARect.Right then
				Result.Right := ARect.Right;
			Result.Bottom := Result.Bottom + ARect.Bottom;
			//スペース
			Result.Bottom := Result.Bottom + HEADER_SPACE;
			//Body
			Canvas.Font.Style := [];
			ARect := Rect(0, 0, MaxWidth, 0);
			DrawText(Canvas.Handle, PChar(ResData.FBody), -1, ARect,
							 DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
			if Result.Right < (ARect.Right + BODY_INDENT) then
				Result.Right := ARect.Right + BODY_INDENT;
			Result.Bottom := Result.Bottom + ARect.Bottom;
		end;
	end;
	Inc(Result.Right, 6);
	Inc(Result.Bottom, 2);
end;

procedure TResPopup.Add(AHeader: string; ABody: string);
var
	ResData: PResDataRec;
begin
	New(ResData);
	ResData.FHeader := AHeader;
//	ResData.FHeaderHeight := 0;
	ResData.FBody := ABody;
//	ResData.FBodyHeight := 0;
	FResList.Add(ResData);
end;

procedure TResPopup.ClearAllRes;
var
	i: Integer;
    ResData: PResDataRec;
begin
	for i := 0 to FResList.Count - 1 do begin
        ResData := FResList[i];
		Dispose(ResData);
    end;
	FResList.Clear;
	FTitle := '';
	Caption := '';
end;

function TResPopup.ResCount: Integer;
begin
	Result := FResList.Count;
end;

end.
