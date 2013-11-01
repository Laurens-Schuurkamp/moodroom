class MainMenu
{
  boolean activated=true;
  
  ArrayList menuList=new ArrayList();
  //String menuItems []={"bckgr", "raster", "pointcloud", "beateffect", "wave", "skellet"};
  String menuItems []={"bckgr", "raster", "pointcloud"};
  float w, h, x, y;
  float offsetX;
  float padding=24*s;

  
  
  int activeHitId=-1;
  int rTimer=66;

  MainMenu(){
    println("mainMenu constructor");

    w = 320*s;
    h = 240*s;
    
    println("w ="+w);
    float widthTotal=(w*menuItems.length)+(padding*menuItems.length)+padding;
    int i;
    for(i=0; i<menuItems.length; i++){
      
      float x= -widthTotal/2 + (i*(w+padding));
      float y= -h/2;
      MainMenuItem item=new MainMenuItem(menuItems[i], i, x, y);
      menuList.add(item); 
      
    }

  }
  
  void drawMenu(){
      if(activated==false)return;
    
      int hitId=-1;
      
      for(int i=0; i<menuList.size(); i++){
        
        MainMenuItem item=(MainMenuItem) menuList.get(i);
        shape(item.iconSvg, item.x, item.y);
        
        if (mouseX - (screenWidth/2) > item.x && mouseX - (screenWidth/2) < item.x+w && mouseY-(screenHeight/2) > item.y && mouseY-(screenHeight/2) < item.y+h) {
            hitId = item.id;
            
            if(activeHitId!=hitId){
              timer.timeActivation=millis();
              activeHitId=item.id;
              
            }else if(activeHitId==hitId){
              boolean timed= timer.setTimer(item.x, item.y);
              if(timed){
                // set menu action
                hitId=-1;
               //activated=false; 
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
  String item;
  PVector pos;
  PImage icon;
  float x, y;
  PShape iconSvg;
  PShape edgeOver = loadShape("data/gui/menu/icon_edgeOver.svg");  
  
  MainMenuItem(String _item, int _id, float _x, float _y){
    id=_id;
    println("mainMenuItem constructor");
    x=_x;
    y=_y;
    item = _item;   
    iconSvg = loadShape("data/gui/menu/icon_"+item+".svg");
  }
  
  
}
