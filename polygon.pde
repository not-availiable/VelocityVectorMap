public class polygon {

  float[][] p;
  float cx, cy;

  polygon( float[][] tempPoints, float centerX, float centerY ) {
    p = tempPoints;
    cx = centerX;
    cy = centerY;
  }

  void display() {
    fill(255,240,0);
    triangle(p[0][0], p[1][0], p[0][p[0].length-1], p[1][p[1].length-1], cx, cy); //covers wraparound
    for (int i = 0; i < p[0].length-1; i++) {
      triangle(p[0][i], p[1][i], p[0][i+1], p[1][i+1], cx, cy);
    }
  }

  boolean update(float x, float y) {

    if (d.DetectTriangle(p[0][0], p[1][0], p[0][p[0].length-1], p[1][p[1].length-1], cx, cy, x, y)) {
      fill(255, 0, 0);
      triangle(p[0][0], p[1][0], p[0][p[0].length-1], p[1][p[1].length-1], cx, cy);
      return (true);
    } //covers wraparound again

    for ( int i = 0; i < p[0].length-1; i++) {
      if (d.DetectTriangle(p[0][i], p[1][i], p[0][i+1], p[1][i+1], cx, cy, x , y)) {
        fill(255, 0, 0);
        triangle(p[0][i], p[1][i], p[0][i+1], p[1][i+1], cx, cy);
        return (true);
      }
    }
    return (false);
  }
}
