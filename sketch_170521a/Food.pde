class Food{
  String description;
  int cost;
  int secondsToMake;
  int position;
  int x, y;
  
  Food(String fDesc, int fCost, int fSec, int pos){
     description = fDesc;
     cost = fCost;
     secondsToMake = fSec;
     position = pos;
     x = 300;
     y = 40;
  }
  
  void display(){
     PShape overall, plate, entree;
     overall = createShape(GROUP);
     
     plate = createShape(ELLIPSE, x + position*50, y, 40, 40);
     plate.setFill(color(120, 120, 120));

     entree = createShape(ELLIPSE, x + position*50, y, 30, 30);
     entree.setFill(color(170, 170, 170));
     
     overall.addChild(plate);
     overall.addChild(entree);
     
     shape(overall);
  }
  
  void move(Table t){
         //fill(200, 100, 0);
         x = t.x;
         y = t.y;
  }
  
}