unit uads1x15;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,uasds1x15_define;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

function inttobin(I : integer ) : string ;
begin
     result := '';
     while I > 0 do
     begin
       result := chr(ord('0') + (I and 1) ) + Result ;
       I := I shr 1;

     end;
     while length (Result ) < 16 do
     result := '0' + Result;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  value : integer ;
begin

     if  not Assigned(ADS1015) then
     ADS1015 := TADS1015.Create()  ;
     value :=   ADS1015.readADC_SingleEnded(A0 );

    Button1.Caption  :=  IntToStr (value );
      Label1.Caption :=   (inttobin(value) );


end;

procedure TForm1.Button2Click(Sender: TObject);

     var
  value : integer ;
begin
    if  not Assigned(ADS1015) then
     ADS1015 := TADS1015.Create()  ;

    value :=   ADS1015.readADC_config();
         Label2 .Caption :=   (inttobin(value) );
end;

{$R *.lfm}

end.

