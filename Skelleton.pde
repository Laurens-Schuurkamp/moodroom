class Skelleton {

  PVector      bodyCenter = new PVector();
  PVector      bodyDir = new PVector();
  int[] limbs;
  PVector limb  = new PVector();
  PVector limbP = new PVector();
  PVector head, neck, torso, shoulderleft, elbowleft, handleft, shoulderright, elbowright, 
  handright, hipleft, kneeleft, footleft, hipright, kneeright, footright;
  ArrayList jointPos;
  
  boolean active=false;
  color cf=color(255, 128);
  color cs=color(255);
  boolean xxx=false;
  int tistsScale=3;
  int dickScale=2;

 Skelleton(){
    println("Skelleton constructor");
    
  }


// draw the skeleton with the selected joints
  void getSkeleton(int userID)
  {
      limbs = new int[] { 
        /* 0 */ SimpleOpenNI.SKEL_HEAD, 
        /* 1 */ SimpleOpenNI.SKEL_NECK,
        /* 2 */ SimpleOpenNI.SKEL_TORSO,
        /* 3 */ SimpleOpenNI.SKEL_WAIST, // NOT USED
    
        /* 4 */ SimpleOpenNI.SKEL_LEFT_COLLAR, // NOT USED
        /* 5 */ SimpleOpenNI.SKEL_LEFT_SHOULDER,
        /* 6 */ SimpleOpenNI.SKEL_LEFT_ELBOW,
        /* 7 */ SimpleOpenNI.SKEL_LEFT_WRIST, // NOT USED
        /* 8 */ SimpleOpenNI.SKEL_LEFT_HAND,
        /* 9 */ SimpleOpenNI.SKEL_LEFT_FINGERTIP, // NOT USED
    
        /* 10 */ SimpleOpenNI.SKEL_RIGHT_COLLAR, //NOT USED
        /* 11 */ SimpleOpenNI.SKEL_RIGHT_SHOULDER,
        /* 12 */ SimpleOpenNI.SKEL_RIGHT_ELBOW,
        /* 13 */ SimpleOpenNI.SKEL_RIGHT_WRIST, // NOT USED
        /* 14 */ SimpleOpenNI.SKEL_RIGHT_HAND, 
        /* 15 */ SimpleOpenNI.SKEL_RIGHT_FINGERTIP, // NOT USED
    
        /* 16 */ SimpleOpenNI.SKEL_LEFT_HIP,
        /* 17 */ SimpleOpenNI.SKEL_LEFT_KNEE,
        /* 18 */ SimpleOpenNI.SKEL_LEFT_ANKLE, // NOT USED
        /* 19 */ SimpleOpenNI.SKEL_LEFT_FOOT,
    
        /* 20 */ SimpleOpenNI.SKEL_RIGHT_HIP, 
        /* 21 */ SimpleOpenNI.SKEL_RIGHT_KNEE, 
        /* 22 */ SimpleOpenNI.SKEL_RIGHT_ANKLE, // NOT USED
        /* 23 */ SimpleOpenNI.SKEL_RIGHT_FOOT
      };
    
      jointPos = new ArrayList(limbs.length);
    
    //  println("Limbs: " + limbs.length);
    
      for (int j=1; j <= limbs.length; j++){
        context.getJointPositionSkeleton(userID, j, limb);
        context.convertRealWorldToProjective(limb, limbP);
        jointPos.add(new PVector(limbP.x, limbP.y));
    
    //    println("JOINTPOS: " + jointPos);
      }
      
      head          = (PVector)jointPos.get(0);
      neck          = (PVector)jointPos.get(1);
      torso         = (PVector)jointPos.get(2);
      shoulderleft  = (PVector)jointPos.get(5);
      elbowleft     = (PVector)jointPos.get(6);
      handleft      = (PVector)jointPos.get(8);
      shoulderright = (PVector)jointPos.get(11);
      elbowright    = (PVector)jointPos.get(12);
      handright     = (PVector)jointPos.get(14);
      hipleft       = (PVector)jointPos.get(16);
      kneeleft      = (PVector)jointPos.get(17);
      footleft      = (PVector)jointPos.get(19);
      hipright      = (PVector)jointPos.get(20);
      kneeright     = (PVector)jointPos.get(21);
      footright     = (PVector)jointPos.get(23);
  }

// draw the skeleton with the selected joints
  void drawSkeleton(int userId)
  {
    

    if(active==false)return;

    // to get the 3d joint data
    drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK, "head");
    drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER, "");
    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW, "left_elbow");
    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND, "left_hand");

    drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER, "");
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW, "");
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND, "right_hand");

    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO, "");
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO, "");

    drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP, "left_hip");
    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE, "");
    drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT, "");

    drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP, "");
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE, "");
    drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT, "");  

    // draw body direction
    getBodyDirection(userId, bodyCenter, bodyDir);

    bodyDir.mult(200);  // 200mm length
    bodyDir.add(bodyCenter);

    stroke(255, 200, 200);
    line(bodyCenter.x, bodyCenter.y, bodyCenter.z, 
    bodyDir.x, bodyDir.y, bodyDir.z);

  }
  
  

  void drawLimb(int userId, int jointType1, int jointType2, String name)
  {
    PVector jointPos1 = new PVector();
    PVector jointPos2 = new PVector();
    float  confidence;

    // draw the joint position

    confidence = context.getJointPositionSkeleton(userId, jointType1, jointPos1);
    confidence = context.getJointPositionSkeleton(userId, jointType2, jointPos2);

    // skellet 
    stroke(red(cs), green(cs), blue(cs), confidence * 200 + 55);
    line(jointPos1.x, jointPos1.y, jointPos1.z, jointPos2.x, jointPos2.y, jointPos2.z);

    drawJointOrientation(userId, jointType1, jointPos1, 50, name);

    
  }
  
  float leftX=0;
  float leftY=0;
  float rightX=0;
  float rightY=0;

  void drawJointOrientation(int userId, int jointType, PVector pos, float length, String name)
  {
    // draw the joint orientation  
    PMatrix3D  orientation = new PMatrix3D();
    float confidence = context.getJointOrientationSkeleton(userId, jointType, orientation);
    if (confidence < 0.001f) 
      // nothing to draw, orientation data is useless
      return;
    //println("returning useless skellet");
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    
    //println(name);
    
    if(name=="left_hand"){
      leftX=pos.x;
      leftY=pos.y;
      
    }else if(name=="right_hand"){
      rightX=pos.x;
      rightY=pos.y;
      
    }

    if (name=="head") {

      ellipse(0, 0, 300, 300);
      fill(cf);
      line(-100, 0, -50, 0);
      //eye R
      ellipse(-75, 0, 100, 50);
      line(50, 0, 100, 0);
      //eye l
      ellipse(75, 0, 100, 50);

      //pupils
      ellipse(-50, 0, 10, 10);
      ellipse(50, 0, 10, 10);

      //nose
      line(0, 0, 0, -50);
      ellipse(0, -50, 30, 30);

      // mouth

      line(-50, -85, 50, -85);
      ellipse(-50, -85, 10, 10);
      ellipse(50, -85, 10, 10);
    } 
    else if (name=="left_hip") {

      fill(cf);

      //navel
      ellipse(0, -150, 15, 15);

      if (xxx) {

        //titts
        ellipse(-50, 100, 25*tistsScale, 25*tistsScale);
        ellipse(50, 100, 25*tistsScale, 25*tistsScale);

        //balls
        ellipse(-25, -250, 50, 50);
        ellipse( 25, -250, 50, 50);
        //the dick
        ellipse(0, -300, 15, dickScale*75);
      }
    } 
    else {
      ellipse(0, 0, 100, 100);
    }
    // set the local coordsys
    applyMatrix(orientation);

    popMatrix();
  }
  
  void getBodyDirection(int userId, PVector centerPoint, PVector dir)
  {
    PVector jointL = new PVector();
    PVector jointH = new PVector();
    PVector jointR = new PVector();
    float  confidence;
  
    // draw the joint position
    confidence = context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, jointL);
    confidence = context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, jointH);
    confidence = context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, jointR);
  
    // take the neck as the center point
    confidence = context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, centerPoint);
  
    /*  // manually calc the centerPoint
     PVector shoulderDist = PVector.sub(jointL,jointR);
     centerPoint.set(PVector.mult(shoulderDist,.5));
     centerPoint.add(jointR);
     */
  
    PVector up = new PVector();
    PVector left = new PVector();
  
    up.set(PVector.sub(jointH, centerPoint));
    left.set(PVector.sub(jointR, centerPoint));
  
    dir.set(up.cross(left));
    dir.normalize();
  }


//end class
}



// -----------------------------------------------------------------
// SimpleOpenNI user events
boolean autoCalib=true;
void onNewUser(int userId)
{
  println("onNewUser - userId: " + userId);
  println("  start pose detection");
  
  int[] userList = context.getUsers(); 
  if(userList.length>1) return;
  
  if (autoCalib)
    context.requestCalibrationSkeleton(userId, true);
  else    
    context.startPoseDetection("Psi", userId);
}

void onLostUser(int userId)
{
    //flowRouter.SetActive(waveDetector);
//    waveControl.activated=false;
//    swipeControl.activated=false;
//    swipeControl.swipeHor=false;
//    swipeControl.swipeVer=false;
    int[] userList = context.getUsers(); 
   
    println("onLostUser - userId: " + userId + " users length ="+userList.length);
}

void onExitUser(int userId)
{
    //    flowRouter.SetActive(waveDetector);
    //    waveControl.activated=false;
    //    swipeControl.activated=false;
    //    swipeControl.swipeHor=false;
    //    swipeControl.swipeVer=false;
    int[] userList = context.getUsers(); 
    println("onExitUser - userId: " + userId + " users length ="+userList.length);
}

void onReEnterUser(int userId)
{
  println("onReEnterUser - userId: " + userId);
  
}


void onStartCalibration(int userId)
{
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)
{
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

  if (successfull) 
  { 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId);
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
    context.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId)
{
  println("onStartdPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");

  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
}

void onEndPose(String pose, int userId)
{
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}





