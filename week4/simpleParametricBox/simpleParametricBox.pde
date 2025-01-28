import controlP5.*;

ControlP5 cp5;

float sizeX = 100;
float sizeY = 100;
float sizeZ = 100;

void setup() {
  size(500, 500, P3D);
  cp5 = new ControlP5(this);

  cp5.addSlider("sizeX")
    .setPosition(10, 10)
    .setRange(0, 255)
    ;

  cp5.addSlider("sizeY")
    .setPosition(10, 20)
    .setRange(0, 255)
    ;

  cp5.addSlider("sizeZ")
    .setPosition(10, 30)
    .setRange(0, 255)
    ;

}

void draw() {
  background(0);
  noStroke();
  lights();
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.011);
  box(sizeX, sizeY, sizeZ);
  popMatrix();
}
