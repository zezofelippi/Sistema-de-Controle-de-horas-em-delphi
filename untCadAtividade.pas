unit untCadAtividade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DB, IBCustomDataSet, IBQuery,
  IBDatabase;

type
  TfrmCadAtividade = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtAtividade: TEdit;
    rdgTipo: TRadioGroup;
    Button1: TButton;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    edtObs: TEdit;
    edtAtiCodigo: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    edtAtividadePesquisa: TEdit;
    rdgTipoPesquisa: TRadioGroup;
    Button2: TButton;
    dsPesquisar: TDataSource;
    qryPesquisa: TIBQuery;
    qryPesquisaATI_CODIGO: TIntegerField;
    qryPesquisaATI_DESCRICAO: TIBStringField;
    qryPesquisaATI_OBS: TIBStringField;
    qryPesquisaATI_TIPO: TIBStringField;
    qry_trans_local: TIBQuery;
    IBTransLocal: TIBTransaction;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure limpa_campos(Sender : TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAtividade: TfrmCadAtividade;
  alterar: string;

implementation

uses untModulo;

{$R *.dfm}

procedure TfrmCadAtividade.limpa_campos(Sender: TObject);
begin
  edtAtividade.Clear;
  edtObs.Clear;
  rdgTipo.ItemIndex:= -1;
end;

procedure TfrmCadAtividade.FormShow(Sender: TObject);
begin
  rdgTipo.ItemIndex:=-1;
  alterar:= 'N';
end;

procedure TfrmCadAtividade.Button1Click(Sender: TObject);
var
  mensagem: string;
begin
  if edtAtividade.Text = '' then
  begin
    mensagem:= 'Informe uma atividade!';
    Application.MessageBox(Pchar(mensagem), 'Informação!', MB_OK+MB_ICONWARNING);
    edtAtividade.SetFocus;
    exit;
  end;

  if rdgTipo.ItemIndex = -1 then
  begin
    mensagem:= 'Informe um tipo de atividade!';
    Application.MessageBox(Pchar(mensagem), 'Informação!', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if alterar <> 'S' then
  begin
    if (not IBTransLocal.InTransaction) then
      IBTransLocal.StartTransaction;
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('INSERT INTO CAD_ATIVIDADES (ATI_DESCRICAO, ATI_OBS, ATI_TIPO) '+
                            'VALUES (:ATI_DESCRICAO, :ATI_OBS, :ATI_TIPO) ');
  end;

  if alterar = 'S' then
  begin
    if (not IBTransLocal.InTransaction) then
      IBTransLocal.StartTransaction;
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('UPDATE CAD_ATIVIDADES SET ATI_DESCRICAO=:ATI_DESCRICAO,  '+
                            ' ATI_OBS=:ATI_OBS, ATI_TIPO=:ATI_TIPO    '+
                            'WHERE ATI_CODIGO=:ATI_CODIGO');
    qry_trans_local.ParamByName('ATI_CODIGO').AsString  := edtAtiCodigo.Text;

  end;

  qry_trans_local.ParamByName('ATI_DESCRICAO').AsString  := edtAtividade.Text;
  qry_trans_local.ParamByName('ATI_OBS').AsString  := edtObs.text;

  if rdgTipo.ItemIndex = 0 then
    qry_trans_local.ParamByName('ATI_TIPO').AsString  := 'A'
  else if rdgTipo.ItemIndex = 1 then
    qry_trans_local.ParamByName('ATI_TIPO').AsString  :=  'E'
  else
    qry_trans_local.ParamByName('ATI_TIPO').AsString  :=  'R';


  qry_trans_local.ExecSQL;
  IBTransLocal.Commit;

  limpa_campos(Sender as TObject);

  alterar := 'N'

end;

procedure TfrmCadAtividade.Button2Click(Sender: TObject);
var
  tipo, atividade : string;
begin

  if rdgTipoPesquisa.ItemIndex = 0 then
    tipo  := 'A'
  else if rdgTipoPesquisa.ItemIndex = 1 then
    tipo  :=  'E'
  else
    tipo  :=  'R';

  atividade  := ' AND UPPER(ATI_DESCRICAO) LIKE UPPER('+ #39 + '%' + edtAtividadePesquisa.Text + '%' + #39 + ')';


  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT ATI_CODIGO, ATI_DESCRICAO, ATI_OBS, ATI_TIPO '+
    ' FROM CAD_ATIVIDADES WHERE ATI_TIPO=:ATI_TIPO  ' + atividade +
    ' ORDER BY ATI_DESCRICAO');
  qryPesquisa.parambyname('ATI_TIPO').asstring := tipo;
  qryPesquisa.Open;
  qryPesquisa.FetchAll;
  qryPesquisa.First;
end;

procedure TfrmCadAtividade.DBGrid1DblClick(Sender: TObject);
begin
  edtAtividade.Text:= qryPesquisa.fieldbyname('ATI_DESCRICAO').asstring;
  edtObs.Text := qryPesquisa.fieldbyname('ATI_OBS').asstring;
  edtAtiCodigo.Text := qryPesquisa.fieldbyname('ATI_CODIGO').asstring;

  alterar:='S';

  if qryPesquisa.fieldbyname('ATI_TIPO').asstring = 'A' then
    rdgTipo.ItemIndex := 0
  else if qryPesquisa.fieldbyname('ATI_TIPO').asstring = 'E' then
    rdgTipo.ItemIndex := 1
  else
    rdgTipo.ItemIndex := 2
 
end;

end.
