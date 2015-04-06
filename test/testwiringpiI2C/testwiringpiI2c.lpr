program testwiringpiI2c;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, h2wiringpiI2c
  { you can add units after this };

type

  { wiringpiI2CTest }

  wiringpiI2CTest = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
  end;

{ wiringpiI2CTest }

procedure wiringpiI2CTest.DoRun;
var

  fh_MCP4725 : longint ;

CONST
  IC2C_DEV_MCP4725 = $62 ;     // 62 and 63 .. jumper only 2
  MCP4725_REG_WRITEDAC = $40;
  MCP4725_REG_WRITEDAC_EPROM = $60;

CONST IC2C_DEV_ADS_1015=  $48 ; // $48
begin

  { add your program here }

  // test of the wire I2C wrapper

  fh_MCP4725 := wiringPiI2CSetup(IC2C_DEV_MCP4725); // hex 20
  if fh_MCP4725 = -1 then
      writeln('-1 on wiringPiI2CSetup 20 ');
        writeln( IntToStr (fh_MCP4725));

   // test loop
   while true do

   begin
        wiringPiI2CWriteReg16 (fh_MCP4725,MCP4725_REG_WRITEDAC,0);
     Sleep(100);
     wiringPiI2CWriteReg16 (fh_MCP4725,MCP4725_REG_WRITEDAC,$FFFFFFFFF);
      Sleep(100);
   end;

     // dummy loop
 // writeln (inttostr(  wiringPiI2CRead(fh)));
//  writeln (inttostr(  wiringPiI2CReadReg8(fh,tmpreg )));
 //  writeln (inttostr(  wiringPiI2CReadReg16(fh,tmpreg )));
  //   writeln (inttostr(  wiringPiI2CWrite (fh ,tmpdata)));
 // writeln (inttostr(  wiringPiI2CWriteReg8 (fh,tmpreg ,tmpdata)));
 //  writeln (inttostr(  wiringPiI2CWriteReg16 (fh,tmpreg ,tmpdata)));
     {
    //extern int wiringPiI2CRead           (int fd) ;
Function wiringPiI2CRead(fd : longint ):longint;cdecl;external;

//extern int wiringPiI2CReadReg8       (int fd, int reg) ;
Function wiringPiI2CReadReg8(fd : longint;reg : longint ):longint;cdecl;external;

//extern int wiringPiI2CReadReg16      (int fd, int reg) ;
Function wiringPiI2CReadReg16(fd : longint;reg : longint ):longint;cdecl;external;

//extern int wiringPiI2CWrite          (int fd, int data) ;
Function wiringPiI2CWrite(fd : longint;data : longint ):longint;cdecl;external;

//extern int wiringPiI2CWriteReg8      (int fd, int reg, int data) ;
Function wiringPiI2CWriteReg8(fd : longint;reg : longint ;data : longint ):longint;cdecl;external;

//extern int wiringPiI2CWriteReg16     (int fd, int reg, int data) ;
Function wiringPiI2CWriteReg16(fd : longint;reg : longint ;data : longint ):longint;cdecl;external;
      }
      // veify dummy link code ..

 //  end;

  // stop program loop
  Terminate;
end;

var
  Application: wiringpiI2CTest;

{$R *.res}

begin
  Application:=wiringpiI2CTest.Create(nil);
  Application.Run;
  Application.Free;
end.

