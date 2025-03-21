unit untMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TfrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    ControleHoras1: TMenuItem;
    MovimentaodeHoras1: TMenuItem;
    CadastrodeAtividades1: TMenuItem;
    Importardoexcel1: TMenuItem;
    procedure MovimentaodeHoras1Click(Sender: TObject);
    procedure CadastrodeAtividades1Click(Sender: TObject);
    procedure Importardoexcel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses untMovimentacaoHoras, untCadAtividade, untExcelParaBancoDados;

{$R *.dfm}

procedure TfrmMenu.MovimentaodeHoras1Click(Sender: TObject);
begin
Application.CreateForm(TfrmMovimentacaoHoras, frmMovimentacaoHoras);
frmMovimentacaoHoras.show;
end;

procedure TfrmMenu.CadastrodeAtividades1Click(Sender: TObject);
begin
Application.CreateForm(TfrmCadAtividade, frmCadAtividade);
frmCadAtividade.show;
end;

procedure TfrmMenu.Importardoexcel1Click(Sender: TObject);
begin
Application.CreateForm(TfrmExcelParaBancoDados, frmExcelParaBancoDados);
frmExcelParaBancoDados.show;
end;

end.
