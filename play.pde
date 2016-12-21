class Ball {

  //global variables
  float x = 0;
  float y = 0;
  float speedX = 2;
  float speedY = 0.5;
  //obstructor
  Ball(float _x, float _y) {

    x = _x;
    y =_y;
  }
  //functions
  void run() {
    display();

    move();

    bounce();

    gravity();
  }




  void gravity() {



    speedY += 0.2;
  }
  void move() {

    x += speedX;
    y += speedY;
  }


  void bounce() {
    if (x > width-10) {
      speedX = speedX *-1;
    }
    if (x < 0) {
      speedX = speedX *-1;
    }

    if (y < 0) {
      speedX = speedX *-1;
    }
    if (y > height-10) {
      speedY = speedY *-1;
    }
  }

  void display() {
    noStroke();
    
    fill(map(x, 0, width, 0, 255), map(y, 0, height, 0, 255), map(y, 0, height, 0, 255));
    ellipse(x, y, 20, 20);
    ellipse(x, y, 20, 20);
   
  }
}