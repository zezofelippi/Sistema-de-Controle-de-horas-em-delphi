unit untCadastrarReceita;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DB, DBTables, uReceitaController,
  uReceitaService, uReceitaRepository, uReceitaRepositoryFireDac, uMensagem,
  uItensReceitaModel, uItensReceitaController, uItensReceitaService,
  uItensReceitaRepository, uItensReceitaRepositoryFireDac, DBClient, Contnrs,
  Menus;

type
  TfrmCadastrarReceita = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtTituloReceita: TEdit;
    btnSalvar: TButton;
    Panel2: TPanel;
    dbgItensReceita: TDBGrid;
    mmPreparo: TMemo;
    Label2: TLabel;
    btnSalvarPreparo: TButton;
    Panel3: TPanel;
    edtIngredientes: TEdit;
    btnAdicionar: TButton;
    btnCancelar: TButton;
    Label3: TLabel;
    btnConcluirReceita: TButton;
    dtsItensReceita: TDataSource;
    cdsItensReceita: TClientDataSet;
    popMenu: TPopupMenu;
    Alterar1: TMenuItem;
    btnCancelarIngrediente: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnConcluirReceitaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarPreparoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mmPreparoKeyPress(Sender: TObject; var Key: Char);
    procedure Alterar1Click(Sender: TObject);
    procedure btnCancelarIngredienteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FReceitaController: TReceitaController;
    FItensReceitaController: TItensReceitaController;
    FId_receita, FIdItensReceita: integer;
    procedure listarItensReceita(ingrediente: string);

  public
    property IdReceita: Integer read FId_receita write FId_receita;
  end;

var
  frmCadastrarReceita: TfrmCadastrarReceita;

implementation

{$R *.dfm}

procedure TfrmCadastrarReceita.FormCreate(Sender: TObject);
var
  receitaService: TReceitaService;
  receitaRepository: IReceitaRepository;

  itensReceitaService: TItensReceitaService;
  itensReceitaRepository: IItensReceitaRepository;

begin
  receitaRepository:= TReceitaRepositoryfireDac.create;
  receitaService:= TReceitaService.create(receitaRepository);
  FReceitaController:= TReceitaController.create(receitaService);

  itensReceitaRepository:= TItensReceitaRepositoryFireDac.create;
  itensReceitaService:= TItensReceitaService.create(itensReceitaRepository);
  FItensReceitaController:= TItensReceitaController.create(itensReceitaService);

  FIdItensReceita:=0;

  btnCancelar.Enabled:= false;
  btnConcluirReceita.Enabled:= false;
  btnAdicionar.Enabled:= false;
  btnSalvarPreparo.Enabled:= false;
  btnCancelarIngrediente.enabled:= false;

end;

procedure TfrmCadastrarReceita.btnSalvarClick(Sender: TObject);
var
  resposta: TMensagem;
begin
  if FId_receita = 0 then
    resposta:= FReceitaController.salvar(0,edtTituloReceita.Text, mmPreparo.Text)
  else
    resposta:= FReceitaController.salvar(FId_receita,edtTituloReceita.Text, mmPreparo.Text);

  if resposta.campo <> '' then
  begin
    MessageDlg(resposta.mensagem, mtWarning, [mbOK], 0);
    //focoComponente(resposta.campo); aqui é para versao nova do delphi
    exit;
  end;

  FId_receita:= resposta.id_receita;
  btnCancelar.Enabled:= true;
  btnConcluirReceita.Enabled:= true;
  btnAdicionar.Enabled:= true;
  btnSalvarPreparo.Enabled:= true;
end;

procedure TfrmCadastrarReceita.btnAdicionarClick(Sender: TObject);
var
  resposta: TMensagem; 
begin

  resposta:= FItensReceitaController.salvar(FIdItensReceita, FId_receita, edtIngredientes.Text);

  if resposta.campo <> '' then
  begin
    MessageDlg(resposta.mensagem, mtWarning, [mbOK], 0);
    //focoComponente(resposta.campo); aqui é para versao nova do delphi
    exit;
  end;

  edtIngredientes.clear;
  FIdItensReceita:=0;

  //Se caso estiver em alteração
  btnAdicionar.caption:= 'Adicionar';
  btnCancelarIngrediente.Enabled:= false;
  //FIM Se caso estiver em alteração

  listarItensReceita('');   
end;

procedure TfrmCadastrarReceita.btnConcluirReceitaClick(Sender: TObject);
begin
  btnCancelar.Enabled:= false;
  btnConcluirReceita.Enabled:= false;
  btnAdicionar.Enabled:= false;
  btnSalvarPreparo.Enabled:= false;

  FId_receita:= 0;
end;

procedure TfrmCadastrarReceita.btnCancelarClick(Sender: TObject);
begin
  btnCancelar.Enabled:= false;
  btnConcluirReceita.Enabled:= false;
  btnAdicionar.Enabled:= false;
  btnSalvarPreparo.Enabled:= false;

  FId_receita:= 0;
end;

procedure TfrmCadastrarReceita.btnSalvarPreparoClick(Sender: TObject);
var
  resposta: TMensagem;
begin
  resposta:= FReceitaController.salvar(FId_receita,edtTituloReceita.Text, mmPreparo.Text);
end;

procedure TfrmCadastrarReceita.listarItensReceita(ingrediente: string);
var
  itensReceita: TItensReceita;
  i: integer;
  lista: TObjectList;
begin
  lista:= FItensReceitaController.listar(FId_receita, ingrediente);
  cdsItensReceita.DisableControls;

  try
    cdsItensReceita.close;
    cdsItensReceita.FieldDefs.Clear;
    cdsItensReceita.FieldDefs.Add('ID', ftInteger, 0, false);
    cdsItensReceita.FieldDefs.Add('INGREDIENTE', ftString, 200, false);
    cdsItensReceita.CreateDataSet;

    for i:=0 to lista.count -1 do
    begin
      itensReceita:= TItensReceita(lista[i]);

      cdsItensReceita.Append;
      cdsItensReceita.FieldByName('ID').AsInteger := itensReceita.id;
      cdsItensReceita.FieldByName('INGREDIENTE').AsString := itensReceita.ingrediente;
      cdsItensReceita.Post;
    end;
  finally
    cdsItensReceita.EnableControls;
    cdsItensReceita.FieldByName('ID').Visible:= false;
    dbgItensReceita.Columns[0].Width:= 600;
    lista.Free;
  end;
end;

procedure TfrmCadastrarReceita.FormShow(Sender: TObject);
begin
  if FId_receita <> 0 then
  begin
    listarItensReceita('');
    btnCancelar.Enabled:= true;
    btnConcluirReceita.Enabled:= true;
    btnAdicionar.Enabled:= true;
    btnSalvarPreparo.Enabled:= true;
  end;

end;

procedure TfrmCadastrarReceita.mmPreparoKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := UpCase(Key)
end;

procedure TfrmCadastrarReceita.Alterar1Click(Sender: TObject);
begin
  edtIngredientes.text:= cdsItensReceita.fieldbyname('INGREDIENTE').AsString;
  FIdItensReceita:= cdsItensReceita.fieldbyname('ID').AsInteger;
  btnCancelarIngrediente.enabled:= true;
  btnAdicionar.Caption:= 'Alterar';
end;

procedure TfrmCadastrarReceita.btnCancelarIngredienteClick(
  Sender: TObject);
begin
  FIdItensReceita:=0;
  btnAdicionar.Caption:= 'Adicionar';
  btnCancelarIngrediente.Enabled:= false;
end;

procedure TfrmCadastrarReceita.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FItensReceitaController.Free;
  FReceitaController.Free;
  frmCadastrarReceita:= nil;
end;

end.
