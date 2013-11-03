import SimpleOpenNI.*;
import processing.opengl.*;
import megamu.shapetween.*;
import geomerative.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import processing.video.*;
import controlP5.*; //controls

JSONArray swipe_objects; 
boolean httpResponse=false;

XML xmlSettings;
XML mainSettings;
XML niteSettings;
XML niteDefaults;

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

MainMenu mainMenu;
SubMenu subMenu;
Skelleton skelleton;
PointCloud3D pointCloud3D;
GestureActions gestureActions;
Timer timer;

LayerPatern layerPatern;

boolean kinectConnected=true;
boolean demoModus=false;
boolean debug=false;
String ip;
String port;
String serverUrl;

Boolean menuActive=false;

ControlP5 cp5;
ControlFrame cf;

Tween mainTweener;
Tween subTweener;
Shaper cosine;
float duration=100;

int screenWidth;
int screenHeight;
float zoom;

float        zoomF =1.0f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
// the data from openni comes upside down
float        rotY = radians(0);

float s;  //screen scale
float padding=24*s;

String layers[]={"bckgr", "patern", "pointcloud", "sound"};

RFont rfont64;
RFont rfont48;

PFont font64;
PFont font48;
PFont font32;
PFont font28;
PFont font24;
PFont font16;
PFont font12;
PFont font10;


//hands
float lx,ly,rx,ry, bodyX;
boolean drawHands=false;
PShape handSvgR;
PShape handSvgL;
PShape handSvgRuser;
PShape handSvgLuser;
float pxHandActive=0;
float handSize=150;
float adjustOffset;

boolean init=false;

PVector leftPos;
PVector rightPos;
color handFeedBack=color(255,0,0);


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
  
  s =mainSettings.getFloat("height")/960;
  screenWidth=parseInt(s*1280);
  screenHeight=parseInt(s*1024);

  size(screenWidth, screenHeight, OPENGL);
  zoom=screenHeight/640;
  
  println("demoModus ="+mainSettings.getString("demoModus"));
  if( mainSettings.getString("demoModus").equals("true")){
    demoModus=true;
    kinectConnected=false;
    
  }
  
  context = new SimpleOpenNI(this, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  
  pushControl = new PushControl();
  pushDetector = new XnVPushDetector();
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
  skelleton=new Skelleton();
  pointCloud3D = new PointCloud3D();
  gestureActions = new GestureActions();
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
        
    pushDetector.RegisterPush(pushControl);
    
    // swipe 
    swipeDetector.RegisterSwipeLeft(swipeControl); 
    swipeDetector.RegisterSwipeRight(swipeControl);
    swipeDetector.RegisterSwipeUp(swipeControl); 
    swipeDetector.RegisterSwipeDown(swipeControl); 
    swipeDetector.RegisterPrimaryPointCreate(swipeControl);
    swipeDetector.RegisterPrimaryPointDestroy(swipeControl);
    swipeDetector.RegisterPointUpdate(swipeControl);
    
    flowRouter = new XnVFlowRouter();
    //flowRouter.SetActive(swipeDetector);
    flowRouter.SetActive(waveDetector);
    //flowRouter.SetActive(pushDetector);
    sessionManager.AddListener(flowRouter);

    //sessionManager.AddListener(swipeDetector);
   
    context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  }
  
  if(mainSettings.getString("debug").equals("true")){
    debug=true;
    cp5 = new ControlP5(this);
    cf = addControlFrame("debug setting", 320,640);
  }
    
  font64 = createFont("VAGRoundedLightSSi", 64);
  font48 = createFont("VAGRoundedLightSSi", 48);
  font32 = createFont("VAGRoundedLightSSi", 32);
  font28 = createFont("VAGRoundedLightSSi", 28);
  font24 = createFont("VAGRoundedLightSSi", 24);
  font16 = createFont("VAGRoundedLightSSi", 16);
  font12 = createFont("VAGRoundedLightSSi", 12);
  font10 = createFont("VAGRoundedLightSSi", 10);

  mainTweener = new Tween(this, 0.5);
  cosine = new CosineShaper( Tween.OUT );
  mainTweener.setEasing( cosine );
  mainTweener.end();
  
  subTweener = new Tween(this, 0.5);
  subTweener.setEasing( cosine );
  subTweener.end();

  RG.init(this);
  rfont64 = new RFont( "data/fonts/vagrlsb_.ttf", 64, RFont.LEFT);
  rfont48 = new RFont( "data/fonts/vagrlsb_.ttf", 48, RFont.LEFT);
  
  handSvgRuser  = loadShape("data/gui/hand_r.svg");
  handSvgLuser  = loadShape("data/gui/hand_l.svg");
  
  handSvgR  = loadShape("data/gui/hand_r.svg");
  handSvgL  = loadShape("data/gui/hand_l.svg");
  
  handSize=95*s;
  adjustOffset=handSize;
  perspective(radians(60), float(width)/float(height), 10.0f, 150000.0f);

  smooth(8);


}





void draw() {


  background(0);
  if(debug){
    cf.framerate.setText("framerate ="+round(frameRate)+" fps");
  };

  
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
        
        //pointCloud3D.drawPointCloud();
        
        
        //skelleton  
        for(int i=0;i<userList.length;i++)
        {
          if(context.isTrackingSkeleton(userList[i])){
            //skelleton.drawSkeleton(userList[i]);
          }
        }
        
      popMatrix();

      //hands
      if (userList.length<=0){
          drawHands=false;
          //flowRouter.SetActive(waveDetector);
          
      }else{
                
          drawHands=true;
          if(drawHands){
            skelleton.getSkeleton(userList[0]);
            bodyX=map(skelleton.torso.x, 0, context.depthWidth(), 0-adjustOffset, width+adjustOffset);
            lx = map(skelleton.handleft.x, 0, context.depthWidth(), 0-adjustOffset, width+adjustOffset);
            ly = map(skelleton.handleft.y, 0, context.depthHeight(), 0-adjustOffset, height+adjustOffset);
            rx = map(skelleton.handright.x, 0, context.depthWidth(), 0-adjustOffset, width+adjustOffset);
            ry = map(skelleton.handright.y, 0, context.depthHeight(), 0-adjustOffset, height+adjustOffset);
            
            PVector left=new PVector(lx, ly);
            PVector right=new PVector(rx, ry);
            
            pushMatrix();
              translate(0,0,2);  
              //handSvgR.setStroke(color(255));
              //handSvgL.setStroke(color(255));
              
              HandLeft hl=new HandLeft(lx-(width/2), ly-(height/2), true);
              HandRight hr=new HandRight(rx-(width/2), ry-(height/2), true);
              
//              shape(handSvgR, rx-(width/2)-(handSize/2), ry-(height/2)-(handSize/2), handSize,handSize);
//              shape(handSvgL, lx-(width/2)-(handSize/2), ly-(height/2)-(handSize/2), handSize,handSize);
              
              
            popMatrix();

            
            mainMenu.drawMenu(left, right);
          }
        
      }

  }
  
  layerPatern.drawLayer();
  
  if(demoModus){
    PVector left=new PVector(mouseX, mouseY);
    PVector right=new PVector(mouseX, mouseY);
    
    mainMenu.drawMenu(left, right);
    pushMatrix();
      translate(0,0,1);
      HandRight hr=new HandRight(mouseX-(width/2), mouseY-(height/2), true);
    popMatrix();
  }else{
   
    
  };
  
   
  
  if(init==false){
    init=true;
    //mainmenu.drawMenu();
    //subMenu.drawMenu();
    
  }
  
}


void updateTweenMain() {


}


void startMainTween(boolean newTween, int tweenDirection) {
   
  mainTweener.setDuration(duration, Tween.FRAMES);
  mainTweener.start();

}

void startSubTween(int dir) {

   subTweener.start();
    
}





void keyReleased()
  {
    
    if(kinectConnected) return;
    
    if (key == CODED) {
      
      if (keyCode == LEFT) {

     } else if (keyCode == RIGHT) {

      
     } else if (keyCode == UP) {

      
     }else if (keyCode == DOWN) {

         
     }
     
    }

    switch(keyCode)
    {
      
      case 'S':
        println("key S released");
        return;
      case 'W':
        println("key W released");
        return;
      case 'P':
        println("key P released");
        return;
      case 'C':
        println("key C released");

     
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


class HandLeft{
  
  HandLeft(float x, float y, boolean user){
    if(user){
      shape(handSvgLuser, x-(handSize/1.5), y-(handSize/2), handSize,handSize);
    }else{
      shape(handSvgL, x-(handSize/1.5), y-(handSize/2), handSize,handSize);
    }
    
    
    if (debug) ellipse(x,y,10,10);
  }
}

class HandRight{
  
    HandRight(float x, float y, boolean user){
      
      if(user){
        shape(handSvgRuser, x-(handSize/1.25), y-(handSize/2), handSize,handSize);
      }else{
        shape(handSvgR, x-(handSize/1.25), y-(handSize/2), handSize,handSize);
      }
      
      if (debug) ellipse(x,y,10,10);
  }
  
}












