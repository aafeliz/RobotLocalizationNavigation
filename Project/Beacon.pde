class Beacon
{
  boolean detected;
  float myX, myY;
  float botDistance;
  float maxRange;
  float rangeVar;
  Beacon(int winWidth, int winHeight, int _maxRange, int _rangeVar)
  {
    detected = true;
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
  
  void updateDistance()
  {
    
  }
}