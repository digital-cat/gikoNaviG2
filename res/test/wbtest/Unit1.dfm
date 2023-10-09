object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 642
  ClientWidth = 954
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 954
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object ButtonGet: TButton
      Left = 56
      Top = 8
      Width = 75
      Height = 25
      Caption = #21462#24471
      TabOrder = 0
      OnClick = ButtonGetClick
    end
  end
  object WebBrowser: TWebBrowser
    Left = 0
    Top = 41
    Width = 954
    Height = 601
    Align = alClient
    TabOrder = 1
    OnNavigateComplete2 = WebBrowserNavigateComplete2
    ExplicitLeft = 104
    ExplicitTop = 104
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000996200001D3E00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
