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
}

void draw(){
  drawrange();
  angle = angle();
  if (mousePressed == true && mouseButton == LEFT){
    println("Left wheel:" , speed(angle)[0] , " Right wheel:" , speed(angle)[1], " Angle:" , angle());
  } else {
    println("Left wheel: 101   Right wheel: 95  Angle:", angle);
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
      leftspeed = 176 - (sc * 750/10);    
      rightspeed = 95;
    } else if (angle > 15 && mouseX < 1000){
      leftspeed = 101;
      rightspeed = 20 + (sc * 750/10);
    } else if (angle <= 15){
      rightspeed = 20 + (sc * 75);
      leftspeed = 176 - (sc * 75);
    } else {
      rightspeed = 95;
      leftspeed = 101;
    }
  } else {
    if (angle > 15 && mouseX > 1000){
      leftspeed = 26 + (sc * 750/10);    
      rightspeed = 95;
    } else if (angle > 15 && mouseX < 1000){
      leftspeed = 101;
      rightspeed = 170 - (sc * 750/10);
    } else if (angle <= 15){
      rightspeed = 170 - (sc * 75);
      leftspeed = 26 + (sc * 75);
    } else {
      rightspeed = 95;
      leftspeed = 101;
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