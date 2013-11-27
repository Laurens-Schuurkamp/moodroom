class LayerPatern{
 
 String activePrimitive="ellipse";
 boolean activated=true;
 
 color cf=color(255, 96);
 color cs=color(255);

 String activeActions="none";
 
 int minDensity=10;
 PVector densityInit=new PVector(1,1);
 PVector densityEdit=new PVector(1,1);
 PVector dims=new PVector(40,40);
 PVector scaleInit = new PVector(1.0, 1.0);
 PVector scaleEdit = new PVector(1.0, 1.0);
 PVector strokeWInit=new PVector(1, 1);
 PVector strokeWEdit=new PVector(1, 1);

 Primitives primitives; 

 LayerPatern(){
  println("layer patern contructor");
  primitives = new Primitives(width, height, minDensity);

 };
 
 void reset(){
   activePrimitive="ellipse";
   activated=false;
   densityInit.set(1,1);
   densityEdit.set(1,1);
   dims.set(40,40);
   scaleInit.set(1.0, 1.0);
   scaleEdit.set(1.0, 1.0);
   strokeWInit.set(1, 1);
   strokeWEdit.set(1, 1);

 }

 void drawLayer(){

   if(activePrimitive=="none") return;
   if(!activated)return;
   pushMatrix();
     translate(0,0,0);
   
     pushStyle();
       fill(cf);
       stroke(cs);
       
       translate(-width/2, -height/2);
       
       float sw=(strokeWInit.x*strokeWEdit.x);
                    
       float stepx=(densityInit.x*densityEdit.x)*50;
       float stepy=(densityInit.y*densityEdit.y)*50;
       
       float widthP=dims.x*(scaleInit.x*scaleEdit.x);
       float heightP=dims.y*(scaleInit.y*scaleEdit.y);
       
       for (int i=0; i<primitives.allSvgShapes.length; i++){
         primitives.allSvgShapes[i].setStroke(cs);  
         primitives.allSvgShapes[i].setFill(cf);
         primitives.allSvgShapes[i].setStrokeWeight(sw);
 
       };
       
       int index=0;
       for (int y=0;y < height; y+=stepy)
        {
          for (int x=0;x < width; x+=stepx)
          {

            float ampx=0;
            float ampy=0;
            if(layerSound.activated){
              int spc =(int) random(fft.specSize());    
              ampx = fft.getBand(  spc )*layerSound.amp;
            };

            if(activePrimitive=="ellipse"){
              primitives.pEllipse.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="rectangle"){
              primitives.pRectangle.display(x, y, 0, widthP+ampx, heightP+ampx); 
            }else if(activePrimitive=="triangle"){
              primitives.pTriangle.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="star"){
              primitives.pStar.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="hectagon"){
              primitives.pHectagon.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="hart"){
              primitives.pHart.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="cross"){
              primitives.pCross.display(x, y, 0, widthP+ampx, heightP+ampx);
            }
            
            //index++;

          }
        }
        
     popStyle(); 
   popMatrix();
   
   
 };

 

}

