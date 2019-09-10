unit Start;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls,ExtCtrls,
  Ecosystem, Environment, Population, Individual, Toxicant, Output,LoadData, LoadPara;

type
  TForm_Start = class(TForm)
    MainMenu1:              TMainMenu;
    Start1:                 TMenuItem;
    SingleSimulation1:      TMenuItem;
    MonteCarloSimulation1:  TMenuItem;
    Load1:                  TMenuItem;
    Save1:                  TMenuItem;
    Info1:                  TMenuItem;
    TB_Setting:             TTabControl;
    Populationdata1: TMenuItem;
    Populationresults1: TMenuItem;
    Endpoints1: TMenuItem;

    procedure TB_SettingChange(Sender: TObject);
    procedure open1Click(Sender: TObject);
    procedure close1Click(Sender: TObject);
    procedure SingleSimulation1Click(Sender: TObject);
    procedure MonteCarloSimulation1Click(Sender: TObject);
    procedure hide1Click(Sender: TObject);
    procedure show1Click(Sender: TObject);
    procedure Populationdata1Click(Sender: TObject);
    procedure Populationresults1Click(Sender: TObject);
    procedure Endpoints1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    para:T_para;
  end;

var
  Form_Start: TForm_Start;

implementation
{$R *.dfm}
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               Main menue procedures: Simulation
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
// if Monte-Carlo simulation is selected:
procedure TForm_Start.MonteCarloSimulation1Click(Sender: TObject);
begin
    Ecosystem.Form_Ecosystem.RG_Simtype.ItemIndex:=1;
    Ecosystem.Form_Ecosystem.readsettings;
    Ecosystem.Form_Ecosystem.runregularsimulation;
end;
// if single simulation run is selected:
procedure TForm_Start.SingleSimulation1Click(Sender: TObject);
begin
    Ecosystem.Form_Ecosystem.RG_Simtype.ItemIndex:=0;
    Ecosystem.Form_Ecosystem.readsettings;
    Ecosystem.Form_Ecosystem.runregularsimulation;
end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Main menue procedures: Load
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Start.Populationdata1Click(Sender: TObject);
begin
 Form_Load.loadpopdata;
 Form_Load.showloaddata;
end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Main menue procedures: Save
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Start.Populationresults1Click(Sender: TObject);
begin
  Output.Form_Output.savepopresult;
end;

procedure TForm_Start.Endpoints1Click(Sender: TObject);
begin
  Output.Form_Output.saveendpoints;
end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Main menue procedures: Output
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Start.show1Click(Sender: TObject);
begin
  Output.Form_Output.Left:=TB_setting.Left+TB_setting.Width+50;
  Output.Form_Output.Show;
end;

procedure TForm_Start.hide1Click(Sender: TObject);
begin
   Output.Form_Output.hide;
end;


procedure TForm_Start.Info1Click(Sender: TObject);
begin
 Application.Title:='DEB based IBM for Daphnia magna V1.2';
 showmessage('Copyright (c) 2019 Andre Gergs' +#10#13+  'Licensed under AGPL-3.0 ' +#10#13+ 'For details see https://www.gnu.org/licenses/agpl-3.0.txt');
end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Click procedures for Setting Tabsheets
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Start.open1Click(Sender: TObject);
begin
 TB_Setting.show;
 Form_Ecosystem.Show;
 Form_Environment.hide;
 Form_Population.hide;
 Form_Individual.hide;
 Form_Toxicant.hide;
 Form_Load.hide;
end;

procedure TForm_Start.close1Click(Sender: TObject);
begin
 TB_Setting.hide;
 Form_Ecosystem.hide;
 Form_Environment.hide;
 Form_Population.hide;
 Form_Individual.hide;
 Form_Toxicant.hide;
 Form_Load.hide;
end;

//Show and hide different forms when selecting tabs
procedure TForm_Start.TB_SettingChange(Sender: TObject);
begin
 case TB_Setting.TabIndex of
    0:begin Form_Ecosystem.Show;Form_Environment.hide;Form_Population.hide;Form_Individual.hide; Form_Toxicant.hide; end;
    1:begin Form_Environment.Show; Form_Ecosystem.hide; Form_Population.hide; Form_Individual.hide; Form_Toxicant.hide; end;
    2:begin Form_Population.Show; Form_Ecosystem.hide; Form_Environment.hide; Form_Individual.hide; Form_Toxicant.hide; end;
    3:begin Form_Individual.Show; Form_Population.hide; Form_Ecosystem.hide; Form_Environment.hide;  Form_Toxicant.hide; end;
    4:begin Form_Toxicant.Show; Form_Ecosystem.hide;Form_Environment.hide;Form_Population.hide;Form_Individual.hide; end
 end;
end;




end.
