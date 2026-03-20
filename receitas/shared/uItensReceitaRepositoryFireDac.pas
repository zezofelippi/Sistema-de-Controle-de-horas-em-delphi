unit uItensReceitaRepositoryFireDac;

interface

uses uItensReceitaModel, uItensReceitaRepository, IBQuery, IBDatabase, untModulo, Contnrs;

type

  TItensReceitaRepositoryFireDac = class(TInterfacedObject, IItensReceitaRepository)
    public
      procedure salvar(itensReceita: TItensReceita);
      procedure alterar(itensReceita: TItensReceita);
      function listar(id_receita: integer; ingrediente: string): TObjectList;

  end;

implementation

{ TItensReceitaRepositoryFireDac }

procedure TItensReceitaRepositoryFireDac.alterar(
  itensReceita: TItensReceita);
var
  query : TIBQuery;
  IBTransLocal : TIBTRansaction;
begin

  IBTransLocal:= TIBTRansaction.Create(nil);
  query := TIBQuery.create(nil);

  try
    try
      frmModulo.BD.Open;
      IBTransLocal.DefaultDatabase:= frmModulo.BD;
      query.Database:= frmModulo.BD;

      query.Transaction:= IBTransLocal;

      if (not IBTransLocal.InTransaction) then
        IBTransLocal.StartTransaction;

      query.SQL.Text:= 'UPDATE ITENS_RECEITA SET INGREDIENTE=:INGREDIENTE WHERE ID=:ID AND ID_RECEITA=:ID_RECEITA';
      query.ParamByName('INGREDIENTE').AsString:= itensReceita.ingrediente;
      query.ParamByName('ID_RECEITA').AsInteger:= itensReceita.receita.id;
      query.ParamByName('ID').AsInteger:=  itensReceita.id;
      query.ExecSQL;

      IBTransLocal.commit;

    except
      raise
    end;
  finally
    query.free;
  end;

end;

function TItensReceitaRepositoryFireDac.listar(id_receita: integer; ingrediente: string): TObjectList;
var
  query : TIBQuery;
  itensReceita: TItensReceita;
  lista: TObjectList;
begin

  query := TIBQuery.create(nil);

  try 
    frmModulo.BD.Open;
    query.Database:= frmModulo.BD;

    query.SQL.Add('SELECT ID, INGREDIENTE FROM ITENS_RECEITA WHERE 1=1 ');
    if id_receita <> 0 then
    begin
      query.SQL.Add(' AND ID_RECEITA=:ID_RECEITA');
      query.ParamByName('ID_RECEITA').AsInteger:= id_receita;
    end;
    if ingrediente <> '' then
    begin
      query.SQL.Add(' AND INGREDIENTE LIKE :INGREDIENTE');
      query.ParamByName('INGREDIENTE').AsString:= ingrediente;
    end;

    query.Open;
    query.First;

    lista := TObjectList.Create;

    while not query.eof do
    begin
      itensReceita:= TItensReceita.create;
      itensReceita.id:= query.fieldbyname('ID').AsInteger;
      itensReceita.ingrediente:= query.fieldbyname('INGREDIENTE').AsString;
      lista.Add(itensReceita);
      query.next;
    end;
    result:= lista;
  finally
    query.free;
  end;

end;

procedure TItensReceitaRepositoryFireDac.salvar(
  itensReceita: TItensReceita);
var
  query : TIBQuery;
  IBTransLocal : TIBTRansaction;
begin

  IBTransLocal:= TIBTRansaction.Create(nil);
  query := TIBQuery.create(nil);

  try
    try
      frmModulo.BD.Open;
      IBTransLocal.DefaultDatabase:= frmModulo.BD;
      query.Database:= frmModulo.BD;

      query.Transaction:= IBTransLocal;

      if (not IBTransLocal.InTransaction) then
        IBTransLocal.StartTransaction;

      query.SQL.Text:= 'INSERT INTO ITENS_RECEITA (INGREDIENTE, ID_RECEITA) VALUES (:INGREDIENTE, :ID_RECEITA)';
      query.ParamByName('INGREDIENTE').AsString:= itensReceita.ingrediente;
      query.ParamByName('ID_RECEITA').AsInteger:= itensReceita.receita.id;
      query.ExecSQL;

      IBTransLocal.commit;

    except
      raise
    end;
  finally
    query.free;
  end;



end;

end.
