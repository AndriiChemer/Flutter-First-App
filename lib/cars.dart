import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_food_app/bloc/listStyleColorBloc.dart';
import 'package:flutter_food_app/car_detail.dart';
import 'package:flutter_food_app/model/carItem.dart';
import 'package:flutter_food_app/model/foodItem.dart';


//class CarsList extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    AppBar getAppBar(BuildContext context) {
//      return AppBar(
//        actions: <Widget>[
//          GestureDetector(
//            onTap: () {
//              //TODO changing view
//              Navigator.pop(context);
//            },
//            child: Container(
//              margin: EdgeInsets.only(right: 20),
//              child: Icon(Icons.apps),
//            ),
//          )
//        ],
//      );
//    }
//
//    return Scaffold(
//        appBar: getAppBar(context),
//        body: CarsListContainer(),
//        bottomNavigationBar: CustomBottomNavigationBar(),
//    );
//  }
//}

//TODO main CartList screen
class CarsList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => CarsListState();
}

class CarsListState extends State<CarsList> {

  @override
  Widget build(BuildContext context) {
    AppBar getAppBar(BuildContext context) {
      return AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              //TODO changing view
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.apps),
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: getAppBar(context),
      body: CarsListContainer(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

}




//TODO Container content
class CarsListContainer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => CarsListContainerState();
}

class CarsListContainerState extends State<CarsListContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(

      child: ListView(
        children: <Widget>[
          SizedBox(height: 45,),
          for(Car car in carList.carList)
            CarItem(car: car),
        ],
      ),
    );
  }
}




//TODO car item
class CarItem extends StatefulWidget {

  final Car car;

  CarItem({@required this.car});

  @override
  State<StatefulWidget> createState() => CarItemState();

}

class CarItemState extends State<CarItem> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetail(car: widget.car,)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(color: widget.car.auction ? Colors.blue : Colors.transparent, width: 2),
            image: DecorationImage(
              image: NetworkImage(widget.car.photo),
              fit: BoxFit.cover,
            )
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              getPriceRow(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.car.brand} ${widget.car.model}",
                  style: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.w700),
                ),),
              getCarInfoRow()
            ],
          ),
        ),
      ),
    );
  }

  Row getCarInfoRow() {
    return Row(
      children: <Widget>[
        Icon(Icons.time_to_leave, color: Colors.white,),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text("${widget.car.fuel}", style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500,)),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text("${widget.car.year.toString()}", style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500,)),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text("${widget.car.km.toString()}", style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500,)),
        )
      ],
    );
  }

  Row getPriceRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${widget.car.price.toStringAsFixed(0)}",
          style: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        Text(
          "PLN",
          style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

}



//TODO bottom navigation
class CustomBottomNavigationBar extends StatefulWidget {

  @override
  State createState() => BottomNavigationBar();
}

class BottomNavigationBar extends State<CustomBottomNavigationBar> {

  int selectedIndex = 0;
  Color backgroundColor = Colors.white;
  List<NavigationItem> listNavItem = [
    NavigationItem(Icon(Icons.home), Text("Home"), Colors.deepPurpleAccent),
    NavigationItem(Icon(Icons.star), Text("Favorite"), Colors.pinkAccent),
    NavigationItem(Icon(Icons.add), Text("Add"), Colors.amberAccent),
    NavigationItem(Icon(Icons.account_box), Text("Account"), Colors.cyanAccent),
  ];

  Widget buildItems(NavigationItem navigationItem, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 270),
      width: isSelected ? 125 : 50,
      padding: isSelected ? EdgeInsets.only(right: 16, left: 16): null,
      height: double.maxFinite,
      decoration: isSelected ? BoxDecoration(
        color: navigationItem.color,
        borderRadius: BorderRadius.all(Radius.circular(50))
      ) : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                child: navigationItem.icon,
                data: IconThemeData(size: 24, color: isSelected ? backgroundColor : Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: isSelected ? DefaultTextStyle(
                  style: TextStyle( color: backgroundColor),
                  child: navigationItem.text,
                ) : Container(),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5
          )
        ],

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listNavItem.map((item){
          var itemIndex = listNavItem.indexOf(item);
          return GestureDetector(
            onTap: (){
              setState((){
                selectedIndex = itemIndex;
              });
            },
            child: buildItems(item, selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text text;
  final Color color;

  NavigationItem(this.icon, this.text, this.color);
}

