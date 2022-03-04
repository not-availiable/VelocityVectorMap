public class Detection
{
  public boolean DetectTriangle(float aX, float aY, float bX, float bY, float cX, float cY, float px, float py)
  {
    return Area(aX, aY, bX, bY, cX, cY) - (Area(aX, aY, bX, bY, px, py) + Area(bX, bY, cX, cY, px, py) + Area(cX, cY, aX, aY, px, py)) <= 2 && Area(aX, aY, bX, bY, cX, cY) - (Area(aX, aY, bX, bY, px, py) + Area(bX, bY, cX, cY, px, py) + Area(cX, cY, aX, aY, px, py)) >= -1;
  }
  
  public float Area(float aX, float aY, float bX, float bY, float cX, float cY)
  { 
    float a = dist(aX, aY, bX, bY);
    float b = dist(bX, bY, cX, cY);
    float c = dist(cX, cY, aX, aY);
    
    float p = (a + b + c)/2;
    
    return (float)Math.round(Math.sqrt(p * ((p-a) * (p-b)) * (p-c)));
  }
}
