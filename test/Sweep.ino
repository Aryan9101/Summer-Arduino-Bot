#include <Servo.h>

Servo myservo;
int loopstop = 0;
//int pos = 0;
int lastpos = 0;
int newpos = 1;

void setup() {
  Serial.begin(9600);
  myservo.attach(7);
}

void loop() {
  while (loopstop == 0){
  /*
    for (int pos = 0; pos <= 90; pos += 1) {
      newpos = pos;
      if (newpos != lastpos){
        myservo.write(pos);              
        delay(15);   
        lastpos = pos;                    
      } else {
      myservo.write(lastpos);
      }
      Serial.println(myservo.read());
    }
  */
    for (int pos = 90; pos >= 0; pos -= 1) {
      newpos = pos;
      Serial.println("newpos");
      Serial.print(newpos);
      Serial.println("lastpos");
      Serial.print(lastpos);
      if (newpos != lastpos){
        myservo.write(pos);              
        lastpos = myservo.read();                       
        Serial.println(myservo.read());      
      } 
      else if (newpos == lastpos) {
        Serial.println("lol");
        break;
      }
      Serial.println(myservo.read());
      delay(15);
    }
    loopstop += 1;
  }
}

