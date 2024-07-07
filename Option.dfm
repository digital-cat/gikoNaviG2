object OptionDialog: TOptionDialog
  Left = 300
  Top = 166
  BorderStyle = bsDialog
  Caption = #12458#12503#12471#12519#12531
  ClientHeight = 428
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Label26: TLabel
    Left = 32
    Top = 132
    Width = 69
    Height = 12
    Caption = #12497#12473#12527#12540#12489'(&P)'
  end
  object CancelBotton: TButton
    Left = 232
    Top = 400
    Width = 89
    Height = 21
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 0
  end
  object ApplyButton: TButton
    Left = 328
    Top = 400
    Width = 89
    Height = 21
    Cancel = True
    Caption = #36969#29992'(&A)'
    ModalResult = 8
    TabOrder = 1
    OnClick = ApplyButtonClick
  end
  object CroutOption: TButton
    Left = 424
    Top = 400
    Width = 88
    Height = 21
    Caption = #35443#32048#35373#23450
    TabOrder = 2
    OnClick = CroutOptionClick
  end
  object OptionTab: TPageControl
    Left = 4
    Top = 4
    Width = 509
    Height = 389
    ActivePage = TabSheet4
    MultiLine = True
    TabOrder = 3
    OnChange = OptionTabChange
    object ConnectSheet: TTabSheet
      Caption = #25509#32154
      object ReadProxyGroupBox: TGroupBox
        Left = 12
        Top = 4
        Width = 477
        Height = 105
        Caption = #12503#12525#12461#12471#35373#23450' '#65288#12480#12454#12531#12525#12540#12489#29992#65289
        TabOrder = 0
        object ReadAddressLabel: TLabel
          Left = 12
          Top = 48
          Width = 56
          Height = 12
          Caption = #12450#12489#12524#12473'(&R)'
          FocusControl = ReadProxyAddressEdit
        end
        object ReadPortLabel: TLabel
          Left = 368
          Top = 48
          Width = 47
          Height = 12
          Caption = #12509#12540#12488'(&O)'
          FocusControl = ReadPortEdit
        end
        object ReadUserIDLabel: TLabel
          Left = 12
          Top = 76
          Width = 63
          Height = 12
          Caption = #12518#12540#12470'ID(&U)'
          FocusControl = ReadProxyUserIDEdit
        end
        object ReadPasswordLabel: TLabel
          Left = 244
          Top = 76
          Width = 69
          Height = 12
          Caption = #12497#12473#12527#12540#12489'(&S)'
          FocusControl = ReadProxyPasswordEdit
        end
        object ReadProxyCheck: TCheckBox
          Left = 12
          Top = 20
          Width = 173
          Height = 17
          Caption = 'HTTP'#12503#12525#12461#12471#12434#20351#29992#12377#12427'(&P)'
          TabOrder = 0
          OnClick = ReadProxyCheckClick
        end
        object ReadProxyAddressEdit: TEdit
          Left = 88
          Top = 44
          Width = 273
          Height = 20
          MaxLength = 256
          TabOrder = 1
        end
        object ReadPortEdit: TEdit
          Left = 420
          Top = 44
          Width = 45
          Height = 20
          MaxLength = 6
          TabOrder = 2
          OnExit = ReadPortEditExit
        end
        object ReadProxyUserIDEdit: TEdit
          Left = 88
          Top = 72
          Width = 145
          Height = 20
          MaxLength = 256
          TabOrder = 3
        end
        object ReadProxyPasswordEdit: TEdit
          Left = 320
          Top = 72
          Width = 145
          Height = 20
          MaxLength = 256
          PasswordChar = '*'
          TabOrder = 4
        end
      end
      object WriteProxyGroupBox: TGroupBox
        Left = 12
        Top = 116
        Width = 477
        Height = 105
        Caption = #12503#12525#12461#12471#35373#23450' '#65288#26360#12365#36796#12415#29992#65289
        TabOrder = 1
        object WriteAddressLabel: TLabel
          Left = 12
          Top = 48
          Width = 56
          Height = 12
          Caption = #12450#12489#12524#12473'(&D)'
          FocusControl = WriteProxyAddressEdit
        end
        object WritePortLabel: TLabel
          Left = 368
          Top = 48
          Width = 46
          Height = 12
          Caption = #12509#12540#12488'(&T)'
          FocusControl = WritePortEdit
        end
        object WriteUserIDLabel: TLabel
          Left = 12
          Top = 76
          Width = 62
          Height = 12
          Caption = #12518#12540#12470'ID(&E)'
          FocusControl = WriteProxyUserIDEdit
        end
        object WritePasswordLabel: TLabel
          Left = 244
          Top = 76
          Width = 71
          Height = 12
          Caption = #12497#12473#12527#12540#12489'(&W)'
          FocusControl = WriteProxyPasswordEdit
        end
        object WriteProxyCheck: TCheckBox
          Left = 12
          Top = 20
          Width = 173
          Height = 17
          Caption = 'HTTP'#12503#12525#12461#12471#12434#20351#29992#12377#12427'(&X)'
          TabOrder = 0
          OnClick = WriteProxyCheckClick
        end
        object WriteProxyAddressEdit: TEdit
          Left = 88
          Top = 44
          Width = 273
          Height = 20
          MaxLength = 256
          TabOrder = 1
        end
        object WritePortEdit: TEdit
          Left = 420
          Top = 44
          Width = 45
          Height = 20
          MaxLength = 6
          TabOrder = 2
          OnExit = WritePortEditExit
        end
        object WriteProxyUserIDEdit: TEdit
          Left = 88
          Top = 72
          Width = 145
          Height = 20
          MaxLength = 256
          TabOrder = 3
        end
        object WriteProxyPasswordEdit: TEdit
          Left = 320
          Top = 72
          Width = 145
          Height = 20
          MaxLength = 256
          PasswordChar = '*'
          TabOrder = 4
        end
      end
      object GroupBox4: TGroupBox
        Left = 12
        Top = 224
        Width = 477
        Height = 113
        Caption = #12508#12540#12489'URL(&U)'
        TabOrder = 2
        object Label13: TLabel
          Left = 12
          Top = 24
          Width = 155
          Height = 12
          Caption = #65298#12385#12419#12435#12397#12427#12508#12540#12489#19968#35239'URL(&N)'
        end
        object BoardURLComboBox: TComboBox
          Left = 24
          Top = 43
          Width = 417
          Height = 20
          ItemHeight = 12
          TabOrder = 0
          Text = 'BoardURLComboBox'
        end
        object AddURLButton: TButton
          Left = 278
          Top = 69
          Width = 75
          Height = 25
          Caption = #36861#21152
          TabOrder = 1
          OnClick = AddURLButtonClick
        end
        object RemoveURLButton: TButton
          Left = 366
          Top = 69
          Width = 75
          Height = 25
          Caption = #21066#38500
          TabOrder = 2
          OnClick = RemoveURLButtonClick
        end
      end
    end
    object Font1Sheet: TTabSheet
      Caption = #12501#12457#12531#12488
      ImageIndex = 1
      object Bevel1: TBevel
        Left = 8
        Top = 100
        Width = 485
        Height = 2
      end
      object Bevel2: TBevel
        Left = 8
        Top = 239
        Width = 485
        Height = 2
      end
      object Label19: TLabel
        Left = 16
        Top = 8
        Width = 103
        Height = 12
        Caption = #12461#12515#12499#12493#12483#12488#65288#12484#12522#12540#65289
      end
      object Bevel5: TBevel
        Left = 252
        Top = 4
        Width = 2
        Height = 341
      end
      object Label20: TLabel
        Left = 16
        Top = 108
        Width = 66
        Height = 12
        Caption = #12473#12524#12483#12489#12522#12473#12488
      end
      object Label21: TLabel
        Left = 16
        Top = 248
        Width = 106
        Height = 12
        Caption = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      end
      object Label22: TLabel
        Left = 268
        Top = 8
        Width = 64
        Height = 12
        Caption = #12502#12521#12454#12470#12479#12502
      end
      object Label23: TLabel
        Left = 268
        Top = 108
        Width = 82
        Height = 12
        Caption = #12456#12487#12451#12479#12486#12461#12473#12488
      end
      object lblSFont: TLabel
        Left = 268
        Top = 249
        Width = 221
        Height = 73
        AutoSize = False
        Caption = '_'
        WordWrap = True
      end
      object CabinetFontBotton: TButton
        Left = 156
        Top = 24
        Width = 85
        Height = 21
        Caption = #12501#12457#12531#12488'(&B)...'
        TabOrder = 0
        OnClick = CabinetFontBottonClick
      end
      object CabinetColorBotton: TButton
        Left = 156
        Top = 48
        Width = 85
        Height = 21
        Caption = #32972#26223#33394'(&C)...'
        TabOrder = 2
        OnClick = CabinetColorBottonClick
      end
      object CabinetDefaultButton: TButton
        Left = 156
        Top = 72
        Width = 85
        Height = 21
        Caption = #12487#12501#12457#12523#12488'(&D)'
        TabOrder = 3
        OnClick = CabinetDefaultButtonClick
      end
      object CabinetMemo: TMemo
        Left = 12
        Top = 24
        Width = 137
        Height = 69
        TabStop = False
        Lines.Strings = (
          #12461#12515#12499#12493#12483#12488)
        ReadOnly = True
        TabOrder = 1
        WantReturns = False
        WordWrap = False
      end
      object ListMemo: TMemo
        Left = 12
        Top = 124
        Width = 137
        Height = 69
        TabStop = False
        Lines.Strings = (
          #12473#12524#12483#12489#12522#12473#12488)
        ReadOnly = True
        TabOrder = 16
        WantReturns = False
        WordWrap = False
      end
      object ListFontBotton: TButton
        Left = 156
        Top = 124
        Width = 85
        Height = 21
        Caption = #12501#12457#12531#12488'(&E)...'
        TabOrder = 4
        OnClick = ListFontBottonClick
      end
      object ListColorBotton: TButton
        Left = 156
        Top = 148
        Width = 85
        Height = 21
        Caption = #32972#26223#33394'(&F)...'
        TabOrder = 5
        OnClick = ListColorBottonClick
      end
      object ListDefaultBotton: TButton
        Left = 156
        Top = 172
        Width = 85
        Height = 21
        Caption = #12487#12501#12457#12523#12488'(&G)'
        TabOrder = 6
        OnClick = ListDefaultBottonClick
      end
      object HintFontButton: TButton
        Left = 156
        Top = 264
        Width = 85
        Height = 21
        Caption = #12501#12457#12531#12488'(&H)...'
        TabOrder = 7
        OnClick = HintFontButtonClick
      end
      object HintBackButton: TButton
        Left = 156
        Top = 288
        Width = 85
        Height = 21
        Caption = #32972#26223#33394'(&I)...'
        TabOrder = 8
        OnClick = HintBackButtonClick
      end
      object HintDefaultButton: TButton
        Left = 156
        Top = 312
        Width = 85
        Height = 21
        Caption = #12487#12501#12457#12523#12488'(&J)'
        TabOrder = 9
        OnClick = HintDefaultButtonClick
      end
      object HintMemo: TMemo
        Left = 12
        Top = 264
        Width = 137
        Height = 69
        TabStop = False
        Lines.Strings = (
          #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503)
        ReadOnly = True
        TabOrder = 17
        WantReturns = False
        WordWrap = False
      end
      object EditorMemo: TMemo
        Left = 264
        Top = 124
        Width = 137
        Height = 69
        TabStop = False
        Lines.Strings = (
          #12456#12487#12451#12479#12486#12461#12473#12488)
        ReadOnly = True
        TabOrder = 18
        WantReturns = False
        WordWrap = False
      end
      object EditorFontBotton: TButton
        Left = 408
        Top = 124
        Width = 85
        Height = 21
        Caption = #12501#12457#12531#12488'(&M)...'
        TabOrder = 12
        OnClick = EditorFontBottonClick
      end
      object EditorColorBotton: TButton
        Left = 408
        Top = 148
        Width = 85
        Height = 21
        Caption = #32972#26223#33394'(&N)...'
        TabOrder = 13
        OnClick = EditorColorBottonClick
      end
      object EditorDefaultBotton: TButton
        Left = 408
        Top = 172
        Width = 85
        Height = 21
        Caption = #12487#12501#12457#12523#12488'(&O)'
        TabOrder = 14
        OnClick = EditorDefaultBottonClick
      end
      object BrowserTabMemo: TMemo
        Left = 264
        Top = 24
        Width = 137
        Height = 69
        TabStop = False
        Lines.Strings = (
          #12502#12521#12454#12470#12479#12502)
        ReadOnly = True
        TabOrder = 19
        WantReturns = False
        WordWrap = False
      end
      object BruwserTabFontButton: TButton
        Left = 408
        Top = 24
        Width = 85
        Height = 21
        Caption = #12501#12457#12531#12488'(&K)...'
        TabOrder = 10
        OnClick = BruwserTabFontButtonClick
      end
      object BrowserTabDefaultButton: TButton
        Left = 408
        Top = 48
        Width = 85
        Height = 21
        Caption = #12487#12501#12457#12523#12488'(&L)'
        TabOrder = 11
        OnClick = BrowserTabDefaultButtonClick
      end
      object OddResNumCheckBox: TCheckBox
        Left = 15
        Top = 201
        Width = 130
        Height = 17
        Caption = #12524#12473#25968#22679#28187#12473#12524#24375#35519
        TabOrder = 20
        OnClick = OddResNumCheckBoxClick
      end
      object OddResNumColorBox: TColorBox
        Left = 144
        Top = 198
        Width = 97
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
        ItemHeight = 16
        TabOrder = 21
      end
      object UnFocusedBoldCheckBox: TCheckBox
        Left = 15
        Top = 219
        Width = 210
        Height = 17
        Caption = #12501#12457#12540#12459#12473#12364#28961#12356#12392#12365#12399#22826#23383#12395#12377#12427
        TabOrder = 22
      end
      object BoardInfCheckBox: TCheckBox
        Left = 267
        Top = 201
        Width = 218
        Height = 17
        Caption = #26495#24773#22577#12418#21516#12376#35373#23450#12391#34920#31034#12377#12427
        TabOrder = 15
      end
    end
    object CSSTabSheet: TTabSheet
      Caption = 'CSS '#12392#12473#12461#12531
      ImageIndex = 10
      object GroupBox12: TGroupBox
        Left = 12
        Top = 8
        Width = 477
        Height = 329
        Caption = #12473#12479#12452#12523#12471#12540#12488#12392#12473#12461#12531
        TabOrder = 0
        object CSSListLabel: TLabel
          Left = 12
          Top = 48
          Width = 191
          Height = 12
          Caption = #12473#12479#12452#12523#12471#12540#12488#12414#12383#12399#12473#12461#12531#12398#36984#25246'(&S)'
        end
        object CSSCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 317
          Height = 17
          Caption = #12473#12524#12483#12489#34920#31034#12395#12473#12479#12452#12523#12471#12540#12488#12414#12383#12399#12473#12461#12531#12434#20351#29992#12377#12427'(&A)'
          TabOrder = 0
          OnClick = CSSCheckBoxClick
        end
        object CSSListView: TListView
          Left = 12
          Top = 64
          Width = 213
          Height = 137
          Columns = <
            item
              Caption = #12473#12479#12452#12523#12471#12540#12488#12414#12383#12399#12473#12461#12531
              Width = 180
            end>
          ColumnClick = False
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          OnChange = CSSListViewChange
        end
        object CSSBrowser: TWebBrowser
          Left = 232
          Top = 64
          Width = 233
          Height = 257
          TabOrder = 2
          ControlData = {
            4C00000015180000901A00000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
        object CSSFontCheckBox: TCheckBox
          Left = 16
          Top = 211
          Width = 113
          Height = 17
          Caption = #12501#12457#12531#12488#12434#25351#23450'(&F)'
          TabOrder = 3
          OnClick = CSSFontCheckBoxClick
        end
        object CSSBackColorCheckBox: TCheckBox
          Left = 16
          Top = 242
          Width = 113
          Height = 17
          Caption = #32972#26223#33394#12434#25351#23450'(&B)'
          TabOrder = 4
          OnClick = CSSBackColorCheckBoxClick
        end
        object CSSFontButton: TButton
          Left = 136
          Top = 208
          Width = 75
          Height = 21
          Caption = #35373#23450'...'
          Enabled = False
          TabOrder = 5
          OnClick = CSSFontButtonClick
        end
        object CSSBackColorButton: TButton
          Left = 136
          Top = 240
          Width = 75
          Height = 21
          Caption = #35373#23450'...'
          Enabled = False
          TabOrder = 6
          OnClick = CSSBackColorButtonClick
        end
        object UseKatjuTypeSkinCheckBox: TCheckBox
          Left = 16
          Top = 272
          Width = 193
          Height = 17
          Caption = #12363#12385#12421#65374#12375#12419#12398#12473#12461#12531#12434#21033#29992#12377#12427
          TabOrder = 7
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #12473#12524#12483#12489#19968#35239
      object GroupBox9: TGroupBox
        Left = 12
        Top = 8
        Width = 477
        Height = 41
        Caption = #34920#31034#35373#23450
        TabOrder = 0
        object ThreadListIconCheckBox: TCheckBox
          Left = 12
          Top = 16
          Width = 217
          Height = 17
          Caption = #12473#12524#12483#12489#26356#26032#12450#12452#12467#12531#12434#34920#31034#12377#12427'(&I)'
          TabOrder = 0
        end
      end
      object GroupBox16: TGroupBox
        Left = 12
        Top = 52
        Width = 477
        Height = 45
        Caption = #12473#12524#20316#25104#26085#26178#34920#31034#35373#23450
        TabOrder = 1
        object CreationTimeLogsCheckBox: TCheckBox
          Left = 12
          Top = 16
          Width = 217
          Height = 17
          Caption = #12525#12464#26377#12426#12473#12524#12483#12489#12398#12415#34920#31034
          TabOrder = 0
        end
        object FutureThreadCheckBox: TCheckBox
          Left = 204
          Top = 16
          Width = 265
          Height = 17
          Caption = #26085#20184#12364#26410#26469#12398#12418#12398#12399#34920#31034#12375#12394#12356#65288'924'#12473#12524#31995#65289
          TabOrder = 1
        end
      end
      object GroupBox5: TGroupBox
        Left = 12
        Top = 105
        Width = 477
        Height = 86
        Caption = #12502#12521#12454#12470#12398#26368#22823#21270
        TabOrder = 2
        object BrowserMaxLabel: TLabel
          Left = 12
          Top = 24
          Width = 6
          Height = 12
          Caption = '-'
        end
        object BrowserMaxCombo: TComboBox
          Left = 12
          Top = 56
          Width = 229
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 0
          Items.Strings = (
            #26368#22823#21270#12375#12394#12356
            #12473#12524#12483#12489#12434#12463#12522#12483#12463#12375#12383#12392#12365
            #12473#12524#12483#12489#12434#12480#12502#12523#12463#12522#12483#12463#12375#12383#12392#12365)
        end
      end
      object GroupBox17: TGroupBox
        Left = 12
        Top = 196
        Width = 477
        Height = 45
        Caption = #12502#12521#12454#12470#12479#12502#38750#34920#31034#26178#35373#23450
        TabOrder = 3
        object SelectIntervalLabel: TLabel
          Left = 10
          Top = 20
          Width = 199
          Height = 12
          Caption = #12459#12540#12477#12523#12461#12540#12391#12398#31227#21205#26178#12398#28961#21453#24540#26178#38291
        end
        object Label4: TLabel
          Left = 271
          Top = 20
          Width = 29
          Height = 12
          Caption = #12511#12522#31186
        end
        object Label6: TLabel
          Left = 305
          Top = 20
          Width = 164
          Height = 12
          Caption = #65288'55'#12511#12522#31186#20197#19978#12395#35373#23450#12375#12390#19979#12373#12356#65289
        end
        object SelectIntervalEdit: TEdit
          Left = 214
          Top = 16
          Width = 49
          Height = 20
          ImeMode = imClose
          TabOrder = 0
          Text = 'SelectIntervalEdit'
        end
      end
      object GroupBox18: TGroupBox
        Left = 12
        Top = 246
        Width = 477
        Height = 43
        Caption = 'dat'#33853#12385#12473#12524#12477#12540#12488#38918
        TabOrder = 4
        object DatOchiSortCombo: TComboBox
          Left = 12
          Top = 15
          Width = 229
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 0
          Items.Strings = (
            #12473#12524#19968#35239#12398#12477#12540#12488#38918
            #12473#12524#30058#21495'('#26119#38918')'
            #12473#12524#30058#21495'('#38477#38918')'
            #21462#24471#26085#26178'('#26119#38918')'
            #21462#24471#26085#26178'('#38477#38918')'
            #12473#12524#20316#25104#26085#26178'('#26119#38918')'
            #12473#12524#20316#25104#26085#26178'('#38477#38918')'
            #12473#12524#26368#32066#26356#26032#26085#26178#65288#26119#38918#65289
            #12473#12524#26368#32066#26356#26032#26085#26178#65288#38477#38918#65289)
        end
      end
      object GroupBox20: TGroupBox
        Left = 12
        Top = 291
        Width = 477
        Height = 41
        Caption = #12473#12524#12483#12489#19968#35239#12480#12454#12531#12525#12540#12489#24460#12398#21205#20316
        TabOrder = 5
        object Label24: TLabel
          Left = 219
          Top = 18
          Width = 142
          Height = 12
          Caption = #65288#12481#12455#12483#12463#12375#12394#12356#22580#21512#28961#20966#29702#65289
        end
        object AutoSortCheckBox: TCheckBox
          Left = 10
          Top = 16
          Width = 207
          Height = 17
          Caption = #33258#21205#12391#12473#12524#12483#12489#21517#12391#26119#38918#12477#12540#12488#12377#12427
          TabOrder = 0
        end
      end
    end
    object ThreadSheet: TTabSheet
      Caption = #12473#12524#12483#12489#65297
      ImageIndex = 5
      object GroupBox1: TGroupBox
        Left = 12
        Top = 8
        Width = 477
        Height = 94
        Caption = #34920#31034#35373#23450
        TabOrder = 0
        object Label30: TLabel
          Left = 11
          Top = 70
          Width = 271
          Height = 12
          Caption = 'Windows 11'#12391#34920#31034#12434#38459#23475#12377#12427#25991#23383'&&#78840;'#12398#25201#12356'(&C)'
          FocusControl = ReplCharComboBox
        end
        object ShowMailCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 277
          Height = 17
          Caption = #12513#12540#12523#27396#12434#34920#31034#12377#12427'(&M)'
          TabOrder = 0
        end
        object ResRangeHoldCheckBox: TCheckBox
          Left = 11
          Top = 43
          Width = 198
          Height = 17
          Caption = #36215#21205#26178#12398#12524#12473#34920#31034#31684#22258#12434#22266#23450#12377#12427
          TabOrder = 1
          OnClick = ResRangeHoldCheckBoxClick
        end
        object ResRangeHoldComboBox: TComboBox
          Left = 224
          Top = 40
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 2
          Items.Strings = (
            #12377#12409#12390#12398#12524#12473#12434#34920#31034#12377#12427
            #26368#26032'100'#12524#12473#12398#12415#34920#31034
            #26410#35501#12524#12473#12398#12415#34920#31034
            #26032#30528#12524#12473#12398#12415#34920#31034)
        end
        object DispImageCheckBox: TCheckBox
          Left = 224
          Top = 20
          Width = 249
          Height = 17
          Caption = 'BE2.0'#12450#12452#12467#12531#12539'Emoticons'#12434#30011#20687#34920#31034#12377#12427'(I)'
          TabOrder = 3
        end
        object ReplCharComboBox: TComboBox
          Left = 288
          Top = 66
          Width = 179
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 4
          Items.Strings = (
            #20309#12418#12375#12394#12356
            #25991#23383#21015#12300'&#78840;'#12301#12392#12375#12390#34920#31034
            #39006#20284#25991#23383'&#77954;'#12395#32622#12365#25563#12360)
        end
      end
      object GroupBox2: TGroupBox
        Left = 12
        Top = 108
        Width = 477
        Height = 148
        Caption = #12522#12531#12463#12463#12522#12483#12463#26178#21205#20316
        TabOrder = 1
        object AppFolderLabel: TLabel
          Left = 32
          Top = 48
          Width = 120
          Height = 12
          Caption = #12450#12503#12522#12465#12540#12471#12519#12531#12497#12473'(&L)'
          FocusControl = AppFolderEdit
        end
        object URLAppCheckBox: TCheckBox
          Left = 12
          Top = 24
          Width = 385
          Height = 17
          Caption = #12473#12524#12483#12489'URL'#12434#12463#12522#12483#12463#25351#23450#12375#12383#12392#12365#12395#25351#23450#12398#12450#12503#12522#12465#12540#12471#12519#12531#12391#38283#12367'(&P)'
          TabOrder = 0
          OnClick = URLAppCheckBoxClick
        end
        object AppFolderEdit: TEdit
          Left = 32
          Top = 64
          Width = 309
          Height = 20
          TabOrder = 1
        end
        object AppFolderButton: TButton
          Left = 350
          Top = 63
          Width = 75
          Height = 21
          Caption = #21442#29031'(&B)...'
          TabOrder = 2
          OnClick = AppFolderButtonClick
        end
        object OpenMailerCheckBox: TCheckBox
          Left = 12
          Top = 92
          Width = 301
          Height = 17
          Caption = #12473#12524#12483#12489'mailto'#12463#12522#12483#12463#26178#12395#12513#12540#12521#12540#12434#36215#21205#12377#12427'(&T)'
          TabOrder = 3
          OnClick = URLAppCheckBoxClick
        end
        object ResAnchorCheckBox: TCheckBox
          Left = 12
          Top = 118
          Width = 333
          Height = 17
          Caption = #12524#12473#12450#12531#12459#12540#12398#22580#21512#12289#12381#12398#12524#12473#12414#12391#12472#12515#12531#12503#12377#12427
          TabOrder = 4
        end
      end
      object GroupBox6: TGroupBox
        Left = 12
        Top = 264
        Width = 477
        Height = 74
        Caption = #30906#35469#12513#12483#12475#12540#12472
        TabOrder = 2
        object LogDeleteMessageCheckBox: TCheckBox
          Left = 12
          Top = 22
          Width = 321
          Height = 17
          Caption = #12525#12464#12434#21066#38500#12377#12427#12392#12365#12395#30906#35469#12513#12483#12475#12540#12472#12434#34920#31034#12377#12427'(&O)'
          TabOrder = 0
          OnClick = URLAppCheckBoxClick
        end
        object IgnoreLimitResCountCheckBox: TCheckBox
          Left = 12
          Top = 44
          Width = 389
          Height = 17
          Caption = #21516'ID'#12524#12473#12450#12531#12459#12540#34920#31034#12391#21046#38480#25968#36234#12360#12398#30906#35469#12513#12483#12475#12540#12472#12434#34920#31034#12377#12427'(&R)'
          TabOrder = 1
          OnClick = URLAppCheckBoxClick
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #12473#12524#12483#12489#65298
      ImageIndex = 7
      object TabAddRadioGroup: TRadioGroup
        Left = 12
        Top = 288
        Width = 477
        Height = 49
        Caption = #12473#12524#12483#12489#12398#12479#12502#36861#21152#20301#32622'(&D)'
        Columns = 4
        Items.Strings = (
          #19968#30058#22987#12417
          #19968#30058#26368#24460
          #29694#22312#12398#21491
          #29694#22312#12398#24038)
        TabOrder = 2
      end
      object GroupBox8: TGroupBox
        Left = 12
        Top = 176
        Width = 477
        Height = 105
        Caption = #30011#20687#12503#12524#12499#12517#12540#12509#12483#12503#12450#12483#12503
        TabOrder = 1
        object Label14: TLabel
          Left = 12
          Top = 48
          Width = 49
          Height = 12
          Caption = #12469#12452#12474'(&S)'
          FocusControl = PreviewSizeComboBox
        end
        object Label15: TLabel
          Left = 12
          Top = 76
          Width = 111
          Height = 12
          Caption = #34920#31034#12414#12391#12398#12454#12455#12452#12488'(&T)'
          FocusControl = PreviewSizeComboBox
        end
        object Label16: TLabel
          Left = 176
          Top = 76
          Width = 158
          Height = 12
          Caption = 'ms'#12288'(500'#65374'9999) 1000ms'#65309'1'#31186
        end
        object PreviewVisibleCheckBox: TCheckBox
          Left = 12
          Top = 16
          Width = 233
          Height = 17
          Caption = #30011#20687#12503#12524#12499#12517#12540#12509#12483#12503#12450#12483#12503#12434#34920#31034#12377#12427'(&V)'
          TabOrder = 0
        end
        object PreviewSizeComboBox: TComboBox
          Left = 72
          Top = 44
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 1
          Items.Strings = (
            '128 * 96 pixel'
            '256 * 192 pixel'
            '384 * 288 pixel'
            '512 * 384 pixel'
            '640 * 480 pixel')
        end
        object PreviewWaitEdit: TEdit
          Left = 132
          Top = 72
          Width = 37
          Height = 20
          MaxLength = 4
          TabOrder = 2
          OnExit = PreviewWaitEditExit
        end
      end
      object GroupBox10: TGroupBox
        Left = 12
        Top = 100
        Width = 477
        Height = 69
        Caption = #12524#12473#12509#12483#12503#12450#12483#12503#34920#31034#35373#23450
        TabOrder = 0
        object UnActivePopupCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 357
          Height = 17
          Caption = #12462#12467#12490#12499#12364#38750#12450#12463#12486#12451#12502#12391#12418#12509#12483#12503#12450#12483#12503#12434#34920#31034#12377#12427'(&U)'
          TabOrder = 0
        end
        object ResPopupBoldCheckBox: TCheckBox
          Left = 12
          Top = 44
          Width = 225
          Height = 17
          Caption = #12504#12483#12480#12540#12434#22826#23383#12391#34920#31034#12377#12427'(&B)'
          TabOrder = 1
        end
      end
      object GroupBox24: TGroupBox
        Left = 11
        Top = 10
        Width = 478
        Height = 81
        Caption = #12524#12473#12509#12483#12503#12450#12483#12503#34920#31034'(&P)'
        TabOrder = 3
        object gppRightTopRB: TRadioButton
          Left = 324
          Top = 19
          Width = 120
          Height = 20
          Caption = #21491#19978#65288#12487#12501#12457#12523#12488#65289
          TabOrder = 0
        end
        object gppTopRB: TRadioButton
          Left = 170
          Top = 19
          Width = 120
          Height = 20
          Caption = #19978
          TabOrder = 1
        end
        object gppLeftTopRB: TRadioButton
          Left = 8
          Top = 19
          Width = 120
          Height = 20
          Caption = #24038#19978
          TabOrder = 2
        end
        object gppLeftRB: TRadioButton
          Left = 8
          Top = 39
          Width = 120
          Height = 20
          Caption = #24038
          TabOrder = 3
        end
        object gppRightRB: TRadioButton
          Left = 324
          Top = 39
          Width = 120
          Height = 20
          Caption = #21491
          TabOrder = 4
        end
        object gppLeftBottomRB: TRadioButton
          Left = 8
          Top = 59
          Width = 120
          Height = 20
          Caption = #24038#19979
          TabOrder = 5
        end
        object gppBottomRB: TRadioButton
          Left = 170
          Top = 59
          Width = 120
          Height = 20
          Caption = #19979
          TabOrder = 6
        end
        object gppRighBottomRB: TRadioButton
          Left = 324
          Top = 59
          Width = 120
          Height = 20
          Caption = #21491#19979
          TabOrder = 7
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #12381#12398#20182#21205#20316#65297
      ImageIndex = 8
      object GroupBox7: TGroupBox
        Left = 12
        Top = 8
        Width = 477
        Height = 108
        Caption = #12450#12489#12524#12473#12496#12540
        TabOrder = 0
        object Label3: TLabel
          Left = 12
          Top = 82
          Width = 73
          Height = 12
          Caption = 'URL'#20445#23384#25968'(&S)'
          FocusControl = AddressHistoryCountEdit
        end
        object Label11: TLabel
          Left = 150
          Top = 82
          Width = 12
          Height = 12
          Caption = #20491
        end
        object URLDisplayCheckBox: TCheckBox
          Left = 12
          Top = 18
          Width = 389
          Height = 17
          Caption = #12473#12524#12483#12489#12434#38283#12356#12383#12392#12365#12395#12289#12450#12489#12524#12473#12496#12540#12395'URL'#12434#34920#31034#12377#12427'(&D)'
          TabOrder = 0
        end
        object AddressHistoryCountEdit: TEdit
          Left = 100
          Top = 78
          Width = 45
          Height = 20
          TabOrder = 3
          OnExit = AddressHistoryCountEditExit
        end
        object TabStopAddressBarCheckBox: TCheckBox
          Left = 12
          Top = 38
          Width = 389
          Height = 17
          Caption = #12479#12502#12461#12540#12391#12450#12489#12524#12473#12496#12540#12395#31227#21205#12391#12365#12427#12424#12358#12395#12377#12427'(&T)'
          TabOrder = 1
        end
        object LinkAddCheckBox: TCheckBox
          Left = 12
          Top = 58
          Width = 413
          Height = 17
          Caption = #12502#12521#12454#12470#12398#12522#12531#12463#12434#12463#12522#12483#12463#12375#12383#12392#12365#12395' '#12450#12489#12524#12473#12496#12540#23653#27508#12395'URL'#12434#36861#21152#12377#12427'(&L)'
          TabOrder = 2
        end
      end
      object GroupBox15: TGroupBox
        Left = 12
        Top = 124
        Width = 478
        Height = 66
        Caption = #30906#35469#12480#12452#12450#12525#12464
        TabOrder = 1
        object ShowDialogForEndCheckBox: TCheckBox
          Left = 12
          Top = 18
          Width = 204
          Height = 17
          Caption = #32066#20102#26178#12395#30906#35469#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
          TabOrder = 0
        end
        object AllTabCloseCheckBox: TCheckBox
          Left = 12
          Top = 38
          Width = 344
          Height = 17
          Caption = #20840#12390#12398#12479#12502#12434#38281#12376#12427#12392#12365#12395#30906#35469#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
          TabOrder = 1
        end
      end
      object Other1GroupBox: TGroupBox
        Left = 12
        Top = 199
        Width = 477
        Height = 130
        Caption = #65298#12385#12419#12435#12397#12427
        TabOrder = 2
        object UseSambaCheckBox: TCheckBox
          Left = 12
          Top = 18
          Width = 153
          Height = 17
          Caption = 'Samba24'#23550#31574#27231#33021#12434#20351#12358
          TabOrder = 0
        end
        object ThreadTitleTrimCheckBox: TCheckBox
          Left = 12
          Top = 38
          Width = 453
          Height = 17
          Caption = #12473#12524#12479#12452#12398'['#36578#36617#31105#27490']'#12392#12300'&&copy;2ch.net'#12301#12289#12300'&&copy;bbspink.com'#12301#12434#34920#31034#12375#12394#12356
          TabOrder = 1
        end
        object URLitestCheckBox: TCheckBox
          Left = 12
          Top = 58
          Width = 435
          Height = 17
          Caption = 'URL'#12467#12500#12540#21450#12403'WEB'#12502#12521#12454#12470#34920#31034#12539#12450#12489#12524#12473#12496#12540#34920#31034#12395'itest'#29256'URL'#12434#20351#29992#12377#12427
          TabOrder = 2
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #12381#12398#20182#21205#20316#65298
      ImageIndex = 11
      object GroupBox13: TGroupBox
        Left = 12
        Top = 8
        Width = 473
        Height = 46
        Caption = #12473#12524#12483#12489#32094#36796#12415
        TabOrder = 0
        object UseUndecidedCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 213
          Height = 17
          Caption = #26410#30906#23450#20837#21147#12391#12398#32094#36796#12415#12434#26377#21177#12395#12377#12427
          TabOrder = 0
        end
      end
      object GroupBox21: TGroupBox
        Left = 12
        Top = 58
        Width = 473
        Height = 46
        Caption = #26368#23567#21270#26178#12479#12473#12463#12488#12524#12452
        TabOrder = 1
        object StoredTaskTrayCB: TCheckBox
          Left = 12
          Top = 20
          Width = 118
          Height = 17
          Caption = #26377#21177#12395#12377#12427
          TabOrder = 0
        end
      end
      object GroupBox22: TGroupBox
        Left = 12
        Top = 108
        Width = 473
        Height = 66
        Caption = #12502#12521#12454#12470#12479#12502
        TabOrder = 2
        object TabLoadSave: TCheckBox
          Left = 12
          Top = 20
          Width = 251
          Height = 17
          Caption = #32066#20102#26178#12395#12479#12502#12398#38918#30058#12434#33258#21205#20445#23384#12539#33258#21205#24489#20803
          TabOrder = 0
        end
        object LoopBrowserTabsCB: TCheckBox
          Left = 12
          Top = 40
          Width = 134
          Height = 17
          Caption = #12523#12540#12503#12375#12390#31227#21205#12377#12427
          TabOrder = 1
        end
      end
      object GroupBox23: TGroupBox
        Left = 12
        Top = 180
        Width = 473
        Height = 48
        Caption = #12510#12454#12473#12472#12455#12473#12481#12515#12540
        TabOrder = 3
        object IgnoreContextCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 294
          Height = 17
          Caption = #12467#12531#12486#12461#12473#12488#19978#12391#12510#12454#12473#12472#12455#12473#12481#12515#12540#12434#28961#21177#12395#12377#12427
          TabOrder = 0
        end
      end
      object GroupBox26: TGroupBox
        Left = 12
        Top = 234
        Width = 473
        Height = 94
        Caption = #12524#12473#12456#12487#12451#12479
        TabOrder = 4
        object PreviewStyleCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 274
          Height = 17
          Caption = #12503#12524#12499#12517#12540#34920#31034#12395'CSS'#12414#12383#12399#12473#12461#12531#12434#36969#29992
          TabOrder = 0
        end
        object OekakiCheckBox: TCheckBox
          Left = 12
          Top = 40
          Width = 177
          Height = 17
          Caption = #12362#32117#25551#12365#65288#30011#20687#28155#20184#65289#26377#21177
          TabOrder = 1
        end
        object ReloadAfterWriteCheckBox: TCheckBox
          Left = 12
          Top = 60
          Width = 397
          Height = 17
          Caption = #26360#12365#36796#12415#25104#21151#26178#12395#23550#35937#12398#12473#12524#12483#12489#19968#35239#12414#12383#12399#12473#12524#12483#12489#12434#20877#35501#12415#36796#12415#12377#12427
          TabOrder = 2
        end
      end
    end
    object SoundSheet: TTabSheet
      Caption = #12469#12454#12531#12489
      ImageIndex = 6
      object SoundEventGroupBox: TGroupBox
        Left = 12
        Top = 8
        Width = 477
        Height = 205
        Caption = #12469#12454#12531#12489#12452#12505#12531#12488
        TabOrder = 0
        object SoundListView: TListView
          Left = 12
          Top = 20
          Width = 449
          Height = 145
          Columns = <
            item
              Caption = #12452#12505#12531#12488
              Width = 120
            end
            item
              Caption = #12501#12449#12452#12523
              Width = 260
            end>
          ColumnClick = False
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnChanging = SoundListViewChanging
        end
        object SoundReferButton: TButton
          Left = 392
          Top = 172
          Width = 67
          Height = 21
          Caption = #21442#29031'(&B)...'
          TabOrder = 3
          OnClick = SoundReferButtonClick
        end
        object SoundFileEdit: TEdit
          Left = 8
          Top = 172
          Width = 341
          Height = 20
          TabOrder = 1
          OnChange = SoundFileEditChange
        end
        object SoundPlayButton: TBitBtn
          Left = 356
          Top = 172
          Width = 29
          Height = 21
          TabOrder = 2
          OnClick = SoundPlayButtonClick
          Glyph.Data = {
            CE000000424DCE0000000000000076000000280000000B0000000B0000000100
            04000000000058000000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555550
            0000555505555550000055550055555000005555000555500000555500005550
            0000555500000550000055550000555000005555000555500000555500555550
            000055550555555000005555555555500000}
        end
      end
    end
    object FolderSheet: TTabSheet
      Caption = #12501#12457#12523#12480
      ImageIndex = 5
      object FolderGroupBox: TGroupBox
        Left = 12
        Top = 8
        Width = 477
        Height = 109
        Caption = #12525#12464#12501#12457#12523#12480
        TabOrder = 0
        object Label1: TLabel
          Left = 12
          Top = 88
          Width = 210
          Height = 12
          Caption = #8251#12462#12467#12490#12499#12434#20877#36215#21205#12377#12427#12392#26377#21177#12395#12394#12426#12414#12377
        end
        object Label2: TLabel
          Left = 12
          Top = 20
          Width = 135
          Height = 12
          Caption = #12525#12464#12434#20445#23384#12377#12427#12501#12457#12523#12480'(&F)'
          FocusControl = LogFolderEdit
        end
        object Label5: TLabel
          Left = 12
          Top = 72
          Width = 269
          Height = 12
          Caption = #8251#26410#20837#21147#12398#22580#21512#12399#12487#12501#12457#12523#12488#12398#12501#12457#12523#12480#12434#20351#29992#12375#12414#12377
        end
        object LogFolderEdit: TEdit
          Left = 12
          Top = 40
          Width = 369
          Height = 20
          TabOrder = 0
        end
        object LogFolderButton: TButton
          Left = 388
          Top = 40
          Width = 75
          Height = 21
          Caption = #21442#29031'(&B)...'
          TabOrder = 1
          OnClick = LogFolderButtonClick
        end
      end
    end
    object NGwordSheet: TTabSheet
      Caption = #12354#12412#65374#12435
      ImageIndex = 11
      object GroupBox14: TGroupBox
        Left = 12
        Top = 8
        Width = 477
        Height = 202
        Caption = #12354#12412#65374#12435
        TabOrder = 0
        object RloCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 389
          Height = 17
          Caption = '&&rlo;'#12392'&&lro;'#21442#29031#25991#23383#12434#28961#35222#12377#12427'(&F)'#12288#65288'Win98+IE6'#12518#12540#12470#12540#12481#12455#12483#12463#25512#22888#65289
          TabOrder = 0
        end
        object ReplaceulCheckBox: TCheckBox
          Left = 12
          Top = 64
          Width = 221
          Height = 17
          Caption = '<ul>'#12479#12464#12434'<br>'#12479#12464#12395#32622#25563#12377#12427'(&R)'
          TabOrder = 1
        end
        object PopUpAbonCheckBox: TCheckBox
          Left = 12
          Top = 86
          Width = 221
          Height = 17
          Caption = #12524#12473#12509#12483#12503#12450#12483#12503#26178#12398#12354#12412#65374#12435#26377#21177'(&P)'
          TabOrder = 2
        end
        object ShowNGLineCheckBox: TCheckBox
          Left = 12
          Top = 108
          Width = 181
          Height = 17
          Caption = 'NG'#12501#12449#12452#12523#12398#34892#25968#12434#34920#31034'(&N)'
          TabOrder = 3
        end
        object AddResAnchorCheckBox: TCheckBox
          Left = 12
          Top = 130
          Width = 205
          Height = 17
          Caption = #65326#65319#12524#12473#12408#12398#12524#12473#12450#12531#12459#12540#12398#36861#21152'(&A)'
          TabOrder = 4
        end
        object DeleteSyriaCheckBox: TCheckBox
          Left = 12
          Top = 42
          Width = 205
          Height = 17
          Caption = #12471#12522#12450#35486#12502#12521#12463#12521#23550#31574#12434#12377#12427'(&S)'
          TabOrder = 5
        end
        object IgnoreKanaCheckBox: TCheckBox
          Left = 12
          Top = 152
          Width = 332
          Height = 17
          Caption = #20840#35282#21322#35282#12402#12425#12364#12394#12459#12479#12459#12490#12398#36949#12356#12434#28961#35222#12377#12427'(&K)'
          TabOrder = 6
        end
        object KeepNgFileCheckBox: TCheckBox
          Left = 12
          Top = 174
          Width = 462
          Height = 17
          Caption = #12473#12524#20840#20307#20877#21462#24471#26178#12395#25163#21205#12354#12412#65374#12435#24773#22577#12434#12463#12522#12450#12375#12394#12356'(&E) '#65288#12354#12412#65374#12435#26908#20986#12539#24375#21046#20877#21462#24471#65289
          TabOrder = 7
        end
      end
      object SpamFilterGroupBox: TGroupBox
        Left = 12
        Top = 291
        Width = 477
        Height = 49
        Caption = #12473#12497#12512#12501#12451#12523#12479
        TabOrder = 2
        Visible = False
        object SpamFilterAlgorithmComboBox: TComboBox
          Left = 12
          Top = 18
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 0
          Text = #20351#29992#12375#12394#12356
          Items.Strings = (
            #20351#29992#12375#12394#12356
            #20351#29992#12377#12427)
        end
      end
      object GroupBox28: TGroupBox
        Left = 12
        Top = 218
        Width = 477
        Height = 49
        Caption = 'NG'#12527#12540#12489#32232#38598
        TabOrder = 1
        object NGTextEditCheckBox: TCheckBox
          Left = 12
          Top = 20
          Width = 349
          Height = 17
          Caption = #12513#12514#24115#12394#12393#12398#12486#12461#12473#12488#12456#12487#12451#12479#12434#20351#29992#12377#12427'(&T)'
          TabOrder = 0
        end
      end
    end
    object UserIDSheet: TTabSheet
      Caption = #65298#12385#12419#12435#12397#12427
      ImageIndex = 9
      object GroupBox3: TGroupBox
        Left = 12
        Top = 6
        Width = 477
        Height = 84
        Caption = #35469#35388
        TabOrder = 0
        object Label9: TLabel
          Left = 12
          Top = 18
          Width = 63
          Height = 12
          Caption = #12518#12540#12470'ID(&U)'
          FocusControl = UserIDEdit
        end
        object Label10: TLabel
          Left = 12
          Top = 40
          Width = 69
          Height = 12
          Caption = #12497#12473#12527#12540#12489'(&P)'
          FocusControl = PasswordEdit
        end
        object Tora3URLLabel: TLabel
          Left = 329
          Top = 62
          Width = 110
          Height = 12
          Caption = 'https://uplift.5ch.net/'
          Font.Charset = SHIFTJIS_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = Tora3URLLabelClick
        end
        object Label12: TLabel
          Left = 237
          Top = 62
          Width = 83
          Height = 12
          Caption = #12518#12540#12470'ID'#12398#21462#24471
        end
        object UserIDEdit: TEdit
          Left = 88
          Top = 14
          Width = 377
          Height = 20
          TabOrder = 0
        end
        object PasswordEdit: TEdit
          Left = 88
          Top = 36
          Width = 377
          Height = 20
          PasswordChar = '*'
          TabOrder = 1
        end
        object AutoLoginCheckBox: TCheckBox
          Left = 12
          Top = 60
          Width = 193
          Height = 17
          Caption = #36215#21205#26178#12395#33258#21205#12525#12464#12452#12531#12377#12427'(&S)'
          TabOrder = 2
        end
      end
      object GroupBox11: TGroupBox
        Left = 12
        Top = 96
        Width = 477
        Height = 82
        Caption = 'Be 2ch'
        TabOrder = 1
        object Label7: TLabel
          Left = 8
          Top = 18
          Width = 90
          Height = 12
          Caption = #12513#12540#12523#12450#12489#12524#12473'(&M)'
          FocusControl = BeUserIDEdit
        end
        object Label8: TLabel
          Left = 18
          Top = 40
          Width = 71
          Height = 12
          Caption = #12497#12473#12527#12540#12489'(&W)'
          FocusControl = BeCodeEdit
        end
        object BeUserIDEdit: TEdit
          Left = 104
          Top = 14
          Width = 353
          Height = 20
          TabOrder = 0
        end
        object BeCodeEdit: TEdit
          Left = 104
          Top = 36
          Width = 353
          Height = 20
          PasswordChar = '*'
          TabOrder = 1
        end
        object BeAutoLoginCheckBox: TCheckBox
          Left = 12
          Top = 60
          Width = 193
          Height = 17
          Caption = #36215#21205#26178#12395#33258#21205#12525#12464#12452#12531#12377#12427'(&T)'
          TabOrder = 2
        end
      end
      object GroupBox29: TGroupBox
        Left = 12
        Top = 186
        Width = 477
        Height = 146
        Caption = #12393#12435#12368#12426#12471#12473#12486#12512
        TabOrder = 2
        object Label27: TLabel
          Left = 12
          Top = 120
          Width = 177
          Height = 12
          Caption = 'User-Agent'#12496#12540#12472#12519#12531#30058#21495#22266#23450'(&V)'
          FocusControl = UAVerComboBox
        end
        object Label25: TLabel
          Left = 12
          Top = 96
          Width = 52
          Height = 12
          Caption = #36215#21205#26178'(G)'
          FocusControl = DonAutoLgnComboBox
        end
        object UAVerComboBox: TComboBox
          Left = 195
          Top = 116
          Width = 270
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 2
        end
        object GroupBox25: TGroupBox
          Left = 12
          Top = 20
          Width = 452
          Height = 66
          Caption = #35686#20633#21729#12450#12459#12454#12531#12488
          TabOrder = 0
          object Label28: TLabel
            Left = 12
            Top = 20
            Width = 89
            Height = 12
            Caption = #12513#12540#12523#12450#12489#12524#12473'(&A)'
            FocusControl = DonMailEdit
          end
          object Label29: TLabel
            Left = 12
            Top = 42
            Width = 70
            Height = 12
            Caption = #12497#12473#12527#12540#12489'(&D)'
            FocusControl = DonPwdEdit
          end
          object DonMailEdit: TEdit
            Left = 107
            Top = 16
            Width = 332
            Height = 20
            TabOrder = 0
          end
          object DonPwdEdit: TEdit
            Left = 107
            Top = 38
            Width = 332
            Height = 20
            PasswordChar = '*'
            TabOrder = 1
          end
        end
        object DonAutoLgnComboBox: TComboBox
          Left = 70
          Top = 92
          Width = 395
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 1
          Text = #33258#21205#12525#12464#12452#12531#12375#12394#12356
          Items.Strings = (
            #33258#21205#12525#12464#12452#12531#12375#12394#12356
            #33258#21205#12525#12464#12452#12531#12377#12427
            #33258#21205#12391#12495#12531#12479#12540#12392#12375#12390#12513#12540#12523#12525#12464#12452#12531
            #33258#21205#12391#35686#20633#21729#12392#12375#12390#12513#12540#12523#12525#12464#12452#12531)
        end
      end
    end
  end
  object OkBotton: TButton
    Left = 136
    Top = 400
    Width = 89
    Height = 21
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnClick = OkBottonClick
  end
  object FontDialog: TFontDialog
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    Options = [fdAnsiOnly, fdEffects]
    Left = 8
    Top = 396
  end
  object ColorDialog: TColorDialog
    Options = [cdSolidColor]
    Left = 40
    Top = 396
  end
  object OpenDialog: TOpenDialog
    Title = #12501#12449#12452#12523#12398#21442#29031
    Left = 72
    Top = 396
  end
end
