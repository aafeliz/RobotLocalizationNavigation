int N=100;

float[] vx=new float[N];
float[] vy=new float[N];

float[] x=new float[N]; 
float[] y=new float[N];

float[] x1=new float[N];
float[] y1=new float[N];

float[] x2=new float[N];
float[] y2=new float[N];

float[] p1=new float[N];
float[] py1=new float[N];

float[] p2=new float[N];
float[] py2=new float[N];

float[] k=new float[N];
float[] ky=new float[N];

float[] z=new float[N];
float[] zy=new float[N];

float q=1.0;
float r=2.0;

void setup() {
  size(1000, 1000); 
  
  for(int i=0; i<vx.length; i++){
    vx[i]=3;
  }
  
  for(int i=0; i<vy.length; i++){
    vy[i]=4;
  }
  
    
  for (int t=0; t<x.length; t++) {
    x[t]=vx[t]*t;
  }
  
  for(int t=0; t<y.length; t++){
    y[t]=vy[t]*t;
  }
  
  for(int t=0; t<x.length; t++){
    z[t]=x[t]+random(-0.3,0.3)*t;
  }
  
  for(int t=0; t<y.length; t++){
    zy[t]=y[t]+random(-0.4,0.4)*t;
  }
  
  
  for(int i=1; i<N; i++){
      x1[i]=1*x2[i-1];
      p1[i]=1*p2[i-1]*1+q;
      k[i]=p1[i]*1/(r+1*p1[i]*1);
      x2[i]=1*x1[i]+k[i]*(z[i]-1*x1[i]);
      p2[i]=(1-k[i]*1)*p1[i];
  }
  
   for(int i=1; i<N; i++){
    y1[i]=1*y2[i-1];
    py1[i]=1*py2[i-1]*1+q;
    ky[i]=py1[i]*1/(r+1*py1[i]*1);
    y2[i]=1*y1[i]+ky[i]*(zy[i]-1*y1[i]);
    py2[i]=(1-ky[i]*1)*py1[i];
  }
}



void draw(){
  background(255);
  
  translate(0,height);
  
  scale(2.5,-2.5);
   
  stroke(0,0,255);//blue line represents the output of KF;
  strokeWeight(0.3);
   for(int i=0; i<y.length-1; i++){
   line(x2[i],y2[i],x2[i+1],y2[i+1]);
  }
     
  stroke(255,0,0);// red line represents the real value of the position of robot;
  strokeWeight(0.3);
   for(int i=0; i<y.length-1; i++){
   line(x[i],y[i],x[i+1],y[i+1]);
  } 
  
  stroke(0,255,0);//green line represents the not so accurate observation value of the robot's position.
  strokeWeight(0.3);
  for(int i=0; i<y.length-1; i++){
    line(z[i],zy[i],z[i+1],zy[i+1]);
  }
}