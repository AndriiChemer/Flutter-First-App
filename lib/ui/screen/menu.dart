
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/bloc/cartListBloc.dart';
import 'package:flutter_food_app/model/categorymodel.dart';
import 'package:flutter_food_app/model/foodmodel.dart';
import 'package:flutter_food_app/tools/color_tools.dart';
import 'package:flutter_food_app/tools/image_tools.dart';
import 'package:flutter_food_app/tools/string_tools.dart';
import 'package:flutter_food_app/ui/screen/cart.dart';
import 'package:flutter_food_app/ui/widget/categoryitem.dart';
import 'package:flutter_food_app/ui/widget/fooditem.dart';
import 'package:flutter_food_app/ui/widget/tutorial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorTool.fromHex("#F9F9F9"),
      body: ShowCaseWidget(
        builder: Builder(
          builder: (context) => HomeBody(),
        ),
      ),
    );;
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  GlobalKey _cartIndicatorKey = GlobalKey();
  GlobalKey _categoriesKey = GlobalKey();
  GlobalKey _optionsKey = GlobalKey();
  GlobalKey _searchKey = GlobalKey();
  GlobalKey _nameKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    SharedPreferences preferences;

    displayShowCase() async {
      preferences = await SharedPreferences.getInstance();
      bool showCaseVisibilityStatus = preferences.getBool("foodListDisplayShowcase");

      if(showCaseVisibilityStatus == null) {
        preferences.setBool("foodListDisplayShowcase", false);
        return true;
      }

      return false;
    }

    displayShowCase().then((status){
      if(status) {
        ShowCaseWidget.of(context).startShowCase([
          _optionsKey,
          _cartIndicatorKey,
          _nameKey,
          _searchKey,
          _categoriesKey
        ]);
      }
    });

    return KeysToBeInherited(
      nameKey: _nameKey,
      cartIndicatorKey: _cartIndicatorKey,
      categoriesKey: _categoriesKey,
      optionsKey: _optionsKey,
      searchKey: _searchKey,
      child: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              FirstHalf(),
              SizedBox(height: 45,),
              for(var foodItem in foodItemList.foodItem)
                ItemContainer(foodItem: foodItem)
            ],
          ),
        ),
      ),
    );
  }
}

class ItemContainer extends StatefulWidget {

  final FoodModel foodItem;

  ItemContainer({
    @required this.foodItem
  });

  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  final CartListBloc listBloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodModel foodItem) {
    listBloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(widget.foodItem);

        final snackBar = SnackBar(
          content: Text("${widget.foodItem.title} added to cart"),
          duration: Duration(milliseconds: 550),
          backgroundColor: Colors.green[700],

        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: FoodItem(
        hotel: widget.foodItem.hotel,
        itemName: widget.foodItem.title,
        itemPrice: widget.foodItem.price,
        imgUrl: widget.foodItem.imageUrl,
        leftAligned: widget.foodItem.id % 2 == 0 ? true : false,
      ),
    );
  }
}

class FirstHalf extends StatelessWidget {

  var selectedId = -1;

  @override
  Widget build(BuildContext context) {

    final getKeys = KeysToBeInherited.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox(height: 30,),
          Showcase(
            key: getKeys.nameKey,
            description: "This is the name of the app incase you haven't noticed",
            child: title(),
          ),
          SizedBox(height: 30,),
          Showcase(
            key: getKeys.searchKey,
            description: "This is where you type in a query",
            child: searchBar(),
          ),
          SizedBox(height: 30,),
          Showcase(
            key: getKeys.categoriesKey,
            description: "Choose from not thousands but 5 categories",
            child: categories(),
          ),
        ],
      ),
    );
  }

  Widget categories() {
    var listCategory = categoryListItem.categoryList;
    selectedId = listCategory[0].id;

    return Container(
      height: 185,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listCategory.length,
        itemBuilder: (context, i) {
          return CategoryItem(
            categoryIcon: ImageTools.getCategoryImage(listCategory[i].categoryIcon),
            categoryName: listCategory[i].categoryName,
            availability: listCategory[i].availability,
            selected: listCategory[i].selected,
          );
        },
      ),
    );
  }

  Widget searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.search, color: Colors.black45,),
        SizedBox(width: 20,),
        Expanded(child: TextField(
          decoration: InputDecoration(
              hintText: "Search...",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(color: Colors.black87)
          ),
        ),)
      ],
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 45,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(StringTools.food, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
            Text(StringTools.delivery, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),),
          ],
        )
      ],
    );
  }

}


//TODO custom app bar
class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  bool isCheck = false;
  SharedPreferences sharedPreferences;

  void getSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isCheck = sharedPreferences.containsKey("foodListDisplayShowcase");
    });
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Showcase(
            key: KeysToBeInherited.of(context).optionsKey,
            description: "Click here to open the options drawer",
            child: Icon(Icons.menu),
          ),

          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodModel> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;

              return buildGestureDetector(length, context, foodItems);
            },
          )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(int length, BuildContext context, List<FoodModel> foodItems) {
    return GestureDetector(
      onLongPress: () {
        showCustomBottomSheetDialog(context);
      },

      onTap: () {
        if(length > 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }
      },
      child: Showcase(
        key: KeysToBeInherited.of(context).cartIndicatorKey,
        description: "Click here to review the items in your cart",
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Image.asset("assets/images/icons/shopping_cart.png", width: 25, height: 25,),
            ),
            Container(
              width: 60,
              height: 30,
              alignment: Alignment.topRight,
              child: length > 0 ? Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.bottomLeft,
                  child: Center(
                    child: Text(length.toString(), style: TextStyle(fontSize: 15),),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(50)
                  )
              ) : Container(),
            ),
          ],
        ),
      ),
    );
  }


  showCustomBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 250,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),

            ),
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoSwitch(
                      value: isCheck,
                      onChanged: (bool newValue) {

                        if(newValue) {
                          sharedPreferences.setBool("foodListDisplayShowcase", false);
                        } else {
                          sharedPreferences.remove("foodListDisplayShowcase");
                        }
                        setState(() {
                          isCheck = newValue;
                        });
                      },
                    ),

                    Text("Tutorial", style: TextStyle(fontSize: 20),)

                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[900],
                )
              ],
            ),
          ),
        )
    );
  }

}
