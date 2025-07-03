import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel{
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({
      required this.id, required this.name, required this.latLng});
  // List<PlaceModel> places =[
  //   PlaceModel(
  //       id: 1,
  //       name: 'مستشفى المنيا الجامعى',
  //       latLng: LatLng(28.091341960156655, 30.755974203275553)),
  //   PlaceModel(
  //       id: 2,
  //       name: 'عزبة ابو فليو',
  //       latLng: LatLng(28.093159216683816, 30.77597275293702)),
  //   PlaceModel(
  //       id: 3,
  //       name:  'كورنيش النيل',
  //       latLng: LatLng(28.10398639898872, 30.753399282718277)),
  // ];

}