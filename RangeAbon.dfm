object RangeAbonForm: TRangeAbonForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #31684#22258#12354#12412#12540#12435
  ClientHeight = 100
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 101
    Height = 13
    Caption = #12354#12412#12540#12435#12377#12427#12524#12473#30058#21495
  end
  object Label2: TLabel
    Left = 202
    Top = 16
    Width = 12
    Height = 13
    Caption = #65374
  end
  object EditFrom: TEdit
    Left = 143
    Top = 13
    Width = 49
    Height = 21
    ImeMode = imClose
    MaxLength = 4
    TabOrder = 0
    Text = '1000'
  end
  object EditTo: TEdit
    Left = 224
    Top = 13
    Width = 49
    Height = 21
    ImeMode = imClose
    MaxLength = 4
    TabOrder = 1
    Text = '1000'
  end
  object ButtonAbon: TButton
    Left = 8
    Top = 56
    Width = 94
    Height = 25
    Caption = #12354#12412#12540#12435'(&A)'
    TabOrder = 2
    OnClick = ButtonAbonClick
  end
  object ButtonCancel: TButton
    Left = 208
    Top = 56
    Width = 82
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 4
  end
  object ButtonInvis: TButton
    Left = 108
    Top = 56
    Width = 94
    Height = 25
    Caption = #36879#26126#12354#12412#12540#12435'(&I)'
    TabOrder = 3
    OnClick = ButtonInvisClick
  end
end
