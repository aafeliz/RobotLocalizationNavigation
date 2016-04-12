


class EstBot
{
  float x, y;
  float botWidth, botHeight;
  float heading;
  String name;
  float R,G,B;
  char letter;
  
  EstBot(String _name, float _x, float _y, float _botWidth, float _botHeight, float _heading)
  {
    name = _name;
    x = _x;
    y = _y;
    heading = _heading;
    botWidth = _botWidth;
    botHeight = _botHeight;
    R = 100;
    G =100;
    B = 100;
    
    
    
    if(name == "Kalman")
    {
      R = 200;
      G = 20;
      B = 20;
      letter = 'K';
    }
    else if(name == "Particle")
    {
      R = 20;
      G = 20;
      B = 200;
      letter = 'P';
    }
    
  }
  
  void display()
  {
    fill(R, G, B, 50);
    strokeWeight(3);
    stroke(R, G, B,70);
    //rotate(heading);
    rect(x, y, botWidth, botHeight, 7); 
    textSize(36);
    fill(50);
    text(letter,(x+botWidth*0.1),(y+botHeight*0.8));
  }
  
  void move(float newX, float newY)
  {
    x = newX;
    y = newY;
  }
  
}