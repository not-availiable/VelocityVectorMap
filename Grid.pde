public class Grid
{
  public VPointer[][] cells;
  
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
        float size = width/(float)(cells.length - 2);
        cells[i][j] = new VPointer((height/(float)(cells.length-2)) * (float)(i-1) + (float)size/2, (width/(float)(cells[i].length-2)) * (float)(j-1) + (float)size/2, size);
        cells[i][j].initalize(pointerLength);
        //vX[i][j] = cells[i][j].getXMagnitude();
        //vY[i][j] = cells[i][j].getYMagnitude();
        //vX0 = vX;
        //vY0 = vY;
      }
    }
  }
  
  public void update()
  {
    for (int i = 1; i < cells.length - 1; i++)
    {
      for (int j = 1; j < cells[i].length - 1; j++)
      {
        //adding buffer cells to not have out of index array errors
        //if (i != 0 || i != cells.length || j != 0 || j != cells.length) cells[i][j].drawPointerWithMouse(pointerLength);
        if (i != 0 || i != cells.length || j != 0 || j != cells.length) cells[i][j].generatePointer();
        //if (i != 0 || i != cells.length || j != 0 || j != cells.length) cells[i][j].generateSquare();
      }
    }
    
    advect();
    
    //bad code ... again
    
    /*for (int i = 1; i < cells.length - 1; i++)
    {
      for (int j = 1; j < cells[i].length - 1; j++)
      {
        //adding buffer cells to not have out of index array errors
        if (i != 0 || i != cells.length || j != 0 || j != cells.length) cells[i][j].paintRed(false);
      }
    }
    */
  }
  
  //gets an accurate representation of the xMagnitudes of the four nearest pointers to the player using linear interpolation
  public float sampleAccelerationsX(float posX, float posY)
  { 
    float size = width / (float) cells.length;
    
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
  public float sampleAccelerationsY (float posX, float posY)
  { 
    float size = width / (float) cells.length;
    
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
  
  int num = 0;
  int num2 = 0;
  private void advect()
  {
    float[][] magXStorage = new float[cells.length][cells.length];
    float[][] magYStorage = new float[cells.length][cells.length];
    
    for (int i = 2; i < cells.length - 1; i++)
    {
      for (int j = 1; j < cells[i].length - 1; j++)
      {
        float targetX = cells[i][j].getCenterXPos() + cells[i][j].getXMagnitude();
        float targetY = cells[i][j].getCenterYPos() + cells[i][j].getYMagnitude();
        
        //println(targetX);
        
        if (!(targetX < 0 || targetY < 0 || targetX > width || targetY > width))
        {
          float size = width / (float) cells.length;
          
          float actualWidth = width + 2 * size;
          
          float actualSize = actualWidth / cells.length;
          
          float xInput = targetX / actualSize;
          int xIndex = floor(xInput);
          
          float yInput = targetY / actualSize;
          int yIndex = floor(yInput);
          
          float xRemainder = xInput - xIndex;
          float yRemainder = yInput - yIndex;
          
          float zX1 = lerp(cells[xIndex][yIndex].getXMagnitude(), cells[xIndex+1][yIndex].getXMagnitude(), abs((xRemainder <= .5 ? -1 : 0) + xRemainder));
          float zX2 = lerp(cells[xIndex][yIndex+1].getXMagnitude(), cells[xIndex+1][yIndex+1].getXMagnitude(), abs((xRemainder <= .5 ? -1 : 0) + xRemainder));
          
          float zY1 = lerp(cells[xIndex][yIndex].getYMagnitude(), cells[xIndex+1][yIndex].getYMagnitude(), abs((xRemainder <= .5 ? -1 : 0) + xRemainder));
          float zY2 = lerp(cells[xIndex][yIndex+1].getYMagnitude(), cells[xIndex+1][yIndex+1].getYMagnitude(), abs((xRemainder <= .5 ? -1 : 0) + xRemainder));
          
          magXStorage[xRemainder <= .5 ? xIndex : xIndex+1][yRemainder <= .5 ? yIndex : yIndex+1] = lerp(zX1, zX2, abs((yRemainder <= .5 ? -1 : 0) + yRemainder));
          magYStorage[xRemainder <= .5 ? xIndex : xIndex+1][yRemainder <= .5 ? yIndex : yIndex+1] = lerp(zY1, zY2, abs((yRemainder <= .5 ? -1 : 0) + yRemainder));
          
          
          
          
          /*
          magXStorage[xIndex][yIndex] = lerp(zX1, zX2, yRemainder);
          magYStorage[xIndex][yIndex] = lerp(zY1, zY2, yRemainder);
          
          zX1 = lerp(cells[xIndex][yIndex].getXMagnitude(), cells[xIndex+1][yIndex].getXMagnitude(), 1-xRemainder);
          zX2 = lerp(cells[xIndex][yIndex+1].getXMagnitude(), cells[xIndex+1][yIndex+1].getXMagnitude(), 1-xRemainder);
          
          zY1 = lerp(cells[xIndex][yIndex].getYMagnitude(), cells[xIndex+1][yIndex].getYMagnitude(), 1-xRemainder);
          zY2 = lerp(cells[xIndex][yIndex+1].getYMagnitude(), cells[xIndex+1][yIndex+1].getYMagnitude(), 1-xRemainder);
          
          magXStorage[xIndex+1][yIndex] = lerp(zX1, zX2, yRemainder);
          magYStorage[xIndex+1][yIndex] = lerp(zY1, zY2, yRemainder);
          
          zX1 = lerp(cells[xIndex][yIndex].getXMagnitude(), cells[xIndex+1][yIndex].getXMagnitude(), xRemainder);
          zX2 = lerp(cells[xIndex][yIndex+1].getXMagnitude(), cells[xIndex+1][yIndex+1].getXMagnitude(), xRemainder);
          
          zY1 = lerp(cells[xIndex][yIndex].getYMagnitude(), cells[xIndex+1][yIndex].getYMagnitude(), xRemainder);
          zY2 = lerp(cells[xIndex][yIndex+1].getYMagnitude(), cells[xIndex+1][yIndex+1].getYMagnitude(), xRemainder);
          
          magXStorage[xIndex][yIndex+1] = lerp(zX1, zX2, 1-yRemainder);
          magYStorage[xIndex][yIndex+1] = lerp(zY1, zY2, 1-yRemainder);
                    
          zX1 = lerp(cells[xIndex][yIndex].getXMagnitude(), cells[xIndex+1][yIndex].getXMagnitude(), 1-xRemainder);
          zX2 = lerp(cells[xIndex][yIndex+1].getXMagnitude(), cells[xIndex+1][yIndex+1].getXMagnitude(), 1-xRemainder);
          
          zY1 = lerp(cells[xIndex][yIndex].getYMagnitude(), cells[xIndex+1][yIndex].getYMagnitude(), 1-xRemainder);
          zY2 = lerp(cells[xIndex][yIndex+1].getYMagnitude(), cells[xIndex+1][yIndex+1].getYMagnitude(), 1-xRemainder);                    
                    
          magXStorage[xIndex+1][yIndex+1] = lerp(zX1, zX2, 1-yRemainder);
          magYStorage[xIndex+1][yIndex+1] = lerp(zY1, zY2, 1-yRemainder);
          */
          
          if (xIndex > j && yIndex > i) {
            //cells[i][j].paintRed(true);
            //println("please", num);
            num++;
          }
          if (xIndex < j) {
            //println("dont", num2);
            //println(xIndex, j, yIndex, i);
            cells[i][j].paintRed(true);
            num2++;
          }
        }
      }
    }
     
    for (int i = 1; i < cells.length - 1; i++)
    {
       for (int j = 1; j < cells[i].length - 1; j++)
       {
          //float a = cells[i][j].getXMagnitude();
          //float b = cells[i][j].getYMagnitude();
         
          cells[i][j].setXMagnitude(cells[i][j].getXMagnitude() + magXStorage[i][j]);
          cells[i][j].setYMagnitude(cells[i][j].getYMagnitude() + magYStorage[i][j]);

          
          //cells[i][j].setXMagnitude(magXStorage[i][j]);
          //cells[i][j].setYMagnitude(magYStorage[i][j]);
       }
    }
  }
  
  /*for (int i = cells.length - 1; i > 1; i--)
    {
       for (int j = cells.length - 1; j > 1; j--)
       {
          cells[i][j].setXMagnitude(cells[i][j].getXMagnitude() + magXStorage[i][j]);
          cells[i][j].setYMagnitude(cells[i][j].getYMagnitude() + magYStorage[i][j]);
       }
    }
  }*/
}
