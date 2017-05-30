import java.util.List;
class Customer{
  Food[] menu = new Food[3];
  
  int x,y;
  String description; //such as businessman, food critic, mother
  int id; //to keep track of customer
  int partyOf; //how many people in one party
  int timerSec; //how long each customer is willing to wait for service
  color shade;
  Table sittingAt;
  int sittingTime;//time at which customer started sitting
  boolean ordered;
  boolean leaving;
  Check myCheck;
  
  Customer(String desc, int ID, int num, int sec, int xcor, int ycor){
    menu[0] = new Food("sausage",10,5000,0);
    menu[1] = new Food("ham",10,5000,1);
    menu[2] = new Food("lettuce",3,3000,2);
    description = desc;
    id = ID; 
    partyOf = num;
    timerSec = sec;
    shade = color(0, 255, 0);
    x = xcor;
    y = ycor;
    sittingAt = null;
    sittingTime = -1;
    leaving = false;
    myCheck = new Check();
  }
  
  void display(){
    PShape customer, c1, c2, c3, c4;
    
    if(sittingTime != -1){
      int timeDif = millis() - sittingTime;
      if(timeDif > 10000){
        shade = color(255,0,0);
        leave();
      } 
      else{
        shade = color(255 * timeDif/10000,255 - 255 * timeDif/10000,0);
      }
    }
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
  
  //sets customers table and time they started sitting
  void sit(Table t){
      sittingAt = t;
      sittingTime = millis();
  }
  
  //Precondition: sit(Table t) has been called, so sittingAt is != null
  void askForService(){
    
    //make an exclamation point appear above table
    PShape exclamation, top, bottom;
    exclamation = createShape(GROUP);
    
    bottom = createShape(ELLIPSE, sittingAt.x, sittingAt.y+37, 20,20);
    bottom.setFill(color(256, 0, 0));
    top = createShape(ELLIPSE, sittingAt.x, sittingAt.y, 20, 55);
    top.setFill(color(256, 0, 0));
    
    
    exclamation.addChild(top);
    exclamation.addChild(bottom);
    
    shape(exclamation);
    
  }
  
  Food order(){
    ordered = true;
    //add food to check
    myCheck.addFood(menu[(int)random(menu.length)]);
    return myCheck.getFood(0);

  }


  //walk towards exit and disappears
  void leave(){
    leaving = true;
  }
}
