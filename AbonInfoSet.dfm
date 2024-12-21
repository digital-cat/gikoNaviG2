object AbonInfoEdit: TAbonInfoEdit
  Left = 192
  Top = 133
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'NG'#12527#12540#12489#35373#23450
  ClientHeight = 350
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object AbonTypeRadio: TRadioGroup
    Left = 16
    Top = 8
    Width = 313
    Height = 49
    Caption = #12354#12412#12540#12435#31278#21029
    Columns = 2
    Items.Strings = (
      #36890#24120#12354#12412#12540#12435
      #36879#26126#12354#12412#12540#12435)
    TabOrder = 0
  end
  object CompTypeRadio: TRadioGroup
    Left = 16
    Top = 64
    Width = 313
    Height = 49
    Caption = #27604#36611#31278#21029
    Columns = 3
    Items.Strings = (
      #36890#24120#27604#36611
      #27491#35215#34920#29694
      #27491#35215#34920#29694#65298)
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 120
    Width = 409
    Height = 177
    Caption = #12354#12412#12540#12435#23550#35937
    TabOrder = 2
    object AllRadio: TRadioButton
      Left = 9
      Top = 20
      Width = 113
      Height = 17
      Caption = #20840#12473#12524#23550#35937
      TabOrder = 0
      OnClick = TargetRadioClick
    end
    object ThreadRadio: TRadioButton
      Left = 9
      Top = 42
      Width = 113
      Height = 17
      Caption = #12473#12524#25351#23450
      TabOrder = 1
      OnClick = TargetRadioClick
    end
    object BoardRadio: TRadioButton
      Left = 9
      Top = 106
      Width = 113
      Height = 17
      Caption = #26495#25351#23450
      TabOrder = 2
      OnClick = TargetRadioClick
    end
    object ThrNameEdit: TEdit
      Left = 24
      Top = 60
      Width = 334
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object ThrIDEdit: TEdit
      Left = 24
      Top = 80
      Width = 334
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object BrdNameEdit: TEdit
      Left = 24
      Top = 124
      Width = 334
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
    object BrdIDEdit: TEdit
      Left = 24
      Top = 144
      Width = 334
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object ThrSelButton: TButton
      Left = 360
      Top = 60
      Width = 40
      Height = 25
      Caption = #36984#25246
      TabOrder = 5
      OnClick = ThrSelButtonClick
    end
    object BrdSelButton: TButton
      Left = 360
      Top = 124
      Width = 40
      Height = 25
      Caption = #36984#25246
      TabOrder = 8
      OnClick = BrdSelButtonClick
    end
  end
  object OkButton: TButton
    Left = 128
    Top = 312
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 240
    Top = 312
    Width = 75
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 4
  end
end
