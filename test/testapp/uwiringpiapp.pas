unit UwiringPiapp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,contnrs;

type

  { TPinShape }

  TPinShape = class(Tshape)
     private
       FPinPhy : integer;
    public

       constructor Create(TheOwner: TComponent ; pin : integer ) ;reintroduce;
    public
        property PinPhy: integer read FPinPhy ;


  end;

type
  { TfrmWiringpiapp }

  TfrmWiringpiapp = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Shape1: TShape;
    StaticText1: TStaticText;
    lblreadpin: TStaticText;

    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShapeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
  private
    { private declarations }
    wiringPiSetupdone : boolean;
    procedure dopin(pin : longint );
    private
     pinshapes : tobjectlist;
  public
    { public declarations }
  end; 

var
  frmWiringpiapp: TfrmWiringpiapp;

implementation

{$R *.lfm}

{ TfrmWiringpiapp }
 uses h2wiringpi;

{ TPinShape }

constructor TPinShape.Create(TheOwner: TComponent ; pin : integer);
begin

  inherited Create(TheOwner );
      Parent := twincontrol(TheOwner);
      Visible := true;
      Shape := stCircle  ;
      Height := 15 ;
      Width := 15 ;
      tag := pin;
      FPinPhy := pin;
end;

procedure TfrmWiringpiapp.ShapeMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  APinPhy : integer ;
  stringwire : string ;

begin
   if sender is TpinShape then
   begin

            aPinPhy :=  TpinShape(sender).PinPhy;

            case PI_2_Phy_toWire[aPinPhy] of
            -1 : stringwire := 'GRD';

            -3 :   stringwire := '3.3V';
            -5  :  stringwire := '5V';
            -6 ,-7 :   stringwire := 'NA';

            else

            stringwire := inttostr(PI_2_Phy_toWire[aPinPhy] );
             end;



         StaticText1.Caption := 'PIN ' + inttostr(aPinPhy) +
         ' Wire ' + stringwire ;

         if wiringPiSetupdone then
         if PI_2_Phy_toWire[aPinPhy] >= 0  then
         begin
               // read the value ..
               lblreadpin.caption := 'value : ' + inttostr(digitalRead(PI_2_Phy_toWire[aPinPhy] ) ) ;
         end else
         begin
              lblreadpin.caption := '' ;
         end;

   end
   ELSE
   begin
       StaticText1.Caption := ' PIN  ?';
   end;
end;

procedure TfrmWiringpiapp.Button1Click(Sender: TObject);
var
  cnt :integer ;

begin
   try
       // crash if not root no way to detect ..
        if not wiringPiSetupdone then
       wiringPiSetup ;
    except
       ShowMessage(' wiringPiSetup Run as root ') ;
    end;

     wiringPiSetupdone := true;
     for cnt := 1 to 40 do
     begin
         if PI_2_Phy_toWire[cnt] >= 0  then
         begin
               // read the value ..
               if digitalRead(PI_2_Phy_toWire[cnt ]) = 1 then
               begin
                 TPinShape(pinshapes[cnt -1]).Brush.Color  := clred   ;

               end

               else
               begin
                    TPinShape(pinshapes[cnt -1]).Brush.Color  := clWhite   ;
               end;

               //lblreadpin.caption := 'value : ' + inttostr(digitalRead(PI_2_Phy_toWire[aPinPhy] ) ) ;
         end;
     end;

end;

procedure TfrmWiringpiapp.FormCreate(Sender: TObject);
var
  cnt : integer ;
  pinshape : TPinShape;

begin
  Inherited;
  pinshapes := tobjectlist.create(false);

  for cnt := 1 to 40    do
  begin


     pinshape := TPinShape.Create(self,cnt) ;

     if odd(cnt) then
     begin
           pinshape.left := 43 ;
             pinshape.Top:= (cnt  * 12) + 50 ;
     end

     else
     begin
          pinshape.left := 285 ;
            pinshape.Top:= ((cnt-1)  * 12) + 50 ;
     end;


     pinshape.OnMouseMove  := @ShapeMouseMove  ;
     pinshapes.Add(pinshape);


  end ;





end;

procedure TfrmWiringpiapp.dopin(pin: longint);
begin

      StaticText1.Caption := 'WIRE ' + inttostr(pin) +
      '  BCM  ' + inttostr( wpiPinToGpio( pin )) ;


end;



end.

