import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/carItem.dart';

class CustomMap extends StatefulWidget {
  final Car car;

  CustomMap({@required this.car});

  @override
  _CustomMap createState() => _CustomMap(car: car);
}

class _CustomMap extends State<CustomMap> {

  Car car;
  double zoomVal = 12.0;
  Position currentPosition;
  Completer<GoogleMapController> _controller = Completer();

  _CustomMap({@required this.car});

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps'),
          backgroundColor: Colors.green[700],
          leading: Container(
              child: GestureDetector(
                child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onTap: () {
                  Navigator.pop(context);
                },
              )
          ),

        ),
        body: Stack(
          children: <Widget>[
            _googleMap(context),
            _zoomMinusFunction(),
            functionButtons(),
//            _carsContainer(context),
          ],
        )
      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        mapType: MapType.normal,
        compassEnabled: false,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: getCatLocation(),
          zoom: zoomVal,
        ),
        markers: {
          getCarMarker()
        },
      ),
    );
  }

  Widget functionButtons() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _zoomPlusFunction(),
          SizedBox(height: 16,),
          _myLocationButton()
        ],
      )
    );
  }

  Widget _myLocationButton() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: FloatingActionButton(
        onPressed: (){
          //TODO draw rout
        },
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: Color(0xff6200ee),
        child: Icon(Icons.my_location, color: Colors.white, size: 36,),
      ),
    );
  }

  Widget _zoomMinusFunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee),),
        onPressed: (){
          zoomVal--;
          zoom(zoomVal);
        },
      ),
    );
  }

  Widget _zoomPlusFunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee),),
        onPressed: (){
          zoomVal++;
          zoom(zoomVal);
        },
      ),
    );
  }

  Widget _carsContainer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            for(int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.all(8),
                child: _carBox(car),
              ),
            SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }

  Future<void> zoom(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(car.lat, car.lng),
          zoom: zoomVal,
          tilt: 50.0,
          bearing: 45.0)));
  }

  Widget _carBox(Car car) {
    return GestureDetector(
      onTap: (){
        this.car = car;
        goToSelectedCarLocation(car);
      },
      child: Container(
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(car.photo),
                    ),
                  ),
                ),
                Container(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: carDetailsContainer(car),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> goToSelectedCarLocation(Car car) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(car.lat, car.lng),
                zoom: zoomVal,
                tilt: 50.0,
                bearing: 45.0)));
  }

  double getRatingStars() {
    final _random = new Random();
    return 0.0 + _random.nextInt(5 - 0);
  }

  Widget carDetailsContainer(Car car) {
    double rating = getRatingStars();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            child: Text(
                "${car.brand} ${car.model}",
              style: TextStyle(color: Color(0xff6200ee), fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(rating.toString(), style: TextStyle(color: Colors.black54, fontSize: 18),),
              ),
              for(int i = 0; i < 5; i++)
                getStar(rating--),
              SizedBox(height: 5.0,),
            ],
          ),
        ),
      ],
    );
  }

  Container getStar(double rating) {
    bool isRatingMoreThenOne = rating > 0;
    return Container(
      child: Icon(
        FontAwesomeIcons.solidStar,
        color: isRatingMoreThenOne ? Colors.amber : Colors.grey,
        size: 15,
      ),
    );
  }

  Marker getCarMarker() {
    return Marker(
        markerId: MarkerId("${car.brand} ${car.model}"),
        position: getCatLocation(),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "${car.brand} ${car.model}")
    );
  }

  LatLng getCatLocation() {
    return LatLng(car.lat, car.lng);
  }

  void getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition();
    setState(() {
      currentPosition = position;
    });
  }
}