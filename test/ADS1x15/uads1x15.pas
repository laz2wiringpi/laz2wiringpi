unit uads1x15;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,uasds1x15_define;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
    ADS1015 : TADS1015;
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation


{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin

     ADS1015 := TADS1015.Create()  ;
    Button1.Caption  :=  IntToStr ( ADS1015.readADC_SingleEnded(A0 ));


end;

{$R *.lfm}

end.

