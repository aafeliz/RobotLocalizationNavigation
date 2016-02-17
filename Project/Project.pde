
final int winHeight = 400;
final int winWidth = 400;
final int numBeacons = 10;
final int maxBeaconRange = winWidth/2;
final int beaconRangeVar = 10;

Beacon[] be = new Beacon[numBeacons]; //<>//
void setup()
{
  size(400, 400);
  for(int i =0; i < be.length; i++)
  {
    be[i] = new Beacon(winWidth, winHeight, maxBeaconRange, beaconRangeVar); //<>//
    println("constructed a beacon");
  }
  
}

void draw()
{
  background(0);
  for(int i =0; i < be.length; i++)
  {
    be[i].display(); //<>//
  }
  
}