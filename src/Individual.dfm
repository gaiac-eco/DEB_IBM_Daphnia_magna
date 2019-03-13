object Form_Individual: TForm_Individual
  Left = 22
  Top = 100
  BorderStyle = bsNone
  Caption = 'Individual Properties'
  ClientHeight = 606
  ClientWidth = 346
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 321
    Height = 143
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 6
      Width = 194
      Height = 13
      Caption = 'Parameters for growth and reproduction'
    end
    object E_EG: TLabeledEdit
      Left = 34
      Top = 27
      Width = 59
      Height = 21
      EditLabel.Width = 21
      EditLabel.Height = 13
      EditLabel.Caption = '[EG]'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 0
      Text = '0.00179'
    end
    object E_km: TLabeledEdit
      Left = 34
      Top = 55
      Width = 59
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'km'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '1.599'
    end
    object E_v: TLabeledEdit
      Left = 34
      Top = 84
      Width = 59
      Height = 21
      EditLabel.Width = 6
      EditLabel.Height = 13
      EditLabel.Caption = 'v'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 2
      Text = '0.825'
    end
    object E_kappa: TLabeledEdit
      Left = 137
      Top = 26
      Width = 60
      Height = 21
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = 'kappa'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 3
      Text = '0.678'
    end
    object E_kj: TLabeledEdit
      Left = 137
      Top = 54
      Width = 60
      Height = 21
      EditLabel.Width = 8
      EditLabel.Height = 13
      EditLabel.Caption = 'kj'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 4
      Text = '0.969'
    end
    object E_UBH: TLabeledEdit
      Left = 241
      Top = 25
      Width = 59
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'UBH'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 5
      Text = '0.012'
    end
    object E_UPH: TLabeledEdit
      Left = 241
      Top = 54
      Width = 59
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'UPH'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 6
      Text = '0.1997'
    end
    object E_U0E: TLabeledEdit
      Left = 241
      Top = 82
      Width = 59
      Height = 21
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = 'U0E'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 7
      Text = '0.089'
    end
    object E_kr: TLabeledEdit
      Left = 137
      Top = 82
      Width = 60
      Height = 21
      EditLabel.Width = 9
      EditLabel.Height = 13
      EditLabel.Caption = 'kr'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 8
      Text = '0.95'
    end
    object E_dM: TLabeledEdit
      Left = 34
      Top = 112
      Width = 59
      Height = 21
      EditLabel.Width = 14
      EditLabel.Height = 13
      EditLabel.Caption = 'dM'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 9
      Text = '0.54'
    end
    object E_Li: TLabeledEdit
      Left = 137
      Top = 111
      Width = 60
      Height = 21
      EditLabel.Width = 7
      EditLabel.Height = 13
      EditLabel.Caption = 'Li'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 10
      Text = '0.0000001'
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 147
    Width = 321
    Height = 86
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 6
      Width = 192
      Height = 13
      Caption = 'Parameters for food dependent survival'
    end
    object E_ha: TLabeledEdit
      Left = 34
      Top = 27
      Width = 59
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'ha'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 0
      Text = '0.00029'
    end
    object E_sg: TLabeledEdit
      Left = 34
      Top = 55
      Width = 59
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'sG'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '0.4'
    end
    object E_kd: TLabeledEdit
      Left = 241
      Top = 26
      Width = 59
      Height = 21
      EditLabel.Width = 11
      EditLabel.Height = 13
      EditLabel.Caption = 'kd'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 2
      Text = '0.09'
    end
    object E_ealpha: TLabeledEdit
      Left = 137
      Top = 25
      Width = 60
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'alpha'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 3
      Text = '0.41'
    end
    object E_ebeta: TLabeledEdit
      Left = 137
      Top = 52
      Width = 60
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'beta'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 4
      Text = '4'
    end
  end
  object Panel3: TPanel
    Left = 8
    Top = 239
    Width = 321
    Height = 114
    BevelOuter = bvNone
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 6
      Width = 189
      Height = 13
      Caption = 'Parameters for feeding and assimilation'
    end
    object E_fx: TLabeledEdit
      Left = 34
      Top = 27
      Width = 59
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'fx'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 0
      Text = '2.97'
    end
    object E_xk: TLabeledEdit
      Left = 34
      Top = 55
      Width = 59
      Height = 21
      EditLabel.Width = 11
      EditLabel.Height = 13
      EditLabel.Caption = 'xk'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '0.00022'
    end
    object E_ill: TLabeledEdit
      Left = 33
      Top = 82
      Width = 59
      Height = 21
      EditLabel.Width = 6
      EditLabel.Height = 13
      EditLabel.Caption = 'ill'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 2
      Text = '0.00036'
    end
    object E_e0: TLabeledEdit
      Left = 137
      Top = 27
      Width = 60
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'e0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 3
      Text = '0.63'
    end
    object E_fa: TLabeledEdit
      Left = 137
      Top = 82
      Width = 60
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'fa'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 4
      Text = '10.4'
    end
    object E_pam: TLabeledEdit
      Left = 241
      Top = 25
      Width = 59
      Height = 21
      EditLabel.Width = 21
      EditLabel.Height = 13
      EditLabel.Caption = 'pAm'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 5
      Text = '0.0145'
    end
    object E_pxmin: TLabeledEdit
      Left = 241
      Top = 54
      Width = 59
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'pxmin'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 6
      Text = '0.58'
    end
    object E_pxmax: TLabeledEdit
      Left = 241
      Top = 82
      Width = 59
      Height = 21
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'pxmax'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 7
      Text = '0.95'
    end
    object E_eT: TLabeledEdit
      Left = 137
      Top = 54
      Width = 60
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'eT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 8
      Text = '0.139'
    end
  end
  object Panel4: TPanel
    Left = 8
    Top = 420
    Width = 322
    Height = 178
    BevelOuter = bvNone
    TabOrder = 3
    object Label4: TLabel
      Left = 8
      Top = 6
      Width = 156
      Height = 13
      Caption = 'Crowding and adaptive plasticity'
    end
    object Label6: TLabel
      Left = 119
      Top = 61
      Width = 108
      Height = 13
      Caption = 'Reduced filtration rate'
    end
    object Label7: TLabel
      Left = 119
      Top = 118
      Width = 157
      Height = 13
      Caption = 'Increased costs for reproduction'
    end
    object CB_crowding: TCheckBox
      Left = 34
      Top = 57
      Width = 79
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Crowding'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CB_plasticity: TCheckBox
      Left = 33
      Top = 24
      Width = 136
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Adaptive Plasticity'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object E_f_dT: TLabeledEdit
      Left = 142
      Top = 80
      Width = 60
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'dT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 2
      Text = '0.95'
    end
    object E_f_d0: TLabeledEdit
      Left = 242
      Top = 80
      Width = 60
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'd0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 3
      Text = '0.37'
    end
    object E_c_dT: TLabeledEdit
      Left = 142
      Top = 137
      Width = 60
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'dT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 4
      Text = '0.59'
    end
    object E_c_d0: TLabeledEdit
      Left = 242
      Top = 137
      Width = 60
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'd0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 5
      Text = '0.021'
    end
  end
  object Panel5: TPanel
    Left = 8
    Top = 359
    Width = 322
    Height = 63
    BevelOuter = bvNone
    TabOrder = 4
    object Label5: TLabel
      Left = 8
      Top = 6
      Width = 62
      Height = 13
      Caption = 'Temperature'
    end
    object E_TA: TLabeledEdit
      Left = 34
      Top = 25
      Width = 59
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'TA'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 0
      Text = '6400'
    end
    object E_Tref: TLabeledEdit
      Left = 242
      Top = 25
      Width = 60
      Height = 21
      EditLabel.Width = 79
      EditLabel.Height = 13
      EditLabel.Caption = 'reference T ['#176'C]'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '20'
    end
  end
end
