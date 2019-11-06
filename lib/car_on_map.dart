import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/carItem.dart';

class CustomMap extends StatefulWidget {
  final Car car;

  CustomMap({@required this.car});

  @override
  _CustomMap createState() => _CustomMap();
}

//class _CustomMap extends State<CustomMap> {
//
//  LatLng _center =  LatLng(51.110462, 17.033409);
//  static const String urlTemplate = "https://api.tiles.mapbox.com/v4/"
//      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}";
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Maps'),
//          backgroundColor: Colors.green[700],
//          leading: Container(
//              child: GestureDetector(
//                child: Icon(Icons.arrow_back_ios, color: Colors.white,),
//                onTap: () {
//                  Navigator.pop(context);
//                },
//              )
//          ),
//
//        ),
//        body: //Container(),
//        FlutterMap(
//            options: MapOptions(
//              center: _center,
//              zoom: 13.0,
//            ),
//          layers: [
//            TileLayerOptions(
//              urlTemplate: urlTemplate,
//              additionalOptions: {
//                'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
//                'id': 'mapbox.streets',
//              }
//            ),
//            MarkerLayerOptions(
//              markers: [
//                Marker(
//                  width: 80.0,
//                  height: 80.0,
//                  point: _center,
//                  builder: (context) {
//                    return Container(
//                      child: FlutterLogo(),
//                    );
//                  }
//                )
//              ]
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}

//TODO google maps doesn't support yet on IOS
class _CustomMap extends State<CustomMap> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(51.110462, 17.033409);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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
        body: //Container(),
        GoogleMap(
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}