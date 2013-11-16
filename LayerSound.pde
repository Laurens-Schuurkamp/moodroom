class LayerSound{
 
 boolean activated=true;
 float amp=2;
 float beatAmp=0;
  
 LayerSound(){
  println("soundlayer contructor");
 } 
  
 void drawSounds(){
   
  if(!activated)return; 
   
  fft.forward(sound.mix);
  beat.detect(sound.mix);
  
  if(beat.isOnset()){
    if(beatAmp>0){
      beatAmp=beatAmp-(beatAmp/30);
      
    }
     
  }
  
 };
  
  
}
