
class Bot
{
  float x, y;
  float heading;
  float scalar;
  float botWidth;
  float botHeight;
  int near1Idx;
  int near2Idx;
  int near3Idx;
  float easing;
  float targetX, targetY;
  float dx, dy;
  Particle[] p;
  int numP;
  int pNumDelta;//number of particles per step
  int pIndx;
  
  Bot(float xpos, float ypos, float headinginit, float scale, float _botWidth, float _botHeight, int _numP, int _pNumDelta)
  {
    x = xpos;
    y = ypos;
    heading = headinginit;
    scalar = scale/100.0;
    botWidth = _botWidth;
    botHeight = _botHeight;
    near1Idx = -1;
    near2Idx = -1;
    near3Idx = -1;
    easing = 0.05;
    numP = _numP;
    p = new Particle[numP];
    for(int i =0; i < p.length; i++)
    { 
      p[i] = new Particle();
    }
    pNumDelta = _pNumDelta;
    pIndx = 0;
  }
  void move()
  {
    targetX = mouseX;
    targetY = mouseY;
    dx = targetX - x;
    dy = targetY - y;
    x += dx*easing;
    y += dy*easing;
  }
  void display()
  {
    
    fill(0,0,255);
    strokeWeight(3);
    stroke(155, 153);
    //rotate(heading);
    rect(x, y, botWidth, botHeight); 
    
    
  }
  void kNearestBeacon(Beacon be[])
  { //<>// //<>//
    near1Idx = -1; //<>// //<>// //<>//
    near2Idx = -1;
    near3Idx = -1;
    for (int i = 0; i < be.length; i++)
    {
      be[i].updateDistance(x, y);
      be[i].display(); //<>// //<>//
      // check which are the two nearest neighbor //<>// //<>// //<>//
      //check if beacon can get distances
      if (be[i].detected)
      {
        if((near1Idx > -1) && (near2Idx > -1) && (near3Idx > -1))/// the first one is always going to be the smallest distance
        {
          if (be[i].noiseDis < be[near1Idx].noiseDis)
          {
            near3Idx = near2Idx;
            near2Idx = near1Idx;
            near1Idx = i;
          }
          else if (be[i].noiseDis < be[near2Idx].noiseDis)
          {
            near3Idx = near2Idx;
            near2Idx = i;
          }
          else if (be[i].noiseDis < be[near3Idx].noiseDis)
          {
            near3Idx = i;
          }
        }
        else if((near1Idx > -1) && (near2Idx > -1) && (near3Idx == -1)) // might not need to test the first idx
        {
          if(be[i].noiseDis < be[near1Idx].noiseDis)
          {
            near3Idx = near2Idx;
            near2Idx = near1Idx;
            near1Idx = i;
          }
          else if(be[i].noiseDis < be[near2Idx].noiseDis)
          {
            near3Idx = near2Idx;
            near2Idx = i;
          }
          else
          {
            near3Idx = i;
          }
        }
        else if((near1Idx > -1) && (near2Idx == -1) && (near3Idx == -1))
        {
          if(be[i].noiseDis < be[near1Idx].noiseDis)
          {
            near2Idx = near1Idx;
            near1Idx = i;
          }
          else
          {
            near2Idx = i;
          }
        }
        else if(near1Idx == -1)
        {
          near1Idx = i; //<>//
        } //<>//
    } //<>//
  } //<>//
  if ((near1Idx > -1) && (near2Idx > -1) && (near3Idx > -1)) //<>//
  { //<>//
    be[near1Idx].near = true; //<>//
    be[near2Idx].near = true; //<>//
    be[near3Idx].near = true;
    be[near1Idx].display();
    be[near2Idx].display();
    be[near3Idx].display();
  }
  else if((near1Idx > -1) && (near2Idx > -1))
  {
    be[near1Idx].near = true;
    be[near2Idx].near = true;
    be[near1Idx].display();
    be[near2Idx].display();
  }
  
}
  void getParticles(Beacon beacon[])
  { //<>//
    if ((near1Idx > -1)&&(near2Idx > -1))  //<>// //<>//
    {
      int i = pIndx;
      while((i < (pIndx +pNumDelta)) && (i < p.length))
      {
        triangulate(beacon[near1Idx], beacon[near2Idx], i);
        i++;
      }
      pIndx = i;
      if (pIndx == p.length) //<>//
      {
        pIndx = 0; //<>//
        getPFpos(); //<>// //<>//
        //might set show for all particles to false //<>//
      } //<>//
      for(int j = 0; j < pIndx; j++)
      { //<>//
        p[j].display(); //<>// //<>//
        
      }
    }
    
  }
  void triangulate(Beacon beA, Beacon beB, int pIndx)
  {
    beA.updateNoiseDistance();
    beB.updateNoiseDistance();
    p[pIndx].x = width/2;
    p[pIndx].y = height/2;
    float disX = beA.myX - beB.myX;
    float disY = beA.myY - beB.myY;
    float c = dist(beA.myX, beA.myY, beB.myX, beB.myY);//sqrt(sq(disX) + sq(disY));//disB1B2
    float a = beA.noiseDis;
    float b = beB.noiseDis;
    p[pIndx].angMy = acos((sq(a) + sq(b) - sq(c))/(2*a*b));
    p[pIndx].angA = acos((sq(b) + sq(c) - sq(a))/(2*b*c));
    p[pIndx].angB = PI -   p[pIndx].angA - p[pIndx].angMy;
    //test for x
    if (beA.myX < beB.myX)
    {
      //test for Y //<>//
      if(beA.myY > beB.myY)
      {
        float la = beB.myX - beA.myX;
        float lb = beA.myY - beB.myY;
        float theta = acos((sq(c) + sq(la) - sq(lb))/(2*c*la));
        float lambda = theta + p[pIndx].angA;
        p[pIndx].x = (a*cos(lambda)) + beA.myX;
        p[pIndx].y = beA.myY - (a*sin(lambda));
        
      }
      else if(beA.myY < beB.myY)
      { //<>//
        
      }
      else if(beA.myY == beB.myY)
      {
         //<>//
      }
    }
    else if (beA.myX > beB.myX)
    {
      if(beA.myY > beB.myY)
      {
        
      }
      else if(beA.myY < beB.myY)
      {
        
      }
      else if(beA.myY == beB.myY)
      {
        
      }
    }
    else if(beA.myX == beB.myX)
    {
      if(beA.myY > beB.myY)
      {
        
      }
      else if(beA.myY < beB.myY)
      {
        
      }
    }
    
    
    
    
    //float px, py; //<>//
    //px = random(0,100); //<>// //<>// //<>//
    //py = random(0,100); //<>// //<>// //<>//
    //p[pIndx].x = px; //<>// //<>// //<>//
    //p[pIndx].y = py; //<>// //<>// //<>//
    p[pIndx].show = true; //<>// //<>//
  }
  void getPFpos()
  {
    println("needs to be implemented");
  }
}

 
/**
 * Finds the intersections of two circles, if they exist.
 *
 * Given two circle equations:
 *   Cirlce 1: r1^2 = (x - x1)^2 + (y - y1)^2
 *   Circle 2: r2^2 = (x - x2)^2 + (y - y2)^2
 *
 * Returns coordinates (2 sets of 2 doubles) or else returns null if intersections do not exist.
 *
 * Rarely this function may return null if the circles are tangental or very close to tangental.
 */
public double[] circleCircleIntersects(double x1, double y1, double x2, double y2, double r1, double r2)
{
  // Use change of coordinates to get:
  //   Cirlce 1: r1^2 = x^2 + y^2
  //   Circle 2: r2^2 = (x - a)^2 + (y - b)^2
  double a = x2 - x1;
  double b = y2 - y1;
   
  // Find distance between circles.
  double ds = a*a + b*b;
  double d = Math.sqrt( ds );
   
  // Ensure that the combined radii lengths are longer than the distance between the circles,
  // i.e. tha the circles are close enough to intersect.
  if (r1 + r2 <= d)
    return null;
    //<>//
  // Ensure that one circle is not inside the other. //<>//
  if (d <= Math.abs( r1 - r2 )) //<>//
    return null; //<>//
    //<>//
  // Find the intersections (formula derivations not shown here).
  double t = Math.sqrt( (d + r1 + r2) * (d + r1 - r2) * (d - r1 + r2) * (-d + r1 + r2) );
 
  double sx1 = 0.5 * (a + (a*(r1*r1 - r2*r2) + b*t)/ds);
  double sx2 = 0.5 * (a + (a*(r1*r1 - r2*r2) - b*t)/ds);
   
  double sy1 = 0.5 * (b + (b*(r1*r1 - r2*r2) - a*t)/ds);
  double sy2 = 0.5 * (b + (b*(r1*r1 - r2*r2) + a*t)/ds);
   
  // Translate to get the intersections in the original reference frame.
  sx1 += x1;
  sy1 += y1;
   
  sx2 += x1;
  sy2 += y1;
   
  double[] r = new double[4];
  r[0] = sx1;
  r[1] = sy1;
  r[2] = sx2;
  r[3] = sy2;
   
  return r;
}
boolean circleCircleIntersect(float cx1, float cy1, float cr1, float cx2, float cy2, float cr2) {
  if (dist(cx1, cy1, cx2, cy2) < cr1 + cr2) {
    return true;
  } else {
    return false;
  }
}


    