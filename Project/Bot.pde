
class Bot
{
  float x, y;
  float heading;
  float scalar;
  float botWidth;
  float botHeight;
  
  Bot(float xpos, float ypos, float headinginit, float scale, float _botWidth, float _botHeight)
  {
    x = xpos;
    y = ypos;
    heading = headinginit;
    scalar = scale/100.0;
    botWidth = _botWidth;
    botHeight = _botHeight;
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
    
  }
  void getParticle()
  {
    
  }
  void getPFpos()
  {
    
  }
}
    