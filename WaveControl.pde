class WaveControl extends XnVPointControl
{

  boolean activated=false;

  WaveControl(){
    println("wave control constructor");
  }
  
  void setActive(){
    activated=true;
    flowRouter.SetActive(waveDetector);
    
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////
  // XnV callbacks

  void onPrimaryPointCreate(XnVHandPointContext pContext, XnPoint3D ptFocus) {
    
    println("onPrimaryPointCreate: wavedetector --> ptFocusWave ="+ptFocus.getX());
      flowRouter.SetActive(pushDetector);
      activated=false;
      mainMenu.activated=true;
     // pxHandActive=ptFocus.getX();

  }
  
  void onPrimaryPointDestroy(int nID) {
    //println("onPrimaryPointDestroy: " + nID);    
  }

  void onPointUpdate(XnVHandPointContext pContex) {
    //handPosition=ptPosition.getX();
    //println("handPosition ="+handPosition);

  }
  
  
  
}

