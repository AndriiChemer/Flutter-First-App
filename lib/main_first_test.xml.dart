import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/bloc/cartListBloc.dart';
import 'package:flutter_food_app/bloc/listStyleColorBloc.dart';
import 'package:flutter_food_app/model/foodItem.dart';

import 'cart.dart';

class HomeTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i)=>CartListBloc()),
        Bloc((i)=> ColorBloc())
      ],
      child: MaterialApp(
        title: "Food delivery",
        home: Home1(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBur(),
      body: SafeArea(
        child: ListView(

        ),
      ),
    );
  }
}

class CustomAppBur extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBurState createState() => _CustomAppBurState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => null;
}

class _CustomAppBurState extends State<CustomAppBur> {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;

              int length = foodItems != null ? foodItems.length : 0;

              return circleDishCount(length);
            },
          )
        ],
      ),
    );
  }

  Container circleDishCount(int length) {
    return Container(
      decoration: BoxDecoration(color: Colors.yellow[700]),
    );
  }
}



