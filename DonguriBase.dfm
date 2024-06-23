object DonguriForm: TDonguriForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #12393#12435#12368#12426#12471#12473#12486#12512
  ClientHeight = 538
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 280
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object SpeedButtonTopMost: TSpeedButton
      Left = 245
      Top = 2
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
    Top = 28
    Width = 280
    Height = 510
    ActivePage = TabSheetModW
    Align = alClient
    TabOrder = 0
    OnDrawTab = PageControlDrawTab
    object TabSheetHome: TTabSheet
      Caption = #12507#12540#12512
      object PanelHome: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 472
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object LabelID: TLabel
          Left = 92
          Top = 75
          Width = 26
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'ID'#65306
        end
        object Label3: TLabel
          Left = 72
          Top = 94
          Width = 46
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #12524#12505#12523#65306
        end
        object LabelPeriod: TLabel
          Left = 12
          Top = 136
          Width = 54
          Height = 13
          Caption = #31532' 1000 '#26399
        end
        object Label12: TLabel
          Left = 68
          Top = 114
          Width = 50
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #32076#39443#20516#65306
        end
        object Label13: TLabel
          Left = 78
          Top = 136
          Width = 40
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #32076#36942#65306
        end
        object ExprValLabel: TLabel
          Left = 246
          Top = 114
          Width = 20
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '100'
        end
        object TimeValLabel: TLabel
          Left = 246
          Top = 136
          Width = 20
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '100'
        end
        object ExplorValLabel: TLabel
          Left = 246
          Top = 158
          Width = 20
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '100'
        end
        object MiningValLabel: TLabel
          Left = 246
          Top = 180
          Width = 20
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '100'
        end
        object WoodctValLabel: TLabel
          Left = 246
          Top = 202
          Width = 20
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '100'
        end
        object WeaponValLabel: TLabel
          Left = 246
          Top = 224
          Width = 20
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '100'
        end
        object ArmorcValLabel: TLabel
          Left = 246
          Top = 246
          Width = 20
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '100'
        end
        object Label24: TLabel
          Left = 12
          Top = 318
          Width = 36
          Height = 13
          Caption = #20445#31649#24235
        end
        object Label1: TLabel
          Left = 12
          Top = 268
          Width = 24
          Height = 13
          Caption = #32113#35336
        end
        object Label30: TLabel
          Left = 12
          Top = 58
          Width = 34
          Height = 13
          Caption = #12514#12540#12489#65306
        end
        object Label34: TLabel
          Left = 78
          Top = 56
          Width = 40
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #21517#21069#65306
        end
        object EditName: TEdit
          Left = 122
          Top = 55
          Width = 142
          Height = 17
          TabStop = False
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 0
        end
        object EditID: TEdit
          Left = 122
          Top = 74
          Width = 142
          Height = 17
          TabStop = False
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 1
        end
        object EditLevel: TEdit
          Left = 122
          Top = 93
          Width = 142
          Height = 17
          TabStop = False
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 2
        end
        object RootPnlButton: TPanel
          Left = 12
          Top = 3
          Width = 80
          Height = 47
          BevelInner = bvRaised
          Caption = #34920#31034#26356#26032
          TabOrder = 3
          OnClick = RootPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object InfoGrid: TStringGrid
          Left = 12
          Top = 332
          Width = 253
          Height = 135
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ColCount = 2
          Ctl3D = False
          DefaultColWidth = 100
          DefaultRowHeight = 16
          Enabled = False
          FixedCols = 0
          RowCount = 8
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          ParentCtl3D = False
          ScrollBars = ssNone
          TabOrder = 4
        end
        object ExplorPnlButton: TPanel
          Left = 12
          Top = 156
          Width = 70
          Height = 20
          Hint = #8217#25506#26908#8217#12434#20462#34892#12377#12427
          BevelInner = bvRaised
          Caption = #25506#26908
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = ExplorPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object MiningPnlButton: TPanel
          Left = 12
          Top = 178
          Width = 70
          Height = 20
          Hint = #8217#25505#25496#8217#12434#20462#34892#12377#12427
          BevelInner = bvRaised
          Caption = #25505#25496
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = MiningPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object WoodctPnlButton: TPanel
          Left = 12
          Top = 200
          Width = 70
          Height = 20
          Hint = #8217#26408#12371#12426#8217#12434#20462#34892#12377#12427
          BevelInner = bvRaised
          Caption = #26408#12371#12426
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = WoodctPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object WeaponPnlButton: TPanel
          Left = 12
          Top = 222
          Width = 70
          Height = 20
          Hint = #8217#27494#22120#35069#20316#8217#12434#20462#34892#12377#12427
          BevelInner = bvRaised
          Caption = #27494#22120#35069#20316
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = WeaponPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object ArmorcPnlButton: TPanel
          Left = 12
          Top = 244
          Width = 70
          Height = 20
          Hint = #8217#38450#20855#35069#20316#8217#12434#20462#34892#12377#12427
          BevelInner = bvRaised
          Caption = #38450#20855#35069#20316
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = ArmorcPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object ExprProgressBar: TProgressBar
          Left = 122
          Top = 116
          Width = 126
          Height = 10
          Smooth = True
          Step = 1
          TabOrder = 10
        end
        object TimeProgressBar: TProgressBar
          Left = 122
          Top = 138
          Width = 126
          Height = 10
          Smooth = True
          Step = 1
          TabOrder = 11
        end
        object ExplorProgressBar: TProgressBar
          Left = 122
          Top = 160
          Width = 126
          Height = 10
          Smooth = True
          Step = 1
          TabOrder = 12
        end
        object MiningProgressBar: TProgressBar
          Left = 122
          Top = 182
          Width = 126
          Height = 10
          Smooth = True
          Step = 1
          TabOrder = 13
        end
        object WoodctProgressBar: TProgressBar
          Left = 122
          Top = 204
          Width = 126
          Height = 10
          Smooth = True
          TabOrder = 14
        end
        object WeaponProgressBar: TProgressBar
          Left = 122
          Top = 226
          Width = 126
          Height = 10
          Smooth = True
          Step = 1
          TabOrder = 15
        end
        object ArmorcProgressBar: TProgressBar
          Left = 122
          Top = 248
          Width = 126
          Height = 10
          Smooth = True
          Step = 1
          TabOrder = 16
        end
        object ExplorPanel: TPanel
          Left = 82
          Top = 156
          Width = 36
          Height = 20
          Hint = #20462#34892#20013
          BevelOuter = bvLowered
          Caption = '00000'
          TabOrder = 18
        end
        object MiningPanel: TPanel
          Left = 82
          Top = 178
          Width = 36
          Height = 20
          Hint = #20462#34892#20013
          BevelOuter = bvLowered
          Caption = '00000'
          TabOrder = 20
        end
        object WoodctPanel: TPanel
          Left = 82
          Top = 200
          Width = 36
          Height = 20
          Hint = #20462#34892#20013
          BevelOuter = bvLowered
          Caption = '00000'
          TabOrder = 26
        end
        object WeaponPanel: TPanel
          Left = 82
          Top = 222
          Width = 36
          Height = 20
          Hint = #20462#34892#20013
          BevelOuter = bvLowered
          Caption = '00000'
          TabOrder = 17
        end
        object ArmorcPanel: TPanel
          Left = 82
          Top = 244
          Width = 36
          Height = 20
          Hint = #20462#34892#20013
          BevelOuter = bvLowered
          Caption = '00000'
          TabOrder = 19
        end
        object StatisticsGrid: TStringGrid
          Left = 12
          Top = 282
          Width = 253
          Height = 33
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ColCount = 2
          Ctl3D = False
          DefaultColWidth = 100
          DefaultRowHeight = 16
          Enabled = False
          FixedCols = 0
          RowCount = 2
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          ParentCtl3D = False
          ScrollBars = ssNone
          TabOrder = 21
        end
        object LoginPnlButton: TPanel
          Left = 110
          Top = 3
          Width = 76
          Height = 23
          BevelInner = bvRaised
          Caption = #12525#12464#12452#12531
          TabOrder = 22
          OnClick = LoginPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object LogoutPnlButton: TPanel
          Left = 110
          Top = 27
          Width = 76
          Height = 23
          BevelInner = bvRaised
          Caption = #12525#12464#12450#12454#12488
          TabOrder = 23
          OnClick = LogoutPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object AuthPnlButton: TPanel
          Left = 188
          Top = 3
          Width = 76
          Height = 23
          BevelInner = bvRaised
          Caption = #20877#35469#35388
          TabOrder = 24
          OnClick = AuthPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object NewRegPnlButton: TPanel
          Left = 188
          Top = 27
          Width = 76
          Height = 23
          Hint = #35686#20633#21729#12450#12459#12454#12531#12488#12434#12513#12540#12523#35469#35388#12395#30331#37682#12377#12427
          BevelInner = bvRaised
          Caption = #35686#20633#21729#30331#37682
          ParentShowHint = False
          ShowHint = True
          TabOrder = 25
          OnClick = NewRegPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object ModePanel: TPanel
          Left = 12
          Top = 74
          Width = 60
          Height = 17
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Color = clWindow
          ParentBackground = False
          TabOrder = 27
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 472
        Width = 272
        Height = 10
        Align = alClient
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 1
      end
    end
    object TabSheetService: TTabSheet
      Caption = #12469#12540#12499#12473
      ImageIndex = 1
      object PanelService: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 472
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ResurrectPnlButton: TPanel
          Left = 12
          Top = 12
          Width = 100
          Height = 25
          BevelInner = bvRaised
          Caption = #12524#12505#12523#24489#27963
          TabOrder = 0
          OnClick = ResurrectPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object CraftKYGroupBox: TGroupBox
          Left = 12
          Top = 42
          Width = 250
          Height = 85
          Caption = #37444#12398#12461#12540#20316#25104
          TabOrder = 1
          object Label14: TLabel
            Left = 16
            Top = 24
            Width = 52
            Height = 13
            Caption = #20316#25104#25968'(&M)'
            FocusControl = KYAmountComboBox
          end
          object Label15: TLabel
            Left = 150
            Top = 24
            Width = 40
            Height = 13
            Caption = #37444#12398#37327#65306
          end
          object KYIronLabel: TLabel
            Left = 192
            Top = 24
            Width = 6
            Height = 13
            Caption = '0'
          end
          object Label4: TLabel
            Left = 16
            Top = 56
            Width = 87
            Height = 13
            Caption = '1'#20491#24403#12383#12426#37444#12398#37327#65306
          end
          object KYCostLabel: TLabel
            Left = 106
            Top = 56
            Width = 12
            Height = 13
            Caption = '15'
          end
          object KYAmountComboBox: TComboBox
            Left = 76
            Top = 20
            Width = 60
            Height = 21
            ImeMode = imClose
            ItemHeight = 13
            TabOrder = 0
            OnChange = KYAmountComboBoxChange
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '10'
              '15'
              '20'
              '30')
          end
          object CraftKYPnlButton: TPanel
            Left = 150
            Top = 47
            Width = 83
            Height = 25
            BevelInner = bvRaised
            Caption = #20316#25104
            TabOrder = 1
            OnClick = CraftKYPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
        end
        object CraftCBGroupBox: TGroupBox
          Left = 12
          Top = 134
          Width = 250
          Height = 85
          Caption = #37444#12398#22823#30770#12398#29577#20316#25104
          TabOrder = 2
          object Label6: TLabel
            Left = 16
            Top = 24
            Width = 51
            Height = 13
            Caption = #20316#25104#25968'(&A)'
            FocusControl = CBAmountComboBox
          end
          object Label7: TLabel
            Left = 150
            Top = 24
            Width = 40
            Height = 13
            Caption = #37444#12398#37327#65306
          end
          object CBIronLabel: TLabel
            Left = 192
            Top = 24
            Width = 6
            Height = 13
            Caption = '0'
          end
          object Label5: TLabel
            Left = 16
            Top = 56
            Width = 87
            Height = 13
            Caption = '1'#20491#24403#12383#12426#37444#12398#37327#65306
          end
          object CBCostLabel: TLabel
            Left = 106
            Top = 56
            Width = 18
            Height = 13
            Caption = '100'
          end
          object CBAmountComboBox: TComboBox
            Left = 76
            Top = 20
            Width = 60
            Height = 21
            ImeMode = imClose
            ItemHeight = 13
            MaxLength = 4
            TabOrder = 0
            OnChange = CBAmountComboBoxChange
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '10'
              '15'
              '20'
              '30')
          end
          object CraftCBPnlButton: TPanel
            Left = 150
            Top = 47
            Width = 83
            Height = 25
            BevelInner = bvRaised
            Caption = #20316#25104
            TabOrder = 1
            OnClick = CraftCBPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
        end
        object RenameGroupBox: TGroupBox
          Left = 12
          Top = 225
          Width = 250
          Height = 107
          Caption = #12495#12531#12479#12540#12493#12540#12512#22793#26356
          TabOrder = 3
          object Label16: TLabel
            Left = 16
            Top = 24
            Width = 113
            Height = 13
            Caption = #26032#12375#12356#12495#12531#12479#12540#12493#12540#12512'(&N)'
            FocusControl = NewNameEdit
          end
          object Label17: TLabel
            Left = 16
            Top = 78
            Width = 42
            Height = 13
            Caption = #25163#25968#26009#65306
          end
          object RNCostLabel: TLabel
            Left = 60
            Top = 78
            Width = 66
            Height = 13
            Caption = '0.001 '#12393#12435#12368#12426
          end
          object RenamePnlButton: TPanel
            Left = 150
            Top = 69
            Width = 83
            Height = 25
            BevelInner = bvRaised
            Caption = #22793#26356
            TabOrder = 0
            OnClick = RenamePnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object NewNameEdit: TEdit
            Left = 16
            Top = 42
            Width = 217
            Height = 21
            TabOrder = 1
          end
        end
        object TransferGroupBox: TGroupBox
          Left = 12
          Top = 339
          Width = 250
          Height = 110
          Caption = #12393#12435#12368#12426#36578#36865
          TabOrder = 4
          object Label2: TLabel
            Left = 16
            Top = 24
            Width = 62
            Height = 13
            Caption = #21463#21462#20154'ID(&R)'
            FocusControl = RIDEdit
          end
          object Label10: TLabel
            Left = 16
            Top = 48
            Width = 85
            Height = 13
            Caption = #36578#36865#12393#12435#12368#12426#38989'(&T)'
            FocusControl = TAmountEdit
          end
          object Label11: TLabel
            Left = 16
            Top = 80
            Width = 42
            Height = 13
            Caption = #25163#25968#26009#65306
          end
          object TRCostLabel: TLabel
            Left = 60
            Top = 80
            Width = 66
            Height = 13
            Caption = '0.001 '#12393#12435#12368#12426
          end
          object TransferPnlButton: TPanel
            Left = 142
            Top = 71
            Width = 91
            Height = 25
            BevelInner = bvRaised
            Caption = #12393#12435#12368#12426#36578#36865
            TabOrder = 0
            OnClick = TransferPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object RIDEdit: TEdit
            Left = 110
            Top = 20
            Width = 85
            Height = 21
            Hint = #12495#12531#12479#12540'ID'#12414#12383#12399#35686#20633#21729'ID'
            ImeMode = imDisable
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
          end
          object TAmountEdit: TEdit
            Left = 110
            Top = 44
            Width = 85
            Height = 21
            Hint = #23567#25968#28857#25968#12391#25351#23450#65288#12393#12435#12368#12426#27531#39640#12398#31684#22258#20869#65289
            ImeMode = imDisable
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
          end
        end
        object CraftPnlButton: TPanel
          Left = 144
          Top = 12
          Width = 118
          Height = 25
          Hint = #12469#12540#12499#12473#12395#24517#35201#12394#37444#12398#37327#12420#12393#12435#12368#12426#12434#21462#24471#12377#12427
          BevelInner = bvRaised
          Caption = #12469#12540#12499#12473#12467#12473#12488#30906#35469
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = CraftPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 472
        Width = 272
        Height = 10
        Align = alClient
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 1
      end
    end
    object TabSheetChest: TTabSheet
      Caption = #12450#12452#12486#12512
      ImageIndex = 2
      object BagTopPanel: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 126
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label9: TLabel
          Left = 12
          Top = 73
          Width = 51
          Height = 13
          Caption = #12473#12525#12483#12488#25968#65306
        end
        object SlotLabel: TLabel
          Left = 76
          Top = 73
          Width = 22
          Height = 13
          Caption = '0 / 0'
        end
        object BagPnlButton: TPanel
          Left = 12
          Top = 6
          Width = 240
          Height = 25
          BevelInner = bvRaised
          Caption = #12450#12452#12486#12512#12496#12483#12464#34920#31034#26356#26032
          TabOrder = 0
          OnClick = BagPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object ChestPnlButton: TPanel
          Left = 12
          Top = 36
          Width = 102
          Height = 25
          Hint = #37444#12398#12461#12540'10'#12391#27494#22120'2'#12539#38450#20855'2'#12434#21462#24471
          BevelInner = bvRaised
          Caption = #23453#31665#12434#38283#12369#12427
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = ChestPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object SlotPnlButton: TPanel
          Left = 162
          Top = 66
          Width = 90
          Height = 25
          Hint = #26408#26448'1000'#12391#12473#12525#12483#12488'10'#12434#21462#24471
          BevelInner = bvRaised
          Caption = #12473#12525#12483#12488#36861#21152
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = SlotPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object RecycleAllPnlButton: TPanel
          Left = 12
          Top = 96
          Width = 240
          Height = 25
          BevelInner = bvRaised
          Caption = #12525#12483#12463#12373#12428#12390#12356#12394#12356#35013#20633#12434#12377#12409#12390#35299#20307
          TabOrder = 3
          OnClick = RecycleAllPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object ChestB70PnlButton: TPanel
          Left = 120
          Top = 36
          Width = 132
          Height = 25
          Hint = #37444#12398#12461#12540'100'#12391#27494#22120'20'#12539#38450#20855'20'#12434#21462#24471
          BevelInner = bvRaised
          Caption = #22823#22411#12398#23453#31665#12434#38283#12369#12427
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = ChestB70PnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
      end
      object PageControlItemBag: TPageControl
        Left = 0
        Top = 126
        Width = 272
        Height = 356
        ActivePage = TabSheetUsing
        Align = alClient
        TabOrder = 1
        OnDrawTab = PageControlItemBagDrawTab
        object TabSheetUsing: TTabSheet
          Caption = #35013#20633#20013
          object UsingPanel: TPanel
            Left = 0
            Top = 0
            Width = 264
            Height = 322
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object UsingWeaponLabel: TLabel
              Left = 8
              Top = 7
              Width = 24
              Height = 13
              Caption = #27494#22120
            end
            object UsingArmorLabel: TLabel
              Left = 8
              Top = 145
              Width = 24
              Height = 13
              Caption = #38450#20855
            end
            object RemWeaponPnlButton: TPanel
              Left = 48
              Top = 2
              Width = 60
              Height = 22
              Hint = #27494#22120#12398#35013#20633#12434#12420#12417#12427
              BevelInner = bvRaised
              Caption = #22806#12377
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = RemWeaponPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object RemArmorPnlButton: TPanel
              Left = 48
              Top = 140
              Width = 60
              Height = 22
              Hint = #38450#20855#12398#35013#20633#12434#12420#12417#12427
              BevelInner = bvRaised
              Caption = #22806#12377
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = RemArmorPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object GridWeaponUsing1: TStringGrid
              Left = 8
              Top = 26
              Width = 250
              Height = 35
              BevelInner = bvNone
              BevelOuter = bvNone
              ColCount = 3
              Ctl3D = False
              DefaultColWidth = 83
              DefaultRowHeight = 16
              DefaultDrawing = False
              Enabled = False
              FixedCols = 0
              RowCount = 2
              FixedRows = 0
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 2
              OnDrawCell = DrawGridCell
            end
            object GridWeaponUsing2: TStringGrid
              Left = 8
              Top = 60
              Width = 250
              Height = 35
              BevelInner = bvNone
              BevelOuter = bvNone
              ColCount = 3
              Ctl3D = False
              DefaultColWidth = 83
              DefaultRowHeight = 16
              DefaultDrawing = False
              Enabled = False
              FixedCols = 0
              RowCount = 2
              FixedRows = 0
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 3
              OnDrawCell = DrawGridCell
            end
            object GridWeaponUsing3: TStringGrid
              Left = 8
              Top = 94
              Width = 250
              Height = 35
              BevelInner = bvNone
              BevelOuter = bvNone
              ColCount = 3
              Ctl3D = False
              DefaultColWidth = 83
              DefaultRowHeight = 16
              DefaultDrawing = False
              Enabled = False
              FixedCols = 0
              RowCount = 2
              FixedRows = 0
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 4
              OnDrawCell = DrawGridCell
            end
            object GridArmorUsing3: TStringGrid
              Left = 8
              Top = 232
              Width = 250
              Height = 35
              BevelInner = bvNone
              BevelOuter = bvNone
              ColCount = 3
              Ctl3D = False
              DefaultColWidth = 83
              DefaultRowHeight = 16
              DefaultDrawing = False
              Enabled = False
              FixedCols = 0
              RowCount = 2
              FixedRows = 0
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 5
              OnDrawCell = DrawGridCell
            end
            object GridArmorUsing2: TStringGrid
              Left = 8
              Top = 198
              Width = 250
              Height = 35
              BevelInner = bvNone
              BevelOuter = bvNone
              ColCount = 3
              Ctl3D = False
              DefaultColWidth = 83
              DefaultRowHeight = 16
              DefaultDrawing = False
              Enabled = False
              FixedCols = 0
              RowCount = 2
              FixedRows = 0
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 6
              OnDrawCell = DrawGridCell
            end
            object GridArmorUsing1: TStringGrid
              Left = 8
              Top = 164
              Width = 250
              Height = 35
              BevelInner = bvNone
              BevelOuter = bvNone
              ColCount = 3
              Ctl3D = False
              DefaultColWidth = 83
              DefaultRowHeight = 16
              DefaultDrawing = False
              Enabled = False
              FixedCols = 0
              RowCount = 2
              FixedRows = 0
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 7
              OnDrawCell = DrawGridCell
            end
            object ModUseWPnlButton: TPanel
              Left = 114
              Top = 2
              Width = 60
              Height = 22
              Hint = #27494#22120#12434#24375#21270#12377#12427
              BevelInner = bvRaised
              Caption = #24375#21270
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 8
              OnClick = ModUseWPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object ModUseAPnlButton: TPanel
              Left = 114
              Top = 140
              Width = 60
              Height = 22
              Hint = #27494#22120#12434#24375#21270#12377#12427
              BevelInner = bvRaised
              Caption = #24375#21270
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 9
              OnClick = ModUseAPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 322
            Width = 264
            Height = 6
            Align = alClient
            BevelOuter = bvLowered
            ParentColor = True
            TabOrder = 1
          end
        end
        object TabSheetWeapon: TTabSheet
          Caption = #27494#22120
          ImageIndex = 1
          object WeaponTopPanel: TPanel
            Left = 0
            Top = 0
            Width = 264
            Height = 30
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object WeaponAllCheckBox: TCheckBox
              Left = 4
              Top = 12
              Width = 18
              Height = 17
              Hint = #20840#34892#12398#12481#12455#12483#12463'ON'#65295'OFF'
              TabStop = False
              Caption = #12288
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = WeaponAllCheckBoxClick
            end
            object RecycleWPnlButton: TPanel
              Left = 132
              Top = 4
              Width = 44
              Height = 22
              Hint = #12481#12455#12483#12463#12375#12383#27494#22120#12434#20998#35299#12377#12427
              BevelInner = bvRaised
              Caption = #20998#35299
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = RecycleWPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object UnlockWPnlButton: TPanel
              Left = 70
              Top = 4
              Width = 60
              Height = 22
              Hint = #12481#12455#12483#12463#12375#12383#27494#22120#12398#12525#12483#12463#12434#35299#38500#12377#12427
              BevelInner = bvRaised
              Caption = #12450#12531#12525#12483#12463
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = UnlockWPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object LockWPnlButton: TPanel
              Left = 24
              Top = 4
              Width = 44
              Height = 22
              Hint = #12481#12455#12483#12463#12375#12383#27494#22120#12434#12525#12483#12463#12377#12427
              BevelInner = bvRaised
              Caption = #12525#12483#12463
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = LockWPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object UseWPnlButton: TPanel
              Left = 178
              Top = 4
              Width = 44
              Height = 22
              Hint = #12481#12455#12483#12463#12375#12383#27494#22120#12434#35013#20633#12377#12427
              BevelInner = bvRaised
              Caption = #35013#20633
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = UseWPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object ModWPnlButton: TPanel
              Left = 224
              Top = 4
              Width = 44
              Height = 22
              BevelInner = bvRaised
              Caption = #24375#21270
              Enabled = False
              TabOrder = 5
              OnClick = ModWPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
          end
          object ListViewWeapon: TListView
            Left = 0
            Top = 30
            Width = 264
            Height = 298
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            Checkboxes = True
            Columns = <
              item
                Caption = #65435#65391#65400#29366#24907
                Width = 60
              end
              item
                Alignment = taCenter
                Caption = #65434#65393#65432#65411#65384
                Width = 36
              end
              item
                Caption = #21517#31216
                Width = 100
              end
              item
                Alignment = taCenter
                Caption = 'ATK'
              end
              item
                Alignment = taRightJustify
                Caption = 'SPD'
                Width = 36
              end
              item
                Alignment = taRightJustify
                Caption = 'CRIT'
                Width = 40
              end
              item
                Caption = 'ELEM'
              end
              item
                Alignment = taRightJustify
                Caption = 'MOD'
                Width = 30
              end
              item
                Alignment = taRightJustify
                Caption = #12510#12522#12514
              end>
            Ctl3D = False
            FlatScrollBars = True
            MultiSelect = True
            ReadOnly = True
            RowSelect = True
            SmallImages = BagImageList
            SortType = stData
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = ListViewWeaponChange
            OnColumnClick = ListViewWeaponColumnClick
            OnCompare = ListViewWeaponCompare
          end
        end
        object TabSheetArmor: TTabSheet
          Caption = #38450#20855
          ImageIndex = 2
          object ArmorTopPanel: TPanel
            Left = 0
            Top = 0
            Width = 264
            Height = 30
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object ArmorAllCheckBox: TCheckBox
              Left = 4
              Top = 12
              Width = 18
              Height = 17
              Hint = #20840#34892#12398#12481#12455#12483#12463'ON'#65295'OFF'
              TabStop = False
              Caption = #12288
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = ArmorAllCheckBoxClick
            end
            object LockAPnlButton: TPanel
              Left = 24
              Top = 4
              Width = 44
              Height = 22
              Hint = #12481#12455#12483#12463#12375#12383#38450#20855#12434#12525#12483#12463#12377#12427
              BevelInner = bvRaised
              Caption = #12525#12483#12463
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = LockAPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object UnlockAPnlButton: TPanel
              Left = 70
              Top = 4
              Width = 60
              Height = 22
              Hint = #12481#12455#12483#12463#12375#12383#38450#20855#12398#12525#12483#12463#12434#35299#38500#12377#12427
              BevelInner = bvRaised
              Caption = #12450#12531#12525#12483#12463
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = UnlockAPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object RecycleAPnlButton: TPanel
              Left = 132
              Top = 4
              Width = 44
              Height = 22
              Hint = #12481#12455#12483#12463#12375#12383#38450#20855#12434#20998#35299#12377#12427
              BevelInner = bvRaised
              Caption = #20998#35299
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = RecycleAPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object UseAPnlButton: TPanel
              Left = 178
              Top = 4
              Width = 44
              Height = 22
              Hint = #12481#12455#12483#12463#12375#12383#38450#20855#12434#35013#20633#12377#12427
              BevelInner = bvRaised
              Caption = #35013#20633
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = UseAPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object ModAPnlButton: TPanel
              Left = 224
              Top = 4
              Width = 44
              Height = 22
              BevelInner = bvRaised
              Caption = #24375#21270
              Enabled = False
              TabOrder = 5
              OnClick = ModAPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
          end
          object ListViewArmor: TListView
            Left = 0
            Top = 30
            Width = 264
            Height = 298
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            Checkboxes = True
            Columns = <
              item
                Caption = #65435#65391#65400#29366#24907
                Width = 60
              end
              item
                Alignment = taCenter
                Caption = #65434#65393#65432#65411#65384
                Width = 36
              end
              item
                Caption = #21517#31216
                Width = 100
              end
              item
                Alignment = taCenter
                Caption = 'DEF'
              end
              item
                Alignment = taRightJustify
                Caption = 'WT.'
                Width = 36
              end
              item
                Alignment = taRightJustify
                Caption = 'CRIT'
                Width = 40
              end
              item
                Caption = 'ELEM'
              end
              item
                Alignment = taRightJustify
                Caption = 'MOD'
                Width = 30
              end
              item
                Alignment = taRightJustify
                Caption = #12510#12522#12514
              end>
            Ctl3D = False
            FlatScrollBars = True
            MultiSelect = True
            ReadOnly = True
            RowSelect = True
            SmallImages = BagImageList
            SortType = stData
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = ListViewArmorChange
            OnColumnClick = ListViewArmorColumnClick
            OnCompare = ListViewArmorCompare
          end
        end
      end
    end
    object TabSheetModW: TTabSheet
      Caption = #27494#22120#24375#21270
      ImageIndex = 5
      object ModWPanel: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 482
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object ModWBasePanel: TPanel
          Left = 0
          Top = 0
          Width = 272
          Height = 472
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label59: TLabel
            Left = 8
            Top = 7
            Width = 55
            Height = 13
            Caption = #20445#26377#12510#12522#12514#65306
          end
          object ModWImage: TImage
            Left = 8
            Top = 29
            Width = 78
            Height = 76
            Center = True
            Proportional = True
            Stretch = True
          end
          object Label46: TLabel
            Left = 8
            Top = 184
            Width = 70
            Height = 13
            Caption = 'DMG'#65288#26368#23567#20516#65289
          end
          object Label47: TLabel
            Left = 60
            Top = 202
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label48: TLabel
            Left = 134
            Top = 184
            Width = 49
            Height = 13
            Caption = #12510#12522#12514#28040#36027
          end
          object Label49: TLabel
            Left = 8
            Top = 246
            Width = 70
            Height = 13
            Caption = 'DMG'#65288#26368#22823#20516#65289
          end
          object Label50: TLabel
            Left = 60
            Top = 264
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label51: TLabel
            Left = 134
            Top = 246
            Width = 49
            Height = 13
            Caption = #12510#12522#12514#28040#36027
          end
          object Label52: TLabel
            Left = 8
            Top = 308
            Width = 19
            Height = 13
            Caption = 'SPD'
          end
          object Label53: TLabel
            Left = 60
            Top = 326
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label54: TLabel
            Left = 134
            Top = 308
            Width = 49
            Height = 13
            Caption = #12510#12522#12514#28040#36027
          end
          object Label55: TLabel
            Left = 8
            Top = 370
            Width = 24
            Height = 13
            Caption = 'CRIT'
          end
          object Label56: TLabel
            Left = 60
            Top = 388
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label57: TLabel
            Left = 134
            Top = 370
            Width = 49
            Height = 13
            Caption = #12510#12522#12514#28040#36027
          end
          object Label60: TLabel
            Left = 60
            Top = 410
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label61: TLabel
            Left = 60
            Top = 225
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label62: TLabel
            Left = 60
            Top = 287
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label63: TLabel
            Left = 60
            Top = 349
            Width = 11
            Height = 13
            Caption = #8594
          end
          object ModWMarimoPanel: TPanel
            Left = 70
            Top = 6
            Width = 80
            Height = 16
            BevelOuter = bvNone
            Caption = '1234567890'
            Color = clWindow
            ParentBackground = False
            TabOrder = 16
          end
          object ModWGrid1: TStringGrid
            Left = 87
            Top = 37
            Width = 177
            Height = 70
            BevelInner = bvNone
            BevelOuter = bvNone
            ColCount = 2
            Ctl3D = False
            DefaultColWidth = 54
            DefaultRowHeight = 16
            Enabled = False
            FixedCols = 0
            RowCount = 4
            FixedRows = 0
            ParentCtl3D = False
            ScrollBars = ssNone
            TabOrder = 17
            OnDrawCell = DrawModGridCell
          end
          object ModBackWPnlButton: TPanel
            Left = 164
            Top = 4
            Width = 100
            Height = 22
            BevelInner = bvRaised
            Caption = #25147#12427
            TabOrder = 18
            OnClick = ModBackWPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object ModWGrid2: TStringGrid
            Left = 8
            Top = 106
            Width = 135
            Height = 67
            BevelInner = bvNone
            BevelOuter = bvNone
            ColCount = 2
            Ctl3D = False
            DefaultColWidth = 78
            DefaultRowHeight = 16
            Enabled = False
            FixedCols = 0
            RowCount = 4
            FixedRows = 0
            ParentCtl3D = False
            ScrollBars = ssNone
            TabOrder = 19
            OnDrawCell = DrawModGridCell
          end
          object ModWGrid3: TStringGrid
            Left = 142
            Top = 106
            Width = 122
            Height = 67
            BevelInner = bvNone
            BevelOuter = bvNone
            ColCount = 2
            Ctl3D = False
            DefaultColWidth = 50
            DefaultRowHeight = 16
            Enabled = False
            FixedCols = 0
            RowCount = 4
            FixedRows = 0
            ParentCtl3D = False
            ScrollBars = ssNone
            TabOrder = 20
            OnDrawCell = DrawModGridCell
          end
          object DmgMinCurPanel: TPanel
            Left = 8
            Top = 200
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 0
          end
          object DmgMinNewPanel: TPanel
            Left = 76
            Top = 200
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 1
          end
          object DmgMinMrmPanel: TPanel
            Left = 134
            Top = 200
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 2
          end
          object ModDmgMinPnlButton: TPanel
            Left = 202
            Top = 196
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9650#24375#21270
            TabOrder = 3
            OnClick = ModDmgMinPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object DmgMaxCurPanel: TPanel
            Left = 8
            Top = 262
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 4
          end
          object DmgMaxNewPanel: TPanel
            Left = 76
            Top = 262
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 5
          end
          object DmgMaxMrmPanel: TPanel
            Left = 134
            Top = 262
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 6
          end
          object ModDmgMaxPnlButton: TPanel
            Left = 202
            Top = 258
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9650#24375#21270
            TabOrder = 7
            OnClick = ModDmgMaxPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object SpeedCurPanel: TPanel
            Left = 8
            Top = 324
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 8
          end
          object SpeedNewPanel: TPanel
            Left = 76
            Top = 324
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 9
          end
          object SpeedMrmPanel: TPanel
            Left = 134
            Top = 324
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 10
          end
          object ModSpeedPnlButton: TPanel
            Left = 202
            Top = 320
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9650#24375#21270
            TabOrder = 11
            OnClick = ModSpeedPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object CritWCurPanel: TPanel
            Left = 8
            Top = 386
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 13
          end
          object CritWNewPanel: TPanel
            Left = 76
            Top = 386
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 15
          end
          object CritWMrmPanel: TPanel
            Left = 134
            Top = 386
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 12
          end
          object ModCritWPnlButton: TPanel
            Left = 202
            Top = 382
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9650#24375#21270
            TabOrder = 14
            OnClick = ModCritWPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object CritWDwnPanel: TPanel
            Left = 76
            Top = 408
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 21
          end
          object CritWDMrPanel: TPanel
            Left = 134
            Top = 408
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 22
          end
          object DwnCritWPnlButton: TPanel
            Left = 202
            Top = 404
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9660#20302#19979
            TabOrder = 23
            OnClick = DwnCritWPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object DmgMinDwnPanel: TPanel
            Left = 76
            Top = 223
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 24
          end
          object DmgMinDMrPanel: TPanel
            Left = 134
            Top = 223
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 25
          end
          object DwnDmgMinPnlButton: TPanel
            Left = 202
            Top = 219
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9660#20302#19979
            TabOrder = 26
            OnClick = DwnDmgMinPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object DmgMaxDwnPanel: TPanel
            Left = 76
            Top = 285
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 27
          end
          object DmgMaxDMrPanel: TPanel
            Left = 134
            Top = 285
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 28
          end
          object DwnDmgMaxPnlButton: TPanel
            Left = 202
            Top = 281
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9660#20302#19979
            TabOrder = 29
            OnClick = DwnDmgMaxPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object DwnSpeedPnlButton: TPanel
            Left = 202
            Top = 343
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9660#20302#19979
            TabOrder = 30
            OnClick = DwnSpeedPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object SpeedDMrPanel: TPanel
            Left = 134
            Top = 347
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 31
          end
          object SpeedDwnPanel: TPanel
            Left = 76
            Top = 347
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 32
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 472
          Width = 272
          Height = 10
          Align = alClient
          BevelOuter = bvLowered
          ParentColor = True
          TabOrder = 1
        end
      end
    end
    object TabSheetModA: TTabSheet
      Caption = #38450#20855#24375#21270
      ImageIndex = 6
      object ModAPanel: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 482
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object ModABasePanel: TPanel
          Left = 0
          Top = 0
          Width = 272
          Height = 472
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label26: TLabel
            Left = 8
            Top = 184
            Width = 67
            Height = 13
            Caption = 'DEF'#65288#26368#23567#20516#65289
          end
          object Label35: TLabel
            Left = 60
            Top = 202
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label36: TLabel
            Left = 134
            Top = 184
            Width = 49
            Height = 13
            Caption = #12510#12522#12514#28040#36027
          end
          object Label37: TLabel
            Left = 8
            Top = 248
            Width = 67
            Height = 13
            Caption = 'DEF'#65288#26368#22823#20516#65289
          end
          object Label38: TLabel
            Left = 60
            Top = 264
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label39: TLabel
            Left = 134
            Top = 248
            Width = 49
            Height = 13
            Caption = #12510#12522#12514#28040#36027
          end
          object Label40: TLabel
            Left = 8
            Top = 308
            Width = 20
            Height = 13
            Caption = 'WT.'
          end
          object Label41: TLabel
            Left = 60
            Top = 326
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label42: TLabel
            Left = 134
            Top = 308
            Width = 49
            Height = 13
            Caption = #12510#12522#12514#28040#36027
          end
          object Label43: TLabel
            Left = 8
            Top = 370
            Width = 24
            Height = 13
            Caption = 'CRIT'
          end
          object Label44: TLabel
            Left = 60
            Top = 388
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label45: TLabel
            Left = 134
            Top = 370
            Width = 49
            Height = 13
            Caption = #12510#12522#12514#28040#36027
          end
          object Label58: TLabel
            Left = 8
            Top = 7
            Width = 55
            Height = 13
            Caption = #20445#26377#12510#12522#12514#65306
          end
          object ModAImage: TImage
            Left = 8
            Top = 29
            Width = 78
            Height = 76
            Center = True
            Proportional = True
            Stretch = True
          end
          object Label64: TLabel
            Left = 60
            Top = 225
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label65: TLabel
            Left = 60
            Top = 287
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label66: TLabel
            Left = 60
            Top = 349
            Width = 11
            Height = 13
            Caption = #8594
          end
          object Label67: TLabel
            Left = 60
            Top = 410
            Width = 11
            Height = 13
            Caption = #8594
          end
          object ModAGrid1: TStringGrid
            Left = 87
            Top = 37
            Width = 177
            Height = 70
            BevelInner = bvNone
            BevelOuter = bvNone
            ColCount = 2
            Ctl3D = False
            DefaultColWidth = 54
            DefaultRowHeight = 16
            Enabled = False
            FixedCols = 0
            RowCount = 4
            FixedRows = 0
            ParentCtl3D = False
            ScrollBars = ssNone
            TabOrder = 0
            OnDrawCell = DrawModGridCell
          end
          object ModBackAPnlButton: TPanel
            Left = 162
            Top = 4
            Width = 100
            Height = 25
            BevelInner = bvRaised
            Caption = #25147#12427
            TabOrder = 1
            OnClick = ModBackAPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object DefMinCurPanel: TPanel
            Left = 8
            Top = 200
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 2
          end
          object DefMinNewPanel: TPanel
            Left = 76
            Top = 200
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 3
          end
          object DefMinMrmPanel: TPanel
            Left = 134
            Top = 200
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 4
          end
          object ModDefMinPnlButton: TPanel
            Left = 202
            Top = 196
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9650#24375#21270
            TabOrder = 5
            OnClick = ModDefMinPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object DefMaxCurPanel: TPanel
            Left = 8
            Top = 262
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 6
          end
          object DefMaxNewPanel: TPanel
            Left = 76
            Top = 262
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 7
          end
          object DefMaxMrmPanel: TPanel
            Left = 134
            Top = 262
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 8
          end
          object ModDefMaxPnlButton: TPanel
            Left = 202
            Top = 258
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9650#24375#21270
            TabOrder = 9
            OnClick = ModDefMaxPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object WeightCurPanel: TPanel
            Left = 8
            Top = 324
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 10
          end
          object WeightNewPanel: TPanel
            Left = 76
            Top = 324
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 11
          end
          object WeightMrmPanel: TPanel
            Left = 134
            Top = 324
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 12
          end
          object ModWeightPnlButton: TPanel
            Left = 202
            Top = 320
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9650#24375#21270
            TabOrder = 13
            OnClick = ModWeightPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object CritACurPanel: TPanel
            Left = 8
            Top = 386
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 14
          end
          object CritANewPanel: TPanel
            Left = 76
            Top = 386
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 15
          end
          object CritAMrmPanel: TPanel
            Left = 134
            Top = 386
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 16
          end
          object ModCritAPnlButton: TPanel
            Left = 202
            Top = 382
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9650#24375#21270
            TabOrder = 17
            OnClick = ModCritAPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object ModAMarimoPanel: TPanel
            Left = 70
            Top = 6
            Width = 80
            Height = 16
            BevelOuter = bvNone
            Caption = '1234567890'
            Color = clWindow
            ParentBackground = False
            TabOrder = 18
          end
          object ModAGrid3: TStringGrid
            Left = 142
            Top = 106
            Width = 122
            Height = 67
            BevelInner = bvNone
            BevelOuter = bvNone
            ColCount = 2
            Ctl3D = False
            DefaultColWidth = 50
            DefaultRowHeight = 16
            Enabled = False
            FixedCols = 0
            RowCount = 4
            FixedRows = 0
            ParentCtl3D = False
            ScrollBars = ssNone
            TabOrder = 19
            OnDrawCell = DrawModGridCell
          end
          object ModAGrid2: TStringGrid
            Left = 8
            Top = 106
            Width = 135
            Height = 67
            BevelInner = bvNone
            BevelOuter = bvNone
            ColCount = 2
            Ctl3D = False
            DefaultColWidth = 78
            DefaultRowHeight = 16
            Enabled = False
            FixedCols = 0
            RowCount = 4
            FixedRows = 0
            ParentCtl3D = False
            ScrollBars = ssNone
            TabOrder = 20
            OnDrawCell = DrawModGridCell
          end
          object DefMinDwnPanel: TPanel
            Left = 76
            Top = 223
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 21
          end
          object DefMinDMrPanel: TPanel
            Left = 134
            Top = 223
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 22
          end
          object DwnDefMinPnlButton: TPanel
            Left = 202
            Top = 219
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9660#20302#19979
            TabOrder = 23
            OnClick = DwnDefMinPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object DefMaxDwnPanel: TPanel
            Left = 76
            Top = 285
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 24
          end
          object DefMaxDMrPanel: TPanel
            Left = 134
            Top = 285
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 25
          end
          object DwnDefMaxPnlButton: TPanel
            Left = 202
            Top = 281
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9660#20302#19979
            TabOrder = 26
            OnClick = DwnDefMaxPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object WeightDwnPanel: TPanel
            Left = 76
            Top = 347
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 27
          end
          object WeightDMrPanel: TPanel
            Left = 134
            Top = 347
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 28
          end
          object DwnWeightPnlButton: TPanel
            Left = 202
            Top = 343
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9660#20302#19979
            TabOrder = 29
            OnClick = DwnWeightPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object CritADwnPanel: TPanel
            Left = 76
            Top = 408
            Width = 46
            Height = 16
            BevelOuter = bvNone
            Caption = '12345'
            Color = clWindow
            ParentBackground = False
            TabOrder = 30
          end
          object CritADMrPanel: TPanel
            Left = 134
            Top = 408
            Width = 58
            Height = 16
            BevelOuter = bvNone
            Caption = '123456'
            Color = clWindow
            ParentBackground = False
            TabOrder = 31
          end
          object DwnCritAPnlButton: TPanel
            Left = 202
            Top = 404
            Width = 60
            Height = 22
            BevelInner = bvRaised
            Caption = #9660#20302#19979
            TabOrder = 32
            OnClick = DwnCritAPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 472
          Width = 272
          Height = 10
          Align = alClient
          BevelOuter = bvLowered
          ParentColor = True
          TabOrder = 1
        end
      end
    end
    object TabSheetLink: TTabSheet
      Caption = #12522#12531#12463
      ImageIndex = 3
      object LinkPanel: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 472
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label18: TLabel
          Left = 12
          Top = 36
          Width = 122
          Height = 13
          Caption = #12393#12435#12368#12426#12471#12473#12486#12512'WEB'#12469#12452#12488
        end
        object LabelHomeLink: TLabel
          Left = 22
          Top = 52
          Width = 70
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelHomeLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label20: TLabel
          Left = 22
          Top = 68
          Width = 239
          Height = 13
          Caption = #8251#26410#30331#37682#35686#20633#21729#12450#12459#12454#12531#12488#12391#12399#12525#12464#12452#12531#12391#12365#12414#12379#12435#12290
        end
        object Label21: TLabel
          Left = 12
          Top = 90
          Width = 94
          Height = 13
          Caption = #12393#12435#12368#12426#12471#12473#12486#12512'FAQ'
        end
        object LabelFaqLink: TLabel
          Left = 22
          Top = 106
          Width = 61
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelFaqLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label19: TLabel
          Left = 12
          Top = 8
          Width = 161
          Height = 13
          Caption = 'WEB'#12502#12521#12454#12470#12391#12522#12531#12463#12434#34920#31034#12375#12414#12377#12290
        end
        object Label22: TLabel
          Left = 12
          Top = 128
          Width = 76
          Height = 13
          Caption = #12393#12435#12368#12426#22823#30770'API'
        end
        object LabelApiLink: TLabel
          Left = 22
          Top = 144
          Width = 58
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelApiLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label23: TLabel
          Left = 12
          Top = 166
          Width = 80
          Height = 13
          Caption = #12393#12435#12368#12426#12521#12531#12461#12531#12464
        end
        object LabelRankLink: TLabel
          Left = 22
          Top = 182
          Width = 67
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelRankLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label25: TLabel
          Left = 12
          Top = 204
          Width = 77
          Height = 13
          Caption = #12393#12435#12368#12426#22823#30770#12525#12464
        end
        object LabelCLogLink: TLabel
          Left = 22
          Top = 220
          Width = 67
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelCLogLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label27: TLabel
          Left = 12
          Top = 242
          Width = 89
          Height = 13
          Caption = #12393#12435#12368#12426#22823#20081#38360#12525#12464
        end
        object LabelFLogLink: TLabel
          Left = 22
          Top = 258
          Width = 66
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelFLogLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label29: TLabel
          Left = 12
          Top = 280
          Width = 70
          Height = 13
          Caption = #12450#12452#12486#12512#12454#12457#12483#12481
        end
        object LabelItemWLink: TLabel
          Left = 22
          Top = 296
          Width = 75
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelItemWLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label31: TLabel
          Left = 12
          Top = 318
          Width = 64
          Height = 13
          Caption = #33618#12425#12375#12450#12521#12540#12488
        end
        object LabelAlertLink: TLabel
          Left = 22
          Top = 334
          Width = 66
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelAlertLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label33: TLabel
          Left = 12
          Top = 410
          Width = 34
          Height = 13
          Caption = 'UPLIFT'
        end
        object LabelUpliftLink: TLabel
          Left = 22
          Top = 426
          Width = 68
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelUpliftLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label28: TLabel
          Left = 12
          Top = 356
          Width = 145
          Height = 13
          Caption = #12393#12435#12368#12426#12471#12519#12483#12503#65288#37444#12398#12461#12540#36092#20837#65289
        end
        object LabelShopLink: TLabel
          Left = 22
          Top = 372
          Width = 67
          Height = 13
          Cursor = crHandPoint
          Caption = 'LabelShopLink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          PopupMenu = PopupMenuLink
          OnClick = LabelLinkClick
          OnContextPopup = LabelLinkContextPopup
        end
        object Label32: TLabel
          Left = 22
          Top = 388
          Width = 227
          Height = 13
          Caption = #8251#26410#30331#37682#35686#20633#21729#12450#12459#12454#12531#12488#12391#12399#21033#29992#12391#12365#12414#12379#12435#12290
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 472
        Width = 272
        Height = 10
        Align = alClient
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 1
      end
    end
    object TabSheetSetting: TTabSheet
      Caption = #35373#23450
      ImageIndex = 4
      object PanelSetting: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 472
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object SystemGroupBox: TGroupBox
          Left = 12
          Top = 12
          Width = 245
          Height = 154
          Caption = #12393#12435#12368#12426#12471#12473#12486#12512
          TabOrder = 0
          object Label8: TLabel
            Left = 32
            Top = 78
            Width = 204
            Height = 13
            Caption = #65288#12371#12398#30011#38754#12434#38281#12376#12390#20877#24230#34920#31034#12377#12427#12392#26377#21177#21270#65289
          end
          object AutoLoginLabel: TLabel
            Left = 32
            Top = 38
            Width = 95
            Height = 13
            Caption = #65288#12495#12531#12479#12540#12399#24120#12395'ON'#65289
            Visible = False
          end
          object TaskBarCheckBox: TCheckBox
            Left = 12
            Top = 58
            Width = 213
            Height = 17
            Caption = #12479#12473#12463#12496#12540#12395#12450#12452#12467#12531#34920#31034'(&I)'
            TabOrder = 1
            OnClick = TaskBarCheckBoxClick
          end
          object ColorRadioGroup: TRadioGroup
            Left = 12
            Top = 98
            Width = 220
            Height = 45
            Caption = #12454#12452#12531#12489#12454#37197#33394
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              #12521#12452#12488
              #12480#12540#12463)
            TabOrder = 2
            OnClick = ColorRadioGroupClick
          end
          object AutoLoginCheckBox: TCheckBox
            Left = 12
            Top = 20
            Width = 230
            Height = 17
            Caption = #12393#12435#12368#12426#30011#38754#12458#12540#12503#12531#26178#12395#33258#21205#12525#12464#12452#12531'(&A)'
            TabOrder = 0
            OnClick = AutoLoginCheckBoxClick
          end
        end
        object CannonGroupBox: TGroupBox
          Left = 12
          Top = 176
          Width = 245
          Height = 51
          Caption = #12393#12435#12368#12426#22823#30770
          TabOrder = 1
          object CannonMenuCheckBox: TCheckBox
            Left = 12
            Top = 20
            Width = 213
            Height = 17
            Caption = #12524#12473#30058#21495#12513#12491#12517#12540#12398#20808#38957#12395#34920#31034#12377#12427'(&T)'
            TabOrder = 0
            OnClick = CannonMenuCheckBoxClick
          end
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 472
        Width = 272
        Height = 10
        Align = alClient
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 1
      end
    end
  end
  object TimerInit: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerInitTimer
    Left = 328
    Top = 24
  end
  object BagImageList: TImageList
    Left = 16
    Bitmap = {
      494C01010A001400200110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400000000000000000000000000000000000000000000000000015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6337400D633
      74000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9
      FF00D6337400D633740000000000000000000000000000000000015DF400015D
      F400000000000000000000000000000000000000000000000000000000000000
      0000015DF400015DF40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D63374000EC9
      FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF000EC9FF00D6337400D63374000000000000000000015DF400015DF4000000
      000000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF0000000000015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D63374000EC9
      FF0000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF000EC9FF00D6337400D63374000000000000000000015DF400015DF4000000
      000000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000000000015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D63374000EC9
      FF0000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF000EC9FF00D6337400D63374000000000000000000015DF400015DF4000000
      000000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000000000015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D63374000EC9
      FF0000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF000EC9FF00D6337400D63374000000000000000000015DF400015DF4000000
      000000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF0000000000015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D63374000EC9
      FF0000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF000EC9FF00D6337400D63374000000000000000000015DF400015DF4000000
      000000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF0000000000015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D63374000EC9
      FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF000EC9FF00D6337400D63374000000000000000000015DF400015DF4000000
      000000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF0000000000015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D6337400D633
      74000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9
      FF00D6337400D6337400D63374000000000000000000015DF400015DF400015D
      F400000000000000000000000000000000000000000000000000000000000000
      0000015DF400015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D6337400D633
      7400D63374000EC9FF00D6337400D6337400D6337400D63374000EC9FF00D633
      7400D6337400D6337400D63374000000000000000000015DF400015DF400015D
      F400015DF40000000000015DF400015DF400015DF400015DF40000000000015D
      F400015DF400015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D6337400D633
      7400D63374000EC9FF00D6337400D6337400D6337400D63374000EC9FF00D633
      7400D6337400D6337400D63374000000000000000000015DF400015DF400015D
      F400015DF40000000000015DF400015DF400015DF400015DF40000000000015D
      F400015DF400015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6337400D6337400D633
      7400D63374000EC9FF00D6337400D6337400D6337400D63374000EC9FF00D633
      7400D6337400D6337400D63374000000000000000000015DF400015DF400015D
      F400015DF40000000000015DF400015DF400015DF400015DF40000000000015D
      F400015DF400015DF400015DF400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6337400D633
      7400D6337400D63374000EC9FF000EC9FF000EC9FF000EC9FF00D6337400D633
      7400D6337400D633740000000000000000000000000000000000015DF400015D
      F400015DF400015DF40000000000000000000000000000000000015DF400015D
      F400015DF400015DF40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400000000000000000000000000000000000000000000000000015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF4000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F0000000000000000000000000000000000000000000000000035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F00000000000000000000000000000000000000000000000000D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D97521000000000000000000000000000000000000000000015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400000000000000000000000000000000007F7F7F00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007F7F7F000000000000000000000000000000000035A43F0035A4
      3F00000000000000000000000000000000000000000000000000000000000000
      000035A43F0035A43F0000000000000000000000000000000000D9752100D975
      21000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9
      FF00D9752100D9752100000000000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF000000
      000000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF0000000000FFFFFF007F7F7F00000000000000000035A43F0035A43F000000
      000000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF000000000035A43F0035A43F000000000000000000D9752100D97521000EC9
      FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF000EC9FF00D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF000000
      000000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000000000FFFFFF007F7F7F00000000000000000035A43F0035A43F000000
      000000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF000000000035A43F0035A43F000000000000000000D9752100D97521000EC9
      FF0000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF000EC9FF00D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF000000
      000000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF0000000000FFFFFF007F7F7F00000000000000000035A43F0035A43F000000
      000000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF000000000035A43F0035A43F000000000000000000D9752100D97521000EC9
      FF0000F2FF0000F2FF0000F2FF000000000000F2FF0000F2FF0000F2FF0000F2
      FF000EC9FF00D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF000000
      000000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF0000000000FFFFFF007F7F7F00000000000000000035A43F0035A43F000000
      000000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF000000000035A43F0035A43F000000000000000000D9752100D97521000EC9
      FF0000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF000EC9FF00D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF000000
      000000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF0000000000FFFFFF007F7F7F00000000000000000035A43F0035A43F000000
      000000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF000000000035A43F0035A43F000000000000000000D9752100D97521000EC9
      FF0000F2FF0000F2FF0000F2FF00000000000000000000F2FF0000F2FF0000F2
      FF000EC9FF00D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF000000
      000000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF0000000000FFFFFF007F7F7F00000000000000000035A43F0035A43F000000
      000000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF000000000035A43F0035A43F000000000000000000D9752100D97521000EC9
      FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2FF0000F2
      FF000EC9FF00D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F00000000000000000000000000000000000000000000000000000000000000
      000035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      21000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9FF000EC9
      FF00D9752100D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F000000000035A43F0035A43F0035A43F0035A43F000000000035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D97521000EC9FF00D9752100D9752100D9752100D97521000EC9FF00D975
      2100D9752100D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F000000000035A43F0035A43F0035A43F0035A43F000000000035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D97521000EC9FF00D9752100D9752100D9752100D97521000EC9FF00D975
      2100D9752100D9752100D97521000000000000000000015DF400015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400015DF40000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F000000000035A43F0035A43F0035A43F0035A43F000000000035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D97521000EC9FF00D9752100D9752100D9752100D97521000EC9FF00D975
      2100D9752100D9752100D9752100000000000000000000000000015DF400015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF400015DF400000000000000000000000000000000007F7F7F00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF007F7F7F000000000000000000000000000000000035A43F0035A4
      3F0035A43F0035A43F000000000000000000000000000000000035A43F0035A4
      3F0035A43F0035A43F0000000000000000000000000000000000D9752100D975
      2100D9752100D97521000EC9FF000EC9FF000EC9FF000EC9FF00D9752100D975
      2100D9752100D97521000000000000000000000000000000000000000000015D
      F400015DF400015DF400015DF400015DF400015DF400015DF400015DF400015D
      F400015DF4000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F0000000000000000000000000000000000000000000000000035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F00000000000000000000000000000000000000000000000000D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D97521000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F0000000000000000000000000000000000000000000000000035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F00000000000000000000000000000000000000000000000000D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100000000000000000000000000000000000000000000000000D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D633740000000000000000000000000000000000000000007F7F7F00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007F7F7F000000000000000000000000000000000035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0000000000000000000000000000000000D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D975210000000000000000000000000000000000D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D63374000000000000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D633740000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0035A43F000000000000000000D9752100D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D9752100D97521000000000000000000D6337400D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D6337400D63374000000000000000000000000007F7F7F00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007F7F7F000000000000000000000000000000000035A43F0035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F0035A43F0000000000000000000000000000000000D9752100D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100D975210000000000000000000000000000000000D6337400D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D6337400D633740000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F0000000000000000000000000000000000000000000000000035A4
      3F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A43F0035A4
      3F0035A43F00000000000000000000000000000000000000000000000000D975
      2100D9752100D9752100D9752100D9752100D9752100D9752100D9752100D975
      2100D9752100000000000000000000000000000000000000000000000000D633
      7400D6337400D6337400D6337400D6337400D6337400D6337400D6337400D633
      7400D63374000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000E007E00700000000
      C003C00300000000800180010000000080018001000000008001800100000000
      8001800100000000800180010000000080018001000000008001800100000000
      800180010000000080018001000000008001800100000000C003C00300000000
      E007E00700000000FFFFFFFF00000000FFFFFFFFFFFFFFFFE007E007E007E007
      C003C003C003C003800180018001800180018001800180018001800180018001
      8001800180018001800180018001800180018001800180018001800180018001
      800180018001800180018001800180018001800180018001C003C003C003C003
      E007E007E007E007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE007E007E007E007
      C003C003C003C003800180018001800180018001800180018001800180018001
      8001800180018001800180018001800180018001800180018001800180018001
      800180018001800180018001800180018001800180018001C003C003C003C003
      E007E007E007E007FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenuLink: TPopupMenu
    Left = 48
    object ManuItemOpen: TMenuItem
      Caption = 'WEB'#12502#12521#12454#12470#12391#38283#12367'(&O)'
      OnClick = ManuItemOpenClick
    end
    object ManuItemCopy: TMenuItem
      Caption = #12522#12531#12463#12434#12467#12500#12540'(&C)'
      OnClick = ManuItemCopyClick
    end
  end
  object PopupMenuLogin: TPopupMenu
    Left = 88
    object MItemLogin: TMenuItem
      Caption = #12381#12398#12414#12414#12525#12464#12452#12531'(&L)'
      OnClick = MItemLoginClick
    end
    object MItemHntLogin: TMenuItem
      Caption = #12495#12531#12479#12540#12392#12375#12390#12513#12540#12523#12525#12464#12452#12531'(&H)'
      OnClick = MItemHntLoginClick
    end
    object MItemGrdLogin: TMenuItem
      Caption = #35686#20633#21729#12392#12375#12390#12513#12540#12523#12525#12464#12452#12531'(&G)'
      OnClick = MItemGrdLoginClick
    end
  end
end
