class SubMenu{
 

 ArrayList subMenuList=new ArrayList();
 
 String actionsBckgr []={"color"};
 String actionsPatern []={"primitives", "size", "color",  "stroke", "vibration", "disable"};
 String actionsPointcloud []={"primitives", "size", "color",  "stroke", "vibration", "disable"};
 String actionsSound []={"primitives", "vibration"};

 float w, h, x, y;
 boolean activated=true;
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
          MenuItem item=new MenuItem(actions[j], j, x, y, sSvg);
          layerActions.actions.add(item); 
          
        }

 }
 
 
 void drawSubMenu(float x1, float y1, float x2, float y2, String activeLayer){
      
      
      if(activeAction!="none"){
        setLayerActions(activeAction, activeLayer, x1, y1, x2, y2);
        return;
      };
      
      activated  =  gestureActions.checkMenuActive(y1, y2, h);
      if(activated==false)return;

      SubMenuActions subList;
      int i,j;
      
      pushMatrix();
      translate(0,0,1);
      
      pushStyle();
        fill(0);
        rect(-width/2, -(h/2)-padding, width, h+(2*padding) );
      popStyle();
      boolean hit=false;
      
      for(i=0; i<subMenuList.size(); i++){
          subList= (SubMenuActions) subMenuList.get(i);
          if(activeLayer==subList.layer){
            
            for(j=0; j<subList.actions.size(); j++){

              MenuItem item=(MenuItem) subList.actions.get(j);
              hit=gestureActions.checkHitId(item, x1, y1, x2, y2, w, h);
   
             if(hit){
               boolean timed = timer.setTimer(item.x, item.y, item.id);
               if(timed){
                    // set menu action
                    activeAction=item.item;

                };
      
             };     

              shape(item.iconSvg, item.x, item.y);
           };

        };
      };
      
      popMatrix();

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


class SubMenuActions{
  
  String layer;
  ArrayList actions=new ArrayList();
  
  SubMenuActions(String _layer){
    layer=_layer;
    println("adding sub menu :"+_layer);
  };
  
}
