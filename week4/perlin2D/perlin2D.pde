size(500, 500);

float r = random(10000);
float size = random(0.1);
float value = 0;

for (int i=0; i<width; i++) {
  for (int j=0; j<height; j++) {
    value = noise(i * size + r, j * size + r);
    stroke(value * 255.);
    point(i,j);
    
  }
}
