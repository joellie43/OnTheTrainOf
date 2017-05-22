Table[] tables;

void setup() {
  size(640, 360);
  tables = new Table[4];
  tables[0] = new Table(4,90,90);
  
}

void draw() {
  background(0);
  for (Table t : tables){
    t.display();}
}