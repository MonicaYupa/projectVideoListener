import processing.video.*;

/*
This is the main code for the project.
Contains the setup() and draw() function.
*/

// Global variables
int WINDOW_HEIGHT = 540;
int WINDOW_WIDTH = 950;

//Screen display
Capture cam = null;

Movie farmerScene;
Movie timelineScene;
//Movie timelineVid1;
//Movie timelineVid2;
//Movie timelineVid3;
//Movie timelineVid4;
//Movie timelineVid5;

PImage bg = null;
PImage welcome = null;
float startTime = second();

void setup()
{
  // GUI setup; this sets the relevant parameters for the size of the screen, and framerate.
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  frameRate(30);
  setupEnvironments();
  setup_TUIO();
  
  // Webcam setup
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    // TODO: Put a safety hack here
    cam = new Capture(this, cameras[15]);
    cam.start();
  }
}

void setupEnvironments()
{
  farmerScene = new Movie(this, "farmerScene.mp4");
  timelineVideo = new Movie(this, "onevideo.mp4");
//  timelineVid1 = new Movie(this, "p1small.mov");
//  timelineVid2 = new Movie(this, "p2small.mov");
//  timelineVid3 = new Movie(this, "p3small.mov");
//  timelineVid4 = new Movie(this, "p4small.mov");
//  timelineVid5 = new Movie(this, "p5small.mov");
  //background(0,0,0); // black
}

void draw() 
{  
  draw_TUIO();  

}

void movieEvent(Movie m) {
  m.read();
}
