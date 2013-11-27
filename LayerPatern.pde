class LayerPatern{
 
 String activePrimitive="ellipse";
 boolean activated=true;
 
 color cf=color(255, 96);
 color cs=color(255);

 String activeActions="none";
 
 int minDensity=10;
 PVector densityInit=new PVector(1,1);
 PVector densityEdit=new PVector(1,1);
 PVector dims=new PVector(100,100);
 PVector scaleInit = new PVector(1.0,1.0);
 PVector scaleEdit = new PVector(0.4,0.4);
 PVector strokeWInit=new PVector(1, 1);
 PVector strokeWEdit=new PVector(1, 1);

 Primitives primitives; 

 LayerPatern(){
  println("layer patern contructor");
  primitives = new Primitives(minDensity);

 };

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
              Primitive item=(Primitive) primitives.pEllipses.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="rectangle"){
              Primitive item=(Primitive) primitives.pRectangles.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx); 
            }else if(activePrimitive=="triangle"){
              Primitive item=(Primitive) primitives.pTriangles.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx); 
            }else if(activePrimitive=="star"){
              Primitive item=(Primitive) primitives.pStars.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="hectagon"){
              Primitive item=(Primitive) primitives.pHectagons.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="hart"){
              Primitive item=(Primitive) primitives.pHarts.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx);
            }

          }
        }
        
     popStyle(); 
   popMatrix();
   
   
 };

 

}

