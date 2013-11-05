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
    "density", "size", "return"
  }; 

  float w, h, x, y;
  boolean activated=true;
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

    back = new MenuItem("action", "return", 1000, width/2-w-padding, height/2-h-padding, sSvg);
    float y= -h/2;
  }

  void addActions(String [] actions, SubActions layerActions) {

    float widthTotal=(w*actions.length)+(padding*actions.length)+padding;
    for (int j=0; j<actions.length; j++) {

      float x= -widthTotal/2 + (j*(w+padding)) +padding;
      float y= -h/2;
      println(actions[j]);          
      MenuItem item=new MenuItem("action", actions[j], j, x, y, sSvg);
      layerActions.actions.add(item); 

    }
  };

  void drawActions(String activeActions, String activeLayer, PVector left, PVector right) {

    if (activeAction!="none") { 
      if(activeAction=="return"){
         subMenu.activeActions="none";
         activeAction="none";
         
      }else{
        setActions(activeAction, activeLayer, left, right);
          
      };
      return;

    }
    
    SubActions subList;
      int i,j;
      
      pushMatrix();
      translate(0,0,1);
      
      pushStyle();
        fill(0);
        rect(-width/2, -(h/2)-padding, width, h+(2*padding) );
      popStyle();
      boolean hit=false;
      
      for(i=0; i<mainActionsList.size(); i++){
          subList= (SubActions) mainActionsList.get(i);
          if(activeActions==subList.action){
            
            for(j=0; j<subList.actions.size(); j++){

              MenuItem item=(MenuItem) subList.actions.get(j);
              boolean leftHit=gestureActions.checkSingleHitId(item, left, w, h);
              boolean rightHit=gestureActions.checkSingleHitId(item, right, w, h);
   
             if(leftHit || rightHit){
               boolean timed = timer.setTimer(item.x, item.y, item.item);
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

  void setActions(String action, String activeLayer, PVector left, PVector right) {
      
    if(action=="size"){
         boolean isActive=gestureActions.scalingActive(left, right);
               
         if(isActive && activeLayer=="patern"){
           layerPatern.scaling=gestureActions.setScale(left, right, layerPatern.scaling);
         }else if(isActive && activeLayer=="pointcloud"){
           PVector w=gestureActions.setScale(left, right, layerPatern.strokeW);
             w.x=w.x*50;
             w.y=w.y*50;
             if(w.x<1) w.x=1;
             if(w.y<1) w.y=1;
                      
           pointCloud3D.strokeW=w;
             
       }
        
      }else if(action=="density"){
        
        boolean isActive=gestureActions.scalingActive(left, right);
               
         if(isActive && activeLayer=="patern"){
           PVector dens=gestureActions.setScale(left, right, layerPatern.density);
           if(dens.x<0.25) dens.x=0.25;
           if(dens.y<0.25) dens.y=0.25;
           layerPatern.density=dens;
         }else if(isActive && activeLayer=="pointcloud"){
           PVector dens=gestureActions.setScale(left, right, pointCloud3D.density);
           if(dens.x<0.25) dens.x=0.25;
           if(dens.y<0.25) dens.y=0.25;
           pointCloud3D.density=dens;
         }
        
      }else if(action=="color"){
        if(activeLayer=="patern"){
           layerPatern.cf=gestureActions.setColor(left, right, layerPatern.cf);  
        }else if(activeLayer=="pointcloud"){
           pointCloud3D.cs=gestureActions.setColor(left, right, pointCloud3D.cs);  
        }
        
      }else if(action=="strokewidth"){
          
          boolean isActive=gestureActions.scalingActive(left, right);
                 
           if(isActive && activeLayer=="patern"){
             PVector w=gestureActions.setScale(left, right, layerPatern.strokeW);
             w.x=w.x*2;
             w.y=w.y*2;
             if(w.x<0.1) w.x=0.1;
             if(w.y<0.1) w.y=0.1;
             
             layerPatern.strokeW=w;
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


