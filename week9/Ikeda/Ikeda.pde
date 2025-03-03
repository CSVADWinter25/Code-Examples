import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int numLines;
ArrayList<Integer> lines;
ArrayList<Integer> linesB;

void setup() {
  size(400, 600); // Set canvas size
  frameRate(240);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  numLines = height/10; // Number of lines based on canvas height
  lines = new ArrayList<Integer>();
  linesB = new ArrayList<Integer>();

  // Initialize with random black or white lines
  for (int i = 0; i < numLines; i++) {
    lines.add(random(1) > 0.5 ? 0 : 255);
    linesB.add(random(1) > 0.5 ? 0 : 255);
  }
}

void draw() {
  background(200);

  // Shift lines upward
  for (int i = 0; i < lines.size(); i++) {
    stroke(lines.get(i));
    strokeWeight(10);
    line(0, i*10, width/2, i*10);
  }
  for (int i = 0; i < linesB.size(); i++) {
    stroke(linesB.get(i));
    strokeCap(0);
    strokeWeight(10);
    line(width/2, i*10, width, i*10);
  }

  // Remove the top line and add a new random line at the bottom
  lines.remove(0);
  linesB.remove(linesB.size()-1);
  float b = random(2);
  int c = random(b) < 0.5 ? 0 : 255;
  lines.add(c);
  int c2 = random(b) < 0.5 ? 0 : 255;
  linesB.add(0, c2);
  OscMessage myMessage = new OscMessage("/color");
  myMessage.add(c);
  myMessage.add(c2);
  oscP5.send(myMessage, myRemoteLocation);
}
