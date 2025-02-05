int xSize = 25;
int ySize = 25;

void setup() {
  size(500, 500);
  for (int i = 0; i < width/xSize; i++) {
    for (int j = 0; j < height/ySize; j++) {
      int c = (i + j) % 2 * 255;
      gridCell(i*xSize, j*ySize, c);
    }
  }
}

void gridCell(float x, float y, int c) {
  pushMatrix(); // saves the current coordinate system to the stack (enables controlling the scope of matrix transformations)
  translate(x + xSize/2, y + ySize/2);  // translates the origin of the coordinate system to a new position
  fill(c);
  rectMode(CENTER); //draw from centerpoint rather than top-left corner
  rect(0, 0, xSize, ySize); // draws the rectangle at the origin of the  coordinate system
  popMatrix(); // restores the prior, pre-translated coordinate system  (origin is back to 0, 0)
}
