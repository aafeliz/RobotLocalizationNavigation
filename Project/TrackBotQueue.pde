/*
  *TODO:
  *  Implement the display function to display past N movements(capacity) 
*/

class TrackBotQueue 
{
  
  final int capacity;
  float actual[][];
  float kbot[][];
  float pbot[][];
  
  //int size = 0;
  int actualTop = -1;
  int actualRear = 0;
  int kbotTop = -1;
  int kbotRear = 0;
  int pbotTop = -1;
  int pbotRear = 0;
  
  TrackBotQueue(int capacity_)
  {
    capacity = capacity_;
    actual = new float[capacity][2];
    kbot = new float[capacity][2];
    pbot = new float[capacity][2];
  }
 
  void push(float x, float y, char bot) 
  {
    if(bot == 'A')
    {
      if (actualTop < capacity - 1) 
      {
        actualTop++;
        actual[actualTop][0] = x;
        actual[actualTop][1] = y;
        //display();
      } 
      else 
      {
        println("Overflow !");
      }
    }
    else if(bot=='K')
    {
      if (kbotTop < capacity - 1) 
      {
        kbotTop++;
        kbot[kbotTop][0] = x;
        kbot[kbotTop][1] = y;
      } 
      else 
      {
        println("Overflow !");
      }
    }
    else if(bot=='P')
    {
      if (pbotTop < capacity - 1) 
      {
        pbotTop++;
        pbot[pbotTop][0] = x;
        pbot[pbotTop][1] = y;
      } 
      else 
      {
        println("Overflow !");
      }
    }
  }
 
  void pop(char bot) 
  {
    if(bot == 'A')
    {
      if (actualTop >= actualRear) 
      {
        actualRear++;
        actualTop--;
      } 
      else 
      {
        println("Underflow !");
      }
    }
    else if(bot == 'K')
    {
      if (kbotTop >= kbotRear) 
      {
        kbotRear++;
        kbotTop--;
      } 
      else 
      {
        println("Underflow !");
      }
    }
    if(bot == 'P')
    {
      if (pbotTop >= pbotRear) 
      {
        pbotRear++;
        pbotTop--;
      } 
      else 
      {
        println("Underflow !");
      }
    }
    
  }
  
  void display(char bot)
  {
    if(bot == 'A')
    {
      float x1 = 0;
      float x2 = 0;
      float y1 = 0;
      float y2 = 0;
      for(int i = actualRear; i< actualTop; i++)
      {
        x1 = actual[i][0];
        y1 = actual[i][1];
        x2 = actual[i+1][0];
        y2 = actual[i+1][1];
        line(x1, y1, x2, y2);
      }
    }
    else if(bot == 'P')
    {
      float x1 = 0;
      float x2 = 0;
      float y1 = 0;
      float y2 = 0;
      for(int i = pbotRear; i< pbotTop; i++)
      {
        x1 = pbot[i][0];
        y1 = pbot[i][1];
        x2 = pbot[i+1][0];
        y2 = pbot[i+1][1];
        line(x1, y1, x2, y2);
      }
    }
    else if(bot == 'K')
    {
      float x1 = 0;
      float x2 = 0;
      float y1 = 0;
      float y2 = 0;
      for(int i = kbotRear; i< kbotTop; i++)
      {
        x1 = kbot[i][0];
        y1 = kbot[i][1];
        x2 = kbot[i+1][0];
        y2 = kbot[i+1][1];
        line(x1, y1, x2, y2);
      }
    }
   
  }
 
  
}