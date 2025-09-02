unit untImportarDadosCorpo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, IBQuery, Grids, DBGrids,
  IBDatabase;

type
  TfrmImportarDadosCorpo = class(TForm)
    Button1: TButton;
    qryCorpo: TIBQuery;
    qryCorpoDATA: TDateTimeField;
    qryCorpoOBS: TIBStringField;
    DBGrid1: TDBGrid;
    edtResultado: TEdit;
    dsCorpo: TDataSource;
    qryPesqAux: TIBQuery;
    mmoDados: TMemo;
    IBTransLocal: TIBTransaction;
    qry_trans_local: TIBQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportarDadosCorpo: TfrmImportarDadosCorpo;

implementation

{$R *.dfm}

procedure TfrmImportarDadosCorpo.Button1Click(Sender: TObject);
var
  dado: string;
  i: integer;
begin
  dado := 'INTESTINO NORMAL';

  qryCorpo.Close;
  qryCorpo.SQL.Clear;
  qryCorpo.SQL.Add('SELECT DATA, OBS FROM MOVIMENTACAO_HORA WHERE '+
   ' UPPER(OBS) LIKE UPPER('+ #39 + '%' + dado + '%' + #39 + ')');
  qryCorpo.Open;
  qryCorpo.FetchAll;

  edtResultado.Text:= inttostr(qryCorpo.RecordCount);

  qryCorpo.First;
  i:=1;

  if (not IBTransLocal.InTransaction) then
    IBTransLocal.StartTransaction;


  while not qryCorpo.eof do
  begin

    qryPesqAux.close;
    qryPesqAux.SQL.clear;
    qryPesqAux.SQL.Add('SELECT DATA FROM CORPO WHERE DATA=:DATA');
    qryPesqAux.ParamByName('DATA').ASSTRING:= qryCorpo.fieldbyname('DATA').asstring;
    qryPesqAux.Open;

    if not qryPesqAux.isempty then
    begin
      mmoDados.Lines.Add('data existe ' + qryCorpo.fieldbyname('DATA').asstring );

      qry_trans_local.Close;
      qry_trans_local.SQL.Clear;
      qry_trans_local.SQL.Add('UPDATE CORPO SET OBS=:OBS '+
                              'WHERE DATA=:DATA');
      qry_trans_local.parambyname('DATA').asstring :=qryCorpo.fieldbyname('DATA').asstring;
      qry_trans_local.parambyname('OBS').asstring:= 'INTESTINO NORMAL';
    end
    else
    begin
      qry_trans_local.Close;
      qry_trans_local.SQL.Clear;
      qry_trans_local.SQL.Add('INSERT INTO CORPO (DATA, OBS)'+
           'VALUES (:DATA, :OBS )');
      qry_trans_local.parambyname('DATA').asstring :=qryCorpo.fieldbyname('DATA').asstring;
      qry_trans_local.parambyname('OBS').asstring:= 'INTESTINO NORMAL';     

       mmoDados.Lines.Add('data NAO existe ' + qryCorpo.fieldbyname('DATA').asstring );

    end;

    qry_trans_local.ExecSQL;
    //IBTransLocal.Commit;
    inc(i);

    qryCorpo.Next;

  end;

 // qry_trans_local.ExecSQL;
  IBTransLocal.Commit;

end;

end.
