Table[] tables;
Waiter flo;

void setup() {
  size(640, 360);
  tables = new Table[4];
  tables[0] = new Table(4,250,100);
  tables[1] = new Table(4,510,250);
  tables[2] = new Table(4,250,250);
  tables[3] = new Table(4,510,100);
  flo = new Waiter();
  
}

void draw() {
  background(0);
  for (Table t : tables){
    t.display();}
    flo.display();
}