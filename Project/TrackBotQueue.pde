/*
  *TODO:
  *  check the pop has no leaks
*/
import java.util.Iterator;

public class TrackBotQueue
{
    private Node head;
    private Node tail;
    private int length;
    int maxLength;
    int R;
    int G;
    int B;

    public TrackBotQueue(int r, int g, int b, int capacity)
    {
        this.length = 0;
        this.maxLength = capacity;
        this.head = null;
        this.tail = null;
        this.R = r;
        this.G = g;
        this.B = b;
    }

    public int length()
    {
        return this.length;
    }

    void push(float x, float y)
    {
      if(this.length < this.maxLength) //<>//
      {
        if(length()==0)
        {
          Node node = new Node();
          node.x = x;
          node.y = y;
          node.ahead = null;
          node.back = null;
          this.head = node;
          this.tail = node;
          this.length++;
        }
        else
        {
          Node node = new Node();
          node.x = x;
          node.y = y;
          node.ahead = this.tail;
          this.tail.back = node;
          this.tail = node;
          this.length++;
        }
      }
    }
    void pop()
    {
      if(this.length >= this.maxLength)
      {
        if(length()!=0)
        {
          this.head = this.head.back;
          this.head.ahead.back = null;
          this.head.ahead = null;
          this.length--;
        }
        else
        {
          println("Queue is empty");
        }
      }
    }
    void display()
    {
      float x1 = 0;
      float x2 = 0;
      float y1 = 0;
      float y2 = 0;
      Node temp = this.head;
      while(temp.back != null)
      {
        x1 = temp.x;
        y1 = temp.y;
        x2 = temp.back.x;
        y2 = temp.back.y;
        stroke( this.R, this.G, this.B, 50);
        line(x1, y1, x2, y2);
        temp = temp.back;
      }
    }
}

class Node
{
    public float x;
    public float y;
    public Node back;
    public Node ahead;
}