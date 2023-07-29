object ShitarabaJBBSAcquireBoardDialog: TShitarabaJBBSAcquireBoardDialog
  Left = 194
  Top = 160
  Caption = #12375#12383#12425#12400'JBBS'#26495#21462#24471
  ClientHeight = 228
  ClientWidth = 289
  Color = clBtnFace
  Constraints.MinHeight = 267
  Constraints.MinWidth = 305
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    289
    228)
  PixelsPerInch = 96
  TextHeight = 12
  object CategoryLabel: TLabel
    Left = 46
    Top = 16
    Width = 43
    Height = 12
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = #12459#12486#12468#12522':'
    ParentBiDiMode = False
    Layout = tlCenter
  end
  object BoardNameLabel: TLabel
    Left = 17
    Top = 48
    Width = 72
    Height = 12
    Alignment = taRightJustify
    Caption = #21462#24471#12377#12427#26495#21517':'
    Layout = tlCenter
  end
  object SaveCategoryLabel: TLabel
    Left = 22
    Top = 80
    Width = 67
    Height = 12
    Alignment = taRightJustify
    Caption = #20445#23384#12459#12486#12468#12522':'
    Layout = tlCenter
  end
  object CategoryComboBox: TComboBox
    Left = 96
    Top = 16
    Width = 185
    Height = 20
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 12
    TabOrder = 0
  end
  object BoardNameEdit: TEdit
    Left = 96
    Top = 48
    Width = 185
    Height = 20
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object AcquireButton: TButton
    Left = 124
    Top = 192
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #21462#24471'(&A)'
    TabOrder = 2
    OnClick = AcquireButtonClick
  end
  object SaveButton: TButton
    Left = 204
    Top = 192
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #20445#23384'(&S)'
    Default = True
    Enabled = False
    TabOrder = 3
    OnClick = SaveButtonClick
  end
  object LogEdit: TMemo
    Left = 16
    Top = 112
    Width = 265
    Height = 65
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object SaveCategoryComboBox: TComboBox
    Left = 96
    Top = 80
    Width = 185
    Height = 20
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 12
    TabOrder = 5
  end
end
