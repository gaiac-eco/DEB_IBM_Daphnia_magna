object Form_Environment: TForm_Environment
  Left = 22
  Top = 100
  BorderStyle = bsNone
  Caption = 'Form_Environment'
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
  object P_food: TPanel
    Left = 20
    Top = 118
    Width = 307
    Height = 143
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object RG_food: TRadioGroup
      Left = 7
      Top = 8
      Width = 103
      Height = 113
      Caption = 'Add food'
      ItemIndex = 1
      Items.Strings = (
        'once '
        'daily'
        'scenario'
        'flow through')
      TabOrder = 0
      OnClick = RG_foodClick
    end
    object E_fooddensity: TLabeledEdit
      Left = 134
      Top = 80
      Width = 48
      Height = 22
      EditLabel.Width = 125
      EditLabel.Height = 14
      EditLabel.Caption = 'Food density [mgC/ml]'
      LabelPosition = lpRight
      LabelSpacing = 5
      TabOrder = 1
      Text = '0.5'
    end
    object RG_foodcalculation: TRadioGroup
      Left = 134
      Top = 8
      Width = 135
      Height = 66
      Caption = 'Calculate as'
      ItemIndex = 1
      Items.Strings = (
        'Food density'
        'Food total')
      TabOrder = 2
      OnClick = RG_foodcalculationClick
    end
    object E_flow: TLabeledEdit
      Left = 134
      Top = 108
      Width = 48
      Height = 22
      EditLabel.Width = 89
      EditLabel.Height = 14
      EditLabel.Caption = 'Flow rate [ml/h]'
      LabelPosition = lpRight
      LabelSpacing = 5
      TabOrder = 3
      Text = '360'
      Visible = False
    end
  end
  object E_volume: TLabeledEdit
    Left = 154
    Top = 46
    Width = 48
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'Volume [ml]'
    LabelPosition = lpRight
    LabelSpacing = 5
    TabOrder = 1
    Text = '900'
  end
  object RG_Sytemtype: TRadioGroup
    Left = 28
    Top = 8
    Width = 102
    Height = 60
    Caption = 'Type'
    ItemIndex = 0
    Items.Strings = (
      'water column'
      'sediment')
    TabOrder = 2
    OnClick = RG_SytemtypeClick
  end
  object E_Simtime: TLabeledEdit
    Left = 154
    Top = 18
    Width = 48
    Height = 21
    EditLabel.Width = 88
    EditLabel.Height = 13
    EditLabel.Caption = 'Simulation time [d]'
    LabelPosition = lpRight
    LabelSpacing = 5
    TabOrder = 3
    Text = '43'
  end
  object CB_tox_on: TCheckBox
    Left = 26
    Top = 278
    Width = 168
    Height = 26
    Caption = 'Toxicant exposure'
    TabOrder = 4
  end
  object E_temperature: TLabeledEdit
    Left = 154
    Top = 73
    Width = 48
    Height = 21
    EditLabel.Width = 79
    EditLabel.Height = 13
    EditLabel.Caption = 'Temperture ['#176'C]'
    LabelPosition = lpRight
    TabOrder = 5
    Text = '19'
  end
  object CB_media_renewal: TCheckBox
    Left = 164
    Top = 284
    Width = 139
    Height = 14
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Weekly media renewal'
    TabOrder = 6
  end
end
