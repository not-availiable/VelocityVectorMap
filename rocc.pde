public class Rocc {
  
  private polygon rock;
  private float accX, accY, vX, vY, xPos, yPos;
  
  public Rocc(float x, float y){
   // super(x, y, s); 
    
    xPos = x;
    yPos = y;
    
    vX = 2;
    vY = -2;
    
    accX = 0;
    accY = 0;
    
    rock = new polygon (new float[][] {{xPos   , xPos+20, xPos+50, xPos+30, xPos+40, xPos   , xPos-40, xPos-30, xPos-50, xPos-20}, //star!
                                       {yPos+50, yPos+30, yPos+30, yPos-20, yPos-50, yPos-30, yPos-50, yPos-20, yPos+30, yPos+30}},
                                       xPos, yPos);
  }
  
  
  public void update(float x, float y){
    
    if(xPos < 20 || xPos > width - 20){ //bounce off walls
      vX = vX*-1;
    }
    if(yPos < 20 || yPos > width - 20){
      vY = vY*-1;
    }
    
    vX += accX;
    vY += accY;
   
    
    xPos += vX;
    yPos += vY;
    //println(xPos);
    rock.display();
     rock = new polygon (new float[][] {{xPos  , xPos+20, xPos+50, xPos+30, xPos+42, xPos   , xPos-42, xPos-30, xPos-50, xPos-20},
                                       {yPos-50, yPos-20, yPos-20, yPos+12, yPos+40, yPos+25, yPos+40, yPos+12, yPos-20, yPos-20}},
                                       xPos, yPos);
    
    
  }
  
  public boolean playerGoByeBye(float x, float y) {
    if (rock.update(x, y)== true){
      return true;
  }
  return false;
}


  public void setAcceleratonX(float value)  { accX = value;}
  public void setAccelerationY(float value) { accY = value;}
  
  public float getXPos() { return xPos; }
  public float getYPos() { return yPos; }
}
