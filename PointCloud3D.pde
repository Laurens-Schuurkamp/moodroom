class PointCloud3D
{

  boolean activated=true;
  color cf = color(255, 128);
  color cs = color (255, 128);
  
   int stepSize=20;
   PVector densityInit=new PVector(0.25,0.25);
   PVector densityEdit=new PVector(1,1);
   PVector dims=new PVector(50,50);
   PVector scaling=new PVector(1,1);
   PVector strokeWInit=new PVector(0.25,0.25);
   PVector strokeWEdit=new PVector(1,1);

  PointCloud3D(){
    println("PointCloud3D constructor");
   

  }
  
  void drawPointCloud(){
    
    if(demoModus) return;
    if(!activated) return;

    
    //pointcloud
        int[]   depthMap = context.depthMap();
        
        int     stepsX   =parseInt( (densityInit.x*densityEdit.x)*stepSize);  // to speed up the drawing
        int     stepsY   =parseInt( (densityInit.y*densityEdit.y)*stepSize);
        int     index;
        PVector realWorldPoint;

       pushStyle(); 
         

         
         float sw=(strokeWInit.x*strokeWEdit.x)*4;
         
         stroke(cs);
         strokeWeight(sw);
        for (int y=0;y < context.depthHeight();y+=stepsY)
        {
          for (int x=0;x < context.depthWidth();x+=stepsX)
          {
            index = x + y * context.depthWidth();
            if (depthMap[index] > 0)
            { 
              // draw the projected point
              realWorldPoint = context.depthMapRealWorld()[index];              
              point(realWorldPoint.x, realWorldPoint.y, (realWorldPoint.z-layerSound.beatAmp));
            }
          }
        }
        popStyle();

       
  } 

}
