class PushControl  extends XnVPointControl
{

  boolean activated=false;

  PushControl(){
    println("push control constructor");
  };
  
  
  void onPush(float velocity, float angle)
  {
    println("push");
  }
  

  
}
