import controlP5.*;
ControlP5 cp5;

int cubeSize = 100;
int gapSize = 10;
float noiseAmount = 0;
int spacing = 110;
int xCount = 10;
int yCount = 10;
int zCount = 10;
float xNoise;
float yNoise;
float zNoise;



void setup() {
  size(500, 500, P3D);
  noStroke();
  cp5 = new ControlP5(this);



  cp5.addSlider("cubeSize")
    .setPosition(10, 10)
    .setRange(0, 255)
    ;

  cp5.addSlider("gapSize")
    .setPosition(10, 25)
    .setRange(0, 255)
    ;

  cp5.addSlider("noiseAmount")
    .setPosition(10, 40)
    .setRange(0, 200)
    ;

  cp5.setAutoDraw(true);
}

void draw() {
  background(0);
  
  lights();
  spacing = cubeSize + gapSize;
  pushMatrix();
  translate(250, 250, -600);
  rotateY(frameCount * 0.001);
  for (int i = 0; i < xCount; i++) {
    for (int j = 0; j < xCount; j++) {
      for (int k = 0; k < xCount; k++) {

        pushMatrix();
        xNoise = noise(i * 0.2 + frameCount * 0.003, j * 0.2, k * 0.2); 
        yNoise = noise(i * 0.2 + 10000 + frameCount * 0.003, j * 0.2 + 10000, k * 0.2 + 10000); 
        zNoise = noise(i * 0.2 + 20000 + frameCount * 0.003, j * 0.2 + 20000, k * 0.2 + 20000); 
        translate(i * spacing - (xCount * spacing / 2) + ((xNoise - 0.5) * noiseAmount), j * spacing - (yCount * spacing / 2) + ((yNoise - 0.5) * noiseAmount), k * spacing - (zCount * spacing / 2) + ((zNoise - 0.5) * noiseAmount));
 
        box(xNoise * xNoise * noiseAmount, yNoise * yNoise * noiseAmount, zNoise * zNoise * noiseAmount);
        popMatrix();
      }
    }
  }
  popMatrix();
}
