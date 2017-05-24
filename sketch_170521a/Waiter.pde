class Waiter{
  int x,y;
  color shade; 
  Check order;
  Food inHands;
  int madeSoFar;
  int state;
  int targetX;
  int targetY;
  float dx, dy;
  Waiter(){
    x = 45;
    y = 45;
    shade = color(255, 204, 0);
    state = 0; //default
    dx = 1;
    dy = 1;
    targetX = -1;
    targetY = -1;
  }
  
  void display(){
    /*
    pushMatrix();
  translate(width*0.8, height*0.5);
 // star(0, 0, 20, 50, 5); 
  popMatrix();
    fill(shade);*/
    PShape waiter, head, body, armL, armR, legL, legR;
    
    //waiter shape group
    waiter = createShape(GROUP);
    
    //making all the appendages
    body = createShape(RECT, x, y, 24, 25);
    body.setFill(color(shade));
    head = createShape(ELLIPSE, x+12, y-10, 22, 22);
    head.setFill(color(shade));
    armL = createShape(RECT, x-21, y+5, 20, 5);
    armL.setFill(color(shade));
    armR = createShape(RECT, x+25, y+5, 20, 5);
    armR.setFill(color(shade));
    legL = createShape(RECT, x+2, y+25, 5, 20);
    legL.setFill(color(shade));
    legR = createShape(RECT, x+18, y+25, 5, 20);
    legR.setFill(color(shade));
    
    //put it all together
    waiter.addChild(body);
    waiter.addChild(head);
    waiter.addChild(armL);
    waiter.addChild(armR);
    waiter.addChild(legL);
    waiter.addChild(legR);
    
    shape(waiter);
  }

  void move(){
      if(targetX != -1 && targetY != -1){
        float D = dist(x,y,targetX,targetY);
        dx = 10*(targetX-x)/D;
        dy = 10*(targetY-y)/D;
        if(D > 55){//continue moving towards target
          x += dx;
          y += dy;
        }
        else{targetX = -1; targetY = -1;}//target reached
      }
  }
  
  void rotate(){
  
  }
  void pickUpFood(Food foo){
    inHands = foo;
  }
  
  /*void takeOrder(Customer c){
    //order = new Check(c.order());
  }*/
  
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
