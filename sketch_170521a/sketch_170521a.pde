import java.util.ArrayList;

ArrayList<Table> tables; 
Waiter flo;
ArrayList<Food> foods;
ArrayList<Food> toServe; //initially null when no food is being carried by Flo
ArrayList<Food> atTable;
ArrayList<Customer> customers;
Food toPlaceOnTable = null;
Food dinner;

boolean nearTo210;
boolean nearTo320;
boolean nearTo333;
boolean nearTo3059;
boolean nearTo3058;
boolean nearTo334, nearTo338, nearTo340;

boolean nearToFood;
boolean overCustomer = false;
boolean lockedCustomer = false;
boolean lockedFood = false;
Customer target;
int customerSize = 300; //size of square encompassing customers
int xOffset = 0;
int yOffset = 0;
boolean disableFlo = false;
int initTime;
int genTime;
int start;
int goal = 100;
int customerCount = 0; //how many customers are waiting to be seated
int[] availablePos = {150,300,450,600};

void setup() {
  size(960, 640);
  tables = new ArrayList<Table>();
  tables.add(0, new Table(4,375,200));
  tables.add(1, new Table(4,765,500));
  tables.add(2, new Table(4,375,500));
  tables.add(3, new Table(4,765,200));
  flo = new Waiter();
  customers = new ArrayList<Customer>();
  
  target = null;

  toServe = new ArrayList<Food>();
  foods = new ArrayList<Food>();
  atTable = new ArrayList<Food>();
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
  genTime = millis();
}

void draw() {
  background(0);
  
  //spawn customers every 8 sceconds
  if(millis() > genTime + 8000 && customerCount < 4){
      System.out.println("added customer" + second());
      int x = 0;
      int tempI = 0;
      for(int i = 0 ; i < 4; i += 1){
        if(availablePos[i] > 0){
          x = availablePos[i];
          tempI = i;
        }
      }
      customers.add(new Customer("businessman",1,4,10,tempI,50,x));
      customerCount += 1;
      availablePos[tempI] = - availablePos[tempI];
      genTime = millis();
    }
  
  //light pink top right corner
  fill(255,200,200);
  ellipse(960,0,300,300);
  
  //counter at top right corner
  int timer = (millis() - initTime)/1000;
  textSize(32);
  fill(255);
  text(timer,875,50);
  
  //
  textSize(32);
  fill(255);
  text(flo.madeSoFar + "/" + goal,825,600);
  
  for (Table t : tables){
    t.display();
  }
  
  for (Food f: foods){
     f.display();
  }
  for (Food x: toServe){
    if(flo.x != 210 && flo.y != 40){
       nearTo210 = false; 
    }
    else{
       nearTo210 = true; 
    }
    if(dist(flo.x, flo.y, 320, 85)>7){
       nearTo320 = false; 
    }
    else{
       nearTo320 = true; 
    }
    if(dist(flo.x, flo.y, 333, 72)>=5){
       nearTo333 = false; 
    }
    else{
       nearTo333 = true; 
    }
    if(dist(flo.x, flo.y, 305, 95)>=5){
       nearTo3059 = false; 
    }
    else{
       nearTo3059 = true; 
    }
    if(dist(flo.x, flo.y, 305, 85)>=3){
       nearTo3058 = false; 
    }
    else{
       nearTo3058 = true; 
    }
    if(dist(flo.x, flo.y, 334, 50)>=3){
       nearTo334 = false; 
    }
    else{
       nearTo334 = true; 
    }
    if(dist(flo.x, flo.y, 338, 70)>=3){
       nearTo338 = false; 
    }
    else{
       nearTo338 = true; 
    }
    if(dist(flo.x, flo.y, 340, 52)>=3){
       nearTo340 = false; 
    }
    else{
       nearTo340 = true; 
    }
    
     x.display();
     //to test if it is stopped
     int oldX = x.x;
     int oldY = x.y;
     //to move food with flo
     x.x = flo.x;
     x.y = flo.y;
     //System.out.println("target x: " + flo.targetX + " target y: " + flo.targetY);
     System.out.println("x: " + flo.x + " y: " + flo.y + " old x: " + oldX + " old y: " + oldY);
     //System.out.println("food x: " + x.x + " food y: " + x.y);
     //if((x.x == oldX && x.x != 210) && (x.y == oldY && x.y != 40)){
       if(x.x == oldX && x.y == oldY && !(nearTo320) &&  !(nearTo210) 
       && !(nearTo333) && !(nearTo3059) && !(nearTo3058) && !(nearTo334)
       && !(nearTo338) && !(nearTo340)){
         System.out.println("" + nearTo320);
         toPlaceOnTable = toServe.get(0);
         lockedFood = false;
         nearTo210 = nearTo320 = nearTo333 = nearTo3059 = nearTo3058 = nearTo334
         = nearTo338 = nearTo340 = true;
     }
  }
  if(toPlaceOnTable != null){
     toServe.remove(0);
     atTable.add(toPlaceOnTable);
     toPlaceOnTable = null;
  }
  for (Food z: atTable){
     for (Table t: tables){
        if(dist(z.x, z.y, t.x, t.y) < 60){
           z.x = t.x + 7;
           z.y = t.y + 7;
        }
     }
     z.display();
  } 
  //****FLO'S CODE****
  
  //if flo is carrying food
  /*if(toServe != null){
     toServe.display();
     toServe.x = flo.x;
     toServe.y = flo.y;
  }*/
  
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
  if(mousePressed&& !disableFlo && dist(mouseX,mouseY,300,40) < 50){
    flo.targetX = 300;
    flo.targetY = 40;
  }
  
  /*if(dist(flo.x,flo.y,300,40) < 50 && toServe == null){
     serveFood();
  }*/
  
  //System.out.println("x:" + flo.x + " y:" + flo.y);
  //System.out.println("dx:" + flo.dx + " dy:" + flo.dy);
  if((dist(210, 40, flo.x, flo.y)<5)||(dist(320, 84, flo.x, flo.y)<7)
  ||(dist(333, 72, flo.x, flo.y)<=3)||(dist(305, 95, flo.x, flo.y)<=3)
  ||(dist(305, 85, flo.x, flo.y)<=3)||(dist(338, 78, flo.x, flo.y)<=3)
  ||(dist(340, 52, flo.x, flo.y)<=3)||(dist(334, 50, flo.x, flo.y)<=3)){
    
    lockedFood = true;
  }

  if(lockedFood){
     serveFood(foods);
     lockedFood = false;
  }
  
  //*****************
  
 //**CUSTOMER'S CODE**
 
 for (Customer c : customers){
  c.display();
  //if customer is not yet seated and mouse is within 55 from customer
  for(int i : availablePos){
  System.out.print(i + ";");
  }
  System.out.println();
  if (c.sittingAt == null && mousePressed && dist(mouseX,mouseY,c.x,c.y) < 55) {
    disableFlo = true;
    //keep track of customer
    target = c;
  }
  
  //if customer is seated
  else if (c.sittingAt != null){
    //make exclamation point appear 5 seconds after each interaction
    if (millis() - c.sittingTime > 5000){
    c.askForService();
    }
    //if waiter is 100 away from customer
    if (dist(flo.x,flo.y,c.x,c.y) < 100 && c.ordered != true){
      c.order();}
      else if (dist(flo.x,flo.y,c.x,c.y) < 100 && c.served != true){
        flo.serveFood(c);
      }
  }
  //leave to the left of the screen
  if(c.leaving){
    if(c.x > -50){
      c.x -= 5;
    }
  }
 }
 //drag the customer along mouse
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
        customerCount -= 1;
        availablePos[target.genPos] = - availablePos[target.genPos];
      }
    }
    if(target.sittingAt == null){
      //customer has not been dragged to a table, so put back in line
      target.x = 50;
      target.y = Math.abs(availablePos[target.genPos]);
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
        for(Customer c: customers){
          if(c.sittingAt != null && c.sittingAt.equals(t) && !(t.served)){
              targetTable = t;
              t.served = true;
              break;
          }
        }
     }
     toServe.add(dinner);

   flo.targetX = targetTable.x;
   flo.targetY = targetTable.y;
   dinner.x = flo.x;
   dinner.y = flo.y;
}
