import SimpleOpenNI.*;
import processing.opengl.*;
import megamu.shapetween.*;
import geomerative.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import processing.video.*;
import controlP5.*; //controls
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

JSONArray swipe_objects; 
boolean httpResponse=false;

XML xmlSettings;
XML mainSettings;
XML niteSettings;
XML niteDefaults;

Minim minim;
AudioInput sound;
//AudioPlayer sound;
FFT fft;
BeatDetect beat;

// NITE & Kinect
SimpleOpenNI context;
XnVPushDetector pushDetector;
PushControl pushControl;
XnVSessionManager sessionManager;
XnVWaveDetector waveDetector;
WaveControl waveControl;
XnVSwipeDetector swipeDetector;
XnVFlowRouter flowRouter;
SwipeControl swipeControl;
int depthWidth;
int depthHeigth;


MainMenu mainMenu;
SubMenu subMenu;
ActionsMenu actionsMenu;
Skelleton skelleton;
PointCloud3D pointCloud3D;
LayerSound layerSound;
GestureActions gestureActions;
ColorPicker colorPicker;
PrimitivesPicker primitivesPicker;
Timer timer;

LayerPatern layerPatern;
String layers[]={"bckgr", "patern", "pointcloud", "sound"};
int menuLevel=0;

boolean kinectConnected=true;
boolean demoModus=false;
boolean debug=false;
String ip;
String port;
String serverUrl;

ControlP5 cp5;
ControlFrame cf;

Tween mainTweener;
Tween subTweener;
Shaper cosine;
float duration=30;

float zoom;


float        zoomF =1.0f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
// the data from openni comes upside down
float        rotY = radians(0);

float s;  //screen scale
int padding=24;

PFont font64, font48, font36, font32, font28, font24, font16, font12, font10;

//hands
float lx,ly,rx,ry, bodyX;
boolean drawHands=false;
PShape handSvgR;
PShape handSvgL;
PShape handSvgRuserInactive;
PShape handSvgLuserInactive;
PShape handSvgRuser;
PShape handSvgLuser;
PShape waveActivation;
float pxHandActive=0;
float handSize=150;
float adjustOffset;

boolean init=false;

PVector leftPos;
PVector rightPos;
float sensitivity=0.1;
color handFeedBack=color(255,0,255);

color colorBckgr=color(0);



void setup()
{
  xmlSettings = loadXML("data/appSettings.xml");
  mainSettings= xmlSettings.getChild("mainSettings");
  niteSettings= xmlSettings.getChild("niteSettings");
  niteDefaults= xmlSettings.getChild("niteDefaults");
  
  //server settings
  ip=mainSettings.getString("ip");
  port=mainSettings.getString("port");
  serverUrl="http://"+ip+":"+port+"/";
  println("server ="+serverUrl);
  
  s =mainSettings.getFloat("height")/800;
  int screenWidth=parseInt(s*1280);
  int screenHeight=parseInt(s*800);

  size(screenWidth, screenHeight, OPENGL);
  zoom=screenHeight/640;
  padding=parseInt(24*s);
  
  println("demoModus ="+mainSettings.getString("demoModus"));
  if( mainSettings.getString("demoModus").equals("true")){
    demoModus=true;
    kinectConnected=false;
    
  }
  
  context = new SimpleOpenNI(this, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  
  //pushControl = new PushControl();
  //pushDetector = new XnVPushDetector();
  waveControl= new WaveControl();
  waveDetector = new XnVWaveDetector();
  swipeControl = new SwipeControl();
  swipeDetector = new XnVSwipeDetector(true); 
  swipeDetector.SetSteadyDuration(niteSettings.getInt("SteadyDuration"));
  swipeDetector.SetMotionTime(niteSettings.getInt("MotionTime")); 
  swipeDetector.SetMotionSpeedThreshold(niteSettings.getFloat("MotionSpeedThreshold"));  
  swipeDetector.SetXAngleThreshold(niteSettings.getFloat("XAngleThreshold"));
  swipeDetector.SetYAngleThreshold(niteSettings.getFloat("YAngleThreshold"));

  mainMenu = new MainMenu();
  subMenu = new SubMenu();
  actionsMenu =  new ActionsMenu();
  skelleton=new Skelleton();
  pointCloud3D = new PointCloud3D();
  layerSound = new LayerSound();
  gestureActions = new GestureActions();
  primitivesPicker = new PrimitivesPicker();
  timer = new Timer();
  
  layerPatern = new LayerPatern();
  
  
  if (kinectConnected) {
    // mirror is by default enabled
    context.setMirror(true);

    // enable depthMap generation 
    if (context.enableDepth() == false)
    {
      println("Can't open the depthMap, maybe the camera is not connected!"); 
      exit();
      return;
    }

    // enable the hands + gesture
    context.enableGesture();
    context.enableHands();

    // setup NITE 
    sessionManager = context.createSessionManager("Click,Wave", "RaiseHand");
    
    waveDetector.RegisterPrimaryPointCreate(waveControl);
        
    //pushDetector.RegisterPush(pushControl);
    
    // swipe 
    //swipeDetector.RegisterSwipeLeft(swipeControl); 
    //swipeDetector.RegisterSwipeRight(swipeControl);
    //swipeDetector.RegisterSwipeUp(swipeControl); 
    //swipeDetector.RegisterSwipeDown(swipeControl); 
    swipeDetector.RegisterPrimaryPointCreate(swipeControl);
    swipeDetector.RegisterPrimaryPointDestroy(swipeControl);
    //swipeDetector.RegisterPointUpdate(swipeControl);
    
    flowRouter = new XnVFlowRouter();
    //flowRouter.SetActive(swipeDetector);
    flowRouter.SetActive(waveDetector);
    //flowRouter.SetActive(pushDetector);
    sessionManager.AddListener(flowRouter);
    //sessionManager.RemoveListener(flowRouter);

    //sessionManager.AddListener(swipeDetector);
   
    context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
    
    depthWidth = context.depthWidth();
    depthHeigth = context.depthHeight();
    
  }
  
  if(mainSettings.getString("debug").equals("true")){
    debug=true;
    cp5 = new ControlP5(this);
    cf = addControlFrame("debug setting", 320,640);
  }
    
  font64 = createFont("VAGRoundedLightSSi", 64);
  font48 = createFont("VAGRoundedLightSSi", 48);
  font36 = createFont("VAGRoundedLightSSi", 36);
  font32 = createFont("VAGRoundedLightSSi", 32);
  font28 = createFont("VAGRoundedLightSSi", 28);
  font24 = createFont("VAGRoundedLightSSi", 24);
  font16 = createFont("VAGRoundedLightSSi", 16);
  font12 = createFont("VAGRoundedLightSSi", 12);
  font10 = createFont("VAGRoundedLightSSi", 10);
  
   
  minim = new Minim(this);
  sound = minim.getLineIn(Minim.STEREO, 1024);;
  
  //String path = "data/sounds/timo-maas.mp3";
  //sound = minim.loadFile(path, 1024);
  //sound.loop();
  
  fft = new FFT(sound.bufferSize(), sound.sampleRate());
  beat = new BeatDetect();
  
  mainTweener = new Tween(this, 0.5);
  cosine = new CosineShaper( Tween.OUT );
  mainTweener.setEasing( cosine );
  mainTweener.end();
  
  subTweener = new Tween(this, 0.5);
  subTweener.setEasing( cosine );
  subTweener.end();

  RG.init(this);
  //rfont64 = new RFont( "data/fonts/vagrlsb_.ttf", 64, RFont.LEFT);
  //rfont48 = new RFont( "data/fonts/vagrlsb_.ttf", 48, RFont.LEFT);
  
  handSvgRuser  = loadShape("data/gui/hand_r.svg");
  handSvgLuser  = loadShape("data/gui/hand_l.svg");
  
  handSvgRuserInactive  = loadShape("data/gui/hand_r.svg");
  handSvgLuserInactive  = loadShape("data/gui/hand_l.svg");
  handSvgRuserInactive.setFill(color(128,64));
  handSvgLuserInactive.setFill(color(128,64));
  
  handSvgR  = loadShape("data/gui/hand_r.svg");
  handSvgL  = loadShape("data/gui/hand_l.svg");
  
  waveActivation = loadShape("data/gui/wave.svg");
  
  handSize=95*s;
  adjustOffset=handSize;
  perspective(radians(60), float(width)/float(height), 10.0f, 150000.0f);
  frameRate(60);
  smooth(8);

}

void draw() {

  background(colorBckgr);

  if(debug){
    cf.framerate.setText("framerate ="+round(frameRate)+" fps");
  };
  
  layerSound.drawSounds();

  PVector left=new PVector(0, 0);
  PVector right=new PVector(0,0);
    // set the scene pos
    translate(width/2, height/2, 0);
    
    if (kinectConnected) {
      
      
      context.update();
      context.update(sessionManager);
      
      int[] userList = context.getUsers();
      
      pushMatrix();
        rotateX(rotX);
        rotateY(rotY);
        scale(zoomF);
        translate(0,0,0-1250);

      pushStyle();
      for(int i=0;i<userList.length;i++)
       {
         skelleton.drawSkeleton(userList[i]);
       };
      popStyle();

      pointCloud3D.drawPointCloud(userList);

      popMatrix();
     

      //hands
      if (userList.length<=0){
          waveControl.activated=false;
          
          drawHands=false;
          waveControl.checkActive();
          //flowRouter.SetActive(waveDetector);
          
      }else{
          //swipeControl.checkActive();
          waveControl.activated=true;      
          waveControl.checkActive();
          drawHands=true;
          
         
          if(drawHands){
            for(int i=0;i<userList.length;i++)
            {
              if(context.isTrackingSkeleton(userList[i])){

              skelleton.getSkeleton(userList[i]);

              lx = map(skelleton.handleft.x, 0, context.depthWidth(), 0-adjustOffset, width+adjustOffset);
              ly = map(skelleton.handleft.y, 0, context.depthHeight(), 0-adjustOffset, height+adjustOffset);
              rx = map(skelleton.handright.x, 0, context.depthWidth(), 0-adjustOffset, width+adjustOffset);
              ry = map(skelleton.handright.y, 0, context.depthHeight(), 0-adjustOffset, height+adjustOffset);

              left=new PVector(lx, ly);
              right=new PVector(rx, ry);

              pushMatrix();
                translate(0,0,3);  
                //handSvgR.setStroke(color(255));
                //handSvgL.setStroke(color(255));
                if(i==0){
                  HandLeft hl=new HandLeft(lx-(width/2), ly-(height/2), true, true);
                  HandRight hr=new HandRight(rx-(width/2), ry-(height/2), true, true);
                }else{
                  HandLeft hl=new HandLeft(lx-(width/2), ly-(height/2), true, false);
                  HandRight hr=new HandRight(rx-(width/2), ry-(height/2), true, false);
                }
                 
               popMatrix();
                
                if(i==0 ){
                  pushMatrix();
                    translate(0,0,1);
                    mainMenu.drawMenu(left, right , i);
                  popMatrix();
                }
                
              }

            }

          }
        
      }

  }
  
  layerPatern.drawLayer();
  
  if(demoModus){
    left=new PVector(mouseX, mouseY);
    right=new PVector(mouseX, mouseY);
    pushMatrix();
      translate(0,0,2);
      HandRight hr=new HandRight(mouseX-(width/2), mouseY-(height/2), true, true);
      //HandLeft hl=new HandLeft(-(width/4), -(height/4), true, false);
    popMatrix();
    mainMenu.drawMenu(left, right, 0); 
    
  }
  
  //println("menu level ="+menuLevel);

  if(init==false){
    init=true;
    
  }
  
}


void updateTweenMain() {


}

void startMainTween(boolean newTween, String tweenDirection) {
  duration=15;
  mainTweener.setDuration(15, Tween.FRAMES);
  //mainTweener.setPlayMode( Tween.ONCE );
  mainTweener.start();

}

void startSubTween(int dir) {
   subTweener.start();
}


void keyReleased()
  {
    
    //if(kinectConnected) return;
    
    if (key == CODED) {
      
      if (keyCode == LEFT) {

     } else if (keyCode == RIGHT) {

      
     } else if (keyCode == UP) {

      
     }else if (keyCode == DOWN) {

         
     }
     
    }

    switch(keyCode)
    {
      
      case 'R':
        println("key R released");
        layerPatern.reset();
        pointCloud3D.reset();
        skelleton.activated=false;
     
    }
  
  }
  
  void mouseReleased() {
  
//  if (mouseX<(width/3)) {
//    //println("left"); 
//    direction=-1;
//    startMainTween();
//  }else if (mouseX > (width-(width/3) )) {
//    //println("right");
//    direction=1;
//    startMainTween();
//  } else if (mouseY < (height/2) ){
//    
//    startSubTween(-1);
//  }else if (mouseY > (height/2) ){
//    startSubTween(1);
//    
//  }

}

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(10, 10);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}



void setTextHeader(String header){
  
  fill(0);
  //stroke(255);
  noStroke();
  rect(-width/4, -(mainMenu.menuHeight/2)-(3*padding), width/2, (4*padding), 15 );
  rect(-width/2, -(mainMenu.menuHeight/2)-padding, width, mainMenu.menuHeight+(2*padding) );
  stroke(0);
  fill(255);
  textFont(font36, 36);
  textAlign(CENTER, CENTER);
  text(header, 0, -(mainMenu.menuHeight/2)-(2*padding));
  
};

