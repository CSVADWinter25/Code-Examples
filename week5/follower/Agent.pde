class Agent {
  PVector acceleration;
  PVector position;
  PVector velocity = new PVector(0,0);
  float size = 10;
  
  Agent(float positionX, float positionY) {
    position = new PVector(positionX, positionY);
  }
  
  void update() {
    PVector mousePosition = new PVector(mouseX,mouseY);
    PVector direction = mousePosition.sub(position);
    acceleration = direction.normalize();
    acceleration.mult(0.05);
    PVector rand = new PVector(random(2) - 1,random(2)- 1);
    rand.mult(.2);
    velocity.add(acceleration);
    velocity.add(rand);
    velocity.limit(2);
    position.add(velocity);
  }
  
  void display() {
    noStroke();
    fill(255);
    circle(position.x,position.y, 10);
  }
  
}
