
class Bot
{
  float x, y;
  float heading;
  float scalar;
  float botWidth;
  float botHeight;
  int nearest1Indx;
  int nearest2Indx;
  
  Bot(float xpos, float ypos, float headinginit, float scale, float _botWidth, float _botHeight)
  {
    x = xpos;
    y = ypos;
    heading = headinginit;
    scalar = scale/100.0;
    botWidth = _botWidth;
    botHeight = _botHeight;
    nearest1Indx = -1;
    nearest2Indx = -1;
  }
  void move()
  {
    
    
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
    nearest1Indx = -1; //<>//
    nearest2Indx = -1;
    for (int i = 0; i < beacon.length; i++)
    {
      beacon[i].updateDistance(x, y);
      beacon[i].display();
      // check which are the two nearest neighbor //<>//
      //check if beacon can get distances
      if (beacon[i].detected)
      {
        if((nearest1Indx > -1) && (nearest2Indx > -1))
        { //<>//
          if(beacon[nearest1Indx].botNoiseDistance < beacon[nearest2Indx].botNoiseDistance) //<>//
          { //<>//
            if(beacon[i].botNoiseDistance < beacon[nearest2Indx].botNoiseDistance) //<>//
            { //<>//
              if(beacon[i].botNoiseDistance < beacon[nearest1Indx].botNoiseDistance) //<>//
              { //<>//
                nearest2Indx = nearest1Indx;  //<>//
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
        else if(nearest1Indx == -1) //<>//
        {
          nearest1Indx = i;
        }
        else if(nearest2Indx == -1) //<>//
        { //<>//
          nearest2Indx = i;
        }
        
      }
    }
    if((nearest1Indx != -1) && (nearest1Indx != -1))
    {
      beacon[nearest1Indx].near = true;
      beacon[nearest2Indx].near = true;
      beacon[nearest1Indx].display();
      beacon[nearest2Indx].display();
    }
  }
  void getParticle()
  {
    
  }
  void getPFpos()
  {
    
  }
}
    