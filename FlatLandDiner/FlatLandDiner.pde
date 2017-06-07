import java.util.ArrayList;

String gameMode = "title";
boolean gameSetUpYet = false;

ArrayList<Table> tables; 
Waiter flo;
ArrayList<Food> foods; //collection of ordered foods
ArrayList<Customer> customers;
int customerID = 0;
ArrayList<String> messageBoard;
String newMessage = "";

boolean nearToFood;
Customer target;
int customerSize = 300; //size of square encompassing customers
boolean disableFlo = false;
int initTime;
int genTime;
int goal = 50;
int customerCount = 0; //how many customers are waiting to be seated
int[] availablePos = {150,300,450,600};
boolean won,lost;

void setup() {
  size(960, 640);
  tables = new ArrayList<Table>();
  tables.add(0, new Table(375,200));
  tables.add(1, new Table(765,500));
  tables.add(2, new Table(375,500));
  tables.add(3, new Table(765,200));
  flo = new Waiter();
  customers = new ArrayList<Customer>();
  messageBoard = new ArrayList<String>();
  target = null;
  foods = new ArrayList<Food>();
  initTime = millis();//roughly 370-450 by end of setup
  genTime = millis();
  won = false;
  lost = false;
}

void draw() {
  if(gameMode.equals("title")){
     titleScreen(); 
  }
  else if(gameMode.equals("instruct")){
     instruction(); 
  }
  else{
  if(!gameSetUpYet){
      setup();
      gameSetUpYet = true;
  }
  background(245,245,220);
 
  if (!won && !lost){
  
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
  fill(0);
  text(flo.madeSoFar + "/" + goal,825,600);
  
  //right side order customer tracker
  textSize(12);
  fill(150);
  
  //dish washer
  fill(209);
  rect(725,0,50,50);
  
  if(messageBoard.isEmpty()){
      messageBoard.add(newMessage);
  }
  
  if(!(messageBoard.isEmpty())){
    boolean addOrNot = true;
    for(String s: messageBoard){
       if(s.equals(newMessage)){
         addOrNot = false; 
       } 
    }
    
  if(addOrNot){
    messageBoard.add(newMessage); 
    }
    
  for(int i = 0; i < messageBoard.size(); i++){
    fill(0);
    text(messageBoard.get(i), 750, 320 + 10*i); 
    }
  }
  
  if(messageBoard.size() > 10){
     messageBoard.remove(0); 
  }
  
  for (Table t : tables){
    t.display();
  }
  
  for (Food f: foods){
       f.display();
  }

  //****FLO'S CODE****
  
  flo.move();
  
  flo.display();
  
  for(Table t: tables){
    //user clicks on table, move to table
    if(mousePressed && !disableFlo && dist(mouseX,mouseY,t.x,t.y) < 55){
      flo.targetX = t.x;
      flo.targetY = t.y;
    }
    
    //if clicks on table that needs to be cleaned
    if (t.empty && !t.clean && flo.inHands == null){
    flo.inHands = t.dish;
    flo.inHands.display();
    flo.inHands.x = flo.x - 10;
    flo.inHands.y = flo.y + 10;
    t.dish = null;
    t.clean = true;
  }
  
  //user clicks on dish washer while holding finished food
  if (mousePressed && dist(mouseX,mouseY,725,0) < 50 && flo.inHands != null){
    //move to dish washer
    flo.targetX = 725;
    flo.targetY = 0;
    //click again to "wash dish" = make dish disappear
    if (dist(flo.x,flo.y,725,0) < 50 && flo.inHands.finished){
      flo.inHands = null;
    }
  }
}
  
  //user clicks food station
  if(mousePressed && !disableFlo && dist(mouseX,mouseY,300,40) < 100){
    flo.targetX = 300;
    flo.targetY = 40;
  }
  
  //if near food station
  if(dist(flo.x, flo.y, 300, 40) == 0 && flo.inHands == null){
    pickUp();
  }
  
  //if flo is carrying food
    if (flo.inHands != null){
     flo.inHands.display();
     
     //to move food with flo
     flo.inHands.x = flo.x - 10;
     flo.inHands.y = flo.y + 10;
   }
  
  
 //**CUSTOMER'S CODE**
 
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
      Customer c = new Customer(customerID,tempI,75,x);
      customerID += 1;
      customers.add(c);
      newMessage = "Customer " + c.id + " has entered";
      customerCount += 1;
      availablePos[tempI] = - availablePos[tempI];
      genTime = millis();
    }
 
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
  
  //drag the customer along mouse
 if(mousePressed && target != null && target.leaving == -1){
   target.x = mouseX;
   target.y = mouseY;
 }
 
  //while customer is seated
  if (c.sittingAt != null){
    newMessage = "Customer " + c.id + " is now seated";
    //make exclamation point appear 5 seconds after each interaction
    if (millis() - c.interactionTime > 5000){
    c.askForService();
    c.askingForService = true;
    newMessage = "Please attend Customer " + c.id;
    }
    //exclamation point appears
    //if waiter is 100 away from customer
    //first order
    if (dist(flo.x,flo.y,c.x,c.y) < 100){
      if (c.ordered != true && c.askingForService){
      c.order();
      newMessage = "Customer " + c.id + " has ordered: " + c.foodOrdered.description;
      createFood(c.foodOrdered, c, foods.size() + 1);
    }
    //then receive food
    if (c.ordered && c.askingForService && flo.inHands != null && flo.inHands == c.foodOrdered){
        flo.serveFood(c);
        messageBoard.add("Customer " + c.id + " has received food");
      }
    //wait 5 seconds after receiving food before ready to pay  
    if (millis() - c.interactionTime > 5000){
       c.doneEating = true;
    } 
    //lastly pay and leave
    if (c.served && c.askingForService && c.doneEating){
      flo.madeSoFar += c.foodOrdered.cost;
      messageBoard.add("You have made $" + c.foodOrdered.cost + "!");
      //customer leaves happily
      c.leave(1);
    }
    }
  }
  //leave to the left of the screen(whether happy or angry)
  if(c.leaving >= 0){
    newMessage = "Customer " + c.id + " is leaving"; 
    if(c.x > -50){
      c.x -= 5;
    }
    //if customer left without taking food, make his/her order disappear
    if (foods.size() > 0 && foods.get(0).recipient == c){
      foods.remove(0);
    }
   }
 }
}
    //check if time is up
 if (millis() - initTime >= 100000){
   lost = true;
   fill(0,0,0); 
   rect(0,0,960,640);
   textSize(100);
  fill(255);
  text("You lost!",230,320);
  }
 
 //check if waiter reached goal
 if (flo.madeSoFar >= goal){
   won = true;
   fill(0,0,0); 
   rect(0,0,960,640);
   textSize(100);
  fill(255);
  text("You won!",230,320);
  }
 //***************
  }
}//end of draw()

//mouseReleased for dropping customer
void mouseReleased(){
  //check if customer was dropped off at a table
  if(target != null){
    for(Table t: tables){
      if(dist(target.x,target.y,t.x,t.y) < 55 && t.empty && t.clean){
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

void titleScreen(){
   background(200, 200, 200);
   textSize(32);
   fill(255);
   text("Welcome to FlatLand Diner!", 500, 500);

   rect(200, 550, 150, 30);
   fill(150, 150, 100);
   
   rect(400, 550, 150, 30);
   fill(255, 200, 0);
   
   textSize(15);
   fill(100);
   text("Start Game", 235, 575);
   
   textSize(15);
   fill(100);
   text("Instructions", 435, 575);
   
   if(mousePressed && dist(mouseX, mouseY, 275, 565) < 75){
      gameMode = "play"; 
   }
   else if(mousePressed && dist(mouseX, mouseY, 475, 565) < 75){
      gameMode = "instruct"; 
   }
}

void instruction(){
   background(0, 50, 200);
   
   textSize(25);
   fill(250, 150, 250);
   text("You are Flo. You are in charge of FlatLand Diner.", 100, 200);
   text("Start by dragging the customers (triangles) to their tables.", 100, 235);
   text("Attend to the customers when they request it!", 100, 270);
   text("Click on the food queue to pick up the customer's request.", 100, 305);
   text("Empty plates at the dishwasher after customers leave.", 100, 340);
   text("Look to the sidebar for advice.", 100, 375);
   text("Enjoy and don't mess up!", 100, 410);
   
   rect(600, 550, 150, 30);
   fill(150, 150, 100);
   
   rect(800, 550, 150, 30);
   fill(255, 200, 0);
   
   textSize(15);
   fill(100);
   text("Start Game", 635, 575);
   
   textSize(15);
   fill(100);
   text("Title Screen", 835, 575);
   
   if(mousePressed && dist(mouseX, mouseY, 675, 565) < 75){
      gameMode = "play"; 
   }
   else if(mousePressed && dist(mouseX, mouseY, 875, 565) < 75){
      gameMode = "title"; 
   }
}

void pickUp(){
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