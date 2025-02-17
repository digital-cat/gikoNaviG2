object ThreadSrch: TThreadSrch
  Left = 192
  Top = 133
  Caption = #65301#12385#12419#12435#12397#12427#12473#12524#12479#12452#26908#32034
  ClientHeight = 511
  ClientWidth = 513
  Color = clBtnFace
  Constraints.MinHeight = 500
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 513
    Height = 511
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 0
      Top = 490
      Width = 513
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 250
      ExplicitWidth = 238
    end
    object PanelHead: TPanel
      Left = 0
      Top = 0
      Width = 513
      Height = 250
      Align = alTop
      BevelOuter = bvNone
      Constraints.MinWidth = 510
      TabOrder = 0
      ExplicitWidth = 510
      object Label1: TLabel
        Left = 8
        Top = 21
        Width = 70
        Height = 12
        Caption = #12461#12540#12527#12540#12489'(&K)'
      end
      object BtnSearch: TButton
        Left = 420
        Top = 37
        Width = 75
        Height = 25
        Caption = #26908#32034'(&S)'
        Default = True
        TabOrder = 1
        OnClick = BtnSearchClick
      end
      object ChkTop: TCheckBox
        Left = 324
        Top = 6
        Width = 185
        Height = 17
        Caption = #12371#12398#12454#12451#12531#12489#12454#12434#21069#38754#12395#34920#31034'(T)'
        TabOrder = 5
        OnClick = ChkTopClick
      end
      object ChkNG: TCheckBox
        Left = 250
        Top = 79
        Width = 137
        Height = 17
        Caption = #12473#12524#12479#12452'NG'#12434#26377#21177'(&N)'
        TabOrder = 3
      end
      object RadioGroupDomain: TRadioGroup
        Left = 8
        Top = 65
        Width = 217
        Height = 39
        Caption = #26908#32034#23550#35937
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #65301#12385#12419#12435#12397#12427
          'BBSPINK')
        TabOrder = 2
      end
      object MemoHelp: TMemo
        Left = 8
        Top = 110
        Width = 487
        Height = 133
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 6
      end
      object ButtonHelp: TButton
        Left = 420
        Top = 79
        Width = 75
        Height = 25
        Caption = #9660#12504#12523#12503
        TabOrder = 4
        OnClick = ButtonHelpClick
      end
      object CmbKW: TTntComboBox
        Left = 8
        Top = 39
        Width = 406
        Height = 20
        ItemHeight = 12
        TabOrder = 0
      end
    end
    object ResultList: TTntListView
      Left = 0
      Top = 250
      Width = 513
      Height = 240
      Align = alClient
      Columns = <
        item
          Caption = #26495#21517
          Width = 100
        end
        item
          Caption = #12473#12524#12483#12489#21517
          Width = 350
        end
        item
          Alignment = taRightJustify
          Caption = #65398#65395#65437#65412
          Width = 40
        end
        item
          Alignment = taCenter
          Caption = #26368#32066#12509#12473#12488
          Width = 150
        end
        item
          Alignment = taRightJustify
          Caption = #21218#12356
          Width = 60
        end
        item
          Caption = 'URL'
          Width = 350
        end>
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu
      TabOrder = 1
      ViewStyle = vsReport
      OnColumnClick = ResultListColumnClick
      OnCompare = ResultListCompare
      OnDblClick = ResultListDblClick
      ExplicitLeft = 29
      ExplicitTop = 256
      ExplicitWidth = 306
      ExplicitHeight = 150
    end
    object MessageList: TTntListBox
      Left = 0
      Top = 493
      Width = 513
      Height = 18
      Align = alBottom
      ItemHeight = 12
      TabOrder = 2
    end
  end
  object Indy: TIdHTTP
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
    Top = 192
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 256
    Top = 168
    object MenuShowThread: TMenuItem
      Caption = #12473#12524#12483#12489#12434#34920#31034'(&S)'
      OnClick = MenuShowThreadClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuCopyURL: TMenuItem
      Caption = 'URL'#12434#12467#12500#12540'(&U)'
      OnClick = MenuCopyURLClick
    end
    object MenuCopyThread: TMenuItem
      Caption = #12473#12524#12483#12489#21517#12434#12467#12500#12540'(&T)'
      OnClick = MenuCopyThreadClick
    end
    object MenuCopyThrURL: TMenuItem
      Caption = #12473#12524#12483#12489#21517#12392'URL'#12434#12467#12500#12540'(&C)'
      OnClick = MenuCopyThrURLClick
    end
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
    Left = 304
    Top = 232
  end
end
