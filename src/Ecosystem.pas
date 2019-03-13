unit Ecosystem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, math,
  Population, Output, Environment, LoadData, LoadEnvData, Toxicant;

//---Declarations for ecosystem settings-----------------------------------------------------------
type
  T_eco=record
   //simulation time  [d]
   simtime:integer;
   //number of simulations: single simulations=1, MC-Simulations=xxx
   simnumber:integer;
end;


//---Data produced in simulation runs-------------------------------------------------------------
type
  T_simdata=record      //Data are saved in an array of array of record per MC-Simulation and per day for endpoint calculation in unit Output
    //Total abundance in size classes/cohorts
     cohort_abundance:     array of integer;
     //Mean reserve density in size classes/cohorts
     cohort_e:             array of double;
    //Population feeding rate [mg/(d*pop)]
    popfeedingrate:double;
    //food leftover [mgC]
    foodleft:double;
  end;

//---declarations of parent TForm-------------------------------------------------------------------
type
  TForm_Ecosystem = class(TForm)
    Panel2: TPanel;
    Label2: TLabel;
    E_t1: TLabeledEdit;
    E_t2: TLabeledEdit;
    E_timex: TLabeledEdit;
    E_extday: TLabeledEdit;
    RG_MC: TRadioGroup;
    RG_Simtype: TRadioGroup;
    procedure simulationrun;
    procedure runregularsimulation;
    procedure readsettings;

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    eco:                     T_eco;
    Simdata:                 array of array of T_simdata;
    pop:                     T_population;
    env:                     T_environment;
    endpoint:                T_endpoint;
    fooddata:                T_fooddata;
    procedure calculatepopendpoints;
  end;

var
  Form_Ecosystem: TForm_Ecosystem;

implementation
{$R *.dfm}
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Run Population simulation
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Ecosystem.simulationrun;
var
//Counter for Monte-Carlo simulation(m) and time [days] (d)
m,d:integer;
begin

//run through simulations
  for m := 0 to eco.simnumber - 1 do
    begin
    //create a population
     pop:=T_population.create;

     //run through time
        for d := 0 to eco.simtime - 1 do
          begin
           //saves day of simulation in environment:
             env.day:=d;
           //calculates food availability per day by considering leftovers from previous day:

             //consider weekly media renewal
             if Form_Environment.CB_media_renewal.checked then
             begin
               if d=0 then env.foodavailability[d]:= env.foodtotal[d]
              else
               begin
                 if (d/7)=trunc(d/7) then env.foodavailability[d]:= env.foodtotal[d]
                 else
                 env.foodavailability[d]:= env.foodtotal[d]+env.foodleft[d-1];
               end;
             end
             //no weekly media renewal
             else
             begin
               if d=0 then env.foodavailability[d]:= env.foodtotal[d]
                else env.foodavailability[d]:= env.foodtotal[d]+env.foodleft[d-1];
             end;


           //runs through population:
             pop.runthrough (env);
           //computes food leftover on actual day:
             env.foodleft[d]:=env.foodtotal[d]-pop.feedingrate;
             if env.foodleft[d] <0 then   env.foodleft[d]:=0;

           //saves total abundance and cohort abandance as well as mean reserve density on actual day for actual MC simulation:
             setlength (simdata[m,d].cohort_abundance, 4);
             setlength (simdata[m,d].cohort_e, 3);
             //total abundance:
             simdata[m,d].cohort_abundance[0]:=pop.poplist.Count;
             //abundance class 1:
             simdata[m,d].cohort_abundance[1]:=pop.sizeclass[0].number;
             //abundance class 2:
             simdata[m,d].cohort_abundance[2]:=pop.sizeclass[1].number;
             //abundance class 3:
             simdata[m,d].cohort_abundance[3]:=pop.sizeclass[2].number;
             //mean reserve density class 1:
             simdata[m,d].cohort_e[0]:=pop.sizeclass[0].mean_e;
             //mean reserve density class 2:
             simdata[m,d].cohort_e[1]:=pop.sizeclass[1].mean_e;
             //mean reserve density class 3:
             simdata[m,d].cohort_e[2]:=pop.sizeclass[2].mean_e;
             //saves feeding rate of the population on actual day:
             simdata[m,d].popfeedingrate:=pop.feedingrate;
             //saves amount of food that was left ona actual day:
             simdata[m,d].foodleft:=env.foodleft[d];
          end;//End of time loop
     //delete the population
     pop.destroy;

     Output.Form_Output.Progressbar1.Position:=(m+1);
    end;//End of Monte-Carlo Loop
    //calculate population endpoints from simulation results
    calculatepopendpoints;
    //show population endpoints in diagram and table
    Output.Form_Output.showpopresults (endpoint);
    //shows statistical endpoints in table:
    Output.Form_Output.showendpoints(endpoint);
    //shows diagrams at the end of the simulation
    Output.Form_Output.Show;
end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Single setting simulation
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Ecosystem.runregularsimulation;
begin
   //Create array to save simulation results for each simulation and each day
  setlength (Simdata,eco.simnumber,eco.simtime);
  //create an environment
  env:=T_Environment.create;
  //sets toxicant concentration in the environment:
   if Form_Environment.CB_tox_on.checked then env.readtoxicant;
  //runs Monte-Carlo or sinlge simulation:
  simulationrun;
end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Read settings clear everything
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Ecosystem.readsettings;
var
simnr:integer;
begin
  //---Settings of Ecosystem----------------------------------------------------
  case RG_MC.ItemIndex of
    0: simnr:=10;   //10 MC simulations
    1: simnr:=100;  //100 MC simulations
    2: simnr:=1000; //1000 MC simulations
  end;

  case RG_Simtype.ItemIndex of
    0:eco.simnumber:=1;
    1:eco.simnumber:=simnr;
    2:eco.simnumber:=simnr;
  end;

  eco.simtime:=strtoint(Environment.Form_Environment.E_Simtime.Text);

   //---Set progress bar---------------------------------------------------------
   Output.Form_Output.ProgressBar1.Min:=0;
   Output.Form_Output.ProgressBar1.Max:=eco.simnumber;
  //---Clear diagrams and other output------------------------------------------
  Output.Form_Output.cleareverything;
  //Set initial simulation number 0:
  endpoint.nr:=0;  endpoint.concnr:=0; endpoint.concentration:=0;
end;



{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Calculate endpoints of model simulations
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Ecosystem.calculatepopendpoints;
var
//Counter for Monte-Carlo simulation(m) and time [days] (d)
m,d,c:integer;
SumSq, Conf, z,t,s, pop1, pop2: double;
begin
  setlength (endpoint.popresult,eco.simtime);
  endpoint.MC_no:=eco.simnumber;

//----calculates every day endpoints--------------------------------------------
  for d := 0 to eco.simtime - 1 do
  begin
      //resets endpoints before calculating value for each day:
      setlength (endpoint.popresult[d].mean_abundance, 4);
      setlength (endpoint.popresult[d].lower_abundance, 4);
      setlength (endpoint.popresult[d].upper_abundance, 4);
      setlength (endpoint.popresult[d].e_sizeclass,3);
      setlength (endpoint.popresult[d].MC_total_abundance,eco.simnumber);

      endpoint.popresult[d].popfeedingrate_min:=100000000000;
      endpoint.popresult[d].popfeedingrate_mean:=0;
      endpoint.popresult[d].popfeedingrate_max:=0;
      endpoint.popresult[d].extprob:=0;

      //sets mean of class c to 0:
      for c := 0 to 3 do
       begin
          //c=0: total abundance; c=1-C=3: Classes 1-3
          endpoint.popresult[d].mean_abundance[c]:=0;
          endpoint.popresult[d].lower_abundance[c]:=10000000000;
          endpoint.popresult[d].upper_abundance[c]:=0;
          if c<3 then endpoint.popresult[d].e_sizeclass[c]:=0;
       end;


      //runs through monte carlo simulations for calculating min, mean & max:
      for m := 0 to eco.simnumber - 1 do
      begin
      //total abundances-----------------------------------------------------------------
        //mean and range of population feeding rate:
          endpoint.popresult[d].popfeedingrate_mean:=endpoint.popresult[d].popfeedingrate_mean+simdata[m,d].popfeedingrate;
          if simdata[m,d].popfeedingrate < endpoint.popresult[d].popfeedingrate_min then endpoint.popresult[d].popfeedingrate_min:= simdata[m,d].popfeedingrate;
          if simdata[m,d].popfeedingrate > endpoint.popresult[d].popfeedingrate_max then endpoint.popresult[d].popfeedingrate_max:= simdata[m,d].popfeedingrate;

          for c := 0 to 3 do
          begin
            //abundances:
            endpoint.popresult[d].mean_abundance[c]:=endpoint.popresult[d].mean_abundance[c]+simdata[m,d].cohort_abundance[c];
            //reserve densities:
            if c<3 then endpoint.popresult[d].e_sizeclass[c]:=endpoint.popresult[d].e_sizeclass[c]+simdata[m,d].cohort_e[c];
            //saves total abundance individual simulation run to endpoint array
            if c=0 then endpoint.popresult[d].MC_total_abundance[m]:=simdata[m,d].cohort_abundance[c];
          end;
          //summs up number of populations that went extinct:
          if simdata[m,d].cohort_abundance[0]<=0 then  endpoint.popresult[d].extprob:=endpoint.popresult[d].extprob+1;


       end;//End of MC loop

       //calculates mean values:
        for c := 0 to 3 do
          begin
            endpoint.popresult[d].mean_abundance[c]:=endpoint.popresult[d].mean_abundance[c]/eco.simnumber;
            if c<3 then endpoint.popresult[d].e_sizeclass[c]:=endpoint.popresult[d].e_sizeclass[c]/eco.simnumber;;
          end;
        endpoint.popresult[d].popfeedingrate_mean:=endpoint.popresult[d].popfeedingrate_mean/eco.simnumber;

       //calculates extinction probability:
       endpoint.popresult[d].extprob:=endpoint.popresult[d].extprob/eco.simnumber;


//calculates minimum and maximum-------------------------------------------------------------------------

        //runs through classes
        for c:= 0 to 3 do
         begin
          //runs through MC simulations:
           for m := 0 to eco.simnumber - 1 do
            begin
              if endpoint.popresult[d].lower_abundance[c]> simdata[m,d].cohort_abundance[c]
                 then  endpoint.popresult[d].lower_abundance[c]:= simdata[m,d].cohort_abundance[c];
              if endpoint.popresult[d].upper_abundance[c]< simdata[m,d].cohort_abundance[c]
                 then  endpoint.popresult[d].upper_abundance[c]:= simdata[m,d].cohort_abundance[c];
            end;//MC
         end;//class
  end;//End of day loop

//----calculates population growth rate--------------------------------------------
   // if growth rate is calculated from day 0 then reads numbers from edits (t1=0), otherwise from population result array with d=0 in simulation is day 1 in final output (t1=d+1):
    if strtoint(E_t1.text)=0 then pop1:=strtofloat(Population.Form_Population.E_class1_nr.Text)+ strtofloat(Population.Form_Population.E_class2_nr.Text)+strtofloat(Population.Form_Population.E_class3_nr.Text)
    else pop1:=endpoint.popresult[strtoint(E_t1.text)+1].mean_abundance[0];
   //accordingly secont point in time is t2=d+1
    pop2:=endpoint.popresult[strtoint(E_t2.text)+1].mean_abundance[0];
   //calculates population growth rate lambda:
    if pop2>pop1 then endpoint.lambda:=(ln(pop2) - ln(pop1))/(strtoint(E_t2.text)-strtoint(E_t1.text))
    else endpoint.lambda:=0;//will be later indicated as no/negative growth

//----saves population abundance at day x and maximum density----------------------
    endpoint.density:= endpoint.popresult[strtoint(E_timex.text)+1].mean_abundance[0]/strtofloat(Environment.Form_Environment.E_volume.text);
    endpoint.maxdensity:=0;  endpoint.meandensity:=0;
    for d := 0 to eco.simtime - 1 do
     begin
      if endpoint.maxdensity < endpoint.popresult[d].mean_abundance[0] then endpoint.maxdensity := endpoint.popresult[d].mean_abundance[0];
      endpoint.meandensity:=endpoint.meandensity+ endpoint.popresult[d].mean_abundance[0];
     end;
    endpoint.meandensity:=endpoint.meandensity/(eco.simtime*env.volume);
    endpoint.maxdensity:=endpoint.maxdensity/strtofloat(Environment.Form_Environment.E_volume.text);
    endpoint.extprobdayx:=endpoint.popresult[strtoint(E_extday.Text)].extprob;
    endpoint.concnr:=1;
    endpoint.concentration:=strtofloat(Toxicant.Form_Toxicant.E_tox_concentration.Text);



end;//End procedure


end.
