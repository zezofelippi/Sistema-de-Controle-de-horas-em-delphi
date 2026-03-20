unit uReceitaModel;

interface

type

  TReceita = class
    private
      FId: integer;
      FTituloReceita: string;
      FModoPreparo: string;
    public
      property id: integer read FId write  FId;
      property tituloReceita: string read FTituloReceita write FTituloReceita;
      property modoPreparo: string read FModoPreparo write FModoPreparo;  

  end;

implementation

end.
