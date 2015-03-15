unit utest_interrupt;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils,h2wiringpi;

function setuppins :boolean;

procedure   makepinsblink;

implementation
procedure pintestint3;
begin
  // got an interrupt
   writeln('Pulled Low');
end;

function setuppins :boolean;

//var

//   pptest3 : pointer;

begin
   If wiringPiSetup <> -1 then // Setup Hardware (Gordons magic)
   Begin
    pinMode_pas (P11, pm_INPUT );
    //pullUpDnControl(P11,PUD_UP );
    pullUpDnControl_pas(P11,prPUD_UP  );
    pinMode_pas(P7, pm_OUTPUT );
    pinMode_pas(P12, pm_PWM_OUTPUT); //PWM only possible on P12
  //  pptest3 := @pintestint3;
    // set the interupt on pin 3
   wiringPiISR_pas ( P11, il_EDIGE_FALLING , @pintestint3 );
    result := true;
   end;

end;


procedure   makepinsblink;
var
   i : longint;
begin

// If digitalRead(P3) = 0 Then writeln('Pulled Low'); // If P3 gets pulled to ground
    pwmWrite (P12,0);
    digitalWrite(P7,HIGH); //Turn LED on P7 on
    delay(800);
    digitalWrite(P7,LOW); //Turn LED on P7 off
    for i:= 0 to 1023 do //Loop to make the LED on P12 grow brighter
     begin
      pwmWrite (P12,i);
      delay(2);
     end;
    for i:= 1023 downto 0 do //Loop to make the LED on P12 go dimmer
     begin
      pwmWrite (P12,i);
      delay(2);
     end;
 end;

end.

