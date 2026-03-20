unit uReceitaRepositoryFireDac;

interface

uses uReceitaModel, IBQuery, uReceitaRepository, untModulo, IBDatabase, Contnrs;

type

  TReceitaRepositoryFireDac = class(TInterfacedObject, IReceitaRepository)
    public
      function salvar(receita: TReceita): integer;
      function listar(idReceita: integer; tituloReceita: string): TObjectList;
      procedure alterar(receita: TReceita);

  end;

implementation

{ TReceitaRepositoryFireDac }

procedure TReceitaRepositoryFireDac.alterar(receita: TReceita);
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

      query.SQL.Text:= 'UPDATE RECEITAS SET TITULO_RECEITA=:TITULO_RECEITA, MODO_PREPARO=:MODO_PREPARO WHERE ID=:ID';
      query.ParamByName('ID').AsInteger:= receita.id;
      query.ParamByName('TITULO_RECEITA').AsString:= receita.tituloReceita;
      query.ParamByName('MODO_PREPARO').AsString:= receita.modoPreparo;
      query.ExecSQL;

      IBTransLocal.commit;
    except
      raise
    end;
  finally
    query.free;
  end;


end;

function TReceitaRepositoryFireDac.listar(
  idReceita: integer; tituloReceita: string): TObjectList;
var
  query : TIBQuery;
  receita: TReceita;
  lista: TObjectList;  
begin
  query := TIBQuery.create(nil);

  try 
    frmModulo.BD.Open;
    query.Database:= frmModulo.BD;

    query.SQL.add('SELECT ID, TITULO_RECEITA, MODO_PREPARO FROM RECEITAS WHERE 1=1 ');
    if tituloReceita <> '' then
    begin
      query.SQL.Add(' AND TITULO_RECEITA LIKE :TITULO_RECEITA ');
      query.ParamByName('TITULO_RECEITA').AsString:= '%' + tituloReceita + '%';
    end;
    if idReceita <> 0 then
    begin
      query.SQL.Add(' AND ID =:ID ');
      query.ParamByName('ID').AsInteger:= idReceita;
    end;
    query.SQL.Add('ORDER BY TITULO_RECEITA');
    query.Open;
    query.First;

    lista := TObjectList.Create;

    while not query.eof do
    begin
      receita:= TReceita.create;
      receita.id:= query.fieldbyname('ID').AsInteger;
      receita.tituloReceita:= query.fieldbyname('TITULO_RECEITA').AsString;
      receita.modoPreparo:= query.fieldbyname('MODO_PREPARO').AsString;
      lista.Add(receita);
      query.next;
    end;
    result:= lista;
  finally
    query.free;
  end;


end;

function TReceitaRepositoryFireDac.salvar(receita: TReceita): integer;
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

      query.SQL.Text:= 'INSERT INTO RECEITAS (TITULO_RECEITA, MODO_PREPARO) VALUES (:TITULO_RECEITA, :MODO_PREPARO) RETURNING ID';
      query.ParamByName('TITULO_RECEITA').AsString:= receita.tituloReceita;
      query.ParamByName('MODO_PREPARO').AsString:= receita.modoPreparo;
     // query.SQL.Text := query.SQL.Text + ' RETURNING ID'; colocar isso no firedac
      query.ExecSQL;

      IBTransLocal.commit;

      //tirar esse bloco do firedac e usar so o RETURNING ID de cima
      query.Close;
      query.SQL.Text := 'SELECT MAX(ID) AS ID FROM RECEITAS';
      query.Open;
      //FIM tirar esse bloco do firedac e usar so o RETURNING ID de cima
      
      Result := query.FieldByName('ID').AsInteger;
    except
      raise
    end;
  finally
    query.free;
  end;

end;

end.
