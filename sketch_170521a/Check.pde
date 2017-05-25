import java.util.ArrayList;
class Check{
  ArrayList<Food> foods;
  int total;
  void Check(){
  foods = new ArrayList<Food>();
  int total = 0;}
  
  void addFood(Food f){
  foods.add(f);
  total += f.cost;
  }
}
