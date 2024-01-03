object FormHTMarchHuntek6022BE: TFormHTMarchHuntek6022BE
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'FormHTMarchHuntek6022BE'
  ClientHeight = 598
  ClientWidth = 1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object img1: TPaintBox
    Left = 0
    Top = 0
    Width = 1074
    Height = 353
    Align = alClient
    ExplicitWidth = 1438
    ExplicitHeight = 113
  end
  object stat1: TStatusBar
    Left = 0
    Top = 579
    Width = 1074
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end>
    ExplicitTop = 578
    ExplicitWidth = 1070
  end
  object pnl1: TPanel
    Left = 0
    Top = 353
    Width = 1074
    Height = 226
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 352
    ExplicitWidth = 1070
    object chk1Active: TCheckBox
      Left = 553
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Active'
      TabOrder = 0
      OnClick = chk1ActiveClick
    end
    object lstm_nCH1VoltDIV: TListBox
      Left = 385
      Top = 23
      Width = 144
      Height = 182
      ItemHeight = 15
      Items.Strings = (
        '0 20mV/DIV'
        '1 50mV/DIV'
        '2 100mV/DIV'
        '3 200mV/DIV'
        '4 500mV/DIV'
        '5 1V/DIV'
        '6 2V/DIV'
        '7 5V/DIV')
      TabOrder = 1
    end
    object lstm_nTimeDIV: TListBox
      Left = 18
      Top = 10
      Width = 361
      Height = 195
      Columns = 3
      ItemHeight = 15
      Items.Strings = (
        ' 0 ~ 10 : 48MSa/s'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11 16MSa/s'
        '12 8MSa/s'
        '13 4MSa/s'
        '14 ~ 24: 1MSa/s'
        '15'
        '16'
        '17'
        '18'
        '19'
        '25 500KSa/s'
        '26 200KSa/s'
        '27 100KSa')
      TabOrder = 2
    end
    object grp1: TGroupBox
      Left = 535
      Top = 123
      Width = 129
      Height = 74
      Caption = 'Read x 1000 points'
      TabOrder = 3
      object se1: TSpinEdit
        Left = 18
        Top = 25
        Width = 71
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 10
      end
    end
    object grpTrigger: TGroupBox
      Left = 690
      Top = 4
      Width = 359
      Height = 201
      Caption = 'Trigger'
      TabOrder = 4
      object rgSlope: TRadioGroup
        Left = 240
        Top = 23
        Width = 97
        Height = 70
        Caption = 'Slope'
        ItemIndex = 0
        Items.Strings = (
          'Rise '
          'Fall')
        TabOrder = 0
      end
      object rgSweep: TRadioGroup
        Left = 18
        Top = 24
        Width = 113
        Height = 81
        Caption = 'Sweep'
        ItemIndex = 0
        Items.Strings = (
          'AUTO'
          'NORMAL'
          'SINGLE')
        TabOrder = 1
      end
      object rgSource: TRadioGroup
        Left = 250
        Top = 99
        Width = 97
        Height = 70
        Caption = 'Source'
        ItemIndex = 0
        Items.Strings = (
          'CH1'
          'CH2')
        TabOrder = 2
      end
      object chkShiftTrigger: TCheckBox
        Left = 147
        Top = 143
        Width = 97
        Height = 17
        Caption = 'Shift Trigger'
        TabOrder = 3
      end
      object GroupBoxLevel: TGroupBox
        Left = 145
        Top = 55
        Width = 89
        Height = 65
        Caption = 'Level'
        TabOrder = 4
        object lbledtLevel: TSpinEdit
          Left = 6
          Top = 24
          Width = 67
          Height = 25
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
      end
      object grpHoriz: TGroupBox
        Left = 16
        Top = 111
        Width = 113
        Height = 73
        Caption = 'Horiz'
        TabOrder = 5
        object lbledtHTrigPos: TSpinEdit
          Left = 3
          Top = 25
          Width = 96
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
      end
    end
    object rgCH1: TRadioGroup
      Left = 544
      Top = 39
      Width = 50
      Height = 70
      Caption = 'CH1'
      ItemIndex = 0
      Items.Strings = (
        'Y'
        'X')
      TabOrder = 5
    end
    object rgCH2: TRadioGroup
      Left = 600
      Top = 39
      Width = 50
      Height = 70
      Caption = 'CH2'
      ItemIndex = 0
      Items.Strings = (
        'Y'
        'X')
      TabOrder = 6
    end
  end
end
