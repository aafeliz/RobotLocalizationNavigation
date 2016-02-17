// Beacon parameters
final int winHeight = 400;
final int winWidth = 400;
final int numBeacons = 10;
final int maxBeaconRange = winWidth/2;
final int beaconRangeVar = 10;
//Bot parameters Bot(xpos, ypos, headinginit, scale, _botWidth, _botHeight)
float botX = random(0, winWidth);
float botY = random(0, winHeight);
float headinginit = random(0, 2*PI);
final float scale = winHeight * winWidth;// not sure what to use as scale
final float _botWidth = scale/(winWidth*20);
final float _botHeight = scale/(winHeight*20);

Beacon[] be = new Beacon[numBeacons]; //<>//
Bot bot;
void setup()
{
  size(400, 400);
  for(int i =0; i < be.length; i++)
  {
    be[i] = new Beacon(winWidth, winHeight, maxBeaconRange, beaconRangeVar); //<>//
    println("constructed a beacon");
  }
  bot = new Bot(botX, botY, headinginit, scale, _botWidth, _botHeight);
  
}

void draw()
{
  background(0);
  for(int i =0; i < be.length; i++)
  {
    be[i].display(); //<>//
  }
  bot.display();
  
}