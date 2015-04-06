unit UwiringPiapp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus,contnrs,
         h2wiringpi;
type

  { TPinShape }

  TPinShape = class(TCheckBox)
     private
       FPinPhy : integer;
       FPinMode :  integer ;
       Fstrpinmode : string ;
       Fwire : integer ;
       Fstrwire : string ;

       procedure  setPinMode( const AValue: integer );
    public

       constructor Create(TheOwner: TComponent ; pin : integer ) ;reintroduce;
       procedure refreshwire();

    public
        property PinPhy: integer read FPinPhy ;
        property PinMode: integer read FPinMode write setPinMode ;
        property wire: integer read Fwire ;

  end;




type
  { TfrmWiringpiapp }

  TfrmWiringpiapp = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Image1: TImage;
    lblpinstatus: TStaticText;
    mnupullresup: TMenuItem;
    PopupMenu1: TPopupMenu;
    StaticText1: TStaticText;
    lblreadpin: TStaticText;

    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);

    procedure mnupullresupClick(Sender: TObject);
       procedure mnupullresNoneClick(Sender: TObject);
           procedure mnupullresDownClick(Sender: TObject);
     procedure pinMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ShapeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
  private
    { private declarations }
    wiringPiSetupdone : boolean;
    procedure dopullUpDnControl(wire: integer; valuse: TpullRisistor);
    procedure dorefreshALL();
    procedure pinCheckBox1Change(Sender: TObject);



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






{ TPinShape }

procedure TPinShape.setPinMode(const AValue: integer);
begin
  if FPinMode=AValue then exit;
  FPinMode:=AValue;

     case AValue of
            -1 : Fstrpinmode  := 'GRD';
            -2 :  Fstrpinmode := 'UKN';
            -3 :   Fstrpinmode := '3.3V';
            -5  :  Fstrpinmode := '5V';
            -6 ,-7 :   Fstrpinmode := 'NA';

            else

           Fstrpinmode := altmodes[Avalue] ;
             end;


end;

constructor TPinShape.Create(TheOwner: TComponent ; pin : integer);
begin

  inherited Create(TheOwner );
      Parent := twincontrol(TheOwner);
      Visible := true;
    //  Shape := stCircle  ;
      Height := 15 ;
      Width := 100 ;
      tag := pin;
      FPinPhy := pin;
      Checked := false;
      Enabled := true;
      caption := 'UKN';
      PinMode := -2;
      fwire := -2;






end;

procedure TPinShape.refreshwire();
begin

  Fwire := PI_2_Phy_toWire[FPinPhy] ;

   if Fwire >= 0  then
         begin
            Fstrwire :=  IntToStr (Fwire );

            PinMode := getAlt(Fwire)  ;
               // read the value ..
               if digitalRead(Fwire) = 1 then
               begin
               //   Color  := clred;
                 Checked   := true;


               end

               else
               begin
                 //   Color  := clblack   ;
                    Checked   := false;
               end;


         end
         else
          // other
          begin
           PinMode  := Fwire;

          end;


        caption :=  format('%3d %-4s %5s',[ FPinPhy, Fstrpinmode ,Fstrwire ])  ;



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
               lblpinstatus.caption := 'Mode : ' + getaltpintostr (PI_2_Phy_toWire[aPinPhy]  ) ;
         end else
         begin
              lblreadpin.caption := '' ;
              lblpinstatus.Caption := '';
         end;

   end
   ELSE
   begin
       StaticText1.Caption := ' PIN  ?';
   end;
end;
procedure TfrmWiringpiapp.dorefreshALL();
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

         // wire pins


          TPinShape(pinshapes[cnt -1]).refreshwire();


     end;

end;


procedure TfrmWiringpiapp.Button1Click(Sender: TObject);


begin
  dorefreshALL;


end;


procedure TfrmWiringpiapp.pinCheckBox1Change(Sender: TObject);
var
  awire : longint;

begin


  if sender is TPinShape then
  begin


        awire := TPinShape ( sender).wire;
     if awire > -1 then
     begin
         {       ops /// loop
         case   TPinShape ( sender).PinMode of
           0: // INPUT
           if      digitalRead(awire) = 0 then
                pullUpDnControl_pas(awire, prPUD_UP )
           else
               pullUpDnControl_pas(awire, prPUD_DOWN  );


            1: // OUT
           if      digitalRead(awire) = 0 then
                 digitalWrite(awire,1  )

           else
               digitalWrite(awire,0  )  ;
        end;

         //  dorefreshALL;
          }
     end
     else


         if TPinShape ( sender).Checked then
             TPinShape ( sender).Checked := false;
     end;





end;


procedure TfrmWiringpiapp.CheckBox1Change(Sender: TObject);
begin


   Image1.Visible := CheckBox1.Checked  ;
end;



procedure TfrmWiringpiapp.dopullUpDnControl(wire : integer ; valuse : TpullRisistor   );
begin
  if wiringPiSetupdone then
  begin
      pullUpDnControl_pas(wire, valuse);

  end;

   dorefreshALL;

end;

procedure TfrmWiringpiapp.mnupullresupClick(Sender: TObject);
var
  awire : Integer ;
begin
   if sender is TMenuItem then
   begin
         if TMenuItem ( Sender).Owner is TPopupMenu then
         begin
               awire := TPopupMenu (TMenuItem ( Sender).Owner).tag;

                dopullUpDnControl(awire,prPUD_UP  );
              // showmessage(inttostr(awire))
         end;
   end;
end;

procedure TfrmWiringpiapp.mnupullresDownClick(Sender: TObject);
var
  awire : Integer ;
begin
   if sender is TMenuItem then
   begin
         if TMenuItem ( Sender).Owner is TPopupMenu then
         begin
               awire := TPopupMenu (TMenuItem ( Sender).Owner).tag;

                dopullUpDnControl(awire,prPUD_DOWN   );
              // showmessage(inttostr(awire))
         end;
   end;
end;

procedure TfrmWiringpiapp.mnupullresNoneClick(Sender: TObject);
var
  awire : Integer ;
begin
   if sender is TMenuItem then
   begin
         if TMenuItem ( Sender).Owner is TPopupMenu then
         begin
               awire := TPopupMenu (TMenuItem ( Sender).Owner).tag;

                dopullUpDnControl(awire,prPUD_OFF   );
              // showmessage(inttostr(awire))
         end;
   end;
end;








procedure TfrmWiringpiapp.pinMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  tmp : TMenuItem ;
begin

  if button = mbRight  then
  begin
    // if  PopupMenu1 .Items.Count < 2 then
     // begin

         PopupMenu1.Items.Clear ;

         tmp := TMenuItem.Create(PopupMenu1)  ;
         tmp.caption := 'Resitor Pull UP';
          tmp.OnClick := @mnupullresupClick;
         PopupMenu1.Items.Add(tmp);

          tmp := TMenuItem.Create(PopupMenu1)  ;
         tmp.caption := 'Resitor Pull DOWN';
            tmp.OnClick := @mnupullresdownClick;
         PopupMenu1.Items.Add(tmp);

          tmp := TMenuItem.Create(PopupMenu1)  ;
         tmp.caption := 'Resitor Pull NONE';
             tmp.OnClick := @mnupullresnoneClick;
         PopupMenu1.Items.Add(tmp);


      //   end;

    if sender is TPinShape then
    begin
        if  TPinShape(sender).wire >= 0 then
        begin
       PopupMenu1.Tag := TPinShape(sender).wire  ;
       PopupMenu1.PopUp (x,y ) ;
       end
         else
         PopupMenu1.Tag := -2;

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
      PopupMenu1.items.Clear   ;

    CheckBox1.PopupMenu := PopupMenu1  ; // tetsing

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
        pinshape.OnMouseDown := @pinMouseDown;


     pinshape.OnMouseMove  := @ShapeMouseMove  ;
       pinshape .OnChange :=  @pinCheckBox1Change;


     pinshapes.Add(pinshape);


  end ;





end;





end.

