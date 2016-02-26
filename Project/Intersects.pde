class Intersects
{
  float x, y;
  float xD, yD;
  boolean show;
  float angA,angB;
  float angMy;
  Intersects()
  {
    x = 0;
    y = 0;
    xD = 5;
    yD = 5;
    show = false;
  }
  void display()
  {
    if (show)
    {
      fill(100,100,100);
      noStroke();
      ellipse(x, y, xD, yD);
    }
  }
}