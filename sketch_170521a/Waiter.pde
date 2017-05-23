class Waiter{
  int x,y;
  color shade; 
  Check order;
  Food inHands;
  int madeSoFar;
  Waiter(){
    x = 45;
    y = 45;
    shade = color(255, 204, 0);
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
    body = createShape(RECT, x, y, 40, 50);
    body.setFill(color(shade));
    head = createShape(ELLIPSE, x+20, y-20, 45, 45);
    head.setFill(color(shade));
    armL = createShape(RECT, x-40, y+5, 40, 10);
    armL.setFill(color(shade));
    armR = createShape(RECT, x+40, y+5, 40, 10);
    armR.setFill(color(shade));
    legL = createShape(RECT, x+5, y+50, 10, 40);
    legL.setFill(color(shade));
    legR = createShape(RECT, x+25, y+50, 10, 40);
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
 
  /*
  void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
*/


  void move(int xcor, int ycor){
    x = xcor;
    y = ycor;
  }
  
  void pickUpFood(Food foo){
    inHands = foo;
  }
  
  void takeOrder(Customer c){
    //order = new Check(c.order());
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