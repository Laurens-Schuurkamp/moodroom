class SwipeControl extends XnVPointControl
{

  boolean activated=false;
  int savedTime;
  int totalTime = 6000;


  SwipeControl(){
    println("swipe control constructor");
    //swipeDelay=niteSettings.getInt("swipeDelay");

  }
  
  void setActive(){
    
    
    flowRouter.SetActive(swipeDetector);
    sessionManager.AddListener(flowRouter);
    activated=false;
    
    
    
  };
  
  void setInactive(){
    
    flowRouter.SetActive(waveDetector);
    sessionManager.RemoveListener(flowRouter);
    
  }
  
  void checkActive(){
    
    if(activated==false){
       float w=height/2;
       pushMatrix();
         translate(0,0,1);
         shape(waveActivation, -w/2, -w/2, w ,w);
       popMatrix();    
    }
    
    
    
  }

  ////////////////////////////////////////////////////////////////////////////////////////////
  // XnV callbacks
  // to do add velocity to tweenlist);
  void onSwipeLeft(float fVelocity, float fAngle) {
    println();
    println("--------------------------------------------------------------------------------"); 
    println("onSwipeLeft: fVelocity=" + fVelocity + " , fAngle=" + fAngle);
    if(actionsMenu.activeAction=="none"){
      gestureActions.toggleMenus();
    }
    
  }

  void onSwipeRight(float fVelocity, float fAngle) {
    println();
    println("--------------------------------------------------------------------------------"); 
    println("onSwipeRight: fVelocity=" + fVelocity + " , fAngle=" + fAngle);
    
    gestureActions.toggleMenus();

  }


  void onSwipeUp(float fVelocity, float fAngle) {
    println();
    println("--------------------------------------------------------------------------------"); 
    println("onSwipeUp: fVelocity=" + fVelocity + " , fAngle=" + fAngle);
 
  }

  void onSwipeDown(float fVelocity, float fAngle) {
    println();
    println("--------------------------------------------------------------------------------"); 
    println("onSwipeDown: fVelocity=" + fVelocity + " , fAngle=" + fAngle);
    
  }

  void onPrimaryPointCreate(XnVHandPointContext pContext, XnPoint3D ptFocus) {
    println("onPrimaryPointCreate: swipedetector");
    println("hand point ="+ptFocus.getX());
    activated=true;


  }

  void onPrimaryPointDestroy(int nID) {
    //println("onPrimaryPointDestroy: " + nID); 
   activated=false;   
  }

  void onPointUpdate(XnVHandPointContext pContex) {
    //handPosition=ptPosition.getX();
    //println("handPosition ="+handPosition);
      
    

  }
    
}

