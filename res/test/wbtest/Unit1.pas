unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls, StdCtrls, MSHTML;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    WebBrowser: TWebBrowser;
    ButtonGet: TButton;
    procedure FormShow(Sender: TObject);
    procedure ButtonGetClick(Sender: TObject);
    procedure WebBrowserNavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  private
    htmlPath: String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  htmlPath := ExtractFilePath(Application.ExeName) + 'test.html';

  WebBrowser.Navigate('about:blank');
end;

procedure TForm1.WebBrowserNavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  html: TStringList;
  doc: IHTMLDocument2;
begin
  html := TStringList.Create;

  try
    if Assigned(WebBrowser.Document) then begin
      doc := WebBrowser.Document as IHTMLDocument2;

      html.LoadFromFile(htmlPath);

      doc.body.innerHTML := html.Text;
    end else begin
      ShowMessage('Assigned(WebBrowser.Document) = False');
    end;
  finally
    html.Free;
  end;
end;

procedure TForm1.ButtonGetClick(Sender: TObject);
var
  doc:   IHTMLDocument3;
  title: WideString;
  name:  WideString;
  mail:  WideString;
  msg:   WideString;
  sage:  WideString;
  svhdl: WideString;
  debug: WideString;
begin
  try
    if Assigned(WebBrowser.Document) then begin
      doc := WebBrowser.Document as IHTMLDocument3;

      title := doc.getElementById('posttitle').getAttribute('value', 0);
      name  := doc.getElementById('postname').getAttribute('value', 0);
      mail  := doc.getElementById('postmail').getAttribute('value', 0);
      msg   := doc.getElementById('postmessage').innerText;
      sage  := doc.getElementById('sage').getAttribute('checked', 0);
      svhdl := doc.getElementById('savehandle').getAttribute('checked', 0);

      debug := title + #10#13 + name + #10#13 + mail + #10#13 + msg + #10#13 + sage + #10#13 + svhdl;

      MessageBoxW(Handle, PWideChar(debug), 'debug', MB_OK);

    end else begin
      ShowMessage('Assigned(WebBrowser.Document) = False');
    end;
  finally

  end;
end;

end.
