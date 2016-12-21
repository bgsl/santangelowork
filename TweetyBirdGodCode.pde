import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
import gohai.glvideo.*;
import guru.ttslib.*;




GLCapture video;
int x, y;
int shapeSize = 10;
int value = 0;
Twitter twitter;

TTS tts;

//#nts = note to self in gnatas google drive

// #schedule = schedules meetings  in gnatas google calander

//#ball = draws ball to screen

//#bounce = makes ball bounce


String input = "";
Ball myBall;

Ball[] myBalls = new Ball[100];

PImage webImg;
void setup()
{
  fullScreen(P2D);
  //size (800,600,P2D);
  tts = new TTS();
  //String url = "https://unsplash.it/200/300/?random";
  //// Load image from a web server
  //webImg = loadImage(url, "png");

  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("Aap5pGLUkV1DvC8MpjWzXFQOB");
  cb.setOAuthConsumerSecret("eNchIk5rsE8bVQzBn1DWGoNur5vi2odO7AlLI1dub99n6Pzorb");
  cb.setOAuthAccessToken("4143863663-n68HvoTd4nP02eNGNU7OcwfqG9B6Drwlf4xfqxY");
  cb.setOAuthAccessTokenSecret("QBRRe5xKjFP9tnWBwFlSk8Iu8Eu0qjf7ilF4qAMLQKyp9");

  TwitterFactory tf = new TwitterFactory(cb.build());

  twitter = tf.getInstance();

  for (int i = 0; i < myBalls.length; i++) {
  }

  myBall = new Ball( mouseX, mouseY);




  String[] devices = GLCapture.list();
  println("Devices:");
  printArray(devices);
  if (0 < devices.length) {
    String[] configs = GLCapture.configs(devices[0]);
    println("Configs:");
    printArray(configs);
  }

  // this will use the first recognized camera by default
  video = new GLCapture(this);

  // you could be more specific also, e.g.
  //video = new GLCapture(this, devices[0]);
  //video = new GLCapture(this, devices[0], 640, 480, 25);
  //video = new GLCapture(this, devices[0], configs[0]);

  video.play();
}

void draw()
{

  background(255);
  fill(0);
  PFont font;
  font = loadFont ("NeueHaasUnicaW1G-Black-50.vlw");

  textFont(font);
  textAlign(CENTER);
  text(input, 15, 20, width, 450);

  if (input.equals("#ball")) {

    myBall.run();
  }
  if (input.equals("#mouse")) {
    fill(30, 0, mouseX);
    noStroke();
    ellipse(mouseX, mouseY, 30, 30);
  }




//image randomizier

  if (input.equals("#random")) {
    String url = "https://unsplash.it/200/300/?random";
    // Load image from a web server
    webImg = loadImage(url, "png");
    image(webImg, random(0, width)-150, height/2);
  }
  
  //camera / mirror
  

  if (input.equals("#mirror")) {
    if (video.available()) {
      video.read();
    }
    image(video, 0, 0, width, height);
  }
}


void keyPressed() {
  if (key == BACKSPACE) {
    if (input.length()>0) {
      input = input.substring(0, input.length()-1);
    }
  } else if (key == CODED) {
    if (keyCode == SHIFT) {
    }
  } else {
    input+= key;
    //println( input );

    //str = str.substring(0,str.length()-1)
  }
}
void tweet()
{
  try
  {
    Status status = twitter.updateStatus(input);
    System.out.println("Status updated to [" + status.getText() + "].");
  }
  catch (TwitterException te)
  {
    System.out.println("Error: "+ te.getMessage());
  }
}



void mousePressed()
{
  tweet();
  tts.speak(input);
}