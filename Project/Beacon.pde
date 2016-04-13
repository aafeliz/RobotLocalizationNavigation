class Beacon
{
  boolean detected;
  boolean near;
  float myX, myY;
  float botRealDistance;
  float maxRange;
  float rangeVar;
  // attributes for filter
  float noiseDis;
  
  Beacon(int winWidth, int winHeight, int _maxRange, int _rangeVar)
  {
    detected = false;
    near = false;
    myX = random(0, winWidth);
    myY = random(0, winHeight);
    rangeVar = _rangeVar;
    maxRange = _maxRange + random(-rangeVar, rangeVar);
  }
  
  void display()
  {
    if((detected == true) && (near == true))
    {
      fill(203,255,236);
      strokeWeight(3);
      smooth(20);
      stroke(168,216,198);
      ellipse(myX, myY, maxRange, maxRange);
    }
    else if (detected == true)
    {
      noFill();
      strokeWeight(3);
      stroke(155, 153, 255, 90);
      ellipse(myX, myY, maxRange, maxRange);
    }
  }
  
  void updateDistance(float botx, float boty)
  {
    
    float disX = myX - botx;
    float disY = myY - boty;
    botRealDistance = sqrt(sq(disX) + sq(disY));
    updateNoiseDistance();
    if(botRealDistance < maxRange/2)
    {
      detected = true;
      near = false;
    } 
    else 
    {
      detected = false;
      near = false;
    }
  }
  
  void updateNoiseDistance()
  {
    float sd= map(botRealDistance, 0, maxRange, 0, 10); //the sigma changes linearly as a function of distance
    noiseDis = getRandomNormalDistributedValue(botRealDistance, sd);
  }
  
  
}
float getRandomNormalDistributedValue(float mean, float sd) 
{
  float n = 0;
  for (int i = 0; i < 100; i++)
    n += random(-1.0, 1.0);
  return mean + n * sd / 6;
}
 /*
float normalDistribution(float num, float mu, float sd) 
{
  float e = 2.71828182845904523536; 
  float ND  =  (1/sqrt(TWO_PI * sd ))*pow (e, (-(sq(num - mu))/(2*sq(sd ))));
  return ND;
}*/