int xSize = 25;
int ySize = 25;

void setup() {
  size(500, 500);
  for (int i = 0; i < width/xSize; i++) {
    for (int j = 0; j < height/ySize; j++) {
      int c = 255; //(i + j) % 2 * 255;
      gridCell(i*xSize, j*ySize, c);
    }
  }
}

void gridCell(float x, float y, int c) {
  pushMatrix();
  translate(x + xSize/2, y + ySize/2);
  fill(c);
  rectMode(CENTER);
  rect(0, 0, xSize, ySize);
  popMatrix();
}
