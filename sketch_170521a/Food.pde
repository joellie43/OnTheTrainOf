class Food{
  String description;
  int cost;
  int secondsToMake;
  int position;
  int x, y;
  color shade;
  int foodTimer = 0;
  Customer recipient;
  String label = "";
  
  Food(String fDesc, int fCost, int fSec, int pos){
     description = fDesc;
     cost = fCost;
     secondsToMake = fSec;
     position = pos;
     x = 300;
     y = 40;
     if(description.equals("sausage")){
        shade = color(125, 10, 10);
     }
     else if(description.equals("ham")){
        shade = color(200, 0, 100); 
     }
     else{
        shade = color(0, 200, 0); 
     }
     recipient = null;
  }
  
  void display(){
      
     PShape overall, plate, entree;
     overall = createShape(GROUP);
     
     plate = createShape(ELLIPSE, x + position*50, y, 40, 40);
     plate.setFill(color(120, 120, 120));

     entree = createShape(ELLIPSE, x + position*50, y, 30, 30);
     entree.setFill(shade);
     
     overall.addChild(plate);
     overall.addChild(entree);
     
     shape(overall);
     
     /*textSize(12);
     fill(0);
     int z = 45 + position*50;
     System.out.println(z);
     text(label, x + 45, y + 5);*/
  }
  
  void move(Table t){
         //fill(200, 100, 0);
         x = t.x;
         y = t.y;
  }
  
}