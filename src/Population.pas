unit Population;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Contnrs, math, StdCtrls, ExtCtrls,
  Individual, Environment, Toxicant;

//---declarations of the population------------------------------------------------------
//record that saves results of population feeding rates
type
   T_feeding = record
      //Amount of  food available to population [mgC]
      availablefood:                double;
      //potential feeding rate of population [mgC/h]
      potpopfeeding:                double;
      //realized feeding rate of population  [mgC/h]
      realpopfeeding:               double;
   end;

//records that saves results of population demography:
type
   T_sizeclass = record
      //number of individuals in size class
      number:                       integer;
      //mean reserve density in size class
      mean_e:                       double;
   end;

type
//defines a class of population
  T_population = class(tobject)
    //---------parameters and state variables of the population-----------
      //List of Individuals in the Population
      poplist:                      TObjectlist;
      //Individuals in the population with properties of The class T_individual
      ind:                          T_individual;
      //total abundance of individuals in startpopulation
      initialabundance:             integer;
      //embryo information for creating new individual
      embryo_e, embryo_L, embryo_UH:double;
      //size distriution: number in size classes;
      sizeclass:                    array of T_sizeclass;
      //realized feeding rate of the population [mgC/d]
      feedingrate:                  double;
      //saves results of potential and realized feeding per hour
      feeding:                      array of T_feeding;
      //body size of individual in start population
      bodysize:                     double;
      //standard deviation of body size in start population
      SD_bodysize:                  double;
      //adult number needed for initialization of start populationn
      adult_nr:                    integer;
      //array of random numbers for acute toxicity to remove individuals
      randind:                     array of integer;
    //---------processes of the population----------------------------------
      //creates a population
      constructor create;
      //deletes a population
      destructor destroy; override; //override defines a method that replaces a virtual parent class method
      //run through individuals in a given population
      procedure runthrough (env:T_Environment);
      //calculates feeding rate of population
      procedure calculatefeedingrate (env:T_Environment);
    end;

//---declarations of parent TForm-----------------------------------------------------------
type
  TForm_Population = class(TForm)
    P_Startpop:                 TPanel;
    Label1:                     TLabel;
    E_class1_nr:                TLabeledEdit;
    E_class2_nr:                TLabeledEdit;
    E_class3_nr:                TLabeledEdit;
    L_number:                   TLabel;
    E_class1_size:              TEdit;
    E_class2_size:              TEdit;
    E_class3_size:              TEdit;
    L_size:                     TLabel;
    Panel1:                     TPanel;
    Label2:                     TLabel;
    E_class1_sizeclass:         TLabeledEdit;
    E_class3_sizeclass:         TLabeledEdit;
    L_sizeclass1:               TLabel;
    L_sizeclass3:               TLabel;
    E_Iterations:               TLabeledEdit;
    s_sizeclass3:               TEdit;
    s_sizeclass2:               TEdit;
    s_sizeclass1:               TEdit;
    Label4:                     TLabel;
    E_noeggs: TLabeledEdit;
    E_pref: TLabeledEdit;

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    env:T_Environment;
  end;

var
  Form_Population: TForm_Population;

implementation
{$R *.dfm}
{ t_population }
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Run through a population for each day of the simulation
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_population.runthrough (env:T_Environment);
var
//counter of individuals in population list (i)
i,n,s:integer;
size:double;
deadones,x:integer;//counters for acute toxicity
begin
  //goes trough population to let individuals sense their environment:
  for i := poplist.Count - 1 downto 0 do
  begin
     //Defines individual as item (i) in the list:
     ind:=poplist[i] as T_individual;
     // individual senses temperature
     ind.temp:=env.temperature;
     ind.sensetemperature;
     //individual senses population density:
     ind.density:=poplist.Count/env.volume;
     //sensing density has consequences for life history parameters:
     ind.adaptation;
     //individual toxicant exposure (internal or external concentration):
     if Environment.Form_Environment.CB_tox_on.Checked then
      begin
        ind.cW:=env.toxconcentration [env.day];
        ind.toxicokinetics;
      end;
     //sub-lethal tox effects change life history parameters:
     if Environment.Form_Environment.CB_tox_on.Checked and Toxicant.Form_Toxicant.CB_sublethal.Checked and (Toxicant.Form_Toxicant.RG_modelchoice.ItemIndex=0)
       then ind.sublethaltoxeffect;
  end;

  //calculates feeding of population and individual at actual day:
  calculatefeedingrate (env);

  //goes through population at actual day to stuggle for life:
  for i := poplist.Count - 1 downto 0 do
  begin
     //Defines individual as item (i) in the list:
     ind:=poplist[i] as T_individual;
     //individual has to struggle for life:
     ind.struggleforlife;
     //remove individual from population if dead
     if ind.alive=false then poplist.Remove(ind);
  end;

  //goes through population and randomly removes individuals when assuming acute toxicity in dose response manner:
  if (Environment.Form_Environment.CB_tox_on.Checked) and (Toxicant.Form_Toxicant.RG_modelchoice.ItemIndex=1)
   and (Toxicant.Form_Toxicant.CB_lethal.Checked) then
   begin
     for i := poplist.Count - 1 downto 0 do
     begin
        //Defines individual as item (i) in the list:
        ind:=poplist[i] as T_individual;
        //if a randomnumber exceeds fraction of survivors in dose response curve then individual is removed from population:
        if random >=(1/(1+power((ind.cw/ind.a_ec50),ind.a_slope)))then poplist.Remove(ind);
     end;
   end;

  //add new born individuals to poplist
   for i := poplist.Count - 1 downto 0 do
   begin
     //Defines individual as item (i) in the list:
     ind:=poplist[i] as T_individual;
     {a mother releases offspring when ebryo reaches maturity at birth
       new individuals are created and added to population list:}
     if ind.brood.b_UH >= ind.UBH then
     begin
        //inherits mother brood information to offspring:
         embryo_e:=ind.brood.b_e;
         embryo_L:=ind.brood.b_L;
         embryo_UH:=ind.brood.b_UH;
         for n := 0 to ind.R-1 do
          begin
             //creates new individual
             ind:=t_individual.create (embryo_e, embryo_L, embryo_UH);
             poplist.Add(ind);
          end;
     end;
   end;

//recording of size class results----------------------------------------------
  for s := 0 to length(sizeclass)-1 do
    begin
      sizeclass[s].number:=0;
      sizeclass[s].mean_e:=0;
    end;
  //goes trough apopulation:
  for i := poplist.Count - 1 downto 0 do
  begin
    ind:=poplist[i] as T_individual;
    //assign individual to first class:
    if ind.L/ind.dm < strtofloat(Form_Population.E_class1_sizeclass.text)then s:=0;
    //or assign individual to second class:
    if (ind.L/ind.dm >= strtofloat(Form_Population.E_class1_sizeclass.text))
        and (ind.L/ind.dm < strtofloat(Form_Population.E_class3_sizeclass.text)) then s:=1;
    //or assign individual to third class:
    if ind.L/ind.dm >= strtofloat(Form_Population.E_class3_sizeclass.text) then s:=2;

    //add individual to respective class
    inc(sizeclass[s].number);
    //add resderve density to respective class for calculation of mean
    sizeclass[s].mean_e:=sizeclass[s].mean_e+ind.e;
  end;
  //reserve density for calcualtation of average reserves per class:
    for s := 0 to length(sizeclass)-1 do
    begin
      if sizeclass[s].number >0 then sizeclass[s].mean_e:=sizeclass[s].mean_e/sizeclass[s].number else sizeclass[s].mean_e:=0;
    end;


end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Creates an population at start of the simulation run
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
constructor t_population.create;
var
i, number_no_eggs:integer;
culture_f:single;
begin
  inherited;  // always call at the start of a Creator
// Execute the (T_Population) constructor:
  poplist:=tobjectlist.Create(true);
  //number of adults in initial population that do carry any egggs or neonates
  number_no_eggs:=strtoint(Form_Population.E_noeggs.Text);
  //scaled fucntional response in culture conditions
  culture_f:=strtofloat(Form_Population.E_pref.Text);

//---creates class1 individuals at simulation start----------------------------
  //abundance of individual at simulation start:
  initialabundance:=strtoint(Form_Population.E_class1_nr.text);
  //mean body size of individual at simulation start:
  bodysize:=strtofloat(Form_Population.E_class1_size.text);
  SD_bodysize:=strtofloat(Form_Population.s_sizeclass1.text);
  //counter for adult number
  adult_nr:=0;
  //creates individual neonates:
  for i := 0 to initialabundance - 1 do
  begin
      ind:=t_individual.create (bodysize, SD_bodysize, adult_nr, number_no_eggs, culture_f);
      poplist.Add(ind);
  end;

//---creates class2 individuals at simulation start----------------------------
  //abundance of individual at simulation start:
  initialabundance:=strtoint(Form_Population.E_class2_nr.text);
  //mean body size of individual at simulation start:
  bodysize:=strtofloat(Form_Population.E_class2_size.text);
  SD_bodysize:=strtofloat(Form_Population.s_sizeclass2.text);
  //creates individual juvenile:
  for i := 0 to initialabundance - 1 do
  begin
      ind:=t_individual.create (bodysize, SD_bodysize, adult_nr, number_no_eggs, culture_f);
      poplist.Add(ind);
  end;

//---creates class3 individuals at simulation start----------------------------
  //abundance of individual at simulation start:
  initialabundance:=strtoint(Form_Population.E_class3_nr.text);
  //mean body size of individual at simulation start:
  bodysize:=strtofloat(Form_Population.E_class3_size.text);
  SD_bodysize:=strtofloat(Form_Population.s_sizeclass3.text);
  //creates individual adults:
  for i := 0 to initialabundance - 1 do
  begin
      ind:=t_individual.create (bodysize, SD_bodysize, adult_nr, number_no_eggs, culture_f);
      poplist.Add(ind);
      inc(adult_nr);
  end;

  setlength (feeding,24);
  setlength(sizeclass,3);
end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Calculates potential and realized feeding of a population
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_population.calculatefeedingrate;
var
//counter of hours(h) and individuals(i), time step (i) in terations (iter):
h,i,s,iter:integer;
begin
  iter:=strtoint(Form_Population.E_Iterations.Text);
  //resets population feeding rates:
  feedingrate:=0;
   for h := 0 to 24 - 1 do
    begin
      feeding[h].potpopfeeding:=0;
      feeding[h].realpopfeeding:=0;
    end;

  //Calculates daily feeding of population and individual
  for h := 0 to 24 - 1 do
    begin
        //sets available total food to the amount left from previous time step:
          case Environment.Form_Environment.RG_food.ItemIndex of
           //food on first day only
           0: begin
               if h=0 then
               begin
                 if env.day=0 then feeding[h].availablefood:=env.foodavailability[env.day]
                 //else feeding[h].availablefood:=env.foodleft[env.day-1];
                 else feeding[h].availablefood:=env.foodavailability[env.day-1];
               end;
               //hands over food from previous hour
               if h>0 then feeding[h].availablefood:=feeding[h-1].availablefood;
              end;
           //adds daily food
           1: if h=0 then feeding[h].availablefood:=env.foodavailability[env.day] else feeding[h].availablefood:=feeding[h-1].availablefood;
           //adds daily food as given in scenario
           2: if h=0 then feeding[h].availablefood:=env.foodavailability[env.day] else feeding[h].availablefood:=feeding[h-1].availablefood;
           //food in flow through scenario
           3: begin
               if h=0 then
               begin
                 if env.day=0 then feeding[h].availablefood:=env.foodavailability[env.day]
                 //else feeding[h].availablefood:=env.foodleft[env.day-1];
                 else feeding[h].availablefood:=env.foodavailability[env.day-1];
               end;
               //calculates food based on food leftover and flow rate
               if h>0 then feeding[h].availablefood:=feeding[h-1].availablefood - env.flowrate*(feeding[h-1].availablefood/env.volume)+ env.flowrate*(env.foodavailability[0]/env.volume) ;
              end;
          end;

      if feeding[h].availablefood >0 then
      begin
     //---go though Population to calculate potential feeding rate assuming unlimited food-----------
          for i := poplist.Count - 1 downto 0 do
            begin
              ind:=poplist[i] as T_individual;
              //resets the individuals ingestion rate:
              ind.ir[h]:=0;
              //calculates feeding of individual:
              feeding[h].potpopfeeding:=feeding[h].potpopfeeding+(ind.fx*ind.ill*power(ind.L,2)* (feeding[h].availablefood/env.volume)/(ind.xk+(feeding[h].availablefood/env.volume)));
            end;

     //---if enough food is available:
          if feeding[h].potpopfeeding <= feeding[h].availablefood then
            begin
              //calculates ingestion rate [mgC/h] of the individual:
              for i := poplist.Count - 1 downto 0 do
                begin
                  ind:=poplist[i] as T_individual;
                  ind.ir[h]:=(ind.fx*ind.ill*power(ind.L,2)* (feeding[h].availablefood/env.volume)/(ind.xk+(feeding[h].availablefood/env.volume)));
                  ind.fd[h]:=feeding[h].availablefood/env.volume;

                end;
                //realized feeding of population equals potential feeding:
                feeding[h].realpopfeeding:=feeding[h].potpopfeeding;
                feeding[h].availablefood:=feeding[h].availablefood-feeding[h].potpopfeeding;
            end
     //---if population likes to eat more than the amount available, then reduce time interval: h/iter
          else
              begin
               //calculate feeding for shorter timesteps by means of iterations
               for s := 0 to iter- 1 do
                 begin
                    //go through population and calculate individual feeding rate for short time inteval
                    for i := poplist.Count - 1 downto 0 do
                     begin
                          ind:=poplist[i] as T_individual;
                          if feeding[h].availablefood >0 then
                          begin
                            //calculates ingestion rate of the individual:
                            ind.ir[h]:=ind.ir[h]+((ind.fx*ind.ill*power(ind.L,2))* (feeding[h].availablefood/env.volume)/(ind.xk+(feeding[h].availablefood/env.volume))/iter);
                            //calculates population feeding rate:
                            feeding[h].realpopfeeding:=feeding[h].realpopfeeding+((ind.fx*ind.ill*power(ind.L,2))* (feeding[h].availablefood/env.volume)/(ind.xk+(feeding[h].availablefood/env.volume))/iter);
                            //calculates actual food availability:
                            feeding[h].availablefood:=feeding[h].availablefood-((ind.fx*ind.ill*power(ind.L,2))* (feeding[h].availablefood/env.volume)/(ind.xk+(feeding[h].availablefood/env.volume))/iter);

                          end; //end if
                          ind.fd[h]:=feeding[h].availablefood/env.volume;
                      end;//end individual
                 end;//end iteration
                 if feeding[h].availablefood < 0 then feeding[h].availablefood:=0;
              end;
      end;//end of if food>0 loop
    end;//End of hour loop

    //saves food leftover at the end of the day
    env.foodavailability[env.day]:=feeding[23].availablefood;
  //Sum up hourly realized feeding rate to daily feeding rate
    for h := 0 to 24 - 1 do
    begin
       feedingrate:=feedingrate+feeding[h].realpopfeeding;
    end;

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Destroys an population at the end of the simulation run
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
destructor t_population.destroy;
begin
    //Empties list of individuals:
    poplist.Free;
    inherited; // Always call at the end of a destructor
end;



end.
