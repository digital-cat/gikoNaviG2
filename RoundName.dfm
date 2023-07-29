object RoundNameDialog: TRoundNameDialog
  Left = 303
  Top = 210
  BorderStyle = bsDialog
  Caption = #24033#22238#21517#25351#23450
  ClientHeight = 104
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object TitleLabel: TLabel
    Left = 8
    Top = 12
    Width = 108
    Height = 12
    Caption = #24033#22238#12398#26032#12375#12356#21517#21069'(&N)'
  end
  object OkButton: TButton
    Left = 132
    Top = 76
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 212
    Top = 76
    Width = 75
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object RoundNameEdit: TEdit
    Left = 20
    Top = 32
    Width = 261
    Height = 20
    MaxLength = 255
    TabOrder = 0
  end
end
