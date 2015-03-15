program testinterrupt;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, utest_interrupt
  { you can add units after this }
  ,h2wiringpi
  ;

type

  { test_lsr }

  test_lsr = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ test_lsr }

procedure test_lsr.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }



   writeln('Starting ' );
  If setuppins then // Setup Hardware (Gordons magic)
  begin
      writeln('BOARD :' +  piboardtostr() );
    While true do
    begin
        makepinsblink;
    end;
  end

  Else
   Begin
    writeln('Error Setting up the RaspberryPi2');
   End;
  // stop program loop


  Terminate;
end;

constructor test_lsr.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor test_lsr.Destroy;
begin
  inherited Destroy;
end;

procedure test_lsr.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: test_lsr;

{$R *.res}

begin
  Application:=test_lsr.Create(nil);
  Application.Run;
  Application.Free;
end.

