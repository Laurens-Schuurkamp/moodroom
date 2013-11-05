class PointCloud3D
{

  boolean activated=false;
  color cf = color(255, 128);
  color cs = color (255, 128);
  
   PVector density=new PVector(0.25,0.25);
   PVector dims=new PVector(50,50);
   PVector scaling=new PVector(1,1);
   PVector strokeW=new PVector(2,2);

  PointCloud3D(){
    println("PointCloud3D constructor");
   

  }
  
  void drawPointCloud(){
    
    if(demoModus) return;
    
    //pointcloud
        int[]   depthMap = context.depthMap();
        //int     steps   = parseInt(density.x*50);  // to speed up the drawing, draw every third point
        
        
        
        int     stepsX   =parseInt(density.x*15);  // to speed up the drawing, draw every third point
        int     stepsY   =parseInt(density.y*15);
        int     index;
        PVector realWorldPoint;
      
        translate(0, 0, -1250);  // set the rotation center of the scene 1000 infront of the camera
      
        
       pushStyle(); 
         
         stroke(cs);
         strokeWeight(strokeW.x);
        for (int y=0;y < context.depthHeight();y+=stepsY)
        {
          for (int x=0;x < context.depthWidth();x+=stepsX)
          {
            index = x + y * context.depthWidth();
            if (depthMap[index] > 0)
            { 
              // draw the projected point
              realWorldPoint = context.depthMapRealWorld()[index];              
              point(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
            }
          }
        }
        popStyle();
       
  } 

}
