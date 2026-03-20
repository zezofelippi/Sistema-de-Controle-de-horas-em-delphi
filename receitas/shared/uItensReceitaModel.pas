unit uItensReceitaModel;

interface

uses uReceitaModel;

type
  TItensReceita = class
    private
      FId: integer;
      FIngrediente: string;
      FReceita: TReceita;
    public
      property id : integer read FId write FId;
      property ingrediente : string read FIngrediente write FIngrediente;
      property receita : TReceita read FReceita write FReceita;

      constructor create;
      destructor destroy;
  end;

implementation

{ TItensReceita }

constructor TItensReceita.create;
begin
  inherited;
  receita:= TReceita.create;
end;

destructor TItensReceita.destroy;
begin
  receita.free;
  inherited;
end;

end.
