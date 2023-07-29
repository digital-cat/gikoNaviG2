unit ResPopupBrowser;
interface
uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	ActiveX, OleCtrls, {HintWindow,} HTMLDocumentEvent, BoardGroup,
{$IF Defined(DELPRO) }
	SHDocVw,
	MSHTML
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB
{$IFEND}
;

type
    TGikoPopupType = (gptRaw, gptThread);
    
	TResPopupBrowser = class(TWebBrowser)
	private
        FChild :TResPopupBrowser;
        FParentBrowser :TResPopupBrowser;
        FTitle :String;
        FRawDocument: String;
   		FPopupType: TGikoPopupType;
		FEvent: THTMLDocumentEventSink;//ブラウザドキュメントイベント
        FThread: TThreadItem;
        function GetBodyStyle(OnlyTitle: Boolean = False): string;
        function GetWindowHeight : Integer;
        function GetTitle(OnlyTitle: Boolean): string;
		function CalcRect(WorkArea: TRect; Scroll: Boolean): TRect;
        function ResPopupBrowserClick(Sender: TObject): WordBool;
        function ResPopupBrowserDbClick(Sender: TObject): WordBool;
        function GetThread: TThreadItem;
	protected
		procedure CreateParams(var Params: TCreateParams); override;
	public
		constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;
        property Child: TResPopupBrowser read FChild;
        property ParentBrowser:TResPopupBrowser read FParentBrowser write FParentBrowser;
        property Title: String read FTitle write FTitle;
        property RawDocument: String read FRawDocument write FRawDocument;
        property Thread: TThreadItem read GetThread write FThread;
        function CreateNewBrowser: TResPopupBrowser;
        function CurrentBrowser: TResPopupBrowser;
        procedure Write(ADocument: String; OnlyTitle: Boolean = False);
        procedure Clear;
        procedure ChildClear;
        procedure NavigateBlank(Forced: Boolean);
    	property PopupType: TGikoPopupType read FPopupType write FPopupType;
        procedure TitlePopup;
        procedure Popup;
        procedure Blur;
	end;

implementation
uses MojuUtils, GikoSystem, Setting, Giko, GikoDataModule, Preview;

constructor TResPopupBrowser.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
    TOleControl(Self).Parent := nil;
    Visible := False;
    FChild := nil;
    Title := '';
    RawDocument := '';
    FEvent := nil;
    ShowWindow(Self.Handle, SW_HIDE);
    GikoSys.ShowRefCount('ResPop Create', Self.ControlInterface);
    GikoSys.ShowRefCount('ResPop.Document Create', Self.ControlInterface.Document);
end;

destructor TResPopupBrowser.Destroy;
begin
    Self.Blur;
    Self.OnEnter := nil;
    Self.OnBeforeNavigate2 := nil;
    Self.OnStatusTextChange := nil;
    Self.OnNewWindow2 := nil;
    if (FChild <> nil) then begin
        FChild.Free;
        FChild := nil;
    end;
    if (FEvent <> nil) then begin
        FEvent.Free;
        FEvent := nil;
    end;
    FThread := nil;

    GikoSys.ShowRefCount('ResPop Desctroy', Self.ControlInterface);
    GikoSys.ShowRefCount('ResPop.Document Create', Self.ControlInterface.Document);

	inherited Destroy;
end;

procedure TResPopupBrowser.CreateParams(var Params: TCreateParams);
begin
	inherited;
    Params.Style := Params.Style or WS_EX_TOOLWINDOW;

end;
function TResPopupBrowser.CreateNewBrowser: TResPopupBrowser;
begin
    if (Self.Visible) then begin
        if (FChild <> nil) then begin
            if (FChild.Visible) then begin
                Result := FChild.CreateNewBrowser;
            end else begin
                Result := FChild;
            end;
        end else begin
            FChild := TResPopupBrowser.Create(Self.Owner);
            FChild.ParentBrowser := Self;
            FChild.NavigateBlank(False);
            FChild.OnEnter := GikoForm.BrowserEnter;
            FChild.OnBeforeNavigate2 := GikoForm.BrowserBeforeNavigate2;
            FChild.OnStatusTextChange := GikoForm.BrowserStatusTextChange;
            FChild.OnNewWindow2 := GikoForm.BrowserNewWindow2;
            SetWindowPos(FChild.Handle, HWND_BOTTOM,
                0, 0, 0 , 0,
                SWP_NOSIZE or SWP_NOMOVE or  SWP_NOACTIVATE or SWP_HIDEWINDOW);
            Result := FChild;
        end;
    end else begin
        FParentBrowser := nil;
        Self.NavigateBlank(False);
        Self.OnEnter := GikoForm.BrowserEnter;
        Self.OnBeforeNavigate2 := GikoForm.BrowserBeforeNavigate2;
        Self.OnStatusTextChange := GikoForm.BrowserStatusTextChange;
        Self.OnNewWindow2 := GikoForm.BrowserNewWindow2;
        SetWindowPos(Self.Handle, HWND_BOTTOM,
            0, 0, 0 , 0,
            SWP_NOSIZE or SWP_NOMOVE or  SWP_NOACTIVATE or SWP_HIDEWINDOW);
        Result := Self;
    end;
end;
function TResPopupBrowser.CurrentBrowser: TResPopupBrowser;
begin
    Result := Self.CreateNewBrowser;
    if (Result.ParentBrowser <> nil) then
        Result := Result.ParentBrowser;
end;
procedure TResPopupBrowser.NavigateBlank(Forced: Boolean);
begin
    if (not Assigned(Self.ControlInterface.Document)) or (Forced) then begin
        Self.Navigate('about:blank');
    end;
    while (Self.ReadyState <> READYSTATE_COMPLETE) and
            (Self.ReadyState <> READYSTATE_INTERACTIVE) do begin
        Sleep(1);
        Forms.Application.ProcessMessages;
    end;
end;
procedure TResPopupBrowser.TitlePopup;
begin
    Write('', True);
end;
procedure TResPopupBrowser.Popup;
begin
    if (GetAsyncKeyState(VK_SHIFT) = Smallint($8001)) then begin
        // シフト押してる場合はそのまま出す
        Write(Self.RawDocument, false);
    end else begin
        // 騙し絵が見えるように半角スペース*2を&nbsp;*2に置換する
        Write(
            MojuUtils.CustomStringReplace(
                Self.RawDocument, '  ', '&nbsp;&nbsp;'),
            false);
    end;
end;
procedure TResPopupBrowser.Write(ADocument: String; OnlyTitle: Boolean = False);
var
	p: TPoint;
    doc: OleVariant;
   	ARect: TRect;
begin
    try
        // タスクバーから消す
        SetWindowLongA(Self.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);
        GetCursorpos(p);
        // いったん縮小
        SetWindowPos(Self.Handle, HWND_BOTTOM,
            p.X, p.Y, 50 , 50,
            SWP_NOACTIVATE or SWP_HIDEWINDOW);
        doc := Self.OleObject.Document;
        doc.open;
        doc.charset := 'Shift_JIS';
        doc.Write('<html><head>'#13#10 +
                '<meta http-equiv="Content-type" content="text/html; charset=Shift_JIS">'#13#10 +
                '<meta http-equiv="Pragma" content="no-cache">'#13#10 +
                '<meta http-equiv="Cache-Control" content="no-cache">'#13#10 +
                GetBodyStyle(OnlyTitle) + '</head><body>'
                + GetTitle(OnlyTitle)
                + ADocument + '<a name="bottom"></a></body></html>');

        doc.Close;
        // マルチモニタ対応
        ARect := CalcRect(Screen.MonitorFromPoint(p).WorkareaRect,
                        not OnlyTitle);

        FEvent := THTMLDocumentEventSink.Create(Self, Self.OleObject.Document, HTMLDocumentEvents2);
        FEvent.OnClick := ResPopupBrowserClick;
        FEvent.OnDoubleClick := ResPopupBrowserDbClick;
        Self.Visible := True;
        SetWindowPos(Self.Handle, HWND_TOPMOST,
            ARect.Left, ARect.Top,
            (ARect.Right - ARect.Left) ,
            (ARect.Bottom - ARect.Top),
            SWP_NOACTIVATE or SWP_HIDEWINDOW);
        ShowWindow(Self.Handle, SW_SHOWNOACTIVATE);
    except
    end;
end;
function TResPopupBrowser.GetTitle(OnlyTitle: Boolean): string;
begin
    Result := '<span id="hTitle">' + Title +'</span>';
    if OnlyTitle then Result := Result + '<BR>';
end;
function TResPopupBrowser.GetBodyStyle(OnlyTitle: Boolean = False): string;
var
    i : Integer;
begin

    Result := '<style type="text/css">' +
            'dl { margin :0px; padding :0px}'#13#10 +
            'body { ' +
            'border-width: 1px; border-style: solid;white-space: nowrap; ' +
            'margin: 2px 4px 0px 0px; padding: 0px 4px 0px 0px; ';

	if Length( GikoSys.Setting.HintFontName ) > 0 then
		Result := Result + 'font-family:"' + GikoSys.Setting.HintFontName + '";';
	if GikoSys.Setting.HintFontSize <> 0 then
		Result := Result + 'font-size:' + IntToStr( GikoSys.Setting.HintFontSize ) + 'pt;';
	if GikoSys.Setting.HintFontColor <> -1 then
		Result := Result + 'color:#' + IntToHex( GikoSys.Setting.HintFontColor, 6 ) + ';';
	if GikoSys.Setting.HintBackColor <> -1 then begin
   		i := ColorToRGB( GikoSys.Setting.HintBackColor );
		Result := Result + 'background-color:#' +
            IntToHex( (i shr 16) or (i and $ff00) or ((i and $ff) shl 16), 6 ) + ';';
    end;
    if OnlyTitle then
        Result := Result + 'overflow: hidden; ';

    Result := Result + '}';
    if GikoSys.Setting.ResPopupHeaderBold then begin
        Result := Result + #13#10'span#hTitle{font-weight: bold; }';
    end;
    Result := Result + '</style>';
end;

procedure TResPopupBrowser.Clear;
begin
    ChildClear;
    if (Self.Visible) then begin
        Self.Title := '';
        Self.RawDocument := '';
        Self.FThread := nil;
        Self.FEvent.Free;
        Self.FEvent := nil;
        Self.Blur;
        ShowWindow(Self.Handle, SW_HIDE);
        Self.Visible := False;
    end;
end;
procedure TResPopupBrowser.ChildClear;
begin
    if (FChild <> nil) then begin
        FChild.Clear;
    end;
end;

function TResPopupBrowser.CalcRect(WorkArea: TRect; Scroll: Boolean): TRect;
var
	p: TPoint;
    ele: IHTMLElement2;
    h, w, dx1, dx2, dy1, dy2: Integer;
    MaxWidth, MaxHeight: Integer;
    DIV_X, DIV_Y: Integer;
begin
	GetCursorpos(p);
    ele := ((Self.ControlInterface.Document as IHTMLDocument2).body as IHTMLElement2);
    if Scroll then begin
        h := GetWindowHeight + 10;
        w := ele.scrollWidth + 25
    end else begin
        h := GetWindowHeight + 5;
        w := ele.scrollWidth + 10;
    end;

    DIV_X := GikoSys.Setting.RespopupDeltaX;
    DIV_Y := GikoSys.Setting.RespopupDeltaY;
    
    dx1 := 0; dx2 := 0;
    dy1 := 0; dy2 := 0;

	Result := Rect(0, 0, w, h);
    case GikoSys.Setting.PopupPosition of
        gppRightTop:
        begin
            dx1 := 0; dx2 := + DIV_X;
            dy1 := -h; dy2 := - DIV_Y;
        end;
        gppRight:
        begin
            dx1 := 0; dx2 := + DIV_X;
            dy1 := - (h div 2); dy2 := 0;
        end;
        gppRightBottom:
        begin
            dx1 := 0; dx2 := + DIV_X;
            dy1 := 0; dy2 := + DIV_Y;
        end;
        gppTop:
        begin
            dx1 := - (w div 2); dx2 := 0;
            dy1 := -h; dy2 := - DIV_Y;
        end;
        // 廃止 gppCenter: OffsetRect(Result, p.x - (w div 2), p.y - (h div 2));
    	gppBottom:
        begin
            dx1 := - (w div 2); dx2 := 0;
            dy1 := 0; dy2 := + DIV_Y;
        end;
        gppLeftTop:
        begin
            dx1 := -w; dx2 := - DIV_X ;
            dy1 := -h; dy2 := - DIV_Y;
        end;
        gppLeft:
        begin
            dx1 := -w; dx2 := - DIV_X;
            dy1 := - (h div 2); dy2 := 0;
        end;
        gppLeftBottom:
        begin
            dx1 := -w; dx2 := - DIV_X;
            dy1 := 0; dy2 := + DIV_Y;
        end;
    end;
    // 初期位置に移動
    OffsetRect(Result, p.x + dx1 + dx2, p.y + dy1 + dy2);

    MaxWidth := WorkArea.Right - WorkArea.Left;
    MaxHeight := WorkArea.Bottom - WorkArea.Top;
    // 以下、初期位置に問題があるときの移動
    if (Result.Left < WorkArea.Left) then begin
        // 逆サイドに余裕があれば、出力位置の左右転換
        if ((p.X - WorkArea.Left) * 2 < MaxWidth) then begin
            if ( (GikoSys.Setting.PopupPosition = gppTop) or
                (GikoSys.Setting.PopupPosition = gppBottom)) then begin
                OffsetRect(Result, -Result.Left, 0);
            end else begin
                OffsetRect(Result, - (dx1 + 2 * dx2), 0);
            end;
        end else begin
            // 画面端まで画面幅を小さくする
            Result := Rect(WorkArea.Left, Result.Top,
                Result.Right, Result.Bottom);
        end;
    end;
    if (Result.Top < WorkArea.Top) then begin
        // 底側に余裕があれば、出力位置の上下転換
        if ((p.Y - WorkArea.Top) * 2 < MaxHeight) then begin
            OffsetRect(Result, 0, - (dy1 + 2 * dy2));
        end else begin
            // 画面端まで画面高を小さくする
            Result := Rect(Result.Left, WorkArea.Top,
                Result.Right, Result.Bottom);
        end;
    end;
    if (Result.Right > WorkArea.Right) then begin
        // 逆サイドに余裕があれば、出力位置の左右転換
        if ((p.X - WorkArea.Left) * 2 > MaxWidth) then begin
            if( (GikoSys.Setting.PopupPosition = gppTop) or
                (GikoSys.Setting.PopupPosition = gppBottom)) then begin
                OffsetRect(Result, -(Result.Right - WorkArea.Right), 0);
            end else begin
                OffsetRect(Result, -w - (dx1 + 2 * dx2), 0);
            end;
            // 逆サイドにオーバーした場合は画面端まで幅を小さくする
            if (Result.Left < WorkArea.Left) then begin
                Result := Rect(WorkArea.Left, Result.Top,
                    Result.Right, Result.Bottom);
            end;
        end else begin
            // 画面端まで画面幅を小さくする
            Result := Rect(Result.Left, Result.Top,
                WorkArea.Right, Result.Bottom);
        end;
    end;
    if (Result.Bottom > WorkArea.Bottom) then begin
        // 上側に余裕があれば、出力位置の上下転換
        if ((p.Y - WorkArea.Top) * 2 > WorkArea.Bottom) then begin
            OffsetRect(Result, 0, -h - (dy1 + 2 * dy2));
            // 上に貫いた場合は、
            if (Result.Top < WorkArea.Top) then begin
                Result := Rect(Result.Left, WorkArea.Top,
                    Result.Right, Result.Bottom);
            end;
        end else begin
            // 画面端まで画面高を小さくする
            Result := Rect(Result.Left, Result.Top,
                Result.Right, WorkArea.Bottom);
        end;
    end;
end;
function TResPopupBrowser.GetWindowHeight : Integer;
var
	top: Integer;
	item: OleVariant;
begin
    Result := 0;
    //ブラウザがデータの読み込み中の時は読み込みを待つ
    while (Self.ReadyState <> READYSTATE_COMPLETE) and
                (Self.ReadyState <> READYSTATE_INTERACTIVE) do begin
        Sleep(1);
        Forms.Application.ProcessMessages;
    end;

    try
        top := 0;
        item := Self.OleObject.Document.anchors.item(OleVariant('bottom'));
        item.focus();
        repeat
            top := top + item.offsetTop;
            item := item.offsetParent;
        until AnsiCompareText(item.tagName, 'body' ) = 0;
        Result := top;
    except
    end;
end;
function TResPopupBrowser.ResPopupBrowserClick(Sender: TObject): WordBool;
begin
    // ギコナビのフォーカスを奪ってるのでフォームに無理やり返す
    Blur;
    Result := True;
end;
function TResPopupBrowser.GetThread: TThreadItem;
begin
    Result := nil;
    if (FThread <> nil) then begin
        try
            // 無効なポインタ検査
            if (FThread.ParentBoard <> nil) then begin
                Result := FThread
            end;
        except
            //無効なポインタだった
            Result := nil;
        end;
    end;
end;
procedure TResPopupBrowser.Blur;
var
    FOleInPlaceActiveObject: IOleInPlaceActiveObject;
begin
    FOleInPlaceActiveObject := Self.ControlInterface as IOleInPlaceActiveObject;
    FOleInPlaceActiveObject.OnFrameWindowActivate(False);
end;
function TResPopupBrowser.ResPopupBrowserDbClick(Sender: TObject): WordBool;
begin
    // ギコナビのフォーカスを奪ってるのでフォームに無理やり返す
    Blur;
    // 自分で自分は消せないので、メッセージ経由で消してもらう
    PostMessage( GikoForm.Handle , USER_POPUPCLEAR, Integer( Self ), 0 );
    Result := True;
end;
initialization
    OleInitialize(nil);

finalization
    OleUninitialize;

end.
