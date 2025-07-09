import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../google_map_controller.dart';

class PlaceDetailsWidget extends StatefulWidget{
  const PlaceDetailsWidget({super.key});

  @override
 createState() => _PlaceDetailsWidgetState();
}

class _PlaceDetailsWidgetState extends StateMVC<PlaceDetailsWidget> {
  _PlaceDetailsWidgetState() : super(MyMapController()) {
    con = controller as MyMapController;
    // con =  MyMapController();
  }

  late MyMapController con;
  @override
  Widget build(BuildContext context) {
  return   Container(
    color: Colors.white,
    child: ListView.separated(
        itemBuilder:(context,index)=>ListTile(
          title:Text(con.placeSuggest[index].description),
          leading: Icon(Icons.man),
          trailing: IconButton(
              onPressed: ()async{
              var placeDetails = await con.getPlaceDetails(id: con.placeSuggest[index].placeId.toString());
              if (con.placeDetailsModel != null) {
                print('Name: ${con.placeDetailsModel?.result!.name}');
                print('📍 Lat: ${con.placeDetailsModel!.latitude}');
                print('📍 Lng: ${con.placeDetailsModel!.longitude}');
              } else {
                print('❌ مفيش بيانات راجعة من الـ API');
              }
              con.placeSuggest.clear();
              },
              icon: Icon(Icons.start)),
        ) ,
        separatorBuilder: (context,index)=>Divider(),
        itemCount: con.placeSuggest.length),
  );
  }
}