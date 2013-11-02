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
                shape(svgEllipse, 0, 0, widthP, widthP);
                svgEllipse.setStroke(cs);  
                svgEllipse.setStrokeWeight(strokeWidth);
                svgEllipse.setFill(cf);
                
              popMatrix();
            }else if(activePrimitive=="rectangle"){
               //rect(x-wP/2, y-hP/2, wP, hP);
              pushMatrix();
                translate(x,y);
                shape(svgRectangle, 0, 0, widthP, widthP);
                svgRectangle.setStroke(cs);  
                svgRectangle.setStrokeWeight(strokeWidth);
                svgRectangle.setFill(cf);
              popMatrix(); 
            }else if(activePrimitive=="triangle"){
               //triangle(x-wP/2, y+hP/2, x+wP/2, y+hP/2, x, y-hP/2);
               pushMatrix();
                translate(x,y);
                shape(svgTriangle, 0, 0, widthP, widthP);
                svgTriangle.setStroke(cs);  
                svgTriangle.setStrokeWeight(strokeWidth);
                svgTriangle.setFill(cf);
              popMatrix(); 
            }else if(activePrimitive=="star"){
              
              pushMatrix();
                translate(x,y);
                shape(svgStar, 0, 0, widthP, widthP);
                svgStar.setStroke(cs);  
                svgStar.setStrokeWeight(strokeWidth);
                svgStar.setFill(cf);
                
              popMatrix();
               
            }else if(activePrimitive=="hectagon"){
              
              pushMatrix();
                translate(x,y);
                shape(svgHectagon, 0, 0, widthP, widthP);
                svgHectagon.setStroke(cs);  
                svgHectagon.setStrokeWeight(strokeWidth);
                svgHectagon.setFill(cf);
              popMatrix();
               
            }else if(activePrimitive=="hart"){
              
              pushMatrix();
                translate(x,y);
                
                shape(svgHart, 0, 0, widthP, widthP);
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
 
 void drawPrimitivesPicker(float x1, float y1, float x2, float y2){
   
      activated  =  gestureActions.checkMenuActive(y1, y2, h);  
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
        hit=gestureActions.checkHitId(item, x1, y1, x2, y2, w, h);
   
       if(hit){
         boolean timed = timer.setTimer(item.x, item.y, item.id);
         if(timed){
                // set menu action
                activePrimitive=item.item;
                timer.activeId=-1;
                subMenu.activeAction="none"; 
          };

       };     

        shape(item.iconSvg, item.x, item.y);
      };
      popMatrix();


   };
   
   void setScaling(){
     
     
   };
 
  
}
//end class layer

//class Star{
//  PShape star = loadShape("data/gui/primitives/primitives_star.svg");
//  
//}
