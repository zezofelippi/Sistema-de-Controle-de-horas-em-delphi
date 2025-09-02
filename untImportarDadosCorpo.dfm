object frmImportarDadosCorpo: TfrmImportarDadosCorpo
  Left = 236
  Top = 284
  Width = 559
  Height = 498
  Caption = 'frmImportarDadosCorpo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 88
    Top = 40
    Width = 193
    Height = 25
    Caption = 'Importar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 6
    Top = 77
    Width = 520
    Height = 200
    DataSource = dsCorpo
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBS'
        Width = 350
        Visible = True
      end>
  end
  object edtResultado: TEdit
    Left = 24
    Top = 296
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'edtResultado'
  end
  object mmoDados: TMemo
    Left = 160
    Top = 296
    Width = 361
    Height = 145
    TabOrder = 3
  end
  object qryCorpo: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from corpo')
    Left = 312
    Top = 40
    object qryCorpoDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'CORPO.DATA'
    end
    object qryCorpoOBS: TIBStringField
      FieldName = 'OBS'
      Origin = 'CORPO.OBS'
      Size = 250
    end
  end
  object dsCorpo: TDataSource
    DataSet = qryCorpo
    Left = 360
    Top = 40
  end
  object qryPesqAux: TIBQuery
    Database = frmModulo.BD
    Transaction = frmModulo.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 160
    Top = 144
  end
  object IBTransLocal: TIBTransaction
    Active = False
    DefaultDatabase = frmModulo.BD
    AutoStopAction = saNone
    Left = 448
    Top = 152
  end
  object qry_trans_local: TIBQuery
    Database = frmModulo.BD
    Transaction = IBTransLocal
    BufferChunks = 1000
    CachedUpdates = False
    Left = 488
    Top = 152
  end
end
