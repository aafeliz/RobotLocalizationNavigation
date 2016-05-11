
class PlanningStack
{
  ArrayList<OutVer> stack;
  int len;
  PlanningStack()
  {
    this.stack = new ArrayList<OutVer>();
    len = 0;
  }
  void push(OutVer ver)
  {
    this.stack.add(this.len, ver);
    this.len++;
  }
  void pop()
  {
    this.stack.remove(0);
    this.len--;
  }
  public OutVer peek()
  {
    return this.stack.get(0);
  }
  public OutVer peekLast()
  {
    return this.stack.get(this.len-1);
  }
  void emptyStack()
  {
     this.stack.clear(); 
     this.len = 0;
  }
}