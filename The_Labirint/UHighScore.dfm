object FHighScore: TFHighScore
  Left = 393
  Top = 189
  Width = 320
  Height = 173
  BorderIcons = [biSystemMenu]
  Caption = 'FHighScore'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 44
    Height = 13
    Caption = 'D'#233'butant'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 60
    Height = 13
    Caption = 'Interm'#233'diaire'
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 30
    Height = 13
    Caption = 'Expert'
  end
  object DScore: TLabel
    Left = 96
    Top = 16
    Width = 44
    Height = 13
    Caption = 'D'#233'butant'
  end
  object IScore: TLabel
    Left = 96
    Top = 40
    Width = 60
    Height = 13
    Caption = 'Interm'#233'diaire'
  end
  object EScore: TLabel
    Left = 96
    Top = 64
    Width = 30
    Height = 13
    Caption = 'Expert'
  end
  object DName: TLabel
    Left = 176
    Top = 16
    Width = 44
    Height = 13
    Caption = 'D'#233'butant'
  end
  object IName: TLabel
    Left = 176
    Top = 40
    Width = 60
    Height = 13
    Caption = 'Interm'#233'diaire'
  end
  object EName: TLabel
    Left = 176
    Top = 64
    Width = 30
    Height = 13
    Caption = 'Expert'
  end
  object Button1: TButton
    Left = 32
    Top = 104
    Width = 97
    Height = 25
    Caption = 'Effacer les scores'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 200
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button2Click
  end
end
