public class AsteroidBelt {
  ArrayList<Rocc> asteroids;
  float time, sX, sY;
  
  AsteroidBelt(float startX, float startY){
    asteroids = new ArrayList<Rocc>();
    sX = startX;
    sY = startY;
    asteroids.add(new Rocc(sX,sY));
    time = 0;
  }
  
  void run(float bX, float bY){
   
    if (time%120 == 0){
     asteroids.add(new Rocc(sX,sY));
    }
    for(int i = 0; i < asteroids.size(); i++){
      asteroids.get(i).update(bX,bY); 
      asteroids.get(i).setAcceleratonX(g.sampleAccelerationsX(asteroids.get(i).getXPos(), asteroids.get(i).getYPos()) * .02);
      asteroids.get(i).setAccelerationY(g.sampleAccelerationsY(asteroids.get(i).getXPos(), asteroids.get(i).getYPos()) * .02);
      if(asteroids.get(i).playerGoByeBye(bX,bY)){
        playerGoDieDie();
      }
    }
    time++;
    
  }
  
  public void playerGoDieDie(){
     die = true;
  }
  
}
