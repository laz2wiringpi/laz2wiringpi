unit mcp4725_define;

{$mode objfpc}{$H+}



interface

uses
  Classes, SysUtils;

CONST
//# Registers
 __REG_WRITEDAC         = $40;
 __REG_WRITEDACEEPROM   = $60;



MCP4725_ADD1 = $62;
MCP4725_ADD2 = $64;

procedure  MCP4725_Write12bit(fh : longint ; value : longint );

implementation
uses h2wiringpi,h2wiringpii2c;

procedure  MCP4725_Write12bit(fh : longint ; value : longint );
begin

   if  value > 4096 then
   value := 4096 ;

      if  value < 0 then
   value := 0 ;

    wiringPiI2CWriteReg16(fh ,__REG_WRITEDAC,  (value Shr 4))  ;
end;



end.

