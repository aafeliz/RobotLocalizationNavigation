// Beacon parameters
final int winHeight = 800;
final int winWidth = 800;
final int numBeacons = 20;
final int maxBeaconRange = int(winWidth/2);
final float distBetBeacons = maxBeaconRange/(numBeacons/1.5);
final int beaconRangeVar = 10;

// Bot parameters 
float botX = random(0, winWidth);
float botY = random(0, winHeight);
float headinginit = random(PI, TWO_PI);
final float scale = winHeight * winWidth;// not sure what to use as scale
final float _botWidth = scale/(winWidth*20);
final float _botHeight = scale/(winHeight*20);
final int numP = 100;
final int pNumDelta = 50;

Beacon[] be = new Beacon[numBeacons];
Bot bot;
void setup()
{
  size(800, 800);
  for(int i =0; i < be.length; i++)
  {
    be[i] = new Beacon(winWidth, winHeight, maxBeaconRange, beaconRangeVar);
    for(int j = i-1; j >= 0; j--)
    {
      while((dist(be[i].myX, be[i].myY, be[j].myX, be[j].myY)) < distBetBeacons)
      {
        be[i].myX = random(0, winWidth);
        be[i].myY = random(0, winHeight);
      }
    println("constructed a beacon " + i);
    }
  }
  bot = new Bot(botX, botY, headinginit, scale, _botWidth, _botHeight, numP, pNumDelta);
  println(headinginit);
}

void draw()
{
  frameRate(50);
  background(255);
  bot.move();
  bot.kNearestBeacon(be);
  bot.getParticles(be); //<>//
  for(int j = 0; j < bot.pIndx; j++) //<>//
  {
    bot.p[j].display(); 
  }
  for(int j = 0; j < bot.secs.length; j++)
  {
    bot.secs[j].display(); 
  }
  bot.Pbot.display();
  bot.Kbot.display();
  bot.display(); //<>//
}