import 'package:dartz/dartz.dart';
import '../Models/Place_suggestion.dart';
import '../Models/place_autocomplete_model.dart';
import '../Models/place_details_model.dart';
import '../core/API/generic_request.dart';
import '../core/API/request_method.dart';
import '../core/error/exceptions.dart';

import '../core/error/failures.dart';
import '../core/error/handle_error_for_google_map.dart';
import '../core/network/error_message_model.dart';
import '../utilitis/google_api_services.dart';


class PickLocationDataHandler {
  static Future<Either<Failure, List<PlaceSuggestion>>> getPlaces({
    required String place,
    required String sessionToken,
  }) async {
    try {
      final encodedPlace = Uri.encodeComponent(place);
      final url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$encodedPlace""&types=address"
          "&components=country:eg"
          "&key=YOUR_API_KEY"  // Replace with secure key
          "&sessiontoken=$sessionToken";

      final response = await GenericRequest<List<PlaceSuggestion>>(
        method: RequestApi.get(
          url: url,
        ),
        fromMap: (json) => List<PlaceSuggestion>.from(
          (json["predictions"] as List).map((e) => PlaceSuggestion.fromJson(e)),
        ).toList(),
      ).getResponse();

      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
  static Future<Either<Failure,PlaceDetailsModel>> getPlaceDetails({required String id, required String sessionToken})async{
    try {
      PlaceDetailsModel response = await GenericRequest<PlaceDetailsModel>(
        method: RequestApi.get(
            url: "https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&fields=geometry&key=AIzaSyDxGfP9wVkkoIDBRwqR1i4H7afn-oQm33w&sessiontoken=$sessionToken",

        ),
          fromMap: (json) => PlaceDetailsModel.fromJson(json)

        //  fromMap:(_)=>PlaceDetailsModel.fromJson(_["result"]["geometry"]["location"]),
      ).getResponse();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}


// Future<void> fetchPlaceDetails(String placeId) async {
//   final String apiKey = 'YOUR_API_KEY'; // 🔐 استبدله بمفتاحك
//   final String endpoint =
//       'https://places.googleapis.com/v1/places/places/$placeId';
//
//   RequestApi.get(
//    url: "https://places.googleapis.com/v1/places/places/$placeId",
//   headers: {
//     'X-Goog-Api-Key': 'YOUR_API_KEY',
//     'X-Goog-FieldMask': 'id,displayName,location,iconMaskBaseUri,iconBackgroundColor'
//   }
// )
//
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//
//     final id = data['id'];
//     final name = data['displayName']['text'];
//     final lat = data['location']['latitude'];
//     final lng = data['location']['longitude'];
//     final iconUrl = data['iconMaskBaseUri'];
//     final iconBg = data['iconBackgroundColor'];
//
//     print('ID: $id');
//     print('Name: $name');
//     print('LatLng: $lat, $lng');
//     print('Icon URL: $iconUrl');
//     print('Icon BG: $iconBg');
//   } else {
//     print('Failed to fetch place details: ${response.statusCode}');
//     print(response.body);
//   }
// }

// class PlaceAutoCompleteDataHandler {
//   final GooglePlacesApiService placesApiService;
//
//   PlaceAutoCompleteDataHandler({required this.placesApiService});
//
//   static Future<Either<Failure, List<PlaceAutocompleteModel>>> getPlaces({
//     required String input,
//     required String language,
//     required GooglePlacesApiService placesApiService,
//   }) async {
//     try {
//       final result = await placesApiService.fetchSuggestions(
//         input: input,
//         languageCode: language,
//       );
//       return Right(result);
//     } on ExternalServiceFailure catch (e) {
//       return Left(e); // handle in UI or Bloc
//     } catch (e) {
//       return Left(ExternalServiceFailure(message: e.toString()));
//     }
//   }
// }