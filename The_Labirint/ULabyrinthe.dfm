object FLabyrinthe: TFLabyrinthe
  Left = 247
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  BorderWidth = 2
  Caption = 'The Labirint'
  ClientHeight = 305
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 332
    Height = 50
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clMoneyGreen
    TabOrder = 0
    DesignSize = (
      332
      50)
    object Label1: TLabel
      Left = 7
      Top = 10
      Width = 77
      Height = 26
      Caption = 'Record'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -23
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 196
      Top = 10
      Width = 67
      Height = 26
      Anchors = [akRight, akBottom]
      Caption = 'Actuel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -23
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnSolver: TSpeedButton
      Left = 150
      Top = 6
      Width = 40
      Height = 41
      Anchors = []
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      Layout = blGlyphRight
      NumGlyphs = 2
      Spacing = 2
      OnClick = BtnSolverClick
    end
    object ValRecord: TEdit
      Left = 96
      Top = 9
      Width = 52
      Height = 30
      TabStop = False
      AutoSelect = False
      CharCase = ecUpperCase
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -23
      Font.Name = 'Algerian'
      Font.Style = [fsBold]
      MaxLength = 3
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '000'
    end
    object ValTempEcoule: TEdit
      Left = 272
      Top = 9
      Width = 54
      Height = 30
      TabStop = False
      Anchors = [akRight, akBottom]
      AutoSelect = False
      CharCase = ecUpperCase
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -23
      Font.Name = 'Algerian'
      Font.Style = [fsBold]
      MaxLength = 3
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '000'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 50
    Width = 332
    Height = 255
    Align = alClient
    BevelInner = bvSpace
    BevelOuter = bvLowered
    Color = clSkyBlue
    TabOrder = 1
    object IconActuel: TImage
      Left = 138
      Top = 10
      Width = 31
      Height = 31
      Picture.Data = {
        07544269746D617076060000424D760600000000000036040000280000001800
        0000180000000100080000000000400200000000000000000000000100000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
        E00000400000004020000040400000406000004080000040A0000040C0000040
        E00000600000006020000060400000606000006080000060A0000060C0000060
        E00000800000008020000080400000806000008080000080A0000080C0000080
        E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
        E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
        E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
        E00040000000400020004000400040006000400080004000A0004000C0004000
        E00040200000402020004020400040206000402080004020A0004020C0004020
        E00040400000404020004040400040406000404080004040A0004040C0004040
        E00040600000406020004060400040606000406080004060A0004060C0004060
        E00040800000408020004080400040806000408080004080A0004080C0004080
        E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
        E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
        E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
        E00080000000800020008000400080006000800080008000A0008000C0008000
        E00080200000802020008020400080206000802080008020A0008020C0008020
        E00080400000804020008040400080406000804080008040A0008040C0008040
        E00080600000806020008060400080606000806080008060A0008060C0008060
        E00080800000808020008080400080806000808080008080A0008080C0008080
        E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
        E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
        E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
        E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
        E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
        E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
        E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
        E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
        E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
        E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
        A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD82FDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFD656565656565820982FDFDFDFDFDFDFDFDFDFDFDFD
        FD65652F2F2F2F2F2F6504FDFDFDFDFDFDFDFDFDFDFDFDFD6577777777777777
        6F2F6765FDFDFDFDFDFDFDFDFDFDFD65BFBF7F7F7F7F7F77776F9A8265FDFDFD
        FDFDFDFDFDFDFD65BFBFB7AFAFBFBF7F7F7782046582FDFDFDFDFDFDFDFD65BF
        BFBFBFBF6F6F1EBF7F77779A040482FDFDFDFDFDFDFD65BFBFBF6E1E1E6EBFBF
        BF9A776F820482FDFDFDFDFDFDFD65BFBFBFBFBFBFBFBFBF04049A9A040482FD
        FDFDFDFDFDFD65BFBFBFBFBF6F777F77D50404040404D5FDFDFDFDFDFDFD65BF
        BFBF776F096F770977D5D5D5D565FDFDFDFDFDFDFDFD65BFBF7777BF826FBF82
        BF6677772F65FDFDFDFDFDFDFDFDFD65BF776FBFBF77BFBFBF667F7765FDFDFD
        FDFDFDFDFDFDFD65BF776FBF77BFBFBF6F7F772F65FDFDFDFDFDFDFDFDFDFDFD
        65BFBF661E1EBFBF7F7F7765FDFDFDFDFDFDFDFDFDFDFDFDFD6565BFBFBFBFBF
        7F6565FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD656565656565FDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFD}
      Transparent = True
      Visible = False
    end
  end
  object ResolverTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = ResolverTimerTimer
    Left = 184
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 136
    Top = 72
    object Partie1: TMenuItem
      Caption = 'Partie  '
      object Nouveau1: TMenuItem
        Caption = 'Nouveau'
        OnClick = Nouveau1Click
      end
      object Charger1: TMenuItem
        Caption = 'Charger'
        OnClick = Charger1Click
      end
      object Enregistrersous1: TMenuItem
        Caption = 'Enregistrer sous...'
        OnClick = Enregistrersous1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Debutant1: TMenuItem
        Caption = 'Debutant'
        Checked = True
        OnClick = Debutant1Click
      end
      object Intermdiaire1: TMenuItem
        Caption = 'Intermediaire'
        OnClick = Intermdiaire1Click
      end
      object Expert1: TMenuItem
        Caption = 'Expert'
        OnClick = Expert1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Meilleurtemps1: TMenuItem
        Caption = 'Meilleur temps'
        OnClick = Meilleurtemps1Click
      end
      object Quitter1: TMenuItem
        Caption = 'Quitter'
        OnClick = Quitter1Click
      end
    end
    object N1: TMenuItem
      Caption = '  ?  '
      OnClick = N1Click
    end
  end
  object Chrono: TTimer
    Enabled = False
    OnTimer = ChronoTimer
    Left = 200
    Top = 104
  end
  object LoutreIcon: TImageList
    Left = 56
    Top = 57
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080E0E00080C0C00040A0C00080A0C00080C0E0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004080A0004080A0004080A0004080A0004080A0004080A0008000
      4000F0CAA6008000400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080E0E00040A0E00040A0E00040C0E00040C0E00040C0E00040A0E00040A0
      C00080C0C0000000000000000000000000000000000000000000000000000000
      00000000000040A0C00040E0E00040C0E00040E0E00040C0E00040A0C0000020
      E0000020E0000000000000000000000000000000000000000000000000004080
      A0004080A00000A0E00000A0E00000A0E00000A0E00000A0E00000A0E0004080
      A000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000080E0
      E00040C0E00040C0E00040C0E00040C0E00040C0E00040C0E00040C0E00040C0
      E00040A0E00080C0C00000000000000000000000000000000000000000000000
      000040A0C00040E0E00040C0E00040E0E00040C0E00040E0E00040C0E00040A0
      C0000020E00000000000000000000000000000000000000000004080A00040C0
      E00040C0E00040C0E00040C0E00040C0E00040C0E00040C0E00040A0E00000A0
      E0004080E0004080A00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080E0E00040C0
      E00040C0E00040C0E00040A0E00040A0E00040C0E00040C0E00040C0E00040C0
      E00040A0E00040A0E00080C0C00000000000000000000000000000000000F0FB
      FF0040E0E0000020E0000020E0000000FF000000FF000000FF000020E00040C0
      E00040E0E0000020E0000020E00000000000000000004080A00080E0E00080E0
      E00040E0E00040E0E00040E0E00040E0E00040E0E00040C0E00040C0E00040A0
      E00080604000800040004080A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040C0E00040E0
      E00040C0E0004080C0004080C0004080C0004080C00040C0E00040C0E0004080
      C00040A0E00040C0E00040A0E00000000000000000000000000040A0C000F0FB
      FF000020E0000000FF000000FF000000FF000000FF000000FF000000FF0040A0
      C00040C0E00040A0C0000020E00000000000000000004080A00080E0E00080E0
      E00080C0E00080A0E00080A0E00080E0E00080E0E00040E0E00040E0E00040C0
      E00080004000800000004080A000800040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040C0E00080E0E00040E0E00040E0
      E00040C0E0004080C00040C0E00040C0E0004080C0004080C0004080C0004080
      C00040A0E00040C0E00040A0E00080C0E0000000000040A0C00040E0E00040A0
      C000000000000020E0000020E0000000FF000020E0000000FF000020E0000020
      E0000000000040C0E00040A0C000000000004080A00080E0E00080E0E00080E0
      E00080E0E00080E0E00040A0E00040A0E0000060C00080E0E00040E0E00040C0
      E00040C0E0008060400080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040C0E00080E0E00040E0E00040E0
      E00040E0E00040C0E00040E0E00040E0E00040E0E00040C0E00040A0E00040C0
      E00040C0E00040C0E00040C0E00040C0E00000000000FFFFFF0040E0E0000020
      E0000020E0000020E0000020E0000020E0000020E0000020E0000020E0000000
      00000020E00040E0E00040C0E000000000004080A00080E0E00080E0E00080E0
      E00040A0C0000060C0000060C00040A0C00080E0E00080E0E00080E0E0008060
      400040C0E00040A0E00080004000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040C0E00080E0E00040E0E00040E0
      E00040E0E00040E0E00080E0E00040E0E00040E0E00040E0E00040E0E00040C0
      E00040E0E00040C0E00040C0E00040C0E0000000000040E0E00040E0E00040A0
      C00040C0E000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0040C0E00040C0E00040E0E000000000004080A00080E0E00080E0E00080E0
      E00080E0E00080E0E00080E0E00080E0E00080E0E00080E0E000800000008000
      0000806040008060400080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040C0E00040E0E00080E0E00040E0
      E00080C0E00080C0C00080C0E00080E0E00080E0E00080E0E00080C0E00080C0
      C00080C0E00040C0E00040C0E00040C0E00000000000FFFFFF0040E0E00040E0
      E00040C0E000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0040C0E00040E0E00040C0E000000000004080A00080E0E00080E0E00080E0
      E00080E0E00080E0E00040A0E00040C0E00040E0E00040C0E000C040A0008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040C0E00080E0E00080E0E00040E0
      E00080C0C000C0C0C00080A0C00040C0E00080E0E00040E0E00080A0C000C0C0
      C00080A0C00040C0E00040C0E00040C0E00000000000FFFFFF0040E0E00040E0
      E00040E0E00040E0E00040E0E00040E0E00040E0E00040E0E00040E0E00040E0
      E00040E0E00040C0E00040E0E000000000004080A00080E0E00080E0E00080E0
      E00040C0E00040A0E000F0CAA60040A0E00040C0E000F0CAA60040C0E000C040
      A000C040A000C040A000C040A0004080A0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040C0E00080E0E00040E0E00080E0
      E00080A0C0004080A0004080A00040C0E00080E0E00040E0E0004080A0004080
      A00080A0C00040C0E00040C0E00040C0E0000000000040A0C000FFFFFF0040E0
      E00040E0E000808080008000000040E0E00040E0E000800000008080800040E0
      E00040E0E00040E0E00040A0C000000000004080A00080E0E00080E0E00040C0
      E00040C0E00080E0E0008000400040A0E00080E0E0008000400080E0E0004080
      C00040C0E00040C0E00000A0E0004080A0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040E0E00040E0
      E00080C0C000C0C0C00080A0C00040C0E00080E0E00040E0E00080A0C000C0C0
      C00080A0C00040C0E00040C0E00000000000000000000000000040A0C00040E0
      E00040E0E00040E0E00040E0E00040E0E00040E0E00040E0E00040E0E00040E0
      E00040E0E00040A0C0000000000000000000000000004080A00080E0E00040C0
      E00040A0E00080E0E00080E0E00040C0E00080E0E00080E0E00080E0E0004080
      C00040E0E00040C0E0004080A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080E0E00080E0
      E00080C0E00080C0C00080C0E00080E0E00080E0E00080E0E00080C0E00080C0
      C00080C0E00040C0E00040C0E00000000000000000000000000000000000FFFF
      FF00FFFFFF0040E0E00040E0E00040E0E00040E0E00040E0E00040E0E00040E0
      E00040C0E000000000000000000000000000000000004080A00080E0E00040C0
      E00040A0E00080E0E00040C0E00080E0E00080E0E00080E0E00040A0E00040E0
      E00040C0E00000A0E0004080A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000080E0
      E00080E0E00040E0E00080E0E00080E0E00080E0E00080E0E00080E0E00040E0
      E00040E0E00040C0E00000000000000000000000000000000000000000000000
      000040A0C00040E0E00040E0E00040E0E00040E0E000F0FBFF0040E0E00040A0
      C0000000000000000000000000000000000000000000000000004080A00080E0
      E00080E0E0004080C0000060C0000060C00080E0E00080E0E00040E0E00040E0
      E00040C0E0004080A00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080E0E00040E0E00040E0E00080E0E00080E0E00040E0E00040E0E00040E0
      E00080E0E0000000000000000000000000000000000000000000000000000000
      00000000000040A0C000FFFFFF00F0FBFF00F0FBFF00F0FBFF0040A0C0000000
      0000000000000000000000000000000000000000000000000000000000004080
      A0004080A00080E0E00080E0E00080E0E00080E0E00080E0E00040E0E0004080
      A0004080A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080E0E00080E0E00080E0E00080E0E00080E0E00080E0E00080E0
      E000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004080A0004080A0004080A0004080A0004080A0004080A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC1FFFFFF8030000F007F807E0070000
      E003F007C0030000C001E00180010000C001C001800000000000880900000000
      0000801100000000000080010000000000008001000000000000800100000000
      0000800100000000C001C00380010000C001E00780010000E003F00FC0030000
      F007F81FE0070000F80FFFFFF81F000000000000000000000000000000000000
      000000000000}
  end
  object Chargeur: TOpenDialog
    DefaultExt = 'SLB'
    Filter = 'Fichier Labyrinthe (*.SLB)|*.SLB'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 16
    Top = 65
  end
end
