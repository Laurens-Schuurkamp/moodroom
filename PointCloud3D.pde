class PointCloud3D
{

  boolean activated=false;

  PointCloud3D(){
    println("PointCloud3D constructor");
   

  }
  
  void drawPointCloud(){
    //pointcloud
        int[]   depthMap = context.depthMap();
        int     steps   = 4;  // to speed up the drawing, draw every third point
        int     index;
        PVector realWorldPoint;
      
        translate(0, 0, -1000);  // set the rotation center of the scene 1000 infront of the camera
      
        stroke(100); 
        for (int y=0;y < context.depthHeight();y+=steps)
        {
          for (int x=0;x < context.depthWidth();x+=steps)
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
       
  } 

}
