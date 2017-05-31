import java.util.ArrayList;
class Check{
  ArrayList<Food> foods;
  int total;

  Check(){
  foods = new ArrayList<Food>();
  int total = 0;}
  
  //add Food to foods
  void addFood(Food f){
  foods.add(f);
  total += f.cost;
  }
  
  //get a specific Food in foods
  Food getFood(int x){
    return foods.get(x);
  }
}
