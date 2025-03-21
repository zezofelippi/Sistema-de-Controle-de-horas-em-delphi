object frmExcelParaBancoDados: TfrmExcelParaBancoDados
  Left = 703
  Top = 155
  Width = 609
  Height = 178
  Caption = 'Excel para banco de dados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtCaminhoExcel: TEdit
    Left = 23
    Top = 50
    Width = 417
    Height = 21
    Color = 14803425
    ReadOnly = True
    TabOrder = 0
  end
  object Button2: TButton
    Left = 444
    Top = 45
    Width = 105
    Height = 25
    Caption = 'Abrir arquivo...'
    TabOrder = 1
    OnClick = Button2Click
  end
  object IBTransLocal: TIBTransaction
    Active = False
    DefaultDatabase = frmModulo.BD
    AutoStopAction = saNone
    Left = 256
    Top = 80
  end
  object qryTransLocal: TIBQuery
    Database = frmModulo.BD
    Transaction = IBTransLocal
    BufferChunks = 1000
    CachedUpdates = False
    Left = 296
    Top = 80
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Excel Arquivo|*.xls'
    Left = 140
    Top = 88
  end
end
