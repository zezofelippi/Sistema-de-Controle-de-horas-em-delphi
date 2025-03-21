unit untModulo;

interface

uses
  SysUtils, Classes, DB, IBDatabase;

type
  TfrmModulo = class(TDataModule)
    IBTransaction1: TIBTransaction;
    BD: TIBDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModulo: TfrmModulo;

implementation

{$R *.dfm}

end.
