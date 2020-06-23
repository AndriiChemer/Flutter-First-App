import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/bloc/car_bloc/bottom_nav_bloc.dart';
import 'package:flutter_food_app/bloc/cartListBloc.dart';
import 'package:flutter_food_app/bloc/listStyleColorBloc.dart';
import 'package:flutter_food_app/ui/screen/splash.dart';

import 'package:flutter_food_app/ui/screen/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i)=>CartListBloc()),
        Bloc((i)=> ColorBloc()),
        Bloc((i)=> BottomNavBloc())
      ],
      child: MaterialApp(
        title: "Food delivery",
        home: Splash(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Colors.transparent
        ),
        routes: {
          '/home': (context) => Menu(),
        },
      ),
    );
  }
}

