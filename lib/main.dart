import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/bloc/cartListBloc.dart';
import 'package:flutter_food_app/bloc/listStyleColorBloc.dart';
import 'package:flutter_food_app/model/foodItem.dart';
import 'package:flutter_food_app/tools/color_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import 'bloc/tutorial_bloc/tutorial_check_box_bloc.dart';
import 'cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i)=>CartListBloc()),
        Bloc((i)=> ColorBloc())
      ],
      child: MaterialApp(
        title: "Food delivery",
        home: Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.transparent
        ),
      ),
    );
  }
}

//TODO tutorial
class KeysToBeInherited extends InheritedWidget {
  final GlobalKey cartIndicatorKey;
  final GlobalKey categoriesKey;
  final GlobalKey optionsKey;
  final GlobalKey searchKey;
  final GlobalKey nameKey;

  KeysToBeInherited({
    this.cartIndicatorKey,
    this.categoriesKey,
    this.optionsKey,
    this.searchKey,
    this.nameKey,
    Widget child
  }) : super(child: child);

  static KeysToBeInherited of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(KeysToBeInherited);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

}

// TODO Home
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTool.fromHex("#F9F9F9"),
      body: ShowCaseWidget(
        builder: Builder(
            builder: (context) => HomeBody(),
        ),
      ),
    );
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

// TODO counter
class ItemContainer extends StatefulWidget {

  final FoodItem foodItem;

  ItemContainer({
    @required this.foodItem
  });

  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  final CartListBloc listBloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodItem foodItem) {
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
      child: Item(
        hotel: widget.foodItem.hotel,
        itemName: widget.foodItem.title,
        itemPrice: widget.foodItem.price,
        imgUrl: widget.foodItem.imageUrl,
        leftAligned: widget.foodItem.id % 2 == 0 ? true : false,
      ),
    );
  }
}

//TODO item
class Item extends StatefulWidget {

  final String hotel;
  final String itemName;
  final double itemPrice;
  final String imgUrl;
  final bool leftAligned;

  Item({
    @required this.hotel,
    @required this.itemName,
    @required this.itemPrice,
    @required this.imgUrl,
    @required this.leftAligned});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: widget.leftAligned ? 0 : containerPadding,
              right: widget.leftAligned ? containerPadding : 0
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                      left: widget.leftAligned ? Radius.circular(0) : Radius.circular(containerBorderRadius),
                      right: widget.leftAligned ? Radius.circular(containerBorderRadius) : Radius.circular(0)
                  ),
                  child: Image.network(widget.imgUrl, fit: BoxFit.fitWidth,),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(
                  left: widget.leftAligned ? 20 : 0,
                  right: widget.leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.itemName,
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                        Text("\$${widget.itemPrice}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15
                            ),
                            children: [
                              TextSpan(text: "by "),
                              TextSpan(text: widget.hotel, style: TextStyle(fontWeight: FontWeight.w700)),
                            ]
                        ),
                      ),
                    ),
                    SizedBox(height: containerPadding,)
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}


// TODO first part screen
class FirstHalf extends StatelessWidget {

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
    return Container(
      height: 185,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: true,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Sushi",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Pizza",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Stacke",
            availability: 12,
            selected: false,
          ),
        ],
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
            Text("Food", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
            Text("Delivery", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),),
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
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;

              return buildGestureDetector(length, context, foodItems);
            },
          )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(int length, BuildContext context, List<FoodItem> foodItems) {
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
        child: Container(
          margin: EdgeInsets.only(right: 30),
          child: Text(length.toString()),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.yellow[800],
              borderRadius: BorderRadius.circular(50)
          ),
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
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [BoxShadow(
                    blurRadius: 10, color: Colors.grey[300], spreadRadius: 2)
                ]
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


//TODO categories
class CategoryListItem extends StatelessWidget {

  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  const CategoryListItem({
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.availability,
    @required this.selected});


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color:  selected ? Color(0xfffeb324) : Colors.white,
        border: Border.all(
          color: selected ? Colors.transparent : Colors.grey[200],
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
                  color: selected ? Colors.transparent : Colors.grey,
                  width: 1.5
              )
            ),
            child: Icon(
              categoryIcon,
              color: Colors.black,
                size: 30,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            categoryName,
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
            availability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          )

        ],
      ),
    );
  }

}
