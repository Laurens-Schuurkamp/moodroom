class GestureActions
{
  
  boolean activated=false;
  PVector lastLeft=new PVector(0,0);
  PVector lastRight=new PVector(0,0);
  
  float deltaOrg=0;
  float distXorg=0;
  float distYorg=0;
  
  float offset=220*s;
  boolean isScaling=false;
  
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
  
  
  boolean scalingActive(PVector left, PVector right){
     
     if(isScaling)return true; 

      PVector tl=new PVector(-offset, -offset);
      PVector bl=new PVector(-offset, offset);
      
      PVector tr=new PVector(offset, -offset);
      PVector br=new PVector(offset, offset);
      
      float hitSize=handSize/2;
     
       for(int i=0; i<2; i++){
         if(i==0){
           //top
           
           HandLeft hl=new HandLeft(tl.x, tl.y, false);
           HandRight hr=new HandRight(tr.x, tr.y, false);
           
         }else if(i==1){
           //bottem
           HandLeft hl=new HandLeft(bl.x, bl.y, false);
           HandRight hr=new HandRight(br.x, br.y, false);           
         }
         
       };

       boolean leftHit=gestureActions.zoomGestureActivation(left.x, left.y, tl,  bl, hitSize);
       boolean rightHit=gestureActions.zoomGestureActivation(right.x, right.y, tr,  br, hitSize);
       

       if(demoModus){
        HandLeft demo=new HandLeft(bl.x, bl.y, true); 
        leftHit=true;
       } 
        
       handSvgRuser.setStroke(color(255));
       handSvgLuser.setStroke(color(255));
       
       if(rightHit)  handSvgRuser.setStroke(handFeedBack);
       if(leftHit)  handSvgLuser.setStroke(handFeedBack);
       
       if(leftHit && rightHit){
           boolean timed = timer.setTimer(0, 0, "scaleActivation");
           if(timed){
             timer.activeId="none";
             if(demoModus){
                left.x=-offset*s;
                left.y=offset*s;
              }; 
             distXorg=right.x-left.x;
             distYorg=right.y-left.y;
             deltaOrg = dist(left.x, left.y, right.x, right.y);
             isScaling=true;
           }

         
       };
       
       return isScaling;

   };
   
   PVector setScale(PVector left, PVector right, PVector scaling){
    
     
     if(demoModus){
       left.x=-offset*s;
       left.y=offset*s;
    }; 

     float distX=right.x-left.x;
     float distY=right.y-left.y;
     
     scaling.x=distX/distXorg;
     scaling.y=distY/distYorg;
     
     float deltaNew=dist(left.x, left.y, right.x, right.y);
     //println(deltaOrg/deltaNew);
     
     if( (deltaOrg/deltaNew)>(1-sensitivity) && (deltaOrg/deltaNew)<(1+sensitivity) ){
       
       boolean timed = timer.setTimer(0, 0, "scale");
           if(timed){
             subMenu.activeAction="none";
             //isScaling=false;
             timer.activeId="none";
             deltaOrg=0;
             
           }
     }else{
       timer.activeId="none";
     };
     
     deltaOrg=deltaNew;
     return scaling;

   }
  
  
}



