import java.util.List;
class Customer{
  List<Food> menu;
  String description; //such as businessman, food critic, mother
  int id; //to keep track of customer
  int partyOf; //how many people in one party
  int timerSec; //how long each customer is willing to wait for service
  
  Customer(String desc, int ID, int num, int sec){
    description = desc;
    id = ID; 
    partyOf = num;
    timerSec = sec;
  }
  
  void askToOrder(){
    //make some indicator pop up
  }
  
  /*Food order(){
    return menu.get(random(menu.size());
  }*/
  
  void askToPay(){
    //make some indicator pop up
  }
  

  //walk towards exit and disappears
  void leave(){
  }
}