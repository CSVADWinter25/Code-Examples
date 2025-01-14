void setup() {
  size(800, 800); // Set the canvas size
  background(255); // Set the background color to white
  stroke(0);
}

void draw() {
  if (mousePressed) {
    // Draw at the current mouse position
    
    strokeWeight(map(sin(frameCount * 0.1), -1, 1, 1, 20)); // modulate weight of line
    
    line(mouseX, mouseY, pmouseX, pmouseY); // Draw a small circle

    // Mirror horizontally
    line(width - mouseX, mouseY, width - pmouseX, pmouseY);

    // Mirror vertically
    line(mouseX, height - mouseY, pmouseX, height - pmouseY);

    // Mirror both horizontally and vertically
    line(width - mouseX, height - mouseY, width - pmouseX, height - pmouseY);
  }
}
