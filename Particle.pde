class Particle {
  float posX = random(0, width);
  float posY = random(0, height);
  float maxSpeed = 2;
  float speed = maxSpeed;
  float angle = random(0, TWO_PI);

  void updatePosition() {
    posX += cos(angle) * speed;
    posY += sin(angle) * speed;
  }
  
  void display() {
    point(posX, posY);
  }
  
  void influence(float[][] wind) {
    int yIndex = floor(posY / (scale + 1));
    int xIndex = floor(posX / (scale + 1));
    float windAngle = wind[yIndex][xIndex];
    float x1 = cos(angle) * speed;
    float y1 = sin(angle) * speed;
    float x2 = x1 + (cos(windAngle) * influence);
    float y2 = y1 + (sin(windAngle) * influence);
    speed = dist(0, 0, x2, y2);
    if (speed > maxSpeed) {
      speed = maxSpeed; 
    }
    angle = atan2(y2, x2);
  }
  
  void teleport() {
    if (posX < 0) {
      posX = width;
    }
    if (posX > width) {
      posX = 0;
    }
    if (posY < 0) {
      posY = height;
    }
    if (posY > height) {
      posY = 0;
    }
  }
}
