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
  }
 
  void pushActual(float x, float y) 
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
 
  void popActual() 
  {
    if (actualTop >= actualRear) 
    {
      actualRear++;
      println("Pop operation done !");
      //display();
      actualTop--;
    } 
    else 
    {
      println("Underflow !");
    }
  }
  
  void pushKbot(float x, float y) 
  {
    if (kbotTop < capacity - 1) 
    {
      kbotTop++;
      kbot[kbotTop][0] = x;
      kbot[kbotTop][1] = y;
      //display();
    } 
    else 
    {
      println("Overflow !");
    }
  }
 
  void popKbot() 
  {
    if (kbotTop >= kbotRear) 
    {
      kbotRear++;
      println("Pop operation done !");
      kbotTop--;
    } 
    else 
    {
      println("Underflow !");
    }
  }
  void pushPbot(float x, float y) 
  {
    if (pbotTop < capacity - 1) 
    {
      pbotTop++;
      pbot[pbotTop][0] = x;
      pbot[pbotTop][1] = y;
      //display();
    } 
    else 
    {
      println("Overflow !");
    }
  }
 
  void popPbot() 
  {
    if (pbotTop >= pbotRear) 
    {
      pbotRear++;
      println("Pop operation done !");
      pbotTop--;
    } 
    else 
    {
      println("Underflow !");
    }
  }
  
  void display()
  {
    
  }
 
  
}