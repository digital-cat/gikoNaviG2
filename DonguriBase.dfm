object DonguriForm: TDonguriForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #12393#12435#12368#12426#12471#12473#12486#12512
  ClientHeight = 566
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
    Top = 502
    Width = 280
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
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
    Height = 469
    ActivePage = TabSheetSetting
    Align = alClient
    TabOrder = 1
    OnDrawTab = PageControlDrawTab
    object TabSheetHome: TTabSheet
      Caption = #12507#12540#12512
      object PanelHomeTop: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 136
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 12
          Top = 44
          Width = 70
          Height = 13
          Caption = #12518#12540#12470#12540#31278#21029#65306
        end
        object LabelUserType: TLabel
          Left = 88
          Top = 44
          Width = 36
          Height = 13
          Caption = #35686#20633#21729
        end
        object Label2: TLabel
          Left = 12
          Top = 64
          Width = 40
          Height = 13
          Caption = #21628#12403#21517#65306
        end
        object LabelID: TLabel
          Left = 12
          Top = 81
          Width = 53
          Height = 13
          Caption = #35686#20633#21729'ID'#65306
        end
        object Label3: TLabel
          Left = 12
          Top = 102
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
          Top = 120
          Width = 12
          Height = 13
          Caption = 'K'#65306
        end
        object Label5: TLabel
          Left = 218
          Top = 120
          Width = 13
          Height = 13
          Caption = 'D'#65306
        end
        object LabelD: TLabel
          Left = 234
          Top = 120
          Width = 24
          Height = 13
          Caption = '1234'
        end
        object LabelK: TLabel
          Left = 170
          Top = 120
          Width = 36
          Height = 13
          Caption = '123456'
        end
        object EditName: TEdit
          Left = 88
          Top = 63
          Width = 176
          Height = 17
          TabStop = False
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 0
        end
        object EditID: TEdit
          Left = 88
          Top = 82
          Width = 176
          Height = 17
          TabStop = False
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 1
        end
        object EditLevel: TEdit
          Left = 88
          Top = 101
          Width = 176
          Height = 17
          TabStop = False
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 2
        end
        object RootPnlButton: TPanel
          Left = 12
          Top = 8
          Width = 60
          Height = 25
          BevelInner = bvRaised
          Caption = #20877#34920#31034
          TabOrder = 3
          OnClick = RootPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object AuthPnlButton: TPanel
          Left = 80
          Top = 8
          Width = 60
          Height = 25
          BevelInner = bvRaised
          Caption = #20877#35469#35388
          TabOrder = 4
          OnClick = AuthPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object LoginPnlButton: TPanel
          Left = 142
          Top = 8
          Width = 60
          Height = 25
          BevelInner = bvRaised
          Caption = #12525#12464#12452#12531
          TabOrder = 5
          OnClick = LoginPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object LogoutPnlButton: TPanel
          Left = 204
          Top = 8
          Width = 60
          Height = 25
          BevelInner = bvRaised
          Caption = #12525#12464#12450#12454#12488
          TabOrder = 6
          OnClick = LogoutPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
      end
      object InfoGrid: TStringGrid
        Left = 0
        Top = 136
        Width = 272
        Height = 235
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
      end
      object PanelHome: TPanel
        Left = 0
        Top = 371
        Width = 272
        Height = 70
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object ExplorPnlButton: TPanel
          Left = 12
          Top = 8
          Width = 80
          Height = 25
          BevelInner = bvRaised
          Caption = #25506#26908
          TabOrder = 0
          OnClick = ExplorPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object MiningPnlButton: TPanel
          Left = 98
          Top = 8
          Width = 80
          Height = 25
          BevelInner = bvRaised
          Caption = #25505#25496
          TabOrder = 1
          OnClick = MiningPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object WoodctPnlButton: TPanel
          Left = 184
          Top = 8
          Width = 80
          Height = 25
          BevelInner = bvRaised
          Caption = #26408#12371#12426
          TabOrder = 2
          OnClick = WoodctPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object WeaponPnlButton: TPanel
          Left = 12
          Top = 36
          Width = 80
          Height = 25
          BevelInner = bvRaised
          Caption = #27494#22120#35069#20316
          TabOrder = 3
          OnClick = WeaponPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
        object ArmorcPnlButton: TPanel
          Left = 98
          Top = 36
          Width = 80
          Height = 25
          BevelInner = bvRaised
          Caption = #38450#20855#35069#20316
          TabOrder = 4
          OnClick = ArmorcPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
      end
    end
    object TabSheetHunter: TTabSheet
      Caption = #12495#12531#12479#12540#12469#12540#12499#12473
      ImageIndex = 1
      object PanelHunterTop: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ResurrectPnlButton: TPanel
          Left = 12
          Top = 12
          Width = 80
          Height = 25
          BevelInner = bvRaised
          Caption = #12524#12505#12523#24489#27963
          TabOrder = 0
          OnClick = ResurrectPnlButtonClick
          OnMouseDown = PanelButtonMouseDown
          OnMouseUp = PanelButtonMouseUp
        end
      end
      object PageControlHunter: TPageControl
        Left = 0
        Top = 48
        Width = 272
        Height = 393
        ActivePage = TabSheetCraft
        Align = alClient
        MultiLine = True
        TabOrder = 1
        OnDrawTab = PageControlHunterDrawTab
        object TabSheetRename: TTabSheet
          Caption = #21628#12403#21517#22793#26356#12539#12489#12531#12464#12522#36578#36865
          object RenamePnlButton: TPanel
            Left = 12
            Top = 12
            Width = 80
            Height = 25
            BevelInner = bvRaised
            Caption = #21628#12403#21517#22793#26356
            Enabled = False
            TabOrder = 0
            OnClick = RenamePnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object TransferPnlButton: TPanel
            Left = 12
            Top = 100
            Width = 80
            Height = 25
            BevelInner = bvRaised
            Caption = #12393#12435#12368#12426#36578#36865
            Enabled = False
            TabOrder = 1
            OnClick = TransferPnlButtonClick
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
        end
        object TabSheetCraft: TTabSheet
          Caption = #24037#20316#12475#12531#12479#12540
          ImageIndex = 2
          object GroupBox1: TGroupBox
            Left = 10
            Top = 12
            Width = 242
            Height = 85
            Caption = #37444#12398#12461#12540
            TabOrder = 0
          end
          object GroupBox2: TGroupBox
            Left = 8
            Top = 103
            Width = 246
            Height = 85
            Caption = #37444#12398#22823#30770#12398#29577
            TabOrder = 1
            object Label6: TLabel
              Left = 16
              Top = 24
              Width = 51
              Height = 13
              Caption = #20316#25104#25968'(&A)'
              FocusControl = CBAmountComboBox
            end
            object Label7: TLabel
              Left = 160
              Top = 24
              Width = 40
              Height = 13
              Caption = #37444#12398#37327#65306
            end
            object CBIronLabel: TLabel
              Left = 202
              Top = 24
              Width = 6
              Height = 13
              Caption = '0'
            end
            object CBAmountComboBox: TComboBox
              Left = 76
              Top = 20
              Width = 70
              Height = 21
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
              Left = 152
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
        end
        object TabSheetChest: TTabSheet
          Caption = #12450#12452#12486#12512#12496#12483#12464
          ImageIndex = 3
          object BagPnlButton: TPanel
            Left = 12
            Top = 12
            Width = 100
            Height = 25
            BevelInner = bvRaised
            Caption = #12450#12452#12486#12512#12496#12483#12464
            Enabled = False
            TabOrder = 0
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
          object ChestPnlButton: TPanel
            Left = 140
            Top = 12
            Width = 100
            Height = 25
            BevelInner = bvRaised
            Caption = #23453#31665#12434#38283#12369#12427
            Enabled = False
            TabOrder = 1
            OnMouseDown = PanelButtonMouseDown
            OnMouseUp = PanelButtonMouseUp
          end
        end
      end
    end
    object TabSheetSetting: TTabSheet
      Caption = #35373#23450
      ImageIndex = 2
      object ColorRadioGroup: TRadioGroup
        Left = 12
        Top = 12
        Width = 245
        Height = 45
        Caption = #12454#12452#12531#12489#12454#37197#33394
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #12521#12452#12488
          #12480#12540#12463)
        TabOrder = 0
        OnClick = ColorRadioGroupClick
      end
      object CannonGroupBox: TGroupBox
        Left = 12
        Top = 63
        Width = 245
        Height = 50
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
  end
  object TimerInit: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerInitTimer
    Left = 328
    Top = 24
  end
end
