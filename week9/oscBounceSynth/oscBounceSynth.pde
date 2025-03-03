import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Ball ball1;
Ball ball2;
Ball ball3;

void setup() {
  size(400, 400);

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  ball1 = new Ball("/ball_1");
  ball2 = new Ball("/ball_2");
  ball3 = new Ball("/ball_3");
}

void draw() {
  background(0);

  ball1.update();
  ball1.display();
  ball2.update();
  ball2.display();
  ball3.update();
  ball3.display();
}
