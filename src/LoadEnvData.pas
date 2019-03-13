unit LoadEnvData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;
 //...food data storrage.........................................................
type
    T_fooddata=class
    foodamount: array of double;
    constructor create;
end;
//...tox data storrage.........................................................
type
    T_toxdata=class
    toxconc: array of double;
    constructor create;
end;

type
    TForm_LoadEnv = class(TForm)
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    Memo1: TMemo;
    Memo2: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_LoadEnv: TForm_LoadEnv;

implementation

{$R *.dfm}

uses LoadData;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                       load food data from file
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
constructor T_fooddata.create;
var
t,i,a:integer;
character:char;
counter, nr_conc:integer;
line, val:string;
begin
  Form_LoadEnv.Memo1.Clear;
  Form_LoadEnv.OpenDialog1.Title:='Load food data';
  if Form_LoadEnv.OpenDialog1.Execute then Form_LoadEnv.Memo1.Lines.Loadfromfile (Form_LoadEnv.OpenDialog1.FileName);

  setlength(foodamount,Form_LoadEnv.memo1.lines.Count-1);
  t:=0;
  //...load data...........................................................
  for i := 0 to Form_LoadEnv.memo1.lines.Count - 1 do
  begin
    //writes memo line into variable 'line'
    line:=Form_LoadEnv.memo1.lines[i]+',';
    //empties the variable val:
    val:='';
    //sets column counter to 0
    counter:=0;
    //goes through lines
    for a := 1 to length(line) do
    begin
      character:=line[a];
      if character=',' then
      begin
        //ignore first line
        //from second line: concentrations in second column, ignore first column
        if (i>0) and (val<>'')then
        begin
              if counter=1 then
             begin
                foodamount[t]:=strtofloat(val);
                inc(t);
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
  end;
end;

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                       load tox data from file
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
//procedure TForm_Load.loadfooddata;
constructor T_toxdata.create;
var
t,i,a:integer;
character:char;
counter, nr_conc:integer;
line, val:string;
begin
  Form_LoadEnv.Memo2.Clear;
  Form_LoadEnv.OpenDialog2.Title:='Load exposure scenario data';
  if Form_LoadEnv.OpenDialog2.Execute then Form_LoadEnv.Memo2.Lines.Loadfromfile (Form_LoadEnv.OpenDialog2.FileName);

  setlength(toxconc,Form_LoadEnv.memo2.lines.Count-1);
  t:=0;
  //...load data...........................................................
  for i := 0 to Form_LoadEnv.memo2.lines.Count - 1 do
  begin
    //writes memo line into variable 'line'
    line:=Form_LoadEnv.memo2.lines[i]+',';
    //empties the variable val:
    val:='';
    //sets column counter to 0
    counter:=0;
    //goes through lines
    for a := 1 to length(line) do
    begin
      character:=line[a];
      //if the current character is ';' (marks end of a field in csv file) then do...
      if character=',' then
      begin
        //ignore first line
        //from second line: concentrations in second column, ignore first column
        if (i>0) and (val<>'')then
        begin
             if counter=1 then
             begin
                toxconc[t]:=strtofloat(val);
                inc(t);
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
  end;
end;

end.
