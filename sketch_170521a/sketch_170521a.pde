Table[] tables;
Waiter flo;

void setup() {
  size(960, 640);
  tables = new Table[4];
  tables[0] = new Table(4,375,200);
  tables[1] = new Table(4,765,500);
  tables[2] = new Table(4,375,500);
  tables[3] = new Table(4,765,200);
  flo = new Waiter();
  
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
}
