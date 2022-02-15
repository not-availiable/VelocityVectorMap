public class Grid
{
  public VPointer[][] cells;
  
  private float[][] vX = new float[resolution+2][resolution+2], vY = new float[resolution + 2][resolution+2], vX0 = new float[resolution + 2][resolution+2], vY0 = new float[resolution + 2][resolution+2];
  
  //the length of each pointer at it's maximum value
  //also the magnitude of the acceleration (changing this means we'll have to change the constant on the acceleration)
  public float pointerLength = 15;
 
  public Grid(VPointer[][] c)
  {
    //initalizes all non-border cells
    cells = c;
    for (int i = 0; i < cells.length; i++)
    {
      for (int j = 0; j < cells[i].length; j++)
      {
        float size = width/(cells.length - 2);
        cells[i][j] = new VPointer((height/(cells.length-2)) * (i-1) + size/2, (width/(cells[i].length-2)) * (j-1) + size/2, size);
        cells[i][j].initalize(pointerLength);
        vX[i][j] = cells[i][j].getXMagnitude();
        vY[i][j] = cells[i][j].getYMagnitude();
        vX0 = vX;
        vY0 = vY;
      }
    }
  }
  
  public void update()
  {
    //the double nested loop is necessary because of the layering of squares
    //if we find the tiles unnesessary, we can make this one nested loop
    for (int i = 1; i < cells.length - 1; i++)
    {
      for (int j = 1; j < cells[i].length - 1; j++)
      {
        //adding buffer cells to not have out of index array errors
        if (i != 0 || i != cells.length || j != 0 || j != cells.length) cells[i][j].generateSquare();
      }
    }
    for (int i = 1; i < cells.length - 1; i++)
    {
      for (int j = 1; j < cells[i].length - 1; j++)
      {
        //adding buffer cells to not have out of index array errors
        //if (i != 0 || i != cells.length || j != 0 || j != cells.length) cells[i][j].drawPointerWithMouse(pointerLength);
        if (i != 0 || i != cells.length || j != 0 || j != cells.length) cells[i][j].generatePointer();
      }
    }
    
    //bad code ... again
    
    for (int i = 1; i < cells.length - 1; i++)
    {
      for (int j = 1; j < cells[i].length - 1; j++)
      {
        //adding buffer cells to not have out of index array errors
        if (i != 0 || i != cells.length || j != 0 || j != cells.length) cells[i][j].paintRed(false);
      }
    }
  }
  
  //gets an accurate representation of the xMagnitudes of the four nearest pointers to the player using linear interpolation
  public float sampleAccelerationsX(float posX, float posY)
  { 
    float size = width/cells.length;
    
    float actualWidth = width + 2 * size;
    
    float actualSize = actualWidth / cells.length;
    
    float xInput = posX / actualSize;
    int xIndex = floor(xInput);
    
    float yInput = posY / actualSize;
    int yIndex = floor(yInput);

    
    float xMagnitude1 = cells[xIndex][yIndex].getXMagnitude();
    float xMagnitude2 = cells[xIndex][yIndex+1].getXMagnitude();
    
    float kX1 = xInput - xIndex;
    
    float x1 = lerp(xMagnitude1, xMagnitude2, kX1);
    
    
    float xMagnitude3 = cells[xIndex+1][yIndex].getXMagnitude();
    float xMagnitude4 = cells[xIndex+1][yIndex+1].getXMagnitude();
    
    float kX2 = xInput - xIndex;
    
    float x2 = lerp(xMagnitude3, xMagnitude4, kX2);
    
    float kY = yInput - yIndex;
    
    cells[xIndex][yIndex].paintRed(true);
    cells[xIndex+1][yIndex].paintRed(true);
    cells[xIndex][yIndex+1].paintRed(true);
    cells[xIndex+1][yIndex+1].paintRed(true);
    
    return lerp(x1, x2, kY);
  }
  
 //gets an accurate representation of the yMagnitudes of the four nearest pointers to the player using linear interpolation
  public float sampleAccelerationsY(float posX, float posY)
  { 
    float size = width/cells.length;
    
    float actualWidth = width + 2 * size;
    
    float actualSize = actualWidth / cells.length;
    
    float xInput = posX / actualSize;
    int xIndex = floor(xInput);
    
    float yInput = posY/ actualSize;
    int yIndex = floor(yInput);
    
    
    float yMagnitude1 = cells[xIndex][yIndex].getYMagnitude();
    float yMagnitude2 = cells[xIndex][yIndex+1].getYMagnitude();
    
    float kY1 = xInput - xIndex;
    
    float y1 = lerp(yMagnitude1, yMagnitude2, kY1);
 
    
    float yMagnitude3 = cells[xIndex+1][yIndex].getYMagnitude();
    float yMagnitude4 = cells[xIndex+1][yIndex+1].getYMagnitude();
    
    float kY2 = xInput - xIndex;
    
    float y2 = lerp(yMagnitude3, yMagnitude4, kY2);
    
    float kY = yInput - yIndex;
    
    return lerp(y1, y2, kY);
  }

  private float lerp(float a, float b, float k) 
  {
    return a + k * (b - a);
  }
  
  
  public float[][] getVx() { return vX; }
  public float[][] getVy() { return vY; }
  public float[][] getVx0() { return vX0; }
  public float[][] getVy0() { return vY0; }
  
  private float getDeltaVelocity(int indexX, int indexY)
  {
    return (cells[indexX + 1][indexY].getXMagnitude() - cells[indexX - 1][indexY].getXMagnitude() + cells[indexX][indexY+1].getYMagnitude() - cells[indexX][indexY-1].getYMagnitude()) * .5;
  }
  
  private float p(int indexX, int indexY)
  {
    return ((p(indexX - 1, indexY) + p(indexX + 1, indexY) + p(indexX, indexY - 1) + p(indexX, indexY + 1)) - cells[indexX][indexY].getDeltaVel()) * .25;
  }
  
  void lin_solve(int b, float[][] x, float[][] x0, float a, float c) {
  float cRecip = 1.0 / c;
  for (int k = 0; k < iter; k++) {
    for (int j = 1; j < resolution - 1; j++) {
      for (int i = 1; i < resolution - 1; i++) {
        x[i][j] =
          (x0[i][j]
          + a*(x[i+1][j]
          +x[i-1][j]
          +x[i][j+1]
          +x[i][j-1]
          )) * cRecip;
        }
      }
     set_bnd(b, x);
   }
 }
  
  void project(float[][] velocX, float[][] velocY, float[][] p, float[][] div) {
  for (int j = 1; j < resolution - 1; j++) {
    for (int i = 1; i < resolution - 1; i++) {
      div[i][j] = -0.5f*(
        velocX[i+1][j]
        -velocX[i-1][j]
        +velocY[i][j+1]
        -velocY[i][j-1]
        )/resolution;
      p[i][j] = 0;
    }
  }

  set_bnd(0, div); 
  set_bnd(0, p);
  //lin_solve(0, p, div, 1, 4);

  for (int j = 1; j < resolution - 1; j++) {
    for (int i = 1; i < resolution - 1; i++) {
      velocX[i][j] -= 0.5f * (p[i+1][j]
        -p[i-1][j]) * resolution;
      velocY[i][j] -= 0.5f * (p[i][j+1]
        -p[i][j-1]) * resolution;
    }
  }
  set_bnd(1, velocX);
  set_bnd(2, velocY);
 }


 void set_bnd(int b, float[][] x) {
    for (int i = 1; i < resolution - 1; i++) {
      x[i][0] = b == 2 ? -x[i][1] : x[i][1];
      x[i][resolution-1] = b == 2 ? -x[i][resolution-2] : x[i][resolution-2];
    }
    for (int j = 1; j < resolution - 1; j++) {
      x[0][j] = b == 1 ? -x[1][j] : x[1][j];
      x[resolution-1][j] = b == 1 ? -x[resolution-2][j] : x[resolution-2][j];
    }
  
    x[0][0] = 0.5f * (x[1][0] + x[0][1]);
    x[0][resolution-1] = 0.5f * (x[1][resolution-1] + x[0][resolution-2]);
    x[resolution-1][0] = 0.5f * (x[resolution-2][0] + x[resolution-1][1]);
    x[resolution-1][resolution-1] = 0.5f * (x[resolution-2][resolution-1] + x[resolution-1][resolution-2]);
  }
 }
