object frmCadastrarReceita: TfrmCadastrarReceita
  Left = 239
  Top = 125
  Width = 668
  Height = 610
  Caption = 'Cadastrar Receita'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 102
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 78
      Height = 13
      Caption = 'T'#237'tulo da receita'
    end
    object edtTituloReceita: TEdit
      Left = 24
      Top = 34
      Width = 433
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object btnSalvar: TButton
      Left = 474
      Top = 6
      Width = 94
      Height = 25
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 474
      Top = 32
      Width = 94
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnConcluirReceita: TButton
      Left = 475
      Top = 60
      Width = 93
      Height = 25
      Caption = 'Concluir receita'
      TabOrder = 3
      OnClick = btnConcluirReceitaClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 304
    Width = 652
    Height = 267
    Align = alBottom
    TabOrder = 1
    object Label2: TLabel
      Left = 207
      Top = 6
      Width = 163
      Height = 24
      Caption = 'Modo de preparo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mmPreparo: TMemo
      Left = 1
      Top = 34
      Width = 650
      Height = 232
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyPress = mmPreparoKeyPress
    end
    object btnSalvarPreparo: TButton
      Left = 459
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = btnSalvarPreparoClick
    end
  end
  object dbgItensReceita: TDBGrid
    Left = 0
    Top = 161
    Width = 652
    Height = 138
    Align = alTop
    DataSource = dtsItensReceita
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    PopupMenu = popMenu
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel3: TPanel
    Left = 0
    Top = 102
    Width = 652
    Height = 59
    Align = alTop
    TabOrder = 3
    object Label3: TLabel
      Left = 28
      Top = 14
      Width = 58
      Height = 13
      Caption = 'Ingredientes'
    end
    object edtIngredientes: TEdit
      Left = 25
      Top = 32
      Width = 433
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object btnAdicionar: TButton
      Left = 464
      Top = 27
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 1
      OnClick = btnAdicionarClick
    end
    object btnCancelarIngrediente: TButton
      Left = 546
      Top = 26
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarIngredienteClick
    end
  end
  object dtsItensReceita: TDataSource
    DataSet = cdsItensReceita
    Left = 200
    Top = 216
  end
  object cdsItensReceita: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 216
  end
  object popMenu: TPopupMenu
    Left = 80
    Top = 224
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      OnClick = Alterar1Click
    end
  end
end
