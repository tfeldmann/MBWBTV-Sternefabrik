class star {
  float x ,y ;
  float dx,dy;
  float phi, dphi;
  float speed = 2;
  byte colored = 0, broken = 0;
  PImage Img;
  int starAlpha = 180;
  float Scale = 1;

  star() {
    init();
  }
  
  void init() {
    x = random(width);
    y = random(height);
    if (round(random(2)) == 0) dx = random(speed); else dx = -random(speed);
    if (round(random(2)) == 0) dy = random(speed); else dy = -random(speed);
    Img = loadImage("00.png");
    phi = random(360);
    dphi = random(5) * (random(4)-2);  
    Scale = 0.7 + random(0.5);
    broken = 0;
    colored = 0;
  }
  
  void move() {
    x += dx;
    y += dy;
    phi += dphi;
    if (x < 0 && dx < 0) dx = random(speed);
    if (x > width && dx > 0) dx = -random(speed);
    if (y < 0 && dy < 0) dy = random(speed);
    if (y > height && dy > 0) dy = -random(speed);
    if (y > height || y < 0 || x > width || x < 0)
      dphi = random(5) * (random(4)-2);
    if (starAlpha < 180 && (broken == 0 || colored == 0)) starAlpha += 9;
    if (broken == 1 && colored == 1) {
      Scale *= 1.1;
      starAlpha = 50;
    }
    if (Scale > 100) init();
  }
  
  void changePic() {
    Img = loadImage(str(colored)+str(broken)+".png");
    starAlpha = 0;
  }
};
