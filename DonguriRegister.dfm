object DonguriRegForm: TDonguriRegForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #35686#20633#21729#12450#12459#12454#12531#12488#26032#35215#30331#37682
  ClientHeight = 329
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object WizardPageControl: TPageControl
    Left = 0
    Top = 0
    Width = 569
    Height = 329
    ActivePage = TabSheet3
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #12399#12376#12417#12395
      object MemoInfo: TMemo
        Left = 0
        Top = 0
        Width = 561
        Height = 247
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          #12371#12398#12469#12540#12499#12473#12391#12399#12289#12525#12464#12452#12531#12375#12383#35686#20633#21729#12450#12459#12454#12531#12488#12434#12513#12540#12523#12450#12489#12524#12473#12392#12497#12473#12527#12540#12489#12391#30331#37682#12375#12414#12377#12290#12418#12375
          'UPLIFT'#12414#12383#12399#12495#12531#12479#12540#12398#12450#12459#12454#12531#12488#12418#12362#25345#12385#12398#22580#21512#12399#12289#35686#20633#21729#12450#12459#12454#12531#12488#12434'UPLIFT'#12450#12459#12454#12531#12488#12392#21516#12376
          #12513#12540#12523#12450#12489#12524#12473#12395#30331#37682#12375#12394#12356#12391#12367#12384#12373#12356#12290#12381#12358#12375#12394#12356#12392#12289#35686#20633#21729#12450#12459#12454#12531#12488#12395#12450#12463#12475#12473#12391#12365#12394#12367#12394#12427#21487#33021
          #24615#12364#12354#12426#12414#12377#12290
          ''
          #27880#24847': '#30331#37682#12391#12365#12427#12398#12399' gmail.com '#12398#12450#12459#12454#12531#12488#12398#12415#12391#12377#12290#12371#12428#12399#12356#12383#12378#12425#12434#38450#27490#12377#12427#12383#12417#12391#12377#12290#12394
          #12362#12289#12450#12459#12454#12531#12488#12398#30331#37682#12399#24517#38920#12391#12399#12354#12426#12414#12379#12435#12290#23436#20840#12395#12458#12503#12471#12519#12531#12391#12377#12290
          ''
          'NOREPLY@synic.org'#12363#12425#12522#12531#12463#20184#12365#12398#12513#12540#12523#12364#23626#12365#12414#12377#12290#12522#12531#12463#12434#12463#12522#12483#12463#12375#12390#12289#35686#20633#21729#12450#12459#12454#12531#12488#12395#12513
          #12540#12523#12450#12489#12524#12473#12392#12497#12473#12527#12540#12489#12434'30'#20998#20197#20869#12395#30331#37682#12375#12390#12367#12384#12373#12356#12290
          ''
          
            #12394#12362#12289#12450#12459#12454#12531#12488#12434#30331#37682#12377#12427#22580#21512#12399#12289'https://www.synic.org/donguri-pivacy-policy'#12398#12503#12521#12452 +
            #12496#12471#12540
          #12509#12522#12471#12540#12395#21516#24847#12375#12383#12418#12398#12392#12415#12394#12373#12428#12414#12377#12290)
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object PanelBottom1: TPanel
        Left = 0
        Top = 247
        Width = 561
        Height = 51
        Align = alBottom
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        object ButtonOk1: TButton
          Left = 350
          Top = 16
          Width = 90
          Height = 25
          Caption = #27425#12408' '#8594
          TabOrder = 0
          OnClick = ButtonOk1Click
        end
        object ButtonCancel: TButton
          Left = 456
          Top = 16
          Width = 90
          Height = 25
          Cancel = True
          Caption = #20013#27490
          ModalResult = 2
          TabOrder = 1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #30331#37682
      ImageIndex = 1
      object PanelReg: TPanel
        Left = 0
        Top = 0
        Width = 561
        Height = 247
        Align = alClient
        BevelOuter = bvNone
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        object Label1: TLabel
          Left = 43
          Top = 56
          Width = 80
          Height = 13
          Caption = #12513#12540#12523#12450#12489#12524#12473'(&M)'
          FocusControl = EditMail
        end
        object Label2: TLabel
          Left = 43
          Top = 136
          Width = 61
          Height = 13
          Caption = #12497#12473#12527#12540#12489'(&P)'
        end
        object Label3: TLabel
          Left = 40
          Top = 16
          Width = 274
          Height = 13
          Caption = #12450#12459#12454#12531#12488#12434#12398#12513#12540#12523#12450#12489#12524#12473#12392#12497#12473#12527#12540#12489#12434#20837#21147#12375#12390#12367#12384#12373#12356#12290
        end
        object Label4: TLabel
          Left = 176
          Top = 80
          Width = 220
          Height = 13
          Caption = 'gmail.com'#12398#12513#12540#12523#12450#12489#12524#12473#12384#12369#12364#30331#37682#12391#12365#12414#12377#12290
        end
        object Label5: TLabel
          Left = 176
          Top = 99
          Width = 240
          Height = 13
          Caption = 'UPLIFT'#12392#21516#12376#12513#12540#12523#12450#12489#12524#12473#12434#20351#29992#12375#12394#12356#12391#12367#12384#12373#12356#12290
        end
        object EditMail: TEdit
          Left = 160
          Top = 53
          Width = 345
          Height = 21
          TabOrder = 0
        end
        object EditPassword: TEdit
          Left = 160
          Top = 133
          Width = 345
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
        object CheckBoxShowPW: TCheckBox
          Left = 424
          Top = 160
          Width = 97
          Height = 17
          Caption = #34920#31034#12377#12427'(&S)'
          TabOrder = 2
          OnClick = CheckBoxShowPWClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 247
        Width = 561
        Height = 51
        Align = alBottom
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        object ButtonOk2: TButton
          Left = 350
          Top = 16
          Width = 90
          Height = 25
          Caption = #30331#37682
          TabOrder = 0
          OnClick = ButtonOk2Click
        end
        object ButtonCancel2: TButton
          Left = 456
          Top = 16
          Width = 90
          Height = 25
          Cancel = True
          Caption = #20013#27490
          ModalResult = 2
          TabOrder = 1
        end
        object ButtonBack2: TButton
          Left = 240
          Top = 16
          Width = 90
          Height = 25
          Caption = #8592' '#25147#12427
          TabOrder = 2
          OnClick = ButtonBack2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #30331#37682#30906#35469
      ImageIndex = 2
      object PanelLink: TPanel
        Left = 0
        Top = 0
        Width = 561
        Height = 247
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 176
        ExplicitTop = 24
        ExplicitWidth = 185
        ExplicitHeight = 41
        object Label6: TLabel
          Left = 30
          Top = 29
          Width = 491
          Height = 13
          Caption = #12513#12540#12523#12391#21463#12369#21462#12387#12383#12393#12435#12368#12426#12471#12473#12486#12512#12398#26908#35388#12467#12540#12489#12398#12522#12531#12463#12434#12371#12371#12395#36028#12426#20184#12369#12390#30331#37682#12508#12479#12531#12434#12463#12522#12483#12463#12375#12390#12367#12384#12373#12356#12290
        end
        object Label7: TLabel
          Left = 30
          Top = 72
          Width = 88
          Height = 13
          Caption = #26908#35388#12467#12540#12489#12522#12531#12463'(&L)'
          FocusControl = EditLink
        end
        object EditLink: TEdit
          Left = 30
          Top = 91
          Width = 489
          Height = 21
          TabOrder = 0
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 247
        Width = 561
        Height = 51
        Align = alBottom
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        object ButtonOk3: TButton
          Left = 350
          Top = 16
          Width = 90
          Height = 25
          Caption = #30331#37682
          TabOrder = 0
          OnClick = ButtonOk3Click
        end
        object ButtonCancel3: TButton
          Left = 456
          Top = 16
          Width = 90
          Height = 25
          Cancel = True
          Caption = #20013#27490
          ModalResult = 2
          TabOrder = 1
        end
      end
    end
  end
end
