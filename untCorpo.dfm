object frmCorpo: TfrmCorpo
  Left = 442
  Top = 162
  Width = 654
  Height = 640
  Caption = 'Corpo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 15
    Top = 12
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
  object lbl3: TLabel
    Left = 130
    Top = 8
    Width = 36
    Height = 20
    Caption = 'Peso'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 210
    Top = 8
    Width = 102
    Height = 20
    Caption = 'Cintura em cm'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 12
    Top = 64
    Width = 418
    Height = 16
    Caption = 'Cintura medida de manha em jejum 1 dedo acima do umbigo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 85
    Width = 34
    Height = 20
    Caption = 'OBS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 18
    Top = 530
    Width = 187
    Height = 16
    Caption = 'Qtde de Dias Pesquisados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 221
    Top = 532
    Width = 223
    Height = 16
    Caption = 'Intervalo de Datas Pesquisadas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtData: TDateEdit
    Left = 13
    Top = 32
    Width = 111
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
  end
  object edtPeso: TCurrencyEdit
    Left = 130
    Top = 31
    Width = 74
    Height = 28
    AutoSize = False
    DecimalPlaces = 3
    DisplayFormat = '###,##0.000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object btnGravar: TButton
    Left = 511
    Top = 50
    Width = 94
    Height = 28
    Caption = 'Gravar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnGravarClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 234
    Width = 609
    Height = 282
    DataSource = dtsCorpo
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    PopupMenu = PopupMenu1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Alignment = taCenter
        Title.Color = clNavy
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PESO'
        Title.Alignment = taCenter
        Title.Color = clNavy
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CINTURA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Color = clNavy
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBS'
        Title.Color = clNavy
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 350
        Visible = True
      end>
  end
  object edtCintura: TCurrencyEdit
    Left = 236
    Top = 29
    Width = 74
    Height = 28
    AutoSize = False
    DecimalPlaces = 1
    DisplayFormat = '#0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtObs: TEdit
    Left = 16
    Top = 104
    Width = 601
    Height = 28
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 136
    Width = 601
    Height = 91
    Caption = 'Pesquisar'
    TabOrder = 6
    object Label5: TLabel
      Left = 6
      Top = 35
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
    object Label6: TLabel
      Left = 122
      Top = 35
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
    object Label7: TLabel
      Left = 245
      Top = 32
      Width = 34
      Height = 20
      Caption = 'OBS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDataInicial: TDateEdit
      Left = 5
      Top = 57
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
    end
    object edtDataFinal: TDateEdit
      Left = 122
      Top = 56
      Width = 111
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
    object edtObsPesquisa: TEdit
      Left = 242
      Top = 55
      Width = 351
      Height = 28
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object btnPesquisar: TButton
      Left = 492
      Top = 18
      Width = 94
      Height = 28
      Caption = 'Pesquisar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnPesquisarClick
    end
  end
  object edtDias: TEdit
    Left = 16
    Top = 553
    Width = 185
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    Text = 'edtDias'
  end
  object edtIntervaloDatas: TEdit
    Left = 221
    Top = 552
    Width = 224
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    Text = 'edtIntervaloDatas'
  end
  object edtIdCorpo: TEdit
    Left = 376
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 9
    Text = 'edtIdCorpo'
    Visible = False
  end
  object dtsCorpo: TDataSource
    DataSet = qryCorpo
    Left = 432
    Top = 368
  end
  object qryCorpo: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from corpo')
    Left = 488
    Top = 368
    object qryCorpoID_CORPO: TIntegerField
      FieldName = 'ID_CORPO'
      Origin = 'CORPO.ID_CORPO'
      Required = True
    end
    object qryCorpoPESO: TIBBCDField
      FieldName = 'PESO'
      Origin = 'CORPO.PESO'
      DisplayFormat = '###,##0.000'
      Precision = 4
      Size = 3
    end
    object qryCorpoDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'CORPO.DATA'
    end
    object qryCorpoCINTURA: TIntegerField
      FieldName = 'CINTURA'
      Origin = 'CORPO.CINTURA'
    end
    object qryCorpoOBS: TIBStringField
      FieldName = 'OBS'
      Origin = 'CORPO.OBS'
      Size = 250
    end
  end
  object IBTransLocal: TIBTransaction
    Active = False
    DefaultDatabase = frmModulo.BD
    AutoStopAction = saNone
    Left = 336
    Top = 80
  end
  object qry_trans_local: TIBQuery
    Database = frmModulo.BD
    Transaction = IBTransLocal
    BufferChunks = 1000
    CachedUpdates = False
    Left = 368
    Top = 72
  end
  object PopupMenu1: TPopupMenu
    Left = 240
    Top = 280
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      OnClick = Alterar1Click
    end
  end
  object qryPesquisa: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 440
    Top = 272
  end
end
