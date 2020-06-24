import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_food_app/model/categorymodel.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  CategoryBloc();

  var categoryController = BehaviorSubject<CategoryModel>();

  Stream<CategoryModel> get categoryStream => categoryController.stream;
  Sink<CategoryModel> get categorySink => categoryController.sink;

  onCategoryClick(CategoryModel category) {
    categorySink.add(category);
  }

  @override
  void dispose() {
    categoryController.close();
    super.dispose();
  }
}