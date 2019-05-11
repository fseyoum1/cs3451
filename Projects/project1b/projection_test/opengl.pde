// Dummy routines for OpenGL commands.
// These are for you to write!
// You should incorporate your matrix stack routines from part A of this project.

import java.util.Stack;
import java.util.ArrayList;

// some global variables 
int check = 0;

boolean drawLines=false;

int vertexSize=0;

//GT Perspective
float perK=0;
float nearClip=0;
float farClip=0;

//GT Ortho Stuff
float leftClip=0;
float rightClip=0;
float bottomClip=0;
float topClip=0;



// class to simulate matrix 
public class matrixSimulation {   
  float[][] matrix;
   matrixSimulation() { 
   matrix = new float[4][4];   
  }
}
//vetices 
public class gtVertex { 
  float[] v; 
   gtVertex() {   
   v = new float[4];     
  }  
}
// here is a current transformation matrix
matrixSimulation CTM = new matrixSimulation();
//declared generic stack to hold the marices 
Stack mStack = new Stack<matrixSimulation>();
int stackSize = 0;
// array to hold the vetices whic is generic too
ArrayList vertices = new ArrayList<gtVertex>();

void gtInitialize()
{
  float[][] a = {{1,0,0,0},
                 {0,1,0,0},
                 {0,0,1,0},
                 {0,0,0,1}};
                 
   matrixSimulation iMatrix = new matrixSimulation();
   
   iMatrix.matrix = a;
   
   mStack.add(iMatrix);
   
   CTM = iMatrix;
   stackSize = 1;
  
}

void gtPushMatrix()
{
  
  matrixSimulation pMatrix = new matrixSimulation();
  matrixSimulation peekMatrix = (matrixSimulation)mStack.peek();
  
  for(int i =0; i < 4; i++){
     for (int j = 0; j < 4; j++) {
      
       pMatrix.matrix[i][j] = peekMatrix.matrix[i][j];
       
     }
    
  }
  
  mStack.push(pMatrix);
  CTM = pMatrix;
  stackSize++; 
}

void gtPopMatrix()
{
  
  if (stackSize == 1) {
     println("stack is only one"); 
    
  } else {
    
   mStack.pop();
   CTM = (matrixSimulation)mStack.peek();
   
   stackSize--;
    
  } 
}

//multiplication of two matrices
float[][] gtMatrixMultiply (float[][] firstMatrix, float[][] secondMatrix)
{
  
  float[][] result = new float[4][4];
  
  for (int i = 0; i < firstMatrix.length; i++) {
    for (int j = 0; j < secondMatrix.length; j++) {
      for (int k = 0; k < result.length; k++) {
        result[i][j] += firstMatrix[i][k]*secondMatrix[k][j];
      } 
    }
  } 
  return result;
}

void gtTranslate(float x, float y, float z)
{
  matrixSimulation tMatrix = new matrixSimulation();
  
  float [][] a = {{1,0,0,x},
                  {0,1,0,y},
                  {0,0,1,z},
                  {0,0,0,1}};
                  
  tMatrix.matrix = a;
  
  CTM.matrix = gtMatrixMultiply(CTM.matrix, tMatrix.matrix);
  
}

void gtScale(float x, float y, float z)
{
  matrixSimulation sMatrix = new matrixSimulation();
  float [][]a = { {x,0,0,0},
                  {0,y,0,0},
                  {0,0,z,0},
                  {0,0,0,1}};
  sMatrix.matrix=a;
  CTM.matrix= gtMatrixMultiply(CTM.matrix, sMatrix.matrix);
  
  
}

void gtRotateX(float theta)
{
  matrixSimulation rxMatrix = new matrixSimulation();
  float ang = radians(theta);
  
  float [][] x = { {1,0,0,0},
                  {0, cos(ang), -sin(ang),0},
                  {0, sin(ang), cos(ang),0},
                  {0,0,0,1}};
                  
  rxMatrix.matrix = x;
  
  CTM.matrix = gtMatrixMultiply(CTM.matrix, rxMatrix.matrix);
  
}

void gtRotateY(float theta)
{
  matrixSimulation ryMatrix = new matrixSimulation();
  float ang = radians(theta);
  
  float [][] y = { {cos(ang),0, sin(ang),0},
                  {0, 1, 0 ,0},
                  {-sin(ang), 0, cos(ang),0},
                  {0,0,0,1}};
                  
  ryMatrix.matrix = y;
  
  CTM.matrix = gtMatrixMultiply(CTM.matrix, ryMatrix.matrix);
  
  
}

void gtRotateZ(float theta)
{
  
  matrixSimulation rzMatrix = new matrixSimulation();
  float ang = radians(theta);
  
  float [][] z = { {cos(ang),-sin(ang),0,0},
                  {sin(ang), cos(ang), 0 ,0},
                  {0, 0, 1,0},
                  {0,0,0,1}};
                  
  rzMatrix.matrix = z;
  
  CTM.matrix = gtMatrixMultiply(CTM.matrix, rzMatrix.matrix);
  
  
}

void print_ctm()
{
  matrixSimulation display = (matrixSimulation)mStack.peek();
  for (int i = 0; i < display.matrix.length; i++) {
    for (int j = 0; j < display.matrix.length; j++) {
      print(display.matrix[i][j] + " ");
  }
  println();
  }
  println();
  
}

void gtPerspective(float f, float near, float far)
{
  check = 2;
 
 //fov filed of view 
   float fov=radians(f);
   float k = near*tan(fov/2);
   perK = k;
   nearClip=near;
   farClip=far;
  
  
}

void gtOrtho(float l, float r, float b, float t, float n, float f)
{
  
    check =1;
    leftClip=l;
    rightClip=r;
    bottomClip=b;
    topClip=t;
  
}

void gtBeginShape()
{
  
 drawLines=true;
 vertices.clear();
 vertexSize=0; 
  
}

void gtEndShape()
{
  drawLines=false;
 vertices.clear();
 vertexSize=0;
  
}

float[] multiplyMatrixby1(float[] vertex, float[][] CTM){
  float[]newVertex = new float[4];
  for(int i=0; i < 4; i++){
  newVertex[i] = (CTM[i][0]*vertex[0])+(CTM[i][1]*vertex[1])+(CTM[i][2]*vertex[2])+(CTM[i][3]*vertex[3]);
  }
  return newVertex;
}



void gtVertex(float x, float y, float z)
{
  if(drawLines) {
    gtVertex newVertex = new gtVertex();
    float[] a = {x,y,z,1};
   
    newVertex.v = a;
    vertices.add(newVertex);
    vertexSize++;
    
    
    if(vertexSize == 2) {
     
        gtVertex vStart = (gtVertex) vertices.get(0);
        gtVertex vEnd = (gtVertex) vertices.get(1);
        vStart.v = multiplyMatrixby1(vStart.v, CTM.matrix); 
        vEnd.v = multiplyMatrixby1(vEnd.v, CTM.matrix);
    
        // orthographic 
        if(check == 1) {  
         
             float xStartp =(vStart.v[0] - leftClip) *(width /(rightClip -leftClip));
             float xEnd =(vEnd.v[0] - leftClip) *(width /(rightClip -leftClip));
             
             float yStartp =(vStart.v[1] - topClip) *(height /(bottomClip -topClip));
             float yEnd =(vEnd.v[1] - topClip) *(height /(bottomClip -topClip));
             //draw
             line(xStartp, yStartp, xEnd, yEnd);    
        }
        // perspective case 
        if(check == 2) { 
             
           float xStartp=(nearClip)*(vStart.v[0]/abs(vStart.v[2]));  
           float yStartp=-1*(nearClip)*(vStart.v[1]/abs(vStart.v[2]));
             
           float xEndp=(nearClip)*(vEnd.v[0]/abs(vEnd.v[2]));
           float yEndp=-1*(nearClip)*(vEnd.v[1]/abs(vEnd.v[2]));
             
           vStart.v[0]=(xStartp+perK)*width/(2*perK);
           vEnd.v[0]=(xEndp+perK)*width/(2*perK);
           
           vStart.v[1]=(yStartp+perK)*height/(2*perK);
           vEnd.v[1]=(yEndp+perK)*height/(2*perK);
           //draw
           line(vStart.v[0], vStart.v[1], vEnd.v[0], vEnd.v[1]);
          
        }
    
       vertexSize=0;
       vertices.clear();
    
  }
  
  }
  
}
