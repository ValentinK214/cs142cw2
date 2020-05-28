class Particle{
//Variables
PVector location;
PVector velocity;
PVector acceleration;

boolean isSus;
boolean isInf;
boolean isRem;

float timeUntilRem;
float timeUntilDrawn;

float maxProb = 10;
float pRandom;
int pRandomINT;

//CONSTRUCTOR
Particle(PVector inputLocation, PVector inputAcceleration, boolean inputSus, boolean inputInf, boolean inputRem){
location = inputLocation.get();
velocity = new PVector(0, 0);
acceleration = inputAcceleration.get();

isSus = inputSus;
isInf = inputInf;
isRem = inputRem;

timeUntilRem = 40;
timeUntilDrawn = 40;

//pRandom = random(maxProb);
//pRandomINT = ceil(pRandom);

}//END CONSTRUCTOR

void update(){
  //acceleration = new PVector(random(-1, 1), random(-1, 1) );
  velocity.limit(5);
  velocity.add(acceleration);  
  location.add(velocity);
  acceleration.mult(0);
  timeUntilDrawn = timeUntilDrawn -1;
}//END update

//BOOLEAN METHODS FOR SUS, INF, REM
void setSusToFalse(){
  isSus = false;
}

void setInfToFalse(){
  isInf = false;
}

void setInfToTrue(){
  isInf = true;
}

void setRemToTrue(){
  isRem = true;
}

//DISPLAY METHODS
void displaySus(){
  fill(255);
  circle(location.x, location.y, circleDia);
  
  //fill(0);
  //textSize(30);
  //text(pRandomINT, location.x, location.y);
}

void displayInf(float infectionRadius){
  fill(255, 0, 0);
  circle(location.x, location.y, circleDia);
  fill(255, 0, 0, 40);
  
  circle(location.x, location.y, infectionRadius);
  
  timeUntilRem = timeUntilRem - 1;
  
  if (timeUntilRem < 0) {
    setInfToFalse();
    setRemToTrue();
    setSusToFalse();
  } 
    //else if (timeUntilRem > 0){
    //System.out.println("display infected ELSE");
    //System.out.println(isSus+"; "+isInf+"; "+isRem);
    //System.out.println(timeUntilRem+"\n");
    //}

}//END displayInf

void displayP0(float infectionRadius){  
  fill(255, 255, 0, 140);
  //fill(0, 255, 0, 40);
  circle(location.x, location.y, infectionRadius);
  
}

void displayInfBOX2(){
  fill(255, 0, 0);
  circle(location.x, location.y, circleDia);
  fill(255, 0, 0, 40);
  circle(location.x, location.y, infectionRadiusBoxTWO);
  
  timeUntilRem = timeUntilRem - 1;
  
  if (timeUntilRem < 0) {
    //System.out.println("Enterder IF statement displayINFECTEDinBOX2"+timeUntilRem);
    setInfToFalse();
    setRemToTrue();
    setSusToFalse();
  }
}

void displayRem(){  
  if (timeUntilRem < 0) {
    fill(0);
    circle(location.x, location.y, circleDia);
  } else {
    System.out.println("displayRem entered ELSE statement");
  }   
}

//LEGEND DISPLAY Methods
void displayLegSus(){
    fill(255);
    circle(location.x, location.y, sampleRad);
}

void displayLegInf(){
  fill(255, 0, 0);
  circle(location.x, location.y, sampleRad);
  fill(255, 0, 0, 40);
  circle(location.x, location.y, sampleInfRad);
}

void displayLegRem(){
    fill(0);
    circle(location.x, location.y, sampleRad);
}

void displayLegP0(float infectionRadius){
  fill(255);
  circle(location.x, location.y, sampleRad);
  fill(255, 255, 0, 140);
  //fill(0, 255, 0, 40);
  circle(location.x, location.y, infectionRadius);
  
}

//CALCULATE DISTANCE
float calcDistToInputP(Particle inputP){
  PVector currentLoc = location.get();
  PVector distanceV = PVector.sub(currentLoc, inputP.location);
  float distance = distanceV.mag();
  return distance;
}

//CHECK EDGES METHODS
void checkEdgesBoxOne(){
  if (location.x < (boxOneX1 + circleDia/2) ) {
    location.x = boxOneX1 + circleDia/2;
    velocity.x = velocity.x * -1;
  } else if (location.x > (boxOneX2 - circleDia/2)) {
    location.x = boxOneX2 - circleDia/2;
    velocity.x = velocity.x * -1;
  } else {
    velocity.x = velocity.x * 1;
  }
  
  if (location.y < (boxOneY1 + circleDia/2) ) {
    location.y = boxOneY1 + circleDia/2;
    velocity.y = velocity.y * -1;
  } else if ( location.y > (height - boxOneY1 - circleDia/2) ) {
    location.y = height - boxOneY1 - circleDia/2;
    velocity.y = velocity.y * -1;
  } else {
    velocity.y = velocity.y * 1;
  }
}//END checkEdgesBoxOne

void checkEdgesBoxTwo(){
  if (location.x < (boxTwoX1 + circleDia/2) ) {
    location.x = boxTwoX1 + circleDia/2;
    velocity.x = velocity.x * -1;
  } else if (location.x > (boxTwoX2 - circleDia/2)) {
    location.x = boxTwoX2 - circleDia/2;
    velocity.x = velocity.x * -1;
  } else {
    velocity.x = velocity.x * 1;
  }
  
  if (location.y < (boxTwoY1 + circleDia/2) ) {
    location.y = boxTwoY1 + circleDia/2;
    velocity.y = velocity.y * -1;
  } else if ( location.y > (height - boxTwoY1 - circleDia/2) ) {
    location.y = height - boxTwoY1 - circleDia/2;
    velocity.y = velocity.y * -1;
  } else {
    velocity.y = velocity.y * 1;
  }
}//END checkEdgesBoxTwo
  
  
}//END Particle Class
