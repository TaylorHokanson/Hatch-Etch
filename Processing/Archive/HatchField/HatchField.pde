// loads a SVG
// makes a field of cross hatching
// hello

PShape bot;
 
int fieldSize = 20;
int hatchSize = 30;
 
void setup(){
  size(500, 500);
  smooth();
  bot = loadShape("pattern.svg");
  shapeMode(CENTER);
  makeHatch();
}
 
void draw(){
}

void makeHatch(){
  
  for(int i = 0; i < fieldSize; i++){      // rows
    for(int j = 0; j < fieldSize; j++){    // columns
      pushMatrix();
      // identify SVG centerpoint relative to origin
      translate(hatchSize * j, hatchSize * i);
      // rotation happens first
      rotate(random(radians(360)));
      // finally we load the SVG
      shape(bot, 0, 0, hatchSize, hatchSize);
      popMatrix();
      
    }
  }
}