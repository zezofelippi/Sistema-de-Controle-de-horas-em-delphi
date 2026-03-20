unit uReceitaService;

interface

uses uReceitaModel, uReceitaRepository, uMensagem, Contnrs, SysUtils;

type

  TReceitaService = class
  private
    FReceitaRepository: IReceitaRepository;
  public
    constructor create(receitaRepository: IReceitaRepository);
    function salvar(receita: TReceita):TMensagem;
    function listar(idReceita: integer; titulo_receita: string): TObjectList;


  end;

implementation

{ TReceitaService }

constructor TReceitaService.create(receitaRepository: IReceitaRepository);
begin
  FReceitaRepository:= receitaRepository;
end;

function TReceitaService.listar(idReceita: integer; titulo_receita: string): TObjectList;
begin
  result:= FReceitaRepository.listar(idReceita, titulo_receita);
end;

function TReceitaService.salvar(receita: TReceita): TMensagem;
begin
  if Trim(receita.tituloReceita) = '' then
  begin
    result.mensagem:= 'Título da receita precisa ser preenchido';
    result.campo:= 'TituloReceita';
    exit;
  end;

  if receita.id = 0 then
    result.id_receita:= FReceitaRepository.salvar(receita)
  else
  begin
    FReceitaRepository.alterar(receita);
    result.id_receita:= result.id_receita;
  end;
end;

end.
