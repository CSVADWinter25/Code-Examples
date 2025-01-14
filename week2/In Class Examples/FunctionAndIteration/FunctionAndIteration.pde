void setup() {
  size(500, 500);
  background(0);
  noStroke();

  for (int i = 0; i < height; i++) {
    fill((i/500.) * 255);
    threeCircles(width/2, i, i);
  }
}

void draw() {
}

void threeCircles(float x, float y, float s) {
  circle(x, y, s);
  circle(x - s, y, s/2);
  circle(x + s, y, s/2);
  circle(x - s * 2, y, s/4);
  circle(x + s * 2, y, s/4);
  circle(x - s * 3, y, s/6);
  circle(x + s * 3, y, s/6);
  circle(x - s * 4, y, s/8);
  circle(x + s * 4, y, s/8);
}
