class Ball {
  PVector position;       // Ball position
  PVector velocity = new PVector(0, 0);     // Ball velocity
  PVector gravity = new PVector (0, 0.5);  // Gravity acceleration
  float bounce = -0.8;  // Bounce factor (energy loss)
  float radius = 20;    // Ball radius

  Ball(float xPos, float yPos, float xVel, float yVel) {
    position = new PVector(xPos, yPos);
    velocity = new PVector(xVel, yVel);
  }

  void update() {

    // Apply gravity
    velocity.add(gravity);
    position.add(velocity);

      // Check for collision with the floor
      if (position.y + radius > height) {
      position.y = height - radius; // Prevent sinking into the floor
      velocity.y *= bounce; // Reverse direction with energy loss
    }

    // Check for collision with walls
    if (position.x - radius < 0 || position.x + radius > width) {
      velocity.x *= bounce; // Reverse horizontal velocity
    }
  }

  void display() {
    // Draw the ball
    noStroke();
    fill(255);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}
