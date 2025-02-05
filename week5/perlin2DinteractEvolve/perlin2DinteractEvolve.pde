float r = random(10000);
float stepSize = 0.005;//random(0.005);
color c;
float value;

void setup() {
  size(300, 300);
}

void draw() {

  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    value = noise(i % width * stepSize + r, i/height * stepSize + r, frameCount * 0.002);
    c = color(value * 255);
    pixels[i] = c; 
  }
  updatePixels();
  
  noFill();
  stroke(255,0,0);
  circle(mouseX,mouseY, pow(noise(mouseX * stepSize + r, mouseY * stepSize + r, frameCount * 0.002),2) * 300);
}
