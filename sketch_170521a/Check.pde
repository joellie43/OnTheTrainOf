import java.util.ArrayList;
class Check{
  ArrayList<Food> foods;
  int total;

  Check(){
  foods = new ArrayList<Food>();
  int total = 0;}
  
  void addFood(Food f){
  foods.add(f);
  total += f.cost;
  }
  
  Food getFood(int x){
    return foods.get(x);
  }
}
