import 'package:flutter/cupertino.dart';

FoodItemList foodItemList = FoodItemList(foodItem: [
  FoodModel(id: 1, title: "Beach BBQ Burger", hotel: "Las Vegas Hotel", price: 14.49, imageUrl: "https://natashaskitchen.com/wp-content/uploads/2019/04/Best-Burger-4.jpg", category_id: 1),
  FoodModel(id: 2, title: "Kick Ass Burger", hotel: "Dudles", price: 17.43, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTok8uFpQr1qUzzU5rsPjBk3O7D0GFGN3RmaeKKr_SsQUDeg6vm&s", category_id: 1),
  FoodModel(id: 3, title: "Super Pizza Burger", hotel: "New York", price: 17.43, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJS06eE_3U5TYdWORJB0z-_YqyjmNgOs_UDvFiE_RKbg5bu1dG&s", category_id: 1),
  FoodModel(id: 4, title: "Golf Course", hotel: "Dudles", price: 17.43, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTok8uFpQr1qUzzU5rsPjBk3O7D0GFGN3RmaeKKr_SsQUDeg6vm&s", category_id: 1),

  FoodModel(id: 5, title: "Sushi tunec", hotel: "Dudles", price: 15.44, imageUrl: "https://www.tarantino-family.com/wp-content/uploads/2763004.png", category_id: 2),
  FoodModel(id: 6, title: "Sushi spasi", hotel: "Torronto", price: 13.23, imageUrl: "https://www.tarantino-family.com/wp-content/uploads/2763008.png", category_id: 2),
  FoodModel(id: 7, title: "Sushi spasi tunec", hotel: "Dortmund", price: 18.73, imageUrl: "https://www.tarantino-family.com/wp-content/uploads/2762002.png", category_id: 2),
  FoodModel(id: 8, title: "Sushi crab tunec spasi", hotel: "Kiev", price: 10.43, imageUrl: "https://www.tarantino-family.com/wp-content/uploads/2762001.png", category_id: 2),

  FoodModel(id: 9, title: "Pizza Exotic", hotel: "Las Vegas Hotel", price: 14.49, imageUrl: "https://images.pizza33.ua/products/product/KM8k3arousrLPeUydg7omY7xHHfWNh5P.jpg", category_id: 3),
  FoodModel(id: 10, title: "Mexican", hotel: "Dudles", price: 17.43, imageUrl: "https://images.pizza33.ua/products/product/MDJPYvvmzDs0TZRtYRvwTHx9f8V6Kk8V.png", category_id: 3),
  FoodModel(id: 11, title: "Pizza Chicago", hotel: "New York", price: 17.43, imageUrl: "https://images.pizza33.ua/products/product/aJXvRcBrZrHqhUrR3wX7WPPVQbYbTvFD.jpg", category_id: 3),
  FoodModel(id: 12, title: "Pizza Italy", hotel: "Dudles", price: 17.43, imageUrl: "https://images.pizza33.ua/products/product/kPD1aT9Bj0GJ5tsP26hm9yOzHw7OS6vN.jpg", category_id: 3),

  FoodModel(id: 13, title: "RICHApple 1 l", hotel: "Dudles", price: 15.44, imageUrl: "https://images.pizza33.ua/products/product/uIR7kFZvPYbncPYiHiRYbG47cV9vnkhK.jpg", category_id: 4),
  FoodModel(id: 14, title: "RICH Exotic 0.5 l", hotel: "Torronto", price: 13.23, imageUrl: "https://images.pizza33.ua/products/product/0NY8TfkSeBUMP5JfxuipWezvPtBMg1Eb.png", category_id: 4),
  FoodModel(id: 15, title: "Staropramen", hotel: "Dortmund", price: 18.73, imageUrl: "https://images.pizza33.ua/products/product/Rx3RiX0Ql73q8TD6MCgILNpfsqsN6qOZ.jpg", category_id: 4),
  FoodModel(id: 16, title: "Cabernet Merlot Argentinian red dry wine", hotel: "Kiev", price: 10.43, imageUrl: "https://images.pizza33.ua/products/product/1Ff32DFxuPcqLV8S7CfoXTuY2dpbNma5.png", category_id: 4),
]);

class FoodItemList {
  List<FoodModel> foodItem;

  FoodItemList({@required this.foodItem});
}

class FoodModel {

  int id;
  String title;
  String hotel;
  double price;
  String imageUrl;
  int quantity;
  int category_id;

  FoodModel({
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imageUrl,
    @required this.category_id,

    this.quantity = 1
  });

  void incrementQuantity() {
    this.quantity++;
  }

  void decrementQuantity() {
    this.quantity--;
  }
}