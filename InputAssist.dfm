object InputAssistForm: TInputAssistForm
  Left = 371
  Top = 195
  Width = 390
  Height = 460
  Caption = #20837#21147#12450#12471#12473#12488#35373#23450
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 374
    Height = 200
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object Panel5: TPanel
      Left = 280
      Top = 33
      Width = 93
      Height = 166
      Align = alRight
      TabOrder = 0
      object CloseButton: TButton
        Left = 10
        Top = 136
        Width = 75
        Height = 25
        Caption = #32066#20102'(&X)'
        TabOrder = 4
        OnClick = CloseButtonClick
      end
      object ApplyButton: TButton
        Left = 10
        Top = 64
        Width = 75
        Height = 25
        Caption = #36969#29992'(&P)'
        TabOrder = 2
        OnClick = ApplyButtonClick
      end
      object DeleteButton: TButton
        Left = 10
        Top = 36
        Width = 75
        Height = 25
        Caption = #21066#38500'(&D)'
        TabOrder = 1
        OnClick = DeleteButtonClick
      end
      object AddButton: TButton
        Left = 10
        Top = 8
        Width = 75
        Height = 25
        Caption = #36861#21152'(&A)'
        TabOrder = 0
        OnClick = AddButtonClick
      end
      object DiffButton: TButton
        Left = 10
        Top = 98
        Width = 75
        Height = 25
        Caption = #24046#20998#30331#37682'(&F)'
        TabOrder = 3
        OnClick = DiffButtonClick
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 33
      Width = 279
      Height = 166
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object GikoListView1: TGikoListView
        Left = 0
        Top = 0
        Width = 279
        Height = 166
        Align = alClient
        Columns = <>
        ReadOnly = True
        RowSelect = True
        SmallImages = ColumnImageList
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = GikoListView1ColumnClick
        OnCompare = GikoListView1Compare
        OnSelectItem = GikoListView1SelectItem
      end
    end
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 372
      Height = 32
      Align = alTop
      TabOrder = 2
      object CategoryComboLabel: TLabel
        Left = 12
        Top = 10
        Width = 77
        Height = 12
        Caption = #12459#12486#12468#12522#21517#36984#25246
      end
      object CategoryComboBox: TComboBox
        Left = 105
        Top = 6
        Width = 176
        Height = 20
        ItemHeight = 12
        TabOrder = 0
        Text = 'CategoryComboBox'
        OnChange = CategoryComboBoxChange
        OnKeyPress = CategoryComboBoxKeyPress
      end
      object InsertButton: TButton
        Left = 290
        Top = 4
        Width = 75
        Height = 25
        Action = InsertButtonAction
        Caption = #25407#20837'(&I)'
        TabOrder = 1
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 200
    Width = 374
    Height = 222
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 374
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Splitter: TSplitter
        Left = 185
        Top = 0
        Width = 8
        Height = 48
        Beveled = True
      end
      object KeyPanel: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 48
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          185
          48)
        object KeyNameEdit: TLabeledEdit
          Left = 8
          Top = 21
          Width = 169
          Height = 20
          Hint = #20837#21147#12395#20351#12358#12461#12540#21517
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 36
          EditLabel.Height = 12
          EditLabel.Caption = #12461#12540#21517
          TabOrder = 0
        end
      end
      object CategoryPanel: TPanel
        Left = 193
        Top = 0
        Width = 181
        Height = 48
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          181
          48)
        object CategoryNameLabel: TLabel
          Left = 9
          Top = 6
          Width = 41
          Height = 12
          Caption = #12459#12486#12468#12522
        end
        object CategoryNameComboBox: TComboBox
          Left = 5
          Top = 21
          Width = 172
          Height = 20
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 12
          TabOrder = 0
          Text = 'CategoryNameComboBox'
        end
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 48
      Width = 374
      Height = 174
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 374
        Height = 174
        Align = alClient
        Caption = #25407#20837#25991#23383#21015
        TabOrder = 0
        object TextMemo: TMemo
          Left = 2
          Top = 14
          Width = 370
          Height = 158
          Hint = #25407#20837#12377#12427#25991#23383#21015
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
  end
  object ColumnImageList: TImageList
    Left = 304
    Top = 192
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400848484000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400848484000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000E01FFCFF00000000E79FF87F00000000
      F7BFFB7F00000000F33FF33F00000000FB7FF7BF00000000F87FE79F00000000
      FCFFE01F00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object InputAssistFormActionList: TActionList
    Left = 264
    Top = 192
    object EditCut1: TEditCut
      Category = #32232#38598
      Caption = #20999#12426#21462#12426'(&T)'
      Hint = #20999#12426#21462#12426'|'#36984#25246#37096#20998#12434#20999#12426#21462#12426#12289#12463#12522#12483#12503#12508#12540#12489#12395#36865#12427
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = #32232#38598
      Caption = #12467#12500#12540'(&C)'
      Hint = #12467#12500#12540'|'#36984#25246#37096#20998#12434#12467#12500#12540#12375#12289#12463#12522#12483#12503#12508#12540#12489#12395#36865#12427
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = #32232#38598
      Caption = #36028#12426#20184#12369'(&P)'
      Hint = #36028#12426#20184#12369'|'#12463#12522#12483#12503#12508#12540#12489#12398#20869#23481#12434#36028#12426#20184#12369#12427
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = #32232#38598
      Caption = #12377#12409#12390#12434#36984#25246'(&A)'
      Hint = #12377#12409#12390#12434#36984#25246'|'#12489#12461#12517#12513#12531#12488#20840#20307#12434#36984#25246#12377#12427
      ShortCut = 16449
    end
    object EditUndo1: TEditUndo
      Category = #32232#38598
      Caption = #20803#12395#25147#12377'(&U)'
      Hint = #20803#12395#25147#12377'|'#30452#21069#12398#22793#26356#12434#20803#12395#25147#12377
      ImageIndex = 3
      ShortCut = 16474
    end
    object EditDelete1: TEditDelete
      Category = #32232#38598
      Caption = #21066#38500'(&D)'
      Hint = #21066#38500'|'#36984#25246#37096#20998#12434#21066#38500#12377#12427
      ImageIndex = 5
      ShortCut = 46
    end
    object InsertButtonAction: TAction
      Category = #32232#38598
      Caption = #25407#20837
      OnExecute = InsertButtonActionExecute
      OnUpdate = InsertButtonActionUpdate
    end
    object CloseAction: TAction
      Category = #32232#38598
      Caption = 'CloseAction'
      OnExecute = CloseActionExecute
    end
  end
end
