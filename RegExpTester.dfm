object RegExpTest: TRegExpTest
  Left = 192
  Top = 133
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #27491#35215#34920#29694#12486#12473#12488
  ClientHeight = 112
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 60
    Height = 12
    Caption = #23550#35937#25991#23383#21015
  end
  object Label2: TLabel
    Left = 16
    Top = 44
    Width = 48
    Height = 12
    Caption = #27491#35215#34920#29694
  end
  object TargetEdit: TEdit
    Left = 88
    Top = 16
    Width = 561
    Height = 20
    TabOrder = 0
  end
  object RegExpEdit: TEdit
    Left = 88
    Top = 40
    Width = 561
    Height = 20
    TabOrder = 1
  end
  object TestButton: TButton
    Left = 200
    Top = 72
    Width = 115
    Height = 25
    Caption = #27491#35215#34920#29694#12486#12473#12488
    TabOrder = 2
    OnClick = TestButtonClick
  end
  object CloseButton: TButton
    Left = 576
    Top = 72
    Width = 75
    Height = 25
    Caption = #38281#12376#12427
    ModalResult = 2
    TabOrder = 4
  end
  object Test2Button: TButton
    Left = 354
    Top = 72
    Width = 115
    Height = 25
    Caption = #27491#35215#34920#29694#65298#12486#12473#12488
    TabOrder = 3
    OnClick = Test2ButtonClick
  end
end
