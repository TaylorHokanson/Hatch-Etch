// press s to save a frame
//press p to save a pdf

/* video hatching sketch
 JSL x THO
 
 
 horizontal lines
 */

PImage img;


//load the image here, remember to change size in setup to match
String imgFileName = "ansel";
String fileType = "jpg";

import java.util.Calendar;
import processing.pdf.*;
boolean record = false;

int cellsize = 10; // Dimensions of each cell in the grid
int cols, rows;   // Number of columns and rows in our system

PShape hatch1, hatch2, hatch3, hatch4, hatch5; //declare the hatch svgs
PImage p;

float theta=0.0;

void settings() {
  img = loadImage(imgFileName+"."+fileType);
  size(img.width, img.height); //size of composition is set by size of the image
}

void setup()
{
  image(img, 0, 0);

  cols = width/cellsize;
  rows = height/cellsize;
  //load hatch svgs
  hatch1 = loadShape("pattern1.svg");
  hatch2 = loadShape("pattern2.svg");
  hatch3 = loadShape("pattern3.svg");
  hatch4 = loadShape("pattern4.svg");
  hatch5 = loadShape("pattern5.svg");
}

void draw()
{
  //pdf record
  if (record) {
    beginRecord(PDF, timestamp()+".pdf");
  }
  shapeMode(CENTER);
  background(255);

  hatch1.disableStyle(); //turn off formatting to allow processing to style the shape
  hatch2.disableStyle(); //turn off formatting to allow processing to style the shape
  hatch3.disableStyle(); //turn off formatting to allow processing to style the shape
  hatch4.disableStyle(); //turn off formatting to allow processing to style the shape
  hatch5.disableStyle(); //turn off formatting to allow processing to style the shape
  strokeWeight(.5);
  noFill();
  stroke (0);

  img.loadPixels();

  for ( int i = 0; i < cols; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2; // x position
      int y = j*cellsize + cellsize/2; // y position
      int loc = x + y*width;           // Pixel array location
      color c = img.pixels[loc];       // Grab the color
      float b = brightness(img.pixels[loc]); //grab brightness

      // Translate to the location
      pushMatrix();
      translate(x, y);
      // fill(c);

      float r = random(10);

      // ********************** try this as well, gets purty funky! ************ /
      // float angle = r * PI/8;
      float angle = PI/8;
      rectMode(CENTER);

      //design by brightness
      if (b<40) {

        //rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch1, 0, 0, cellsize, cellsize);
      } else if (b<80) {

        //rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch2, 0, 0, cellsize, cellsize);
      } else if (b<100) {

        //rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch3, 0, 0, cellsize, cellsize);
      } else if (b<160) {

        //rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch4, 0, 0, cellsize, cellsize);
      } else if (b<200) {

        //rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch5, 0, cellsize, cellsize, cellsize);
      }

      theta+=.001; //increment theta
      popMatrix();
    }
  }
  if (record) {
    endRecord();
    record = false;
  }
}


void keyPressed() {
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
  if (key=='p' || key=='P') record = true;
}


String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}