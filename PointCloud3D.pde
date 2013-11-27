
class PointCloud3D
{
  String activePrimitive="ellipse";
  boolean activated=false;
  color cf = color(255, 255);
  color cs = color (255, 255);
  
  int minDensity=12;
  PVector densityInit=new PVector(0.5,0.5);
  PVector densityEdit=new PVector(1,1);
  PVector dims=new PVector(24,24);
  PVector scaleInit = new PVector(1.0, 1.0);
  PVector scaleEdit = new PVector(1.0, 1.0);
  PVector strokeWInit=new PVector(1,1);
  PVector strokeWEdit=new PVector(1,1);
  
  Primitives primitives;
   
  PointCloud3D(){
    println("PointCloud3D constructor");
    primitives = new Primitives(640, 480, 8);

    
  }
  
  void reset(){
    activePrimitive="ellipse";
    activated=false;
    densityInit.set(1,1);
    densityEdit.set(1,1);
    dims.set(24,24);
    scaleInit.set(1.0, 1.0);
    scaleEdit.set(1.0, 1.0);
    strokeWInit.set(1,1);
    strokeWEdit.set(1,1);
    
  };
  
  void drawPointCloud(int[] userList){
    
    if(demoModus) return;
    if(!activated) return;
    if(activePrimitive=="none") return;
    if(userList.length <= 0)  return;
    

       int [] depthMap = context.depthMap();
       int     stepsX   =parseInt( (densityInit.y*densityEdit.y)*50);
       int     stepsY   =parseInt( (densityInit.y*densityEdit.y)*50);

       float widthP=dims.x*(scaleInit.x*scaleEdit.x);
       float heightP=dims.y*(scaleInit.y*scaleEdit.y);

       int index=0;
       int pIndex = 0;
       PVector realWorldPoint;

       PVector [] usersCenter= new PVector [userList.length] ;
       
       for (int i=0; i < userList.length; i++){
           usersCenter[i]=skelleton.getBodyCenter(userList[i]);
       };       

       pushStyle(); 
       
       for (int i=0; i<primitives.allSvgShapes.length; i++){
           
         primitives.allSvgShapes[i].setFill(cf);
         primitives.allSvgShapes[i].setStroke(false);
 
       };

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
                  //float d = abs(usersCenter[u].dist(realWorldPoint)); 
                  
                  if(d<900){
                     pushMatrix();
                    translate(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
                      if(activePrimitive=="ellipse"){
                        primitives.pEllipse.display(0, 0, 0, widthP, heightP);
                      }else if(activePrimitive=="rectangle"){
                        primitives.pRectangle.display(0, 0, 0, widthP, heightP);
                      }else if(activePrimitive=="triangle"){
                        primitives.pTriangle.display(0, 0, 0, widthP, heightP);
                      }else if(activePrimitive=="star"){
                        primitives.pStar.display(0, 0, 0, widthP, heightP);
                      }else if(activePrimitive=="hectagon"){
                        primitives.pHectagon.display(0, 0, 0, widthP, heightP);
                      }else if(activePrimitive=="hart"){
                        primitives.pHart.display(0, 0, 0, widthP, heightP);
                      }else if(activePrimitive=="cross"){
                        primitives.pCross.display(0, 0, 0, widthP, heightP);
                      }

                    //pIndex++;
                    popMatrix();
                    //vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
                  };

                };
              }

            }
            

          }


       popStyle();
 
  }; 
  
}



