class OutVer
{
  public int objectNum_to;
  public int verId_to;
  public int objectNum_from;
  public int verId_from;
  public float weight;
  public float x;//x and y are for to
  public float y;
  public boolean visited;
  public int me;
  public OutVer(int _objectNum_to, int _verId_to, int _objectNum_from, int _verId_from, float _weight, float _x, float _y)
  {
    this.objectNum_to = _objectNum_to;
    this.verId_to = _verId_to;
    this.objectNum_from = _objectNum_from;
    this.verId_from = _verId_from;
    this.weight = _weight;
    this.x = _x;
    this.y = _y;
    this.visited = false;
    this.me = 0;
  }
  
}