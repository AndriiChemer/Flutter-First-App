import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Center(
      child: Container(
        height: 500,
        width: 500,
        child: Shimmer.fromColors(
            child: Image.asset("assets/images/thecsguy.png"),
            baseColor: Colors.black,
            highlightColor: Colors.white
        ),
      ),
    );
  }

  loadData() async {
    return Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() {
    Navigator.pushReplacementNamed(context, '/home');
  }
}