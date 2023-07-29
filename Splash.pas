unit Splash;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	StdCtrls, ComCtrls, ExtCtrls;

type
	TSplashWindow = class(TForm)
    ProgressPanel: TPanel;
    VersionLabel: TLabel;
    ProgressBar: TProgressBar;
    SplashImage: TImage;
		procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
	private
		{ Private êÈåæ }
	protected
		procedure CreateParams(var Params: TCreateParams); override;
	public
		{ Public êÈåæ }
	end;

var
	SplashWindow: TSplashWindow;

implementation

uses
    GikoSystem;

{$R *.DFM}

procedure TSplashWindow.CreateParams(var Params: TCreateParams);
begin
	inherited;
//	Params.Style := Params.Style or WS_THICKFRAME;
//	Params.ExStyle := Params.ExStyle or WS_EX_DLGMODALFRAME;
	Params.Style := Params.Style or WS_DLGFRAME;
end;

procedure TSplashWindow.FormDeactivate(Sender: TObject);
begin
	Release;
	SplashWindow := nil;
end;

procedure TSplashWindow.FormCreate(Sender: TObject);
var
	FileName: string;
begin
	VersionLabel.Caption := 'Version ' + BETA_VERSION_NAME_J
												+ FloatToStr(BETA_VERSION)
												+ BETA_VERSION_BUILD;
	try
		FileName := GikoSys.GetAppDir + 'gikoNavi.bmp';
		if FileExists(FileName) then begin
			SplashImage.Picture.LoadFromFile(FileName);
			ClientHeight := SplashImage.Picture.Height + ProgressPanel.Height;
			ClientWidth := SplashImage.Picture.Width;
		end;
	except
	end;
end;

initialization
	SplashWindow := TSplashWindow.Create(nil);
	SplashWindow.Show;
	SplashWindow.Update;
end.
