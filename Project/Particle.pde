
class Particle
{
  float x, y;
  float xD, yD;
  boolean show;
  Particle()
  {
    x = 0;
    y = 0;
    xD = 50;
    yD = 50;
    show = false;
  }
  void display()
  {
    if (show)
    {
      fill(204,102,0);
      strokeWeight(3);
      stroke(155, 153);
      ellipse(x, y, xD, yD);
    }
  }
}