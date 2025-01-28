float r = random(10000);
float size = random(0.05);
color c;
float value;

void setup() {
  size(500, 500);
}

void draw() {
  loadPixels();
  for (int i = 0; i < width*height; i++) {
    value = noise(i % width * size + r, i/height * size + r);
    c = color(value * 255);
    pixels[i] = c;
  }
  updatePixels();
  
  noFill();
  stroke(255,0,0);
  circle(mouseX,mouseY, pow(noise(mouseX * size + r, mouseY * size + r),2) * 200);
}
