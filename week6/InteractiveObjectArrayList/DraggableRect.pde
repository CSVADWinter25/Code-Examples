// Class for draggable rectangles
class DraggableRect {
  float x, y, w, h;
  color rectColor;

  DraggableRect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.rectColor = color(random(255), random(255), random(255), random(255));
  }

  void display() {
    fill(rectColor);
    stroke(0);
    rect(x, y, w, h);
  }

  boolean contains(float px, float py) {
    return (px > x && px < x + w && py > y && py < y + h);
  }
}
