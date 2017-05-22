Table[] tables;

void setup() {
  size(640, 360);
  tables = new Table[4];
  tables[0] = new Table(4,90,90);
  tables[1] = new Table(4,300,300);
  tables[2] = new Table(4,90,300);
  tables[3] = new Table(4,300,90);
  
}

void draw() {
  background(0);
  for (Table t : tables){
    t.display();}
}
