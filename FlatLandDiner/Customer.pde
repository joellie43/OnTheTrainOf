import java.util.List;
class Customer{
  Food[] menu = new Food[6];
  
  int x,y;
  int id; //to keep track of customer
  int timeOrdered; //mark the time at which customer ordered
  color shade;
  Table sittingAt;
  int interactionTime;//time at which waiter last interacted with customer
  Food foodOrdered;
  boolean askingForService;
  boolean ordered;
  boolean served;
  boolean doneEating;
  int leaving;//-1 if not leaving, 0 if leaving angry, 1 if leaving happy
  int genPos;
  int blueShift; //b compnent of customer's rgb for personality
  int greenShift; //g component of customer's rgb for personaliy
  //no redShift red is designated for angry customers only
  
  Customer(int ID, int newGenPos, int xcor, int ycor){
    menu[0] = new Food("ice cream",6); //white
    menu[1] = new Food("pasta",8); //red
    menu[2] = new Food("salad",5); //green
    menu[3] = new Food("burger",9); //brown
    menu[4] = new Food("taco",7); //yellow
    menu[5] = new Food("soup",5); //orange
    id = ID; 
    blueShift = (int)(Math.random()*256);
    greenShift = (int)(Math.random()*256);
    shade = color(0, greenShift, blueShift);
    x = xcor;
    y = ycor;
    genPos = newGenPos;
    sittingAt = null;
    interactionTime = -1;
    leaving = -1;//not leaving state
    foodOrdered = null;
  }
  
  void display(){
    PShape customer, c1, c2, c3, c4;
    
    if(sittingAt != null && leaving == -1){//if sitting at a table
      int timeDif = millis() - interactionTime;
      if(timeDif > 15000){
        shade = color(255,0,0);
        leave(0);//leave angrily
        flo.madeSoFar -= foodOrdered.cost;//flo wasted food so deduct that food's cost from her earnings
      }
      else{
        shade = color(255 * timeDif/10000,
                      greenShift - greenShift * timeDif/10000,
                      blueShift - blueShift *timeDif/10000);
      }
    }
    else if(leaving == 0){ //leaving angry
      shade = color(255,0,0);
    }
    else{ //leaving happy
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
      interactionTime = millis();
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
    interactionTime = millis();
    return foodOrdered;
  }

  //walk towards exit and disappears
  //precondition: sittingAt isnt null, newLeaving is 0 or 1
  void leave(int newLeaving){
    if(sittingAt != null){
      sittingAt.empty = true;
      //removes food from table
      //sittingAt.dish = null;
      sittingAt = null;
      foodOrdered.finished = true;
    }
    leaving = newLeaving;
  }
}
