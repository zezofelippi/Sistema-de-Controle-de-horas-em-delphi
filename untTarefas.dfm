object frmTarefas: TfrmTarefas
  Left = 625
  Top = 220
  Width = 668
  Height = 573
  Caption = 'Tarefas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
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
  object Label3: TLabel
    Left = 13
    Top = 68
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
  object edtObs: TEdit
    Left = 13
    Top = 87
    Width = 628
    Height = 28
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
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
  object GroupBox1: TGroupBox
    Left = 15
    Top = 121
    Width = 626
    Height = 126
    Caption = 'Pesquisar'
    TabOrder = 3
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
    object rdgOpcao: TRadioGroup
      Left = 248
      Top = 82
      Width = 297
      Height = 41
      Columns = 3
      Items.Strings = (
        'Abertos'
        'Finalizados'
        'Todos')
      TabOrder = 4
    end
  end
  object DBGrid1: TDBGrid
    Left = 13
    Top = 248
    Width = 627
    Height = 279
    DataSource = dtsTarefa
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    PopupMenu = PopupMenu1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_TAREFA'
        Title.Alignment = taCenter
        Title.Caption = 'ID'
        Title.Color = clNavy
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 30
        Visible = True
      end
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
        Width = 70
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
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_FINALIZADO'
        Title.Alignment = taCenter
        Title.Caption = 'DATA FIM'
        Title.Color = clNavy
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 70
        Visible = True
      end>
  end
  object edtIdTarefa: TEdit
    Left = 192
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 5
    Visible = False
  end
  object IBTransLocal: TIBTransaction
    Active = False
    DefaultDatabase = frmModulo.BD
    AutoStopAction = saNone
    Left = 312
    Top = 40
  end
  object qry_trans_local: TIBQuery
    Database = frmModulo.BD
    Transaction = IBTransLocal
    BufferChunks = 1000
    CachedUpdates = False
    Left = 360
    Top = 40
  end
  object PopupMenu1: TPopupMenu
    Left = 240
    Top = 280
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      OnClick = Alterar1Click
    end
    object Finalizar1: TMenuItem
      Caption = 'Finalizar'
      OnClick = Finalizar1Click
    end
  end
  object dtsTarefa: TDataSource
    DataSet = qryTarefa
    Left = 432
    Top = 368
  end
  object qryTarefa: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from tarefas')
    Left = 488
    Top = 368
    object qryTarefaID_TAREFA: TIntegerField
      FieldName = 'ID_TAREFA'
      Origin = 'TAREFAS.ID_TAREFA'
      Required = True
    end
    object qryTarefaDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'TAREFAS.DATA'
    end
    object qryTarefaOBS: TIBStringField
      FieldName = 'OBS'
      Origin = 'TAREFAS.OBS'
      Size = 250
    end
    object qryTarefaDATA_FINALIZADO: TDateTimeField
      FieldName = 'DATA_FINALIZADO'
      Origin = 'TAREFAS.DATA_FINALIZADO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qryTarefaOPCAO: TIBStringField
      FieldName = 'OPCAO'
      Origin = 'TAREFAS.OPCAO'
      FixedChar = True
      Size = 1
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
