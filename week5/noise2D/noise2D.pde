size(500, 500);

float value = 0;

for (int i=0; i<width; i++) {
  for (int j=0; j<height; j++) {
    value = random(1);
    stroke(value * 255.);
    point(i,j);
    
  }
}
