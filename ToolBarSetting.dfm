object ToolBarSettingDialog: TToolBarSettingDialog
  Left = 187
  Top = 164
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsDialog
  Caption = #12484#12540#12523#12496#12540#35373#23450
  ClientHeight = 336
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 40
    Width = 159
    Height = 12
    Caption = #21033#29992#12391#12365#12427#12484#12540#12523#12496#12540#12508#12479#12531'(&V)'
    FocusControl = AllListView
  end
  object Label2: TLabel
    Left = 408
    Top = 40
    Width = 139
    Height = 12
    Caption = #29694#22312#12398#12484#12540#12523#12496#12540#12508#12479#12531'(&T)'
    FocusControl = CurrentListView
  end
  object Bevel1: TBevel
    Left = 12
    Top = 296
    Width = 673
    Height = 2
  end
  object Label3: TLabel
    Left = 16
    Top = 12
    Width = 120
    Height = 12
    Caption = #22793#26356#12377#12427#12484#12540#12523#12496#12540'(&B)'
    FocusControl = ToolBarComboBox
  end
  object AllListView: TListView
    Left = 12
    Top = 56
    Width = 281
    Height = 229
    Columns = <
      item
        Width = 230
      end>
    ColumnClick = False
    HideSelection = False
    OwnerData = True
    ReadOnly = True
    RowSelect = True
    SmallImages = GikoForm.HotToobarImageList
    TabOrder = 1
    ViewStyle = vsReport
    OnChange = AllListViewChange
    OnData = AllListViewData
  end
  object AddButton: TButton
    Left = 304
    Top = 112
    Width = 89
    Height = 21
    Caption = #36861#21152'(&A) ->'
    TabOrder = 2
    OnClick = AddButtonClick
  end
  object RemoveButton: TButton
    Left = 304
    Top = 144
    Width = 89
    Height = 21
    Caption = '<- '#21066#38500'(&R)'
    TabOrder = 3
    OnClick = RemoveButtonClick
  end
  object CurrentListView: TListView
    Left = 404
    Top = 56
    Width = 281
    Height = 201
    Columns = <
      item
        Width = 230
      end>
    ColumnClick = False
    HideSelection = False
    OwnerData = True
    ReadOnly = True
    RowSelect = True
    SmallImages = GikoForm.HotToobarImageList
    TabOrder = 5
    ViewStyle = vsReport
    OnChange = CurrentListViewChange
    OnData = CurrentListViewData
  end
  object UpButton: TButton
    Left = 404
    Top = 264
    Width = 89
    Height = 21
    Caption = #19978#12408'(&U)'
    TabOrder = 6
    OnClick = UpButtonClick
  end
  object DownButton: TButton
    Left = 500
    Top = 264
    Width = 89
    Height = 21
    Caption = #19979#12408'(&D)'
    TabOrder = 7
    OnClick = DownButtonClick
  end
  object OKButton: TButton
    Left = 504
    Top = 308
    Width = 89
    Height = 21
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 9
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 600
    Top = 308
    Width = 89
    Height = 21
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 10
  end
  object ToolBarComboBox: TComboBox
    Left = 144
    Top = 8
    Width = 209
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 0
    OnChange = ToolBarComboBoxChange
  end
  object SeparatorAddButton: TButton
    Left = 304
    Top = 176
    Width = 89
    Height = 21
    Caption = #21306#20999#12426#36861#21152'(&S)'
    TabOrder = 4
    OnClick = SeparatorAddButtonClick
  end
  object ResetButton: TButton
    Left = 596
    Top = 264
    Width = 89
    Height = 21
    Caption = #12522#12475#12483#12488'(&C)'
    TabOrder = 8
    OnClick = ResetButtonClick
  end
end
