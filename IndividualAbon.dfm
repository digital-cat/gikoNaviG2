object IndividualAbonForm: TIndividualAbonForm
  Left = 264
  Top = 314
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #20491#21029#12354#12412#12540#12435#35299#38500
  ClientHeight = 261
  ClientWidth = 254
  Color = clBtnFace
  Constraints.MaxWidth = 270
  Constraints.MinHeight = 300
  Constraints.MinWidth = 270
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  Padding.Left = 10
  Padding.Bottom = 10
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object CheckListBoxNo: TCheckListBox
    Left = 10
    Top = 26
    Width = 111
    Height = 225
    OnClickCheck = CheckListBoxNoClickCheck
    Align = alClient
    ItemHeight = 12
    TabOrder = 0
  end
  object PanelTop: TPanel
    Left = 10
    Top = 0
    Width = 244
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 1
      Top = 8
      Width = 156
      Height = 13
      Caption = #20491#21029#12354#12412#12540#12435#12373#12428#12390#12356#12427#12524#12473
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
  end
  object PanelRight: TPanel
    Left = 121
    Top = 26
    Width = 133
    Height = 225
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object ButtonChkAll: TButton
      Left = 6
      Top = 6
      Width = 115
      Height = 25
      Caption = #20840#12390#12481#12455#12483#12463
      TabOrder = 0
      OnClick = ButtonChkAllClick
    end
    object ButtonUnchkAll: TButton
      Left = 6
      Top = 36
      Width = 115
      Height = 25
      Caption = #20840#12390#12481#12455#12483#12463#35299#38500
      TabOrder = 1
      OnClick = ButtonUnchkAllClick
    end
    object GroupBox1: TGroupBox
      Left = 4
      Top = 90
      Width = 120
      Height = 89
      Caption = #12354#12412#12540#12435#35299#38500
      TabOrder = 2
      object ButtonReversal: TButton
        Left = 10
        Top = 20
        Width = 100
        Height = 25
        Caption = #12481#12455#12483#12463#12398#12415
        Enabled = False
        ModalResult = 1
        TabOrder = 0
        OnClick = ButtonReversalClick
      end
      object BitBtnAll: TBitBtn
        Left = 10
        Top = 50
        Width = 100
        Height = 25
        Caption = #12377#12409#12390'(&A)'
        ModalResult = 1
        TabOrder = 1
        OnClick = BitBtnAllClick
        Glyph.Data = {
          F2010000424DF201000000000000760000002800000024000000130000000100
          0400000000007C01000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
          3333333333388F3333333333000033334224333333333333338338F333333333
          0000333422224333333333333833338F33333333000033422222243333333333
          83333338F3333333000034222A22224333333338F33F33338F33333300003222
          A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
          38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
          2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
          0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
          333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
          33333A2224A2233333333338F338F83300003333333333A2224A333333333333
          8F338F33000033333333333A222433333333333338F338F30000333333333333
          A224333333333333338F38F300003333333333333A223333333333333338F8F3
          000033333333333333A3333333333333333383330000}
        NumGlyphs = 2
      end
    end
    object BitBtnCancel: TBitBtn
      Left = 6
      Top = 198
      Width = 115
      Height = 25
      TabOrder = 3
      Kind = bkClose
    end
  end
end
