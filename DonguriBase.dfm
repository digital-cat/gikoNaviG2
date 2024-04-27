object DonguriForm: TDonguriForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #12393#12435#12368#12426#12471#12473#12486#12512
  ClientHeight = 571
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottom: TPanel
    Left = 0
    Top = 507
    Width = 280
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 543
    object MsgLabel: TLabel
      Left = 4
      Top = 10
      Width = 272
      Height = 46
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 280
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object SpeedButtonTopMost: TSpeedButton
      Left = 245
      Top = 8
      Width = 23
      Height = 22
      Hint = #12454#12451#12531#12489#12454#26368#21069#38754
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      Glyph.Data = {
        76020000424D7602000000000000760000002800000040000000100000000100
        04000000000000020000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        5555555555555555555555555555555555555555555555555555555500000000
        0000555577777777777755550000000000005555000000000000555507777777
        7770555578888888888755550777777777705555077777777770555507777777
        7770555578888888888755550777777777705555077777777770000000000007
        77707777777777788887777777777777777077777777777777700FFFFFFFFF07
        777078888888887888878FFFFFFFFF7777708FFFFFFFFF7777700FFFFFFFFF07
        777078888888887888878FFFFFFFFF7777708FFFFFFFFF7777700FFFFFFFFF07
        777078888888887888878FFFFFFFFF7777708FFFFFFFFF7777700FFFFFFFFF00
        000078888888887777778FFFFFFFFF7444448FFFFFFFFF7444440FFFFFFFFF00
        000078888888887777778FFFFFFFFF7444448FFFFFFFFF7444440FFFFFFFFF05
        555578888888887555558FFFFFFFFF7555558FFFFFFFFF755555000000000005
        55557777777777755555CCCCCCCCCCC55555CCCCCCCCCCC55555000000000005
        55557777777777755555CCCCCCCCCCC55555CCCCCCCCCCC55555555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButtonTopMostClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 33
    Width = 280
    Height = 474
    ActivePage = TabSheetHome
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 510
    object TabSheetHome: TTabSheet
      Caption = #12507#12540#12512
      ExplicitHeight = 482
      object PanelHomeTop: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 139
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object AuthSpButton: TSpeedButton
          Left = 80
          Top = 8
          Width = 60
          Height = 25
          Caption = #20877#35469#35388
          OnClick = AuthSpButtonClick
        end
        object LoginSpButton: TSpeedButton
          Left = 142
          Top = 8
          Width = 60
          Height = 25
          Caption = #12525#12464#12452#12531
          OnClick = LoginSpButtonClick
        end
        object LogoutSpButton: TSpeedButton
          Left = 204
          Top = 8
          Width = 60
          Height = 25
          Caption = #12525#12464#12450#12454#12488
          OnClick = LogoutSpButtonClick
        end
        object Label1: TLabel
          Left = 12
          Top = 53
          Width = 70
          Height = 13
          Caption = #12518#12540#12470#12540#31278#21029#65306
        end
        object LabelUserType: TLabel
          Left = 96
          Top = 53
          Width = 36
          Height = 13
          Caption = #35686#20633#21729
        end
        object Label2: TLabel
          Left = 12
          Top = 75
          Width = 40
          Height = 13
          Caption = #21628#12403#21517#65306
        end
        object LabelID: TLabel
          Left = 12
          Top = 96
          Width = 53
          Height = 13
          Caption = #35686#20633#21729'ID'#65306
        end
        object Label3: TLabel
          Left = 12
          Top = 117
          Width = 35
          Height = 13
          Caption = #12524#12505#12523#65306
        end
        object LabelPeriod: TLabel
          Left = 183
          Top = 39
          Width = 81
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #31532' 100 '#26399
        end
        object Label4: TLabel
          Left = 154
          Top = 117
          Width = 12
          Height = 13
          Caption = 'K'#65306
        end
        object Label5: TLabel
          Left = 218
          Top = 117
          Width = 13
          Height = 13
          Caption = 'D'#65306
        end
        object LabelD: TLabel
          Left = 234
          Top = 117
          Width = 24
          Height = 13
          Caption = '1234'
        end
        object LabelK: TLabel
          Left = 170
          Top = 117
          Width = 36
          Height = 13
          Caption = '123456'
        end
        object LabelLevel: TLabel
          Left = 54
          Top = 117
          Width = 86
          Height = 13
          Caption = '12345 ('#21069' 12345)'
        end
        object RootSpButton: TSpeedButton
          Left = 12
          Top = 8
          Width = 60
          Height = 25
          Caption = #20877#34920#31034
          OnClick = RootSpButtonClick
        end
        object EditName: TEdit
          Left = 98
          Top = 72
          Width = 166
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
        end
        object EditID: TEdit
          Left = 98
          Top = 93
          Width = 166
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 1
        end
      end
      object InfoGrid: TStringGrid
        Left = 0
        Top = 139
        Width = 272
        Height = 237
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        ColCount = 2
        DefaultColWidth = 100
        DefaultRowHeight = 18
        FixedCols = 0
        RowCount = 12
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
        TabOrder = 1
        ExplicitTop = 113
        ExplicitHeight = 256
      end
      object PanelHome: TPanel
        Left = 0
        Top = 376
        Width = 272
        Height = 70
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitTop = 424
        object ExplorSpButton: TSpeedButton
          Left = 12
          Top = 8
          Width = 80
          Height = 25
          Caption = #25506#26908
          OnClick = ExplorSpButtonClick
        end
        object MiningSpButton: TSpeedButton
          Left = 98
          Top = 8
          Width = 80
          Height = 25
          Caption = #25505#25496
          OnClick = MiningSpButtonClick
        end
        object WoodctSpButton: TSpeedButton
          Left = 184
          Top = 8
          Width = 80
          Height = 25
          Caption = #26408#12371#12426
          OnClick = WoodctSpButtonClick
        end
        object WeaponSpButton: TSpeedButton
          Left = 12
          Top = 36
          Width = 80
          Height = 25
          Caption = #27494#22120#35069#20316
          OnClick = WeaponSpButtonClick
        end
        object ArmorcSpButton: TSpeedButton
          Left = 98
          Top = 36
          Width = 80
          Height = 25
          Caption = #38450#20855#35069#20316
          OnClick = ArmorcSpButtonClick
        end
      end
    end
    object TabSheetHunter: TTabSheet
      Caption = #12495#12531#12479#12540#12469#12540#12499#12473
      ImageIndex = 1
      ExplicitHeight = 482
      object PanelHunterTop: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ResurrectSpButton: TSpeedButton
          Left = 12
          Top = 12
          Width = 80
          Height = 25
          Caption = #12524#12505#12523#24489#27963
          OnClick = ResurrectSpButtonClick
        end
      end
      object PageControlHunter: TPageControl
        Left = 0
        Top = 48
        Width = 272
        Height = 398
        ActivePage = TabSheetRename
        Align = alClient
        MultiLine = True
        TabOrder = 1
        ExplicitHeight = 434
        object TabSheetRename: TTabSheet
          Caption = #21628#12403#21517#22793#26356#12539#12489#12531#12464#12522#36578#36865
          ExplicitHeight = 388
          object RenameButton: TButton
            Left = 12
            Top = 12
            Width = 80
            Height = 25
            Caption = #21628#12403#21517#22793#26356
            Enabled = False
            TabOrder = 0
            OnClick = RenameButtonClick
          end
          object TransferButton: TButton
            Left = 12
            Top = 100
            Width = 80
            Height = 25
            Caption = #12393#12435#12368#12426#36578#36865
            Enabled = False
            TabOrder = 1
            OnClick = TransferButtonClick
          end
        end
        object TabSheetCraft: TTabSheet
          Caption = #24037#20316#12475#12531#12479#12540
          ImageIndex = 2
          ExplicitHeight = 388
          object CraftButton: TButton
            Left = 12
            Top = 12
            Width = 80
            Height = 25
            Caption = #24037#20316#12475#12531#12479#12540
            Enabled = False
            TabOrder = 0
            OnClick = CraftButtonClick
          end
        end
        object TabSheetChest: TTabSheet
          Caption = #12450#12452#12486#12512#12496#12483#12464
          ImageIndex = 3
          ExplicitHeight = 388
          object ChestSpButton: TSpeedButton
            Left = 140
            Top = 12
            Width = 101
            Height = 25
            Caption = #23453#31665#12434#38283#12369#12427
            Enabled = False
          end
          object BagSpButton: TSpeedButton
            Left = 12
            Top = 12
            Width = 100
            Height = 25
            Caption = #12450#12452#12486#12512#12496#12483#12464
            Enabled = False
          end
        end
      end
    end
    object TabSheetSetting: TTabSheet
      Caption = #35373#23450
      ImageIndex = 2
      ExplicitHeight = 482
    end
  end
  object TimerInit: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerInitTimer
    Left = 328
    Top = 24
  end
end
