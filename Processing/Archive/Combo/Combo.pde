// Taylor Hokanson
// Pixelate, posterize, hatch
// Based in part on the work of Jeffrey Thompson
 
String filename = "StarryNight.jpg";
PImage p;
color c;
int pixSize = 10;

PShape bot;
int fieldSize = 20;
int hatchSize = 30;

void setup() {
  
  noStroke();

  p = loadImage(filename);           
  size(700, 500);           
  // background(#FFFFFF);
  
  // important for brightness info
  colorMode(HSB, 255);
  image(p, 0, 0);

  // pixel size, higher value = bigger pixels
  pixelateImage(pixSize);    
  // posterization, higher value = fewer colors
  posterizeImage(25); 
  //background(#FFFFFF);
  replacePixels();
  
  // save("PixelatedAndPosterized_" + filename);
  
}

void pixelateImage(int pxSize) {
 
  // use ratio of height/width...
  float ratio;
  if (width < height) {
    ratio = height/width;
  }
  else {
    ratio = width/height;
  }
  
  // ... to set pixel height
  int pxH = int(pxSize * ratio);
  
  noStroke();
  for (int x=0; x<width; x+=pxSize) {
    for (int y=0; y<height; y+=pxH) {
      fill(p.get(x, y));
      rect(x, y, pxSize, pxH);
    }
  }
}

void posterizeImage(int rangeSize) {
  
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    int bright = int(brightness(pixels[i])/rangeSize) * rangeSize;
    pixels[i] = color(bright);
  }
  updatePixels();
}

void replacePixels(){
  for (int i = 0; i < width/pixSize; i++) {
    c = get(pixSize*i, 0);
    stroke(255);
    fill(c);
    ellipseMode(CORNER);
    ellipse(pixSize*i, 0, pixSize, pixSize);
  }
}

void makeHatch(){
  
  smooth();
  bot = loadShape("pattern.svg");
  shapeMode(CENTER);
  
  //pushMatrix();
  // identify SVG centerpoint relative to origin
  //translate(hatchSize/2, hatchSize/2);
  // rotation happens first
  //rotate(random(radians(360)));
  // finally we load the SVG
  shape(bot, 0, 0, hatchSize, hatchSize);
  //popMatrix();
}