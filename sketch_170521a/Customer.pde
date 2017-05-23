import java.util.List;
class Customer{
  List<Food> menu;
  int x,y;
  String description; //such as businessman, food critic, mother
  int id; //to keep track of customer
  int partyOf; //how many people in one party
  int timerSec; //how long each customer is willing to wait for service
  color shade;
  
  Customer(String desc, int ID, int num, int sec){
    description = desc;
    id = ID; 
    partyOf = num;
    timerSec = sec;
    x = 10;
    y = 10;
    shade = color(170, 220, 60);
  }
  
  void display(){
    PShape customer, c1, c2, c3, c4;
    
    //waiter shape group
    customer = createShape(GROUP);
    
    //making all the appendages
    c1 = createShape(TRIANGLE, 25, 35, 75, 35, 50,10);
    c1.setFill(color(shade));
    c2 = createShape(TRIANGLE, 75, 35, 125, 35, 100, 10);
    c2.setFill(color(shade));

    c3 = createShape(TRIANGLE, 25, 60, 75, 60, 50, 40);
    c3.setFill(color(shade));
    
    c4 = createShape(TRIANGLE, 75, 60, 125, 60, 100, 40);
    c4.setFill(color(shade));
    
    //put it all together
    customer.addChild(c1);
   
    customer.addChild(c2);
    
    customer.addChild(c3);
    
    customer.addChild(c4);
    
    shape(customer);
  }
  
  void askToOrder(){
    //make some indicator pop up
  }
  
  /*Food order(){
    return menu.get(random(menu.size());
  }*/
  
  void askToPay(){
    //make some indicator pop up
  }
  

  //walk towards exit and disappears
  void leave(){
  }
}