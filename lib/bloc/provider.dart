import 'package:flutter_food_app/model/foodmodel.dart';

class CartProvider {
  List<FoodModel> foodItems = [];

  List<FoodModel> addToList(FoodModel foodItem) {
    bool isPresent = false;

    if(foodItems.length > 0) {
      for(int i = 0; i < foodItems.length; i++) {
        if(foodItems[i].id == foodItem.id) {
          increaseItemQuantity(foodItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if(!isPresent) {
        foodItems.add(foodItem);
      }
    } else {
      foodItems.add(foodItem);
    }


    return foodItems;
  }

  List<FoodModel> removeFromList(FoodModel foodItem) {
    if(foodItem.quantity > 1) {
      foodItem.decrementQuantity();
    } else {
      foodItems.remove(foodItem);
    }
    return foodItems;
  }

  void increaseItemQuantity(FoodModel foodItem) => foodItem.incrementQuantity();
  void decreaseItemQuantity(FoodModel foodItem) => foodItem.decrementQuantity();
}