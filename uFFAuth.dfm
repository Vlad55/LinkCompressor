object ffauthform: Tffauthform
  Left = 0
  Top = 0
  Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1074' FriendFeed'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 35
    Align = alTop
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 513
      Height = 13
      Caption = 
        #1040#1074#1090#1086#1088#1080#1079#1091#1081#1090#1077#1089#1100' '#1074' '#1089#1077#1088#1074#1080#1089#1077', '#1074#1074#1077#1076#1080#1090#1077' '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1083#1086#1075#1080#1085#1072' '#1080' '#1091#1076 +
        #1072#1083#1077#1085#1085#1086#1075#1086' '#1082#1083#1102#1095#1072' '#1074' '#1087#1086#1083#1103' '#1092#1086#1088#1084#1099
    end
    object Label2: TLabel
      Left = 164
      Top = 19
      Width = 173
      Height = 13
      Caption = #1080' '#1079#1072#1082#1086#1085#1095#1080#1090#1077' '#1087#1088#1086#1094#1077#1089#1089' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 35
    Width = 526
    Height = 253
    Align = alClient
    TabOrder = 1
    ExplicitTop = 41
    ExplicitHeight = 232
    ControlData = {
      4C0000005D360000261A00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel2: TPanel
    Left = 0
    Top = 288
    Width = 526
    Height = 34
    Align = alBottom
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 12
      Width = 30
      Height = 13
      Caption = #1051#1086#1075#1080#1085
    end
    object Label4: TLabel
      Left = 123
      Top = 12
      Width = 88
      Height = 13
      Caption = #1059#1076#1072#1083#1077#1085#1085#1099#1081' '#1082#1083#1102#1095
    end
    object Edit1: TEdit
      Left = 44
      Top = 8
      Width = 73
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 217
      Top = 8
      Width = 88
      Height = 21
      TabOrder = 1
    end
    object Button1: TButton
      Left = 328
      Top = 6
      Width = 193
      Height = 25
      Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1087#1088#1086#1094#1077#1089#1089' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
