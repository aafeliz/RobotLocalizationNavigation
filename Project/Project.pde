// Beacon parameters
final int winHeight = 800;
final int winWidth = 800;
final int numBeacons = 10;
final int maxBeaconRange = int(winWidth/1.5);
final int beaconRangeVar = 10;

// Bot parameters 
float botX = random(0, winWidth);
float botY = random(0, winHeight);
float headinginit = random(PI, TWO_PI);
final float scale = winHeight * winWidth;// not sure what to use as scale
final float _botWidth = scale/(winWidth*20);
final float _botHeight = scale/(winHeight*20);
final int numP = 100;
final int pNumDelta = 20;

Beacon[] be = new Beacon[numBeacons];
Bot bot;
void setup()
{
  size(800, 800);
  for(int i =0; i < be.length; i++)
  {
    be[i] = new Beacon(winWidth, winHeight, maxBeaconRange, beaconRangeVar);
    println("constructed a beacon");
  }
  bot = new Bot(botX, botY, headinginit, scale, _botWidth, _botHeight, numP, pNumDelta);
  println(headinginit);
}

void draw()
{
  background(255);
  /*for(int i =0; i < be.length; i++)
  {
    be[i].updateDistance(bot.x, bot.y);
    be[i].display();
  }*/
  bot.move();
  bot.kNearestBeacon(be);
  bot.getParticles(be); //<>// //<>//
  bot.display(); //<>// //<>//
  
  
}