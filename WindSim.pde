Grid g;
Plane p;

//sets the number of tiles in the grid
//NOTE: the current code only supports square grids thus the single resolution variable
static public final int resolution = 40;
static public boolean mouseDown = false;

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
  background(255);
  g.update();
  p.setAcceleratonX(g.sampleAccelerationsX(p.getXPos(), p.getYPos()) * .005);
  p.setAccelerationY(g.sampleAccelerationsY(p.getXPos(), p.getYPos()) * .005);
  p.update();
}

void mousePressed()
{
  mouseDown = true;
}

void mouseReleased()
{
  mouseDown = false;
}
