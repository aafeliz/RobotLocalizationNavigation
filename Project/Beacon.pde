class Beacon
{
  boolean detected;
  float myX, myY;
  float botDistance;
  float maxRange;
  float rangeVar;
  Beacon(int winWidth, int winHeight, int _maxRange, int _rangeVar)
  {
    detected = false;
    myX = random(0, winWidth);
    myY = random(0, winHeight);
    rangeVar = _rangeVar;
    maxRange = _maxRange + random(-rangeVar, rangeVar);
  }
  void display()
  {
    if (detected == true)
    {
      noFill();
      strokeWeight(3);
      stroke(155, 153);
      ellipse(myX, myY, maxRange, maxRange);
    }
  }
  void updateDistance(float botx, float boty)
  {
    
    float disX = myX - botx;
    float disY = myY - boty;
    botDistance = sqrt(sq(disX) + sq(disY));
    if (botDistance < maxRange/2 ) 
    {
      detected = true;
    } 
    else 
    {
      detected = false;
    }
  }
   
}