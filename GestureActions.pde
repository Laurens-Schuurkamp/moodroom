class GestureActions
{
  
  boolean activated=false;
  PVector lastLeft=new PVector(0,0);
  PVector lastRight=new PVector(0,0);
  
  GestureActions(){
    println("gestureScaling constopuctor");
    
    colorPicker = new ColorPicker( 0, 0, width, parseInt(handSize), 255 );
    //swipeDelay=niteSettings.getInt("swipeDelay");

  }
  
  boolean checkMenuActive(PVector left, PVector right, float h){
    if ( ( left.y-(height/2) > -h/2 && left.y-(height/2) < h/2 ) || ( right.y-(height/2) > -h/2 && right.y-(height/2) < h/2 )) {
      return true;
    }else{
      timer.activeId="none"; 
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
    float sens=sensitivity*handSize;
    boolean timed=false;
    boolean timerLeft=false;
    boolean timerRight=false;
    if(demoModus){
      left.x=random(1000);
      left.y=random(1000);
    };
    
    if( left.x>lastLeft.x-sens && left.x<lastLeft.x+sens && left.y>lastLeft.y-sens && left.y<lastLeft.y+sens){
       timerLeft=true;     
     }
     
     if( right.x>lastRight.x-sens && right.x<lastRight.x+sens &&  right.y>lastRight.y-sens && right.y<lastRight.y+sens){
       timerRight=true;           
     }
    
    if(timerLeft){
       timed = timer.setTimer(left.x-(width/2)-(handSize/2), left.y-(height/2)-(handSize/2), "left");   
    }else if(timerRight){
       timed = timer.setTimer(right.x-(width/2)-(handSize/2), right.y-(height/2)-(handSize/2), "right");
    }else{
       timer.activeId="none";
    } 

    
    if(timed){
            // set menu action
            subMenu.activeAction="none";
            timer.activeId="none"; 
      };

    

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
    lastLeft=left;
    lastRight=right;
    return c;
  };
  

  
  int setAlpha(PVector left, PVector right, String activeLayer){
    int alpha=96;   
    return alpha;
  };
  
  
}



