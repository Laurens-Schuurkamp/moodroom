
class PointCloud3D
{

  boolean activated=true;
  color cf = color(255, 255);
  color cs = color (255, 255);
  
   int stepSize=32;
   
   PVector densityInit=new PVector(0.25,0.25);
   PVector densityEdit=new PVector(1,1);
   PVector dims=new PVector(32,32);
   PVector scaling=new PVector(1,1);
   PVector strokeWInit=new PVector(2,2);
   PVector strokeWEdit=new PVector(1,1);
   
   ArrayList<Primitive> pRectangles;
   ArrayList<Primitive> pEllipses;
   ArrayList<Primitive> pStars;
   ArrayList<Primitive> pTriangles;
   ArrayList<Primitive> pHectagons;
   ArrayList<Primitive> pHarts;
   
   PShape svgRectangle = loadShape("data/gui/primitives/primitives_rectangle.svg");
   PShape svgEllipse = loadShape("data/gui/primitives/primitives_ellipse.svg");
   PShape svgStar = loadShape("data/gui/primitives/primitives_star.svg");
   PShape svgTriangle = loadShape("data/gui/primitives/primitives_triangle.svg");
   PShape svgHectagon = loadShape("data/gui/primitives/primitives_hectagon.svg");
   PShape svgHart = loadShape("data/gui/primitives/primitives_hart.svg");
   
   PShape allSvgShapes []= {svgRectangle, svgEllipse, svgStar, svgTriangle, svgHectagon, svgHart};
   
   
   
  PointCloud3D(){
    println("PointCloud3D constructor");
    
  }
  
  void drawPointCloud(int[] userList){
    
    if(demoModus) return;
    if(!activated) return;
    if(userList.length <= 0)  return;
    
       int [] depthMap = context.depthMap();
       int     stepsX   =parseInt( (densityInit.y*densityEdit.y)*stepSize);
       int     stepsY   =parseInt( (densityInit.y*densityEdit.y)*stepSize);

       int     index=0;
       PVector realWorldPoint;

       PVector [] usersCenter= new PVector [userList.length] ;
       
       for (int i=0; i < userList.length; i++){
           usersCenter[i]=skelleton.getBodyCenter(userList[i]);
       };       

       pushStyle(); 
         
         float sw=(strokeWInit.x*strokeWEdit.x);
         stroke(cs);
         
        strokeWeight(parseInt(sw));
        noFill();

        beginShape(POINTS);
         for (int x=0;x < depthWidth; x+=stepsX)
          {
            
            for (int y=0;y < depthHeigth; y+=stepsY)
            {
              
              index = x + y * depthHeigth;
              if (depthMap[index] > 0)
              { 
                // draw the projected point
                realWorldPoint = context.depthMapRealWorld()[index];
                //vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
                for (int u=0; u<usersCenter.length; u++){
                  float d = abs(dist(usersCenter[u].x, usersCenter[u].z, realWorldPoint.x, realWorldPoint.z));   
                  if(d<900){
                    vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
                  };

                };
              }

            }
            

          }
          endShape();
         
         
         //verical
//         for (int x=0;x < depthWidth; x+=stepsX)
//          {
//            beginShape(LINES);
//            for (int y=0;y < depthHeigth; y+=stepsY)
//            {
//              index = x + y * depthWidth;
//              if (depthMap[index] > 0)
//              { 
//                // draw the projected point
//                realWorldPoint = context.depthMapRealWorld()[index];              
//                //point(realWorldPoint.x, realWorldPoint.y, (realWorldPoint.z-layerSound.beatAmp));
//                vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
//                //ellipse(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z, 10);
//
//
//              }
//            }
//            endShape();
//            
//          }
        
            //horizontal
//          for (int y=0;y < depthHeigth; y+=stepsY)
//          {
//            beginShape(LINES);
//            for (int x=0;x < depthWidth; x+=stepsX)
//            {
//              index = x + y * depthWidth;
//              if (depthMap[index] > 0)
//              { 
//                // draw the projected point
//                realWorldPoint = context.depthMapRealWorld()[index];              
//                //point(realWorldPoint.x, realWorldPoint.y, (realWorldPoint.z-layerSound.beatAmp));
//                float vx = map(realWorldPoint.x, 0, context.depthWidth(), 0, width);
//                float vy = map(realWorldPoint.y, 0, context.depthHeight(), 0, height);
//                
//                
//                vertex(vx, vy, 0);
//                vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
//                //ellipse(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z, 10);
//
//
//              }
//            }
//            endShape();
//            
//          }

       popStyle();
 
  }; 
  
}



