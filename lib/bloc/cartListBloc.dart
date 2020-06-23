import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_food_app/bloc/provider.dart';
import 'package:flutter_food_app/model/foodmodel.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc extends BlocBase{

  var _listController = BehaviorSubject<List<FoodModel>>.seeded([]);
  CartProvider cartProvider = CartProvider();

  CartListBloc();

  //output
  Stream<List<FoodModel>> get listStream => _listController.stream;

  Sink<List<FoodModel>> get listSink => _listController.sink;


  addToList(FoodModel foodItem) {
    listSink.add(cartProvider.addToList(foodItem));
  }

  removeFromList(FoodModel foodItem) {
    listSink.add(cartProvider.removeFromList(foodItem));
  }


  @override
  void dispose() {// will be called automatically
    _listController.close();
  }

}

//class CartListBloc {
//
//  final cartItemController = StreamController.broadcast();
//  final CartProvider cartProvider = CartProvider();
//
//  Stream<List<FoodItem>> get getList => cartItemController.stream;
//
//
//  addToList(FoodItem foodItem) {
//    cartProvider.addToList(foodItem);
//    cartItemController.sink.add(cartProvider.addToList(foodItem));
//  }
//
//  removeFromList(FoodItem foodItem) {
//    cartProvider.removeFromList(foodItem);
//    cartItemController.sink.add(cartProvider.removeFromList(foodItem));
//  }
//
//
//  @override
//  void dispose() {// will be called automatically
//    cartItemController.close();
//  }
//
//}