object GikoInputBox: TGikoInputBox
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'GikoInputBox'
  ClientHeight = 112
  ClientWidth = 427
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
  object PromptLabel: TLabel
    Left = 16
    Top = 16
    Width = 59
    Height = 13
    Caption = 'PromptLabel'
  end
  object InputEdit: TEdit
    Left = 16
    Top = 35
    Width = 393
    Height = 21
    TabOrder = 0
  end
  object OkButton: TButton
    Left = 104
    Top = 72
    Width = 85
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 248
    Top = 72
    Width = 85
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
end
