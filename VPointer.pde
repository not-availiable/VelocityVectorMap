public class VPointer
{
  private float centerXPos, centerYPos, size;
  private float pointerXPos, pointerYPos, maxLength;
  private boolean isBuffer = true;
  private boolean paintRed = false;
  
  private float windDecay = .53;
  //private float windDecay = 1.2;
  
  private float mouseX0 = mouseX;
  private float mouseY0 = mouseY;
  private float magConst = 1;
  
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
    generateSquare();
    //initalizePointerRandomly(Length);
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
    float magX = pointerXPos - centerXPos;
    float magY = pointerYPos - centerYPos;
    stroke(255 - (int)(255/(1 + Math.pow(exp(1.0), 4 + (-.5 * sqrt(magX * magX + magY * magY))))), (int)(255/(1 + Math.pow(exp(1.0), 4 + (-.5 * sqrt(magX * magX + magY * magY))))), 0);
    fill(255 - (int)(255/(1 + Math.pow(exp(1.0), 4 + (-.5 * sqrt(magX * magX + magY * magY))))), (int)(255/(1 + Math.pow(exp(1.0), 4 + (-.5 * sqrt(magX * magX + magY * magY))))), 0);
    line(centerXPos, centerYPos, pointerXPos, pointerYPos);
    ellipse(pointerXPos, pointerYPos, 2, 2);
    stroke(0);
    
    decayVelocity();
    addVelocityBrush();
  }
  
  void decayVelocity()
  {
    setXMagnitude(getXMagnitude() * windDecay);
    setYMagnitude(getYMagnitude() * windDecay);
  }
  
  public float getXMagnitude() { return !isBuffer ? pointerXPos - centerXPos : 0; }
  public float getYMagnitude() { return !isBuffer ? pointerYPos - centerYPos : 0; }
  public float getCenterXPos() { return centerXPos; }
  public float getCenterYPos() { return centerYPos; }
  
  public void setXMagnitude(float value) { pointerXPos = value + centerXPos; }
  public void setYMagnitude(float value) { pointerYPos = value + centerYPos; }

  public void addVelocityBrush()
  {
    if (mouseDown)
    {
      float r = min(dist(mouseX0, mouseY0, mouseX, mouseY), 100);
      
      
      //distance between old mouse position and origin of vector
      float v1 = dist(mouseX0, mouseY0, centerXPos, centerYPos);
      
      
      if (r - v1 >= 0)
      {
        float mag = (r - v1) * magConst;
        float theta = atan2((mouseY - mouseY0), (mouseX - mouseX0));
        
        setXMagnitude(mag * cos(theta));
        setYMagnitude(mag * sin(theta));
      }
    }
    mouseX0 = mouseX;
    mouseY0 = mouseY;
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
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
