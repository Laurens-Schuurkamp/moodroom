class WaveControl extends XnVPointControl
{

  boolean activated=false;

  WaveControl(){
    println("wave control constructor");
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////
  // XnV callbacks

  void onPrimaryPointCreate(XnVHandPointContext pContext, XnPoint3D ptFocus) {
    
    println("onPrimaryPointCreate: wavedetector --> ptFocusWave ="+ptFocus.getX());
    activated=true;
    if(kinectConnected){
      
      pxHandActive=ptFocus.getX();
      flowRouter.SetActive(swipeDetector);
    }
    
  }
  
  void onPrimaryPointDestroy(int nID) {
    //println("onPrimaryPointDestroy: " + nID);    
  }

  void onPointUpdate(XnVHandPointContext pContex) {
    //handPosition=ptPosition.getX();
    //println("handPosition ="+handPosition);

  }
  
  
  
}

