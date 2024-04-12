object KuroutOption: TKuroutOption
  Left = 323
  Top = 173
  BorderStyle = bsDialog
  Caption = #35443#32048#35373#23450
  ClientHeight = 422
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 517
    Height = 393
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #35443#32048#35373#23450#65297
      object GroupBox11: TGroupBox
        Left = 12
        Top = 8
        Width = 477
        Height = 101
        Caption = #25509#32154#35373#23450
        TabOrder = 0
        object Label17: TLabel
          Left = 12
          Top = 24
          Width = 114
          Height = 12
          Caption = #21463#20449#12496#12483#12501#12449#12469#12452#12474'(&B)'
          Enabled = False
          FocusControl = RecvBufferSize
        end
        object Label18: TLabel
          Left = 188
          Top = 24
          Width = 94
          Height = 12
          Caption = #65288#12487#12501#12457#12523#12488'=4096'#65289
          Enabled = False
        end
        object Label6: TLabel
          Left = 16
          Top = 52
          Width = 100
          Height = 12
          Caption = #12479#12452#12512#12450#12454#12488#26178#38291'(&T)'
          FocusControl = ReadTimeOut
        end
        object Label7: TLabel
          Left = 190
          Top = 51
          Width = 119
          Height = 12
          Caption = #65288#12487#12501#12457#12523#12488'=10000 ms'#65289
        end
        object RecvBufferSize: TEdit
          Left = 140
          Top = 20
          Width = 41
          Height = 20
          Enabled = False
          MaxLength = 5
          TabOrder = 0
        end
        object ProxyProtocolCheckBox: TCheckBox
          Left = 196
          Top = 72
          Width = 269
          Height = 17
          Caption = #12503#12525#12461#12471#25509#32154#12391' HTTP 1.1 '#12434#20351#29992#12377#12427'(&Y)'
          TabOrder = 2
        end
        object ProtocolCheckBox: TCheckBox
          Left = 12
          Top = 72
          Width = 149
          Height = 17
          Caption = 'HTTP 1.1 '#12434#20351#29992#12377#12427'(&H)'
          TabOrder = 1
        end
        object ReadTimeOut: TEdit
          Left = 140
          Top = 48
          Width = 42
          Height = 20
          TabOrder = 3
        end
      end
      object GroupBox13: TGroupBox
        Left = 12
        Top = 116
        Width = 477
        Height = 113
        Caption = #26360#12365#36796#12415'time'#12398#25351#23450
        TabOrder = 1
        object Label24: TLabel
          Left = 12
          Top = 20
          Width = 388
          Height = 12
          Caption = #12371#12398#35373#23450#12399#19978#32026#32773#21521#12369#12391#12377#12290#24847#21619#12364#20998#12363#12425#12394#12356#22580#21512#12399#22793#26356#12375#12394#12356#12391#12367#12384#12373#12356#12290
        end
        object Label25: TLabel
          Left = 12
          Top = 36
          Width = 218
          Height = 12
          Caption = #38291#36949#12387#12383#35373#23450#12434#34892#12358#12392#12289#21205#20316#12375#12394#12367#12394#12426#12414#12377#12290
        end
        object PostTimeLabel: TLabel
          Left = 12
          Top = 88
          Width = 94
          Height = 12
          Caption = #12510#12471#12531#26178#21051#12363#12425'(&O)'
        end
        object Label27: TLabel
          Left = 164
          Top = 88
          Width = 12
          Height = 12
          Caption = #31186
        end
        object PostTimeCheckBox: TCheckBox
          Left = 12
          Top = 60
          Width = 389
          Height = 17
          Caption = #26360#12365#36796#12415#26178#12395#12510#12471#12531#26178#21051#12434#20351#29992#12377#12427'(&C)'
          TabOrder = 0
        end
        object PostTimeEdit: TEdit
          Left = 116
          Top = 84
          Width = 41
          Height = 20
          MaxLength = 4
          TabOrder = 1
        end
        object PutPostTimeRadioButton: TRadioButton
          Left = 184
          Top = 84
          Width = 81
          Height = 17
          Caption = #36914#12417#12427'(&P)'
          TabOrder = 2
        end
        object BackPostTimeRadioButton: TRadioButton
          Left = 268
          Top = 84
          Width = 85
          Height = 17
          Caption = #36933#12425#12379#12427'(&B)'
          TabOrder = 3
        end
      end
      object GroupBox1: TGroupBox
        Left = 14
        Top = 232
        Width = 475
        Height = 57
        Caption = #12395#12385#12419#12435#35486#26696#20869#27231#33021
        TabOrder = 2
        object Label5: TLabel
          Left = 8
          Top = 16
          Width = 234
          Height = 12
          Caption = #12395#12385#12419#12435#35486#12434#20351#12387#12390#12462#12467#12490#12499#12434#12469#12509#12540#12488#12375#12414#12377#12290
        end
        object GengoSupport: TCheckBox
          Left = 8
          Top = 32
          Width = 201
          Height = 17
          Caption = #12395#12385#12419#12435#35486#26696#20869#27231#33021#12434#26377#21177#12395#12377#12427
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 14
        Top = 293
        Width = 473
        Height = 57
        Caption = #26360#12365#36796#12415'Ini'#12501#12449#12452#12523
        TabOrder = 3
        object Label13: TLabel
          Left = 13
          Top = 24
          Width = 58
          Height = 12
          Caption = #26368#22823#12469#12452#12474
        end
        object Label14: TLabel
          Left = 160
          Top = 24
          Width = 282
          Height = 12
          Caption = 'MB ('#26368#22823#12469#12452#12474#12434#36229#12360#12427#12392#12501#12449#12452#12523#12399#12522#12493#12540#12512#12373#12428#12414#12377#65289
        end
        object SentIniFileSizeEdit: TEdit
          Left = 83
          Top = 20
          Width = 54
          Height = 20
          TabOrder = 0
          Text = '100'
        end
        object SentIniFileSizeUpDown: TUpDown
          Left = 137
          Top = 20
          Width = 15
          Height = 20
          Associate = SentIniFileSizeEdit
          Position = 100
          TabOrder = 1
        end
      end
    end
    object ColumnTabSheet: TTabSheet
      Caption = #35443#32048#35373#23450'2'
      ImageIndex = 1
      object CategoryColumnGroupBox: TGroupBox
        Left = 8
        Top = 16
        Width = 481
        Height = 145
        Caption = #34920#31034#12459#12521#12512#35373#23450'('#12459#12486#12468#12522#12540')'
        TabOrder = 0
        object Label1: TLabel
          Left = 80
          Top = 16
          Width = 60
          Height = 12
          Caption = #38750#34920#31034#38917#30446
        end
        object Label2: TLabel
          Left = 312
          Top = 16
          Width = 48
          Height = 12
          Caption = #34920#31034#38917#30446
        end
        object CUnVisibledListBox: TListBox
          Left = 32
          Top = 33
          Width = 161
          Height = 65
          ItemHeight = 12
          TabOrder = 0
        end
        object CVisibledListBox: TListBox
          Left = 264
          Top = 33
          Width = 161
          Height = 65
          ItemHeight = 12
          TabOrder = 1
        end
        object CAddButton: TButton
          Left = 200
          Top = 38
          Width = 57
          Height = 25
          Caption = '>>'
          TabOrder = 2
          OnClick = CAddButtonClick
        end
        object CDeleteButton: TButton
          Left = 200
          Top = 70
          Width = 57
          Height = 25
          Caption = '<<'
          TabOrder = 3
          OnClick = CDeleteButtonClick
        end
        object CUpButton: TButton
          Left = 264
          Top = 104
          Width = 75
          Height = 25
          Caption = #19978#12408
          TabOrder = 4
          OnClick = CUpButtonClick
        end
        object CDownButton: TButton
          Left = 352
          Top = 104
          Width = 75
          Height = 25
          Caption = #19979#12504
          TabOrder = 5
          OnClick = CDownButtonClick
        end
      end
      object BoardColumnGroupBox: TGroupBox
        Left = 8
        Top = 168
        Width = 481
        Height = 185
        Caption = #34920#31034#12459#12521#12512#35373#23450'('#26495')'
        TabOrder = 1
        object Label3: TLabel
          Left = 80
          Top = 16
          Width = 60
          Height = 12
          Caption = #38750#34920#31034#38917#30446
        end
        object Label4: TLabel
          Left = 312
          Top = 16
          Width = 48
          Height = 12
          Caption = #34920#31034#38917#30446
        end
        object BUnVisibledListBox: TListBox
          Left = 32
          Top = 31
          Width = 161
          Height = 113
          ItemHeight = 12
          TabOrder = 0
        end
        object BVisibledListBox: TListBox
          Left = 264
          Top = 31
          Width = 161
          Height = 113
          ItemHeight = 12
          TabOrder = 1
        end
        object BAddButton: TButton
          Left = 200
          Top = 48
          Width = 57
          Height = 25
          Caption = '>>'
          TabOrder = 2
          OnClick = BAddButtonClick
        end
        object BDeleteButton: TButton
          Left = 200
          Top = 80
          Width = 57
          Height = 25
          Caption = '<<'
          TabOrder = 3
          OnClick = BDeleteButtonClick
        end
        object BUpButton: TButton
          Left = 264
          Top = 152
          Width = 75
          Height = 25
          Caption = #19978#12408
          TabOrder = 4
          OnClick = BUpButtonClick
        end
        object BDownButton: TButton
          Left = 352
          Top = 152
          Width = 75
          Height = 25
          Caption = #19979#12504
          TabOrder = 5
          OnClick = BDownButtonClick
        end
      end
    end
    object KakikomiTabSheet: TTabSheet
      Caption = #35443#32048#35373#23450'3'
      ImageIndex = 2
      object CookieGroupBox: TGroupBox
        Left = 16
        Top = 16
        Width = 473
        Height = 97
        Caption = #12463#12483#12461#12540
        TabOrder = 0
        object Label8: TLabel
          Left = 16
          Top = 20
          Width = 59
          Height = 12
          Caption = #22266#23450'Cookie'
        end
        object Label9: TLabel
          Left = 20
          Top = 67
          Width = 321
          Height = 12
          Caption = '2'#12385#12419#12435#12397#12427#12408#12398#26360#12365#36796#12415#12398#38555#12395#65380#19978#35352#12398#25991#23383#21015#12434#24120#12395#36865#20449#12377#12427
        end
        object FixedCookieEdit: TEdit
          Left = 16
          Top = 40
          Width = 441
          Height = 20
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 16
        Top = 118
        Width = 473
        Height = 43
        Caption = #12522#12531#12463#31227#21205#23653#27508
        TabOrder = 1
        object Label10: TLabel
          Left = 8
          Top = 20
          Width = 84
          Height = 12
          Caption = #23653#27508#26368#22823#20445#25345#25968
        end
        object Label11: TLabel
          Left = 227
          Top = 20
          Width = 158
          Height = 12
          Caption = #65288#12487#12501#12457#12523#12488'=20 '#20877#36215#21205#24460#26377#21177#65289
        end
        object MoveHistoryMaxEdit: TEdit
          Left = 112
          Top = 16
          Width = 105
          Height = 20
          TabOrder = 0
          OnExit = MoveHistoryMaxEditExit
        end
      end
      object AHandredGroupBox: TGroupBox
        Left = 16
        Top = 168
        Width = 473
        Height = 49
        Caption = '100'#12524#12473#34920#31034#35373#23450
        TabOrder = 2
        object AHandredLabeledEdit: TLabeledEdit
          Left = 96
          Top = 19
          Width = 73
          Height = 20
          EditLabel.Width = 81
          EditLabel.Height = 12
          EditLabel.Caption = #20808#38957#34920#31034#12524#12473#25968
          LabelPosition = lpLeft
          TabOrder = 0
          Text = '1'
          OnExit = AHandredLabeledEditExit
        end
        object AHandredUpDown: TUpDown
          Left = 169
          Top = 19
          Width = 15
          Height = 20
          Associate = AHandredLabeledEdit
          Min = 1
          Position = 1
          TabOrder = 1
        end
        object ResRangeLabeledEdit: TLabeledEdit
          Left = 317
          Top = 18
          Width = 121
          Height = 20
          EditLabel.Width = 113
          EditLabel.Height = 12
          EditLabel.Caption = #34920#31034#12524#12473#25968'(100-9999)'
          ImeMode = imDisable
          LabelPosition = lpLeft
          TabOrder = 2
          Text = '100'
          OnExit = ResRangeLabeledEditExit
        end
        object ResRangeCountUpDown: TUpDown
          Left = 438
          Top = 18
          Width = 17
          Height = 20
          Associate = ResRangeLabeledEdit
          Min = 100
          Max = 9999
          Position = 100
          TabOrder = 3
          Thousands = False
        end
      end
      object ThreadGroupBox: TGroupBox
        Left = 16
        Top = 224
        Width = 473
        Height = 113
        Caption = #12473#12524#12483#12489
        TabOrder = 3
        object Label15: TLabel
          Left = 11
          Top = 64
          Width = 225
          Height = 12
          Caption = #8251#23550#35937#12392#12377#12427#25313#24373#23376#12434' ; '#12391#12388#12394#12370#12390#12367#12384#12373#12356#12290
        end
        object AddKeywordCheckBox: TCheckBox
          Left = 12
          Top = 19
          Width = 233
          Height = 17
          Caption = #38306#36899#12461#12540#12527#12540#12489#12398#12522#12531#12463#12434#36861#21152#12377#12427
          TabOrder = 0
        end
        object ExtListLabeledEdit: TLabeledEdit
          Left = 96
          Top = 43
          Width = 361
          Height = 20
          EditLabel.Width = 82
          EditLabel.Height = 12
          EditLabel.Caption = 'URL'#21462#24471#25313#24373#23376
          LabelPosition = lpLeft
          TabOrder = 1
          OnExit = ExtListLabeledEditExit
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #35443#32048#35373#23450'4'
      ImageIndex = 3
      object SecurityGroupBox: TGroupBox
        Left = 16
        Top = 16
        Width = 473
        Height = 154
        Caption = #12475#12461#12517#12522#12486#12451
        TabOrder = 0
        object Label12: TLabel
          Left = 23
          Top = 108
          Width = 374
          Height = 12
          Caption = #8251#26377#21177#12395#12375#12383#22580#21512#12289'dat'#12398#20869#23481#12364#12469#12540#12496#19978#12398#12418#12398#12392#30064#12394#12427#22580#21512#12364#12354#12426#12414#12377#12290
        end
        object GroupBox2: TGroupBox
          Left = 20
          Top = 20
          Width = 427
          Height = 57
          Caption = #65420#65404#65393#65413#65412#65431#65391#65420#65439#35686#21578#27231#33021
          TabOrder = 0
          object LocalTrapAtt: TCheckBox
            Left = 16
            Top = 16
            Width = 241
            Height = 17
            Caption = #12525#12540#12459#12523#12501#12471#12450#12490#12488#12521#12483#12503#35686#21578#12434#26377#21177#12395#12377#12427
            TabOrder = 0
          end
          object RemoteTrapAtt: TCheckBox
            Left = 16
            Top = 35
            Width = 233
            Height = 17
            Caption = #12522#12514#12540#12488#12501#12471#12450#12490#12488#12521#12483#12503#35686#21578#12434#26377#21177#12395#12377#12427
            TabOrder = 1
          end
        end
        object ReplaceDatCheckBox: TCheckBox
          Left = 23
          Top = 88
          Width = 345
          Height = 17
          Caption = #12475#12461#12517#12522#12486#12451#23550#31574#12477#12501#12488#12398#35492#21453#24540#23550#31574
          TabOrder = 1
        end
        object UseGobakuCheckBox: TCheckBox
          Left = 23
          Top = 128
          Width = 345
          Height = 17
          Caption = #34920#31034#26495'/'#12473#12524#12483#12489#12392#30064#12394#12427#26495'/'#12473#12524#12483#12489#12395#25237#31295#12377#12427#38555#12395#35686#21578#12377#12427#12290
          TabOrder = 2
        end
      end
      object LogGroupBox: TGroupBox
        Left = 16
        Top = 176
        Width = 473
        Height = 46
        Caption = #12525#12464
        TabOrder = 1
        object CheckDatFileCheckBox: TCheckBox
          Left = 22
          Top = 18
          Width = 369
          Height = 17
          Caption = #12473#12524#12483#12489#19968#35239#65288'Folder.idx'#65289#35501#12415#36796#12415#26178#12395'dat'#12501#12449#12452#12523#12434#12481#12455#12483#12463#12377#12427#12290
          TabOrder = 0
        end
      end
      object GroupBox5: TGroupBox
        Left = 16
        Top = 228
        Width = 473
        Height = 125
        Caption = #25509#32154#35373#23450'2'
        TabOrder = 2
        object IPv4Label: TLabel
          Left = 160
          Top = 18
          Width = 208
          Height = 12
          Caption = #38500#22806#12489#12513#12452#12531'(&E) '#65288'IPv4'#12391#25509#32154#12377#12427#12489#12513#12452#12531#65289
          FocusControl = IPv4ListBox
        end
        object IPv6Label: TLabel
          Left = 16
          Top = 50
          Width = 129
          Height = 24
          Caption = #65288'IPv6'#12434#20351#29992#12391#12365#12394#12356#22238#32218#12391#12399#12456#12521#12540#12395#12394#12426#12414#12377#65289
          WordWrap = True
        end
        object IPv6CheckBox: TCheckBox
          Left = 22
          Top = 20
          Width = 123
          Height = 17
          Caption = 'IPv6'#12434#20351#29992#12377#12427'(&I)'
          TabOrder = 0
          OnClick = IPv6CheckBoxClick
        end
        object IPv4ListBox: TListBox
          Left = 160
          Top = 32
          Width = 214
          Height = 84
          ItemHeight = 12
          TabOrder = 1
        end
        object IPv4AddButton: TButton
          Left = 378
          Top = 38
          Width = 75
          Height = 25
          Caption = #36861#21152'(&A)'
          TabOrder = 2
          OnClick = IPv4AddButtonClick
        end
        object IPv4EdtButton: TButton
          Left = 378
          Top = 64
          Width = 75
          Height = 25
          Caption = #32232#38598'(&E)'
          TabOrder = 3
          OnClick = IPv4EdtButtonClick
        end
        object IPv4DelButton: TButton
          Left = 378
          Top = 90
          Width = 75
          Height = 25
          Caption = #21066#38500'(&D)'
          TabOrder = 4
          OnClick = IPv4DelButtonClick
        end
        object IPv4ResetButton: TButton
          Left = 378
          Top = 10
          Width = 75
          Height = 25
          Caption = #12522#12475#12483#12488'(&R)'
          TabOrder = 5
          OnClick = IPv4ResetButtonClick
        end
      end
    end
    object RespopupTabSheet: TTabSheet
      Caption = #35443#32048#35373#23450'5'
      ImageIndex = 4
      object RespopuGroupBox: TGroupBox
        Left = 8
        Top = 16
        Width = 473
        Height = 121
        Caption = #12524#12473#12509#12483#12503#12450#12483#12503
        TabOrder = 0
        object Label16: TLabel
          Left = 16
          Top = 48
          Width = 292
          Height = 12
          Caption = '( '#12510#12454#12473#12459#12540#12477#12523#20301#32622#12363#12425#12398#12378#12425#12375#20301#32622' -25 px '#65374' 25'#12288'px)'
        end
        object Label19: TLabel
          Left = 192
          Top = 72
          Width = 96
          Height = 12
          Caption = '(0 ms '#65374' 5000 ms)'
        end
        object DeltaXLabeledEdit: TLabeledEdit
          Left = 120
          Top = 24
          Width = 49
          Height = 20
          EditLabel.Width = 97
          EditLabel.Height = 12
          EditLabel.Caption = #12509#12483#12503#12450#12483#12503#20301#32622' X'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 0
          Text = '0'
          OnExit = DeltaXLabeledEditExit
        end
        object DeltaYLabeledEdit: TLabeledEdit
          Left = 304
          Top = 24
          Width = 49
          Height = 20
          EditLabel.Width = 97
          EditLabel.Height = 12
          EditLabel.Caption = #12509#12483#12503#12450#12483#12503#20301#32622' Y'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 1
          Text = '0'
          OnExit = DeltaYLabeledEditExit
        end
        object DeltaXUpDown: TUpDown
          Left = 169
          Top = 24
          Width = 16
          Height = 20
          Associate = DeltaXLabeledEdit
          Min = -25
          Max = 25
          TabOrder = 2
        end
        object DeltaYUpDown: TUpDown
          Left = 353
          Top = 24
          Width = 16
          Height = 20
          Associate = DeltaYLabeledEdit
          Min = -25
          Max = 25
          TabOrder = 3
        end
        object RespopupWaitLabeledEdit: TLabeledEdit
          Left = 76
          Top = 66
          Width = 92
          Height = 20
          EditLabel.Width = 52
          EditLabel.Height = 12
          EditLabel.Caption = #12463#12522#12450'Wait'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 4
          Text = '100'
          OnExit = RespopupWaitLabeledEditExit
        end
        object RespopupWaitUpDown: TUpDown
          Left = 168
          Top = 66
          Width = 17
          Height = 20
          Associate = RespopupWaitLabeledEdit
          Max = 5000
          Increment = 100
          Position = 100
          TabOrder = 5
          Thousands = False
        end
        object RespopupMailToCheckBox: TCheckBox
          Left = 16
          Top = 96
          Width = 185
          Height = 17
          Caption = #12513#12540#12523#27396#12434#12509#12483#12503#12450#12483#12503#12377#12427
          TabOrder = 6
        end
      end
    end
  end
  object OkBotton: TButton
    Left = 224
    Top = 398
    Width = 89
    Height = 21
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OkBottonClick
  end
  object CancelBotton: TButton
    Left = 320
    Top = 398
    Width = 89
    Height = 21
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
  object ApplyButton: TButton
    Left = 416
    Top = 398
    Width = 89
    Height = 21
    Cancel = True
    Caption = #36969#29992'(&A)'
    TabOrder = 3
    OnClick = OkBottonClick
  end
end
