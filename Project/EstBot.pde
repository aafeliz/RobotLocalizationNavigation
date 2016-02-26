
class EstBot
{
  float x, y;
  float botWidth, botHeight;
  float heading;
  String name;
  float R,G,B;
  
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
      
    }
    else if(name == "Particle")
    {
      R = 20;
      G = 20;
      B = 200;
    }
    
  }
  
  void display()
  {
    fill(R, G, B);
    strokeWeight(3);
    stroke(155, 153);
    //rotate(heading);
    rect(x, y, botWidth, botHeight); 
  }
  
  void move(float newX, float newY)
  {
    x = newX;
    y = newY;
  }
  
}