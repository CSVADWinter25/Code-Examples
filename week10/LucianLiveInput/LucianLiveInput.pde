import processing.sound.*;

AudioIn mic;
Amplitude amp;

int xScan = 0;
int yScan = 0;
int xStep = 0;
int yStep = 0;

int xLen = 0;
int yLen = 0;
float xDir = 1;
float yDir = 1;

void setup() {
  size(1000, 1000);
  background(255, 252, 239);

  // Sound setup
  mic = new AudioIn(this, 0);
  mic.start();
  amp = new Amplitude(this);
  amp.input(mic);

  xStep = int(width / 500);
  yStep = int(height / 200) * 5;
}

void draw() {
  // Instead of random magnitude, use amplitude from mic
  // Map amplitude range [0..1] to a suitable range e.g. [0..1000].
  int Magnitude = int(map(amp.analyze(), 0, 1, 0, 1000));
  
  // Draw with that amplitude-derived Magnitude
  makeLines(xScan, yScan, Magnitude, 500, 1);
  makeLines(xScan, yScan, Magnitude, 200, 2);
}

void updatePos(int startingY) {
  xScan += xStep;
  // same random logic for y
  yScan = startingY + int(random(yStep)) * int(2 * (random(2) - 1));
}

void makeLines(int x, int y, int mag, int startingY, int palette) {
  updatePos(startingY);

  xLen = int(random(200));
  yLen = int(random(200));
  
  xDir = (random(1) < 0.5) ? -1 : 1;
  yDir = (random(1) < 0.5) ? -1 : 1;
  
  for (int m = 0; m < mag; m++) {
    if (palette == 1) {
      stroke(random(255), random(38), random(157), 1);
    } else {
      stroke(random(20), random(200), random(255), 1);
    }
    strokeWeight(1);
    line(x, y, x + (xLen * xDir), y + (random(yLen) * yDir));
  }
}
