import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:techno_weather/models/PlaceSearch.dart';

class PlacesService {
  Future<List<PlaceSearch>> getAutocomplete(String searchParam) async {
    final String apiKey = 'AIzaSyCLE9uUtDmMyzDDKJiOdS3whIyCUDIg-PU';
    final String filterOptions = 'components=country:it&types=(cities)';

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchParam&key=$apiKey&$filterOptions');

    final response = await http.get(url);
    final json = convert.jsonDecode(response.body);
    final jsonResults = json['predictions'] as List;

    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
