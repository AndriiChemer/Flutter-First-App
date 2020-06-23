import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/bloc/car_bloc/state_bloc.dart';
import 'package:flutter_food_app/bloc/car_bloc/state_provider.dart';
import 'package:flutter_food_app/bloc/listStyleColorBloc.dart';
import 'package:flutter_food_app/car_on_map.dart';
import 'package:flutter_food_app/model/carItem.dart';
import 'package:flutter_food_app/model/foodmodel.dart';

class CarDetail extends StatelessWidget {

  final Car car;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CarDetail({@required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(),
      backgroundColor: Colors.black,
      body: LayoutStarts(car: car, scaffoldKey: _scaffoldKey,),
    );
  }
}


//TODO Custom App Bar
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {

  MyAppBar() : super();

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _MyAppBarState extends State<MyAppBar> {
  bool isFavourite = false;
  IconData iconFavourite = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Container(
        child: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      actions: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Icon(iconFavourite),
              onTap: () {
                setState(() {
                  if(isFavourite) {
                    handleFavorite();
                    iconFavourite = Icons.favorite_border;
                  } else {
                    handleFavorite();
                    iconFavourite = Icons.favorite;
                  }
                });

              },
            )
        )
      ],
    );
  }

  handleFavorite() {
    isFavourite = !isFavourite;
  }
}


//TODO build Stack
class LayoutStarts extends StatelessWidget {
  final Car car;
  final GlobalKey<ScaffoldState> scaffoldKey;

  LayoutStarts({@required this.car, @required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarHeaderAnimation(car: car, scaffoldKey: scaffoldKey,),
        CustomBottomSheet(car: car, scaffoldKey: scaffoldKey)
      ],
    );
  }
}


//TODO Header part
class CarHeaderAnimation extends StatefulWidget {

  final Car car;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CarHeaderAnimation({@required this.car, @required this.scaffoldKey});

  @override
  State<StatefulWidget> createState() => CarHeaderAnimationState(car: car, scaffoldKey: scaffoldKey);
}

class CarHeaderAnimationState extends State<CarHeaderAnimation> with TickerProviderStateMixin {

  final Car car;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CarHeaderAnimationState({@required this.car, @required this.scaffoldKey});

  AnimationController fadeController;
  AnimationController scaleController;

  Animation fadeAnimation;
  Animation scaleAnimation;


  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(duration:  Duration(milliseconds: 180), vsync: this);
    scaleController = AnimationController(duration:  Duration(milliseconds: 350), vsync: this);

    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(fadeController);
    scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut
    ));
  }

  forward() {
    scaleController.forward();
    fadeController.forward();
  }

  reverse() {
    scaleController.reverse();
    fadeController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      initialData: StateProvider().isAnimating,
      stream: stateBloc.animationStatus,
      builder: (context, snapshot) {

        snapshot.data ? forward() : reverse();

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: getCarHeader(context),
          ),
        );
      },
    );
  }

  Container getCarHeader(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 5.0
                  )
                ],
                image: DecorationImage(
                    image: NetworkImage(car.photo),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(height: MediaQuery.of(context).size.height - 350, width: MediaQuery.of(context).size.width, decoration: BoxDecoration(color: Colors.black),)
        ],
      ),
    );
  }


  @override
  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  void showSnackBar(String text, TextStyle textStyle, Color color) {
    final snackBar = SnackBar(
      content: Text("This feature not implemented yet!", style: textStyle,),
      duration: Duration(milliseconds: 550),
      backgroundColor: color,

    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

}


//TODO Bottom part
class CustomBottomSheet extends StatefulWidget {

  final Car car;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomBottomSheet({@required this.car, @required this.scaffoldKey});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState(car: car, scaffoldKey: scaffoldKey);
}

class _CustomBottomSheetState extends State<CustomBottomSheet> with SingleTickerProviderStateMixin {

  double sheepTop = 320;
  double minSheepTop = 30;
  bool isExpanded = false;

  final Car car;
  final GlobalKey<ScaffoldState> scaffoldKey;

  Animation<double> animation;
  AnimationController animationController;

  _CustomBottomSheetState({@required this.car, @required this.scaffoldKey});


  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    animation = Tween<double>(begin: sheepTop, end: minSheepTop).animate(
        //animationController
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut
      )
    )
    ..addListener((){
      setState(() {

      });
    });

    Future.delayed(Duration.zero, () {
      stateBloc.revertAnimation();
    });
  }

  forwardAnimation() {
    animationController.forward();
    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    animationController.reverse();
    stateBloc.toggleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: GestureDetector(

          onTap: (){
            animationController.isCompleted ? reverseAnimation() : forwardAnimation();
          },
          onVerticalDragEnd: (DragEndDetails dragEndDetails) {
            if(dragEndDetails.primaryVelocity < 0.0) {
              //upward drag
              forwardAnimation();
            } else if(dragEndDetails.primaryVelocity > 0.0) {
              reverseAnimation();
            } else {
              return;
            }
          },
          child: SheetContainer(car: car, scaffoldKey: scaffoldKey),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


}

class SheetContainer extends StatelessWidget {

  final Car car;
  final GlobalKey<ScaffoldState> scaffoldKey;

  SheetContainer({@required this.car, @required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              blurRadius: 5.0
          )
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Colors.white
      ),
      child: Column(
        children: <Widget>[
          drawHandle(context),
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[
                getPriceContainer(context),
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200]
                  ),
                ),
                getCarDescription(),
                Container(
                  height: 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200]
                  ),
                ),
                getUserDescription(),
                Container(
                  height: 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200]
                  ),
                ),
                getLocationBlock(context),
                Container(
                  height: 130,
                  width: double.infinity,
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  Container getLocationBlock(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CustomMap(car: car,)));
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.blue[400],),
                Text(car.localimodelzation ?? "" , style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.w500, fontSize: 15),),
              ],
            ),
          ),
          RaisedButton(
            color: Colors.indigo[900],
            child: Text("Pokaż nomer", style: TextStyle(color: Colors.white),),
            onPressed: (){
              showSnackBar("This feature not implemented yet?", TextStyle(color: Colors.white), Colors.red);
            },
          )
        ],
      ),
    );
  }

  Container drawHandle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 3,
      width: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffd9dbdb),
      ),
    );
  }

  Container getUserDescription() {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "OPIS",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue[900]),
          ),
          SizedBox(height: 7,),
          Text(car.description ?? "")
        ],
      ),
    );
  }

  TextStyle getTextStyleTitle() {
    return TextStyle(fontSize: 17, fontWeight: FontWeight.w300);
  }

  TextStyle getTextStyleDescription() {
    return TextStyle(color: Colors.blue[900], fontSize: 17, fontWeight: FontWeight.w700);
  }

  Container getCarDescription() {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Kategoria", style: getTextStyleTitle(),),
              Text("Osobowe", style: getTextStyleDescription(),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Marka pojazdu", style: getTextStyleTitle(),),
              Text(car.brand ?? "", style: getTextStyleDescription(),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Model pojazdu", style: getTextStyleTitle(),),
              Text(car.model ?? "", style: getTextStyleDescription(),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Rok produkcji", style: getTextStyleTitle(),),
              Text(car.year == null ? "" : car.year.toString(), style: getTextStyleDescription(),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Przebieg", style: getTextStyleTitle(),),
              Text(car.km == null ? "" : car.km.toString(), style: getTextStyleDescription(),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Kategoria", style: getTextStyleTitle(),),
              Text(car.category == null ? "" : car.category, style: getTextStyleDescription(),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Palne", style: getTextStyleTitle(),),
              Text(car.fuel ?? "", style: getTextStyleDescription(),)
            ],
          ),
          SizedBox(height: 5,),
        ],
      ),
    );
  }

  Container getPriceContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: car.auction ? CustomPaint(
              painter: CurvePainter(),
              child: Container(
                margin: EdgeInsets.all(4),
                child: Text("Wyroznione", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),),
              ),
            ) : Container(),
          ),
          SizedBox(height: 12,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(car.price.toStringAsFixed(0), style: TextStyle(color: Colors.red[900], fontSize: 30, fontWeight: FontWeight.w700),),
              Text("PLN", style: TextStyle(color: Colors.red[900], fontSize: 15, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 3,),
          Text("Do negocjacji", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w300),),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: (){
              showSnackBar(
                  "This feature not implemented yet!",
                  TextStyle(color: Colors.white, fontSize: 20),
                  Colors.red[900]);
            },
            child: Text("Oblich rate kredytu dla tego pojazdu", style: TextStyle(color: Colors.blue[900], decoration: TextDecoration.underline),),
          ),
          SizedBox(height: 5,)
        ],
      ),
    );
  }

  void showSnackBar(String text, TextStyle textStyle, Color color) {
    final snackBar = SnackBar(
      content: Text("This feature not implemented yet!", style: textStyle,),
      duration: Duration(milliseconds: 550),
      backgroundColor: color,

    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

class CurvePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue[900];
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();

    path.lineTo(70, 0);
    path.lineTo(80, 12);
    path.lineTo(70, 24);
    path.lineTo(0, 24);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}






