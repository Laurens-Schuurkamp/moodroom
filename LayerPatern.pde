class LayerPatern{
  
 ArrayList primitivesList=new ArrayList();
 float w, h, x, y;

 String activePrimitive="none";
 float sSvg=0.65; 
  
 color cf=color(255,96);
 color cs=color(255);
 String activeAction="none";
 
 String primitives [] ={"rectangle", "ellipse", "triangle", "star", "hectagon", "hart"};
 
 int density=50;
 float wP=25;
 float hP=25;
 
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
      PrimitiveItem item=new PrimitiveItem(primitives[i], i, x, y, sSvg);
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
       
       for (int y=0;y < height; y+=density)
        {
          for (int x=0;x < width; x+=density)
          {
            
            if(activePrimitive=="ellipse"){
               pushMatrix();
                translate(x-wP/w,y-hP/2);
                shape(svgEllipse, 0, 0);
                svgEllipse.setStroke(cs);  
                svgEllipse.setStrokeWeight(1);
                svgEllipse.setFill(cf);
                
              popMatrix();
            }else if(activePrimitive=="rectangle"){
               //rect(x-wP/2, y-hP/2, wP, hP);
              pushMatrix();
                translate(x-wP/w,y-hP/2);
                shape(svgRectangle, 0, 0);
                svgRectangle.setStroke(cs);  
                svgRectangle.setStrokeWeight(1);
                svgRectangle.setFill(cf);
              popMatrix(); 
            }else if(activePrimitive=="triangle"){
               //triangle(x-wP/2, y+hP/2, x+wP/2, y+hP/2, x, y-hP/2);
               pushMatrix();
                translate(x-wP/w,y-hP/2);
                shape(svgTriangle, 0, 0);
                svgTriangle.setStroke(cs);  
                svgTriangle.setStrokeWeight(1);
                svgTriangle.setFill(cf);
              popMatrix(); 
            }else if(activePrimitive=="star"){
              
              pushMatrix();
                translate(x-wP/w,y-hP/2);
                shape(svgStar, 0, 0);
                svgStar.setStroke(cs);  
                svgStar.setStrokeWeight(1);
                svgStar.setFill(cf);
                
              popMatrix();
               
            }else if(activePrimitive=="hectagon"){
              
              pushMatrix();
                translate(x-wP/w,y-hP/2);
                shape(svgHectagon, 0, 0);
                svgHectagon.setStroke(cs);  
                svgHectagon.setStrokeWeight(1);
                svgHectagon.setFill(cf);
              popMatrix();
               
            }else if(activePrimitive=="hart"){
              
              pushMatrix();
                translate(x-wP/w,y-hP/2);
                float sr=random(48);
                shape(svgHart, 0, 0, sr, sr);
                svgHart.setStroke(cs);  
                svgHart.setStrokeWeight(1);
                svgHart.setFill(cf);
               
              popMatrix();
               
            }

          }
        }
        
     popStyle(); 
   popMatrix();
   
   
 };
 
 void drawPrimitivesPicker(float x1, float y1, float x2, float y2){
   
      pushMatrix();
      translate(0,0,1);
      for(int i=0; i<primitivesList.size(); i++){
        
        PrimitiveItem item=(PrimitiveItem) primitivesList.get(i);
        
        if (x1 - (screenWidth/2) > item.x && x1 - (screenWidth/2) < item.x+w && y1-(screenHeight/2) > item.y && y1-(screenHeight/2) < item.y+h &&
            x2 - (screenWidth/2) > item.x && x2 - (screenWidth/2) < item.x+w && y2-(screenHeight/2) > item.y && y2-(screenHeight/2) < item.y+h) {
            activePrimitive=item.primitive;  
            
            shape(item.edgeOver, item.x, item.y);

        };
        
        shape(item.iconSvg, item.x, item.y);
      };
      popMatrix();

 };
 
  
}


class PrimitiveItem{
  
  int id;
  String primitive;
  PImage icon;
  float x, y;
  PShape iconSvg;
  PShape edgeOver = loadShape("data/gui/menu/icon_edgeOver.svg");  
  
  PrimitiveItem(String _primitive, int _id, float _x, float _y, float sSvg){
    id=_id;
    x=_x;
    y=_y;
    primitive = _primitive;   
    iconSvg = loadShape("data/gui/menu/icon_"+primitive+".svg");
    iconSvg.scale(sSvg);
    edgeOver.scale(sSvg);
    
    println("adding action :"+_primitive);
  }
  
  
}

//class Star{
//  PShape star = loadShape("data/gui/primitives/primitives_star.svg");
//  
//}
