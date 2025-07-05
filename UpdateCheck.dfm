object UpdateCheckForm: TUpdateCheckForm
  Left = 331
  Top = 160
  BorderStyle = bsDialog
  Caption = #26356#26032#12481#12455#12483#12463
  ClientHeight = 385
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object CancelBitBtn: TBitBtn
    Left = 473
    Top = 80
    Width = 112
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    Enabled = False
    TabOrder = 2
    OnClick = CancelBitBtnClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object CheckButton: TButton
    Left = 8
    Top = 80
    Width = 459
    Height = 25
    Caption = #26368#26032#29256#12398#30906#35469
    TabOrder = 1
    OnClick = CheckButtonClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 120
    Width = 577
    Height = 217
    Caption = #26368#26032#12398#12496#12540#12472#12519#12531
    TabOrder = 3
    object Label5: TLabel
      Left = 59
      Top = 48
      Width = 39
      Height = 12
      Caption = 'Version'
    end
    object NewVerLabel: TLabel
      Left = 111
      Top = 48
      Width = 48
      Height = 12
      Caption = '1.00.1.000'
    end
    object NewMsgLabel: TLabel
      Left = 183
      Top = 48
      Width = 79
      Height = 12
      Caption = #26356#26032#21487#33021#12391#12377#12290
    end
    object NlyNameLabel: TLabel
      Left = 10
      Top = 140
      Width = 36
      Height = 12
      Caption = #20154#26609#29256
    end
    object Label9: TLabel
      Left = 59
      Top = 140
      Width = 39
      Height = 12
      Caption = 'Version'
    end
    object NlyVerLabel: TLabel
      Left = 111
      Top = 140
      Width = 48
      Height = 12
      Caption = '1.00.0.000'
    end
    object NlyMsgLabel: TLabel
      Left = 183
      Top = 140
      Width = 79
      Height = 12
      Caption = #26356#26032#21487#33021#12391#12377#12290
    end
    object NewNameLabel: TLabel
      Left = 10
      Top = 48
      Width = 29
      Height = 12
      Caption = #65418#65438#65408'00'
    end
    object Label2: TLabel
      Left = 24
      Top = 68
      Width = 53
      Height = 12
      Caption = #12522#12522#12540#12473#26085
    end
    object NewDateLabel: TLabel
      Left = 96
      Top = 68
      Width = 60
      Height = 12
      Caption = '2024/12/31'
    end
    object Label3: TLabel
      Left = 24
      Top = 160
      Width = 53
      Height = 12
      Caption = #12522#12522#12540#12473#26085
    end
    object NlyDateLabel: TLabel
      Left = 96
      Top = 160
      Width = 60
      Height = 12
      Caption = '2024/12/31'
    end
    object NlyDate3Label: TLabel
      Left = 396
      Top = 160
      Width = 60
      Height = 12
      Caption = '2024/12/31'
    end
    object Label6: TLabel
      Left = 324
      Top = 160
      Width = 53
      Height = 12
      Caption = #12522#12522#12540#12473#26085
    end
    object NlyMsg3Label: TLabel
      Left = 483
      Top = 140
      Width = 79
      Height = 12
      Caption = #26356#26032#21487#33021#12391#12377#12290
    end
    object NlyVer3Label: TLabel
      Left = 411
      Top = 140
      Width = 48
      Height = 12
      Caption = '1.00.0.000'
    end
    object Label10: TLabel
      Left = 359
      Top = 140
      Width = 39
      Height = 12
      Caption = 'Version'
    end
    object NlyName3Label: TLabel
      Left = 310
      Top = 140
      Width = 36
      Height = 12
      Caption = #20154#26609#29256
    end
    object NewDate3Label: TLabel
      Left = 396
      Top = 68
      Width = 60
      Height = 12
      Caption = '2024/12/31'
    end
    object Label13: TLabel
      Left = 324
      Top = 68
      Width = 53
      Height = 12
      Caption = #12522#12522#12540#12473#26085
    end
    object NewMsg3Label: TLabel
      Left = 483
      Top = 48
      Width = 79
      Height = 12
      Caption = #26356#26032#21487#33021#12391#12377#12290
    end
    object NewVer3Label: TLabel
      Left = 411
      Top = 48
      Width = 48
      Height = 12
      Caption = '1.00.1.000'
    end
    object Label16: TLabel
      Left = 359
      Top = 48
      Width = 39
      Height = 12
      Caption = 'Version'
    end
    object NewName3Label: TLabel
      Left = 310
      Top = 48
      Width = 29
      Height = 12
      Caption = #65418#65438#65408'00'
    end
    object UpdateNewButton: TButton
      Left = 24
      Top = 86
      Width = 226
      Height = 25
      Caption = 'OpenSSL 1 '#26368#26032#29256#12395#26356#26032
      TabOrder = 0
      OnClick = UpdateNewButtonClick
    end
    object UpdateNlyButton: TButton
      Left = 24
      Top = 178
      Width = 226
      Height = 25
      Caption = 'OpenSSL 1 '#20154#26609#29256#12395#26356#26032
      TabOrder = 1
      OnClick = UpdateNlyButtonClick
    end
    object Panel1: TPanel
      Left = 6
      Top = 20
      Width = 263
      Height = 17
      BevelOuter = bvLowered
      Caption = 'OpenSSL 1 '#29256
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
    end
    object Panel2: TPanel
      Left = 306
      Top = 20
      Width = 263
      Height = 17
      BevelOuter = bvLowered
      Caption = 'OpenSSL 3 '#29256
      Color = clWhite
      ParentBackground = False
      TabOrder = 3
    end
    object UpdateNly3Button: TButton
      Left = 324
      Top = 178
      Width = 226
      Height = 25
      Caption = 'OpenSSL 3 '#20154#26609#29256#12395#26356#26032
      TabOrder = 4
      OnClick = UpdateNly3ButtonClick
    end
    object UpdateNew3Button: TButton
      Left = 324
      Top = 86
      Width = 226
      Height = 25
      Caption = 'OpenSSL 3 '#26368#26032#29256#12395#26356#26032
      TabOrder = 5
      OnClick = UpdateNew3ButtonClick
    end
    object Panel3: TPanel
      Left = 286
      Top = 48
      Width = 2
      Height = 153
      TabOrder = 6
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 577
    Height = 57
    Caption = #29694#22312#12398#12496#12540#12472#12519#12531
    TabOrder = 0
    object CurNameLabel: TLabel
      Left = 10
      Top = 26
      Width = 29
      Height = 12
      Caption = #65418#65438#65408'00'
    end
    object CurVerLabel: TLabel
      Left = 111
      Top = 26
      Width = 48
      Height = 12
      Caption = '1.00.0.000'
    end
    object CurTypLabel: TLabel
      Left = 183
      Top = 26
      Width = 67
      Height = 12
      Caption = #20154#26609#29256#12391#12377#12290
    end
    object Label1: TLabel
      Left = 59
      Top = 26
      Width = 39
      Height = 12
      Caption = 'Version'
    end
  end
  object CloseButton: TButton
    Left = 487
    Top = 350
    Width = 98
    Height = 25
    Caption = #38281#12376#12427
    TabOrder = 4
    OnClick = CloseButtonClick
  end
  object Panel4: TPanel
    Left = 14
    Top = 350
    Width = 427
    Height = 22
    BevelOuter = bvLowered
    Caption = #8251'OpenSSL 1 '#29256#12399#65301#12385#12419#12435#12397#12427#12395#25509#32154#12391#12365#12394#12356#21487#33021#24615#12364#12354#12426#12414#12377#12290
    Color = clWhite
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
  end
  object IdHTTP: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL
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
    Left = 304
    Top = 8
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
    Left = 336
    Top = 8
  end
end
