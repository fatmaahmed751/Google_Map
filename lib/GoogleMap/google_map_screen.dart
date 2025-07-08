import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map/Widgets/custom_textfield_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Widgets/loading_screen.dart';
import 'google_map_controller.dart';
class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  State createState() => MyMapScreenState();
}
class MyMapScreenState extends StateMVC<MyMapScreen> {

 // final Completer<GoogleMapController> _mapController = Completer();
  MyMapScreenState() : super(MyMapController()) {
  con = controller as MyMapController;
   // con =  MyMapController();
  }

  late MyMapController con;
 final Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    Location().hasPermission().then((perm) {
      print('PERMISSION STATUS: $perm');
    });
    super.initState();
    con.onMarkersUpdated = () {
      if (mounted) {
        setState(() {});
      }
    };

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   con.updateMyLocation();
    // });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoadingScreen(
        loading: con.loading,
        child: Stack(
          children: [
          //   con.markers.isEmpty
          // ? const Center(child: CircularProgressIndicator())
          //   :
            CustomTextFieldWidget(
              controller: con.searchController,
              onchange: (searchValue){
                con.searchController.addListener((){
                  con.getSuggestedPlaces(
                      place:  con.searchController.text,
                      sessionToken: con.sessionToken);
                });
              },
            ),
            GoogleMap(
              zoomControlsEnabled: false,
           markers:con.markers,
              initialCameraPosition: CameraPosition(
                target: con.currentLatLng,
                zoom: 12.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
                con.googleMapController = controller;
                con.initStyleMap(context);
                con.updateMyLocation();

              },
            ),
            // Positioned(
            //   bottom: 16,
            //   right: 16,
            //   left: 16,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       con.goToMyCurrentLocation();
            //       print('الموقع المبدئي*****************************************************: ${con.currentLatLng}');
            //     //  print('الموقع المستهدف: ${con.targetLocation}');
            //     },
            //     child: Text("Change location"),
            //   ),
            // )
            // if (con.loading)
            //   const Center(child: CircularProgressIndicator()),
          ],
        ),
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