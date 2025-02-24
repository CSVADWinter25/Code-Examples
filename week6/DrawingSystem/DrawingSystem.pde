DrawTool tool = new DrawTool();

import controlP5.*;

ControlP5 cp5;

void setup() {
  size(500, 500);
  cp5 = new ControlP5(this);
  background(255);
  //pX = mouseX;
  //pY = mouseY;
}

void draw() {
  tool.randomDisplacement(10);
  //tool.modSize(1.);
  tool.randomSize(0.1);
  //tool.velocity();
  tool.update();
  if (mousePressed == true) {
    tool.style("MULTILINES");
  }
  tool.updateHistory();
}
