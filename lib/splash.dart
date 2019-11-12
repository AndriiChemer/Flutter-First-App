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
    return Center(
      child: Container(
        height: 500,
        width: 500,
        child: Shimmer.fromColors(
            child: Image.asset("thecsguy.png"),
            baseColor: Colors.black,
            highlightColor: Colors.white
        ),
      ),
    );
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Container()));
  }
}
