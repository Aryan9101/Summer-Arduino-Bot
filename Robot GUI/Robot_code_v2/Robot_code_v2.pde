import cc.arduino.*;
import processing.serial.*;

Arduino arduino;
//final int claw = 5;
final int leftwheel = 7;
final int rightwheel = 8;
int angle;
float sc;
float rightdist;  
float leftdist;
float rightspeed;
float leftspeed;
boolean incircle = (Math.pow((mouseX - 1000),2) + Math.pow((mouseY - 500),2)) <= Math.pow(375,2);

void setup(){
  size(2000,1000);
  background(0.);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
//  arduino.pinMode(claw, Arduino.SERVO);
  arduino.pinMode(leftwheel, Arduino.SERVO);
  arduino.pinMode(rightwheel, Arduino.SERVO);
}

void draw(){
  drawrange();
  angle = angle();
  if (mousePressed == true && mouseButton == LEFT){
    arduino.servoWrite(7, round(speed(angle)[0]*0.7));
    arduino.servoWrite(8, speed(angle)[1]);
    println("Left wheel:" , speed(angle)[0] , " Right wheel:" , speed(angle)[1], " Angle:" , angle);
  } else {
    arduino.servoWrite(7, 101-2);
    arduino.servoWrite(8, 95-2);
    println("Left wheel: 100   Right wheel:  95  Angle:", angle);
  }
}

int angle(){
  float diffX = mouseX - 1000;
  float diffY = mouseY - 500;
  float slope = diffY/diffX;
  int angle = round(atan(slope) * 180 / PI);
  if ((mouseX < 1000) && (mouseY < 500)){
    angle = 90 - angle;
  } else if ((mouseX > 1000) && (mouseY < 500)){
    angle += 90;
  } else if ((mouseX < 1000) && (mouseY > 500)){
    angle = 90 + angle;
  } else {
    angle = 90 - angle;
  }
  return angle;
}

int[] speed(int angle){
  if (Math.pow((mouseX - 1000),2) + Math.pow((mouseY - 500),2) <= Math.pow(375,2)){
    sc = 1 - dist(mouseX, mouseY, 1000, 500)/375;
  }
  if (mouseY < 500){
    if (angle > 15 && mouseX > 1000){
      leftspeed = 174 - (sc * 75/10);    
      rightspeed = 18 + (sc * 750/10);
    } else if (angle > 15 && mouseX < 1000){
      leftspeed = 174 - (sc * 750/10);
      rightspeed = 18 + (sc * 75/10);
    } else if (angle <= 15){
      rightspeed = 18 + (sc * 75);
      leftspeed = 174 - (sc * 75);
    } else {
      rightspeed = 93;
      leftspeed = 100-1;
    }
  } else {
    if (angle > 15 && mouseX > 1000){
      leftspeed = 24 + (sc * 75/10);    
      rightspeed = 168 - (sc * 750/10);
    } else if (angle > 15 && mouseX < 1000){
      leftspeed = 24 + (sc * 750/10);
      rightspeed = 168 - (sc * 75/10);
    } else if (angle <= 15){
      rightspeed = 168 - (sc * 75);
      leftspeed = 24 + (sc * 75);
    } else {
      rightspeed = 93;
      leftspeed = 100-1;
    }
  }
  int[] speed = new int[2];
  speed[0] = round(leftspeed);
  speed[1] = round(rightspeed);
  return speed;
}

void drawrange(){
  noStroke();
  for(int i = 255; i >=0; i--){
    fill(255-i/2, 0+i ,0);
    ellipse(1000,500,i*750/255,i*750/255);
  }
  stroke(255);
  noFill();
  for(int i = 750; i >= 0; i-= 150){
    ellipse(1000,500,i,i);
  }
  line(625,500,1375,500);
  line(1000,875,1000,125);
  for(int i = 0; i <= 180; i += 30){
    line(-400 * cos(radians(i)) + 1000 , -400 * sin(radians(i)) + 500 , 400 * cos(radians(i)) + 1000 , 400 * sin(radians(i)) + 500);
  } 
}