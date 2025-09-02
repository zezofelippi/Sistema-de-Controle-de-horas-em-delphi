unit untCorpo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, ToolEdit, CurrEdit, Grids, DBGrids, DB,
  IBCustomDataSet, IBQuery, IBDatabase, DateUtils, Menus;

type
  TfrmCorpo = class(TForm)
    edtData: TDateEdit;
    Label4: TLabel;
    lbl3: TLabel;
    edtPeso: TCurrencyEdit;
    btnGravar: TButton;
    DBGrid1: TDBGrid;
    dtsCorpo: TDataSource;
    qryCorpo: TIBQuery;
    qryCorpoID_CORPO: TIntegerField;
    qryCorpoPESO: TIBBCDField;
    qryCorpoDATA: TDateTimeField;
    IBTransLocal: TIBTransaction;
    qry_trans_local: TIBQuery;
    Label1: TLabel;
    edtCintura: TCurrencyEdit;
    Label2: TLabel;
    qryCorpoCINTURA: TIntegerField;
    Label3: TLabel;
    edtObs: TEdit;
    GroupBox1: TGroupBox;
    edtDataInicial: TDateEdit;
    edtDataFinal: TDateEdit;
    edtObsPesquisa: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnPesquisar: TButton;
    qryCorpoOBS: TIBStringField;
    Label9: TLabel;
    edtDias: TEdit;
    edtIntervaloDatas: TEdit;
    Label8: TLabel;
    PopupMenu1: TPopupMenu;
    Alterar1: TMenuItem;
    qryPesquisa: TIBQuery;
    edtIdCorpo: TEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure limpa_campos(Sender : TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure btnPesquisarClick(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCorpo: TfrmCorpo;
   alterar: string;

implementation

uses untModulo;

{$R *.dfm}

function DiasEntreDatas(DataInicial, DataFinal: TDate): Integer;
begin
  Result := DaysBetween(DataFinal, DataInicial) +1;
end;

procedure TfrmCorpo.limpa_campos(Sender: TObject);
begin
  edtData.Clear;
  edtPeso.clear;
  edtCintura.Clear;
  edtObs.clear;
  edtIdCorpo.clear;
  edtData.Enabled:= TRUE;
  
end;

procedure TfrmCorpo.btnGravarClick(Sender: TObject);
begin
  if edtData.Text = '  /  /    ' then
  begin
    showmessage('Coloque a data');
    edtData.SetFocus;
    exit;
  end
  else if (edtPeso.Value = 0) and (edtCintura.Value = 0) and (edtObs.Text = '') then
  begin
    showmessage('Coloque algum dado no peso, na cintura ou obs');
    edtPeso.SetFocus;
    exit;
  end;

  if (not IBTransLocal.InTransaction) then
    IBTransLocal.StartTransaction;

  if alterar <> 'S' then
  begin
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('INSERT INTO CORPO (DATA, PESO, CINTURA, OBS)'+
                            'VALUES (:DATA, :PESO, :CINTURA, :OBS) ');
    qry_trans_local.ParamByName('DATA').AsString  := edtData.Text;
    qry_trans_local.ParamByName('PESO').AsFloat  :=  edtPeso.Value;
    qry_trans_local.ParamByName('CINTURA').AsFloat  :=  edtCintura.Value;
    qry_trans_local.ParamByName('OBS').AsString  := edtObs.Text;
  end
  else
  begin
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('UPDATE CORPO SET OBS=:OBS,    '+
                            ' PESO=:PESO, CINTURA=:CINTURA '+
                            'WHERE ID_CORPO=:ID_CORPO');  
    qry_trans_local.ParamByName('PESO').AsFloat  :=  edtPeso.Value;
    qry_trans_local.ParamByName('CINTURA').AsFloat  :=  edtCintura.Value;
    qry_trans_local.ParamByName('OBS').AsString  := edtObs.Text;
    qry_trans_local.ParamByName('ID_CORPO').AsString := edtIdCorpo.Text;

  end;

  qry_trans_local.ExecSQL;
  IBTransLocal.Commit;

  limpa_campos(Sender as TObject);

  alterar := 'N';

end;

procedure TfrmCorpo.FormShow(Sender: TObject);
begin

alterar:= 'N';

end;

procedure TfrmCorpo.DBGrid1TitleClick(Column: TColumn);
var
  campo, data1, data2, dta, obs: string;
begin
  campo := column.fieldname; // CAMPO RECEBE O NOME DA COLUNA CLICADA,
  application.processmessages; // para considerar algo que aconteça no dbgrid durante a entrada nesta procedure

  data1 := Copy(edtDataInicial.Text,4,3) + Copy(edtDataInicial.Text,1,3) + Copy(edtDataInicial.Text,7,4) + ' 00:00:00';
  data2 := Copy(edtDataFinal.Text,4,3) + Copy(edtDataFinal.Text,1,3) + Copy(edtDataFinal.Text,7,4) + ' 23:59:59';

  if (edtDataInicial.Text <> '  /  /    ') and (edtDataFinal.Text <> '  /  /    ') then
    dta := ' AND DATA BETWEEN '+ #39 + data1 + #39 + ' AND '+ #39 + data2 + #39
  else
    dta := '';

  if edtObsPesquisa.Text <> '' then
    obs:= ' AND UPPER(OBS) LIKE UPPER('+ #39 + '%' + edtObsPesquisa.Text + '%' + #39 + ')';

  qryCorpo.Close;
  qryCorpo.SQL.Clear;
  qryCorpo.SQL.Add('SELECT ID_CORPO, DATA, PESO, OBS, CINTURA FROM CORPO WHERE 1=1 ' + dta + obs +
      'ORDER BY ' + campo);
  qryCorpo.Open;
  qryCorpo.FetchAll;


end;

procedure TfrmCorpo.btnPesquisarClick(Sender: TObject);
var
  data1, data2, dta, obs: string;
  qtde_dias: integer;
begin

  data1 := Copy(edtDataInicial.Text,4,3) + Copy(edtDataInicial.Text,1,3) + Copy(edtDataInicial.Text,7,4) + ' 00:00:00';
  data2 := Copy(edtDataFinal.Text,4,3) + Copy(edtDataFinal.Text,1,3) + Copy(edtDataFinal.Text,7,4) + ' 23:59:59';

  if (edtDataInicial.Text <> '  /  /    ') and (edtDataFinal.Text <> '  /  /    ') then
    dta := ' AND DATA BETWEEN '+ #39 + data1 + #39 + ' AND '+ #39 + data2 + #39
  else
    dta := '';

  if edtObsPesquisa.Text <> '' then
    obs:= ' AND UPPER(OBS) LIKE UPPER('+ #39 + '%' + edtObsPesquisa.Text + '%' + #39 + ')';


  qryCorpo.Close;
  qryCorpo.SQL.Clear;
  qryCorpo.SQL.Add('SELECT ID_CORPO, DATA, PESO, OBS, CINTURA FROM CORPO WHERE 1=1 ' + dta + obs +
    'ORDER BY DATA');
  qryCorpo.Open;
  qryCorpo.FetchAll;

  edtDias.Text := inttostr(qryCorpo.RecordCount) + ' dias pesquisados'; 

  //calcular qtde de dias pesquisados
  qtde_dias := DiasEntreDatas(edtDataInicial.Date, edtDataFinal.Date);
  edtIntervaloDatas.text := IntToStr(qtde_dias);
  //FIM calcular qtde de dias pesquisados

  
end;

procedure TfrmCorpo.Alterar1Click(Sender: TObject);
var
  data_pesquisa : string;
begin
  
  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT DATA, PESO, CINTURA, OBS FROM CORPO '+
   ' WHERE ID_CORPO=:ID_CORPO');
  qryPesquisa.parambyname('ID_CORPO').asstring:= qryCorpo.fieldbyname('ID_CORPO').asstring;
  qryPesquisa.Open;

  edtData.Text:= qryPesquisa.fieldbyname('DATA').asstring;
  edtData.Enabled:=false;
  edtObs.Text:= qryPesquisa.FieldByName('obs').AsString;
  edtPeso.text := qryPesquisa.FieldByName('PESO').AsString;
  edtCintura.text := qryPesquisa.FieldByName('CINTURA').AsString;
  edtIdCorpo.Text := qryCorpo.fieldbyname('ID_CORPO').asstring;

  alterar:= 'S';

end;

procedure TfrmCorpo.DBGrid1DblClick(Sender: TObject);
begin
  showmessage(qryCorpo.fieldbyname('data').asstring + ':  ' + qryCorpo.fieldbyname('obs').asstring);
end;

end.
