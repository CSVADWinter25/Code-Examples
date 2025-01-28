float xPosition;
float yPosition;
float xSize;
float ySize;
float rotationRate;

void setup() {
  size(500, 500);
  xPosition = width/2;
  yPosition = height/2;
  xSize = 300;
  ySize = 10;
  rotationRate = 0.005;
}

void draw() {
  background(0);
  pushMatrix();
  noStroke();
  fill(255);
  rectMode(CENTER);
  translate(xPosition, yPosition);
  rotate(frameCount * rotationRate);
  rect(0, 0, xSize, ySize);
  popMatrix();
}
