object frmMovimentacaoHoras: TfrmMovimentacaoHoras
  Left = 269
  Top = 211
  BorderStyle = bsSingle
  Caption = 'Movimenta'#231#227'o de Horas'
  ClientHeight = 501
  ClientWidth = 1132
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 59
    Width = 1132
    Height = 122
    Align = alTop
    TabOrder = 0
    object Label4: TLabel
      Left = 9
      Top = 11
      Width = 35
      Height = 20
      Caption = 'Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 215
      Top = 9
      Width = 65
      Height = 20
      Caption = 'Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 124
      Top = 7
      Width = 49
      Height = 20
      Caption = 'Tempo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 63
      Width = 38
      Height = 20
      Caption = 'OBS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 765
      Top = 7
      Width = 56
      Height = 20
      Caption = 'Acordar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtData: TDateEdit
      Left = 7
      Top = 31
      Width = 112
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtDataKeyPress
    end
    object cboAtividade: TDBLookupComboBox
      Left = 212
      Top = 28
      Width = 504
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'ATI_CODIGO'
      ListField = 'ATIVIDADE'
      ListSource = dsAtividade
      ParentFont = False
      TabOrder = 1
      OnExit = cboAtividadeExit
      OnKeyPress = cboAtividadeKeyPress
    end
    object edtTempo: TMaskEdit
      Left = 126
      Top = 30
      Width = 77
      Height = 28
      EditMask = '!90:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  :  '
      OnKeyPress = edtTempoKeyPress
    end
    object edtObs: TEdit
      Left = 6
      Top = 85
      Width = 889
      Height = 28
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtObsKeyPress
    end
    object btnSalvar: TButton
      Left = 905
      Top = 80
      Width = 100
      Height = 31
      Caption = 'Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnSalvarClick
    end
    object edtIdMovimentacaoHora: TEdit
      Left = 576
      Top = 64
      Width = 121
      Height = 21
      TabOrder = 5
      Text = 'edtIdMovimentacaoHora'
      Visible = False
    end
    object edtAcordar: TMaskEdit
      Left = 765
      Top = 25
      Width = 77
      Height = 28
      EditMask = '!90:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 6
      Text = '  :  '
      OnKeyPress = edtTempoKeyPress
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 246
    Width = 1132
    Height = 192
    Align = alClient
    DataSource = dsGrid
    FixedColor = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindow
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 181
    Width = 1132
    Height = 65
    Align = alTop
    TabOrder = 2
    object lbl1: TLabel
      Left = 8
      Top = 8
      Width = 79
      Height = 20
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 135
      Top = 8
      Width = 73
      Height = 20
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 700
      Top = 26
      Width = 76
      Height = 26
      AutoSize = False
      Color = clAqua
      ParentColor = False
    end
    object Label6: TLabel
      Left = 780
      Top = 34
      Width = 347
      Height = 16
      Caption = 'Atividades com suas respectivas OBSERVA'#199#213'ES'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 268
      Top = 8
      Width = 38
      Height = 20
      Caption = 'OBS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object txt_data_i: TDateEdit
      Left = 9
      Top = 29
      Width = 121
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
    end
    object txt_data_f: TDateEdit
      Left = 134
      Top = 28
      Width = 128
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
    object btnPesquisar: TButton
      Left = 584
      Top = 25
      Width = 108
      Height = 31
      Caption = 'Pesquisar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnPesquisarClick
    end
    object edtObsPesquisa: TEdit
      Left = 267
      Top = 27
      Width = 312
      Height = 28
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtObsKeyPress
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 0
    Width = 1132
    Height = 59
    Align = alTop
    TabOrder = 3
    object rdgTipoPesquisa: TRadioGroup
      Left = 7
      Top = 6
      Width = 614
      Height = 48
      Columns = 4
      Items.Strings = (
        'Atividades em Geral(A)'
        'Estudo(E)'
        'Redes Sociais(R)'
        'Todos')
      TabOrder = 0
      OnClick = rdgTipoPesquisaClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 438
    Width = 1132
    Height = 63
    Align = alBottom
    TabOrder = 4
    object edtDias: TEdit
      Left = 24
      Top = 24
      Width = 641
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edtDias'
    end
  end
  object dsAtividade: TDataSource
    DataSet = qryAtividade
    Left = 472
    Top = 72
  end
  object qryAtividade: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT ATI_DESCRICAO AS ATIVIDADE, ATI_CODIGO'
      'FROM CAD_ATIVIDADES')
    Left = 520
    Top = 72
    object qryAtividadeATI_CODIGO: TIntegerField
      FieldName = 'ATI_CODIGO'
      Origin = 'CAD_ATIVIDADES.ATI_CODIGO'
      Required = True
    end
    object qryAtividadeATIVIDADE: TIBStringField
      FieldName = 'ATIVIDADE'
      Origin = 'CAD_ATIVIDADES.ATI_DESCRICAO'
      Size = 100
    end
  end
  object IBTransLocal: TIBTransaction
    Active = False
    DefaultDatabase = frmModulo.BD
    AutoStopAction = saNone
    Left = 728
    Top = 128
  end
  object qry_trans_local: TIBQuery
    Database = frmModulo.BD
    Transaction = IBTransLocal
    BufferChunks = 1000
    CachedUpdates = False
    Left = 768
    Top = 128
  end
  object cdsGrid: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 504
    Top = 248
  end
  object dsGrid: TDataSource
    DataSet = cdsGrid
    Left = 464
    Top = 248
  end
  object qryPesquisa: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 600
    Top = 248
  end
  object qryPesqAux: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 672
    Top = 240
  end
  object PopupMenu1: TPopupMenu
    Left = 264
    Top = 232
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      OnClick = Alterar1Click
    end
  end
end
