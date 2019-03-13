unit LoadPara;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
   T_para=array of record
      //name of parameter set, e.g. species name
      name:         string;
      //parameters:
      meter:        array of double;
end;

type
  TForm_LoadParameter = class(TForm)
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
  private
    { Private declarations }
  public
    { Public declarations }
    para:T_para;
    procedure       loadparameters;
  end;

var
  Form_LoadParameter: TForm_LoadParameter;

implementation

{$R *.dfm}
{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                       loads parameter sets from file
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
procedure TForm_LoadParameter.loadparameters;
var
p,i,a,c:integer;
character:char;
counter, nr_conc:integer;
line, val:string;
begin
 //empty memo;
  Memo1.Clear;
  //open csv file
  OpenDialog1.Title:='Load parameter sets';
  if OpenDialog1.Execute then Memo1.Lines.Loadfromfile (OpenDialog1.FileName);


  //...load data...........................................................
  for i := 0 to memo1.lines.Count - 1 do
  begin
    c:=0;
    //writes memo line into variable 'line'
    line:=memo1.lines[i];
    //empties the variable val:
    val:='';
    //sets column counter to 0
    counter:=0;
    //sets parameter counter 0
    p:=0;
  //...goes through lines...........:
    for a := 1 to length(line) do
    begin
      character:=line[a];

      //if the current character is ';' (marks end of a field in csv file) then do...
      if character=';' then
      begin
         if counter=1 then
         begin

            //ignore first line of file
            if (i=0) and (val<>'') then
            begin
              setlength (para, strtoint(val));
              for p := 0 to length(para)-1 do
                 setlength (para[p].meter, 25);
            end;
         end;

         if counter>1 then
         begin
            p:=counter-2;
            //second line: species information
            if (i=1) and (val<>'')then  para[p].name:=val;

            //from third line: read parameter values
            if (i>1) and (val<>'')then para[p].meter[i-2]:=strtofloat(val);

        end;
        //increase column counter
        inc(counter);
        //if a value is fixed then empty variable val
        val:='';
      end
      //merges single characters to a value (e.g. 1+2+3; --> 123)
      else val:=val+character;
    end; //end caracter a
  end; //end row i

end;


end.
