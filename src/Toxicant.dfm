object Form_Toxicant: TForm_Toxicant
  Left = 22
  Top = 100
  BorderStyle = bsNone
  Caption = 'Form_Toxicant'
  ClientHeight = 796
  ClientWidth = 432
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 9
    Top = 0
    Width = 411
    Height = 103
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object CB_sublethal: TCheckBox
      Left = 200
      Top = 52
      Width = 148
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Sub-lethal effects'
      TabOrder = 0
      OnClick = CB_sublethalClick
    end
    object CB_lethal: TCheckBox
      Left = 200
      Top = 21
      Width = 127
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Lethal effects'
      TabOrder = 1
      OnClick = CB_lethalClick
    end
    object RG_modelchoice: TRadioGroup
      Left = 16
      Top = 16
      Width = 165
      Height = 88
      Caption = 'Type of effect model'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'process based'
        'dose response')
      ParentFont = False
      TabOrder = 2
      OnClick = RG_modelchoiceClick
    end
  end
  object P_sublethal: TPanel
    Left = 9
    Top = 514
    Width = 411
    Height = 244
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 167
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Physiological modes of action'
    end
    object E_c01: TLabeledEdit
      Left = 230
      Top = 29
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 13
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'c0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 0
      Text = '0'
      Visible = False
    end
    object E_cT1: TLabeledEdit
      Left = 327
      Top = 29
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 14
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'cT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '0'
      Visible = False
    end
    object E_c02: TLabeledEdit
      Left = 230
      Top = 58
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 13
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'c0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 2
      Text = '0'
      Visible = False
    end
    object E_cT2: TLabeledEdit
      Left = 327
      Top = 58
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 14
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'cT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 3
      Text = '0'
      Visible = False
    end
    object E_c03a: TLabeledEdit
      Left = 230
      Top = 88
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 13
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'c0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 4
      Text = '0'
      Visible = False
    end
    object E_cT3a: TLabeledEdit
      Left = 327
      Top = 88
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 14
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'cT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 5
      Text = '0'
      Visible = False
    end
    object E_c03b: TLabeledEdit
      Left = 230
      Top = 118
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 13
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'c0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 6
      Text = '0'
      Visible = False
    end
    object E_cT3b: TLabeledEdit
      Left = 327
      Top = 118
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 14
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'cT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 7
      Text = '0'
      Visible = False
    end
    object E_c04: TLabeledEdit
      Left = 230
      Top = 148
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 13
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'c0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 8
      Text = '0'
      Visible = False
    end
    object E_cT4: TLabeledEdit
      Left = 327
      Top = 148
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 14
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'cT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 9
      Text = '0'
      Visible = False
    end
    object E_c05: TLabeledEdit
      Left = 230
      Top = 178
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 13
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'c0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 10
      Text = '0'
      Visible = False
    end
    object E_cT5: TLabeledEdit
      Left = 327
      Top = 178
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 14
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'cT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 11
      Text = '0'
      Visible = False
    end
    object E_c06: TLabeledEdit
      Left = 230
      Top = 208
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 13
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'c0'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 12
      Text = '0'
      Visible = False
    end
    object E_cT6: TLabeledEdit
      Left = 327
      Top = 208
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 14
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'cT'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 13
      Text = '0'
      Visible = False
    end
    object CB_pmo1: TCheckBox
      Left = 20
      Top = 26
      Width = 106
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Feeding'
      TabOrder = 14
      OnClick = CB_pmo1Click
    end
    object CB_pmo2: TCheckBox
      Left = 20
      Top = 55
      Width = 116
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Assimilation'
      TabOrder = 15
      OnClick = CB_pmo2Click
    end
    object CB_pmo3a: TCheckBox
      Left = 20
      Top = 85
      Width = 168
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Somatic maintenance'
      TabOrder = 16
      OnClick = CB_pmo3aClick
    end
    object CB_pmo3b: TCheckBox
      Left = 20
      Top = 120
      Width = 168
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Maturity maintenance'
      TabOrder = 17
      OnClick = CB_pmo3bClick
    end
    object CB_pmo4: TCheckBox
      Left = 20
      Top = 150
      Width = 147
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Cost for growth'
      TabOrder = 18
      OnClick = CB_pmo4Click
    end
    object CB_pmo5: TCheckBox
      Left = 20
      Top = 180
      Width = 179
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Cost for reproduction'
      TabOrder = 19
      OnClick = CB_pmo5Click
    end
    object CB_pmo6: TCheckBox
      Left = 20
      Top = 211
      Width = 147
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Hazard to embryo'
      TabOrder = 20
      OnClick = CB_pmo6Click
    end
  end
  object P_lethal: TPanel
    Left = 9
    Top = 400
    Width = 411
    Height = 106
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
    object RG_SD_IT: TRadioGroup
      Left = 10
      Top = 10
      Width = 189
      Height = 85
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Toxicodynamic assumption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Items.Strings = (
        'Individual tolerance'
        'Stochastic death')
      ParentFont = False
      TabOrder = 0
      OnClick = RG_SD_ITClick
    end
    object E_kk: TLabeledEdit
      Left = 230
      Top = 64
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 12
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'kk'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '0'
      Visible = False
    end
    object E_z: TLabeledEdit
      Left = 328
      Top = 64
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 6
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'z'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 2
      Text = '0'
      Visible = False
    end
    object E_alpha: TLabeledEdit
      Left = 230
      Top = 29
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 7
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'a'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 3
      Text = '0'
      Visible = False
    end
    object E_beta: TLabeledEdit
      Left = 328
      Top = 29
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 7
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'b'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 4
      Text = '0'
      Visible = False
    end
  end
  object RG_exposure_scenario: TRadioGroup
    Left = 21
    Top = 111
    Width = 169
    Height = 102
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Exposure Scenario'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Constant'
      'Single peak'
      'Multiple peak')
    ParentFont = False
    TabOrder = 3
  end
  object P_tk: TPanel
    Left = 9
    Top = 221
    Width = 411
    Height = 171
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object RG_metric: TRadioGroup
      Left = 10
      Top = 8
      Width = 235
      Height = 155
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Dose metric'
      ItemIndex = 0
      Items.Strings = (
        'external concentration'
        'internal concentration'
        'scaled internal concentration'
        'Lm scaled internal concentration'
        'scaled damage')
      TabOrder = 0
      OnClick = RG_metricClick
    end
    object E_ki: TLabeledEdit
      Left = 286
      Top = 16
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 9
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'ki'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '0'
      Visible = False
    end
    object E_ke: TLabeledEdit
      Left = 286
      Top = 51
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 13
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'ke'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 2
      Text = '0'
      Visible = False
    end
    object E_krec: TLabeledEdit
      Left = 286
      Top = 86
      Width = 54
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 11
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'kr'
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 3
      Text = '0'
      Visible = False
    end
    object CB_g_dil: TCheckBox
      Left = 268
      Top = 118
      Width = 133
      Height = 33
      Caption = 'growth dilution'
      TabOrder = 4
      Visible = False
    end
  end
  object E_tox_concentration: TLabeledEdit
    Left = 209
    Top = 115
    Width = 54
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    EditLabel.Width = 119
    EditLabel.Height = 16
    EditLabel.Margins.Left = 4
    EditLabel.Margins.Top = 4
    EditLabel.Margins.Right = 4
    EditLabel.Margins.Bottom = 4
    EditLabel.Caption = 'Concentration [mg/l]'
    LabelPosition = lpRight
    LabelSpacing = 5
    TabOrder = 5
    Text = '0'
  end
  object E_tox_time: TLabeledEdit
    Left = 209
    Top = 184
    Width = 54
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    EditLabel.Width = 113
    EditLabel.Height = 16
    EditLabel.Margins.Left = 4
    EditLabel.Margins.Top = 4
    EditLabel.Margins.Right = 4
    EditLabel.Margins.Bottom = 4
    EditLabel.Caption = 'Exposure period [d]'
    LabelPosition = lpRight
    LabelSpacing = 5
    TabOrder = 6
    Text = '0'
  end
  object E_exposure_start: TLabeledEdit
    Left = 209
    Top = 150
    Width = 54
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    EditLabel.Width = 122
    EditLabel.Height = 16
    EditLabel.Margins.Left = 4
    EditLabel.Margins.Top = 4
    EditLabel.Margins.Right = 4
    EditLabel.Margins.Bottom = 4
    EditLabel.Caption = 'Day of exposure start'
    LabelPosition = lpRight
    LabelSpacing = 5
    TabOrder = 7
    Text = '0'
  end
  object P_doseresponse: TPanel
    Left = 25
    Top = 240
    Width = 348
    Height = 153
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Visible = False
    object P_acute: TPanel
      Left = 22
      Top = 31
      Width = 163
      Height = 97
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object Label2: TLabel
        Left = 25
        Top = 0
        Width = 114
        Height = 16
        Caption = 'Acute toxicity (24 h)'
      end
      object E_Acute_EC50: TLabeledEdit
        Left = 64
        Top = 31
        Width = 65
        Height = 24
        EditLabel.Width = 33
        EditLabel.Height = 16
        EditLabel.Caption = 'EC 50'
        LabelPosition = lpLeft
        TabOrder = 0
        Text = '0'
      end
      object E_Acute_Slope: TLabeledEdit
        Left = 64
        Top = 62
        Width = 65
        Height = 24
        EditLabel.Width = 32
        EditLabel.Height = 16
        EditLabel.Caption = 'Slope'
        LabelPosition = lpLeft
        TabOrder = 1
        Text = '0'
      end
    end
    object P_repro: TPanel
      Left = 184
      Top = 31
      Width = 146
      Height = 106
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object Label3: TLabel
        Left = 25
        Top = 0
        Width = 75
        Height = 16
        Caption = 'Reproduction'
      end
      object E_Repro_EC50: TLabeledEdit
        Left = 65
        Top = 31
        Width = 65
        Height = 24
        EditLabel.Width = 33
        EditLabel.Height = 16
        EditLabel.Caption = 'EC 50'
        LabelPosition = lpLeft
        TabOrder = 0
        Text = '0'
      end
      object E_Repro_Slope: TLabeledEdit
        Left = 64
        Top = 62
        Width = 65
        Height = 24
        EditLabel.Width = 32
        EditLabel.Height = 16
        EditLabel.Caption = 'Slope'
        LabelPosition = lpLeft
        TabOrder = 1
        Text = '0'
      end
    end
  end
end
