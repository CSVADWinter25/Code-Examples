String axiom = "F";
String current = axiom;
int iterations = 7;  // Adjust recursion depth
float angle = 33;  // Turning angle
float length;

void setup() {
  size(800, 600);
  background(255);
  stroke(0);
  length = 10;  // Base segment length

  // Generate the L-System with stochastic rules
  for (int i = 0; i < iterations; i++) {
    current = generate(current);
  }

  // Draw the stochastic L-System
  translate(width / 2, height);
  drawLSystem(current);
}

// Function to apply stochastic L-System rules
String generate(String input) {
  String result = "";
  for (char c : input.toCharArray()) {
    if (c == 'F') {
      // Stochastic replacement: randomly pick a rule
      float r = random(1);
      if (r < 0.33) {
        result += "F[+F]F[-F]F";  // Rule 1
      } else if (r < 0.66) {
        result += "F[+F]F";  // Rule 2
      } else {
        result += "F[-F]F";  // Rule 3
      }
    } else {
      result += c;  // Keep other characters unchanged
    }
  }
  return result;
}

// Function to draw the stochastic L-System using Turtle Graphics
void drawLSystem(String instructions) {
  for (char c : instructions.toCharArray()) {
    if (c == 'F') {
      line(0, 0, 0, -length);
      translate(0, -length);
    } else if (c == '+') {
      rotate(radians(angle + random(-5, 5)));  // Small random variation in angle
    } else if (c == '-') {
      rotate(radians(-angle + random(-5, 5))); // Small random variation in angle
    } else if (c == '[') {
      pushMatrix();
    } else if (c == ']') {
      popMatrix();
    }
  }
}
