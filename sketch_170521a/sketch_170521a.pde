import java.util.ArrayList;

Table[] tables;
Waiter flo;
ArrayList<Food> foods;
ArrayList<Customer> customers;

void setup() {
  size(640, 360);
  tables = new Table[4];
  tables[0] = new Table(4,250,100);
  tables[1] = new Table(4,510,250);
  tables[2] = new Table(4,250,250);
  tables[3] = new Table(4,510,100);
  flo = new Waiter();
  customers = new ArrayList<Customer>();
}

void draw() {
  background(0);
  for (Table t : tables){
    t.display();}
    flo.display();
    //just moves flo down the screen
    //flo.move(flo.x+1, flo.y+1);
    flo.click();
       flo.move(flo.x+flo.dx, flo.y+flo.dy); 
       customers.add(new Customer("businessman",1,4,10));
       for (Customer c : customers){
         c.display();}
}