import java.util.ArrayList;

ArrayList<Table> tables;
Waiter flo;
ArrayList<Food> foods;
ArrayList<Customer> customers;

boolean lockedCustomer = false;
boolean disableFlo = false;
Customer target;

void setup() {
  size(960, 640);
  tables = new ArrayList<Table>();
  tables.add(0, new Table(4,375,200));
  tables.add(1, new Table(4,765,500));
  tables.add(2, new Table(4,375,500));
  tables.add(3, new Table(4,765,200));
  flo = new Waiter();
  customers = new ArrayList<Customer>();
  customers.add(new Customer("businessman",1,4,10,50,100));
  target = null;
  
  foods = new ArrayList<Food>();
  for(int i = 0; i < 8; i++){
    String fDesc;
    int descNum = (int)random(3);
    if(descNum == 0){
       fDesc = "Sausage";
    }
    else if(descNum == 1){
       fDesc = "Ham"; 
    }
    else{
       fDesc = "Lettuce"; 
    }
    foods.add(0, new Food(fDesc, (int)random(100), (int)random(10), i));
  }
  
}

void draw() {
  background(0);
  
  for (Table t : tables){
    t.display();
  }
  for (Food f: foods){
     f.display(); 
  }
  //****FLO'S CODE****
  flo.move();
  flo.display();
  for(Table t: tables){
    //user clicks on table
    if(mousePressed && !disableFlo && dist(mouseX,mouseY,t.x,t.y) < 55){
      flo.targetX = t.x;
      flo.targetY = t.y;
    }
    //flo is going to bumb into a table that's not a target
    if(t.x != flo.targetX && t.y != flo.targetY && dist(flo.x+flo.dx,flo.y+flo.dy,t.x,t.y) < 55){
      flo.rotate();
    }
  }
  //user clicks food station
  if(mousePressed&& !disableFlo && dist(mouseX,mouseY,300,40) < 40){
    flo.targetX = 300;
    flo.targetY = 40;
  }
 //*****************
 //**Customer Code**
 for (Customer c : customers){
  c.display();
  if (mousePressed && dist(mouseX,mouseY,c.x,c.y) < 55) {
    lockedCustomer = true;
    disableFlo = true;
    //keep track of customer
    target = c;
  }
 }
 if(mousePressed && target != null){
   target.x = mouseX;
   target.y = mouseY;
 }
}//end of draw()

void mouseReleased() {
  disableFlo = false;
  lockedCustomer = false;
  target = null;
}
