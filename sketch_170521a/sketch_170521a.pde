import java.util.ArrayList;

ArrayList<Table> tables;
Waiter flo;
ArrayList<Food> foods;
ArrayList<Food> toServe;
ArrayList<Customer> customers;
Food dinner;

boolean overCustomer = false;
boolean lockedCustomer = false;
boolean lockedFood = false;
Customer target;
int customerSize = 300;
int xOffset = 0;
int yOffset = 0;
boolean disableFlo = false;
int initTime;
int start;

void setup() {
  size(960, 640);
  start = second();
  tables = new ArrayList<Table>();
  tables.add(0, new Table(4,375,200));
  tables.add(1, new Table(4,765,500));
  tables.add(2, new Table(4,375,500));
  tables.add(3, new Table(4,765,200));
  flo = new Waiter();
  customers = new ArrayList<Customer>();
  customers.add(new Customer("businessman",1,4,10,50,100));
  target = null;
  
  toServe = new ArrayList<Food>();
  foods = new ArrayList<Food>();
  for(int i = 0; i < 8; i++){
    /*String fDesc;
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
    foods.add(0, new Food(fDesc, (int)random(100), (int)random(10), i));*/
    createFood(foods, i);
  }
  initTime = millis();//roughly 370-450 by end of setup
}

void draw() {
  background(0);
  //light pink top right corner
  fill(255,200,200);
  ellipse(960,0,300,300);
  //timer at top right corner
  int timer = (millis() - initTime)/1000;
  textSize(32);
  fill(255);
  text(timer,875,50);
  
  for (Table t : tables){
    t.display();
  }
  for (Food f: foods){
     f.display();
  }
  for (Food x: toServe){
     x.display();
     x.x = flo.x;
     x.y = flo.y;
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
  }
  //user clicks food station
  if(mousePressed&& !disableFlo && dist(mouseX,mouseY,300,40) < 40){
    flo.targetX = 300;
    flo.targetY = 40;
  }
  if(dist(flo.x,flo.y,250,40) < 40){
    
    lockedFood = true;
    System.out.println("x: " + flo.x + " y: " + flo.y);
  }

  if(lockedFood){
     serveFood(foods);
     lockedFood = false;
  }
  //*****************
 //*****************
 //**Customer Code**
 for (Customer c : customers){
  c.display();
  if (c.sittingAt == null && mousePressed && dist(mouseX,mouseY,c.x,c.y) < 55) {
    disableFlo = true;
    //keep track of customer
    target = c;
  }
  else if (c.sittingAt != null){
    c.askForService();
    if (dist(flo.x,flo.y,c.x,c.y) < 100){
      c.order();
    c.display();}
  }
  if(c.leaving){
    if(c.x > -50){
      c.x -= 5;
    }
  }
 }
 //while a customer is being dragged
 if(mousePressed && target != null){
   target.x = mouseX;
   target.y = mouseY;
 }
 
 //***************
}//end of draw()

//mouseReleased for dropping customer
void mouseReleased(){
  //check if customer was dropped off at a table
  if(target != null){
    for(Table t: tables){
      if(dist(target.x,target.y,t.x,t.y) < 55){
        target.sit(t);
      }
    }
  }
  disableFlo = false;
  target = null;
}

void createFood(ArrayList foods, int i){
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
    foods.add(new Food(fDesc, (int)random(100), (int)random(10), i));
}

void serveFood(ArrayList foods){
  Table targetTable = new Table(0, 0, 0);
    //take out the first food
     dinner = (Food)foods.remove(0);
     for(Object f: foods){
        ((Food)f).position -= 1; 
     }
     //replenish the food queue
     createFood(foods, 7); //final index of the arrayList
     for(Table t: tables){
        if(!(t.served)){
            targetTable = t;
            t.served = true;
            break;
        }
     }
     toServe.add(dinner);

   flo.targetX = targetTable.x;
   flo.targetY = targetTable.y;
   dinner.x = flo.x;
   dinner.y = flo.y;
}
