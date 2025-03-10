import processing.sound.*;

AudioIn mic;
FFT fft;
int bands = 8;      // Number of frequency bins
float[] spectrum = new float[bands];

// Variables for line drawing logic
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

  fft = new FFT(this, bands);
  fft.input(mic);

  // You can tweak these steps as desired
  xStep = int(width / 500);
  yStep = int(height / 200) * 5;
}

void draw() {
  // Analyze the current audio frame, filling 'spectrum' with frequency magnitudes
  fft.analyze(spectrum);

  // Clear the background each frame if you want "fresh" lines
  // Otherwise, leave it commented out for continuous layering:
  // background(255, 252, 239);

  // One makeLines() call per frequency bin
  for (int i = 0; i < bands; i++) {
    // Scale frequency magnitudes to something visible, e.g., up to 1000
    int magnitude = int(spectrum[i] * 100000);

    makeLines(xScan, yScan, magnitude, height/bands * i, 1);
  }
}


/**
 * Randomly changes xScan and yScan based on xStep, yStep, and a given baseline (startingY).
 */
void updatePos(int startingY) {
  xScan += xStep;
  yScan = startingY + int(random(yStep)) * int(2 * (random(2) - 1));
}

void makeLines(int x, int y, int mag, int startingY, int palette) {
  updatePos(startingY);

  xLen = int(random(200));
  yLen = int(random(200));

  xDir = (random(1) < 0.5) ? -1 : 1;
  yDir = (random(1) < 0.5) ? -1 : 1;

  for (int m = 0; m < mag; m++) {
    // Choose colors based on palette
    if (palette == 1) {
      // e.g. a more purple/pink range
      stroke(random(255), random(38), random(157), 1);
    } else {
      // e.g. a more blue range
      stroke(random(20), random(200), random(255), 1);
    }
    strokeWeight(1);

    // Draw the line using random length in y direction, fixed xLen
    line(x, y, x + (xLen * xDir), y + (random(yLen) * yDir));
  }
}
