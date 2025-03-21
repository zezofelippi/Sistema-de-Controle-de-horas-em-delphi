object frmCadAtividade: TfrmCadAtividade
  Left = 256
  Top = 125
  Width = 1066
  Height = 578
  Caption = 'Cadastro de Atividades'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1050
    Height = 168
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 17
      Width = 67
      Height = 16
      Caption = 'Atividade'
    end
    object Label2: TLabel
      Left = 18
      Top = 71
      Width = 124
      Height = 16
      Caption = 'OBS da Atividade'
    end
    object edtAtividade: TEdit
      Left = 15
      Top = 33
      Width = 479
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object rdgTipo: TRadioGroup
      Left = 15
      Top = 113
      Width = 614
      Height = 48
      Columns = 3
      Items.Strings = (
        'Atividades em Geral(A)'
        'Estudo(E)'
        'Redes Sociais(R)')
      TabOrder = 1
    end
    object Button1: TButton
      Left = 648
      Top = 118
      Width = 153
      Height = 41
      Caption = 'Salvar'
      TabOrder = 2
      OnClick = Button1Click
    end
    object edtObs: TEdit
      Left = 16
      Top = 91
      Width = 673
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtAtiCodigo: TEdit
      Left = 688
      Top = 32
      Width = 121
      Height = 24
      TabOrder = 4
      Text = 'edtAtiCodigo'
      Visible = False
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 273
    Width = 1050
    Height = 266
    Align = alClient
    DataSource = dsPesquisar
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ATI_DESCRICAO'
        Title.Caption = 'Atividade'
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATI_OBS'
        Title.Caption = 'OBS'
        Width = 450
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATI_TIPO'
        Title.Caption = 'Tipo'
        Width = 180
        Visible = True
      end>
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 168
    Width = 1050
    Height = 105
    Align = alTop
    Caption = 'Pesquisar'
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 17
      Width = 67
      Height = 16
      Caption = 'Atividade'
    end
    object edtAtividadePesquisa: TEdit
      Left = 15
      Top = 33
      Width = 479
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object rdgTipoPesquisa: TRadioGroup
      Left = 17
      Top = 55
      Width = 614
      Height = 48
      Columns = 3
      Items.Strings = (
        'Atividades em Geral(A)'
        'Estudo(E)'
        'Redes Sociais(R)')
      TabOrder = 1
    end
    object Button2: TButton
      Left = 648
      Top = 55
      Width = 155
      Height = 42
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object dsPesquisar: TDataSource
    DataSet = qryPesquisa
    Left = 416
    Top = 360
  end
  object qryPesquisa: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM CAD_ATIVIDADES')
    Left = 472
    Top = 360
    object qryPesquisaATI_CODIGO: TIntegerField
      FieldName = 'ATI_CODIGO'
      Origin = 'CAD_ATIVIDADES.ATI_CODIGO'
      Required = True
    end
    object qryPesquisaATI_DESCRICAO: TIBStringField
      FieldName = 'ATI_DESCRICAO'
      Origin = 'CAD_ATIVIDADES.ATI_DESCRICAO'
      Size = 100
    end
    object qryPesquisaATI_OBS: TIBStringField
      FieldName = 'ATI_OBS'
      Origin = 'CAD_ATIVIDADES.ATI_OBS'
      Size = 200
    end
    object qryPesquisaATI_TIPO: TIBStringField
      FieldName = 'ATI_TIPO'
      Origin = 'CAD_ATIVIDADES.ATI_TIPO'
      FixedChar = True
      Size = 1
    end
  end
  object qry_trans_local: TIBQuery
    Database = frmModulo.BD
    Transaction = IBTransLocal
    BufferChunks = 1000
    CachedUpdates = False
    Left = 848
    Top = 104
  end
  object IBTransLocal: TIBTransaction
    Active = False
    DefaultDatabase = frmModulo.BD
    AutoStopAction = saNone
    Left = 800
    Top = 104
  end
end
