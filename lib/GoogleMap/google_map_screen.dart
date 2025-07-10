import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map/GoogleMap/widgets/place_details_widget.dart';
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
        con.locationInitialized
        ? GoogleMap(
          polylines: con.polyLines,
        zoomControlsEnabled: false,
          markers: con.markers,
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
        )
              : const Center(child: CircularProgressIndicator()),
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: Column(
                children: [
                  CustomTextFieldWidget(
                    controller: con.searchController,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            PlaceDetailsWidget(),
          ],
        ),
      ),
    );
  }
}
//   con.markers.isEmpty
// ? const Center(child: CircularProgressIndicator())
//   :
//  GoogleMap(
// //   polylines: ,
//    zoomControlsEnabled: false,
//    markers: con.markers,
//    initialCameraPosition: CameraPosition(
//      target: con.currentLatLng,
//      zoom: 12.0,
//    ),
//    onMapCreated: (GoogleMapController controller) {
//      _mapController.complete(controller);
//      con.googleMapController = controller;
//      con.initStyleMap(context);
//      con.updateMyLocation();
//    },
//  ),
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
