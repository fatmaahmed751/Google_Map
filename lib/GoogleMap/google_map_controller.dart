import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

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
  late GoogleMapController googleMapController;
  //LatLng currentLatLng = LatLng(28.069255832901767, 30.763991964592556);
  final LatLng currentLatLng = const LatLng(28.069255, 30.763991);
  final LatLng targetLocation = const LatLng(30.257923, 31.537993);
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
googleMapController.dispose();
    super.dispose();
  }
  Future<void> goToMyCurrentLocation() async {
    await googleMapController.animateCamera(
        CameraUpdate.newLatLng(targetLocation
        ));
    print('الموقع المبدئي: ${currentLatLng}');
    print('الموقع المستهدف: ${targetLocation}');
  }
  void initStyleMap(BuildContext context)async{
   var nightStyle = await DefaultAssetBundle.of(context).loadString("assets/map_style/night_map_style.json");
   googleMapController.setMapStyle(nightStyle);
  }
}