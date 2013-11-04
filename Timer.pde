class Timer{
  
 int timer = 2000;
 int timeActivation;
 String activeId="none";
 int delay = 500;
 
 Timer(){
  println("timer constructor");
  
 } 

 
 boolean setTimer(float x, float y, String id) {
   
   
    if(id!=activeId){
       timeActivation=millis()+delay;
       activeId=id;  
    } 

    float r=75;
    // Calculate how much time has passed
    float passedTime =  millis() - timeActivation;
    
    // Has five seconds passed?
    if (passedTime > timer) {
      activeId="none";
      return true;
      
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



