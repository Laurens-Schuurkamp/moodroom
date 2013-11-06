class SubMenu{

 ArrayList subMenuList=new ArrayList();
 
 String actionsBckgr []={ "color","return"};
 String actionsPatern []={ "stroke", "size", "primitives", "color", "return"};
 String actionsPointcloud []={"size", "color", "return"};
 String actionsSound []={"soundPrimitives", "vibration", "return"};


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

    back = new MenuItem("action", "return", 1000, width/2-w-padding, height/2-h-padding, sSvg);
    float y= -h/2;

 };
 
 void addActions(String [] actions, SubMenuActions layerActions){
   
   float widthTotal=(w*actions.length)+(padding*actions.length)+padding;
   for(int j=0; j<actions.length; j++){
          
          float x= -widthTotal/2 + (j*(w+padding)) +padding;
          float y= -h/2;
                    
          MenuItem item=new MenuItem("subMenu", actions[j], j, x, y, sSvg);
          if(item.item=="soundPrimitives"){
            item.iconSvg.setFill(color(0,96));
          };
          layerActions.actions.add(item); 
          
        }

 }

 
 void drawSubMenu(PVector left, PVector right, String activeLayer){
      //println("active action ="+
      if(activeActions!="none"){
         if(activeActions=="color" && activeLayer=="bckgr"){
             actionsMenu.activeAction="color";             
         }else if(activeActions=="primitives" && activeLayer=="patern"){
              actionsMenu.activeAction="primitives";              
         }else if(activeActions=="vibration" && activeLayer=="sound"){
              actionsMenu.activeAction="vibration"; 
         }else if(activeActions=="return"){
           mainMenu.activeLayer="none";
           activeActions="none";
           return;

         };
        
         actionsMenu.drawActions(activeActions, activeLayer, left, right);
         return;
      };

      //activated  =  gestureActions.checkMenuActive(left, right, h);
      //if(activated==false)return;
      
      

      SubMenuActions subList;
      int i,j;
      
      pushMatrix();
      translate(0,0,1);
      
      pushStyle();
        setTextHeader(h, activeLayer); 
      popStyle();
      boolean hit=false;
      
      for(i=0; i<subMenuList.size(); i++){
          subList= (SubMenuActions) subMenuList.get(i);
          if(activeLayer==subList.layer){
            
            for(j=0; j<subList.actions.size(); j++){

              MenuItem item=(MenuItem) subList.actions.get(j);
              
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
                    activeActions=item.item;

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
