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
    x =xcor;
    y= ycor;
    numSeats = seats;
  }
  
  void display(){
    rect(x, y, 55, 55, 7);
    fill(shade);
  }
}
