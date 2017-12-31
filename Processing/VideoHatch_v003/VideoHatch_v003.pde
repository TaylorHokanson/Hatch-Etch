// press s to save a frame
//press p to save a pdf

/* video hatching sketch
JSL x THO

*/

import processing.video.*;

import java.util.Calendar;
import processing.pdf.*;
boolean record = false;

Capture cam;
PImage img;

int cellsize = 5; // Dimensions of each cell in the grid
int cols, rows;   // Number of columns and rows in our system

PShape hatch1, hatch2; //declare the hatch svgs


float theta=0.0;
void setup()
{
  size(1280, 720, P3D);
  cols = width/cellsize/2;
  rows = height/cellsize/2;

  img = createImage(width, height, RGB);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("no cameras available");
    exit();
  } else {
    println("cameras available:");
    for (int i = 0; i<cameras.length; i++) {
      println(cameras[i]);
    }

    cam = new Capture(this, cameras[3]);
    cam.start();
  }

  shapeMode(CENTER);
  
  //load hatch svgs
  hatch1 = loadShape("pattern1.svg");
  hatch2 = loadShape("pattern.svg");
}

void draw()
{
  //pdf record
    if (record) {
    beginRecord(PDF, timestamp()+".pdf");
  }
  
  background(255);
  strokeWeight(1);
  hatch1.disableStyle(); //turn off formatting to allow processing to style the shape
  hatch2.disableStyle(); //turn off formatting to allow processing to style the shape
  if (cam.available() == true) {   
    img.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
    img.updatePixels();
    cam.read();
  }

  loadPixels();
  cam.loadPixels();
  img.loadPixels();

  for ( int i = 0; i < cols; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2; // x position
      int y = j*cellsize + cellsize/2; // y position
      int loc = x + y*width;           // Pixel array location
      color c = img.pixels[loc];       // Grab the color
      float b = brightness(img.pixels[loc]); //grab brightness

      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (mouseX/(float)width) * brightness(img.pixels[loc]) - 100.0; //not really used at this point
      //float z = random(1, 100);

      // Translate to the location
      pushMatrix();
      translate(x*2, y*2);
      fill(c);


      float r = random(10);
      
      // ********************** try this as well, gets purty funky! ************ /
      // float angle = r * PI/8;
      float angle = PI/8;
      
      rectMode(CENTER);



      //design by brightness
      if (b<200) {
       
        rotate(angle*sin(theta));//use sine values to incrementally rotate the shape
        shape(hatch1, 0, 0, cellsize, cellsize);
       
      } 
   


      if (b<180) {
     
               rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch1, 0, 0, cellsize*2, cellsize*2);
     
      } 


      if (b<120) {

       rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch1, 0, 0, cellsize*2, cellsize*2);
      
      } 
 
      if (b<90) {
      
       rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch2, 0, 0, cellsize*2, cellsize*2);
     
      } 

      if (b<30) {
      
       rotate(angle*sin(theta)); //use sine values to incrementally rotate the shape
        shape(hatch2, 0, 0, cellsize*2, cellsize*2);
    
      }

      theta+=.00001; //increment theta
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