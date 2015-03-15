program wiringPiapp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UwiringPiapp
  { you can add units after this }
  ,h2wiringpi,dialogs;

{$R *.res}

begin
 //   if wiringPiSetup = -1
  //  then
  //  ShowMessage('Run as root ') ;

  Application.Title:='Test wiringPi app';
  Application.Initialize;

  Application.CreateForm(TfrmWiringpiapp, frmWiringpiapp);
  Application.Run;
end.

