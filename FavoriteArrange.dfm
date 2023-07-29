object FavoriteArrangeDialog: TFavoriteArrangeDialog
  Left = 305
  Top = 172
  Width = 537
  Height = 335
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  Caption = #12362#27671#12395#20837#12426#12398#25972#29702
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
    Top = 0
    Width = 257
    Height = 267
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 12
      Width = 225
      Height = 81
      AutoSize = False
      Caption = 
        #26032#12375#12356#12501#12457#12523#12480#12434#20316#25104#12377#12427#12395#12399#12289' ['#12501#12457#12523#12480#12398#20316#25104'] '#12508#12479#12531#12434#12463#12522#12483#12463#12375#12390#12367#12384#12373#12356#12290#38917#30446#12398#21517#21069#12434#22793#26356#12414#12383#12399#21066#38500#12377#12427#12395#12399#12289#38917#30446#12434#36984#25246 +
        #12375#12390#12363#12425' ['#21517#21069#12398#22793#26356'] '#12508#12479#12531#12289#12414#12383#12399' ['#21066#38500'] '#12508#12479#12531#12434#12463#12522#12483#12463#12375#12390#12367#12384#12373#12356#12290
      WordWrap = True
    end
    object DeleteButton: TButton
      Left = 12
      Top = 124
      Width = 117
      Height = 21
      Caption = #21066#38500'(&D)'
      TabOrder = 0
      OnClick = DeleteButtonClick
    end
    object RenameButton: TButton
      Left = 136
      Top = 96
      Width = 117
      Height = 21
      Caption = #21517#21069#12398#22793#26356'(&R)'
      TabOrder = 1
      OnClick = RenameButtonClick
    end
    object NewFolderButton: TButton
      Left = 12
      Top = 96
      Width = 117
      Height = 21
      Caption = #12501#12457#12523#12480#12398#20316#25104'(&C)'
      TabOrder = 2
      OnClick = NewFolderButtonClick
    end
  end
  object Panel2: TPanel
    Left = 257
    Top = 0
    Width = 264
    Height = 267
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 10
    TabOrder = 1
    object FolderTreeView: TTreeView
      Left = 10
      Top = 10
      Width = 244
      Height = 247
      Align = alClient
      DragCursor = crDefault
      DragMode = dmAutomatic
      HideSelection = False
      Images = GikoForm.ItemIcon16
      Indent = 19
      PopupMenu = SortPopupMenu
      ReadOnly = True
      ShowRoot = False
      TabOrder = 0
      OnDragDrop = FolderTreeViewDragDrop
      OnDragOver = FolderTreeViewDragOver
      OnEdited = FolderTreeViewEdited
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 267
    Width = 521
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Panel4: TPanel
      Left = 414
      Top = 0
      Width = 107
      Height = 30
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object CloseButton: TButton
        Left = 4
        Top = 4
        Width = 93
        Height = 21
        Cancel = True
        Caption = #38281#12376#12427
        TabOrder = 0
        OnClick = CloseButtonClick
      end
    end
  end
  object SortPopupMenu: TPopupMenu
    Left = 16
    Top = 160
    object N1: TMenuItem
      Caption = #21517#21069#38918#25972#21015
      object SortAscName: TMenuItem
        Caption = #26119#38918
        OnClick = SortAscNameClick
      end
      object SortDscName: TMenuItem
        Caption = #38477#38918
        OnClick = SortDscNameClick
      end
    end
    object SortURL: TMenuItem
      Caption = 'URL'#38918#25972#21015
      object SortAscURL: TMenuItem
        Caption = #26119#38918
        OnClick = SortAscURLClick
      end
      object SortDscURL: TMenuItem
        Caption = #38477#38918
        OnClick = SortDscURLClick
      end
    end
    object SortTitle: TMenuItem
      Caption = #12479#12452#12488#12523#38918#12477#12540#12488
      object SortAscTitle: TMenuItem
        Caption = #26119#38918
        OnClick = SortAscTitleClick
      end
      object SortDscTitle: TMenuItem
        Caption = #38477#38918
        OnClick = SortDscTitleClick
      end
    end
  end
end
