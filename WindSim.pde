Grid g;


void setup()
{
  size(700, 700);
  g = new Grid(new VPointer[40][40]);
}

void draw()
{
  background(0);
  g.update();
}
