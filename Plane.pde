public class Plane
{
  private float accX, accY, vX, vY, xPos, yPos, size;
  
  public Plane(float x, float y, float s)
  {
    xPos = x;
    yPos = y;
    
    size = s;
    
    vX = 0;
    vY = 0;
    
    accX = 0;
    accY = 0;
  }
  
  public void update()
  {    
    vX += accX;
    vY += accY;
    
    xPos += vX;
    yPos += vY;
    
    fill(255);
    stroke(0);
    ellipse(xPos, yPos, size/2, size/2); 
  }
  
  public void setAcceleratonX(float value) { accX = value;}
  public void setAccelerationY(float value) { accY = value;}
  
  public float getXPos() { return xPos; }
  public float getYPos() { return yPos; }
}
