object GikoForm: TGikoForm
  Left = 241
  Top = 116
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = '-'
  ClientHeight = 558
  ClientWidth = 775
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheel = FormMouseWheel
  OnResize = FormResize
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar: TStatusBar
    Left = 0
    Top = 538
    Width = 775
    Height = 20
    Panels = <
      item
        Width = 100
      end
      item
        Width = 500
      end
      item
        Width = 80
      end
      item
        Width = 50
      end>
    OnResize = StatusBarResize
  end
  object MainPanel: TPanel
    Left = 0
    Top = 77
    Width = 775
    Height = 461
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object MessageSplitter: TSplitter
      Left = 0
      Top = 422
      Width = 775
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      MinSize = 26
      ResizeStyle = rsUpdate
    end
    object ClientPanel: TPanel
      Left = 0
      Top = 0
      Width = 775
      Height = 422
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object TreeSplitter: TSplitter
        Left = 145
        Top = 0
        Width = 5
        Height = 422
        AutoSnap = False
        ResizeStyle = rsUpdate
      end
      object CabinetPanel: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 422
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object TreeView: TTreeView
          Left = 4
          Top = 80
          Width = 137
          Height = 167
          BorderStyle = bsNone
          ChangeDelay = 50
          HideSelection = False
          Images = ItemIcon16
          Indent = 19
          PopupMenu = TreePopupMenu
          ReadOnly = True
          RightClickSelect = True
          ShowRoot = False
          TabOrder = 0
          OnCollapsed = TreeViewCollapsed
          OnCustomDraw = TreeViewCustomDraw
          OnCustomDrawItem = TreeViewCustomDrawItem
          OnExpanded = TreeViewExpanded
          OnKeyDown = TreeViewKeyDown
          OnMouseDown = TreeViewMouseDown
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 145
          Height = 25
          Align = alTop
          Alignment = taLeftJustify
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          DesignSize = (
            145
            25)
          object CabinetCloseSpeedButton: TSpeedButton
            Left = 121
            Top = 4
            Width = 20
            Height = 17
            Hint = #12461#12515#12499#12493#12483#12488#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
            Anchors = [akRight]
            Flat = True
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
            Font.Style = [fsBold]
            Glyph.Data = {
              DE000000424DDE0000000000000076000000280000000E0000000D0000000100
              04000000000068000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00111111111111
              1100111111111111110011111111111111001110011110011100111100110011
              1100111110000111110011111100111111001111100001111100111100110011
              1100111001111001110011111111111111001111111111111100111111111111
              1100}
            Layout = blGlyphTop
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            Transparent = False
            OnClick = CabinetCloseSpeedButtonClick
          end
          object ToolBar1: TToolBar
            Left = 2
            Top = 4
            Width = 15
            Height = 18
            Align = alNone
            AutoSize = True
            ButtonHeight = 18
            ButtonWidth = 16
            List = True
            ShowCaptions = True
            TabOrder = 0
            object CabinetSelectToolButton: TToolButton
              Left = 0
              Top = 0
              AutoSize = True
              Caption = '_'
              DropdownMenu = CabinetSelectPopupMenu
            end
          end
        end
        object HistoryToolBar: TToolBar
          Left = 0
          Top = 25
          Width = 145
          Height = 24
          AutoSize = True
          BorderWidth = 1
          ButtonHeight = 18
          ButtonWidth = 54
          Caption = 'HistoryToolBar'
          EdgeBorders = [ebLeft, ebRight, ebBottom]
          List = True
          ShowCaptions = True
          TabOrder = 2
          object HistoryShowToolButton: TToolButton
            Left = 0
            Top = 0
            AutoSize = True
            Caption = #34920#31034
            ImageIndex = 0
          end
          object HistoryAllClearToolButton: TToolButton
            Left = 40
            Top = 0
            AutoSize = True
            Caption = #20840#12463#12522#12450
            ImageIndex = 1
            OnClick = HistoryAllClearToolButtonClick
          end
        end
        object FavoriteTreeView: TTreeView
          Left = 4
          Top = 256
          Width = 137
          Height = 57
          BorderStyle = bsNone
          ChangeDelay = 50
          DragMode = dmAutomatic
          HideSelection = False
          Images = ItemIcon16
          Indent = 19
          PopupMenu = FavoriteTreePopupMenu
          ReadOnly = True
          RightClickSelect = True
          ShowRoot = False
          TabOrder = 3
          OnDragDrop = FavoriteTreeViewDragDrop
          OnDragOver = FavoriteTreeViewDragOver
          OnEdited = FavoriteTreeViewEdited
          OnEditing = FavoriteTreeViewEditing
          OnEndDrag = FavoriteTreeViewEndDrag
          OnKeyDown = FavoriteTreeViewKeyDown
          OnMouseDown = FavoriteTreeViewMouseDown
        end
        object FavoriteToolBar: TToolBar
          Left = 0
          Top = 49
          Width = 145
          Height = 42
          AutoSize = True
          BorderWidth = 1
          ButtonHeight = 18
          ButtonWidth = 124
          Caption = 'FavoriteToolBar'
          EdgeBorders = [ebLeft, ebRight, ebBottom]
          List = True
          ShowCaptions = True
          TabOrder = 4
          object FavoriteAddToolButton: TToolButton
            Left = 0
            Top = 0
            Action = GikoDM.FavoriteAddAction
            AutoSize = True
            Wrap = True
          end
          object FavoriteArrangeToolButton: TToolButton
            Left = 0
            Top = 18
            Hint = #12362#27671#12395#20837#12426#25972#29702#12480#12452#12450#12525#12464#12434#38283#12367
            AutoSize = True
            Caption = #25972#29702'...'
            OnClick = FavoriteArrangeToolButtonClick
          end
        end
      end
      object ThreadMainPanel: TPanel
        Left = 150
        Top = 0
        Width = 625
        Height = 422
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object ListSplitter: TSplitter
          Left = 0
          Top = 189
          Width = 625
          Height = 5
          Cursor = crVSplit
          Align = alTop
          AutoSnap = False
          MinSize = 1
          ResizeStyle = rsUpdate
          OnMoved = ListSplitterMoved
        end
        object ViewPanel: TPanel
          Left = 0
          Top = 0
          Width = 625
          Height = 189
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object ListView: TGikoListView
            Left = 0
            Top = 24
            Width = 625
            Height = 165
            Align = alClient
            AllocBy = 2
            Columns = <>
            DragMode = dmAutomatic
            HideSelection = False
            LargeImages = ItemIcon32
            MultiSelect = True
            OwnerData = True
            ReadOnly = True
            RowSelect = True
            SmallImages = ItemIcon16
            StateImages = StateIconImageList
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = ListViewColumnClick
            OnColumnRightClick = ListViewColumnRightClick
            OnCustomDraw = ListViewCustomDraw
            OnCustomDrawItem = ListViewCustomDrawItem
            OnKeyDown = ListViewKeyDown
            OnKeyUp = ListViewKeyUp
            OnMouseDown = ListViewMouseDown
            OnColumnInfo = ListViewColumnInfo
          end
          object ListCoolBar: TGikoCoolBar
            Left = 0
            Top = 0
            Width = 625
            Height = 24
            AutoSize = True
            BandMaximize = bmDblClick
            Bands = <
              item
                Break = False
                Control = ListToolBar
                ImageIndex = -1
                MinHeight = 22
                Width = 606
              end
              item
                Break = False
                Control = ListNameToolBar
                ImageIndex = -1
                MinHeight = 18
                Width = 9
              end>
            EdgeBorders = [ebLeft, ebTop, ebRight]
            EdgeInner = esLowered
            OnContextPopup = MainCoolBarContextPopup
            OnBandInfo = ListCoolBarBandInfo
            OnChevronClick = ListCoolBarChevronClick
            object ListToolBar: TToolBar
              Left = 11
              Top = 0
              Width = 593
              Height = 22
              AutoSize = True
              ButtonWidth = 25
              Caption = #12522#12473#12488#12484#12540#12523#12496#12540
              HotImages = HotToobarImageList
              Images = GikoDM.ToobarImageList
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Transparent = True
              Wrapable = False
              OnResize = ListToolBarResize
              object SelectComboBoxPanel: TPanel
                Left = 0
                Top = 0
                Width = 200
                Height = 22
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object SelectComboBoxSplitter: TImage
                  Tag = 1
                  Left = 192
                  Top = 0
                  Width = 8
                  Height = 22
                  Cursor = crHSplit
                  Align = alRight
                  Picture.Data = {
                    07544269746D6170E6040000424DE60400000000000036040000280000000800
                    0000160000000100080000000000B00000000000000000000000000100000000
                    000000000000000080000080000000808000800000008000800080800000C0C0
                    C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
                    E00000400000004020000040400000406000004080000040A0000040C0000040
                    E00000600000006020000060400000606000006080000060A0000060C0000060
                    E00000800000008020000080400000806000008080000080A0000080C0000080
                    E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
                    E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
                    E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
                    E00040000000400020004000400040006000400080004000A0004000C0004000
                    E00040200000402020004020400040206000402080004020A0004020C0004020
                    E00040400000404020004040400040406000404080004040A0004040C0004040
                    E00040600000406020004060400040606000406080004060A0004060C0004060
                    E00040800000408020004080400040806000408080004080A0004080C0004080
                    E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
                    E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
                    E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
                    E00080000000800020008000400080006000800080008000A0008000C0008000
                    E00080200000802020008020400080206000802080008020A0008020C0008020
                    E00080400000804020008040400080406000804080008040A0008040C0008040
                    E00080600000806020008060400080606000806080008060A0008060C0008060
                    E00080800000808020008080400080806000808080008080A0008080C0008080
                    E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
                    E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
                    E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
                    E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
                    E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
                    E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
                    E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
                    E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
                    E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
                    E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
                    A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
                    FF00FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFD
                    FDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFD
                    FDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFD
                    FDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFD
                    FDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFDFDFDFDFDFDA4FFFD
                    FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
                  Transparent = True
                  OnMouseDown = SelectComboBoxSplitterMouseDown
                  OnMouseMove = SelectComboBoxSplitterMouseMove
                  OnMouseUp = SelectComboBoxSplitterMouseUp
                end
                object SelectComboBox: TComboBox
                  Tag = 128
                  Left = 0
                  Top = 1
                  Width = 127
                  Height = 20
                  Hint = #12473#12524#12483#12489#12434#26908#32034#12377#12427#12395#12399#12371#12371#12395#35486#21477#12434#20837#21147#12375#12414#12377
                  ItemHeight = 0
                  TabOrder = 0
                  OnChange = SelectComboBoxChange
                  OnEnter = SelectComboBoxEnter
                  OnExit = SelectComboBoxExit
                  OnKeyDown = SelectComboBoxKeyDown
                end
              end
            end
            object ListNameToolBar: TToolBar
              Left = 621
              Top = 2
              Width = 0
              Height = 18
              AutoSize = True
              ButtonHeight = 16
              Constraints.MinHeight = 18
              TabOrder = 1
              Transparent = True
              OnResize = ListToolBarResize
              object FolderImage: TImage
                Left = 0
                Top = 0
                Width = 16
                Height = 16
                Constraints.MaxHeight = 16
                Constraints.MaxWidth = 16
                Constraints.MinHeight = 16
                Constraints.MinWidth = 16
                Transparent = True
              end
              object ListNameLabel: TLabel
                Left = 16
                Top = 0
                Width = 5
                Height = 16
                Caption = '_'
                Constraints.MinHeight = 16
                Font.Charset = SHIFTJIS_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
              end
            end
          end
        end
        object ThreadPanel: TPanel
          Left = 0
          Top = 194
          Width = 625
          Height = 228
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object BrowserPanel: TPanel
            Left = 0
            Top = 42
            Width = 625
            Height = 166
            Align = alClient
            BevelOuter = bvNone
            UseDockManager = False
            TabOrder = 2
            OnResize = BrowserPanelResize
            object Browser: TWebBrowser
              Left = 0
              Top = 0
              Width = 625
              Height = 166
              Align = alClient
              TabOrder = 0
              OnEnter = BrowserEnter
              OnStatusTextChange = BrowserStatusTextChange
              OnBeforeNavigate2 = BrowserBeforeNavigate2
              OnNewWindow2 = BrowserNewWindow2
              OnDocumentComplete = BrowserDocumentComplete
              ControlData = {
                4C00000098400000281100000000000000000000000000000000000000000000
                000000004C000000000000000000000001000000E0D057007335CF11AE690800
                2B2E126202000000000000004C0000000114020000000000C000000000000046
                8000000000000000000000000000000000000000000000000000000000000000
                00000000000000000100000000000000000000000000000000000000}
            end
          end
          object BrowserBottomPanel: TGikoPanel
            Left = 0
            Top = 208
            Width = 625
            Height = 20
            Align = alBottom
            BevelEdges = [beLeft, beRight, beBottom]
            BevelInner = bvLowered
            BevelKind = bkTile
            TabOrder = 0
            Visible = False
          end
          object BrowserCoolBar: TGikoCoolBar
            Left = 0
            Top = 0
            Width = 625
            Height = 42
            AutoSize = True
            BandMaximize = bmDblClick
            Bands = <
              item
                Control = BrowserToolBar
                ImageIndex = -1
                MinHeight = 18
                Width = 584
              end
              item
                Break = False
                Control = BrowserNameToolBar
                ImageIndex = -1
                MinHeight = 18
                Width = 31
              end
              item
                Control = BrowserTabToolBar
                ImageIndex = -1
                MinHeight = 20
                Width = 619
              end>
            EdgeBorders = [ebLeft, ebTop, ebRight]
            EdgeInner = esLowered
            OnContextPopup = MainCoolBarContextPopup
            OnBandInfo = BrowserCoolBarBandInfo
            OnChevronClick = BrowserCoolBarChevronClick
            object BrowserToolBar: TToolBar
              Left = 11
              Top = 0
              Width = 571
              Height = 18
              AutoSize = True
              ButtonWidth = 24
              Caption = #12502#12521#12454#12470#12484#12540#12523#12496#12540
              HotImages = HotToobarImageList
              Images = GikoDM.ToobarImageList
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Transparent = True
              Wrapable = False
              OnResize = BrowserToolBarResize
            end
            object BrowserNameToolBar: TToolBar
              Left = 599
              Top = 0
              Width = 22
              Height = 18
              AutoSize = True
              ButtonHeight = 16
              Constraints.MinHeight = 18
              TabOrder = 1
              Transparent = True
              OnResize = BrowserToolBarResize
              object ItemBoardImage: TImage
                Left = 0
                Top = 0
                Width = 16
                Height = 16
                Constraints.MaxHeight = 16
                Constraints.MaxWidth = 16
                Constraints.MinHeight = 16
                Constraints.MinWidth = 16
                Transparent = True
              end
              object BrowserBoardNameLabel: TLabel
                Left = 16
                Top = 0
                Width = 5
                Height = 16
                Caption = '_'
                Constraints.MinHeight = 16
                Font.Charset = SHIFTJIS_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
              end
              object ItemImage: TImage
                Left = 21
                Top = 0
                Width = 16
                Height = 16
                Constraints.MaxHeight = 16
                Constraints.MaxWidth = 16
                Constraints.MinHeight = 16
                Constraints.MinWidth = 16
                Transparent = True
              end
              object BrowserNameLabel: TLabel
                Left = 37
                Top = 0
                Width = 5
                Height = 16
                Caption = '_'
                Constraints.MinHeight = 16
                Font.Charset = SHIFTJIS_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
                Font.Style = [fsBold]
                ParentFont = False
                ShowAccelChar = False
                Transparent = True
                Layout = tlCenter
              end
            end
            object BrowserTabToolBar: TToolBar
              Left = 11
              Top = 20
              Width = 610
              Height = 20
              ButtonHeight = 20
              Caption = 'BrowserTabToolBar'
              TabOrder = 2
              OnResize = BrowserTabToolBarResize
              object BrowserTab: TTabControl
                Left = 0
                Top = 0
                Width = 625
                Height = 20
                Align = alClient
                Font.Charset = SHIFTJIS_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
                Font.Style = []
                HotTrack = True
                ParentFont = False
                ParentShowHint = False
                PopupMenu = BrowserTabPopupMenu
                ShowHint = True
                Style = tsButtons
                TabHeight = 16
                TabOrder = 0
                OnChange = BrowserTabChange
                OnContextPopup = BrowserTabContextPopup
                OnDragDrop = BrowserTabDragDrop
                OnDragOver = BrowserTabDragOver
                OnMouseDown = BrowserTabMouseDown
                OnMouseMove = BrowserTabMouseMove
                OnMouseUp = BrowserTabMouseUp
                OnResize = BrowserTabResize
              end
            end
          end
        end
      end
    end
    object MessagePanel: TPanel
      Left = 0
      Top = 427
      Width = 775
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      OnResize = MessagePanelResize
      object MessageBar: TPanel
        Left = 0
        Top = 0
        Width = 28
        Height = 34
        Align = alLeft
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          28
          34)
        object MessageHideButton: TSpeedButton
          Left = 4
          Top = 4
          Width = 20
          Height = 17
          Hint = #38281#12376#12427
          Anchors = [akTop]
          Flat = True
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000E0000000D0000000100
            04000000000068000000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00111111111111
            1100111111111111110011111111111111001110011110011100111100110011
            1100111110000111110011111100111111001111100001111100111100110011
            1100111001111001110011111111111111001111111111111100111111111111
            1100}
          Layout = blGlyphTop
          ParentShowHint = False
          ShowHint = True
          Spacing = 0
          Transparent = False
          OnClick = MessageHideButtonClick
        end
      end
      object MessageListView: TListView
        Left = 28
        Top = 0
        Width = 747
        Height = 34
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Width = 10
          end>
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        SmallImages = MessageImageList
        TabOrder = 1
        ViewStyle = vsReport
        OnResize = MessageListViewResize
      end
    end
  end
  object ProgressBar: TProgressBar
    Left = 44
    Top = 396
    Width = 101
    Height = 16
    Smooth = True
    TabOrder = 2
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 775
    Height = 77
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object TopRightPanel: TPanel
      Left = 739
      Top = 0
      Width = 36
      Height = 77
      Align = alRight
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      object AnimePanel: TPanel
        Left = 0
        Top = 0
        Width = 36
        Height = 29
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Constraints.MaxHeight = 29
        Constraints.MaxWidth = 36
        Constraints.MinHeight = 29
        Constraints.MinWidth = 36
        TabOrder = 0
        object Animate: TAnimate
          Left = 2
          Top = 2
          Width = 32
          Height = 25
          Align = alClient
          AutoSize = False
          Color = clWhite
          ParentColor = False
          StopFrame = 24
        end
      end
    end
    object TopCoolPanel: TPanel
      Left = 0
      Top = 0
      Width = 739
      Height = 77
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object MainCoolBar: TGikoCoolBar
        Left = 0
        Top = 0
        Width = 739
        Height = 70
        AutoSize = True
        BandMaximize = bmDblClick
        Bands = <
          item
            Control = MenuToolBar
            ImageIndex = -1
            MinHeight = 18
            Width = 733
          end
          item
            Control = StdToolBar
            ImageIndex = -1
            MinHeight = 22
            Visible = False
            Width = 438
          end
          item
            Break = False
            Control = AddressToolBar
            ImageIndex = -1
            MinHeight = 22
            Text = #12450#12489#12524#12473
            Width = 291
          end
          item
            Control = LinkToolBar
            ImageIndex = -1
            MinHeight = 22
            Text = #12522#12531#12463
            Width = 733
          end>
        OnContextPopup = MainCoolBarContextPopup
        OnResize = MainCoolBarResize
        OnBandInfo = MainCoolBarBandInfo
        OnChevronClick = MainCoolBarChevronClick
        object MenuToolBar: TToolBar
          Left = 11
          Top = 0
          Width = 724
          Height = 18
          AutoSize = True
          ButtonHeight = 18
          ButtonWidth = 83
          List = True
          Menu = MainMenu
          ShowCaptions = True
          TabOrder = 0
          Transparent = True
          Wrapable = False
          OnCustomDrawButton = MenuToolBarCustomDrawButton
          OnResize = MenuToolBarResize
        end
        object StdToolBar: TToolBar
          Left = 11
          Top = 20
          Width = 425
          Height = 22
          AutoSize = True
          ButtonWidth = 25
          Caption = #27161#28310#12484#12540#12523#12496#12540
          HotImages = HotToobarImageList
          Images = GikoDM.ToobarImageList
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Transparent = True
          Visible = False
          Wrapable = False
          OnResize = MenuToolBarResize
        end
        object AddressToolBar: TToolBar
          Left = 492
          Top = 20
          Width = 243
          Height = 22
          ButtonWidth = 51
          HotImages = HotToobarImageList
          Images = GikoDM.ToobarImageList
          List = True
          ShowCaptions = True
          TabOrder = 2
          Transparent = True
          Wrapable = False
          OnResize = AddressToolBarResize
          object AddressComboBox: TComboBox
            Left = 0
            Top = 0
            Width = 177
            Height = 22
            DropDownCount = 20
            ItemHeight = 0
            TabOrder = 0
            OnKeyDown = AddressComboBoxKeyDown
          end
          object MoveToToolButton: TToolButton
            Left = 177
            Top = 0
            Action = GikoDM.MoveToAction
            AutoSize = True
          end
        end
        object LinkToolBar: TToolBar
          Left = 41
          Top = 44
          Width = 694
          Height = 22
          AutoSize = True
          ButtonWidth = 89
          Constraints.MinHeight = 22
          Images = HotToobarImageList
          List = True
          ShowCaptions = True
          TabOrder = 3
          Transparent = True
          Wrapable = False
          OnDragDrop = LinkToolBarDragDrop
          OnDragOver = LinkToolBarDragOver
          OnResize = MenuToolBarResize
        end
      end
    end
  end
  object ItemIcon16: TImageList
    Left = 4
    Top = 212
    Bitmap = {
      494C010113001800B80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00848484000000000000000000000000000000000084848400FFFF
      FF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C6000000000084848400000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C6000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C600848484000000000084848400000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C600848484000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF000000000084848400848484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00000000008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000000000C6C6C600848484000000000084848400FFFFFF000000FF00FFFF
      FF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000000000C6C6C60084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000FFFF00848484000000000084848400848484000000FF000000
      FF00848484000000FF0084848400848484008484840084848400848484008484
      84008484840000FFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFFFF008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484840084848400FFFF
      FF0000000000C6C6C60084848400000000000000000084848400FFFFFF000000
      FF000000FF000000FF00FFFFFF000000FF000000FF008484840084848400FFFF
      FF0000000000C6C6C60084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFFFF00C6C6
      C60084848400FFFFFF008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0084848400000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFFFF0000FF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00848484008484840084848400FFFF
      FF00FFFFFF0000000000848484000000000000000000848484000000FF000000
      FF00848484000000FF000000FF00FFFFFF00848484008484840084848400FFFF
      FF00FFFFFF000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840084848400848484008484840000000000000000000000000084848400FFFF
      FF0084848400FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000000000000000
      00000000000084848400FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF000000FF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      840084848400848484008484840084848400848484008484840000000000FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400848484000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00848484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600848484000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000008484
      84008484840000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00848484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      00008484840000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000008484840000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000084848400848484000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400848484000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008484840000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000000000848484000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000000000000000000000848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000008484840084848400FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0084848400848484008484
      8400848484008484840084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484840000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00848484000000000000000000000000000000FF00FFFF
      FF00848484000000FF0084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000000000000000FF00FFFF
      FF00848484000000FF0084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00848484000000000000000000000000000000FF000000
      FF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000000000000000FF000000
      FF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000848484000000
      FF000000FF000000FF00848484000000FF000000FF0084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000848484000000
      FF000000FF000000FF00848484000000FF000000FF0084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00848484000000000000000000000000000000FF000000
      FF00848484000000FF000000FF00848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000000000000000FF000000
      FF00848484000000FF000000FF00848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400848484008484840084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840084848400848484008484840000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000FF000000FF00848484000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000FF000000FF00848484000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000848484000000
      FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000848484000000
      FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000848484000000
      FF0084848400848484000000FF00848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000848484000000
      FF0084848400848484000000FF00848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF0084848400000000000000000000000000000000000000000084848400FFFF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF0084848400000000000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C600000000008484840000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000000000848484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000008484840084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6008484
      8400000000000000000000000000000000008484840084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6008484
      840000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF000000
      0000C6C6C600C6C6C600000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF000000
      0000C6C6C600C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484000000
      0000FF000000FFFFFF00C6C6C6000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484000000
      0000FF000000FFFFFF00C6C6C60000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00FFFFFF0000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00FFFFFF000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60084848400FFFFFF00FFFFFF00FF000000C6C6C600FF000000FFFF
      FF00FFFFFF000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60084848400FFFFFF00FFFFFF00FF000000C6C6C600FF000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60084848400FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF00000000008484840000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60084848400FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF0000000000848484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60084848400FFFFFF00FFFFFF00FFFFFF000000
      0000848484008484840000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60084848400FFFFFF00FFFFFF00FFFFFF000000
      000084848400848484000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF00848484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60084848400000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008484840000000000000000000000000084848400FFFF
      FF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF008484840000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C6000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0084848400000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C600848484000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600848484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00000000008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00848484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000000000C6C6C60084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000FFFF0084848400000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0084848400000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF00000000000000000000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0084848400848484008484
      8400848484008484840084848400000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C600FFFFFF0084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000FF000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000000000000000000000000000FF000000FF000000
      00000000000000000000000000000000000000000000000000008484840000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF008484840000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00C001FFFFFFFF0000C001E000E0000000
      C001C000C0000000C001C000C0000000C001800080000000C001800080000000
      C001000000000000C001000000000000C001000000000000C001800080000000
      C001800000000000C001800180010000C001C00380030000C003E00320030000
      C007F81FE81F0000C00FF8FFE8FF0000FFFFFFFFFFFF8001FFFFFFFFC0000001
      FFFFFFFF80000001FFFFFFFF80000001E01FFCFF80000001E79FF87F80000001
      F7BFFB7F80000001F33FF33F80008001FB7FF7BF8000C001F87FE79F8000C001
      FCFFE01F8000C001FFFFFFFF8001C001FFFFFFFFC07FC001FFFFFFFFE0FFC003
      FFFFFFFFFFFFC007FFFFFFFFFFFFC00FC001C001C001C001C001C001C001C001
      C001C001C001C001C001C001C001C001C001C001C001C001C001C001C001C001
      C001C001C001C001C001C001C001C001C001C001C001C001C001C001C001C001
      C001C00100010001C001C001C001C001C001C00180018001C003C00300030003
      C007C007C007C007C00FC00FC00FC00FFFFFFFFFC001C001E001E001C001C001
      C001C001C001C001C001C001C001C00180018001C001C00100010001C001C001
      00010001C001C00100000000C001C00180018001C001C00180018001C001C001
      80018001C001C00180038003C001C001C01FC01FC001C001E1BFE1BFC003C003
      FFFFFFFFC007C007FFFFFFFFC00FC00FFFFFFFFFFFFFFFFFFFFFFFFFC000E000
      FFFFFFFF8000C000E003E0038000C000FC1FFC1F80008000FFEFFFEF80008000
      FFE7FFE780000000FFF7FFF780000000FFF7FFF780000000F7F7F7F780008000
      F7F7F7F780008000F3E7F3E780018001FB9FFB9FC07FC07FFC3FFC3FE0FFE0FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ItemIcon32: TImageList
    Height = 32
    Width = 32
    Left = 36
    Top = 212
    Bitmap = {
      494C01010F001300B80020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000008000000001002000000000000000
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600008484000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00008484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600008484000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00008484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600008484000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00008484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600008484000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00008484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000084840000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600008484000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6008484840084848400848484008484840000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000848484008484
      840000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000008484
      84008484840084848400848484008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000848400000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400C6C6C6008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400C6C6C6008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      FF00FFFFFF00FFFFFF000000FF00848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      FF00FFFFFF00FFFFFF000000FF00848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      FF000000FF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      FF000000FF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600848484008484840084848400848484008484
      840084848400000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000008484
      84000000FF000000FF000000FF00FFFFFF000000FF000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000FF000000FF000000FF00FFFFFF000000FF000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      840000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      840000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00C6C6C600848484000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00C6C6C600848484000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00C6C6C600848484000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00C6C6C60084848400000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00C6C6C60084848400000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF00C6C6C60084848400000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400C6C6C6008484840000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400C6C6C6008484840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C6008484840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C6008484840000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF008484
      84000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF008484
      84000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000FF0084848400848484000000FF008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000FF0084848400848484000000FF008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008484840000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008484840000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C6000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF0000000000FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF0000000000FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00008484840000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008484840000000000FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008484840000000000FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000084848400C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000000000FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000000000FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00C6C6C6000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00C6C6C6000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FF00
      0000FFFFFF00FFFFFF00C6C6C6000000000000FFFF0000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FF00
      0000FFFFFF00FFFFFF00C6C6C6000000000000FFFF0000848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0000FFFF0084848400FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FF000000FFFF
      FF00FFFFFF00C6C6C6000000000000FFFF0000FFFF0000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0000FFFF0084848400FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FF000000FFFF
      FF00FFFFFF00C6C6C6000000000000FFFF0000FFFF0000848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF00C6C6C60000FFFF008484
      8400FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00C6C6C6000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF00C6C6C60000FFFF008484
      8400FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00C6C6C6000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400C6C6C6008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400C6C6C6008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400000000000000000000000000000000008484
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000008484
      840000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000008484
      8400C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C6000084840000000000000000000000000084848400C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00008484000000000000000000000000008484840000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C6000084840000000000000000000000000084848400C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00008484000000000000000000000000008484840000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C6008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C6000084840000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000084848400C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C6000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C6000084840000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C600848484000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000084848400C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00848484000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600008484000000000084848400C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C600000000008484840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000008484840000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00000000008484840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600008484000000000084848400C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF008484
      84000000000000FFFF0000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000008484840000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6008484
      840000000000C6C6C60000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600008484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00008484840000FFFF0000848400000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF000084840000000000000000008484840084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000008484
      8400FFFFFF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000008484
      8400FFFFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000848400000000000000000000000000000000008484
      8400FFFFFF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0000848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000848400000000000000000000000000000000008484
      8400FFFFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000008484
      8400FFFFFF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400FFFFFF0000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000800000000100010000000000000800000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFE0000007E000000700000000
      FFFFFFFFE0000007E0000007000000008000000180000007E000000700000000
      0000000000000007E0000007000000000000000000000007E000000700000000
      0000000000000007E0000007000000000000000000000007E000000700000000
      0000000000000007E0000007000000000000000000000007E000000700000000
      0000000000000007E0000007000000000000000000000007E000000700000000
      0000000000000007E0000007000000000000000000000007E000000700000000
      0000000080000007E00000070000000000000000C0000007E000000700000000
      00000000E0000007E00000070000000000000000E0000007E000000700000000
      00000000E0000007E00000070000000000000000E0000007E000000700000000
      00000000E0000007E00000070000000000000000E0000007E000000700000000
      00000000E0000007E00000070000000000000000E0000007E000000700000000
      00000000E0000007E00000070000000000000001E0000007E000000700000000
      8000FFFFE0000007E000000700000000C001FFFFE000000FE000000F00000000
      E003FFFFE000001FE000001F00000000F007FFFFE000003FE000003F00000000
      FFFFFFFFE000007FE000007F00000000FFFFFFFFE00000FFE00000FF00000000
      FFFFFFFFE00001FFE00001FF00000000E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E0000007E0000007E0000007E0000007
      E0000007E0000007E0000007E0000007E000000FE000000F8000000F8000000F
      E000001FE000001FE000001FE000001FE000003FE000003FC000003FC000003F
      E000007FE000007F8000007F8000007FE00000FFE00000FFE00000FFE00000FF
      E00001FFE00001FFE00001FFE00001FFFFFFFFFFFFFFFFFFE0000007E0000007
      FFFFFFFFFFFFFFFFE0000007E0000007FFFFFFFFFFFFFFFFE0000007E0000007
      FFFFFFFFFFFFFFFFE0000007E0000007FF00003FFF00003FE0000007E0000007
      FE00001FFE00001FE0000007E0000007FE00001FFE00001FE0000007E0000007
      FE00001FFE00001FE0000007E0000007FC00001FFC00001FE0000007E0000007
      FC00001FFC00001FE0000007E0000007FC00001FFC00001FE0000007E0000007
      F800001FF800001FE0000007E0000007F800001FF800001FE0000007E0000007
      F800001FF800001FE0000007E0000007F000000FF000000FE0000007E0000007
      F000001FF000001FE0000007E0000007F000001FF000001FE0000007E0000007
      F800001FF800001FE0000007E0000007FE00001FFE00001FE0000007E0000007
      FE00003FFE00003FE0000007E0000007FE00007FFE00007FE0000007E0000007
      FF0007FFFF0007FFE0000007E0000007FF800FFFFF800FFFE0000007E0000007
      FFFC1FFFFFFC1FFFE0000007E0000007FFFE3FFFFFFE3FFFE0000007E0000007
      FFFF7FFFFFFF7FFFE0000007E0000007FFFFFFFFFFFFFFFFE000000FE000000F
      FFFFFFFFFFFFFFFFE000001FE000001FFFFFFFFFFFFFFFFFE000003FE000003F
      FFFFFFFFFFFFFFFFE000007FE000007FFFFFFFFFFFFFFFFFE00000FFE00000FF
      FFFFFFFFFFFFFFFFE00001FFE00001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80000001F0000001
      FFFFFFFFFFFFFFFF00000000E0000000FFFFFFFFFFFFFFFF00000000E0000000
      FFFFFFFFFFFFFFFF00000000E0000000FFFFFC1FFFFFFC1F00000000C0000000
      FC0003FFFC0003FF00000000C0000000FFE00FFFFFE00FFF00000000C0000000
      FFFFF7FFFFFFF7FF00000000C0000000FFFFFBFFFFFFFBFF0000000080000000
      FFFFFDFFFFFFFDFF0000000080000000FFFFFDFFFFFFFDFF0000000080000000
      FFFFFEFFFFFFFEFF0000000080000000FFFFFEFFFFFFFEFF0000000000000000
      FFFFFF7FFFFFFF7F0000000000000000FFFFFF7FFFFFFF7F0000000000000000
      FFFFFF7FFFFFFF7F0000000000000000FFFFFF7FFFFFFF7F0000000000000000
      FEFFFEFFFEFFFEFF0000000080000000FEFFFEFFFEFFFEFF00000000E0000000
      FEFFFEFFFEFFFEFF00000000E0000000FF7FFEFFFF7FFEFF00000000E0000000
      FFBFF9FFFFBFF9FF00000000E0000001FFBFF7FFFFBFF7FF00000001E0000003
      FFDFCFFFFFDFCFFF8000FFFFF0001FFFFFE03FFFFFE03FFFC001FFFFF8003FFF
      FFFFFFFFFFFFFFFFE003FFFFFC007FFFFFFFFFFFFFFFFFFFF007FFFFFE00FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object HotToobarImageList: TImageList
    Left = 4
    Top = 244
    Bitmap = {
      494C01013F008000B80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000000001000001002000000000000000
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000045609200456092004560920045609200000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000456092004560920045609200456092004560920012192600456092004560
      9200000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004560920000DB000000DB000000DB00004560920045609200121926004560
      920000000000000000000000000000000000000000000000000000FFFF0000FF
      FF000000000000000000000000000000000000FFFF0000FFFF00000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF000000000000000000000000000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004560
      920000DB000000DB0000456092004560920045609200456092001219260000DB
      00004560920000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004560
      920000DB0000456092004560920045609200456092004560920000DB000000DB
      000000DB00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF000000000000FFFF0000FFFF000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000DB000000DB
      000000DB000000DB000000DB0000456092004560920000DB000000DB000000DB
      000000DB000000DB0000000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF00000000000000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF000000000000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000DB
      000000DB000000DB0000000000000000000000000000000000000000000000DB
      000000000000000000000000000000000000000000000000000000FF00000000
      000000000000000000000000000000FF00000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000000000000000FF000000
      0000000000000000000000FFFF000000FF000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A2B5D900A2B5
      D90000DB0000A2B5D90045609200A2B5D900A2B5D9004560920000DB000000DB
      000045609200456092000000000000000000000000000000000000FF00000000
      000000000000000000000000000000FF00000000000000000000000000000000
      0000000000000000000000FFFF000000000000000000000000000000FF000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A2B5D9000000
      0000A2B5D90000000000A2B5D9000000000000DB000000DB000000DB00000000
      000000000000456092000000000000000000000000000000000000FF00000000
      0000000000000000000000FF000000FF00000000000000000000000000000000
      000000000000000000000000000000FFFF0000000000000000000000FF000000
      00000000000000000000000000000000FF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A2B5
      D90045609200A2B5D90045609200A2B5D900A2B5D90045609200A2B5D9004560
      9200A2B5D900000000000000000000000000000000000000000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A2B5D900A2B5D900A2B5D900A2B5D90000000000A2B5D90045609200A2B5
      D90000000000000000000000000000000000000000000000000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A2B5D9004560920000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000000
      000000000000000000000000000000FF00000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000045609200456092004560920045609200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000045609200456092004560920045609200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000045609200456092004560920045609200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000456092004560920045609200456092004560920012192600456092004560
      9200000000000000000000000000000000000000000000000000000000000000
      00000000000049669A0049669A0049669A0049669A0049669A0049669A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000456092004560920045609200456092004560920012192600456092004560
      9200000000000000000000000000000000000000000000000000000000000000
      000045609200456092004560920045609200456092001219260045609200241C
      ED00000000000000000000000000000000000000000000000000000000000000
      000045609200A2B5D90045609200456092004560920045609200121926004560
      9200000000000000000000000000000000000000000000000000000000004966
      9A0049669A00839CCB00839CCB00839CCB00839CCB00839CCB00839CCB004966
      9A0049669A0000000000000000000000000000F2FF0000000000000000000000
      000045609200A2B5D90045609200456092000000000045609200121926004560
      9200000000000000000000000000000000000000000000000000000000000000
      000045609200A2B5D9004560920045609200456092004560920012192600241C
      ED00241CED000000000000000000000000000000000000000000000000004560
      920045609200A2B5D90045609200456092004560920045609200121926004560
      9200456092000000000000000000000000000000000000000000000000004966
      9A00839CCB00839CCB00839CCB003B527D00839CCB00839CCB00839CCB00839C
      CB0049669A000000000000000000000000000000000000F2FF00000000000000
      000045609200A2B5D900456092000000000000F2FF0000000000121926004560
      9200456092000000000000000000000000000000000000000000000000004560
      920045609200A2B5D9004560920045609200456092004560920012192600241C
      ED00241CED00241CED0000000000000000000000000000000000000000004560
      9200A2B5D9004560920045609200456092004560920045609200456092001219
      260045609200000000000000000000000000000000000000000049669A00839C
      CB00839CCB00839CCB003B527D003B527D003B527D00839CCB00839CCB00839C
      CB00839CCB0049669A000000000000000000000000000000000000F2FF0000F2
      FF000000000045609200456092000000000000F2FF0000F2FF00000000001219
      2600456092000000000000000000000000000000000000000000000000004560
      9200A2B5D9004560920045609200241CED00241CED00241CED00241CED00241C
      ED00241CED00241CED00241CED00000000000000000000000000000000004560
      9200456092004560920045609200456092004560920045609200121926001219
      2600121926000000000000000000000000000000000000000000839CCB00839C
      CB00839CCB00839CCB00839CCB003B527D003B527D00839CCB00839CCB003B52
      7D00839CCB0049669A00000000000000000000000000000000000000000000F2
      FF0000F2FF0000000000456092000000000000F2FF0000F2FF0000F2FF001219
      2600121926000000000000000000000000000000000000000000000000004560
      9200456092004560920045609200241CED00241CED00241CED00241CED00241C
      ED00241CED00241CED00241CED00241CED000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000839CCB00839C
      CB003B527D003B527D00839CCB00839CCB00839CCB00839CCB003B527D003B52
      7D00839CCB00839CCB0000000000000000000000000000000000000000000000
      000000F2FF0000F2FF000000000000F2FF0000F2FF000000000000F2FF0000F2
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000241CED00241CED00241CED00241CED00241C
      ED00241CED00241CED00241CED00000000000000000000000000A2B5D900A2B5
      D90045609200A2B5D90045609200A2B5D900A2B5D90045609200A2B5D900A2B5
      D90045609200456092000000000000000000000000000000000000000000839C
      CB00839CCB003B527D00839CCB00839CCB00839CCB00839CCB00839CCB00839C
      CB00839CCB000000000000000000000000000000000000000000A2B5D900A2B5
      D9000000000000F2FF0000F2FF0000F2FF0000000000456092000000000000F2
      FF0000F2FF000000000000000000000000000000000000000000A2B5D900A2B5
      D90045609200A2B5D90045609200A2B5D900A2B5D90045609200A2B5D900241C
      ED00241CED00241CED0000000000000000000000000000000000A2B5D9000000
      0000A2B5D90000000000A2B5D9000000000000000000A2B5D900000000000000
      000000000000456092000000000000000000000000000000000000000000839C
      CB00839CCB00839CCB00839CCB00839CCB00839CCB003B527D003B527D00839C
      CB00839CCB000000000000000000000000000000000000000000A2B5D9000000
      0000A2B5D9000000000000F2FF0000F2FF0000000000A2B5D900000000000000
      000000F2FF0000F2FF0000000000000000000000000000000000A2B5D9000000
      0000A2B5D90000000000A2B5D9000000000000000000A2B5D90000000000241C
      ED00241CED00456092000000000000000000000000000000000000000000A2B5
      D90045609200A2B5D90045609200A2B5D900A2B5D90045609200A2B5D9004560
      9200A2B5D9000000000000000000000000000000000000000000000000000000
      000000000000839CCB00839CCB003B527D00839CCB00839CCB003B527D000000
      000000000000000000000000000000000000000000000000000000000000A2B5
      D90045609200A2B5D9000000000000F2FF000000000045609200A2B5D9004560
      9200000000000000000000F2FF0000000000000000000000000000000000A2B5
      D90045609200A2B5D90045609200A2B5D900A2B5D90045609200A2B5D900241C
      ED00A2B5D9000000000000000000000000000000000000000000000000000000
      0000A2B5D900A2B5D900A2B5D900A2B5D90000000000A2B5D90045609200A2B5
      D900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A2B5D900A2B5D900A2B5D9000000000000000000A2B5D90045609200A2B5
      D90000000000000000000000000000F2FF000000000000000000000000000000
      0000A2B5D900A2B5D900A2B5D900A2B5D90000000000A2B5D90045609200A2B5
      D900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A2B5D9004560920000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A2B5D9004560920000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A2B5D9004560920000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000042840000428400004284000042840000428400004284000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      00000000FF000000FF000000FF0000000000000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000084840000000000C6C6C600C6C6C600848484000000
      FF000000FF000000000084848400000000000000000000000000000000000000
      0000004284004284E7004284E7004284E7004284E7004284E7004284E7000042
      8400000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000000000FF000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF008484840084848400FFFFFF00FFFFFF00848484000000
      0000000000000000FF0000000000000000000000000000000000000000000042
      84004284E7000000000000000000000000000000000000000000000000000000
      0000004284000000000000000000000000000000000000000000C6C6C600FFFF
      FF00C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00C6C6C600000000000000
      0000000000000000FF000000000000000000000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FFFFFF00C6C6C6000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000008484000000FF000000FF00C6C6C600FFFFFF00FFFFFF00848484000000
      000084848400000000000000FF00000000000000000000000000004284004284
      E7004284E7000000000000000000FFFFFF00FFFFFF00FFFFFF004284E7000000
      0000000000000042840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000084
      840000FFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00848484000000
      000000000000000000000000FF000000000000000000004284004284E7004284
      E7004284E7000000000000000000FFFFFF004284E7004284E7004284E7000000
      0000000000004284E7000042840000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00848484000000
      000000000000000000000000000000000000000000000000FF008484840000FF
      FF00FFFFFF0000FFFF00000000000000FF000000FF00FFFFFF00848484000000
      00000000000000000000000000000000FF0000000000004284004284E7004284
      E7004284E7000000000000000000FFFFFF004284E7004284E7004284E7000000
      0000000000004284E7000042840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      00000000000000E700000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C60084848400000000000000
      000000000000000000000000000000000000008484000000FF00C6C6C600FFFF
      FF0000FFFF00FFFFFF0000000000848484000000FF000000FF00848484000000
      00008484840084848400848484000000FF0000000000004284004284E7004284
      E7004284E7000000000000000000000000000000000000000000000000000000
      00004284E7004284E7000042840000000000000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00C6C6C600000000000000
      000000E7000000E7000000E70000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840000000000000000000000
      000000000000000000000000000000000000008484000000FF00C6C6C60000FF
      FF00FFFFFF0000FFFF0000000000C6C6C600000000000000FF000000FF000000
      00000000000000000000000000000000FF0000000000004284004284E7004284
      E7004284E7000000000000000000FFFFFF00FFFFFF00FFFFFF00000000004284
      E7004284E7004284E7000042840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      00000000000000E7000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000008484000000FF00C6C6C600FFFF
      FF0000FFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000FF000000
      FF000000000000000000000000000000FF0000000000004284004284E7004284
      E7004284E7000000000000000000FFFFFF004284E7004284E700000000000000
      00004284E7004284E7000042840000000000000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000008484000000FF0000FF
      FF00FFFFFF0000FFFF0000000000C6C6C600FFFFFF00FFFFFF00848484000000
      FF000000FF00000000000000FF000000000000000000004284004284E7004284
      E7004284E7000000000000000000FFFFFF004284E7004284E700000000000000
      00004284E7004284E7000042840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000084
      840000FFFF00FFFFFF0000000000C6C6C600FFFFFF00FFFFFF00848484000000
      00000000FF000000FF000000FF00000000000000000000000000004284004284
      E7004284E7000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      00004284E700004284000000000000000000000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00C6C6C600000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000084840000FFFF008484840084848400C6C6C600FFFFFF00848484000000
      0000000000000000FF0084848400000000000000000000000000000000000042
      84004284E7000000000000000000000000000000000000000000000000004284
      E70000428400000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000FF00000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000FFFF0000000000C6C6C600C6C6C600000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000004284004284E7004284E7004284E7004284E7004284E7004284E7000042
      840000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF0084848400000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000042840000428400004284000042840000428400004284000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484840000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      000000000000000000000000000084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000000000000FFFF
      FF0000000000FF848400FF848400FF848400FF848400FF848400FF8484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0000000000000000000000000000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      000000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000000000000FFFF
      FF0000000000FF848400FF848400FF848400FF848400FF848400FF8484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      000000000000000000000000000084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000000000000FFFF
      FF0000000000FF848400FF848400FF848400FF848400FF848400FF8484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0000000000000000000000000000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      000000000000000000000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000000000000FFFF
      FF0000000000FF848400FF848400FF848400FF848400FF848400FF8484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      000000000000000000000000000084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000000000000FFFF
      FF0000000000FF848400FF848400FF848400FF848400FF848400FF8484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      00000000000000000000000000000000000000000000000000000000000084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000000000000FFFF
      FF0000000000FF848400FF848400FF848400FF848400FF848400FF8484000000
      0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000FF000000FF0000008400000000000000FFFF
      FF00FFFFFF00FFFFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000000000000FFFF
      FF0000000000FF848400FF848400FF848400FF848400FF848400FF8484000000
      0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084000000FF000000FF0000008400000000000000FFFF
      FF00FFFFFF00FFFFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FF
      FF0084FFFF0084FFFF000000000000000000000000000000000000000000FFFF
      FF0000000000FF848400FF848400FF848400FF848400FF848400FF8484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FF000000FF00000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000C6C6C6000000
      00000084840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FFFFFF00FF00
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000FF000084840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000C6C6C6000000
      00000084840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FFFFFF00FF00
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF0000FF
      000000FF000000FF0000FFFFFF0000FF000084840000FFFFFF0000FF000000FF
      000084840000FFFFFF00FFFFFF0000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000000000
      00000084840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FF000000FFFFFF00FF000000FFFFFF00FF00
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000FF000000FF000000FF000000FF000000FF000084840000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000084840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FF000000FFFFFF00FF00
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FF000000FF000000FF000084840000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000000084
      84000084840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FFFFFF00FF00
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF0000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000084840000FFFFFF00FFFFFF0000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00000084840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000FF000084840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00000084840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000FF000084840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084FFFF0084FF
      FF0084FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000FF000000FF000000FF000000FF000000FF000000FF000000FF00008484
      0000FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000FF000084840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084FFFF0084FF
      FF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF0084FFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB500000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600000000000000000000000000FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000B5FFB500C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600B5FFB500000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000B5FFB500C6C6C600B5FFB500B5FF
      B500B5FFB500FF000000FF000000FF000000FF000000FF000000B5FFB500B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF0084848400848484008484840084848400FF00000084848400FF848400FF00
      0000FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000B5FFB500C6C6C600420042004200
      4200B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FF00
      0000FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000B5FFB500C6C6C600B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF0084848400848484008484840084848400FF000000FF00000084848400FF00
      0000FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000B5FFB500C6C6C600420042004200
      4200420042004200420042004200B5FFB50042004200B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF848400FFFFFF00FF00
      0000FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000B5FFB500C6C6C600B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000B5FFB500C6C6C600420042004200
      420042004200B5FFB5004200420042004200420042004200420042004200B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000B5FFB500C6C6C600B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000B5FFB500C6C6C60042004200C6C6
      C60042004200B5FFB50042004200B5FFB50042004200B5FFB50042004200B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000B5FFB500C6C6C600B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000FF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000FF000000
      000000000000000000000000000000000000B5FFB500C6C6C600420042004200
      420042004200420042004200420042004200B5FFB500FF000000FF000000FF00
      0000B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF0000000000000000000000000000000000B5FFB500C6C6C600B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500C6C6C600B5FFB500000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF00000000000000000000000000B5FFB500C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600B5FFB500000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FFB500B5FF
      B500B5FFB500B5FFB500B5FFB500B5FFB5000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008484000084840000848400000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000084
      8400008484000084840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000848400008484000084840000FFFF0000FFFF0000FFFF00008484000084
      8400000000000000000000000000000000000084840000FFFF0000FFFF000084
      8400008484000000000000000000000000000000000000000000008484000084
      840000FFFF0000FFFF0000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000FFFF000084
      840000000000000000000000000000000000008484000084840000FFFF0000FF
      FF000084840000848400008484000000000000848400008484000084840000FF
      FF0000FFFF0000848400008484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000000000FF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FF
      FF0000848400008484000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000848400008484000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FFFF000084
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000FFFF0000848400000000000000000000000000008484000084840000FF
      FF0000FFFF0000FFFF0000FFFF000084840000FFFF0000FFFF0000FFFF0000FF
      FF000084840000848400000000000000000000000000FFFFFF000000FF000000
      FF000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FFFF000084
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000FFFF0000848400008484000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000084840000000000000000000000000000000000FFFFFF00FFFFFF000000
      FF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000FFFF00008484000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000084840000000000000000000000000000000000FFFFFF00FFFFFF000000
      FF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00C6C6C6008484840084848400C6C6C600C6C6C600FFFF
      FF000000000000FFFF0000848400000000000000000000000000008484000084
      840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000084
      84000084840000000000000000000000000000000000FFFFFF00FFFFFF000000
      FF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000848400FFFF
      FF00FFFFFF00C6C6C60084848400FFFFFF00FFFFFF008484840084848400C6C6
      C600FFFFFF0000FFFF00008484000000000000000000008484000084840000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000084840000848400000000000000000000000000FFFFFF00FFFFFF000000
      FF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000FFFF000084
      8400FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000FFFF00008484000000000000000000008484000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000848400008484000000000000000000FFFFFF000000FF000000
      FF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF00FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000FFFF000084
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000FFFF000084840000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00008484000000000000000000FFFFFF00FFFFFF000000
      FF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF00FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF0000848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FF
      FF00008484000000000000000000000000000084840000848400008484000084
      84000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00008484000084
      84000084840000848400008484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF00008484000084840000000000FFFFFF00FFFFFF0000FFFF000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000FFFF0000FFFF0000FFFF0000848400008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000848400000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000848400008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000008484000084840000FFFF000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AD7B6B00DEAD
      9C00D6AD9C00D6A59C00D6A59400CEA59C00CE9C9400C69C9400C69C9400C694
      9400B5948C00BD8C8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5847300FFE7
      CE00FFE7CE00FFDEC600FFDEC600FFDEBD00FFDEBD00A59C8C007B6B6B00847B
      8400CEB5AD00EFBDA50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000084
      0000848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD8C7300FFE7
      CE00FFE7CE00FFE7CE00FFDEC600FFDEC600A59C8C007B6B6B00947B94005284
      CE0094B5CE00EFBDAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000084
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C68C7B00FFE7
      D600FFD6AD00FFD6AD00FFD6AD00B5A594007B6B6300947B94005284D60063BD
      FF00DEDEDE00F7C6AD0000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000084
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE947B00948C
      8C008C847B00948C8400ADADA500847B7B0084738C005284CE005AB5FF00CEDE
      E700FFDEBD00F7C6AD0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000084
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B009484
      7B00D6C6AD00D6C6A500C6AD94009C847B007B94B50063BDFF00C6CED600FFD6
      AD00FFDEBD00F7C6B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000084
      0000FFFFFF008484000000000000000000000000000000000000000000000084
      00000000000000000000000000000000000000000000736B6B0094847B00FFF7
      EF00FFFFF700FFFFDE00FFFFCE00EFCEA500D6BDBD00D6DEE700FFE7CE00FFDE
      C600FFDEC600F7CEB50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000840000C6C6C60084840000000000000000000000000000000000008484
      00000084000000000000000000000000000000000000735A6300DECEB500FFFF
      FF00FFFFFF00FFFFE700FFFFC600FFEFB500EFD6BD00FFD6AD00FFD6AD00FFD6
      AD00FFDEC600F7CEB50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000840000FFFFFF00C6C6C60000FF00000084000000840000848400008484
      000084840000008400000000000000000000000000007B636B00F7E7BD00FFFF
      EF00FFFFEF00FFFFDE00FFF7BD00FFEFBD00EFD6B500FFE7D600FFE7D600FFE7
      CE00FFE7CE00F7CEBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      00000000000000840000FFFFFF00FFFFFF00C6C6C60000FF000000FF000000FF
      000000FF0000848400000084000000000000000000008C7B7B00E7D6AD00FFFF
      D600FFFFCE00FFFFC600FFEFBD00FFF7CE00EFD6BD00FFD6AD00FFD6AD00FFD6
      AD00FFE7D600F7CEBD0000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000000000000000000084000000840000FFFFFF00FFFFFF00FFFFFF00C6C6
      C60000FF000000FF000000000000000000000000000000000000C6AD9400FFF7
      BD00FFEFB500FFEFBD00FFFFE700FFF7E700E7CEC600FFEFDE00FFEFDE00FFEF
      DE00FFE7D600F7CEBD0000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000000000000000000000000000000000008400000084000000840000FFFF
      FF00C6C6C6000000000000000000000000000000000000000000C69C8400D6BD
      9C00F7DEB500F7DEB500F7E7D600E7D6D600FFF7E700FFEFE700FFD6CE00FFD6
      CE00F7B5AD00D639B50000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000840000FFFF
      FF00000000000000000000000000000000000000000000000000DEAD8400FFFF
      FF00FFFFF700FFFFF700FFF7F700FFF7EF00FFF7EF00FFF7E700F7A54200F7A5
      4200E78C42000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008400000000
      0000000000000000000000000000000000000000000000000000DEAD8400FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFF7EF00FFF7EF00DEAD8400EFAD
      7B00E708DE000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008400000000
      0000000000000000000000000000000000000000000000000000DEAD8400DEAD
      8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8C00D6A58400DEAD8400FF29
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840084848400848484008484840000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      840084848400848484008484840084848400848484008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400848484000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000000084000000FF000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00848484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000000084000000FF000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600848484000000000084848400FFFFFF0000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF000084000000840000008400000084000000840000FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000084000000
      FF00000084000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00848484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFFFF00008400000084
      0000FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      84000000FF0000008400000000000000000000000000000000000000FF000000
      8400000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000008484840000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF000084
      0000FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000084000000FF000000840000000000000000000000FF00000084000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008484840000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF0000840000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000084
      0000FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000000000000000084000000FF00000084000000FF0000008400000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000000000000000000000848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF0000840000FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF000084000000840000FFFFFF000084000000840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000084000000FF0000008400000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF000084000000840000008400000084000000840000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      00000000FF000000FF000000840000000000000000000000FF00000084000000
      000000000000000000000000000000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0084848400848484008484
      8400848484008484840084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000084000000
      FF000000FF0000008400000000000000000000000000000000000000FF000000
      84000000000000000000000000000000000000000000000000008484840000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840084848400848484008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF0084848400000000000000000000000000000084000000FF000000
      FF00000084000000000000000000000000000000000000000000000000000000
      FF00000084000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000084000084000000840000000000000000000000FF0000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000FF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000084000000FF000000FF00000000000000000000FF000000000000000000
      000000000000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000000000000FFFFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
      FF000000FF000000FF0000840000008400000084000000840000008400000084
      00000084000000840000FFFFFF0000000000000000000000000000000000FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00000000000084
      000000FF000000FF0000000000000000000000848400FF000000000000008400
      0000FF000000FF000000FF000000FF00000084000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000084000000FF
      000000FF0000000000000000000000000000008484000084840084000000FF00
      0000FF000000C6C6C600C6C6C60084000000FF00000084000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000000000000FFFFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000840000008400000084
      00000084000000840000FFFFFF0000000000000000000000000000000000FFFF
      FF00FF000000FF000000FF000000FFFFFF00000000000084000000FF000000FF
      00000000000000000000000000000000000000848400C6C6C60084000000FF00
      000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000000000000000FF000000
      0000000000000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FF00000000
      0000FFFFFF00000000000000000000000000000000000084840000FFFF00FF00
      0000FF000000FF000000FF000000FF000000FF00000084000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000000000000000FF000000
      FF00000000000000FF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000084000000840000FFFFFF0000000000000000000000000000000000FFFF
      FF00FF000000FF000000FF000000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF0000000000000000000000000000000000840000000084840000FF
      FF00FF000000FFFFFF00FFFFFF0084000000FF00000084000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      FF000000FF000000FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000840000000084
      840000FFFF00FF000000FF000000FF00000084000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000840000008400000084
      00000084000000840000FFFFFF0000000000000000000000000000000000FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FFFFFF000000000000000000000000000000000000000000000000008400
      0000FF000000FF000000FF00000084000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000000000000000FF000000
      FF00000000000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
      FF000000FF000000FF0000840000008400000084000000840000008400000084
      00000084000000840000FFFFFF0000000000000000000000000000000000FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FFFFFF000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000FF000000FF00000000000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000FF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      FF00000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      FF0000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      00000000000000000000000000000000000000FF000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000000000000000000000000000FF0000008400000000
      00000000000000000000000000000000000000000000000000000000000000FF
      00000084000000000000000000000000000000FF000000000000000000000084
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FFFF0000FFFF0000FFFF0000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000840000000000000000000000FF000000FF00000084
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF000000840000000000000000000000FF0000000000000084000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FFFF0000FFFF0000FFFF0000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000008400000000000000FF000000FF000000FF
      00000084000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF0000008400000000000000FF00000084000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084000000FF00000084000000000000000000000084000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000084
      000000FF000000840000000000000000000000FF0000000000000084000000FF
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000084000000000000000000000000000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000084
      00000084000000000000000000000000000000FF000000000000000000000084
      0000008400000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FFFF0000FFFF0000FFFF0000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      00000000000000000000000000000000000000FF000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FFFF0000FFFF0000FFFF0000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FFFF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000840000008400000084000000FF000000FF000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000840000008400000084000000FF000000FF000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000084000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084000000FF000000FF000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000000000000000000000000000000000000084
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084000000FF000000FF000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084000000FF000000FF000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000084000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000FF00000000000000000000000000000084000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000084000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000840000008400000084000000FF000000FF000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084000000FF000000FF000000000000000000000084000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      000000FF000000FF000000FF0000000000000084000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      00000084000000FF00000084000000000000000000000084000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000840000008400000084000000FF000000FF000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000084000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000000000000000000000000000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084000000FF000000FF000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084000000FF000000FF000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000084000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000000000000000000000000000000000000084
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000084000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000840000008400000084000000FF000000FF000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084000000FF000000FF000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000840000008400000084000000FF000000FF000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000008484000084
      8400000000000000000084000000840000008400000084000000840000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000FFFF00C6C6C60000FF
      FF00C6C6C600008400000084000000840000C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000084840000FFFF00000000000000
      0000008400000084000000000000FF00000084000000FF000000840000008400
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FFFFFF00FFFFFF00FF000000FF000000FF00
      0000FF000000C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C600008400000084000000FFFF00C6C6C60000FFFF00C6C6C60000FFFF000084
      000000FFFF00C6C6C60000FFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000084840000FFFF00000000000084
      00000084000000FF00000000000000000000FF00000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FFFFFF00C6C6C60000000000000000000000000000FFFF00C6C6C60000FF
      FF000084000000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00008400000084
      00000084000000FFFF00C6C6C60000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF000084000000840000008400000084000000840000FFFF
      FF00FFFFFF00C6C6C60000000000000000000084840000FFFF0000FFFF000000
      0000C6C6C6000000000000000000FF000000840000000084840000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FFFFFF00C6C6C600000000000000000000000000C6C6C600008400000084
      0000008400000084000000840000C6C6C60000FFFF0000840000008400000084
      0000008400000084000000FFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFFFF00008400000084
      0000FFFFFF00C6C6C600000000000000000000848400FFFFFF0000FFFF0000FF
      FF000000000000FFFF0000000000FF000000FF00000000848400FFFFFF0000FF
      FF0000FFFF00000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FFFFFF00C6C6C60000000000000000000000000000FFFF00C6C6C6000084
      00000084000000840000C6C6C60000FFFF00C6C6C60000FFFF00C6C6C6000084
      0000C6C6C60000FFFF00C6C6C60000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF000084
      0000FFFFFF00C6C6C60000000000000000000000000000848400FFFFFF0000FF
      FF0000FFFF0000FFFF000000000084840000FF0000000084840000FFFF00FFFF
      FF0000FFFF0000FFFF000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FF000000FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C60000840000C6C6C60000FFFF00C6C6C60000FFFF00C6C6C600008400000084
      000000FFFF00C6C6C60000FFFF0000000000000000000000000084848400FFFF
      FF0000840000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000084
      0000FFFFFF00C6C6C6000000000000000000000000000000000000000000FFFF
      FF0000FFFF0000FFFF0000000000FF0000008484000000848400FFFFFF000084
      8400FFFFFF0000FFFF0000FFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FF000000FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF0000840000008400000084000000FF
      FF00C6C6C60000FFFF00C6C6C60000000000000000000000000084848400FFFF
      FF0000840000FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF000000000084840000FF0000000084840000848400FF00
      000000848400FFFFFF0000FFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF0000000000000000000000000084848400FFFF
      FF000084000000840000FFFFFF000084000000840000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000084840000848400008484000084
      8400008484000084840000000000FF000000FF00000000848400FF0000008400
      00000084000000848400FFFFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF000084000000840000008400000084000000840000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000084848400C6C6C60000FF00000084000000FF000000840000008400000084
      0000000000000084840000FFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FFFFFF000000
      000000000000000000000000000000000000000000000000000000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400FFFFFF00FFFFFF00C6C6C60000FF0000008400000000
      000000FFFF0000FFFF000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF0084848400000000000000000000000000000000000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400848484000000
      000000848400008484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FF00
      0000FF000000FFFFFF00C6C6C600000000000000000000000000000000000000
      000084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF00C6C6C60000FFFF000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000FFFF00C6C6C60000FF
      FF00C6C6C60000000000C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FF00
      0000FF000000FFFFFF00C6C6C60000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6
      C60000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF000000000000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C60000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C60000000000C6C6
      C60000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000FFFF00C6C6C6000000
      000000000000000000000000000000000000C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000084848400848484008484
      840084848400848484008484840000000000000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00C6C6C60000000000C6C6
      C60000000000C6C6C600000000000000000000000000000000000000FF00FFFF
      FF00848484000000FF0084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C600000000000000000000000000C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      840084848400848484008484840084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C60000000000C6C6
      C6000000000000000000000000000000000000000000000000000000FF000000
      FF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000FFFF00C6C6C60000FF
      FF00C6C6C60000000000C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00C6C6C60000000000C6C6
      C600000000008484840000000000000000000000000000000000848484000000
      FF000000FF000000FF00848484000000FF000000FF0084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FF00
      0000FF000000FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00C6C6C600000000008484
      84000000000000000000000000000000000000000000000000000000FF000000
      FF00848484000000FF000000FF00848484008484840084848400848484008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FF00
      0000FF000000FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000FF000000FF00848484000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      84008484840084848400848484000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      FF0084848400848484000000FF00848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FF000000FF00
      0000FF000000FF000000FF000000FF000000FFFFFF00FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF000000000000000000FFFFFF00840000008400
      000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000840000008400
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF000000000000000000FFFFFF0084000000FFFF
      FF0084000000FFFFFF000000000000000000FFFFFF0084000000FFFFFF008400
      0000FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF000000000000000000FFFFFF00840000008400
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF000000000000000000FFFFFF00840000008400
      000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0084000000840000008400
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF000000000000000000FFFFFF0084000000FFFF
      FF0084000000FFFFFF000000000000000000FFFFFF0084000000FFFFFF008400
      0000FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00840000008400
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008400000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000084000000840000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C60084848400848484000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400C6C6C6008484840084848400000000000000000000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008400000000FFFF00C6C6C60084000000C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600000000000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000FF000000FF
      0000C6C6C60084848400848484000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF008400000084000000C6C6C60000FFFF008400000084000000C6C6
      C60000FFFF00C6C6C60000FFFF00000000000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      84000000840000008400000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000FF000000FF
      0000C6C6C6008484840084848400000000000000000000FFFF00C6C6C60000FF
      FF0084000000FF0000008400000000FFFF00C6C6C60084000000FF0000008400
      0000C6C6C60000FFFF00C6C6C600000000000000000000008400000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000008400000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084848400848484000000000000000000C6C6C60000FFFF008400
      0000FF000000FF00000084000000C6C6C60000FFFF0084000000FF000000FF00
      000084000000C6C6C60000FFFF00000000000000000000008400000084000000
      840000008400FFFFFF00FFFFFF000000840000008400FFFFFF00FFFFFF000000
      840000008400000084000000840000000000000000000000000000FFFF0000FF
      FF000000000000000000000000000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60084000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084848400000000000000000000FFFF00C6C6C60000FF
      FF0084000000FF0000008400000000FFFF00C6C6C60084000000FF0000008400
      0000C6C6C60000FFFF00C6C6C600000000000000000000008400000084000000
      84000000840000008400FFFFFF00FFFFFF00FFFFFF00FFFFFF00000084000000
      84000000840000008400000084000000000000000000000000000000000000FF
      FF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084000000FF0000008400000084848400848484008484
      84008484840084848400848484000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF008400000084000000C6C6C60000FFFF008400000084000000C6C6
      C60000FFFF00C6C6C60000FFFF00000000000000000000008400000084000000
      8400000084000000840000008400FFFFFF00FFFFFF0000008400000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      000000FFFF0000FFFF000000000000FFFF0000FFFF000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FF000000FF000000FF00000084000000848484000000
      0000000000000000000000000000000000000000000000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008400000000FFFF00C6C6C60084000000C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C600000000000000000000008400000084000000
      84000000840000008400FFFFFF00FFFFFF00FFFFFF00FFFFFF00000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000084000000FF000000FF000000FF000000FF000000FF000000840000008484
      84000000000000000000000000000000000000000000C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00000000000000000000008400000084000000
      840000008400FFFFFF00FFFFFF000000840000008400FFFFFF00FFFFFF000000
      8400000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000008400
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000008400
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000840000008400
      00008400000084000000FF000000FF000000FF00000084000000840000008400
      000084000000848484000000000000000000000000000000000000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      00000000000084000000FF000000FF000000FF00000084000000848484000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FF000000FF000000FF00000084000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000084000000840000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000000100000100010000000000000800000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FC3F7FFF7FFF0000
      F00F3F7F3F7F0000E0070E3F0E3F0000E007861F861F0000C003C20FC20F0000
      C003E007E0070000C003C0C380430000C003806188610000800188708C700000
      8001887C807C0000C003887E807E0000E0078E7F807F0000F00F807F8C7F0000
      FE7FC0FF8C7F0000FFFFE1FF8C7F0000FFFFFFFFFFFFFFFFFC3FFFFFFC3FFC3F
      F00FF81FF00FF00FE007E0076007E007E007C0032007E007C003C0030003C003
      C00380018003C001C0038001C003C000C0038001C003C0018001C00380018001
      8001C00380018001C003E007C000C003E007F81FE004E007F00FFFFFF00EF00F
      FE7FFFFFFE7FFE7FFFFFFFFFFFFFFFFFFE7FFFFFC01BC00FFC1FF81FC011C00F
      F005F00FC01BC00FE01BE007C01BC00FC015C003C01FC00F801D8001C01FC01F
      001E8001C01BC03F00108001C011C07F001E8001C01BFBFF000E8001C01FFBFF
      80058001C01FFBFFC011C003C01BFBFFE019E007C01BE0FFF027F00FC031FBFF
      FC1FF81FC07BFBFFFE7FFFFFC0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003
      FFFFFFFFFFFFC003FC01803FFC01C003FC01803C3C01C003FC01803C3C01C003
      FC01803C3C01C003FC01803C3C01C003FC01803C3C01C003C00180000001C003
      C00180000001C003C00180000001C003C00180000001C003FFFFFFFC3FFFC003
      FFFFFFFC3FFFC003FFFFFFFFFFFFFFFFFF7EFFFFFFFFFFFFBFFF00000000FFFF
      F00300000000FFFFE00300000000803FE00300000000803FE00300000000803F
      E00300000000803F200300000000803FE00200000000803FE003000000008003
      E003000000008003E003000000008003E003000000008003FFFF00000000FFFF
      BF7D00000000FFFF7F7EFFFFFFFFFFFFFFFFFFFFFFFFC001000000000000C001
      000000000000C001000000000000C001000000000000C001000000000000C001
      000000000000C001000000000000C001000000000000C001000700070000C001
      000700070000C001000700070000C001000700070000C001800F000F0000C003
      FFFFFFE70000C007FFFFFFFF0000C00FFE3F0FE1FFFFFFFFF00F07C100000000
      E00F010100000000E003800300000000C003800300000000C001C00700000000
      8001C007000000008001C007000000008001800300000000C003000100000007
      C003000100000007E007000100000007F00FF01F00000007F81FF83F0000800F
      FC1FF83F0000FFFFF81FFC7FFFFFFFFFC001F8FFC003FFFFC001F1FFC003FFFF
      C001E3FFC003FFFFC001E3FFC003E003C001E3DFC003FC1FC001E3CFC003FFEF
      C001E1C78003FFE7C001F0038003FFF7C001F0018003FFF7C001F8008003F7F7
      C001FC01C003F7F7C001FF03C003F3E7C001FFC7C007FB9FC003FFCFC007FC3F
      C007FFDFC00FFFFFC00FFFFFFFFFFFFFC001FFFFFFFF8001C001FFFFC0000001
      C0019FFB80000001C0018FFF80000001C00187F780000001C001C7EF80000001
      C001E3CF80000001C001F19F80008001C001F83F8000C001C001FC7F8000C001
      C001F83F8000C001C001F19F8001C001C001C3CFC07FC001C00387E7E0FFC003
      C0078FFBFFFFC007C00FFFFFFFFFC00FFFFFFFFFFFFFE001F000F000C001E001
      F000F000C000C001F000C000C000A001F000E000C0010001F000F000C0030001
      F000F000C0030001D0000000C0038001C0000000C0038001E0000000C003C001
      0000F000C003E001C000F000C003E0018000E000C003E0032000C000C003E007
      E000F000C003E00FEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3FC003
      FFFFFE7FFC3FC003EF7FDE7BFC3FFE7FE73FCE73FC3FFC3FE31FC663FC3FF81F
      E10FC243FC3FF00FE007C003FC3FE007E007C003E007FC3FE10FC243F00FFC3F
      E31FC663F81FFC3FE73FCE73FC3FFC3FEF7FDE7BFE7FFC3FFFFFFE7FC003FC3F
      FFFFFFFFC003FC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFE007FFFFE007FE7FF00FFEF7F00FFC3FF81FFCE7F81FF81FFC3FF8C7
      FC3FF00FFE7FF087FE7FE007C003E007E007FE7FC003E007F00FFC3FFE7FF087
      F81FF81FFC3FF8C7FC3FF00FF81FFCE7FE7FE007F00FFEF7FFFFFFFFE007FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC001FFFFC001FFFFC0010000C001CC1F
      C0010000C001800FC0010000C0010007C0010000C0010000C0010000C0010001
      C0010000C0010001C0010000C0018001C0010000C001C000C0010000C0018000
      C0010000C0010000C0010000C001F000C001803FC001F801C003C07FC003FC13
      C007E0FFC007FFFFC00FFFFFC00FFFFFFFFF8080FC01C00100008080FC01C001
      00008080F001C00100008080F001C00100008080C001C00100008080C001C001
      00008080C001C00100008080C001C00100008080C001C00100008080C003C001
      00008080C007000100008080C00FC001803F8080C01F8001C07F8080C03F0003
      E0FF8080C07FC007FFFF8080C0FFC00FFFFFFFFFFFFFFFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFF8003FFFFF81FFFFF00010000E007FFFF
      00000000C003FFFF0000000080017FFF0000000080013F7F0000000000000E3F
      000000000000861F800000000000C20FC00100000000E007F81F00000000F043
      F00F00000000F861E00700008001FC70C003803F8001FEFCF81FC07FC003FFFE
      F81FE0FFE007FFFFF83FFFFFF81FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ItemImageList: TImageList
    Left = 4
    Top = 276
    Bitmap = {
      494C010103000400B80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000008400840084008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840084008400840084008400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400840084008400840084008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840084008400840084008400840084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840084008400840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840084008400840084008400840084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840084008400840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840084008400840084008400840084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840084008400840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00848484008400840084008400840084000000FF00FFFF
      FF00848484000000FF0084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00848484008400840084008400840084000000FF000000
      FF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400840084008400840084008400848484000000
      FF000000FF000000FF00848484000000FF000000FF0084848400848484008484
      8400FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400840084000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00848484008400840084008400840084000000FF000000
      FF00848484000000FF000000FF00848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840084848400848484008484840084008400840084000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF000000
      0000000000000000000000000000840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840084008400840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60084008400840084000000FF000000FF00848484000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840084008400840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000840084008400840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484008400840084008400840084008400840084008400C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6008400840084008400840084008400840084008400848484000000
      FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484008400840084008400840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400840084008400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400840084008400840084008400840084008400840084008400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600840084008400840084008400840084008400840084008400848484000000
      FF0084848400848484000000FF00848484008484840084848400848484008484
      8400840084008400840084008400840084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object MessageImageList: TImageList
    Height = 12
    Width = 32
    Left = 36
    Top = 276
    Bitmap = {
      494C010104000900B80020000C00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000001800000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      F700F7F7F700FFFFFF00FFFFFF00F7F7F700F7F7F70000000000FFFFFF00F7F7
      F700CECECE00F7F7F700CECECE00CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00F7F7F700FFFFFF00FFFFFF000000000000000000F7F7F700000000000000
      0000CECECE00F7F7F700CECECE00CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      F700FFFFFF00F7F7F70000000000F7F7F700F7F7F700F7F7F70000000000F7F7
      F700F7F7F700CECECE00F7F7F700CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      F700FFFFFF00F7F7F70000000000F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F70000000000CECECE00F7F7F700CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700F7F7F700F7F7F70000000000A5A5CE0000000000FFFF
      FF00F7F7F700CECECE00F7F7F700CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F700FFFFFF00F7F7F700000000009494C6009494C600000000009494C6009494
      C60000000000CECECE00F7F7F700CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7F7F700FFFF
      FF00F7F7F700F7F7F7000000000000000000000000000000000000000000F7F7
      F700CECECE00F7F7F700CECECE00CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7F7F700FFFF
      FF00F7F7F700F7F7F70000000000000000000000000000000000000000000000
      000000000000F7F7F700CECECE00CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F700F7F7F700F7F7F700F7F7F70000000000A5A5CE00A5A5CE00A5A5CE000000
      0000CECECE00F7F7F700CECECE00CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00F7F7F700F7F7F700000000009494C6009494C600000000009494C6009494
      C60000000000F7F7F700CECECE00CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F700F7F7F700F7F7F700F7F7F700000000009494C6009494C60000000000F7F7
      F700F7F7F700CECECE00F7F7F700CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F700F7F7F700F7F7F700F7F7F700000000009494C6009494C6009494C6000000
      0000F7F7F700CECECE00F7F7F700CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F7000000000000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF000000000000000000F7F7F700CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F7000000000000000000F7F7F700000000009494C6009494C6009494C6000000
      0000FFFFFF000000000000000000F7F7F700CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7F7F700FFFF
      FF00F7F7F700F7F7F700F7F7F700000000009494C6009494C60000000000F7F7
      F700F7F7F700F7F7F700CECECE00F7F7F700CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7F7F700FFFF
      FF00F7F7F700F7F7F700F7F7F700000000009494C6009494C6009494C6000000
      0000F7F7F700F7F7F700CECECE00F7F7F700CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000000000000000000F7F7F70000000000FFFFFF00F7F7F700F7F7F7000000
      0000CECECE000000000000000000CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000000000000000000F7F7F700F7F7F700000000009494C60000000000F7F7
      F700F7F7F7000000000000000000CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F70000000000F7F7F700F7F7F700000000009494C6009494C60000000000F7F7
      F700F7F7F70000000000F7F7F700CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F70000000000F7F7F700F7F7F70000000000000000000000000000000000F7F7
      F700F7F7F70000000000F7F7F700CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00F7F7
      F700FFFFFF00F7F7F700F7F7F70000000000F7F7F700F7F7F700F7F7F7000000
      0000F7F7F700CECECE00F7F7F700CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000F7F7F700FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700CECECE00CECECE0000000000CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7F7F7000000
      0000FFFFFF0000000000F7F7F700000000009494C6009494C60000000000F7F7
      F70000000000FFFFFF0000000000CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00F7F7F7000000
      0000FFFFFF0000000000F7F7F700FFFFFF00F7F7F700FFFFFF00F7F7F700F7F7
      F70000000000FFFFFF0000000000CECECE00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00F7F7F700F7F7F700F7F7F700FFFFFF00F7F7F700FFFFFF00F7F7
      F700CECECE00FFFFFF00CECECE00CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00F7F7
      F70000000000F7F7F700F7F7F700F7F7F700FFFFFF00F7F7F700FFFFFF00F7F7
      F700CECECE00FFFFFF0000000000CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F7F700F7F7
      F70000000000F7F7F700FFFFFF0000000000000000000000000000000000F7F7
      F700CECECE0000000000FFFFFF00CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F7F700F7F7
      F70000000000F7F7F700FFFFFF00F7F7F700FFFFFF00F7F7F700FFFFFF00F7F7
      F700CECECE0000000000FFFFFF00CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECE
      CE00FFFFFF00CECECE00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECE
      CE00FFFFFF00CECECE00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700CECE
      CE00FFFFFF00CECECE00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECE
      CE00FFFFFF00CECECE00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE00FFFF
      FF00CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE00FFFF
      FF00CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE00FFFF
      FF00CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE00FFFF
      FF00CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000180000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E001FFFFE001D5F3E001FFFFE001FFFF
      C000FFFFC000D59DC000FFFFC000FFFF80007FFF800077FE80007FFF80007FFF
      0000376B000002BA00003FDD000037B50000377F0000357700002EDF00003BCF
      0000376B00003FFF00002ECD00003BAD0000266B0000067F000035D5000020F5
      0000376B00003B7F0000358500003B8580007BBF80006A7F80007FFE80007FFE
      C000FFFFC000DF7FC000FFFAC000FFFAE001FFFFE001F67FE001FFFDE001FFFD
      F807FFFFF807EFFFF807FFFFF807FFFF00000000000000000000000000000000
      000000000000}
  end
  object StateIconImageList: TImageList
    Width = 11
    Left = 4
    Top = 308
    Bitmap = {
      494C010104000900B8000B001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000002C0000002000000001002000000000000016
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840084848400C6DEC600848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6DEC600C6DEC600C6DE
      C60084848400000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000008484
      8400C6DEC600C6DEC600C6DEC600C6DEC600C6DEC60084848400000000000000
      0000000000000000000000000000FFFFFF00008400000084000000840000FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF0084848400FFFFFF0000000000000000000000
      000000000000000000000000000084848400C6DEC600C6DEC600C6DEC600C6DE
      C600C6DEC60084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000084000000FF000000840000FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00840000008400000084000000840000008400000084000000840000008400
      000084000000FFFFFF00000000000000000000000000FFFFFF00848484008484
      840084848400FFFFFF0000000000000000000000000000000000000000008484
      8400C6DEC600C6DEC600C6DEC600C6DEC600C6DEC60084848400000000000000
      000000000000FFFFFF0000840000008400000084000000FF0000008400000084
      000000840000FFFFFF000000000000000000FFFFFF0084000000840000008400
      000084000000840000008400000084000000FFFFFF0000000000000000000000
      0000FFFFFF008484840084848400848484008484840084848400FFFFFF000000
      00000000000000000000000000000000000084848400C6DEC600C6DEC600C6DE
      C6008484840000000000000000000000000000000000FFFFFF000084000000FF
      000000FF000000FF000000FF000000FF000000840000FFFFFF00000000000000
      000000000000FFFFFF008400000084000000840000008400000084000000FFFF
      FF00000000000000000000000000FFFFFF008484840084848400848484008484
      8400848484008484840084848400FFFFFF000000000000000000000000000000
      00008484840084848400C6DEC600848484008484840000000000000000000000
      000000000000FFFFFF0000840000008400000084000000FF0000008400000084
      000000840000FFFFFF0000000000000000000000000000000000FFFFFF008400
      00008400000084000000FFFFFF00000000000000000000000000FFFFFF008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF000000000000000000000000000000000000000000848484000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF000084000000FF000000840000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF0084000000FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00008400000084000000840000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      280000002C000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFF00000FFFFFFFFFDF00000
      FFFFFFFFF0700000FFFFFFFFF0700000E0FFFFEFE0300000E0E003C7E0300000
      80200383E030000080300701F070000080380E00F0700000803C1C007DF00000
      803E3C007FF00000E0FF7FFFFFF00000E0FFFFFFFFF00000FFFFFFFFFFF00000
      FFFFFFFFFFF00000FFFFFFFFFFF0000000000000000000000000000000000000
      000000000000}
  end
  object AddressImageList: TImageList
    Left = 4
    Top = 340
    Bitmap = {
      494C010102000400B80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000C6C6C6000000
      000000000000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000848400FF000000000000008400
      0000FF000000FF000000FF000000FF00000084000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000008484000084840084000000FF00
      0000FF000000C6C6C600C6C6C60084000000FF00000084000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      84000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000848400C6C6C60084000000FF00
      000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      8400FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000084840000FFFF00FF00
      0000FF000000FF000000FF000000FF000000FF00000084000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000840000000084840000FF
      FF00FF000000FFFFFF00FFFFFF0084000000FF00000084000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000000084
      840000FFFF00FF000000FF000000FF00000084000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000000000000000FF008484
      8400FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF000000FF000000FF00000084000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000008484
      84000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E001E00100000000E001E00100000000
      C001E001000000008001C001000000000001E001000000000001E00100000000
      0001E001000000008001E001000000008001E00100000000C001C00100000000
      E001E00100000000E001E00100000000E003E00300000000E007E00700000000
      E00FE00F00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object MainMenu: TMainMenu
    Images = HotToobarImageList
    Left = 72
    Top = 212
    object FileMenu: TMenuItem
      Caption = #12501#12449#12452#12523'(&F)'
      object L4: TMenuItem
        Action = GikoDM.LoginAction
        AutoCheck = True
      end
      object B4: TMenuItem
        Action = GikoDM.NewBoardAction
      end
      object N80: TMenuItem
        Action = GikoDM.NewBoardSearchAction
      end
      object N84: TMenuItem
        Caption = '-'
      end
      object DeleteMenu: TMenuItem
        Action = GikoDM.LogDeleteAction
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object S4: TMenuItem
        Action = GikoDM.SelectTextClearAction
      end
      object N29: TMenuItem
        Action = GikoDM.NameTextClearAction
      end
      object N30: TMenuItem
        Action = GikoDM.MailTextClearAction
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object TabSave: TMenuItem
        Action = GikoDM.TabsSaveAction
      end
      object TabOpen: TMenuItem
        Action = GikoDM.TabsOpenAction
      end
      object N66: TMenuItem
        Caption = #36984#25246#12473#12524#12483#12489#12434#20445#23384
        object SelectThreadSave: TMenuItem
          Action = GikoDM.SelectItemSaveForHTML
        end
        object dat1: TMenuItem
          Action = GikoDM.SelectItemSaveForDat
        end
      end
      object ExportFavoriteFileAction1: TMenuItem
        Action = GikoDM.ExportFavoriteFile
      end
      object N61: TMenuItem
        Caption = '-'
      end
      object N77: TMenuItem
        Action = GikoDM.StoredTaskTrayAction
      end
      object N78: TMenuItem
        Caption = '-'
      end
      object ExitMenu: TMenuItem
        Action = GikoDM.ExitAction
      end
    end
    object ViewMenu: TMenuItem
      Caption = #34920#31034'(&V)'
      object T2: TMenuItem
        Caption = #12484#12540#12523#12496#12540'(&T)'
        object StdToolBarMenu: TMenuItem
          Action = GikoDM.StdToolBarVisibleAction
          AutoCheck = True
        end
        object AddressToolBarMenu: TMenuItem
          Action = GikoDM.AddressBarVisibleAction
          AutoCheck = True
        end
        object L7: TMenuItem
          Action = GikoDM.LinkBarVisibleAction
          AutoCheck = True
        end
        object N25: TMenuItem
          Caption = '-'
        end
        object L3: TMenuItem
          Action = GikoDM.ListToolBarVisibleAction
          AutoCheck = True
        end
        object S3: TMenuItem
          Action = GikoDM.ListNameBarVisibleAction
          AutoCheck = True
        end
        object N26: TMenuItem
          Caption = '-'
        end
        object B3: TMenuItem
          Action = GikoDM.BrowserToolBarVisibleAction
          AutoCheck = True
        end
        object R2: TMenuItem
          Action = GikoDM.BrowserNameBarVisibleAction
          AutoCheck = True
        end
        object T4: TMenuItem
          Caption = #12502#12521#12454#12470#12479#12502'(&T)'
          object Show1: TMenuItem
            Action = GikoDM.BrowserTabVisibleAction
            AutoCheck = True
          end
          object N34: TMenuItem
            Caption = '-'
          end
          object T5: TMenuItem
            Action = GikoDM.BrowserTabTopAction
            AutoCheck = True
            GroupIndex = 1
            RadioItem = True
          end
          object B5: TMenuItem
            Action = GikoDM.BrowserTabBottomAction
            AutoCheck = True
            GroupIndex = 1
            RadioItem = True
          end
          object N35: TMenuItem
            Caption = '-'
            GroupIndex = 2
          end
          object A8: TMenuItem
            Action = GikoDM.BrowserTabTabStyleAction
            AutoCheck = True
            GroupIndex = 2
            RadioItem = True
          end
          object U2: TMenuItem
            Action = GikoDM.BrowserTabButtonStyleAction
            AutoCheck = True
            GroupIndex = 2
            RadioItem = True
          end
          object F1: TMenuItem
            Action = GikoDM.BrowserTabFlatStyleAction
            AutoCheck = True
            GroupIndex = 2
            RadioItem = True
          end
        end
      end
      object CabinetMenu: TMenuItem
        Caption = #12461#12515#12499#12493#12483#12488'(&C)'
        object H1: TMenuItem
          Action = GikoDM.CabinetHistoryAction
          AutoCheck = True
          RadioItem = True
        end
        object N54: TMenuItem
          Action = GikoDM.CabinetFavoriteAction
          AutoCheck = True
        end
        object N4: TMenuItem
          Caption = '-'
        end
        object CabinetVisibleMenu: TMenuItem
          Action = GikoDM.CabinetVisibleAction
          AutoCheck = True
        end
      end
      object MessageMenu: TMenuItem
        Action = GikoDM.MsgBarVisibleAction
        AutoCheck = True
      end
      object StatusBarMenu: TMenuItem
        Action = GikoDM.StatusBarVisibleAction
        AutoCheck = True
      end
      object MMSep03: TMenuItem
        Caption = '-'
      end
      object LargeIconMenu: TMenuItem
        Action = GikoDM.LargeIconAction
        GroupIndex = 2
        RadioItem = True
      end
      object SmallIconMenu: TMenuItem
        Tag = 1
        Action = GikoDM.SmallIconAction
        GroupIndex = 2
        RadioItem = True
      end
      object ListMenu: TMenuItem
        Tag = 2
        Action = GikoDM.ListIconAction
        GroupIndex = 2
        RadioItem = True
      end
      object DetailMenu: TMenuItem
        Tag = 3
        Action = GikoDM.DetailIconAction
        GroupIndex = 2
        RadioItem = True
      end
      object N9: TMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object H3: TMenuItem
        Action = GikoDM.ArrangeAction
        AutoCheck = True
        GroupIndex = 2
      end
      object I1: TMenuItem
        Action = GikoDM.PaneInitAction
        GroupIndex = 2
      end
      object N27: TMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object N10: TMenuItem
        Action = GikoDM.StopAction
        GroupIndex = 2
      end
    end
    object B1: TMenuItem
      Caption = #26495'(&B)'
      object N3: TMenuItem
        Action = GikoDM.ListNumberVisibleAction
        AutoCheck = True
      end
      object U1: TMenuItem
        Action = GikoDM.UpFolderAction
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object A1: TMenuItem
        Action = GikoDM.AllItemAction
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
      object L1: TMenuItem
        Action = GikoDM.LogItemAction
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
      object N5: TMenuItem
        Action = GikoDM.NewItemAction
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
      object N76: TMenuItem
        Action = GikoDM.LiveItemAction
        AutoCheck = True
        GroupIndex = 1
      end
      object DAT3: TMenuItem
        Action = GikoDM.ArchiveItemAction
        AutoCheck = True
        GroupIndex = 1
      end
      object S2: TMenuItem
        Action = GikoDM.SelectItemAction
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
      object N39: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object T6: TMenuItem
        Action = GikoDM.ThreadEditorAction
        GroupIndex = 1
      end
      object N19: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object KidokuMenu: TMenuItem
        Action = GikoDM.KidokuAction
        GroupIndex = 1
      end
      object MidokuMenu: TMenuItem
        Action = GikoDM.MidokuAction
        GroupIndex = 1
      end
      object N23: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object OpenLogFolder: TMenuItem
        Action = GikoDM.LogFolderOpenAction
        GroupIndex = 1
      end
      object B6: TMenuItem
        Action = GikoDM.BoardIEAction
        GroupIndex = 1
      end
      object BrowsBoradHeadAction1: TMenuItem
        Action = GikoDM.BrowsBoradHeadAction
        GroupIndex = 1
      end
      object URLC3: TMenuItem
        Action = GikoDM.SelectItemURLCopyAction
        GroupIndex = 1
      end
      object SelectItemNameCopyAction1: TMenuItem
        Action = GikoDM.SelectItemNameCopyAction
        GroupIndex = 1
      end
      object URLN2: TMenuItem
        Action = GikoDM.SelectItemNameURLCopyAction
        GroupIndex = 1
      end
      object AllSelectMenu: TMenuItem
        Action = GikoDM.AllSelectAction
        GroupIndex = 1
      end
      object N21: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object D1: TMenuItem
        Action = GikoDM.SelectListReloadAction
        GroupIndex = 1
      end
      object D2: TMenuItem
        Action = GikoDM.SelectThreadReloadAction
        GroupIndex = 1
      end
    end
    object S1: TMenuItem
      Caption = #12473#12524'(&R)'
      object G2: TMenuItem
        Action = GikoDM.BrowserMaxAction
      end
      object About1: TMenuItem
        Action = GikoDM.BrowserMinAction
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object T3: TMenuItem
        Action = GikoDM.ScrollTopAction
      end
      object L2: TMenuItem
        Action = GikoDM.ScrollLastAction
      end
      object N12: TMenuItem
        Action = GikoDM.ScrollNewAction
      end
      object K1: TMenuItem
        Action = GikoDM.ScrollKokoAction
      end
      object N74: TMenuItem
        Action = GikoDM.JumpToNumOfResAction
        GroupIndex = 1
      end
      object N13: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object A11: TMenuItem
        Action = GikoDM.AllResAction
        AutoCheck = True
        GroupIndex = 1
      end
      object S5: TMenuItem
        Action = GikoDM.SelectResAction
        AutoCheck = True
        GroupIndex = 1
      end
      object N50: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object R1: TMenuItem
        Action = GikoDM.EditorAction
        GroupIndex = 1
      end
      object N14: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object N6: TMenuItem
        Caption = #12479#12502'(&T)'
        GroupIndex = 1
        object C1: TMenuItem
          Action = GikoDM.BrowserTabCloseAction
          GroupIndex = 1
        end
        object V1: TMenuItem
          Action = GikoDM.NotSelectTabCloseAction
          GroupIndex = 1
        end
        object N24: TMenuItem
          Caption = '-'
          GroupIndex = 1
        end
        object D4: TMenuItem
          Action = GikoDM.ActiveLogDeleteAction
          GroupIndex = 1
        end
        object N62: TMenuItem
          Caption = '-'
          GroupIndex = 1
        end
        object A6: TMenuItem
          Action = GikoDM.AllTabCloseAction
          GroupIndex = 1
        end
        object N17: TMenuItem
          Caption = '-'
          GroupIndex = 1
        end
        object L5: TMenuItem
          Action = GikoDM.LeftmostTabSelectAction
          GroupIndex = 1
        end
        object L6: TMenuItem
          Action = GikoDM.LeftTabSelectAction
          GroupIndex = 1
        end
        object A7: TMenuItem
          Action = GikoDM.RightTabSelectAction
          GroupIndex = 1
        end
        object R3: TMenuItem
          Action = GikoDM.RightmostTabSelectAction
          GroupIndex = 1
        end
      end
      object N31: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object T1: TMenuItem
        Action = GikoDM.ShowThreadAction
        GroupIndex = 1
      end
      object B2: TMenuItem
        Action = GikoDM.ShowBoardAction
        GroupIndex = 1
      end
      object URLC2: TMenuItem
        Action = GikoDM.URLCopyAction
        GroupIndex = 1
      end
      object T9: TMenuItem
        Action = GikoDM.NameCopyAction
        GroupIndex = 1
      end
      object URLN1: TMenuItem
        Action = GikoDM.NameURLCopyAction
        GroupIndex = 1
      end
      object N49: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object A2: TMenuItem
        Action = GikoDM.ItemReloadAction
        GroupIndex = 1
      end
      object N8: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object AntiIndivAbonMenuItem: TMenuItem
        Action = GikoDM.AntiIndividualAbonDlgAction
        GroupIndex = 1
      end
      object N87: TMenuItem
        Action = GikoDM.ThreadRangeAbonAction
        GroupIndex = 1
      end
    end
    object FavoriteMenu: TMenuItem
      AutoHotkeys = maManual
      Caption = #12362#27671#12395#20837#12426'(&A)'
      OnClick = FavoriteMenuClick
    end
    object ToolMenu: TMenuItem
      Caption = #12484#12540#12523'(&T)'
      object Find1: TMenuItem
        Action = GikoDM.SearchAction
      end
      object RoundMenu: TMenuItem
        Action = GikoDM.RoundAction
      end
      object Search1: TMenuItem
        Action = GikoDM.ThreadSearchAction
      end
      object MMSep04: TMenuItem
        Caption = '-'
      end
      object K3: TMenuItem
        Action = GikoDM.KotehanAction
      end
      object K2: TMenuItem
        Action = GikoDM.KeySettingAction
      end
      object T7: TMenuItem
        Action = GikoDM.ToolBarSettingAction
      end
      object N86: TMenuItem
        Action = GikoDM.PopupMenuSettingAction
      end
      object N40: TMenuItem
        Caption = '-'
      end
      object NG1: TMenuItem
        Action = GikoDM.EditNGAction
      end
      object NG2: TMenuItem
        Caption = 'NG'#12527#12540#12489#35501#12415#36796#12415
        object GoBack: TMenuItem
          Action = GikoDM.GoBackAction
        end
        object Reload: TMenuItem
          Action = GikoDM.ReloadAction
        end
        object GoFoward: TMenuItem
          Action = GikoDM.GoFowardAction
        end
      end
      object ThrNGEdit: TMenuItem
        Action = GikoDM.ThreadNgEditAction
      end
      object N43: TMenuItem
        Caption = '-'
      end
      object N22: TMenuItem
        Action = GikoDM.SetInputAssistAction
      end
      object N42: TMenuItem
        Caption = '-'
      end
      object DongriMenu: TMenuItem
        Caption = #12393#12435#12368#12426#12471#12473#12486#12512'(&D)'
        ImageIndex = 56
        object DonguriShowMenu: TMenuItem
          Action = GikoDM.DonguriAction
        end
        object DonguriLoginMenu: TMenuItem
          Action = GikoDM.DonguriLoginAction
        end
        object DonguriHntLoginMenu: TMenuItem
          Action = GikoDM.DonguriHntLoginAction
        end
        object DonguriGrdLoginMenu: TMenuItem
          Action = GikoDM.DonguriGrdLoginAction
        end
        object DonguriAuthMenu: TMenuItem
          Action = GikoDM.DonguriAuthAction
        end
        object DonguriLogoutMenu: TMenuItem
          Action = GikoDM.DonguriLogoutAction
        end
      end
      object CookieMngMenu: TMenuItem
        Action = GikoDM.CookieMngAction
      end
      object N88: TMenuItem
        Caption = '-'
      end
      object PlugInMenu: TMenuItem
        Caption = #12503#12521#12464#12452#12531'(&P)'
      end
      object OptionMenu: TMenuItem
        Action = GikoDM.OptionAction
      end
    end
    object HelpMenu: TMenuItem
      Caption = #12504#12523#12503'(&H)'
      object H4: TMenuItem
        Action = GikoDM.GikoHelpAction
      end
      object WikiFAQ: TMenuItem
        Action = GikoDM.WikiFAQWebPageAction
      end
      object WikiFAQ1: TMenuItem
        Action = GikoDM.GoWikiFAQWebPageAction
      end
      object N36: TMenuItem
        Caption = '-'
      end
      object G1: TMenuItem
        Action = GikoDM.GikoNaviWebPageAction
      end
      object K4: TMenuItem
        Action = GikoDM.GikoNaviGoesonWebPageAction
      end
      object MonazillaWebPageAction1: TMenuItem
        Action = GikoDM.MonazillaWebPageAction
      end
      object N2N1: TMenuItem
        Action = GikoDM.BBS2chWebPageAction
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object F2: TMenuItem
        Action = GikoDM.GikoFolderOpenAction
      end
      object N38: TMenuItem
        Caption = '-'
      end
      object UpdateGikonaviAction1: TMenuItem
        Action = GikoDM.UpdateGikonaviAction
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object AboutMenu: TMenuItem
        Action = GikoDM.AboutAction
      end
    end
  end
  object PreviewTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = PreviewTimerTimer
    Left = 100
    Top = 340
  end
  object SelectTimer: TTimer
    Interval = 220
    OnTimer = SelectTimerTimer
    Left = 100
    Top = 308
  end
  object BrowserPopupMenu: TPopupMenu
    Left = 68
    Top = 280
    object ShowThreadMenu: TMenuItem
      Action = GikoDM.ShowThreadAction
    end
    object ShowBoardMenu: TMenuItem
      Action = GikoDM.ShowBoardAction
    end
    object URLC1: TMenuItem
      Action = GikoDM.URLCopyAction
    end
    object T8: TMenuItem
      Action = GikoDM.NameCopyAction
    end
    object URL1: TMenuItem
      Action = GikoDM.NameURLCopyAction
    end
  end
  object ListIconPopupMenu: TPopupMenu
    Left = 68
    Top = 308
    object LargeIconPMenu: TMenuItem
      Action = GikoDM.LargeIconAction
      GroupIndex = 2
      RadioItem = True
    end
    object SmallIconPMenu: TMenuItem
      Tag = 1
      Action = GikoDM.SmallIconAction
      GroupIndex = 2
      RadioItem = True
    end
    object ListPMenu: TMenuItem
      Tag = 2
      Action = GikoDM.ListIconAction
      GroupIndex = 2
      RadioItem = True
    end
    object DetailPMenu: TMenuItem
      Tag = 3
      Action = GikoDM.DetailIconAction
      GroupIndex = 2
      RadioItem = True
    end
  end
  object ClosePopupMenu: TPopupMenu
    Left = 68
    Top = 340
    object CloseMenu: TMenuItem
      Caption = #38281#12376#12427'(&C)'
    end
  end
  object ListPopupMenu: TPopupMenu
    OnPopup = ListPopupMenuPopup
    Left = 68
    Top = 244
    object ItemRoundPMenu: TMenuItem
      Action = GikoDM.SelectThreadReloadAction
    end
    object ItemReservPMenu: TMenuItem
      Action = GikoDM.SelectReservAction
    end
    object LPMSep01: TMenuItem
      Caption = '-'
    end
    object ListRoundPMenu: TMenuItem
      Action = GikoDM.SelectListReloadAction
    end
    object ListReservPMenu: TMenuItem
      Caption = #12473#12524#12483#12489#19968#35239#24033#22238#20104#32004'(&R)'
      Hint = #12473#12524#12483#12489#19968#35239#24033#22238#20104#32004
    end
    object LPMSep02: TMenuItem
      Caption = '-'
    end
    object BoardFavoriteAddMenu: TMenuItem
      Action = GikoDM.BoardFavoriteAddAction
    end
    object ThreadFavoriteAddMenu: TMenuItem
      Action = GikoDM.ThreadFavoriteAddAction
    end
    object N32: TMenuItem
      Caption = '-'
    end
    object KidokuPMenu: TMenuItem
      Action = GikoDM.KidokuAction
    end
    object MidokuPMenu: TMenuItem
      Action = GikoDM.MidokuAction
    end
    object N55: TMenuItem
      Caption = '-'
    end
    object UrlCopyPMenu: TMenuItem
      Action = GikoDM.SelectItemURLCopyAction
    end
    object NameCopyPMenu: TMenuItem
      Action = GikoDM.SelectItemNameCopyAction
    end
    object NameUrlCopyPMenu: TMenuItem
      Action = GikoDM.SelectItemNameURLCopyAction
    end
    object AllSelectPMenu: TMenuItem
      Action = GikoDM.AllSelectAction
    end
    object LPMSep05: TMenuItem
      Caption = '-'
    end
    object DeletePMenu: TMenuItem
      Action = GikoDM.LogDeleteAction
    end
    object LPMSep06: TMenuItem
      Caption = '-'
    end
    object SaveThreadFile: TMenuItem
      Caption = #36984#25246#12473#12524#12483#12489#12434#20445#23384#12377#12427
      object HTML1: TMenuItem
        Action = GikoDM.SelectItemSaveForHTML
      end
      object DAT4: TMenuItem
        Action = GikoDM.SelectItemSaveForDat
      end
    end
    object N79: TMenuItem
      Caption = '-'
    end
    object ViewPMenu: TMenuItem
      Caption = #34920#31034'(&V)'
      object LargeIconLPMenu: TMenuItem
        Action = GikoDM.LargeIconAction
        GroupIndex = 2
        RadioItem = True
      end
      object SmallIconLPMenu: TMenuItem
        Tag = 1
        Action = GikoDM.SmallIconAction
        GroupIndex = 2
        RadioItem = True
      end
      object ListLPMenu: TMenuItem
        Tag = 2
        Action = GikoDM.ListIconAction
        GroupIndex = 2
        RadioItem = True
      end
      object DetailLPMenu: TMenuItem
        Tag = 3
        Action = GikoDM.DetailIconAction
        GroupIndex = 2
        RadioItem = True
      end
    end
  end
  object KokoPopupMenu: TPopupMenu
    OnPopup = KokoPopupMenuPopup
    Left = 68
    Top = 372
    object DonguriCannonTopMenu: TMenuItem
      Action = GikoDM.DonguriCannonAction
    end
    object DonguriSeparatorTopMenu: TMenuItem
      Caption = '-'
    end
    object KokomadePMenu: TMenuItem
      Action = GikoDM.KokomadeAction
    end
    object AllPMenu: TMenuItem
      Action = GikoDM.ZenbuAction
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object MenuItem2: TMenuItem
      Action = GikoDM.KokoResAction
    end
    object N64: TMenuItem
      Caption = '-'
    end
    object N63: TMenuItem
      Action = GikoDM.KoreCopy
    end
    object dat5: TMenuItem
      Action = GikoDM.KoreDatCopy
    end
    object N41: TMenuItem
      Caption = '-'
    end
    object N53: TMenuItem
      Caption = #12371#12398#12524#12473
      object IndividualAbon1: TMenuItem
        Tag = 1
        Action = GikoDM.IndividualAbon1Action
      end
      object IndividualAbon2: TMenuItem
        Action = GikoDM.IndividualAbon0Action
      end
      object RangeBon: TMenuItem
        Action = GikoDM.RangeAbonAction
      end
      object DonguriCannonMenu: TMenuItem
        Action = GikoDM.DonguriCannonAction
      end
    end
    object ID3: TMenuItem
      Caption = #12371#12398#12524#12473#12398'ID'
      object ID2: TMenuItem
        Action = GikoDM.IndividualAbonID1Action
      end
      object N71: TMenuItem
        Action = GikoDM.IndividualAbonID0Action
      end
      object N82: TMenuItem
        Caption = '-'
      end
      object IDNG1: TMenuItem
        Action = GikoDM.AddIDtoNGWord1Action
      end
      object IDNG2: TMenuItem
        Action = GikoDM.AddIDtoNGWord0Action
      end
    end
    object N91: TMenuItem
      Caption = #12371#12398#12524#12473#12398#12527#12483#12481#12519#12452
      object N92: TMenuItem
        Caption = #12527#12483#12481#12519#12452#20840#20307
        object N93: TMenuItem
          Action = GikoDM.IndividualAbon1WcAllAction
        end
        object N94: TMenuItem
          Action = GikoDM.IndividualAbon0WcAllAction
        end
        object N97: TMenuItem
          Caption = '-'
        end
        object NG3: TMenuItem
          Action = GikoDM.AddWcAlltoNGWord1Action
        end
        object NG4: TMenuItem
          Action = GikoDM.AddWcAlltoNGWord0Action
        end
      end
      object N411: TMenuItem
        Caption = #12527#12483#12481#12519#12452#19979'4'#26689
        object N95: TMenuItem
          Action = GikoDM.IndividualAbon1WcLs4Action
        end
        object N96: TMenuItem
          Action = GikoDM.IndividualAbon0WcLs4Action
        end
        object N98: TMenuItem
          Caption = '-'
        end
        object N4NG1: TMenuItem
          Action = GikoDM.AddWcLs4toNGWord1Action
        end
        object N4NG2: TMenuItem
          Action = GikoDM.AddWcLs4toNGWord0Action
        end
      end
    end
    object N52: TMenuItem
      Caption = #20491#21029#12354#12412#65374#12435#35299#38500
      object AntiIndividualAbon: TMenuItem
        Action = GikoDM.AntiIndividualAbonAction
      end
      object N51: TMenuItem
        Action = GikoDM.AntiIndividualAbonDlgAction
      end
    end
    object N70: TMenuItem
      Caption = '-'
    end
    object ID1: TMenuItem
      Action = GikoDM.SameIDResAnchorAction
    end
    object N83: TMenuItem
      Action = GikoDM.DereferenceResAction
    end
    object N89: TMenuItem
      Caption = #21516#12527#12483#12481#12519#12452#12408#12398#12524#12473#12450#12531#12459#12540#34920#31034
      object N90: TMenuItem
        Action = GikoDM.SameWcAllResAnchorAction
      end
      object N410: TMenuItem
        Action = GikoDM.SameWcLast4ResAnchorAction
      end
    end
    object N85: TMenuItem
      Caption = '-'
    end
    object URL2: TMenuItem
      Caption = #12371#12398#12524#12473#12398'URL'
      object URLPATHINFO1: TMenuItem
        Action = GikoDM.konoURLPATHAction
      end
      object PATHINFOitest1: TMenuItem
        Action = GikoDM.konoURLitestAction
      end
      object URLQUERYSTRING1: TMenuItem
        Action = GikoDM.konoURLQueryAction
      end
    end
  end
  object BrowserTabPopupMenu: TPopupMenu
    Images = HotToobarImageList
    OnPopup = BrowserTabPopupMenuPopup
    Left = 68
    Top = 404
    object A4: TMenuItem
      Action = GikoDM.ItemReloadAction
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object A9: TMenuItem
      Action = GikoDM.FavoriteAddAction
    end
    object dummy1: TMenuItem
      Caption = 'dummy1'
    end
    object N37: TMenuItem
      Caption = '-'
    end
    object SameBoardThreadItem: TMenuItem
      Caption = #21516#26495#12391#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489
      Hint = #21516#26495#12391#34920#31034#12375#12390#12427#12473#12524#12483#12489
    end
    object N81: TMenuItem
      Caption = '-'
    end
    object Close1: TMenuItem
      Action = GikoDM.BrowserTabCloseAction
    end
    object A3: TMenuItem
      Action = GikoDM.NotSelectTabCloseAction
    end
    object N72: TMenuItem
      Action = GikoDM.LeftTabCloseAction
    end
    object N73: TMenuItem
      Action = GikoDM.RightTabCloseAction
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object D3: TMenuItem
      Action = GikoDM.ActiveLogDeleteAction
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object A5: TMenuItem
      Action = GikoDM.AllTabCloseAction
    end
  end
  object TreePopupMenu: TPopupMenu
    OnPopup = TreePopupMenuPopup
    Left = 68
    Top = 436
    object TreeSelectThreadPupupMenu: TMenuItem
      Action = GikoDM.TreeSelectThreadReload
    end
    object TreeSelectBoardPupupMenu: TMenuItem
      Action = GikoDM.TreeSelectBoradReload
    end
    object TPMSep01: TMenuItem
      Caption = '-'
    end
    object TreeSelectFavoriteAddPupupMenu: TMenuItem
      Action = GikoDM.TreeSelectFavoriteAddAction
    end
    object N33: TMenuItem
      Caption = '-'
    end
    object TreeSelectURLPupupMenu: TMenuItem
      Action = GikoDM.TreeSelectURLCopy
    end
    object TreeSelectNamePupupMenu: TMenuItem
      Action = GikoDM.TreeSelectNameCopy
    end
    object TreeSelectNameURLPupupMenu: TMenuItem
      Action = GikoDM.TreeSelectNameURLCopy
    end
    object TreeSelectLogDeleteSeparator: TMenuItem
      Caption = '-'
    end
    object TreeSelectLogDeletePopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewLogDeleteAction
    end
    object N65: TMenuItem
      Caption = '-'
    end
    object SearchBoardName: TMenuItem
      Action = GikoDM.TreeSelectSearchBoardName
    end
  end
  object CabinetSelectPopupMenu: TPopupMenu
    Left = 68
    Top = 468
    object H2: TMenuItem
      Action = GikoDM.CabinetHistoryAction
      AutoCheck = True
    end
    object A13: TMenuItem
      Action = GikoDM.CabinetFavoriteAction
      AutoCheck = True
    end
  end
  object RoundNamePopupMenu: TPopupMenu
    OnPopup = RoundNamePopupMenuPopup
    Left = 100
    Top = 212
  end
  object ChevronPopupMenu: TPopupMenu
    Left = 100
    Top = 244
    object a10: TMenuItem
      Caption = 'a'
    end
  end
  object LinkBarPopupMenu: TPopupMenu
    Images = HotToobarImageList
    Left = 100
    Top = 276
  end
  object ThreadPopupMenu: TPopupMenu
    Left = 100
    Top = 372
    object MenuItem4: TMenuItem
      Caption = #26495#12434#12502#12521#12454#12470#12391#34920#31034'(&B)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#26495#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
    end
    object MenuItem5: TMenuItem
      Action = GikoDM.SelectItemURLCopyAction
    end
    object MenuItem6: TMenuItem
      Action = GikoDM.SelectItemNameURLCopyAction
    end
    object URLN3: TMenuItem
      Action = GikoDM.SelectItemNameCopyAction
    end
  end
  object MainCoolBarPopupMenu: TPopupMenu
    Left = 100
    Top = 404
    object StdToolBarVisiblePMenu: TMenuItem
      Action = GikoDM.StdToolBarVisibleAction
      AutoCheck = True
    end
    object AddressToolBarVisiblePMenu: TMenuItem
      Action = GikoDM.AddressBarVisibleAction
      AutoCheck = True
    end
    object LinkToolBarVisiblePMenu: TMenuItem
      Action = GikoDM.LinkBarVisibleAction
      AutoCheck = True
    end
    object N44: TMenuItem
      Caption = '-'
    end
    object L9: TMenuItem
      Action = GikoDM.ListToolBarVisibleAction
      AutoCheck = True
    end
    object I3: TMenuItem
      Action = GikoDM.ListNameBarVisibleAction
      AutoCheck = True
    end
    object N45: TMenuItem
      Caption = '-'
    end
    object B9: TMenuItem
      Action = GikoDM.BrowserToolBarVisibleAction
      AutoCheck = True
    end
    object R5: TMenuItem
      Action = GikoDM.BrowserNameBarVisibleAction
      AutoCheck = True
    end
    object T12: TMenuItem
      Caption = #12502#12521#12454#12470#12479#12502'(&T)'
      object Show3: TMenuItem
        Action = GikoDM.BrowserTabVisibleAction
        AutoCheck = True
      end
      object N46: TMenuItem
        Caption = '-'
      end
      object T13: TMenuItem
        Action = GikoDM.BrowserTabTopAction
        AutoCheck = True
      end
      object B10: TMenuItem
        Action = GikoDM.BrowserTabBottomAction
        AutoCheck = True
      end
      object N47: TMenuItem
        Caption = '-'
      end
      object A12: TMenuItem
        Action = GikoDM.BrowserTabTabStyleAction
        AutoCheck = True
      end
      object U4: TMenuItem
        Action = GikoDM.BrowserTabButtonStyleAction
        AutoCheck = True
      end
      object F4: TMenuItem
        Action = GikoDM.BrowserTabFlatStyleAction
        AutoCheck = True
      end
    end
    object N48: TMenuItem
      Caption = '-'
    end
    object T14: TMenuItem
      Action = GikoDM.ToolBarSettingAction
    end
  end
  object FavoriteTreePopupMenu: TPopupMenu
    OnPopup = FavoriteTreePopupMenuPopup
    Left = 99
    Top = 436
    object FavoriteTreeBrowseFolderPopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewBrowseFolderAction
    end
    object N57: TMenuItem
      Caption = '-'
    end
    object FavoriteTreeDeletePopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewDeleteAction
    end
    object FavoriteTreeRenamePopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewURLCopyAction
    end
    object N56: TMenuItem
      Caption = '-'
    end
    object FavoriteTreeNewFolderPopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewNewFolderAction
    end
    object N58: TMenuItem
      Caption = '-'
    end
    object FavoriteTreeItemNameCopyPopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewItemNameCopyAction
    end
    object FavoriteTreeURLCopyPopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewURLCopyAction
    end
    object FavoriteTreeNameCopyPopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewNameCopyAction
    end
    object FavoriteTreeNameURLCopyPopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewNameURLCopyAction
    end
    object N60: TMenuItem
      Caption = '-'
    end
    object FavoriteTreeReloadPopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewReloadAction
    end
    object N59: TMenuItem
      Caption = '-'
    end
    object FavoriteTreeLogDeletePopupMenu: TMenuItem
      Action = GikoDM.FavoriteTreeViewLogDeleteAction
    end
  end
  object BBSSelectPopupMenu: TPopupMenu
    Left = 99
    Top = 468
  end
  object ResRangePopupMenu: TPopupMenu
    Left = 37
    Top = 472
    object ResRangeAllPMenuItem: TMenuItem
      Action = GikoDM.AllResAction
      AutoCheck = True
      GroupIndex = 2
    end
    object ResRangeHundPMenuItem: TMenuItem
      Action = GikoDM.OnlyAHundredResAction
      AutoCheck = True
      GroupIndex = 2
    end
    object ResRangeKokoPMenuItem: TMenuItem
      Action = GikoDM.OnlyKokoResAction
      AutoCheck = True
      GroupIndex = 2
    end
    object ResRangeNewPMenuItem: TMenuItem
      Action = GikoDM.OnlyNewResAction
      AutoCheck = True
      GroupIndex = 2
    end
    object N69: TMenuItem
      Caption = '-'
      GroupIndex = 2
    end
    object ResRangeSelectPMenuItem: TMenuItem
      Action = GikoDM.SelectResAction
      AutoCheck = True
      GroupIndex = 2
    end
  end
  object ThreadRangePopupMenu: TPopupMenu
    Left = 37
    Top = 436
    object A15: TMenuItem
      Action = GikoDM.AllItemAction
      AutoCheck = True
    end
    object L8: TMenuItem
      Action = GikoDM.LogItemAction
      AutoCheck = True
    end
    object N67: TMenuItem
      Action = GikoDM.NewItemAction
      AutoCheck = True
    end
    object N75: TMenuItem
      Action = GikoDM.LiveItemAction
      AutoCheck = True
    end
    object DAT2: TMenuItem
      Action = GikoDM.ArchiveItemAction
      AutoCheck = True
    end
    object N68: TMenuItem
      Caption = '-'
    end
    object S6: TMenuItem
      Action = GikoDM.SelectItemAction
      AutoCheck = True
    end
  end
  object ListColumnPopupMenu: TPopupMenu
    Left = 37
    Top = 403
  end
  object GikoApplicationEvents: TApplicationEvents
    OnDeactivate = GikoApplicationEventsDeactivate
    OnException = GikoApplicationEventsException
    OnMessage = GikoApplicationEventsMessage
    Left = 4
    Top = 373
  end
  object ResPopupClearTimer: TTimer
    Tag = 1
    Enabled = False
    OnTimer = ResPopupClearTimerTimer
    Left = 8
    Top = 440
  end
  object TaskTrayPopupMenu: TPopupMenu
    Left = 38
    Top = 373
    object Exit1: TMenuItem
      Action = GikoDM.ExitAction
    end
  end
end
