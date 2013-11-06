class LayerPatern{
  
 ArrayList primitivesList=new ArrayList();
 float w, h, x, y;

 String activePrimitive="none";
 boolean activated;
 
 boolean enabled=true;
 
 float sSvg=0.45; 
  
 color cf=color(255, 96);
 color cs=color(255);
 
 float strokeWidth=1;
 String activeActions="none";
 
 String primitives [] ={"rectangle", "ellipse", "triangle", "star", "hectagon", "hart", "none"};
 
 PVector density=new PVector(1,1);
 PVector dims=new PVector(50,50);
 PVector scaling=new PVector(0.9,0.9);
 PVector strokeW=new PVector(1,1);
 
 PShape svgRectangle = loadShape("data/gui/primitives/primitives_rectangle.svg");
 PShape svgEllipse = loadShape("data/gui/primitives/primitives_ellipse.svg");
 PShape svgStar = loadShape("data/gui/primitives/primitives_star.svg");
 PShape svgTriangle = loadShape("data/gui/primitives/primitives_triangle.svg");
 PShape svgHectagon = loadShape("data/gui/primitives/primitives_hectagon.svg");
 PShape svgHart = loadShape("data/gui/primitives/primitives_hart.svg");
 
 PShape allSvgShapes []= {svgRectangle, svgEllipse, svgStar, svgTriangle, svgHectagon, svgHart};
 LayerPatern(){
  println("layer patern contructor");

    w = 320*s*sSvg;
    h = 240*s*sSvg;
    
    println("w ="+w);
    float widthTotal=(w*primitives.length)+(padding*primitives.length)+padding;
    String subsPrimitives []={};
    int i;
    for(i=0; i<primitives.length; i++){
      
      float x= -widthTotal/2 + (i*(w+padding)) + padding;
      float y= -h/2;
      
      MenuItem item=new MenuItem("action", primitives[i], i, x, y, sSvg);
      primitivesList.add(item); 
      
    }
  
 };

 void drawLayer(){
   
   
   
   if(activePrimitive=="none") return;

   pushMatrix();
     translate(0,0,1);
//      pushStyle();
//        setTextHeader(h, "none"); 
//      popStyle();
   
     pushStyle();
       fill(cf);
       stroke(cs);
       float sw=strokeW.x;
       translate(-width/2, -height/2);
              
       
       float stepx=density.x*50;
       float stepy=density.y*50;
       
       if(stepx<25)stepx=25;
       if(stepy<25)stepy=25;
       
       
       
       float widthP=dims.x*scaling.x;
       float heightP=dims.y*scaling.y;
       
       for (int i=0; i<allSvgShapes.length; i++){
         allSvgShapes[i].setStroke(cs);  
         allSvgShapes[i].setStrokeWeight(strokeWidth);
         allSvgShapes[i].setFill(cf);
         allSvgShapes[i].setStrokeWeight(sw);
       };
       
       
       
       for (int y=0;y < height; y+=stepy)
        {
          for (int x=0;x < width; x+=stepx)
          {
            //float xpos=
            int spc =(int) random(fft.specSize());    
            float ampx = fft.getBand(  spc )*amp;
            
            
            if(activePrimitive=="ellipse"){
               pushMatrix();
                translate(x,y);
                shape(svgEllipse, 0, 0, widthP+ampx, heightP+ampx);
//                svgEllipse.setStroke(cs);  
//                svgEllipse.setStrokeWeight(strokeWidth);
//                svgEllipse.setFill(cf);
//                svgEllipse.setStrokeWeight(sw);
                
              popMatrix();
            }else if(activePrimitive=="rectangle"){
               //rect(x-dims.x/2, y-hP/2, dims.x, hP);
              pushMatrix();
                translate(x,y);
                shape(svgRectangle, 0, 0, widthP+ampx, heightP+ampx);
//                svgRectangle.setStroke(cs);  
//                svgRectangle.setStrokeWeight(strokeWidth);
//                svgRectangle.setFill(cf);
//                svgRectangle.setStrokeWeight(sw);
              popMatrix(); 
            }else if(activePrimitive=="triangle"){
               //triangle(x-dims.x/2, y+hP/2, x+/2, y+hP/2, x, y-hP/2);
               pushMatrix();
                translate(x,y);
                shape(svgTriangle, 0, 0, widthP+ampx, heightP+ampx);
//                svgTriangle.setStroke(cs);  
//                svgTriangle.setStrokeWeight(strokeWidth);
//                svgTriangle.setFill(cf);
//                svgTriangle.setStrokeWeight(sw);
              popMatrix(); 
            }else if(activePrimitive=="star"){
              
              pushMatrix();
                translate(x,y);
                shape(svgStar, 0, 0, widthP+ampx, heightP+ampx);
//                svgStar.setStroke(cs);  
//                svgStar.setStrokeWeight(strokeWidth);
//                svgStar.setFill(cf);
//                svgStar.setStrokeWeight(sw);
              popMatrix();
               
            }else if(activePrimitive=="hectagon"){
              
              pushMatrix();
                translate(x,y);
                shape(svgHectagon, 0, 0, widthP+ampx, heightP+ampx);
//                svgHectagon.setStroke(cs);  
//                svgHectagon.setStrokeWeight(strokeWidth);
//                svgHectagon.setFill(cf);
//                svgHectagon.setStrokeWeight(sw);
              popMatrix();
               
            }else if(activePrimitive=="hart"){
              
              pushMatrix();
                translate(x,y);
                
                shape(svgHart, 0, 0, widthP+ampx, heightP+ampx);
//                svgHart.setStroke(cs);  
//                svgHart.setStrokeWeight(strokeWidth);
//                svgHart.setFill(cf);
//                svgHart.setStrokeWeight(sw);
               
              popMatrix();
               
            }

          }
        }
        
     popStyle(); 
   popMatrix();
   
   
 };

 
// void setAction(PVector left, PVector right, String action){
//     if(action=="primitives"){
//         drawPrimitivesPicker(left, right);
//     }else if (action=="size"){
//       boolean isActive=gestureActions.scalingActive(left, right);
//       if(isActive ){
//         scaling=gestureActions.setScale(left, right, scaling);
//       }
//       
//     }else if(action=="density"){
//       boolean isActive=gestureActions.scalingActive(left, right);
//       if(isActive ){
//         density=gestureActions.setScale(left, right, density);
//       }
//       
//     }
//   
//   
// }
 
 void drawPrimitivesPicker(PVector left, PVector right){
   
      //activated  =  gestureActions.checkMenuActive(left, right, h);  
      //if(activated==false)return; 
   
      pushMatrix();
      translate(0,0,1);
      
      pushStyle();
        fill(0);
        rect(-width/2, -(h/2)-padding, width, h+(2*padding) );
      popStyle();
      
      boolean hit=false;
      
      for(int i=0; i<primitivesList.size(); i++){
        
        MenuItem item=(MenuItem) primitivesList.get(i);
        boolean leftHit=gestureActions.checkSingleHitId(item, left, w, h);
        boolean rightHit=gestureActions.checkSingleHitId(item, right, w, h);
   
       if(leftHit || rightHit){
         activePrimitive=item.item;
         boolean timed = timer.setTimer(item.x, item.y, item.item);
         if(timed){
                // set menu action
                activePrimitive=item.item;
                subMenu.activeActions="none";
                actionsMenu.activeAction="none";
                timer.activeId="none";
                 
          };

       };
  
        shape(item.iconSvg, item.x, item.y);
            

        
      };
      popMatrix();


   };
   
   
   
   
 
  
}
//end class layer

//class Star{
//  PShape star = loadShape("data/gui/primitives/primitives_star.svg");
//  
//}
