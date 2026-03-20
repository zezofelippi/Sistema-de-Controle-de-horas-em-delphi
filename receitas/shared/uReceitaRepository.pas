unit uReceitaRepository;

interface

uses uReceitaModel, Contnrs;

type

  IReceitaRepository = Interface
    function salvar(receita: TReceita): integer;
    function listar(idReceita: integer; tituloReceita: string): TObjectList;
    procedure alterar(receita: TReceita);

  end;

implementation

end.
