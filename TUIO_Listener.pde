/* //<>//
 TUIO 1.1 Demo for Processing
 Copyright (c) 2005-2014 Martin Kaltenbrunner <martin@tuio.org>

 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files
 (the "Software"), to deal in the Software without restriction,
 including without limitation the rights to use, copy, modify, merge,
 publish, distribute, sublicense, and/or sell copies of the Software,
 and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/



// import the TUIO library
import TUIO.*;
// declare a TuioProcessing client
TuioProcessing tuioClient;

// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
float buffer_scale = 0.15; //NOTE THIS MAY HAVE TO BE ADJUSTED AFTER TESTING PHYSICAL SETUP
PFont font;

boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks

boolean farmerSceneTriggered = false;
//boolean timelineVid1Triggered = false;
//boolean timelineVid2Triggered = false;
//boolean timelineVid3Triggered = false;
//boolean timelineVid4Triggered = false;
//boolean timelineVid5Triggered = false;


void setup_TUIO()
{
  
  font = createFont("Arial", 18);
  scale_factor = height/table_size;
  
  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);
}

//Assume the fiducial is placed in the middle of the cup's lid, so we 
//measure a square buffer around the cup centered about the fiducial
//Function takes in intended coordinates of where the cup is "expected" to be

boolean checkCupPosition(TuioObject tobj, float xExpected, float yExpected) {
  float xCup = tobj.getX() * width;
  float yCup = tobj.getY() * height;
  float horizontal_buff = width * buffer_scale;
  float vertical_buff = height * buffer_scale;
  
//  background(timelineScreen);
//  line(tobj.getX() * width, 0, tobj.getX() * width, height); // x
//  stroke(#0000ff);
//  line(0, tobj.getY() * height, width, tobj.getY() * height); // y
//  stroke(#0000ff);
//  
//  line(abs(xExpected - xCup), 0, abs(xExpected - xCup), height); // x
//  stroke(#00ff00);
//  line(0, abs(yExpected - yCup), width, abs(yExpected - yCup)); // y
//  stroke(#00ff00);

  //if cup is within buffered expcted coordinates, return true
  if ((abs(xExpected - xCup) <= horizontal_buff) && (abs(yExpected - yCup) <= vertical_buff)) {
    return true;
  } else { 
    return false;
  }
}

boolean timeCheck(int segment, float mt, float md) {
  if (segment == 1) {
    return (mt < 6.0);
  } else if (segment == 2) {
    return ((mt > 6.0) && (mt < 12.0));
  } else if (segment == 3) {
    return ((mt > 12.0) && (mt < 20.0));
  } else if (segment == 4) {
    return ((mt > 20.0) && (mt < md));
  }
  return false;
}

// within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw_TUIO() {
  textFont(font,18*scale_factor);   
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  
//  if (timelineVid1Triggered) {
//    timelineVid1.play();
//    image(timelineVid1, 0, 0);
//  }
//  if (timelineVid2Triggered) {
//    timelineVid2.play();
//    image(timelineVid2, 0, 0);
//  }
//  if (timelineVid3Triggered) {
//    timelineVid3.play();
//    image(timelineVid3, 0, 0);
//  }
//  if (timelineVid4Triggered) {
//    timelineVid4.play();
//    image(timelineVid4, 0, 0);
//  }
//  if (farmerSceneTriggered) {
//    farmerScene.play();
//    image(farmerScene, 0, 0);
//  }
  
  
   /* -------------------------------------------------------------
   --- FEDUCIAL DETECTION (ENVIRONMENT AND OBJECT CHANGES) -----
   --------------------------------------------------------------- */
   // Determine which fiducials are present on the screen
   if(tuioObjectList.size() > 0) {
     TuioObject last = tuioObjectList.get(0); // Each new fiducial is added to start of arraylist
     float timeline_md = timelineVideo.duration();
     float timeline_mt = timelineVideo.time();
     
     if (checkCupPosition(last, 5.0*table_size/6.0, table_size/6.0) && timeCheck(1, mt, md)) {
       timelineVideo.play();
       image(timelineVideo,0,0);
     } else if (checkCupPosition(last, 4.0*table_size/6.0, table_size/6.0) && timeCheck(2, mt, md)) {
       timelineVideo.play();
     } else if (checkCupPosition(last, 3.0*table_size/6.0, table_size/6.0) && timeCheck(3, mt, md)) {
       timelineVideo.play();
     } else if (checkCupPosition(last, 2.0*table_size/6.0, table_size/6.0) && timeCheck(4, mt, md)) {
       timelineVideo.play();
     } else {
       timelineVideo.pause();
     }
     
//     if (checkCupPosition(last, 5.0*table_size/6.0, table_size/6.0)) { // trigger timelineVid1
//         //LOAD VID1
//         timelineVid1Triggered = true;
//       } else if (checkCupPosition(last, 4.0*table_size/6.0, table_size/6.0) && timelineVid1Triggered) { // trigger timelineVid2
//         //LOAD VID2
//         timelineVid2Triggered = true;
//       } else if (checkCupPosition(last, 3.0*table_size/6.0, table_size/6.0) && timelineVid2Triggered) { // trigger timelineVid3
//         //LOAD VID3
//         timelineVid3Triggered = true;
//       } else if (checkCupPosition(last, 2.0*table_size/6.0, table_size/6.0) && timelineVid3Triggered) { // trigger timelineVid4
//         //LOAD VID4
//         timelineVid4Triggered = true;
//       }
//       else { // Default to black screen
//          background(0,0,0); // black
//       }
      
   }
}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
          +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}


