


class Bot
{
  float x, y;
  float botWidth, botHeight;
  float heading;
  String name;
  float R,G,B;
  char letter;
  float targetX,targetY;
  float destX, destY;
  float preX, preY;
  float dx, dy;
  float easing;
  MapObstacles map;
  boolean changeDest;
  int loopCount;
  
  Bot(float _x, float _y, float _botWidth, float _botHeight, float _heading)
  {
    
    heading = _heading;
    botWidth = _botWidth;
    botHeight = _botHeight;
    R = 100;
    G =100;
    B = 100;
    this.map = new MapObstacles(15);
    this.x = _x;
    this.y = _y;
    while(checkPoint(this.x, this.y) == true)
    {
      this.x = random(800);
      this.y = random(800);
    }
    this.map.setRobotPos(this.x, this.y);
    this.changeDest = false;
    this.targetX = 0;
    this.targetY = 0;
    this.destX = 200; 
    this.destY = 200;
    while(checkPoint(this.destX, this.destY) == true)
    {
      this.destX = random(800);
      this.destY = random(800);
    }
    this.map.setDestination(this.destX, this.destY);
    this.dx = 0; 
    this.dy = 0;
    this.easing = 1.0;
    this.preX = 0.00;
    this.preY = 0.00;
    //println("created Bot");
  }
  
  void display()
  {
    if(this.map.pStack.len>0)
    {
      fill(R, G, B, 60);
    }
    else
    {
       fill(255,0,0,80); 
    }
    strokeWeight(3);
    stroke(R, G, B,90);
    rect(x, y, botWidth, botHeight, 2);
    strokeWeight(3);
    stroke(0,100,255,50);
    line(x, y, preX, preY);
  }
  void checkStack()
  {
    //setting target
    // user clicked somewhere new
    if(this.changeDest == true)
    {
      this.map.setDestination(this.destX, this.destY);//int(this.destX), int(this.destY));
      this.map.pStack.emptyStack();
      this.map.plan();
      /*
      if(this.map.pStack.len > 0)
      {
        OutVer tOutVer = this.map.pStack.peek();
        this.targetX = tOutVer.x;
        this.targetY = tOutVer.y;
      }*/
      this.changeDest = false;
    }
    if((this.map.pStack.len == 0) && ((this.x != this.destX) || (this.y != this.destY))) //((this.x != int(this.destX)) || (this.y != int(this.destY))))
    {
      this.map.setDestination(this.destX, this.destY);//(int(this.destX), int(this.destY));
      this.map.plan();
      /*if(this.map.pStack.len > 0)
      {
        OutVer tOutVer = this.map.pStack.peek();
        this.targetX = tOutVer.x;
        this.targetY = tOutVer.y;
      }*/
    }
    if(this.map.pStack.len > 0)// might need to pop
    {
      OutVer tOutVer = this.map.pStack.peek();
      float tX = (tOutVer.x);//int(tOutVer.x);
      float tY = (tOutVer.y);//int(tOutVer.y);
      if(this.targetX != tX || this.targetY != tY)
      {
        this.targetX = (tX);//int(tX);
        this.targetY = (tY);//int(tY);
      }
    }
    // reached vertex on the stack
    if((this.x == this.targetX) && (this.y == this.targetY))//(int(this.x) == int(this.targetX)) && (int(this.y) == int(this.targetY)))
    {
      if(this.map.pStack.len > 0)
      {
        this.map.pStack.pop();
        if(this.map.pStack.len > 0)
        {
          OutVer tOutVer = this.map.pStack.peek();
          this.targetX = (tOutVer.x);//int(tOutVer.x);
          this.targetY = (tOutVer.y);//int(tOutVer.y);
        }
      }
    }
    
    
    
  }
  void move()
  {
    
    /*if(mousePressed)
    {
      this.destX = mouseX;
      this.destY = mouseY;
      this.changeDest = true;
    }*/
    if(((this.x == this.destX) && (this.y == this.destY)))//(loopCount < 50) && 
    {
      this.destX = random(800);
      this.destY = random(800);
      while(checkPoint(this.destX, this.destY) == true)
      {
        this.destX = random(800);
        this.destY = random(800);
      }
      //this.changeDest = true;
      println("destination reached");
      this.loopCount = 0;
    }
    else
    {
      this.dx = this.targetX - this.x;
      this.dy = this.targetY - this.y;
      this.preX = this.x;
      this.preY = this.y;
      this.x += this.dx*this.easing;
      this.y += this.dy*this.easing;
    }
    this.map.setRobotPos(this.x, this.y);//(int(this.x), int(this.y));
    
  }
  
  boolean checkPoint(float X, float Y)
  {
    //println("checkPoint");
    for(int i  = 0; i < this.map.obstacles.size(); i++)
    {
      Obstacle2 tObs = this.map.obstacles.get(i); 
      if(tObs.minPtX < X && tObs.maxPtX > X)
      {
        if(tObs.minPtY < Y && tObs.maxPtY > Y)
        {
          return true;
        }
      }
    }
    return false;
  }
}