import java.util.List;
class Customer{
  Food[] menu = new Food[3];
  
  int x,y; //coordinates 
  String description; //such as businessman, food critic, mother
  int id; //to keep track of customer
  int partyOf; //how many people in one party
  int timerSec; //how long each customer is willing to wait for service
  int timeOrdered; //mark the time at which customer ordered
  color shade;
  Table sittingAt;
  int sittingTime; //time at which customer started sitting
  boolean ordered;
  boolean served;
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
    //if customer is sitting at a table,
    if(sittingTime != -1){
      //keep track of how long customer is sitting
      int timeDif = millis() - sittingTime;
      //if customer sat for more than 10 seconds, turn red and leave
      if(timeDif > 15000){
        shade = color(255,0,0);
        leave();
      } 
      //if customer sat for less than 15 seconds, gradually change from green to red
      else{
        shade = color(255 * timeDif/15000,255 - 255 * timeDif/15000,0);
      }
    }
    //if customer is not sitting
    else {
      shade = color(0,255,0);}
      
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
  
  //sets customer's table and time they started sitting
  void sit(Table t){
      sittingAt = t;
      sittingTime = millis();
  }
  
  //Precondition: sit(Table t) has been called, so sittingAt is != null
  //make an exclamation point appear above table
  void askForService(){
   
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

  //customer chooses a food randomly from the menu
  //ordered is set to true to allow for further interactions
  Food order(){
    ordered = true;
    //add food to check
    myCheck.addFood(menu[(int)random(menu.length)]);
    sittingTime = millis();
    return myCheck.getFood(0);
  }


  //sets leaving to true,
  //through sketch, customer walks towards exit and disappears
  void leave(){
    leaving = true;
  }
}