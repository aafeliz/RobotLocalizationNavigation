//NavBot navBot = new NavBot(botx, boty, botW, botH, botHeading, numobj);

/*TODO: you need to set visited vertices
 *    * also make it all positive only
 */

//MapObstacles o = new MapObstacles(15);

PFont f;
float oldDestX = 0.0;
float oldDestY = 0.0;
Bot r = new Bot(100.0, 100.0, 10.0, 10.0, 0.0);
void setup()
{
  f = createFont("Chalkboard-Bold.vlw", 24);
  textFont(f);
  size(800, 800);
  background(255);
  //o.display();
  r.map.display(); 
}
boolean firstDone = false;
void draw()
{
 // r.map.display();
  if(firstDone == true)
  {
    r.move();
    r.checkStack(); //<>//
    oldDestX = r.destX;
    oldDestY = r.destY;
    if(r.map.pStack.len>0)
    {
      println("planned new path");
    }
  }
  else
  {
    r.checkStack();
    oldDestX = r.destX;
    oldDestY = r.destY;
    firstDone = true;
  }
  
  r.display();
  delay(10);
}