class MainMenu
{
  boolean activated=true;
  String activeLayer="none";
  
  ArrayList menuList=new ArrayList();
  float w, h, x, y;

  //int rTimer=66;
  float sSvg=0.8;

  MainMenu(){
    println("mainMenu constructor");

    w = 320*s*sSvg;
    h = 240*s*sSvg;
    
    println("w ="+w);
    float widthTotal=(w*layers.length)+(padding*layers.length)+padding;
    int i;
    for(i=0; i<layers.length; i++){
      
      float x= -widthTotal/2 + (i*(w+padding)) + padding;
      float y= -h/2;
      MenuItem item=new MenuItem(layers[i], i, x, y, sSvg);
      menuList.add(item); 
      
    }

  }
  
  void drawMenu(PVector left, PVector right){

      if(activeLayer!="none"){
        subMenu.drawSubMenu(left, right, activeLayer);
        return;
        
      };
      
      activated  =  gestureActions.checkMenuActive(left, right, h);  
      if(activated==false)return;
    
      int hitId=-1;

      pushMatrix();
      translate(0,0,1);
      pushStyle();
        fill(0);
        rect(-width/2, -(h/2)-padding, width, h+(2*padding) );
      popStyle();
      boolean hit=false;
      for(int i=0; i<menuList.size(); i++){
        
      MenuItem item=(MenuItem) menuList.get(i);
      boolean leftHit=gestureActions.checkSingleHitId(item, left, w, h);
      boolean rightHit=gestureActions.checkSingleHitId(item, right, w, h);
       
       if(leftHit || rightHit){
         boolean timed = timer.setTimer(item.x, item.y, item.id);
         if(timed){
                // set menu action
                activeLayer=item.item;
                timer.activeId=-1; 
          };

       };
  
       

        shape(item.iconSvg, item.x, item.y);
      };
      
      popMatrix();

  };
    
}



class MenuItem{
  
  int id;
  String item;
  PVector pos;
  PImage icon;
  float x, y;
  PShape iconSvg;
  PShape edgeOver = loadShape("data/gui/menu/icon_edgeOver.svg");  
  
  MenuItem(String _item, int _id, float _x, float _y, float sSvg){
    id=_id;
    x=_x;
    y=_y;
    item = _item;   
    iconSvg = loadShape("data/gui/menu/icon_"+item+".svg");
    iconSvg.scale(sSvg*s);
    edgeOver.scale(sSvg*s);
  }
  
  
}
