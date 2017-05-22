import java.util.ArrayList; 

class Table{
  int x,y;
  color shade;
  int numSeats;
  //ArrayList<Customer> customers;
  
  
  Table(int seats, int xcor, int ycor){
    float r = random(256);
    float g = random(256);
    float b = random(256);
    shade = color(r,g,b);
    numSeats = seats;
  }
  
  void display(){
    rect(30, 20, 55, 55, 7);
    fill(shade);
  }
}