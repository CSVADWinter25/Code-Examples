color[] colors = new color[18];
int dW = 40;
int dH = 40;

color c;
void setup() {
  size(800, 800);
  noStroke();

  for (int i = 0; i < 18; i++) {
    float r = random(255);
    float g = random(255);
    float b = random(255);
    colors[i] = color(r, g, b);
  }

  for (int x = 0; x < width/dW; x++) {
    for (int y = 0; y < height/dH; y++) {
      if (random(1) > 0.5) {
        c = color(255);
      } else {
        c = colors[int(random(18))];
      }
      drawCell(x * dW, y * dH, c);
    }
  }
}

void drawCell(float x, float y, color c) {
  pushMatrix(); // saves the current coordinate system to the stack (enables controlling the scope of matrix transformations)
  translate(x+dW/2, y+dH/2); // translates the origin of the coordinate system to a new position
  fill(c);
  rectMode(CENTER); // draws the center of the rectangle at the coordinates specified (as opposed to the top left corner of the rectangle -> default draw mode)
  rect(0, 0, dW, dH); // draws the rectangle at the origin of the rotated coordinate system (rW/2, y+rH/2)
  popMatrix(); // restores the prior, pre-translated coordinate system  (origin is back to 0, 0)
}
