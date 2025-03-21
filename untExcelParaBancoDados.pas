unit untExcelParaBancoDados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, IBQuery, IBDatabase, StrUtils;

type
  TfrmExcelParaBancoDados = class(TForm)
    edtCaminhoExcel: TEdit;
    Button2: TButton;
    IBTransLocal: TIBTransaction;
    qryTransLocal: TIBQuery;
    OpenDialog1: TOpenDialog;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExcelParaBancoDados: TfrmExcelParaBancoDados;

implementation

uses untMovimentacaoHoras, untModulo;

{$R *.dfm}

procedure TfrmExcelParaBancoDados.Button2Click(Sender: TObject);
var
  iLinhaExcel, iColunaExcel : Integer;
  objExcel : Variant;
  desconto : string;


  ArquivoCSV: TextFile;
  Contador, I, iContador : Integer;
  Linha: String;
  teste : string;

  data_str, acordar_str: string;

  // Lê Linha e Monta os valores
  function MontaValor: String;
  var
    ValorMontado, strAux: String;
    ii : integer;
  begin
    ValorMontado := '';
    I :=0;
    inc(I);
    iContador := 0;
    iColunaExcel := 1;

   { if (not IBTransLocal.InTransaction) then
      IBTransLocal.StartTransaction;

    qryTransLocal.Close;
    qryTransLocal.SQL.Clear;
    qryTransLocal.SQL.Add('INSERT INTO MOVIMENTACAO_HORA          '+
                          '(DATA, QTDE_HORAS, ATI_CODIGO, OBS, ACORDAR )       '+
                          'VALUES                                 '+
                          '(:DATA, :QTDE_HORAS, :ATI_CODIGO, :OBS, :ACORDAR ) '); }
    While Linha[I] >= ' ' do
    begin
      If Linha[I] = ';' then
      begin
        if  AnsiContainsStr(ValorMontado, '"') then
        begin
          iContador := 0;
          for ii := 1 to Length(ValorMontado) do
          begin
            strAux := ValorMontado[ii];
            if strAux = '"' then
              Inc(iContador);
          end;
          if (iContador > 1) or (iContador = 0) then
          begin
            ValorMontado :=  StringReplace(ValorMontado, '"', '', [rfReplaceAll]);
            ValorMontado :=  StringReplace(ValorMontado, ',', '.', [rfReplaceAll]);

           { if iColunaExcel = 1 then
            begin
              qryTransLocal.ParamByName('DATA').AsString := ValorMontado;
            end
            else if iColunaExcel = 2 then
            BEGIN
              qryTransLocal.ParamByName('ATI_CODIGO').asinteger := 14;
              qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
            end
            else if iColunaExcel = 3 then
            begin
              qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 15;
              qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
            end; }
           { else if iColunaExcel = 4 then
              qryTransLocal.ParamByName('VALOR_UNIT').AsString := ValorMontado
            else if iColunaExcel = 5 then
            begin
              if ValorMontado = 'Não Informado' then
                ValorMontado := '0';
              qryTransLocal.ParamByName('DESCONTO').AsString := ValorMontado;
            end
            else if iColunaExcel = 3 then
              qryTransLocal.ParamByName('VALOR_TOTAL').AsString := ValorMontado; }

            Inc(iColunaExcel);

            ValorMontado := ''   //LANCAR AQUI OS DADOS DO ValorMontado DENTRO DA TABELA
          end
          else
            ValorMontado := ValorMontado + Linha[I];
        end
        else
        begin

             ValorMontado :=  StringReplace(ValorMontado, '"', '', [rfReplaceAll]);

             ValorMontado :=  StringReplace(ValorMontado, ',', '.', [rfReplaceAll]);

           if iColunaExcel = 1 then
             data_str := ValorMontado
           else if iColunaExcel = 2 then
             acordar_str := ValorMontado
           else
           begin

             if (not IBTransLocal.InTransaction) then
              IBTransLocal.StartTransaction;

            qryTransLocal.Close;
            qryTransLocal.SQL.Clear;
            qryTransLocal.SQL.Add('INSERT INTO MOVIMENTACAO_HORA          '+
                                  '(DATA, QTDE_HORAS, ATI_CODIGO, OBS, ACORDAR )       '+
                                  'VALUES                                 '+
                                  '(:DATA, :QTDE_HORAS, :ATI_CODIGO, :OBS, :ACORDAR )');

            // if iColunaExcel = 1 then
            //    qryTransLocal.ParamByName('DATA').AsString := ValorMontado
             if iColunaExcel = 3 then
             begin
                qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 43;
                qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
                qryTransLocal.ParamByName('DATA').AsString := data_str;
                qryTransLocal.ParamByName('ACORDAR').AsString := acordar_str;
               // IF ValorMontado <> '' then
               //   qryTransLocal.ParamByName('OBS').AsString := 'TRT-MS-24';
             end;
            { else if iColunaExcel = 4 then
             begin
                qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 40;
                qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
                qryTransLocal.ParamByName('DATA').AsString := data_str;
                qryTransLocal.ParamByName('ACORDAR').AsString := acordar_str;
                //IF ValorMontado <> '' then
                //  qryTransLocal.ParamByName('OBS').AsString := 'TRT-MS-24';
             end
             else if iColunaExcel = 5 then
             begin
                qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 41;
                qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
                qryTransLocal.ParamByName('DATA').AsString := data_str;
                qryTransLocal.ParamByName('ACORDAR').AsString := acordar_str;
                //IF ValorMontado <> '' then
                //  qryTransLocal.ParamByName('OBS').AsString := 'TRT-MS-24';
             end
             else if iColunaExcel = 6 then
             begin
                qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 42;
                qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
                qryTransLocal.ParamByName('DATA').AsString := data_str;
                qryTransLocal.ParamByName('ACORDAR').AsString := acordar_str;
                //IF ValorMontado <> '' then
                //  qryTransLocal.ParamByName('OBS').AsString := 'TRT-MS-24';
             end
             else if iColunaExcel = 7 then
             begin
                qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 42;
                qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
                qryTransLocal.ParamByName('DATA').AsString := data_str;
                qryTransLocal.ParamByName('ACORDAR').AsString := acordar_str;
                //IF ValorMontado <> '' then
               //   qryTransLocal.ParamByName('OBS').AsString := 'TRT-MS-24';
             end;  }
            { else if iColunaExcel = 8 then
             begin
                qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 37;
                qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
                qryTransLocal.ParamByName('DATA').AsString := data_str;
                qryTransLocal.ParamByName('ACORDAR').AsString := acordar_str;
                //IF ValorMontado <> '' then
                //  qryTransLocal.ParamByName('OBS').AsString := 'TRT-MS-24';
             end
             else if iColunaExcel = 9 then
             begin
                qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 38;
                qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
                qryTransLocal.ParamByName('DATA').AsString := data_str;
                qryTransLocal.ParamByName('ACORDAR').AsString := acordar_str;
                //IF ValorMontado <> '' then
                //  qryTransLocal.ParamByName('OBS').AsString := 'TRT-MS-24';
             end;}


             { else if iColunaExcel = 16 then
             begin
                qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 24;
                qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
                qryTransLocal.ParamByName('DATA').AsString := data_str;
                IF ValorMontado <> '' then
                  qryTransLocal.ParamByName('OBS').AsString := 'TRT-MS-24';
             end;}

            { else if iColunaExcel = 5 then
                qryTransLocal.ParamByName('VALOR_UNIT').AsString := ValorMontado
             else if iColunaExcel = 6 then
             begin

                if ValorMontado = 'Não Informado' then
                  ValorMontado := '0';

                qryTransLocal.ParamByName('DESCONTO').AsString := ValorMontado;
             end
             else if iColunaExcel = 3 then
                qryTransLocal.ParamByName('VALOR_TOTAL').AsString := ValorMontado;  }
            qryTransLocal.ExecSQL;
            IBTransLocal.Commit;
         end;

          Inc(iColunaExcel);

          ValorMontado := ''; //LANCAR AQUI OS DADOS DO ValorMontado DENTRO DA TABELA

        end

      end
      else
        ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;

    ValorMontado :=  StringReplace(ValorMontado, '"', '', [rfReplaceAll]);

    ValorMontado :=  StringReplace(ValorMontado, ',', '.', [rfReplaceAll]);

    if iColunaExcel = 3 then
    begin
       if (not IBTransLocal.InTransaction) then
              IBTransLocal.StartTransaction;

        qryTransLocal.Close;
        qryTransLocal.SQL.Clear;
        qryTransLocal.SQL.Add('INSERT INTO MOVIMENTACAO_HORA          '+
                              '(DATA, QTDE_HORAS, ATI_CODIGO, OBS, ACORDAR )       '+
                              'VALUES                                 '+
                              '(:DATA, :QTDE_HORAS, :ATI_CODIGO, :OBS, :ACORDAR )');
       qryTransLocal.ParamByName('ATI_CODIGO').Asinteger := 43;
       qryTransLocal.ParamByName('QTDE_HORAS').AsString := ValorMontado;
       qryTransLocal.ParamByName('DATA').AsString := data_str;
       qryTransLocal.ParamByName('ACORDAR').AsString := acordar_str;
       qryTransLocal.ExecSQL;
       IBTransLocal.Commit;

    end;

  //  qryTransLocal.ExecSQL;
  //  IBTransLocal.Commit;
  end;
begin
  OpenDialog1.DefaultExt := '.csv*';
  OpenDialog1.FileName := '*.csv*';
  If OpenDialog1.Execute then
    edtCaminhoExcel.text := OpenDialog1.FileName;

  // Carregando o arquivo ...
  AssignFile(ArquivoCSV, edtCaminhoExcel.text);

  try
    Reset(ArquivoCSV);
    Readln(ArquivoCSV, Linha);
    Contador := 1;

    while not Eoln(ArquivoCSV) do
    begin
      if Contador >= 2 then
        teste := MontaValor;
      Readln(ArquivoCSV, Linha);
      Contador := Contador + 1;
    end;
    teste := MontaValor;

  finally
    CloseFile(ArquivoCSV);
  end;
end;

end.
