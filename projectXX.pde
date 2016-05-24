/*
This is the main code for the StoryTeller physics simulator.
Contains the setup() and draw() function.
*/

// Global variables
int WINDOW_HEIGHT = 500;
int WINDOW_WIDTH = 700;
int ROVER_SIZE = 150;

String[] environments = new String[9];
float[] gravityArray = new float[9];
PImage planet = null;
PImage stanford = null;
PImage walle = null;
float gravity = 9.81; // Default is set to Earth's gravity
float speed = 10.0;
float position_x = (WINDOW_WIDTH/2.0 - ROVER_SIZE/2.0);
float position_y = 0.0;
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
  stanford = loadImage("stanford.jpg");
  stanford.resize(WINDOW_WIDTH, WINDOW_HEIGHT);
  if(planet == null) {
    background(stanford);
  }
  
  // Initialize Wall-E!
  walle = loadImage("walle.png");
  walle.resize(ROVER_SIZE, ROVER_SIZE);
  
  // Initialize environment images
  environments[0] = "stanford.jpg";
  environments[1] = "mercury.jpg";
  environments[2] = "venus.jpg";
  environments[3] = "earth.png";
  environments[4] = "mars.jpg";
  environments[5] = "jupiter.png";
  environments[6] = "saturn.jpg";
  environments[7] = "uranus.png";
  environments[8] = "neptune.jpg";
  
  //Initialize gravity array
  gravityArray[0] = 9.81;
  gravityArray[1] = 3.7;
  gravityArray[2] = 8.87;
  gravityArray[3] = 9.81;
  gravityArray[4] = 3.71;
  gravityArray[5] = 24.79;
  gravityArray[6] = 10.44;
  gravityArray[7] = 8.69;
  gravityArray[8] = 11.15;
}

void draw() 
{  
  draw_TUIO();  

  // Check if Wall-E is done moving vertically
  float time = abs(second() - startTime);
  float acceleration = (.5*gravity*time*time);
  //println(time);
  if((position_y + acceleration) < (WINDOW_HEIGHT - ROVER_SIZE)) {
    position_y += acceleration;
  } else {
    bringToGround();
    if(position_x < WINDOW_WIDTH) { // Check if Wall-E is done moving horizontally
      position_x += speed;
      println(speed);
    } else {
      position_x = (WINDOW_WIDTH/2.0 - ROVER_SIZE/2.0);
      position_y = 0.0;
      startTime = second();
    }
  }  
}

void bringToGround()
{
  position_y = WINDOW_HEIGHT - ROVER_SIZE;
}
