public class Grid
{
  private VPointer[][] cells;
  
  public Grid(VPointer[][] c)
  {
    cells = c;
    for (int i = 0; i < cells.length; i++)
    {
      for (int j = 0; j < cells[i].length; j++)
      {
        float size = width/cells.length;
        cells[i][j] = new VPointer((height/cells.length) * i + size/2, (width/cells[i].length) * j + size/2, size);
      }
    }
  }
  
  public void update()
  {
    for (int i = 0; i < cells.length; i++)
    {
      for (int j = 0; j < cells[i].length; j++)
      {
        cells[i][j].update();
        cells[i][j].drawPointer(20);
      }
    }
  }
}
