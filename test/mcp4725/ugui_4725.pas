unit ugui_4725;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { private declarations }
    fhdac : longint;
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation


{$R *.lfm}
uses
  mcp4725_define,h2wiringpi,h2wiringpii2c;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

  fhdac:= wiringPiI2CSetup(MCP4725_ADD1) ;

end;

procedure TForm1.TrackBar1Change(Sender: TObject);


begin

   MCP4725_Write12bit( fhdac, TTrackBar (Sender ).Position );


end;

end.

