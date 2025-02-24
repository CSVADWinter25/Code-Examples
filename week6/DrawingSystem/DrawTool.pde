class DrawTool {

  PVector current;
  PVector previous;
  float baseSize = 10;
  float rSize = 0;
  float velocityMag = 0;
  float modSize = 0;
  boolean modSizeCalled = false;
  boolean rSizeCalled = false;
  boolean velocityCalled = false;
  boolean displacementCalled = false;

  DrawTool() {
    current = new PVector(mouseX, mouseY);
    previous = new PVector(mouseX, mouseY);
  }

  void randomDisplacement(float amount) {
    float xOffset = (random(amount) - amount/2);
    float yOffset = (random(amount) - amount/2);
    current.x = mouseX + xOffset;
    current.y = mouseY + yOffset;
    displacementCalled = true;
  }

  void randomSize(float step) {
    rSize = noise(frameCount * step);
    rSizeCalled = true;
  }

  void modSize(float rate) {
    modSize = sin(frameCount / 30. * rate) * 0.5 + 0.5;
    modSizeCalled = true;
  }

  void update() {
    if (!displacementCalled) {
      current.x = mouseX;
      current.y = mouseY;
    }
  }

  void style(String styleType) {
    if (!velocityCalled) {
      velocityMag = 1;
    }
    if (!rSizeCalled) {
      rSize = 1;
    }
    if (!modSizeCalled) {
      modSize = 1;
    }
    float size = baseSize * rSize * velocityMag * modSize;



    switch(styleType) {
    case "DOTS":
      fill(0);
      noStroke();
      circle(current.x, current.y, size);
      break;
    case "LINES":
      strokeWeight(size);
      stroke(255, 0, 0);
      line(previous.x, previous.y, current.x, current.y);
      break;
    case "SYMMETRY":
      strokeWeight(size);
      stroke(255, 0, 0);
      line(previous.x, previous.y, current.x, current.y);
      line(width - previous.x, previous.y, width - current.x, current.y);
      break;
    case "MULTILINES":
      strokeWeight(size);
      stroke(0);
      //PVector start = new PVector(previous.x, previous.y);
      //PVector end = new PVector(current.x, current.y);

      // Get the direction vector
      PVector direction = PVector.sub(current, previous);
      if (direction.mag() > 1.) {
        direction.normalize(); // Make it a unit vector

        // Rotate 90 degrees to get the perpendicular vector
        PVector offset = new PVector(-direction.y, direction.x);

        // Scale the offset by half the separation distance
        offset.mult(20 / 2);

        // Compute the two parallel line endpoints
        PVector start1 = PVector.add(previous, offset);
        PVector end1 = PVector.add(current, offset);

        PVector start2 = PVector.sub(previous, offset);
        PVector end2 = PVector.sub(current, offset);

        // Draw the two lines
        line(start1.x, start1.y, end1.x, end1.y);
        line(start2.x, start2.y, end2.x, end2.y);
 
        break;
      }
    }
  }

  void velocity() {
    velocityMag = abs(current.dist(previous)) * 0.01;
    velocityCalled = true;
  }

  void updateHistory() {
    previous = current.copy();
    //previous.x = current.x;
    //previous.y = current.y;
    rSizeCalled = false;
    velocityCalled = false;
    modSizeCalled = false;
    displacementCalled = false;
  }
}
