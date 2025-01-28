int count = 7;
Module[] mods;

void setup() {
  size(480, 640);
  mods = new Module[count];
  for (int i = 0; i < count; i++) {
    mods[i] = new Module(random(width), random(height), random(5,40), random(100,400), random(0.01));
  }
}

void draw() {
  background(0);
  for (Module mod : mods) {
    mod.displayModule();
  }
}
