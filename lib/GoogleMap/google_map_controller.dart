import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map/Models/place_details_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../Models/Place_suggestion.dart';
import '../Models/destination_model.dart';
import '../Models/place_model.dart';
import '../Models/route_model.dart';
import 'google_map_data_handler.dart';

class MyMapController extends ControllerMVC {
  // singleton
  factory MyMapController() {
    _this ??= MyMapController._();
    return _this!;
  }

  MyMapController._();

  static MyMapController? _this;
  //var locationData =  location.getLocation();
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
  List<PlaceSuggestion> placeSuggest = [];
  PlaceDetailsModel? placeDetailsModel;

  final LatLng currentLatLng = const LatLng(
    28.099414823056698, 30.758728803467985
  );
// late LatLng currentLatLng;
  //LatLng? currentLatLng;
  LatLng startPoint = LatLng(
      28.091341960156655, 30.755974203275553); // مثال: مستشفى
  LatLng endPoint = LatLng(28.10398639898872, 30.753399282718277);
  RouteInfo? routeInfo;
  late LatLng currentPosition;
  bool locationInitialized = false;
  late LatLng destination;
  RouteModel? routeModel;
  final LatLng targetLocation = const LatLng(30.257923, 31.537993);
  final Location location = Location();
  void Function()? onMarkersUpdated;
  Timer? _debounce;
  String? sessionToken;
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> polyLines = {};
Set<Circle>circles={};

  DestinationModel? destinationModel;

  //final sessionToken = Uuid().generateV4();
  void startNewSession() {
    sessionToken = Uuid().generateV4();
  }

  void endSession() => sessionToken = null;
  bool isFirst = true;

  @override
  void initState() {
    searchController = TextEditingController();
    updateMyLocation();
    /// getCurrentLocation();
    //  searchController.addListener(() {
    //    final input = searchController.text.trim();
    //
    //    if (_debounce?.isActive ?? false) _debounce!.cancel();
    //
    //    _debounce = Timer(const Duration(milliseconds: 200), () {
    //      if (input.isNotEmpty) {
    //        if (sessionToken == null) startNewSession();
    //        getSuggestedPlaces(place: input, sessionToken: sessionToken!);
    //      } else {
    //        searchController.clear();
    //        placeSuggest.clear();
    //
    //        setState(() {});
    //      }
    //    });
    //  });
    super.initState();
  }



  @override
  void dispose() {
    googleMapController?.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future getSuggestedPlaces({required place, required sessionToken}) async {
    setState(() {
      placeSuggest = [];
    });
    setState(() {
      loading = true;
    });
    final result = await PickLocationDataHandler.getPlaces(
      place: place,
      sessionToken: sessionToken!,
    );
    result.fold(
      (l) {
        //ToastHelper.showError(message: l.errorModel.modelName)
      },
      (r) {
        placeSuggest = r;
      },
    );
    setState(() {
      loading = false;
    });
    sessionToken = null;
  }

  void drawCustomPolyline() {
    List<LatLng> points = [
      LatLng(28.096604347727716, 30.758291631802862),
      LatLng(28.105067659782573, 30.756764338521446),
      LatLng(28.09886655374783, 30.757515979509574),
    ];

    Polyline polyline = Polyline(
      polylineId: PolylineId('custom_route'),
      color: Colors.red.withOpacity(0.5),
      width:2,
      points: points,
    );

    polyLines.clear(); // لو بتحب تمسح القديم
    polyLines.add(polyline);

    onMarkersUpdated?.call(); // علشان يحدث الـ UI
  }

  Future getPlaceDetails({required id}) async {
    setState(() {
      placeSuggest = [];
    });
    setState(() {
      loading = true;
    });
    final result = await PickLocationDataHandler.getPlaceDetails(
      id: id,
      sessionToken: sessionToken!,
    );
    result.fold(
      (l) {
        // ToastHelper.showError(message: l.errorModel.modelName);
      },
      (r) {
        placeDetailsModel = r;
        endSession();
        setState(() {});
        ///هل المكن ده صح
        destination = LatLng(
          placeDetailsModel!.latitude!,
          placeDetailsModel!.longitude!,
        );
      },
    );
    setState(() {
      loading = false;
    });
  }

 getRoutesDestination() async {
    if (destinationModel?.origin == null || destinationModel?.destination == null) return;
    final result = await PickLocationDataHandler.getRoutes(
      origin: destinationModel!.origin!,
      destination: destinationModel!.destination!,
    );
    result.fold(
      (l) {
        // ToastHelper.showError(message: l.errorModel.modelName);
      },
      (r) {
        //ده الخط المرسوم اللى راجع من الgoogle api لكن مش خط مرسوم ولكن نقاط مشفرة
      //   final encodedPolyline = r.routes!.first.polyline!.encodedPolyline!;
      // if (encodedPolyline != null) {
      //     // فك التشفير
      //     List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
      //
      //     // تحويل PointLatLng إلى LatLng
      //     List<LatLng> polylineCoordinates = result
      //         .map((point) => LatLng(point.latitude, point.longitude))
      //         .toList();
      //
      //     // إنشاء الـ polyline
      //     Polyline polyline = Polyline(
      //       polylineId: PolylineId('route'),
      //       color: Colors.blue,
      //       width: 5,
      //       points:
      //       polylineCoordinates,
      //     );
      //     if (polylineCoordinates.isNotEmpty) {
      //       LatLngBounds bounds = _createLatLngBounds(polylineCoordinates);
      //
      //       // تحريك الكاميرا لتشمل كل المسار
      //     googleMapController?.animateCamera(
      //         CameraUpdate.newLatLngBounds(bounds,40), // 50 = padding
      //       );
      //     }
      //
      //     // إضافته
      //     polyLines.clear(); // لو عايزة تعملي Reset
      //     polyLines.add(polyline);
      //
      //     // تحديث الـ UI
      //     onMarkersUpdated?.call();
      //  }
      },
    );
 }

  LatLngBounds _createLatLngBounds(List<LatLng> coordinates) {
    double south = coordinates.first.latitude;
    double north = coordinates.first.latitude;
    double west = coordinates.first.longitude;
    double east = coordinates.first.longitude;

    for (LatLng point in coordinates) {
      if (point.latitude < south) south = point.latitude;
      if (point.latitude > north) north = point.latitude;
      if (point.longitude < west) west = point.longitude;
      if (point.longitude > east) east = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  Future<bool> checkAndRequestLocation() async {
    try {
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
    location.changeSettings(interval: 2000, distanceFilter: 2);
    location.onLocationChanged.listen((data) {
      if (data.latitude != null && data.longitude != null) {
        addMarkerAsMyLocation(data);
        updateCameraPosition(data); // يتحرك أول مرة للموقع الفعلي
      }
    });
  }

  void updateCurrentUserLocation() async {
    var locationData = await location.getLocation();

    // currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);
    currentPosition = currentLatLng;
    var myMarker = Marker(
      markerId: MarkerId('1'),
      position: currentPosition,
    );
    markers.removeWhere((m) => m.markerId == MarkerId('1'));
    markers.add(myMarker);

    if (onMarkersUpdated != null) {
      onMarkersUpdated!(); // this will call setState in the Widget
    }
    CameraPosition cameraPosition = CameraPosition(
      target:currentPosition,
      //LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 18,
    );
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  void updateCameraPosition(LocationData data) {
    if (isFirst) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(data.latitude!, data.longitude!),
        zoom: 17,
      );
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      isFirst = false;
    } else {
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(data.latitude!, data.longitude!)),
      );
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
      //locationInitialized = true;
      onMarkersUpdated?.call();
      await checkAndRequestLocation();
      var hasPermission = await checkPermission();
      if (hasPermission) {
        // getStreamUserLocation();
        updateCurrentUserLocation();
      } else {
        print(
          '***********************************************************************Location permissions not granted',
        );
        // Handle permission denial
      }
    } catch (e) {
      print('Error updating location: $e');
      // Handle error appropriately
    } finally {
      loading = false;
      onMarkersUpdated?.call(); // لتحديث الـ UI عند انتهاء التحميل
    }
  }

  void initMarker() {
    Circle myLocation = Circle(
      circleId: CircleId('my_location_circle'),
      center: LatLng(28.094148289471846, 30.74859561310244),
      radius: 100,
      strokeWidth: 2,
      strokeColor: Colors.red,
      fillColor: Colors.red.withOpacity(0.3),
    );

    circles.clear();
    circles.add(myLocation);
    onMarkersUpdated?.call();

  }
  Future<void> goToMyCurrentLocation() async {
    await googleMapController!.animateCamera(
      CameraUpdate.newLatLng(targetLocation),
    );
   // print('الموقع المبدئي: ${currentLatLng}');
    print('الموقع المستهدف: ${targetLocation}');
  }

  void initStyleMap(BuildContext context) async {
    var nightStyle = await DefaultAssetBundle.of(
      context,
    ).loadString("assets/map_style/night_map_style.json");
    googleMapController!.setMapStyle(nightStyle);
  }
}
