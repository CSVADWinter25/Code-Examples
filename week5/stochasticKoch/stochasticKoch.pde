float lengthMin = .5;
float lengthMax = 2.0;
float angleVar = 20;

void setup() {
  size(800, 800);
  background(255);
  stroke(0);
  noFill();

  // Define the three main points of an equilateral triangle
  PVector p1 = new PVector(width / 2, 100);
  PVector p2 = new PVector(100, height - 200);
  PVector p3 = new PVector(width - 100, height - 200);

  // Draw the stochastic Koch snowflake
  drawStochasticKoch(p1, p2, 4);
  drawStochasticKoch(p2, p3, 4);
  drawStochasticKoch(p3, p1, 4);
}

// Recursive function to draw a stochastic Koch curve on each edge
void drawStochasticKoch(PVector p1, PVector p5, int depth) {
  if (depth == 0) {
    line(p1.x, p1.y, p5.x, p5.y);  // Base case: Draw a straight line
  } else {
    // Introduce randomness in length and angle variation
    float randomFactor = random(lengthMin, lengthMax);
    float angleVariation = random(-angleVar, angleVar);  // Small angle variation

    // Calculate intermediate points
    PVector p2 = PVector.lerp(p1, p5, 1.0 / 3.0);
    PVector p4 = PVector.lerp(p1, p5, 2.0 / 3.0);
    
    // Compute peak of the "bump" with randomness
    PVector direction = PVector.sub(p5, p1);
    direction.mult(1.0 / 3.0);
    PVector p3 = PVector.add(p2, direction.copy().rotate(radians(60 + angleVariation) * randomFactor));

    // Recursively draw the four line segments
    drawStochasticKoch(p1, p2, depth - 1);
    drawStochasticKoch(p2, p3, depth - 1);
    drawStochasticKoch(p3, p4, depth - 1);
    drawStochasticKoch(p4, p5, depth - 1);
  }
}
