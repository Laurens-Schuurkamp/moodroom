class SubMenu{
 

 ArrayList subMenuList=new ArrayList();
 
 String actionsBckgr []={"color"};
 String actionsPatern []={"primitives", "size", "color",  "stroke", "vibration", "disable"};
 String actionsPointcloud []={"primitives", "size", "color",  "stroke", "vibration", "disable"};
 String actionsSound []={"primitives", "vibration"};

 float w, h, x, y;
 boolean activated=true;
 int activeHitId=-1;
 float sSvg=0.65;
 String activeAction="none";
 
 SubMenu(){
  println("submenu constructor");
  
    w = 320*s*sSvg;
    h = 240*s*sSvg;
    
    int i, j;
    
    for(i=0; i<layers.length; i++){
      
      SubMenuActions layerActions  = new SubMenuActions(layers[i]);
      subMenuList.add(layerActions);

      if(layers[i]=="bckgr"){        
        addActions(actionsBckgr, layerActions);
      }else if(layers[i]=="patern"){
        addActions(actionsPatern, layerActions);
      }else if(layers[i]=="pointcloud"){
        addActions(actionsPointcloud, layerActions);
      }else if(layers[i]=="sound"){
        addActions(actionsSound, layerActions);
      }

    }

  
 };
 
 void addActions(String [] actions, SubMenuActions layerActions){
   
   float widthTotal=(w*actions.length)+(padding*actions.length)+padding;
   for(int j=0; j<actions.length; j++){
          
          float x= -widthTotal/2 + (j*(w+padding));
          float y= -h/2;
          SubMenuItem item=new SubMenuItem(actions[j], j, x, y, sSvg);
          layerActions.actions.add(item); 
          
        }

 }
 
 
 void drawSubMenu(float x1, float y1, float x2, float y2, String activeLayer){
      if(activated==false)return;
      
      if(activeAction!="none"){
        setLayerActions(activeAction, activeLayer, x1, y1, x2, y2);
        return;
      };
    
      int hitId=-1;
      SubMenuActions subList;
      int i,j;
      
      pushMatrix();
      translate(0,0,1);
      
      for(i=0; i<subMenuList.size(); i++){
          subList= (SubMenuActions) subMenuList.get(i);
          if(activeLayer==subList.layer){
            
            for(j=0; j<subList.actions.size(); j++){

              SubMenuItem item=(SubMenuItem) subList.actions.get(j);
              
              
              if (x1 - (screenWidth/2) > item.x && x1 - (screenWidth/2) < item.x+w && y1-(screenHeight/2) > item.y && y1-(screenHeight/2) < item.y+h &&
                  x2 - (screenWidth/2) > item.x && x2 - (screenWidth/2) < item.x+w && y2-(screenHeight/2) > item.y && y2-(screenHeight/2) < item.y+h) {
      
                hitId = item.id;
                  
                  if(activeHitId!=hitId){
                    timer.timeActivation=millis();
                    activeHitId=item.id;
                    
                  }else if(activeHitId==hitId){
                    boolean timed= timer.setTimer(item.x, item.y);
                    if(timed){
                      hitId=-1;
                      activeAction=item.action;
      
                    };
      
                  };
                  
                  shape(item.edgeOver, item.x, item.y);
      
              };
              
              shape(item.iconSvg, item.x, item.y);
            };

        };
      };
      
      popMatrix();
      
      if(hitId==-1){
        activeHitId=-1;  
      };


  };
  
  
  void setLayerActions(String action, String activeLayer, float x1, float y1, float x2, float y2){
    //println("setting action :"+action+" --> for layer :"+activeLayer);
    
    
    if(activeLayer=="patern" && action=="primitives"){
      layerPatern.drawPrimitivesPicker(x1, y1, x2, y2);
    }else{
      activeAction="none";
      mainMenu.activeLayer="none";
    };
    
  };

 
  
  
  
}
// end class submenu

class SubMenuItem{
  
  int id;
  String action;
  PVector pos;
  PImage icon;
  float x, y;
  PShape iconSvg;
  PShape edgeOver = loadShape("data/gui/menu/icon_edgeOver.svg");  
  
  SubMenuItem(String _action, int _id, float _x, float _y, float sSvg){
    id=_id;
    x=_x;
    y=_y;
    action = _action;   
    iconSvg = loadShape("data/gui/menu/icon_"+action+".svg");
    iconSvg.scale(sSvg);
    edgeOver.scale(sSvg);
    
    println("adding action :"+_action);
  }
  
  
}

class SubMenuActions{
  
  String layer;
  ArrayList actions=new ArrayList();
  
  SubMenuActions(String _layer){
    layer=_layer;
    println("adding sub menu :"+_layer);
  };
  
}
