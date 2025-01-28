class Module {
  float xPosition; // these are our object's attributes
  float yPosition;
  float xSize;
  float ySize;
  float rotationRate; 
  
  // Contructor
  Module(float xPosition, float yPosition, float xSize, float ySize, float rotationRate) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.xSize = xSize;
    this.ySize = ySize;
    this.rotationRate = rotationRate;
  }
  
  // Custom method for drawing the object (its behavior)
  void displayModule() {
    pushMatrix();
    noStroke();
    fill(255);
    rectMode(CENTER);
    translate(xPosition, yPosition);
    rotate(frameCount * rotationRate);
    rect(0, 0, xSize, ySize);
    popMatrix();
  }
}
