unit GikoPanel;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, ExtCtrls,
	Graphics;

type
	TStaticBorderStyle = (sbsNone, sbsSingle, sbsSunken);

	TGikoPanel = class(TWinControl)
	private
		FBorderStyle: TStaticBorderStyle;
		procedure SetBorderStyle(Value: TStaticBorderStyle);
	protected
		procedure CreateParams(var Params: TCreateParams); override;
	public
		constructor Create(AOwner: TComponent); override;
	published
		property BorderStyle: TStaticBorderStyle read FBorderStyle
			write SetBorderStyle default sbsNone;
		property Align;
		property Anchors;
		property AutoSize;
		property BevelEdges;
		property BevelInner;
		property BevelKind default bkNone;
		property BevelOuter;
		property Color;
		property Constraints;
		property DragCursor;
		property DragKind;
		property DragMode;
		property Enabled;
		property ParentColor;
		property ParentShowHint;
		property PopupMenu;
		property ShowHint;
		property TabOrder;
		property TabStop;
		property Visible;
		property OnClick;
		property OnContextPopup;
		property OnDblClick;
		property OnDragDrop;
		property OnDragOver;
		property OnEndDock;
		property OnEndDrag;
		property OnMouseDown;
		property OnMouseMove;
		property OnMouseUp;
		property OnStartDock;
		property OnStartDrag;
	end;

procedure Register;

implementation

procedure Register;
begin
	RegisterComponents('gikoNavi', [TGikoPanel]);
end;

constructor TGikoPanel.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
	ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
		csOpaque, csReplicatable, csDoubleClicks];
	Width := 185;
	Height := 41;
end;

procedure TGikoPanel.CreateParams(var Params: TCreateParams);
const
	Alignments: array[Boolean, TAlignment] of DWORD =
		((SS_LEFT, SS_RIGHT, SS_CENTER), (SS_RIGHT, SS_LEFT, SS_CENTER));
	Borders: array[TStaticBorderStyle] of DWORD = (0, WS_BORDER, SS_SUNKEN);
begin
	inherited CreateParams(Params);
	with Params do begin
		Style := Style or SS_NOTIFY or
			Borders[FBorderStyle];
		WindowClass.style := WindowClass.style and not CS_VREDRAW;
	end;
end;

procedure TGikoPanel.SetBorderStyle(Value: TStaticBorderStyle);
begin
	if FBorderStyle <> Value then	begin
		FBorderStyle := Value;
		RecreateWnd;
	end;
end;

end.
