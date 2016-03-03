
float[] a=new float[100];
float[] v=new float[100];
float[] s=new float[100]; 

void setup() {
  size(800, 800);
  
  for (int i=0; i<a.length; i++) {
    a[i]=1;
  }

  for (int t=0; t<a.length; t++) {
    a[t]=a[t]+random(-0.1, 0.1);
  }

  for (int t=0; t<v.length; t++) {
    v[t]=v[0]+a[t]*t;
  }

  for (int t=0; t<s.length; t++) {
    s[t]=v[0]*t+0.5*t*t;
  }
}



void draw() {
  background(255);

  translate(0, height);
  scale(7, -7);
  
  stroke(255,0,0);
  strokeWeight(0.4);
  
  for (int t=0; t<v.length; t++) {
    point(t, v[t]);
  }

  for (int t=0; t<s.length; t++) {
    point(t, s[t]);
  }
  
  
}