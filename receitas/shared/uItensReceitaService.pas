unit uItensReceitaService;

interface

uses uItensReceitaModel, uItensReceitaRepository, uMensagem, Contnrs, SysUtils;

type

  TItensReceitaService = class
    private
      FItensReceitaRepository: IItensReceitaRepository;

    public
      constructor create(itensReceitaRepository: IItensReceitaRepository);
      function salvar(itensReceita: TItensReceita): TMensagem;
      function lista(id_receita: integer; ingrediente: string): TObjectList;

  end;

implementation

{ TItensReceitaService }

constructor TItensReceitaService.create(
  itensReceitaRepository: IItensReceitaRepository);
begin
  FItensReceitaRepository:= itensReceitaRepository;
end;

function TItensReceitaService.lista(id_receita: integer; ingrediente: string): TObjectList;
begin
  result:= FItensReceitaRepository.listar(id_receita, ingrediente);
end;

function TItensReceitaService.salvar(
  itensReceita: TItensReceita): TMensagem;
var
  lista: TObjectList;  
begin
  if (Trim(itensReceita.ingrediente) = '') then
  begin
    result.mensagem:= 'Campo ingredientes precisa ser preenchido';
    result.campo:= 'Ingredientes';
    exit;
  end;

  //VERIFICA SE INGREDIENTE JÁ FOI INSERIDO
 // if itensReceita.id = 0 then
 // begin
     lista:= FItensReceitaRepository.listar(itensReceita.receita.id, itensReceita.ingrediente);

     if (lista.Count > 0) then
     begin
       result.mensagem:= 'Ingrediente ' + itensReceita.ingrediente + ' já existe';
       result.campo:= 'Ingredientes';
       exit;
     end;
  // end;
  //FIM VERIFICA SE INGREDIENTE JÁ FOI INSERIDO

  if itensReceita.id = 0 then
    FItensReceitaRepository.salvar(itensReceita)
  else
    FItensReceitaRepository.alterar(itensReceita);
end;

end.
