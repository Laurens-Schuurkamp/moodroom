class SubMenu{
 

 ArrayList subMenuList=new ArrayList();
 
 String actionsBckgr []={"color"};
 String actionsPatern []={ "stroke", "size", "color", "primitives", "vibration", "disable"};
 String actionsPointcloud []={};
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
 
 
 void drawSubMenu(PVector left, PVector right, String activeLayer){
      
      
      if(activeAction!="none"){
        setLayerActions(activeAction, activeLayer, left, right);
        return;
      };
      
      activated  =  gestureActions.checkMenuActive(left.y, right.y, h);
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
              hit=gestureActions.checkMenuHitId(item, left.x, left.y, right.x, right.y, w, h);
   
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
  
  
  void setLayerActions(String action, String activeLayer, PVector left, PVector right){

    if(activeLayer=="patern"){
      
      if(action=="primitives" || action =="size"){
        layerPatern.setAction(left, right, action);
      }else{
        activeAction="none";
        mainMenu.activeLayer="none";
      }
    }
    
    else{
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
