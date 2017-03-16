Ball ball; //<>//
Paddle player1;
Paddle player2;
Timer timer;
float xOffsetPlayer1;
float xOffsetPlayer2;
float ballSpeed = 5;
float paddleSpeed = 10;
int player1Score;
int player2Score;
color scoreColor;
color defaultColor;
boolean gameOver;
PFont f;

void setup() {
  size(600, 400);
  smooth();
  xOffsetPlayer1 = width - 30;
  xOffsetPlayer2 = 15;
  f = createFont("Georgia", 32, true);
  textSize(32);
  timer = new Timer (2000);
  gameOver = false;
  player1Score = 4;
  player2Score = 0;
  ball = new Ball(15, 15);
  player1 = new Paddle(xOffsetPlayer1, (height-75)/2, 15, 75, 0);
  player2 = new Paddle(xOffsetPlayer2, (height-75)/2, 15, 75, 1);
}

void draw() {
  background(0);
  textAlign(LEFT);
  text(player1Score, (width-150)/2, 50);
  text(player2Score, (width+100)/2, 50);
  // Draw middle line and circle
  stroke(255);
  noFill();
  line(width/2, 0, width/2, height);
  ellipse(width/2, height/2, 125, 125);
  // Draw and move ball

  // Draw and move Paddle
  player1.display();
  player2.display();
  if (!gameOver) {
    ball.display();
    player1.update();
    player2.update();
    ball.updateBall();
  }
  gameOver();
}

// User input to move Paddle
void keyPressed() {
  if (keyCode == DOWN) { // Down arrow increments ySpeed positively
    player1.addSpeed(paddleSpeed);
  }
  if (keyCode == UP) { // Up arrow increments ySpeed positively
    player1.addSpeed(-paddleSpeed);
  }
  // Repeat for player2
  if (keyCode == 'S') {
    player2.addSpeed(paddleSpeed);
  }
  if (keyCode == 'W') {
    player2.addSpeed(-paddleSpeed);
  }
  if (key == ' ') {
    resetGame();
  }
}

void keyReleased() {
  if (keyCode == DOWN || keyCode == UP) {
    player1.ySpeed = 0;
  }
  if (keyCode == 'S' || keyCode == 'W') {
    player2.ySpeed = 0;
  }
}

color colorLerp() {
  scoreColor = lerpColor(scoreColor, defaultColor, .2);
  return scoreColor;
}

void gameOver() {
  if (player1Score >= 5 || player2Score >= 5) {
    gameOver = true;
    textAlign(CENTER);
    text("Game over! \n Press Spacebar to reset the game", width/2, height/2);
  }
}

void resetGame() {
  if (gameOver) {
    gameOver = false;
    player1Score = 0;
    player2Score = 0;
  }
}