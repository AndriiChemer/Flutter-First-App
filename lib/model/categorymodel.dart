import 'package:flutter/material.dart';

CategoryModelList categoryListItem = CategoryModelList(categoryList: [
  CategoryModel(id: 1, categoryName: "Burgers", categoryIcon: "burger", selected: true, availability: 4),
  CategoryModel(id: 2, categoryName: "Sushi", categoryIcon: "sushi", selected: false, availability: 4),
  CategoryModel(id: 3, categoryName: "Pizza", categoryIcon: "pizza", selected: false, availability: 4),
  CategoryModel(id: 4, categoryName: "Drinks", categoryIcon: "drinks", selected: false, availability: 4),
]);

class CategoryModelList {
  List<CategoryModel> categoryList;

  CategoryModelList({@required this.categoryList});
}

class CategoryModel {

  int id;
  String categoryName;
  String categoryIcon;
  bool selected;
  int availability;

  CategoryModel({
    @required this.id,
    @required this.categoryName,
    @required this.categoryIcon,
    @required this.selected,
    @required this.availability,
  });
}