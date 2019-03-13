program DEB_IBM_Daphnia;

uses
  Forms,
  Start in 'Start.pas' {Form_Start},
  Environment in 'Environment.pas' {Form_Environment},
  Population in 'Population.pas' {Form_Population},
  Individual in 'Individual.pas' {Form_Individual},
  Ecosystem in 'Ecosystem.pas' {Form_Ecosystem},
  Toxicant in 'Toxicant.pas' {Form_Toxicant},
  Output in 'Output.pas' {Form_Output},
  LoadData in 'LoadData.pas' {Form_Load},
  LoadEnvData in 'LoadEnvData.pas' {Form_LoadEnv};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Start, Form_Start);
  Application.CreateForm(TForm_Environment, Form_Environment);
  Application.CreateForm(TForm_Population, Form_Population);
  Application.CreateForm(TForm_Individual, Form_Individual);
  Application.CreateForm(TForm_Ecosystem, Form_Ecosystem);
  Application.CreateForm(TForm_Toxicant, Form_Toxicant);
  Application.CreateForm(TForm_Output, Form_Output);
  Application.CreateForm(TForm_Load, Form_Load);
  Application.CreateForm(TForm_LoadEnv, Form_LoadEnv);
  Application.Run;
end.
