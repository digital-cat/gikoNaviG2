object ListSelectDialog: TListSelectDialog
  Left = 55
  Top = 91
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsDialog
  Caption = #32094#36796#12415
  ClientHeight = 119
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object TitleLabel: TLabel
    Left = 8
    Top = 12
    Width = 51
    Height = 12
    Caption = #32094#36796#12415'(&T)'
    FocusControl = SelectComboBox
  end
  object SelectComboBox: TComboBox
    Left = 20
    Top = 32
    Width = 265
    Height = 20
    DropDownCount = 10
    ItemHeight = 12
    TabOrder = 0
  end
  object KubetsuCheckBox: TCheckBox
    Left = 20
    Top = 60
    Width = 185
    Height = 17
    Caption = #22823#25991#23383#12392#23567#25991#23383#12434#21306#21029#12377#12427'(&C)'
    Enabled = False
    TabOrder = 3
  end
  object OkButton: TButton
    Left = 108
    Top = 92
    Width = 87
    Height = 21
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 200
    Top = 92
    Width = 87
    Height = 21
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
end
