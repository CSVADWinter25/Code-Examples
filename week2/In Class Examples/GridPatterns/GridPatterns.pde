float offset = 0;
   float c;
int wX = 20;
int wY = 20;

void setup() {
  size(800, 800);
}

void draw() {
  background(0);
  offset = 0;
  for (int x = 0; x < width; x += wX) {
    for (int y = 0; y < height; y += wY) {

      c = x/wX + y/wY;

      if (sin(c * (mouseY * 0.005)) > sin(offset * (mouseX * 0.005))) {
        fill(0);
      } else {
        fill(255);
      }
      rect(x, y, wX, wY);
    }
    offset += 1;
  }
}
