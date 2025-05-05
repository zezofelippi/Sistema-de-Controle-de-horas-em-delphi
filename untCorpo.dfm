object frmCorpo: TfrmCorpo
  Left = 433
  Top = 195
  Width = 447
  Height = 508
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
  object Button1: TButton
    Left = 216
    Top = 31
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
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 72
    Width = 417
    Height = 385
    DataSource = dtsCorpo
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
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
      end>
  end
  object dtsCorpo: TDataSource
    DataSet = qryCorpo
    Left = 152
    Top = 144
  end
  object qryCorpo: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from corpo')
    Left = 208
    Top = 144
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
  end
  object IBTransLocal: TIBTransaction
    Active = False
    DefaultDatabase = frmModulo.BD
    AutoStopAction = saNone
    Left = 336
    Top = 32
  end
  object qry_trans_local: TIBQuery
    Database = frmModulo.BD
    Transaction = IBTransLocal
    BufferChunks = 1000
    CachedUpdates = False
    Left = 376
    Top = 32
  end
end
