object NewFavoriteFolderDialog: TNewFavoriteFolderDialog
  Left = 181
  Top = 554
  BorderStyle = bsDialog
  Caption = #26032#12375#12356#12501#12457#12523#12480#12398#20316#25104
  ClientHeight = 110
  ClientWidth = 399
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
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 193
    Height = 12
    Caption = #20316#25104#12377#12427#12501#12457#12523#12480#21517#12434#20837#21147#12375#12390#12367#12384#12373#12356
  end
  object Label2: TLabel
    Left = 12
    Top = 40
    Width = 72
    Height = 12
    Caption = #12501#12457#12523#12480#21517'(&F):'
    FocusControl = FolderEdit
  end
  object ErrLabel: TLabel
    Left = 12
    Top = 64
    Width = 18
    Height = 12
    Caption = '_err'
  end
  object FolderEdit: TEdit
    Left = 92
    Top = 36
    Width = 293
    Height = 20
    TabOrder = 0
    OnChange = FolderEditChange
  end
  object OKButton: TButton
    Left = 204
    Top = 80
    Width = 87
    Height = 21
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 300
    Top = 80
    Width = 87
    Height = 21
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
end
