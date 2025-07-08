// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../Models/place_autocomplete_model.dart';
// import '../core/error/handle_error_for_google_map.dart';
//
// class GooglePlacesApiService {
//   final String apiKey;
//   final http.Client client;
//
//   GooglePlacesApiService({
//     required this.apiKey,
//     required this.client,
//   });
//
//   Future<List<PlaceAutocompleteModel>> fetchSuggestions({
//     required String input,
//     String languageCode = 'en',
//   }) async {
//     try {
//     final url = Uri.parse('https://places.googleapis.com/v1/places :autocomplete');
//     final response = await client.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'X-Goog-Api-Key': apiKey,
//         'X-Goog-FieldMask': 'suggestions',
//       },
//       body: jsonEncode({
//         'input': input,
//         'languageCode': languageCode,
//       }),
//     );
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List<dynamic> suggestions = data['suggestions'];
//       return suggestions.map((item) => PlaceAutocompleteModel.fromJson(item)).toList();
//     } else {
//       final responseData = jsonDecode(response.body);
//       throw ExternalServiceFailure(
//         message: responseData['error']['message'] ?? 'Unknown error',
//         statusCode: response.statusCode,
//         rawResponse: responseData,
//       );
//     }
//   } catch (e) {
//   throw ExternalServiceFailure(
//   message: e.toString(),
//   );
//   }
// }
//   //   if (response.statusCode == 200) {
//   //     final data = jsonDecode(response.body);
//   //     final List<dynamic> suggestions = data['suggestions'];
//   //     return suggestions
//   //         .map((item) => PlaceAutocompleteModel.fromJson(item))
//   //         .toList();
//   //   } else {
//   //     throw Exception('Failed to load autocomplete results');
//   //   }
//   // }
// }