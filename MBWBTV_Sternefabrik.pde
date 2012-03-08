
//  Die My Baby Wants To Eat Your Pussy Sternefabrik
//  by Thomas Feldmann

boolean Einleitung = true, Spiel = false, Zertifikat = false;
boolean timeLeftWarning = false;
PImage Hintergrund, Intro, Outro;
PFont font;

int startzeit = 0;
int gesZeit = 120;
int STARCOUNT = 50;
int ellipseAlpha = 30, textAlpha = 100, comboTextLeft = 400;
int count = 0;
String comboText = "Start";

star[] Stern = new star[STARCOUNT];

void setup() {
  //Größe
  size(400,400);
  //Bilder
  Hintergrund = loadImage("kachel.png");
  Intro       = loadImage("start.png");
  Outro       = loadImage("bescheinigung.png");
  //Schriftart
  font = loadFont("Ziggurat-HTF-Black-32.vlw");
  //Sterne
  for (int i=0; i<STARCOUNT; i++) Stern[i] = new star(); 
  //Optionen
  smooth();
  ellipseMode(CORNER);
  imageMode(CENTER);
  cursor(HAND);
}

void draw() {
  int timeLeft = gesZeit*1000-(millis()-startzeit);
  if (Einleitung == true) {
    noLoop();
    background(Intro);
  }
  else if (Zertifikat == true) {
    cursor(HAND);
    tint(255,255,255,abs(timeLeft/2));
    image(Outro,200,200,400,400);
    if (-timeLeft >= 510) {
      noLoop();
      textSize(13);
      textAlign(LEFT);
        text(str(day())+"."+str(month())+"."+str(year()),0,10);
       text("Herzlichen Dank für ihre Mitarbeit in der",30,120);
       text("MBWTEYP Sternfabrik.",30,150);
       int INS = count/20;
       if (INS>28) INS = 28;
       text("Sie waren "+insert[INS]+" und haben",30,180);
      textSize(25);
      textAlign(CENTER);
       text(str(count)+" Euro",200,250);
      textSize(13);
      textAlign(LEFT);
       text("für MBWTEYP gesammelt.",30,290);
      textAlign(CENTER);
       text(" - Dafür dankt das MBWßTV- Team - ",200,310);
      textSize(11);
      textAlign(CENTER);
       text("Klicken, um weiterzusammeln",200,360);
       text("S-Taste drücken um das Zertifikat zu speichern",200,393);
    }
  }
  else if (Spiel == true) {
    background(Hintergrund);

    //Linien
    stroke(0,0,0,100);
    for(int i=0;i<STARCOUNT;i++) 
      line(200,200,Stern[i].x,Stern[i].y);
    stroke(100,100,100);
    line(200,200,mouseX,mouseY);
    stroke(0);

    //Maus
    if (ellipseAlpha > 30) ellipseAlpha -= 15;
    fill(255,255,255,ellipseAlpha);
    ellipse(mouseX-15,mouseY-15,30,30);

    //Sterne
    for(int i=0;i<STARCOUNT;i++) {
      tint(255,255,255,Stern[i].starAlpha);
      pushMatrix();
      translate(Stern[i].x, Stern[i].y);
      rotate(radians(Stern[i].phi));
      scale(Stern[i].Scale);
      image(Stern[i].Img, 0, 0);
      popMatrix();
      Stern[i].move();
    }
    //Zähler
    if (textAlpha > 100) textAlpha -= 5;
    fill(255,255,255,textAlpha);
    textFont(font,25);
    textAlign(RIGHT);
    text(str(count)+" Euro",400,400);

    //Restanzeige
    if (timeLeft <= 10000 && timeLeftWarning == false) {
      comboText = "Noch 10 Sekunden!";
      comboTextLeft = 400;
      timeLeftWarning = true;
    }

    //Ausfaden
    if (timeLeft <= 510) {
      fill(255,255,255,255-timeLeft/2);
      rect(-10,-10,430,430);
    }
    //Spiel vorbei
    if (timeLeft <= 0) {
      Spiel = false;
      Zertifikat = true;
    }
    //ComboText
    if (comboTextLeft >  -textWidth(comboText)) {
      comboTextLeft -= 5;
      textAlign(LEFT);
      text(comboText,comboTextLeft,200);
    }
  }
}

void mousePressed() {
  if (Einleitung == true) {
    noCursor();
    Einleitung = false;
    Zertifikat = false;
    startzeit = millis();
    Spiel = true;
    loop();
  }
  if (Zertifikat == true && millis()-startzeit-gesZeit*1000 > 1000) {
    Spiel = false;
    Zertifikat = false;
    Einleitung = true;
    loop();
    for (int i=0;i<STARCOUNT;i++) Stern[i].init();
  }
  int comboCount = 0;
  for (int i = 0; i < STARCOUNT; i++)
    if (sqrt(sq(Stern[i].x-mouseX)+sq(Stern[i].y-mouseY))<20 && Stern[i].starAlpha>100) {
      if (mouseButton==LEFT) Stern[i].colored = 1;
      if (mouseButton==RIGHT) Stern[i].broken = 1;
      if (Stern[i].colored == 1 && Stern[i].broken == 1) {
        textAlpha = 255;
        count++;
        comboCount++;
      }
      Stern[i].changePic();
    }
  if (comboCount > 1) {
    count += pow(comboCount,2);
    comboTextLeft = 400;
    comboText = "Combo! x"+str(comboCount);
  }
  ellipseAlpha = 255;
}

void keyPressed() {
  if(Zertifikat == true && millis()-startzeit-gesZeit*1000 > 510) {
    if (key == 's') saveFrame("Zertifikat-####.png");
  }
}
