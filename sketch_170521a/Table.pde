import java.util.ArrayList; 

class Table{
  int x,y;
  color shade;
  int numSeats;
  ArrayList<Customer> customers;
  boolean capacity, served;
  
  
  Table(int seats, int xcor, int ycor){
    float r = random(256);
    float g = random(256);
    float b = random(256);
    shade = color(r,g,b);
    x =xcor + 22;
    y =ycor + 22;
    numSeats = seats;
    capacity = false;
    served = false;
  }
  
  void display(){
    rect(x - 22, y - 22, 55, 55, 7);
    fill(shade);
    /*
    if (customers.size() != 0){
    }*/
  }
  
  
}
