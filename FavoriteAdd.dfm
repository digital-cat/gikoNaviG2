object FavoriteAddDialog: TFavoriteAddDialog
  Left = 503
  Top = 134
  BorderStyle = bsDialog
  Caption = #12362#27671#12395#20837#12426#12398#36861#21152
  ClientHeight = 307
  ClientWidth = 523
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
    Left = 12
    Top = 12
    Width = 20
    Height = 12
    Caption = 'text'
  end
  object NameLabel: TLabel
    Left = 12
    Top = 36
    Width = 20
    Height = 12
    Caption = 'text'
  end
  object Label3: TLabel
    Left = 12
    Top = 64
    Width = 54
    Height = 12
    Caption = #34920#31034#21517'(&N):'
    FocusControl = CaptionEdit
  end
  object Label4: TLabel
    Left = 12
    Top = 92
    Width = 54
    Height = 12
    Caption = #12501#12457#12523#12480'(&I)'
    FocusControl = FolderTreeView
  end
  object NameEdit: TEdit
    Left = 80
    Top = 32
    Width = 309
    Height = 20
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
  end
  object CaptionEdit: TEdit
    Left = 80
    Top = 60
    Width = 309
    Height = 20
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 404
    Top = 12
    Width = 105
    Height = 21
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 404
    Top = 40
    Width = 105
    Height = 21
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object NewFolderButton: TButton
    Left = 404
    Top = 92
    Width = 105
    Height = 21
    Caption = #26032#35215#12501#12457#12523#12480'(&W)...'
    TabOrder = 2
    OnClick = NewFolderButtonClick
  end
  object FolderTreeView: TTreeView
    Left = 80
    Top = 92
    Width = 309
    Height = 205
    HideSelection = False
    Images = GikoForm.ItemIcon16
    Indent = 19
    ReadOnly = True
    ShowRoot = False
    TabOrder = 1
  end
end
