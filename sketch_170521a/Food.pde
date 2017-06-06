class Food{
  String description;
  int cost;
  int position;
  int x, y;
  color shade;
  boolean finished;
  Customer recipient;
  
  Food(String fDesc, int fCost){
     description = fDesc;
     cost = fCost;
     x = 300;
     y = 40;
     if(description.equals("ice cream")){
        shade = color(255, 255, 255);
     }
     else if(description.equals("pasta")){
        shade = color(200, 0, 100); 
     }
     else if(description.equals("salad")){
        shade = color(0, 200, 0); 
     }
     else if(description.equals("burger")){
       shade = color(80,50,10);
     }
     else if(description.equals("taco")){
       shade = color(255, 204, 0);
     }
     else if(description.equals("soup")){
       shade = color(256,128,0);
     }
     recipient = null;
     finished = false;
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
  }
}
