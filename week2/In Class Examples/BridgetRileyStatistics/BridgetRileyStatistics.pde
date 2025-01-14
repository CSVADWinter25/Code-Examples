int dX = 25;
int dY = 25;

void setup() {
  size(500, 500);
  background(255);
  fill(0);

  for (int x = 0; x <= width/dX; x++) {
    for (int y = 0; y <= height/dY; y++) {
      float r = random(100);
      if (r >= 73 && r < 84) {
        drawCell(x * dX, y * dY, 5);
      } else if (r >= 84 && r < 94) {
        drawCell(x * dX, y * dY, 10);
      } else if (r >= 94) {
        drawCell(x * dX, y * dY, 20);
      } 
      
    }
  }
}

void drawCell(float x, float y, float s) {
  pushMatrix(); // saves the current coordinate system to the stack (enables controlling the scope of matrix transformations)
  translate(x+dX/2, y+dY/2); // translates the origin of the coordinate system to a new position
  circle(0, 0, s); // draws the cicrle at the origin of the  coordinate system
  popMatrix(); // restores the prior, pre-translated coordinate system  (origin is back to 0, 0)
}
