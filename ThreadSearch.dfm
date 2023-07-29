object ThreadSrch: TThreadSrch
  Left = 192
  Top = 133
  Caption = #65298#12385#12419#12435#12397#12427#12473#12524#12479#12452#26908#32034
  ClientHeight = 511
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 0
    Top = 428
    Width = 510
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 429
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 510
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 0
      Top = 405
      Width = 510
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 406
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 510
      Height = 132
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 70
        Height = 12
        Caption = #12461#12540#12527#12540#12489'(&K)'
        FocusControl = CmbKW
      end
      object Label2: TLabel
        Left = 104
        Top = 44
        Width = 24
        Height = 12
        Caption = #26368#22823
      end
      object Label3: TLabel
        Left = 192
        Top = 44
        Width = 36
        Height = 12
        Caption = #20214#34920#31034
      end
      object Label4: TLabel
        Left = 304
        Top = 44
        Width = 81
        Height = 12
        Caption = #12524#12473#26410#28288#38750#34920#31034
      end
      object Label5: TLabel
        Left = 332
        Top = 116
        Width = 69
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Powerd by'
      end
      object LblSite: TLabel
        Left = 406
        Top = 116
        Width = 93
        Height = 12
        Cursor = crHandPoint
        Caption = 'http://dig.2ch.net/'
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = LblSiteClick
      end
      object BtnSearch: TButton
        Left = 420
        Top = 8
        Width = 75
        Height = 25
        Caption = #26908#32034'(&S)'
        Default = True
        TabOrder = 1
        OnClick = BtnSearchClick
      end
      object CmbType: TComboBox
        Left = 8
        Top = 40
        Width = 81
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 2
        Text = 'AND'#26908#32034
        Items.Strings = (
          'AND'#26908#32034
          'OR'#26908#32034)
      end
      object CmbMax: TComboBox
        Left = 132
        Top = 40
        Width = 57
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 3
        TabOrder = 3
        Text = '100'
        Items.Strings = (
          '1'
          '5'
          '50'
          '100'
          '200'
          '300'
          '500')
      end
      object CmbLim: TComboBox
        Left = 244
        Top = 40
        Width = 57
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 4
        Text = '1'
        Items.Strings = (
          '1'
          '5'
          '50'
          '100'
          '200'
          '300'
          '500'
          '1000')
      end
      object CmbSort: TComboBox
        Left = 400
        Top = 40
        Width = 97
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 5
        TabOrder = 5
        Text = #26368#26032#25237#31295#38918
        Items.Strings = (
          #20154#27671#26495#38918
          #21218#12356#38918
          #12524#12473#25968#38918
          #26368#26032#12473#12524#38918
          #26368#21476#12473#12524#38918
          #26368#26032#25237#31295#38918)
      end
      object CmbBoard: TComboBox
        Left = 8
        Top = 68
        Width = 113
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 6
        Text = #20840#12390#12398#26495
        Items.Strings = (
          #20840#12390#12398#26495
          #36895#65291
          #33464#65291
          #65291#20840#37096
          #23455#27841#20840#37096
          #12466#12540#12512'G'
          #33464#33021#12539#12486#12524#12499'G'
          #12469#12502#12459#12523'G'
          #37326#29699'G'
          #12469#12483#12459#12540'G'
          'PC'#38306#20418'G'
          #23398#21839#12539#25991#21270'G'
          #22899#24615#21521#12369'G'
          #22269#38555'G'
          #22269#38555#12539#26481#20124'G'
          #26997#26481'G'
          #36939#21942'G'
          'bbspink'#39894
          #29436#12290
          #23244#20786)
      end
      object Cmb924: TComboBox
        Left = 8
        Top = 96
        Width = 89
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 1
        TabOrder = 11
        Text = '924'#12434#20986#12377
        Items.Strings = (
          '924'#12434#28040#12377
          '924'#12434#20986#12377)
      end
      object ChkTop: TCheckBox
        Left = 324
        Top = 96
        Width = 185
        Height = 17
        Caption = #12371#12398#12454#12451#12531#12489#12454#12434#21069#38754#12395#34920#31034'(T)'
        TabOrder = 13
        OnClick = ChkTopClick
      end
      object CmbKW: TComboBox
        Left = 88
        Top = 12
        Width = 329
        Height = 20
        ItemHeight = 12
        TabOrder = 0
      end
      object ChkBbs: TCheckBox
        Left = 128
        Top = 70
        Width = 57
        Height = 17
        Caption = #26495#25351#23450
        TabOrder = 7
        OnClick = ChkBbsClick
      end
      object PnlBbsName: TPanel
        Left = 188
        Top = 68
        Width = 181
        Height = 20
        Alignment = taLeftJustify
        BevelOuter = bvLowered
        TabOrder = 8
      end
      object PnlBbsId: TPanel
        Left = 370
        Top = 68
        Width = 100
        Height = 20
        Alignment = taLeftJustify
        BevelOuter = bvLowered
        TabOrder = 9
      end
      object BtnBbs: TButton
        Left = 472
        Top = 64
        Width = 23
        Height = 25
        Caption = #26495
        Enabled = False
        TabOrder = 10
        OnClick = BtnBbsClick
      end
      object ChkNG: TCheckBox
        Left = 112
        Top = 96
        Width = 137
        Height = 17
        Caption = #12473#12524#12479#12452'NG'#12434#26377#21177'(&N)'
        TabOrder = 12
      end
    end
    object ResultList: TListView
      Left = 0
      Top = 132
      Width = 510
      Height = 273
      Align = alClient
      Columns = <
        item
          Caption = #26495#21517
          Width = 80
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
          Caption = 'URL'
          Width = 500
        end>
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu
      TabOrder = 1
      ViewStyle = vsReport
      OnDblClick = ResultListDblClick
    end
    object MessageList: TListBox
      Left = 0
      Top = 408
      Width = 510
      Height = 20
      Align = alBottom
      ExtendedSelect = False
      ItemHeight = 12
      TabOrder = 2
    end
  end
  object CmBrowser: TWebBrowser
    Left = 0
    Top = 431
    Width = 510
    Height = 80
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 432
    ControlData = {
      4C000000B6340000450800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Indy: TIdHTTP
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
  object PopMenuBbs: TPopupMenu
    Left = 184
    Top = 256
  end
end
