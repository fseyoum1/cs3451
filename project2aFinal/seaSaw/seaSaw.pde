//will use it to move items from one place to another place
float time = 0;
float angle = 0;
int state = 0;
float a = 1.0;
float b = 1.2;

void setup(){
  size(600,600,P3D);
   noStroke();  
}
void draw () { 
  time += 0.01;
  camera (0.0, 0.0, 100.0, 0.0, 0.0, 0.0, 0.0, -24.0, 10.0);
  background(0,255,0);
  
  directionalLight (102, 102, 102, -0.7, -0.7, -1);
  directionalLight (152, 152, 152, 0, 0, -1);
 
  
  noStroke();
  specular (180, 180, 180);
  
  //rotateY(0.05*time);
  rotateX(-PI/4);
  rotateY(-PI/7);
  rotateZ(PI/4);
  
  //animation of rotation and translation movement
  
  if (time < 10) {
  camera(70.0, 35.0, 120.0, 50.0, 50.0, 0.0, 
       0.0, 1.0, 0.0);
   
      //if you just use 1.5time, time, 0, then you see object moving in diagonal
      // if you use 1.5*time,time,time, comes towards you but moving in diagonal
      //background(0,255,0);
      
      pushMatrix();
      translate(7*time,0,0);
      rotateY(PI/2 + time);
      goingToSeaSaw();
      popMatrix();
      pushMatrix();
      translate(10*time,50,0);
      goingToSeaSaw();
      popMatrix();
    
  
  } else if(time < 30) {
    if(time > 10 && time < 15) {
      camera (70.0, 35.0, 120.0, 10, 10, 0, 0,  1, 0); 
    }  else if (time > 14 && time < 21) {
      
      camera (80, 0, 100, 0, 0, 0, 0,  1, 0);
      
    } else {
      // bottom view of the play 
        camera (0, -50, -100, 0, 0, 0, 0,  1, 0);
    } 
      seaSawBoard();
      shininess(7.0);
      specular(255, 255, 255);
      cylinder(1, 60, 8);
      seaSawBoard3();
      seaSawBoard4(); 
      
      rotateX(2*PI); 
      
  println(time);
  }
  
}

/*
  Here is the code for the seaSaw
  I have instanced two objects in here
  The two character objects are playing a seaSaw
*/


void seaSawBoard() {
     
     fill (25, 50, 100);
     pushMatrix();
     translate (0, 0, 0);
     rotateY(a *sin(b*time));
     shininess(1.5);
     scale(0.9);
     box(100,15,3);
     
     
     pushMatrix();
     // object can easily rotate with the seasaw
     //rotateX(PI/4);
     translate(-45,-3.5, 26.2);
     rotateX(PI/2 + PI);
     mainbody(); // instancing an object, this is for the first object
     popMatrix();
     
     
      pushMatrix();
     // object can easily rotate with the seasaw
     //rotateX(PI/4);
     translate(45,3.5, 26.1);
     rotateX(PI + PI/2);
     rotateY(PI);
     mainbody(); // instancing an object this is for the second object
     popMatrix();
     
     
     pushMatrix();
     rotate(PI/2);
     translate (-2, 38, 10);
     
     pushMatrix();
     translate (-2, -73, 3);
     // seasaw's hand handlers
     fill (255);
     pushMatrix();
     translate(-2,3,20);
     scale(1);
     rotateX(PI/2);
     shininess(1.2);
     cylinder(0.5,14,100);
     
     //top left horiz cylinder
     pushMatrix();
     translate(10, 30, 0);
     fill(255);
     //rotateX(PI/2);
     cylinder(0.5,14,100);
     
     //Top part of left 
     fill (255);
     pushMatrix();
     translate(-28, 10,0);
     rotateZ(PI/2);
     cylinder(0.5,15,100);
     right();
     rightTop();
     rightHorizontal();

     popMatrix();
     //Top part of right end here
   
     popMatrix();
     popMatrix();   
     popMatrix();
     popMatrix();
     popMatrix();
}   

void seaSawBoard2() {
  
 fill (255);
     pushMatrix();
     translate (0, 10, 0);
     shininess(2.5);
     box(60,10,10);
     popMatrix(); 
}

//bottom base box 
void seaSawBoard3() {
  
  fill (166,128,100);
  pushMatrix();
  translate(0,5,-5); 
  box(10,10,-29);
  popMatrix(); 
}

void seaSawBoard4() {
  fill (166,128,100);
  pushMatrix();
  translate(0,55,-5);
  box(10,10,-29);
  popMatrix(); 
}

void right(){
  //right side handler code
  fill (255);
  pushMatrix();
  translate(-30, 12, -65);
  rotateZ(PI/2);
  shininess(1.5);
  cylinder(0.5,15,100);
  popMatrix();
}
void rightTop(){
     fill (255);
     pushMatrix();
     translate(-30, 2, -65);
     rotateZ(PI/2);
     shininess(1.5);
     cylinder(0.5,15,100);
     popMatrix();     
}
void rightHorizontal(){
  //right side handler code
     fill (255);
     pushMatrix();
     translate(-2, 30, -65);
     cylinder(0.5,15,100);
     popMatrix();
}  
 
// Draw a cylinder of a given radius, height and number of sides.
// The base is on the y=0 plane, and it extends vertically in the y direction.
void cylinder (float radius, float height, int sides) {
  translate(0,-30, 0);
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  
  // bottom end cap
  
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  
  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    vertex (0.0, height, 0.0);
    endShape();
  }
  
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}


//character body is produced in here

void mainbody() {
 
  pushMatrix();
  fill(255,255,0);
  translate(2,10,4);
  box(10,30,25);
  popMatrix();
  
 
 //in ward eye
  pushMatrix();
  translate(-22,3,8);
  rotate(PI/2);
  fill(0);
  cylinder(0.4, 8, 100);
  popMatrix();
  
  //out ward eye
  pushMatrix();
  translate(-22,3,0);
  rotate(PI/2);
  fill(0);
  cylinder(0.4, 8, 100);
  popMatrix();
  
  //mouse
  pushMatrix();
  translate(-22,8,4);
  rotate(PI/2);
  fill(0);
  cylinder(0.4, 8, 100);
  popMatrix();
 
  //hand
  pushMatrix();
  translate(2,11,4);
  scale(0.2,0.2,1);
  box(10,7,40);
  popMatrix();
   
  //leg near to me
  //z value helped me to set the width in between 
  pushMatrix();
  translate(3,30,14);
  scale(0.5,0.4,1);  
  cylinder(0.5, 75, 100);
  popMatrix();
  
  //leg inwards
  //y is height 
  pushMatrix();
  translate(2,30, -6);
  scale(0.5,0.4,1);  
  cylinder(0.5, 75, 100);
  popMatrix();
  
  //first show outward
  //working in here 
  pushMatrix();
  translate(5,48,14);
  rotate(PI/2);
  scale(0.5);
  fill(255,255, 0);
  box(2,10,5);  
  popMatrix();
  
  //second shoe inward
  pushMatrix();
  translate(4,48, -6);
  rotate(PI/2);
  scale(0.5);
  fill(255,255, 0);
  box(2,10,5);  
  popMatrix();
  
}

void goingToSeaSaw(){
 
   pushMatrix();
  fill(255,255,0);
  translate(2,10,4);
  box(10,30,25);
  popMatrix();
  
 
 //in ward eye
  pushMatrix();
  //used the y as it is
  //
  translate(-22,3,8);
  rotate(PI/2);
  fill(255);
  cylinder(0.4, 8, 100);
  popMatrix();
  
  //out ward eye
  pushMatrix();
  translate(-22,3,0);
  rotate(PI/2);
  fill(255);
  cylinder(0.4, 8, 100);
  popMatrix();
  
 
 //mouse
  pushMatrix();
  translate(-22,8,4);
  rotate(PI/2);
  fill(255);
  cylinder(0.4, 8, 100);
  popMatrix();
 
 
 
 
  
  //hand
  pushMatrix();
  translate(2,11,4);
  //rotate(PI/4);
  scale(0.2,0.2,1);
  box(10,7,40);
  popMatrix();
   
  
  //leg near to me
  //z value helped me to set the width in between 
  pushMatrix();
  translate(3,30,14);
  scale(0.5,0.4,1);  
  cylinder(0.5, 75, 100);
  popMatrix();
  
  
  //leg inwards
  //y is height 
  // 
  pushMatrix();
  translate(2,30, -6);
  scale(0.5,0.4,1);  
  cylinder(0.5, 75, 100);
  popMatrix();
  
  //first show outward
  //working in here 
  pushMatrix();
  translate(5,48,14);
  rotate(PI/2);
  scale(0.5);
  fill(255,255, 0);
  box(2,10,5);  
  popMatrix();
  
  //second shoe inward
  pushMatrix();
  translate(4,48, -6);
  rotate(PI/2);
  scale(0.5);
  fill(255,255, 0);
  box(2,10,5);  
  popMatrix(); 
    
}
