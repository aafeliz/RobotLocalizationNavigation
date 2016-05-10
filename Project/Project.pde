// Beacon parameters
final int winHeight = 800;
final int winWidth = 800;
final int numBeacons = 40;
final int maxBeaconRange = int(winWidth/2);
final float distBetBeacons = maxBeaconRange/(numBeacons/1.5);
final int beaconRangeVar = 50;

// Bot parameters 
float botX = random(0, winWidth);
float botY = random(0, winHeight);
float headinginit = random(PI, TWO_PI);
final float scale = winHeight * winWidth;// not sure what to use as scale
final float _botWidth = scale/(winWidth*20);
final float _botHeight = scale/(winHeight*20);
final int numP = 100;
final int pNumDelta = 20;

PFont f;
Beacon[] be = new Beacon[numBeacons];
Bot bot;
TrackBotQueue Aq = new TrackBotQueue(0,255,222,200);
TrackBotQueue Kq = new TrackBotQueue(200, 20, 20, 200);
TrackBotQueue Pq = new TrackBotQueue(20, 20, 200, 200);

void setup()
{
   f = createFont("Chalkboard-Bold.vlw", 24);
  textFont(f);
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
  background(255);
  bot.move();
  bot.kNearestBeacon(be);
  bot.getParticles(be);
  for(int j = 0; j < bot.pIndx; j++)
  {
    bot.p[j].display(); 
  }
  for(int j = 0; j < bot.secs.length; j++)
  {
    bot.secs[j].display(); 
  }
  Aq.push(bot.x, bot.y);
  Kq.push(bot.Kbot.x, bot.Kbot.y);
  Pq.push(bot.Pbot.x, bot.Pbot.y);
  Aq.pop();
  Kq.pop();
  Pq.pop();
  bot.Pbot.display();
  bot.Kbot.display();
  bot.display();
  Aq.display();
  Kq.display();
  Pq.display();
  delay(20);
}