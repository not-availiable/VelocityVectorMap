public class VPointer
{
  private float centerXPos, centerYPos, size;
  
  public VPointer(float cXPos, float cYPos, float s)
  {
    centerXPos = cXPos;
    centerYPos = cYPos;
    size = s;
  }
  
  //don't know if we'll need this yet
  /*
  public void initalize()
  {
    rect(centerXPos - size * .5, centerYPos - size * .5, centerXPos + size * .5, centerYPos + size * .5);
  }
  */
  
  public void update()
  {
    rectMode(CENTER);
    rect(centerXPos, centerYPos, size, size);
  }
  
  public void drawPointer(float Length)
  {
    line(centerXPos, centerYPos, centerXPos + (mouseX - centerXPos) * (Length/width), centerYPos + (mouseY - centerYPos) * (Length/height));
  }
}
