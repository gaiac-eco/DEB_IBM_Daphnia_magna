unit Environment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, math,
  toxicant, LoadEnvData;

type
 T_Environment = class
   volume:               integer;              //Volume [ml] or dry mass [mg] of the environment
   day:                  integer;              //day of simulation
   foodtotal:            array of double;      //Total amount of food [mgC per enviroment and day]; note: in Form given as food density!
   foodavailability:     array of double;      //Total amount of food [mgC per enviroment and day] + leftovers from previous day
   flowrate:             double;               //Flwo rate in flow through scenario [ml/h]
   foodleft:             array of double;      //Total amount of food [mgC per enviroment and day] - population feeding rate
   fooddata:             T_fooddata;           //Food data as read from file
   toxconcentration:     array of double;      //Concentration of a toxicant [mg/l]
   toxdata:              T_toxdata;            //Exposure scenario
   temperature:          double;               //Environmental temperature [°C]
   constructor create;
   procedure readfood;
   procedure readtoxicant;
 end;


type
  TForm_Environment = class(TForm)
    P_food:             TPanel;
    RG_food:            TRadioGroup;
    E_fooddensity:      TLabeledEdit;
    E_volume:           TLabeledEdit;
    RG_Sytemtype:       TRadioGroup;
    E_Simtime:          TLabeledEdit;
    RG_foodcalculation: TRadioGroup;
    CB_tox_on:          TCheckBox;
    E_flow: TLabeledEdit;
    E_temperature: TLabeledEdit;
    CB_media_renewal: TCheckBox;
    procedure RG_SytemtypeClick(Sender: TObject);
    procedure RG_foodcalculationClick(Sender: TObject);
    procedure RG_foodClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    //env:                T_environment;
  end;

var
  Form_Environment: TForm_Environment;

implementation
{$R *.dfm}

uses LoadData;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       Selection of ecosystem type and food scenario: change of labelling
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Environment.RG_foodcalculationClick(Sender: TObject);
begin
   case RG_foodcalculation.ItemIndex of
     0: begin E_fooddensity.EditLabel.Caption:='Food denstiy [mgC/ml]'; E_fooddensity.text:=floattostr(0.001); end;
     1: begin E_fooddensity.EditLabel.Caption:='Food total [mgC]'; E_fooddensity.text:=floattostr(1); end;
   end;
end;

procedure TForm_Environment.RG_foodClick(Sender: TObject);
begin
  if RG_Food.itemindex =3 then E_flow.Visible:=true
  else  E_flow.Visible:=false;
end;

procedure TForm_Environment.RG_SytemtypeClick(Sender: TObject);
begin
   case RG_Sytemtype.ItemIndex of
    0: begin E_volume.EditLabel.Caption:='Volume [ml]';   E_volume.text:=inttostr(1000);
             RG_food.ItemIndex:=1; E_fooddensity.EditLabel.Caption:='Food density [mgC/ml]'; end;
    1: begin E_volume.EditLabel.Caption:='Dry mass [mg]'; E_volume.text:=inttostr(10);
             RG_food.ItemIndex:=0; E_fooddensity.EditLabel.Caption:='Food density [mgC/mg]'; end;
   end;
end;

{ T_Environment }
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Create environment and read environmental settings
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
constructor T_Environment.create;
begin
   //Sets ecosystem volume [ml] or dry weight [mg]:
   volume:=strtoint(Form_Environment.E_volume.text);
   //sets flow rate for flow through
   flowrate:=strtofloat(Form_Environment.E_flow.Text);
   //Sets amount of food in environment [mgC] for each day:
   readfood;
   //sets toxicant concentration in the environment:
   //if Form_Environment.CB_tox_on.checked then readtoxicant;
   //Set environmental temperature
   temperature:=strtofloat(Form_Environment.E_temperature.text);
end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Read food settings
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_Environment.readfood;
var
d, simtime:integer;
food:double;
begin
   simtime:=strtoint(Form_Environment.E_Simtime.Text);
   setlength (foodtotal,simtime);
   setlength (foodavailability,simtime);
   setlength (foodleft,simtime);

    case Form_Environment.RG_foodcalculation.ItemIndex of
     0: food:=strtofloat(Form_Environment.E_Fooddensity.Text)*volume;
     1: food:=strtofloat(Form_Environment.E_Fooddensity.Text);
    end;

   case Form_Environment.RG_food.ItemIndex of
    //food given once in the beginning:
    0: foodtotal[0]:=food;
    //food given every day
    1: begin
         for d := 0 to simtime - 1 do
          begin
             foodtotal[d]:=food;
          end;
       end;
    //food given every day, but different ammounts as read from file:
    2: begin
          //reads food seetings from file data array:
          fooddata:=T_Fooddata.create;
          //saves food setting as read from file in food array
          for d := 0 to simtime - 1 do
          begin
              foodtotal[d]:= fooddata.foodamount [d];
          end;
       end;
    //food given once in the beginning:
    3: foodtotal[0]:=food;
   end;

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Read toxicant exposure
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_Environment.readtoxicant;
var
d, dt, simtime:integer;
begin
   //sets simulation time:
   simtime:=strtoint(Form_Environment.E_Simtime.Text);
   //Sets length of toxconcentration array
   setlength (toxconcentration,simtime);
   //sets day counter for peak exposure =0:
   dt:=0;
   //if multiple peak scenario is read from fiel:
   if Form_Toxicant.RG_exposure_scenario.ItemIndex=2 then toxdata:=T_toxdata.create;

   //Sets exposure concentration for each day
   for d := 0 to simtime - 1 do
       begin
          case Form_Toxicant.RG_exposure_scenario.ItemIndex of
              //sets constant exposure:
              0: toxconcentration[d]:=strtofloat(Form_Toxicant.E_tox_concentration.Text);
              //sets single peak exposure:
              1: begin
                  if (d>strtoint(Form_Toxicant.E_exposure_start.text))
                  and (dt<strtoint(Form_Toxicant.E_tox_time.text)) then
                    begin
                       toxconcentration[d]:=strtofloat(Form_Toxicant.E_tox_concentration.Text);
                       inc (dt)
                    end;//end if
                 end;//end case 1
              //sets multiple peak read from file:
              2: begin
                       toxconcentration[d+1]:=toxdata.toxconc[d];

                 end;//end case 2
           end;//end case
       end;//end day

end;//end procedure


end.
