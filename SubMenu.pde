class SubMenu{
 

 ArrayList subMenuList=new ArrayList();
 
 String actionsBckgr []={"color","transparency", "return"};
 String actionsPatern []={ "stroke", "size", "color", "primitives", "disable", "return"};
 String actionsPointcloud []={"size", "color", "primitives", "return"};
 String actionsSound []={"primitives", "vibration", "return"};

 float w, h, x, y;
 boolean activated=true;
 float sSvg=0.65;
 String activeAction="none";
 
 MenuItem back;
 
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
    
    back = new MenuItem("return", 1000, width/2-w-padding, height/2-h-padding, sSvg);

  
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
      
      
      
      //activated  =  gestureActions.checkMenuActive(left, right, h);
      //if(activated==false)return;

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
              boolean leftHit=gestureActions.checkSingleHitId(item, left, w, h);
              boolean rightHit=gestureActions.checkSingleHitId(item, right, w, h);
   
             if(leftHit && rightHit){
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

    //MenuItem back=new MenuItem("return", 1000, width/2-w-padding, height/2-h-padding, sSvg);
    shape(back.iconSvg, back.x, back.y);
    boolean leftHit=gestureActions.checkSingleHitId(back, left, w, h);
    boolean rightHit=gestureActions.checkSingleHitId(back, right, w, h);
   
             if(leftHit && rightHit){
               boolean timed = timer.setTimer(back.x, back.y, back.id);
               if(timed){
                    timer.activeId=-1;
                    activeAction="none";
                    return;

                };
      
             };  

    if(activeLayer=="patern"){
      
      if(action=="primitives" || action =="size"){
        layerPatern.setAction(left, right, action);
      }else if(action=="color"){
          color c = gestureActions.setColor(left, right, layerPatern.cf);
          layerPatern.cf=c;
      }else{
        activeAction="none";
        mainMenu.activeLayer="none";
      }

    }else if(action=="color"){
        if(activeLayer=="bckgr"){
          color c = gestureActions.setColor(left, right, colorBckgr);
          colorBckgr=c;
        }
    
    }else if( activeAction=="none" || activeAction=="return"){
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
