Grid g;
Plane p;

private int resolution = 25;

void setup()
{
  size(700, 700);
  g = new Grid(new VPointer[resolution + 2][resolution + 2]);
  p = new Plane(width/2, height/2, 40);
}

void draw()
{
  background(0);
  g.update();
  p.setAcceleratonX(g.sampleAccelerationsX(p.getXPos(), p.getYPos()) * .005);
  p.setAccelerationY(g.sampleAccelerationsY(p.getXPos(), p.getYPos()) * .005);
  p.update();
}
