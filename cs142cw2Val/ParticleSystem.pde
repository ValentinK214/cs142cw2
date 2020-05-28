import java.util.Iterator;

class ParticleSystem{
//VARIABLES
ArrayList<Particle> myParList;

ArrayList<PVector> psLocListShifted = new ArrayList<PVector>();
PVector b1PlusXLocation;

int numOfInf = 0;



//CONSTRUCTOR
//In case else statement is entered, ps ought to be displayed in box1
ParticleSystem(int inputSize, String b1OrB2){
  myParList = new ArrayList<Particle>();
  
  if (b1OrB2 == "b1") {
    for (int i = 0; i < inputSize; i++){
      myParList.add(new Particle( locationList.get(i), accelerationList.get(i), true, false, false ) );
    }
  } else if (b1OrB2 == "b2") {
    for (int i = 0; i < inputSize; i++){      
      psLocListShifted.add(b1PlusXLocation = PVector.add( locationList.get(i), new PVector(boxTwoX1-boxOneX1, 0) ));
      myParList.add(new Particle( psLocListShifted.get(i), accelerationList.get(i), true, false, false ));
    }
  } else {
    System.out.println("Particle System Constructor - Entered the ELSE statement");
    for (int i = 0; i < inputSize; i++){
      myParList.add(new Particle( locationList.get(i), accelerationList.get(i), true, false, false ) );
    }
  }
}//END OF CONSTRUCTOR

//I wanted to try out the java iterator 
void patientZero(float infectionRadius){
  Iterator<Particle> myPIterator = myParList.iterator();  
  Particle gotP = myPIterator.next();
  
  if (gotP.timeUntilDrawn > 0) {
    gotP.displayP0(infectionRadius);
  }
  
  if (gotP.timeUntilDrawn < 0 && gotP.timeUntilRem > 0) {
    myParList.get(0).setInfToTrue();
    myParList.get(0).setSusToFalse();
  }  
}//END OF PATIENT ZERO

//For each particle, check its location and apply the according checkEdges method
//Call the appropriate display method in accordance to the particle's boolean values
void run(){
  Iterator<Particle> myPIterator = myParList.iterator();
  
  while (myPIterator.hasNext() ) {
    Particle gotP = myPIterator.next();
    
    //CHECK EDGES AND DISPLAY INFECTED
    if (gotP.location.x < boxOneX2+6) {
      //System.out.println("gotP is in Box1");
      gotP.checkEdgesBoxOne();
      gotP.update();
      if (gotP.isSus == false && gotP.isInf == true && gotP.isRem == false){
        gotP.displayInf(infectionRadiusBoxONE);
      } else if (gotP.isSus == true && gotP.isInf == false && gotP.isRem == false) {
        gotP.displaySus();
      } else if (gotP.isSus == false && gotP.isInf == false && gotP.isRem == true) {
        gotP.displayRem();
      } else {
        System.out.println("ELSE in BoxONE");
        System.out.println("BoxONE: isSUS= "+gotP.isSus+" isINF= "+gotP.isInf+" isREM= "+gotP.isRem);
      }    
    } else  {
      //System.out.println("gotP is in Box2");
      gotP.checkEdgesBoxTwo();
      gotP.update();
      if (gotP.isSus == false && gotP.isInf == true && gotP.isRem == false){
        gotP.displayInf(infectionRadiusBoxTWO);
      } else if (gotP.isSus == true && gotP.isInf == false && gotP.isRem == false) {
        gotP.displaySus();
      } else if (gotP.isSus == false && gotP.isInf == false && gotP.isRem == true) {
        gotP.displayRem();
      } else {
        System.out.println("ELSE in BoxTWO");
      }
    }          
  }//END OF WHILE LOOP 
}//END OF RUN METHOD

//Input Patient infects all remaining particles in the system
void virusPatientINPUT(float inputRadius, int inputIndex){
  
  //Input Patient
   Iterator<Particle> myPIterator = myParList.iterator();
   Particle gotPinput = myParList.get(inputIndex);
   
   //Distances from input patient to EVERY other particle
   ArrayList<Float> distancesP0 = psListOfDistPINPUTtoALL(inputIndex);
   Iterator<Float> myDistIterator = distancesP0.iterator();
   
   //Checks if input patient is susceptible
   if (gotPinput.isSus == false && gotPinput.isInf == true && gotPinput.isRem == false) {  
     //System.out.println("P0 found");
     
     //Check if all other particles meet the 'get infected by input patient' conditions 
     while (myDistIterator.hasNext() ){
       float currentDist = myDistIterator.next();
       Particle currentP = myPIterator.next();
       
       //Attempt to include a 'probability of transmission'
       //if (currentDist < inputRadius && (currentP.pRandomINT == 1 || currentP.pRandomINT == 2 || currentP.pRandomINT == 3)) {
         
       //IMPORTANT!! 
       //current Particle cannot be input patient
       //timeUntilRem must be 40, i.e. the starting value, otherwise an already infected particle gets reinfected (timeUntilRem starts to decrease once it gets infected)
       if (currentDist < inputRadius && currentDist != 0  && currentP.timeUntilRem == 40 ) {  
         //System.out.println("current distance "+currentDist);
         currentP.setSusToFalse();
         currentP.setInfToTrue();
       } else {
         //Already infected OR removed
         //System.out.println("virusPatienInput ELSE, i.e does NOT meet the 'get infected' conditions");
         //System.out.println(currentDist);
         //System.out.println("virusPatientInput: isSUS= "+currentP.isSus+" isINF= "+currentP.isInf+" isREM= "+currentP.isRem); 
       }
     }//END OF WHILE LOOP
   }       
}//END OF virusPatientINPUT METHOD 

void virus(float inputRadius){
  for (int p = 0; p < myParList.size(); p++){
    virusPatientINPUT(inputRadius, p);
  }
}//END OF VIRUS METHOD

  

//ARRAY LIST OF DISTANCES FROM INPUT INDEX TO ALL OTHER PARTICLES
ArrayList<Float> psListOfDistPINPUTtoALL(int inputIndex){
  ArrayList<Float> distancesPINPUTtoAll = new ArrayList<Float>();
  for (int i = 0; i < myParList.size(); i++) {
    distancesPINPUTtoAll.add(myParList.get(inputIndex).calcDistToInputP(myParList.get(i)));
  }
  return distancesPINPUTtoAll;
}// END OF psListOfDistPINPUTtoALL

}//END OF PS CLASS
