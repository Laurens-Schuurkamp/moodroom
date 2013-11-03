class LayerPatern{
  
 ArrayList primitivesList=new ArrayList();
 float w, h, x, y;

 String activePrimitive="none";
 boolean activated;
 
 float sSvg=0.65; 
  
 color cf=color(255,96);
 color cs=color(255);
 float strokeWidth=1;
 String activeAction="none";
 
 boolean isScaling=false;
 float deltaOrg=0;
 
 float distXorg=0;
 float distYorg=0;
 
 String primitives [] ={"rectangle", "ellipse", "triangle", "star", "hectagon", "hart"};
 
 int densityX=50;
 int densityY=50;
 float wP=25;
 float hP=25;
 float sX=1.0;
 float sY=1.0;
 
 PShape svgRectangle = loadShape("data/gui/primitives/primitives_rectangle.svg");
 PShape svgEllipse = loadShape("data/gui/primitives/primitives_ellipse.svg");
 PShape svgStar = loadShape("data/gui/primitives/primitives_star.svg");
 PShape svgTriangle = loadShape("data/gui/primitives/primitives_triangle.svg");
 PShape svgHectagon = loadShape("data/gui/primitives/primitives_hectagon.svg");
 PShape svgHart = loadShape("data/gui/primitives/primitives_hart.svg");
  
 LayerPatern(){
  println("layer patern contructor");

    w = 320*s*sSvg;
    h = 240*s*sSvg;
    
    println("w ="+w);
    float widthTotal=(w*primitives.length)+(padding*primitives.length)+padding;
    int i;
    for(i=0; i<primitives.length; i++){
      
      float x= -widthTotal/2 + (i*(w+padding));
      float y= -h/2;
      MenuItem item=new MenuItem(primitives[i], i, x, y, sSvg);
      primitivesList.add(item); 
      
    }
  
 };

 void drawLayer(){
   
   if(activePrimitive=="none") return;
   pushMatrix();
     pushStyle();
       fill(cf);
       stroke(cs);
       translate(-width/2, -height/2);
       
       float widthP=wP*sX;
       float heightP=hP*sY;
       
       for (int y=0;y < height; y+=densityY)
        {
          for (int x=0;x < width; x+=densityX)
          {
            
            if(activePrimitive=="ellipse"){
               pushMatrix();
                translate(x,y);
                shape(svgEllipse, 0, 0, widthP, heightP);
                svgEllipse.setStroke(cs);  
                svgEllipse.setStrokeWeight(strokeWidth);
                svgEllipse.setFill(cf);
                
              popMatrix();
            }else if(activePrimitive=="rectangle"){
               //rect(x-wP/2, y-hP/2, wP, hP);
              pushMatrix();
                translate(x,y);
                shape(svgRectangle, 0, 0, widthP, heightP);
                svgRectangle.setStroke(cs);  
                svgRectangle.setStrokeWeight(strokeWidth);
                svgRectangle.setFill(cf);
              popMatrix(); 
            }else if(activePrimitive=="triangle"){
               //triangle(x-wP/2, y+hP/2, x+wP/2, y+hP/2, x, y-hP/2);
               pushMatrix();
                translate(x,y);
                shape(svgTriangle, 0, 0, widthP, heightP);
                svgTriangle.setStroke(cs);  
                svgTriangle.setStrokeWeight(strokeWidth);
                svgTriangle.setFill(cf);
              popMatrix(); 
            }else if(activePrimitive=="star"){
              
              pushMatrix();
                translate(x,y);
                shape(svgStar, 0, 0, widthP, heightP);
                svgStar.setStroke(cs);  
                svgStar.setStrokeWeight(strokeWidth);
                svgStar.setFill(cf);
                
              popMatrix();
               
            }else if(activePrimitive=="hectagon"){
              
              pushMatrix();
                translate(x,y);
                shape(svgHectagon, 0, 0, widthP, heightP);
                svgHectagon.setStroke(cs);  
                svgHectagon.setStrokeWeight(strokeWidth);
                svgHectagon.setFill(cf);
              popMatrix();
               
            }else if(activePrimitive=="hart"){
              
              pushMatrix();
                translate(x,y);
                
                shape(svgHart, 0, 0, widthP, heightP);
                svgHart.setStroke(cs);  
                svgHart.setStrokeWeight(strokeWidth);
                svgHart.setFill(cf);
               
              popMatrix();
               
            }

          }
        }
        
     popStyle(); 
   popMatrix();
   
   
 };
 
 void setProperties( ){
   
 };
 
 void setAction(PVector left, PVector right, String action){
     if(action=="primitives"){
         drawPrimitivesPicker(left, right);
     }else{
       setScaling(left, right);
     }
   
   
 }
 
 void drawPrimitivesPicker(PVector left, PVector right){
   
      activated  =  gestureActions.checkMenuActive(left, right, h);  
      if(activated==false)return; 
   
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
   
       if(leftHit && rightHit){
         boolean timed = timer.setTimer(item.x, item.y, item.id);
         if(timed){
                // set menu action
                activePrimitive=item.item;
                timer.activeId=-1;
                 
          };

       };     

        shape(item.iconSvg, item.x, item.y);
      };
      popMatrix();


   };
   
   void setScaling(PVector left, PVector right){
     
     float offset=220*s;
     
     if(isScaling){
       setScale(left, right, offset);
       return;
     }
     
     int i;
     
      PVector tl=new PVector(-offset, -offset);
      PVector bl=new PVector(-offset, offset);
      
      PVector tr=new PVector(offset, -offset);
      PVector br=new PVector(offset, offset);
      
      float hitSize=handSize/2;
     
       for(i=0; i<2; i++){
         if(i==0){
           //top
           
           HandLeft hl=new HandLeft(tl.x, tl.y, false);
           HandRight hr=new HandRight(tr.x, tr.y, false);
           
         }else if(i==1){
           //bottem
           HandLeft hl=new HandLeft(bl.x, bl.y, false);
           HandRight hr=new HandRight(br.x, br.y, false);           
         }
         
       };

       boolean rightHit=false;
       boolean leftHit=false;
       
       leftHit=gestureActions.zoomGestureActivation(left.x, left.y, tl,  bl, hitSize);
       rightHit=gestureActions.zoomGestureActivation(right.x, right.y, tr,  br, hitSize);
       

       if(demoModus){
        HandLeft demo=new HandLeft(bl.x, bl.y, true); 
        leftHit=true;
       } 
        
       handSvgRuser.setStroke(color(255));
       handSvgLuser.setStroke(color(255));
       
       if(rightHit)  handSvgRuser.setStroke(handFeedBack);
       if(leftHit)  handSvgLuser.setStroke(handFeedBack);
       
       if(leftHit && rightHit){
           boolean timed = timer.setTimer(0, 0, 100);
           if(timed){
             timer.activeId=-1;
             if(demoModus){
                left.x=-offset*s;
                left.y=offset*s;
              }; 
             distXorg=right.x-left.x;
             distYorg=right.y-left.y;
             deltaOrg = dist(left.x, left.y, right.x, right.y);
             isScaling=true;
           }

         
       };
       
       

   };
   
   void setScale(PVector left, PVector right, float offset){
    
     if(demoModus){
       left.x=-offset*s;
       left.y=offset*s;
    }; 

     float distX=right.x-left.x;
     float distY=right.y-left.y;
     
     sX=distX/distXorg;
     sY=distY/distYorg;
     
     float deltaNew=dist(left.x, left.y, right.x, right.y);
     //println(deltaOrg/deltaNew);
     
     if( (deltaOrg/deltaNew)>0.99 && (deltaOrg/deltaNew)<1.01 ){
       
       boolean timed = timer.setTimer(0, 0, 101);
           if(timed){
             subMenu.activeAction="none";
             isScaling=false;
             timer.activeId=-1;
             deltaOrg=0;
             
           }
     }else{
       timer.activeId=-1;
     };
     
     deltaOrg=deltaNew;

   }
 
  
}
//end class layer

//class Star{
//  PShape star = loadShape("data/gui/primitives/primitives_star.svg");
//  
//}
