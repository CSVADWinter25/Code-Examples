import controlP5.*;

ControlP5 cp5;

Slider2D a;
Slider2D b;
Slider2D c;

PVector p1;
PVector p2;
PVector p3;
int d = 5;


void setup() {
  size(600, 600);
  background(255);
  noFill();
  stroke(0);

  cp5 = new ControlP5(this);
  a = cp5.addSlider2D("a")
    .setPosition(10, 10)
    .setSize(100, 100)
    .setMinMax(0, 0, width, height)
    .setValue(width / 2, 50)
    //.disableCrosshair()
    ;
  b = cp5.addSlider2D("b")
    .setPosition(10, 115)
    .setSize(100, 100)
    .setMinMax(0, 0, width, height)
    .setValue(50, height - 50)
    //.disableCrosshair()
    ;
  c = cp5.addSlider2D("c")
    .setPosition(10, 220)
    .setSize(100, 100)
    .setMinMax(0, 0, width, height)
    .setValue(width - 50, height - 50)
    //.disableCrosshair()
    ;
    
    cp5.addSlider("d")
     .setPosition(10,325)
     .setSize(100,20)
     .setRange(0,7)
     .setNumberOfTickMarks(8)
     ;

  // Define the three main points of the triangle
  p1 = new PVector(width / 2, 50);
  p2 = new PVector(50, height - 50);
  p3 = new PVector(width - 50, height - 50);

  drawTriangle(p1, p2, p3, 5); // Adjust recursion depth
}

void drawTriangle(PVector a, PVector b, PVector c, int depth) {
  if (depth == 0) {
    // Base case: draw the triangle
    fill(0);
    triangle(a.x, a.y, b.x, b.y, c.x, c.y);
  } else {
    // Calculate midpoints
    PVector ab = PVector.lerp(a, b, 0.5); // linear interpolation (lerp) between coordinate vectors. 0.5 gives us the midpoint between points.
    PVector bc = PVector.lerp(b, c, 0.5);
    PVector ca = PVector.lerp(c, a, 0.5);

    // Recursive calls for three new triangles
    drawTriangle(a, ab, ca, depth - 1);
    drawTriangle(ab, b, bc, depth - 1);
    drawTriangle(ca, bc, c, depth - 1);
  }
}

void draw() {
  background(255);
  p1 = new PVector(a.getArrayValue()[0], a.getArrayValue()[1]);
  p2 = new PVector(b.getArrayValue()[0], b.getArrayValue()[1]);
  p3 = new PVector(c.getArrayValue()[0], c.getArrayValue()[1]);
  drawTriangle(p1, p2, p3, d);
}
