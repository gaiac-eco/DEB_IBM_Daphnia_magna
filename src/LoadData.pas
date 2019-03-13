unit LoadData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Environment, Population, Individual, Output;

  //...Information on start population............................................
type
    t_popdata=array of record
    //number per size class, mean size in class and standard deviation of size
      nrclass:                            integer; //array over class: class 1(0)...total(3)
      sizeinclass:                        double;  //array over class: class 1(0)...total(3)
      SDclass:                            double; //array over class: class 1(0)...total(3)
    //actual population test data
      day:                                array of integer; //array over time
      num:                                array of double;  //array over time
end;

//...population data storrage...................................................
type
    T_data=record  //array over treatments
      //species in test:
      species:                            string;
      //test medium: water (0) sediment (1)
      medium:                             integer;
      //volume of media [ml]
      vol:                                integer;
      //simulation time [d]
      simultime:                          integer;
      //amount of food [mg C]
      foodmass:                           double;
      //unit given as density [mg C/l]:(0) or total amount [mg C/population]:(1)
      foodunit:                           integer;
      //food given daily/scenrio/once in the beginning (0/1/3); scenario: load data from csv file
      foodscenario:                       integer;
      //Upper limit of size class1 and lower limit of class 3
      limclass1, limclass3:               double;
      //if tox test then concentration of compound
      concentration:                      double;
      //data for each size class
      popdata:                            t_popdata;
end;

  TForm_Load = class(TForm)
    Memo1:          TMemo;
    OpenDialog1:    TOpenDialog;
  private
    { Private declarations }
  public
    { Public declarations }
    data:           T_data;

    procedure       loadpopdata;
    procedure       showloaddata;


  end;

var
  Form_Load: TForm_Load;

implementation

{$R *.dfm}

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                       load population data from file
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
{procedure loads data from csv file that looks e.g. like:
Test                            Population
Species	                        Daphnia magna
Water/Sediment (0/1)	          0
Volume of medium [ml]:	        20000
Simulation time [d]:	          80
Feeding mass [mgC/x]:	          12
unit x: density or total (0/1)	0
daily/scenrio/once (0/1/3)	    1
Initial number in Size class 1 	10
Mean length of SC 1 [mm]	      1
SD of SC 1  [mm]	              0,2
Initial number of Size class 2  0
Mean length of SC 2 [mm]	      0
SD of SC 2  [mm]	              0
Initial number of Size class 3 	5
Mean length of SC 3 [mm]	      4,1
SD of SC 3  [mm]	              0,2
Size class 1 < [mm]	            1,3
Size class 3 >= [mm]	          2,6
Literature	                    Gergs et al 2012
Test Item	                      Control
Concentration [µg/l]	          0
                        day ;    size1;    day;    size2;  day   size3   day   total
                          0 ;     10;      0 ;     0;       0      5      0      15
                          3 ;     33;      3 ;     6;       3      5      3      38
                          .        .        .       .       .      .      .      .
                          .        .        .       .       .      .      .      .
                          .        .        .       .       .      .      .      . }

procedure TForm_Load.loadpopdata;
var
t,i,a,c:integer;
character:char;
counter, nr_conc:integer;
line, val:string;
begin
  //empty memo;
  Memo1.Clear;
  //open csv file
  OpenDialog1.Title:='Load population data';
  if OpenDialog1.Execute then Memo1.Lines.Loadfromfile (OpenDialog1.FileName);
  //set length of data arrays
  setlength (data.popdata,4);
    for c := 0 to 4-1 do
      begin
        setlength (data.popdata[c].day,(memo1.lines.Count - 23));
        setlength (data.popdata[c].num,(memo1.lines.Count - 23));
      end;

  t:=0;
  //...load data...........................................................
  for i := 0 to memo1.lines.Count - 1 do
  begin
    c:=0;
    //writes memo line into variable 'line'
    line:=memo1.lines[i]+',';
    //empties the variable val:
    val:='';
    //sets column counter to 0
    counter:=0;
  //...goes through lines...........:
    for a := 1 to length(line) do
    begin
      character:=line[a];

      //if the current character is ';' (marks end of a field in csv file) then do...
      if character=',' then
      begin
         if counter=1 then
         begin
            //ignore first line of file

            //second line: species information
            if (i=1) and (val<>'')then data.species:=val;

            //third line: medium type
            if (i=2) and (val<>'')then data.medium:=strtoint(val);

            //4th line: envirmonmental volume
            if (i=3) and (val<>'')then data.vol:=strtoint(val);

            //5th line: simulation time [d]
            if (i=4) and (val<>'')then data.simultime:=strtoint(val);

            //6th line: amount of food [mg C]
            if (i=5) and (val<>'')then data.foodmass:=strtofloat(val);

            //7th line: food density or total
            if (i=6) and (val<>'')then data.foodunit:=strtoint(val);

            //8th line: food given daily/scenario/once in the beginning
            if (i=7) and (val<>'')then data.foodscenario:=strtoint(val);

            //9th line: number in class 1
            if (i=8) and (val<>'')then data.popdata[1].nrclass :=strtoint(val);

            //10th line: size mean  in class 1
            if (i=9) and (val<>'')then data.popdata[1].sizeinclass :=strtofloat(val);

            //11th line: size standard deviation in class 1
            if (i=10)and (val<>'')then data.popdata[1].SDclass :=strtofloat(val);

            //12th line: number in class 2
            if (i=11) and (val<>'')then data.popdata[2].nrclass :=strtoint(val);

            //13th line: size mean  in class 2
            if (i=12) and (val<>'')then data.popdata[2].sizeinclass :=strtofloat(val);

            //14th line: size standard deviation in class 2
            if (i=13)and (val<>'')then data.popdata[2].SDclass :=strtofloat(val);

            //15th line: number in class 3
            if (i=14) and (val<>'')then data.popdata[3].nrclass :=strtoint(val);

            //16th line: size mean  in class 2
            if (i=15) and (val<>'')then data.popdata[3].sizeinclass :=strtofloat(val);

            //17th line: size standard deviation in class 3
            if (i=16)and (val<>'')then data.popdata[3].SDclass :=strtofloat(val);

            //18th line: upper limit of class 1
            if (i=17)and (val<>'')then data.limclass1:=strtofloat(val);

            //19th line: lower limit of class 3
            if (i=18)and (val<>'')then data.limclass3:=strtofloat(val);

            //ignore line 20 line

            //ignore line 21 line

            //22nd line: concentration of toxicant exposure
            if (i=21)and (val<>'')then data.concentration:=strtofloat(val);

            //ignore line 23
        end;

        //Form_Load.Show;

        //23th line and higher: ; even numbers: numbers (ydata)
        if (i>=23) and (val<>'') and (counter<8)then
        begin
            //even column numbers: time [days]
            if ((counter/2)=trunc(counter/2)) then
            begin
              if val='x' then val:='1000000';
              data.popdata[c].day[t]:=strtoint(val);

            end
            //odd column numbers: numbers per size class (1-3) or total (4)
            else
            begin
                if val='x' then val:='0';
                data.popdata[c].num[t]:=strtofloat(val);
                //inc(t);
                inc(c);
            end;
        end;
        //increase column counter
        inc(counter);
        //if a value is fixed then empty variable val
        val:='';
      end
      //merges single characters to a value (e.g. 1+2+3; --> 123)
      else val:=val+character;
    end;
    //row counter for popdata
    if (i>=23) then inc(t);
  end;

end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                       shows population data
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_Load.showloaddata;
var
t:integer;
begin
  //clears data in graphs:
   output.Form_Output.S_data_class1.Clear;
   output.Form_Output.S_data_class2.Clear;
   output.Form_Output.S_data_class3.Clear;
   output.Form_Output.S_data_total.Clear;

  //sets medium type:
    if data.medium=0 then Form_Environment.RG_Sytemtype.ItemIndex:=0
    else  Form_Environment.RG_Sytemtype.ItemIndex:=0;
  //sets environmental volume:
    Form_Environment.E_volume.text:=inttostr(data.vol);
  //sets simulation time:
    Form_Environment.E_Simtime.text:=inttostr(data.simultime);
  //sets amount of food:
    Form_Environment.E_fooddensity.text:=floattostr(data.foodmass);
  //sets unit of food
    if data.foodunit=0 then  Form_Environment.RG_foodcalculation.ItemIndex:=0
    else Form_Environment.RG_foodcalculation.ItemIndex:=1;
  //sets food scenario
    case data.foodscenario of
     0: Form_Environment.RG_food.ItemIndex:=0;
     1: Form_Environment.RG_food.ItemIndex:=1;
     2: Form_Environment.RG_food.ItemIndex:=1;
    end;
  //sets initial population:
    Form_Population.E_class1_nr.text:=inttostr(data.popdata[1].nrclass);
        Form_Population.E_class1_size.text:=floattostr(data.popdata[1].sizeinclass);
            Form_Population.s_sizeclass1.text:=floattostr(data.popdata[1].SDclass);
    Form_Population.E_class2_nr.text:=inttostr(data.popdata[2].nrclass);
        Form_Population.E_class2_size.text:=floattostr(data.popdata[2].sizeinclass);
            Form_Population.s_sizeclass2.text:=floattostr(data.popdata[2].SDclass);
    Form_Population.E_class3_nr.text:=inttostr(data.popdata[3].nrclass);
        Form_Population.E_class3_size.text:=floattostr(data.popdata[3].sizeinclass);
            Form_Population.s_sizeclass3.text:=floattostr(data.popdata[3].SDclass);
  //sets upper and lower limits of size classes:
    Form_Population.E_class1_sizeclass.text:=floattostr(data.limclass1);
    Form_Population.E_class3_sizeclass.text:=floattostr(data.limclass3);

  //shows data in graphs:
   output.Form_Output.Chart_neonates.Title.Caption:= 'Abundance fraction ≤'+ floattostr (data.limclass1) +' mm';
   output.Form_Output.Chart_juvenile.Title.Caption:= 'Abundance fraction ' + floattostr (data.limclass1) + '-'+ floattostr (data.limclass3)  +' mm';
   output.Form_Output.Chart_adults.Title.Caption:= 'Abundance fraction >' + floattostr (data.limclass3) +' mm';

   for t := 0 to length(data.popdata[1].num)-1  do
   begin
       output.Form_Output.S_data_class1.AddXY(data.popdata[0].day[t],data.popdata[0].num[t]);
       output.Form_Output.S_data_class2.AddXY(data.popdata[0].day[t],data.popdata[1].num[t]);
       output.Form_Output.S_data_class3.AddXY(data.popdata[2].day[t],data.popdata[2].num[t]);
       output.Form_Output.S_data_total.AddXY(data.popdata[3].day[t],data.popdata[3].num[t]);
   end;
end;
end.
