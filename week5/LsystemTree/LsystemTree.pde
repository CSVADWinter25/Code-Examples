import controlP5.*;

ControlP5 cp5;

String axiom = "F";  // Starting string
String current;
int iterations;  // Number of generations
float angle;  // Branch angle
float length;  // Initial branch length

void setup() {
  size(800, 800);
  background(255);
  stroke(0);

  iterations = 2;  // Number of generations
  angle = 25;  // Branch angle
  length = 150;
  current = axiom;
  
  cp5 = new ControlP5(this);

  cp5.addSlider("iterations")
    .setPosition(10, 10)
    .setSize(100, 20)
    .setRange(1, 5)
    .setNumberOfTickMarks(5)
    ;

  cp5.addSlider("angle")
    .setPosition(10, 35)
    .setSize(100, 20)
    .setRange(0, 360)
    ;

  cp5.addSlider("length")
    .setPosition(10, 60)
    .setSize(100, 20)
    .setRange(0, 360)
    ;


  for (int i = 0; i < iterations; i++) {
    current = generate(current);
  }
}

void draw() {
  background(255);
  // Generate the L-System string
  current = axiom;
  for (int i = 0; i < iterations; i++) {
    current = generate(current);
  }

  // Draw the L-System tree
  pushMatrix();
  translate(width / 2, height);
  drawLSystem(current);
  popMatrix();
}

// Function to apply the L-System rules
String generate(String input) {
  String result = "";
  for (char c : input.toCharArray()) {
    if (c == 'F') {
      result += "FF+[+F-F-F]-[-F+F+F]";  // Apply tree rule. Alternate rule: "F[+F]F[-F][F]"
    } else {
      result += c;  // Keep other symbols the same
    }
  }
  return result;
}

// Function to draw the L-System using Turtle Graphics
void drawLSystem(String instructions) {
  float branchLength = length / pow(2, iterations - 1);
  for (char c : instructions.toCharArray()) {
    if (c == 'F') {
      line(0, 0, 0, -branchLength);
      translate(0, -branchLength);
    } else if (c == '+') {
      rotate(radians(angle));
    } else if (c == '-') {
      rotate(radians(-angle));
    } else if (c == '[') {
      pushMatrix();
    } else if (c == ']') {
      popMatrix();
    }
  }
}
