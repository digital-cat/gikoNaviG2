object NgEdit: TNgEdit
  Left = 192
  Top = 133
  Width = 845
  Height = 478
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'NG'#12527#12540#12489#32232#38598
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 845
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
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object SetInfButton: TButton
      Left = 8
      Top = 8
      Width = 81
      Height = 25
      Action = SetInfAction
      TabOrder = 0
    end
    object InsRowButton: TButton
      Left = 96
      Top = 8
      Width = 113
      Height = 25
      Action = InsRowAction
      TabOrder = 1
    end
    object AddRowButton: TButton
      Left = 216
      Top = 8
      Width = 105
      Height = 25
      Action = AddRowAction
      TabOrder = 2
    end
    object DelRowButton: TButton
      Left = 328
      Top = 8
      Width = 129
      Height = 25
      Action = DelRowAction
      TabOrder = 3
    end
    object AddColButton: TButton
      Left = 464
      Top = 8
      Width = 105
      Height = 25
      Action = AddColAction
      TabOrder = 4
    end
    object DelColButton: TButton
      Left = 576
      Top = 8
      Width = 129
      Height = 25
      Action = DelColAction
      TabOrder = 5
    end
    object RegExpButton: TButton
      Left = 720
      Top = 8
      Width = 97
      Height = 25
      Action = RegExpAction
      TabOrder = 6
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 399
    Width = 829
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object ButtonOk: TButton
      Left = 256
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = ButtonOkClick
    end
    object ButtonReload: TButton
      Left = 352
      Top = 8
      Width = 113
      Height = 25
      Caption = 'OK('#20877#35501#12415#36796#12415')'
      TabOrder = 1
      OnClick = ButtonReloadClick
    end
    object ButtonCancel: TButton
      Left = 488
      Top = 8
      Width = 75
      Height = 25
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 2
    end
  end
  object NgWordGrid: TStringGrid
    Left = 0
    Top = 41
    Width = 829
    Height = 358
    Align = alClient
    ColCount = 4
    Ctl3D = True
    DefaultColWidth = 200
    DefaultRowHeight = 19
    FixedCols = 2
    RowCount = 10
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goEditing]
    ParentCtl3D = False
    TabOrder = 0
    OnMouseUp = NgWordGridMouseUp
  end
  object GridMenu: TPopupMenu
    Left = 88
    Top = 288
    object MnStdAbn: TMenuItem
      Caption = #27161#28310#12354#12412#12540#12435
      OnClick = MnStdAbnClick
    end
    object MnTrnAbn: TMenuItem
      Caption = #36879#26126#12354#12412#12540#12435
      OnClick = MnTrnAbnClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MnStdCmp: TMenuItem
      Caption = #36890#24120#27604#36611
      OnClick = MnStdCmpClick
    end
    object MnRegexp: TMenuItem
      Caption = #27491#35215#34920#29694
      OnClick = MnRegexpClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MnAllThr: TMenuItem
      Caption = #20840#12473#12524#23550#35937
      OnClick = MnAllThrClick
    end
    object MnSpcThr: TMenuItem
      Caption = #12473#12524#25351#23450'...'
      OnClick = MnSpcThrClick
    end
    object MnSpcBrd: TMenuItem
      Caption = #26495#25351#23450'...'
      OnClick = MnSpcBrdClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MnInsRow: TMenuItem
      Action = InsRowAction
    end
    object MnAddRow: TMenuItem
      Action = AddRowAction
    end
    object MnDelRow: TMenuItem
      Action = DelRowAction
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MnAddCol: TMenuItem
      Action = AddColAction
    end
    object MnDelCol: TMenuItem
      Action = DelColAction
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object MnRegExpTest: TMenuItem
      Action = RegExpAction
    end
  end
  object ActionList: TActionList
    Left = 144
    Top = 296
    object AddRowAction: TAction
      Category = #12464#12522#12483#12489
      Caption = #19968#30058#19979#12395#34892#36861#21152
      OnExecute = AddRowActionExecute
    end
    object AddColAction: TAction
      Category = #12464#12522#12483#12489
      Caption = #19968#30058#21491#12395#21015#36861#21152
      OnExecute = AddColActionExecute
    end
    object InsRowAction: TAction
      Category = #12464#12522#12483#12489
      Caption = #36984#25246#20301#32622#12395#34892#25407#20837
      OnExecute = InsRowActionExecute
    end
    object DelColAction: TAction
      Category = #12464#12522#12483#12489
      Caption = #36984#25246#21015#65288#32294#26041#21521#65289#21066#38500
      OnExecute = DelColActionExecute
    end
    object DelRowAction: TAction
      Category = #12464#12522#12483#12489
      Caption = #36984#25246#34892#65288#27178#26041#21521#65289#21066#38500
      OnExecute = DelRowActionExecute
    end
    object RegExpAction: TAction
      Category = #35373#23450
      Caption = #27491#35215#34920#29694#12486#12473#12488
      OnExecute = RegExpActionExecute
    end
    object SetInfAction: TAction
      Category = #35373#23450
      Caption = #36984#25246#34892#35373#23450
      OnExecute = SetInfActionExecute
    end
  end
end
