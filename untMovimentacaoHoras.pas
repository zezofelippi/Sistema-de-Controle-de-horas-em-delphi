unit untMovimentacaoHoras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Mask, DBCtrls, ToolEdit, DB,
  IBCustomDataSet, IBQuery, IBDatabase, DBClient, Menus, ExtCtrls;

type
  TfrmMovimentacaoHoras = class(TForm)
    GroupBox1: TGroupBox;
    Label4: TLabel;
    edtData: TDateEdit;
    cboAtividade: TDBLookupComboBox;
    Label1: TLabel;
    edtTempo: TMaskEdit;
    lbl3: TLabel;
    Label2: TLabel;
    edtObs: TEdit;
    btnSalvar: TButton;
    DBGrid1: TDBGrid;
    dsAtividade: TDataSource;
    qryAtividade: TIBQuery;
    qryAtividadeATI_CODIGO: TIntegerField;
    qryAtividadeATIVIDADE: TIBStringField;
    GroupBox2: TGroupBox;
    lbl1: TLabel;
    txt_data_i: TDateEdit;
    txt_data_f: TDateEdit;
    lbl2: TLabel;
    btnPesquisar: TButton;
    edtIdMovimentacaoHora: TEdit;
    IBTransLocal: TIBTransaction;
    qry_trans_local: TIBQuery;
    cdsGrid: TClientDataSet;
    dsGrid: TDataSource;
    qryPesquisa: TIBQuery;
    qryPesqAux: TIBQuery;
    Label3: TLabel;
    edtAcordar: TMaskEdit;
    PopupMenu1: TPopupMenu;
    Alterar1: TMenuItem;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    rdgTipoPesquisa: TRadioGroup;
    Label7: TLabel;
    edtObsPesquisa: TEdit;
    GroupBox4: TGroupBox;
    edtDias: TEdit;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure limpa_campos(Sender : TObject);
    procedure edtDataKeyPress(Sender: TObject; var Key: Char);
    procedure edtTempoKeyPress(Sender: TObject; var Key: Char);
    procedure cboAtividadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtObsKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure cboAtividadeExit(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure rdgTipoPesquisaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMovimentacaoHoras: TfrmMovimentacaoHoras;
  alterar: string;

implementation

uses untModulo;

{$R *.dfm}

procedure TfrmMovimentacaoHoras.limpa_campos(Sender: TObject);
begin
  edtData.Clear;
  edtTempo.Clear;
  cboAtividade.KeyValue := null;
  edtObs.clear;
end;

procedure TfrmMovimentacaoHoras.btnSalvarClick(Sender: TObject);
var
  mensagem, data_pesquisa: string;
begin
  if edtData.Text = '  /  /    ' then
  begin
    showmessage('Coloque a data');
    edtData.SetFocus;
    exit;
  end;

  if cboAtividade.Text = '' then
  begin
    mensagem:= 'Informe uma atividade!';
    Application.MessageBox(Pchar(mensagem), 'Informação!', MB_OK+MB_ICONWARNING);
    cboAtividade.SetFocus;
    exit;
  end;

  if edtTempo.Text = '  :  ' then
  begin
    mensagem:= 'Informe uma quantidade de tempo!';
    Application.MessageBox(Pchar(mensagem), 'Informação!', MB_OK+MB_ICONWARNING);
    edtTempo.SetFocus;
    exit;
  end;

  if edtAcordar.Text = '  :  ' then
  begin
    mensagem:= 'Informe a hora que acordou!';
    Application.MessageBox(Pchar(mensagem), 'Informação!', MB_OK+MB_ICONWARNING);
    edtAcordar.SetFocus;
    exit;
  end;


  //Verifica se atividade ja foi lançada no dia/////

 // data_pesquisa:= Copy(edtData.Text,4,3) + Copy(edtData.Text,1,3) + Copy(edtData.Text,7,4)+ ' 00:00:00';
  data_pesquisa:=  Copy(edtData.Text,1,3) +  Copy(edtData.Text,4,3) + Copy(edtData.Text,7,4)+ ' 00:00:00';

  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT QTDE_HORAS FROM MOVIMENTACAO_HORA  '+
   ' WHERE DATA=:DATA AND ATI_CODIGO=:ATI_CODIGO ');
  qryPesquisa.parambyname('DATA').asstring:= data_pesquisa;
  qryPesquisa.parambyname('ATI_CODIGO').asstring:= cboAtividade.KeyValue;
  qryPesquisa.Open;
  qryPesquisa.FetchAll;

  IF not (qryPesquisa.IsEmpty) and (alterar <> 'S') then
  begin
     if (not IBTransLocal.InTransaction) then
      IBTransLocal.StartTransaction;
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('UPDATE MOVIMENTACAO_HORA SET QTDE_HORAS=:QTDE_HORAS, OBS=:OBS '+
                            'WHERE ATI_CODIGO=:ATI_CODIGO and DATA=:DATA');
    qry_trans_local.parambyname('DATA').AsDateTime:= edtData.Date;
    qry_trans_local.parambyname('ATI_CODIGO').asstring:= cboAtividade.KeyValue;
    qry_trans_local.parambyname('QTDE_HORAS').AsTime:=  qryPesquisa.fieldbyname('QTDE_HORAS').AsDateTime + strtotime(edtTempo.Text);
    qry_trans_local.parambyname('OBS').asstring:= edtObs.Text;

    qry_trans_local.ExecSQL;
    IBTransLocal.Commit;


    //GRAVAR HORA DE ACORDAR////////

    if (not IBTransLocal.InTransaction) then
      IBTransLocal.StartTransaction;
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('UPDATE MOVIMENTACAO_HORA SET ACORDAR=:ACORDAR '+
                            'WHERE DATA=:DATA');
    qry_trans_local.parambyname('DATA').AsDateTime:= edtData.Date;
    qry_trans_local.ParamByName('ACORDAR').AsString  := edtAcordar.text;

    qry_trans_local.ExecSQL;
    IBTransLocal.Commit;

    ///FIM GRAVAR HORA DE ACORDAR//////////


    limpa_campos(Sender as TObject);

    alterar := 'N';

    exit;

  end;

  //FIM Verifica se atividade ja foi lançada no dia/////


  if alterar <> 'S' then
  begin
    if (not IBTransLocal.InTransaction) then
      IBTransLocal.StartTransaction;
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('INSERT INTO MOVIMENTACAO_HORA (DATA, QTDE_HORAS, ATI_CODIGO, OBS, ACORDAR)'+
                            'VALUES (:DATA, :QTDE_HORAS, :ATI_CODIGO, :OBS, :ACORDAR)   ');
  end;

  if alterar = 'S' then
  begin
    if (not IBTransLocal.InTransaction) then
      IBTransLocal.StartTransaction;
    qry_trans_local.Close;
    qry_trans_local.SQL.Clear;
    qry_trans_local.SQL.Add('UPDATE MOVIMENTACAO_HORA SET ACORDAR=:ACORDAR,  '+
                            ' QTDE_HORAS=:QTDE_HORAS, OBS=:OBS    '+
                            'WHERE DATA=:DATA and ATI_CODIGO=:ATI_CODIGO');

    cboAtividade.enabled:= true;
    edtData.enabled:= true;
    edtAcordar.Enabled:= true;

  end;

  qry_trans_local.ParamByName('DATA').AsString  := edtData.Text;
  qry_trans_local.ParamByName('QTDE_HORAS').AsString  := edtTempo.text;
  qry_trans_local.ParamByName('ATI_CODIGO').AsString  := cboAtividade.keyvalue;
  qry_trans_local.ParamByName('OBS').AsString  := edtObs.text;

  if edtAcordar.text <> '  :  ' then
    qry_trans_local.ParamByName('ACORDAR').AsString  := edtAcordar.text;


  qry_trans_local.ExecSQL;
  IBTransLocal.Commit;

  limpa_campos(Sender as TObject);

  if alterar = 'S' then
     edtAcordar.Clear;

  alterar := 'N';

end;

procedure TfrmMovimentacaoHoras.FormShow(Sender: TObject);
begin
  rdgTipoPesquisa.ItemIndex:=0;

  qryAtividade.Close;
  qryAtividade.SQL.Clear;
  qryAtividade.SQL.Add('SELECT ATI_CODIGO, ATI_DESCRICAO AS ATIVIDADE FROM CAD_ATIVIDADES   '+
   'WHERE ATI_TIPO=:ATI_TIPO '+
   'ORDER BY ATI_DESCRICAO');
  qryAtividade.parambyname('ATI_TIPO').asstring:= 'A';
  qryAtividade.Open;
  qryAtividade.FetchAll;

  alterar:= 'N';
  edtData.setfocus;
end;

procedure TfrmMovimentacaoHoras.edtDataKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key =#13 then
    edtTempo.SetFocus;
end;

procedure TfrmMovimentacaoHoras.edtTempoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key =#13 then
    cboAtividade.setfocus;
end;

procedure TfrmMovimentacaoHoras.cboAtividadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    edtObs.SetFocus;
end;

procedure TfrmMovimentacaoHoras.edtObsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key =#13 then
    btnSalvar.SetFocus;
end;

procedure TfrmMovimentacaoHoras.btnPesquisarClick(Sender: TObject);
var
  nomeColuna, tipo, data1, data2, dta, obs: string;
  i: integer;
  qtde_horas : TTime;
  Horas, Minutos, TotalMinutos, TotalHoras: Integer;
  qtde_horas_total: string;

begin
  /////TITULOS DA GRID////////////
  cdsGrid.close;
  cdsGrid.FieldDefs.Clear;
  cdsGrid.FieldDefs.Add('DATA', ftString, 18, false);

  if rdgTipoPesquisa.ItemIndex = 0 then
    tipo  := 'A'
  else if rdgTipoPesquisa.ItemIndex = 1 then
    tipo  :=  'E'
  else if rdgTipoPesquisa.ItemIndex = 2 then
    tipo  :=  'R'
  else
    tipo := '';

  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT ATI_CODIGO, ATI_DESCRICAO FROM CAD_ATIVIDADES   ');
  if tipo <> '' then
    qryPesquisa.SQL.Add('WHERE ATI_TIPO=:ATI_TIPO ');
  qryPesquisa.SQL.Add('ORDER BY ATI_DESCRICAO');
  if tipo <> '' then
    qryPesquisa.parambyname('ATI_TIPO').asstring:= tipo;
  qryPesquisa.Open;
  qryPesquisa.FetchAll;

 // qtde_horas_total:= 0;

  while not qryPesquisa.eof do
  begin
    cdsGrid.FieldDefs.Add(qryPesquisa.fieldbyname('ATI_DESCRICAO').asstring, ftString, 10, false);
    qryPesquisa.next;
  end;

  cdsGrid.FieldDefs.Add('TOTAL', ftString, 10, false);
  cdsGrid.FieldDefs.Add('ACORDAR', ftString, 10, false);
  cdsGrid.CreateDataSet;
  /////FIM TITULOS DA GRID////////////

  data1 := Copy(txt_data_i.Text,4,3) + Copy(txt_data_i.Text,1,3) + Copy(txt_data_i.Text,7,4) + ' 00:00:00';
  data2 := Copy(txt_data_f.Text,4,3) + Copy(txt_data_f.Text,1,3) + Copy(txt_data_f.Text,7,4) + ' 23:59:59';

  if (txt_data_i.Text <> '  /  /    ') and (txt_data_f.Text <> '  /  /    ') then
    dta := ' AND MH.DATA BETWEEN '+ #39 + data1 + #39 + ' AND '+ #39 + data2 + #39
  else
    dta := '';

  if edtObsPesquisa.Text <> '' then
    obs:= ' AND UPPER(OBS) LIKE UPPER('+ #39 + '%' + edtObsPesquisa.Text + '%' + #39 + ')';
 // else
 //   obs:= '';

  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT DATA  ');
  qryPesquisa.SQL.Add(' FROM MOVIMENTACAO_HORA MH INNER JOIN CAD_ATIVIDADES CA ON MH.ATI_CODIGO = CA.ATI_CODIGO ');
  qryPesquisa.SQL.Add(' WHERE 1=1 ');
  if tipo <> '' then
    qryPesquisa.SQL.Add('AND CA.ATI_TIPO=:ATI_TIPO ');
  if dta <> '' then
    qryPesquisa.SQL.Add( dta );
  if edtObsPesquisa.Text <> '' then
    qryPesquisa.SQL.Add( obs );
  qryPesquisa.SQL.Add(' GROUP BY DATA ');
  qryPesquisa.SQL.Add(' ORDER BY DATA');
  if tipo <> '' then
    qryPesquisa.parambyname('ATI_TIPO').asstring:= tipo;
  qryPesquisa.Open;
  qryPesquisa.FetchAll;
  qryPesquisa.First;

  TotalMinutos := 0;

  while not qryPesquisa.eof do
  begin
    if qryPesquisa.fieldbyname('DATA').asstring <> '' then
    begin
      i := 0;
      cdsGrid.Append;
      cdsGrid.FieldByName('DATA').AsString := qryPesquisa.fieldbyname('DATA').asstring;

      qryPesqAux.Close;
      qryPesqAux.SQL.Clear;
      qryPesqAux.SQL.Add('SELECT ATI_DESCRICAO, QTDE_HORAS, OBS, ACORDAR  ');
      qryPesqAux.SQL.Add(' FROM MOVIMENTACAO_HORA MH INNER JOIN CAD_ATIVIDADES CA ON MH.ATI_CODIGO = CA.ATI_CODIGO ');
      qryPesqAux.SQL.Add(' WHERE DATA=:DATA ');
      if tipo <> '' then
        qryPesqAux.SQL.Add('AND CA.ATI_TIPO=:ATI_TIPO ');
      if edtObsPesquisa.Text <> '' then
        qryPesqAux.SQL.Add( obs );
      qryPesqAux.SQL.Add(' ORDER BY ATI_DESCRICAO');
      qryPesqAux.parambyname('DATA').AsDateTime:= qryPesquisa.fieldbyname('DATA').AsDateTime;
      if tipo <> '' then
        qryPesqAux.parambyname('ATI_TIPO').asstring:= tipo;
      qryPesqAux.Open;
      qryPesqAux.FetchAll;
      qryPesqAux.First;

      qtde_horas:=0;

      while (i < DBGrid1.Columns.Count) do
      begin
        nomeColuna := DBGrid1.Columns[i].FieldName;

        if (nomeColuna <> 'DATA') and (nomeColuna <> 'TOTAL') and (nomeColuna = qryPesqAux.fieldbyname('ATI_DESCRICAO').asstring) then
           //and (qryPesqAux.fieldbyname('QTDE_HORAS').asstring <> '') then
        begin
          IF qryPesqAux.fieldbyname('OBS').asstring <> '' then
            cdsGrid.FieldByName(nomeColuna).AsString := qryPesqAux.fieldbyname('QTDE_HORAS').asstring + '_'
          ELSE
            cdsGrid.FieldByName(nomeColuna).AsString := qryPesqAux.fieldbyname('QTDE_HORAS').asstring;

          if qryPesqAux.fieldbyname('QTDE_HORAS').asstring <> '' then
          begin
            qtde_horas:= qtde_horas + StrToTime(qryPesqAux.fieldbyname('QTDE_HORAS').asstring);//soma horas por dia

            // Converte 'HH:MM' para horas e minutos
            Horas := StrToInt(Copy(qryPesqAux.fieldbyname('QTDE_HORAS').asstring, 1, Pos(':', qryPesqAux.fieldbyname('QTDE_HORAS').asstring) - 1)); // Pega a parte das horas
            Minutos := StrToInt(Copy(qryPesqAux.fieldbyname('QTDE_HORAS').asstring, Pos(':', qryPesqAux.fieldbyname('QTDE_HORAS').asstring) + 1, 2));

            // Soma tudo em minutos
            TotalMinutos := TotalMinutos + (Horas * 60) + Minutos;

            //qtde_horas_total:= qtde_horas_total + StrToTime(qryPesqAux.fieldbyname('QTDE_HORAS').asstring);
          end;

         // cdsGrid.FieldByName('ACORDAR').AsString := qryPesqAux.fieldbyname('ACORDAR').asstring;

          qryPesqAux.Next;
        end;
        cdsGrid.FieldByName('TOTAL').AsString := timetostr(qtde_horas);
       //cdsGrid.FieldByName('TOTAL').AsFloat := qtde_horas;
        Inc(i);  // Incrementa o índice
      end;

      cdsGrid.FieldByName('ACORDAR').AsString := qryPesqAux.fieldbyname('ACORDAR').asstring;

      cdsGrid.post;
    end;
    qryPesquisa.Next;
  end;
  cdsGrid.Append;
  cdsGrid.post;


   cdsGrid.Append;
   /////Calcular total hora por coluna/////////////
   qtde_horas := 0;
 //  cdsGrid.First;

  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT ATI_DESCRICAO,                       ');
 // qryPesquisa.SQL.Add(' case when (QTDE_HORAS/3600) > 10 then ''0''||(QTDE_HORAS/3600) else (QTDE_HORAS/3600) end ||'':''||  ');
  qryPesquisa.SQL.Add(' case when (QTDE_HORAS/3600) > 10 then ''''||(QTDE_HORAS/3600) else (QTDE_HORAS/3600) end ||'':''||  ');
  qryPesquisa.SQL.Add('    CASE when ((QTDE_HORAS-((QTDE_HORAS)/3600)*3600)/60) < 10 then                                    ');
 // qryPesquisa.SQL.Add(' ''0''||((QTDE_HORAS-((QTDE_HORAS)/3600)*3600)/60) else                                               ');
  qryPesquisa.SQL.Add(' ''0''||((QTDE_HORAS-((QTDE_HORAS)/3600)*3600)/60) else                                               ');
  qryPesquisa.SQL.Add('((QTDE_HORAS-((QTDE_HORAS)/3600)*3600)/60) end AS TOTAL_HORAS                                         ');

  qryPesquisa.SQL.Add('FROM                                                                                                   ');
  qryPesquisa.SQL.Add('(                                                                                                      ');
  qryPesquisa.SQL.Add('SELECT ATI_DESCRICAO,                                                                                  ');
  qryPesquisa.SQL.Add('    CAST(SUM(                                                                                          ');
  qryPesquisa.SQL.Add('        EXTRACT( HOUR FROM QTDE_HORAS ) * 3600 +                                                       ');
  qryPesquisa.SQL.Add('        EXTRACT( MINUTE FROM QTDE_HORAS ) * 60 +                                                       ');
  qryPesquisa.SQL.Add('        EXTRACT( SECOND FROM QTDE_HORAS )                                                              ');
  qryPesquisa.SQL.Add('    ) AS INTEGER) AS QTDE_HORAS                                                                        ');


  qryPesquisa.SQL.Add(' FROM MOVIMENTACAO_HORA MH INNER JOIN CAD_ATIVIDADES CA ON MH.ATI_CODIGO = CA.ATI_CODIGO ');
  qryPesquisa.SQL.Add('WHERE 1=1 ');
  if tipo <> '' then
    qryPesquisa.SQL.Add('AND CA.ATI_TIPO=:ATI_TIPO ');
  if dta <> '' then
    qryPesquisa.SQL.Add( dta );
  if edtObsPesquisa.Text <> '' then
    qryPesquisa.SQL.Add( obs );
  qryPesquisa.SQL.Add(' GROUP BY ATI_DESCRICAO )');
  qryPesquisa.SQL.Add(' ORDER BY ATI_DESCRICAO');
  if tipo <> '' then
    qryPesquisa.parambyname('ATI_TIPO').asstring:= tipo;
  qryPesquisa.Open;
  qryPesquisa.FetchAll;
  qryPesquisa.First;

   while not qryPesquisa.Eof do
   begin
    // if cdsGrid.fieldbyname('ACADEMIA').asstring <> '' then
    //  qtde_horas := qtde_horas + strtotime(Copy(cdsGrid.fieldbyname('ACADEMIA').asstring, 1, 8));
     cdsGrid.fieldbyname(qryPesquisa.fieldbyname('ATI_DESCRICAO').asstring).asstring:= qryPesquisa.fieldbyname('TOTAL_HORAS').asstring;
     qryPesquisa.Next;
   end;
  //cdsGrid.fieldbyname('ACADEMIA').asstring:= timetostr(qtde_horas);
  /////FIM Calcular total hora por coluna/////////////

  // Converte de volta para HH:MM, garantindo que pode ultrapassar 24 horas
  TotalHoras := TotalMinutos div 60;
  TotalMinutos := TotalMinutos mod 60;

  qtde_horas_total := Format('%d:%2.2d', [TotalHoras, TotalMinutos]);

  cdsGrid.FieldByName('DATA').AsString := 'TOTAL';
  cdsGrid.FieldByName('TOTAL').AsString :=  qtde_horas_total;
 // cdsGrid.FieldByName('TOTAL').AsString := timetostr(qtde_horas_total);
  cdsGrid.post;

  edtDias.Text := inttostr(cdsGrid.RecordCount - 2) + ' dias pesquisados'; //-2 é para NAO contar linha verde escuro e TOTAL

end;

procedure TfrmMovimentacaoHoras.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  caracter: string;
  Texto: string;
  TextoLargura, TextoAltura, PosX, PosY: Integer;
begin


  // Verifica se a célula pertence ao cabeçalho (título da coluna)
  if (gdFixed in State) then
  begin
    DBGrid1.Canvas.FillRect(Rect);  // Preenche fundo corretamente
    DBGrid1.Canvas.Font.Style := [fsBold]; // Deixa o título em negrito
    
    // Calcula a posição central do título
    PosX := Rect.Left + ((Rect.Right - Rect.Left) div 2) - (DBGrid1.Canvas.TextWidth(Column.Title.Caption) div 2);
    PosY := Rect.Top + ((Rect.Bottom - Rect.Top) div 2) - (DBGrid1.Canvas.TextHeight(Column.Title.Caption) div 2);

    // Desenha o título centralizado
    DBGrid1.Canvas.TextRect(Rect, PosX, PosY, Column.Title.Caption);

    Exit; // Sai para evitar desenhar o conteúdo da célula sobre o título
  end;

  // ----- Código para células normais -----
  Texto := Column.Field.AsString;

  // Obtém largura e altura do texto
  TextoLargura := DBGrid1.Canvas.TextWidth(Texto);
  TextoAltura := DBGrid1.Canvas.TextHeight(Texto);

  // Calcula a posição central da célula
  PosX := Rect.Left + ((Rect.Right - Rect.Left) div 2) - (TextoLargura div 2);
  PosY := Rect.Top + ((Rect.Bottom - Rect.Top) div 2) - (TextoAltura div 2);

  // Preenche o fundo corretamente
  DBGrid1.Canvas.FillRect(Rect);

  // Verifica regras para colorir as células
  caracter := Copy(Column.Field.AsString, Length(Column.Field.AsString), 1);

  if caracter = '_' then
    DBGrid1.Canvas.Brush.Color := clAqua;

  if cdsGrid.FieldByName('DATA').AsString = '' then
    DBGrid1.Canvas.Brush.Color := clGreen;

  if cdsGrid.FieldByName('DATA').AsString = 'TOTAL' then
    DBGrid1.Canvas.Font.Size := 11;

  // Desenha o texto centralizado
  DBGrid1.Canvas.TextRect(Rect, PosX, PosY, Texto); 


end;

procedure TfrmMovimentacaoHoras.DBGrid1DblClick(Sender: TObject);
var
  data_pesquisa: string;
begin
 //  showmessage(DBGrid1.SelectedField.FieldName );
 //  showmessage(cdsGrid.Fields[0].AsString);

  data_pesquisa:=  Copy(cdsGrid.Fields[0].AsString,1,3) +  Copy(cdsGrid.Fields[0].AsString,4,3) + Copy(cdsGrid.Fields[0].AsString,7,4)+ ' 00:00:00';

  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT DATA, QTDE_HORAS, OBS, ACORDAR, CA.ATI_CODIGO FROM MOVIMENTACAO_HORA MH INNER JOIN CAD_ATIVIDADES CA ON MH.ATI_CODIGO = CA.ATI_CODIGO '+
   ' WHERE DATA=:DATA AND ATI_DESCRICAO=:ATI_DESCRICAO ');
  qryPesquisa.parambyname('DATA').asstring:= data_pesquisa;
  qryPesquisa.parambyname('ATI_DESCRICAO').asstring:= DBGrid1.SelectedField.FieldName;
  qryPesquisa.Open;
  qryPesquisa.FetchAll;

  showmessage(qryPesquisa.fieldbyname('data').asstring + '  ' + qryPesquisa.fieldbyname('qtde_horas').asstring +
    '  ' + DBGrid1.SelectedField.FieldName + ' OBS: ' + qryPesquisa.fieldbyname('OBS').asstring);

end;

procedure TfrmMovimentacaoHoras.cboAtividadeExit(Sender: TObject);
var
  data_pesquisa: string;
begin

  if (cboAtividade.text = '') or (edtData.Text = '  /  /    ') then
    exit;

  data_pesquisa:=  Copy(edtData.Text,1,3) +  Copy(edtData.Text,4,3) + Copy(edtData.Text,7,4)+ ' 00:00:00';

  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT OBS FROM MOVIMENTACAO_HORA  '+
   ' WHERE DATA=:DATA AND ATI_CODIGO=:ATI_CODIGO ');
  qryPesquisa.parambyname('DATA').asstring:= data_pesquisa;
  qryPesquisa.parambyname('ATI_CODIGO').asstring:= cboAtividade.KeyValue;
  qryPesquisa.Open;
  qryPesquisa.FetchAll;

  edtObs.Text:= qryPesquisa.fieldbyname('OBS').asstring;

end;

procedure TfrmMovimentacaoHoras.Alterar1Click(Sender: TObject);
var
  data_pesquisa : string;
begin
 // showmessage(DBGrid1.SelectedField.FieldName);
 // showmessage(cdsGrid.Fields[0].AsString);

  data_pesquisa:=  Copy(cdsGrid.Fields[0].AsString,1,3) +  Copy(cdsGrid.Fields[0].AsString,4,3) + Copy(cdsGrid.Fields[0].AsString,7,4)+ ' 00:00:00';

  qryPesquisa.Close;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT DATA, QTDE_HORAS, OBS, ACORDAR, CA.ATI_CODIGO FROM MOVIMENTACAO_HORA MH INNER JOIN CAD_ATIVIDADES CA ON MH.ATI_CODIGO = CA.ATI_CODIGO '+
   ' WHERE DATA=:DATA AND ATI_DESCRICAO=:ATI_DESCRICAO ');
  qryPesquisa.parambyname('DATA').asstring:= data_pesquisa;
  qryPesquisa.parambyname('ATI_DESCRICAO').asstring:= DBGrid1.SelectedField.FieldName;
  qryPesquisa.Open;
  qryPesquisa.FetchAll;

  edtData.Text:= qryPesquisa.fieldbyname('DATA').asstring;
  edtData.Enabled:=false;
  edtAcordar.Text:= FormatDateTime('hh:nn', StrToTime(qryPesquisa.FieldByName('Acordar').AsString));
  edtAcordar.Enabled:=false;
  cboAtividade.KeyValue := qryPesquisa.fieldbyname('ATI_CODIGO').asstring;
  cboAtividade.Enabled:=FALSE;

  edtTempo.Text := FormatDateTime('hh:nn', StrToTime(qryPesquisa.FieldByName('QTDE_HORAS').AsString));
  edtObs.Text:= qryPesquisa.FieldByName('obs').AsString;

  alterar:= 'S';

  //qryPesquisa.parambyname('QTDE_HORAS').asstring:= edtTempo.Text;
  //qryPesquisa.parambyname('OBS').asstring:= edtObs.Text;



end;

procedure TfrmMovimentacaoHoras.rdgTipoPesquisaClick(Sender: TObject);
var
  tipo: string;
begin

  cboAtividade.KeyValue := -1;

  if rdgTipoPesquisa.ItemIndex = 0 then
    tipo  := 'A'
  else if rdgTipoPesquisa.ItemIndex = 1 then
    tipo  :=  'E'
  else if rdgTipoPesquisa.ItemIndex = 2 then
    tipo  :=  'R'
  else
    tipo := '';

  qryAtividade.Close;
  qryAtividade.SQL.Clear;
  qryAtividade.SQL.Add('SELECT ATI_CODIGO, ATI_DESCRICAO AS ATIVIDADE FROM CAD_ATIVIDADES   ');
  if tipo <> '' then
    qryAtividade.SQL.Add('WHERE ATI_TIPO=:ATI_TIPO ');
  qryAtividade.SQL.Add('ORDER BY ATI_DESCRICAO');
  if tipo <> '' then
    qryAtividade.parambyname('ATI_TIPO').asstring:= tipo;
  qryAtividade.Open;
  qryAtividade.FetchAll;

  edtObs.clear;

end;

end.
