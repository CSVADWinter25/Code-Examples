class Ball {

  String address;
  PVector position;
  PVector velocity;
  float radius = random(10,100);
  float a = 0;
  float r = random(255);
  float g = random(255);
  float b = random(255);

  Ball(String address) {
    this.address = address;
    position = new PVector(random(radius,width-radius), random(radius,height-radius));
    velocity = new PVector(random(-2, 2), random(-2, 2));
  }

  void update() {
    position.add(velocity);
    checkEdges();
    if (a != 0) {
      a -= 5;
    }
    OscMessage myMessage = new OscMessage(address);
    myMessage.add("/amplitude");
    myMessage.add(a);
    oscP5.send(myMessage, myRemoteLocation);
  }

  void display() {
    stroke(255);
    fill(r,g,b, a);
    circle(position.x, position.y, radius * 2);
  }

  void checkEdges() {
    if (position.x > width - radius) {
      velocity.x *= -1;
      OscMessage myMessage = new OscMessage(address);
      myMessage.add("/bounce");
      myMessage.add("right");
      oscP5.send(myMessage, myRemoteLocation);
      a = 255;
    }
    if (position.x < radius) {
      velocity.x *= -1;
      OscMessage myMessage = new OscMessage(address);
      myMessage.add("/bounce");
      myMessage.add("left");
      oscP5.send(myMessage, myRemoteLocation);
      a = 255;
    }
    if (position.y > height - radius) {
      velocity.y *= -1;
      OscMessage myMessage = new OscMessage(address);
      myMessage.add("/bounce");
      myMessage.add("bottom");
      oscP5.send(myMessage, myRemoteLocation);
      a = 255;
    }
    if (position.y < radius) {
      velocity.y *= -1;
      OscMessage myMessage = new OscMessage(address);
      myMessage.add("/bounce");
      myMessage.add("top");
      oscP5.send(myMessage, myRemoteLocation);
      a = 255;
    }
  }
}
