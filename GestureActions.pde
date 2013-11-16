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
  String scaleLock="none";
  
  
  
  GestureActions(){
    println("gestureScaling constopuctor");
    
    colorPicker = new ColorPicker( 0, 0, width, parseInt(mainMenu.menuHeight), 255 );
    //swipeDelay=niteSettings.getInt("swipeDelay");

  }
  
  boolean checkMenuActive(PVector left, PVector right, float h){
    //println("checking sub items");
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
  
  boolean checkSliderBarActive(PVector hand){
    boolean isActive=false;
    //zit ik in de colorpicker met rechts?
    if( hand.y > (height/2)-(mainMenu.menuHeight/2) && hand.y < (height/2)+(mainMenu.menuHeight/2) ){
        
        isActive=true;
    }
    return isActive;
      
    
  }
  


  color setColor(PVector left, PVector right, color c){
    
    float alpha=alpha(c);
    
    boolean isActive=false;
    PVector hand = new PVector(0,0);
    String activeHand="none";

      if( checkSliderBarActive(right) ){
        hand=right;
        activeHand="right";
        isActive=true;
        handSvgRuser.setFill(handFeedBack);

      }//zit ik in de color picker met links?
      else if( checkSliderBarActive(left) ){
        hand=left;
        activeHand="left";
        isActive=true;
        handSvgLuser.setFill(handFeedBack);

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
      if( checkSliderBarActive(right) ){
        hand=right;
        activeHand="right";
        isActive=true;
        handSvgRuser.setFill(handFeedBack);

      }//zit ik in de color picker met links?
      else if( checkSliderBarActive(left) ){
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
          rect(i*step, -mainMenu.menuHeight/2, step, mainMenu.menuHeight);
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
      if( checkSliderBarActive(right) ){
        hand=right;
        activeHand="right";
        isActive=true;
        handSvgRuser.setFill(handFeedBack);

      }//zit ik in de color picker met links?
      else if( checkSliderBarActive(left) ){
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
      
      rect(0, -mainMenu.menuHeight/2, width, mainMenu.menuHeight );
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
  
  
  
  boolean scaleGestureActivation(PVector hand, PVector hitItem, float hitSize){
    
       boolean hit=false;  
       if ( hand.x - (width/2) > hitItem.x-hitSize && hand.x - (width/2) < hitItem.x+hitSize && hand.y-(height/2) > hitItem.y-hitSize && hand.y-(height/2) < hitItem.y+hitSize ) {
            hit=true;    
       }

    return hit;
   }
  
  boolean scalingActive(PVector left, PVector right, String gestureType){
     
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
        PVector demoPos = bl;
          HandLeft demo=new HandLeft(demoPos.x, demoPos.y, true, true); 
          left.x=demoPos.x + (width/2);
          left.y=demoPos.y + (height/2);
       }
       popStyle();
       popMatrix();
        
       //left hits
       
       boolean leftHitTop=gestureActions.scaleGestureActivation(left, tl, hitSize);
       if(!leftHitTop)leftHitTop=gestureActions.scaleGestureActivation(left, tr, hitSize);
       
       boolean leftHitBottom=gestureActions.scaleGestureActivation(left, bl, hitSize);
       if(!leftHitBottom)leftHitBottom=gestureActions.scaleGestureActivation(left, br, hitSize);
       
       boolean rightHitTop=gestureActions.scaleGestureActivation(right, tr, hitSize);
       if(!rightHitTop) rightHitTop=gestureActions.scaleGestureActivation(right, tl, hitSize);
       
       boolean rightHitBottom=gestureActions.scaleGestureActivation(right, br, hitSize);
       if(!rightHitBottom) rightHitBottom=gestureActions.scaleGestureActivation(right, bl, hitSize);
       

       handSvgRuser.setFill(color(0));
       handSvgLuser.setFill(color(0));
       
       if(leftHitTop || leftHitBottom)  handSvgLuser.setFill(handFeedBack);
       if(rightHitTop || rightHitBottom )  handSvgRuser.setFill(handFeedBack);
       
       
       scaleLock="none";
       boolean timed=false;
       // look voor scale system hor, ver or diagonal
       if ( (leftHitTop && leftHitBottom) || (rightHitTop && rightHitBottom)){
           scaleLock="vertical";
           timed = timer.setTimer(0, 0, "scaleVertical");  
       }else if ( (leftHitTop && rightHitTop) || (leftHitBottom && rightHitBottom)){
           scaleLock="horizontal";
           timed = timer.setTimer(0, 0, "horizontal");
       }else if( (leftHitTop && rightHitBottom) ||  (leftHitBottom && rightHitTop)){ 
           scaleLock="diagonal";
           timed = timer.setTimer(0, 0, "diagonal");
       } ;

       if(timed){
         timer.activeId="none";
         
         distXorg=right.x-left.x;
         distYorg=right.y-left.y;
         deltaOrg = dist(left.x, left.y, right.x, right.y);
         isScaling=true;
       }    

       return isScaling;

   };

   PVector setScale(PVector left, PVector right, PVector scaling){
       
       if(demoModus){
         pushMatrix();
           translate(0,0,2);
           HandLeft demo=new HandLeft(bl.x, bl.y, true, true); 
           left.x=bl.x + (width/2);
           left.y=bl.y + (height/2);
         popMatrix();
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
     PVector newScale=scaling;
     if(scaleLock=="horizontal"){
       scaling.x=distX/distXorg;
     }else if(scaleLock=="vertical"){
       scaling.y=distY/distYorg;
     }else if(scaleLock=="diagonal"){
       scaling.x=distX/distXorg;
       scaling.y=distY/distYorg;
       
     };

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
    actionsMenu.activeAction="none";

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




