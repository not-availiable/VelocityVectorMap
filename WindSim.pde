Grid g;
Plane p;

//sets the number of tiles in the grid
//NOTE: the current code only supports square grids thus the single resolution variable
static public final int resolution = 50;
static public final int iter = 16;

void setup()
{
  size(700, 700);
  g = new Grid(new VPointer[resolution + 2][resolution + 2]);
  p = new Plane(width/2, height/2, 40);
  background(0);
  g.update();
  
 
}

void draw()
{
  delay(2000);
  
  background(0);
  p.setAcceleratonX(g.sampleAccelerationsX(p.getXPos(), p.getYPos()) * .005);
  p.setAccelerationY(g.sampleAccelerationsY(p.getXPos(), p.getYPos()) * .005);
  g.update();
  p.update();
  
  g.project(g.getVx(), g.getVy(), g.getVx0(), g.getVy0());
  g.project(g.getVy(), g.getVx(), g.getVy0(), g.getVx0());
  
  //g.project(g.getVx0(), g.getVy0(), g.getVx(), g.getVy());
  
  //g.project(g.getVy0(), g.getVx0(), g.getVy0(), g.getVx0());
  //g.project(g.getVx0(), g.getVy0(), g.getVx(), g.getVy());
  
  for (int i = 0; i < g.cells.length; i++)
  {
    for (int j = 0; j < g.cells.length; j++)
    {
      g.cells[i][j].setXMagnitude(g.getVx0()[i][j] - g.getVx()[i][j] * 100);
      g.cells[i][j].setYMagnitude(g.getVy0()[i][j] - g.getVy()[i][j] * 100);
    }
  }
  g.update();
}
