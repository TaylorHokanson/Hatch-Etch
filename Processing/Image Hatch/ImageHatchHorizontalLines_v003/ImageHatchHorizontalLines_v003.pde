/*  Image Hatch v0003
    
    svgs are rotated to random orientations (but maintain their centers)
    first svg is circular
    why does the seem to be the wrong size after pressing P?
    press p to generate a new image and save as pdf

    JSL x THO
*/

PImage img;


//load the image here, remember to change size in setup to match
String imgFileName = "skull";
String fileType = "jpg";

import java.util.Calendar;
import processing.pdf.*;
boolean record = false;


float scaleMin = 1.2;  // Minimum size of hatch SVGs
float scaleMax = 1.5;  // Maximum size of hatch SVGs
int cellsize = 5;   // Dimensions of each cell in the grid
int cols, rows;      // Number of columns and rows in our system

PShape hatch1, hatch2, hatch3, hatch4, hatch5; //declare the hatch svgs
PImage p;

void setup()
{
  img = loadImage(imgFileName+"."+fileType);
  size(300, 277); //size of composition
  image(img, 0, 0);

  cols = width/cellsize/2;
  rows = height/cellsize/2;


  //load hatch svgs
  hatch1 = loadShape("pattern1.svg");
  hatch2 = loadShape("pattern2.svg");
  hatch3 = loadShape("pattern3.svg");
  hatch4 = loadShape("pattern4.svg");
  hatch5 = loadShape("pattern5.svg");
  
  rectMode(CENTER);
  
}

void draw(){
  if(record == true){
   hatchIt(); 
  }
}


void keyPressed() {
  if (key=='p' || key=='P') record = true;
}


// log key variables in output filename
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("scaleMin" + scaleMin + "scaleMax" + scaleMax + "cSize" + cellsize + "_%1$tH%1$tM%1$tS", now);
}

void hatchIt(){
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

      translate(x*2, y*2);

      // Pick SVGs based on pixel brightness
      if (b<40) {

        rotate(random(PI)); 
        hatch1.scale(random(scaleMin,scaleMax));
        shape(hatch1, 0, 0, cellsize*2, cellsize*2);
      } else if (b<80) {

        rotate(random(PI)); 
        hatch2.scale(random(scaleMin,scaleMax));
        shape(hatch2, 0, 0, cellsize*2, cellsize*2);
      } else if (b<100) {

        rotate(random(PI)); 
        hatch3.scale(random(scaleMin,scaleMax));
        shape(hatch3, 0, 0, cellsize*2, cellsize*2);
      } else if (b<160) {

        rotate(random(PI)); 
        hatch4.scale(random(scaleMin,scaleMax));
        shape(hatch4, 0, 0, cellsize*2, cellsize*2);
      } else if (b<200) {

        rotate(random(PI)); 
        hatch5.scale(random(scaleMin,scaleMax));
        shape(hatch5, 0, cellsize, cellsize*2, cellsize*2);
      }
      popMatrix();
      hatch1.resetMatrix();
      hatch2.resetMatrix();
      hatch3.resetMatrix();
      hatch4.resetMatrix();
      hatch5.resetMatrix();
    }
  }
  if (record) {
    endRecord();
    record = false;
  }
}