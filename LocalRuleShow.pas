unit LocalRuleShow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GikoSystem, BoardGroup, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP;

type
  TShow = class(TForm)
    ShowMemo: TMemo;
    IdHTTP1: TIdHTTP;
  private
    { Private �錾 }
    FBoard: TBoard;
  public
    { Public �錾 }
    function RuleShow(TXTName:String): String;
  end;

var
  Show: TShow;
  TXTName:String;

implementation

{$R *.dfm}

function TShow.RuleShow(TXTName:String): String;
var
        RefUrl,URL: String;
        Indy: TIdHTTP;
begin
        RefURL := GikoSys.UrlToServer(FBoard.URL)
               + GikoSys.UrlToID(FBoard.URL)
	       + '/';
	//RefURL������SETTING.TXT�A�h���X�w��
	URL := RefURL
	     	+ TXTName;
        ShowMemo.Text := Indy.Get(URL);
end;

end.
