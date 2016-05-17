class Obstacle2
{
  float xPos;
  float yPos;
  int numSides;
  float minL;
  float maxL;
  float minPtX;
  float maxPtX;
  float minPtY;
  float maxPtY;
  int id;
  char letter;
  
  public ArrayList<Ver> vertices;
  Obstacle2(int nSides, float x, float y, float minLength, float maxLength)
  {
    
    xPos = x;
    yPos = y;
    numSides = nSides;
    minL = minLength;
    maxL = maxLength;
    minPtX = x;
    maxPtX = x;
    minPtY = y;
    maxPtY = y;
    
    vertices = new ArrayList<Ver>();
    float angle = (360.0 / numSides);
    for (int i = 0; i < numSides; i++) /// useto be numSides+1 
    {
      float gain = random(this.minL, this.maxL);
      float tempX = -1;
      float tempY = -1;
      
      while((tempX < 0) || (tempY < 0))  //||((tempX > 800) || (tempY > 800))
      {
        tempX = xPos + gain * cos(radians(angle * (i+1)));
        tempY = yPos + gain * sin(radians(angle * (i+1)));
        gain = random(this.minL, this.maxL);
      }
      if(tempY > this.maxPtY)
      {
        this.maxPtY = tempY;
      }
      if(tempY < this.minPtY)
      {
        this.minPtY = tempY;
      }
      if(tempX < this.minPtX)
      {
        this.minPtX = tempX; 
      }
      if(tempX > this.maxPtX)
      {
        this.maxPtX = tempX;
      }
      Ver tempVer = new Ver(tempX, tempY, i);
      vertices.add(i,tempVer);
    }
    this.letter = char(this.id);
  }
  
  
  void display()
  {
    pushMatrix();
    beginShape();
    fill(200);
    stroke(0);
    strokeWeight(3);
    for(int i = 0; i < this.numSides; i++) 
    {
      Ver tempVer = this.vertices.get(i);
      vertex(tempVer.x, tempVer.y);
    }
    
    endShape(CLOSE);
    popMatrix();
    
    
  } 
}