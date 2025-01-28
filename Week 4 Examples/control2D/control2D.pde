import controlP5.*;

ControlP5 cp5;

float xSize = 100;
float ySize = 100;
float rotation = 0;

void setup() {
  size(500, 500);
  noStroke();
  cp5 = new ControlP5(this);

  cp5.addSlider("xSize")
    .setPosition(10, 10)
    .setRange(0, 255)
    ;

  cp5.addSlider("ySize")
    .setPosition(10, 25)
    .setRange(0, 255)
    ;

  cp5.addSlider("rotation")
    .setPosition(10, 40)
    .setRange(0, 2)
    ;
}

void draw() {
  background(0);

  pushMatrix();

  translate(width/2, height/2); //translate following objects to center
  rotate(PI * rotation);
  rectMode(CENTER);
  rect(0, 0, xSize, ySize);
  popMatrix();
}
