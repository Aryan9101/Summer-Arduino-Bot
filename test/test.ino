char val;
int ledpin = 13;
void setup() {
  Serial.begin(9600);
  pinMode(ledpin, OUTPUT);
}

void loop() {
    Serial.flush();
    if(Serial.available()>0){
      val = Serial.read(); 
    }
    if(val == '1'){
      digitalWrite(ledpin, HIGH);
    } else {
      digitalWrite(ledpin, LOW);
    }
    delay(10);
}
