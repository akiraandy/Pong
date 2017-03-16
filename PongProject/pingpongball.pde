class Ball {
  float x, y; // Declare ball's X and Y position 
  float w, h; // Declare ball's width and height
  float xSpeed, ySpeed; // Declare ball's speed
  boolean hitDetected;
  boolean roundOver;

  Ball (float _w, float _h) {
    x = (width-w)/2;
    y = (height-h)/2;
    w = _w;
    h = _h;
    xSpeed = ySpeed = ballSpeed;
    roundOver = false;
  }

  void display() {
    noStroke();
    fill(255);
    rectMode(CORNER);
    rect(x, y, w, h);
  }

  void move() {
    x += xSpeed;
    y += ySpeed;
    if ((x+w >= width) || (x <= 0) || x >= xOffsetPlayer1 || x <= xOffsetPlayer2) { // if the ball reaches either the far left or right of the window, run score()
      score();
    }
    if (y+h >= height) { // bounce off top and bottom of window
      ySpeed = ySpeed * -1;
      y = y - h;
    }
    if (y <= 0) {
      ySpeed = ySpeed * -1;
      y = 0;
    }
  }


  void score() {
    // if the ball goes off the right side of the screen player1 gets a point
    if (x+w >= width || x+w >= xOffsetPlayer1) {
      player1Score++; // increment player1's score
      roundDone(); // call roundDone()
    }
    // if the ball goes off the left side of the screen player2 gets a point
    if (x <= 0 || x <= xOffsetPlayer2) {
      player2Score++; // increment player2's score
      roundDone(); // call roundDone()
    }
  }
  
  // called once a point is scored by either player
  void roundDone() {
    roundOver = true;
    timer.start(); // start a timer until the next round starts
    // reset the puck's position to the center and set the speed to 0
    x = (width-w)/2;
    y = (height-h)/2;
    xSpeed = 0;
    ySpeed = 0;
  }

  // called on every draw()
  void updateBall() {
    move();
    collision(player1);
    collision(player2);
    if (roundOver) { // if round is over
      if (timer.isFinished()) { // and the timer is finished
        if (player1Score > player2Score) { // if player1's score is higher, give the ball to player1
          xSpeed = ySpeed = ballSpeed;
        } else { // else give the ball to player2
          xSpeed = ySpeed = -ballSpeed;
        }
        roundOver = false; // set roundOver to false
      }
    }
  }

  // ball collision detection
  void collision(Paddle paddle) {
    if ((x >= paddle.x && paddle.player == 1) 
      && (x <= paddle.x + paddle.w)) {
      if ((y >= paddle.y) && (y <= paddle.y + paddle.h))
      {
        xSpeed *=  -1;
      }
    }
    if ((x + w >= paddle.x && paddle.player == 0) 
      && (x <= paddle.x + paddle.w)) {
      if ((y >= paddle.y) && (y <= paddle.y + paddle.h))
      {
        xSpeed *=  -1;
      }
    }
  }
}