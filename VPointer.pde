public class VPointer
{
  private float centerXPos, centerYPos, size;
  private boolean isBuffer = true;
  private boolean paintRed = false;
  
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
    fill(paintRed ? 0 : 255);
    rect(centerXPos, centerYPos, size, size);
    isBuffer = false;
  }
  
  public float getXMagnitude(float Length) { return !isBuffer ? (mouseX - centerXPos) * (Length/width) : 0; }
  public float getYMagnitude(float Length) { return !isBuffer ? (mouseY - centerYPos) * (Length/height) : 0; }
  
  //for testing purposes
  public void drawPointerWithMouse(float Length)
  {
    line(centerXPos, centerYPos, centerXPos + (mouseX - centerXPos) * (Length/width), centerYPos + (mouseY - centerYPos) * (Length/height));
    ellipse(centerXPos + (mouseX - centerXPos) * (Length/width), centerYPos + (mouseY - centerYPos) * (Length/height), 2, 2);
  }
  
  public void paintRed(boolean b) { paintRed = b; }
}
