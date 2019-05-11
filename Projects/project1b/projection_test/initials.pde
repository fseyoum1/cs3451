/******************************************************************************
Draw your initials here in perspective.
******************************************************************************/

void persp_initials()
{
gtBeginShape();


 gtInitialize();
  gtPerspective (60.0, 1.0, 100.0);

  gtPushMatrix();
  gtTranslate (0.0, 0.0, -4.0);
 gtScale(0.5,0.5,0.5);
 gtRotateX(-50);
  
  
  gtBeginShape();

  /* top square */
  
  // fitstum verticale F
  gtVertex (-1.5, -1.5,  1.0);
  gtVertex (-1.5,  1.5,  1.0);

  // fitsum Top F
  gtVertex (-1.5,  1.5,  1.0);
  gtVertex ( 0.0,  1.5,  1.0);

  //second line for fitsum(F)
  gtVertex ( -1.5, 0.5,  1.0);
  gtVertex ( -0.25, 0.5,  1.0);

 

  // last name top horizontal S
  gtVertex ( 0.25,  1.5,  1.0);
  gtVertex ( 1.5,  1.5,  1.0);
  
  // last name vertical s
  gtVertex (0.25, 0.5,  1.0);
  gtVertex (0.25,  1.5,  1.0);
  
  // second horizontal S
  gtVertex ( 0.25, 0.5,  1.0);
  gtVertex ( 1.5, 0.5,  1.0);

  // last name vertical second s
  gtVertex (1.5, 0.5,  1.0);
  gtVertex (1.5,  -1.5,  1.0);
  
  
   // third horizontal S
  gtVertex ( 1.5, -1.5,  1.0);
  gtVertex ( 0.25, -1.5,  1.0);

  
  
  gtEndShape();
 
}
