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
    ActivePage = TabSheetHunter
    Align = alClient
    TabOrder = 1
    OnDrawTab = PageControlDrawTab
    object TabSheetHome: TTabSheet
      Caption = #12507#12540#12512
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
        ActivePage = TabSheetChest
        Align = alClient
        MultiLine = True
        TabOrder = 1
        OnDrawTab = PageControlHunterDrawTab
        object TabSheetRename: TTabSheet
          Caption = #21628#12403#21517#22793#26356#12539#12489#12531#12464#12522#36578#36865
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
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
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
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
              ItemHeight = 0
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
          object BagTopPanel: TPanel
            Left = 0
            Top = 0
            Width = 264
            Height = 96
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label9: TLabel
              Left = 12
              Top = 43
              Width = 51
              Height = 13
              Caption = #12473#12525#12483#12488#25968#65306
            end
            object SlotLabel: TLabel
              Left = 76
              Top = 43
              Width = 22
              Height = 13
              Caption = '0 / 0'
            end
            object BagPnlButton: TPanel
              Left = 12
              Top = 6
              Width = 130
              Height = 25
              BevelInner = bvRaised
              Caption = #12450#12452#12486#12512#12496#12483#12464#34920#31034#26356#26032
              TabOrder = 0
              OnClick = BagPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object ChestPnlButton: TPanel
              Left = 162
              Top = 6
              Width = 90
              Height = 25
              BevelInner = bvRaised
              Caption = #23453#31665#12434#38283#12369#12427
              TabOrder = 1
              OnClick = ChestPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object SlotPnlButton: TPanel
              Left = 162
              Top = 36
              Width = 90
              Height = 25
              BevelInner = bvRaised
              Caption = #12473#12525#12483#12488#36861#21152
              TabOrder = 2
              OnClick = SlotPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
            object RecycleAllPnlButton: TPanel
              Left = 12
              Top = 66
              Width = 240
              Height = 25
              BevelInner = bvRaised
              Caption = #12525#12483#12463#12373#12428#12390#12356#12394#12356#35013#20633#12434#12377#12409#12390#35299#20307
              TabOrder = 3
              OnClick = RecycleAllPnlButtonClick
              OnMouseDown = PanelButtonMouseDown
              OnMouseUp = PanelButtonMouseUp
            end
          end
          object PageControlItemBag: TPageControl
            Left = 0
            Top = 96
            Width = 264
            Height = 251
            ActivePage = TabSheetArmor
            Align = alClient
            TabOrder = 1
            OnDrawTab = PageControlItemBagDrawTab
            object TabSheetUsing: TTabSheet
              Caption = #35013#20633#20013
              OnResize = TabSheetUsingResize
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object Label10: TLabel
                Left = 2
                Top = 7
                Width = 24
                Height = 13
                Caption = #27494#22120
              end
              object Label11: TLabel
                Left = 2
                Top = 100
                Width = 24
                Height = 13
                Caption = #38450#20855
              end
              object ListViewWeaponUsing: TListView
                Left = 0
                Top = 25
                Width = 250
                Height = 59
                BevelInner = bvNone
                BevelOuter = bvNone
                Columns = <
                  item
                    Caption = #12288
                    Width = 10
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
                ReadOnly = True
                RowSelect = True
                TabOrder = 0
                ViewStyle = vsReport
              end
              object RemWeaponPnlButton: TPanel
                Left = 48
                Top = 2
                Width = 60
                Height = 22
                BevelInner = bvRaised
                Caption = #22806#12377
                Enabled = False
                TabOrder = 1
                OnClick = RemWeaponPnlButtonClick
                OnMouseDown = PanelButtonMouseDown
                OnMouseUp = PanelButtonMouseUp
              end
              object RemArmorPnlButton: TPanel
                Left = 48
                Top = 95
                Width = 60
                Height = 22
                BevelInner = bvRaised
                Caption = #22806#12377
                Enabled = False
                TabOrder = 2
                OnClick = RemArmorPnlButtonClick
                OnMouseDown = PanelButtonMouseDown
                OnMouseUp = PanelButtonMouseUp
              end
              object ListViewArmorUsing: TListView
                Left = 3
                Top = 120
                Width = 250
                Height = 59
                BevelInner = bvNone
                BevelOuter = bvNone
                Columns = <
                  item
                    Caption = #12288
                    Width = 10
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
                ReadOnly = True
                RowSelect = True
                TabOrder = 3
                ViewStyle = vsReport
              end
            end
            object TabSheetWeapon: TTabSheet
              Caption = #27494#22120
              ImageIndex = 1
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object WeaponTopPanel: TPanel
                Left = 0
                Top = 0
                Width = 256
                Height = 30
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object WeaponAllCheckBox: TCheckBox
                  Left = 4
                  Top = 12
                  Width = 18
                  Height = 17
                  TabStop = False
                  Caption = #12288
                  TabOrder = 0
                  OnClick = WeaponAllCheckBoxClick
                end
                object RecycleWPnlButton: TPanel
                  Left = 138
                  Top = 4
                  Width = 44
                  Height = 22
                  BevelInner = bvRaised
                  Caption = #20998#35299
                  Enabled = False
                  TabOrder = 1
                  OnClick = RecycleWPnlButtonClick
                  OnMouseDown = PanelButtonMouseDown
                  OnMouseUp = PanelButtonMouseUp
                end
                object UnlockWPnlButton: TPanel
                  Left = 76
                  Top = 4
                  Width = 60
                  Height = 22
                  BevelInner = bvRaised
                  Caption = #12450#12531#12525#12483#12463
                  Enabled = False
                  TabOrder = 2
                  OnClick = UnlockWPnlButtonClick
                  OnMouseDown = PanelButtonMouseDown
                  OnMouseUp = PanelButtonMouseUp
                end
                object LockWPnlButton: TPanel
                  Left = 30
                  Top = 4
                  Width = 44
                  Height = 22
                  BevelInner = bvRaised
                  Caption = #12525#12483#12463
                  Enabled = False
                  TabOrder = 3
                  OnClick = LockWPnlButtonClick
                  OnMouseDown = PanelButtonMouseDown
                  OnMouseUp = PanelButtonMouseUp
                end
                object UseWPnlButton: TPanel
                  Left = 184
                  Top = 4
                  Width = 44
                  Height = 22
                  BevelInner = bvRaised
                  Caption = #35013#20633
                  Enabled = False
                  TabOrder = 4
                  OnClick = UseWPnlButtonClick
                  OnMouseDown = PanelButtonMouseDown
                  OnMouseUp = PanelButtonMouseUp
                end
              end
              object ListViewWeapon: TListView
                Left = 0
                Top = 30
                Width = 256
                Height = 193
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
                ReadOnly = True
                RowSelect = True
                SmallImages = BagImageList
                TabOrder = 1
                ViewStyle = vsReport
                OnChange = ListViewWeaponChange
              end
            end
            object TabSheetArmor: TTabSheet
              Caption = #38450#20855
              ImageIndex = 2
              object ArmorTopPanel: TPanel
                Left = 0
                Top = 0
                Width = 256
                Height = 30
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object ArmorAllCheckBox: TCheckBox
                  Left = 4
                  Top = 12
                  Width = 18
                  Height = 17
                  TabStop = False
                  Caption = #12288
                  TabOrder = 0
                  OnClick = ArmorAllCheckBoxClick
                end
                object LockAPnlButton: TPanel
                  Left = 30
                  Top = 4
                  Width = 44
                  Height = 22
                  BevelInner = bvRaised
                  Caption = #12525#12483#12463
                  Enabled = False
                  TabOrder = 1
                  OnClick = LockAPnlButtonClick
                  OnMouseDown = PanelButtonMouseDown
                  OnMouseUp = PanelButtonMouseUp
                end
                object UnlockAPnlButton: TPanel
                  Left = 76
                  Top = 4
                  Width = 60
                  Height = 22
                  BevelInner = bvRaised
                  Caption = #12450#12531#12525#12483#12463
                  Enabled = False
                  TabOrder = 2
                  OnClick = UnlockAPnlButtonClick
                  OnMouseDown = PanelButtonMouseDown
                  OnMouseUp = PanelButtonMouseUp
                end
                object RecycleAPnlButton: TPanel
                  Left = 138
                  Top = 4
                  Width = 44
                  Height = 22
                  BevelInner = bvRaised
                  Caption = #20998#35299
                  Enabled = False
                  TabOrder = 3
                  OnClick = RecycleAPnlButtonClick
                  OnMouseDown = PanelButtonMouseDown
                  OnMouseUp = PanelButtonMouseUp
                end
                object UseAPnlButton: TPanel
                  Left = 184
                  Top = 4
                  Width = 44
                  Height = 22
                  BevelInner = bvRaised
                  Caption = #35013#20633
                  Enabled = False
                  TabOrder = 4
                  OnClick = UseAPnlButtonClick
                  OnMouseDown = PanelButtonMouseDown
                  OnMouseUp = PanelButtonMouseUp
                end
              end
              object ListViewArmor: TListView
                Left = 0
                Top = 30
                Width = 256
                Height = 193
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
                ReadOnly = True
                RowSelect = True
                SmallImages = BagImageList
                TabOrder = 1
                ViewStyle = vsReport
                OnChange = ListViewArmorChange
              end
            end
          end
        end
      end
    end
    object TabSheetSetting: TTabSheet
      Caption = #35373#23450
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SystemGroupBox: TGroupBox
        Left = 12
        Top = 12
        Width = 245
        Height = 118
        Caption = #12393#12435#12368#12426#12471#12473#12486#12512
        TabOrder = 0
        object Label8: TLabel
          Left = 32
          Top = 40
          Width = 204
          Height = 13
          Caption = #65288#12371#12398#30011#38754#12434#38281#12376#12390#20877#24230#34920#31034#12377#12427#12392#26377#21177#21270#65289
        end
        object TaskBarCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 213
          Height = 17
          Caption = #12479#12473#12463#12496#12540#12395#12450#12452#12467#12531#34920#31034'(&I)'
          TabOrder = 0
          OnClick = TaskBarCheckBoxClick
        end
        object ColorRadioGroup: TRadioGroup
          Left = 12
          Top = 62
          Width = 220
          Height = 45
          Caption = #12454#12452#12531#12489#12454#37197#33394
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            #12521#12452#12488
            #12480#12540#12463)
          TabOrder = 1
          OnClick = ColorRadioGroupClick
        end
      end
      object CannonGroupBox: TGroupBox
        Left = 12
        Top = 142
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
  end
  object TimerInit: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerInitTimer
    Left = 328
    Top = 24
  end
  object BagImageList: TImageList
    Left = 200
    Top = 456
    Bitmap = {
      494C01010A001400180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
end
