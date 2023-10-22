object NewBoardURLForm: TNewBoardURLForm
  Left = 382
  Top = 189
  BorderStyle = bsDialog
  Caption = #26495#31227#36578#20808#26908#32034
  ClientHeight = 280
  ClientWidth = 483
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object CategoryLabel: TLabel
    Left = 24
    Top = 16
    Width = 53
    Height = 12
    Caption = #12459#12486#12468#12522#21517
  end
  object CategoryComboBox: TComboBox
    Left = 88
    Top = 13
    Width = 145
    Height = 20
    ItemHeight = 0
    TabOrder = 0
    Text = 'CategoryComboBox'
  end
  object SearchButton: TButton
    Left = 256
    Top = 8
    Width = 75
    Height = 25
    Caption = #26908#32034'(&s)'
    TabOrder = 1
    OnClick = SearchButtonClick
  end
  object ResultMemo: TMemo
    Left = 24
    Top = 48
    Width = 457
    Height = 225
    Lines.Strings = (
      'ResultMemo')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object CloseButton: TButton
    Left = 352
    Top = 8
    Width = 75
    Height = 25
    Caption = #38281#12376#12427
    ModalResult = 1
    TabOrder = 3
  end
  object IdHTTP: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    OnRedirect = IdHTTPRedirect
    Left = 408
    Top = 16
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvTLSv1_2
    SSLOptions.SSLVersions = [sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 448
    Top = 16
  end
end
