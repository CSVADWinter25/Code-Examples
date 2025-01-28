import controlP5.*;

ControlP5 cp5;

float xSize = 100;
float ySize = 100;
float zSize = 100;
int divs = 6;


void setup() {
  size(500, 500, P3D);
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

  cp5.addSlider("zSize")
    .setPosition(10, 40)
    .setRange(0, 255)
    ;

cp5.addSlider("divs")
     .setPosition(10,55)
     .setRange(1,11)
     .setNumberOfTickMarks(11)
     ;
}

void draw() {
  background(0);
  lights();

  pushMatrix();

  translate(width/2, height/2, 0); //translate following objects to center
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.012);
  rotateZ(frameCount * 0.013);

  for (int i = 0; i <= divs; i++) {
    
    pushMatrix();
    rotateX(PI/divs * i);
    box(xSize, ySize, zSize);
    popMatrix();
    /*
    pushMatrix();
    rotateY(PI/divs * i);
    box(ySize, xSize, zSize);
    popMatrix();
    */
  }
  

  popMatrix();
}
