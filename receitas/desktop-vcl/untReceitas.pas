unit untReceitas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, uReceitaController, Contnrs,
  DB, DBClient;

type
  TfrmReceitas = class(TForm)
    Panel1: TPanel;
    dbgReceita: TDBGrid;
    Label1: TLabel;
    edtReceita: TEdit;
    btnListar: TButton;
    btnCadastrarReceita: TButton;
    dtsReceita: TDataSource;
    cdsReceita: TClientDataSet;
    procedure btnCadastrarReceitaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgReceitaDblClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
  private
    FReceitaController: TReceitaController;
    procedure listarReceitas(idReceita: integer);
  public
    { Public declarations }
  end;

var
  frmReceitas: TfrmReceitas;

implementation

uses untCadastrarReceita, uReceitaModel, uReceitaService, uReceitaRepository, uReceitaRepositoryFireDac;

{$R *.dfm}

procedure TfrmReceitas.btnCadastrarReceitaClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCadastrarReceita, frmCadastrarReceita);
  frmCadastrarReceita.IdReceita:= 0;
  frmCadastrarReceita.show;
end;

procedure TfrmReceitas.FormCreate(Sender: TObject);
var
  receitaRepository: IReceitaRepository;
  receitaService: TReceitaService;
begin
  receitaRepository:= TReceitaRepositoryFireDac.create;
  receitaService:= TReceitaService.create(receitaRepository);
  FReceitaController:= TReceitaController.create(receitaService);
end;

procedure TfrmReceitas.dbgReceitaDblClick(Sender: TObject);
begin
  listarReceitas(cdsReceita.FieldByName('ID').AsInteger);
  
  Application.CreateForm(TfrmCadastrarReceita, frmCadastrarReceita);
  
  frmCadastrarReceita.IdReceita:= cdsReceita.FieldByName('ID').AsInteger;
  frmCadastrarReceita.edtTituloReceita.Text := cdsReceita.FieldByName('TITULO_RECEITA').AsString;
  frmCadastrarReceita.mmPreparo.Text:= cdsReceita.FieldByName('MODO_PREPARO').AsString;
  frmCadastrarReceita.show;
end;

procedure TfrmReceitas.listarReceitas(idReceita: integer);
var
  lista: TObjectList;
  receita: TReceita;
  i: integer;
begin
  lista:= FReceitaController.listar(idReceita, edtReceita.Text);

  cdsReceita.DisableControls;

  try
    cdsReceita.close;
    cdsReceita.FieldDefs.Clear;
    cdsReceita.FieldDefs.Add('ID', ftInteger, 0, false);
    cdsReceita.FieldDefs.Add('TITULO_RECEITA', ftString, 120, false);
    cdsReceita.FieldDefs.Add('MODO_PREPARO', ftString, 4000, false);
    cdsReceita.CreateDataSet;

    for i:=0 to lista.count -1 do
    begin
      receita:= TReceita(lista[i]);

      cdsReceita.Append;
      cdsReceita.FieldByName('ID').AsInteger := receita.id;
      cdsReceita.FieldByName('TITULO_RECEITA').AsString := receita.tituloReceita;
      cdsReceita.FieldByName('MODO_PREPARO').AsString := receita.modoPreparo;
      cdsReceita.Post;
    end;
  finally
    cdsReceita.EnableControls;
    cdsReceita.FieldByName('ID').Visible:= false;
    cdsReceita.FieldByName('MODO_PREPARO').Visible:= false;
    dbgReceita.Columns[0].Width:= 600;
    lista.Free;
  end;
end;

procedure TfrmReceitas.btnListarClick(Sender: TObject);
begin
  listarReceitas(0);
end;

end.
