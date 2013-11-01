class Timer{
  
 int timer = 2000;
 int timeActivation; 
 
 Timer(){
  println("timer constructor");
  
 } 

 
 boolean setTimer(float x, float y) {
   
    float r=75;
    // Calculate how much time has passed
    float passedTime =  millis() - timeActivation;
    
    // Has five seconds passed?
    if (passedTime > timer) {
      return true;
      //activeHitId=-1;
    }else{
      float timerProgress= (passedTime / timer);
      
      if(timerProgress>0.1 && timerProgress<1){
            pushMatrix();
              translate(x,y,10);
              rotate(-PI/2);
              stroke(255);
              fill(0);
              arc( 0, 0, r*s, r*s, 0, TWO_PI );
              fill(timerProgress*255);
              fill(255);
              stroke(0);
              arc( 0, 0, r*s, r*s, 0, (TWO_PI*timerProgress) );
            popMatrix();
          } 
      return false;
      
    }
 }
  
  
  
  
  
}



