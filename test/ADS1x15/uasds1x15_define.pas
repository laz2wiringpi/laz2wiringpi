unit uasds1x15_define;

{$mode objfpc}{$H+}

interface
{
/**************************************************************************/
/*!
    @file     Adafruit_ADS1015.h
    @author   K. Townsend (Adafruit Industries;
    @license  BSD (see license.txt)

    This is a library for the Adafruit ADS1015 breakout board
    ----> https://www.adafruit.com/products/???

    Adafruit invests time and resources providing this open source code,
    please support Adafruit and open-source hardware by purchasing
    products from Adafruit!

    @section  HISTORY

    v1.0  - First release
    v1.1  - Added ADS1115 support - W. Earl
*/
/**************************************************************************/

#if ARDUINO >= 100
 #include "Arduino.h"
#else
 #include "WProgram.h"
#endif

#include <Wire.h>
      }
 uses
  Classes, SysUtils ;

 CONST
{/*=========================================================================
    I2C ADDRESS/BITS
    -----------------------------------------------------------------------*/}
     ADS1015_ADDRESS       =         $48;   // 1001 000 (ADDR = GND)
{/*=========================================================================*/}

{/*=========================================================================
    CONVERSION DELAY (in mS)
    -----------------------------------------------------------------------*/}
    ADS1015_CONVERSIONDELAY   =      1;
    ADS1115_CONVERSIONDELAY   =      8;
{/*=========================================================================*/}

{/*=========================================================================
    POINTER REGISTER
    -----------------------------------------------------------------------*/}
    ADS1015_REG_POINTER_MASK        = $03;
    ADS1015_REG_POINTER_CONVERT     = $00;
    ADS1015_REG_POINTER_CONFIG      = $01;
    ADS1015_REG_POINTER_LOWTHRESH   = $02;
    ADS1015_REG_POINTER_HITHRESH    = $03;
{/*=========================================================================*/}

{/*=========================================================================
    CONFIG REGISTER
    -----------------------------------------------------------------------*/}
    ADS1015_REG_CONFIG_OS_MASK      = $8000;
    ADS1015_REG_CONFIG_OS_SINGLE    = $8000;  // Write: Set to start a single-conversion
    ADS1015_REG_CONFIG_OS_BUSY      = $0000;  // Read: Bit = 0 when conversion is in progress
    ADS1015_REG_CONFIG_OS_NOTBUSY   = $8000;  // Read: Bit = 1 when device is not performing a conversion

    ADS1015_REG_CONFIG_MUX_MASK     = $7000;
    ADS1015_REG_CONFIG_MUX_DIFF_0_1 = $0000;  // Differential P = AIN0, N = AIN1 (default;
    ADS1015_REG_CONFIG_MUX_DIFF_0_3 = $1000;  // Differential P = AIN0, N = AIN3
    ADS1015_REG_CONFIG_MUX_DIFF_1_3 = $2000;  // Differential P = AIN1, N = AIN3
    ADS1015_REG_CONFIG_MUX_DIFF_2_3 = $3000;  // Differential P = AIN2, N = AIN3
    ADS1015_REG_CONFIG_MUX_SINGLE_0 = $4000;  // Single-ended AIN0
    ADS1015_REG_CONFIG_MUX_SINGLE_1 = $5000;  // Single-ended AIN1
    ADS1015_REG_CONFIG_MUX_SINGLE_2 = $6000;  // Single-ended AIN2
    ADS1015_REG_CONFIG_MUX_SINGLE_3 = $7000;  // Single-ended AIN3

    ADS1015_REG_CONFIG_PGA_MASK     = $0E00;
    ADS1015_REG_CONFIG_PGA_6_144V   = $0000;  // +/-6.144V range = Gain 2/3
    ADS1015_REG_CONFIG_PGA_4_096V   = $0200;  // +/-4.096V range = Gain 1
    ADS1015_REG_CONFIG_PGA_2_048V   = $0400;  // +/-2.048V range = Gain 2 (default;
    ADS1015_REG_CONFIG_PGA_1_024V   = $0600;  // +/-1.024V range = Gain 4
    ADS1015_REG_CONFIG_PGA_0_512V   = $0800;  // +/-0.512V range = Gain 8
    ADS1015_REG_CONFIG_PGA_0_256V   = $0A00;  // +/-0.256V range = Gain 16

    ADS1015_REG_CONFIG_MODE_MASK    = $0100;
    ADS1015_REG_CONFIG_MODE_CONTIN  = $0000;  // Continuous conversion mode
    ADS1015_REG_CONFIG_MODE_SINGLE  = $0100;  // Power-down single-shot mode (default;

    ADS1015_REG_CONFIG_DR_MASK      = $00E0;
    ADS1015_REG_CONFIG_DR_128SPS    = $0000;  // 128 samples per second
    ADS1015_REG_CONFIG_DR_250SPS    = $0020;  // 250 samples per second
    ADS1015_REG_CONFIG_DR_490SPS    = $0040;  // 490 samples per second
    ADS1015_REG_CONFIG_DR_920SPS    = $0060;  // 920 samples per second
    ADS1015_REG_CONFIG_DR_1600SPS   = $0080;  // 1600 samples per second (default;
    ADS1015_REG_CONFIG_DR_2400SPS   = $00A0;  // 2400 samples per second
    ADS1015_REG_CONFIG_DR_3300SPS   = $00C0;  // 3300 samples per second

    ADS1015_REG_CONFIG_CMODE_MASK   = $0010;
    ADS1015_REG_CONFIG_CMODE_TRAD   = $0000;  // Traditional comparator with hysteresis (default)
    ADS1015_REG_CONFIG_CMODE_WINDOW = $0010;  // Window comparator

    ADS1015_REG_CONFIG_CPOL_MASK    = $0008;
    ADS1015_REG_CONFIG_CPOL_ACTVLOW = $0000;  // ALERT/RDY pin is low when active (default)
    ADS1015_REG_CONFIG_CPOL_ACTVHI  = $0008;  // ALERT/RDY pin is high when active

    ADS1015_REG_CONFIG_CLAT_MASK    = $0004;  // Determines if ALERT/RDY pin latches once asserted
    ADS1015_REG_CONFIG_CLAT_NONLAT  = $0000;  // Non-latching comparator (default)
    ADS1015_REG_CONFIG_CLAT_LATCH   = $0004;  // Latching comparator

    ADS1015_REG_CONFIG_CQUE_MASK    = $0003;
    ADS1015_REG_CONFIG_CQUE_1CONV   = $0000;  // Assert ALERT/RDY after one conversions
    ADS1015_REG_CONFIG_CQUE_2CONV   = $0001;  // Assert ALERT/RDY after two conversions
    ADS1015_REG_CONFIG_CQUE_4CONV   = $0002;  // Assert ALERT/RDY after four conversions
    ADS1015_REG_CONFIG_CQUE_NONE    = $0003;  // Disable the comparator and put ALERT/RDY in high state (default)
{/*=========================================================================*/}
 type

TadsGain_t =
(
  GAIN_TWOTHIRDS    = ADS1015_REG_CONFIG_PGA_6_144V,
  GAIN_ONE          = ADS1015_REG_CONFIG_PGA_4_096V,
  GAIN_TWO          = ADS1015_REG_CONFIG_PGA_2_048V,
  GAIN_FOUR         = ADS1015_REG_CONFIG_PGA_1_024V,
  GAIN_EIGHT        = ADS1015_REG_CONFIG_PGA_0_512V,
  GAIN_SIXTEEN      = ADS1015_REG_CONFIG_PGA_0_256V
);

TADS1015channel = ( A0,A1,A2,A3);

{ TAdafruit_ADS1015 }

{ TADS1015 }

TADS1015 = class


Private
   // Instance-specific properties
      Fi2cAddress : byte;
      FconversionDelay: byte;
      FbitShift : byte;
     Fgain : TadsGain_t;
     fh : longint;




 public
       constructor Create     (  i2cAddress : byte  = ADS1015_ADDRESS);
       function readADC_SingleEnded(channel: TADS1015channel): integer;
       function readADC_config(): integer;
   {
  void begin(void);
  uint16_t  readADC_SingleEnded(uint8_t channel);
  int16_t   readADC_Differential_0_1(void);
  int16_t   readADC_Differential_2_3(void);
  void      startComparator_SingleEnded(uint8_t channel, int16_t threshold);
  int16_t   getLastConversionResults();
  void      setGain(adsGain_t gain);
  adsGain_t getGain(void);



     }
     end ;


implementation

    uses h2wiringpi,h2wiringpii2c;

{ TAdafruit_ADS1015 }
  {

/*!
    @brief  Instantiates a new ADS1015 class w/appropriate properties
*/
/**************************************************************************/
}
constructor TADS1015.Create(i2cAddress: byte);
begin


   Fi2cAddress:= i2cAddress;
   FconversionDelay:= ADS1015_CONVERSIONDELAY;
   FbitShift:= 4;
   Fgain:= GAIN_TWOTHIRDS; // /* +/- 6.144V range (limited to VDD +0.3V max!) */

end;

  { TODO
/**************************************************************************/
/*!
    @brief  Instantiates a new ADS1115 class w/appropriate properties
*/
/**************************************************************************/
constructor TAdafruit_ADS1115.Create(i2cAddress: byte);
begin
{
   Fi2cAddress:=i2cAddress;
   FconversionDelay:=ADS1115_CONVERSIONDELAY;
   FbitShift:=0;
   Fgain:=GAIN_TWOTHIRDS; /* +/- 6.144V range (limited to VDD +0.3V max!) */
   end
}
    }


{

/**************************************************************************/
/*!
    @brief  Gets a single-ended ADC reading from the specified channel
*/
/**************************************************************************/

}
 function  TADS1015.readADC_SingleEnded(  channel : TADS1015channel  ) : integer ;
 var
  config : integer   ;

 begin
    result := 0;


      config := (ADS1015_REG_CONFIG_CQUE_NONE   OR // Disable the comparator (default val)
                    ADS1015_REG_CONFIG_CLAT_NONLAT  OR  // Non-latching (default val)
                    ADS1015_REG_CONFIG_CPOL_ACTVLOW OR  // Alert/Rdy active low   (default val)
                    ADS1015_REG_CONFIG_CMODE_TRAD   OR  // Traditional comparator (default val)
                    ADS1015_REG_CONFIG_DR_1600SPS   OR  // 1600 samples per second (default)
                    ADS1015_REG_CONFIG_MODE_SINGLE);   // Single-shot mode (default)



     config := 34179;
       config := (config OR $200);
    case channel of
    A0 : config :=  (config OR  ADS1015_REG_CONFIG_MUX_SINGLE_0);

    A1 : config :=  (config OR  ADS1015_REG_CONFIG_MUX_SINGLE_1);

    A2 : config :=  (config OR  ADS1015_REG_CONFIG_MUX_SINGLE_2);

    A3 : config :=  (config OR  ADS1015_REG_CONFIG_MUX_SINGLE_3);


    end;

     config :=  (config OR  ADS1015_REG_CONFIG_OS_SINGLE);
  //  config := 34179;

     if fh = 0 then
    fh :=  wiringPiI2CSetup(Fi2cAddress) ;

     wiringPiI2CWriteReg16( fh ,ADS1015_REG_POINTER_CONFIG ,config ) ;

     sleep   (1000);


     result :=   (  wiringPiI2CReadReg16 ( fh ,ADS1015_REG_POINTER_CONVERT  )   ) ;



 end;

  function TADS1015.readADC_config(): integer;
 begin
       if fh = 0 then
    fh :=  wiringPiI2CSetup(Fi2cAddress) ;


     result :=   (  wiringPiI2CReadReg16 ( fh ,ADS1015_REG_POINTER_CONFIG  )   ) ;
 end;

  {

  // Start with default values
  uint16_t config = ADS1015_REG_CONFIG_CQUE_NONE    | // Disable the comparator (default val)
                    ADS1015_REG_CONFIG_CLAT_NONLAT  | // Non-latching (default val)
                    ADS1015_REG_CONFIG_CPOL_ACTVLOW | // Alert/Rdy active low   (default val)
                    ADS1015_REG_CONFIG_CMODE_TRAD   | // Traditional comparator (default val)
                    ADS1015_REG_CONFIG_DR_1600SPS   | // 1600 samples per second (default)
                    ADS1015_REG_CONFIG_MODE_SINGLE;   // Single-shot mode (default)

  // Set PGA/voltage range
  config |= m_gain;

  // Set single-ended input channel
  switch (channel)
  {
    case (0):
      config |= ADS1015_REG_CONFIG_MUX_SINGLE_0;
      break;
    case (1):
      config |= ADS1015_REG_CONFIG_MUX_SINGLE_1;
      break;
    case (2):
      config |= ADS1015_REG_CONFIG_MUX_SINGLE_2;
      break;
    case (3):
      config |= ADS1015_REG_CONFIG_MUX_SINGLE_3;
      break;
  }

  // Set 'start single-conversion' bit
  config |= ADS1015_REG_CONFIG_OS_SINGLE;

  // Write config register to the ADC
  writeRegister(m_i2cAddress, ADS1015_REG_POINTER_CONFIG, config);

  // Wait for the conversion to complete
  delay(m_conversionDelay);

  // Read the conversion results
  // Shift 12-bit results right 4 bits for the ADS1015
  return readRegister(m_i2cAddress, ADS1015_REG_POINTER_CONVERT) >> m_bitShift;
}


end.

