// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  
  float lat=0.0;
  float lng=0.0;
  boolean init=true;
  
  Textlabel framerate;
  
  public void setup() {
        
    PFont font = createFont("arial",20);
    
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    
     cp5.addTextlabel("labelSwipe")
                    .setText("Swipe settings")
                    .setPosition(10,20)
                    .setFont(createFont("arial",20))
                    ;
                    
                  

         
     cp5.addSlider("SteadyDuration").setRange(0, 500).setPosition(10,60).setSize(200,16).setValue(niteSettings.getInt("SteadyDuration"));

     cp5.addSlider("MotionTime").setRange(0, 1000).setPosition(10,90).setSize(200,16).setValue(niteSettings.getInt("MotionTime"));
     
     cp5.addSlider("MotionSpeedThreshold").setRange(0.0, 1.0).setPosition(10,120).setSize(200,16).setValue(niteSettings.getFloat("MotionSpeedThreshold"));
     
     cp5.addSlider("XAngleThreshold").setRange(0, 100).setPosition(10,150).setSize(200,16).setValue(niteSettings.getFloat("XAngleThreshold"));
     
     cp5.addSlider("YAngleThreshold").setRange(0, 100).setPosition(10,180).setSize(200,16).setValue(niteSettings.getFloat("YAngleThreshold"));
     
     cp5.addSlider("swipeDelay").setRange(0, 5000).setPosition(10,210).setSize(200,16).setValue(niteSettings.getInt("swipeDelay"));
     
     cp5.addTextlabel("labelMain")
                    .setText("Main settings")
                    .setPosition(10,250)
                    .setFont(createFont("arial",20))
                    ;
                    
     cp5.addSlider("mainTweener").setRange(0, 100).setPosition(10,290).setSize(200,16).setValue(30);
     cp5.addSlider("subTweener").setRange(0, 100).setPosition(10,320).setSize(200,16).setValue(30);

     cp5.addToggle("skelletActive")
     .setPosition(10,360)
     .setSize(16,16)
     ;

     
     
     framerate = cp5.addTextlabel("framerate")
                    .setText("framerate =")
                    .setPosition(10,h-100)
                    .setFont(createFont("arial",20))
                    ;
     
     
     cp5.addButton("reset_defaults")
     .setValue(0)
     .setPosition(10,h-60)
     .setSize(140,32)
     ;
     
     cp5.addButton("save_xml_settings")
     .setValue(0)
     .setPosition(170,h-60)
     .setSize(140,32)
     ;
     
  textFont(font);
  init=true;
  }
  
  
  void SteadyDuration(int value) {
      if(init==false){
         return;
      }
    
      if(value<=0){
        swipeDetector.SetUseSteady(false);//
      }else{
        swipeDetector.SetUseSteady(true);
        
      }
      
      swipeDetector.SetSteadyDuration(value);
      

  }
  
  void MotionTime(int value) { 
   if(init==false){
       return;
    } 
      swipeDetector.SetMotionTime(value);
      

  }
  
  void MotionSpeedThreshold(float value) {
    if(init==false){
       return;
    }
    swipeDetector.SetMotionSpeedThreshold(value);
    

  }
  void XAngleThreshold(float value) {
    if(init==false){
       return;
    }
      swipeDetector.SetXAngleThreshold(value);
      

  }
  void YAngleThreshold(float value) {
    if(init==false){
       return;
    }
    swipeDetector.SetYAngleThreshold(value);

  }
  
  void swipeDelay(int value) {
    if(init==false){
       return;
    }


  }
  
  void skelletActive(boolean value){
    if(init==false){
       return;
    }
    println("checkbox :"+value);
    
  }

  public void reset_defaults() {
        
    if(init==false){
       return;
    }
   
   println("resetting defaults"); 
    
    cp5.get(Slider.class,"SteadyDuration").setValue(niteDefaults.getInt("SteadyDuration"));
    cp5.get(Slider.class,"MotionTime").setValue(niteDefaults.getInt("MotionTime"));
    cp5.get(Slider.class,"MotionSpeedThreshold").setValue(niteDefaults.getFloat("MotionSpeedThreshold"));
    cp5.get(Slider.class,"XAngleThreshold").setValue(niteDefaults.getFloat("XAngleThreshold"));
    cp5.get(Slider.class,"YAngleThreshold").setValue(niteDefaults.getFloat("YAngleThreshold"));
    cp5.get(Slider.class,"swipeDelay").setValue(niteDefaults.getInt("swipeDelay"));
    
    //println("xml settings defaults ="+niteDefaults);

  }
  
  public void save_xml_settings() {
    
    if(init==false){
       return;
    } 
    
//     XML niteSettingsOld= xmlSettings.getChild("niteSettings");
//     xmlSettings.removeChild(niteSettingsOld);
//     niteSettings.setInt("SteadyDuration",  parseInt(cp5.get(Slider.class,"SteadyDuration").getValue()) );
//     niteSettings.setInt("MotionTime",  parseInt(cp5.get(Slider.class,"MotionTime").getValue()) );
//     niteSettings.setFloat("MotionSpeedThreshold",  cp5.get(Slider.class,"MotionSpeedThreshold").getValue() );
//     niteSettings.setFloat("XAngleThreshold",  cp5.get(Slider.class,"XAngleThreshold").getValue() );
//     niteSettings.setFloat("YAngleThreshold",  cp5.get(Slider.class,"YAngleThreshold").getValue() );
//     niteSettings.setFloat("swipeDelay",  cp5.get(Slider.class,"swipeDelay").getValue() );
//     xmlSettings.addChild(niteSettings);
//     saveXML(xmlSettings, "test/appSettings_test.xml");
//     
//     println("save xml settings ="+niteSettings+" && nite defaults ="+niteDefaults);  
     
     

  }
  

  public void draw() {
      background(abc);
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  
  ControlP5 cp5;

  Object parent;

  
}

