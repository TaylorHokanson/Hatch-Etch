// Taylor Hokanson
// Pixelate, posterize, hatch
// Based in part on the work of Jeffrey Thompson
 
String filename = "StarryNight.jpg";
PImage p;

void setup() {

  p = loadImage(filename);           
  size(800, 500);           
  // important for brightness info
  colorMode(HSB, 255);
  image(p, 0, 0);

  // pixel size, higher value = bigger pixels
  pixelateImage(10);    
  // posterization, higher value = fewer colors
  posterizeImage(100);   
  
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