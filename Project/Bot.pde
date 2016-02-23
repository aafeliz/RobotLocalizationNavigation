
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
  float[][] intersectAB;
  float[][] intersectBC;
  float[][] intersectAC;
  float wigRoom;
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
    intersectAB = new float[2][2];
    intersectBC = new float[2][2];
    intersectAC = new float[2][2];
    wigRoom = 30;
    for(int i = 0; i < intersectAB.length; i++)
    {
      for(int j = 0; j < intersectAB[0].length; j++)
      {
        intersectAB[i][j] = 0;
      }
    }
    for(int i = 0; i < intersectBC.length; i++)
    {
      for(int j = 0; j < intersectBC[0].length; j++)
      {
        intersectBC[i][j] = 0;
      }
    }
    for(int i = 0; i < intersectAC.length; i++)
    {
      for(int j = 0; j < intersectAC[0].length; j++)
      {
        intersectAC[i][j] = 0;
      }
    }
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
    
    fill(0,255,222);
    strokeWeight(3);
    stroke(155, 153);
    //rotate(heading);
    rect(x, y, botWidth, botHeight); 
    
    
  }
  void kNearestBeacon(Beacon be[])
  { //<>// //<>//
    near1Idx = -1; //<>// //<>// //<>// //<>//
    near2Idx = -1;
    near3Idx = -1;
    for (int i = 0; i < be.length; i++)
    {
      be[i].updateDistance(x, y);
      be[i].display(); //<>// //<>//
      // check which are the two nearest neighbor //<>// //<>// //<>// //<>//
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
          near1Idx = i;
        }
    }
  }
  if ((near1Idx > -1) && (near2Idx > -1) && (near3Idx > -1))
  {
    be[near1Idx].near = true;
    be[near2Idx].near = true;
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
  /*
   * getParticles uses the beacons that are closest
   * triagulates and displays the particles on the window
   */
  void getParticles(Beacon beacon[])
  { //<>// //<>//
    //while?
    if((near1Idx > -1) && (near2Idx > -1))  //<>// //<>// //<>//
    {
      int i = pIndx;
      while((i < (pIndx + pNumDelta)) && (i < p.length))
      {
        if (near3Idx > -1)
        {
          triangulate(beacon[near1Idx], beacon[near2Idx], beacon[near3Idx], i);
        }
        else
        {
          triangulate(beacon[near1Idx], beacon[near2Idx], i);
        }
        i++;
      }
      pIndx = i;
      if (pIndx == p.length)
      {
        pIndx = 0; //<>// //<>//
        getPFpos();  //<>// //<>//
        //might set show for all particles to false
      }
      //display used to be here //<>// //<>// //<>//
    }
    
  }
  /*
   * Triangulate method used when utilizing 
   * 3 beacons. 
   */
  void triangulate(Beacon beA, Beacon beB, Beacon beC, int pIdx)
  {
    beA.updateNoiseDistance();
    beB.updateNoiseDistance();
    beC.updateNoiseDistance();
    if(isIntersect(beA.myX, beA.myY, beB.myX, beB.myY, (beA.noiseDis+wigRoom), (beB.noiseDis+wigRoom)))
    {
      CircleIntersects(beA.myX, beA.myY, beB.myX, beB.myY, (beA.noiseDis+wigRoom), (beB.noiseDis+wigRoom), 1);
      if(isIntersect(beB.myX, beB.myY, beC.myX, beC.myY, (beB.noiseDis+wigRoom), (beC.noiseDis+wigRoom)))
      {
        CircleIntersects(beB.myX, beB.myY, beC.myX, beC.myY, (beB.noiseDis+wigRoom), (beC.noiseDis+wigRoom), 2);
        if(isIntersect(beA.myX, beA.myY, beC.myX, beC.myY, (beC.noiseDis+wigRoom), (beC.noiseDis+wigRoom)))
        {
           CircleIntersects(beA.myX, beA.myY, beC.myX, beC.myY, (beC.noiseDis+wigRoom), (beC.noiseDis+wigRoom), 3);
           float avgX = ((intersectAB[0][0] + intersectAB[1][0])+ (intersectBC[0][0] + intersectBC[1][0]) + (intersectAC[0][0] + intersectAC[1][0]))/6;
           float avgY = ((intersectAB[0][1] + intersectAB[1][1])+ (intersectBC[0][1] + intersectBC[1][1]) + (intersectAC[0][1] + intersectAC[1][1]))/6;
           p[pIdx].x = avgX;
           p[pIdx].y = avgY;
           p[pIdx].show = true;
        }
      }
    }
   
    
    
  }
  /*
   * Triangulates when two beacons are used
   * it also sets the partcle to show on the window
   */
  void triangulate(Beacon beA, Beacon beB, int pIdx)
  {
    beA.updateNoiseDistance();
    beB.updateNoiseDistance();
    if(isIntersect(beA.myX, beA.myY, beB.myX, beB.myY, (beA.noiseDis+wigRoom), (beB.noiseDis+wigRoom)))
    {
      CircleIntersects(beA.myX, beA.myY, beB.myX, beB.myY, (beA.noiseDis+wigRoom), (beB.noiseDis+wigRoom),1);
      float avgX = ((intersectAB[0][0] + intersectAB[1][0])/2);
      float avgY = ((intersectAB[0][1] + intersectAB[1][1])/2);
      p[pIdx].x = avgX;
      p[pIdx].y = avgY;
      p[pIdx].show = true; 
    }
  }
  /**
 * Finds the intersections of two beacons, if they exist.
 *
 * Given two circle equations:
 *   Cirlce 1: r1^2 = (x - x1)^2 + (y - y1)^2
 *   Circle 2: r2^2 = (x - x2)^2 + (y - y2)^2
 *
 * Returns coordinates (2 sets of 2 floats) or else returns null if intersections do not exist.
 *
 * Rarely this function may return null if the circles are tangental or very close to tangental.
 */
  void CircleIntersects(float x1, float y1, float x2, float y2, float r1, float r2, int num)
  {
    // Use change of coordinates to get:
    //   Cirlce 1: r1^2 = x^2 + y^2
    //   Circle 2: r2^2 = (x - a)^2 + (y - b)^2
    float a = x2 - x1;
    float b = y2 - y1;
     
    // Find distance between circles.
    float ds = a*a + b*b;
    float d = sqrt( ds );
     
    // Find the intersections (formula derivations not shown here).
    float t = sqrt( (d + r1 + r2) * (d + r1 - r2) * (d - r1 + r2) * (-d + r1 + r2) );
   
    float sx1 = 0.5 * (a + (a*(r1*r1 - r2*r2) + b*t)/ds);
    float sx2 = 0.5 * (a + (a*(r1*r1 - r2*r2) - b*t)/ds);
     
    float sy1 = 0.5 * (b + (b*(r1*r1 - r2*r2) - a*t)/ds);
    float sy2 = 0.5 * (b + (b*(r1*r1 - r2*r2) + a*t)/ds);
     
    // Translate to get the intersections in the original reference frame.
    sx1 += x1;
    sy1 += y1;
     
    sx2 += x1;
    sy2 += y1;
     
    //float[][] r = new float[2][2];
    /*r[0][0] = sx1;
    r[0][1] = sy1;
    r[1][0] = sx2;
    r[1][1] = sy2;*/
    if(num == 1)
    {
      intersectAB[0][0] = sx1;
      intersectAB[0][1] = sy1;
      intersectAB[1][0] = sx2;
      intersectAB[1][1] = sy2;
    }
    else if(num == 2)
    {
      intersectBC[0][0] = sx1;
      intersectBC[0][1] = sy1;
      intersectBC[1][0] = sx2;
      intersectBC[1][1] = sy2;
    }
    else if(num == 3)
    {
      intersectAC[0][0] = sx1;
      intersectAC[0][1] = sy1;
      intersectAC[1][0] = sx2;
      intersectAC[1][1] = sy2;
    }
  }
  /**
   * checks if the the two beacons intercept
   * Utilized before finding the intercepts
   * returns true if the beacons intercept
   */
  boolean isIntersect(float cx1, float cy1,  float cx2, float cy2, float cr1, float cr2) 
  {
    if (dist(cx1, cy1, cx2, cy2) < cr1 + cr2) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }

  void getPFpos()
  {
    println("needs to be implemented");
  }
  
  void getKFpos()
  {
    println("needs to be implemented");
  }
}

 




    