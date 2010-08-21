object fDeshifr: TfDeshifr
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1044#1077#1096#1080#1092#1088#1072#1090#1086#1088' '#1082#1086#1088#1086#1090#1082#1086#1081' '#1089#1089#1099#1083#1082#1080
  ClientHeight = 235
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 9
    Width = 71
    Height = 13
    Caption = #1050#1086#1088#1086#1090#1082#1080#1081' URL'
  end
  object SpeedButton1: TSpeedButton
    Left = 216
    Top = 4
    Width = 23
    Height = 22
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000604830604830
      6048306048306048306048306048306048306048306048306048306048306048
      30604830FFFFFFFFFFFFA09080C0B0A0F0F0F0FFFFFFFFFFFFFFFFFFFFF8F0FF
      F0F0F0F0E0F0E8E0F0E0D0F0D8D0E0C8C0D0B8B0604830FFFFFFA09080F0F0F0
      803010503020503020D0C0C0106080003850203040B0A0A01028800018600018
      60001860D0B8B0604830A09080FFFFFF803010E07840B0583050302010688000
      C0F000A0C03030301030801040D00030B00030B0001860604830A09080FFFFFF
      903810F08850E08050C0603020688000C0F000C0F000A0C02038802048E01040
      D01030B0001860FFFFFFA09080FFFFFF904020F0A070F09860C0785020708020
      C8F010C0F000A0C02038803058E02050E01038B0001860FFFFFFA09080FFF8F0
      A05020FFB080F0A880C0886030708030D0F020C8F010A0C03040804068E04060
      E03048C0001860FFFFFFA09080FFF0F0A05030B06840C08060D0907030788050
      D8F040D0F030A8C03048806078F05070F04058C0001860FFFFFFA09080F0F0E0
      B06040FFF0F0FFE8E0FFD8C040808070E0F060D8F040B0C04050907088F07080
      F05068C0001860FFFFFFA09080F0E8E0E0C8B0E09870E09070E0886040808090
      E8F080E0F060B8D04058908098FF8090F06070D0001860FFFFFFA09080F0E0D0
      F0E0E0604830FFFFFFFFFFFF508880B0F0FFA0E8FF80C0D05060906078B07088
      D07080D0001860FFFFFFA09080F0D8D0F0E0D0604830FFFFFFFFFFFF508880D0
      F0FFC0F0FF90C0D05080807080B0E0E0FFB0C0FF102060FFFFFFA6A197D0C8C0
      E0D8D0604830FFFFFFFFFFFF5088907098A080B0B0B0C8D0508080A8CBE66070
      A06070A0506090FFFFFFC0C6C0B19D87D0C8C0604830FFFFFFFFFFFF508890F0
      FFFFF0FFFFD0F8FF508080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C2B9
      B2A28F604830FFFFFFFFFFFF97C7D5508890508890508890508890FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C6C0887873FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = SpeedButton1Click
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 109
    Height = 13
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1089#1090#1088#1072#1085#1080#1094#1099':'
  end
  object Label3: TLabel
    Left = 136
    Top = 32
    Width = 103
    Height = 13
    AutoSize = False
    Caption = '---'
    EllipsisPosition = epEndEllipsis
    ParentShowHint = False
    ShowHint = True
  end
  object Label4: TLabel
    Left = 8
    Top = 83
    Width = 36
    Height = 13
    Caption = #1044#1086#1084#1077#1085':'
  end
  object Label5: TLabel
    Left = 136
    Top = 83
    Width = 103
    Height = 13
    AutoSize = False
    Caption = '---'
    EllipsisPosition = epWordEllipsis
  end
  object Label6: TLabel
    Left = 8
    Top = 130
    Width = 108
    Height = 13
    Caption = 'Mime-'#1090#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
  end
  object Label7: TLabel
    Left = 136
    Top = 130
    Width = 12
    Height = 13
    Caption = '---'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 8
    Top = 153
    Width = 117
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072', '#1050#1073':'
  end
  object Label9: TLabel
    Left = 136
    Top = 153
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label10: TLabel
    Left = 8
    Top = 177
    Width = 107
    Height = 13
    Caption = #1069#1083#1077#1084#1077#1085#1090#1099' '#1089#1090#1088#1072#1085#1080#1094#1099':'
  end
  object Label11: TLabel
    Left = 20
    Top = 196
    Width = 30
    Height = 13
    Caption = 'iframe'
  end
  object Label13: TLabel
    Left = 68
    Top = 196
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnMouseMove = Label13MouseMove
    OnMouseLeave = Label13MouseLeave
  end
  object Label15: TLabel
    Left = 8
    Top = 106
    Width = 61
    Height = 13
    Caption = #1056#1077#1076#1080#1088#1077#1082#1090#1099':'
  end
  object Label16: TLabel
    Left = 136
    Top = 106
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label16Click
    OnMouseMove = Label16MouseMove
    OnMouseLeave = Label16MouseLeave
  end
  object Label17: TLabel
    Left = 8
    Top = 56
    Width = 92
    Height = 13
    Caption = #1056#1072#1089#1078#1072#1090#1072#1103' '#1089#1089#1099#1083#1082#1072':'
  end
  object Label18: TLabel
    Left = 136
    Top = 56
    Width = 103
    Height = 13
    AutoSize = False
    Caption = '---'
    EllipsisPosition = epWordEllipsis
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = Label18Click
    OnMouseMove = Label18MouseMove
    OnMouseLeave = Label18MouseLeave
  end
  object Label12: TLabel
    Left = 8
    Top = 215
    Width = 134
    Height = 13
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1076#1086#1084#1077#1085' '#1074' Google'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label12Click
    OnMouseMove = Label12MouseMove
    OnMouseLeave = Label12MouseLeave
  end
  object Edit1: TEdit
    Left = 80
    Top = 5
    Width = 133
    Height = 21
    TabOrder = 0
    Text = 'http://'
  end
  object Edit2: TEdit
    Left = 132
    Top = 52
    Width = 107
    Height = 21
    TabOrder = 1
    Visible = False
    OnExit = Edit2Exit
  end
end
