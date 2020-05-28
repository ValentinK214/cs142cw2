//VARIABLES
ParticleSystem ps1, ps2;
Particle sus, inf, rem, smallRad, bigRad;

int sizeOfPS = 250;//250
float circleDia = 10;//10
float circleRad = circleDia/2;
float infectionRadiusBoxONE = circleRad*7;
float infectionRadiusBoxTWO = circleRad*3.5;

float sampleRad = 12;
float sampleInfRad = 20;

ArrayList<PVector> locationList;
ArrayList<PVector> accelerationList;

float boxOneX1 = 4;
float boxOneY1 = 80;
float boxOneWidth = 625;
float boxOneX2 = boxOneX1+boxOneWidth;
float boxOneY2 = 720-boxOneY1;

float boxTwoX1 = boxOneX2+6+6;
float boxTwoY1 = 80;
float boxTwoX2 = boxTwoX1+boxOneWidth;
float boxTwoY2 = 720-boxTwoY1;

void setup(){
  size(1270, 720);
  
  locationList = new ArrayList<PVector>();
  accelerationList = new ArrayList<PVector>();
  
  for (int i = 0; i < sizeOfPS; i++){
    locationList.add( new PVector(random(boxOneX1, boxOneX2), random(boxOneY1, boxOneY2)));
    accelerationList.add( new PVector(random(-4, 4), random(-4, 4)));
  }
  
  //"b1" or "b2" determines which location list the particle list gets its locations from
  ps1 = new ParticleSystem(sizeOfPS, "b1");
  ps2 = new ParticleSystem(sizeOfPS, "b2");
  
  sus = new Particle(new PVector(boxOneX1+sampleRad, boxOneY2+22), new PVector(0, 0), true, false, false);
  inf = new Particle(new PVector(boxOneX1+sampleRad, boxOneY2+22*2), new PVector(0, 0), false, true, false);
  rem = new Particle(new PVector(boxOneX1+sampleRad, boxOneY2+22*3), new PVector(0, 0), false, false, true);
  smallRad = new Particle(new PVector(boxTwoX2-sampleRad, boxOneY2+22*2), new PVector(0, 0), true, false, false);
  bigRad = new Particle(new PVector(boxTwoX1+sampleRad, boxOneY2+22*2), new PVector(0, 0), true, false, false);
}


void draw(){
  frameRate(20);
  background(255, 255, 255);
  textSize(32);
  fill(0);
  text("Lower transmission factor means slower virus spread (SIR model)", 120, 55); 
  fill(220, 220, 220);
  stroke(0);
  rect(boxOneX1, boxOneY1, boxOneWidth, (720-2*boxOneY1));
  rect(boxTwoX1, boxTwoY1, boxOneWidth, (720-2*boxOneY1));
  //noStroke();
  
  textSize(12);
  fill(0);
  text("Susceptible - healthy, gets infected if within infection radius", boxOneX1+sampleRad+20, boxOneY2+22+sampleRad/2);
  text("Infected - cannot get reinfected, gets removed after some time", boxOneX1+sampleRad+20, boxOneY2+22*2+sampleRad/2);
  text("Removed - out of the system, recovered or dead", boxOneX1+sampleRad+20, boxOneY2+22*3+sampleRad/2);
  text("Big infection radius (high transmission)", boxTwoX1+sampleInfRad*2+5, boxOneY2+22*2+sampleRad/2);
  text("Small infection radius (low transmission)", boxTwoX2-260, boxOneY2+22*2+sampleRad/2);
  
  
  sus.displayLegSus();
  inf.displayLegInf();
  rem.displayLegRem();
  smallRad.displayLegP0(sampleInfRad);
  bigRad.displayLegP0(sampleInfRad*3);
  
  ps1.run();
  ps1.patientZero(infectionRadiusBoxONE);
  ps1.virus(infectionRadiusBoxONE);
  
  ps2.run();
  ps2.patientZero(infectionRadiusBoxTWO);
  ps2.virus(infectionRadiusBoxTWO);
  
  
  
  
}
