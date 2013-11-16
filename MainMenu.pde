class MainMenu
{
  boolean activated;
  String activeLayer="none";
   
// String actionsBckgr []={"color", "return"};
// String actionsPatern []={ "disable", "stroke", "size", "primitives", "color", "return"};
// String actionsPointcloud []={"disable", "size", "color", "primitives", "return"};
// String actionsSound []={"disable", "primitives", "vibration", "return"};
 
  ArrayList menuList=new ArrayList();
  float menuHeight=240;
  float w, h, x, y;
  
  float posXmenu;

  //int rTimer=66;
  float sSvg=0.8;

  MainMenu() {
    println("mainMenu constructor");

    w = 320*s*sSvg;
    h = 240*s*sSvg;
    menuHeight=h;

    println("w ="+w);
    float widthTotal=(w*layers.length)+(padding*layers.length)+padding;
    int i;
    for (i=0; i<layers.length; i++) {
      float x= -widthTotal/2 + (i*(w+padding)) + padding;
      float y= -h/2;
      
      MenuItem item=new MenuItem("mainMenu", layers[i], true, i, x, y, sSvg);
      menuList.add(item);
    }
  }
  
  
  void drawMenu(PVector left, PVector right, int id) {
    
    float posXtarget=0;
      if(menuLevel==0){
          posXtarget=0;
      }else if(menuLevel==1){
          posXtarget=-width;
      }else if(menuLevel==2){
          posXtarget=-2*width;
      };
        
    if(mainTweener.isTweening()){
      float tweenPos=mainTweener.position();
      if(tweenPos>=0.99){
        tweenPos=1;
        mainTweener.end();
      }      
      //println("tweener pos ="+mainTweener.position());

      if(posXtarget<posXmenu){
         posXmenu = posXtarget + (( 1-tweenPos )*width); 
      }else{
         posXmenu = (posXtarget-width) + (tweenPos *width);    
      }; 

    }else{
      posXmenu=posXtarget;
      
    };

    subMenu.drawSubMenu(left, right, activeLayer);

    if(menuLevel>0 && !mainTweener.isTweening()) return;
    
    activated  =  gestureActions.checkMenuActive(left, right, h);  
    if (activated==false){
      timer.activeId="none";
      return;
    };

    int hitId=-1;

    pushMatrix();
    translate(posXmenu, 0, 1);
    pushStyle();
      String header="Kies een laag om te bewerken";
      setTextHeader(header); 
    popStyle();
    boolean hit=false;
    for (int i=0; i<menuList.size(); i++) {

      MenuItem item=(MenuItem) menuList.get(i);
      
      if( !mainTweener.isTweening() && menuLevel==0) {
        //println("checking tweener "+mainTweener.isTweening());
        //println("check hands level 0");
        boolean leftHit=gestureActions.checkSingleHitId(item, left, w, h);
        boolean rightHit=gestureActions.checkSingleHitId(item, right, w, h);
        
        if (leftHit || rightHit) {
          boolean timed = timer.setTimer(item.x, item.y, item.item);
          if (timed) {
            // set menu action
            menuLevel++;
            activeLayer=item.item;
            timer.activeId="none";
            startMainTween(true, "left");
          };
        };
      };

      shape(item.iconSvg, item.x, item.y);
    };

    popMatrix();
  };
}



class MenuItem {

  int id;
  String item;
  PVector pos;
  PImage icon;
  float x, y;
  PShape iconSvg;
  PShape iconSvgDisabled;
  PShape edgeOver = loadShape("data/gui/menu/icon_edgeOver.svg"); 
  color c;
  String menuLevel;
  boolean subs;
  boolean active=true;

  MenuItem(String _menuLevel, String _item, boolean _subs, int _id, float _x, float _y, float sSvg) {
    
    id=_id;
    x=_x;
    y=_y;
    item = _item;
    subs=_subs;
    menuLevel=_menuLevel; 
    iconSvg = loadShape("data/gui/menu/icon_"+item+".svg");
    iconSvg.scale(sSvg*s);
    
    if(item=="toggleActive"){
      iconSvgDisabled = loadShape("data/gui/menu/icon_toggleInactive.svg");
    }else{
      iconSvgDisabled = loadShape("data/gui/menu/icon_"+item+".svg");
      iconSvgDisabled.setFill(color(0,96));
    }
    
    iconSvgDisabled.scale(sSvg*s);
    edgeOver.scale(sSvg*s);
    
  }
}

