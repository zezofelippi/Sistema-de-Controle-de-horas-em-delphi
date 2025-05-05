program ControleHoras;

uses
  Forms,
  untMenu in 'untMenu.pas' {frmMenu},
  untMovimentacaoHoras in 'untMovimentacaoHoras.pas' {frmMovimentacaoHoras},
  untModulo in 'untModulo.pas' {frmModulo: TDataModule},
  untCadAtividade in 'untCadAtividade.pas' {frmCadAtividade},
  untExcelParaBancoDados in 'untExcelParaBancoDados.pas' {frmExcelParaBancoDados},
  untCorpo in 'untCorpo.pas' {frmCorpo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmMovimentacaoHoras, frmMovimentacaoHoras);
  Application.CreateForm(TfrmModulo, frmModulo);
  Application.CreateForm(TfrmCadAtividade, frmCadAtividade);
  Application.CreateForm(TfrmExcelParaBancoDados, frmExcelParaBancoDados);
  Application.CreateForm(TfrmCorpo, frmCorpo);
  Application.Run;
end.
