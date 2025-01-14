import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float r;
float g = 0;
float b;
int s = 0;


void setup() {
  size(500, 500);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 6000);
}

void draw() {
  background(0);
  
  if (mousePressed) {
    s = 255;
  } else if (s > 0) {
    s -= 1;
  } else {
    s = 0;
  }
  
  r = map(mouseX,0,500,0,255);
  b = map(mouseY,0,500,255,0);
  
  fill(r,g,b,s);
  noStroke();
  circle(mouseX,mouseY,s);

  OscMessage myMessage = new OscMessage("/parameters");
  myMessage.add(mouseX); /* add an int to the osc message */
  myMessage.add(mouseY);
  myMessage.add(s);
  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}
