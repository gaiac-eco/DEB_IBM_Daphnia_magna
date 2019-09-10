object Form_Start: TForm_Start
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'DEB based IBM for Daphnia magna'
  ClientHeight = 633
  ClientWidth = 1343
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object TB_Setting: TTabControl
    Left = 8
    Top = 16
    Width = 418
    Height = 648
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 0
    Tabs.Strings = (
      'Model Settings'
      'Environment'
      'Population'
      'Individual'
      'Toxicant')
    TabIndex = 0
    OnChange = TB_SettingChange
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 8
    object Start1: TMenuItem
      Caption = 'Start'
      object SingleSimulation1: TMenuItem
        Caption = 'Single Simulation'
        OnClick = SingleSimulation1Click
      end
      object MonteCarloSimulation1: TMenuItem
        Caption = 'Monte-Carlo Simulation'
        OnClick = MonteCarloSimulation1Click
      end
    end
    object Load1: TMenuItem
      Caption = 'Load'
      object Populationdata1: TMenuItem
        Caption = 'Population Data'
        OnClick = Populationdata1Click
      end
    end
    object Save1: TMenuItem
      Caption = 'Save'
      object Populationresults1: TMenuItem
        Caption = 'Population results'
        OnClick = Populationresults1Click
      end
      object Endpoints1: TMenuItem
        Caption = 'Endpoints'
        OnClick = Endpoints1Click
      end
    end
    object Info1: TMenuItem
      Caption = 'Info'
      OnClick = Info1Click
    end
  end
end
