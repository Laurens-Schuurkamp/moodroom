class SubMenu{

 ArrayList subMenuList=new ArrayList();
 
 String actionsBckgr [][]={ {"color", "false"},{"return", "true"}};
 String actionsPatern [][]={ {"stroke", "true"}, {"size", "true"}, {"primitives", "false"}, {"color", "true"}, {"return", "true"}};
 String actionsPointcloud [][]={{"size", "true"}, {"color", "true"}, {"return", "true"}};
 String actionsSound [][]={{"soundPrimitives", "true"}, {"vibration", "false"}, {"return", "true"}};


 float w, h, x, y;
 boolean activated=true;
 float sSvg=0.60;
 String activeActions="none";
 
 
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

    back = new MenuItem("action", "return", false, 1000, width/2-w-padding, height/2-h-padding, sSvg);
    float y= -h/2;

 };
 
 void addActions(String [][] actions, SubMenuActions layerActions){
   
   float widthTotal=(w*actions.length)+(padding*actions.length)+padding;
   for(int j=0; j<actions.length; j++){
          
          float x= -widthTotal/2 + (j*(w+padding)) +padding;
          float y= -h/2;
          boolean subs=false;
          if(actions[j][1]=="true") subs=true;
                     
          MenuItem item=new MenuItem("subMenu", actions[j][0], subs, j, x, y, sSvg);
          if(item.item=="soundPrimitives"){
            item.iconSvg.setFill(color(0,96));
          };
          layerActions.actions.add(item); 
          
        }

 }

 
 void drawSubMenu(PVector left, PVector right, String activeLayer){

     if(actionsMenu.activeAction!="none"){
        actionsMenu.drawActions(activeActions, activeLayer, left, right);
        return;
      } 
   
     
      if( mainTweener.isTweening() || menuLevel>=1 ){
        actionsMenu.drawActions(activeActions, activeLayer, left, right);
      }
      
     
      SubMenuActions subList;
      int i,j;
      
      pushMatrix();
      translate(mainMenu.posXmenu+width,0,1);
      
      pushStyle();
        String header="Bewerk de laag "+activeLayer;
        setTextHeader(header); 
      popStyle();
      boolean hit=false;
      
      for(i=0; i<subMenuList.size(); i++){
          subList= (SubMenuActions) subMenuList.get(i);
          if(activeLayer==subList.layer){
            
            for(j=0; j<subList.actions.size(); j++){

              MenuItem item=(MenuItem) subList.actions.get(j);
              if(!mainTweener.isTweening() && menuLevel==1){

                boolean leftHit=false;
                boolean rightHit=false;;
  
                if(item.item!="soundPrimitives"){
                  leftHit=gestureActions.checkSingleHitId(item, left, w, h);
                  rightHit=gestureActions.checkSingleHitId(item, right, w, h);
                };
                 
               if(leftHit || rightHit){
                 boolean timed = timer.setTimer(item.x, item.y, item.item);
                 if(timed){
                      // set menu action
                      
                      if(item.subs){
                        if(item.item=="return"){
                          menuLevel--;
                          mainMenu.activeLayer="none";
                          actionsMenu.activeAction="none";
                          activeActions="none";
                          startMainTween(true, "right");
                          
                        }else{
                          menuLevel++;
                          startMainTween(true, "left");
                          activeActions=item.item;
                        };
                      }else{
                          //menuLevel++;
                          activeActions=item.item;
                          actionsMenu.activeAction=item.item;
                          //startMainTween(true, "left");
                          
                      };

                  };
        
               };
              };
             
             shape(item.iconSvg, item.x, item.y);
             
             //show inactives 
//             if( activeLayer=="patern" && layerPatern.activePrimitive=="none"){
//                if(item.item!="primitives" ){
//                    item.iconSvg.setFill(color(255, 96));
//                }
//             }else{
//          
//             }      

              
           };

        };
      };

      
      popMatrix();

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
