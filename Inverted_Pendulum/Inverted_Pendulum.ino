#include <ADXL345.h>
#include <bma180.h>
#include <HMC58X3.h>
#include <ITG3200.h>
#include <MS561101BA.h>
#include <I2Cdev.h>
#include <MPU60X0.h>
#include <EEPROM.h>
#include <PID_v1.h>

//#define DEBUG
#include "DebugUtils.h"
#include "CommunicationUtils.h"
#include "FreeIMU.h"
#include <Wire.h>
#include <SPI.h>

#define PIN_1 5
#define PIN_2 6

int raw_values[9];
//char str[512];
float ypr[3]; // yaw pitch roll
float val[9];

//Define Variables we'll be connecting to
double Setpoint, Input, Output;

//Specify the links and initial tuning parameters
double Kp=2, Ki=5, Kd=1;
PID myPID(&Input, &Output, &Setpoint, Kp, Ki, Kd, DIRECT);

// Set the FreeIMU object
FreeIMU my3IMU = FreeIMU();
void setup() { 
  Serial.begin(115200);
  Wire.begin();
  delay(5);
  my3IMU.init(); // the parameter enable or disable fast mode
  delay(5);

  my3IMU.getYawPitchRoll(ypr);
  Input = ypr[0]; // Yaw is the input
  Setpoint = 0;
  
  //turn the PID on
  myPID.SetMode(AUTOMATIC);
  
}
void loop() { 
  
  my3IMU.getYawPitchRoll(ypr);
  Input = ypr[0]; // Yaw is the input
  myPID.Compute();
  if (Input<0)
  {
    analogWrite(PIN_1,Output);
    analogWrite(PIN_2,0)
  }
  else
  {
    analogWrite(PIN_2, Output);
    analogWrite(PIN_1, 0);
  }
  
  delay(10);
}


