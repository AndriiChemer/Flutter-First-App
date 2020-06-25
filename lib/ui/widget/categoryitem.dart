import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/bloc/categoryBloc.dart';
import 'package:flutter_food_app/model/categorymodel.dart';
import 'package:flutter_food_app/tools/image_tools.dart';

class CategoryItem1 extends StatefulWidget {

  final int position;
  final CategoryModel categoryModel;

  const CategoryItem1({
    @required this.position,
    @required this.categoryModel
  });

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem1> {

  var firstItemIndex = 0;
  var isSelected = false;
  CategoryModel categoryModel;

  final CategoryBloc categoryBloc = BlocProvider.getBloc<CategoryBloc>();

  @override
  void initState() {

    firstItemIndex = widget.position;
    categoryModel = widget.categoryModel;

    if(firstItemIndex == 0) {
      isSelected = true;
    }

    listenCategoryClick();
    super.initState();
  }

  @override
  void setState(fn) {
    if(this.mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    String image = ImageTools.getCategoryImage(categoryModel.categoryIcon);

    return GestureDetector(
      onTap: () {
        categoryBloc.onCategoryClick(categoryModel);

        setState(() {
          isSelected = false;
        });

      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color:  isSelected ? Color(0xfffeb324) : Colors.white,
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

  void listenCategoryClick() {
    categoryBloc.categoryStream.listen((model) {

      if(model.id == categoryModel.id && !isSelected) {
        setState(() {

          isSelected = true;
        });
      } else if(model.id != categoryModel.id && isSelected) {
        setState(() {
          if (firstItemIndex == widget.position) {
            firstItemIndex = -1;
          }
          isSelected = false;
        });
      }

    });
  }
}


class CategoryItem extends StatelessWidget {

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