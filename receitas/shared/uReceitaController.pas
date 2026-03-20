unit uReceitaController;

interface

uses uReceitaModel, uReceitaService, uMensagem, Contnrs;

type

  TReceitaController = class
    private
      FReceitaService: TReceitaService;
    public
      constructor create(receitaService: TReceitaService);
      function salvar(id: integer; tituloReceita, modoPreparo: string): TMensagem;
      function listar(idReceita: integer; titulo_receita: string): TObjectList;

  end;

implementation

{ TReceitaController }

constructor TReceitaController.create(receitaService: TReceitaService);
begin
  FReceitaService:= receitaService;
end;

function TReceitaController.listar(idReceita: integer; titulo_receita: string): TObjectList;
begin
  result:= FReceitaService.listar(idReceita, titulo_receita);
end;

function TReceitaController.salvar(id: integer; tituloReceita,
  modoPreparo: string): TMensagem;
var
  receita: TReceita;
begin
  receita:= TReceita.create;

  try
    receita.id:= id;
    receita.tituloreceita:= tituloReceita;
    receita.modoPreparo:= modoPreparo;
    result:= FReceitaService.salvar(receita);
  finally
    receita.free;
  end;
  
end;

end.
