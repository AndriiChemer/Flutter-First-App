import 'package:flutter/cupertino.dart';

FoodItemList foodItemList = FoodItemList(foodItem: [
  FoodItem(id: 1, title: "Beach BBQ Burger", hotel: "Las Vegas Hotel", price: 14.49, imageUrl: "https://natashaskitchen.com/wp-content/uploads/2019/04/Best-Burger-4.jpg"),
  FoodItem(id: 2, title: "Kick Ass Burger", hotel: "Dudles", price: 17.43, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTok8uFpQr1qUzzU5rsPjBk3O7D0GFGN3RmaeKKr_SsQUDeg6vm&s"),
  FoodItem(id: 3, title: "Super Pizza Burger", hotel: "New York", price: 17.43, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJS06eE_3U5TYdWORJB0z-_YqyjmNgOs_UDvFiE_RKbg5bu1dG&s"),
  FoodItem(id: 4, title: "Golf Course", hotel: "Dudles", price: 17.43, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTok8uFpQr1qUzzU5rsPjBk3O7D0GFGN3RmaeKKr_SsQUDeg6vm&s"),
  FoodItem(id: 5, title: "Bacon Double Burger", hotel: "Dudles", price: 15.44, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0XzuIQqeaXoIOhHEThPHIIef4H37Shjz1Cf7ZCrOFes5ZCQWb&s"),
  FoodItem(id: 6, title: "Torronto Burger", hotel: "Torronto", price: 13.23, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDy5pieG1TbCsgdj1YVXIrbD6WYfnyYkTevrvz_HqeujH62NX9&s"),
  FoodItem(id: 7, title: "German Cheesburger", hotel: "Dortmund", price: 18.73, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4DMCrAgix8GLP_YBNbSyLufNXuoyxL-yYcDspkrjp4fsHmG3v&s"),
  FoodItem(id: 8, title: "Red Robin Chees", hotel: "Kiev", price: 10.43, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwLQR4EwBfGiJlskWl1UC_Q-e5TgdCHJpNupyphrxo9LyQZpbD&s"),
]);

class FoodItemList {
  List<FoodItem> foodItem;

  FoodItemList({@required this.foodItem});
}

class FoodItem {

  int id;
  String title;
  String hotel;
  double price;
  String imageUrl;
  int quantity;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imageUrl,

    this.quantity = 1
  });

  void incrementQuantity() {
    this.quantity++;
  }

  void decrementQuantity() {
    this.quantity--;
  }
}