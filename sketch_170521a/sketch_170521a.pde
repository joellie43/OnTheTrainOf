import java.util.ArrayList;

ArrayList<Table> tables;
Waiter flo;
ArrayList<Food> foods;
ArrayList<Customer> customers;

boolean overCustomer = false;
boolean lockedCustomer = false;
int customerSize = 300;
int cx, cy;
int xOffset = 0;
int yOffset = 0;

void setup() {
  size(960, 640);
  tables = new ArrayList<Table>();
  tables.add(0, new Table(4,375,200));
  tables.add(1, new Table(4,765,500));
  tables.add(2, new Table(4,375,500));
  tables.add(3, new Table(4,765,200));
  flo = new Waiter();
  customers = new ArrayList<Customer>();
  customers.add(new Customer("businessman",1,4,10));
  cx = width/2;
  cy = height/2;
}

void draw() {
  background(0);
  flo.move();
  for (Table t : tables){
    t.display();}
    flo.display();
    if(mousePressed){
      for(Table t: tables){
        if(dist(mouseX,mouseY,t.x,t.y) < 55 && !overCustomer){
          flo.targetX = t.x;
          flo.targetY = t.y;
        }
      }
      }
      // Test if the cursor is over the box 
  if (mouseX > cx-customerSize && mouseX < cx+customerSize && 
      mouseY > cy-customerSize && mouseY < cy+customerSize) {
        System.out.println("above customer");
    overCustomer = true;  
    if(!lockedCustomer) { 
      System.out.println("hi");
      stroke(255); 
      fill(153);
    } 
  } else {
    stroke(153);
    fill(153);
    overCustomer = false;
  }
  for (Customer c : customers){
      c.display(cx,cy);}
}

void mousePressed() {
  if(overCustomer) { 
    lockedCustomer = true; 
    fill(255, 255, 255);
  } else {
    lockedCustomer = false;
  }
  xOffset = mouseX-cx; 
  yOffset = mouseY-cy; 

}

void mouseDragged() {
  if(lockedCustomer) {
    cx = mouseX-xOffset; 
    cy = mouseY-yOffset; 
  }
}

void mouseReleased() {
  lockedCustomer = false;
}
