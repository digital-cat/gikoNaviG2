object KotehanDialog: TKotehanDialog
  Left = 296
  Top = 152
  Width = 536
  Height = 354
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  Caption = #12467#12486#12495#12531#35373#23450
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 261
    Width = 520
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object HandleLabel: TLabel
      Left = 8
      Top = 4
      Width = 58
      Height = 12
      Caption = #12495#12531#12489#12523'(&H)'
      FocusControl = HandleEdit
    end
    object MailLabel: TLabel
      Left = 8
      Top = 28
      Width = 50
      Height = 12
      Caption = #12513#12540#12523'(&M)'
      FocusControl = MailEdit
    end
    object Panel2: TPanel
      Left = 336
      Top = 0
      Width = 184
      Height = 55
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object StatusBar1: TStatusBar
        Left = 0
        Top = 34
        Width = 184
        Height = 21
        Panels = <
          item
            Bevel = pbNone
            Width = 0
          end>
      end
      object OKButton: TButton
        Left = 0
        Top = 24
        Width = 85
        Height = 21
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
        OnClick = OKButtonClick
      end
      object CancelButton: TButton
        Left = 92
        Top = 24
        Width = 85
        Height = 21
        Cancel = True
        Caption = #12461#12515#12531#12475#12523
        ModalResult = 2
        TabOrder = 1
      end
    end
    object HandleEdit: TEdit
      Left = 72
      Top = 0
      Width = 121
      Height = 20
      TabOrder = 1
    end
    object MailEdit: TEdit
      Left = 72
      Top = 24
      Width = 121
      Height = 20
      TabOrder = 2
    end
    object ApplyButton: TButton
      Left = 200
      Top = 24
      Width = 85
      Height = 21
      Caption = #36969#29992'(&A)'
      TabOrder = 3
      OnClick = ApplyButtonClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 261
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 4
    TabOrder = 0
    object KotehanListView: TListView
      Left = 4
      Top = 53
      Width = 512
      Height = 204
      Align = alClient
      Columns = <
        item
          Caption = #26495
          Width = 140
        end
        item
          Caption = #21517#21069#65288#12495#12531#12489#12523')'
          Width = 160
        end
        item
          Caption = #12513#12540#12523
          Width = 160
        end>
      ColumnClick = False
      HideSelection = False
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
      OnChange = KotehanListViewChange
    end
    object Panel4: TPanel
      Left = 4
      Top = 4
      Width = 512
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 4
        Top = 8
        Width = 40
        Height = 12
        Caption = #34920#31034'(&V)'
        FocusControl = ViewComboBox
      end
      object Label2: TLabel
        Left = 4
        Top = 32
        Width = 85
        Height = 12
        Caption = #12467#12486#12495#12531#12522#12473#12488'(&L)'
        FocusControl = KotehanListView
      end
      object ViewComboBox: TComboBox
        Left = 52
        Top = 4
        Width = 189
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 0
        OnChange = ViewComboBoxChange
      end
    end
  end
end
