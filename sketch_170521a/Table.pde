import java.util.ArrayList; 

class Table{
  int x,y;
  color shade;
  int numSeats;
  boolean empty, served;
  Food dish;
  
  Table(int seats, int xcor, int ycor){
    float r = random(256);
    float g = random(256);
    float b = random(256);
    shade = color(r,g,b);
    x =xcor;
    y= ycor;
    numSeats = seats;
    empty = true;
    served = false;
    dish = null;
  }
  
  //place a dish on table
  void setDish(Food f){
    f.x = x;
    f.y = y;
    dish = f;
    
  }
  
  void display(){
    rect(x - 22, y - 22, 55, 55, 7);
    fill(shade);
    if (dish != null){
      if(dish.description.equals("sausage")){
        shade = color(125, 10, 10);
     }
     else if(dish.description.equals("ham")){
        shade = color(200, 0, 100); 
     }
     else{
        shade = color(0, 200, 0); 
     }
      PShape overall, plate, entree;
     overall = createShape(GROUP);
     
     plate = createShape(ELLIPSE, x, y, 40, 40);
     plate.setFill(color(120, 120, 120));

     entree = createShape(ELLIPSE, x, y, 30, 30);
     entree.setFill(shade);
     
     overall.addChild(plate);
     overall.addChild(entree);
     
     shape(overall);}
}
}