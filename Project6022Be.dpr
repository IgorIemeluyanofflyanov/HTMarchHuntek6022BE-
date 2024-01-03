program Project6022Be;

uses
  Vcl.Forms,
  UnitHTMarchHuntek6022BE in 'UnitHTMarchHuntek6022BE.pas' {FormHTMarchHuntek6022BE};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormHTMarchHuntek6022BE, FormHTMarchHuntek6022BE);
  Application.Run;
end.
