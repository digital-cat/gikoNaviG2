object BbsThreadSel: TBbsThreadSel
  Left = 192
  Top = 133
  Width = 800
  Height = 554
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #26495#36984#25246
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 550
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 516
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object PanelCat: TPanel
      Left = 0
      Top = 0
      Width = 140
      Height = 516
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object PanelCatHead: TPanel
        Left = 0
        Top = 0
        Width = 140
        Height = 17
        Align = alTop
        Caption = #12459#12486#12468#12522
        TabOrder = 0
      end
      object ListCat: TListBox
        Left = 0
        Top = 17
        Width = 140
        Height = 499
        Align = alClient
        ItemHeight = 12
        TabOrder = 1
        OnClick = ListCatClick
      end
    end
    object PanelBrd: TPanel
      Left = 140
      Top = 0
      Width = 180
      Height = 516
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PanelBrdHead: TPanel
        Left = 0
        Top = 0
        Width = 180
        Height = 17
        Align = alTop
        Caption = #26495
        TabOrder = 0
      end
      object ListBrd: TListBox
        Left = 0
        Top = 17
        Width = 180
        Height = 499
        Align = alClient
        ItemHeight = 12
        TabOrder = 1
        OnClick = ListBrdClick
      end
    end
  end
  object PanelRight: TPanel
    Left = 320
    Top = 0
    Width = 464
    Height = 516
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PanelThr: TPanel
      Left = 0
      Top = 0
      Width = 464
      Height = 44
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      OnResize = PanelThrResize
      object EditFilter: TEdit
        Left = 2
        Top = 21
        Width = 276
        Height = 20
        TabOrder = 0
        OnKeyPress = EditFilterKeyPress
      end
      object ButtonFilter: TButton
        Left = 280
        Top = 18
        Width = 40
        Height = 25
        Caption = #32094#36796
        TabOrder = 1
        OnClick = ButtonFilterClick
      end
      object PanelThrHead: TPanel
        Left = 0
        Top = 0
        Width = 464
        Height = 17
        Align = alTop
        Caption = #12473#12524#12483#12489
        TabOrder = 2
      end
    end
    object ListThr: TListBox
      Left = 0
      Top = 44
      Width = 464
      Height = 472
      Align = alClient
      ItemHeight = 12
      TabOrder = 1
      OnClick = ListThrClick
    end
  end
end
