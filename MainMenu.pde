class MainMenu
{
  boolean activated=true;
  String activeLayer="none";
  
  ArrayList menuList=new ArrayList();
  float w, h, x, y;

  int activeHitId=-1;
  //int rTimer=66;
  float sSvg=0.9;

  MainMenu(){
    println("mainMenu constructor");

    w = 320*s*sSvg;
    h = 240*s*sSvg;
    
    println("w ="+w);
    float widthTotal=(w*layers.length)+(padding*layers.length)+padding;
    int i;
    for(i=0; i<layers.length; i++){
      
      float x= -widthTotal/2 + (i*(w+padding));
      float y= -h/2;
      MainMenuItem item=new MainMenuItem(layers[i], i, x, y, sSvg);
      menuList.add(item); 
      
    }

  }
  
  void drawMenu(float x1, float y1, float x2, float y2){
      if(activated==false)return;
      
      if(activeLayer!="none"){
        subMenu.drawSubMenu(mouseX, mouseY, mouseX, mouseY, activeLayer);
        return;
        
      };
    
      int hitId=-1;
      
      for(int i=0; i<menuList.size(); i++){
        
        MainMenuItem item=(MainMenuItem) menuList.get(i);
        shape(item.iconSvg, item.x, item.y);
        
        if (x1 - (screenWidth/2) > item.x && x1 - (screenWidth/2) < item.x+w && y1-(screenHeight/2) > item.y && y1-(screenHeight/2) < item.y+h &&
            x2 - (screenWidth/2) > item.x && x2 - (screenWidth/2) < item.x+w && y2-(screenHeight/2) > item.y && y2-(screenHeight/2) < item.y+h) {

          hitId = item.id;
            
            if(activeHitId!=hitId){
              timer.timeActivation=millis();
              activeHitId=item.id;
              
            }else if(activeHitId==hitId){
              boolean timed = timer.setTimer(item.x, item.y);
              if(timed){
                // set menu action
                activeLayer=item.subject;
                hitId=-1; 
              };

            };
            
            shape(item.edgeOver, item.x, item.y);

        };
      };
      
      if(hitId==-1){
        activeHitId=-1;  
      };


  };
    
}



class MainMenuItem{
  
  int id;
  String subject;
  PVector pos;
  PImage icon;
  float x, y;
  PShape iconSvg;
  PShape edgeOver = loadShape("data/gui/menu/icon_edgeOver.svg");  
  
  MainMenuItem(String _subject, int _id, float _x, float _y, float sSvg){
    id=_id;
    x=_x;
    y=_y;
    subject = _subject;   
    iconSvg = loadShape("data/gui/menu/icon_"+subject+".svg");
    iconSvg.scale(sSvg);
    edgeOver.scale(sSvg);
  }
  
  
}
