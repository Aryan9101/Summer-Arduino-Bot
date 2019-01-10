#include <Servo.h>
Servo panservo;
Servo tiltservo;
Servo leftwheel;
Servo rightwheel;
Servo clawservo;
int pos = 0;
int a = 1;
void setup() {
  Serial.begin(9600);
  panservo.attach(8);
  tiltservo.attach(7);
  rightwheel.attach(13);
  leftwheel.attach(11);
  clawservo.attach(5);
}

void loop() {
  while (a == 1){
    rightwheel.write(60);
    leftwheel.write(60);
    delay(2000);
    rightwheel.write(90);
    leftwheel.write(90);
    for(int i = 30; i <= 150; i++){
      panservo.write(i);
      delay(50);
    }
    for(int i = 150; i >= 90; i--){
      panservo.write(i);
      delay(50);
    }
    for(int i = 45; i <= 90; i++){
      tiltservo.write(i);
      delay(50);
    }
    for(int i = 90; i >= 45; i--){
      tiltservo.write(i);
      delay(50);
    }
    for (pos = 0; pos <= 90; pos += 1) { 
      clawservo.write(pos);              
      delay(50);                       
    }
    for (pos = 90; pos >= 0; pos -= 1) { 
      clawservo.write(pos);              
      delay(50);                       
    }
  }
}
