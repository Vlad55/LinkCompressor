object ContactForm: TContactForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = #1057#1087#1080#1089#1086#1082' '#1082#1086#1087#1080#1088#1091#1077#1084#1099#1093' '#1082#1086#1076#1086#1074
  ClientHeight = 158
  ClientWidth = 285
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
    Left = 24
    Top = 59
    Width = 31
    Height = 13
    Caption = #1040#1085#1082#1086#1088
  end
  object Label2: TLabel
    Left = 24
    Top = 106
    Width = 31
    Height = 13
    Caption = #1040#1085#1082#1086#1088
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 8
    Width = 265
    Height = 17
    Caption = #1050#1086#1076' '#1076#1083#1103' '#1092#1086#1088#1091#1084#1072' ('#1073#1077#1079' '#1072#1085#1082#1086#1088#1072')'
    TabOrder = 0
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 31
    Width = 265
    Height = 17
    Caption = #1050#1086#1076' '#1076#1083#1103' '#1092#1086#1088#1091#1084#1072' ('#1089' '#1072#1085#1082#1086#1088#1086#1084')'
    TabOrder = 1
    OnClick = CheckBox2Click
  end
  object CheckBox3: TCheckBox
    Left = 12
    Top = 78
    Width = 265
    Height = 17
    Caption = 'HTML-'#1082#1086#1076' '#1076#1083#1103' '#1089#1072#1081#1090#1072
    TabOrder = 2
    OnClick = CheckBox3Click
  end
  object Edit1: TEdit
    Left = 61
    Top = 55
    Width = 216
    Height = 21
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 61
    Top = 102
    Width = 216
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 69
    Top = 129
    Width = 137
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 5
    OnClick = Button1Click
  end
end
