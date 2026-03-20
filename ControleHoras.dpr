program ControleHoras;

uses
  Forms,
  untMenu in 'untMenu.pas' {frmMenu},
  untMovimentacaoHoras in 'untMovimentacaoHoras.pas' {frmMovimentacaoHoras},
  untModulo in 'untModulo.pas' {frmModulo: TDataModule},
  untCadAtividade in 'untCadAtividade.pas' {frmCadAtividade},
  untExcelParaBancoDados in 'untExcelParaBancoDados.pas' {frmExcelParaBancoDados},
  untCorpo in 'untCorpo.pas' {frmCorpo},
  untImportarDadosCorpo in 'untImportarDadosCorpo.pas' {frmImportarDadosCorpo},
  untTarefas in 'untTarefas.pas' {frmTarefas},
  untReceitas in 'receitas\desktop-vcl\untReceitas.pas' {frmReceitas},
  untCadastrarReceita in 'receitas\desktop-vcl\untCadastrarReceita.pas' {frmCadastrarReceita},
  uReceitaController in 'receitas\shared\uReceitaController.pas',
  uReceitaModel in 'receitas\shared\uReceitaModel.pas',
  uReceitaService in 'receitas\shared\uReceitaService.pas',
  uReceitaRepository in 'receitas\shared\uReceitaRepository.pas',
  uMensagem in 'receitas\shared\classesGerais\uMensagem.pas',
  uReceitaRepositoryFireDac in 'receitas\shared\uReceitaRepositoryFireDac.pas',
  uItensReceitaModel in 'receitas\shared\uItensReceitaModel.pas',
  uItensReceitaController in 'receitas\shared\uItensReceitaController.pas',
  uItensReceitaService in 'receitas\shared\uItensReceitaService.pas',
  uItensReceitaRepository in 'receitas\shared\uItensReceitaRepository.pas',
  uItensReceitaRepositoryFireDac in 'receitas\shared\uItensReceitaRepositoryFireDac.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmMovimentacaoHoras, frmMovimentacaoHoras);
  Application.CreateForm(TfrmModulo, frmModulo);
  Application.CreateForm(TfrmCadAtividade, frmCadAtividade);
  Application.CreateForm(TfrmExcelParaBancoDados, frmExcelParaBancoDados);
  Application.CreateForm(TfrmCorpo, frmCorpo);
  Application.CreateForm(TfrmImportarDadosCorpo, frmImportarDadosCorpo);
  Application.CreateForm(TfrmTarefas, frmTarefas);
  Application.CreateForm(TfrmReceitas, frmReceitas);
  Application.CreateForm(TfrmCadastrarReceita, frmCadastrarReceita);
  Application.Run;
end.
