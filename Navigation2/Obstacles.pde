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
  
  public ArrayList<Ver> vertices;
  Obstacle2(int nSides, float x, float y, float minLength, float maxLength)
  {
    
    xPos = x;
    yPos = y;
    numSides = nSides;
    minL = minLength;
    maxL = maxLength;
    minPtX = maxL;
    maxPtX = minL;
    minPtY = maxL;
    maxPtY = minL;
    
    vertices = new ArrayList<Ver>();
    float angle = (360.0 / numSides);
    for (int i = 0; i < numSides; i++) /// useto be numSides+1 
    {
      float gain = random(this.minL, this.maxL);
      float tempX = xPos + gain * cos(radians(angle * (i+1)));
      float tempY = yPos + gain * sin(radians(angle * (i+1)));
      if(tempX < minPtX)
      {
        if(tempY < minPtY)
        {
          this.minPtY = tempY;
          this.minPtX = tempX;
        }
        if(tempY > maxPtY)
        {
          this.maxPtY = tempY;
          this.minPtX = tempX;
        }
      }
      if(tempX > maxPtX)
      {
        if(tempY < minPtY)
        {
          this.minPtY = tempY;
          this.maxPtX = tempX;
        }
        if(tempY > maxPtY)
        {
          this.maxPtY = tempY;
          this.maxPtX = tempX;
        }
      }
      Ver tempVer = new Ver(tempX, tempY, i);
      vertices.add(i,tempVer);
    }
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