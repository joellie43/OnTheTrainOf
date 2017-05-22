class Waiter{
  int x,y;
  Check order;
  Food inHands;
  int madeSoFar;
  Waiter(){
    x = 10;
    y = 10;
  }
  void move(int xcor, int ycor){
    x = xcor;
    y = ycor;
  }
  
  void pickUpFood(Food foo){
    inHands = foo;
  }
  
  void takeOrder(Customer c){
    order = new Check(c.order());
  }
  
  //gives check to chef
  /*giveCheck(Check c){
  }
  */
  
  /*gives check to customer
  customer pays, and then leaves*/
  void giveCheck(Check c, Customer bob){
    madeSoFar += c.total;
    bob.leave();
  }
}