object frmReceitas: TfrmReceitas
  Left = 385
  Top = 159
  Width = 871
  Height = 540
  Caption = 'Receitas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 855
    Height = 89
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 16
      Width = 37
      Height = 13
      Caption = 'Receita'
    end
    object edtReceita: TEdit
      Left = 16
      Top = 35
      Width = 473
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object btnListar: TButton
      Left = 496
      Top = 32
      Width = 105
      Height = 25
      Caption = 'Listar'
      TabOrder = 1
      OnClick = btnListarClick
    end
    object btnCadastrarReceita: TButton
      Left = 632
      Top = 32
      Width = 129
      Height = 25
      Caption = 'Cadastrar receita'
      TabOrder = 2
      OnClick = btnCadastrarReceitaClick
    end
  end
  object dbgReceita: TDBGrid
    Left = 0
    Top = 89
    Width = 855
    Height = 412
    Align = alClient
    DataSource = dtsReceita
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgReceitaDblClick
  end
  object dtsReceita: TDataSource
    DataSet = cdsReceita
    Left = 136
    Top = 224
  end
  object cdsReceita: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 224
  end
end
