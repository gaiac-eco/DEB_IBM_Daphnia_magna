object Form_LoadEnv: TForm_LoadEnv
  Left = 0
  Top = 0
  Caption = 'Load environment data'
  ClientHeight = 279
  ClientWidth = 1242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 17
  object Memo1: TMemo
    Left = 52
    Top = 10
    Width = 943
    Height = 106
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 52
    Top = 146
    Width = 943
    Height = 96
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Lines.Strings = (
      'Memo2')
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Left = 8
    Top = 8
  end
  object OpenDialog2: TOpenDialog
    Left = 8
    Top = 120
  end
end
