class Paddle {
  float x, y; // Declare Paddle's X and Y position
  float w, h; // Declare Paddle's width and height
  float ySpeed; // Declare Paddle's ySpeed
  int player; // Declare player number

  Paddle(float _x, float _y, float _w, float _h, int _player) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    ySpeed = 0;
    player = _player;
  }

  void display() {
    fill(255);
    noStroke();
    rectMode(CORNER);
    rect(x, y, w, h);
  }
  // increments ySpeed by _m
  void addSpeed(float _m) {
    ySpeed += _m;
  }
  
  // increments y by ySpeed
  void update() {
    y += ySpeed;
    // ySpeed is constrained to never go past 10
    ySpeed = constrain(ySpeed, -10, 10);
    // if the Paddle touches the bottom of the window, y is set to the height and ySpeed is set to 0
    // if the Paddle touches the top of the window, y is set to zero and ySpeed is set to 0
    if (y + h >= height) {
      y = height - h;
      ySpeed = 0;
    }
    if (y <= 0) {
      y = 0;
      ySpeed = 0;
    }
  }
}