import java.util.List;
class Customer{
  Food[] menu = new Food[3];
  
  int x,y;
  String description; //such as businessman, food critic, mother
  int id; //to keep track of customer
  int partyOf; //how many people in one party
  int timerSec; //how long each customer is willing to wait for service
  int timeOrdered; //mark the time at which customer ordered
  color shade;
  Table sittingAt;
  int sittingTime;//time at which customer started sitting
  Food foodOrdered;
  boolean askingForService;
  boolean ordered;
  boolean served;
  boolean leaving;
  int genPos;
  int blueShift; //b compnent of customer's rgb for personality
  int greenShift; //g component of customer's rgb for personaliy
  //no redShift red is designated for angry customers only
  
  Customer(String desc, int ID, int num, int sec, int newGenPos, int xcor, int ycor){
    menu[0] = new Food("sausage",10,5000,0);
    menu[1] = new Food("ham",10,5000,1);
    menu[2] = new Food("lettuce",3,3000,2);
    description = desc;
    id = ID; 
    partyOf = num;
    timerSec = sec;
    blueShift = (int)(Math.random()*256);
    greenShift = (int)(Math.random()*256);
    shade = color(0, greenShift, blueShift);
    x = xcor;
    y = ycor;
    genPos = newGenPos;
    sittingAt = null;
    sittingTime = -1;
    leaving = false;
    foodOrdered = menu[(int)random(3)];
  }
  
  void display(){
    PShape customer, c1, c2, c3, c4;
    
    if(sittingAt != null){
      int timeDif = millis() - sittingTime;
      if(timeDif > 10000){
        shade = color(255,0,0);
        leave();
      } 
      else{
        shade = color(255 * timeDif/10000,
                      greenShift - greenShift * timeDif/10000,
                      blueShift - blueShift *timeDif/10000);
      }
    }
    else if(leaving){
      shade = color(255,0,0);
    }
    else {
      shade = color(0,greenShift,blueShift);
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
      t.empty = false;
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
    foodOrdered = menu[(int)random(menu.length)];
    sittingTime = millis();
    return foodOrdered;
  }


  //walk towards exit and disappears
  //precondition: sittingAt isnt null
  void leave(){
    if(sittingAt != null){
      sittingAt.empty = true;
    }
    leaving = true;
    sittingAt = null;
  }
}
