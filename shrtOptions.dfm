object FOptions: TFOptions
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 294
  ClientWidth = 346
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 346
    Height = 265
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1054#1073#1097#1080#1077
      object Label1: TLabel
        Left = 3
        Top = 3
        Width = 104
        Height = 13
        Caption = #1040#1082#1082#1072#1091#1085#1090' '#1074' Twitter'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 143
        Width = 30
        Height = 13
        Caption = #1051#1086#1075#1080#1085
      end
      object Label3: TLabel
        Left = 120
        Top = 142
        Width = 48
        Height = 13
        Caption = #1050#1083#1102#1095' API'
      end
      object Label4: TLabel
        Left = 20
        Top = 216
        Width = 79
        Height = 13
        Caption = #1056#1072#1079#1084#1077#1088' '#1080#1089#1090#1086#1088#1080#1080
      end
      object Label5: TLabel
        Left = 155
        Top = 216
        Width = 36
        Height = 13
        Caption = #1089#1089#1099#1083#1086#1082
      end
      object Label7: TLabel
        Left = 3
        Top = 49
        Width = 115
        Height = 13
        Caption = #1040#1082#1082#1072#1091#1085#1090' FriendFeed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Button3: TButton
        Left = 116
        Top = 18
        Width = 118
        Height = 25
        Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1076#1086#1089#1090#1091#1087
        TabOrder = 0
        OnClick = Button3Click
      end
      object Button2: TButton
        Left = 3
        Top = 18
        Width = 107
        Height = 25
        Caption = #1040#1074#1090#1086#1088#1080#1079#1086#1074#1072#1090#1100#1089#1103
        TabOrder = 1
        OnClick = Button2Click
      end
      object CheckBox1: TCheckBox
        Left = 3
        Top = 93
        Width = 342
        Height = 17
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1088#1086#1074#1077#1088#1103#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
        TabOrder = 2
      end
      object CheckBox2: TCheckBox
        Left = 3
        Top = 116
        Width = 130
        Height = 17
        Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' bit.ly'
        TabOrder = 3
        OnClick = CheckBox2Click
      end
      object Edit1: TEdit
        Left = 52
        Top = 139
        Width = 58
        Height = 21
        TabOrder = 4
      end
      object Edit2: TEdit
        Left = 174
        Top = 139
        Width = 159
        Height = 21
        TabOrder = 5
      end
      object CheckBox3: TCheckBox
        Left = 3
        Top = 166
        Width = 374
        Height = 17
        Caption = '"'#1059#1084#1085#1099#1081'" '#1087#1086#1080#1089#1082' URL'#39#1086#1074' '#1074' '#1073#1091#1092#1077#1088#1077' '#1086#1073#1084#1077#1085#1072
        TabOrder = 6
      end
      object CheckBox4: TCheckBox
        Left = 3
        Top = 189
        Width = 366
        Height = 17
        Caption = #1047#1072#1087#1086#1084#1080#1085#1072#1090#1100' '#1080#1089#1090#1086#1088#1080#1102' '#1089#1078#1072#1090#1080#1103' '#1089#1089#1099#1083#1086#1082
        TabOrder = 7
      end
      object Edit3: TEdit
        Left = 105
        Top = 212
        Width = 28
        Height = 21
        TabOrder = 8
        Text = '1'
      end
      object UpDown1: TUpDown
        Left = 133
        Top = 212
        Width = 16
        Height = 21
        Associate = Edit3
        Min = 1
        Position = 1
        TabOrder = 9
      end
      object Button4: TButton
        Left = 116
        Top = 62
        Width = 118
        Height = 25
        Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1076#1086#1089#1090#1091#1087
        TabOrder = 10
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 3
        Top = 62
        Width = 107
        Height = 25
        Caption = #1040#1074#1090#1086#1088#1080#1079#1086#1074#1072#1090#1100#1089#1103
        TabOrder = 11
        OnClick = Button5Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1048#1085#1090#1077#1088#1092#1077#1089
      ImageIndex = 1
      object Label6: TLabel
        Left = 3
        Top = 26
        Width = 278
        Height = 13
        Caption = #1050#1085#1086#1087#1082#1072' "'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1089#1089#1099#1083#1082#1091'" '#1079#1072#1085#1086#1089#1080#1090' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072':'
      end
      object CheckBox5: TCheckBox
        Left = 3
        Top = 3
        Width = 306
        Height = 17
        Caption = #1055#1088#1080' '#1074#1099#1093#1086#1076#1077' '#1079#1072#1087#1086#1084#1080#1085#1072#1090#1100' '#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1080' '#1088#1072#1079#1084#1077#1088' '#1086#1082#1085#1072
        TabOrder = 0
      end
      object ComboBox1: TComboBox
        Left = 3
        Top = 45
        Width = 192
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = #1050#1086#1088#1086#1090#1082#1091#1102' '#1089#1089#1099#1083#1082#1091
        Items.Strings = (
          #1050#1086#1088#1086#1090#1082#1091#1102' '#1089#1089#1099#1083#1082#1091
          'BB-'#1082#1086#1076' '#1076#1083#1103' '#1092#1086#1088#1091#1084#1072' ('#1089' '#1072#1085#1082#1086#1088#1086#1084')'
          'BB-'#1082#1086#1076' '#1076#1083#1103' '#1092#1086#1088#1091#1084#1072' ('#1073#1077#1079' '#1072#1085#1082#1086#1088#1072')'
          'HTML-'#1082#1086#1076' '#1076#1083#1103' '#1089#1072#1081#1090#1072)
      end
    end
  end
  object Button1: TButton
    Left = 124
    Top = 267
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
end
