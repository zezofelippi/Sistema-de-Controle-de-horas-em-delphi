unit uItensReceitaController;

interface

uses uItensReceitaModel, uItensReceitaService, uMensagem, Contnrs;

type

  TItensReceitaController = class
    private
      FItensReceitaService: TItensReceitaService;
    public
      constructor create(itensReceitaService: TItensReceitaService);
      function salvar(id, id_receita: integer; ingrediente: string): TMensagem;
      function listar(id_receita: integer; ingrediente: string): TObjectList;

  end;

implementation

{ TItensReceitaController }

constructor TItensReceitaController.create(
  itensReceitaService: TItensReceitaService);
begin
  FItensReceitaService:= itensReceitaService;
end;

function TItensReceitaController.listar(id_receita: integer; ingrediente: string): TObjectList;
begin
  result:= FItensReceitaService.lista(id_receita, ingrediente);
end;

function TItensReceitaController.salvar(id, id_receita: integer;
  ingrediente: string): TMensagem;
var
  itensReceita: TItensReceita;
begin

  itensReceita:= TItensReceita.Create;

  try
    itensReceita.id:= id;
    itensReceita.ingrediente:= ingrediente;
    itensReceita.receita.id:= id_receita;
    result:= FItensReceitaService.salvar(itensReceita);
  finally
    itensReceita.free;
  end;
  
end;

end.
