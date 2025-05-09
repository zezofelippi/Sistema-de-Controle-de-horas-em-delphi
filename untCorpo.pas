unit untCorpo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, ToolEdit, CurrEdit, Grids, DBGrids, DB,
  IBCustomDataSet, IBQuery, IBDatabase;

type
  TfrmCorpo = class(TForm)
    edtData: TDateEdit;
    Label4: TLabel;
    lbl3: TLabel;
    edtPeso: TCurrencyEdit;
    Button1: TButton;
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
    procedure Button1Click(Sender: TObject);
    procedure limpa_campos(Sender : TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCorpo: TfrmCorpo;

implementation

uses untModulo;

{$R *.dfm}

procedure TfrmCorpo.limpa_campos(Sender: TObject);
begin
  edtData.Clear;
  edtPeso.clear;
end;

procedure TfrmCorpo.Button1Click(Sender: TObject);
begin
  if edtData.Text = '  /  /    ' then
  begin
    showmessage('Coloque a data');
    edtData.SetFocus;
    exit;
  end;

   if (not IBTransLocal.InTransaction) then
      IBTransLocal.StartTransaction;
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('INSERT INTO CORPO (DATA, PESO, CINTURA)'+
                            'VALUES (:DATA, :PESO, :CINTURA) ');
    qry_trans_local.ParamByName('DATA').AsString  := edtData.Text;
    qry_trans_local.ParamByName('PESO').AsFloat  :=  edtPeso.Value;
    qry_trans_local.ParamByName('CINTURA').AsFloat  :=  edtCintura.Value;

    qry_trans_local.ExecSQL;
    IBTransLocal.Commit;

    qryCorpo.Close;
    qryCorpo.SQL.Clear;
    qryCorpo.SQL.Add('SELECT ID_CORPO, DATA, PESO, CINTURA FROM CORPO   '+
      'ORDER BY DATA');
    qryCorpo.Open;
    qryCorpo.FetchAll;


end;

procedure TfrmCorpo.FormShow(Sender: TObject);
begin
  qryCorpo.Close;
  qryCorpo.SQL.Clear;
  qryCorpo.SQL.Add('SELECT ID_CORPO, DATA, PESO, CINTURA FROM CORPO   '+
   'ORDER BY DATA');
  qryCorpo.Open;
  qryCorpo.FetchAll;
end;

end.
