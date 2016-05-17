/*
    findNextVer()
    get the next vertex to add to the stack
  */
  /*
  OutVer findNextVer()
  {
    //println("findNextVer");
    if(this.pStack.len > 0)
    {
      
      // peek the stack in order to see where to start
      OutVer fromStack = this.pStack.peekLast();
      float tX1 = fromStack.x;
      float tY1 = fromStack.y;
      int tObjId = fromStack.objectNum_to;
      int tVerId = fromStack.verId_to;
      Ver tempV = this.obstacles.get(tObjId).vertices.get(tVerId);
      OutVer toStack = this.pStack.peekLast();
      // for all outver of that ver
      float minLen = Float.POSITIVE_INFINITY;
      int tOutID = -1;
      for(int i=0; i < tempV.outVer.size(); i++)// stack is not empty so i can just look at the outver of that ver
      {
        OutVer tOutVer = tempV.outVer.get(i);
        if(tOutVer.visited == false)
        {
          float len1 = tempV.outVer.get(i).weight;
          float tX2 = tempV.outVer.get(i).x;
          float tY2 = tempV.outVer.get(i).y;
          float len2 = dist(tX1, tY1, tX2, tY2);
          float tempTotal = len1 + len2;
          int tVerId2 = tOutVer.verId_to;
          int tObjId2 = tOutVer.objectNum_to;
          
          Ver tV = this.obstacles.get(tObjId2).vertices.get(tVerId2);    // check where the outVer are being made cause index might be wrong 
          if((minLen > tempTotal) && (tV.outVer.size() > 1))// new closer spot, found with more than one connection
          {
             tOutID = i;
             minLen = tempTotal; 
             toStack = tOutVer;//tempV.outVer.get(i);
          }
        }
        
      }
      if(tOutID > 0)
      {
        int tobjID = 0;
        for (int i=0; i < this.obstacles.size(); i++)
        {
          if(toStack.objectNum_to == this.obstacles.get(i).id)
          {
            tobjID = i;
          }
        }
        int toverID = 0;
        for (int i=0; i < this.obstacles.get(tobjID).vertices.size(); i++)
        {
          if(toStack.verId_to == this.obstacles.get(tobjID).vertices.get(i).id)
          {
            toverID = i;
          }
        }
        this.obstacles.get(tobjID).vertices.get(toverID).outVer.get(tOutID).visited = true;
      }
      return toStack;
      /// I think instead i should do obj in  line ID
      
      OutVer fromStack = this.pStack.peekLast();
      float tX1 = fromStack.x;
      float tY1 = fromStack.y;
      int tObjID = ObjInLineId(tX1, tY1, this.destX, this.destY);
      
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
          float len1 = dist(tX2,tY2, this.destX, this.destY);//vertices to destination
          float len2 = dist(tX1, tY1, tX2, tY2);
          float tempTotal = len1 + len2;                    //this.desX, this.destY
          if((minLen > tempTotal)&&((noLineOfSight(tX2, tY2, tX1, tY1))== false)&&(tObj.vertices.get(i).outVer.size() > 1))// if there is a line of sight from that point or you can go elsewhere
          {
             minLen = tempTotal;
             Ver tVer = tObj.vertices.get(i);
             int tverId = tVer.id;
             if(tVer.outVer.size()>1)
             {
               //OutVer tOutver = this.obstacles.get(tObjID).vertices.get(i).outVer.get(tOutID)
               toStack = new OutVer(tObjID, tverId, 0, 0, len2,  tVer.x, tVer.y);
             }
          }
        }
      }
      //this.obstacles.get(toStack.objectNum).vertices.get(toStack.verId).outVer.get(
      return toStack;
    }
    else
    {
      /// I think instead i should do obj in  line ID
      float tX1 = this.rX;
      float tY1 = this.rY;
      int tObjID = ObjInLineId(tX1, tY1, this.destX, this.destY);
      
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
          float len1 = dist(tX2,tY2, this.destX, this.destY);//vertices to destination
          float len2 = dist(tX1, tY1, tX2, tY2);
          float tempTotal = len1 + len2;                    //this.desX, this.destY
          if((minLen > tempTotal)&&((noLineOfSight(tX2, tY2, tX1, tY1))== false)&&(tObj.vertices.get(i).outVer.size() > 1))// if there is a line of sight from that point or you can go elsewhere
          {
             minLen = tempTotal;
             Ver tVer = tObj.vertices.get(i);
             int tverId = tVer.id;
             if(tVer.outVer.size()>1)
             {
               //OutVer tOutver = this.obstacles.get(tObjID).vertices.get(i).outVer.get(tOutID)
               toStack = new OutVer(tObjID, tverId, 0, 0, len2,  tVer.x, tVer.y);
             }
          }
        }
      }
      //this.obstacles.get(toStack.objectNum).vertices.get(toStack.verId).outVer.get(
      return toStack;
    }
  }
  */