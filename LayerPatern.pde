class LayerPatern{
  
 ArrayList primitivesList=new ArrayList();
 float w, h, x, y;

 String activePrimitive="ellipse";
 boolean activated=false;
 float sSvg=0.5; 
  
 color cf=color(255, 96);
 color cs=color(255);

 String activeActions="none";
 
 String primitives [] ={"rectangle", "ellipse", "triangle", "star", "hectagon", "hart"};
 
 int minDensity=10;
 PVector densityInit=new PVector(1,1);
 PVector densityEdit=new PVector(1,1);
 PVector dims=new PVector(100,100);
 PVector scaleInit = new PVector(1.0,1.0);
 PVector scaleEdit = new PVector(0.4,0.4);
 PVector strokeWInit=new PVector(1, 1);
 PVector strokeWEdit=new PVector(1, 1);
 
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
      MenuItem item=new MenuItem("action", primitives[i], false, i, x, y, sSvg);
      primitivesList.add(item); 
    }
    
   pRectangles = new ArrayList<Primitive>();
   pEllipses = new ArrayList<Primitive>();
   pStars = new ArrayList<Primitive>();
   pTriangles = new ArrayList<Primitive>();
   pHectagons = new ArrayList<Primitive>();
   pHarts = new ArrayList<Primitive>();
   

   
   for (int iy =0; iy < height; iy+=minDensity){
      for (int ix=0; ix < width; ix+=minDensity)
      {
        pRectangles.add(new Primitive(svgRectangle));
        pEllipses.add(new Primitive(svgEllipse));
        pStars.add(new Primitive(svgStar));
        pTriangles.add(new Primitive(svgTriangle));
        pHectagons.add(new Primitive(svgHectagon));
        pHarts.add(new Primitive(svgHart));
        
      }
   };
  
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
       
       for (int i=0; i<allSvgShapes.length; i++){
         allSvgShapes[i].setStroke(cs);  
         allSvgShapes[i].setFill(cf);
         allSvgShapes[i].setStrokeWeight(sw);
 
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
              Primitive item=(Primitive) pEllipses.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="rectangle"){
              Primitive item=(Primitive) pRectangles.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx); 
            }else if(activePrimitive=="triangle"){
              Primitive item=(Primitive) pTriangles.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx); 
            }else if(activePrimitive=="star"){
              Primitive item=(Primitive) pStars.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="hectagon"){
              Primitive item=(Primitive) pHectagons.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx);
            }else if(activePrimitive=="hart"){
              Primitive item=(Primitive) pHarts.get(index);
              item.display(x, y, 0, widthP+ampx, heightP+ampx);
            }

          }
        }
        
     popStyle(); 
   popMatrix();
   
   
 };

 void drawPrimitivesPicker(PVector left, PVector right){
   
      //activated  =  gestureActions.checkMenuActive(left, right, h);  
      //if(activated==false)return; 
   
      pushMatrix();
      translate(0,0,1);
      
      pushStyle();
        String header="Kies een patroon vorm";
        setTextHeader(header); 
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

