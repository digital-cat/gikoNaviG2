object SplashWindow: TSplashWindow
  Left = 200
  Top = 234
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsNone
  ClientHeight = 170
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 12
  object SplashImage: TImage
    Left = 0
    Top = 0
    Width = 300
    Height = 130
    Align = alClient
  end
  object ProgressPanel: TPanel
    Left = 0
    Top = 130
    Width = 300
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      300
      40)
    object VersionLabel: TLabel
      Left = 51
      Top = 4
      Width = 198
      Height = 13
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Version No'
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgressBar: TProgressBar
      Left = 12
      Top = 20
      Width = 275
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      Min = 0
      Max = 100
      Smooth = True
      Step = 1
      TabOrder = 0
    end
  end
end
