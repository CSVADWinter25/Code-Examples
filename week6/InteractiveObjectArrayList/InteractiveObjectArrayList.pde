ArrayList<DraggableRect> rectangles; 
DraggableRect selectedRect = null; 
PVector offset; 

void setup() {
  size(600, 400);
  rectangles = new ArrayList<DraggableRect>();
}

void draw() {
  background(220);

  // Draw all rectangles
  for (DraggableRect rect : rectangles) {
    rect.display();
  }
}

void mousePressed() {
  boolean found = false;
  
  // Check if clicking on an existing rectangle
  for (DraggableRect rect : rectangles) {
    if (rect.contains(mouseX, mouseY)) {
      selectedRect = rect;
      offset = new PVector(mouseX - rect.x, mouseY - rect.y);
      found = true;
      break;
    }
  }
  
  // If no rectangle was selected, create a new one
  if (!found) {
    rectangles.add(new DraggableRect(mouseX, mouseY, random(500), random(500)));
  }
}

void mouseDragged() {
  if (selectedRect != null) {
    selectedRect.x = mouseX - offset.x;
    selectedRect.y = mouseY - offset.y;
  }
}

void mouseReleased() {
  selectedRect = null; // Release the selected rectangle
}
