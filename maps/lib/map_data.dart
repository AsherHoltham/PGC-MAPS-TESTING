import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class GoogleMapsDataGetter {
  final String _apiKey;

  GoogleMapsDataGetter(this._apiKey);

  /// Factory method to create an instance of [GoogleMapsDataGetter] by loading the API key.
  static Future<GoogleMapsDataGetter> create() async {
    // Load the maps.json file from the assets
    final jsonString = await rootBundle.loadString('lib/keys/maps.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    // Extract the API key from the JSON
    final apiKey = jsonMap['apiKey'] as String;
    return GoogleMapsDataGetter(apiKey);
  }

  /// Example method: Fetch place details using Google Places API.
  /// [placeId] is the unique identifier of the place.
  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final uri =
        Uri.https('maps.googleapis.com', '/maps/api/place/details/json', {
      'place_id': placeId,
      'key': _apiKey,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
          'Failed to load place details. Status code: ${response.statusCode}');
    }
  }

  // You can add more methods to fetch different types of Google Maps data.
}
