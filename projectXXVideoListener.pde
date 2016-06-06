import processing.video.*;

/*
This is the main code for the project.
Contains the setup() and draw() function.
*/

// Global variables
int WINDOW_HEIGHT = 540;
int WINDOW_WIDTH = 950;

Movie farmerScene;
Movie timelineVid1;
Movie timelineVid2;
Movie timelineVid3;
Movie timelineVid4;
Movie timelineVid5;

String[] environments = new String[5];
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
}

void setupEnvironments()
{
  farmerScene = new Movie(this, "farmerScene.mp4");
  timelineVid1 = new Movie(this, "p1small.mov");
  timelineVid2 = new Movie(this, "p2small.mov");
  timelineVid3 = new Movie(this, "p3small.mov");
  timelineVid4 = new Movie(this, "p4small.mov");
  timelineVid5 = new Movie(this, "p5small.mov");
  background(0,0,0); // black
}

void draw() 
{  
  draw_TUIO();  

}

void movieEvent(Movie m) {
  m.read();
}
