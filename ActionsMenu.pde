class ActionsMenu
{

  ArrayList mainActionsList=new ArrayList();

  String mainActions [] = {
    "color", "size", "stroke"
  }; 
  String actionsColor [] = {
    "color", "transparency", "return"
  };
  String actionsStroke [] = {
    "strokecolor", "strokewidth", "return"
  };
  String actionsSize [] = {
    "density", "scale", "rotate", "return"
  }; 

  float w, h, x, y;
  float sSvg=0.60;
  String activeAction="none";

  MenuItem back;

  ActionsMenu() {
    println("mainMenu constructor");

    w = 320*s*sSvg;
    h = 240*s*sSvg;
    println("w ="+w);

    int i;
    for (i=0; i<mainActions.length; i++) {

      SubActions layerActions  = new SubActions(mainActions[i]);
      mainActionsList.add(layerActions);

      if (mainActions[i]=="color") {        
        addActions(actionsColor, layerActions);
      }
      else if (mainActions[i]=="stroke") {        
        addActions(actionsStroke, layerActions);
      }
      else if (mainActions[i]=="size") {        
        addActions(actionsSize, layerActions);
      }
    }

    back = new MenuItem("action", "return", false, 1000, width/2-w-padding, height/2-h-padding, sSvg);
    float y= -h/2;
  }

  void addActions(String [] actions, SubActions layerActions) {

    float widthTotal=(w*actions.length)+(padding*actions.length)+padding;
    for (int j=0; j<actions.length; j++) {

      float x= -widthTotal/2 + (j*(w+padding)) +padding;
      float y= -h/2;
      println(actions[j]);          
      MenuItem item=new MenuItem("action", actions[j], false, j, x, y, sSvg);
      layerActions.actions.add(item); 

    }
  };

  void drawActions(String activeActions, String activeLayer, PVector left, PVector right) {

      //println("before draw actions :"+activeAction+" menu level ="+menuLevel);  
      if(activeAction!="none"){
        setActions(activeAction, activeLayer, left, right);
        return;
      };
    
    boolean activated  =  gestureActions.checkMenuActive(left, right, h);  
    if (activated==false){
      timer.activeId="none";
      //return;
    };
    
    SubActions subList;
      int i,j;
      
      pushMatrix();
      translate(mainMenu.posXmenu+(2*width),0,1);

      pushStyle();
        String header="Bewerk de "+activeActions+" voor laag "+activeLayer;   
        setTextHeader(header); 
      popStyle();
      boolean hit=false;
      
      for(i=0; i<mainActionsList.size(); i++){
          subList= (SubActions) mainActionsList.get(i);
          if(activeActions==subList.action){
            
            for(j=0; j<subList.actions.size(); j++){

              MenuItem item=(MenuItem) subList.actions.get(j);
              if(!mainTweener.isTweening() && menuLevel==2){
                  
                  boolean leftHit=gestureActions.checkSingleHitId(item, left, w, h);
                  boolean rightHit=gestureActions.checkSingleHitId(item, right, w, h);
       
                 if(leftHit || rightHit){
                   boolean timed = timer.setTimer(item.x, item.y, item.item);
                   if(timed){
                        // set menu action

                        if(item.item=="return"){
                          menuLevel--;
                          activeAction="none";
                          startMainTween(true, "right");
                        }else{
                          activeAction=item.item;
                        };
                      }

                 };
              };
             
             shape(item.iconSvg, item.x, item.y);

           };

        };
      };

      
      popMatrix();

  };

  void setActions(String action, String activeLayer, PVector left, PVector right) {
      
    if(action=="scale"){
         Boolean isActive=gestureActions.scalingActive(left, right, "free");
               
         if(isActive && activeLayer=="patern"){
           
           PVector scaleEdit = gestureActions.setScale(left, right, layerPatern.scaleInit, layerPatern.scaleEdit);  
           if(scaleEdit.x==1.0 && scaleEdit.y==1.0){
             
             layerPatern.scaleInit.x*=layerPatern.scaleEdit.x;
             layerPatern.scaleInit.y*=layerPatern.scaleEdit.y;
             layerPatern.scaleEdit.x=1;
             layerPatern.scaleEdit.y=1;
             
           }else{
             layerPatern.scaleEdit=scaleEdit;
           };
                      
         
         }else if(isActive && activeLayer=="pointcloud"){
           PVector strokeWEdit=gestureActions.setScale(left, right, pointCloud3D.strokeWInit, pointCloud3D.strokeWEdit);
           if(strokeWEdit.x==1.0 && strokeWEdit.y==1.0){
             
             pointCloud3D.strokeWInit.x*=pointCloud3D.strokeWEdit.x;
             pointCloud3D.strokeWInit.y*=pointCloud3D.strokeWEdit.y;
             pointCloud3D.strokeWEdit.x=1;
             pointCloud3D.strokeWEdit.y=1;

           }else{
             if(strokeWEdit.x<=0)strokeWEdit.x=0;
             if(strokeWEdit.y<=0)strokeWEdit.y=0;
             
             pointCloud3D.strokeWEdit=strokeWEdit;
           };
             
       }
        
      }else if(action=="density"){
        
        boolean isActive=gestureActions.scalingActive(left, right, "free");
               
         if(isActive && activeLayer=="patern"){
           PVector densityEdit=gestureActions.setScale(left, right, layerPatern.densityInit, layerPatern.densityEdit);  
           if(densityEdit.x==1.0 && densityEdit.y==1.0){
             layerPatern.densityInit.x*=layerPatern.densityEdit.x;
             layerPatern.densityInit.y*=layerPatern.densityEdit.y;
             layerPatern.densityEdit.x=1;
             layerPatern.densityEdit.y=1;
           }else{
             if(densityEdit.x<0.5)densityEdit.x=0.5;
             if(densityEdit.y<0.5)densityEdit.y=0.5;
             layerPatern.densityEdit=densityEdit;
           };

         }else if(isActive && activeLayer=="pointcloud"){
           PVector densityEdit=gestureActions.setScale(left, right, pointCloud3D.densityInit, pointCloud3D.densityEdit);
           if(densityEdit.x==1.0 && densityEdit.y==1.0){
             pointCloud3D.densityInit.x*=pointCloud3D.densityEdit.x;
             pointCloud3D.densityInit.y*=pointCloud3D.densityEdit.y;
             pointCloud3D.densityEdit.x=1;
             pointCloud3D.densityEdit.y=1;
           }else{
             if(densityEdit.x<0.25)densityEdit.x=0.25;
             if(densityEdit.y<0.25)densityEdit.y=0.25;
             pointCloud3D.densityEdit=densityEdit;
           };
         }
        
      }else if(action=="color"){
        if(activeLayer=="patern"){
           layerPatern.cf=gestureActions.setColor(left, right, layerPatern.cf);  
        }else if(activeLayer=="pointcloud"){
           pointCloud3D.cs=gestureActions.setColor(left, right, pointCloud3D.cs);  
        }else if(activeLayer=="bckgr"){
          colorBckgr=gestureActions.setColor(left, right, colorBckgr);  
          
        }
        
      }else if(action=="strokewidth"){
          
          boolean isActive=gestureActions.scalingActive(left, right, "horizontal");
                 
           if(isActive && activeLayer=="patern"){
             PVector strokeWEdit=gestureActions.setScale(left, right, layerPatern.strokeWInit, layerPatern.strokeWEdit);
             if(strokeWEdit.x==1.0 && strokeWEdit.y==1.0){
             
               layerPatern.strokeWInit.x*=layerPatern.strokeWEdit.x;
               layerPatern.strokeWInit.y*=layerPatern.strokeWEdit.y;
               layerPatern.strokeWEdit.x=1;
               layerPatern.strokeWEdit.y=1;

           }else{
               if(strokeWEdit.x<=0)strokeWEdit.x=0;
               if(strokeWEdit.y<=0)strokeWEdit.y=0;
             
               layerPatern.strokeWEdit=strokeWEdit;
           };
             
           }

        
      }else if(action=="strokecolor"){
          if(activeLayer=="patern"){
           layerPatern.cs=gestureActions.setColor(left, right, layerPatern.cf);  
        }

      }else if(action=="transparency"){
        if(activeLayer=="patern"){
           layerPatern.cf=gestureActions.setAlpha(left, right, layerPatern.cf);  
        }else if(activeLayer=="pointcloud"){
           pointCloud3D.cs=gestureActions.setAlpha(left, right, pointCloud3D.cs);  
        }

      }else if(action=="primitives"){
         if(activeLayer=="patern"){
            layerPatern.drawPrimitivesPicker(left, right);
         }   
        
        
      }else if(action == "vibration" ){
        if(activeLayer=="sound"){
          layerSound.amp = gestureActions.setVibration(left, right, layerSound.amp);
         }  
        
      }else if(action == "toggleActive"){
        if(activeLayer=="patern"){
          if(layerPatern.activated){
            layerPatern.activated=false;
          }else{
            layerPatern.activated=true;
          };
         }else if(activeLayer=="pointcloud"){
          if(pointCloud3D.activated){
            pointCloud3D.activated=false;
          }else{
            pointCloud3D.activated=true;
          };
         }else if(activeLayer=="sound"){
//          if(pointCloud3D.activated){
//            pointCloud3D.activated=false;
//          }else{
//            pointCloud3D.activated=true;
//          };
         }
         activeAction="none";
      }

  }

}

class SubActions {

  String action;
  ArrayList actions=new ArrayList();

  SubActions(String _action) {
    action=_action;
    println("adding sub menu :"+_action);
  };
}


