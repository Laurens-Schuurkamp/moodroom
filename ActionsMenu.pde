class ActionsMenu
{
 
 String actionsColor [] = {"color", "alpha"};
 String actionsStroke [] = {"color", "width"};
 String actionsSize [] = {"density", "size"}; 
  
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
    
    String subsEmpty [] ={};
    back = new MenuItem("action", "return", subsEmpty, 1000, width/2-w-padding, height/2-h-padding, sSvg);
    float y= -h/2;

  }

  void drawActions(String activeActions, String activeLayer, PVector left, PVector right) {
      
    if(activeAction!="none"){ 
        setActions(activeActions, activeLayer, left, right);
        return;
     };
    
      
  };
  
  void setActions(String action, String activeLayer, PVector left, PVector right){

    //MenuItem back=new MenuItem("return", 1000, width/2-w-padding, height/2-h-padding, sSvg);
      
//
//
//    if(action=="color" ){
//      
//      if(activeLayer=="bckgr"){
//          colorBckgr=gestureActions.setColor(left, right, colorBckgr);
//      }else if(activeLayer=="patern"){
//
//          layerPatern.cf=gestureActions.setColor(left, right, layerPatern.cf);
//        
//      }
//      
//    }else if(action=="primitives"){
//      if(activeLayer=="patern"){
//        layerPatern.setAction(left, right, action);
//      }else{
//        return;
//      }
//      
//    }else if(action=="size"){
//      if(activeLayer=="patern"){
//        layerPatern.setAction(left, right, action);
//      }else{
//        return;
//      }
//      
//    }

   
  }


  
  
  
}

class SubActions{
  
  String layer;
  ArrayList actions=new ArrayList();
  
  SubActions(String _layer){
    layer=_layer;
    println("adding sub menu :"+_layer);
  };
  
}



