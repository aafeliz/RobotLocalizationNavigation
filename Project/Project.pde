
final int winHeight = 200;
final int winWidth = 200;
final int numBeacons = 20;
final int maxBeaconRange = winWidth/4;
final int beaconRangeVar = 8;

Beacon[] be;
void setup()
{
  size(200, 200);
  for(int i =0; i < numBeacons; i++)
  {
    be[i] = new Beacon(winWidth, winHeight, maxBeaconRange, beaconRangeVar);
  }
  
}

void draw()
{
  background(0);
  for(int i =0; i < numBeacons; i++)
  {
    be[i].display();
  }
  
}