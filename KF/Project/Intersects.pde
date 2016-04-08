class Intersects
{
  float x, y;
  float xD, yD;
  boolean show, inner;
  float R,G,B;
  Intersects()
  {
    x = 0;
    y = 0;
    xD = 5;
    yD = 5;
    show = false;
    inner = false;
    R = 50;
    G = 100;
    B = 200;
  }
  void display()
  {
    if (show && inner)
    {
      fill(R,G,B);
      noStroke();
      ellipse(x, y, (2*xD), (2*yD));
    }
    else if (show)
    {
      fill(100,100,100);
      noStroke();
      ellipse(x, y, xD, yD);
    }
  }
}