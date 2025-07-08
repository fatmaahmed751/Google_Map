import 'dart:convert';
/// placePrediction : {"place":"places/ChIJkQQVTZqAhYARHxPt2iJkm1Q","placeId":"ChIJkQQVTZqAhYARHxPt2iJkm1Q","text":{"text":"Asian Art Museum, Larkin Street, San Francisco, CA, USA","matches":[{"startOffset":6,"endOffset":16}]},"structuredFormat":{"mainText":{"text":"Asian Art Museum","matches":[{"startOffset":6,"endOffset":16}]},"secondaryText":{"text":"Larkin Street, San Francisco, CA, USA"}},"types":["establishment","museum","point_of_interest"]}

PlaceAutocompleteModel placeAutocompleteModelFromJson(String str) => PlaceAutocompleteModel.fromJson(json.decode(str));
String placeAutocompleteModelToJson(PlaceAutocompleteModel data) => json.encode(data.toJson());
class PlaceAutocompleteModel {
  PlaceAutocompleteModel({
      PlacePrediction? placePrediction,}){
    _placePrediction = placePrediction;
}

  PlaceAutocompleteModel.fromJson(dynamic json) {
    _placePrediction = json['placePrediction'] != null ? PlacePrediction.fromJson(json['placePrediction']) : null;
  }
  PlacePrediction? _placePrediction;
PlaceAutocompleteModel copyWith({  PlacePrediction? placePrediction,
}) => PlaceAutocompleteModel(  placePrediction: placePrediction ?? _placePrediction,
);
  PlacePrediction? get placePrediction => _placePrediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_placePrediction != null) {
      map['placePrediction'] = _placePrediction?.toJson();
    }
    return map;
  }

}

/// place : "places/ChIJkQQVTZqAhYARHxPt2iJkm1Q"
/// placeId : "ChIJkQQVTZqAhYARHxPt2iJkm1Q"
/// text : {"text":"Asian Art Museum, Larkin Street, San Francisco, CA, USA","matches":[{"startOffset":6,"endOffset":16}]}
/// structuredFormat : {"mainText":{"text":"Asian Art Museum","matches":[{"startOffset":6,"endOffset":16}]},"secondaryText":{"text":"Larkin Street, San Francisco, CA, USA"}}
/// types : ["establishment","museum","point_of_interest"]

PlacePrediction placePredictionFromJson(String str) => PlacePrediction.fromJson(json.decode(str));
String placePredictionToJson(PlacePrediction data) => json.encode(data.toJson());
class PlacePrediction {
  PlacePrediction({
      String? place, 
      String? placeId, 
      Text? text, 
      StructuredFormat? structuredFormat, 
      List<String>? types,
  }){
    _place = place;
    _placeId = placeId;
    _text = text;
    _structuredFormat = structuredFormat;
    _types = types;
}

  PlacePrediction.fromJson(dynamic json) {
    _place = json['place'];
    _placeId = json['placeId'];
    _text = json['text'] != null ? Text.fromJson(json['text']) : null;
    _structuredFormat = json['structuredFormat'] != null ? StructuredFormat.fromJson(json['structuredFormat']) : null;
    _types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  String? _place;
  String? _placeId;
  Text? _text;
  StructuredFormat? _structuredFormat;
  List<String>? _types;
PlacePrediction copyWith({  String? place,
  String? placeId,
  Text? text,
  StructuredFormat? structuredFormat,
  List<String>? types,
}) => PlacePrediction(  place: place ?? _place,
  placeId: placeId ?? _placeId,
  text: text ?? _text,
  structuredFormat: structuredFormat ?? _structuredFormat,
  types: types ?? _types,
);
  String? get place => _place;
  String? get placeId => _placeId;
  Text? get text => _text;
  StructuredFormat? get structuredFormat => _structuredFormat;
  List<String>? get types => _types;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['place'] = _place;
    map['placeId'] = _placeId;
    if (_text != null) {
      map['text'] = _text?.toJson();
    }
    if (_structuredFormat != null) {
      map['structuredFormat'] = _structuredFormat?.toJson();
    }
    map['types'] = _types;
    return map;
  }

}

/// mainText : {"text":"Asian Art Museum","matches":[{"startOffset":6,"endOffset":16}]}
/// secondaryText : {"text":"Larkin Street, San Francisco, CA, USA"}

StructuredFormat structuredFormatFromJson(String str) => StructuredFormat.fromJson(json.decode(str));
String structuredFormatToJson(StructuredFormat data) => json.encode(data.toJson());
class StructuredFormat {
  StructuredFormat({
      MainText? mainText, 
      SecondaryText? secondaryText,}){
    _mainText = mainText;
    _secondaryText = secondaryText;
}

  StructuredFormat.fromJson(dynamic json) {
    _mainText = json['mainText'] != null ? MainText.fromJson(json['mainText']) : null;
    _secondaryText = json['secondaryText'] != null ? SecondaryText.fromJson(json['secondaryText']) : null;
  }
  MainText? _mainText;
  SecondaryText? _secondaryText;
StructuredFormat copyWith({  MainText? mainText,
  SecondaryText? secondaryText,
}) => StructuredFormat(  mainText: mainText ?? _mainText,
  secondaryText: secondaryText ?? _secondaryText,
);
  MainText? get mainText => _mainText;
  SecondaryText? get secondaryText => _secondaryText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mainText != null) {
      map['mainText'] = _mainText?.toJson();
    }
    if (_secondaryText != null) {
      map['secondaryText'] = _secondaryText?.toJson();
    }
    return map;
  }

}

/// text : "Larkin Street, San Francisco, CA, USA"

SecondaryText secondaryTextFromJson(String str) => SecondaryText.fromJson(json.decode(str));
String secondaryTextToJson(SecondaryText data) => json.encode(data.toJson());
class SecondaryText {
  SecondaryText({
      String? text,}){
    _text = text;
}

  SecondaryText.fromJson(dynamic json) {
    _text = json['text'];
  }
  String? _text;
SecondaryText copyWith({  String? text,
}) => SecondaryText(  text: text ?? _text,
);
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    return map;
  }

}

/// text : "Asian Art Museum"
/// matches : [{"startOffset":6,"endOffset":16}]

MainText mainTextFromJson(String str) => MainText.fromJson(json.decode(str));
String mainTextToJson(MainText data) => json.encode(data.toJson());
class MainText {
  MainText({
      String? text, 
      List<Matches>? matches,}){
    _text = text;
    _matches = matches;
}

  MainText.fromJson(dynamic json) {
    _text = json['text'];
    if (json['matches'] != null) {
      _matches = [];
      json['matches'].forEach((v) {
        _matches?.add(Matches.fromJson(v));
      });
    }
  }
  String? _text;
  List<Matches>? _matches;
MainText copyWith({  String? text,
  List<Matches>? matches,
}) => MainText(  text: text ?? _text,
  matches: matches ?? _matches,
);
  String? get text => _text;
  List<Matches>? get matches => _matches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    if (_matches != null) {
      map['matches'] = _matches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// startOffset : 6
/// endOffset : 16

// Matches matchesFromJson(String str) => Matches.fromJson(json.decode(str));
// String matchesToJson(Matches data) => json.encode(data.toJson());
// class Matches {
//   Matches({
//       int? startOffset,
//       int? endOffset,}){
//     _startOffset = startOffset;
//     _endOffset = endOffset;
// }
//
//   Matches.fromJson(dynamic json) {
//     _startOffset = json['startOffset'];
//     _endOffset = json['endOffset'];
//   }
//   int? _startOffset;
//   int? _endOffset;
// Matches copyWith({  int? startOffset,
//   int? endOffset,
// }) => Matches(  startOffset: startOffset ?? _startOffset,
//   endOffset: endOffset ?? _endOffset,
// );
//   int? get startOffset => _startOffset;
//   int? get endOffset => _endOffset;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['startOffset'] = _startOffset;
//     map['endOffset'] = _endOffset;
//     return map;
//   }
//
// }

/// text : "Asian Art Museum, Larkin Street, San Francisco, CA, USA"
/// matches : [{"startOffset":6,"endOffset":16}]

Text textFromJson(String str) => Text.fromJson(json.decode(str));
String textToJson(Text data) => json.encode(data.toJson());
class Text {
  Text({
      String? text, 
      List<Matches>? matches,}){
    _text = text;
    _matches = matches;
}

  Text.fromJson(dynamic json) {
    _text = json['text'];
    if (json['matches'] != null) {
      _matches = [];
      json['matches'].forEach((v) {
        _matches?.add(Matches.fromJson(v));
      });
    }
  }
  String? _text;
  List<Matches>? _matches;
Text copyWith({  String? text,
  List<Matches>? matches,
}) => Text(  text: text ?? _text,
  matches: matches ?? _matches,
);
  String? get text => _text;
  List<Matches>? get matches => _matches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    if (_matches != null) {
      map['matches'] = _matches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// startOffset : 6
/// endOffset : 16

Matches matchesFromJson(String str) => Matches.fromJson(json.decode(str));
String matchesToJson(Matches data) => json.encode(data.toJson());
class Matches {
  Matches({
      int? startOffset, 
      int? endOffset,}){
    _startOffset = startOffset;
    _endOffset = endOffset;
}

  Matches.fromJson(dynamic json) {
    _startOffset = json['startOffset'];
    _endOffset = json['endOffset'];
  }
  int? _startOffset;
  int? _endOffset;
Matches copyWith({  int? startOffset,
  int? endOffset,
}) => Matches(  startOffset: startOffset ?? _startOffset,
  endOffset: endOffset ?? _endOffset,
);
  int? get startOffset => _startOffset;
  int? get endOffset => _endOffset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startOffset'] = _startOffset;
    map['endOffset'] = _endOffset;
    return map;
  }

}