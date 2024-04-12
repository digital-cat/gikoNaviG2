object DonguriForm: TDonguriForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #12489#12531#12464#12522#12471#12473#12486#12512
  ClientHeight = 415
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object InfoGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 526
    Height = 321
    Align = alTop
    BevelInner = bvNone
    BevelOuter = bvNone
    ColCount = 2
    DefaultColWidth = 100
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 14
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 0
    ExplicitWidth = 518
  end
  object AuthButton: TButton
    Left = 80
    Top = 336
    Width = 177
    Height = 25
    Caption = #12393#12435#12368#12426#20877#35469#35388
    TabOrder = 1
    OnClick = AuthButtonClick
  end
  object LogoutButton: TButton
    Left = 263
    Top = 336
    Width = 178
    Height = 25
    Caption = #12393#12435#12368#12426#12525#12464#12450#12454#12488
    TabOrder = 2
    OnClick = LogoutButtonClick
  end
  object UplLoginButton: TButton
    Left = 80
    Top = 376
    Width = 177
    Height = 25
    Caption = 'UPLIFT'#12525#12464#12452#12531
    TabOrder = 3
    OnClick = UplLoginButtonClick
  end
  object UplLogoutButton: TButton
    Left = 263
    Top = 376
    Width = 178
    Height = 25
    Caption = 'UPLIFT'#12525#12464#12450#12454#12488
    TabOrder = 4
    OnClick = UplLogoutButtonClick
  end
  object TimerInit: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerInitTimer
    Left = 328
    Top = 24
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
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 424
    Top = 24
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
    Left = 472
    Top = 24
  end
end
