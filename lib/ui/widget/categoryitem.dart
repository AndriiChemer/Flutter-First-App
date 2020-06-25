import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/bloc/categoryBloc.dart';
import 'package:flutter_food_app/model/categorymodel.dart';
import 'package:flutter_food_app/tools/image_tools.dart';

enum CategoryAnimationStatus { closed, open, animating }

class CategoryItem extends StatefulWidget {

  final int position;
  final CategoryModel categoryModel;

  const CategoryItem({
    @required this.position,
    @required this.categoryModel
  });

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> with SingleTickerProviderStateMixin {

  //ANIMATION VALUE
  AnimationController animationCategoryController;
  CategoryAnimationStatus categoryAnimationStatus = CategoryAnimationStatus.closed;

  Animation<double> animationCircular;
  Animation<double> animationSizeBox;
  Animation<double> animationFontSize;
  Animation<double> animationVerticalLine;
  Animation<double> paddingSize;

  Animation<double> animationMenu;
  //=============================

  var firstItemIndex = 0;
  var isSelected = false;
  CategoryModel categoryModel;

  final CategoryBloc categoryBloc = BlocProvider.getBloc<CategoryBloc>();

  @override
  void initState() {
    _prepareAnimationController();
    _prepareAnimations();
    _handleCategoryAnimationState();

    animationCategoryController.reverse();

    firstItemIndex = widget.position;
    categoryModel = widget.categoryModel;

    if(firstItemIndex == 0) {
      isSelected = true;
    }

    _listenCategoryClick();
    super.initState();
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
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(animationCircular.value),
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
                      color: isSelected ? Colors.transparent : Colors.grey,
                      width: 1.5
                  )
              ),
              child: Image.asset(image, width: 30, height: 30,),
            ),
            SizedBox(height: animationSizeBox.value,),
            Text(
              categoryModel.categoryName,
              style: TextStyle(
                fontSize: animationFontSize.value,
                fontWeight: FontWeight.w700,
                color: Colors.black
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, paddingSize.value),
              width: 1.5,
              height: animationVerticalLine.value,
              color: Colors.black26,
            ),
            Text(
              categoryModel.availability.toString(),
              style: TextStyle(
                fontSize: animationFontSize.value,
                fontWeight: FontWeight.w600,
                color: Colors.black
              ),
            )

          ],
        ),
      ),
    );
  }

  void _listenCategoryClick() {
    categoryBloc.categoryStream.listen((model) {

      _handleCategoryAnimationState();

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


  //TODO Animation
  _handleCategoryAnimationState(){
    if (categoryAnimationStatus == CategoryAnimationStatus.closed){
      animationCategoryController.forward().orCancel;
    } else if (categoryAnimationStatus == CategoryAnimationStatus.open) {
      animationCategoryController.reverse().orCancel;
    }
  }

  _prepareAnimationController() {
    animationCategoryController = new AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
    )..addListener((){
      setState((){});
    })..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        ///
        /// When the animation is at the end, the menu is open
        ///
        categoryAnimationStatus = CategoryAnimationStatus.open;
      } else if (status == AnimationStatus.dismissed) {
        ///
        /// When the animation is at the beginning, the menu is closed
        ///
        categoryAnimationStatus = CategoryAnimationStatus.closed;
      } else {
        ///
        /// Otherwise the animation is running
        ///
        categoryAnimationStatus = CategoryAnimationStatus.animating;
      }
    });
  }

  _prepareAnimations() {
    animationCircular = new Tween(begin: 50.0, end: 20.0)
        .animate(animationCategoryController);

    animationSizeBox = new Tween(begin: 10.0, end: 0.0)
        .animate(animationCategoryController);

    animationVerticalLine = new Tween(begin: 15.0, end: 0.0)
        .animate(animationCategoryController);

    animationFontSize = new Tween(begin: 14.0, end: 0.0)
        .animate(animationCategoryController);

    paddingSize = new Tween(begin: 10.0, end: 2.0)
        .animate(animationCategoryController);

  }

  @override
  void setState(fn) {
    if(this.mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    animationCategoryController.dispose();
    super.dispose();
  }
}
