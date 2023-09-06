object NewBoardDialog: TNewBoardDialog
  Left = 337
  Top = 197
  BorderStyle = bsDialog
  Caption = #26495#19968#35239#26356#26032
  ClientHeight = 346
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 128
    Height = 12
    Caption = #26495#19968#35239#12398#26356#26032#12434#34892#12356#12414#12377
  end
  object Label13: TLabel
    Left = 6
    Top = 245
    Width = 155
    Height = 12
    Caption = #65298#12385#12419#12435#12397#12427#12508#12540#12489#19968#35239'URL(&N)'
  end
  object Label2: TLabel
    Left = 12
    Top = 23
    Width = 4
    Height = 12
  end
  object MessageMemo: TMemo
    Left = 4
    Top = 40
    Width = 453
    Height = 197
    ScrollBars = ssVertical
    TabOrder = 3
    WantReturns = False
  end
  object UpdateButton: TButton
    Left = 220
    Top = 316
    Width = 75
    Height = 21
    Caption = #26356#26032
    TabOrder = 0
    OnClick = UpdateButtonClick
  end
  object CloseButton: TButton
    Left = 380
    Top = 316
    Width = 75
    Height = 21
    Caption = #38281#12376#12427
    TabOrder = 2
    OnClick = CloseButtonClick
  end
  object StopButton: TButton
    Left = 300
    Top = 316
    Width = 75
    Height = 21
    Caption = #20013#27490
    TabOrder = 1
    OnClick = StopButtonClick
  end
  object BoardURLComboBox: TComboBox
    Left = 4
    Top = 261
    Width = 417
    Height = 20
    ItemHeight = 0
    TabOrder = 4
    Text = 'BoardURLComboBox'
  end
  object EditIgnoreListsButton: TButton
    Left = 8
    Top = 315
    Width = 113
    Height = 21
    Caption = #38500#22806#12459#12486#12468#12522#12540#32232#38598
    TabOrder = 6
    OnClick = EditIgnoreListsButtonClick
  end
  object SakuCheckBox: TCheckBox
    Left = 8
    Top = 288
    Width = 361
    Height = 17
    Caption = #12300#21066#38500#35201#35531#12301#26495#12364#12300'saku'#12301#12398#22580#21512#12300'saku2ch'#12301#12395#32622#12365#25563#12360#12427'(&S)'
    TabOrder = 5
  end
  object Indy: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL
    AllowCookies = False
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = []
    Left = 388
    Top = 4
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
    Left = 424
    Top = 8
  end
end
