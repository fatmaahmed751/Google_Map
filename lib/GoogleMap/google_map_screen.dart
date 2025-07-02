import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'google_map_controller.dart';
class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  State createState() => MyMapScreenState();
}
class MyMapScreenState extends StateMVC<MyMapScreen> {
  MyMapScreenState() : super(MyMapController()) {
    con = controller as MyMapController;
  }

  late MyMapController con;
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: con.currentLatLng,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
              con.googleMapController = controller;
              con.initStyleMap(context);
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: () {
                con.goToMyCurrentLocation();
                print('الموقع المبدئي: ${con.currentLatLng}');
              //  print('الموقع المستهدف: ${con.targetLocation}');
              },
              child: Text("Change location"),
            ),
          )
        ],
      ),
    );
  }
}
// class MyMapScreen extends StatefulWidget {
//   const MyMapScreen({super.key});
//
//   @override
//   State createState() => MyMapScreenState();
// }
//
// class MyMapScreenState extends StateMVC<MyMapScreen> {
//
//
//   MyMapScreenState() : super(MyMapController()) {
//     con =  MyMapController();
//   }
//
// late MyMapController con;
//
//   @override
//   void initState() {
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller){
//               con.googleMapController = controller;
//             con.goToMyCurrentLocation();
//             },
//             // mapType: MapType.hybrid,
//             initialCameraPosition : CameraPosition(
//                 target: con.currentLatLng,
//                 zoom: 14)
//
//           ),
//           Positioned(
//             bottom:16 ,
//               right:16 ,
//               left: 16,
//               child: ElevatedButton(
//                   onPressed: (){
//                     con.goToMyCurrentLocation();
//                   }, child: Text("Change location"))
//           )
//         ],
//       ),
//
//     );
//   }
//
// // Future<void> _goToTheLake() async {
// //   final GoogleMapController controller = await _controller.future;
// //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// // }
// }