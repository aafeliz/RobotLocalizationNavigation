
class MapObstacles
{
  public ArrayList<Obstacle2> obstacles;
  public PlanningStack pStack;
  int numObj;
  int DONT_INTERSECT;
  int COLLINEAR;
  int DO_INTERSECT;
  
  public float destX;
  public float destY;
  public float rX;
  public float rY;
  float[][] lines;
  
  public MapObstacles(int _numObj)
  {
    DONT_INTERSECT = 0;
    COLLINEAR = 1;
    DO_INTERSECT = 2;
    this.destX = 0.00;
    this.destY = 0.00;
    this.rX = 0.00;
    this.rY = 0.00;
    this.numObj = _numObj;
    this.obstacles = new ArrayList<Obstacle2>();
    this.pStack = new PlanningStack();
    for(int i = 0; i < numObj; i++)
    {
      float oX = random(800);
      float oY = random(800);
      int oNumSides = int(random(3, 6));
      float oMin = random(25, 30);
      float oMax = random(70, 90);
      while((oX < oMax)||(oY < oMax))
      {
        oX = random(800);
        oY = random(800);
      }
      Obstacle2 tempObs = new Obstacle2(oNumSides,oX, oY, oMin, oMax);
      tempObs.id = i;
      tempObs.letter = char(i); 
      //boolean tester = true;
      obstacles.add(i,tempObs);
      
      if(this.obstacles.size() > 1)
      {
        while(this.objCollide(i))
        {
          //tester = objCollide(i);
          float oX2 = random(800);
          float oY2 = random(800);
          int oNumSides2 = int(random(3, 15));
          float oMin2 = random(5, 10);
          float oMax2 = random(40, 60);
          while((oX2 < oMax2)||(oY2 < oMax2))
          {
            oX2 = random(800);
            oY2 = random(800);
          }
          tempObs = new Obstacle2(oNumSides2,oX2, oY2, oMin2, oMax2);
          tempObs.id = i;
          tempObs.letter = char(i);
          obstacles.set(i,tempObs);
        }
        println("created Obj: "+i);
      }
      
      //else obstacles.add(tempObs);
    }
    this.connectAll(); //<>//
  }
  
  /*
    objCollide(int)
    check if objects overlap
  */
  boolean objCollide(int objN)
  {
    Obstacle2 tempObs = this.obstacles.get(objN);
    //println("node: " + objN);
    float radius = 2.1* tempObs.maxL;
    for(int i = 0; i < objN; i++)
    {
      Obstacle2 tempObs2 = this.obstacles.get(i);
      float distance = dist(tempObs.xPos, tempObs.yPos, tempObs2.xPos, tempObs2.yPos);
      float radius2 = 2.1* tempObs2.maxL;
      if((distance < radius)||(distance < radius2))
      {
         return true; 
      }
    }
    return false;
  }
  
  /*
    connectAll()
    will connect all the vertices with all the vertices of the other objects
  */
  void connectAll()
  {
    // obstacles->vertices->outVer
    for(int i = 0; i < this.obstacles.size(); i++)// all objects
    {
      Obstacle2 tempObs1 = this.obstacles.get(i);
      for(int j = 0; j < tempObs1.vertices.size(); j++)// all index in that object
      {
        // another two for loops inside to connect with other object's vertices
        Ver tempVer1 = this.obstacles.get(i).vertices.get(j);
        for(int i2 = 0; i2 < this.obstacles.size(); i2++)// all other objects
        {
          if(i != i2)// dont connect to yourself, however with the second line you should check with all of them //// actually check if j == j2 so you can actually still go to the ones next to it
           {
              Obstacle2 tempObs2 = this.obstacles.get(i2);
              for(int j2 = 0; j2 < tempObs2.vertices.size(); j2++)// vertices of that object
              {
                  // now you have one line still need to get the other line to compare
                  Ver tempVer2 = this.obstacles.get(i2).vertices.get(j2);
                  /////
                  boolean connect = true;
                  float tX1= 0.00, tX2 = 0.00, tY1 = 0.00, tY2 = 0.00, tX3 = 0.00, tX4 = 0.00, tY3 = 0.00, tY4 = 0.00;
                  /////
                  for(int i3 = 0; i3 < this.obstacles.size(); i3++)// including itself
                  {
                    Obstacle2 tempObs3 = this.obstacles.get(i3);
                    for(int j3 = 0; j3 < tempObs3.vertices.size(); j3++)                       ////////might need something here
                    {
                      // another two for loops inside to connect with other object's vertices
                      int i4 = i3;// same object
                      //int j4;
                      
                      Ver tempVer3 = this.obstacles.get(i3).vertices.get(j3);
                      for(int j4 = 0; j4 < tempObs3.vertices.size(); j4++)
                      {
                        /*if(j3 == tempObs3.vertices.size()-1)
                        {
                          j4 = 0;// vertex right before
                        }
                        else
                        {
                          j4 = j3+1;
                        }*/
                        if((i3 != i || j3 != j) && (i4 != i || j4 != j) && (i3 != i2 || j3 != j2) && (i4 != i2 || j4 != j2))
                        {
                          if(j4 != j3)
                          {
                            Ver tempVer4 = this.obstacles.get(i4).vertices.get(j4);
                            
                            tX1 = tempVer1.x;
                            tX2 = tempVer2.x;
                            tY1 = tempVer1.y;
                            tY2 = tempVer2.y;
                            tX3 = tempVer3.x;
                            tX4 = tempVer4.x;
                            tY3 = tempVer3.y;
                            tY4 = tempVer4.y;
                            
                            // check it intersects
                            if(lineIntersect2(tX1,tY1, tX2,tY2, tX3,tY3, tX4,tY4) == true) connect = false;
                            //else connect = false;
                          }
                        }
                      }
                    }
                  }
                  // check if you can connectx and if so connect
                  if(connect == true) 
                  {
                    float tWeight = dist(tX1,tY1, tX2,tY2);
                    OutVer tempOutVer = new OutVer(i2, j2, i, j, tWeight, tX2, tY2);
                    this.obstacles.get(i).vertices.get(j).outVer.add(tempOutVer);
                  } 
                }
          }
        } 
      }
    }
  }
  
  /*
    showLines()
    show all connections between vertices
  */
  void showLines()
  {
    for(int i = 0; i < this.obstacles.size(); i++)
    {
      for(int j = 0; j < this.obstacles.get(i).vertices.size(); j++)
      {
        float tX1 = this.obstacles.get(i).vertices.get(j).x;
        float tY1 = this.obstacles.get(i).vertices.get(j).y;
        for(int k = 0; k < this.obstacles.get(i).vertices.get(j).outVer.size(); k++)
        {
          float tX2 = this.obstacles.get(i).vertices.get(j).outVer.get(k).x;
          float tY2 = this.obstacles.get(i).vertices.get(j).outVer.get(k).y;
          strokeWeight(2);
          stroke(0,255,100,20);
          line(tX1, tY1, tX2, tY2);
          ellipse(tX1, tY1, 8,8);
          
        }
      }
    }
  }
  
  void display()
  {
    for(int i = 0; i < this.obstacles.size(); i++) //<>//
    {
      this.obstacles.get(i).display();
      stroke(3);
      strokeWeight(5);
      textSize(18);
      fill(120);
      float tx = (this.obstacles.get(i).maxPtX + this.obstacles.get(i).minPtX)/2.0; //this.obstacles.get(i).xPos;
      float ty = (this.obstacles.get(i).maxPtY + this.obstacles.get(i).minPtY)/2.0; //this.obstacles.get(i).yPos;//
      String s = str(this.obstacles.get(i).id);
      text(s, tx, ty);
    }
    this.showLines();
  }
  /*
    showLines()
    show all connections between vertices
  */
  void resetOuts()
  {
    for(int i = 0; i < this.obstacles.size(); i++)
    {
      for(int j = 0; j < this.obstacles.get(i).vertices.size(); j++)
      {
        for(int k = 0; k < this.obstacles.get(i).vertices.get(j).outVer.size(); k++)
        {
          this.obstacles.get(i).vertices.get(j).outVer.get(k).visited = false;
        }
      }
    }
  }
  void resetVers()
  {
    for(int i = 0; i < this.obstacles.size(); i++)
    {
      for(int j = 0; j < this.obstacles.get(i).vertices.size(); j++)
      {
        this.obstacles.get(i).vertices.get(i).visited = false;
      }
    }
  }
  
  
  boolean lineIntersect2(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4)
  {
    //println("lineItersect2");
    if(lineIntersect(x1, y1, x2, y2, x3, y3, x4, y4) == 2)return true; 
    else return false;
    
  }
  
  int lineIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4)
  {
    //println("lineItersect");
    float a1, a2, b1, b2, c1, c2;
    float r1, r2 , r3, r4;
    float denom, offset, num;
  
    // Compute a1, b1, c1, where line joining points 1 and 2
    // is "a1 x + b1 y + c1 = 0".
    a1 = y2 - y1;
    b1 = x1 - x2;
    c1 = (x2 * y1) - (x1 * y2);
  
    // Compute r3 and r4.
    r3 = ((a1 * x3) + (b1 * y3) + c1);
    r4 = ((a1 * x4) + (b1 * y4) + c1);
  
    // Check signs of r3 and r4. If both point 3 and point 4 lie on
    // same side of line 1, the line segments do not intersect.
    if ((r3 != 0) && (r4 != 0) && same_sign(r3, r4)){
      return DONT_INTERSECT;
    }
  
    // Compute a2, b2, c2
    a2 = y4 - y3;
    b2 = x3 - x4;
    c2 = (x4 * y3) - (x3 * y4);
  
    // Compute r1 and r2
    r1 = (a2 * x1) + (b2 * y1) + c2;
    r2 = (a2 * x2) + (b2 * y2) + c2;
  
    // Check signs of r1 and r2. If both point 1 and point 2 lie
    // on same side of second line segment, the line segments do
    // not intersect.
    if ((r1 != 0) && (r2 != 0) && (same_sign(r1, r2))){
      return DONT_INTERSECT;
    }
  
    //Line segments intersect: compute intersection point.
    denom = (a1 * b2) - (a2 * b1);
  
    if (denom == 0) {
      return COLLINEAR;
    }
  
    if (denom < 0){ 
      offset = -denom / 2; 
    } 
    else {
      offset = denom / 2 ;
    }
  
    // The denom/2 is to get rounding instead of truncating. It
    // is added or subtracted to the numerator, depending upon the
    // sign of the numerator.
    float tempX, tempY;
    num = (b1 * c2) - (b2 * c1);
    if (num < 0){
      tempX = (num - offset) / denom;
    } 
    else {
      tempX = (num + offset) / denom;
    }
  
    num = (a2 * c1) - (a1 * c2);
    if (num < 0){
      tempY = ( num - offset) / denom;
    } 
    else {
      tempY = (num + offset) / denom;
    }
  
    // lines_intersect
    //this.interceptQ.pop();
    //this.interceptQ.push(tempX, tempY);
    return DO_INTERSECT;
  }
  
  boolean same_sign(float a, float b){
  
    return (( a * b) >= 0);
  }
  /*
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  */
  
  
  
  /*
    plan()
    fill in the planning stack 
  */
  void plan()
  {
    //println("plan");
    
    float tX1, tY1, tX2, tY2;
    if(this.pStack.len > 0)
    {
      OutVer fromStack = this.pStack.peek();
      tX1 = fromStack.x;
      tY1 = fromStack.y;
    }
    else
    {
      tX1 = this.rX;
      tY1 = this.rY;
    }
    tX2 = this.destX;
    tY2 = this.destY;
    //int size = 0;
    while((this.noLineOfSight(tX1, tY1, tX2, tY2)==true))//peek of stack and destination
    {
      OutVer tOutVer = this.findNextVer();
      //this.obstacles.get(tOutVer.objectNum).vertices.get(tOutVer.verId).outVer.get(i).visited = true;
      this.pStack.push(tOutVer);
      tX1 = tOutVer.x;
      tY1 = tOutVer.y;
      //size++;
    }
    this.resetOuts();
    // finally add destination
    float tw = dist(tX1, tY1, tX2, tY2);
    OutVer tOutVer = new OutVer(Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, tw, tX2, tY2);
    this.pStack.push(tOutVer);
  }
  
  /*
    noLineOfSight()
    check to see if there is a dirrect line of signt
  */
  boolean noLineOfSight(float x1, float y1,float x2, float y2)        /////////////// this might be zero so check stack before
  {
    //println("noLineOfSight");
    // peek the stack in order to see where to start
    //OutVer fromStack = this.pStack.peek();
    float tX1 = x1;//fromStack.x;
    float tY1 = y1;//fromStack.y;
    float tX2 = x2;//this.destX;
    float tY2 = y2;//this.destY;
    
    //now compate to all other lines
    ////////////////////////////////////////////////// NO COMPARE TO ALL OTHER LINES//////////////////////////////////////////////////////////////
    float tX3 = 0.00, tX4 = 0.00, tY3 = 0.00, tY4 = 0.00;
    for(int i3 = 0; i3 < this.obstacles.size(); i3++)// including itself
    {
      Obstacle2 tempObs3 = this.obstacles.get(i3);
      for(int j3 = 0; j3 < tempObs3.vertices.size(); j3++)                       ////////might need something here
      {
        // another two for loops inside to connect with other object's vertices
        int i4 = i3;// same object
        //int j4;
        
        Ver tempVer3 = this.obstacles.get(i3).vertices.get(j3);
        for(int j4 = 0; j4 < tempObs3.vertices.size(); j4++)
        {
          if(j4 != j3)
          {
            Ver tempVer4 = this.obstacles.get(i4).vertices.get(j4);
            
            tX3 = tempVer3.x;
            tX4 = tempVer4.x;
            tY3 = tempVer3.y;
            tY4 = tempVer4.y;
            if((tX3 != x1 || tY3 != y1) && (tX4 != x1 || tY4 != y1) && (tX3 != x2 || tY3 != y2) && (tX4 != x2 || tY4 != y2))
            {
            // check it intersects
            if(lineIntersect2(tX1,tY1, tX2,tY2, tX3,tY3, tX4,tY4) == true) return true;
            //else connect = false;
            }
          }
        }
      }
    }
    /*
    boolean connect = true;
    float tX3 = 0.00, tX4 = 0.00, tY3 = 0.00, tY4 = 0.00;
    /////
    for(int i3 = 0; i3 < this.obstacles.size(); i3++)
    {
      Obstacle2 tempObs3 = this.obstacles.get(i3);
      for(int j3 = 0; j3 < tempObs3.vertices.size(); j3++)                       ////////might need something here
      {
        // another two for loops inside to connect with other object's vertices
        int i4 = i3;// same object
        int j4;
        Ver tempVer3 = this.obstacles.get(i3).vertices.get(j3);
        if(j3 == tempObs3.vertices.size()-1)
        {
          j4 = 0;// vertex right before
        }
        else
        {
          j4 = j3+1;
        }
        
        Ver tempVer4 = this.obstacles.get(i4).vertices.get(j4);
        
        tX3 = tempVer3.x;
        tX4 = tempVer4.x;
        tY3 = tempVer3.y;
        tY4 = tempVer4.y;
        if(((tX1 == tX3)&&(tY1 == tY3)) || ((tX1 == tX4)&&(tY1 == tY4)) || ((tX2 == tX3)&&(tY2 == tY3)) || ((tX2 == tX4)&&(tY2 == tY4)))
        {
           println("Same point");
        }
        else
        {
          // check it intersects
          if(lineIntersect2(tX1,tY1, tX2,tY2, tX3,tY3, tX4,tY4) == true) return true;
        }
      }
    }
    */
    // check if you can connectx and if so connect 
    return false;
  }
  
  
  /*
    objInLineId()
    get whcih obj is in the way
  */
  int ObjInLineId(float x1, float y1,float x2, float y2)    //x2, y2 for destination    /////////////// this might be zero so check stack before
  {
    //println("ObjInlineId");
    // peek the stack in order to see where to start
    //OutVer fromStack = this.pStack.peek();
    float tX1 = x1;//fromStack.x;
    float tY1 = y1;//fromStack.y;
    float tX2 = x2;//this.destX;
    float tY2 = y2;//this.destY;
    
    //now compate to all other lines
    int nearestObjID = 0;
    float nearestObjDist = Float.POSITIVE_INFINITY;
    ////////////////////////////////////////////////// NO COMPARE TO ALL OTHER LINES//////////////////////////////////////////////////////////////
    boolean connect = true;
    float tX3 = 0.00, tX4 = 0.00, tY3 = 0.00, tY4 = 0.00;
    /////
    for(int i3 = 0; i3 < this.obstacles.size(); i3++)// including itself
    {
      Obstacle2 tempObs3 = this.obstacles.get(i3);
      for(int j3 = 0; j3 < tempObs3.vertices.size(); j3++)                       ////////might need something here
      {
        int i4 = i3;// same object
        Ver tempVer3 = this.obstacles.get(i3).vertices.get(j3);
        for(int j4 = 0; j4 < tempObs3.vertices.size(); j4++)
        {
          if(j4 != j3)
          {
            Ver tempVer4 = this.obstacles.get(i4).vertices.get(j4);
            tX3 = tempVer3.x;
            tX4 = tempVer4.x;
            tY3 = tempVer3.y;
            tY4 = tempVer4.y;
            if((tX3 != x1 || tY3 != y1) && (tX4 != x1 || tY4 != y1) && (tX3 != x2 || tY3 != y2) && (tX4 != x2 || tY4 != y2))
            {
              // check it intersects
              if(lineIntersect2(tX1, tY1, tX2, tY2, tX3, tY3, tX4, tY4) == true)
              {
                // check is distance is shorter
                float tObjX = (tempObs3.minPtX + tempObs3.maxPtX)/2;
                float tObjY = (tempObs3.minPtY + tempObs3.maxPtY)/2;
                float tDist1 = dist(x1,y1,tObjX,tObjY);
                float tDist2 = dist(x2,y2,tObjX,tObjY);
                float tTotal = tDist1 + tDist2;
                if(tTotal < nearestObjDist)
                {
                  nearestObjID = this.obstacles.get(i3).id;
                  nearestObjDist = tTotal;
                }
              }
            }
          }
          
        }
      }
    }
    /*
    for(int i3 = 0; i3 < this.obstacles.size(); i3++)
    {
      Obstacle2 tempObs3 = this.obstacles.get(i3);
      for(int j3 = 0; j3 < tempObs3.vertices.size(); j3++)                       ////////might need something here
      {
        // another two for loops inside to connect with other object's vertices
        int i4 = i3;// same object
        int j4;
        Ver tempVer3 = this.obstacles.get(i3).vertices.get(j3);
        if(j3 == tempObs3.vertices.size()-1)
        {
          j4 = 0;// vertex right before
        }
        else
        {
          j4 = j3+1;
        }
        
        Ver tempVer4 = this.obstacles.get(i4).vertices.get(j4);
        
        tX3 = tempVer3.x;
        tX4 = tempVer4.x;
        tY3 = tempVer3.y;
        tY4 = tempVer4.y;
        if(((tX1 == tX3)&&(tY1 == tY3)) || ((tX1 == tX4)&&(tY1 == tY4)) || ((tX2 == tX3)&&(tY2 == tY3)) || ((tX2 == tX4)&&(tY2 == tY4)))
        {
           println("Same point");
        }
        else
        {
          // check it intersects
          if(lineIntersect2(tX1,tY1, tX2,tY2, tX3,tY3, tX4,tY4) == true)
          {
            // check is distance is shorter
            float tObjX = (tempObs3.minPtX + tempObs3.maxPtX)/2;
            float tObjY = (tempObs3.minPtY + tempObs3.maxPtY)/2;
            float tDist1 = dist(x1,y1,tObjX,tObjY);
            float tDist2 = dist(x2,y2,tObjX,tObjY);
            float tTotal = tDist1+tDist2;
            if(tTotal < nearestObjDist)
            {
              nearestObjID = i3;
              nearestObjDist = tTotal;
            }
            
          }
        }
      }
    }
    */
    return nearestObjID;
  }
  
  
  /*
    findNextVer()
    get the next vertex to add to the stack
  */
  OutVer findNextVer()
  {
    //println("findNextVer");
    float tX1 = 0.0;
    float tY1 = 0.0;
    if(this.pStack.len > 0)
    { //<>// //<>// //<>// //<>// //<>//
      OutVer fromStack = this.pStack.peekLast();
      tX1 = fromStack.x;
      tY1 = fromStack.y;
    }
    else
    {
      /// I think instead i should do obj in  line ID
      tX1 = this.rX;
      tY1 = this.rY;
    }
    int tObjID = ObjInLineId(tX1, tY1, this.destX, this.destY); //<>//
    
    Obstacle2 tObj = this.obstacles.get(tObjID);
    for(int i = 0; i < this.obstacles.size(); i++)
    {
      if(this.obstacles.get(i).id == tObjID)
      {
        tObj = this.obstacles.get(i);
        break;
      }
    }
    
    //Ver tempV = this.obstacles.get(tObjID).vertices.get(tVerId);
    
    // check if i can even get there without things in my way
    // check chich vertex is best along the tempV by shortest distance
    
    
    OutVer toStack =new OutVer(0, 0, 0, 0, 0, 0, 0);
    // for all outver of that ver
    float minLen = Float.POSITIVE_INFINITY;
    for(int i=0; i < tObj.vertices.size(); i++)
    {
      float tX2 = tObj.vertices.get(i).x;//tempV.outVer.get(i).x;
      float tY2 = tObj.vertices.get(i).y;//tempV.outVer.get(i).y;
      if(noLineOfSight(tX1, tY1, tX2, tY2) == false)
      {
        float len1 = dist(tX2, tY2, this.destX, this.destY);//vertices to destination
        float len2 = dist(tX1, tY1, tX2, tY2);
        float tempTotal = len1 + len2;                    //this.desX, this.destY
        if((minLen > tempTotal)&&((noLineOfSight(tX2, tY2, tX1, tY1))== false)&&(tObj.vertices.get(i).outVer.size() > 1))// if there is a line of sight from that point or you can go elsewhere
        {
           minLen = tempTotal;
           Ver tVer = tObj.vertices.get(i);
           int tverId = tVer.id;
           if(this.pStack.len > 0)
           { 
             OutVer fromStack = this.pStack.peekLast();
             if(fromStack.objectNum_to != tObjID || fromStack.verId_to != tverId)
             {
               if(tVer.outVer.size()>1)
               {
                 //OutVer tOutver = this.obstacles.get(tObjID).vertices.get(i).outVer.get(tOutID)
                 toStack = new OutVer(tObjID, tverId, 0, 0, len2,  tVer.x, tVer.y);
               }
             }
           }
           else
           {
             if(tVer.outVer.size()>1)
             {
               //OutVer tOutver = this.obstacles.get(tObjID).vertices.get(i).outVer.get(tOutID)
               toStack = new OutVer(tObjID, tverId, 0, 0, len2,  tVer.x, tVer.y);
             }
           }
           
        }
      }
    }
    //this.obstacles.get(toStack.objectNum).vertices.get(toStack.verId).outVer.get(
    return toStack;
  }
  
  /*
    setDestination()
    pass the destination from bot
  */
  void setDestination(float X, float Y)
  {
    //println("setDestination");
    this.destX = X;
    this.destY = Y;
  }
  
  /*
    setRobotPos()
    pass the robots position
  */
  void setRobotPos(float X, float Y)
  {
    this.rX = X;
    this.rY = Y;
  }
}