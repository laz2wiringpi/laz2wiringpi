unit h2wiringpiI2c;

(* Pascal wrapper unit for Gordon Henderson wiringPi library. The source can
 * be found at https://http://wiringpi.com
 *
 * hwiringpi: origanal Wrapper and
 * pascal sample by Alex Schaller.
 *
 * h2wiringpiI2C: Version 0.1 By Allen Roton
 * wiringPi Version 2.23
 * $linklib
 *
 * wiringPi:
 *	Arduino compatable (ish) Wiring library for the Raspberry Pi
 *	Copyright (c) 2012 Gordon Henderson
 ***********************************************************************
 * This file is part of wiringPi:
 *	https://projects.drogon.net/raspberry-pi/wiringpi/
 *
 *    wiringPi is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    wiringPi is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
 ***********************************************************************
 *)

//{$mode objfpc}{$H+}

{$linklib c}
{$linklib libwiringPi}
interface
    {

    }


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

//extern int wiringPiI2CSetupInterface (const char *device, int devId) ;
// ??? what is it ?

//extern int wiringPiI2CSetup          (const int devId) ;
Function wiringPiI2CSetup(devId : longint ):longint;cdecl;external;


implementation

end.

