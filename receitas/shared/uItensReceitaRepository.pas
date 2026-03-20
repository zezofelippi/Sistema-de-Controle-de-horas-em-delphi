unit uItensReceitaRepository;

interface

uses uItensReceitaModel,  Contnrs;

type
  IItensReceitaRepository = interface
    procedure salvar(itensReceita: TItensReceita);
    procedure alterar(itensReceita: TItensReceita);
    function listar(id_receita: integer; ingrediente: string): TObjectList;


  end;

implementation

end.
