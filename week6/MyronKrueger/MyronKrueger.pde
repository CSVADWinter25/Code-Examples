import processing.video.*;

Capture cam;

float threshold = 127;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  //load image pixel array
  cam.loadPixels(); 
  
  // loop through all pixels
  for (int x = 0; x < cam.width; x++) {
    for (int y = 0; y < cam.height; y++ ) {
      int loc = x + y * cam.width;
      // Test the brightness against the threshold
      if (brightness(cam.pixels[loc]) > threshold) {
        cam.pixels[loc]  = color(255);  // White
      }  else {
        cam.pixels[loc]  = color(0);    // Black
      }
    }
  }
  // update image pixel array
  cam.updatePixels();
  
  //display the result
  image(cam, 0, 0);
  
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}
