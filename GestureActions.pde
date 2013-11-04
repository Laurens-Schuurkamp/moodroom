class GestureActions
{
  
  boolean activated=false;

  GestureActions(){
    println("gestureScaling constopuctor");
    
    colorPicker = new ColorPicker( 0, 0, width, parseInt(handSize), 255 );
    //swipeDelay=niteSettings.getInt("swipeDelay");

  }
  
  boolean checkMenuActive(PVector left, PVector right, float h){
    if ( ( left.y-(height/2) > -h/2 && left.y-(height/2) < h/2 ) || ( right.y-(height/2) > -h/2 && right.y-(height/2) < h/2 )) {
      return true;
    }else{
      timer.activeId=-1; 
      return false;
     
    }
  
  }
  
  
//  boolean checkDoubleHitId(MenuItem item, PVector left, PVector right, float w, float h){
//    
//    boolean hit=false;
//      if (left - (width/2) > item.x && left - (width/2) < item.x+w && left-(height/2) > item.y && left-(height/2) < item.y+h &&
//              right - (width/2) > item.x && right - (width/2) < item.x+w && right-(height/2) > item.y && right-(height/2) < item.y+h) {
//            hit=true;
//            shape(item.edgeOver, item.x, item.y);
//  
//      };
//      
//    return hit;  
//
//  }
  
  boolean checkSingleHitId(MenuItem item, PVector pos, float w, float h){
    
    boolean hit=false;
      if ( (pos.x - (width/2) > item.x && pos.x - (width/2) < item.x+w && pos.y-(height/2) > item.y && pos.y-(height/2) < item.y+h)  ) {
            hit=true;
            shape(item.edgeOver, item.x, item.y);
  
      };
      
    return hit;  

  }
  
  boolean zoomGestureActivation(float x, float y, PVector top,  PVector bottom, float hitSize){
    
        boolean hit=false;  
        //right
       if ( x - (width/2) > top.x-hitSize && x - (width/2) < top.x+hitSize && y-(height/2) > top.y-hitSize && y-(height/2) < top.y+hitSize ) {
            hit=true;    
        }else if ( x - (width/2) > bottom.x-hitSize && x - (width/2) < bottom.x+hitSize && y-(height/2) > bottom.y-hitSize && y-(height/2) < bottom.y+hitSize ) {
            hit=true;
        };

    
    return hit;
  }
  
  
  color setColor(PVector left, PVector right){

    color c=color(0);;
    pushMatrix();
    translate(-width/2, -height/2, 0);
      pushStyle();
      noStroke();
        
      float rh=handSize;
//      pushStyle();
//        fill(activeColor);
//        rect(0, (height/2)-(200/2), width, 200);
//      popStyle();      
      colorPicker.draw();
      if( right.y > (height/2)-(150/2) && right.y < (height/2)+(150/2) ){
        c = colorPicker.getColor (left, right);
      }else if( left.y > (height/2)-(150/2) && left.y < (height/2)+(150/2) ){
        c = colorPicker.getColor (left, right);
      }
    
       popStyle();
     popMatrix();

    return c;
  };
  

  
  int setAlpha(PVector left, PVector right, String activeLayer){
    int alpha=96;   
    return alpha;
  };
  
  
}



