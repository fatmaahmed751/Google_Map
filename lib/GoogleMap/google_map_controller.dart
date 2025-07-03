import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../Models/place_model.dart';

class MyMapController extends ControllerMVC {
  // singleton
  factory MyMapController() {
    _this ??= MyMapController._();
    return _this!;
  }
  MyMapController._();
  static MyMapController? _this;

  late LatLng latLng;
  bool loading = false;
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  List<PlaceModel> places = [
    PlaceModel(
      id: 1,
      name: 'مستشفى المنيا الجامعى',
      latLng: LatLng(28.091341960156655, 30.755974203275553),
    ),
    PlaceModel(
      id: 2,
      name: 'عزبة ابو فليو',
      latLng: LatLng(28.093159216683816, 30.77597275293702),
    ),
    PlaceModel(
      id: 3,
      name: 'كورنيش النيل',
      latLng: LatLng(28.10398639898872, 30.753399282718277),
    ),
  ];
  final LatLng currentLatLng = const LatLng(
    28.094148289471846,
    30.74859561310244,
  );
  final LatLng targetLocation = const LatLng(30.257923, 31.537993);
  Location location = Location();

  @override
  void initState() {
   // updateMyLocation();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }


  Future<void> checkAndRequestLocation() async {
    try{
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services are required but disabled');
      }
    }
    checkPermission();
  } catch (e) {
  print('Error checking location services: $e');
  // Consider showing a user-friendly message
  rethrow;
  }
  }

  Future<bool> checkPermission() async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.deniedForever) {
      return false;
    }
    if (permission == PermissionStatus.denied) {
      await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
    print("Location permissions are denied.");
  }

  void getUserLocation() {
    location.onLocationChanged.listen((data) {
      var cameraPosition = CameraPosition(
        target: LatLng(data.latitude!, data.longitude!),
        zoom: 15,
      );
      var myMarker = Marker(
        markerId: MarkerId('1'),
        position: LatLng(data.latitude!, data.longitude!),
      );
      markers.add(myMarker);
      setState(() {});
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    });
  }

  void updateMyLocation() async {
    try {
      await checkAndRequestLocation();
      var hasPermission = await checkPermission();
      if (hasPermission) {
        getUserLocation();
      } else {
        print('Location permissions not granted');
        // Handle permission denial
      }
    } catch (e) {
      print('Error updating location: $e');
      // Handle error appropriately
    }
    // await checkAndRequestLocation();
    // var hasPermission = await checkPermission();
    // if (hasPermission) {
    //   getUserLocation();
    // }
  }
  // void initMarker(){
  //     var myMarker = Marker(markerId: MarkerId('1'),position:const LatLng(28.069255, 30.763991));
  //     markers.add(myMarker);
  // }
  void initMarker() {
    Circle myLocation = Circle(
      center: LatLng(28.094148289471846, 30.74859561310244),
      radius: 1000,
      strokeWidth: 1,
      fillColor: Colors.grey.withOpacity(0.5),
      circleId: CircleId('1'),
    );
    //  var myMarkers= places.map((placeModel)=>
    //     Marker(
    //       infoWindow: InfoWindow(title:placeModel.name),
    //       position: placeModel.latLng,
    //         markerId: MarkerId(placeModel.id.toString(),
    // ))).toSet();
    // markers.add(myLocation);
  }

  Future<void> goToMyCurrentLocation() async {
    await googleMapController!.animateCamera(
      CameraUpdate.newLatLng(targetLocation),
    );
    print('الموقع المبدئي: ${currentLatLng}');
    print('الموقع المستهدف: ${targetLocation}');
  }

  void initStyleMap(BuildContext context) async {
    var nightStyle = await DefaultAssetBundle.of(
      context,
    ).loadString("assets/map_style/night_map_style.json");
    googleMapController!.setMapStyle(nightStyle);
  }
}
