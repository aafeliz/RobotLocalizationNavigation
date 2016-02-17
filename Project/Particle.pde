
class Particle
{
  float x, y;
  float xD, yD;
  boolean show;
  Particle()
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
      fill(204,102,100);//0
      //strokeWeight(3);
      //stroke(155, 153);
      noStroke();
      ellipse(x, y, xD, yD);
    }
  }
}