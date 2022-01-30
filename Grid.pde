public class Grid
{
  private VPointer[][] cells;
  private float pointerLength = 15;
 
  public Grid(VPointer[][] c)
  {
    cells = c;
    for (int i = 0; i < cells.length; i++)
    {
      for (int j = 0; j < cells[i].length; j++)
      {
        float size = width/(cells.length - 2);
        cells[i][j] = new VPointer((height/(cells.length-2)) * (i-1) + size/2, (width/(cells[i].length-2)) * (j-1) + size/2, size);
      }
    }
  }
  
  public void update()
  {
    //the double nested loop is necessary because of the layering of squares
    for (int i = 1; i < cells.length - 1; i++)
    {
      for (int j = 1; j < cells[i].length - 1; j++)
      {
        //adding buffer cells to not have out of index array errors
        if (i != 0 || i != cells[i].length || i != 0 || i != cells[i].length) cells[i][j].update();
      }
    }
    for (int i = 1; i < cells.length - 1; i++)
    {
      for (int j = 1; j < cells[i].length - 1; j++)
      {
        //adding buffer cells to not have out of index array errors
        if (i != 0 || i != cells[i].length || i != 0 || i != cells[i].length) cells[i][j].drawPointerWithMouse(pointerLength);
      }
    }
  }
  
  //gets an accurate representation of the xMagnitudes of the four nearest pointers to the player using linear interpolation
  public float sampleAccelerationsX(float posX, float posY)
  { 
    float size = width/cells.length;
    
    float xInput = posX / size;
    int xIndex = floor(xInput);
    
    float yInput = posY / size;
    int yIndex = floor(yInput);
    
    float xMagnitude1 = cells[xIndex][yIndex].getXMagnitude(pointerLength);
    float xMagnitude2 = cells[xIndex][yIndex+1].getXMagnitude(pointerLength);
    float kX1 = xInput - xIndex;
    
    float x1 = lerp(xMagnitude1, xMagnitude2, kX1);
    
    float xMagnitude3 = cells[xIndex+1][yIndex].getXMagnitude(pointerLength);
    float xMagnitude4 = cells[xIndex+1][yIndex+1].getXMagnitude(pointerLength);
    float kX2 = xInput - xIndex;
    
    float x2 = lerp(xMagnitude3, xMagnitude4, kX2);
    
    float kY = yInput - yIndex;
        
    return lerp(x1, x2, kY);
  }
  
 //gets an accurate representation of the yMagnitudes of the four nearest pointers to the player using linear interpolation
  public float sampleAccelerationsY(float posX, float posY)
  { 
    float size = width/cells.length;
    
    float xInput = posX / size;
    int xIndex = floor(xInput);
    
    float yInput = posY / size;
    int yIndex = floor(yInput);
    
    float yMagnitude1 = cells[xIndex][yIndex].getYMagnitude(pointerLength);
    float yMagnitude2 = cells[xIndex][yIndex+1].getYMagnitude(pointerLength);
    float kY1 = xInput - xIndex;
    
    float y1 = lerp(yMagnitude1, yMagnitude2, kY1);
    
    float yMagnitude3 = cells[xIndex+1][yIndex].getYMagnitude(pointerLength);
    float yMagnitude4 = cells[xIndex+1][yIndex+1].getYMagnitude(pointerLength);
    float kY2 = xInput - xIndex;
    
    float y2 = lerp(yMagnitude3, yMagnitude4, kY2);
    
    float kY = yInput - yIndex;
    
    return lerp(y1, y2, kY);
  }

  private float lerp(float a, float b, float k) 
  {
    return a + k * (b - a);
  }
}
