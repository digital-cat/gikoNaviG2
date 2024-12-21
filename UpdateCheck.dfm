object UpdateCheckForm: TUpdateCheckForm
  Left = 331
  Top = 160
  BorderStyle = bsDialog
  Caption = #26356#26032#12481#12455#12483#12463
  ClientHeight = 302
  ClientWidth = 444
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
    Left = 336
    Top = 80
    Width = 97
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
    Width = 313
    Height = 25
    Caption = #26368#26032#29256#12398#30906#35469
    TabOrder = 1
    OnClick = CheckButtonClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 120
    Width = 425
    Height = 139
    Caption = #26368#26032#12398#12496#12540#12472#12519#12531
    TabOrder = 3
    object Label5: TLabel
      Left = 59
      Top = 28
      Width = 39
      Height = 12
      Caption = 'Version'
    end
    object NewVerLabel: TLabel
      Left = 111
      Top = 28
      Width = 48
      Height = 12
      Caption = '1.00.1.000'
    end
    object NewMsgLabel: TLabel
      Left = 183
      Top = 28
      Width = 79
      Height = 12
      Caption = #26356#26032#21487#33021#12391#12377#12290
    end
    object NlyNameLabel: TLabel
      Left = 10
      Top = 90
      Width = 36
      Height = 12
      Caption = #20154#26609#29256
    end
    object Label9: TLabel
      Left = 59
      Top = 90
      Width = 39
      Height = 12
      Caption = 'Version'
    end
    object NlyVerLabel: TLabel
      Left = 111
      Top = 90
      Width = 48
      Height = 12
      Caption = '1.00.0.000'
    end
    object NlyMsgLabel: TLabel
      Left = 183
      Top = 90
      Width = 79
      Height = 12
      Caption = #26356#26032#21487#33021#12391#12377#12290
    end
    object NewNameLabel: TLabel
      Left = 10
      Top = 28
      Width = 29
      Height = 12
      Caption = #65418#65438#65408'00'
    end
    object Label2: TLabel
      Left = 24
      Top = 48
      Width = 53
      Height = 12
      Caption = #12522#12522#12540#12473#26085
    end
    object NewDateLabel: TLabel
      Left = 96
      Top = 48
      Width = 60
      Height = 12
      Caption = '2024/12/31'
    end
    object Label3: TLabel
      Left = 24
      Top = 110
      Width = 53
      Height = 12
      Caption = #12522#12522#12540#12473#26085
    end
    object NlyDateLabel: TLabel
      Left = 96
      Top = 110
      Width = 60
      Height = 12
      Caption = '2024/12/31'
    end
    object UpdateNewButton: TButton
      Left = 280
      Top = 24
      Width = 121
      Height = 25
      Caption = #26368#26032#29256#12395#26356#26032
      TabOrder = 0
      OnClick = UpdateNewButtonClick
    end
    object UpdateNlyButton: TButton
      Left = 280
      Top = 86
      Width = 121
      Height = 25
      Caption = #20154#26609#29256#12395#26356#26032
      TabOrder = 1
      OnClick = UpdateNlyButtonClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 425
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
    Left = 335
    Top = 265
    Width = 98
    Height = 25
    Caption = #38281#12376#12427
    TabOrder = 4
    OnClick = CloseButtonClick
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
