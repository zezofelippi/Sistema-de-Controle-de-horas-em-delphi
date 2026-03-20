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
    Corpo1: TMenuItem;
    ImportarExcel1: TMenuItem;
    Importardadoscorpo1: TMenuItem;
    arefas1: TMenuItem;
    N1: TMenuItem;
    Receitas1: TMenuItem;
    procedure MovimentaodeHoras1Click(Sender: TObject);
    procedure CadastrodeAtividades1Click(Sender: TObject);
    procedure Corpo1Click(Sender: TObject);
    procedure ImportarExcel1Click(Sender: TObject);
    procedure Importardadoscorpo1Click(Sender: TObject);
    procedure arefas1Click(Sender: TObject);
    procedure Receitas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses untMovimentacaoHoras, untCadAtividade, untExcelParaBancoDados,
  untCorpo, untImportarDadosCorpo, untTarefas, untReceitas;

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

procedure TfrmMenu.Corpo1Click(Sender: TObject);
begin
Application.CreateForm(TfrmCorpo, frmCorpo);
frmCorpo.show;
end;

procedure TfrmMenu.ImportarExcel1Click(Sender: TObject);
begin
Application.CreateForm(TfrmExcelParaBancoDados, frmExcelParaBancoDados);
frmExcelParaBancoDados.show;
end;

procedure TfrmMenu.Importardadoscorpo1Click(Sender: TObject);
begin
Application.CreateForm(TfrmImportarDadosCorpo, frmImportarDadosCorpo);
frmImportarDadosCorpo.show;
end;

procedure TfrmMenu.arefas1Click(Sender: TObject);
begin
Application.CreateForm(TfrmTarefas, frmTarefas);
frmTarefas.show;
end;

procedure TfrmMenu.Receitas1Click(Sender: TObject);
begin
Application.CreateForm(TfrmReceitas, frmReceitas);
frmReceitas.show;
end;

end.
