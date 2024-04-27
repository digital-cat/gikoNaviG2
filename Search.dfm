object SearchDialog: TSearchDialog
  Left = 357
  Top = 115
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = #12525#12464#26908#32034
  ClientHeight = 291
  ClientWidth = 442
  Color = clBtnFace
  Constraints.MinHeight = 315
  Constraints.MinWidth = 458
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    442
    291)
  PixelsPerInch = 96
  TextHeight = 12
  object BoardLabel: TLabel
    Left = 8
    Top = 116
    Width = 72
    Height = 12
    Caption = #26908#32034#12377#12427#26495'(&L)'
    FocusControl = BoardListView
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 75
    Height = 12
    Caption = #26908#32034#25991#23383#21015'(&S)'
  end
  object BoardListView: TListView
    Left = 156
    Top = 136
    Width = 285
    Height = 129
    Anchors = [akLeft, akTop, akRight, akBottom]
    Checkboxes = True
    Columns = <
      item
        Width = 260
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    TabOrder = 3
    ViewStyle = vsReport
    OnChange = BoardListViewChange
    OnDblClick = BoardListViewDblClick
    OnResize = BoardListViewResize
  end
  object OkBotton: TButton
    Left = 248
    Top = 271
    Width = 93
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = #26908#32034#38283#22987
    Default = True
    TabOrder = 4
    OnClick = OkBottonClick
  end
  object CancelBotton: TButton
    Left = 348
    Top = 271
    Width = 93
    Height = 21
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    Enabled = False
    ModalResult = 2
    TabOrder = 5
    OnClick = CancelBottonClick
  end
  object SearchComboBox: TComboBox
    Left = 96
    Top = 4
    Width = 345
    Height = 20
    Anchors = [akLeft, akTop, akRight]
    DropDownCount = 20
    ItemHeight = 12
    TabOrder = 0
    Items.Strings = (
      '11111'
      '111111'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222'
      '222222')
  end
  object CategoryListView: TListView
    Left = 8
    Top = 136
    Width = 141
    Height = 129
    Anchors = [akLeft, akTop, akBottom]
    Columns = <
      item
        Width = 120
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    TabOrder = 2
    ViewStyle = vsReport
    OnSelectItem = CategoryListViewSelectItem
  end
  object AllReleaseButton: TButton
    Left = 348
    Top = 108
    Width = 93
    Height = 21
    Anchors = [akTop, akRight]
    Caption = #12377#12409#12390#35299#38500'(&C)'
    TabOrder = 7
    OnClick = AllReleaseButtonClick
  end
  object AllSelectButton: TButton
    Left = 248
    Top = 108
    Width = 93
    Height = 21
    Anchors = [akTop, akRight]
    Caption = #12377#12409#12390#36984#25246'(&A)'
    TabOrder = 6
    OnClick = AllSelectButtonClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 28
    Width = 433
    Height = 69
    Anchors = [akLeft, akTop, akRight]
    Caption = #26908#32034#12458#12503#12471#12519#12531
    TabOrder = 1
    object NameCheckBox: TCheckBox
      Left = 12
      Top = 16
      Width = 69
      Height = 17
      Caption = #21517#21069'(&N)'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object MailCheckBox: TCheckBox
      Left = 100
      Top = 16
      Width = 121
      Height = 17
      Caption = #12513#12540#12523#12450#12489#12524#12473'(&M)'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object IDCheckBox: TCheckBox
      Left = 232
      Top = 16
      Width = 85
      Height = 17
      Caption = #26085#20184'+ID(&D)'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object SentenceCheckBox: TCheckBox
      Left = 328
      Top = 16
      Width = 69
      Height = 17
      Caption = #26412#25991'(&B)'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object RegExpCheckBox: TCheckBox
      Left = 12
      Top = 40
      Width = 85
      Height = 17
      Caption = #27491#35215#34920#29694'(&E)'
      TabOrder = 4
    end
    object GoogleCheckBox: TCheckBox
      Left = 100
      Top = 40
      Width = 149
      Height = 17
      Caption = #21462#24471#28168#12415#12525#12464#12398#12415'(&R)'
      TabOrder = 5
      Visible = False
    end
    object FuzzyCharDicCheckBox: TCheckBox
      Left = 232
      Top = 40
      Width = 145
      Height = 17
      Caption = #12354#12356#12414#12356#25991#23383#12398#21516#19968#35222
      TabOrder = 6
    end
  end
  object BoardsProgressBar: TProgressBar
    Left = 8
    Top = 275
    Width = 145
    Height = 16
    Smooth = True
    Step = 1
    TabOrder = 8
    Visible = False
  end
end
