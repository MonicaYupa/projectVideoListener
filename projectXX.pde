/*
This is the main code for the project.
Contains the setup() and draw() function.
*/

// Global variables
int WINDOW_HEIGHT = 500;
int WINDOW_WIDTH = 700;

String[] environments = new String[5];
PImage bg = null;
PImage welcome = null;
float startTime = second();

void setup()
{
  // GUI setup; this sets the relevant parameters for the size of the screen, and framerate.
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  frameRate(15);
  
  setupEnvironments();
  setup_TUIO();
}

void setupEnvironments()
{
  welcome = loadImage("welcome.png");
  welcome.resize(WINDOW_WIDTH, WINDOW_HEIGHT);
  if(bg == null) {
    background(welcome);
  }
  
  // Initialize environment images
  environments[0] = "start.png"; // Start screen
  environments[1] = "node1.png";
  environments[2] = "node2.png";
  environments[3] = "node3.png";
  environments[4] = "hulling.png";
}

void draw() 
{  
  draw_TUIO();  

  //float time = abs(second() - startTime);
  //println(time);
}
