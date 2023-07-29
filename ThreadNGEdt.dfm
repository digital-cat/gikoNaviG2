object ThreadNGEdit: TThreadNGEdit
  Left = 192
  Top = 133
  Width = 360
  Height = 543
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #12473#12524#12479#12452'NG'#12527#12540#12489#32232#38598
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 360
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 344
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object EdtNgWord: TEdit
      Left = 8
      Top = 8
      Width = 329
      Height = 20
      TabOrder = 0
    end
    object BtnAdd: TButton
      Left = 32
      Top = 32
      Width = 75
      Height = 25
      Caption = #36861#21152'(&A)'
      TabOrder = 1
      OnClick = BtnAddClick
    end
    object BtnUpd: TButton
      Left = 136
      Top = 32
      Width = 75
      Height = 25
      Caption = #26356#26032'(&U)'
      TabOrder = 2
      OnClick = BtnUpdClick
    end
    object BtnDel: TButton
      Left = 240
      Top = 32
      Width = 75
      Height = 25
      Caption = #21066#38500'(&D)'
      TabOrder = 3
      OnClick = BtnDelClick
    end
  end
  object LstNgWord: TListBox
    Left = 0
    Top = 65
    Width = 344
    Height = 399
    Align = alClient
    ItemHeight = 12
    TabOrder = 1
    OnClick = LstNgWordClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 464
    Width = 344
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object BtnOk: TButton
      Left = 80
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOkClick
    end
    object BtnCancel: TButton
      Left = 184
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
  end
end
