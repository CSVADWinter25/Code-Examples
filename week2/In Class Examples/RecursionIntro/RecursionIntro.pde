void setup() {
  size(500, 500);
  noLoop();
  background(0);
  noFill();
  stroke(255);
  recursiveCircles(500);
}

void recursiveCircles(float s) {
  circle(width/2, height/2, s);
  if (s > 20) {
    s *= 0.9;
    recursiveCircles(s);
  }
}
