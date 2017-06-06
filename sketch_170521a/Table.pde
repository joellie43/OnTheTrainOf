import java.util.ArrayList; 

class Table{
  int x,y;
  color shade;
  color dishShade;
  boolean empty;
  Food dish;
  
  Table(int xcor, int ycor){
    float r = random(256);
    float g = random(256);
    float b = random(256);
    shade = color(r,g,b);
    x =xcor;
    y= ycor;
    empty = true;
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
      if(dish.description.equals("ice cream")){
        dishShade = color(255, 255, 255);
     }
     else if(dish.description.equals("pasta")){
        dishShade = color(200, 0, 100); 
     }
     else if(dish.description.equals("salad")){
        dishShade = color(0, 200, 0); 
     }
     else if(dish.description.equals("burger")){
       dishShade = color(80,50,10);
     }
     else if(dish.description.equals("taco")){
       dishShade = color(255, 204, 0);
     }
     else if(dish.description.equals("soup")){
       dishShade = color(256,128,0);
     }
     
      PShape overall, plate, entree;
     overall = createShape(GROUP);
     
     plate = createShape(ELLIPSE, x, y, 40, 40);
     plate.setFill(color(120, 120, 120));

     entree = createShape(ELLIPSE, x, y, 30, 30);
     entree.setFill(dishShade);
     
     overall.addChild(plate);
     overall.addChild(entree);
     
     shape(overall);}
  }
}