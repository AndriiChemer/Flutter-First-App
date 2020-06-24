import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/bloc/categoryBloc.dart';
import 'package:flutter_food_app/model/categorymodel.dart';
import 'package:flutter_food_app/tools/image_tools.dart';

class CategoryItem extends StatelessWidget {

//  final String categoryIcon;
//  final String categoryName;
//  final int availability;
//  final bool selected;

//  const CategoryItem({
//    @required this.categoryIcon,
//    @required this.categoryName,
//    @required this.availability,
//    @required this.selected
//  });

  final CategoryModel categoryModel;

  const CategoryItem({@required this.categoryModel});


  @override
  Widget build(BuildContext context) {

    final CategoryBloc categoryBloc = BlocProvider.getBloc<CategoryBloc>();

    String image = ImageTools.getCategoryImage(categoryModel.categoryIcon);

    return GestureDetector(
      onTap: () {
        categoryBloc.onCategoryClick(categoryModel);
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color:  categoryModel.selected ? Color(0xfffeb324) : Colors.white,
            border: Border.all(
                color: categoryModel.selected ? Colors.transparent : Colors.grey[200],
                width: 1.5
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[100],
                  blurRadius: 15,
                  offset: Offset(25, 0),
                  spreadRadius: 5
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: categoryModel.selected ? Colors.transparent : Colors.grey,
                      width: 1.5
                  )
              ),
              child: Image.asset(image, width: 30, height: 30,),
            ),
            SizedBox(height: 10,),
            Text(
              categoryModel.categoryName,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: 1.5,
              height: 15,
              color: Colors.black26,
            ),
            Text(
              categoryModel.availability.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
            )

          ],
        ),
      ),
    );
  }
}