Agent[] agents;
int count = 100;

void setup() {
  size(500, 500);
  agents = new Agent[count];
  for (int i =0; i < count; i++) {
    agents[i] = new Agent(random(width), random(height));
  }
  background(0);
}

void draw() {
  fill(0, 20);
  rect(0, 0, width, height);
  for (int i =0; i < count; i++) {
    agents[i].update();
    agents[i].display();
  }
}
