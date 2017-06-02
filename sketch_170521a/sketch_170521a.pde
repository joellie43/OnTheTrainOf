import java.util.ArrayList;

ArrayList<Table> tables; 
Waiter flo;
ArrayList<Food> foods;
ArrayList<Food> toServe; //initially null when no food is being carried by Flo
ArrayList<Food> atTable;
ArrayList<Customer> customers;
Food toPlaceOnTable = null;
Food dinner;

boolean nearToFood;
boolean overCustomer = false;
boolean lockedCustomer = false;
boolean lockedFood = true;
Customer target;
int customerSize = 300; //size of square encompassing customers
int xOffset = 0;
int yOffset = 0;
boolean disableFlo = false;
int initTime;
int genTime;
int start;
int goal = 50;
int customerCount = 0; //how many customers are waiting to be seated
int[] availablePos = {150,300,450,600};
//ArrayList<Integer> prioritySideBar;

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
  
  //prioritySideBar = new ArrayList<Integer>();

  initTime = millis();//roughly 370-450 by end of setup
  genTime = millis();
}

void draw() {
  background(0);
  
  
  //spawn customers every 8 sceconds
  if(millis() > genTime + 3000 && customerCount < 4){
      //System.out.println("added customer" + second());
      int x = 0;
      int tempI = 0;
      for(int i = 0 ; i < 4; i += 1){
        if(availablePos[i] > 0){
          x = availablePos[i];
          tempI = i;
        }
      }
      Customer c = new Customer("businessman",1,4,10,tempI,50,x);
      customers.add(c);
      System.out.println(c.foodOrdered.description);
      createFood(c.foodOrdered, foods.size() + 1);;
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
     try{
       f.display();
     }
     catch(NullPointerException e){}
  }
  for (Food x: toServe){
    
     x.display();
     //to test if it is stopped
     int oldX = x.x;
     int oldY = x.y;
     //to move food with flo
     x.x = flo.x - 10;
     x.y = flo.y + 10;
       if(dist(x.x, x.y, 365, 209) < 5 || dist(x.x, x.y, 365, 509) < 5 
       || dist(x.x, x.y, 755, 209) < 5 || dist(x.x, x.y, 755, 509) < 5){
         toPlaceOnTable = toServe.get(0);
         lockedFood = false;
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
           z.x = t.x - 40;
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
  
  if(dist(flo.x, flo.y, 300, 40) == 0 && toServe.size() == 0){
    //lockedFood = true;
    serveFood(foods);
    //lockedFood = false;
  }
  
  //*****************
  
 //**CUSTOMER'S CODE**
  int lowestPos = -1;
  for(int i = 0; i < 4; i ++){
    if(availablePos[i] < 0){
      lowestPos = i;
    }
  }
 for (Customer c : customers){
  c.display();
  //if customer is not yet seated and mouse is within 55 from customer
  for(int i : availablePos){
  //System.out.print(i + ";");
  }
  //System.out.println();
  if(lowestPos == c.genPos && c.sittingAt == null && mousePressed && dist(mouseX,mouseY,c.x,c.y) < 55) {
    disableFlo = true;
    //keep track of customer
    target = c;
  }
  
  //while customer is seated
  if (c.sittingAt != null){
    //make exclamation point appear 5 seconds after each interaction
    if (millis() - c.sittingTime > 5000){
    c.askForService();
    c.askingForService = true;
  //System.out.println("exclamation appeared");
}
    //exclamation point appears
    //if waiter is 100 away from customer
    if (dist(flo.x,flo.y,c.x,c.y) < 100){
      if (c.ordered != true && c.askingForService){
      c.order();
    //System.out.println("ordered");
  }
    //make sure waiter has moved away first and then come back
    if (c.ordered && c.askingForService){
        flo.serveFood(c);
      }
      //lastly pay and leave
    if (c.served && c.askingForService){
      flo.madeSoFar += c.foodOrdered.cost;
      //System.out.println("paid");
      c.leave();
    c.sittingAt = null;}
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
 
 //check if waiter reached goal
 if (flo.madeSoFar >= goal){
   fill(0,0,0); 
   rect(0,0,960,640);
   textSize(100);
  fill(255);
  text("You won!",230,320);
  }
 //***************
}//end of draw()

//mouseReleased for dropping customer
void mouseReleased(){
  //check if customer was dropped off at a table
  if(target != null){
    for(Table t: tables){
      if(dist(target.x,target.y,t.x,t.y) < 55 && t.empty){
        target.sit(t);
        customerCount -= 1;
        availablePos[target.genPos] *= -1;
        //shifts all customers in line down by one
        for(Customer c : customers){
          if(c.sittingAt == null && !c.leaving){
            availablePos[c.genPos] *= -1;
            c.genPos += 1;
            availablePos[c.genPos] *= -1;
            c.y += 150;
          }
        }//end of custoemr shifting for
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

void createFood(Food f, int i){
    f.position = i;
    foods.add(f);
}

void serveFood(ArrayList foods){
  Table targetTable = new Table(0, 0, 0);
    //take out the first food
     try{
       dinner = (Food)foods.remove(0);
     }
     catch(IndexOutOfBoundsException e){
       return;
     }
     for(Object f: foods){
        ((Food)f).position -= 1; 
     }
     //replenish the food queue
     //createFood(foods, foods.size()-1); //final index of the arrayList
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

   //flo.targetX = targetTable.x;
   //flo.targetY = targetTable.y;
   dinner.x = 300;
   dinner.y = 40;
}
