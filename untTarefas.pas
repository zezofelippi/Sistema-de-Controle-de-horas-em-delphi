unit untTarefas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Mask, ToolEdit, ExtCtrls, DB,
  IBCustomDataSet, IBQuery, IBDatabase, Menus;

type
  TfrmTarefas = class(TForm)
    Label4: TLabel;
    edtData: TDateEdit;
    edtObs: TEdit;
    Label3: TLabel;
    btnGravar: TButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtDataInicial: TDateEdit;
    edtDataFinal: TDateEdit;
    edtObsPesquisa: TEdit;
    btnPesquisar: TButton;
    DBGrid1: TDBGrid;
    rdgOpcao: TRadioGroup;
    IBTransLocal: TIBTransaction;
    qry_trans_local: TIBQuery;
    PopupMenu1: TPopupMenu;
    Alterar1: TMenuItem;
    dtsTarefa: TDataSource;
    qryTarefa: TIBQuery;
    qryTarefaID_TAREFA: TIntegerField;
    qryTarefaDATA: TDateTimeField;
    qryTarefaOBS: TIBStringField;
    qryTarefaDATA_FINALIZADO: TDateTimeField;
    Finalizar1: TMenuItem;
    edtIdTarefa: TEdit;
    qryPesquisa: TIBQuery;
    qryTarefaOPCAO: TIBStringField;
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure limpa_campos(Sender : TObject);
    procedure Finalizar1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTarefas: TfrmTarefas;
  alterar: string;

implementation

{$R *.dfm}

procedure TfrmTarefas.limpa_campos(Sender: TObject);
begin
  edtData.Clear;
  edtObs.clear;
  edtIdTarefa.clear;
  edtData.Enabled:= TRUE;
  
end;

procedure TfrmTarefas.btnGravarClick(Sender: TObject);
begin
  if edtData.Text = '  /  /    ' then
  begin
    showmessage('Coloque a data');
    edtData.SetFocus;
    exit;
  end
  else if (edtObs.Text = '') then
  begin
    showmessage('Coloque algum dado na obs');
    edtObs.SetFocus;
    exit;
  end;

  if (not IBTransLocal.InTransaction) then
    IBTransLocal.StartTransaction;

  if alterar <> 'S' then
  begin
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('INSERT INTO TAREFAS (DATA, OBS, OPCAO)'+
                            'VALUES (:DATA, :OBS, :OPCAO) ');
    qry_trans_local.ParamByName('DATA').AsString  := edtData.Text;
    qry_trans_local.ParamByName('OBS').AsString  := edtObs.Text;
    qry_trans_local.ParamByName('OPCAO').AsString  := 'A';
  end
  else
  begin
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('UPDATE TAREFAS SET OBS=:OBS    '+
                            'WHERE ID_TAREFA=:ID_TAREFA');
    qry_trans_local.ParamByName('OBS').AsString  := edtObs.Text;
    qry_trans_local.ParamByName('ID_TAREFA').AsString := edtIdTarefa.Text;

  end;

  qry_trans_local.ExecSQL;
  IBTransLocal.Commit;

  limpa_campos(Sender as TObject);

  alterar := 'N';
end;

procedure TfrmTarefas.btnPesquisarClick(Sender: TObject);
var
  data1, data2, dta, obs, opcao: string;
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

  if rdgOpcao.itemindex = 0 then
    opcao:= ' AND UPPER(OPCAO) LIKE ''A'' '
  else if rdgOpcao.itemindex = 1 then
    opcao:= ' AND UPPER(OPCAO) LIKE ''F'' '
  else
    opcao := '';  


  qryTarefa.Close;
  qryTarefa.SQL.Clear;
  qryTarefa.SQL.Add('SELECT * FROM TAREFAS WHERE 1=1 ' + dta + obs + opcao +
    'ORDER BY DATA');
  qryTarefa.Open;
  qryTarefa.FetchAll;

end;

procedure TfrmTarefas.FormShow(Sender: TObject);
begin
  rdgOpcao.ItemIndex:=0;
  alterar:= 'N';
end;

procedure TfrmTarefas.Alterar1Click(Sender: TObject);
begin
  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT DATA, OBS FROM TAREFAS '+
   ' WHERE ID_TAREFA=:ID_TAREFA');
  qryPesquisa.parambyname('ID_TAREFA').asstring:= qryTarefa.fieldbyname('ID_TAREFA').asstring;
  qryPesquisa.Open;

  edtData.Text:= qryPesquisa.fieldbyname('DATA').asstring;
  edtData.Enabled:=false;
  edtObs.Text:= qryPesquisa.FieldByName('obs').AsString;
  edtIdTarefa.Text := qryTarefa.fieldbyname('ID_TAREFA').asstring;

  alterar:= 'S';
end;

procedure TfrmTarefas.Finalizar1Click(Sender: TObject);
begin
  //verifica se tarefa ja foi finalizada, se for nao pode mais finalizar
  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT ID_TAREFA, OPCAO FROM TAREFAS '+
   ' WHERE ID_TAREFA=:ID_TAREFA');
  qryPesquisa.parambyname('ID_TAREFA').asstring:= qryTarefa.fieldbyname('ID_TAREFA').asstring;
  qryPesquisa.Open;

  if qryPesquisa.FieldByName('OPCAO').asstring = 'F' then
  begin
    showmessage('A Tarefa ' + qryPesquisa.FieldByName('ID_TAREFA').asstring + ' já foi finalizada');
    exit;
  end;
  //fim verifica se tarefa ja foi finalizada, se for nao pode mais finalizar

  case MessageBox (Application.Handle, Pchar ('Tem certeza que deseja Finalizar N. ' + qryTarefa.FieldByName('ID_TAREFA').AsString + ' ?'),'Alerta', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON1) of
  IDYES:
  begin

    if not IBTRANSLOCAL.InTransaction then
      IBTRANSLOCAL.StartTransaction;
      qry_trans_local.Close;
      qry_trans_local.SQL.Clear;
      qry_trans_local.SQL.Add('UPDATE TAREFAS SET OPCAO=:OPCAO, DATA_FINALIZADO=:DATA_FINALIZADO  '+
                            'WHERE ID_TAREFA=:ID_TAREFA');
      qry_trans_local.ParamByName('OPCAO').AsString  := 'F';
      qry_trans_local.ParamByName('DATA_FINALIZADO').asDateTime  := now;
      qry_trans_local.ParamByName('ID_TAREFA').AsString := qryTarefa.FieldByName('ID_TAREFA').AsString;
      qry_trans_local.execsql;
    IBTRANSLOCAL.Commit;

  end;//YES
    IDNO : Exit;
  end; //FIM CASE
end;

procedure TfrmTarefas.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  IF (qryTarefa.FieldByName('OPCAO').AsString = 'F' ) then
    DBGrid1.Canvas.Brush.Color := clAqua;

  if (gdSelected in state) then
    with (Sender as TDBGrid).Canvas do
    begin
    Font.Style  := [fsbold];
    DBGrid1.Canvas.Brush.Color := clWhite;

    IF (qryTarefa.FieldByName('OPCAO').AsString = 'F' ) then
      DBGrid1.Canvas.Brush.Color := clAqua;

    end;

  dbgrid1.Canvas.Font.Color:= clBlack;

  dbgrid1.Canvas.FillRect(Rect);
  dbgrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmTarefas.DBGrid1TitleClick(Column: TColumn);
var
  campo, data1, data2, dta, obs, opcao: string;
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

  if rdgOpcao.itemindex = 0 then
    opcao:= ' AND UPPER(OPCAO) LIKE ''A'' '
  else if rdgOpcao.itemindex = 1 then
    opcao:= ' AND UPPER(OPCAO) LIKE ''F'' '
  else
    opcao := '';

  qryTarefa.Close;
  qryTarefa.SQL.Clear;
  qryTarefa.SQL.Add('SELECT ID_TAREFA, DATA, OBS, DATA_FINALIZADO, OPCAO FROM TAREFAS WHERE 1=1 ' + dta + obs + opcao +
      'ORDER BY ' + campo);
  qryTarefa.Open;
  qryTarefa.FetchAll;

end;

procedure TfrmTarefas.DBGrid1DblClick(Sender: TObject);
begin
  showmessage(qryTarefa.fieldbyname('obs').asstring);
end;

end.
