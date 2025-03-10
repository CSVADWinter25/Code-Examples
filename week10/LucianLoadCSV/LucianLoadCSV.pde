Table fftData;
int rowIndex = 0;       // We'll iterate over rows in draw()
int bands = 0;          // Number of frequency bins = columns in CSV

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

  // ----------------------------------
  // 1) Load the CSV file
  //    (Replace "data.csv" with your file’s name/path)
  // ----------------------------------
  fftData = loadTable("dummy.csv", "csv");
  
  // If your CSV includes a header row, switch to:
  // fftData = loadTable("data.csv", "header");
  // ...and adjust how you read data below (getFloat() might reference named columns).

  // Count columns; each is a frequency bin
  bands = fftData.getColumnCount();
  println("Loaded CSV with " + fftData.getRowCount() + " rows and " 
          + bands + " columns.");

  // ----------------------------------
  // 2) Setup drawing steps
  // ----------------------------------
  xStep = int(width / fftData.getRowCount());
  yStep = int(height / 200) * 5;
}

void draw() {
  // Optionally clear each frame so you see each row anew:
  // background(255, 252, 239);

  // If we've reached the end of the CSV, stop drawing
  if (rowIndex >= fftData.getRowCount()) {
    noLoop();
    return;
  }

  // ----------------------------------
  // 3) For each frequency bin in the current row,
  //    read its amplitude and call makeLines()
  // ----------------------------------
  for (int col = 0; col < bands; col++) {
    float amplitude = fftData.getFloat(rowIndex, col);
    // Scale amplitude so that typical 0..1 values become something up to 1000
    int magnitude = int(amplitude * 10000);

    makeLines(xScan, yScan, magnitude, height/fftData.getColumnCount()*col, 1);

  }
  // Move to the next row
  rowIndex++;
}

/**
 * Randomly changes xScan and yScan based on xStep, yStep,
 * and the given baseline (startingY).
 */
void updatePos(int startingY) {
  xScan += xStep;
  yScan = startingY + int(random(yStep)) * int(2 * (random(2) - 1));
}

/**
 * Draws 'mag' lines starting at (x, y), with random directions and lengths.
 *
 * @param x          The current x-position
 * @param y          The current y-position
 * @param mag        How many lines to draw
 * @param startingY  A baseline for randomizing yScan (via updatePos)
 * @param palette    Which palette to use for color
 */
void makeLines(int x, int y, int mag, int startingY, int palette) {
  updatePos(startingY);

  xLen = int(random(200));
  yLen = int(random(200));
  
  // Random direction each time
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
