float circleWidth = 300;

void setup() {
  size(800, 800);
  strokeWeight(.5);
  background(0);
  stroke(255);
  noLoop();
  noFill();

  drawForm(width/2, height/2, 300);
}


void drawForm(float x, float y, float s) {
  drawSeed(x, y, s);
  if (s > 100) {

    drawForm(x + s * .8, y, s *.7);
    drawForm(x, y + s * .7, s *.7);
    drawForm(x - s * .8, y, s *.7);
    drawForm(x, y - s * .7, s *.7);
  }
}

void drawSeed(float x, float y, float s) {
 
  pushMatrix();
  
  translate(x, y);

  scale(s/100);
  circle (0, 0, circleWidth);

  circle (-circleWidth/5, 0, circleWidth/4);
  circle (circleWidth/5, 0, circleWidth/4);
  circle (0, -circleWidth/5, circleWidth/3);
  circle (0, circleWidth/5, circleWidth/3);

  popMatrix();
}
