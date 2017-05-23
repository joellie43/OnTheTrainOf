class Food{
  String description;
  int cost;
  int secondsToMake;
  
  Food(String fDesc, int fCost, int fSec){
     description = fDesc;
     cost = fCost;
     secondsToMake = fSec;
  }
  
  void display(){
     PShape overall, plate, entree;
     overall = createShape(GROUP);
     
     plate = createShape(ELLIPSE, 70, 40, 20, 20);
     plate.setFill(color(120, 120, 120));
     
     entree = createShape(ELLIPSE, 70, 40, 15, 15);
     entree.setFill(color(170, 170, 170));
     
     overall.addChild(plate);
     overall.addChild(entree);
     
     shape(overall);
  }
}