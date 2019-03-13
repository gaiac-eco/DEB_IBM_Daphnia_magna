object Form_Output: TForm_Output
  Left = 500
  Top = 70
  BorderStyle = bsNone
  Caption = 'Medoel results'
  ClientHeight = 891
  ClientWidth = 1053
  Color = clWhite
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
  object PC_Output: TPageControl
    Left = 9
    Top = 27
    Width = 1036
    Height = 786
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ActivePage = TS_Population
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    Style = tsFlatButtons
    TabOrder = 0
    object TS_Population: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Population dynamics'
      object Chart_totalabundance: TChart
        Left = 21
        Top = 31
        Width = 472
        Height = 336
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Height = -15
        Title.Text.Strings = (
          'Total abundance')
        BottomAxis.Grid.Visible = False
        BottomAxis.StartPosition = 1.000000000000000000
        BottomAxis.Title.Caption = 'Time [d]'
        BottomAxis.TitleSize = 13
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        LeftAxis.LabelsSeparation = 70
        LeftAxis.Title.Caption = 'Individuals [#]'
        LeftAxis.TitleSize = 7
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object S_total_min: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_total_mean: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_total_max: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_data_total: TPointSeries
          SeriesColor = clWhite
          ClickableLine = False
          Pointer.Brush.Gradient.EndColor = clWhite
          Pointer.Depth = 1
          Pointer.Gradient.EndColor = clWhite
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Chart_neonates: TChart
        Left = 523
        Top = 31
        Width = 472
        Height = 336
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Height = -15
        Title.Text.Strings = (
          'Abundance fraction '#8804'1.3 mm')
        BottomAxis.Grid.Visible = False
        BottomAxis.StartPosition = 1.000000000000000000
        BottomAxis.Title.Caption = 'Time [d]'
        BottomAxis.TitleSize = 13
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        LeftAxis.LabelsSeparation = 70
        LeftAxis.Title.Caption = 'Individuals [#]'
        LeftAxis.TitleSize = 7
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object S_neonates_min: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_neonates_mean: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_neonates_max: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_data_class1: TPointSeries
          SeriesColor = clWhite
          ClickableLine = False
          Pointer.Brush.Gradient.EndColor = clWhite
          Pointer.Gradient.EndColor = clWhite
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Chart_juvenile: TChart
        Left = 21
        Top = 387
        Width = 472
        Height = 336
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Height = -15
        Title.Text.Strings = (
          'Abuncance fraction 1.3-2.7 mm')
        BottomAxis.Grid.Visible = False
        BottomAxis.StartPosition = 1.000000000000000000
        BottomAxis.Title.Caption = 'Time [d]'
        BottomAxis.TitleSize = 13
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        LeftAxis.LabelsSeparation = 70
        LeftAxis.Title.Caption = 'Individuals [#]'
        LeftAxis.TitleSize = 7
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 2
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object S_juveniles_min: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_juveniles_mean: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_juveniles_max: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_data_class2: TPointSeries
          SeriesColor = clWhite
          ClickableLine = False
          Pointer.Brush.Gradient.EndColor = clWhite
          Pointer.Gradient.EndColor = clWhite
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Chart_adults: TChart
        Left = 523
        Top = 387
        Width = 472
        Height = 336
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Height = -15
        Title.Text.Strings = (
          'Abundance fraction >2.7 mm')
        BottomAxis.Grid.Visible = False
        BottomAxis.StartPosition = 1.000000000000000000
        BottomAxis.Title.Caption = 'Time [d]'
        BottomAxis.TitleSize = 13
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        LeftAxis.LabelsSeparation = 70
        LeftAxis.Title.Caption = 'Individuals [#]'
        LeftAxis.TitleSize = 7
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 3
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object S_adults_min: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_adults_mean: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_adults_max: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_data_class3: TPointSeries
          SeriesColor = clWhite
          ClickableLine = False
          Pointer.Brush.Gradient.EndColor = clWhite
          Pointer.Gradient.EndColor = clWhite
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TS_Food: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Food and reserves'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 31
      ExplicitWidth = 0
      ExplicitHeight = 751
      object Chart_feedingrate: TChart
        Left = 39
        Top = 41
        Width = 462
        Height = 360
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Text.Strings = (
          'Population feeding rate')
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'Time [d]'
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        LeftAxis.Title.Caption = 'Feeding rate [mgC/d]'
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object S_feedingrate_min: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDash
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_feedingrate_mean: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_feedingrate_max: TLineSeries
          SeriesColor = clRed
          Brush.BackColor = clDefault
          LinePen.Style = psDash
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Chart_reserves: TChart
        Left = 523
        Top = 41
        Width = 462
        Height = 416
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Legend.Alignment = laBottom
        Legend.Frame.Visible = False
        Legend.LegendStyle = lsSeries
        Legend.Shadow.Visible = False
        Legend.Title.Text.Strings = (
          'Size classes')
        Legend.VertSpacing = -6
        MarginBottom = 5
        MarginRight = 5
        MarginTop = 5
        Title.Font.Color = clBlack
        Title.Text.Strings = (
          'Average scaled reserve density ')
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'Time [d]'
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        LeftAxis.Maximum = 1.050000000000000000
        LeftAxis.Minimum = -0.050000000000000000
        LeftAxis.Title.Caption = 'Scaled reserve density [-]'
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        BorderWidth = 2
        Color = clWhite
        TabOrder = 1
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object S_neonate_e: TLineSeries
          SeriesColor = clBlack
          Title = 'small'
          Brush.BackColor = clDefault
          LinePen.Style = psDot
          LinePen.Width = 2
          LinePen.SmallSpace = 1
          Pointer.Brush.Gradient.EndColor = clGreen
          Pointer.Gradient.EndColor = clGreen
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_juvenile_e: TLineSeries
          SeriesColor = clBlack
          Title = 'medium'
          Brush.BackColor = clDefault
          LinePen.Style = psDash
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object S_adult_e: TLineSeries
          SeriesColor = clBlack
          Title = 'large'
          Brush.BackColor = clDefault
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TS_Statistics: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Statistics'
      ImageIndex = 2
      object Chart1: TChart
        Left = 51
        Top = 190
        Width = 515
        Height = 334
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Legend.Visible = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'Time [d]'
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        LeftAxis.Maximum = 1.000000000000000000
        LeftAxis.Minimum = -0.010000000000000000
        LeftAxis.Title.Caption = 'Extiction probability'
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object S_extprob: TLineSeries
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object SG_endpoints: TStringGrid
        Left = 21
        Top = 31
        Width = 974
        Height = 96
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        BevelOuter = bvNone
        ColCount = 6
        DefaultColWidth = 150
        RowCount = 2
        TabOrder = 1
        ColWidths = (
          150
          150
          150
          150
          150
          150)
        RowHeights = (
          24
          24)
      end
      object Memo2: TMemo
        Left = 31
        Top = 680
        Width = 964
        Height = 54
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Lines.Strings = (
          'Memo2')
        TabOrder = 2
        Visible = False
      end
    end
    object TS_Numbers: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Dyamics in numbers'
      ImageIndex = 3
      object SG_Numbers: TStringGrid
        Left = 52
        Top = 42
        Width = 933
        Height = 587
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        BevelOuter = bvNone
        ColCount = 14
        DefaultColWidth = 67
        TabOrder = 0
        ColWidths = (
          67
          67
          67
          67
          67
          67
          67
          67
          67
          67
          67
          67
          67
          67)
        RowHeights = (
          24
          24
          24
          24
          24)
      end
      object Memo1: TMemo
        Left = 52
        Top = 659
        Width = 933
        Height = 54
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Lines.Strings = (
          'Memo1')
        TabOrder = 1
        Visible = False
      end
    end
  end
  object ProgressBar1: TProgressBar
    Left = 9
    Top = 59
    Width = 498
    Height = 14
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 1
  end
  object Memo3: TMemo
    Left = 9
    Top = 831
    Width = 1037
    Height = 44
    Lines.Strings = (
      'Memo3')
    ScrollBars = ssBoth
    TabOrder = 2
    Visible = False
  end
  object SaveDialog1: TSaveDialog
    Left = 744
    Top = 536
  end
  object SaveDialog2: TSaveDialog
    Left = 672
    Top = 536
  end
end
