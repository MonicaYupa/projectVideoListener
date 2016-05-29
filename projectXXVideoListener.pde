import processing.video.*;

/*
This is the main code for the project.
Contains the setup() and draw() function.
*/

// Global variables
int WINDOW_HEIGHT = 540;
int WINDOW_WIDTH = 950;

Movie farmerScene;
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
  background(0,0,0); // black
}

void draw() 
{  
  draw_TUIO();  

}

void movieEvent(Movie m) {
  m.read();
}
