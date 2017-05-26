import java.util.List;
class Customer{
  List<Food> menu;
  int x,y;
  String description; //such as businessman, food critic, mother
  int id; //to keep track of customer
  int partyOf; //how many people in one party
  int timerSec; //how long each customer is willing to wait for service
  color shade;
  boolean sitting;
  Table sittingAt;
  
  Customer(String desc, int ID, int num, int sec, int xcor, int ycor){
    description = desc;
    id = ID; 
    partyOf = num;
    timerSec = sec;
    shade = color(170, 220, 60);
    x = xcor;
    y = ycor;
    sitting = false;
  }
  
  void display(){
    PShape customer, c1, c2, c3, c4;
    
    //waiter shape group
    customer = createShape(GROUP);
    
    //making all the appendages
    c1 = createShape(TRIANGLE, x-50, y+25, x, y+25, x-25,y-15);
    c1.setFill(color(shade));
    c2 = createShape(TRIANGLE, x, y+25, x+50, y+25, x+25, y-20);
    c2.setFill(color(shade));
    c3 = createShape(TRIANGLE, x-50, y-25, x, y-25, x-25, y-65);
    c3.setFill(color(shade));
    c4 = createShape(TRIANGLE, x, y-25, x+50, y-25, x+25, y-65);
    c4.setFill(color(shade));
    
    //put it all together
    customer.addChild(c1);
    customer.addChild(c2);
    customer.addChild(c3);
    customer.addChild(c4);
    
    shape(customer);
  }
  
  void sit(Table t){
    if (dist(x,y,t.x,t.y) < 10){
      
      sittingAt = t;}
  }
  
  void askToOrder(){
    //make an exclamation point appear above table
    PShape exclamation, top, bottom;
    
    exclamation = createShape(GROUP);
    
    top = createShape(ELLIPSE, sittingAt.x, sittingAt.y, 3, 7);
    top.setFill(color(255, 204, 0));
    bottom = createShape(ELLIPSE, sittingAt.x, sittingAt.y - 5, 3,3);
    bottom.setFill(color(255, 204, 0));
    
    exclamation.addChild(top);
    exclamation.addChild(bottom);
    
    shape(exclamation);
  }
  
  /*Food order(){
    return menu.get(random(menu.size());
  }*/
  
  void askToPay(){
    //make an exclamation point appear above table
    PShape exclamation, top, bottom;
    
    exclamation = createShape(GROUP);
    
    top = createShape(ELLIPSE, sittingAt.x, sittingAt.y, 3, 7);
    top.setFill(color(255, 204, 0));
    bottom = createShape(ELLIPSE, sittingAt.x, sittingAt.y - 5, 3,3);
    bottom.setFill(color(255, 204, 0));
    
    exclamation.addChild(top);
    exclamation.addChild(bottom);
    
    shape(exclamation);
  }
  

  //walk towards exit and disappears
  void leave(){
  }
}
