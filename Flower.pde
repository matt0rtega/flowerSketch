class Flower {
  
  float fade;
  float target = 255;
  float lifespan;
  float x, y, x1, y1, x2, y2;
  float size;
  color basecolor;
  PVector location;
  
  float easing;
  
  color[] colors = new color[8];
  
  float offset, offset1, f;
  
  int[] circleDirect = new int[3];
  
  float speeds[] = new float[3];

  Flower(float size, color co, float x, float y) {
    this.size = size/2 - random(size);
    fade = 0;
    lifespan = 255;
    basecolor = co;
    colors = colorHarmony.Triads(color(basecolor));
    //colors = co;
    
    easing  = random(0.001, 0.05);
    
    location = new PVector(x, y);

    offset = random(1000);
    
    for(int i=0; i<circleDirect.length; i++){
      int[] rand = {-1, 1};
      
      circleDirect[i] = rand[(int)random(0, 2)];
      
      speeds[i] = random(0.01, 0.04);
    }
  }

  void run(){
    update();
    display();
  }

  void update() {
    x = map(sin(frameCount* speeds[0] + offset), -1*circleDirect[0], 1*circleDirect[0], -size, size);
    y = map(cos(frameCount * speeds[0] + offset), -1, 1, -size, size);
    x1 = map(sin(frameCount * speeds[1]), -1*circleDirect[1], 1*circleDirect[1], -size, size);
    y1 = map(cos(frameCount * speeds[1]-0.2), -1, 1, -size, size);
    x2 = map(sin(frameCount * speeds[2]), -1*circleDirect[2], 1*circleDirect[2], -size, size);
    y2 = map(cos(frameCount * (speeds[2]-0.002)), -1, 1, -size, size);
    
    //println(circleDirect[0]);

    lifespan -=0.5;
    //fade+=1;
    
    float fadeOffset = map(lifespan, 255, 0, 0, 255);
    
    if(fade > 254){
      target = 0;
    }
    
    fade = lerp(fade, target, easing);
    
    fade = fade - fadeOffset;
    
    //println(target);
  }

  void display() {
    
    pushMatrix();
    translate(size + location.x, size + location.y);
    strokeWeight(1);
    stroke(basecolor, fade);
    line(0, 0, x, y);
    stroke(colors[0], fade);
    line(0, 0, x1, y1);
    stroke(colors[1], fade);
    line(0, 0, x2, y2);
    popMatrix();
  }

  boolean isDead() {
    if (lifespan<0) {
      return true;
    } else {
      return false;
    }
  }
}