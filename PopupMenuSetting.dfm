object PopupMenuSettingDialog: TPopupMenuSettingDialog
  Left = 288
  Top = 163
  Caption = #12509#12483#12503#12450#12483#12503#12513#12491#12517#12540#35373#23450
  ClientHeight = 321
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 513
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PopupMenuComboLabel: TLabel
      Left = 16
      Top = 12
      Width = 165
      Height = 12
      Caption = #22793#26356#12377#12427#12509#12483#12503#12450#12483#12503#12513#12491#12517#12540'(&P)'
      FocusControl = PopupMenuComboBox
    end
    object PopupMenuComboBox: TComboBox
      Left = 189
      Top = 8
      Width = 209
      Height = 20
      Style = csDropDownList
      Enabled = False
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 0
      Text = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      OnChange = PopupMenuComboBoxChange
      Items.Strings = (
        #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503)
    end
    object ApplyButton: TButton
      Left = 416
      Top = 8
      Width = 75
      Height = 25
      Caption = #36969#29992'(&A)'
      TabOrder = 1
      OnClick = ApplyButtonClick
    end
  end
  object MainPanel: TPanel
    Left = 0
    Top = 41
    Width = 513
    Height = 280
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 281
    object Splitter1: TSplitter
      Left = 285
      Top = 0
      Height = 280
      Align = alRight
      ExplicitHeight = 281
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 285
      Height = 280
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 281
      object Panel2: TPanel
        Left = 177
        Top = 0
        Width = 108
        Height = 281
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object AddSubButton: TButton
          Left = 1
          Top = 40
          Width = 108
          Height = 25
          Caption = #12469#12502#12513#12491#12517#12540#36861#21152'(&2)'
          TabOrder = 0
          OnClick = AddSubButtonClick
        end
        object AddSepButton: TButton
          Left = 1
          Top = 68
          Width = 108
          Height = 25
          Caption = #21306#20999#12426#36861#21152'(&S)'
          TabOrder = 1
          OnClick = AddSepButtonClick
        end
        object AddMainButton: TButton
          Left = 1
          Top = 13
          Width = 108
          Height = 25
          Caption = #12513#12491#12517#12540#36861#21152'(&1)'
          TabOrder = 2
          OnClick = AddMainButtonClick
        end
        object RemoveButton: TButton
          Left = 1
          Top = 118
          Width = 108
          Height = 25
          Caption = #21066#38500'(&R)'
          TabOrder = 3
          OnClick = RemoveButtonClick
        end
        object LabelButton: TButton
          Left = 1
          Top = 149
          Width = 108
          Height = 25
          Caption = #12521#12505#12523#36861#21152'(&L)'
          TabOrder = 4
          OnClick = LabelButtonClick
        end
        object DownButton: TButton
          Left = 33
          Top = 224
          Width = 50
          Height = 25
          Caption = 'down(&D)'
          TabOrder = 5
          OnClick = DownButtonClick
        end
        object UpButton: TButton
          Left = 33
          Top = 196
          Width = 50
          Height = 25
          Caption = 'Up(&U)'
          TabOrder = 6
          OnClick = UpButtonClick
        end
      end
      object ActionListBox: TListBox
        Left = 0
        Top = 0
        Width = 177
        Height = 281
        Align = alClient
        ItemHeight = 12
        TabOrder = 1
      end
    end
    object Panel4: TPanel
      Left = 288
      Top = 0
      Width = 225
      Height = 280
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitHeight = 281
      object MenuTreeView: TTreeView
        Left = 0
        Top = 0
        Width = 225
        Height = 280
        Align = alClient
        HideSelection = False
        Indent = 19
        ParentShowHint = False
        ReadOnly = True
        ShowHint = False
        TabOrder = 0
        ToolTips = False
        OnChange = MenuTreeViewChange
        OnDblClick = MenuTreeViewDblClick
        OnEdited = MenuTreeViewEdited
        OnEditing = MenuTreeViewEditing
        ExplicitHeight = 281
      end
    end
  end
end
