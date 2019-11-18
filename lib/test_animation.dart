
import 'dart:math';

import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> with SingleTickerProviderStateMixin {

  AnimationController animationButtonController;
  Animation<double> animation0;
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  Animation<double> animationText;
  Animation<double> animationTextSize;
  int currentState = 0;


  @override
  void initState() {
    super.initState();

    animationButtonController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    animation0 = Tween<double>(begin: -16, end: 0).animate(animationButtonController)..addListener((){
      setState(() {

      });
    });
    animation1 = Tween<double>(begin: 0, end: 60).animate(animationButtonController)..addListener((){
      setState(() {

      });
    });
    animation2 = Tween<double>(begin: 0, end: 120).animate(animationButtonController)..addListener((){
      setState(() {

      });
    });
    animation3 = Tween<double>(begin: 0, end: 180).animate(animationButtonController)..addListener((){
      setState(() {

      });
    });
    animationText = Tween<double>(begin: 0, end: 80).animate(animationButtonController)..addListener((){
      setState(() {

      });
    });
    animationTextSize = Tween<double>(begin: 0, end: 20).animate(animationButtonController)..addListener((){
      setState(() {

      });
    });

    animationButtonController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(

        padding: EdgeInsets.only(right: 20, bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: <Widget>[
            //TODO section 1
            Positioned(
                bottom: animation0.value,
                right: 0,
                child: FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: (){},
                  child: Icon(Icons.add),
                )
            ),
            Positioned(
              right: animationText.value,
              bottom: 15,
              child: Text("Text 1", style: TextStyle(color: Colors.white, fontSize: animationTextSize.value, fontWeight: FontWeight.w500),),
            ),
            //TODO section 2
            Positioned(
              bottom: animation1.value,
              right: 0,
              child: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: (){},
                child: Icon(Icons.cake),
              ),
            ),
            Positioned(
              right: animationText.value,
              bottom: 78,
              child: Text("Text 2", style: TextStyle(color: Colors.white, fontSize: animationTextSize.value, fontWeight: FontWeight.w500),),
            ),
            //TODO section 3
            Positioned(
              bottom: animation2.value,
              right: 0,
              child: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: (){},
                child: Icon(Icons.location_on),
              ),
            ),
            Positioned(
              right: animationText.value,
              bottom: 135,
              child: Text("Text 3", style: TextStyle(color: Colors.white, fontSize: animationTextSize.value, fontWeight: FontWeight.w500),),
            ),
            //TODO section 4
            Positioned(
              bottom: animation3.value,
              right: 0,
              child: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: (){},
                child: Icon(Icons.notifications_active),
              ),
            ),
            Positioned(
              right: animationText.value,
              bottom: 195,
              child: Text("Text 4", style: TextStyle(color: Colors.white, fontSize: animationTextSize.value, fontWeight: FontWeight.w500),),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationButtonController.dispose();
//    animationTextController.dispose();
    super.dispose();
  }


}