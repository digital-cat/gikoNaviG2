object DonguriForm: TDonguriForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #12489#12531#12464#12522#12471#12473#12486#12512
  ClientHeight = 534
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object InfoGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 536
    Height = 409
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    ColCount = 2
    DefaultColWidth = 100
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 19
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 0
    ExplicitHeight = 384
  end
  object Panel1: TPanel
    Left = 0
    Top = 409
    Width = 536
    Height = 125
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 384
    object AuthButton: TButton
      Left = 22
      Top = 8
      Width = 160
      Height = 25
      Caption = #12393#12435#12368#12426#20877#35469#35388
      TabOrder = 0
      OnClick = AuthButtonClick
    end
    object LoginButton: TButton
      Left = 188
      Top = 8
      Width = 160
      Height = 25
      Caption = #12393#12435#12368#12426#12525#12464#12452#12531
      TabOrder = 1
      OnClick = LoginButtonClick
    end
    object LogoutButton: TButton
      Left = 354
      Top = 8
      Width = 160
      Height = 25
      Caption = #12393#12435#12368#12426#12525#12464#12450#12454#12488
      TabOrder = 2
      OnClick = LogoutButtonClick
    end
    object UplLoginButton: TButton
      Left = 80
      Top = 48
      Width = 177
      Height = 25
      Caption = 'UPLIFT'#12525#12464#12452#12531
      TabOrder = 3
      OnClick = UplLoginButtonClick
    end
    object UplLogoutButton: TButton
      Left = 263
      Top = 48
      Width = 178
      Height = 25
      Caption = 'UPLIFT'#12525#12464#12450#12454#12488
      TabOrder = 4
      OnClick = UplLogoutButtonClick
    end
    object ExplorButton: TButton
      Left = 12
      Top = 88
      Width = 100
      Height = 25
      Caption = #25506#26908
      TabOrder = 5
      OnClick = ExplorButtonClick
    end
    object MiningButton: TButton
      Left = 113
      Top = 88
      Width = 100
      Height = 25
      Caption = #25505#25496
      TabOrder = 6
      OnClick = MiningButtonClick
    end
    object WoodctButton: TButton
      Left = 214
      Top = 88
      Width = 100
      Height = 25
      Caption = #26408#12371#12426
      TabOrder = 7
      OnClick = WoodctButtonClick
    end
    object WeaponButton: TButton
      Left = 315
      Top = 88
      Width = 100
      Height = 25
      Caption = #27494#22120#35069#20316
      TabOrder = 8
      OnClick = WeaponButtonClick
    end
    object ArmorcButton: TButton
      Left = 416
      Top = 88
      Width = 100
      Height = 25
      Caption = #38450#20855#35069#20316
      TabOrder = 9
      OnClick = ArmorcButtonClick
    end
  end
  object TimerInit: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerInitTimer
    Left = 328
    Top = 24
  end
end
