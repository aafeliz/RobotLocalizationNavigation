
class Bot
{
  float x, y;
  float heading;
  float scalar;
  float botWidth;
  float botHeight;
  int nearest1Indx;
  int nearest2Indx;
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
    nearest1Indx = -1;
    nearest2Indx = -1;
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
  void kNearestBeacon(Beacon beacon[])
  {
    nearest1Indx = -1; //<>// //<>//
    nearest2Indx = -1;
    for (int i = 0; i < beacon.length; i++)
    {
      beacon[i].updateDistance(x, y);
      beacon[i].display();
      // check which are the two nearest neighbor //<>// //<>//
      //check if beacon can get distances
      if (beacon[i].detected)
      {
        if((nearest1Indx > -1) && (nearest2Indx > -1))
        { //<>// //<>//
          if(beacon[nearest1Indx].botNoiseDistance < beacon[nearest2Indx].botNoiseDistance) //<>// //<>//
          { //<>// //<>//
            if(beacon[i].botNoiseDistance < beacon[nearest2Indx].botNoiseDistance) //<>// //<>//
            { //<>// //<>//
              if(beacon[i].botNoiseDistance < beacon[nearest1Indx].botNoiseDistance) //<>// //<>//
              { //<>// //<>//
                nearest2Indx = nearest1Indx;  //<>// //<>//
                nearest1Indx = i;
              }
              else
              {
                nearest2Indx = i;
              }
            }
            
          }
          else if(beacon[nearest2Indx].botNoiseDistance < beacon[nearest1Indx].botNoiseDistance)
          {
            if(beacon[i].botNoiseDistance < beacon[nearest1Indx].botNoiseDistance)
            {
              if(beacon[i].botNoiseDistance < beacon[nearest2Indx].botNoiseDistance)
              {
                nearest1Indx = nearest2Indx; 
                nearest2Indx = i;
              }
              else
              {
                nearest1Indx = i;
              }
            }
          }
        }
        else if(nearest1Indx == -1) //<>// //<>//
        {
          nearest1Indx = i;
        }
        else if(nearest2Indx == -1) //<>// //<>//
        { //<>// //<>//
          nearest2Indx = i;
        }
        
      }
    }
    if((nearest1Indx != -1) && (nearest2Indx != -1))
    {
      beacon[nearest1Indx].near = true;
      beacon[nearest2Indx].near = true;
      beacon[nearest1Indx].display();
      beacon[nearest2Indx].display();
    }
  }
  void getParticles(Beacon beacon[])
  {
    if ((nearest1Indx > -1)&&(nearest2Indx > -1))  //<>//
    {
      int i = pIndx;
      while((i < (pIndx +pNumDelta)) && (i < p.length))
      {
        triangulate(beacon[nearest1Indx], beacon[nearest2Indx], i);
        i++;
      }
      pIndx = i;
      if (pIndx == p.length)
      {
        pIndx = 0;
        getPFpos(); //<>//
        //might set show for all particles to false
      }
      for(int j = 0; j < pIndx; j++)
      {
        p[j].display(); //<>//
        
      }
    }
    
  }
  void triangulate(Beacon beA, Beacon beB, int pIndx)
  {
    beA.updateNoiseDistance();
    beB.updateNoiseDistance();
    float disX = be1.myX - be2.myX;
    float disY = be2.myY - be2.myY;
    float c = sqrt(sq(disX) + sq(disY));//disB1B2
    float a = be1.botNoiseDistance;
    float b = be2.botNoiseDistance;
    p[pIndx].angMy = acos((sq(a) + sq(b) - sq(c))/(2*a*b));
    p[pIndx].angA = acos((sq(b) + sq(c) - sq(a))/(2*b*c));
    p[pIndx].angB = PI -   p[pIndx].angA - p[pIndx].angMy;
    
    if (beA.myX < beB.myX)
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
    
    
    
    
    float px, py;
    px = random(0,100); //<>//
    py = random(0,100); //<>//
    p[pIndx].x = px; //<>//
    p[pIndx].y = py; //<>//
    p[pIndx].show = true; //<>//
  }
  void getPFpos()
  {
    println("needs to be implemented");
  }
}
    