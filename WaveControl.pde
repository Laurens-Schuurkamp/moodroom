class WaveControl extends XnVPointControl
{

  boolean activated=true;

  WaveControl(){
    println("wave control constructor");
  }
  
  void setActive(){
    activated=true;
    flowRouter.SetActive(waveDetector);
    
  }
  
  void checkActive(){
    
    if(activated==false){
       float w=height/2;
       pushMatrix();
         translate(0,0,2);
         //shape(waveActivation, -w/2, -w/2, w ,w);
       popMatrix();    
    }
    
    
    
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////
  // XnV callbacks

  void onPrimaryPointCreate(XnVHandPointContext pContext, XnPoint3D ptFocus) {
    
    println("onPrimaryPointCreate: wavedetector --> ptFocusWave ="+ptFocus.getX());
      //flowRouter.SetActive(pushDetector);
      activated=true;
      
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

