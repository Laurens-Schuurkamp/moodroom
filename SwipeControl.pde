class SwipeControl extends XnVPointControl
{

  boolean activated=false;
  int savedTime;
  int totalTime = 6000;


  SwipeControl(){
    println("swipe control constructor");
    //swipeDelay=niteSettings.getInt("swipeDelay");

  }

  ////////////////////////////////////////////////////////////////////////////////////////////
  // XnV callbacks
  // to do add velocity to tweenlist);
  void onSwipeLeft(float fVelocity, float fAngle) {
    println();
    println("--------------------------------------------------------------------------------"); 
    println("onSwipeLeft: fVelocity=" + fVelocity + " , fAngle=" + fAngle);
    
  }

  void onSwipeRight(float fVelocity, float fAngle) {
    println();
    println("--------------------------------------------------------------------------------"); 
    println("onSwipeRight: fVelocity=" + fVelocity + " , fAngle=" + fAngle);

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


  }

  void onPrimaryPointDestroy(int nID) {
    //println("onPrimaryPointDestroy: " + nID);    
  }

  void onPointUpdate(XnVHandPointContext pContex) {
    //handPosition=ptPosition.getX();
    //println("handPosition ="+handPosition);
      
    

  }
    
}

