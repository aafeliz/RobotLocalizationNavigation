
float x1 = 0.0f;
float y1 = 0.0f;

float x2 = 0.0f;
float y2 = 0.0f;

float prevx2 = 0.0f;
float prevy2 = 0.0f;

float px1 = 0.0f;
float py1 = 0.0f;

float px2 = 0.0f;
float py2 = 0.0f;

float kx = 0.0f;
float ky = 0.0f;

float zx = 0.0f;
float zy = 0.0f;

float x = 0.0f;
float y = 0.0f;
float targetX = 0.0f;
float targetY = 0.0f;


void setup() {
  size(1000,1000);
}

void draw() {
  background(255);
  targetX = mouseX;
  targetY = mouseY;
  zx = x+random(-0.3,0.3);
  zy = y+random(-0.4,0.4);
  //x
  px1 = 1*px2*1+1.0;
  kx = px1*1/(2.0+1*px1*1);
  x1=1*x2;
  x2=1*x1+kx*(zx-1*x1);
  px2=(1-kx*1)*px1;
  //y
  y1=1*y2;
  py1=1*py2*3.0+1.0;
  ky=py1*1/(2.0+1*py1*1);
  y2=1*y1+ky*(zy-1*y1);
  py2=(1-ky*1)*py1;
  strokeWeight(1);
  stroke(255,0,0);
  //red line is real route of the mouse 
  line(x,y,targetX,targetY);
  x = targetX;
  y = targetY;
  delay(100);
  stroke(0,255,0);
  //green line is km result
  line(prevx2,prevy2,x2,y2);
  prevx2 = x2;
  prevy2 = y2;  
}