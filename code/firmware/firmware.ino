#include <Servo.h>
Servo myservo;

const int homePin = 13;  //Digital input 1
const int digitalAuxPin = 12;
const int analogAux1Pin = A6;
const int analogAux2Pin = A7;

const int step1_stpPin = 3; 
const int step1_dirPin = 2;  
const int step1_enblPin = 4;

const int step2_stpPin = 6; 
const int step2_dirPin = 5;  
const int step2_enblPin = 7;

const int mosfet1Pin = 10; 
const int mosfet2Pin = 11;

const int servo1Pin = 9;


int stepspd = 300; 
bool stepenabled=0;
int stephomespd = 800; 
int stepstrtspd = 3500;
long stepbrksteps = 100;
int stepramp = 1;
bool steprmpdwn = 0;
bool steprmpup = 0;
int steptargetspd = 1500;
byte stepdir = 0;
byte stepmove = 0;
long steppos=0;
long  steptarget;
long prevsteptarget;
long steptargetA;
long steptargetB;
bool stepright=1;

unsigned long previousMillis = 0; 
int interval = 1000; 
byte homeState = 1;

byte serbyte = 0;
byte incoming = 0;

int servo1posA = 90;
int servo1posB = 75;
int servo1actpos;

void homeing(){
  homeState = digitalRead(homePin);
  while (homeState==1){
  digitalWrite(step1_enblPin, LOW);
  stepenabled=1;
  digitalWrite(step1_dirPin, HIGH);
  digitalWrite(step1_stpPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(step1_stpPin,LOW);
  delayMicroseconds(stephomespd-10);
  homeState = digitalRead(homePin);
  }
  //digitalWrite(enblPin, HIGH);
  stepenabled=1;
  steppos=0;
  stepdir=1;
  stepDir(0);
}

void doSteps(int steps){
  steps=steps*10;
  if(stepdir==0)steptarget=steppos+steps;
  if(stepdir==1)steptarget=steppos-steps;
  if (steptarget!=steppos) {
  stepright=0;
  stepEnbl(1);
  delayMicroseconds(50);}
  
}

void hit(){
  if (servo1actpos==servo1posA){
  myservo.write(servo1posB);
  servo1actpos=servo1posB; 
  }    
 if (servo1actpos==servo1posB){
  myservo.write(servo1posA);
  servo1actpos=servo1posA; 
  }      
}
    
void stepEnbl(int state){
 int statePin=state*-1+1;
 digitalWrite(step1_enblPin, statePin);
   stepenabled=state;
 delayMicroseconds(50);
 
}
void stepDir(byte dir){
  if(stepdir!=dir){
  digitalWrite(step1_dirPin, dir);
  stepdir=dir;
  delayMicroseconds(2);
  
  }
 
}
void stepSpd(byte spd){
  steptargetspd=spd*4;
  //stepspd=spd*10;
  //interval=spd*10;
}

void stepSndpos(){
  long pos1=steppos/1000;
  long pos2=(steppos-pos1*1000)/10;
  long pos3=steppos-pos1*1000-pos2*10;
  Serial.write(255);
  Serial.write(pos1);
  Serial.write(pos2);
  Serial.write(pos3);
}

void stepMove(){
   
  unsigned long currentMillis = micros();
  if(currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;   
  digitalWrite(step1_stpPin, HIGH);
  delayMicroseconds(4);
  digitalWrite(step1_stpPin,LOW);
  //delayMicroseconds(1);
  if(stepdir==0)steppos=steppos+1;
  if(stepdir==1)steppos=steppos-1;
  if(sqrt(pow(steppos - steptarget,2))<stepbrksteps && steprmpup==0)stepRmpdwn(10);
  }
}

void stepGo2pos(){
  steprmpup=1;
  steptarget=steptargetA*1000+steptargetB*10;
  if (steptarget!=steppos) {
  stepright=0;
  if(prevsteptarget>steppos && steptarget<steppos)steprmpdwn=1;

  if(prevsteptarget<steppos && steptarget>steppos)steprmpdwn=1;
  prevsteptarget=steptarget;}
  
}

void stepRmpdwn(int amount){
  if(stepstrtspd>interval)interval=interval+amount;
  if(stepstrtspd<interval)interval=interval-amount;
  if(stepstrtspd==interval)steprmpdwn=0;
  
  }


void stepRmpup(){
  if(steprmpup==1){
  if(steptargetspd>interval)interval=interval+stepramp;
  if(steptargetspd<interval)interval=interval-stepramp;}
  if(steptargetspd==interval)steprmpup=0;
  
  
  
}


void setup() 
{                
  Serial.begin(115200);
  pinMode(homePin, INPUT);
  pinMode(step1_stpPin, OUTPUT);
  pinMode(step1_dirPin, OUTPUT);
  pinMode(step1_enblPin, OUTPUT);
  pinMode(mosfet1Pin, OUTPUT);
  pinMode(mosfet2Pin, OUTPUT);
  
  
  digitalWrite(homePin, HIGH);
  homeState = digitalRead(homePin);
  
  
  
  digitalWrite(step1_stpPin, LOW);
  digitalWrite(step1_dirPin, LOW);
  digitalWrite(step1_enblPin, HIGH);
  
  digitalWrite(mosfet1Pin, LOW);
  digitalWrite(mosfet2Pin, LOW);
  
  myservo.attach(servo1Pin);
  myservo.write(servo1posA);
  servo1actpos=servo1posA; 
  homeing();
  stepEnbl(0);
  
  
  
}


void loop() 
{
if (Serial.available()) {
       
        serbyte = Serial.read();
        //Serial.write(serbyte);
        if (serbyte > 200) incoming = serbyte - 200;
        if (serbyte <= 200){
            if (incoming == 1) homeing();
            if (incoming == 2) stepEnbl(serbyte);
            if (incoming == 3) stepDir(serbyte);
            if (incoming == 4) stepSpd(serbyte);
            if (incoming == 5) doSteps(serbyte);
            if (incoming == 6) stepmove=serbyte;
            if (incoming == 7) stepSndpos();
            if (incoming == 8) steptargetA=serbyte;
            if (incoming == 9) {
              steptargetB=serbyte; 
              stepGo2pos();}
            if (incoming == 10) myservo.write(serbyte);
            
            
        }  



}

   
  
 if(stepright==0 && stepenabled==1){
   if (steppos<steptarget) {
     if(steprmpdwn==1)stepRmpdwn(stepramp);
     if(steprmpdwn==0){
     stepDir(0); 
     stepRmpup();
   }
     stepmove=1;}
   if (steppos>steptarget) {
     if(steprmpdwn==1)stepRmpdwn(stepramp);
     if(steprmpdwn==0){
     stepDir(1); 
     stepRmpup();
   }
     stepmove=1;}
   }
   if (steppos==steptarget){
     stepmove=0; 
     stepright=1;} 
      
   
 if(digitalRead(homePin)==0)steppos=0;
 if (stepmove>0){
   //stepEnbl(1);
     if(stepenabled=1);stepMove();
 }  
   if (stepmove==0){
     interval=stepstrtspd;
     //stepEnbl(0);
   }
 
}




