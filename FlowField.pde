int cols;
int rows;
float zoff = 0;
float[][] wind;
ArrayList<Particle> particles = new ArrayList<Particle>();
int numberOfParticles = 5000;

// how many square pixels one wind unit covers
int scale = 40;
// how fast the wind changes
float time = 0.001;
// amount of difference a wind unit may have from it's neighbours
float inc = 0.07;
// range within which wind can change
float windAngleRange = TWO_PI * 2;
// amount of influence wind has on particle
float influence = 0.05;

boolean drawWind = false;


void setup() {
  fullScreen();
  noCursor();
  setGrid();
  setParticles(numberOfParticles);
  strokeWeight(1);
  background(0);
  noFill();
}

void draw() {
  updateWind();
  if (drawWind) {
    drawWind();
  }
  updateParticles();
}

void updateWind() {
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      float angle = noise(xoff, yoff, zoff) * windAngleRange; 
      wind[y][x] = angle;
      xoff += inc;
    }
    yoff += inc;
  }
  zoff += time;
}

void drawWind() {
  background(0);
  for (int y = 0; y < wind.length; y++) {
    for (int x = 0; x < wind[y].length; x++) {
      stroke(255);
      push();
      float angle = wind[y][x];
      float lineX = cos(angle) * scale;
      float lineY = sin(angle) * scale;
      translate(x * scale, y * scale);
      line(0, 0, lineX, lineY);
      pop();
    }
  }
}

void updateParticles() {
  stroke(255, 255, 255, 20);
  for (Particle particle : particles) {
    particle.influence(wind);
    particle.updatePosition();
    particle.teleport();
    particle.display();
  }
}

void setGrid() {
  cols = floor(width / scale);
  rows = floor(height / scale);
  wind = new float[rows][cols];
}

void setParticles(int amount) {
  for (int i = 0; i < amount; i++) {
    particles.add(new Particle());
  }
}

void keyPressed() {
  if (key == 'd') {
    background(0);
    drawWind = !drawWind;
  }
}
