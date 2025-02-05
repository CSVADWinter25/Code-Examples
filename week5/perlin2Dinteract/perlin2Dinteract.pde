float r = random(10000);
float stepSize = random(0.005);
color c;
float value;

void setup() {
  size(500, 500);
}

void draw() {

  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    value = noise(i % width * stepSize + r, i/height * stepSize + r);
    c = color(value * 255);
    pixels[i] = c; 
  }
  updatePixels();
  
  fill(255,0,0, 255 - value * 255);
  stroke(255,0,0, 255 - value * 255);
  circle(mouseX,mouseY, pow(noise(mouseX * stepSize + r, mouseY * stepSize + r),2) * 300);
}
