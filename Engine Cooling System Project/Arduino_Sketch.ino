/* 
 Arduino Final Design Project: Engine Cooling System

 This sketch is written to accompany the Arduino Design Project submission for course EEL3003.

 created 14 Dec 2020
 by Jasmin Rabosto
 */

// Initalize Pins for Components
const int tempSensor = A0;
const int potentio = A1;
const int greenLed = 2;    
const int redLed = 3;    
const int blueLed = 4; 
const int button = 5;
const int piezo = 8;
const int motor = 9;

// Define All Constants
const float baselineTemp = 105.0;
const int piezoFreq = 330;

//Define Initial Conditions
int manualStart = 0;
int motorSpeed = 0;
int switchState = 0;
int prevswitchState = 0;

void setup() {
  
// Open Serial Monitor Connection
  Serial.begin(9600);
  
// Define Input Pins
  pinMode(button, INPUT);
  
// Define Output Pins
  pinMode(greenLed, OUTPUT);
  pinMode(redLed, OUTPUT);
  pinMode(blueLed, OUTPUT);
  pinMode(piezo, OUTPUT);
  pinMode(motor, OUTPUT);
  }

void loop() {
  
//Calculate & Display Temperature Value
  int sensorVal = analogRead(tempSensor);
  float voltage = (sensorVal/1024.0) * 5.0;
  Serial.print("degrees C: ");
  float temperature = ((voltage - .5) * 100) + 68;
  Serial.println(temperature);

//Determine Manual System Override
switchState = digitalRead(button);
if (switchState != prevswitchState) {
  if (switchState == HIGH) {
  manualStart = !manualStart;
}
}

// Automated Cooling System Loop 
// If the temperature is lower than the baseline, LEDs, piezo, and dc motor are off
if (manualStart != 1) {
   digitalWrite(4, LOW);
  if (temperature < baselineTemp + 2) {
    motorSpeed = 0;
    digitalWrite(2, LOW);
    digitalWrite(3, LOW);
    noTone(piezo); 
    analogWrite(motor, motorSpeed); 
  } // If the temperature rises 2-5 degrees,green LED and dc motor are on 
  else if (temperature >= baselineTemp + 2 && temperature < baselineTemp + 5) {
    motorSpeed = (1024/4)/4;            // normal motor speed
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW);
    noTone(piezo); 
    analogWrite(motor, motorSpeed);   
  } // If the temperature rises 5 degrees, red LED, dc motor, and piezo are on
  else if (temperature >= baselineTemp + 5) {
    motorSpeed = (1024/2)/4;               // maximum motor speed
    digitalWrite(2, LOW);
    digitalWrite(3, HIGH);
    analogWrite(motor, motorSpeed);
    tone(piezo, piezoFreq);
    Serial.print("WARNING: ENGINE OVERHEATING");
 
 } 
}
// Manual Override Cooling System Loop 
if (manualStart == 1) {
  motorSpeed = analogRead(potentio)*8;
  digitalWrite(4, HIGH);
  analogWrite(motor, motorSpeed);
  if (temperature < baselineTemp + 2) {
    digitalWrite(2, LOW);
    digitalWrite(3, LOW);
    noTone(piezo); 
  } // If the temperature rises 2-5 degrees,green LED and dc motor are on 
  else if (temperature >= baselineTemp + 2 && temperature < baselineTemp + 5) {
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW); 
    noTone(piezo);  
  } // If the temperature rises 5 degrees, red LED, dc motor, and piezo are on
  else if (temperature >= baselineTemp + 5) {
    digitalWrite(2, LOW);
    digitalWrite(3, HIGH);
    tone(piezo, piezoFreq);
    Serial.print("WARNING: ENGINE OVERHEATING.");
  }
}
prevswitchState = switchState;
delay(100);
}
