import 'package:dartz/dartz.dart';
import '../Models/Place_suggestion.dart';
import '../Models/place_autocomplete_model.dart';
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
          "https://maps.googleapis.com/maps/api/place/autocomplete/json"
          "?input=$encodedPlace"
          "&types=address"
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
}

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