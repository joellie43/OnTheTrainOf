import java.util.ArrayList;

ArrayList<Table> tables; 
Waiter flo;
ArrayList<Food> foods; //collection of ordered foods
ArrayList<Customer> customers;

Customer target;
int customerSize = 300; //size of square encompassing customers
boolean disableFlo = false;
int initTime;
int genTime;
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
  foods = new ArrayList<Food>();
  
  //prioritySideBar = new ArrayList<Integer>();

  initTime = millis();//roughly 370-450 by end of setup
  genTime = millis();
}

void draw() {
  background(0);
  
  //spawn customers every 3 sceconds
  if(millis() > genTime + 3000 && customerCount < 4){
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
      customerCount += 1;
      availablePos[tempI] = - availablePos[tempI];
      genTime = millis();
    }
  
  //light pink top right corner
  fill(255,200,200);
  ellipse(960,0,300,300);
  
  //timer at top right corner
  int timer = (millis() - initTime)/1000;
  textSize(32);
  fill(255);
  text(timer,875,50);
  
  //bottom right money tracker
  textSize(32);
  fill(255);
  text(flo.madeSoFar + "/" + goal,825,600);
  
  for (Table t : tables){
    t.display();
  }
  
  for (Food f: foods){
       f.display();
  }
  
  //if flo is carrying food
    if (flo.inHands != null){
     flo.inHands.display();
     
     //to move food with flo
     flo.inHands.x = flo.x - 10;
     flo.inHands.y = flo.y + 10;
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
  if(mousePressed&& !disableFlo && dist(mouseX,mouseY,300,40) < 50){
    flo.targetX = 300;
    flo.targetY = 40;
  }
  
  if(dist(flo.x, flo.y, 300, 40) == 0 && flo.inHands == null){
    pickUp(foods);
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
  if(lowestPos == c.genPos && c.sittingAt == null && mousePressed && dist(mouseX,mouseY,c.x,c.y) < 55) {
    disableFlo = true;
    //keep track of customer
    target = c;
  }
  
  //while customer is seated
  if (c.sittingAt != null){
    //make exclamation point appear 5 seconds after each interaction
    if (millis() - c.interactionTime > 5000){
    c.askForService();
    c.askingForService = true;
    }
    //exclamation point appears
    //if waiter is 100 away from customer
    //first order
    if (dist(flo.x,flo.y,c.x,c.y) < 100){
      if (c.ordered != true && c.askingForService){
      c.order();
      createFood(c.foodOrdered, c, foods.size() + 1);
    }
    //then receive food
    if (c.ordered && c.askingForService && flo.inHands != null && flo.inHands == c.foodOrdered){
        flo.serveFood(c);
        if (c.sittingAt.dish != null){
          c.sittingAt.dish.display();
        }
      }
    //wait 5 seconds after receiving food before ready to pay  
    if (millis() - c.interactionTime > 5000){
          c.doneEating = true;
    } 
    //lastly pay and leave
    if (c.served && c.askingForService && c.doneEating){
      flo.madeSoFar += c.foodOrdered.cost;
      //removes dish from table
      c.sittingAt.dish = null;
      //customer leaves happily
      c.leave(1);
      //c.sittingAt.dish = null;
      c.sittingAt = null;
    }
    }
  }
  //leave to the left of the screen(whether happy or angry)
  if(c.leaving >= 0){
    if(c.x > -50){
      c.x -= 5;
    }
    //if flo is holding a customer that left angrily's food, make that food disappear
    if (flo.inHands != null && flo.inHands.recipient == c){
      flo.inHands = null;
    }
 }
 }
 //drag the customer along mouse
 if(mousePressed && target != null){
   target.x = mouseX;
   target.y = mouseY;
 }
 
 //check if waiter reached goal
 if (second() >= 180){
   fill(0,0,0); 
   rect(0,0,960,640);
   textSize(100);
  fill(255);
  text("You lose!",230,320);
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
          if(c.sittingAt == null && c.leaving == -1){
            availablePos[c.genPos] *= -1;
            c.genPos += 1;
            availablePos[c.genPos] *= -1;
            c.y += 150;
          }
        }//end of customer shifting for
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

//called after customer places order
void createFood(Food f, Customer r, int i){
    f.recipient = r;
    f.position = i;
    foods.add(f);
}

void pickUp(ArrayList foods){
    //take out the first food
     try{
       flo.inHands = (Food)foods.remove(0);
     }
     catch(IndexOutOfBoundsException e){
       return;
     }
     //push all the other foods down the queue
     for(Object f: foods){
        ((Food)f).position -= 1; 
     }
}