unit Individual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, math, Vcl.StdCtrls,
  Environment, Toxicant, Vcl.ExtCtrls, LoadPara;

//---declarations of individual------------------------------------------------------
//Defines a brood of an individual:
type
   T_brood = record
      b_L:    double;   //structural length of an animal in brood
      b_e:    double;   //scaled reserve density of an animal in brood
      b_UH:   double;   //scaled maturity of an animal in brood
      b_Sc:   double;   //Scaled mobilisation flux in brood
      b_Lb:   double;
   end;

//Defines a class of individuals:
  T_individual = Class(TObject)
     //------------general properties-----------------------------
       //status of individual
       alive:                   boolean;

      //------------Parameters for growth and reproduction----------------------
        //DEB parameters
        g, g0, g00:     double;   //Energy investment ratio [-]
        EG:             double;   //[EG]: specific cost for structure
        km, km0, km00:  double;   //Somatic maintenance rate roefficient [per d]
        v,v0,v00:       double;   //Energy conductance [mm/d]    v:=Lm*km*g;
        kappa, kappa0:  double;   //Allocation fraction to soma [-]
        kr, kr0:        double;   //reproduction efficiency [-]
        kj,kj0, kj00:   double;   //maturity maintenance rate coefficient [per d]
        R:              integer;  //reproductive rate: broodsize
        U0E, U0E0:      double;   //Cost of an embryo
        dm:             double;   //shape coefficient

      //-- parameters for food dependent survival-------------------------------
        ha, ha0:        double;   //Weibul acceleration aceleration: calculation of individual survival
        sG:             double;   //Gompertz stress coefficient: calculation of individual survival
        e_alpha:        double;   //threshold function parameter
        e_beta, e_beta0,
        e_beta00:       double;   //threshold function parameter
        dT:             double;   //tolerance density for crowding stress function
        d0:             double;   //no-effect density for crowding stress function
        e_kd, e_kd0,
        e_kd00:         double;   //damage recovery
        e_kk:           double;   //killing rate for hazard rate based on scaled reserve density
        e_z:            double;   //effect threshold for on scaled reserve density
        UBH:            double;   //Scaled maturity at birth [mm^2/d]
        UPH:            double;   //Scaled maturity at puperty [mm^2/d]

      //--State variables and intermediate outputs------------------------------
        Ue:             double;   //Scaled reserve level [t L^2]
        Sc:             double;   //Scaled mobilisation flux of reserves [t*mm^2...?]
        SM:             double;   //Mainenance flux;
        e:              double;   //scaled reserve density [-]
        emin:           double;   //minimum scaled reserve density [-] over time needed for calculation of filtration rate
        L:              double;   //structural length [mm]
        dL:             double;   //change in structural length [mm/d]
        UH:             double;   //Scaled maturity [t*mm^2] UH (0)=0
        UR:             double;   //Scaled reproduction buffer [t*mm^2] UR (0)=0
        f:              double;   //scaled functional response
        q:              double;   //aging acceleration
        h:              double;   //hazard rate
        e_D, e_Dmax:    double;   //scaled damage for scaled reserve density
        s:              double;   //survival probability
        sD:             double;   //stress factor for crowding stress
        ir:             array of double; //Ingestion rate of individual based on population feeding rate [mgC/h] saved per h
        fd:             array of double; //food available in the environment, needed for calcualtion of assimilation effiencey

     //------------Parameters for feeding and assimilation-----------
        fx, fx0, fx00:  double;   //Surface-area-specific filtration rate
        ill:            double;   //incipient limiting level: faktor h in functional response Type II (handling time/digestion time or other factor that limits feeding); =vmax in Michaelis-Menten kinetics
        xk:             double;   //Faktor a in functional response Type II (attack rate or success rate);= km in Michaelis-Menten kintetics
        fa:             double;    //Faktor to calculate increasing filtration rate due to filter area adaptation at low food;
        pA:             double;   //surface area specific assimilation rate [mgC/d]
        pAm,pAm0,pAm00: double;   //surface area specific maximumassimilation rate;
        px:             double;   //assimilation efficiency;
        pxmin, pxmin0:  double;   //minimum assimilation efficiency;
        pxmax:          double;   //maximum assimilation efficiency;
        e0:             double;   //minimum scaled reserve density without additional hazard
        eT:             double;   //tolerance scaled reserve density for low food adaptation


     //-----------parameters that are responsible for variability---------------
        rs:double;             //expected survival of an individual: random number [0...1] assigend at birth

     //-----------state variables of brood--------------------------------------
        brood:      T_brood;
        breeding:   boolean;
     //-----------sensing the environment---------------------------------------
        density:    double;    //population density: number of individuals per ? is it ml?
        temp:       double;    //environmental temperature;
        TA:         double;    //Arrhenius temperature [K]
        Tref:       double;   //reference temperature [°C]

     //-----------toxicant effects---------------------------------------
        c0:         double;     //no effect concentration for stressfunction of sublethal tox effect
        cT:         double;     //tolerance concentration for stressfunction of sublethal tox effect
        M, Mmax:    double;     //selected dose metric for TKTD and sublethal effects
        cW:         double;     //external toxicant concentration
        ci:         double;     //internal toxicant concentration
        ci1,ci2:    double;     //internal toxicant concentrations in two compartment toxicokinetic model
        csi:        double;     //scaled internal concentration
        D:          double;     //scaled damage
        ki:         double;     //accumulation rate constant [x/per d]  what is x in this case?
        ke:         double;     //elimination rate constant   [per d]
        ki1,ki2:    double;     //accumulation rate constant second order kinetics [per d]
        ke1,ke2:    double;     //elimination rate constant second order kinetics  [per d]
        krec:       double;     //damage recovery rate constant  [per d]
        Ft:         double;     //threshold distribution function for individual tolerance assumption
        alpha:      double;     //median of the threshold distribution function for individual tolerance model
        beta:       double;     //width of the threshold distribution function for individual tolerance model
        kk:         double;     //killing rate in the hazard function for stochastic death model
        z:          double;     //threshold in the hazard function for stochastic death model
        a_ec50:     double;     //24h ec50 for acute toxicity
        a_slope:    double;     //slope of 24h acute toxicity log-logistic dose response curve
        r_ec50:     double;     //ec50 for reproduction toxicity
        r_slope:    double;     //slope repro toxicity log-logistic dose response curve

   //------------processes---------------------------------------
      //creates an individual:
      constructor create (embryo_e, embryo_L, embryo_UH:double); overload;    //use overload if a procedure is used more than once
      //second constructor possible e.g. for certain maturity states at start of population, whereas creator above always moduces neonates
      Constructor create(bodysize, SD_bodysize:double; adult_nr:integer;number_no_eggs:integer; culture_f:single); overload;
      //destroys an individual:
      destructor destroy; override;
      //density and low food dependen parameter changes
      procedure adaptation;
      //sums up procedures the individual has to undergo each day
      procedure struggleforlife;
      //calculates the growth of the individual [per d]:
      procedure growth;
      //calculates maturation and allocation of energy to reproducation [per d]:
      procedure maturation;
      //calculates food uptake of inividual (first calculate population feeding rate!!!)
      procedure feeding;
      //calculates of brood size and brood developmental state:
      procedure reproduction;
      //calculates aging, hazard and survival
      procedure survival;
      //read paramters of individual
      procedure readparameters;
      //toxicokinetics: calculation of dose metrics
      procedure toxicokinetics;
      //toxicodynamics: sub-lethal effect of a toxicant
      procedure sublethaltoxeffect;
      //toxicodynamics: lethal effect of a toxicant
      procedure lethaltoxeffect;
      //adjust paramters to temperature
      procedure sensetemperature;
  End;



//---declarations of TForm-----------------------------------------------------------
type
  TForm_Individual = class(TForm)
    Panel1:       TPanel;
    Label1:       TLabel;
    E_EG:         TLabeledEdit;
    E_km:         TLabeledEdit;
    E_v:          TLabeledEdit;
    E_kappa:      TLabeledEdit;
    E_kj:         TLabeledEdit;
    E_UBH:        TLabeledEdit;
    E_UPH:        TLabeledEdit;
    E_U0E:        TLabeledEdit;
    E_kr:         TLabeledEdit;
    Panel2:       TPanel;
    Label2:       TLabel;
    E_ha:         TLabeledEdit;
    E_sg:         TLabeledEdit;
    E_kd:         TLabeledEdit;
    E_ealpha:     TLabeledEdit;
    E_ebeta:      TLabeledEdit;
    Panel3:       TPanel;
    Label3:       TLabel;
    E_fx:         TLabeledEdit;
    E_xk:         TLabeledEdit;
    E_ill:        TLabeledEdit;
    E_e0:         TLabeledEdit;
    E_fa: TLabeledEdit;
    E_pam:        TLabeledEdit;
    E_pxmin:      TLabeledEdit;
    E_pxmax:      TLabeledEdit;
    Panel4:       TPanel;
    Label4:       TLabel;
    E_eT:         TLabeledEdit;
    E_dM:         TLabeledEdit;
    E_Li:         TLabeledEdit;
    CB_crowding:  TCheckBox;
    CB_plasticity: TCheckBox;
    Panel5:       TPanel;
    Label5:       TLabel;
    E_TA:         TLabeledEdit;
    E_Tref:       TLabeledEdit;
    Label6:       TLabel;
    Label7:       TLabel;
    E_f_dT:       TLabeledEdit;
    E_f_d0:       TLabeledEdit;
    E_c_dT:       TLabeledEdit;
    E_c_d0:       TLabeledEdit;
    procedure CB_parameterChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    para:         T_para;
  end;

var
  Form_Individual: TForm_Individual;

implementation
{$R *.dfm}

{ t_individual }
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               Each individual has to struggle for life, including
               feeding, growth, reproduction and survival
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.struggleforlife;
begin
   //individual has to feed:
   feeding;
   //individual allocates energy to mainanence and growth
   growth;
   //individual allocates energy to maturation or reproduction buffer
   maturation;
   //Brood size and embryo development state
   reproduction;
   //Toxicant effect on survival:
   if Environment.Form_Environment.CB_tox_on.Checked and Toxicant.Form_Toxicant.CB_lethal.checked and (Toxicant.Form_Toxicant.RG_modelchoice.ItemIndex=0)then
    lethaltoxeffect;
   //aging acceleration, hazard rate and survival
   survival;
end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  Density and food dependend changes in parameters and intermediate variables
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.adaptation;
begin
{individuals sense environment and changes parameters and variabels according
to population density and food avaialability (via scaled reserve density e)}
//----------------adaptations to low food conditions------------------------------------------
if Form_Individual.CB_plasticity.Checked=true  then
begin
  //adjusting g and kappa to conditions of low food
      sD:=1+(1/eT)*math.Max(0, ((1-e)-(1-e0)));
      kappa:=math.min(1,(kappa0*sD));
      //if e<e0 then   kappa:=1;
      g:=EG*v/(kappa*pam);
  //adjusting filtration rate fs to low reserve density e  (increase in fs with decreasing e)
      fx:=fx0*(1+(fa*power(L,2)*math.max(0,((1-e)-(1-e0))))); //not relating it to fs0, since there is another shift in fs calcualted above
end;

//----------------adaptations to high population densities------------------------------------------
if Form_Individual.CB_crowding.Checked=true  then
begin
   //When changing feeding and cost for reproduction...............................................................
   //stress function for filtration rate
     dT:=strtofloat(Form_Individual.E_f_dT.Text);
     d0:=strtofloat(Form_Individual.E_f_d0.Text);
     //calculates stress function
     sD:=1+(1/dT)*math.Max(0, ((density)-d0));
     //changes parameter value:
     fx:=fx/sD;

   //stress function for costs for reproduction
     dT:=strtofloat(Form_Individual.E_c_dT.Text);
     d0:=strtofloat(Form_Individual.E_c_d0.Text);
     //calculates stress function
     sD:=1+(1/dT)*math.Max(0, ((density)-d0));
     //changes parameter value:
     U0E:=U0E0*sD;   //increased cost for reproduction due to larger eggs
end;

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               Toxicokinetics: calculation of dose metrics
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.toxicokinetics;
var
i, iteration, factor:integer;
Lm:double;
begin
iteration:=24*100;

 for i := 0 to iteration-1 do

  case Toxicant.Form_Toxicant.RG_metric.ItemIndex of
   //if external concentration is selected as dose metric:
   0: begin M:=cW; end;
   //if internal concentration is selected as dose metric:
   1: begin ci:=ci+(ki*cW-ke*Ci)/iteration;  M:=ci; end;
   //if scaled internal concentration is selected as dose metric:
   2: begin csi:=csi+ke*(cW-csi)/iteration;  M:=csi; end;
   //if length scaled internal concentration is selected as dose metric:
   3: begin
        if Toxicant.Form_Toxicant.CB_g_dil.Checked then
        csi:=csi+(ke*((v/(g*km))/L)*(cW-csi))/iteration-(csi*3*dL/L)/iteration //considers dilution by growth
        else csi:=csi+ke*((v/(g*km))/L)*(cW-csi)/iteration;        //no grwoth dilution
       M:=csi;
       end;
   //if scaled damage is selected as dose metric:
   4: begin
       //first order kinetics for internal concentration
       ci:=ci+(ki*cW-ke*Ci)/iteration;
       //scaled damage
       D:=D+krec*(ci-D); M:=D;
       M:=D;
      end;
  end;

  //for individual tolerance model maximum metric over time is needed:
  if Mmax<M then Mmax:=M;
end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       Toxicant sublethal effects: changes in parameters
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.sublethaltoxeffect;
var
st:double; //stress function for toxicant
begin

   //Physiological mode of action 1: reduced feeding
   if Toxicant.Form_Toxicant.CB_pmo1.checked then
   begin
     //reads tolerance concentration:
     cT:=strtofloat(Toxicant.Form_Toxicant.E_cT1.Text);
     //reads no effect concentration:
     c0:=strtofloat(Toxicant.Form_Toxicant.E_c01.Text);
     //calculates stress function
     st:=(1/cT)*math.Max(0, (M-c0));
     //changes parameter value:
     fx:=fx*max(0, (1-st));
   end;

   //Physiological mode of action 2: reduced assimilation
   if Toxicant.Form_Toxicant.CB_pmo2.checked then
   begin
     //reads tolerance concentration:
     cT:=strtofloat(Toxicant.Form_Toxicant.E_cT2.Text);
     //reads no effect concentration:
     c0:=strtofloat(Toxicant.Form_Toxicant.E_c02.Text);
     //calculates stress function
     st:=(1/cT)*math.Max(0, (M-c0));
     //changes parameter value:
     pxmin:=pxmin0*max(0, (1-st));
   end;

   //Physiological mode of action 3: increased maintenance costs
   if Toxicant.Form_Toxicant.CB_pmo3a.checked then
   begin
     //reads tolerance concentration:
     cT:=strtofloat(Toxicant.Form_Toxicant.E_cT3a.Text);
     //reads no effect concentration:
     c0:=strtofloat(Toxicant.Form_Toxicant.E_c03a.Text);
     //calculates stress function
     st:=1+(1/cT)*math.Max(0, (M-c0));
     //changes parameter value:
     km:=km0*st;
   end;

   if Toxicant.Form_Toxicant.CB_pmo3b.checked then
   begin
     //reads tolerance concentration:
     cT:=strtofloat(Toxicant.Form_Toxicant.E_cT3b.Text);
     //reads no effect concentration:
     c0:=strtofloat(Toxicant.Form_Toxicant.E_c03b.Text);
     //calculates stress function
     st:=1+(1/cT)*math.Max(0, (M-c0));
     //changes parameter value:
     kj:=kj0*st;
   end;

   //Physiological mode of action 4: increased costs for growth
   if Toxicant.Form_Toxicant.CB_pmo4.checked then
   begin
     //reads tolerance concentration:
     cT:=strtofloat(Toxicant.Form_Toxicant.E_cT4.Text);
     //reads no effect concentration:
     c0:=strtofloat(Toxicant.Form_Toxicant.E_c04.Text);
     //calculates stress function
     st:=1+(1/cT)*math.Max(0, (M-c0));
     //changes parameter value:
     km:=km0/st;
     g:=g0*st;
   end;

   //Physiological mode of action 5: costs for reproduction
   if Toxicant.Form_Toxicant.CB_pmo5.checked then
   begin
     //reads tolerance concentration:
     cT:=strtofloat(Toxicant.Form_Toxicant.E_cT5.Text);
     //reads no effect concentration:
     c0:=strtofloat(Toxicant.Form_Toxicant.E_c05.Text);
     //calculates stress function
     st:=1+(1/cT)*math.Max(0, (M-c0));
     //changes parameter value:
     kr:=kr0/st;
   end;

   //Physiological mode of action 6: hazard to embryo
   if Toxicant.Form_Toxicant.CB_pmo6.checked then
   begin
     //reads tolerance concentration:
     cT:=strtofloat(Toxicant.Form_Toxicant.E_cT6.Text);
     //reads no effect concentration:
     c0:=strtofloat(Toxicant.Form_Toxicant.E_c06.Text);
     //calculates stress function
     st:=(1/cT)*math.Max(0, (M-c0));
     //changes parameter value:
     kr:=kr0*exp(-st); //this physiological mode directly acts on reproduction (R), here implemented in the same way as above, as only the interpretation differs
   end;

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               aging acceleration, hazard rate and survival
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.lethaltoxeffect;
begin
   //Select Threshold assumption:
   case Toxicant.Form_Toxicant.RG_SD_IT.ItemIndex of
    //calculates log-logistic cummulative threshold distribution function for individual tolerance assumption:
    0: if Mmax>0 then Ft:=1/(1+power((Mmax/alpha),-beta)) else Ft:=0;
    //calculates hazard rate for stochastic death assumption:
    1: h:=h+kk*math.max(0,(M-z));
   end;
end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               aging acceleration, hazard rate and survival
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.survival;
var
Fe: double;
xs:integer;
begin

//---------calculates aging acelleration:
        q:=q+ ((q* (power(L,3)/power((v/(g*km)),3)*sG) + ha) *e*( ((v/L)-(3*dL/L)))-((3*dL/L)*q));
//---------calculates maximum scaled damage:
        e_D:=e_D+e_kd*(((1-e))-e_D);
        if e_Dmax<e_D then e_Dmax:=e_D;

//---------calculates hazard rate based on scaled damage and aging
        h:=h+(q-(3*dL/L)*h);
        if e_Dmax>0 then Fe:=1/(1+power((e_Dmax/e_alpha),-e_beta))
        else Fe:=0;
       if h<0 then h:=0;

//---------calculates survival probability:
       if Toxicant.Form_Toxicant.CB_lethal.checked and (Toxicant.Form_Toxicant.RG_modelchoice.ItemIndex=0)
          and (Toxicant.Form_Toxicant.RG_SD_IT.ItemIndex=0)
       then  s:=(1-Ft)*(1-Fe)*exp(-h)
       else  s:=(1-Fe)*exp(-h);


//---------animal dead?
       if s<=rs then alive:=false;


end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               food uptake by an individual
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.feeding;
var
h:integer;  //counter of hours
begin
//-------resets daily assimilation:
    Pa:=0;
//-------calculates assimilation rate on the basis of realized feeding rate
    for h := 0 to 24 - 1 do
      begin
        //calculates assimilation efficiency according to Rinke and Vijverberg 2005:
         px:=pxmax-((pxmax-pxmin)*(fd[h]/(xk+fd[h])));
        //calculates assimilation rate (cummulative per day):
        Pa:=Pa + (px*ir[h]);
      end;

//------calculates actual scaled functional response [-]
   f:=Pa/(pAm*power(L,2));
   //safety request:
   if f>1 then f:=1;
end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        allocation of energy to growth of an individual
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.growth;
var
s, step:integer;
sl:double;
begin
//Number of iterations:
step:=100;
dL:=0;
//growth in iterations:
for s := 0 to step-1 do
begin
  //calculates scaled body length:
   if e>0 then sl:=L/(v*e/(km*g))
   else sl:=0;
   //sl:=L/(v*e/(km*g));
  //for growth conditions calculates:
    if e>=sl then
     begin
        //calculates actual scaled catabolic flux:
        Sc:= power (L,2) *((g*e)/(g+e))*(1+(km*L/v));
        //calculates daily increase in length, needed for computing aging
        dL:=dL+ (1 /(3*power(L,2)))*(((v/g)*Sc) - km*power(L,3))/step;
        //calculates growth in iterations
        L:=L+ (1 /(3*power(L,2)))*(((v/g)*Sc) - km*power(L,3))/step;
      end
     else
   //for non-growth conditions calculates:
     begin
        // calculates actual scaled catabolic flux then only paying maintenance costs
        Sc:=km*kappa*g*power (L,3)/v;  //see Jager Technical background document for:Making Sense of Chemical Stress, p3
        //and change in length is 0:
        dL:=0;
     end;

   //...updating actual scaled reserves....................
              Ue:= Ue+((((f*power (L,2))-Sc))/step);   //with Sa:=(f*power (L,2))
              if Ue<0 then Ue:=0;
   //...updating actual scaled reserve density............
              e:=v*Ue/power (L,3);
              //safety request:
              if e>1 then e:=1;
              if e<0 then e:=0;
end;//end iterations

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         allocation of energy to maturation or reproduction
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}

procedure T_individual.maturation;
begin
//if above non-growth boundary spend e on maturation or reproduction buffer, otherwise e is spent in maintennce only
if e>f*(L/(v/(km*g))) then
     begin
    //...if individual does not yet reach puperty, energy flux to maturation:
       if UH < UPH then UH:= UH + (((1-kappa)*Sc) - (kj*UH));

   //...if individual reaches puperty, engergy flux into reproductive buffer:
       if UH >= UPH then UR:=UR +(((1-kappa)*Sc) - (kj*UPH));
end;

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               reproduction by an individual
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.reproduction;
var
i,d:integer;
x:double;
begin

//----breeding when calculating embryo growth from egg formation----------------------
if UH >= UPH then
begin
  //---if breeding calculate growth and maturation of ebryos
   if breeding then
   begin
      //calculated scaled catabolic flux and and growth of the embryo under the assumptions that parameter values are inherited and that e does not change:
        brood.b_Sc:= power (brood.b_L,2) *((g0*brood.b_e)/(g0+brood.b_e))*(1+(km0*brood.b_L/v));
        brood.b_L:=brood.b_L+ (1 /(3*power(brood.b_L,2)))*(((v/g0)*brood.b_Sc) - km0*power(brood.b_L,3));
      //Calculates scaled maturity of embryo
      brood.b_UH:= brood.b_UH + (((1-kappa0)*brood.b_Sc) - (kj0*brood.b_UH));
   end;

 //---if not breeding then initialze brood-
     if not breeding then
     begin
       //structural length at egg formation:
       brood.b_L:=strtofloat(Form_Individual.E_Li.Text);
       //scaled reserved density of brood is assumed to be equal to mother scaled reserve density at egg formation (different from DEB assumption: offspring e at birth is equal to mother e)
       brood.b_e:=e;
       //if crwoding is assumed, then also brood reseve density is increased relative to crowding stress:
       if Form_Individual.CB_crowding.Checked=true  then brood.b_e:=min(e*U0E/U0E0,1);
       //scaled maturity at egg formation:
       brood.b_UH:=0;
       //calculates brood size:
       R:=trunc(kr*UR/U0E);

      //considering effect on reproduction based on dose-response curves, basically assuming direct effect on embryo:
       if (Environment.Form_Environment.CB_tox_on.Checked) and (Toxicant.Form_Toxicant.RG_modelchoice.ItemIndex=1)
         and (Toxicant.Form_Toxicant.CB_sublethal.Checked) then
           R:=trunc((1/(1+power((cw/r_ec50),r_slope)))*kr*UR/U0E);

       //resets reproduction buffer, but leaves the rest of buffer that could not be used to produce a full egg:
       UR:=(kr*UR/U0E)-trunc(kr*UR/U0E);
       //start breeding:
       breeding:=true;
     end;

 //---if embryos reach scaled maturity at birth (UPB) then stop breeding:
    if brood.b_UH >= UBH then
    begin
      breeding:=false;
    end;
end;

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               Create an individual at birth
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
constructor t_individual.create (embryo_e, embryo_L, embryo_UH:double);
begin
  inherited create; //always call at the start of a constructor

//-------Read individuals parameters and assign state variables at birth---------
    //structural length [mm] at birth:
    L:=embryo_L;
    //Scaled maturity [t*mm^2] at birth UH (0)=0:
    UH:=embryo_UH;
    //this is where paramters are stored:
    readparameters;
    //scaled reserve density [-]:
    //e:=0.272*embryo_e;
    e:=embryo_e;
    //DEB assumption: embryo will hatch as same reserve density (e) as mother (had at egg formation??? check for argumentation): problemsolving: bisection method or inclomplete beta function?
    //here I assume that reserve density is same as mother during at egg formation, but does not change during egg development
    //minimum scaled reserve density [-] over time:
    emin:=1;//e;
    //Scaled reserve level [t L^2]:
    UE:=(e*power(L,3))/v;
    //status of indivudal after bith
    alive:=true;

end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              creates individuals at simulation start
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
constructor T_individual.create(bodysize, SD_bodysize: double; adult_nr:integer; number_no_eggs:integer; culture_f:single);
var
uppersize, lowersize: double;
count,d, dmax:integer;
begin
  inherited create;
//-----------------Same parameters as in above create procedure-----------------
    //reads rest of the parameters:
    readparameters;
    //structural length [mm] at birth:
    L:=dm*randomrange (95, 115)/100;// 0.85;
    //Scaled maturity [t*mm^2] on day after birth neonate <24h:
    UH:=UBH;
   //------general deb state variables assigned at start of the simulation-------
    //scaled reserve density [-] in culture:
    e:=culture_f;
    //minimum scaled reserve density [-] over time:
    emin:=e;
    //Scaled reserve level [t L^2] in culture conditions:
    UE:=(e*power(L,3))/v;


    //random body size of individual within within one standard deviations from mean:
        uppersize:=bodysize + bodysize*1*SD_bodysize;
        lowersize:=bodysize - bodysize*1*SD_bodysize;

        if SD_bodysize > 0 then
        begin
          repeat
            bodysize:=randG(bodysize, SD_bodysize);
          until (bodysize<uppersize) or (bodysize>lowersize);
        end;
        //under culture conditions with f=0.7 daphnids will not get bigger than this:
        if bodysize>4 then bodysize:=4;

//-----life cycle until individual reaches size at simulation start---------------------
    repeat
        //scaled functional response in culture conditions:
        f:=culture_f;
        //individual allocates energy to mainanence and growth
        growth;
        //individual allocates energy to maturation or reproduction buffer
        maturation;
        //Brood size and embryo development state
        reproduction;
        //aging acceleration, hazard rate and survival
        survival;
        //experiment started with living individuals only:
       alive:=true;
    until L>=bodysize*dm;


   //at start of the experiments only adult daphnids were used that are not going to release neonates on the same day:
   if (UH>UPH) and (adult_nr>=number_no_eggs) then brood.b_UH:=randomrange(0,3)/1000
   else brood.b_UH:=0;

end;


{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               This is where parameters of the individual are stored
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.readparameters;
var
x:double;
begin

//--parameters for growth and reproduction--------------------------------------
    //shape coefficient
    dm:=strtofloat(Form_Individual.E_dM.Text);;
    //Somatic maintenance rate coefficient [per d]:
    km:=strtofloat(Form_Individual.E_km.Text);
    //Energy conductance [mm/d]    v:=Lm*km*g;  :
    v:=strtofloat(Form_Individual.E_v.Text);
    //Allocation fraction to soma [-]:
    kappa:=strtofloat(Form_Individual.E_kappa.Text);
    //Volume specific cost for structure
    EG:=strtofloat(Form_Individual.E_EG.Text);
    //reproduction efficiency [-]:
    kr:=strtofloat(Form_Individual.E_kr.Text);
    //maturity maintenance rate coefficient [per d]:
    kj:=strtofloat(Form_Individual.E_kj.Text);
    //Scaled maturity at birth  [mm^2/d]:
    UBH:=strtofloat(Form_Individual.E_UBH.Text);
    //Scaled maturity at puperty [mm^2/d]:
    UPH:=strtofloat(Form_Individual.E_UPH.Text);
    //Scaled reproduction buffer [t*mm^2] at birth
    UR:=0;
    //Cost of an egg
    U0E:=strtofloat(Form_Individual.E_U0E.Text);
    //initial reproductive output:
    R:=0;  breeding:=false; brood.b_UH:=0;


//---parameters for aging and food dependent survival --------------------------
    //Weibull aging acceleration
    ha:=strtofloat(Form_Individual.E_ha.Text);
    //Gompertz stress coefficient
    sG:=strtofloat(Form_Individual.E_sg.Text);
    //random number that determines individual survival probability
    rs:=random;
  //when calculating scaled damage and hazard rate:
    //damage recovery
    e_kd:=strtofloat(Form_Individual.E_kd.Text);
    //median of thresold distribution
     e_alpha:=strtofloat(Form_Individual.E_ealpha.Text);
    //shape of threshold distribution
     e_beta:=strtofloat(Form_Individual.E_ebeta.Text);
    //hazard rate, damages at birth
    h:=0;  e_D:=0; q:=0;

//---Paramters for feeding and assimilation--------------------------------------
    //scaling factor of maximum feeding/filtration rate
    repeat
      x:=randg(1,0.231);    //coefficient of variation: Preuss et al 2009
    until (x <1.3) or (x<0.7);
    //No stochasticity in feeding:
    x:=1;
    fx:=x*strtofloat(Form_Individual.E_fx.Text);
    //attack/success rate
    xk:=strtofloat(Form_Individual.E_xk.Text);
    //incipient limiting level: limitation to ingestion
    ill:=strtofloat(Form_Individual.E_ill.Text);
    //set length of ingestion rate array [mgC/h]
    setlength (ir,24);
    //set length of food availability array
    setlength (fd,24);
    //Threshold scaled reserve density: needed for calculation of filtration rate and survival
     e0:=strtofloat(Form_Individual.E_e0.Text);
    //Tolerance scaled reserve density for low food adaptation
     eT:=strtofloat(Form_Individual.E_eT.Text);
    //Scaled increase in filtration rate
     fa:=strtofloat(Form_Individual.E_fa.Text);
    //maximum surface area specific assimilation rate;
     pAm:=strtofloat(Form_Individual.E_pam.Text);
    //minimum and maximum assimilation efficiency;
     pxmin:=strtofloat(Form_Individual.E_pxmin.Text);
     pxmax:=strtofloat(Form_Individual.E_pxmax.Text);

//paramters for temperature adjustment
     TA:=strtofloat(Form_Individual.E_TA.Text);
     Tref:=strtofloat(Form_Individual.E_Tref.Text);

//parameters and state variables of toxicokinetiks and toxicodynamics (parameters for sub-lethal effects are set in the procedure)
     //accumulation rate constant:
     ki:=strtofloat(Toxicant.Form_Toxicant.E_ki.Text);
     //elimination rate constant:
     ke:=strtofloat(Toxicant.Form_Toxicant.E_ke.Text);
     //damage recovery rate constant:
     krec:=strtofloat(Toxicant.Form_Toxicant.E_krec.Text);
     //resets intial metrics:
     cW:=0; Ci:=0; Ci1:=0; Ci2:=0; csi:=0; D:=0; Mmax:=0;
     //median of the threshold distribution function for individual tolerance model
     alpha:=strtofloat(Toxicant.Form_Toxicant.E_alpha.Text);
     //width of the threshold distribution function for individual tolerance model
     beta:=strtofloat(Toxicant.Form_Toxicant.E_beta.Text);
     //killing rate in the hazard function for stochastic death model
     kk:=strtofloat(Toxicant.Form_Toxicant.E_kk.Text);
     //threshold in the hazard function for stochastic death model
     z:=strtofloat(Toxicant.Form_Toxicant.E_z.Text);
//parameters for dose- response curves
     //24h ec50 for acute toxicity
     a_ec50:=strtofloat(Toxicant.Form_Toxicant.E_Acute_EC50.Text);
     //slope of 24h acute toxicity log-logistic dose response curve
     a_slope:=strtofloat(Toxicant.Form_Toxicant.E_Acute_Slope.Text);
     //ec50 for reproduction toxicity
     r_ec50:=strtofloat(Toxicant.Form_Toxicant.E_Repro_EC50.Text);
     //slope for reproduction toxicity
     r_slope:=strtofloat(Toxicant.Form_Toxicant.E_Repro_Slope.Text);

//saves original parameters for density dependence and low food
    g:=EG*v/(kappa*pam);
    //single nuls, adjustment in toxicant or adaptation related processes only
    kappa0:=kappa; g0:=g;   pxmin0:=pxmin; kr0:=kr;  U0E0:=U0E;
    km0:=km; kj0:=kj; e_kd0:=e_kd; fx0:=fx; pAm0:=pAm; v0:=v; e_beta0:=e_beta;    ha0:=ha;
    //double nulls, adjustment for temperature needed first
    km00:=km; kj00:=kj; e_kd00:=e_kd; fx00:=fx; pAm00:=pAm; v00:=v; e_beta00:=e_beta;   ha0:=ha;
    g00:=g;
end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               adjust parameters to temperature
      currently only works for constant temperatures
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure T_individual.sensetemperature;
var
f_T:double;
begin
  //Calculated Arrhenius fucntion for temperature adjustment:
  f_T:=exp(TA/(Tref+273.15)-TA/(temp+273.15));
  //update of parameter values
   km0:=km00*f_T;         km:=km0;
   kj0:=kj00*f_T;         kj:=kj0;
   e_kd0:=e_kd00*f_T;     e_kd:=e_kd0;
   v0:=v00*f_T;           v:=v0;
   e_beta0:=e_beta00*f_T; e_beta:=e_beta0;
   fx0:=fx00*f_T;         fx:=fx0;
   pAm0:=pAm00*f_T;       pAm:=pAm0;
   ha:=power((power(ha0,0.5)*f_T),2);


end;
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               destroys an individual when dead
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}

destructor T_individual.destroy;
begin
  //consider: free processes that are related to individuals, setlength(xxx,0)
  inherited; // Always call at the end of a destructor
end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              loads parameter set
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Individual.CB_parameterChange(Sender: TObject);
var
p:integer;
begin
with LoadPara.Form_LoadParameter do
begin
  //Median of threshold distribution (alpha)
  E_ealpha.Text:=floattostr(para[p].meter[0]);
  //Slope of threshold distribution (beta)
  E_ebeta.Text:=floattostr(para[p].meter[1]);
  //Shape coefficient	(dm)
  E_dm.Text:=floattostr(para[p].meter[2]);
  //Volume-specific cost for structure	[EG]
  E_EG.Text:=floattostr(para[p].meter[3]);
  //Scaled reserved density threshold for adaptation (e0)
  E_e0.Text:=floattostr(para[p].meter[4]);
  //Tolerance scaled reserve density for adaptation	(eT)
  E_eT.Text:=floattostr(para[p].meter[5]);
  //	Surface-area-specific filtration rate	{Fx}
  E_fx.Text:=floattostr(para[p].meter[6]);
  //Surface-area-specific filtration rate adaptation {Fa}
  E_fa.Text:=floattostr(para[p].meter[7]);
  //Aging acceleration constant	(ha)
  E_ha.Text:=floattostr(para[p].meter[8]);
  //Incipient limiting level (ill)
  E_ill.Text:=floattostr(para[p].meter[9]);
  //Allocation fraction to soma (kappa)
  E_kappa.Text:=floattostr(para[p].meter[10]);
  //Damage recovery rate constant (kd)
  E_kd.Text:=floattostr(para[p].meter[11]);
  //Maturity maintenance rate coefficient (kJ)
  E_kj.Text:=floattostr(para[p].meter[12]);
  //Somatic maintenance rate coefficient (kM)
  E_kM.Text:=floattostr(para[p].meter[13]);
  //Reproduction efficiency	(kR)
  E_kr.Text:=floattostr(para[p].meter[14]);
  //Initial volumetric structural length (Li)
  E_Li.Text:=floattostr(para[p].meter[15]);
  //Surface-area-specific maximum assimilation rate {pAm}
  E_pam.Text:=floattostr(para[p].meter[16]);
  //Minimum assimilation efficiency	(PXmin)
  E_pxmin.Text:=floattostr(para[p].meter[17]);
  //Maximum assimilation efficiency	(PXmax)
  E_pxmax.Text:=floattostr(para[p].meter[18]);
  //Aging stress coefficient (sG)
  E_sG.Text:=floattostr(para[p].meter[19]);
  //Cost of an egg (U0E)
  E_U0E.Text:=floattostr(para[p].meter[20]);
  //Scaled maturity at birth (UBH)
  E_UBH.Text:=floattostr(para[p].meter[21]);
  //Scaled maturity at puberty (UPH)
  E_UPH.Text:=floattostr(para[p].meter[22]);
  //Energy conductance (v)
  E_v.Text:=floattostr(para[p].meter[23]);
  //Half saturation constant (XK)
  E_xk.Text:=floattostr(para[p].meter[24]);
end;
end;


end.
