unit Preview;

interface
uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	ActiveX, OleCtrls, HTMLDocumentEvent,
{$IF Defined(DELPRO) }
	SHDocVw,
	MSHTML
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB
{$IFEND}
;
type
	TPreviewBrowser = class(TWebBrowser)
	private
        FEvent: THTMLDocumentEventSink;//ブラウザドキュメントイベント
        function makeHTML(const URL, Host, Document : String): String;
        procedure BrowserDocumentComplete(Sender: TObject;
	            const pDisp: IDispatch; var URL: OleVariant);
        function PreviewDbClick(Sender: TObject): WordBool;
	protected
		procedure CreateParams(var Params: TCreateParams); override;
	public
		constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;
        procedure PreviewImage(URL : String);
        function GetWindowRect(Point: TPoint) : TRect;
	end;

implementation
uses MojuUtils, GikoSystem, Setting, Giko;

const
	//プレビューファイル名
	HTML_FILE_NAME 	= 'temp_preview.html';
    // マウスカーソルからのずらし位置
    DIV_X = 15;
    DIV_Y = 15;
    NICO = 'www.nicovideo.jp';

constructor TPreviewBrowser.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
    FEvent := nil;
    OnDocumentComplete := BrowserDocumentComplete;
end;

destructor TPreviewBrowser.Destroy;
begin
    if (FEvent <> nil) then begin
        FreeAndNil(FEvent);
    end;
	inherited Destroy;
end;

procedure TPreviewBrowser.CreateParams(var Params: TCreateParams);
begin
	inherited;
end;
{
\brief  指定されたURLのプレビュー
\param  URL プレビューするイメージのURL
}
procedure TPreviewBrowser.PreviewImage(URL : String);
var
    HtmlFileName : string;
    sl : TStringList;
    Protocol, Host, Path, Document, Port, Bookmark : string;
    Referer : string;
	Flags: OleVariant;
	TargetFrameName: OleVariant;
	PostData: OleVariant;
  	Headers: OleVariant;
begin
	GikoSys.ParseURI(URL, Protocol, Host, Path, Document, Port, Bookmark);
	Referer := Protocol + '://' + Host;
	if Port <> '' then
		Referer := Referer + ':' + Port;
	Referer := Referer + Path;
	Headers := 'Referer: ' + Referer;
    Flags := 0;
    TargetFrameName := '';
    PostData := '';

    HtmlFileName := GikoSys.GetAppDir + HTML_FILE_NAME;
	sl := TStringList.Create;
	try
		try
            sl.Text := makeHTML(URL, Host, Document);
			sl.SaveToFile(HtmlFileName);
		finally
			sl.Free;
		end;
	except
	end;


	Navigate(HtmlFileName,Flags, TargetFrameName, PostData, Headers);

end;
{
\breif 表示するウィンドウサイズを取得する
\param Point マウスカーソルの座標
}
function TPreviewBrowser.GetWindowRect(Point: TPoint) : TRect;
var
    WindowWidth, WindowHeight : Integer;
begin
    // 設定による場合わけ
	case GikoSys.Setting.PreviewSize of
		gpsXSmall: begin
			WindowWidth := 128;
			WindowHeight := 96;
		end;
		gpsSmall: begin
			WindowWidth := 256;
			WindowHeight := 192;
		end;
		gpsLarge: begin
			WindowWidth := 512;
			WindowHeight := 384;
		end;
		gpsXLarge: begin
			WindowWidth := 640;
			WindowHeight := 480;
		end;
		else begin	//gpsMedium
			WindowWidth := 384;
			WindowHeight := 288;
		end;
	end;

	Result := Rect(0, 0, WindowWidth, WindowHeight);
    // bata55以前は左右が間違ってた
    // 出し位置による補正
	case GikoSys.Setting.PopupPosition of
		gppLeftTop: 		OffsetRect(Result,
            Point.x - WindowWidth - DIV_X, Point.y - WindowHeight -	DIV_Y);
		gppLeft: 			OffsetRect(Result,
            Point.x - WindowWidth - DIV_X, Point.y - (WindowHeight div 2));
		gppLeftBottom: OffsetRect(Result,
            Point.x - WindowWidth - DIV_X, Point.y + DIV_Y);
		gppTop:				OffsetRect(Result,
            Point.x - (WindowWidth div 2), Point.y - WindowHeight - DIV_Y);
		gppCenter:			OffsetRect(Result,
            Point.x - (WindowWidth div 2), Point.y - (WindowHeight div 2));
		gppBottom:			OffsetRect(Result,
            Point.x - (WindowWidth div 2), Point.y + DIV_Y);
		gppRightTop:			OffsetRect(Result,
            Point.x + DIV_X, Point.y - WindowHeight - DIV_Y);
		gppRight:			OffsetRect(Result,
            Point.x + DIV_X, Point.y - (WindowHeight div 2));
		gppRightBottom: 	OffsetRect(Result, Point.x + DIV_X, Point.y + DIV_Y);		//ギコナビスレ パート１の453氏に感謝
	end;

end;

{
\breif プレビュー用のHTMLを作成する
\param URL プレビューするイメージファイル
}
function TPreviewBrowser.makeHTML(const URL, Host, Document : String): String;
const
  HDR_NO_CACHE: String = '<meta http-equiv="Pragma" content="no-cache"><meta http-equiv="Cache-Control" content="no-cache"><meta http-equiv="Expires" content="0">'#13#10;
var
    point :TPoint;
    rect  :TRect;
begin
    if (Pos('https://www.nicovideo.jp/watch/', URL) <> 1) then begin
    	Result := '<html><head>'#13#10
        + HDR_NO_CACHE
				+ '<SCRIPT>'#13#10
				+ 'function init() {'#13#10
				+ '	if ((document.body.clientHeight >= Image1.height) && (document.body.clientWidth >= Image1.width)) {'#13#10
				+ '	} else {'#13#10
				+ '		var dh, ih;'#13#10
				+ '		dh = document.body.clientWidth / document.body.clientHeight;'#13#10
				+ '		ih = Image1.width / Image1.height;'#13#10
				+ '		if (document.body.clientWidth < document.body.clientHeight) {'#13#10
				+ '			if (ih > dh)'#13#10
				+ '				Image1.width = document.body.clientWidth;'#13#10
				+ '			else'#13#10
				+ '				Image1.height = document.body.clientHeight;'#13#10
				+ '		} else {'#13#10
				+ '			if (ih < dh)'#13#10
				+ '				Image1.height = document.body.clientHeight;'#13#10
				+ '			else'#13#10
				+ '				Image1.width = document.body.clientWidth;'#13#10
				+ '		}'#13#10
				+ '	}'#13#10
				+ '	Message.style.display = "none";'#13#10
				+ '}'#13#10
				+ '</SCRIPT>'#13#10
				+ '</head>'#13#10
				+ '<body topmargin="0" leftmargin="0" style="border-width: 1px; overflow:hidden; border-style: solid;" onLoad="init()">'#13#10
				+ '<div align="center" id="Message">プレビュー作成中</div>'#13#10
				+ '<div align="center"><img name="Image1" border="0" src="' + URL + '"></div>'#13#10
				+ '</body></html>';
    end else begin
        // <div><iframe width="340" height="185" src="http://www.nicovideo.jp/thumb/sm2494604" scrolling="no" style="border:solid 1px #CCC;" frameborder="0"></iframe></div><div class=link_nicovideo_title><a href="" title="" target="_blank"></a></div>
        rect := GetWindowRect(point);

        Result := '<html><head>'#13#10
				        + HDR_NO_CACHE
                + '<SCRIPT>'#13#10
                + 'function init() {'#13#10
                + '	Message.style.display = "none";'#13#10
                + '}'#13#10
                + '</SCRIPT>'#13#10
                + '</head>'#13#10
                + '<body topmargin="0" leftmargin="0" style="border-width: 1px; overflow:hidden; border-style: solid;" onLoad="init()">'#13#10
                + '<div align="center" id="Message">プレビュー作成中</div>'#13#10
                + '<div><iframe width="' + IntToStr(rect.Right - rect.Left) +'" height="' + IntToStr(rect.Bottom - rect.Top) + '" src="https://' + Host + '/thumb/' + Document + '" scrolling="no" style="border:solid 1px #CCC;" frameborder="0"></iframe></div>'
				+ '</body></html>';
    end;
end;
//! ドキュメント完了イベント
procedure TPreviewBrowser.BrowserDocumentComplete(Sender: TObject;
    const pDisp: IDispatch; var URL: OleVariant);
begin
    if (URL <> 'about:blank') then begin
        FEvent := THTMLDocumentEventSink.Create(Self, Self.OleObject.Document,
            HTMLDocumentEvents2);
        FEvent.OnDoubleClick := PreviewDbClick;
    end else begin
        if (FEvent <> nil) then begin
            FreeAndNil(FEvent);
        end;
    end;
end;
function TPreviewBrowser.PreviewDbClick(Sender: TObject): WordBool;
begin
    // 自分で自分は消せないので、メッセージ経由で消してもらう
    PostMessage( GikoForm.Handle , USER_POPUPCLEAR, Integer( Self ), 0 );
    Result := True;
end;

end.
