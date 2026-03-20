object frmMenu: TfrmMenu
  Left = 290
  Top = 144
  Width = 1044
  Height = 540
  Caption = 'Menu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 144
    Top = 72
    object ControleHoras1: TMenuItem
      Caption = 'Controle Horas'
      object CadastrodeAtividades1: TMenuItem
        Caption = 'Cadastro de Atividades'
        OnClick = CadastrodeAtividades1Click
      end
      object MovimentaodeHoras1: TMenuItem
        Caption = 'Movimenta'#231#227'o de Horas'
        OnClick = MovimentaodeHoras1Click
      end
      object Corpo1: TMenuItem
        Caption = 'Corpo'
        OnClick = Corpo1Click
      end
      object arefas1: TMenuItem
        Caption = 'Tarefas'
        OnClick = arefas1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Receitas1: TMenuItem
        Caption = 'Receitas'
        OnClick = Receitas1Click
      end
    end
    object Importardoexcel1: TMenuItem
      Caption = 'Configura'#231#245'es'
      object ImportarExcel1: TMenuItem
        Caption = 'Importar Excel'
        OnClick = ImportarExcel1Click
      end
      object Importardadoscorpo1: TMenuItem
        Caption = 'Importar dados corpo'
        OnClick = Importardadoscorpo1Click
      end
    end
  end
end
