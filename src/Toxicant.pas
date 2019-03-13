unit Toxicant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Vcl.ExtCtrls;

type
  TForm_Toxicant = class(TForm)
    Panel1:               TPanel;
    P_sublethal:          TPanel;
    P_lethal:             TPanel;
    CB_sublethal:         TCheckBox;
    CB_lethal:            TCheckBox;
    Label1:               TLabel;
    E_c01:                TLabeledEdit;
    E_cT1:                TLabeledEdit;
    E_c02:                TLabeledEdit;
    E_cT2:                TLabeledEdit;
    E_c03a:               TLabeledEdit;
    E_cT3a:               TLabeledEdit;
    E_c03b:               TLabeledEdit;
    E_cT3b:               TLabeledEdit;
    E_c04:                TLabeledEdit;
    E_cT4:                TLabeledEdit;
    E_c05:                TLabeledEdit;
    E_cT5:                TLabeledEdit;
    E_c06:                TLabeledEdit;
    E_cT6:                TLabeledEdit;
    CB_pmo1:              TCheckBox;
    CB_pmo2:              TCheckBox;
    CB_pmo3a:             TCheckBox;
    CB_pmo3b:             TCheckBox;
    CB_pmo4:              TCheckBox;
    CB_pmo5:              TCheckBox;
    CB_pmo6:              TCheckBox;
    RG_exposure_scenario: TRadioGroup;
    P_tk:                 TPanel;
    E_tox_concentration:  TLabeledEdit;
    E_tox_time:           TLabeledEdit;
    E_exposure_start:     TLabeledEdit;
    RG_metric:            TRadioGroup;
    E_ki:                 TLabeledEdit;
    E_ke:                 TLabeledEdit;
    E_krec:               TLabeledEdit;
    RG_SD_IT:             TRadioGroup;
    E_kk:                 TLabeledEdit;
    E_z:                  TLabeledEdit;
    E_alpha:              TLabeledEdit;
    E_beta:               TLabeledEdit;
    RG_modelchoice:       TRadioGroup;
    P_doseresponse:       TPanel;
    P_acute:              TPanel;
    P_repro:              TPanel;
    Label2:               TLabel;
    E_Acute_EC50:         TLabeledEdit;
    E_Acute_Slope:        TLabeledEdit;
    E_Repro_EC50:         TLabeledEdit;
    E_Repro_Slope:        TLabeledEdit;
    CB_g_dil: TCheckBox;
    Label3: TLabel;
    procedure CB_sublethalClick(Sender: TObject);
    procedure CB_lethalClick(Sender: TObject);
    procedure CB_pmo1Click(Sender: TObject);
    procedure CB_pmo2Click(Sender: TObject);
    procedure CB_pmo3aClick(Sender: TObject);
    procedure CB_pmo3bClick(Sender: TObject);
    procedure CB_pmo4Click(Sender: TObject);
    procedure CB_pmo5Click(Sender: TObject);
    procedure CB_pmo6Click(Sender: TObject);
    procedure RG_metricClick(Sender: TObject);
    procedure RG_SD_ITClick(Sender: TObject);
    procedure RG_modelchoiceClick(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form_Toxicant: TForm_Toxicant;

implementation

{$R *.dfm}

{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
               Check box procedures: show parameter boxes
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
//shows lethal effect panels:
procedure TForm_Toxicant.CB_lethalClick(Sender: TObject);
begin
 if CB_lethal.checked then
   begin
    case RG_modelchoice.ItemIndex of
     0: begin  P_lethal.Visible:=true; end;
     1: begin  P_acute.Visible:=true; end;
    end;
   end
    else
    begin
      P_lethal.Visible:=false; P_acute.Visible:=false;
    end;
end;

//shows sub-lethal effect panels:
procedure TForm_Toxicant.CB_sublethalClick(Sender: TObject);
begin
 //if CB_sublethal.checked then P_sublethal.Visible:=true else P_sublethal.Visible:=false;
    if CB_sublethal.checked then
    begin
       case RG_modelchoice.ItemIndex of
         0: begin P_sublethal.Visible:=true; P_sublethal.Visible:=true; RG_SD_IT.Visible:=true;  end;
         1: begin P_sublethal.Visible:=false; P_sublethal.Visible:=false; RG_SD_IT.Visible:=false; P_repro.Visible:=true; end;
       end;
    end
    else
     begin
       P_repro.Visible:=false;
       P_sublethal.Visible:=false;
     end;
end;


//Toxicokinetic panel settings:
procedure TForm_Toxicant.RG_metricClick(Sender: TObject);
begin
 case RG_metric.ItemIndex of
   0:begin E_ki.Visible:=false; E_ke.visible:=false; E_krec.visible:=false; CB_g_dil.visible:=false; end;
   1:begin E_ki.Visible:=true;  E_ke.visible:=true;  E_krec.visible:=false; CB_g_dil.visible:=false; end;
   2:begin E_ki.Visible:=false; E_ke.visible:=true;  E_krec.visible:=false; CB_g_dil.visible:=false; end;
   3:begin E_ki.Visible:=false; E_ke.visible:=true;  E_krec.visible:=false; CB_g_dil.visible:=true;  end;
   4:begin E_ki.Visible:=true;  E_ke.visible:=true;  E_krec.visible:=true;  CB_g_dil.visible:=false; end;
 end;
end;

//panel settings for effect model choice
procedure TForm_Toxicant.RG_modelchoiceClick(Sender: TObject);
begin
   CB_lethal.Checked:=false;
   CB_sublethal.Checked:=false;
   case RG_modelchoice.ItemIndex of
    0: begin P_tk.Visible:=true; P_sublethal.Visible:=false; RG_SD_IT.Visible:=true; P_doseresponse.Visible:=false;  end;
    1: begin P_tk.Visible:=false; P_sublethal.Visible:=false; RG_SD_IT.Visible:=false; P_doseresponse.Visible:=true; end;
   end;
end;

//Lethal effect panel settings
procedure TForm_Toxicant.RG_SD_ITClick(Sender: TObject);
begin
  case RG_SD_IT.ItemIndex of
   0:begin E_alpha.Visible:=true; E_beta.visible:=true; E_kk.visible:=false; E_z.visible:=false; end;
   1:begin E_alpha.Visible:=false; E_beta.visible:=false; E_kk.visible:=true; E_z.visible:=true; end;
  end;
end;

//Parameter input for effect on feeding:
procedure TForm_Toxicant.CB_pmo1Click(Sender: TObject);
begin
  if CB_pmo1.checked then E_C01.Visible:=true else E_C01.Visible:=false;
  if CB_pmo1.checked then E_CT1.Visible:=true else E_CT1.Visible:=false;
end;
//Parameter intput for effect on assimilation:
procedure TForm_Toxicant.CB_pmo2Click(Sender: TObject);
begin
  if CB_pmo2.checked then E_C02.Visible:=true else E_C02.Visible:=false;
  if CB_pmo2.checked then E_CT2.Visible:=true else E_CT2.Visible:=false;
end;
//Parameter intput for effect on maturity mainenance:
procedure TForm_Toxicant.CB_pmo3aClick(Sender: TObject);
begin
  if CB_pmo3a.checked then E_C03a.Visible:=true else E_C03a.Visible:=false;
  if CB_pmo3a.checked then E_CT3a.Visible:=true else E_CT3a.Visible:=false;
end;
//Parameter intput for effect on somatic mainenance:
procedure TForm_Toxicant.CB_pmo3bClick(Sender: TObject);
begin
  if CB_pmo3b.checked then E_C03b.Visible:=true else E_C03b.Visible:=false;
  if CB_pmo3b.checked then E_CT3b.Visible:=true else E_CT3b.Visible:=false;
end;
//Parameter intput for effect on cost for growth:
procedure TForm_Toxicant.CB_pmo4Click(Sender: TObject);
begin
  if CB_pmo4.checked then E_C04.Visible:=true else E_C04.Visible:=false;
  if CB_pmo4.checked then E_CT4.Visible:=true else E_CT4.Visible:=false;
end;
//Parameter intput for effect on cost for reproduction:
procedure TForm_Toxicant.CB_pmo5Click(Sender: TObject);
begin
  if CB_pmo5.checked then E_C05.Visible:=true else E_C05.Visible:=false;
  if CB_pmo5.checked then E_CT5.Visible:=true else E_CT5.Visible:=false;
end;
//Parameter intput for effect on hazard for embryo:
procedure TForm_Toxicant.CB_pmo6Click(Sender: TObject);
begin
  if CB_pmo6.checked then E_C06.Visible:=true else E_C06.Visible:=false;
  if CB_pmo6.checked then E_CT6.Visible:=true else E_CT6.Visible:=false;
end;

end.
