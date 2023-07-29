unit HTMLDocumentEvent;

interface

uses
	Windows, Classes, ActiveX, ComObj;

type
	TDocumentContextMenuEvent = function(Sender: TObject): WordBool of object;

	THTMLDocumentEventSink = class(TInterfacedObject,IUnknown,IDispatch)
	private
		FOwner: TObject;
		FSimpleDisp: IDispatch;
		FSimpleIID: TGUID;
		FSimpleCon: Integer;
		FOnContextMenu: TDocumentContextMenuEvent;
		FOnClick: TDocumentContextMenuEvent;
		FOnMouseMove: TDocumentContextMenuEvent;
		FOnMouseDown: TDocumentContextMenuEvent;
		FOnDoubleClick: TDocumentContextMenuEvent;
	protected
		{ IUnknown }
		function QueryInterface(const IID:TGUID; out Obj): HRESULT; stdcall;
		function _AddRef:Integer; stdcall;
		function _Release:Integer; stdcall;
		{ IDispatch }
		function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
		function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HRESULT; stdcall;
		function GetIDsOfNames(const IID: TGUID; Names: Pointer;
			NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT; stdcall;
		function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
			Flags: Word; var Params; VarResult, ExcepInfo, ArgErr:Pointer): HRESULT; stdcall;
	public
		constructor Create(AOwner: TObject; ADisp: IDispatch; const AIID: TGUID);
		destructor Destroy; override;
		property OnContextMenu: TDocumentContextMenuEvent read FOnContextMenu write FOnContextMenu;
		property OnClick: TDocumentContextMenuEvent read FOnClick write FOnClick;
		property OnMouseMove: TDocumentContextMenuEvent read FOnMouseMove write FOnMouseMove;
		property OnMouseDown: TDocumentContextMenuEvent read FOnMouseDown write FOnMouseDown;
		property OnDoubleClick: TDocumentContextMenuEvent read FOnDoubleClick write FOnDoubleClick;
	end;

implementation

function THTMLDocumentEventSink._AddRef: Integer;
begin
	Result := 2;
end;

function THTMLDocumentEventSink._Release: Integer;
begin
	Result := 1;
end;

constructor THTMLDocumentEventSink.Create(AOwner: TObject; ADisp: IDispatch; const AIID: TGUID);
begin
	inherited Create;
	FOwner := AOwner;
	FSimpleDisp := ADisp;
	FSimpleIID := AIID;
	InterfaceConnect(FSimpleDisp, FSimpleIID, Self, FSimpleCon);
end;

destructor THTMLDocumentEventSink.Destroy;
begin
	InterfaceDisconnect(FSimpleDisp,FSimpleIID,FSimpleCon);
	inherited Destroy;
end;

function THTMLDocumentEventSink.GetIDsOfNames(const IID: TGUID; Names: Pointer;
	NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT;
begin
	Result := E_NOTIMPL;
end;

function THTMLDocumentEventSink.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HRESULT;
begin
	Result := E_NOTIMPL;
end;

function THTMLDocumentEventSink.GetTypeInfoCount(out Count: Integer): HRESULT;
begin
	Count  := 0;
	Result := S_OK;
end;

function THTMLDocumentEventSink.Invoke(DispID: Integer; const IID: TGUID;
	LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
	ArgErr: Pointer): HRESULT;
begin
	case DispID of
	DISPID_MOUSEDOWN:
		if Assigned(FOnMouseDown) then begin
			PVariant(VarResult)^ := FOnMouseDown(FOwner);
		end;
	DISPID_MOUSEMOVE:
		if Assigned(FOnMouseMove) then begin
			PVariant(VarResult)^ := FOnMouseMove(FOwner);
		end;
	DISPID_CLICK:
		if Assigned(FOnClick) then begin
			PVariant(VarResult)^ := FOnClick(FOwner);
		end;
   	DISPID_DBLCLICK:
		if Assigned(FOnDoubleClick) then begin
			PVariant(VarResult)^ := FOnDoubleClick(FOwner);
		end;
	1023:
		if Assigned(FOnContextMenu) then begin
			PVariant(VarResult)^ := FOnContextMenu(FOwner);
		end;
	end;
	Result := S_OK;
end;

function THTMLDocumentEventSink.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
	Result := E_NOINTERFACE;
	if GetInterface(IID,Obj) then
		Result := S_OK;
	if IsEqualGUID(IID,FSimpleIID) and GetInterface(IDispatch,Obj) then
		Result := S_OK;
end;

end.
