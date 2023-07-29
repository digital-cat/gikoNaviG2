unit BrowserRecord;

interface

uses
	Windows, OleCtrls, ActiveX,
{$IF Defined(DELPRO) }
	SHDocVw,
	MSHTML,
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB,
{$IFEND}
	BoardGroup, HTMLDocumentEvent;

type
	TBrowserRecord = class( TObject )
	private
		FBrowser	: TWebBrowser;
		FEvent: THTMLDocumentEventSink;	///< ブラウザドキュメントイベント
		FThread		: TThreadItem;
		FLastSize	: Integer;
		FRepaint	: Boolean;
		//FMovement	: string;							///< スクロール先アンカー
	public
		destructor	Destroy; override;
		property	Event : THTMLDocumentEventSink read FEvent write FEvent;
		property	Browser	: TWebBrowser	read FBrowser	write FBrowser;
		property	Thread	: TThreadItem	read FThread	write FThread;
		property	LastSize	: Integer		read FLastSize	write FLastSize;
		property	Repaint		: Boolean		read FRepaint	write FRepaint;
		//property	Movement	: string		read FMovement	write FMovement;
		procedure	Move(const AName: string); overload;
        procedure	Move(scroll: Integer); overload;
		procedure	IDAnchorPopup(Abody :string);
        procedure OpenFindDialog;
	end;
	// BrowserRecordについているFBrowserを外す
	procedure ReleaseBrowser( BRecord: TBrowserRecord);

implementation

uses
	Forms, SysUtils;

// *************************************************************************
//! BrowserRecordについているFBrowserを外す
// *************************************************************************
procedure ReleaseBrowser( BRecord: TBrowserRecord);
begin
	if BRecord <> nil then begin
		BRecord.Browser := nil;
		if BRecord.Event <> nil then begin
			BRecord.Event.Free;
			BRecord.Event := nil;
		end;
		BRecord.Repaint := true;
	end;
end;
// *************************************************************************
//! BrowserRecordのデストラクタ
// *************************************************************************
destructor	TBrowserRecord.Destroy;
var
	doc :IHTMLDocument2;
begin
	if Self.FEvent <> nil then
		Self.FEvent.Free;

	if Self.FBrowser <> nil then begin
		if Self.Thread <> nil then begin
			//タブの復元で復元されたスレは、描画されていないときがあるので
			//そのときのスクロール量を保存してしまうとトップに戻ってしまう。

            try
                doc := Self.FBrowser.ControlInterface.Document as IHTMLDocument2;
                if Assigned(doc) then begin
                    if (doc as IHTMLDocument3).documentElement.innerText <> '' then begin
                        Self.Thread.ScrollTop := (doc.body as IHTMLElement2).scrollTop;
		    	    end;
                end;
            except
            end;
		end;
		ShowWindow(Self.FBrowser.Handle, SW_HIDE);
	end;

end;
// *************************************************************************
//! ブラウザをスクロールさせる
// *************************************************************************
procedure TBrowserRecord.Move(const AName: string);
var
	top: Integer;
	item: OleVariant;
    doc : OleVariant;
begin
	//ブラウザが付いてるときだけ処理する
    if not Assigned(Self.Browser) then
        Exit;

	//ブラウザがデータの読み込み中の時は読み込みを待つ
	while (Self.Browser.ReadyState <> READYSTATE_COMPLETE) and
    			(Self.Browser.ReadyState <> READYSTATE_INTERACTIVE) do begin
		Sleep(1);
		Application.ProcessMessages;
	end;

	try
        doc := Self.Browser.OleObject.Document;
		top := 0;
		item := doc.anchors.item(OleVariant(AName));
		item.focus();
		repeat
			top := top + item.offsetTop;
    		item := item.offsetParent;
		until AnsiCompareText(item.tagName, 'body' ) = 0;
		doc.body.scrollTop := top;
	except
	end;
end;
// *************************************************************************
//! ブラウザをスクロールさせる
// *************************************************************************
procedure TBrowserRecord.Move(scroll: Integer);
var
    doc: IHTMLDocument2;
begin
	//ブラウザが付いてるときだけ処理する
    if not Assigned(Self.Browser) then
        Exit;

	//ブラウザがデータの読み込み中の時は読み込みを待つ
	while (Self.Browser.ReadyState <> READYSTATE_COMPLETE) and
				(Self.Browser.ReadyState <> READYSTATE_INTERACTIVE) do begin
		Sleep(1);
		Application.ProcessMessages;
	end;

	try
        doc := Self.Browser.ControlInterface.Document as IHTMLDocument2;
		(doc.body as IHTMLElement2).scrollTop := (doc.body as IHTMLElement2).scrollTop + scroll;
	except
	end;
end;

//IDアンカー追加
procedure TBrowserRecord.IDAnchorPopup(Abody :string);
const
	OUTER_HTML = '<p id="idSearch"></p>';
	HIDDEN = 'hidden';
var
	firstElement: IHTMLElement;
	doc : IHTMLDocument2;
	nCSS : string;
begin
    if not Assigned(Self.Browser) then
        Exit;

	try
		doc := Self.Browser.ControlInterface.Document as IHTMLDocument2;
		if not Assigned(doc) then
            Exit;

		firstElement := doc.all.item('idSearch', 0) as IHTMLElement;
		if not Assigned(firstElement) then
            Exit;

        try
    		if Length(Abody) > 0 then begin
		    	nCSS := '<p id="idSearch" style="position:absolute;top:' + IntToStr((doc.body as IHTMLElement2).ScrollTop + 10) + 'px;right:5px;' //
			    	+ 'background-color:window; border:outset 1px infobackground; z-index:10; overflow-y:auto; border-top:none">'
				    + Abody + '</p>';
        		firstElement.outerHTML := nCSS;
	        	firstElement.style.visibility := 'visible';
		    end else begin
			    firstElement.outerHTML := OUTER_HTML;
    			firstElement.style.visibility := HIDDEN;
	    	end;
	    except
		    firstElement.outerHTML := OUTER_HTML;
   			firstElement.style.visibility := HIDDEN;
    	end;

	except
	end;
end;
{
\brief 検索ダイアログ呼び出し
}
procedure TBrowserRecord.OpenFindDialog();
const
	CGID_WebBrowser: TGUID = '{ED016940-BD5B-11cf-BA4E-00C04FD70816}';
	HTMLID_FIND = 1;
var
	CmdTarget : IOleCommandTarget;
	vaIn, vaOut: OleVariant;
begin
	if Assigned(Self.Browser) then begin
		try
			CmdTarget := Self.Browser.ControlInterface.Document as IOleCommandTarget;
			if Assigned(CmdTarget) then begin
				CmdTarget.Exec(@CGID_WebBrowser, HTMLID_FIND, 0, vaIn, vaOut);
			end;
		except
		end;
	end;
end;

end.
