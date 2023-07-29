object UpdateCheckForm: TUpdateCheckForm
  Left = 331
  Top = 160
  Caption = #26356#26032#12481#12455#12483#12463
  ClientHeight = 208
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 41
    Align = alTop
    TabOrder = 0
    object UpdateButton: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = #23455#34892
      TabOrder = 0
      OnClick = UpdateButtonClick
    end
    object NightBuildCheckButton: TButton
      Left = 368
      Top = 8
      Width = 107
      Height = 25
      Caption = #20154#26609#29256#26356#26032
      TabOrder = 1
      OnClick = NightBuildCheckButtonClick
    end
    object CancelBitBtn: TBitBtn
      Left = 96
      Top = 8
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 476
    Height = 167
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object ResultMemo: TMemo
      Left = 1
      Top = 1
      Width = 474
      Height = 165
      Align = alClient
      Lines.Strings = (
        'ResultMemo')
      TabOrder = 0
    end
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
