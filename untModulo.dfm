object frmModulo: TfrmModulo
  OldCreateOrder = False
  Left = 298
  Top = 125
  Height = 343
  Width = 292
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = BD
    Params.Strings = (
      'read_committed'
      'rec_version')
    AutoStopAction = saNone
    Left = 152
    Top = 8
  end
  object BD: TIBDatabase
    DatabaseName = 
      '127.0.0.1:D:\Sistema de Horas Delphi\Base dados\BASE_DADOS_HORAS' +
      '.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 81
    Top = 8
  end
end
