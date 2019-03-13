object Form_Ecosystem: TForm_Ecosystem
  Left = 22
  Top = 100
  BorderStyle = bsNone
  Caption = 'Environmental Settings'
  ClientHeight = 758
  ClientWidth = 432
  Color = clWhite
  TransparentColorValue = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  PixelsPerInch = 120
  TextHeight = 16
  object Panel2: TPanel
    Left = 9
    Top = 129
    Width = 346
    Height = 158
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
    object Label2: TLabel
      Left = 74
      Top = 0
      Width = 136
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Calculation of Endpoints'
    end
    object E_t1: TLabeledEdit
      Left = 220
      Top = 42
      Width = 43
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 185
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'Population growth rate from day'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = '0'
    end
    object E_t2: TLabeledEdit
      Left = 282
      Top = 42
      Width = 44
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
      EditLabel.Caption = 'to'
      LabelPosition = lpLeft
      TabOrder = 1
      Text = '1'
    end
    object E_timex: TLabeledEdit
      Left = 220
      Top = 77
      Width = 43
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 142
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'Population density at day'
      LabelPosition = lpLeft
      TabOrder = 2
      Text = '1'
    end
    object E_extday: TLabeledEdit
      Left = 220
      Top = 110
      Width = 43
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      EditLabel.Width = 149
      EditLabel.Height = 16
      EditLabel.Margins.Left = 4
      EditLabel.Margins.Top = 4
      EditLabel.Margins.Right = 4
      EditLabel.Margins.Bottom = 4
      EditLabel.Caption = 'Extiction probability at day'
      LabelPosition = lpLeft
      TabOrder = 3
      Text = '1'
    end
  end
  object RG_MC: TRadioGroup
    Left = 31
    Top = 35
    Width = 250
    Height = 86
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Number of Monte-Carlo Simulations'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      '10'
      '100'
      '1000')
    ParentFont = False
    TabOrder = 1
  end
  object RG_Simtype: TRadioGroup
    Left = 31
    Top = 545
    Width = 250
    Height = 106
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Type of Simulation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Single simulation'
      'Monte-Carlo simulation'
      'MC Dose-Response')
    ParentFont = False
    TabOrder = 2
    Visible = False
  end
end
