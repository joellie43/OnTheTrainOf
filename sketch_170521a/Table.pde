import java.util.ArrayList; 

class Table{
  int x,y;
  color shade;
  int numSeats;
  boolean empty, served;
  
  Table(int seats, int xcor, int ycor){
    float r = random(256);
    float g = random(256);
    float b = random(256);
    shade = color(r,g,b);
    x =xcor;
    y= ycor;
    numSeats = seats;
    empty = true;
    served = false;
  }
  
  void display(){
    rect(x - 22, y - 22, 55, 55, 7);
    fill(shade);
  } 
}