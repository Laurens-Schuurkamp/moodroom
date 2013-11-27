class LayerSound{
 
 boolean activated=true;
 boolean waveActivated=true;
 float amp=2;
 float beatAmp=0;
  
 LayerSound(){
  println("soundlayer contructor");
 } 
  
 void drawSounds(){
   
  if(!activated){
    beatAmp=0;
    return;
  }; 
   
  fft.forward(sound.mix);
  beat.detect(sound.mix);
  
  
  drawWaveVisualisation();
  
  if(beat.isOnset()){
    if(beatAmp>0){
      beatAmp=beatAmp-(beatAmp/30);
      
    }
     
  }
  
 };
 
 void drawWaveVisualisation(){
   if(!waveActivated) return;
   float wl = (width/2) / (fft.specSize());
   //println(fft.specSize());
   pushStyle();
   for(int i = 0; i < fft.specSize(); i++){
        fill(255);
        noStroke();
        float hl=fft.getBand(i)*amp;
        if(hl>0.5){
          rect((width/2)-(i*wl), height/2-(hl/2), wl, hl);
          rect((width/2)+(i*wl), height/2-(hl/2), wl, hl);
        }

   };
   popStyle();
 };

  
}
