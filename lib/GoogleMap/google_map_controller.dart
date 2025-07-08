import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../Models/Place_suggestion.dart';
import '../Models/place_model.dart';
import 'google_map_data_handler.dart';

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
  late TextEditingController searchController;
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
  List<PlaceSuggestion> placeSuggest=[];
  final LatLng currentLatLng = const LatLng(
    28.094148289471846,
    30.74859561310244,
  );
  final LatLng targetLocation = const LatLng(30.257923, 31.537993);
  final Location location = Location();
  void Function()? onMarkersUpdated;
  Timer? _debounce;

  ///TODO
  final sessionToken = Uuid().generateV4();
bool isFirst = true;

@override
void initState(){
  searchController = TextEditingController();
  searchController.addListener(() {
    final input = searchController.text.trim();

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (input.isNotEmpty) {
        getSuggestedPlaces(
          place: input,
          sessionToken: sessionToken,
        );
      } else {
        placeSuggest.clear();
        setState(() {});
      }
    });
  });
  super.initState();
}
  @override
  void dispose() {
    googleMapController?.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future getSuggestedPlaces({
    required place,
    required sessionToken
  })async{
    setState(() {
      placeSuggest=[];
    });
    setState(() {
      loading = true;
    });
    final result = await PickLocationDataHandler.getPlaces(
        place:place,
        sessionToken:sessionToken);
    result.fold(
          (l){
        //ToastHelper.showError(message: l.errorModel.modelName)
      }, (r) {
      placeSuggest = r;
    },
    );
    setState(() {
      loading = false;
    });
  }

  Future<bool> checkAndRequestLocation() async {
    try{
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
        throw Exception('Location services are required but disabled');
      }
    }
    return true;
   // checkPermission();
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
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return false;
      }
    }
    return permission == PermissionStatus.granted;
    print("Location permissions are denied.");
  }

  void getStreamUserLocation() {
    location.changeSettings(
      interval: 2000,
      distanceFilter: 2
    );
    location.onLocationChanged.listen((data) {
       if (data.latitude != null && data.longitude != null) {
            addMarkerAsMyLocation(data);
            updateCameraPosition(data); // يتحرك أول مرة للموقع الفعلي
          }
        });
  }

  void updateCurrentUserLocation()async{

     var locationData = await location.getLocation();
     var myMarker = Marker(
       markerId: MarkerId('1'),
       position: LatLng(locationData.latitude!, locationData.longitude!),
     );
     markers.add(myMarker);
     if (onMarkersUpdated != null) {
       onMarkersUpdated!(); // this will call setState in the Widget
     }
     CameraPosition cameraPosition = CameraPosition(
       target: LatLng(locationData.latitude!, locationData.longitude!),
       zoom: 17,
     );
     googleMapController?.animateCamera(
         CameraUpdate.newCameraPosition(cameraPosition));

  }

  void updateCameraPosition(LocationData data) {
    if(isFirst) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(data.latitude!, data.longitude!),
        zoom: 17,
      );
      googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition));
      isFirst = false;
    }else {
      googleMapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(data.latitude!, data.longitude!)));
    }
  }

  void addMarkerAsMyLocation(LocationData data) {
    var myMarker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(data.latitude!, data.longitude!),
    );
    markers.add(myMarker);
    if (onMarkersUpdated != null) {
      onMarkersUpdated!(); // this will call setState in the Widget
    }
    print("Current location: ${data.latitude}, ${data.longitude}");

    // setState(() {});
  }

  void updateMyLocation() async {
    try {
      loading = true;
      onMarkersUpdated?.call();
      await checkAndRequestLocation();
      var hasPermission = await checkPermission();
      if (hasPermission) {
       // getStreamUserLocation();
        updateCurrentUserLocation();
      } else {
        print('***********************************************************************Location permissions not granted');
        // Handle permission denial
      }
    } catch (e) {
      print('Error updating location: $e');
      // Handle error appropriately
    }  finally {
  loading = false;
  onMarkersUpdated?.call(); // لتحديث الـ UI عند انتهاء التحميل
  }
  }

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
