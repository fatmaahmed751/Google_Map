// To parse this JSON data, do
//
//     final placeDetailsModel = placeDetailsModelFromJson(jsonString);

import 'dart:convert';

PlaceDetailsModel placeDetailsModelFromJson(String str) => PlaceDetailsModel.fromJson(json.decode(str));

String placeDetailsModelToJson(PlaceDetailsModel data) => json.encode(data.toJson());

class PlaceDetailsModel {
  final Result? result;

  PlaceDetailsModel({
    this.result,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) => PlaceDetailsModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
  };
  double? get latitude => result?.location?.latitude;
  double? get longitude => result?.location?.longitude;
}

class Result {
  final String? name;
  final String? id;
  final DisplayName? displayName;
  final List<String>? types;
  final String? primaryType;
  final DisplayName? primaryTypeDisplayName;
  final String? nationalPhoneNumber;
  final String? internationalPhoneNumber;
  final String? formattedAddress;
  final String? shortFormattedAddress;
  final PostalAddress? postalAddress;
  final LocationForPlace? location;
  final double? rating;
  final String? googleMapsUri;
  final String? websiteUri;
  final List<dynamic>? reviews;
  final RegularOpeningHours? regularOpeningHours;
  final String? priceLevel;
  final bool? takeout;
  final bool? delivery;

  Result({
    this.name,
    this.id,
    this.displayName,
    this.types,
    this.primaryType,
    this.primaryTypeDisplayName,
    this.nationalPhoneNumber,
    this.internationalPhoneNumber,
    this.formattedAddress,
    this.shortFormattedAddress,
    this.postalAddress,
    this.location,
    this.rating,
    this.googleMapsUri,
    this.websiteUri,
    this.reviews,
    this.regularOpeningHours,
    this.priceLevel,
    this.takeout,
    this.delivery,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    id: json["id"],
    displayName: json["displayName"] == null ? null : DisplayName.fromJson(json["displayName"]),
    types: json["types"] == null ? [] : List<String>.from(json["types"]!.map((x) => x)),
    primaryType: json["primaryType"],
    primaryTypeDisplayName: json["primaryTypeDisplayName"] == null ? null : DisplayName.fromJson(json["primaryTypeDisplayName"]),
    nationalPhoneNumber: json["nationalPhoneNumber"],
    internationalPhoneNumber: json["internationalPhoneNumber"],
    formattedAddress: json["formattedAddress"],
    shortFormattedAddress: json["shortFormattedAddress"],
    postalAddress: json["postalAddress"] == null ? null : PostalAddress.fromJson(json["postalAddress"]),
    location: json["location"] == null ? null : LocationForPlace.fromJson(json["location"]),
    rating: json["rating"]?.toDouble(),
    googleMapsUri: json["googleMapsUri"],
    websiteUri: json["websiteUri"],
    reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    regularOpeningHours: json["regularOpeningHours"] == null ? null : RegularOpeningHours.fromJson(json["regularOpeningHours"]),
    priceLevel: json["priceLevel"],
    takeout: json["takeout"],
    delivery: json["delivery"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "displayName": displayName?.toJson(),
    "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
    "primaryType": primaryType,
    "primaryTypeDisplayName": primaryTypeDisplayName?.toJson(),
    "nationalPhoneNumber": nationalPhoneNumber,
    "internationalPhoneNumber": internationalPhoneNumber,
    "formattedAddress": formattedAddress,
    "shortFormattedAddress": shortFormattedAddress,
    "postalAddress": postalAddress?.toJson(),
    "location": location?.toJson(),
    "rating": rating,
    "googleMapsUri": googleMapsUri,
    "websiteUri": websiteUri,
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    "regularOpeningHours": regularOpeningHours?.toJson(),
    "priceLevel": priceLevel,
    "takeout": takeout,
    "delivery": delivery,
  };
}

class DisplayName {
  final String? text;
  final String? languageCode;

  DisplayName({
    this.text,
    this.languageCode,
  });

  factory DisplayName.fromJson(Map<String, dynamic> json) => DisplayName(
    text: json["text"],
    languageCode: json["languageCode"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "languageCode": languageCode,
  };
}

class LocationForPlace {
  final double? latitude;
  final double? longitude;

  LocationForPlace({
    this.latitude,
    this.longitude,
  });

  factory LocationForPlace.fromJson(Map<String, dynamic> json) => LocationForPlace(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class PostalAddress {
  final List<String>? addressLines;
  final String? locality;
  final String? administrativeArea;
  final String? postalCode;
  final String? country;

  PostalAddress({
    this.addressLines,
    this.locality,
    this.administrativeArea,
    this.postalCode,
    this.country,
  });

  factory PostalAddress.fromJson(Map<String, dynamic> json) => PostalAddress(
    addressLines: json["addressLines"] == null ? [] : List<String>.from(json["addressLines"]!.map((x) => x)),
    locality: json["locality"],
    administrativeArea: json["administrativeArea"],
    postalCode: json["postalCode"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "addressLines": addressLines == null ? [] : List<dynamic>.from(addressLines!.map((x) => x)),
    "locality": locality,
    "administrativeArea": administrativeArea,
    "postalCode": postalCode,
    "country": country,
  };
}

class RegularOpeningHours {
  final List<Close>? open;
  final List<Close>? close;

  RegularOpeningHours({
    this.open,
    this.close,
  });

  factory RegularOpeningHours.fromJson(Map<String, dynamic> json) => RegularOpeningHours(
    open: json["open"] == null ? [] : List<Close>.from(json["open"]!.map((x) => Close.fromJson(x))),
    close: json["close"] == null ? [] : List<Close>.from(json["close"]!.map((x) => Close.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "open": open == null ? [] : List<dynamic>.from(open!.map((x) => x.toJson())),
    "close": close == null ? [] : List<dynamic>.from(close!.map((x) => x.toJson())),
  };
}

class Close {
  final String? dayOfWeek;
  final String? time;

  Close({
    this.dayOfWeek,
    this.time,
  });

  factory Close.fromJson(Map<String, dynamic> json) => Close(
    dayOfWeek: json["dayOfWeek"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "dayOfWeek": dayOfWeek,
    "time": time,
  };
}
