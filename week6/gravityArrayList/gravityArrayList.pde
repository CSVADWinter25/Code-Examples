ArrayList<Ball> balls = new ArrayList<Ball>();

float xVel;
float yVel;

void setup() {
  size (500, 500);
  //b = new Ball(width/2., height/2.);
}

void draw() {
  background(0);
  xVel = mouseX - pmouseX;
  yVel = mouseY - pmouseY;
  
  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    ball.display();
    ball.update();
  }
}

void mousePressed () {
  balls.add(new Ball(mouseX, mouseY, xVel, yVel));
}
