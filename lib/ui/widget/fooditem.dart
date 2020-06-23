import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {

  final String hotel;
  final String itemName;
  final double itemPrice;
  final String imgUrl;
  final bool leftAligned;

  FoodItem({
    @required this.hotel,
    @required this.itemName,
    @required this.itemPrice,
    @required this.imgUrl,
    @required this.leftAligned});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<FoodItem> {
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