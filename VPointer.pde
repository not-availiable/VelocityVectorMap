public class VPointer
{
  private float centerXPos, centerYPos, size;
  private float pointerXPos, pointerYPos, maxLength;
  private boolean isBuffer = true;
  private boolean paintRed = false;
  
  public VPointer(float cXPos, float cYPos, float s)
  {
    centerXPos = cXPos;
    centerYPos = cYPos;
    size = s;
    
    pointerXPos = centerXPos;
    pointerYPos = centerYPos;
  }
  
  //only gets called once
  public void initalize(float Length)
  {
    initalizePointerRandomly(Length);
    generateSquare();
  }
  
  void generateSquare()
  {
    rectMode(CENTER);
    fill(paintRed ? 0 : 255);
    rect(centerXPos, centerYPos, size, size);
    isBuffer = false;
  }
  
  void generatePointer()
  {
    line(centerXPos, centerYPos, pointerXPos, pointerYPos);
    ellipse(pointerXPos, pointerYPos, 2, 2);
  }
  
  public float getXMagnitude() { return !isBuffer ? pointerXPos - centerXPos : 0; }
  public float getYMagnitude() { return !isBuffer ? pointerYPos - centerYPos : 0; }
  
  
  //everything below is for testing purposes and will not funciton / be useful in the final implementation
  
  public void initalizePointerRandomly(float Length)
  {
    maxLength = Length;
    
    pointerXPos = centerXPos + (random(width) - centerXPos) * (maxLength/width);
    pointerYPos = centerYPos + (random(height) - centerYPos) * (maxLength/height);
    
    line(centerXPos, centerYPos, pointerXPos, pointerYPos);
    ellipse(pointerXPos, pointerYPos, 2, 2);
  }
  
  //only want to get the magnitude if it is a non-buffer tile.
  public float getXMagnitudeWithMouse(float Length) { return !isBuffer ? (mouseX - centerXPos) * (Length/width) : 0; }
  public float getYMagnitudeWithMouse(float Length) { return !isBuffer ? (mouseY - centerYPos) * (Length/height) : 0; }
  
  public void drawPointerWithMouse(float Length)
  {
    line(centerXPos, centerYPos, centerXPos + (mouseX - centerXPos) * (Length/width), centerYPos + (mouseY - centerYPos) * (Length/height));
    ellipse(centerXPos + (mouseX - centerXPos) * (Length/width), centerYPos + (mouseY - centerYPos) * (Length/height), 2, 2);
  }
  
  public void paintRed(boolean b) { paintRed = b; }
}
