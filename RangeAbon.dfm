object RangeAbonForm: TRangeAbonForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #31684#22258#12354#12412#12540#12435
  ClientHeight = 154
  ClientWidth = 294
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
  object RadioGroupType: TRadioGroup
    Left = 16
    Top = 40
    Width = 257
    Height = 49
    Caption = #31278#21029
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #12354#12412#12540#12435
      #36879#26126#12354#12412#12540#12435)
    TabOrder = 2
  end
  object ButtonOk: TButton
    Left = 40
    Top = 112
    Width = 100
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = ButtonOkClick
  end
  object ButtonCancel: TButton
    Left = 158
    Top = 112
    Width = 100
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 4
  end
end
