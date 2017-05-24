import java.util.ArrayList;

ArrayList<Table> tables;
Waiter flo;
ArrayList<Food> foods;
ArrayList<Customer> customers;

void setup() {
  size(960, 640);
  tables = new ArrayList<Table>();
  tables.add(0, new Table(4,375,200));
  tables.add(1, new Table(4,765,500));
  tables.add(2, new Table(4,375,500));
  tables.add(3, new Table(4,765,200));
  flo = new Waiter();
  
}

void draw() {
  background(0);
  for (Table t : tables){
    t.display();}
    flo.display();
    if(mousePressed){
      for(Table t: tables){
        if(dist(mouseX,mouseY,t.x,t.y) < 55){
          flo.targetX = t.x;
          flo.targetY = t.y;
        }
      }
      }
     
     customers.add(new Customer("businessman",1,4,10));
     for (Customer c : customers){
         c.display();}
}
