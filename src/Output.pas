unit Output;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, grids,
  Vcl.StdCtrls, VclTee.TeeGDIPlus;

//---Endpoints calculated from data that is produced in simulation runs----------------------------
type
  T_popresult=record //Endpoints listed per day as e.g endpoint.popresult[d].abundance_mean
    //Endoints of total abundance of individuals
    mean_abundance, lower_abundance, upper_abundance: array of double;
    //Reserve density in cohorts as means of MC simulations
    e_sizeclass: array of double;
    //Extinction probability: ratio of populations that went extinct to number of Monte-Carlo simulations
    extprob: double;
    //total abundance in each Monte-Carlo simulation
    MC_total_abundance: array of double;

    //Endpoint food dynamics
    popfeedingrate_mean, popfeedingrate_min, popfeedingrate_max:      double;
   end;

type
  T_endpoint=record
    //Array of population results as saved per day
    popresult:array of T_popresult;
    //Population growth rate
    lambda: double;
    //population density at certain day x
    density: double;
    //population mean density over time
    meandensity: double;
    //maximum density
    maxdensity:double;
    //extintion probability at day x:
    extprobdayx:double;
    //maximum number of concentrations to be simulated in dose response
    concnr:integer;
    //concentration simulated:
    concentration:double;
    //actual number of simulated concnetration
    nr:integer;
    //number of Monte-Carlo simulations
    MC_no:integer;
  end;


//---declarations of parent TForm-----------------------------------------------------------
type
  TForm_Output = class(TForm)
    PC_Output:              TPageControl;
    TS_Population:          TTabSheet;
    Chart_totalabundance:   TChart;
    S_total_min:            TLineSeries;
    S_total_mean:           TLineSeries;
    S_total_max:            TLineSeries;
    ProgressBar1:           TProgressBar;
    Chart_neonates:         TChart;
    S_neonates_min:         TLineSeries;
    S_neonates_mean:        TLineSeries;
    S_neonates_max:         TLineSeries;
    Chart_juvenile:         TChart;
    S_juveniles_min:        TLineSeries;
    S_juveniles_mean:       TLineSeries;
    S_juveniles_max:        TLineSeries;
    Chart_adults:           TChart;
    S_adults_min:           TLineSeries;
    S_adults_mean:          TLineSeries;
    S_adults_max:           TLineSeries;
    S_data_total:           TPointSeries;
    S_data_class1:          TPointSeries;
    S_data_class2:          TPointSeries;
    S_data_class3:          TPointSeries;
    SaveDialog1:            TSaveDialog;
    TS_Food:                TTabSheet;
    Chart_feedingrate:      TChart;
    S_feedingrate_min:      TLineSeries;
    S_feedingrate_mean:     TLineSeries;
    S_feedingrate_max:      TLineSeries;
    Chart_reserves:         TChart;
    S_neonate_e:            TLineSeries;
    S_juvenile_e:           TLineSeries;
    S_adult_e:              TLineSeries;
    TS_Statistics:          TTabSheet;
    TS_Numbers:             TTabSheet;
    SG_Numbers:             TStringGrid;
    Memo1:                  TMemo;
    Chart1:                 TChart;
    S_extprob:              TLineSeries;
    SG_endpoints:           TStringGrid;
    SaveDialog2:            TSaveDialog;
    Memo2:                  TMemo;

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  endpoint:                 T_endpoint;
  procedure showpopresults (endpoint:T_endpoint);
  procedure showendpoints (endpoint:T_endpoint);
  procedure cleareverything;
  procedure savepopresult;
  procedure saveendpoints;
  end;

var
    Form_Output: TForm_Output;

implementation
{$R *.dfm}
{ TForm_Output }
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Show model endpoints in table
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Output.showendpoints(endpoint:T_endpoint);
begin
//set string grid for dynamics in numbers
SG_endpoints.rowcount:=endpoint.concnr+2;
SG_endpoints.Cells[0,0]:='Toxicant Concentration';
SG_endpoints.Cells[1,0]:='Population growth rate [1/d]';
SG_endpoints.Cells[2,0]:='Population density[#/ml]';
SG_endpoints.Cells[3,0]:='Population density max [#/ml]';
SG_endpoints.Cells[4,0]:='Extinction probability [-]';
SG_endpoints.Cells[5,0]:='Mean density[#/ml]';

//endpoint.lambda:=round( endpoint.lambda,2);

SG_endpoints.Cells[0,endpoint.nr+1]:=floattostr(endpoint.concentration);
SG_endpoints.Cells[1,endpoint.nr+1]:=floattostr(endpoint.lambda);
SG_endpoints.Cells[2,endpoint.nr+1]:=floattostr(endpoint.density);
SG_endpoints.Cells[3,endpoint.nr+1]:=floattostr(endpoint.maxdensity);
SG_endpoints.Cells[4,endpoint.nr+1]:=floattostr(endpoint.extprobdayx);
SG_endpoints.Cells[5,endpoint.nr+1]:=floattostr(endpoint.meandensity);

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Show model output in Graphs
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Output.showpopresults(endpoint:T_endpoint);
var
//Day counter (d)
d,i,m:integer;
line, name:string;
begin
//set string grid for dynamics in numbers
SG_numbers.rowcount:=length(endpoint.popresult);
SG_numbers.Cells[0,0]:='Time [d]';
SG_numbers.Cells[1,0]:='Total mean';
SG_numbers.Cells[2,0]:='Total min';
SG_numbers.Cells[3,0]:='Total max';
SG_numbers.Cells[4,0]:='Class 1 mean';
SG_numbers.Cells[5,0]:='Class 1 min';
SG_numbers.Cells[6,0]:='Class 1 max';
SG_numbers.Cells[7,0]:='Class 2 mean';
SG_numbers.Cells[8,0]:='Class 2 min';
SG_numbers.Cells[9,0]:='Class 2 max';
SG_numbers.Cells[10,0]:='Class 3 mean';
SG_numbers.Cells[11,0]:='Class 3 min';
SG_numbers.Cells[12,0]:='Class 3 max';
SG_numbers.Cells[13,0]:='Extinction probability';

//shows result for each day:
for d := 0 to length(endpoint.popresult) - 1 do
begin
    //Graphs for population endpoints
    S_total_min.AddXY(d+1,endpoint.popresult[d].lower_abundance[0]);
    S_total_mean.AddXY(d+1,endpoint.popresult[d].mean_abundance[0]);
    S_total_max.AddXY(d+1,endpoint.popresult[d].upper_abundance[0]);
    S_neonates_min.AddXY(d+1,endpoint.popresult[d].lower_abundance[1]);
    S_neonates_mean.AddXY(d+1,endpoint.popresult[d].mean_abundance[1]);
    S_neonates_max.AddXY(d+1,endpoint.popresult[d].upper_abundance[1]);
    S_juveniles_min.AddXY(d+1,endpoint.popresult[d].lower_abundance[2]);
    S_juveniles_mean.AddXY(d+1,endpoint.popresult[d].mean_abundance[2]);
    S_juveniles_max.AddXY(d+1,endpoint.popresult[d].upper_abundance[2]);
    S_adults_min.AddXY(d+1,endpoint.popresult[d].lower_abundance[3]);
    S_adults_mean.AddXY(d+1,endpoint.popresult[d].mean_abundance[3]);
    S_adults_max.AddXY(d+1,endpoint.popresult[d].upper_abundance[3]);

    //sting grid for population endpoint
    SG_numbers.Cells[0,d+1]:=inttostr(d+1);
    SG_numbers.Cells[1,d+1]:=floattostr(endpoint.popresult[d].mean_abundance[0]);
    SG_numbers.Cells[2,d+1]:=floattostr(endpoint.popresult[d].lower_abundance[0]);
    SG_numbers.Cells[3,d+1]:=floattostr(endpoint.popresult[d].upper_abundance[0]);
    SG_numbers.Cells[4,d+1]:=floattostr(endpoint.popresult[d].mean_abundance[1]);
    SG_numbers.Cells[5,d+1]:=floattostr(endpoint.popresult[d].lower_abundance[1]);
    SG_numbers.Cells[6,d+1]:=floattostr(endpoint.popresult[d].upper_abundance[1]);
    SG_numbers.Cells[7,d+1]:=floattostr(endpoint.popresult[d].mean_abundance[2]);
    SG_numbers.Cells[8,d+1]:=floattostr(endpoint.popresult[d].lower_abundance[2]);
    SG_numbers.Cells[9,d+1]:=floattostr(endpoint.popresult[d].upper_abundance[2]);
    SG_numbers.Cells[10,d+1]:=floattostr(endpoint.popresult[d].mean_abundance[3]);
    SG_numbers.Cells[11,d+1]:=floattostr(endpoint.popresult[d].lower_abundance[3]);
    SG_numbers.Cells[12,d+1]:=floattostr(endpoint.popresult[d].upper_abundance[3]);
    SG_numbers.Cells[13,d+1]:=floattostr(endpoint.popresult[d].extprob);

    //Graphs for food dynamics
    S_feedingrate_min.AddXY(d,endpoint.popresult[d].popfeedingrate_min);
    S_feedingrate_mean.AddXY(d,endpoint.popresult[d].popfeedingrate_mean);
    S_feedingrate_max.AddXY(d,endpoint.popresult[d].popfeedingrate_max);

    //Graphs for scaled reserve density
    S_neonate_e.AddXY(d,endpoint.popresult[d].e_sizeclass[0]);
    S_juvenile_e.AddXY(d,endpoint.popresult[d].e_sizeclass[1]);
    S_adult_e.AddXY(d,endpoint.popresult[d].e_sizeclass[2]);

    //Graph for statistics
    S_extprob.AddXY(d,endpoint.popresult[d].extprob);
end;
 //writes string results into memo for saving results:
 for I := 0 to SG_numbers.rowcount-1 do
 begin
   line:=SG_numbers.Cells[0,i] +','+ SG_numbers.Cells[1,i]+','+ SG_numbers.Cells[2,i]+','+ SG_numbers.Cells[3,i]
         +','+ SG_numbers.Cells[4,i]+','+ SG_numbers.Cells[5,i]+','+ SG_numbers.Cells[6,i]
         +','+ SG_numbers.Cells[7,i]+','+ SG_numbers.Cells[8,i]+','+ SG_numbers.Cells[9,i]
         +','+ SG_numbers.Cells[10,i]+','+ SG_numbers.Cells[11,i]+','+ SG_numbers.Cells[12,i]
         +','+ SG_numbers.Cells[13,i]  ;
   memo1.Lines.Add(line);
 end;

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Clear graphs and stuff
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Output.cleareverything;
var
i:integer;
begin
   S_total_min.Clear;
   S_total_mean.Clear;
   S_total_max.Clear;
   S_feedingrate_min.Clear;
   S_feedingrate_mean.Clear;
   S_feedingrate_max.Clear;
   S_neonate_e.Clear;
   S_juvenile_e.Clear;
   S_adult_e.Clear;
   S_neonates_min.clear;
   S_neonates_mean.clear;
   S_neonates_max.clear;
   S_juveniles_min.clear;
   S_juveniles_mean.clear;
   S_juveniles_max.clear;
   S_adults_min.clear;
   S_adults_mean.clear;
   S_adults_max.clear;
   S_extprob.clear;
   memo1.lines.clear;
   memo2.lines.clear;
   for i := 0 to SG_numbers.RowCount - 1 do SG_numbers.Rows[i].Clear;
   for i := 0 to SG_endpoints.RowCount - 1 do SG_endpoints.Rows[i].Clear;

end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Save model output to csv file
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Output.saveendpoints;
var
line,name:string;
i:integer;
begin
 //writes string results into memo for saving results:
 for I := 0 to SG_endpoints.rowcount-1 do
 begin
   line:=SG_endpoints.Cells[0,i] +','+ SG_endpoints.Cells[1,i]+','+ SG_endpoints.Cells[2,i]+','+ SG_endpoints.Cells[3,i]+','+ SG_endpoints.Cells[4,i]+','+ SG_endpoints.Cells[5,i] ;
   memo2.Lines.Add(line);
 end;
 //saves memo content to file:
 savedialog2.Filter := 'CSV (Comma delimited) (*.csv)|*.CSV';
 name := savedialog2.FileName;
 If Copy(name,Pos('.',name),Length(name)-Pos('.',name)+1) <> '.csv' Then name := name + '.csv';
 if savedialog2.Execute then memo2.Lines.SaveToFile(savedialog2.filename);
end;

procedure TForm_Output.savepopresult;
var
name:string;
begin
 //saves to file:
 savedialog1.Filter := 'CSV (Comma delimited) (*.csv)|*.CSV';
 name := savedialog1.FileName;
 If Copy(name,Pos('.',name),Length(name)-Pos('.',name)+1) <> '.csv' Then name := name + '.csv';
 if savedialog1.Execute then memo1.Lines.SaveToFile(savedialog1.filename);
end;


end.
