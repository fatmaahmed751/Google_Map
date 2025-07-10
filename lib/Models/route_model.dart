// To parse this JSON data, do
//
//     final routeModel = routeModelFromJson(jsonString);

import 'dart:convert';

RouteModel routeModelFromJson(String str) => RouteModel.fromJson(json.decode(str));

String routeModelToJson(RouteModel data) => json.encode(data.toJson());

class RouteModel {
  final List<RouteInfo>? routes;

  RouteModel({
    this.routes,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
    routes: json["routes"] == null ? [] : List<RouteInfo>.from(json["routes"]!.map((x) => RouteInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x.toJson())),
  };
}

class RouteInfo {
  final int? distanceMeters;
  final String? duration;
  final PolylineInfo? polyline;

  RouteInfo({
    this.distanceMeters,
    this.duration,
    this.polyline,
  });

  factory RouteInfo.fromJson(Map<String, dynamic> json) => RouteInfo(
    distanceMeters: json["distanceMeters"],
    duration: json["duration"],
    polyline: json["polyline"] == null ? null : PolylineInfo.fromJson(json["polyline"]),
  );

  Map<String, dynamic> toJson() => {
    "distanceMeters": distanceMeters,
    "duration": duration,
    "polyline": polyline?.toJson(),
  };
}

class PolylineInfo {
  final String? encodedPolyline;

  PolylineInfo({
    this.encodedPolyline,
  });

  factory PolylineInfo.fromJson(Map<String, dynamic> json) => PolylineInfo(
    encodedPolyline: json["encodedPolyline"],
  );

  Map<String, dynamic> toJson() => {
    "encodedPolyline": encodedPolyline,
  };
}
