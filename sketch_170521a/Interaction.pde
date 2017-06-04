class Interaction{
  int timeOf;
  String action;
  int floX;
  int floY;
  Customer c;
  Food f;
  
  //interaction = flo moving only
  Interaction(String a, int x, int y){
    action = a;
    floX = x;
    floY = y;
  }
  
  //interaction = flo took order
  Interaction(String a, Customer cm){
    action = a;
    c = cm;
  }
  
  //interaction = flo picked up food
  Interaction(String a, Food foo){
    action = a;
    f = foo;
  }
}