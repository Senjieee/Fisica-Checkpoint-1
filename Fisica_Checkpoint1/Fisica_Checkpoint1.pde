//Johnny Geng
//1-2
//Dec 22
//Fisica

import fisica.*;
//pallete
color blue   = color(29, 178, 242);
color brown  = color(166, 120, 24);
color green  = color(74, 163, 57);
color red    = color(224, 80, 61);
color yellow = color(242, 215, 16);
//assets
PImage redBird;
//fisica
FWorld world;

boolean mouseReleased;
boolean wasPressed;

boolean gravity, fBodies;

Cloud cloud1, cloud2;
Button gravityB, fBodiesB;
void setup() {
  fBodies = true;
  gravity = true;
  
  cloud1 = new Cloud(200);
  cloud2 = new Cloud(800);
  
  gravityB = new Button("gravity", width - 200, height/2 - 100, 140, 100, red, 255);
  fBodiesB = new Button("fBodies", width - 200, height/2 + 100, 140, 100, red, 255);
  //make window
  fullScreen();
  
  //load resources
  redBird = loadImage("red-bird.png");
  //initialize world
  makeWorld();
  //add terrain to world
  makeTopPlatform();
  makeBottomPlatform();
}
//=====================================================================================================================================
void makeWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
}
//=====================================================================================================================================
void makeTopPlatform() {
  FPoly p = new FPoly();
  //plot the vertices of this platform
  p.vertex(-100, height*.1);
  p.vertex(width*0.8, height*0.4);
  p.vertex(width*0.8, height*0.4+100);
  p.vertex(-100, height*0.1+100);
  // define properties
  p.setStatic(true);
  p.setFillColor(brown);
  p.setFriction(0.1);
  //put it in the world
  world.add(p);
}
//=====================================================================================================================================
void makeBottomPlatform() {
  FPoly p = new FPoly();
  //plot the vertices of this platform
  p.vertex(width/2 - 200, height/2 + 200);
  p.vertex(width/2 - 200, height/2 - 200);
  p.vertex(width/2 - 100, height/2 - 200);
  p.vertex(width/2 - 100, height/2 + 100);
  p.vertex(width/2 + 100, height/2 + 100);
  p.vertex(width/2 + 100, height/2 - 200);
  p.vertex(width/2 + 200, height/2 - 200);
  p.vertex(width/2 + 200, height/2 + 200);
  
  // define properties
  p.setStatic(true);
  p.setFillColor(brown);
  p.setFriction(0);
  //put it in the world
  world.add(p);
}

//=====================================================================================================================================
void draw() {
  click();
  println("x: " + mouseX + " y: " + mouseY);
  background(blue);
  if (frameCount % 20 == 0) {  //Every 20 frames ...
    if (fBodies ==  true) {
      makeCircle();
      makeBlob();
      makeBox();
      makeBird();
    }
  }
  cloud2.show();
  world.step();  //get box2D to calculate all the forces and new positions
  world.draw();  //ask box2D to convert this world to processing screen coordinates and draw
  cloud1.show();
  gravityB.show();
  fBodiesB.show();
  
  if (fBodiesB.clicked) {
    if (fBodies == true) {
      fBodies = false;
    } else if (fBodies == false) {
      fBodies = true;
    }
  }
  
  if (gravityB.clicked) {
    if (gravity == true) {
      gravity = false;
      world.setGravity(0, 0);
    } else if (gravity == false) {
      gravity = true;
      world.setGravity(0, 900);
    }
  }
}

//=====================================================================================================================================
void makeCircle() {
  FCircle circle = new FCircle(50);
  circle.setPosition(random(width), -5);
  //set visuals
  circle.setStroke(0);
  circle.setStrokeWeight(2);
  circle.setFillColor(red);
  //set physical properties
  circle.setDensity(0.2);
  circle.setFriction(1);
  circle.setRestitution(1);
  //add to world
  world.add(circle);
}
//=====================================================================================================================================
void makeBlob() {
  FBlob blob = new FBlob();
  //set visuals
  blob.setAsCircle(random(width), -5, 50);
  blob.setStroke(0);
  blob.setStrokeWeight(2);
  blob.setFillColor(yellow);
  //set physical properties
  blob.setDensity(0.2);
  blob.setFriction(1);
  blob.setRestitution(0.25);
  //add to the world
  world.add(blob);
}
//=====================================================================================================================================
void makeBox() {
  FBox box = new FBox(40, 40);
  box.setPosition(random(width), -5);
  //set visuals
  box.setStroke(0);
  box.setStrokeWeight(2);
  box.setFillColor(green);
  //set physical properties
  box.setDensity(0.2);
  box.setFriction(1);
  box.setRestitution(1);
  world.add(box);
}
//=====================================================================================================================================
void makeBird() {
  FCircle bird = new FCircle(48);
  bird.setPosition(random(width), -5);
  //set visuals
  bird.attachImage(redBird);
  //set physical properties
  bird.setDensity(0.8);
  bird.setFriction(1);
  bird.setRestitution(0.5);
  world.add(bird);
}
