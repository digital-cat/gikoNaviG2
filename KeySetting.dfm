object KeySettingForm: TKeySettingForm
  Left = 258
  Top = 263
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  Caption = #12461#12540#35373#23450
  ClientHeight = 321
  ClientWidth = 672
  Color = clBtnFace
  Constraints.MinHeight = 270
  Constraints.MinWidth = 600
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 243
    Width = 672
    Height = 78
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 417
      Height = 78
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 81
        Height = 12
        Caption = #12471#12519#12540#12488#12459#12483#12488'(&S)'
      end
      object Label2: TLabel
        Left = 8
        Top = 4
        Width = 281
        Height = 12
        Caption = #12300#12394#12375#12301#12395#35373#23450#12377#12427#22580#21512#12399' Shift'#12461#12540#12398#12415#12434#25276#12375#12390#12367#12384#12373#12356
      end
      object GestureLabel: TLabel
        Left = 8
        Top = 48
        Width = 80
        Height = 12
        Caption = #12472#12455#12473#12481#12515#12540'(&G)'
      end
      object HotKey: THotKey
        Left = 96
        Top = 21
        Width = 169
        Height = 18
        HotKey = 0
        InvalidKeys = [hcNone]
        Modifiers = []
        TabOrder = 0
        OnEnter = HotKeyEnter
        OnExit = HotKeyExit
      end
      object SetButton: TButton
        Left = 272
        Top = 20
        Width = 85
        Height = 21
        Caption = #35373#23450
        TabOrder = 1
        OnClick = SetButtonClick
      end
      object GestureEdit: TEdit
        Left = 96
        Top = 48
        Width = 169
        Height = 20
        HelpType = htKeyword
        HelpKeyword = #12510#12454#12473#12398#21491#12508#12479#12531#12434#25276#12375#12383#12414#12414#12489#12521#12483#12464#12375#12390#12367#12384#12373#12356
        ReadOnly = True
        TabOrder = 2
        Text = #12394#12375
        OnChange = GestureEditChange
        OnKeyDown = GestureEditKeyDown
      end
      object GestureSetButton: TButton
        Left = 272
        Top = 48
        Width = 85
        Height = 21
        Caption = #35373#23450
        TabOrder = 3
        OnClick = GestureSetButtonClick
      end
      object GestureCheckBox: TCheckBox
        Left = 368
        Top = 48
        Width = 49
        Height = 17
        Caption = #26377#21177
        TabOrder = 4
        OnClick = GestureCheckBoxClick
      end
    end
    object Panel3: TPanel
      Left = 459
      Top = 0
      Width = 213
      Height = 78
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        213
        78)
      object OkBotton: TButton
        Left = 20
        Top = 44
        Width = 89
        Height = 21
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
        OnClick = OkBottonClick
      end
      object StatusBar: TStatusBar
        Left = 192
        Top = 57
        Width = 21
        Height = 21
        Align = alNone
        Anchors = [akRight, akBottom]
        Panels = <
          item
            Bevel = pbNone
            Width = 50
          end>
      end
      object CancelBotton: TButton
        Left = 116
        Top = 44
        Width = 89
        Height = 21
        Cancel = True
        Caption = #12461#12515#12531#12475#12523
        ModalResult = 2
        TabOrder = 1
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 243
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 4
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 4
      Top = 4
      Width = 664
      Height = 235
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #12513#12452#12531
        object ListView: TListView
          Left = 0
          Top = 0
          Width = 656
          Height = 207
          Align = alClient
          Columns = <
            item
              Caption = #12450#12463#12471#12519#12531
              Width = 300
            end
            item
              Caption = #12459#12486#12468#12522
              Width = 120
            end
            item
              Caption = #12471#12519#12540#12488#12459#12483#12488
              Width = 100
            end
            item
              Caption = #12472#12455#12473#12481#12515#12540
              Width = 130
            end>
          ColumnClick = False
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          SmallImages = GikoForm.HotToobarImageList
          SortType = stData
          TabOrder = 0
          ViewStyle = vsReport
          OnCompare = ListViewCompare
          OnSelectItem = ListViewSelectItem
        end
      end
      object TabSheet2: TTabSheet
        Caption = #12456#12487#12451#12479
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object ListView1: TListView
          Left = 0
          Top = 0
          Width = 656
          Height = 207
          Align = alClient
          Columns = <
            item
              Caption = #12450#12463#12471#12519#12531
              Width = 300
            end
            item
              Caption = #12459#12486#12468#12522
              Width = 120
            end
            item
              Caption = #12471#12519#12540#12488#12459#12483#12488
              Width = 100
            end
            item
              Caption = #12472#12455#12473#12481#12515#12540
              Width = 130
            end>
          ColumnClick = False
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          SortType = stData
          TabOrder = 0
          ViewStyle = vsReport
          OnCompare = ListViewCompare
          OnSelectItem = ListViewSelectItem
        end
      end
    end
  end
end
