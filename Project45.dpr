program Project45;

uses
  Forms,
  Unit52 in 'Unit52.pas' {Form52};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm52, Form52);
  Application.Run;
end.
