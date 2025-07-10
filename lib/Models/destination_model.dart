// To parse this JSON data, do
//
//     final destinationModel = destinationModelFromJson(jsonString);

import 'dart:convert';

DestinationModel destinationModelFromJson(String str) => DestinationModel.fromJson(json.decode(str));

String destinationModelToJson(DestinationModel data) => json.encode(data.toJson());

class DestinationModel {
  final Destination? origin;
  final Destination? destination;
  final String? travelMode;
  final String? routingPreference;
  final bool? computeAlternativeRoutes;
  final RouteModifiers? routeModifiers;
  final String? languageCode;
  final String? units;

  DestinationModel({
    this.origin,
    this.destination,
    this.travelMode,
    this.routingPreference,
    this.computeAlternativeRoutes,
    this.routeModifiers,
    this.languageCode,
    this.units,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) => DestinationModel(
    origin: json["origin"] == null ? null : Destination.fromJson(json["origin"]),
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    travelMode: json["travelMode"],
    routingPreference: json["routingPreference"],
    computeAlternativeRoutes: json["computeAlternativeRoutes"],
    routeModifiers: json["routeModifiers"] == null ? null : RouteModifiers.fromJson(json["routeModifiers"]),
    languageCode: json["languageCode"],
    units: json["units"],
  );

  Map<String, dynamic> toJson() => {
    "origin": origin?.toJson(),
    "destination": destination?.toJson(),
    "travelMode": travelMode,
    "routingPreference": routingPreference,
    "computeAlternativeRoutes": computeAlternativeRoutes,
    "routeModifiers": routeModifiers?.toJson(),
    "languageCode": languageCode,
    "units": units,
  };
}

class Destination {
  final LocationForAnotherPlace? location;

  Destination({
    this.location,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    location: json["location"] == null ? null : LocationForAnotherPlace.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
  };
}

class LocationForAnotherPlace {
  final LatLngInfo? latLng;

  LocationForAnotherPlace({
    this.latLng,
  });

  factory LocationForAnotherPlace.fromJson(Map<String, dynamic> json) => LocationForAnotherPlace(
    latLng: json["latLng"] == null ? null : LatLngInfo.fromJson(json["latLng"]),
  );

  Map<String, dynamic> toJson() => {
    "latLng": latLng?.toJson(),
  };
}

class LatLngInfo {
  final double? latitude;
  final double? longitude;

  LatLngInfo({
    this.latitude,
    this.longitude,
  });

  factory LatLngInfo.fromJson(Map<String, dynamic> json) => LatLngInfo(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class RouteModifiers {
  final bool? avoidTolls;
  final bool? avoidHighways;
  final bool? avoidFerries;

  RouteModifiers({
    this.avoidTolls,
    this.avoidHighways,
    this.avoidFerries,
  });

  factory RouteModifiers.fromJson(Map<String, dynamic> json) => RouteModifiers(
    avoidTolls: json["avoidTolls"],
    avoidHighways: json["avoidHighways"],
    avoidFerries: json["avoidFerries"],
  );

  Map<String, dynamic> toJson() => {
    "avoidTolls": avoidTolls,
    "avoidHighways": avoidHighways,
    "avoidFerries": avoidFerries,
  };
}
