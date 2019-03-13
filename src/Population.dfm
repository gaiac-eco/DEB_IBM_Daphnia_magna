object Form_Population: TForm_Population
  Left = 22
  Top = 100
  BorderStyle = bsNone
  Caption = 'Population settings'
  ClientHeight = 606
  ClientWidth = 343
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
  object Label3: TLabel
    Left = 242
    Top = 72
    Width = 46
    Height = 13
    Caption = 'Size [mm]'
  end
  object P_Startpop: TPanel
    Left = 25
    Top = 22
    Width = 294
    Height = 160
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 88
      Height = 14
      Caption = 'Start Population'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object L_number: TLabel
      Left = 71
      Top = 47
      Width = 37
      Height = 13
      Caption = 'Number'
    end
    object L_size: TLabel
      Left = 150
      Top = 42
      Width = 46
      Height = 13
      Caption = 'Size [mm]'
    end
    object Label4: TLabel
      Left = 218
      Top = 42
      Width = 13
      Height = 13
      Caption = 'SD'
    end
    object E_class1_nr: TLabeledEdit
      Left = 71
      Top = 67
      Width = 39
      Height = 21
      EditLabel.Width = 38
      EditLabel.Height = 13
      EditLabel.Caption = 'Class 1:'
      EditLabel.Transparent = False
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 0
      Text = '5'
    end
    object E_class2_nr: TLabeledEdit
      Left = 71
      Top = 95
      Width = 39
      Height = 21
      EditLabel.Width = 38
      EditLabel.Height = 13
      EditLabel.Caption = 'Class 2:'
      EditLabel.Transparent = False
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 1
      Text = '0'
    end
    object E_class3_nr: TLabeledEdit
      Left = 71
      Top = 123
      Width = 39
      Height = 21
      EditLabel.Width = 38
      EditLabel.Height = 13
      EditLabel.Caption = 'Class 3:'
      EditLabel.Transparent = False
      LabelPosition = lpLeft
      LabelSpacing = 5
      TabOrder = 2
      Text = '3'
    end
    object E_class1_size: TEdit
      Left = 150
      Top = 67
      Width = 48
      Height = 21
      TabOrder = 3
      Text = '1'
    end
    object E_class2_size: TEdit
      Left = 150
      Top = 95
      Width = 48
      Height = 21
      TabOrder = 4
      Text = '1.6'
    end
    object E_class3_size: TEdit
      Left = 150
      Top = 123
      Width = 48
      Height = 21
      TabOrder = 5
      Text = '3.2'
    end
    object s_sizeclass3: TEdit
      Left = 218
      Top = 123
      Width = 48
      Height = 21
      TabOrder = 6
      Text = '0.1'
    end
  end
  object Panel1: TPanel
    Left = 25
    Top = 210
    Width = 160
    Height = 109
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 24
      Top = 16
      Width = 61
      Height = 14
      Caption = 'Size classes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object L_sizeclass1: TLabel
      Left = 117
      Top = 57
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object L_sizeclass3: TLabel
      Left = 117
      Top = 84
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object E_class1_sizeclass: TLabeledEdit
      Left = 72
      Top = 48
      Width = 39
      Height = 21
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'Class 1 <'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = '1.25'
    end
    object E_class3_sizeclass: TLabeledEdit
      Left = 72
      Top = 76
      Width = 39
      Height = 21
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'Class 3 '#8805
      LabelPosition = lpLeft
      TabOrder = 1
      Text = '2.1'
    end
  end
  object E_Iterations: TLabeledEdit
    Left = 202
    Top = 339
    Width = 101
    Height = 21
    EditLabel.Width = 100
    EditLabel.Height = 13
    EditLabel.Caption = 'Number of Iterations'
    TabOrder = 2
    Text = '10'
  end
  object s_sizeclass2: TEdit
    Left = 242
    Top = 120
    Width = 49
    Height = 21
    TabOrder = 3
    Text = '0.1'
  end
  object s_sizeclass1: TEdit
    Left = 242
    Top = 92
    Width = 49
    Height = 21
    TabOrder = 4
    Text = '0.1'
  end
  object E_noeggs: TLabeledEdit
    Left = 202
    Top = 243
    Width = 101
    Height = 21
    EditLabel.Width = 114
    EditLabel.Height = 13
    EditLabel.Caption = 'No. adults without eggs'
    TabOrder = 5
    Text = '1'
  end
  object E_pref: TLabeledEdit
    Left = 202
    Top = 289
    Width = 101
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Pre-test f'
    TabOrder = 6
    Text = '0.7'
  end
end
