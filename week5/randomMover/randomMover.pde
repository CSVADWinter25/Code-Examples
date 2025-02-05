// PVectors store 2 or 3 dimensional vectors

PVector acceleration;
PVector velocity; // velocity is the integral of acceleration
PVector position; // position is the integral of velocity

void setup() {
  size(500, 500);
  position = new PVector(width/2, height/2); // initial position
  velocity = new PVector(0,0); // initial velocity
}

void draw() {
  fill(0, 20); // frame blur trick
  rect(0, 0, width, height);
  
  acceleration = new PVector(noise(frameCount * 0.05) - 0.5, noise(frameCount * 0.05 + 100000) - 0.5); // create random acceleration vector
  acceleration.normalize(); // normalize the acceleration vector to unit magnitude
  acceleration.mult(random(2)); // scale acceleration vector to random magnitude
  velocity.add(acceleration); // integrate to calculate new velocity vector
  velocity.limit(2); // contrain velocity to maximum magnitude of 2 to prevent wild behavior
  position.add(velocity); // integrate to calculation new position 
  
  // draw the behavior
  noStroke();
  fill(255);
  circle(position.x, position.y, 10);


// offscreen wrapping (toroidal space)
  if (position.x > width + 5) {
    position.x = -5;
  }
  if (position.x < -5) {
    position.x = width + 5;
  }
  if (position.y > height + 5) {
    position.y = -5;
  }
  if (position.y < -5) {
    position.y = height + 5;
  }
}
