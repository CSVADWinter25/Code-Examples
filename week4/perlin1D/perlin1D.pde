size(720, 480);

float r = random(100000);
float value = 0;
float pValue = 0;

for (int i = 0; i < width; i++) {
  value = noise(i * 0.01 + r);
  stroke(value * 255.);
  line(i, 0, i, height);
  
  if (i != 0) {
    stroke(255,0,0);
    line(i, map(value,0, 1, height, 0), i-1, map(pValue,0, 1, height, 0));
  }
  pValue = value;
}
