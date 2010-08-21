object AuthForm: TAuthForm
  Left = 0
  Top = 0
  Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1074' Twitter '
  ClientHeight = 322
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 526
      Height = 33
      Align = alClient
      Alignment = taCenter
      Caption = 
        #1042#1074#1077#1076#1080#1090#1077' '#1089#1074#1086#1081' '#1083#1086#1075#1080#1085' '#1080' '#1087#1072#1088#1086#1083#1100' '#1082' Twitter-'#1072#1082#1082#1072#1091#1085#1090#1091', '#13#10#1085#1072#1078#1084#1080#1090#1077' "Allow' +
        '" '#1080' '#1089#1082#1086#1087#1080#1088#1091#1081#1090#1077' '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1081' PIN-'#1082#1086#1076' '#1074' '#1087#1086#1083#1077' "PIN" '
      ExplicitWidth = 326
      ExplicitHeight = 26
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 292
    Width = 526
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 12
      Top = 8
      Width = 17
      Height = 13
      Caption = 'PIN'
    end
    object Edit1: TEdit
      Left = 35
      Top = 4
      Width = 74
      Height = 21
      TabOrder = 0
      OnChange = Edit1Change
    end
    object CheckBox1: TCheckBox
      Left = 115
      Top = 6
      Width = 210
      Height = 17
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1084#1077#1085#1103' '#1085#1072' '#1101#1090#1086#1084' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1077
      TabOrder = 1
    end
    object Button1: TButton
      Left = 331
      Top = 2
      Width = 193
      Height = 25
      Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1087#1088#1086#1094#1077#1089#1089' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
      Enabled = False
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 33
    Width = 526
    Height = 259
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 40
    ExplicitTop = 76
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C0000005D360000C51A00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
