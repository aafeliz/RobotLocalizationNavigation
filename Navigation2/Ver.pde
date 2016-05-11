class Ver
{
    public float x;
    public float y;
    public int id;//id in an object
    public int numOut;// gives you number of conncected vertices
    public ArrayList<OutVer> outVer;
    public Boolean visited;
    
    public Ver(float _x, float _y, int _id)
    {
      this.x = _x;
      this.y = _y;
      this.id = _id;
      this.outVer = new ArrayList<OutVer>();
      this.visited = false;
    }
    void addConnected(int _objectNum_to, int _verId_to, int _objectNum_from, int _verId_from, float _weight, float _x, float _y)
    {
      OutVer ver = new OutVer(_objectNum_to, _verId_to, _objectNum_from,_verId_from, _weight, _x,_y);
      this.outVer.add(ver);
      this.numOut++;
    }
}