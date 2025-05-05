object MachiBBSAcquireBoardForm: TMachiBBSAcquireBoardForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #12414#12385'BBS'#26495#26356#26032
  ClientHeight = 369
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 19
    Height = 13
    Caption = '&URL'
    FocusControl = EditURL
  end
  object EditURL: TEdit
    Left = 48
    Top = 13
    Width = 465
    Height = 21
    TabOrder = 3
  end
  object ButtonOk: TButton
    Left = 144
    Top = 329
    Width = 105
    Height = 25
    Caption = #20445#23384#12375#12390#32066#20102'(&S)'
    TabOrder = 1
    OnClick = ButtonOkClick
  end
  object ButtonCancel: TButton
    Left = 296
    Top = 329
    Width = 105
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
  object MemoLog: TMemo
    Left = 16
    Top = 80
    Width = 497
    Height = 233
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object ButtonGet: TButton
    Left = 216
    Top = 40
    Width = 105
    Height = 25
    Caption = #26495#19968#35239#21462#24471'(&G)'
    TabOrder = 0
    OnClick = ButtonGetClick
  end
end
