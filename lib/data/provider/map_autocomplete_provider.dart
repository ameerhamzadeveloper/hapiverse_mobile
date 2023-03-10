import 'dart:convert';
import 'dart:io';
import '../../data/model/map_model.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  static final String androidKey = '';
  static final String iosKey = '';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(
      {required String input,required String lang,required double currentLat,required double currentLng, required String type}) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=$type&location=$currentLat%2C$currentLng&radius=15000&strictbounds=true&types=establishment&types=address&language=$lang&components=country:pk&key=${Utils.placesAPIKey}';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        print(result['status']);
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      } else {
        throw {Exception(result['error_message'])};
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&geometry&key=${Utils.placesAPIKey}';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final Place place = Place(
            formattedAddress: result['result']['formatted_address'],
            lat: result['result']['geometry']['location']['lat'],
            lng: result['result']['geometry']['location']['lng']);

        print("getPlaceDetailFromId: lat: ${result['result']['geometry']['location']['lat']} lng: ${result['result']['geometry']['location']['lng']}");
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<NearBySearch> getNearBySearchResults({required String name,required String radius, required double currentLat,required double currentLng, required String type}) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$currentLat,$currentLng&radius=$radius&name=$name&type=$type&key=${Utils.placesAPIKey}';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      if (result['status'] == 'OK') {

        final nearBySearch = NearBySearch.fromJson(result);
        // final Place place = Place(
        //     formattedAddress: result['result']['formatted_address'],
        //     lat: result['result']['geometry']['location']['lat'],
        //     lng: result['result']['geometry']['location']['lng']);

        // print("getPlaceDetailFromId: lat: ${result['result']['geometry']['location']['lat']} lng: ${result['result']['geometry']['location']['lng']}");
        return nearBySearch;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

}
