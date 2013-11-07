class GestureActions
{
  
  boolean activated=false;
  PVector lastLeft=new PVector(0,0);
  PVector lastRight=new PVector(0,0);
  
  float deltaOrg=0;
  float distXorg=0;
  float distYorg=0;
  
  float offset=200*s;
  PVector tl=new PVector(-offset, -offset);
  PVector bl=new PVector(-offset, offset);
  
  PVector tr=new PVector(offset, -offset);
  PVector br=new PVector(offset, offset);
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
  

  
  boolean checkSingleHitId(MenuItem item, PVector pos, float w, float h){
    
    boolean hit=false;
      if ( (pos.x - (width/2) > item.x && pos.x - (width/2) < item.x+w && pos.y-(height/2) > item.y && pos.y-(height/2) < item.y+h)  ) {
            hit=true;
            shape(item.edgeOver, item.x, item.y);
  
      };
      
    return hit;  

  }
  
  boolean zoomGestureActivation(PVector hand, PVector top, PVector bottom, float hitSize){
    
        boolean hit=false;  
        //top position
       if ( hand.x - (width/2) > top.x-hitSize && hand.x - (width/2) < top.x+hitSize && hand.y-(height/2) > top.y-hitSize && hand.y-(height/2) < top.y+hitSize ) {
            hit=true;    
        }else if ( hand.x - (width/2) > bottom.x-hitSize && hand.x - (width/2) < bottom.x+hitSize && hand.y-(height/2) > bottom.y-hitSize && hand.y-(height/2) < bottom.y+hitSize ) {
            hit=true;
        };

    
    return hit;
  }

  color setColor(PVector left, PVector right, color c){
    
    float alpha=alpha(c);
    
    boolean isActive=false;
    PVector hand = new PVector(0,0);
    String activeHand="none";
    //zit ik in de colorpicker met rechts?
      if( right.y > (height/2)-(175/2) && right.y < (height/2)+(175/2) ){
        hand=right;
        activeHand="right";
        isActive=true;
        handSvgRuser.setFill(handFeedBack);

      }//zit ik in de color picker met links?
      else if( left.y > (height/2)-(175/2) && left.y < (height/2)+(175/2) ){
        hand=left;
        activeHand="left";
        isActive=true;
        handSvgLuser.setFill(handFeedBack);
        //println("cp links :"+left.y);
      }
    
    if(isActive){
       boolean timed=checkHandsSteady(left, right, true, activeHand);
       if(timed) return c;
    }

    pushMatrix();
    translate(-width/2, -height/2, 0);
      pushStyle();
      noStroke();
        
      float rh=handSize;
      pushMatrix();
        translate(0,0,1);
        colorPicker.draw();
      popMatrix();
      if(isActive){
        c = colorPicker.getColor (hand);
      };
      
    
       popStyle();
     popMatrix();

    lastLeft=left;
    lastRight=right;
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    c=color (r,g,b,alpha);
    return c;
  };
 

  
  color setAlpha(PVector left, PVector right, color c){
    float alpha = alpha(c);
    float r= red(c);
    float g = green(c);
    float b = blue(c);
    
    boolean isActive=false;
    PVector hand = new PVector(0,0);
    String activeHand="none";
    //zit ik in de colorpicker met rechts?
      if( right.y > (height/2)-(175/2) && right.y < (height/2)+(175/2) ){
        hand=right;
        activeHand="right";
        isActive=true;
        handSvgRuser.setFill(handFeedBack);

      }//zit ik in de color picker met links?
      else if( left.y > (height/2)-(175/2) && left.y < (height/2)+(175/2) ){
        hand=left;
        activeHand="left";
        isActive=true;
        handSvgLuser.setFill(handFeedBack);
        //println("cp links :"+left.y);
      }
    
    if(isActive){
       boolean timed=checkHandsSteady(left, right, true, activeHand);
       if(timed) return c;
    }
    
    int step=parseInt(width/255);
    pushMatrix();
    translate(-width/2, 0, 1);
        for(int i=0; i<256; i++){
          pushStyle();
          noStroke();
          fill(r,g,b,i);
          rect(i*step, -150/2, step, 150);
          popStyle();
        }
   popMatrix();
   
   if(isActive){
        //println("hand pos ="+hand.x);
        alpha=(hand.x/width)*255;
      };
   c=color(r,g,b,alpha);
  
  lastLeft=left;
    lastRight=right;
  
   
   return c;
  };
  
  
  float setVibration(PVector left, PVector right, float amp){
    
    boolean isActive=false;
    PVector hand = new PVector(0,0);
    String activeHand="none";
    //zit ik in de colorpicker met rechts?
      if( right.y > (height/2)-(175/2) && right.y < (height/2)+(175/2) ){
        hand=right;
        activeHand="right";
        isActive=true;
        handSvgRuser.setFill(handFeedBack);

      }//zit ik in de color picker met links?
      else if( left.y > (height/2)-(175/2) && left.y < (height/2)+(175/2) ){
        hand=left;
        activeHand="left";
        isActive=true;
        handSvgLuser.setFill(handFeedBack);
        //println("cp links :"+left.y);
      }
    
    if(isActive){
       boolean timed=checkHandsSteady(left, right, true, activeHand);
       if(timed) return amp;
    }
    
    int stepw=parseInt(width/255);
    
    pushMatrix();
    translate(-width/2, 0, 1);
    pushStyle();
      noStroke();
      fill(0);
      rect(0, -75-padding, width, 150+padding );
    popStyle();
    
    for(int i=0; i<256; i++){
      pushStyle();
      stroke(256-i);
      fill(255, i);
        float steph=0.585*i;
        
        rect(i*stepw, -(steph+2)/2, stepw, steph+2 );
      popStyle();
    }
   
   popMatrix();
   
   if(isActive){
       amp=(hand.x/width)*2;
       
    };
   
  
  lastLeft=left;
  lastRight=right;
  
   
   return amp;
  };
  
  
  boolean scalingActive(PVector left, PVector right){
     
     if(isScaling){
       return true; 
     }
      
      float hitSize=handSize/2;
      pushMatrix();
      translate(0,0,1);
      pushStyle();
        fill(255);
        stroke(0);
        strokeWeight(2);
        float r=200;
       for(int i=0; i<2; i++){
         if(i==0){
           //top
           ellipse(tl.x, tl.y, r, r);
           HandLeft hl=new HandLeft(tl.x, tl.y, false, false);
           ellipse(tr.x, tr.y, r, r);
           HandRight hr=new HandRight(tr.x, tr.y, false, false);
           
         }else if(i==1){
           //bottem
           ellipse(bl.x, bl.y, r, r);
           HandLeft hl=new HandLeft(bl.x, bl.y, false, false);
           
           ellipse(br.x, br.y, r, r);
           HandRight hr=new HandRight(br.x, br.y, false, false);           
         }
         
       };
       
       if(demoModus){
         HandLeft demo=new HandLeft(bl.x, bl.y, true, true); 
         left.x=bl.x + (width/2);
         left.y=bl.y + (height/2);
       }
       popStyle();
       popMatrix();

       boolean leftHit=gestureActions.zoomGestureActivation(left, tl,  bl, hitSize);
       boolean rightHit=gestureActions.zoomGestureActivation(right, tr,  br, hitSize);

       handSvgRuser.setFill(color(0));
       handSvgLuser.setFill(color(0));
       
       if(rightHit)  handSvgRuser.setFill(handFeedBack);
       if(leftHit)  handSvgLuser.setFill(handFeedBack);
       
       if(leftHit && rightHit){
           boolean timed = timer.setTimer(0, 0, "scaleActivation");
           if(timed){
             timer.activeId="none";
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
         HandLeft demo=new HandLeft(bl.x, bl.y, true, true); 
         left.x=bl.x + (width/2);
         left.y=bl.y + (height/2);
       }  
     
     
     if(checkHandsSteady(left, right, false, "none")){
       isScaling=false;
       handSvgRuser.setFill(color(0));
       handSvgLuser.setFill(color(0));
       return scaling;
     }; 

     handSvgRuser.setFill(handFeedBack);
     handSvgLuser.setFill(handFeedBack);   

     float distX=right.x-left.x;
     float distY=right.y-left.y;
     
     scaling.x=distX/distXorg;
     scaling.y=distY/distYorg;
    

    lastLeft=left;
    lastRight=right;
     return scaling;

   }
   
   boolean checkHandsSteady(PVector left, PVector right, boolean single, String activeHand){
     
     
      float sens=sensitivity*handSize;
      boolean timed=false;
      boolean timerLeft=false;
      boolean timerRight=false;
   
    if(demoModus && single){
      left.x=random(1000);
      left.y=random(1000);
    };
    
    if( left.x>lastLeft.x-sens && left.x<lastLeft.x+sens && left.y>lastLeft.y-sens && left.y<lastLeft.y+sens){
       timerLeft=true;     
     }
     
     if( right.x>lastRight.x-sens && right.x<lastRight.x+sens &&  right.y>lastRight.y-sens && right.y<lastRight.y+sens){
       timerRight=true;           
     }
    
    if(single){
      if(activeHand=="left" && timerLeft){
        timed = timer.setTimer(left.x-(width/2)-(handSize/2), left.y-(height/2)-(handSize/2), "left");
      }else if(activeHand=="right" && timerRight){
        timed = timer.setTimer(right.x-(width/2)-(handSize/2), right.y-(height/2)-(handSize/2), "right"); 
      }else{
        timer.activeId="none";
      }
      

    }else{

       if( timerLeft && timerRight){
         timed = timer.setTimer(0, 0, "double");
       }else{
         timer.activeId="none";
       }
     
    } 

    if(timed){

        toggleMenus();
        
        timer.activeId="none";
        return timed; 
      };
    
    return timed;
  };

 
 void toggleMenus(){
    handSvgRuser.setFill(color(0));
    handSvgLuser.setFill(color(0));
   
   if(actionsMenu.activeAction!="none"){
    if(mainMenu.activeLayer=="bckgr"){
      subMenu.activeActions="none";
     }else if(mainMenu.activeLayer=="patern" && actionsMenu.activeAction=="primitives"){
      subMenu.activeActions="none"; 
     }else if(mainMenu.activeLayer=="sound" && actionsMenu.activeAction=="vibration"){
      subMenu.activeActions="none"; 
     }
        
      actionsMenu.activeAction="none";
   }else if(subMenu.activeActions!="none"){
      subMenu.activeActions="none";
   }else{
       mainMenu.activeLayer="none";
   };

 }
  
  
}




//class hnds
class HandLeft{
  
  HandLeft(float x, float y, boolean user, boolean activeUser){
    if(user && activeUser){
      shape(handSvgLuser, x-(handSize/1.5), y-(handSize/2), handSize,handSize);
    }else if(user && activeUser==false){
      shape(handSvgLuserInactive, x-(handSize/1.5), y-(handSize/2), handSize,handSize);
    }else{
      shape(handSvgL, x-(handSize/1.5), y-(handSize/2), handSize,handSize);
    }
    if (debug) ellipse(x,y,10,10);
  }
}

class HandRight{
  
    HandRight(float x, float y, boolean user, boolean activeUser){
      
      if(user && activeUser){
        shape(handSvgRuser, x-(handSize/1.25), y-(handSize/2), handSize,handSize);
      }else if(user && activeUser==false){
        shape(handSvgRuserInactive, x-(handSize/1.25), y-(handSize/2), handSize,handSize);
      }else{
        shape(handSvgR, x-(handSize/1.25), y-(handSize/2), handSize,handSize);
      }
      
      if (debug) ellipse(x,y,10,10);
  }
  
}




