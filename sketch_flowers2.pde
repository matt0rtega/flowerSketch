import com.cage.colorharmony.*;
import com.hamoid.*;

VideoExport videoExport;

// CREATE A COLORHARMONY INSTANCE (DEFAULT CONSTRUCTOR)
ColorHarmony colorHarmony = new ColorHarmony(this);

PVector[] points;
color [] colors;

PImage img;

//ArrayList<PImage> imgs;

int tileCount;
int gridSize;
int numFlowers;

Flower flower;
ArrayList<Flower> flowers;

PImage[] imgs;
int selectedImg = 0;

int flowerSelector;

void setup() {
  size(500, 500, P3D);
  
  background(255);
  
  videoExport = new VideoExport(this);
  videoExport.startMovie();

  tileCount = 50;
  gridSize = width/tileCount;
  numFlowers = tileCount * tileCount;

  flower = new Flower(gridSize, color(255, 150, 100), 100, 100);
  
  imgs = new PImage[6];
  
  for (int i=0; i<imgs.length; i++){
    imgs[i] = loadImage("img"+i+".png");
    imgs[i].resize(width, height);
  }
  
  //PImage img1 = loadImage("img.png");
  //PImage img2 = loadImage("img2.png");
  
  //img1.resize(width, height);
  //img2.resize(width, height);
  
  //imgs.add(img1);
  //imgs.add(img2);

  //img = loadImage("img2.png");
  //img.resize(width, height);
  
  
  
  flowers = new ArrayList<Flower>();
  points = new PVector[numFlowers];
  colors = new color[numFlowers];
  
  flowerSelector = randomSelect();

  imgs[selectedImg].loadPixels();
  int i = 0;
  for (int x=0; x<tileCount; x++) {
    for (int y=0; y<tileCount; y++) {
      int posx = x * gridSize;
      int posy = y * gridSize;
      
      points[i] = new PVector(posx, posy);
      colors[i] = imgs[selectedImg].get(posx, posy);
      
      
      color co = imgs[selectedImg].get(posx, posy);
      
      //flowers[i] = new Flower(gridSize, co);
      
      //flowers.add(new Flower(gridSize, co, posx, posy));
      i++;
    }
  }
}

void draw() {
  //translate(width/2, height/2);

  if(frameCount % 100 == 0){
    //triggerColors();
  }
  
  println(mouseX);

  flower.run();
  
  // Select a random flower
  
  //Flower flow = flowers.get(flowerSelector);
  //flow.run();
  
  if(frameCount % 2 == 0){
    flowerSelector = randomSelect();
    
    for(int i=0; i<tileCount; i++){
    int randomPoint = (int)random(points.length);
    flowers.add(new Flower(gridSize+mouseX, colors[randomPoint], points[randomPoint].x, points[randomPoint].y));
    }  
}
  
   for(int i=0; i<flowers.size(); i++){
       Flower f = flowers.get(i);
        f.run();
         if(f.isDead()){
          flowers.remove(i);
         } 
      }
      
      //saveFrame("frames/flowers####.png");
      videoExport.saveFrame();
}

void keyPressed() {
  //setup();
  //flowers.add(new Flower(gridSize, color(255, 0, 0), mouseX, mouseY));
  
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}

void mousePressed(){
  //int randomSelector = (int)random(imgs.size());
  
  //reloadColors();
  if(selectedImg < imgs.length-1){
    selectedImg += 1;
  } else {
    selectedImg = 0;
  } 
  
  reloadColors();
  
  //println(selectedImg);
}

int randomSelect(){
  int randomSelector = (int)random(flowers.size());
  
  return randomSelector;
}

void reloadColors(){
  
  imgs[selectedImg].loadPixels();
  int i = 0;
  for (int x=0; x<tileCount; x++) {
    for (int y=0; y<tileCount; y++) {
      int posx = x * gridSize;
      int posy = y * gridSize;

      colors[i] = imgs[selectedImg].get(posx, posy);

      i++;
    }
  }
}