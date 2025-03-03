import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int numPoints = 100;  // Number of points to create the circular shape
float radius = 150;   // Base radius of the circle
float noiseFactor = 2; // Maximum displacement amount
float noiseScale;
float[] displacement = new float[100];
float d;

void setup() {
  size(600, 600);

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  stroke(255);
  for (int i = 0; i < displacement.length; i++) {
    displacement[i] = random(noiseFactor);
  }
}

void draw() {
  background(0);
  translate(mouseX, mouseY);
  radius = map(mouseY, height, 0, 30, 5);
  noiseScale = constrain(map(mouseX, 0 + radius * 2, width - radius * 2, 0, 1), 0, 1);

  if (dist(mouseX, mouseY, pmouseX, pmouseY) > 0) {
    d = 255;
  } else if (d > 0) {
    d -= 10;
  } else if (d < 0) {
    d = 0;
  }
  fill(255, d);

  beginShape();
  for (int i = 0; i < numPoints; i++) {
    float angle = TWO_PI / numPoints * i;

    // Calculate base position of the point
    float x = cos(angle) * (radius + radius * displacement[i] * noiseScale) ;
    float y = sin(angle) * (radius + radius * displacement[i] * noiseScale);

    vertex(x, y);
  }
  endShape(CLOSE);

  OscMessage myMessage = new OscMessage("/parameters");
  myMessage.add(constrain(map(mouseX, 0 + radius * 2, width - radius * 2, 0, 1), 0, 1));
  myMessage.add(map(mouseY, 0, height, 1, 0));
  myMessage.add(map(d, 0, 255, 0, 1));
  oscP5.send(myMessage, myRemoteLocation);
}
