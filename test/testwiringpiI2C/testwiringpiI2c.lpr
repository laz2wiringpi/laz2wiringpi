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

  fh : longint ;
  tmpreg :longint  = 1;
  tmpdata :longint  = 2;
begin

  { add your program here }

  // test of the wire I2C wrapper

  fh := wiringPiI2CSetup(32); // hex 20
  if fh = -1 then
      writeln('-1 on wiringPiI2CSetup 20 ');
        writeln( IntToStr (fh));
//   while true do

   begin
     // dummy loop
  writeln (inttostr(  wiringPiI2CRead(fh)));
  writeln (inttostr(  wiringPiI2CReadReg8(fh,tmpreg )));
   writeln (inttostr(  wiringPiI2CReadReg16(fh,tmpreg )));
     writeln (inttostr(  wiringPiI2CWrite (fh ,tmpdata)));
  writeln (inttostr(  wiringPiI2CWriteReg8 (fh,tmpreg ,tmpdata)));
   writeln (inttostr(  wiringPiI2CWriteReg16 (fh,tmpreg ,tmpdata)));
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

   end;

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

